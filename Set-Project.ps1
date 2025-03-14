#
# This script adds a project to this repository.
#
param
(
	[Parameter(Mandatory)][string]$group,
	[Parameter(Mandatory)][string]$name,
	[Parameter(Mandatory)][IO.FileInfo]$projFile,
	[string]$info
)
$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

if (-not $projFile.Exists)
{
    Write-Error "Specified project file seems to not exist"
}

function LoadVCXProj {
    $vcxproj = Get-Content $projFile -Raw
    if (-not $vcxproj.Contains("nuget", [StringComparison]::OrdinalIgnoreCase))
    {
        Write-Error "Project does not seem to reference nuget packages"        
    }
    $packagesFile = [IO.FileInfo](Join-Path (Split-Path -Parent $projFile) "packages.config")
    if (-not $packagesFile.Exists)
    {
        Write-Error "The required 'packages.config' next to the project file seems missing"
    }
    $infos = Select-Xml -Path $packagesFile -XPath "/packages/package" | Select-Object -ExpandProperty Node | Foreach-Object { @{id=$_.id;version=$_.version;targetFramework=$_.targetFramework} }
    return $infos
}

function LoadCSProj {
    $targetFramework = (Select-Xml -Path "C:\Dev\Afuu\Afuu.csproj" -XPath "/Project/PropertyGroup/TargetFramework" | ForEach-Object { $_.Node.InnerText } | Select-Object -Unique -First 1 | Out-String).Trim()
    $infos = Select-Xml -Path "C:\Dev\Afuu\Afuu.csproj" -XPath "/Project/ItemGroup/PackageReference" | Select-Object -ExpandProperty Node | Foreach-Object { @{id=$_.Include;version=$_.Version;targetFramework=$targetFramework} }
    return $infos
}

switch ($projFile.Extension.ToLowerInvariant()) {
    ".vcxproj" { $packages = LoadVCXProj }
    ".csproj" { $packages = LoadCSProj }
    Default { Write-Error "File extension of specified project file unknown" }
}

if ($packages -is [Hashtable])
{
    $packages = @($packages)
}
if ($packages -isnot [System.Array])
{
    Write-Error "Failed to collect nuget packages information from project file"
}

$framework = "native"
$frameworks = $packages | Select-Object -ExpandProperty targetFramework -Unique
if ($frameworks -is [System.String])
{
    $framework = $frameworks
}
elseif ($frameworks -is [System.Array])
{
    if ($frameworks.Length -eq 1)
    {
        $framework = $frameworks[0]
    }
    else
    {
        Write-Host "Warning: packages are referenced from multiple frameworks:"
        $frameworks | ForEach-Object { Write-Host "    " $_ }
        Write-Host "Fallback: '$framework'"
    }
}

New-Item -ItemType Directory -Force (Join-Path $PSScriptRoot $group $name) | Out-Null
$targetFileName = Join-Path $PSScriptRoot $group $name ($name+".csproj")
$xml = New-Object -TypeName System.Xml.XmlDocument
$root = $xml.AppendChild($xml.CreateElement("Project"))
$root.SetAttribute("Sdk", "Microsoft.NET.Sdk")
$root.AppendChild($xml.CreateComment(" $group $name ")) | Out-Null
if ($info)
{
    $root.AppendChild($xml.CreateComment(" $info ")) | Out-Null
}
$root.AppendChild($xml.CreateElement("PropertyGroup")).AppendChild($xml.CreateElement("TargetFramework")).InnerText = $framework
$items = $root.AppendChild($xml.CreateElement("ItemGroup"))
$packages | ForEach-Object {
    $item = $items.AppendChild($xml.CreateElement("PackageReference"));
    $item.SetAttribute("Include", $_.id);
    $item.SetAttribute("Version", $_.version);
}
$xml.Save($targetFileName)

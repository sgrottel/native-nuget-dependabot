#
# Updates the native-nuget-dependabot repo based for this project
#

remove-item -recurse -force nnd -ErrorAction Ignore
git clone --depth 2 https://github.com/sgrottel/native-nuget-dependabot.git nnd

nnd\Set-Project.ps1 -group "ExampleGroup" -name "ExampleProject" -projFile (Join-Path $PSScriptRoot "Example.csproj")

cd nnd
git config --worktree user.name 'DopinderBot'
git config --worktree user.email 'DopinderBot-noreply@sgrottel.de'
git commit -am "Updated ExampleGroup ExampleProject"
git push
cd ..

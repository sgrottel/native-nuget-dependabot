# Native Nuget Dependabot
Proxy project repository to use Dependabot for Nuget packages in native Cpp projects, incl. private projects, for update reports.

[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/sgrottel/native-nuget-dependabot)](https://github.com/sgrottel/native-nuget-dependabot/pulls)
[![GitHub Issues](https://img.shields.io/github/issues/sgrottel/native-nuget-dependabot)](https://github.com/sgrottel/native-nuget-dependabot/issues)
[![Update config](https://github.com/sgrottel/native-nuget-dependabot/actions/workflows/update.yml/badge.svg)](https://github.com/sgrottel/native-nuget-dependabot/actions/workflows/update.yml)

This repository holds synthetic `csproj` files with Nuget dependencies mirrored from other projects, either in private or offline projects, or in native Cpp code `vcxproj` projects.
Those projects cannot be automatically scanned by Dependabot, either for visibility or for feature set:

[![GitHub issue/pull request detail](https://img.shields.io/github/issues/detail/state/dependabot/dependabot-core/9711) Support .vcxproj for NuGet dependencies](https://github.com/dependabot/dependabot-core/issues/9711)

As [suggested]( https://github.com/dependabot/dependabot-core/issues/8590#issuecomment-1988870679), and similar to [this example]( https://github.com/willbush/dependabot-cpm-updates), this repository hosts proxy projects, which can be scanned by Dependabot.

The content of this repository is very specific to my projects, and it is not really useful by itself.
It's just part of my "updates available reporting setup."
Of course, you can have a look to get inspirations and copies for your own solution to similar problems

## Scripts

### Set-Project.ps1
This script adds a project to this repository.

Invoke:
```
.\Set-Project.ps1 <group> <name> <file.vcxproj> [<info>]
```

It also supports `<file.csproj>`.

- `Group` will be a directory name.
- `Name` will be the final subdirectory name and proxy project file name.
- `file.vcxproj` is the input vcxproj file to load
- `info` is an optional human-readable info about this project, e.g. it's origin.
  This string will be included in the proxy project file as xml comment.

This script does not commit changes or push changes.

Examples:
```ps
.\Set-Project.ps1 -projFile "C:\Dev\tiny-tools\ToggleDisplay\ToggleDisplay.vcxproj" -group "tiny-tools" -name "ToggleDisplay" -info "https://github.com/sgrottel/tiny-tools-collection"

.\Set-Project.ps1 -projFile "C:\Dev\tiny-tools\GlobalHotKeys\GlobalHotKeys.vcxproj" -group "tiny-tools" -name "GlobalHotKeys" -info "https://github.com/sgrottel/tiny-tools-collection"

.\Set-Project.ps1 -projFile "C:\Dev\open-here\ToolboxLib\ToolboxLib.vcxproj" -group "open-here" -name "ToolboxLib" -info "https://github.com/sgrottel/open-here"
```

### Update.ps1
This script is automatically triggered by github action CI on changes on the main branch.
It will update all structural files of this repository, esp. the github action configuration of Dependabot.

Invoke:
```
.\Update.ps1
```

## License
The contents of this repository is freely available under the terms of the [MIT License](LICENSE):

> MIT License
> 
> Copyright (c) 2025 Sebastian Grottel
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.

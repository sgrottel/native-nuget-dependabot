# Native Nuget Dependabot
Proxy project repository to use Dependabot for Nuget packages in native Cpp projects, incl. private projects, for update reports.

![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-pr/sgrottel/native-nuget-dependabot)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/sgrottel/native-nuget-dependabot)

This repository holds synthetic `csproj` files with Nuget dependencies mirrored from other projects, either in private or offline projects, or in native Cpp code `vcxproj` projects.
Those projects cannot be automatically scanned by Dependabot, either for visibility or for feature set:

[![GitHub issue/pull request detail](https://img.shields.io/github/issues/detail/state/dependabot/dependabot-core/9711) Support .vcxproj for NuGet dependencies](https://github.com/dependabot/dependabot-core/issues/9711)

As [suggested]( https://github.com/dependabot/dependabot-core/issues/8590#issuecomment-1988870679), and similar to [this example]( https://github.com/willbush/dependabot-cpm-updates), this repository hosts proxy projects, which can be scanned by Dependabot.

The content of this repository is very specific to my projects, and it is not really useful by itself.
It's just part of my "updates available reporting setup."
Of course, you can have a look to get inspirations and copies for your own solution to similar problems

## Scripts

🚧 TODO

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

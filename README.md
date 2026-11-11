# ext.image.WEBP

WebP image previews for MNXArchiver.

Decode static lossy and lossless WebP images, including alpha, directly to premultiplied BGRA. The extension uses the SkiaSharp native library shipped with MNXArchiver. Animated WebP is outside this version’s supported formats.

## Install

Version 1.0.1 supports MNXArchiver 2.0.0 through 2.1.999 and uses native ABI 1.
Download the ZIP for your OS and CPU architecture, extract `ext.image.WEBP.mnxp`,
and place it in the plugin folder. In MNXArchiver use **Help → Open Plugins Dir**
to open that folder and **Help → About** to confirm the extension loaded after restarting.

- Linux uses `${XDG_CONFIG_HOME:-$HOME/.config}/mnxarchiver/plugins/`.
- Windows uses `%APPDATA%\mnxarchiver\plugins\`.

Install [MNXArchiver](https://github.com/Mashrien/MNXArchiver) and the
[MNXFile engine](https://github.com/Mashrien/MNXFile) separately.

## Build

Use the .NET 10 SDK and the platform’s NativeAOT toolchain. On Linux x64 run

```sh
dotnet publish ext.image.WEBP.csproj -c Release -r linux-x64 -o ./publish/linux-x64
```

On Windows with Visual Studio C++ build tools and a Windows SDK run

```powershell
dotnet publish ext.image.WEBP.csproj -c Release -r win-x64 -o ./publish/win-x64
```

Both commands produce `ext.image.WEBP.mnxp`. The C declarations are in
[`include/mnx_image_provider.h`](include/mnx_image_provider.h).

## Interface

The provider returns pixels to the preview renderer. Archive extraction continues to return the original WebP bytes.

## Source

This independent project was split from the
[MNXArchiver 2.1.0.73 source](https://github.com/Mashrien/MNXArchiver/tree/6e335a3/plugins).
It uses the host’s existing extension ABI and is licensed under GPL-3.0-only.

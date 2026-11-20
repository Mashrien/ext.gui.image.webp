# ext.gui.image.webp

WebP image previews for MNXArchiver.

Decode static lossy and lossless WebP images, including alpha, directly to premultiplied BGRA. The extension uses the SkiaSharp native library shipped with MNXArchiver. Animated WebP is outside this version’s supported formats.

## Install

Version 1.0.2 supports MNXArchiver 2.0.0 through 2.1.999 and uses native ABI 1.
Download the ZIP for your OS and CPU architecture, extract `ext.gui.image.webp.mnxp`,
and place it in the plugin folder. When upgrading, replace the earlier WebP plugin file. In MNXArchiver use **Help → Open Plugins Dir**
to open that folder and **Help → About** to confirm the extension loaded after restarting.

- Linux uses `${XDG_CONFIG_HOME:-$HOME/.config}/mnxarchiver/plugins/`.
- Windows uses `%APPDATA%\mnxarchiver\plugins\`.

Install [MNXArchiver](https://github.com/Mashrien/MNXArchiver) and the
[MNXFile engine](https://github.com/Mashrien/MNXFile) separately.

## Build

Use the .NET 10 SDK and the platform’s NativeAOT toolchain. NuGet restores
SkiaSharp 3.119.4 and the NativeAOT compiler pack (at least 10.0.14).
On Linux x64, install Clang and the platform development libraries, then run:

```sh
./build.sh
```

On Windows x64, use a Visual Studio developer PowerShell with the C++ build
tools and a Windows SDK available, then run:

```powershell
./build.ps1
```

Both scripts copy only `ext.gui.image.webp.mnxp` into
`../MNX_Builds/ext.gui.image.webp/{linux-x64,win-x64}` relative to this checkout.
Pass a directory to override that destination, such as `./build.sh ./release`
or `./build.ps1 -OutputDirectory ./release`. Build intermediates stay in ignored
`bin/` and `obj/` directories. Linux and Windows NativeAOT builds run on their
respective platforms.

The plugin uses the host's `libSkiaSharp.so` on Linux or `libSkiaSharp.dll` on
Windows. Do not distribute a separate SkiaSharp native library with this plugin.

## Interface

The provider returns pixels to the preview renderer. Archive extraction continues to return the original WebP bytes.

- Static lossy (`VP8`), lossless (`VP8L`), and extended (`VP8X`) images, including alpha.
- Full or half resolution output in premultiplied BGRA, with caller-supplied row stride.
- Header validation rejects truncated containers, mismatched dimensions, and animated WebP.

## Source map

- [`NativeExports.cs`](NativeExports.cs): ABI entry points, destination checks, and SkiaSharp decoding.
- [`WebpHeader.cs`](WebpHeader.cs): RIFF chunk parsing and static image dimensions.
- [`ImageProviderProtocol.cs`](ImageProviderProtocol.cs): shared status values, metadata, and JSON descriptor.
- [`include/mnx_image_provider.h`](include/mnx_image_provider.h): C declarations for native ABI 1.
- [`NativeExtension.targets`](NativeExtension.targets): names the NativeAOT shared library with the `.mnxp` suffix.

## Source

This independent project was split from the
[MNXArchiver 2.1.0.73 source](https://github.com/Mashrien/MNXArchiver/tree/6e335a3/plugins).
It uses the host’s existing extension ABI and is licensed under GPL-3.0-only.

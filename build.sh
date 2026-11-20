#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
output_dir=${1:-"$project_dir/../MNX_Builds/ext.gui.image.webp/linux-x64"}
publish_dir="$project_dir/bin/publish/linux-x64"

dotnet publish "$project_dir/ext.gui.image.webp.csproj" \
    -c Release -r linux-x64 -o "$publish_dir" -p:UseSharedCompilation=false

# Only the plugin is distributed; MNXArchiver supplies the SkiaSharp native library.
mkdir -p -- "$output_dir"
install -m 755 -- "$publish_dir/ext.gui.image.webp.mnxp" "$output_dir/ext.gui.image.webp.mnxp"
printf 'Built %s/ext.gui.image.webp.mnxp\n' "$output_dir"

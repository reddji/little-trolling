# URL of the image to download
$imageUrl = "https://i.imgur.com/QESZuU2.jpg"

# Get the temporary directory path
$tempDirectory = [System.IO.Path]::GetTempPath()

# Set the file name for the downloaded image
$fileName = "downloaded_image.jpg"
$outputPath = Join-Path -Path $tempDirectory -ChildPath $fileName

# Download the image from the URL
Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath

# Set the wallpaper
Add-Type -Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

# Set the desktop wallpaper using COM object
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $outputPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

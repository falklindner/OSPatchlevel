function Get-FileEncoding {
    param (
        [string]$FilePath
    )
    
    # Read the first few bytes to check for a BOM
    $bytes = [System.IO.File]::ReadAllBytes($FilePath)
    
    # Check for known BOMs based on the first few bytes
    # UTF-8 format with Byte Order Mark (BOM)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        return "utf8BOM"
    }
    # UTF-16 LE (Little Endian)
    elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
        return "unicode"
    }
    # UTF-16 BE (Big Endian)
    elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFE -and $bytes[1] -eq 0xFF) {
        return "bigendianunicode"
    }
    # UTF-32 BE 
    elseif ($bytes.Length -ge 4 -and $bytes[0] -eq 0x00 -and $bytes[1] -eq 0x00 -and $bytes[2] -eq 0xFE -and $bytes[3] -eq 0xFF) {
        return "bigendianutf32"
    }
    # UTF-32 LE
    elseif ($bytes.Length -ge 4 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE -and $bytes[2] -eq 0x00 -and $bytes[3] -eq 0x00) {
        return "utf32"
    }
    else {
        # Attempt UTF-8 decoding first
        $utf8Decoded = $false
        try {
            [System.Text.Encoding]::UTF8.GetString($bytes) | Out-Null
            $utf8Decoded = $true
        } catch {}

        # Check for high-value bytes (common in ANSI but not ASCII or pure UTF-8)
        $containsHighByte = $bytes | ForEach-Object { $_ -ge 128 }

        if ($utf8Decoded -and -not $containsHighByte) {
            return "utf8NoBOM"
        }
        elseif ($containsHighByte) {
            return "Default"
        }
        else {
            return "Unknown encoding"
        }
    }
}

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file, You
# can obtain one at http://mozilla.org/MPL/2.0/.
# ==============================================================================


$SESSIONS_COUNT_LIMIT_MIN = 0
$SESSIONS_COUNT_LIMIT_MAX = 60000
$TRIMED_FILE_LEN = 784

# Arguments
$SORT = $($args[0])


function processSession($SOURCE_SESSION_DIR) {
    Write-Host "[INFO] If Sessions more than $SESSIONS_COUNT_LIMIT_MAX we only select the largest $SESSIONS_COUNT_LIMIT_MAX."
    Write-Host "[INFO] Finally Selected Sessions:"

    $dirs = Get-ChildItem $SOURCE_SESSION_DIR -Directory
    foreach ($d in $dirs) {
        $files = Get-ChildItem $d.FullName
        $count = $files.count
        if ($count -gt $SESSIONS_COUNT_LIMIT_MIN) {             
            Write-Host "$($d.Name) $count"       
            if ($count -gt $SESSIONS_COUNT_LIMIT_MAX) {
                if ($SORT -eq "-s") {
                    $files = $files | Sort-Object Length -Descending | Select-Object -First $SESSIONS_COUNT_LIMIT_MAX
                }
                elseif ($SORT -eq "-u")  {
                    $files = $files | Select-Object -First $SESSIONS_COUNT_LIMIT_MAX
                }
                $count = $SESSIONS_COUNT_LIMIT_MAX
            }
            $files = $files | Resolve-Path
            $test  = $files | Get-Random -count ([int]($count / 10))
            $train = $files | ?{$_ -notin $test}     

            $path_test  = "3_ProcessedSession\FilteredSession\Test\$($d.Name)"
            $path_train = "3_ProcessedSession\FilteredSession\Train\$($d.Name)"
            New-Item -Path $path_test -ItemType Directory -Force
            New-Item -Path $path_train -ItemType Directory -Force

            Copy-Item $test -destination $path_test        
            Copy-Item $train -destination $path_train
        }
    }

    Write-Host "[INFO] All files will be trimed to $TRIMED_FILE_LEN length and if it's even shorter we'll fill the end with 0x00..."
    
    $paths = @(('3_ProcessedSession\FilteredSession\Train', '3_ProcessedSession\TrimedSession\Train'), ('3_ProcessedSession\FilteredSession\Test', '3_ProcessedSession\TrimedSession\Test'))
    foreach ($p in $paths) {
        foreach ($d in Get-ChildItem $p[0] -Directory) {
            New-Item -Path "$($p[1])\$($d.Name)" -ItemType Directory -Force
            foreach ($f in Get-ChildItem $d.fullname) {
                $content = [System.IO.File]::ReadAllBytes($f.FullName)
                $len = $f.length - $TRIMED_FILE_LEN
                if ($len -gt 0) {        
                    $content = $content[0..($TRIMED_FILE_LEN - 1)]        
                }
                elseif ($len -lt 0) {        
                    $padding = [Byte[]] (,0x00 * ([math]::abs($len)))
                    $content = $content += $padding
                }
                Set-Content -Value $content -AsByteStream -Path "$($p[1])\$($d.Name)\$($f.Name)"
            }        
        }
    }
}


if ($($args.Count) -ne 1) {
    Write-Host "[ERROR] Wrong format of command!"
    Write-Host "[INFO]:   pwsh 2_ProcessSession.ps1 <SORT>"
    Write-Host "[INFO] <SORT>: -s (Sorting) | -u (No sorting)"
}
else {    
    
    processSession "2_Session\AllLayers"
   
}

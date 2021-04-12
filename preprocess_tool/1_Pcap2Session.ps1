$SOURCE_PCAP_DIR = "1_Pcap"

if ($($args.Count) -ne 0) {
    Write-Host $($args.Count)
    Write-Host "[ERROR] Wrong format of command!"
    Write-Host "[INFO]:   pwsh 1_Pcap2Session.ps1"
} 
else {
	Write-Host "[INFO] Spliting the PCAP file into each session"
	foreach ($f in Get-ChildItem $SOURCE_PCAP_DIR) {
	    $FolderName = $f.BaseName.Split('_')[0]
	    #Write-Host $FolderName
	    mono ./0_Tool/SplitCap_2-1/SplitCap.exe -p 4000 -b 50000 -r $f -o ./2_Session/AllLayers/$($FolderName)
	    Get-ChildItem ./2_Session/AllLayers/$($FolderName) | ?{$_.Length -eq 0} | Remove-Item
	}

	# Remove duplicate files
	Write-Host "[INFO] Removing duplicate files"

	# For Linux
	fdupes -rdN ./2_Session/AllLayers/


}

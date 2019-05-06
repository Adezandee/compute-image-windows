$global:logger = 'GCEExtraScripts'
$script:gce_install_dir = 'C:\Program Files\Google\Compute Engine'
$script:gce_base_loc = "$script:gce_install_dir\sysprep\gce_base.psm1"

try {
  Import-Module $script:gce_base_loc -ErrorAction Stop 3> $null
}
catch [System.Management.Automation.ActionPreferenceStopException] {
  Write-Host $_.Exception.GetBaseException().Message
  Write-Host ("Unable to import GCE module $script:gce_base_loc. " +
      'Check error message, or ensure module is present.')
  exit 2
}

function Extend-OSPartition {
  $partition = Get-Partition -DriveLetter C
  $supported = Get-PartitionSupportedSize -DriveLetter C
  Write-Log "Primary partition: $($partition.Size)/$($supported.SizeMax)."

  if ($partition.Size -ne $supported.SizeMax) {
    Write-Log "Resizing partition to $($supported.SizeMax)."
    Resize-Partition -DriveLetter C -Size $supported.SizeMax
  }
}

Extend-OSPartition

Write-Log "Finished running extra scripts."

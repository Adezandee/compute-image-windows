$install_dir = "${env:ProgramFiles}\Google\Compute Engine\extra_scripts"
$machine_env = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'

$path = (Get-ItemProperty $machine_env).Path
if ($path -like "*${install_dir}*") {
  Set-ItemProperty $machine_env -Name 'Path' -Value $path.Replace(";$install_dir", '')
}

& schtasks /delete /tn GCEStartupExtra /f

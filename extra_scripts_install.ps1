$install_dir = "${env:ProgramFiles}\Google\Compute Engine\extra_scripts"
$machine_env = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'

$path = (Get-ItemProperty $machine_env).Path
if ($path -notlike "*${install_dir}*") {
  Set-ItemProperty $machine_env -Name 'Path' -Value ($path + ";${install_dir}")
}

$startup_extra_scripts = "${install_dir}\startup_extra_scripts.cmd"
$service = New-Object -ComObject("Schedule.Service")
$service.Connect()
$task = $service.NewTask(0)
$task.Settings.Enabled = $true
$task.Settings.AllowDemandStart = $true
$task.Settings.Priority = 5
$action = $task.Actions.Create(0)
$action.Path = "`"$startup_extra_scripts`""
$trigger = $task.Triggers.Create(8)
$folder = $service.GetFolder('\')
$folder.RegisterTaskDefinition('GCEStartupExtra',$task,6,'System',$null,5) | Out-Null

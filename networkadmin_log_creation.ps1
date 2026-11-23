
 $rootDir = "$env:USERPROFILE\NetAdminLogs"

 $subDir = @(
    "$rootDir\audit",            
    "$rootDir\nmap",             
    "$rootDir\pcaps",            
    "$rootDir\network_changes",  
    "$rootDir\installs",         
    "$rootDir\scripts",          
    "$rootDir\exports"           
)

$colorSuccess = @{ 
    BackgroundColor = 'Black'
    ForegroundColor = 'Green' 
}

$colorWarning = @{ 
    BackgroundColor = 'Black'
    ForegroundColor = 'Red' 
}	


#Validate script is running as admin 	

function Validate_Admin {

	if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
		Write-Host "Please run this script as Administrator." @colorWarning
		exit 1
	} else {
		Write-Host "Running as Administrator." @colorSuccess
	}
}


#Valistate Root dir exists. If not then create. 

 function Validate_Root_Dir{
 
    if(-not(Test-Path $rootDir)){
        Write-Host "Root Directory does not exist" @colorWarning
        Write-Host "Creating Directory.." @colorSuccess
        try 
        {
            New-Item -ItemType Directory -Path $rootDir
            Write-Host "$rootDir has been created." @colorSuccess
        } 
        catch 
        {
            Write-Host "An error occurred: $_" @colorWarning
        }
    } 

    Write-Host "$rootDir has been validated" @colorSuccess
}
 
 
function Main {

	Validate_Admin
	Validate_Root_Dir
	
	forEach($dir in $subDir) {
		
		    if(-not(Test-Path $dir)){
				Write-Host "Sub Directory does not exist" @colorWarning
				Write-Host "Creating Directroy."  @colorSuccess
				try
				{
					New-Item -ItemType Directory -Path $dir
					Write-Host "$dir has been created." @colorSuccess
				}
				catch
				{
					Write-Host "An error occurred: $_" @colorWarning
			}
        }

        Write-Host "$dir has been validated" @colorSuccess				
	}
	
}

Main

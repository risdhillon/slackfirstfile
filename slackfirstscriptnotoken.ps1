$gitrepo="https://github.com/risdhillon/slack-invite-automation.git"
$gittoken="INSERT TOKEN HERE"
$webappname="rishamDemoSlack"
$location="West Europe"

# Create a resource group.
New-AzureRmResourceGroup -Name rishamdemoA -Location $location

# Create an App Service plan in Free tier.
New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName rishamdemoA -Tier Free

# Create a web app.
New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName rishamdemoA

# SET GitHub
$PropertiesObject = @{token = $token;}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceId /providers/Microsoft.Web/sourcecontrols/GitHub -ApiVersion 2015-08-01 -Force

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{repoUrl = "$gitrepo"; branch = "master";}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName rishamdemoA -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
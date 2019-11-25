Import-Module SitecoreFundamentals
Import-Module SitecoreInstallFramework

#define parameters 
$prefix = "sc902"
$XConnectCollectionService = "$prefix.xconnect"
$sitecoreSiteName = "$prefix.local"
$SolrUrl = "https://localhost:8983/solr"
$SolrRoot = "C:\solr-6.6.2"
$SolrService = "solr"
$SqlServer = "DESKTOP-BKEV1BM\SQLEXPRESSNEW"
$SqlAdminUser = "sa"
$SqlAdminPassword = "12345" 
#$SqlAdminUser = "$prefix"
#$SqlAdminPassword = "Pa##w0rd" 
$FilesRoot = "C:\Sitecore\902"
 
#install client certificate for xconnect 
$certParams = 
@{     
    Path = "$FilesRoot\xconnect-createcert.json"     
    CertificateName = "$prefix.xconnect_client" 
} 
Install-SitecoreConfiguration @certParams -Verbose



#install solr cores for xdb 
$solrParams = 
@{
    Path = "$FilesRoot\xconnect-solr.json"     
    SolrUrl = $SolrUrl    
    SolrRoot = $SolrRoot  
    SolrService = $SolrService  
    CorePrefix = $prefix 
} 
Install-SitecoreConfiguration @solrParams -Verbose

#deploy xconnect instance 
$xconnectParams = 
@{
    Path = "$FilesRoot\xconnect-xp0.json"     
    Package = "$FilesRoot\Sitecore 9.0.2 rev. 180604 (OnPrem)_xp0xconnect.scwdp.zip"
    LicenseFile = "$FilesRoot\license.xml"
    Sitename = $XConnectCollectionService   
    XConnectCert = $certParams.CertificateName    
    SqlDbPrefix = $prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser
    SqlAdminPassword = $SqlAdminPassword
    SolrCorePrefix = $prefix
    SolrURL = $SolrUrl      
    SqlCollectionUser = $SqlAdminUser
    SqlCollectionPassword = $SqlAdminPassword
    SqlMarketingAutomationUser = $SqlAdminUser
    SqlMarketingAutomationPassword = $SqlAdminPassword
    SqlReferenceDataUser = $SqlAdminUser
    SqlReferenceDataPassword = $SqlAdminPassword
    SqlProcessingPoolsUser = $SqlAdminUser
    SqlProcessingPoolsPassword = $SqlAdminPassword
} 
Install-SitecoreConfiguration @xconnectParams -Verbose

#install solr cores for sitecore 
$solrParams = 
@{
    Path = "$FilesRoot\sitecore-solr.json"
    SolrUrl = $SolrUrl
    SolrRoot = $SolrRoot
    SolrService = $SolrService     
    CorePrefix = $prefix 
} 
Install-SitecoreConfiguration @solrParams -Verbose
 
#install sitecore instance 
$sitecoreParams = 
@{     
    Path = "$FilesRoot\sitecore-XP0.json"
    Package = "$FilesRoot\Sitecore 9.0.2 rev. 180604 (OnPrem)_single.scwdp.zip" 
    LicenseFile = "$FilesRoot\license.xml"
    SqlDbPrefix = $prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser     
    SqlAdminPassword = $SqlAdminPassword     
    SolrCorePrefix = $prefix  
    SolrUrl = $SolrUrl     
    XConnectCert = $certParams.CertificateName     
    Sitename = $sitecoreSiteName         
    XConnectCollectionService = "https://$XConnectCollectionService"    
    SqlCoreUser = $SqlAdminUser
    SqlCorePassword = $SqlAdminPassword
    SqlMasterUser = $SqlAdminUser
    SqlMasterPassword = $SqlAdminPassword
    SqlWebUser = $SqlAdminUser
    SqlWebPassword = $SqlAdminPassword
    SqlFormsUser = $SqlAdminUser
    SqlFormsPassword = $SqlAdminPassword
    SqlProcessingTasksUser = $SqlAdminUser
    SqlProcessingTasksPassword = $SqlAdminPassword
    SqlReportingUser = $SqlAdminUser
    SqlReportingPassword = $SqlAdminPassword
    SqlMarketingAutomationUser = $SqlAdminUser
    SqlMarketingAutomationPassword = $SqlAdminPassword
    SqlReferenceDataUser = $SqlAdminUser
    SqlReferenceDataPassword = $SqlAdminPassword
    SqlProcessingPoolsUser = $SqlAdminUser
    SqlProcessingPoolsPassword = $SqlAdminPassword
} 
Install-SitecoreConfiguration @sitecoreParams -Verbose
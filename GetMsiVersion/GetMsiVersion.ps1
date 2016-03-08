Invoke-DscResource -name package -Method get -ModuleName PSDesiredStateConfiguration -Property @{
    ProductID='{DD3A1267-1A98-4332-BE1A-1D415C2CC1D8}'
    Name='Microsoft Lync Web App Plug-in'
    Path='C:\whyisthisneeded.msi'
}

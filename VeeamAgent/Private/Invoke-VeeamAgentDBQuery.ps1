function Invoke-VeeamAgentDBQuery {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Query
    )
    Write-Verbose $Query

    $connectionString = "Data Source=$($script:VeeamAgentSQLParam.dataSource); User ID=$($script:VeeamAgentSQLParam.Username);Password=$($script:VeeamAgentSQLParam.Password); Initial Catalog=$($script:VeeamAgentSQLParam.database)"

    $connection = new-object system.data.SqlClient.SQLConnection($connectionString)
    $command = new-object system.data.sqlclient.sqlcommand($Query,$connection)
    $connection.Open()

    $adapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataSet) | Out-Null

    $connection.Close()
    $dataSet.Tables[0]
}
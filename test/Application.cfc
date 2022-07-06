component{

	/* A server mapping /testbox needs to exist and point to testbox */

	this.name = "luceeMariaDBJDBCTests"
	this.sessionManagement = false
	this.scopeCascading = "strict"
	this.localMode = "modern"
	this.applicationTimeout = CreateTimeSpan( 0, 0, 5, 0 )

	//Environment variables can be used to override the default connection details
	variables.database = {
		host: server.system.environment.MARIADB_HOST?:"localhost"
		,port: server.system.environment.MARIADB_PORT?:3306
		,username: server.system.environment.MARIADB_LUCEE_USER?:"lucee"
		,password: server.system.environment.MARIADB_LUCEE_PASSWORD?:"pass"
	}
	
	this.datasource = {
		class: "org.mariadb.jdbc.Driver"
		,connectionString: "jdbc:mariadb://#database.host#:#database.port#/tests?allowMultiQueries=true"
		,username: database.username
		,password: database.password
	}
	
}
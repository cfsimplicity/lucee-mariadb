component extends="types.Driver" output="no" implements="types.IDatasource" {

	fields = array(
		
		field( 
			"Allow multiple Queries"
			,"allowMultiQueries"
			,"true,false"
			,false
			,"Allow the use of "";"" to delimit multiple queries during one statement"
			,"radio"
		),

		field(
		 	"TinyInt(1) is bit"
		 	,"tinyInt1isBit"
		 	,"true,false"
		 	,true
		 	,"Datatype mapping flag, handle MySQL Tiny as BIT(boolean)."
		 	,"radio"
		 ),

		field(
			"SSL mode"
			,"sslMode"
			,"disable,trust,verify-ca,verify-full"
			,true
			,"Enables SSL/TLS in a specific mode. The following values are supported:
			<ul>
				<li><b>disable</b>: Do not use SSL/TLS (default).</li>
				<li><b>trust</b>: Only use SSL/TLS for encryption. Do not perform certificate or hostname verification. This mode is not safe for production applications.</li>
				<li><b>verify-ca</b>: Use SSL/TLS for encryption and perform certificates verification, but do not perform hostname verification.</li>
				<li><b>verify-full</b>: Use SSL/TLS for encryption, certificate verification, and hostname verification.</li>
			</ul>"
			,"select"
		),

		field(
			"Allow local infile"
			,"allowLocalInfile"
			,"true,false"
			,true
			,"Defines if loading data from file with LOAD DATA LOCAL INFILE is permitted. Disabling it can improve batch performance"
			,"radio"
		 )

	);

	this.type.port = this.TYPE_FREE;
	
	this.value.host = "localhost";
	this.value.port = 3306;
	this.className = "org.mariadb.jdbc.Driver";
	this.bundleName = "mariadb-java-client";
	this.dsn = "jdbc:mariadb://{host}:{port}/{database}";

	public void function onBeforeUpdate() {
		custom_useUnicode = true;
		
		// Timezone
		if( !IsNull( form.timezone ) && !IsEmpty( form.timezone ) )
			local.tz = form.timezone;
		else
			local.tz = ToString( GetTimezone() );
		form[ "custom_serverTimezone" ] = tz;

	}

	/**
	* returns display name of the driver
	*/
	public string function getName() {
		return "MariaDB";
	}

	/**
	* returns the id of the driver
	*/
	public string function getId() {
		return "mariadb";
	}

	/**
	* returns the description of the driver
	*/
	public string function getDescription() {
		return "JDBC Type 4 Driver for the MariaDB database.";
	}

	/**
	* returns array of fields
	*/
	public array function getFields() {
		return fields;
	}

	public boolean function literalTimestampWithTSOffset() {
		return false;
	}

	public boolean function alwaysSetTimeout() {
		return true;
	}
}
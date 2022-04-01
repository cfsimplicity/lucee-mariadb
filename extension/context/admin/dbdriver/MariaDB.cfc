component extends="types.Driver" output="no" implements="types.IDatasource" {

	fields = array(
		field(
			"Use Unicode"
			,"useUnicode"
			,"true,false"
			,true
			,"Should the driver use Unicode character encodings when handling strings? Should only be used when the driver can't determine the character set mapping, or you are trying to 'force' the driver to use a character set that MySQL either doesn't natively support (such as UTF-8)"
			,"radio"
		),
		
		field(
			"Charset"
			,"characterEncoding"
			,"UTF-8"
			,false
			,"If 'Use Unicode' is set to true, what character encoding should the driver use when dealing with strings?"
		),

		field( 
			"Allow multiple Queries"
			,"allowMultiQueries"
			,"true,false"
			,false
			,"Allow the use of ';' to delimit multiple queries during one statement"
			,"radio"
		),
		
		field(
			"Auto reconnect"
			,"autoReconnect"
			,"true,false"
			,false
			,"Should the driver try to re-establish stale and/or dead connections? If enabled the driver will throw an exception for a queries issued on a stale or dead connection, which belong to the current transaction, but will attempt reconnect before the next query issued on the connection in a new transaction. The use of this feature is not recommended, because it has side effects related to session state and data consistency when applications do not handle SQLExceptions properly, and is only designed to be used when you are unable to configure your application to handle SQLExceptions resulting from dead and stale connections properly. Alternatively, investigate setting the MySQL server variable 'wait_timeout' to some high value rather than the default of 8 hours."
			,"radio"
		),
		
		field(
		 	"Throw error upon data truncation"
		 	,"jdbcCompliantTruncation"
		 	,"true,false"
		 	,true
		 	,"Truncation error (""Data truncated for column '%' at row %"", ""Out of range value for column '%' at row %"") will be thrown as an error, and not as a warning."
		 	,"radio"
		 ),

		field(
		 	"TinyInt(1) is bit"
		 	,"tinyInt1isBit"
		 	,"true,false"
		 	,true
		 	,"Datatype mapping flag, handle MySQL Tiny as BIT(boolean)."
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
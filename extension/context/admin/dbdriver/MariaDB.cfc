component extends="types.Driver" output="no" implements="types.IDatasource" {

	fields=array(
		field("Use Unicode","useUnicode","true,false",true,"Should the driver use Unicode character encodings when handling strings? Should only be used when the driver can't determine the character set mapping, or you are trying to 'force' the driver to use a character set that MySQL either doesn't natively support (such as UTF-8)","radio"),
		field("Charset","characterEncoding","UTF-8",false,"If 'Use Unicode' is set to true, what character encoding should the driver use when dealing with strings?"),
		//field("cache ResultSetMetadata","cacheResultSetMetadata","true,false",false,"Should the driver cache ResultSetMetaData for Statements and PreparedStatements.","radio"),
		
		field("Alias Handling","useOldAliasMetadataBehavior","true,false",false,"Should the driver use the legacy behavior for ""AS"" clauses on columns and tables, 
		and only return aliases (if any) rather than the original column/table name? In 5.0.x, the default value was true.","radio"),
		//,field("Allow Multiple Queries","allowMultiQueries","true,false",false,"Allow the use of "";"" to delimit multiple queries during one statement (true/false), defaults to ""false""","radio")
		
		
		field('Allow multiple Queries','allowMultiQueries','true,false',false,'Allow the use of ";" to delimit multiple queries during one statement',"radio"),
		
		field('Zero DateTime behavior','zeroDateTimeBehavior','EXCEPTION,ROUND,CONVERT_TO_NULL',false,'What should happen when the driver encounters DATETIME values that are composed entirely of zeroes (used by MySQL to represent invalid dates)? Valid values are "exception", "round" and "convert_to_null"',"radio"),
		
		field('Auto reconnect','autoReconnect','true,false',false,'Should the driver try to re-establish stale and/or dead connections? If enabled the driver will throw an exception for a queries issued on a stale or dead connection, which belong to the current transaction, but will attempt reconnect before the next query issued on the connection in a new transaction. The use of this feature is not recommended, because it has side effects related to session state and data consistency when applications do not handle SQLExceptions properly, and is only designed to be used when you are unable to configure your application to handle SQLExceptions resulting from dead and stale connections properly. Alternatively, investigate setting the MySQL server variable "wait_timeout" to some high value rather than the default of 8 hours.',"radio"),
		
		 field('Throw error upon data truncation','jdbcCompliantTruncation','true,false',false,'If set to false then values for table fields are automatically truncated so that they fit into the field.',"radio"),
		 field('TinyInt(1) is bit','tinyInt1isBit','true,false',false,'this defines the data type returned for tinyInt(1), if set to "true" (default) tinyInt(1) is converted to a bit value otherwise as integer.',"radio"),
		 field('Legacy Datetime Code','useLegacyDatetimeCode','true,false',true,
		 	'Use code for DATE/TIME/DATETIME/TIMESTAMP handling in result sets and statements that consistently handles timezone conversions from client to server and back again, or use the legacy code for these datatypes that has been in the driver for backwards-compatibility?'
		 		,"radio",1)
	);


	this.type.port=this.TYPE_FREE;
	
	this.value.host="localhost";
	this.value.port=3306;
	this.className="org.mariadb.jdbc.Driver";
	this.bundleName="mariadb-java-client";
	this.dsn="jdbc:mariadb://{host}:{port}/{database}";

	public void function onBeforeUpdate() {
		custom_useUnicode=true;
		
		// Timezone
		if(!isNull(form.timezone) && !isEmpty(form.timezone)) local.tz=form.timezone;
		else local.tz=toString(getTimezone());
		form['custom_serverTimezone']=tz;

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
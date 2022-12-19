component extends="testbox.system.BaseSpec" labels="mariaDb" {

	private string function getClassName( required object object ){
		return GetMetaData( arguments.object ).getCanonicalName()
	}

	private struct function insertBlankRow(){
		var sql = "INSERT INTO `datatypes` SET bitField = NULL"
		QueryExecute( sql, {}, { result: "insertResult" } )
		return insertResult
	}

	function beforeAll(){
		variables.database = {
			host: server.system.environment.MARIADB_HOST?:"localhost"
			,port: server.system.environment.MARIADB_PORT?:3306
			,username: server.system.environment.MARIADB_LUCEE_USER?:"lucee"
			,password: server.system.environment.MARIADB_LUCEE_PASSWORD?:"pass"
		}

		systemOutput(database, true);
		
		application action="update" datasource={
			class: "org.mariadb.jdbc.Driver"
			,connectionString: "jdbc:mariadb://#database.host#:#database.port#/tests?allowMultiQueries=true"
			,username: database.username
			,password: database.password
		};

		dbinfo type="Version" name="verify";
		systemOutput(verify, true);

		include "../sql/setup.cfm"
		insertBlankRow()
		variables.testValues = {
			bit: 0
			,boolean: true
			,booleanString: "true"
			,date: CreateDate( 2022, 7, 4 )
			,datetime: CreateDateTime( 2022, 7, 4, 15, 20, 30 )
			,int: 1000
			,text: RepeatString( "a ", 30000 )
			,tinyint: 1
			,varchar: "testing"
		}
	}

	function afterAll(){
		QueryExecute( "DROP TABLE IF EXISTS `datatypes`" )
		QueryExecute( "DROP TABLE IF EXISTS `testnotes`" )
	}

	function run( testResults, testBox ){

		describe( "the MariaDB JDBC driver", ()=> {

			it( "returns an auto generated primary key after an insert", ()=> {
				var insertResult = insertBlankRow()
				expect( insertResult.generatedKey ).toBeGT( 0 )
				QueryExecute( "DELETE FROM `datatypes` WHERE pk = :pk", { pk: insertResult.generatedKey } )
			})

			it( "can add and retrieve a bit value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET bitField = :testValue", { testValue: { value: testValues.bit, sqltype: "bit" } } )
				var result = QueryExecute( "SELECT bitField FROM `datatypes`" )
				expect( result.bitField ).toBe( testValues.bit )
				expect( getClassName( result.bitField ) ).toBe( "java.lang.Boolean" )
			})

			it( "can add and retrieve a boolean value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET booleanField = :testValue", { testValue: { value: testValues.boolean, sqltype: "boolean" } } )
				var result = QueryExecute( "SELECT booleanField FROM `datatypes`" )
				expect( result.booleanField ).toBe( testValues.boolean )
				expect( getClassName( result.booleanField ) ).toBe( "java.lang.Double" )
			})

			it( "can add and retrieve a boolean string value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET booleanField = :testValue", { testValue: { value: testValues.booleanString, sqltype: "boolean" } } )
				var result = QueryExecute( "SELECT booleanField FROM `datatypes`" )
				expect( result.booleanField ).toBe( testValues.boolean )
				expect( getClassName( result.booleanField ) ).toBe( "java.lang.Double" )
			})

			it( "can add and retrieve a date value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET dateField = :testValue", { testValue: { value: testValues.date, sqltype: "date" } } )
				var result = QueryExecute( "SELECT dateField FROM `datatypes`" )
				expect( result.dateField ).toBe( testValues.date )
				expect( getClassName( result.dateField ) ).toBe( "lucee.runtime.type.dt.DateTimeImpl" )
			})

			it( "can add and retrieve a datetime value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET datetimeField = :testValue", { testValue: { value: testValues.datetime, sqltype: "timestamp" } } )
				var result = QueryExecute( "SELECT datetimeField FROM `datatypes`" )
				expect( result.datetimeField ).toBe( testValues.datetime )
				expect( getClassName( result.datetimeField ) ).toBe( "lucee.runtime.type.dt.DateTimeImpl" )
			})

			it( "can add and retrieve an int value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET intField = :testValue", { testValue: { value: testValues.int, sqltype: "integer" } } )
				var result = QueryExecute( "SELECT intField FROM `datatypes`" )
				expect( result.intField ).toBe( testValues.int )
				expect( getClassName( result.intField ) ).toBe( "java.lang.Integer" )
			})

			it( "can add and retrieve a text value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET textField = :testValue", { testValue: { value: testValues.text } } )
				var result = QueryExecute( "SELECT textField FROM `datatypes`" )
				expect( result.textField ).toBe( testValues.text )
				expect( getClassName( result.textField ) ).toBe( "java.lang.String" )
			})

			it( "can add and retrieve a tinyint value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET tinyintField = :testValue", { testValue: { value: testValues.tinyint, sqltype: "tinyint" } } )
				var result = QueryExecute( "SELECT tinyintField FROM `datatypes`" )
				expect( result.tinyintField ).toBe( testValues.tinyint )
				expect( getClassName( result.tinyintField ) ).toBe( "java.lang.Double" )
			})

			it( "can add and retrieve a varchar value correctly", ()=> {
				QueryExecute( "UPDATE `datatypes` SET varcharField = :testValue", { testValue: { value: testValues.varchar } } )
				var result = QueryExecute( "SELECT varcharField FROM `datatypes`" )
				expect( result.varcharField ).toBe( testValues.varchar )
				expect( getClassName( result.varcharField ) ).toBe( "java.lang.String" )
			})

			it( "can add and retrieve a clob value correctly", ()=> {
				QueryExecute(" CREATE TABLE `testnotes` (
					`id` INT(11) NOT NULL AUTO_INCREMENT,
					`notes` MEDIUMTEXT NOT NULL COLLATE utf16_bin,
					PRIMARY KEY (`id`) USING BTREE
				 ) COLLATE=latin1_swedish_ci ENGINE=InnoDB
				");

				local.notes = ExtensionList().toJson();

				QueryExecute(
					sql="INSERT INTO `testnotes` ( notes ) VALUES ( :notes )",
					params={
						notes: { value: notes, type: "clob" }
					}
				);

				local.qry = QueryExecute("SELECT notes from `testnotes`");

				expect( qry.notes ).toBe( notes );
			})

		})

	}

}
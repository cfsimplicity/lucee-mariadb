component extends="testbox.system.BaseSpec"{

	private function getClassName( required object object ){
		return GetMetaData( arguments.object ).getCanonicalName()
	}

	function beforeAll(){
		include "sql/setup.cfm"
	}

	function afterAll(){
		QueryExecute( "DROP TABLE IF EXISTS `datatypes`" )
	}

	function run( testResults, testBox ){

		describe( "the MariaDB JDBC driver", ()=> {

			beforeEach( ()=> {
				variables.testValues = {
					bit: 0
					,date: CreateDate( 2022, 7, 4 )
					,datetime: CreateDateTime( 2022, 7, 4, 15, 20, 30 )
					,text: RepeatString( "a ", 30000 )
					,tinyint: 1
					,varchar: "testing"
				}
			})

			it( "can insert values correctly", ()=> {
				var params = {
					bitValue: { value: testValues.bit, sqltype: "bit" }
					,dateValue: { value: testValues.date, sqltype: "date" }
					,datetimeValue: { value: testValues.datetime, sqltype: "timestamp" }
					,textValue: { value: testValues.text }
					,tinyintValue: { value: testValues.tinyint, sqltype: "tinyint" }
					,varcharValue: { value: testValues.varchar }
				}
				var sql = "
					INSERT INTO `datatypes`
					SET bitField = :bitvalue
							,dateField = :dateValue
							,datetimeField = :datetimeValue
							,textField = :textValue
							,tinyintField = :tinyintValue
							,varcharField = :varcharValue
				"
				QueryExecute( sql, params, { result: "insertResult" } )
				expect( insertResult.generatedKey ).toBe( 1 )
			})

			it( "can select values correctly", ()=> {
				var result = QueryExecute( "SELECT * FROM datatypes", {}, { returntype: "array"} )
				var result = result.first()
				expect( result.bitField ).toBe( testValues.bit )
				expect( getClassName( result.bitField ) ).toBe( "java.lang.Boolean" )
				expect( result.dateField ).toBe( testValues.date )
				expect( getClassName( result.dateField ) ).toBe( "lucee.runtime.type.dt.DateTimeImpl" )
				expect( result.datetimeField ).toBe( testValues.datetime )
				expect( getClassName( result.datetimeField ) ).toBe( "lucee.runtime.type.dt.DateTimeImpl" )
				expect( result.textField ).toBe( testValues.text )
				expect( getClassName( result.textField ) ).toBe( "java.lang.String" )
				expect( result.tinyintField ).toBe( testValues.tinyint )
				expect( getClassName( result.tinyintField ) ).toBe( "java.lang.Double" )
				expect( result.varcharField ).toBe( testValues.varchar )
				expect( getClassName( result.varcharField ) ).toBe( "java.lang.String" )
			})
			
		})

	}

}
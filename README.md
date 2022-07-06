# Lucee MariaDB Extension

This extension installs the MariaDB Connector/J Type 4 JDBC driver for creating MariaDB data sources in [Lucee Server](https://lucee.org/). It is an alternative to the generic MySQL driver.

## Installation

### via Forgebox

1. In your Lucee Administrator, go to the _Extension > Providers_ page and add `https://forgebox.io` as a New Extension Provider if not already present
2. Go to _Extension > Applications_ and look for _MariaDB_ in the "Not installed" section
3. Click the extension and install

### Manual

1. Download the the lucee-mariadb.lex file
2. In your Lucee Administrator, go to the Extension > Applications page
3. Under "Upload new extension", select the lex file and click "Upload" 

## Usage

Once installed you can either create datasources in the Lucee Administrator using the newly added "MariaDB" type, or you can define them in your Application.cfc as follows:

```
this.datasource = {
	class: "org.mariadb.jdbc.Driver"
	,connectionString: "jdbc:mariadb://[hostname]:[port]/[database]?<parameter>=<value>"
	,username: [username]
	,password: [password]
	//other options if required
};
```
[More details on defining Lucee datasources](https://docs.lucee.org/guides/cookbooks/datasource-define-datasource.html)

[Full driver documentation](https://mariadb.com/kb/en/about-mariadb-connector-j/)

## Migration from the MySQL driver

Note that when inserting records into tables with an auto-increment primary key, the MySQL driver returns the new primary key value in two variables in the query result:
```
GENERATED_KEY
generatedKey
```
However the MariaDB driver returns the value in the following variables:
```
generatedKey
insert_id
```
Before switching drivers, you should therefore check that your code is using `generatedKey` and **not** `GENERATED_KEY`.

## Credits

Inspiration came from [Bruce Kirkpatrick](https://github.com/jetendo).
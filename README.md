# Lucee MariaDB Extension

This extension installs the MariaDB Connector/J Type 4 JDBC driver for creating MariaDB data sources in [Lucee Server](http://lucee.org/). It is an alternative to the generic MySQL driver.

## Installation

1. Download the the lucee-mariadb.lex file
2. In your Lucee Administrator, go to the Extension > Applications page
3. Under "Upload new extension", select the lex file and click "Upload" 

## Usage

Once installed you can either create datasources in the Lucee Administrator using the newly added "MariaDB" type, or you can define them in your Application.cfc as follows:

```
this.datasource = {
	class: "org.mariadb.jdbc.Driver"
	,connectionString: "jdbc:mariadb://[hostname]:[port]/[database]?useUnicode=true&characterEncoding=UTF-8"// and any other required parameters
	,username: [username]
	,password: [password]
	//other options if required
};
```
[More details on defining Lucee datasources](https://docs.lucee.org/guides/cookbooks/datasource-define-datasource.html)

## Credits

Inspiration came from [Bruce Kirkpatrick](https://github.com/jetendo).
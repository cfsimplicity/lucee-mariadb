# Upgrading the driver

1. Download the new jar from https://mariadb.com/downloads/#connectors selecting the Java 8 stable connector
2. Add the jar to the `/extension/jars` folder and remove the previous version

(Version 3.0.3 has no OSGi properties in the manifest. These need to be added as follows:)

3. Use 7-zip to open the new jar and edit the /META-INF/MANIFEST.MF adding:

Bundle-ManifestVersion: 2
Bundle-Name: mariadb-java-client
Bundle-SymbolicName: org.mariadb.jdbc
Bundle-Version: 3.0.3
Export-Package: org.mariadb.jdbc

4. Update `/extension/META-INF/MANIFEST.MF` with new version number and date.
5. Update `box.json` with new version number.
6. Open CommandBox in the this `build` directory and execute:
```
task run
```
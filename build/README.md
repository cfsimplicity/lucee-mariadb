# Upgrading the driver

From version 2.5.x of the driver there has been [an OSGi issue with the jar file manifest](https://github.com/cfsimplicity/lucee-mariadb/issues/1) which prevents it from being installed as a Lucee extension.

The following steps for upgrading include a fix:

1. Download the new jar from https://mariadb.com/downloads/#connectors selecting the Java 8 stable connector
2. Add the jar to the `/extension/jars` folder and remove the previous version
3. Use 7-zip to open the new jar and edit the /META-INF/MANIFEST.MF to remove:
```
Bundle-Activator: org.mariadb.jdbc.internal.osgi.MariaDbActivator
```
and
```
org.osgi.service.jdbc,
```
from the beginning of the `Import-Package` section.

4. Update `/extension/META-INF/MANIFEST.MF` with new version number and date.
5. Update `box.json` with new version number.
6. Open CommandBox in the this `build` directory and execute:
```
task run
```
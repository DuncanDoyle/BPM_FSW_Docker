package com.redhat.demo.HeiseDemo.dashboard;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import org.jboss.dashboard.annotation.Priority;
import org.jboss.dashboard.annotation.Startable;
import org.jboss.dashboard.annotation.config.Config;
import org.jboss.dashboard.database.DataSourceManager;
import org.jboss.dashboard.database.JNDIDataSourceEntry;
import org.jboss.dashboard.factory.InitialModuleRegistry;
import org.jboss.dashboard.kpi.KPIInitialModule;
import org.jboss.dashboard.workspace.export.ImportWorkspacesModule;

@ApplicationScoped
public class DashboardBuilder implements Startable {
    
    @Inject
    private InitialModuleRegistry initialModuleRegistry;
    
    @Inject @Config("WEB-INF/etc/appdata/initialData/heiseDemoKPIs.xml")
    private String kpiFile;
    
    @Inject @Config("WEB-INF/etc/appdata/initialData/heiseDemoWorkspace.xml")
    private String workspaceFile;
    
    @Inject
    DataSourceManager dataSourceManager;

    @Override
    public Priority getPriority() {
        return Priority.NORMAL;
    }

    @Override
    public void start() throws Exception {

    	System.out.println("-------------------------------------");
    	System.out.println("- Entering Dashboard Builder Import V0.1 -");

        if (dataSourceManager.getDataSourceEntry("PostgresDS") == null) {

	    	System.out.println(" - PostgresDS does not exist ");

            JNDIDataSourceEntry entry = new JNDIDataSourceEntry();
            entry.setName("Neugeschaeft Hausrat");
            entry.setTestQuery("SELECT * FROM \"bam.hausrat_neugeschaeft\" order by Datum desc;");
            entry.setJndiPath("java:jboss/datasources/BamDS");
            entry.save();

	    	System.out.println(" - PostgresDS created!");           

        } else {
			System.out.println(" - PostgresDS already defined ");        	
		}         


        
        KPIInitialModule kpis = new KPIInitialModule();
        kpis.setName("com.demo.heiseDemo.dashboard.heiseDemoKPIs");
        kpis.setImportFile(kpiFile);
        kpis.setVersion(1);
        initialModuleRegistry.registerInitialModule(kpis);

        System.out.println(" - heiseDemoKPI injected ");


        
        ImportWorkspacesModule workspace = new ImportWorkspacesModule();
        workspace.setName("com.demo.heiseDemo.dashboard.heiseDemoWorkspace");
        workspace.setImportFile(workspaceFile);
        workspace.setVersion(1);
        initialModuleRegistry.registerInitialModule(workspace);

        System.out.println(" - Workspace injected ");

    	System.out.println("-------------------------------------");

    }

}

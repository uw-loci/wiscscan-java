/*
 * Java code for use with WiscScan
 * 
 * Extracts only the OME XML header and UUID for 
 * partial metadata block in OME XML metadata
 * population in images.
 * 
 * @author Curtis Reuden
 * @author Ajeet Vivekanandan
 * @author David Mayer 
 */

package loci.wiscscan;

import loci.common.services.ServiceFactory;
import loci.formats.ome.OMEXMLMetadata;
import loci.formats.services.OMEXMLService;

public class OMEXMLhelper {

	public String getBinaryOnlyXML(final String metadataFile, final String uuid) {
		try {
			final ServiceFactory sf = new ServiceFactory();
			final OMEXMLService omexmlService =sf.getInstance(OMEXMLService.class);
			final OMEXMLMetadata omeMeta = omexmlService.createOMEXMLMetadata();
			omeMeta.setBinaryOnlyMetadataFile(metadataFile);
			omeMeta.setBinaryOnlyUUID(uuid);
			return omexmlService.getOMEXML(omeMeta);
		}
		catch (Exception exc) {
			//exception will be handled by caller
			return null;
		}
	}
}

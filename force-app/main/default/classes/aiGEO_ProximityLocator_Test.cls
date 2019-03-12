/**
 * Name    : aiGEO_ProximityLocator_Test<br/>
 * Usage   : Test class provides methods to test aiGEO_ProximityLocator_Test
 *			 
 * <br/>
 * Created By	   : Igor Androsov<br/>
 * Modified By     : <br/>
 * Created Date    : April 06, 2016<br/>
 */
@isTest
private class aiGEO_ProximityLocator_Test {
static testMethod void proximityLocatorUnitTest() {
		// Test distance from CA to FL
    	Double lat1 = 37.386339;
    	Double lat2 = 27.8132980;
    	Double lon1 = -122.085823;
    	Double lon2 = -82.6067290;

		Double db = aiGEO_ProximityLocator.calculateDistance(lat1, lon1, lat2, lon2);
		System.assertEquals(2372.542345886539,db);
	
		Double sr1 = aiGEO_ProximityLocator.getSearchRadius();
	    System.assertEquals(20.00, sr1); // Test search in Miles
	
		Double er1 = aiGEO_ProximityLocator.getEarthRadius();
        System.assertEquals(3959.00,er1); // Test radius in miles
    }
}

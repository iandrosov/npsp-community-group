/**
 * Name    : aiGEO_ProximityLocator<br/>
 * Usage   : Utility class provides methods to find a distance based on
 *			 longetude and latetude to find shortest distances to destinations.
 * 		     This class impliments a Haversine formula in APEX that assumes a 
 *           spherical earth for distance clculation. Mountain terains are not
 *           accounted for.
 *			 This class uses kilometers as default measurement of distance.
 * <br/>
 * Created By	   : Igor Androsov<br/>
 * Modified By     : <br/>
 * Created Date    : April 06, 2016<br/>
 */
public without sharing class aiGEO_ProximityLocator {
	private static Double DEFAULT_SEARCH_RADIUS = 20.00; // Default radius 20KM
	private static Double EARTH_RADIUS = 3959.00; // Radius in miles default, for Kilometers use 6371.00 
	private static Double EARTH_RADIUS_MILES = 3959.00;
	private static Double EARTH_RADIUS_KILOMETERS = 6371.00;
	/**
	 * Method calculates a shortest distance for  2 location in latedute adn longetude
	 * This method impliments a Haversine formula in APEX that assumes a spherical earth.
	 * Earths radius used 6371 km (≈3,959 mi)
	 * <br/>
	 * Input Parameters:<br/>
	 * @lat1 - type Double defines latedude of starting location<br/>
	 * @lon1 - type Double defines longetude of starting location<br/>
	 * @lat2 - type Double defines latedude of target location<br/>
	 * @lon2 - type Double defines longetude of target location<br/>
	 */
	public static Double calculateDistance(Double lat1, Double lon1, Double lat2, Double lon2){
			Double Radius = aiGEO_ProximityLocator.getEarthRadius(); //3959.00 miles
			Double dLat = aiGEO_ProximityLocator.toRadians(lat2-lat1);
            Double dLon = aiGEO_ProximityLocator.toRadians(lon2-lon1);            
            Double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(aiGEO_ProximityLocator.toRadians(lat1)) * Math.cos(aiGEO_ProximityLocator.toRadians(lat2)) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
            Double c = 2 * Math.asin(Math.sqrt(a));
            return Radius * c;		
	}
	
	/**
	 * Convert degrees to radians, returns number radians in Double
	 * type.
	 * <br/>
	 * Input Parameters:<br/>
	 * @param degree type Double number to be converted<br/>
	 */	
	public static Double toRadians(Double degree){
		// Value degree * Pi/180
		Double res = degree * 3.1415926 / 180;
		return res;	
	}
	/**
	 * Lookup SF custom settings aiGEO_Proximity_Settings to get a unit
	 * KM/ML kilometers/US Miles respective and return default value
	 * in that unit for Earthe radius. returns type Double
	 * 3959.00 - miles, for Kilometers use 6371.00, US mile is default.
	 * <br/>
	 * Input Parameters:
	 *
	 */
	public static Double getEarthRadius(){
		Double rad = aiGEO_ProximityLocator.EARTH_RADIUS_MILES;
		/** OPTION to use settings
		aiGEO_Proximity_Settings__c prop = aiGEO_Proximity_Settings__c.getOrgDefaults();
		if (prop != null && prop.Distance_Unit__c != null && prop.Distance_Unit__c == 'KM') {
			rad = aiGEO_ProximityLocator.EARTH_RADIUS_KILOMETERS;
		}	
		**/	
		return rad;
	}
	/**
	 * Lookup SF custom settings aiGEO_Proximity_Settings to get search
	 * radius definne by user in units of distance kilometers/US Miles 
	 * Returns type Double for search radius in 
	 * miles, or kilometers. US mile is default.
	 * <br/>
	 * Input Parameters:
	 *
	 */
	public static Double getSearchRadius(){
		Double rad = aiGEO_ProximityLocator.DEFAULT_SEARCH_RADIUS;
		/** OPTION to use settings
		aiGEO_Proximity_Settings__c prop = aiGEO_Proximity_Settings__c.getOrgDefaults();
		if (prop != null && prop.Search_Radius__c != null) {
			rad = prop.Search_Radius__c;
		}		
		**/
		return rad;
	}	
	   
}

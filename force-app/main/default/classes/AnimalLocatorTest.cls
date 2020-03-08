@isTest
public class AnimalLocatorTest {
    @isTest static void AnimalLocatorMock() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
    String response = AnimalLocator.getAnimalNameById(1);
        system.debug(response);
    // Verify that the response received contains fake values
    String expectedValue = 'chicken';
    System.assertEquals(response, expectedValue);
}

}
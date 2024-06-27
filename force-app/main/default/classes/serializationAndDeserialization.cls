public class serializationAndDeserialization {

    public class Contact {
            public String firstName;
            public String lastName;
            public Integer age;
            
            public Contact(String firstName, String lastName, Integer age) {
                this.firstName = firstName;
                this.lastName = lastName;
                this.age = age;
            }
        }
    
    public static void Serialization()
    {
   
        // Create an instance of the Contact class
        Contact myContact = new Contact('John', 'Doe', 30);
        
        // Serialize the Contact object into a JSON string
        String serializedContact = JSON.serialize(myContact);
        
        // Output the serialized JSON string
        System.debug('serializedContact ::'+serializedContact);
    }
    
    public static void Deserialization()
    {
        // JSON string to deserialize
        String jsonContact = '{"firstName":"Jane","lastName":"Smith","age":25}';
        
        // Deserialize the JSON string into a Contact object
        Contact deserializedContact = (Contact) JSON.deserialize(jsonContact, Contact.class);
        
        // Access the properties of the deserialized Contact object
        System.debug('First Name: ' + deserializedContact.firstName);
        System.debug('Last Name: ' + deserializedContact.lastName);
        System.debug('Age: ' + deserializedContact.age);
    }
}
package PetInventory;
import com.intuit.karate.junit5.Karate;

class PetInventoryRunner {

    @Karate.Test
    Karate testPetStore() {
        return Karate.run("classpath:PetInventory/AccessPetStoreOrders.feature")
                .tags("~@ignore")
                .reportDir("target/karate-reports/PetInventory");
    }
}

//mvn test -Dtest=PetInventoryRunner -Dkarate.options="--tags @dbugtag"
package PetStore;
import com.intuit.karate.junit5.Karate;

class PetStoreRunner {

    @Karate.Test
    Karate testPetStore() {
        return Karate.run("classpath:PetStore/PetDetails.feature")
                .tags("~@ignore")
                .reportDir("target/karate-reports/PetDetails");
    }
}


package examples.users;

import com.intuit.karate.junit5.Karate;

class usersTestRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:examples/users/users.feature");
    }
}

package com.example.dummycrudapp

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.TestPropertySource

@SpringBootTest
@TestPropertySource(
    properties = [
        "spring.datasource.url=jdbc:h2:mem:testdb",
        "spring.datasource.driver-class-name=org.h2.Driver",
        "spring.jpa.database-platform=org.hibernate.dialect.H2Dialect",
        "spring.jpa.hibernate.ddl-auto=create-drop",
        "spring.jpa.properties.hibernate.globally_quoted_identifiers=true",
    ],
)
class DummyCrudAppApplicationTests {

    @Test
    fun contextLoads() {
        // This test ensures the Spring context loads successfully
        // Tests run with H2 in-memory database instead of MySQL
    }
}

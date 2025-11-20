package com.example.dummycrudapp

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DummyCrudAppApplication

fun main(args: Array<String>) {
    runApplication<DummyCrudAppApplication>(*args)
}

package com.example.dummycrudapp.controller

import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class VersionController {

    @Value("\${app.version:unknown}")
    private lateinit var appVersion: String

    @GetMapping("/api/version")
    fun getVersion(): Map<String, String> {
        return mapOf(
            "version" to appVersion,
            "application" to "Book CRUD API"
        )
    }
}

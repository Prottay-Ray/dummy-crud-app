package com.example.dummycrudapp.exception

data class ValidationException(override val message: String) : RuntimeException(message)
data class ResourceNotFoundException(override val message: String) : RuntimeException(message)

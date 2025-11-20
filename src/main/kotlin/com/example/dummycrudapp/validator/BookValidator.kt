package com.example.dummycrudapp.validator

import com.example.dummycrudapp.exception.ValidationException
import com.example.dummycrudapp.model.Book
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.time.Year

@Component
class BookValidator {

    private val logger = LoggerFactory.getLogger(BookValidator::class.java)

    fun validateId(id: Long) {
        if (id <= 0) {
            logger.debug("Invalid ID validation failed: {}", id)
            throw ValidationException("Invalid book ID. ID must be a positive number")
        }
    }

    fun validateBook(book: Book) {
        logger.debug("Validating book: {}", book.title)
        
        if (book.title.isBlank()) {
            throw ValidationException("Book title cannot be blank")
        }
        
        if (book.author.isBlank()) {
            throw ValidationException("Book author cannot be blank")
        }
        
        if (book.isbn.isBlank()) {
            throw ValidationException("Book ISBN cannot be blank")
        }
        
        validatePublishedYear(book.publishedYear)
        
        logger.debug("Book validation passed")
    }

    fun validateSearchParameter(paramName: String, paramValue: String) {
        if (paramValue.isBlank()) {
            logger.debug("Invalid search parameter: {} is blank", paramName)
            throw ValidationException("$paramName search parameter cannot be blank")
        }
    }

    private fun validatePublishedYear(year: Int) {
        val currentYear = Year.now().value
        if (year <= 0) {
            throw ValidationException("Published year must be a positive number")
        }
        if (year > currentYear) {
            throw ValidationException("Published year cannot be in the future")
        }
    }
}

package com.example.dummycrudapp.service

import com.example.dummycrudapp.exception.ResourceNotFoundException
import com.example.dummycrudapp.model.Book
import com.example.dummycrudapp.repository.BookRepository
import com.example.dummycrudapp.validator.BookValidator
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class BookService(
    private val bookRepository: BookRepository,
    private val bookValidator: BookValidator,
) {

    companion object {
        private val logger = LoggerFactory.getLogger(BookService::class.java)
    }

    fun getAllBooks(): List<Book> {
        logger.debug("Fetching all books from database")
        val books = bookRepository.findAll()
        logger.debug("Retrieved {} books from database", books.size)
        return books
    }

    fun getBookById(id: Long): Book {
        logger.debug("Fetching book with id: {}", id)
        bookValidator.validateId(id)

        val book = bookRepository.findById(id).orElse(null)
        if (book == null) {
            logger.debug("Book not found with id: {}", id)
            throw ResourceNotFoundException("Book not found with id: $id")
        }

        logger.debug("Book found with id: {}", id)
        return book
    }

    fun createBook(book: Book): Book {
        logger.debug("Creating new book: {}", book.title)
        bookValidator.validateBook(book)

        val savedBook = bookRepository.save(book)
        logger.info("Book created successfully with id: {}", savedBook.id)
        return savedBook
    }

    fun updateBook(id: Long, bookDetails: Book): Book {
        logger.debug("Updating book with id: {}", id)
        bookValidator.validateId(id)
        bookValidator.validateBook(bookDetails)

        val book = bookRepository.findById(id).orElse(null)
        if (book == null) {
            logger.debug("Book not found for update with id: {}", id)
            throw ResourceNotFoundException("Book not found with id: $id")
        }

        book.title = bookDetails.title
        book.author = bookDetails.author
        book.isbn = bookDetails.isbn
        book.publishedYear = bookDetails.publishedYear
        book.description = bookDetails.description
        book.updatedAt = LocalDateTime.now()

        val updatedBook = bookRepository.save(book)
        logger.info("Book updated successfully with id: {}", id)
        return updatedBook
    }

    fun deleteBook(id: Long) {
        logger.debug("Attempting to delete book with id: {}", id)
        bookValidator.validateId(id)

        if (!bookRepository.existsById(id)) {
            logger.debug("Book not found for deletion with id: {}", id)
            throw ResourceNotFoundException("Book not found with id: $id")
        }

        bookRepository.deleteById(id)
        logger.info("Book deleted successfully with id: {}", id)
    }

    fun searchByTitle(title: String): List<Book> {
        logger.debug("Searching books by title: {}", title)
        bookValidator.validateSearchParameter("Title", title)

        val books = bookRepository.findByTitleContainingIgnoreCase(title)
        logger.debug("Found {} books matching title: {}", books.size, title)
        return books
    }

    fun searchByAuthor(author: String): List<Book> {
        logger.debug("Searching books by author: {}", author)
        bookValidator.validateSearchParameter("Author", author)

        val books = bookRepository.findByAuthorContainingIgnoreCase(author)
        logger.debug("Found {} books matching author: {}", books.size, author)
        return books
    }

    fun findByIsbn(isbn: String): Book {
        logger.debug("Finding book by ISBN: {}", isbn)
        bookValidator.validateSearchParameter("ISBN", isbn)

        val book = bookRepository.findByIsbn(isbn)
        if (book == null) {
            logger.debug("Book not found with ISBN: {}", isbn)
            throw ResourceNotFoundException("Book not found with ISBN: $isbn")
        }

        logger.debug("Book found with ISBN: {}", isbn)
        return book
    }
}

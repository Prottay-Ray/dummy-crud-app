package com.example.dummycrudapp.controller

import com.example.dummycrudapp.model.Book
import com.example.dummycrudapp.service.BookService
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/books")
class BookController(private val bookService: BookService) {

    private val logger = LoggerFactory.getLogger(BookController::class.java)

    @GetMapping
    fun getAllBooks(): ResponseEntity<List<Book>> {
        logger.info("GET request to fetch all books")
        val books = bookService.getAllBooks()
        logger.info("Successfully retrieved {} books", books.size)
        return ResponseEntity.ok(books)
    }

    @GetMapping("/{id}")
    fun getBookById(@PathVariable id: Long): ResponseEntity<Book> {
        logger.info("GET request to fetch book with id: {}", id)
        val book = bookService.getBookById(id)
        logger.info("Successfully retrieved book with id: {}", id)
        return ResponseEntity.ok(book)
    }

    @PostMapping
    fun createBook(@RequestBody book: Book): ResponseEntity<Book> {
        logger.info("POST request to create a new book: {}", book.title)
        val createdBook = bookService.createBook(book)
        logger.info("Successfully created book with id: {}", createdBook.id)
        return ResponseEntity.status(HttpStatus.CREATED).body(createdBook)
    }

    @PutMapping("/{id}")
    fun updateBook(@PathVariable id: Long, @RequestBody bookDetails: Book): ResponseEntity<Book> {
        logger.info("PUT request to update book with id: {}", id)
        val updatedBook = bookService.updateBook(id, bookDetails)
        logger.info("Successfully updated book with id: {}", id)
        return ResponseEntity.ok(updatedBook)
    }

    @DeleteMapping("/{id}")
    fun deleteBook(@PathVariable id: Long): ResponseEntity<Void> {
        logger.info("DELETE request to delete book with id: {}", id)
        bookService.deleteBook(id)
        logger.info("Successfully deleted book with id: {}", id)
        return ResponseEntity.noContent().build()
    }

    @GetMapping("/search/title")
    fun searchByTitle(@RequestParam title: String): ResponseEntity<List<Book>> {
        logger.info("GET request to search books by title: {}", title)
        val books = bookService.searchByTitle(title)
        logger.info("Found {} books matching title: {}", books.size, title)
        return ResponseEntity.ok(books)
    }

    @GetMapping("/search/author")
    fun searchByAuthor(@RequestParam author: String): ResponseEntity<List<Book>> {
        logger.info("GET request to search books by author: {}", author)
        val books = bookService.searchByAuthor(author)
        logger.info("Found {} books matching author: {}", books.size, author)
        return ResponseEntity.ok(books)
    }

    @GetMapping("/search/isbn")
    fun findByIsbn(@RequestParam isbn: String): ResponseEntity<Book> {
        logger.info("GET request to find book by ISBN: {}", isbn)
        val book = bookService.findByIsbn(isbn)
        logger.info("Found book with ISBN: {}", isbn)
        return ResponseEntity.ok(book)
    }
}

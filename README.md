# Book CRUD Application

A RESTful CRUD application for managing books, built with Kotlin, Spring Boot, Gradle, and MySQL.

## Technologies Used

- **Kotlin** - Primary programming language
- **Spring Boot 3.2.0** - Application framework
- **Gradle** - Build tool
- **MySQL 8.0** - Database
- **Docker** - Containerization
- **JPA/Hibernate** - ORM

## Prerequisites

- Docker and Docker Compose installed
- Java 17 (if running locally without Docker)
- Gradle (if running locally without Docker)

## Project Structure

```
dummy-crud-app/
├── src/
│   └── main/
│       ├── kotlin/
│       │   └── com/example/dummycrudapp/
│       │       ├── controller/
│       │       │   └── BookController.kt
│       │       ├── model/
│       │       │   └── Book.kt
│       │       ├── repository/
│       │       │   └── BookRepository.kt
│       │       ├── service/
│       │       │   └── BookService.kt
│       │       └── DummyCrudAppApplication.kt
│       └── resources/
│           └── application.properties
├── Dockerfile
├── docker-compose.yml
└── build.gradle.kts
```

## Running the Application

### Using Docker Compose (Recommended)

1. Build and start the containers:
```bash
docker-compose up --build
```

2. The application will be available at `http://localhost:8080`

3. To stop the application:
```bash
docker-compose down
```

### Running Locally

1. Start MySQL database:
```bash
docker run -d -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=bookdb \
  mysql:8.0
```

2. Build and run the application:
```bash
./gradlew bootRun
```

## API Endpoints

### Books API

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/books` | Get all books |
| GET | `/api/books/{id}` | Get book by ID |
| POST | `/api/books` | Create a new book |
| PUT | `/api/books/{id}` | Update a book |
| DELETE | `/api/books/{id}` | Delete a book |
| GET | `/api/books/search/title?title={title}` | Search books by title |
| GET | `/api/books/search/author?author={author}` | Search books by author |
| GET | `/api/books/search/isbn?isbn={isbn}` | Find book by ISBN |

## Sample API Requests

### Create a Book

```bash
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "publishedYear": 2008,
    "description": "A Handbook of Agile Software Craftsmanship"
  }'
```

### Get All Books

```bash
curl http://localhost:8080/api/books
```

### Get Book by ID

```bash
curl http://localhost:8080/api/books/1
```

### Update a Book

```bash
curl -X PUT http://localhost:8080/api/books/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code - Updated",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "publishedYear": 2008,
    "description": "A Handbook of Agile Software Craftsmanship - Updated Edition"
  }'
```

### Delete a Book

```bash
curl -X DELETE http://localhost:8080/api/books/1
```

### Search by Title

```bash
curl "http://localhost:8080/api/books/search/title?title=Clean"
```

### Search by Author

```bash
curl "http://localhost:8080/api/books/search/author?author=Martin"
```

## Book Model

```json
{
  "id": 1,
  "title": "Clean Code",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "publishedYear": 2008,
  "description": "A Handbook of Agile Software Craftsmanship",
  "createdAt": "2025-11-20T10:30:00",
  "updatedAt": "2025-11-20T10:30:00"
}
```

## Database Configuration

The application uses the following default configuration:

- **Database**: bookdb
- **Host**: localhost (or mysql in Docker)
- **Port**: 3306
- **Username**: root
- **Password**: rootpassword

You can override these by setting environment variables:
- `DB_HOST`
- `DB_PORT`
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`

## Docker Images

The Dockerfile uses a multi-stage build:
1. **Build stage**: Uses Gradle with JDK 17 to build the application
2. **Runtime stage**: Uses a lightweight JRE 17 Alpine image to run the application

## License

This is a dummy project for demonstration purposes.

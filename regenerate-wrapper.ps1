# Script to regenerate Gradle wrapper with all required files
# This should be run once and the wrapper files committed to git

Write-Host "Regenerating Gradle wrapper..." -ForegroundColor Cyan

# Generate wrapper with Gradle 8.5
gradle wrapper --gradle-version 8.5 --distribution-type bin

Write-Host ""
Write-Host "✓ Gradle wrapper generated successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Please commit these files:" -ForegroundColor Yellow
Write-Host "  - gradle/wrapper/gradle-wrapper.jar"
Write-Host "  - gradle/wrapper/gradle-wrapper.properties"
Write-Host "  - gradlew"
Write-Host "  - gradlew.bat"
Write-Host ""
Write-Host "Run these commands:" -ForegroundColor Cyan
Write-Host "  git add gradle/wrapper/gradle-wrapper.jar gradle/wrapper/gradle-wrapper.properties gradlew gradlew.bat"
Write-Host "  git commit -m 'Add Gradle wrapper jar file'"
Write-Host "  git push"

#!/usr/bin/env bash

# Script to regenerate Gradle wrapper with all required files
# This should be run once and the wrapper files committed to git

echo "Regenerating Gradle wrapper..."

# Remove existing wrapper if needed
# rm -rf gradle/wrapper/gradle-wrapper.jar

# Generate wrapper with Gradle 8.5
gradle wrapper --gradle-version 8.5 --distribution-type bin

# Make gradlew executable
chmod +x gradlew
chmod +x gradlew.bat

echo ""
echo "✓ Gradle wrapper generated successfully!"
echo ""
echo "Please commit these files:"
echo "  - gradle/wrapper/gradle-wrapper.jar"
echo "  - gradle/wrapper/gradle-wrapper.properties"
echo "  - gradlew"
echo "  - gradlew.bat"
echo ""
echo "Run this command:"
echo "  git add gradle/wrapper/gradle-wrapper.jar gradle/wrapper/gradle-wrapper.properties gradlew gradlew.bat"
echo "  git commit -m 'Add Gradle wrapper jar file'"
echo "  git push"

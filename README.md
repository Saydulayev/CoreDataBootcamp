<p align="center">
  <img src="https://github.com/Saydulayev/CoreDataBootcamp/blob/main/CoreDataBootcamp/Screenshots/Screenshot1.png" width="300">
  <img src="https://github.com/Saydulayev/CoreDataBootcamp/blob/main/CoreDataBootcamp/Screenshots/Screenshot2.png" width="300">
  <img src="https://github.com/Saydulayev/CoreDataBootcamp/blob/main/CoreDataBootcamp/Screenshots/Screenshot3.png" width="300">
</p>


# SwiftUI Core Data Example

## Overview

This project demonstrates a simple SwiftUI application that utilizes Core Data for persistent data storage. The app showcases a basic CRUD (Create, Read, Update, Delete) operations flow with a list of fruits. Users can add new fruits, delete them, and mark them as checked. Additionally, there's functionality to edit fruit names using a long press gesture to trigger an edit view.

## Features

- **Core Data Integration**: Utilizes Core Data to manage a persistent store of fruits.
- **CRUD Operations**: Supports creating, reading, updating, and deleting fruit entries.
- **UI Interactions**: Includes adding new fruits, marking fruits as checked, and editing fruit names via a long press gesture.
- **SwiftUI Views**: Makes use of SwiftUI views for a modern, reactive UI.

## How It Works

The application is built around `ContentView`, which displays a list of fruits fetched from Core Data using a `@FetchRequest`. Users can add new fruits using a text field and a button. Each fruit can be marked as checked with a simple tap on a checkbox icon, and fruits can be edited by performing a long press on the fruit's name, which brings up an edit view.

### Adding Fruits

Users can add fruits by entering a name in the text field and tapping the "plus" icon. The app checks for uniqueness and ensures the name contains only letters.

### Editing Fruits

To edit a fruit, users can perform a long press on the fruit's name, which will present an edit view. The name can be updated, provided it remains unique and contains only letters.

### Marking Fruits as Checked

Fruits can be marked as checked or unchecked by tapping the checkbox icon. This status is saved in Core Data and persists across app launches.

### Deleting Fruits

Users can delete fruits by swiping left on a fruit entry and tapping the delete button.

## Persistence with Core Data

Core Data manages the app's persistent data storage, with `FruitEntity` representing the data model for a fruit. The app demonstrates how to integrate Core Data into a SwiftUI project, showcasing best practices for managing a persistent store.

---

Feel free to explore the code and use this project as a reference for integrating Core Data with SwiftUI in your own applications.

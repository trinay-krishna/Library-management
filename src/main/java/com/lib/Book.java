package com.lib;

public class Book {

    int id;
    String name;
    String genre;
    int available_quantity;

    public Book(int id, String name, String genre, int available_quantity) {
        this.id = id;
        this.name = name;
        this.genre = genre;
        this.available_quantity = available_quantity;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getGenre() {
        return genre;
    }

    public int getAvailableQuantity() {
        return available_quantity;
    }
}

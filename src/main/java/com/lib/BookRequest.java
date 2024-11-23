package com.lib;

public class BookRequest {

    private int id;
    private String name;
    private String genre;
    private int status;

    private int availableQuantity;

    BookRequest(int id, String name, String genre, int status) {
        this.id = id;
        this.name = name;
        this.genre = genre;
        this.status = status;

    }

    BookRequest(int id, String name, String genre, int status, int availableQuantity) {
        this.id = id;
        this.name = name;
        this.genre = genre;
        this.status = status;
        this.availableQuantity = availableQuantity;

    }

    public int getID() {
        return id;
    }

    public String getGenre() {
        return genre;
    }

    public String getName() {
        return name;
    }

    public int getStatus() {
        return status;
    }

    public int getAvailableQuantity() {
        return availableQuantity;
    }
}

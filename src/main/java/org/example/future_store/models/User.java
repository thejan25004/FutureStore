package org.example.future_store.models;

public class User {
    private int userId;
    private String username;
    private String email;
    private boolean isActive;

    public User(int userId, String username, String email, boolean isActive) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.isActive = isActive;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public boolean isActive() {
        return isActive;
    }
}

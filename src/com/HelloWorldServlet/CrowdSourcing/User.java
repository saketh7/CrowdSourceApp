package com.HelloWorldServlet.CrowdSourcing;

import java.io.Serializable;

public class User implements Serializable{
     
    private static final long serialVersionUID = 6297385302078200511L;
     
    private String name;
    private String email;
    private int id;
    private String address;
     
    public User(String nm, String em, String address, int i){
        this.name=nm;
        this.id=i;
        this.address=address;
        this.email=em;
    }
 
    public void setName(String name) {
        this.name = name;
    }
 
 
    public void setEmail(String email) {
        this.email = email;
    }
 
 
    public void setId(int id) {
        this.id = id;
    }
 
 
    public void setAddress(String address) {
        this.address = address;
    }
 
 
    public String getName() {
        return name;
    }
 
    public String getEmail() {
        return email;
    }
 
    public int getId() {
        return id;
    }
 
    public String getAddress() {
        return address;
    }
     
    @Override
    public String toString(){
        return "Name="+this.name+", Email="+this.email+", address="+this.address;
    }
}
package com.server.nanny.models;


import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Convert;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import javax.json.bind.annotation.JsonbVisibility;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;


import java.io.Serializable;
import java.util.Objects;

@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class User   implements Serializable {

    @Id
    private  int  id ;
    @Column( "sur-name")
    private  String surname ;
    @Column( "for-name")

    private  String forname ;
    @Column("email")
    private  String email ;


    @Column("password" )
    private String password ;


    @Column("role")
    private  Role  role ;


    /**
     *
     * All Getters
     */

    public   String getSurname(){
          return  surname ;
    }

    public   String getForname(){
        return  forname ;
    }

    public   String getEmail(){
        return  email ;
    }

    public   String getPassword(){
        return password ;
    }


    public   Role getRole(){
        return  role;
    }

    public int getId() {
        return id;
    }
    /**
     *
     * ALl Setters
     */

    public void setSurname(String surname){
        this.surname=surname ;
    }

    public void setForname(String forname){
        this.forname=forname ;
    }

    public   void setEmail(String email){
        this.email=email ;
    }
    public   void setPassword(String password){
        this.password=password ;
    }
    public   void setRole(Role role){
        this.role=role   ;
    }
    public void setId(int id) {
        this.id = id;
    }

    /**
     * All Args  constructor  and No Args  constructor
      */

    public  User(String surname , String forname  , String email , String password , Role role) {
         this.surname=surname ;
         this.forname=forname ;
         this.email=email;
         this.password=password ;
         this.role=role ;

    }

    public  User(){

    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        User user = (User) o;
        return forname.equals(user.forname) && surname.equals(user.surname) && email.equals(user.email) ;
    }
    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), forname, surname ,email );
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", surname='" + surname + '\'' +
                ", forname='" + forname + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                '}';
    }
}

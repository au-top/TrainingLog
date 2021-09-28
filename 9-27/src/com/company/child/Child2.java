package com.company.child;

import com.company.Main;

public class Child2 extends Main {
    void print(){
        System.out.println(this.p2);
        System.out.println(this.p3);
    }
}

class  Test2{
    Test2(){
        final Main a= new Main();
    }
}
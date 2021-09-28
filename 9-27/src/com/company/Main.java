package com.company;

import com.company.package1.Calculate;

interface Shape{
     double getArea();
     double getGirth();
}

abstract  class  a{

}



class  b extends  a{

}

interface  c{

}

class  d implements c {

}




class Rect implements Shape {
    double width;
    double height;
    Rect(double width,double height){
        this.width=width;
        this.height=height;
        final Main a= new Main();
    }
    @Override
    public double getArea() {
        return width*height;
    }

    @Override
    public double getGirth() {
        return (width+height)*2;
    }
}

class Child extends Main{
    void print(){
        System.out.println(this.p2);
        System.out.println(this.p3);
        System.out.println(this.p4);
    }
}

public class Main {
    private final String p1="这是私有的";
    protected  String p2="受保护的";
    public String p3 ="公开的";
    String p4="默认的";
    public static void main(String[] args) {
        Rect a=new Rect(10,20);
        System.out.println(a.getArea());
        System.out.println(a.getGirth());
        final Calculate calc=new Calculate();
        System.out.println( a instanceof Rect);
        System.out.println(calc.sun(1,2));
        System.out.println(calc.div(1,2));
        System.out.println(calc.mul(1,2));
        System.out.println(calc.sub(1,2));
    }
}

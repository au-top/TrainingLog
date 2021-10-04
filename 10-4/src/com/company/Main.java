package com.company;



class WorkA implements  Runnable {
    private Thread t;
    private final int p;

    WorkA(){
        p=5;
    }
    WorkA(int p ){
        this.p=p;
    }
    @Override
    public void run() {
        while (true) {
            synchronized(Main.w){
                System.out.println("HelloWorld "+Main.w.acc + t.getName());
            }
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
    }

    void start(){
        t=new Thread(this);
        t.setPriority(p);
        t.start();
        System.out.println(t);
    }
}
class WorkB implements Runnable{
    private Thread t;
    public  int acc=0;
    @Override
    public void run() {
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        synchronized (this){
            for (int i=0;i<10;i++){
                acc++;
                System.out.println("New Acc "+acc);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    void start(){
        t=new Thread(this);
        t.start();
    }
}

public class Main {
    static public final WorkB w=new WorkB();

    public static void main(String[] args) {
        WorkA a=new WorkA(1);;
        WorkA b=new WorkA(2);;
        WorkA c=new WorkA(3);;
        a.start();
        b.start();
        c.start();
        w.start();
        Thread d= new Thread(new Runnable(){
            @Override
            public void run() {
                System.out.println("HelloWorld ~");
            }
        });
        d.start();
        try {
            Thread.sleep(1000*15);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try{
            throw new Error("123");
        }catch (Error e){
            System.out.println(e.getMessage());
            throw e;
        }
    }
}

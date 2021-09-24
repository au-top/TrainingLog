// 1. D

// 2. C

// 3 C

void a1(){
  for(int i=0; i<=50; i++){
      if(i.isEven)print(i);
    }
}


void a2(){
  for(int i=0;i<=50;i++){
    if(i%2==0) print(i);
  }
}


void b1(){
  for(int i=1;i<=5;i++){
    int acc=1;
    for(int ii=1; ii<=i;ii++){
      acc*=ii;
    }
    print([i,acc]);
  }
}


void b2(){
  for(int i=1;i<=5;i++){
    int acc=1;
    for(int ii=i; ii>0;ii--){
      acc*=ii;
    }
    print([i,acc]);
  }
}

void c1(){
  var lists=[
    {"a":1},
    {"a":2},
    {"a":3},
  ];
  lists.forEach((element) {
    print(element["a"]);
  });
}


void d1(int a){
  for(int i=1;i<=a;i++){
    if(i.isEven)print(i);
  }
}



abstract class Db{
  late String uri;
  void add(String data);
  void remove();
}

class Mysql implements Db{
  @override
  late String uri;

  @override
  void add(String data) {
    print("you add ${data} -mysql");    
  }

  @override
  void remove() {
    print("you call remove -mysql");    
  }
  clear(){
    print("you call clear -mysql");
  }
}


class Mssql implements Db{
  @override
  late String uri;

  @override
  void add(String data) {
    print("you add ${data} -mssql");    
  }

  @override
  void remove() {
    print("you remove -mssql");    
  }
  
}



main(){
  final db0=Mysql();
  final db1=Mssql();
  callDb(db0);
  callDb(db1);

}


callDb(Db db){
  db.add("123");
  db.remove();
}
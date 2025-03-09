//defineing class in ES6
class person{
    // if u want to define fields, put constructor
    constructor(name,city){
        this.name=name;
        this.city=city;
    }
    display(){
        console.log('Name'+this.name);
        console.log('city is'+this.city);
    }
}
//create object of class
let p1=new person('raja','pune');
let p2=new person('ravi','mumbai');
console.log(p1);
console.log(p2);
p1.display();
p2.display();
//-----------------------------
class Employee extends person{
    constructor(name,city,deptid){
        super(name,city);
        this.deptid=deptid;
        //super.display();
    }
}
let e1 = new Employee('raja ram','pune',201);
console.log(e1);
//Note: we define constructor of a class using special keyword constructor()
//if u define constructor in derived class also, we must

//call back and promises---funtion pass to another function
// is function passed as an argument to another function --- it is used in asynchronous execution model
//synchrnous---linear--time consuming
function divide(n1,n2,cb){
    setTimeout(()=>{
    if(n2===0){
        //throw new Error("divide by zero");
        cb("Divide by zeor");
        
    }
    cb(null,n1/n2);
    //console.log('result',n1/n2);
    //return n1/n2;
},3000);
}
console.log('start of scritp');
let a=10,b=0;
divide(a,b,(err,result)=>{
    if(err){
        console.log('error',err);
    }else{
        console.log('result:',result);
    }
    
});
//let result=divide(a,b);
//console.log(result);
console.log("script end");
//------------------
function fetchData() {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const success = true; // Simulating success or failure
  
        if (success) {
          resolve(); // No value passed, resolves with undefined
        } else {
          reject('Failed to fetch data.');
        }
      }, );
    });
  }
  
  // Async function to handle the promise
  async function handleData() {
    try {
      const message = await fetchData();
      console.log(message); // Output: undefined
    } catch (error) {
      console.error(error); // If the promise was rejected
    }
  }
  
  // Calling the async function
  handleData();
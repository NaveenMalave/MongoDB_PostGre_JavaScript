let a ="hollo ";
console.log(a);
//number
//string
//boolean
//null
//undefined
let userName = "mohan";
let e = "hello " + userName + " hiii";
console.log(e);

console.log(`hii hello ${userName} alsdjflj`);
console.log(`asdf ${userName} asdlfjl`);
//arrow function
let sum1=(a,b)=>{
    return a+b
};
console.log('sum=',sum1(10,4));
//working with arrays
let num1 =[1,1,33,45];
let num2 = [...num1];
num2.push(77);
console.log(num1);
console.log(num2);
//spread operator with objects.
let p1={name: `ramnamth`,emil:`rama@434`};
let p2 = {...p1};
p2.name=`raman`;
console.log(p1);
console.log(p2);
//rest operators(3 dots)
function display(name1,name2,...names){
    console.log(name1,name2);
    console.log('hello',names);
}
display('Ramnath');
display('mohan','staya');
display('kiran','srikanth','navenn','veera');
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

  //--------------HIGHER ORDER FUNCTION-------------
  //A higher order function is a function that takes a function as an argument, or returns a function.
  //1.map(): this function execute call back function on each item on an array.
  //Items on an array. it returns a new array made up of return value from the callback function
  //[1,2,3,4]----map(cb)------>[1,4,9,16]

  let arr=[2,4,6,9]
  let arr2=arr.map((n)=>{return  '<li>${n*n}</li>';});
  console.log(arr2);
  //Note: original array does not get altered and the returned array may
  //contain different elements than original array
  //2. reduce() : this function executes  a callback function on each
  // item of the array and returns single value
  let numbers=[1,2,3,4,5];
  let sum=numbers.reduce((accumulator, currntValue)=>{
    return accumulator+currntValue;
  },0);
  console.log('sum:',sum);
  //3. forEach():- It executes a callback function on each array items
  let cities =['mysore','delhi','bangalore'];
  cities.forEach((c)=>{
    console.log(c);
  })
  //4.filter(): this method accepts a callback function and return the
  //filterd arrry based on condition specified in the callback
  //function
  let number2=[2,11,42,14,39];
  let filterNumbers=number2.filter((n)=>{
    return n%2==0;
  });
  console.log(number2);
  console.log('even numbers',filterNumbers);
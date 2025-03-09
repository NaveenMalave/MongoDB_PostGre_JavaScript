for(var i=1;i<10;i++){
    setTimeout(()=>{
        console.log(i);
    },1000);
    
}
let array=[1,2,3,4,5,6,7,8,9,10];
let number = array.filter((n)=>{
    return n%2!=0;
})
console.log(array);
console.log('odd numbers are:',number);

var arr=[1,2,4,5,6,7,8];
function even(){
    for(let i=0;i<arr.length;i++){
        if(arr[i]%2==0){
            console.log(arr[i]);
        }
    }
}
even();
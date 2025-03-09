let a=5;
let b=50;
let flag=false;
function prime(){
while(a<=b){
    flag=false;
    for(let i=2;i<=Math.trunc(a/2);i++){
        if(a%i==0){
            flag=true;
            break;
        }
    }
    if(!flag){
        console.log(a);
    }
    a++;
}
}
prime();
#pragma strict


// Drag it to the Water Object for more freedom of animation 


// Animate example for EasyWaterFastest shader

//----------------------------------------------------




// Declare here the input properties for each 
// shader properties you want to animate

// MainTex slot
var texture1Speed : Vector2;
var texture2Speed : Vector2;
var bumpMap1Speed : Vector2;
var bumpMap2Speed : Vector2;
var distortSpeed : Vector2;


function Start () {

 texture1Speed = texture1Speed /10;
 texture2Speed = texture2Speed /10;
 bumpMap1Speed = bumpMap1Speed /10;
 bumpMap2Speed = bumpMap2Speed /10;
 distortSpeed = distortSpeed /10;

}

function Update () {

// Declare here the UV properties for each
// shader properties you're animating

//MainTex UV -- Repeat it for each shader properties
var texture1UV : Vector2;
texture1UV.x = Time.time * texture1Speed.x;
texture1UV.y = Time.time * texture1Speed.y;

var texture2UV : Vector2;
texture2UV.x = Time.time * texture2Speed.x;
texture2UV.y = Time.time * texture2Speed.y;

var bumpMap1UV : Vector2;
bumpMap1UV.x = Time.time * bumpMap1Speed.x;
bumpMap1UV.y = Time.time * bumpMap1Speed.y;

var bumpMap2UV : Vector2;
bumpMap2UV.x = Time.time * bumpMap2Speed.x;
bumpMap2UV.y = Time.time * bumpMap2Speed.y;

var distortUV : Vector2;
distortUV.x = Time.time * distortSpeed.x;
distortUV.y = Time.time * distortSpeed.y;




// For each property copy this line and chage texture names and UV properties
GetComponent.<Renderer>().material.SetTextureOffset("_Texture1", texture1UV);
GetComponent.<Renderer>().material.SetTextureOffset("_Texture2", texture2UV);
GetComponent.<Renderer>().material.SetTextureOffset("_BumpMap1", bumpMap1UV);
GetComponent.<Renderer>().material.SetTextureOffset("_BumpMap2", bumpMap2UV);
GetComponent.<Renderer>().material.SetTextureOffset("_DistortionMap", distortUV);


}
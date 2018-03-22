using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorClass : MonoBehaviour {

    public float speed = 20;
    
    private float[] color = new float[3];

	// Use this for initialization
	void Start () {
        color[0] = 255;
        color[1] = 0;
        color[2] = 0;

        StartCoroutine(ChangeColor());
    }

    IEnumerator ChangeColor()
    {
        int i = 2;
        while (true)
        {
            i %= color.Length;

            if (color[i] == 0)
            {
                while (true)
                {
                    color[i] += speed * Time.deltaTime;
                    yield return null;
                    if (color[i] >= 255)
                    {
                        color[i] = 255;
                        i++;
                        break;
                    }
                }
            }
            else if (color[i] == 255)
            {
                while (true)
                {
                    color[i] -= speed * Time.deltaTime;
                    yield return null;
                    if (color[i] <= 0)
                    {
                        color[i] = 0;
                        i++;
                        break;
                    }
                }
            }
            
        }
    }

    public Color GetColor()
    {
        return new Color(color[0] / 255f, color[1] / 255f, color[2] / 255f);
    }

}

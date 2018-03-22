using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioVisualization : MonoBehaviour
{
    public GameObject cube;
    public float cubeHeight = 5;
    public float maxHeight = 40f;

    private float widthOfCube = 1f;
    private float radius = 12f;
    private float reduceSpeed = 8;
    private float addSpeed = 10;
    private float angle = 10f;
    private AudioSource audioSource;
    private float[] samples = new float[64];
    private Transform[] cubeTransform;
    private ColorClass colorClass;
    private MeshRenderer[] cubeMeshrenders;


    // Use this for initialization  
    void Start()
    {
        colorClass = GetComponent<ColorClass>();
        angle = 360f / (samples.Length - 14);
        GameObject tempCube;
        audioSource = GetComponent<AudioSource>();
        cubeTransform = new Transform[samples.Length];
        for (int i = 0; i < samples.Length - 14; i++)
        {
            tempCube = Instantiate(cube, new Vector3(transform.position.x + i * widthOfCube, transform.position.y, transform.position.z), Quaternion.identity);
            cubeTransform[i] = tempCube.transform;
            cubeTransform[i].parent = transform;
            angle %= 360;
            float x = transform.position.x + radius * Mathf.Cos(angle * i * 2 * Mathf.PI / 360);
            float z = transform.position.z + radius * Mathf.Sin(angle * i * 2 * Mathf.PI / 360);
            tempCube.transform.position = new Vector3(x, transform.position.y, z);
            tempCube.transform.LookAt(transform);
        }
        cubeMeshrenders = transform.GetComponentsInChildren<MeshRenderer>();
    }

    // Update is called once per frame  
    void Update()
    {
        audioSource.GetSpectrumData(samples, 0, FFTWindow.BlackmanHarris);

        ChangeSize();
        ChangeColor();
    }

    private void ChangeSize()
    {
        for (int i = 0; i < samples.Length - 14; i++)
        {
            float height = samples[i] * (50 + i * i) * cubeHeight;

            Vector3 targetScale = Vector3.one;
            if (cubeTransform[i].localScale.y < height)
            {
                targetScale.y = Mathf.Lerp(cubeTransform[i].localScale.y, height, addSpeed * Time.deltaTime);
            }
            else
            {
                targetScale.y = cubeTransform[i].localScale.y - reduceSpeed * Time.deltaTime;
            }
            
            targetScale.y = Mathf.Clamp(targetScale.y, 0.1f, maxHeight);
            cubeTransform[i].localScale = targetScale;
        }
    }

    private void ChangeColor()
    {
        Color color = colorClass.GetColor();
        foreach (MeshRenderer m in cubeMeshrenders)
        {
            m.material.SetColor("_TintColor", color);
            m.material.SetColor("_GlowColor", color);
        }
    }
}

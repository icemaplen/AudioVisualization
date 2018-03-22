using UnityEngine;
using System.Collections;

public class ColorChanger : MonoBehaviour
{
 
    Mesh mesh;
    Color[] meshColors;

    void Start() {
        mesh = GetComponent<MeshFilter>().mesh;
        meshColors = new Color[mesh.vertices.Length];
    }

    // Update is called once per frame
    void Update() {

        float offset = transform.position.magnitude / 3;

        float r = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad  + offset));
        float g = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 0.45f + offset));
        float b = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 1.2f + offset));
        Color newColor = new Color(r,g,b);
        for (int i=0; i<meshColors.Length; ++i) {
            meshColors [i] = newColor;
        }
        mesh.colors = meshColors;

    }
    
}
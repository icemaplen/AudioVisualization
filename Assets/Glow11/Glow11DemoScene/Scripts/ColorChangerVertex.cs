using UnityEngine;
using System.Collections;

public class ColorChangerVertex : MonoBehaviour
{
 
    Mesh mesh;
    Color[] meshColors;

    void Start() {
        mesh = GetComponent<MeshFilter>().mesh;
        meshColors = new Color[mesh.vertices.Length];
    }

    // Update is called once per frame
    void Update() {
        for (int i=0; i<meshColors.Length; ++i) {
            float offset = mesh.vertices[i].magnitude;
            float r = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad  + offset));
            float g = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 0.45f + offset));
            float b = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 1.2f + offset));
            Color newColor = new Color(r,g,b);

            meshColors [i] = newColor;
        }
        mesh.colors = meshColors;

    }
    
}
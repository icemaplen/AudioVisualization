using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateAround : MonoBehaviour {

    public float rotateSpeed = 5f;

    private Transform audioPlayerTrans;

	// Use this for initialization
	void Start () {
        audioPlayerTrans = GameObject.Find("AudioPlayer").transform;
	}
	
	// Update is called once per frame
	void Update () {
        transform.RotateAround(audioPlayerTrans.position, Vector3.up, rotateSpeed * Time.deltaTime);
        transform.LookAt(audioPlayerTrans);
	}
}

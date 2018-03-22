using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class Handle : MonoBehaviour, IPointerDownHandler
{
    private PlayerManager playerManager;
    private bool isPressingButton0 = false;

    // Use this for initialization
    void Start()
    {
        playerManager = GameObject.Find("PlayerManager").GetComponent<PlayerManager>();
    }

    // Update is called once per frame
    void Update()
    {
        if (isPressingButton0 && Input.GetMouseButtonUp(0))
        {
            isPressingButton0 = false;
            playerManager.OnHandleButtonUp();
        }
    }
    public void OnPointerDown(PointerEventData eventData)
    {
        playerManager.OnHandleButtonDown();
        isPressingButton0 = true;
    }
}

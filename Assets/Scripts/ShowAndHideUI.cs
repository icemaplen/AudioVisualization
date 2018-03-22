using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowAndHideUI : MonoBehaviour
{

    public float speed = 20;

    [Space(20)]
    public Sprite spreadButtonNormal;
    public Sprite spreadButtonHight;
    public Sprite spreadButtonPressed;

    [Space(20)]
    public Sprite retractButtonNormal;
    public Sprite retractButtonHight;
    public Sprite retractButtonPressed;

    private CanvasGroup bottomCanvasGroup;
    private CanvasGroup rightCanvasGroup;

    private Button spreadButton;

    private bool isSpread = false;
    private bool isBottomShow = true;

    // Use this for initialization
    void Start()
    {
        spreadButton = GameObject.Find("SpreadButton").GetComponent<Button>();
        spreadButton.onClick.AddListener(OnSpreadButtonClick);

        bottomCanvasGroup = GameObject.Find("BottomCanvas").GetComponent<CanvasGroup>();
        rightCanvasGroup = GameObject.Find("RightCanvas").GetComponent<CanvasGroup>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyUp(KeyCode.Escape))
        {
            ShowAndHideBottomUI();
        }
    }

    private void OnSpreadButtonClick()
    {
        if (isSpread && rightCanvasGroup.alpha == 1)
        {
            isSpread = false;
            HideCanvas(rightCanvasGroup);
            spreadButton.image.sprite = retractButtonNormal;
            SpriteState ss = new SpriteState();
            ss.highlightedSprite = retractButtonHight;
            ss.pressedSprite = retractButtonPressed;
            spreadButton.spriteState = ss;
        }
        else if (isSpread == false && rightCanvasGroup.alpha == 0)
        {
            isSpread = true;
            ShowCanvas(rightCanvasGroup);
            spreadButton.image.sprite = spreadButtonNormal;
            SpriteState ss = new SpriteState();
            ss.highlightedSprite = spreadButtonHight;
            ss.pressedSprite = spreadButtonPressed;
            spreadButton.spriteState = ss;
        }
    }

    private void ShowAndHideBottomUI()
    {
        if (isBottomShow && bottomCanvasGroup.alpha == 1)
        {
            isBottomShow = false;
            HideCanvas(bottomCanvasGroup);
            Cursor.visible = false;
            if (isSpread)
            {
                OnSpreadButtonClick();
            }
        }
        else if (isBottomShow == false && bottomCanvasGroup.alpha == 0)
        {
            isBottomShow = true;
            Cursor.visible = true;
            ShowCanvas(bottomCanvasGroup);
        }
    }

    private void ShowCanvas(CanvasGroup canvas)
    {
        StartCoroutine(ChangeAlpha(canvas, true));
        canvas.interactable = true;
        canvas.blocksRaycasts = true;
    }

    private void HideCanvas(CanvasGroup canvas)
    {
        StartCoroutine(ChangeAlpha(canvas, false));
        canvas.interactable = false;
        canvas.blocksRaycasts = false;
    }

    IEnumerator ChangeAlpha(CanvasGroup canvas, bool isToShow)
    {
        if (isToShow == false)
        {
            while (canvas.alpha > 0.01)
            {
                canvas.alpha = Mathf.Lerp(canvas.alpha, 0, speed * Time.deltaTime);
                yield return null;
            }
            canvas.alpha = 0;
        }
        else
        {
            while (canvas.alpha < 0.99)
            {
                canvas.alpha = Mathf.Lerp(canvas.alpha, 1, speed * Time.deltaTime);
                yield return null;
            }
            canvas.alpha = 1;
        }
    }
}

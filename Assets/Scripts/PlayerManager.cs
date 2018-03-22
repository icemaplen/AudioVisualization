using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using NAudio.Wave;
using System.IO;

public class PlayerManager : MonoBehaviour
{
    public AudioClip audioClip;

    #region 底部菜单
    [Space(10)]
    public Sprite playTexture;
    public Sprite pauseTexture;
    public Sprite normalTexture;
    public Sprite muteTexture;

    private Button lastButton;
    private Button nextButton;
    private Button playAndPauseButton;
    private Button volumeButton;
    private Slider progressBar;
    private Slider volumeBar;
    private Button handleButton;
    private Text currentTimeText;
    private Text totalTimeText;
    private Text nameText;
    #endregion

    #region 右边菜单
    private Text indexText;
    private Button indexButton;

    private Slider innerStrengthBar;
    private Slider outerStrengthBar;
    private Slider boostStrengthBar;

    private Button randomButton;
    [Space(10)]
    public Sprite randomOnTexture;
    public Sprite randomOffTexture;

    private Slider waterSpeedBar;
    private Slider waterReflectionBar;

    private Slider colorSpeedBar;
    private Slider cubeHeightBar;
    private Slider maxHeightBar;

    private Button exitButton;
    #endregion

    private Glow11.Glow11 glow11;
    private AudioVisualization audioVisualization;
    private FileControllor fileControllor;
    private ColorClass colorClass;
    private AudioSource audioSource;
    [Space(10)]
    public Material waterMaterial;

    private bool isMute = false;
    private bool isPressingHandle = false;
    private bool isRandom = true;
    private float second = 0;
    private float tempVolume = 0.4f;
    private List<Music> musicList = null;
    private int order = 0;
    private bool hasMusic = false;

    // Use this for initialization
    void Start()
    {
        audioVisualization = GameObject.Find("AudioPlayer").GetComponent<AudioVisualization>();
        colorClass = GameObject.Find("AudioPlayer").GetComponent<ColorClass>();
        fileControllor = GetComponent<FileControllor>();

        InitUI();
        InitGlow11();
        InitBarValue();

        if (CheckIndexAndGetMusic(PlayerPrefs.GetString("index")))
        {
            PlayMusic(musicList[UnityEngine.Random.Range(0, musicList.Count)]);
        }
        else
        {
            InitAudioInfo(audioClip);
            nameText.text = audioSource.clip.name;
        }

    }

    // Update is called once per frame
    void Update()
    {
        if (isPressingHandle == false)
        {
            progressBar.value = audioSource.time / second;
        }

        if (audioSource.time > audioSource.clip.length - 0.2f)
        {
            OnNextButtonClick();
        }

        DisposeKey();
        
        currentTimeText.text = TimeToString(audioSource.time);
    }

    private void InitUI()
    {
        #region 底部菜单
        playAndPauseButton = GameObject.Find("PlayAndPauseButton").GetComponent<Button>();
        playAndPauseButton.onClick.AddListener(OnPlayAndPauseButtonClick);

        nextButton = GameObject.Find("NextButton").GetComponent<Button>();
        nextButton.onClick.AddListener(OnNextButtonClick);

        lastButton = GameObject.Find("LastButton").GetComponent<Button>();
        lastButton.onClick.AddListener(OnLastButtonClick);

        volumeButton = GameObject.Find("VolumeButton").GetComponent<Button>();
        volumeButton.onClick.AddListener(OnVolumeImageButtonClick);

        handleButton = GameObject.Find("ProgressHandle").GetComponent<Button>();
        handleButton.onClick.AddListener(OnHandleButtonDown);

        progressBar = GameObject.Find("ProgressBar").GetComponent<Slider>();
        progressBar.GetComponent<RectTransform>().sizeDelta = new Vector2(Screen.width, 20);
        volumeBar = GameObject.Find("VolumeBar").GetComponent<Slider>();
        volumeBar.onValueChanged.AddListener(OnVolumeBarChange);

        audioSource = GameObject.Find("AudioPlayer").GetComponent<AudioSource>();

        currentTimeText = GameObject.Find("CurrentTime").GetComponent<Text>();
        totalTimeText = GameObject.Find("TotalTime").GetComponent<Text>();
        nameText = GameObject.Find("Name").GetComponent<Text>();
        #endregion

        #region 右边菜单
        indexText = GameObject.Find("IndexText").GetComponent<Text>();
        indexButton = GameObject.Find("IndexButton").GetComponent<Button>();
        indexButton.onClick.AddListener(OnIndexButtonClick);

        innerStrengthBar = GameObject.Find("InnerStrengthBar").GetComponent<Slider>();
        innerStrengthBar.onValueChanged.AddListener(OnInnerStrenthBarChangeValue);
        outerStrengthBar = GameObject.Find("OuterStrengthBar").GetComponent<Slider>();
        outerStrengthBar.onValueChanged.AddListener(OnOuterStrenthBarChangeValue);
        boostStrengthBar = GameObject.Find("BoostStrengthBar").GetComponent<Slider>();
        boostStrengthBar.onValueChanged.AddListener(OnBoostStrenthBarChangeValue);

        randomButton = GameObject.Find("RandomButton").GetComponent<Button>();
        randomButton.onClick.AddListener(OnRandomButtonClick);

        colorSpeedBar = GameObject.Find("ColorSpeedBar").GetComponent<Slider>();
        colorSpeedBar.onValueChanged.AddListener(OnColorSpeedBarChangeValue);
        cubeHeightBar = GameObject.Find("CubeHeightBar").GetComponent<Slider>();
        cubeHeightBar.onValueChanged.AddListener(OnCubeHeightBarChangeValue);
        maxHeightBar = GameObject.Find("MaxHeightBar").GetComponent<Slider>();
        maxHeightBar.onValueChanged.AddListener(OnMaxHeightBarChangeValue);

        waterSpeedBar = GameObject.Find("WaterSpeedBar").GetComponent<Slider>();
        waterSpeedBar.onValueChanged.AddListener(OnWaterSpeedBarChangeValue);
        waterReflectionBar = GameObject.Find("WaterReflectionBar").GetComponent<Slider>();
        waterReflectionBar.onValueChanged.AddListener(OnWaterReflctionBarChangeValue);

        exitButton = GameObject.Find("ExitButton").GetComponent<Button>();
        exitButton.onClick.AddListener(OnExitButtonClick);
        #endregion

        audioSource.volume = volumeBar.value;
    }

    private void InitGlow11()
    {
        glow11 = Camera.main.GetComponent<Glow11.Glow11>();
        innerStrengthBar.value = glow11.settings.innerStrength / 10;
        outerStrengthBar.value = glow11.settings.outerStrength / 10;
        boostStrengthBar.value = glow11.settings.boostStrength / 10;
    }

    private void InitBarValue()
    {
        colorSpeedBar.value = colorClass.speed / 255;
        cubeHeightBar.value = audioVisualization.cubeHeight / 10;
        maxHeightBar.value = audioVisualization.maxHeight / 50;

        waterSpeedBar.value = waterMaterial.GetFloat("_DistortionSpeed") / 30;
        waterReflectionBar.value = waterMaterial.GetFloat("_ReflectPower");
    }

    private void InitAudioInfo(AudioClip clip)
    {
        audioSource.clip = clip;
        second = audioSource.clip.length;
        audioSource.time = 0;
        totalTimeText.text = TimeToString(second);
        audioSource.Play();
    }

    private void DisposeKey()
    {
        if (Input.GetKeyUp(KeyCode.Space))
        {
            OnPlayAndPauseButtonClick();
        }

        if (Input.GetKeyUp(KeyCode.LeftArrow))
        {
            OnLastButtonClick();
        }
        else if (Input.GetKeyUp(KeyCode.RightArrow))
        {
            OnNextButtonClick();
        }

        if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            volumeBar.value += 0.1f;
            volumeBar.value = Mathf.Clamp(volumeBar.value, 0f, 1f);
            OnVolumeBarChange(volumeBar.value);
        }
        else if (Input.GetKeyDown(KeyCode.DownArrow))
        {
            volumeBar.value -= 0.1f;
            volumeBar.value = Mathf.Clamp(volumeBar.value, 0f, 1f);
            OnVolumeBarChange(volumeBar.value);
        }
    }

    private void OnPlayAndPauseButtonClick()
    {
        if (audioSource.isPlaying)
        {
            audioSource.Pause();
            playAndPauseButton.image.sprite = playTexture;
        }
        else
        {
            audioSource.Play();
            playAndPauseButton.image.sprite = pauseTexture;
        }
    }

    private void OnLastButtonClick()
    {
        playAndPauseButton.image.sprite = pauseTexture;

        if (hasMusic)
        {
            order--;
            order = order < 0 ? musicList.Count + order : order;

            PlayMusic(musicList[order]);
        }
        else
        {
            InitAudioInfo(audioClip);
            nameText.text = audioSource.clip.name;
        }
    }

    private void OnNextButtonClick()
    {
        playAndPauseButton.image.sprite = pauseTexture;

        if (hasMusic)
        {
            order++;
            order %= musicList.Count;

            PlayMusic(musicList[order]);
        }
        else
        {
            InitAudioInfo(audioClip);
            nameText.text = audioSource.clip.name;
        }
    }

    private void PlayMusic(Music music)
    {
        if (isRandom)
        {
            order = UnityEngine.Random.Range(0, musicList.Count);
        }
        nameText.text = music.Name;
        StartCoroutine(LoadMusic(music.Path));
    }

    private IEnumerator LoadMusic(string filePath)
    {
        string savePath = Application.streamingAssetsPath + "/temp.wav";
        FileStream stream = File.Open(filePath, FileMode.Open);
        Mp3FileReader reader = new Mp3FileReader(stream);
        WaveFileWriter.CreateWaveFile(savePath, reader);
        WWW www = new WWW("file://" + savePath);
        yield return www;
        stream.Close();
        InitAudioInfo(www.GetAudioClip());
    }

    private void OnVolumeImageButtonClick()
    {
        if (isMute)
        {
            isMute = false;
            audioSource.mute = false;
            volumeBar.value = tempVolume;
            volumeButton.GetComponent<Image>().sprite = normalTexture;
        }
        else
        {
            isMute = true;
            audioSource.mute = true;
            tempVolume = audioSource.volume;
            volumeBar.value = 0;
            volumeButton.GetComponent<Image>().sprite = muteTexture;
        }
    }

    private string TimeToString(float _second)
    {
        int minute = (int)(_second / 60);
        int second = (int)(_second % 60);

        string minute0 = minute < 10 ? "0" : "";
        string second0 = second < 10 ? "0" : "";
        return String.Format("{0}{1}:{2}{3}", minute0, minute, second0, second);
    }

    private void OnVolumeBarChange(float value)
    {
        audioSource.volume = value;
    }

    public void OnHandleButtonDown()
    {
        isPressingHandle = true;
    }

    public void OnHandleButtonUp()
    {
        isPressingHandle = false;

        audioSource.time = progressBar.value * second;
    }


    private void OnIndexButtonClick()
    {
        string path = fileControllor.OpenDir();
        CheckIndexAndGetMusic(path);
        order = 0;
    }

    private bool CheckIndexAndGetMusic(string path)
    {
        indexText.color = Color.red;
        if (string.IsNullOrEmpty(path) == false)
        {
            musicList = fileControllor.GetAllMusic(path);
            if (musicList.Count > 0)
            {
                indexText.color = Color.green;
                PlayerPrefs.SetString("index", path);
                indexText.text = path;
                hasMusic = true;
                return true;
            }
        }
        else
        {
            path = "未指定文件夹";
        }

        indexText.text = path;
        hasMusic = false;
        return false;
    }

    private void OnInnerStrenthBarChangeValue(float value)
    {
        float tmp = value * 10;
        tmp = tmp < 0.1f ? 0.1f : tmp;
        glow11.settings.innerStrength = tmp;
    }

    private void OnOuterStrenthBarChangeValue(float value)
    {
        float tmp = value * 10;
        tmp = tmp < 0.1f ? 0.1f : tmp;
        glow11.settings.outerStrength = tmp;
    }

    private void OnBoostStrenthBarChangeValue(float value)
    {
        float tmp = value * 10;
        tmp = tmp < 0.1f ? 0.1f : tmp;
        glow11.settings.boostStrength = tmp;
    }

    private void OnRandomButtonClick()
    {
        if (isRandom)
        {
            isRandom = false;
            randomButton.GetComponent<Image>().sprite = randomOffTexture;
        }
        else
        {
            isRandom = true;
            randomButton.GetComponent<Image>().sprite = randomOnTexture;
        }
    }

    private void OnColorSpeedBarChangeValue(float value)
    {
        float tmp = value * 255;
        tmp = tmp < 1 ? 1 : tmp;
        colorClass.speed = tmp;
    }
    private void OnCubeHeightBarChangeValue(float value)
    {
        float tmp = value * 10;
        tmp = tmp < 0.1f ? 0.1f : tmp;
        audioVisualization.cubeHeight = tmp;
    }
    private void OnMaxHeightBarChangeValue(float value)
    {
        audioVisualization.maxHeight = value * 50;
    }

    private void OnWaterSpeedBarChangeValue(float value)
    {
        waterMaterial.SetFloat("_DistortionSpeed", value * 30);
    }

    private void OnWaterReflctionBarChangeValue(float value)
    {
        waterMaterial.SetFloat("_ReflectPower", value);
    }

    private void OnExitButtonClick()
    {
        Application.Quit();
    }
}

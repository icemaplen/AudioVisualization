using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Music
{
    public string Name { get; private set; }
    public string Path { get; private set; }


    public Music(string name, string path)
    {
        Name = name.Replace(".mp3", "");
        Path = path;
    }
}

using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System;

public class FileControllor : MonoBehaviour
{
    public string OpenDir()
    {
        OpenDialogDir dir = new OpenDialogDir();
        dir.pszDisplayName = new string(new char[2000]); ;
        dir.lpszTitle = "选择播放目录";
        IntPtr pidlPtr = DllOpenFileDialog.SHBrowseForFolder(dir);

        char[] charArray = new char[2000];
        for (int i = 0; i < 2000; i++)
        {
            charArray[i] = '\0';
        }

        DllOpenFileDialog.SHGetPathFromIDList(pidlPtr, charArray);
        string fullDirPath = new String(charArray);

        fullDirPath = fullDirPath.Substring(0, fullDirPath.IndexOf('\0'));

        return fullDirPath;
    }

    public List<Music> GetAllMusic(string path)
    {
        List<Music> musicList = new List<Music>();
        DirectoryInfo folder = new DirectoryInfo(path);
        foreach (FileInfo file in folder.GetFiles("*.mp3"))
        {
            Music music = new Music(file.Name, file.FullName);
            musicList.Add(music);
        }
        return musicList;
    }

}
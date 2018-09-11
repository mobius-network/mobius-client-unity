using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameController : MonoBehaviour
{

    public static GameController Instance;

    public float scrollSpeed = -1.5f;
    public bool isGameOver = false;
    private int score = 0;

    public Text scoreText;
    public GameObject gameOverText;

	public GameObject gameOverPanel;

	public bool isCheck;

    // Use this for initialization
    void Awake()
    {
		isCheck = false;
        if (Instance == null)
        {
            Instance = this;
        }
        else if (Instance != this)
        {
            Destroy(gameObject);
        }
    }

    // Update is called once per frame
    void Update()
    {
		if(isGameOver && !isCheck)
        {
			gameOverPanel.SetActive (true);
			isCheck = true;
            //SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
    }

    public void Score()
    {
        if(isGameOver) { return; }

        score++;
        scoreText.text = "Score: " + score;
    }

    public void Die()
    {
        gameOverText.SetActive(true);
        isGameOver = true;
    }
}

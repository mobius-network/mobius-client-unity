using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Bird : MonoBehaviour
{
    public float upForce = 200f;
    public bool isDead = false;

    private Rigidbody2D rb2d;
    private Animator anim;

	public GameObject _tapToPlayText;

	public static bool isGameStart;

    // Use this for initialization
    void Start()
    {
		isGameStart = false;
        rb2d = GetComponent<Rigidbody2D>();
        anim = GetComponent<Animator>();
		_tapToPlayText.SetActive (true);
		rb2d.gravityScale = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (isDead) { return; }

        if (Input.GetMouseButtonDown(0))
        {
			if (_tapToPlayText.activeSelf) {
				_tapToPlayText.SetActive (false);
				rb2d.gravityScale = 1;
				isGameStart = true;
			}
            rb2d.velocity = Vector2.zero;
            rb2d.AddForce(new Vector2(0, upForce));
            anim.SetTrigger("Flap");
        }
    }

    void OnCollisionEnter2D()
    {
        isDead = true;
        rb2d.velocity = Vector2.zero;
        anim.SetTrigger("Die");
        GameController.Instance.Die();
    }
}

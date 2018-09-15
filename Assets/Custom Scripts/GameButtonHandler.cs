using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;

public class GameButtonHandler : MonoBehaviour {

	public Text blnceText;
	public Text error_text;
	public GameObject gameOverPanel;

	public GameObject _errorPanel;

	void Start() {
		blnceText.text = "Balance : " + PlayerPrefs.GetString ("CB");
	}

	public void btnEventRetry() {
		string sendPay = "";
		sendPay = MobiusUnity.SendPayment (PlayerPrefs.GetString("PublicKey") , PlayerPrefs.GetString("SecretKey") , "5" , PlayerPrefs.GetString ("Status"));


		try 
		{
			MobiusUnityObject mobius_unity_object = JsonUtility.FromJson<MobiusUnityObject> (sendPay);

			Debug.Log ("public key : " + mobius_unity_object.publicKey);
			Debug.Log ("secret key : " + mobius_unity_object.secretkey);
			Debug.Log ("balance : " + mobius_unity_object.balance);
			Debug.Log ("error : " + mobius_unity_object.error);


			if (mobius_unity_object.error == "NO") {
				PlayerPrefs.SetString ("CB" , mobius_unity_object.balance);
				gameOverPanel.SetActive(false);
				SceneManager.LoadScene (1);
			} else {
				error_text.text = mobius_unity_object.error;
				_errorPanel.SetActive(true);
			}

		} catch (Exception ex) {
			Debug.Log (sendPay);
			//error_text.text = sendPay;
			//_errorPanel.SetActive(true);
			gameOverPanel.SetActive (false);
			SceneManager.LoadScene (1);
		}
	}

	public void btnEventHome() {
		SceneManager.LoadScene (0);
	}

	public void crossBtn() {
		_errorPanel.SetActive (false);
	}
}

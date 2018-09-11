using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;

public class MainMenuHandler : MonoBehaviour {

	public string owner_public_key;
	public string amount_to_receive;
	public string status;

	public UIManager _uiManager;

	public GameObject[] testLiveBtn;

	void Start() {
		btnToggle (0);
		_uiManager = gameObject.GetComponent<UIManager> ();
	}

	public void btnLogin() {
		Debug.Log ("In Btn Login");
		if (_uiManager.login_secret_key.text == "") {
			_uiManager.error_panel.SetActive (true);
			_uiManager.error_text.text = "Error Secret Cannot be Empty";
		} else {
			Debug.Log ("In else ");
			_uiManager.loading_panel.SetActive (true);
			sendPayment (owner_public_key , _uiManager.login_secret_key.text , amount_to_receive , status);
		}
	}

	public void closeErrorPanel() {
		_uiManager.error_panel.SetActive (false);
	}

	public void sendPayment(string pubKey , string secKey , string amount , string status) {
		string sendPay = MobiusUnity.SendPayment (pubKey , secKey , amount , status);

		try 
		{
			PlayerPrefs.SetString("PublicKey" , pubKey);
			PlayerPrefs.SetString("SecretKey" , secKey);
			PlayerPrefs.SetString("Status" , status);

			MobiusUnityObject mobius_unity_object = JsonUtility.FromJson<MobiusUnityObject> (sendPay);

			Debug.Log ("public key : " + mobius_unity_object.publicKey);
			Debug.Log ("secret key : " + mobius_unity_object.secretkey);
			Debug.Log ("balance : " + mobius_unity_object.balance);
			Debug.Log ("error : " + mobius_unity_object.error);

			_uiManager.loading_panel.SetActive (false);


			if (mobius_unity_object.error == "NO") {
				PlayerPrefs.SetString ("CB" , mobius_unity_object.balance);
				SceneManager.LoadScene (1);
				Debug.Log ("Payment Successfully Done ");
			} else {
				_uiManager.error_panel.SetActive (true);
				_uiManager.error_text.text = "Error : " + mobius_unity_object.error;
			}

		} catch (Exception ex) {
			Debug.Log (sendPay);
		//	_uiManager.loading_panel.SetActive (false);
		//	_uiManager.error_panel.SetActive (true);
		//	_uiManager.error_text.text = "Error : " + sendPay;

			_uiManager.loading_panel.SetActive (false);
			SceneManager.LoadScene (1);
		}


	}

	public void btnToggle(int val) {
		if (val == 0) {
			status = "false";
			testLiveBtn [0].GetComponent<Button> ().interactable = false;
			testLiveBtn [1].GetComponent<Button> ().interactable = true;
		} else {
			status = "true";
			testLiveBtn [0].GetComponent<Button> ().interactable = true;
			testLiveBtn [1].GetComponent<Button> ().interactable = false;
		}
	}

	public void getDummyKey() {
		_uiManager.login_secret_key.text = "SB35BOVVOO2XFDEEHYP2JJADZE4X6EGHFUXA4ZYBSWWSZB4GGA5SH3VN"; 
	}
}

using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class MobiusUnity : MonoBehaviour {

	#region Declare external C interface

	#if UNITY_IOS && !UNITY_EDITOR

	[DllImport("__Internal")]
	private static extern string _sayHiToUnity();

	[DllImport("__Internal")]
	private static extern string _CreateAccount(string status);

	[DllImport("__Internal")]
	private static extern string _NativeMethodName(string testing);

	[DllImport("__Internal")]
	private static extern string _getBalance(string secKey , string status);

	[DllImport("__Internal")]
	private static extern string _SendPayment(string pubKey , string secKey , string amount , string status);


	#endif

	#endregion

	#region Wrapped methods and properties

	public static string HiFromSwift()
	{
		Debug.Log("Inside Function");
		#if UNITY_IOS && !UNITY_EDITOR
		return _sayHiToUnity();
		#else
		return "No Swift found!";
		#endif
	}

	public static string TestingParams(string test)
	{
		Debug.Log("Inside Function");
		#if UNITY_IOS && !UNITY_EDITOR
		return _NativeMethodName(test);
		#else
		return "No Swift found!";
		#endif
	}

	public static string getBalance(string secKey, string status)
	{
		Debug.Log("Inside Function");
		#if UNITY_IOS && !UNITY_EDITOR
		return _getBalance(secKey ,status);
		#else
		return "No Swift found!";
		#endif
	}

	public static string CreateAccount(string status)
	{
		Debug.Log("Inside Function");
		#if UNITY_IOS && !UNITY_EDITOR
		return _CreateAccount(status);
		#else
		return "No Swift found!";
		#endif
	}

	public static string SendPayment(string pubKey , string secKey , string amount , string status)
	{
		Debug.Log("Inside Function");
		#if UNITY_IOS && !UNITY_EDITOR
		return _SendPayment(pubKey , secKey , amount , status);
		#else
		return "No Swift found!";
		#endif
	}

//	public static string Transaction(string pubKey , string secKey , string amount) {
//		Debug.Log("Inside Function");
//		#if UNITY_IOS && !UNITY_EDITOR
//		return _transaction(pubKey , secKey , amount);
//		#else
//		return "No Swift found!";
//		#endif
//	}

	#endregion

	#region Singleton implementation

	private static MobiusUnity _instance;

	public static MobiusUnity Instance
	{
		get
		{
			if (_instance == null)
			{
				var obj = new GameObject("SwiftUnity");
				_instance = obj.AddComponent<MobiusUnity>();
			}

			return _instance;
		}
	}

	private void Awake()
	{
		if (_instance != null)
		{
			Destroy(gameObject);
			return;
		}

		DontDestroyOnLoad(gameObject);
	}

	#endregion
}

[System.Serializable]
public class MobiusUnityObject 
{
	public string publicKey;
	public string secretkey;
	public string balance;
	public string error;
}
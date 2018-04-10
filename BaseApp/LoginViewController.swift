//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: UI
    let inputsContainerView = UIView().with {
        $0.backgroundColor = UIColor.white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    let loginRegisterSegmentedControl = UISegmentedControl(items: ["Login", "Register"]).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor.white
        $0.selectedSegmentIndex = 0
        $0.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
    }
    
    lazy var loginRegisterButton = UIButton(type: .system).with {
        $0.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        $0.setTitle("Login", for: UIControlState())
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.white, for: UIControlState())
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
    }
    
    let nameTextField = UITextField().with {
        $0.placeholder = "Name"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let emailTextField = UITextField().with {
        $0.placeholder = "Email"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let passwordTextField = UITextField().with {
        $0.placeholder = "Password"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let separatorView1 = UIView().with {
        $0.backgroundColor = UIColor.rgb(220, green: 220, blue: 220)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let separatorView2 = UIView().with {
        $0.backgroundColor = UIColor.rgb(220, green: 220, blue: 220)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var profileImageView = UIImageView().with {
        $0.image = UIImage(named: "gameofthrones_splash")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        $0.isUserInteractionEnabled = true
    }
    
    lazy var registerBtn = UIButton(type: .system).with {
        $0.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        $0.setTitle("Register", for: UIControlState())
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.white, for: UIControlState())
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(handleRegisterBtn), for: .touchUpInside)
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    // MARK: Lifecycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(profileImageView)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(registerBtn)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        setupProfileImageView()
        setupRegisterBtn()
        handleLoginRegisterChange()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Logic App
extension LoginViewController {
    
    @objc fileprivate func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        picker.didCancel = { picker in
            picker.dismiss(animated: true, completion: nil)
        }
        picker.didFinishPickingMedia = { picker, image in
            self.profileImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControlState())
        let isButtonLogin = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        updateViewWithSegmentedControl(isButtonLogin)
    }
    
    fileprivate func updateViewWithSegmentedControl(_ isButtonLogin: Bool) {
        
        separatorView1.isHidden = isButtonLogin
        inputsContainerViewHeightAnchor?.isActive = false
        inputsContainerViewHeightAnchor?.constant = isButtonLogin ? 100 : 150
        inputsContainerViewHeightAnchor?.isActive = true
        
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isButtonLogin ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = isButtonLogin
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isButtonLogin ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isButtonLogin ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    @objc fileprivate func handleRegisterBtn() {
        let register = RegisterViewController()
        self.present(register, animated: false, completion: nil)
    }
    
    @objc fileprivate func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            self.handleLogin()
        } else {
            self.handleRegister()
        }
    }
    
}

// MARK: - API
extension LoginViewController {
    
    fileprivate func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            logD("error email and or password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                logD(error)
            } else {
                // login Success
                self.dismiss()
            }
            
            
        }
    }
    
    fileprivate func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        
        /// register UserName
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                logD(error)
            }
            guard let uid = user?.uid else {
                return
            }
            
            /// if register Success -> push ImageProfile
            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        logD(error)
                        return
                    }
                    
                    /// if push ImageProfileSuccess -> push to Database
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let value = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users").child(uid)
                        usersReference.updateChildValues(value, withCompletionBlock: { (error, dbref) in
                            if error != nil {
                                logD(error)
                                return
                            }
                        })
                    }
                })
            }
        }
    }
}


// MARK: - Constraint UI
extension LoginViewController {
    
    
    fileprivate func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(separatorView2)
        inputsContainerView.addSubview(passwordTextField)
        
        // naneTextField Constraint
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 0).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //separatorView1
        separatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView1.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        separatorView1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField Constraint
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 0).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //separatorView2
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView2.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        separatorView2.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // passwordTextField Constraint
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 0).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    fileprivate func setupRegisterBtn() {
        registerBtn.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        registerBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    fileprivate func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
    }
    
    fileprivate func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}

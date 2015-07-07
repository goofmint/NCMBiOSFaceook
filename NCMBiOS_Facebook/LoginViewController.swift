//
//  LoginViewController.swift
//  NCMBiOS_Facebook
//
//  Created by naokits on 7/5/15.
//  Copyright (c) 2015 Naoki Tsutsui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // ------------------------------------------------------------------------
    // MARK: Actions
    // ------------------------------------------------------------------------

    @IBAction func tappedLoginButton(sender: AnyObject) {
        NCMBFacebookUtils.logInWithReadPermission(["email"], block: { (user: NCMBUser!, error: NSError!) -> Void in
            if error == nil {
                println("会員登録後の処理")
                // ACLを本人のみに設定
                let acl = NCMBACL(user: NCMBUser.currentUser())
                user.ACL = acl
                user.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
                    if error == nil {
                        println("ACLの保存成功")
                    } else {
                        println("ACL設定の保存失敗: \(error)")
                    }
                    // 手動でセグエを実行
                    self.performSegueWithIdentifier("unwindFromLogin", sender: self)
                })
            } else {
                if error.code == NCMBErrorFacebookLoginCancelled {
                    println("Facebookのログインがキャンセルされました: \(error)")
                } else {
                    println("キャンセル以外のエラー: \(error)")
                }
            }
        })
    }
}

//
//  chatViewController.swift
//  Mazad
//
//  Created by amr sobhy on 5/7/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Alamofire
import MBProgressHUD
import IQKeyboardManagerSwift
import Firebase
import AVFoundation
import AVKit
import MobileCoreServices

class chatViewController: JSQMessagesViewController,UINavigationControllerDelegate {
    var refreshControl = UIRefreshControl()
    var msgDate = [String]()
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    var outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    var messages = [JSQMessage]()
    
    
    let rec = SKRecordView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-100 , width: UIScreen.main.bounds.width , height: 100))
    let sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var otherId = "8"
    var chat_id = ""
    var requestID = ""
    var otherName = ""
    
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        getMsgs()
        ref = Database.database().reference()
        self.setupChatToolBar()
        automaticallyScrollsToMostRecentMessage = true
        reloadMessagesView()
        refreshControl.attributedTitle = NSAttributedString(string: "اسحب للتحديث")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
    }
    func newMessage(_ notification: NSNotification) {
        print()
        self.getMsgs(withLoading: false)
        
    }
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension chatViewController:UITextFieldDelegate{
    
    func setup() {
        self.senderId = userData["shopname"] as? String ?? ""
        self.senderDisplayName = userData["shopname"] as? String ?? ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    func setupChatToolBar()  {
        //    self.inputToolbar.contentView.rightBarButtonItemWidth = 90
        self.inputToolbar.contentView.rightBarButtonItemWidth = 90
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero;
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero;
        
        sendButton.setImage(UIImage(named:"send-icon.png"), for: UIControl.State())
        self.inputToolbar.contentView.rightBarButtonItem.isHidden = true
        self.inputToolbar.contentView.rightBarButtonContainerView.addSubview(sendButton)
        rec.delegate = self
        self.inputToolbar.contentView.rightBarButtonContainerView.superview?.addSubview(rec)
        self.inputToolbar.contentView.rightBarButtonContainerView.superview?.bringSubviewToFront(sendButton)
        
        let vConsts = NSLayoutConstraint(item:self.rec , attribute: .bottom, relatedBy: .equal, toItem: self.inputToolbar.contentView.rightBarButtonContainerView.superview, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let hConsts = NSLayoutConstraint(item: self.rec, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10)
        
        let wSize = NSLayoutConstraint(item: self.rec, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let hSize = NSLayoutConstraint(item: self.rec, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        
        view.addConstraints([hConsts])
        view.addConstraints([vConsts])
        view.addConstraints([hSize])
        view.addConstraints([wSize])
        
        hSize.identifier = "hSize"
        wSize.identifier = "wSize"
        
        sendButton.addTarget(self, action: #selector(self.sendPressed), for: .touchUpInside)
        self.sendButton.isEnabled = true
        
    }
    
    @objc func textChanged(_ notification: Notification){
        if let hasText = notification.object as? NSNumber {
            if Bool(hasText) {
                self.sendButton.isEnabled = true
            }else{
                self.sendButton.isEnabled = false
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "textChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "newMessage"), object: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#394044")
        (IQKeyboardManager.shared).enableAutoToolbar = true
        (IQKeyboardManager.shared).enable = true
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        getMsgs(withLoading: true)
        // Code to refresh table view
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        print("check")
        NotificationCenter.default.addObserver(self, selector: #selector(chatViewController.textChanged(_:)), name:NSNotification.Name(rawValue: "textChanged"), object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        (IQKeyboardManager.shared).enableAutoToolbar = false
        (IQKeyboardManager.shared).enable = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func didPressAccessoryButton(_ sender: UIButton!) {
       
        
    }
    @objc func applicationDidBecomeActive() {
        
        print("what")
        // self.getMsgs(withLoading: false)
        // handle event
        
    }
    
    
}

extension chatViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("msgCountcollectionView\(self.messages.count)")
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    func collectionView(_ collectionView: JSQMessagesCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        // cell.textView!.textColor = UIColor.black
        var fontName = "DroidArabicKufi-Light";
        cell.textView.font = UIFont(name: fontName, size: 6)
        return cell
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        return 20.0
    }
    /*
     override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
     let message: JSQMessage = self.messages[indexPath.item]
     
     return JSQMessagesTimestampFormatter.sharedManager()Formatter().attributedTimestampForDate(message.date)
     }*/
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        if data.senderId == userData["shopname"] as? String ?? "" {
            return self.outgoingBubble
        }else{
            return   self.incomingBubble
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        self.inputToolbar.contentView.textView.resignFirstResponder()
        
    }
    @objc func sendPressed()  {
        if self.inputToolbar.contentView.textView.text.count > 0 {
            
            
            self.didPressSend(self.inputToolbar.contentView.rightBarButtonItem, withMessageText: self.inputToolbar.contentView.textView.text, senderId: self.senderId, senderDisplayName: self.senderDisplayName, date: Date())
            
            self.sendMsg(msg: messages[messages.count-1].text as AnyObject , type: "text")
            self.inputToolbar.contentView.textView.resignFirstResponder()
            self.inputToolbar.contentView.textView.text = ""
            
            
            
        }
    }
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        print("test")
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        // message?.messageStatus = "Sending"
        msgDate.append("منذ اقل من دقيقة")
        print("test")
        self.messages.append(message!)
        print("test")
        // self.finishSendingMessage()
        print("test")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
extension chatViewController{
    
    func sendMsg(msg:AnyObject, type:String,is_url:Bool?=false ,imageDate :UIImage? = nil, media : AnyObject? = nil) {
        var parameters:[String:Any] = [String:Any]()
        // MBProgressHUD.showAdded(to: self.view, animated: true)
        let messageID =   self.ref.childByAutoId().key
        parameters["messageId"] = messageID
        parameters["messageText"] = msg
        parameters["messageUser"] = userData["shopname"]
        parameters["messageUserId"] = userData["userID"]
        parameters["messageTime"] = [".sv": "timestamp"]
        parameters["messageUserImage"] = ""
        if type == "audio"{
            parameters["messageText"] = "Voice Message "
            // ref should be like this
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let imageName = self.ref.childByAutoId().key
            print(imageName)
            let metadata = StorageMetadata()
            metadata.contentType = "video/3gpp"
            let ref = Storage.storage().reference(withPath: "voice/\(imageName).3gb")
            let uploadTask =  ref.putData(msg as! Data, metadata: metadata,
                        completion: { (meta , error) in
                            
                            MBProgressHUD.showAdded(to: self.view, animated: true)
                            if error == nil {
                                // return url)
                                parameters["voice"] = "\((meta?.downloadURL()?.absoluteString)!)"
                               
                            } else {
                                 parameters["voice"] = ""
                            }
                            self.ref.child("chat").child(self.requestID).child(messageID).updateChildValues(parameters)
                            self.messages.remove(at: self.messages.count-1)
                            
                            self.collectionView.reloadData()
            } )
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                print(percentComplete)
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
 
        }else{
            self.ref.child("chat").child(self.requestID).child(messageID).updateChildValues(parameters)
            messages.remove(at: messages.count-1)
            
            // self.messages[self.messages.count-1].messageStatus = "Sent"
            self.collectionView.reloadData()
        }
        
       
        
        
        
        
        
    }
    
    func getMsgs (withLoading :Bool = true){
        print(requestID )
        ref = Database.database().reference()
        self.messages.removeAll()
        self.ref.child("chat").child(self.requestID).observe(.childAdded, with: {(snapshot) in
            
            if let check = snapshot.value as? [String:Any]{
                print(check)
                self.messages.append(self.parseMessage(msg: check as [String : AnyObject]))
                MBProgressHUD.hide(for: self.view, animated: true)
                self.collectionView.reloadData()
                self.automaticallyScrollsToMostRecentMessage = true
                print("msgCountApi\(self.messages.count)")
                self.finishReceivingMessage()
            }else{
                print("snapshot.value\(snapshot.value)")
            }
        })
        { (err) in
            self.view.makeToast("there is no requests")
        }
    }
    
    func parseMessage(msg:[String:AnyObject]) -> JSQMessage {
       
        var from = userData["shopname"]
        
        var senderName = userData["shopname"]
        
        
        
        if msg["messageUserId"] as? String ?? "" != userData["userID"] as? String ?? ""{
            senderName = otherName as AnyObject
            from = msg["messageUser"] as? String as AnyObject ?? "" as AnyObject
        }
        print(from)
        
       
        if let voice =  msg["voice"] as? String  {
            
            
            let fileMgr = FileManager.default
            
            let dirPaths = fileMgr.urls(for: .documentDirectory,
                                        in: .userDomainMask)
            
            let emptyFileURL = dirPaths[0].appendingPathComponent("sound.acc")
            
            
            let audioData = JSQAudioMediaItem(data: try? Data(contentsOf: emptyFileURL as URL))
            
            let message = JSQMessage(senderId: "\(from!)", senderDisplayName: otherName, date: Date(), media: audioData)
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                
                let fileMgr = FileManager.default
                
                let dirPaths = fileMgr.urls(for: .documentDirectory,
                                            in: .userDomainMask)
                
                let fileURL = dirPaths[0].appendingPathComponent("audio" +  "\(self.messages.count)" + ".caf")
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            let audioUrl = msg["msg"] as? String
            let url = voice
            
           
            do{
                Alamofire.download(url, to: destination).response { response in
                    print(response)
                    
                    if response.error == nil, let dataPath = response.destinationURL?.path {
                        
                        audioData.audioData = try? Data(contentsOf: NSURL(string:voice) as! URL)
                        self.collectionView.reloadData()
                        
                    }
                }
                
                return message!
            } catch{
                
            }
          
            
            
            
        } else  {
            if var msg_text = msg["messageText"] as? String {
                msgDate.append(msg["date"] as? String ?? "")
                print("msgtext\(msg_text)")
                
                let message = JSQMessage(senderId: "\(from!)"  , senderDisplayName: otherName, date: Date(), text: msg_text)
                print(message)
                if let seenFlg = msg["seen"] as? Bool{
                    if seenFlg == true{
                        //message?.messageStatus = "Read"
                    }else{
                        //  message?.messageStatus = "Delevered"
                    }
                }
                return message!
            } else{
                let message = JSQMessage(senderId: "\(from!)"  , senderDisplayName: otherName, date: Date(), text: (" " as? String)!)
                return message!
            }
        }
    }
    
    
}
extension chatViewController : SKRecordViewDelegate {
    
    func SKRecordViewDidCancelRecord(_ sender: SKRecordView, button: UIView) {
        sender.state = .none
        sender.setupRecordButton(UIImage(named: "mic.png")!)
        
        rec.recordButton.imageView?.stopAnimating()
        
        rec.layoutIfNeeded()
        print("Cancelled")
    }
    
    func SKRecordViewDidSelectRecord(_ sender: SKRecordView, button: UIView) {
        
        sender.state = .recording
        sender.setupRecordButton(UIImage(named: "rec-1.png")!)
        
        
        
        rec.recordButton.imageView?.startAnimating()
        
        print("Began " + UUID().uuidString)
        
    }
    
    func SKRecordViewDidStopRecord(_ sender : SKRecordView, button: UIView) {
        
        sender.state = .none
        sender.setupRecordButton(UIImage(named: "mic.png")!)
        
        let audioData = JSQAudioMediaItem(data: try? Data(contentsOf: rec.getFileURL() as URL))
        let message = JSQMessage(senderId: self.senderId, senderDisplayName: self.senderDisplayName, date: Date(), media: audioData)
        
        self.messages.append(message!)
        self.finishSendingMessage()
        rec.recordButton.imageView?.stopAnimating()
        rec.layoutIfNeeded()
        
        
        do{
            self.sendMsg(msg: try Data(contentsOf: rec.getFileURL() as URL) as AnyObject , type: "audio")
        }catch{
            
        }
        print("Done")
    }
    
    
    
}

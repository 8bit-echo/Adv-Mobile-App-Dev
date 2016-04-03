
import UIKit
import Firebase


class StudentListTableViewController: UITableViewController {
    
    var allStudents = [Student]()
    let ref = Firebase(url: "https://ctd-students.firebaseio.com")
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        ref.observeEventType(FEventType.Value, withBlock: {snapshot in self.allStudents = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for item in snapshots{
                    guard let studentName = item.value["name"] as? String,
                    let studentBackground = item.value["background"] as? String
                        else{
                            continue
                    }
                    let newStudent = Student(name: studentName, background: studentBackground)
                    self.allStudents.append(newStudent)
                }
            }
            self.tableView.reloadData()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allStudents.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

       let student = allStudents[indexPath.row]
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = student.background

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let student = allStudents[indexPath.row]
            
            let studentRef = ref.childByAppendingPath(student.name)
            studentRef.ref.removeValue()
            allStudents.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }   
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

import UIKit

import Parse



class Message: PFObject, PFSubclassing {
    
    
    
    @NSManaged var message: String
    
    
    
    class func parseClassName() -> String {
        
        return "Message"
        
    }
    
    
    
}

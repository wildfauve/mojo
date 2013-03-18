module Exceptions
  
  class Standard < StandardError 
    attr :errorcode
    
    def intialize
      @errorcode = 1000
    end
  
  end
  
  class InvalidProfileConfidence < Standard
    
    def initialize
      @errorcode = 1001
    end
    
    def message
      "Invalid Profile Confidence on Suspect Profile"
    end
  end
  
  class InvalidSuspectAttr < Standard
    def message
      "Some or All Suspect Attributes are not part of the Member Model"
    end
  end

  class SuspectAttrNotPresent < Standard
    def message
      "The Suspect Attributes must be present"
    end
  end
  
  class SuspectProfileCantBeHigh < Standard
    def message
      "The Suspect Attributes are present, but the confidence is set to High"
    end
  end
  
end
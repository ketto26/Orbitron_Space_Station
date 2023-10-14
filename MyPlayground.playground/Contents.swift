import Foundation


/*
                    -- 4 --
 */

class StationModule {
    var moduleName: String
    var drone: Drone? = nil
    
    init(moduleName: String) {
        self.moduleName = moduleName
    }
    
    func giveTask() -> String {
        return "Drone has given task"
    }
}


/*
                    -- 1 --
 */

class ControlCenter: StationModule {
    var isLockedDown: Bool = false
    private let securityCode: String = "IloveStitchVeryMuch"

    init(isLockedDown: Bool, moduleName: String) {
        self.isLockedDown = isLockedDown
        super.init(moduleName: moduleName)
    }
    
    func lockDown(passcode: String) {
        if passcode == self.securityCode {
            self.isLockedDown = true
        }
    }
    
    func lockedDownInfo() {
        print("Control center is locked down: \(self.isLockedDown)")
    }
}


/*
                    -- 2 --
 */

class ResearchLab: StationModule {
    var labSamples : [String] = []
    
    init(labSamples : [String], moduleName: String) {
        self.labSamples = labSamples
        super.init(moduleName: moduleName)
    }
    
    func addSamples(sample: String){
        self.labSamples.append(sample)
    }
}


/*
                    -- 3 --
 */

class LifeSupportSystem: StationModule {
    var oxygenLevel: Int
    
    init(oxygenLevel: Int, moduleName: String) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: moduleName)
    }
    
    func oxygenInfo() {
        print("Oxygen level: \(oxygenLevel)")
    }
}





//                -- 8 --

class MissionControl {
    var spaceStation: OrbitronSpaceStation? = nil
    
    init(spaceStation: OrbitronSpaceStation?) {
        self.spaceStation = spaceStation
    }
    
    func connect() {
        if self.spaceStation != nil {
            print("Connection established")
        }
    }
    
    func requestControlCenterStatus() {
        self.spaceStation?.controlCenter.lockedDownInfo()
    }
    
    func requestOxygenStatus() {
        self.spaceStation?.lifeSupportSystem.oxygenInfo()
    }
    
    func requestDroneStatus(module: ControlCenter) {
        print(module.drone?.taskInfo() ?? "Missing drone" )
    }
}





/*
                    -- 6 --
 */

class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl? = nil
    
    init(assignedModule: StationModule) {
        self.assignedModule = assignedModule
    }
    
    func taskInfo() {
        if self.task != nil {
            print("\(task!)")
        } else {
            print("Drone doesn't have any task!")
        }
    }
}


/*
                    -- 7 --
 */

class OrbitronSpaceStation {
    var controlCenter = ControlCenter(isLockedDown: false, moduleName: "Steatch")
    var reasearchLab = ResearchLab(labSamples: ["Sample 1", "Sample 2"], moduleName: "Lola")
    var lifeSupportSystem = LifeSupportSystem(oxygenLevel: 26, moduleName: "Mario Chimaro")
    
    init(controlCenter: ControlCenter, reasearchLab: ResearchLab, lifeSupportSystem: LifeSupportSystem) {
        self.controlCenter = controlCenter
        self.reasearchLab = reasearchLab
        self.lifeSupportSystem = lifeSupportSystem
    }
    
    func lockDown(passWord: String) {
         self.controlCenter.lockDown(passcode: passWord)
    }
}





let orbitSpaceStation = OrbitronSpaceStation(controlCenter: ControlCenter(isLockedDown: false, moduleName: "Steatch"), reasearchLab: ResearchLab(labSamples: ["Sample 1", "Sample 2"], moduleName: "Lola"), lifeSupportSystem: LifeSupportSystem(oxygenLevel: 26, moduleName: "Mario Chimaro"))

let drone1 = Drone(assignedModule: orbitSpaceStation.controlCenter)
let drone2 = Drone(assignedModule: orbitSpaceStation.lifeSupportSystem)
let drone3 = Drone(assignedModule: orbitSpaceStation.reasearchLab)


let missionControl = MissionControl(spaceStation: orbitSpaceStation)

missionControl.connect()

print(String(repeating: "-", count: 99))

missionControl.requestControlCenterStatus()

print(String(repeating: "-", count: 99))

drone1.task = "Go destroy Humanity"
drone2.task = "Drain out life from humans!"
drone3.task = "Find Jimena❤️"
 
drone1.taskInfo()
drone2.taskInfo()
drone3.taskInfo()

print(String(repeating: "-", count: 99))

orbitSpaceStation.lifeSupportSystem.oxygenInfo()

print(String(repeating: "-", count: 99))

orbitSpaceStation.controlCenter.lockDown(passcode: "IloveStitchVeryMuch")

orbitSpaceStation.controlCenter.lockedDownInfo()
 
print(String(repeating: "-", count: 99))



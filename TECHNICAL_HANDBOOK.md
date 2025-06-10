# European Rover Challenge 2025 - Remote formula - Technical Handbook

Intention od this document is to provide:
- details about the setup used for the Competition
- requirements for a successful participation in the Competition
- suggestions of the best practices for the Competition

## Wording

RFC 2119 keywords are used in this document. Whenever they are used, they are capitalized.

As a rule of thumb:
- the words MUST, MUST NOT and MAY (and their aliases) are to be considered extra rules that are not explicitly stated in the Rulebook - they are used to clarify the requirements here.
- the words SHOULD and SHOULD NOT (and their aliases) are suggestions about the best practices and proposed  solutions. They may or may not be a part of a scoring system, so it's best to address them somehow - either by implementing them or having an explanation why not. Keep in mind that these suggestions are usually not an exhaustive description of the required work.

Definitions and terms from the [Rulebook](RULES.md) apply to this document too.

If unspecified all dimensions are in millimeters (mm) and all angles in degrees (°). Dimensions in square brackets are optional and in inches (in).

## Common parts

### Marsyard

![Marsyard](assets/marsyard_photo_1.jpg)

Marsyard - the area where the Competition takes place. It is a large, outdoor area with various obstacles on the ground and some infrastructure elements. For the Finals - it'll have the exact same configuration as the one used for the On-site formula. For the Competition Demo - it may be using it's configuration for this year or the one from last year On-site formula (or anything in between).

> [!NOTE]
> Keep in mind that all the photos and diagrams of the Marsyard used in this document are based on the last year's configuration and may not represent the actual configuration used during the Competition. We do not expect any groundbreaking changes, but some minor ones may happen. This is why Competitors SHOULD NOT rely on the exact configuration of the Marsyard.

Competitors MAY use any publicly available materials to get familiar with the Marsyard, including any files published for the on-site formula of the Competition.

> [!TIP]
> Simulation model for the Marsyard has not yet been made. We do encourage the Contestants to make their own models, i.e. based on the [last year's configuration](https://drive.google.com/drive/folders/1kvJ4vRcukgJdDpJXkft8xSptM3QwUmzl). Publishing a usable (this i.e. means decimated to a reasonable amount of polygons) model of the Marsyard on the Community Forum may be granted some extra points ;-)

### Robot setup

![Husarion's robots](assets/husarion_robot_comparison.png)

The Operator will be setting up robots for the Competition. The exact setup will vary depending on the particular robot's and challenge's requirements. This year available platforms will be [Husarion Panther](https://husarion.com/manuals/panther/overview/) (for the first Challenge) and [Husarion Lynx](https://husarion.com/manuals/lynx/overview/) (for the second challenge).

Contestants will be given a ROS 2 interface to the robots via [**eProsima's Fast DDS**](https://fast-dds.docs.eprosima.com/en/latest/).

For the dynamic node discovery [Discovery Server](https://fast-dds.docs.eprosima.com/en/latest/fastdds/discovery/discovery_server.html#discovery-server) will be used. For the exact use with Husarnet, please see the [documentation](https://husarnet.com/docs/ros2/ros-discovery-server-env/). Discovery Server will be provided by the Operator and Competitors MUST use it in their workflows.

Competitors will NOT be given any more direct access to the robot's internals, including SSH access. Depending on the task, robot's ROS 2 interface may be composed of nodes from two different machines - named User Computer and Built-in Computer in the respective robots' manuals. Those computers will be exposed to the Competitors as separate Husarnet Devices ("Elements" in a current Husarnet Dashboard naming scheme). Competitors SHOULD plan for those machines in their account's quota.

Simulation models for the robots used during the Competition can be found [here](https://github.com/husarion/husarion_ugv_ros/tree/ros2-devel/husarion_ugv_description) and for some of their extra equipment [here](https://github.com/husarion/husarion_components_description). Competitors SHOULD use simulations to prepare for the Competition.

> [!WARNING]
> There may be a running [rosbag](http://wiki.ros.org/rosbag) setup in the infrastructure operated by the Judges. It's intention is to prevent any kind of cheating during the Competition. Competitors SHOULD be aware of such setup and MUST NOT try to circumvent it. Competitors MUST be aware that such logs (and any other kind of logs) may both be used by the Judges to score the Competition and be published (both during and after the Competition) for anyone to validate the results. If published, such logs/recordings MAY be used by the Competitors in the following years to prepare for the Competition.

<!-- TODO Add a note about the Judge's control override mechanism here -->

### Husarnet

![Husarnet - Peer to Peer VPN](assets/husarnet_diagram_p2p.png)

[Husarnet](https://husarnet.com) - VPN network solution created and operated by Husarion (the Operator). It will be used to connect to the infrastructure during the whole competition.

All parts of infrastructure provided by the Operator will be using Operator's Husarnet account and counting towards that account's quota. These pieces of infrastructure will be tied together into Husarnet Groups and, during the Competition, Competitors will be invited to (and removed from) required Groups.

Some proficiency with Husarnet will be helpful during the Competition. Connectivity Test is the first part of the Competition testing these skills and Competitors MUST be able to connect to the provided infrastructure and SHOULD be able to complete basic tasks in Husarnet.

> [!WARNING]
> Competitors SHOULD test their Husarnet setup before the Competition. They MAY use any infrastructure that's available to them to do so. The especially tricky part may be any firewalls or NATs that are implemented in the Competitor's computers or on the network they are using. We do not encourage any insecure practices, and, in case of any issues, Competitors SHOULD use their best judgement and organization policies to resolve them.

Competitors MAY use any number of machines to provide their part of the infrastructure. In case the provided free account quota is exceeded - Competitors MUST contact the Operator to get more free quota assigned. Competitors MUST NOT pay for any Husarnet services for the purposes of the Competition. In case Competitors are using Husarnet for any other purposes, they SHOULD NOT use the same account for the Competition.

> [!TIP]
> Both the available Internet connection and Husarnet may limit the Competitor's ability to transmit large amounts of data via the Internet - i.e lidar/uncompressed camera data in full resolution, etc. Competitors MUST be aware of those limitations and SHOULD test and plan accordingly.

### On-site computing

There will be On-site computing infrastructure available to the Competitors during the Competition. The intention of this infrastructure is to provide a way of running any data-heavy workloads that may be required during the Competition, especially for the Challenges.

There will be 5 physical machines, running a hypervisor with multiple virtual machines. Each Team will be assigned a single virtual machine with a fair share of the host's resources (CPU, RAM, disk and networking). This compute will be unavailable during the Connectivity Test, but it will be available during the Payload Test and so on. Disk space will be limited to roughly 128GB per Team. CPU will be `Core i7 1360P` (we will start with a single P-core per Team and increase to two and three for the following events). RAM will be 32GB (and we will start with 8GB per Team and increase to 16GB and 24GB for the following events). Networking will be limited to 1Gbps, with a fair share of the host's resources. We do **not** expect any high-performance GPU access to be available during the Competition.

Contents of those Virtual Machines will be up to a Team to decide and will not be reset between the Challenges. Virtual Machines may be deleted by the Operator after not qualifying for the next Challenge.

Competitors MUST NOT rely on any specific tools being present and SHOULD be prepared to use their own tools.

> [!IMPORTANT]
> Competitors will not only have a Husarnet access to the machine and the rest of the infrastructure, but there will also be available a direct, IPv4 link between the On-site computing node and any nodes on the Robots themself. Intention here is to enable a reasonable way of running unoptimized/compute-heavy workloads even if the networking solutions between the Robot and the Competitors are not advantageous.

Competitors MAY be using multiple machines on their side during the Competition.

## Team proposal

Team proposal does not have any technical requirements on top of the ones specified in the Rulebook.

## Test drives

### Connectivity Test

> [!NOTE]
> Connectivity Test will NOT be held on the Marsyard.
>
> During this Test robots may not be fully equipped with all the sensors and tools that will be available during the Competition Finals. Competitors MUST NOT rely on any specific sensors being present for this Test drive.

User manual for basic tasks in Husarnet can be found [here](https://husarnet.com/docs). Teams MAY be using any other materials to get familiar with the Husarnet.

Exact addresses to connect to/ping will be provided during the Test by the Judges.

WebUI will be a pre-made and pre-configured by the Operator [Foxglove](https://foxglove.dev/ros) interface. The exact address/URL will be provided during the Test by the Judges. Teams will be assigned any available robot at the Judges' discretion.

ROS connectivity can happen via any ROS 2 compatible tool available to the Competitor - conforming to the mechanisms described in the [Robot setup](#Robot_setup) chapter above. Competitors SHOULD use any documentation available on [Husarion's website](https://husarion.com) and [Husarion's Github repository](https://github.com/husarion) to obtain the necessary information for such setup. Competitors MAY use any other applicable materials to get familiar with the Husarion's robots and ROS environment.

The exact ROS topics, whenever not already specified in the documentation, will be provided by the Judges during the Test. As those topics may depend on the robots used during the Test, Competitors SHOULD NOT rely on any specific topics being present and SHOULD be prepared to change used names in moment's notice.

> [!TIP]
> This Test is meant to be a simple task of showing up, proving that you have the basics covered and that's it. Please do not take the preparation lightly though - we do **not** expect any second takes on different dates and so on. This is the reliability-testing part.

### Payload Test

> [!NOTE]
> Payload Test will NOT be held on the Marsyard.
>
> Robots will be in configurations used in the Finals. ROS interface is intended to be the same as the one used during the Competition Finals, however Competitors are encouraged to provide feedback on the provided interfaces and if so MUST provide it as soon as possible to the Operator, as it may change the interface used in the following stages of the Competition.

There will be some Accessories (meaning items not attached to the robots but available in the environment) available for the Test, however they may not be the same as the ones used during the Competition Finals. Competitors SHOULD NOT rely on any specific Accessories being present for this Test drive. Detailed descriptions of the Final Accessories will be provided in later sections of this document.

> [!TIP]
> Guideline here would be to join the test with a short, clear plan as there won't be much time for figuring stuff out live. Payload test can result in some sort of a failure too (it's a test in the end) and scoring will be based on the completeness of the execution of the plan, not by the success like the actual Challenges.
>
> Recording of the data for further development can happen i.e. while doing any other parts of the Test drive - i.e. while presenting current developments to Judges, while doing a subsystem test, or even simply taking all the time left after other activities. Again - competitors MAY be using multiple machines and people for any of the tasks.
>
> TLDR - we want you to come with a clear plan proving that you're focused on the goal,  and leave with some useful data for the further development.

### Challenge Test

> [!NOTE]
> Challenge Test - may or may not be held on the Marsyard. Configuration of the Marsyard may or may not be the same as in Finals.
>
> Robots will be in configurations used in the Finals.
>
> Accessories will be the same as the ones used during the Competition Finals.

This whole Test may be streamed live or recorded and then published. Competitors MUST be aware of that and SHOULD prepare for such situation. Competitors MAY use such data for the further development. - goal of such recording is to give the Contestants as much data about the Challenges and scoring as possible.

> [!TIP]
> It's intended to mock the Finals as closely as possible and Competitors SHOULD treat it as such. Competitors MAY ask questions about the details of scoring but SHOULD NOT expect the full answers to those questions (as the exact scoring will be partially based on the performance of the other Competitors). Competitors MAY test different approaches to the tasks and ask Judges for feedback on those approaches.

## Challenge 1 - Exploration Task

![Challenge 1 diagram](assets/challenge1_diagram_1.png)

### Operation

Intention here is to create a setup where the robot autonomously navigates through the Marsyard and returns to the starting point after mapping the whole available area. Throughout the Marsyard there will be multiple Landmarks meant to be found and documented by the robot. Marsyard will be surrounded by a series of Markers that are meant to limit the area available for the autonomous operation.

> [!IMPORTANT]
> Competitors MAY choose to provide a less autonomous solution at any level, including full manual control. Manual control MAY be realized by implementing a custom ROS 2 interface or using the provided WebUI. WebUI is the least desired solution and will be scored accordingly.

WebUI will be disabled by default, and the Competitors wanting to use it  MUST ask the Judges to enable it.

Some parts of the Marsyard will be **unreachable to the robot** (especially autonomously) - because of the steep terrain. Unreachable areas inside the outer perimeter will **not** be guarded by the Markers. Competitors MUST be aware of such parts and any attempts of reaching such areas MUST be limited (i.e. by the number of attempts, time spent, etc.). Safety measures SHOULD be described to the Judges at the beginning of the Challenge and their states MUST be communicated live to the Judges during any risky manoeuvres. This includes both encouraging and discouraging the Judges from triggering any overrides based on the Team's confidence in any given situation.

> [!TIP]
> All Landmarks meant to be found will be visible from the ground level, so it'd make sense to i.e. incorporate other sensors available (like the built into the base platform IMU) and limit the allowed angles of the robot's movement based on the data from those sensors. This data can be later integrated to i.e. the cost-map used for the navigation - to prevent it from wasting time trying to climb hills.
>
> IMU may also be used for detecting things like - being stuck on rocks, etc. Such cases, when handled properly (i.e. by notifying the Contestants/Judges about the situation) MAY be scored positively in categories like Technical Excellence.

### The robot

<!--![Panther base photo](assets/panther_base_photo_1.jpg)-->
![Panther base](assets/panther_base_render_1.png)
![Panther technical drawing](assets/panther_base_drawing_1.png)

> [!NOTE]
> Have in mind that the images above are showing only the base of the used robot. Additional equipment will be mounted on op of it during the Competition. Those pictures may later be updated to show the actual configurations used during the Competition.
<!-- TODO PIC Panther modded diagrams -->

Robot configuration available to the Competitors:

- [Husarion Panther](https://husarion.com/manuals/panther/overview/) - the base platform with extended battery
- 4x [CAM06](https://husarion.com/manuals/panther/panther-options/#cam06--stereolabs-zed-x) - [Stereolabs ZED X](https://www.stereolabs.com/en-pl/products/zed-x) camera - each of them looking in a different direction, providing both video and point cloud data from the robot's surroundings

On top of that some extra items will be added for other purposes:
- Some sort of safety-basket for sensors - the exact shape is undetermined at this point as we're aiming for one that does not obstruct the cameras' view while also minimizing the risk of damaging them upon collision
- [PAD02](https://husarion.com/manuals/panther/panther-options/#pad02---radiomaster-tx16s) - RadioMaster TX16S - to be used by Judges to manually control the robots in between Contestants and on their request. There will be some control override mechanism to suit that need and Competitors MUST adhere to any technical requirements it imposes. Exact control override mechanism will be provided later.

### Markers

![Marker](assets/marker_render_1.png)
![Marker technical drawing](assets/marker_diagram_1.png)

Near the boundaries of the Marsyard there will be a series of Markers placed. The role of those Markers is two-fold - first to provide clear features for visual systems and also to provide a way of limiting the area available for the autonomous operation.

The number of markers will be between 10 and 50.

These Markers will have a high-contrast (black and white) digital tags on them (think QR/ArUco). Each of the tags will have a number as it's content. The tag right behind the robot in it's starting position will contain the highest available number. From the robot's perspective the numbers will be getting lower by 1 per tag in the clockwise direction - meaning that the tag behind the robot, on the right side will be `0`, and on the left, `n-1`. Contestants MAY or MAY NOT use this information in their algorithms.

The Markers won't be placed right at the physical boundary of the Marsyard, but rather some distance from it, on the inner side. The intention for that is to provide some lee-way for the robots, Contestants and the Judges when it comes to the safety behaviour. This way - the robots SHOULD NOT the virtual wall between any two Markers with consecutive numbers (soft-limit) but such position will still be within the area that they MUST NOT leave (hard-limit).

> [!NOTE]
> Some of the Markers will be placed in spots unreachable to the robots, especially operating autonomously. The algorithms provided by the Contestants MUST be aware of it and MUST NOT try to reach any fixed distance from the Markers.
>
> Markers will NOT be placed at the same height relative to the starting orientation of the robot - some of them will be placed on the hills surrounding the Marsyard. Competitors MUST take this into account when planning their algorithms.

Contestant MAY use the Markers in the maps created as a result of the Challenge. Contestants MAY present the Judges with any internally generated figures (like the geometric figure created by the Markers found during the Challenge) as a part of the Technical Excellence rating.

### Landmarks

Landmarks are the main items to be found during the Challenge. Landmarks will represent a couple of categories (like tools, infrastructure, items out of place, etc.) - Competitors MAY choose not to name the categories in their reports but SHOULD be aware that there will be Landmarks not typical to the Mars environment present during the Challenge, and they SHOULD note that in their reports in the descriptions of the respective items.

> [!IMPORTANT]
> Landmarks will be placed in the Marsyard in a way that they are visible to the robot operating from the ground level. Due to the viewing angles available the backgrounds will vary - from the Marsyard's surface to the sky. Competitors SHOULD plan for both cases (i.e. by using contours as an additional method of recognition).

Geological features MAY be included in the Landmarks by the Competitors however this is NOT the main goal for this Challenge. Landmarks added on top of the ones prepared for the On-site competition will be rather physical object oriented and NOT a soil or a rock.

> [!TIP]
> We will NOT be targeting only items from any popular object detection libraries. Some of them will certainly fit into such categories, but some of them will be less obvious and MAY require some additional processing to be recognized.
>
> The distinction we're aiming for is choose items vastly different from the ground and rocks already available on the Marsyard. We will be targeting the items that are on the large side (both in general and in terms of any given item), possibly with colors that are very distinct from the ground.
>
> Publishing a set of URDFs for proposed items on the Community Forum may get you some Community Excellence points ;-)

### Structure of the resulting data

Resulting file should be a PDF report that first outlines the general findings and then goes into details about each of the Landmarks found. For any data volume suggestions we're assuming page size of A4 and a font readable after printing on a regular household printer. Template for such report will NOT be provided, however the Contestants MAY use the Community Forum to validate their intermediate results.

The general findings section SHOULD include a map of the Marsyard with the path taken by the robot and the Landmarks (possibly Markers) found. In case of a map there MAY be some sort of a coordinate system specified. Any other data (like an LLM summary of the drive) MAY be included provided that it's value can be clearly understood by the reader. This section is expected to be at most a single page long.

Each of the Landmarks found SHOULD be presented on a separate **single** page. Descriptions of the Landmarks SHOULD contain:
- a photo of the Landmark
- a textual description of the Landmark
- the location of the Landmark (ideally with a map with a point on it and NOT a plain numerical GPS location)
- any other data that the Competitors find justified

Textual description of a Landmark SHOULD contain not only a vague description of an item but also a clear section of it's relation to the environment it was found in (i.e. whether the presence of such item on Mars is probable, whether it may be useful in the following steps of the mission, etc.).

> [!NOTE]
> Such reports do not need to be automatically sent to the Judges - that part of the Challenge is to be completely manual. The exact method of sending such reports will be provided during the Challenge (expect a Google Drive or an e-mail).

> [!TIP]
> We're only aiming for the structured PDF reports because of the ease of scoring. We will not be judging any intermediate steps of the data processing, as long as they are not affecting the final results. Competitors MAY use any tools available to them to create such reports, including any tools that are not ROS 2 based - i.e. one can simply add a "Take snapshot" button to the control panel, that will save all the camera images, locations, etc to a directory and then use any other data processing pipeline for analysis and creation of final report. TLDR - staring in the ROS world does not mean that you have to limit yourself to it.

## Challenge 2 - Infrastructure

![Challenge 2 diagram](assets/challenge2_diagram_1.png)

> [!IMPORTANT]
> Keep in mind that the diagram above does **not** represent the actual hazard locations that will be used during the Challenge. It's only a sample configuration to show the principle of operation.

This Challenge is designed to be a series of "mini games" and should be treated as such - meaning - you can have many attempts at any given sub-task, but the goal is to finish all of them in a provided time slot.

Keep in mind that this Challenge and most of it's features are designed to be driven around and operated manually. The challenge here is to create **aids** for such manual operation - like the Airlock software that does need clicking around but reacts to the presence of a robot in close proximity - and **not** to replace the need for a human controller altogether.

### The robot

![Lynx base](assets/lynx_render_1.png)
![Lynx technical drawing](assets/lynx_drawing_1.png)

Robot configuration available to the Competitors:

- [Husarion Lynx](https://husarion.com/manuals/lynx/overview/)
  - ignore the built-in camera part. It's location will most likely not be suitable for some of the tasks
- [Luxonis OAK-1 camera](https://shop.luxonis.com/products/oak-1) - front facing camera
- RTK GPS like [U-blox EVK-F9P-01](https://www.u-blox.com/en/product/evk-f9p) or similar
- UWB (Ultra Wide Band) module - used for "detection" of dangerous areas and only exposed as a single ROS 2 topic

On top of that some extra items will be added for other purposes:
- Some sort of safety-basket for sensors - the exact shape is undetermined at this point as we're aiming for one that does not obstruct the cameras' view while also minimizing the risk of damaging them upon collision
- [PAD02](https://husarion.com/manuals/panther/panther-options/#pad02---radiomaster-tx16s) - RadioMaster TX16S - to be used by Judges to manually control the robots in between Contestants and also on their request. There will be some control override mechanism to suit that need and Competitors MUST adhere to any technical requirements it imposes. Exact control override mechanism will be provided later.

### The microcontrollers

For some of the tasks Competitors will be expected to write firmware for microcontrollers. This year we've chosen ESP32 as the base platform for such tasks. In all such cases the platform for the Contestants will be [Olimex ESP32-POE](https://www.olimex.com/Products/IoT/ESP32/ESP32-POE/open-source-hardware). (Keep in mind that there also exists a [ESP32-POE-ISO](https://www.olimex.com/Products/IoT/ESP32/ESP32-POE-ISO/open-source-hardware) version that may be much safer for development.)

Such hardware platform was chosen partially because of Husarnet - the VPN platform used for connectivity to the robots - as right now the only microcontroller family supported is ESP32. Despite that tasks are designed in a way that such feature is not required for the successful completion of any of them - it's just an option to use if one wants to.

> [!TIP]
> Even tough this is a remote competition we do encourage to source some hardware (not necessarily the same board, but anything with the right microcontroller) and building some sort of local test bed for the development. As most of you probably won't have access to our robots locally - those test beds do not need to be huge contraptions *actually* doing i.e. the airlock duties - they can be simple boards, with switches, buttons, LEDs, etc - that will allow you to test the firmware locally.
>
> Obviously using a fully software based tests is also encouraged - as this is one of the best industry practices - but having a hardware test bed is a solution that's more familiar to more people and may provide an easier learning curve.

**Firmware flashing** - will be done by the Judges, before each of the attempts. Such operation will include a full wipe of the microcontroller's memory, so Competitors MUST NOT save any intermediate data there. Competitors MAY provide multiple firmware versions for the same task and MAY ask the Judges to flash a different version in between the attempts. This is mostly to allow Competitors to test various approaches to the same task - i.e. some may be more reliable but some may be aiming towards higher scores (i.e. different levels of autonomy).

Firmware files MUST be provided in a form of a single binary file (`.bin`) and MUST be sent to the Judges before the Challenge starts (means for doing that will be described before each task requiring them). Sending extra variants during the competition MAY be possible but Competitors MUST NOT rely on such possibility.

Firmware will be written with a procedure similar to:
```
esptool.py erase-flash
esptool.py write-flash 0x1000 team_name_airlock_variant_1.bin
```

Competitors will most likely not have any sort of access to the execution logs (i.e. serial data) during the competition, so if any feedback from the software is desired it MUST be realized by other means available in the specific task.

For all of the tasks IO MUST be configured as follows:
- outputs: push-pull mode
- inputs: no pull-up/pull-down, floating input (proper pull-ups will be populated externally)
- serial: 115200 baud rate, 8 data bits, 1 stop bit, no parity, no flow control

> [!NOTE]
> The exact pinouts will be provided later so in case you're making any sort of physical model - please make it somewhat flexible in that matter.
<!--
TODO Pinouts for all configurations

| IO name   | Direction     | Description/role          |
| --------- | ------------- | ------------------------- |
| +5V       | To the board  | Power supply to the board |
| +3.3V     | Not connected |                           |
| GND       | To the board  | Power supply to the board |
| ESP_EN    | Not connected |                           |
| GPIO0     |               |                           |
| GPIO1     |               |                           |
| GPIO2     |               |                           |
| GPIO3     |               |                           |
| GPIO4     |               |                           |
| GPIO5     |               |                           |
| GPIO39    |               |                           |
| GPIO36    |               |                           |
| GPIO35    |               |                           |
| GPIO34    |               |                           |
| GPIO33    |               |                           |
| GPIO32    |               |                           |
| GPIO16    |               |                           |
| GPIO15    |               |                           |
| GPIO14    |               |                           |
| GPIO13    |               |                           |
| USB-UART1 | Bidirectional |                           |
| Ethernet  | Bidirectional |                           |
-->

### Sub-task 1 - Airlock

![Airlock diagram](assets/airlock_diagram_front.png)
![Airlock diagram isometric](assets/airlock_diagram_isometric.png)
![Airlock top down view](assets/airlock_diagram_top_down.png)

Airlock will consist of three zones divided by two gates. The task here is to provide a firmware for a functional airlock - meaning that the robot will be able to pass through it - in both directions, without ever opening both gates at the same time.

Each of the zones will have a presence sensor - allowing the Airlock to operate autonomously if chosen by the Contestants. The presence sensors will be placed in a way that they will be triggered by the robot's presence in the zone, but not by the robot's presence in the neighbouring zone. Signals from those sensors will be provided to the Competitor's microcontroller as lines `PRESENCE_FRONT`, `PRESENCE_MIDDLE` and `PRESENCE_BACK`.

> [!IMPORTANT]
> Airlock's firmware SHOULD handle cases like objects approaching from both sides. In such cases the Airlock MAY i.e. choose to prioritize one direction over the other, or MAY choose to stop operating until conditions are more straightforward. The exact behaviour SHOULD be described to the Judges right after flashing a new firmware.

Both gates will have their own sensors preventing them from operation if there's any object in their close proximity - meaning **not only right in the middle of the gate, but also dangerously close to it**. Any attempt of operating the gate while those sensors are triggered will result in a failure of the task. Signals from those sensors will be provided to the Competitor's microcontroller as lines `GATE_SAFETY_A` and `GATE_SAFETY_B`. High state means occupied.

> [!TIP]
> Overall sizing of the Airlock and it's components will be large enough to comfortably operate the robot. There will be no need to squeeze the robot through the gates or drive right to any of them. The priority here is safety.

Gates are designed to open *rather quickly* - think roughly 1-5 seconds. The exact time should not matter as the Competitor's microcontroller will be provided with enough signals to infer the current state of the gates.

> [!NOTE]
> This is the task where it'd make some sense to use Husarnet on the microcontroller (although fully autonomous operation is a more favorable option). If you choose to do so - the Internet connection will be provided via an Ethernet cable. Such cable will be disconnected by default and Competitors MUST ask the Judges to connect it if needed. Husarnet Join code MUST be baked into the firmware and Competitors MUST be aware that the identity of the microcontroller will be wiped between the attempts - which will change the microcontroller's Husarnet IP address.

> [!IMPORTANT]
> Between the actual motor controller and the Competitor's microcontroller there will be a Jury board. It's role will be to forward any valid commands as-is and block any commands that'd the physical safety of both the equipment and the people around. This means that dangerous actions requested by the firmware may not be reflected in a physical world - but they will be taken into account during scoring. Jury will have logs of any requests made by the firmware and may choose to share them with Teams in case of any disputes.

Gate operation and feedback fill be realized by the two lines - `GATE_REQUEST_A` (and `GATE_REQUEST_B`) and `GATE_MOVING_A` (`GATE_MOVING_B`). The first one will be used to request a specific desired state of the gate (high - opened, low - closed) and the second one will be used to inform the Competitor's microcontroller whether the gate is currently operating (high - moving, low - idle). Initially requested positions of both gates MUST be closed - as this is the state the gates will be left during the firmware flash.

There will be one additional line for control/decoration LEDs - `LED_DATA`. Think of it as a WS2811-ish strip of some length. The exact specs of this strip will be provided later. Competitors MAY choose to use this strip for any purpose - decoration, status reporting, safety feature, etc. Competitors MAY also choose not to use this piece of equipment at all.

> [!IMPORTANT]
> The Jury provided firmware (that Competitors are allowed to use under the conditions specified in the Rulebook) will be realizing the fully autonomous variant of the Airlock. In order to operate it the Competitors will need to:
> - drive the robot to any of the external zones of the Airlock
> - wait until the gate in front of the robot opens
> - drive the robot to the middle zone
> - wait until the gate behind the robot closes
> - wait until the gate in front of the robot opens
> - drive the robot to the other external zone
> - wait until the gate behind the robot closes

Keep in mind that it's still possible to have a run with the Jury firmware even if you have provided your own. Think of it as a backup solution in case of any issues with your firmware.

Competitors MAY also choose **not** to utilize any kind of firmware (they own or the Judges'). In such case the Judges will open both gates and the Competitors will be able to drive through the Airlock as they wish. This option is penalized accordingly in the Rulebook.

### Sub-task 2 - Equipment panel

> [!NOTE]
> There will be a diagram of the Equipment panel and it's relation to the robot here
<!-- TODO PIC Panel drawing -->

This task is an attempt at creating a remote-competition-friendly version of a standard "equipment panel" task. Teleoperation of a full robotic arm is tricky especially on an uneven terrain and we didn't want to make it a stationary. This is why this time the panel will be trying to communicate with you, not the other way around.

Your task here will be to design a protocol for a one-way, visual data exchange, and implement both the transmit and the receive side. On the transmit side there will be a microcontroller and an LED matrix, and on the receive side you'll be using the same robot's camera as for driving around (and the software running on your equipment).

On the transmit side you'll need to write, similarly to the previous sub-task, firmware for the microcontroller. Most of the workflows and possibilities from the previous sub-task apply here, but the most notable difference is that you MUST NOT use any form of communication with the robot other than the LED matrix.

Such microcontroller will be connected to some sort of Control Board provided by the Judges (with UART and a pin called `LED_ENABLE_REQUEST`) and will be directly controlling the LED matrix (`LED_DATA` pin). Role of the Control Board will be (apart from (re)flashing the ESP32) to hand out passwords and time the transmission attempts (to be exact - time the LED matrix was ON). Proper attempt would look like this:
- Microcontroller is flashed and turned on by the Judges
- Microcontroller initializes and sends `HELLO\n` to the Control Board when ready
- Control Board responds with `ACK\n` to confirm the message
- Team reports readiness to the Judges and Judges press the `START_BUTTON`
- Microcontroller sends `READY\n` to the Control Board
- Control Board responds with `PASSWORD:<PASSWORD>\n`
- Microcontroller pre-computes data if needed
- Microcontroller pulls up `LED_ENABLE_REQUEST` pin to enable the LED matrix
- Control Boards starts the timer
- Microcontroller sends the password with Team's algorithm
- Microcontroller pulls down `LED_ENABLE_REQUEST` pin to disable the LED matrix
- Control Board stops the timer

Any deviations from this list will most likely result in a penalty. I.e. the microcontroller MUST read the flag only once per boot, LED panel MUST be enabled only once per boot (i.e. you CAN'T split the transmission into multiple parts separated by the LED panel being completely disabled and timer stopped), etc.

Passwords will be 100 character long, uppercase letters or digits only. `\n` is to be treated as a newline character and not included in the password.

> [!IMPORTANT]
> Have in mind that each of the attempts will be given a different password. Each of those passwords will have a transmission time attached to it. You can store all the passwords on your side, but the password you use at the next sub-task will determine which attempt in this sub-task will be scored.

On the receiving side there are no specific requirements for computing. You can use any software you want, you can even process the data asynchronously and this part will *not* be timed.

> [!NOTE]
> There will be a diagram of the LED matrix here, showing the order of pixels in the chain
<!-- TODO PIC LED matrix drawing -->

As per the hardware used - there will be 16x16 pixels, 16cm x 16cm large WS1812B LED matrix with a couple of options for the diffuser. Center of this matrix will be on the same height as the robot while in front of it. There will be 4 markers in close proximity of the matrix marking it's edges. On both sides of the matrix there will be some decorations *that may be moving constantly*. Background of the whole panel will be close to matt black and rectangular. Background will not cover the whole camera image. Starting pixel of the matrix will be at the top-left corner and the chain will go in a Z pattern (meaning - top row left to right, second row right to left, etc.).

> [!TIP]
> In the simulation environment the whole visual system may seem simple but in reality it's a much more complex task.
>
> Just think about such a simple aspect like the lighting conditions - sure, the control panel will be inside of a tent but the background will still have some level of light. This may or may not be a problem for the camera's exposure settings and some brightness levels may come out overexposed or underexposed. You can control the brightness of the LED matrix with your firmware but you'll have no way of setting this after you sent final versions of the firmware.
>
> Consider also the dynamic range of the camera - it may be tempting to simply use **a lot of** colors to represent the data but there will be a practical limit of how many colors you can recognize end to end.
>
> Different diffusers will also affect how easy it is to differentiate the signals from individual pixels. Some of them will allow only ~a quarter of them to be used easily and some of them will make all of them available. In addition to that - adding a mesh between the LEDs and the diffuser will also make the position of the robot (including it's angle to the matrix) relevant - we've tested this and in some cases it's much better to approach the panel at an angle than directly straight.

> [!IMPORTANT]
> Because of all those possible issues:
> - first of all - we do encourage you to build a test bed for the LED matrix, experiment and send us all your findings/suggestions using the Community Forum - we will try to incorporate them into the final version of the panel
> - secondly - we do encourage you to make at least one "calibration firmware" that you'll utilize to prepare the receiving software for particular conditions during the Challenge - using it will not be neither timed nor penalized in any way
> - thirdly - Judges will have some test patterns available on request - even if you won't provide your own. Using them will not be penalized in any way either

> [!TIP]
> As per the protocol part our main suggestion would be to include some sort of a checksum/CRC in the transmitted data so you'll be able to tell whether any transmission was good. You can drive to the Reactor and back to the panel but doing so will cost you an enormous amount of time because of the Airlock on the way.
>
> Such control/checksum data can be added at the end of the message, but also whole panel can be split into multiple segments and both parts be transmitted at the same time. Using the latter option may not be beneficial for the Challenge (as there won't be an option for a partial retry) but it may be beneficial during the development phase - it'd make finding a particular problematic patterns much quicker.
>
> You should also consider that the LED matrix does not boot up instantly - it'd be a good practice to utilize the first seconds of the transmission either way - i.e. by showing a test pattern.
>
> If you want to go an extra mile you can even compress the message - `A-Z0-9` does not need the full 8 bits ;)

In this sub-task there will be a Judges provided firmware available too. This firmware will aim at being the most naive and basic implementation possible. Incoming data will be treated as 8bit characters. Matrix will be split into 4 segments (quadrants), each of the segments will be responsible for a single bit of the character - meaning there will be two frames per character. Each of the frames will be shown for 0.5s. Segments will be either full white (`1`) or black (`0`). The order of the frames will be - more significant **bits** first. The order of the segments will be top left segment first (more significant **bits** first), then top right, bottom left and bottom right.

This firmware will have no checksums, no calibration, etc. - mostly because it'll be slow and simple enough to not really need them.

> [!IMPORTANT]
> If you, for any reason, don't want to or won't be able to do this sub-task - there will be a backup "password" written on one of the walls of the tent. This won't give you the full data in the next sub-task, but it will allow you to complete the Challenge. There's no need to read it with any fancy algorithms, a screenshot will be enough, but due to the sheer length of the password you may want to have some OCR ready. We may encode it to i.e. a QR code for the ease of use but that's not guaranteed.

### Sub-task 3 - Reactor

This is a very simple task, mostly for keeping the plot together. There will be some sort of an artifact (we're calling it "a Reactor" here, but in reality it'll probably be a visibly broken robot somewhere on the Marsyard) that'll be accepting a Passphrase from the previous sub-task and giving out various versions of the map (based on the access level granted).

In order to communicate with this device the Competitors MUST activate it's pressure sensor. This will be realized with a similar kind of sensors that'll be available in the Airlock - so expect some sort of a gate that you'll have to drive in.

All the communication will be realized via Husarnet. The exact address will be provided during the Challenge.

Protocol will be simple HTTP GET request. There will be two possible URLs:
- `/data.json` - JSON variant will return a JSON object with the fields described below. This one will be scored higher as you'll need to ingest this data to your own system in order to visualise for the robot's controller.
- `/data.png` - PNG variant will return a PNG image with the data visualized on it. This one is meant to be a last resort variant giving you the already-processed and human-readable data. **Keep in mind that obtaining an image data voids your chance of getting the full score for this task (including any other attempts).**

Request arguments (needed for both URLs):
- `password` - one that you've got from the previous sub-task

There will be two access levels based on the given password:
- basic - which will only return a location of the finish line for the next task. This one will be granted for the "backup" password available inside the Habitat/tent during the previous sub-task.
- advanced - which will also return locations of all hazards in the area. This one will be granted for any valid password from the Equipment panel. **Keep in mind though that the password you use here will also be a declaration of which score from the previous sub-task you want to be scored.** In case of multiple successful attempts of this sub-task - the highest score will be taken into account.

JSON response format is subject to change, but expect something like:
```json
{
    'status': 'OK', // this key will provide a textual description of any errors or OK if provided password is valid at any access level
    'access_level': 'basic', // or 'advanced' - this one can be used to quickly check if the password is correct
    'destination': { // this key will be available regardless of the access level
        'lat': 52.123456,
        'lon': 21.123456
    },
    'hazards': [ // this key will be present (but empty) at a basic access level
        {
            'lat': 52.123456,
            'lon': 21.123456,
        },
        {
            'lat': 52.123456,
            'lon': 21.123456,
        },
        ...
    ]
}
```

> [!TIP]
>Competitors will not be provided with any GPS data for the Marsyard itself, but the RTK sensor will be available during the whole Challenge. It would, however make sense to have an option in controller's panel to have some sort of a Marsyard diagram as a background for the map. It'd also seem helpful to have an ability to move/scale/rotate such background image in case it does not align with the Robot's trace on the map.

### Sub-task 4 - Navigating the site

With the map in hand the Competitors will be able to navigate the Marsyard. The goal here is to reach the finish line without driving too close to any of the hazards. Time is not a factor here so take your time and drive carefully. With the locations of the hazards you'll be able to plot a safe route pretty much instantly, but do not get too confident - some hazards will be *close* to the path and you'll still need to watch your instruments! *There may be more than one valid route to the finish line, but all of them will be scored equally.*

As per the technical details - we will be using UWB (ultrawideband) tags as hazards (and similar modules as receivers). You don't need to worry about the details of that part of the system - we will prepare it in it's entirety, including some basic output filtering and expose it as a single ROS topic with a single integer/float value.

The exact topic name will be provided during the Challenge, as will be the threshold - a value of that topic that the robot MUST NOT ever cross. The exact sign of that comparison does not matter at this moment - assume that the value of that topic at the starting position is on the "safe" side of the threshold and keep it at that. You can also assume that getting closer to the hazard source will result in numbers on said topic getting closer to the threshold.

> [!TIP]
> Use this data to create a heatmap of the area. This will allow you to visualize the areas that are safe and those that are not. This will provide additional data for navigating the field, especially if you have not managed to obtain the hazard map.
>
> If you implement your heatmap as a transparent overlay it'd make sense to also mark the threshold value somehow - i.e. by scaling the color of the overlay based on the distance to the threshold - the threshold value being the max/min and the min/max recorded value being the opposite side.

The Judges will have some sort of a system to monitor these values and will be able to tell whether the threshold was crossed ot not. Judges are not obliged to provide such notification during the traversal. Judges are allowed to override the decisions of the automated system - especially in case of any close calls.

> [!TIP]
> The gist here is that you're given a lot of data, but none of it beforehand. This is why having a reasonable workflow for utilizing such data live is crucial here. The best advice would be to have some sort of a checklist (or even a couple checklists for the whole Competition) and utilize it during the run. Our advice here would be to schedule some time with your Team and do your own simulated competition with your whole Team, doing as many retries as you need to. This should give you some good ideas on what to include in such checklists and how much time any given part will take.

> [!IMPORTANT]
> If you actually do a simulated test run of any full Challenge and find it impossible to squeeze into an estimated time slot (right now we're aiming at 1 hour per Challenge) - you MUST let us know as soon as possible - as we may be able to provide some extra time only if we're aware of the need beforehand.

## Competition Report

Competition Report does not have any technical requirements on top of the ones specified in the Rulebook.

## Social Excellence

Social Excellence does not have any technical requirements on top of the ones specified in the Rulebook.

## Jury points

Jury points do not have any technical requirements on top of the ones specified in the Rulebook.

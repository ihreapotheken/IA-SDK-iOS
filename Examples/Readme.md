How to setup example project:
1. Create new project and add it to workspace.
2. Create "Resources" folder.
3. Drag existing Assets.xcassets file to Resources folder.
4. Drag SharedConfig.xcconfig file to Resources folder, do not copy it, only reference it. Also do not add it to target.
5. Tap on project -> Select target -> Info -> Add following keys and values to Info.plist:
- IASDK_API_KEY: $(IASDK_API_KEY)
- IASDK_CLIEND_ID: $(IASDK_CLIENT_ID)
6. Tap on project -> Select project -> Info: Set all configurations to SharedConfiguration.xcconfig
7. Target -> Build Settings -> Search "Bundle product identifier", select row and delete it. That will make it use value from SharedConfiguration.
8. Use following code:
```
precondition(
    Bundle.main.bundleIdentifier != "ENTER YOUR BUNDLE IDENTIFIER HERE" &&
    Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String != "ENTER YOUR API KEY HERE" &&
    Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String != "ENTER YOUR CLIENT ID HERE",
    "Please configure SharedConfig.xcconfig with your bundle identifier, API key, and client ID."
)

IASDK.setEnvironment(.staging)
IASDK.configuration.apiKey = Bundle.main.object(forInfoDictionaryKey: "IASDK_API_KEY") as? String ?? ""
IASDK.configuration.clientID = Bundle.main.object(forInfoDictionaryKey: "IASDK_CLIENT_ID") as? String ?? ""
```

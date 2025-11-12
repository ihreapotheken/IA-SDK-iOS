How to setup example project:
1. Create new project and add it to workspace.
2. Create "Resources" folder and drag assets into it.
3. Tap on project -> Select target -> Info -> Add following keys and values to Info.plist:
- IASDK_API_KEY: $(IASDK_API_KEY)
- IASDK_CLIEND_ID: $(IASDK_CLIENT_ID)
4. Tap on project -> Select project -> Info: Set all configurations to SharedConfiguration.xcconfig
5. Use following code:
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

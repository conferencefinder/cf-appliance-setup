// This is a template for the container.conf.jsonnet file that is generated
// automatically for each container.
{
	CCF_VERSION : std.extVar('CCF_VERSION'),
	CCF_HOME : std.extVar('CCF_HOME'),
	CCF_FACTS_FILES : std.extVar('CCF_FACTS_FILES'),
	CCF_FACTS_DEST_PATH : std.extVar('CCF_FACTS_DEST_PATH'),
	CCF_LOG_LEVEL : std.extVar('CCF_LOG_LEVEL'),
	
	GENERATED_ON : std.extVar('GENERATED_ON'),
	JSONNET_PATH : std.extVar('JSONNET_PATH'),

	containerName : std.extVar('containerName'),
	containerDefnHome : std.extVar('containerDefnHome'),
	containerEngineTarget : std.extVar('containerEngineTarget'),
	containerRuntimeConfigHome : $.containerDefnHome + "/etc",

	currentUser : {
		name : std.extVar('currentUserName'),
		id : std.extVar('currentUserId'),
		groupId : std.extVar('currentUserGroupId'),
		home : std.extVar('currentUserHome')
	},
}

component {

	variables.service = 's3';

	public any function init(
		required any api
	) {
		variables.api = arguments.api;
		variables.defaultRegion = variables.api.getDefaultRegion();
		variables.signer = variables.api.getSigner();
		variables.utils = variables.api.getUtils();
		variables.emptyStringHash = hash('', 'SHA-256').lcase();
		return this;
	}

	public any function listBuckets() {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var apiResponse = apiCall(region);
		if (apiResponse.statusCode == 200) {
			apiResponse['data'] = utils.parseXmlResponse(apiResponse.rawData, 'ListAllMyBucketsResult');
		}
		return apiResponse;
	}

	public any function listBucket(
		required string Bucket,
		string Delimiter = '',
		string EncodingType = '',
		string Marker = '',
		numeric MaxKeys = 0,
		string Prefix = ''
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var queryParams = {};
		for (var key in ['Delimiter','EncodingType','Marker','Prefix']) {
			if (len(arguments[key])) queryParams[utils.parseKey(key)] = arguments[key];
		}
		if (arguments.MaxKeys) queryParams[utils.parseKey('MaxKeys')] = arguments.Maxkeys;

		var apiResponse = apiCall(region, 'GET','/' & bucket, queryParams);
		if (apiResponse.statusCode == 200) {
			apiResponse['data'] = utils.parseXmlResponse(apiResponse.rawData, 'ListBucketResult');
			if (apiResponse.data.keyExists('Contents') && !isArray(apiResponse.data.Contents)) {
				apiresponse.data.Contents = [apiResponse.data.Contents];
			}
		}
		return apiResponse;
	}

	public any function getBucketAccess(
		required string Bucket
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var apiResponse = apiCall(region, 'HEAD', '/' & Bucket);
		return apiResponse;
	}

	public any function getBucketSetting(
		required string Bucket,
		required string setting
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var validSettings = ['acl','cors','lifecycle','location','logging','notification','policy','tagging','requestPayment','versioning','website'];
		var returnedXmlElement = ['AccessControlPolicy','CORSConfiguration','LifecycleConfiguration','LocationConstraint','BucketLoggingStatus','NotificationConfiguration','','Tagging','RequestPaymentConfiguration','VersioningConfiguration','WebsiteConfiguration'];
		var typeIndex = validSettings.findNoCase(Setting);
		if (!typeIndex) {throw('Invalid setting specified.  Vaid options are: #validSettings.toList(', ')#');}
		var queryParams = { '#validSettings[typeIndex]#': ''};
		var apiResponse = apiCall(region, 'GET', '/' & bucket, queryParams);
		if (apiResponse.statusCode == 200) {
			if (Setting != 'policy') {
				apiResponse['data'] = utils.parseXmlResponse(apiResponse.rawData, returnedXmlElement[typeIndex]);
			} else {
				apiResponse['data'] = deserializeJSON(apiResponse.rawData);
			}
		}
		return apiResponse;
	}

	public any function getObjectMetadata(
        required string Bucket,
        required string ObjectKey,
        string VersionId = ''
    ) {
        if ( !structKeyExists( arguments, 'Region' ) ) arguments.Region = variables.defaultRegion;
        var queryParams = { };
        if ( len( arguments.VersionId ) ) queryParams[ 'versionId' ] = arguments.VersionId;
        var apiResponse = apiCall( region, 'HEAD', '/' & Bucket & '/' & ObjectKey, queryParams );
        return apiResponse;
    }

	public any function getObjectAcl(
		required string Bucket,
		required string ObjectKey,
		string VersionId = ''
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var queryParams = {'acl': ''};
		if (len(arguments.VersionId)) queryParams['versionId'] = arguments.VersionId;
		var apiResponse = apiCall(region, 'GET', '/' & Bucket & '/' & ObjectKey, queryParams);
		if (apiResponse.statusCode == 200) {
			apiResponse['data'] = utils.parseXmlResponse(apiResponse.rawData, 'AccessControlPolicy');
		}
		return apiResponse;
	}

	public string function generatePresignedURL(
		required string Bucket,
		required string ObjectKey,
		numeric Expires = 300,
		string VersionId = ''
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var host = getHost(region);
		var path = '/' & Bucket & '/' & ObjectKey;
		var isoTime = utils.iso8601();
		var queryParams = {'X-Amz-Expires': Expires};
		if (len(arguments.VersionId)) queryParams['versionId'] = arguments.VersionId;
		var params = signer.appendAuthorizationQueryParams(variables.service, host, region, isoTime, 'GET', path, queryParams);
		return host & utils.encodeurl(path, false) & '?' & utils.parseQueryParams(params);
	}

	public any function putObject(
		required string Bucket,
		required string ObjectKey,
		required string FileContent,
		string Acl = '',
		string CacheControl = '',
		string ContentDisposition = '',
		string ContentEncoding = '',
		string ContentType = '',
		string Expires = '',
		struct Metadata = {},
		string StorageClass = '',
		string WebsiteRediractLocation = ''
	) {
		arguments.FileContent = fileReadBinary(arguments.FileContent);

		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		var headers = {};

		headers['Content-MD5'] = binaryEncode(binaryDecode(hash(FileContent, 'MD5', 'utf-8'), 'hex'), 'base64');
		for (var key in ['CacheControl','ContentDisposition','ContentEncoding','ContentType','Expires']) {
			if (len(arguments[key])) headers[utils.parsekey(key)] = arguments[key];
		}

		for (var key in ['Acl','StorageClass','WebsiteRediractLocation']) {
			if (len(arguments[key])) headers['X-Amz-' & utils.parseKey(key)] = arguments[key];
		}

		for (var key in arguments.Metadata) {
			headers['X-Amz-Meta-' & key] = arguments.Metadata[key]
		}

		var apiResponse = apiCall(region, 'PUT', '/' & Bucket & '/' & ObjectKey, {}, headers, FileContent);
		return apiResponse;
	}

	// copyObject

	public any function deleteObject(
		required string Bucket,
		required string ObjectKey
	) {
		if (!structKeyExists(arguments, 'Region')) arguments.Region = variables.defaultRegion;
		return apiCall(region, 'DELETE', '/' & bucket & '/' & objectKey);
	}

	// deleteMultipleObjects
	


	// private functions
	private string function getHost(
		required string region
	) {
		return variables.service & (region == 'us-east-1' ? '' : '-' & region) & '.amazonaws.com';
	}

	private any function apiCall(
		required string region,
		string httpMethod = 'GET',
		string path = '/',
		struct queryParams = {},
		struct headers = {},
		any payload = ''
	) {
		var host = getHost(region);

		if (!isSimpleValue(payload) || len(payload)) {
			headers['X-Amz-Content-Sha256'] = hash(payload, 'SHA-256').lcase();
		} else {
			headers['X-Amz-Content-Sha256'] = variables.emptyStringHash;
		}

		return api.call(variables.service, host, region, httpMethod, path, queryParams, headers, payload);
	}
}
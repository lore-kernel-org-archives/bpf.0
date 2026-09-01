Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BC43846E
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248010; cv=fail; b=OfnN95pYcUz4v6oGlD6QtqCqaV1+S2aSSam6A8DwEOuZ4sH8nTsCkcRg2f+l8FPzdcGxUOFD70s7iys9u3bAmO5vbKoX9R/8HzCMkJSkUwJlYnqGcP3juqLAjJlWQrcmqc821EUnDvVell4WlZLbDCF3KnRVCINug3hq1QPeQ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248010; c=relaxed/simple;
	bh=kKgnKMBWfuH9tjK+bXywjmRkhJhGaVvjFkf5ekZDByU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnucl1JAIFHfrY+5e7+kMHTMISPSrJtc1ONouAC7yPZSLWGNxSmQFcidZ3mFrHwSzx/AfT6CueQlMdyfAs1ykOnG4M/jLvnnbDubGDg6MW8BjNWe62CpwvnpRxbklkPTabvFZXnd+FO9UEf2h6hYalFIa3+C4s2731azgO6OVgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MLNIFsof; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VgaXgu/O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLNIFsof";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VgaXgu/O"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VLCZT02847911;
	Tue, 1 Sep 2026 07:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9pPNvDrp/Hokjq6SdzHVgQ1b05uLUt4tU7p/MlJtDsE=; b=
	MLNIFsofqEBr72o5xBimKbG7sqsMkCxbXjtoNj4N3+u5k1N9g2ERvg7LhJK8TOTo
	Nc5GY/4IRZWMEwtTdt66dqTfS5jcZ7RWRsfDwbAtJPeKeauClSrii7NclxDA3P5r
	TJwuoNxx7Jr83n3dvomOkzfrvInfmFx9FXybZjeF2gSWJKmIjqpFF5jlmB4iTHLZ
	nSkbrmeMfU0atLDAhVcpKtEST7YRdvMVqIY2vIUE1GZR6cvCWFOx4PJbXrMX73iR
	71iraRl5ZRcgGCBHzRfI32UBVfIwMgaCKAQ0cxUaQ+94vzgFrh3NH3rt432ndXWa
	9e2gLaOebi3BZq2GOg0KHg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbav5wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 07:33:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6817V7Os032463;
	Tue, 1 Sep 2026 07:33:24 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvq4hj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 01 Sep 2026 07:33:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8f9i0IIABy3Hl6nUs1hluAGWnVTWJ/xkvOXm8NQHEm4Ewp0gtMJmH+SMo01aW4JWlBPremLHfWXbDR2O8EB5NYwOZZ7esKflQWfmhh+Hw+hj5Z8LIbuHDcOZiks2f6rYx4xUvZJCZZFQ32ozNZaY3dbNQH7noYhT6aS5iN8/IYDOfpii9VlNPa/uZrTvyw3MHMzxLz/8V9HxPU7EnFllfboZFo/kZCMzADt7iWlzJ4OFlyyLWCLFVLyNjYfJO5ZQhSwPRGIRk0sQG80LZH4Yglkaerp2rd6zRgvF0bP0fjq2yBJlY02wemu1Zc4VDr0BA3v4WcksY91vyQiXSieUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pPNvDrp/Hokjq6SdzHVgQ1b05uLUt4tU7p/MlJtDsE=;
 b=meKprXzOl4Z4dODznYhTL3JN4mrvyCcP7RsOf4oOLBGwsEVgVHjzZsrFylxr5f2gxh7m+yRvJJY/rCpVCmyJ9Cv+E9aErS4QxCwG8rw7VXuLJTlrF4nyUeBL6XlwrPLkrGDgxXg9ytfA+sSTqdqzNXwmdCD+L5jwEn2pCZVUsjDRlE2A5l7LJgXNv6LQGidF36nojZ5gXQoc7Afon67tROl0Z/crpPeYVoKL5ZDN6nwmtRntiEmGrKAgrK51+fRZTpE0lTZITPg9P72BCoztRPRpHc8Dkyktk0FWavt/3HdepZjO2b8adVEuH/M5xh+lA7Ctowl36aRPD6SCj0S97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pPNvDrp/Hokjq6SdzHVgQ1b05uLUt4tU7p/MlJtDsE=;
 b=VgaXgu/OdFmG8OiDM1r8SDv5X99f4OtcokBZ2peRYqM8Jw9pITYNVbi6fSBQNAQuJFnAdOk6JpDeELM1g4JDT0VOEe6CoXqMGx22dqisodks9G2fds4WR6Piu3KL6SMyFdHTs5xN+4X2lYSl29/1abx69MOpOoXHE4mmsztVhMg=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA4PR10MB8611.namprd10.prod.outlook.com (2603:10b6:208:564::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 07:33:21 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 07:33:21 +0000
Message-ID: <b2602c85-c5ad-42d9-9f64-1bb7e1100a85@oracle.com>
Date: Tue, 1 Sep 2026 08:33:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
 <20260831133809.1161-2-zhaofuyu@vivo.com>
 <ccb5d732-90ef-4acb-b11d-75da7f1d21ce@oracle.com>
 <dd0005b7-a8e9-4cb1-9ba4-6f80b950c401@vivo.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <dd0005b7-a8e9-4cb1-9ba4-6f80b950c401@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: c70bd272-420c-48b7-1791-08df07fb4cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qP5lolkh3dPsdc6gdjRUaINlC1+8YwY4OGLROkxR3NyS5DWDuxZ2JYFoK35AANVZ3PKiYrxdeqi4SHREdx3F3vjXTGQg081A+/H27u4YtNUMo7mz3eAjuQAh/aNI7VIcFekzgnwi/hi7etqSYbbzRZrlJPEhifsgmyCEUeSbgDR+oQktPaCZW9fxRA+QRxOcZDXB66hJDVeJRfhoYS6RlW1BanSMExEo53JLdR35wyxVboEyJMyJM97IkohN5o91AXXEmWzoiZrw4u7xS0XgyOsvn2u5w63HYhBUq3wUU8iSyez1uqULOnFGmXQYsVNmHoSD3wPRSvdcKGzrsi3VMBTna/rGDyAKyl86eooaHuZYQhY+Yba9tkMxdMl3tNdqVqHoHwG3j+uddBhnXWP8Caw2q92gIUYiW/cRIxlDq0OMZCJPSdEmpHtPH8IVRh7N3nc7Xhjty+GNAnD8ugZDirDqrJS7xVwOS6dmeLANLDK4Z+n22MPQB5MHL5oFc8KCK0yMes2/GdkZ+ZHQ0bnpG/lt3Qulsa1exsu7NtTQj5TeeqdxDGZ4CllEOXFg0CLIvxKttCyykLBAFO+Z4q/QqYda+fjzhyEMrCaFBvbSifrcpRKUVqYj2aJErBuXCjQSQdnFpc0D9HZFwzXsUORtxILVVoAenMEAZkqGRQVOUSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnNuR3RuZEhSVWxRY0RWRzVpNDRaUW92VlBWZGdDT3ppUFpaRk5RcjUrSHZa?=
 =?utf-8?B?Smxody92dzR1TCtXeDBYb0tQNVBSNm5lS01MRVJTSnAxQTZ3bWhLd2gwQm4x?=
 =?utf-8?B?Z3dSeElTR3MxbDNXSjFyNndwR0lWMExPd3AvUjB2WVV3b08yMkM4YlF3UXhG?=
 =?utf-8?B?a3RsdG9qVU1vRlVPZ2JNUVlDQmxHMlZyTnRnc1huZVZiL1JjMWFKVk9lN1FZ?=
 =?utf-8?B?YjVPRC9kMm1jZUpuaWVRckhxSFp6K1B0azE1QVJsTC83azZGV0J2QXhqSXhX?=
 =?utf-8?B?dmhhRFhmZld2V0RCUEI5cTI1Q2pmUUNraXoxZWlPaHdIdWhRZXM1cldrWnpV?=
 =?utf-8?B?R2tVcm9tK3h5KzBGeXhaeGQ5Sm00SkpFZCtSVHMwa1dFN3JhN3JodUpWclFV?=
 =?utf-8?B?UU0vQW4ybGZCZGhZUCtnN2NhNktrZWxQMTF4ODhFQStURkNDZUplSE4wajhm?=
 =?utf-8?B?aERPZWVXaEJYb0hxUk5oMm42ajBmMitpWWNCait3bzZmeGxBRTE2Ui9WbE1w?=
 =?utf-8?B?cGJzeXhPQnU4YkRPZ0ZMU3RuWEVMOFg5THB6WDFFeGNOMGxmejRJaVdwaC9i?=
 =?utf-8?B?bEVBSVl1V1VzOFZGZXZxSUorS2lzdVRwMXAyajVWYjNMTVNlY1NDZWQweUo5?=
 =?utf-8?B?S0p5ZnVEbnpRQnBNNkw3NHMvYVBtVk83RmMxaURUL3YxWnduV0VWV2Z6bkpX?=
 =?utf-8?B?RkorR2Q4ZjkzbTgvRFNRWitEdjc4T1U2MEk0aDNkNWxpcnY2d3V1K1QvUXQ4?=
 =?utf-8?B?OFIzL3VmMkdseFhaclZYQnhRbGU2TWwvNFViMG1QWTh5RXhmbnRVR3hGSmk0?=
 =?utf-8?B?eS9nQUZ5RjBMdDRUeDAzR0VoK3h1bFZMdGRRajF6S3ZFZ0REcFhjR2pSdjF2?=
 =?utf-8?B?NWpvMWpSdFZlNnpuYnFBNVovOVcyZjZRSkFkVFNaSWVhbG1QUHFOQmN0R3ZW?=
 =?utf-8?B?YVo1RjJySzBrTzRPUHVCUGhpd0VvdmUyMTByaFdVVHFvbFNhK053aEpsTlJq?=
 =?utf-8?B?bk5WT3EwMWxVL1JVVWl6S01sVWlHQWFkcUJ3UFc1U3lhZTBlQ0FIbHl5SXJV?=
 =?utf-8?B?WGEvcGoyUmUzMWxaZTFabjZzSDRmZkxmWnZKZVJIbzNjT25ESGN2TnhDWEZ2?=
 =?utf-8?B?V2cxL0JHZGoyekJteG44anU4ODFORjNxRlFMYVJGVzJuNWRYSVFyeEY5d0Nl?=
 =?utf-8?B?QS84TFFGb1c1NHRQbU5vUVlnaUI2am8vTlhMUHo3S3RKMGNUa0dQVmJZRi93?=
 =?utf-8?B?VVZjM2tKeXlNcHBDWlZvenZiN3lxK09hakpSdG9xYkMxUGpHbmJzU0RWd1lo?=
 =?utf-8?B?RHBqaGt4YzdXYmlwRFlTRmlQWHhaeER1RWUrcjcxZlZORUdJNzBWMSs3SjNU?=
 =?utf-8?B?MHdYWm5MQU5VVWFVTHJ5K0ZrQ2QvSERmY21ib3Vnb1FvcGdnTzdaT2I2enlT?=
 =?utf-8?B?UDBXUGRwc0pzNmhGSmJMd1FGcHRyVzVoMTArc2h4OWs2K2xBZXprc1A4TkRn?=
 =?utf-8?B?ZTZTd2kxL2diVGpMckhJLzdOTklWZHNTcVdIbndqYVAvUWNlbGwvUGpqcHpj?=
 =?utf-8?B?di9VSzFqTEkvb0dqKzNoWWhHTVRXZno0STFmRFhPODIvbm15VUhBdGtwTElW?=
 =?utf-8?B?V3BVa1RWeUdrMTFtOThrakVGeTMxZHRBdGdONGJ2bFlzckNQc0I5alNGaVpD?=
 =?utf-8?B?YlpRNytZRmNXL25uWTFYRTdIT0tDMk5YOG11bUdjMFFReW1iaXJPSzdJQVdN?=
 =?utf-8?B?d296aEpXQ2ZDbStGVHNYM1NmMDQ1SEV1QkhtZCtrUEV5QWhYdG9jaWYzY051?=
 =?utf-8?B?OHRQNjBXNFUzdTh2czhZakZUVUdMOVVZYzVveGFtUGVqZFVkNUtRV1RzT3B2?=
 =?utf-8?B?S2FDTjlQdWpxSGI3Ym55cHB6YjRxWWpzdFBocHFpTjlWRGhoT0FsbXRPaURk?=
 =?utf-8?B?bG9nMUpFZ0EvVWUvKy95RStFZ1BlMUN2cGZJUW9EY3ZDUnFNMDUvWFcrTVhT?=
 =?utf-8?B?TFdlVko5ai80UDFOTnJvM1puSGpMeWJKSXduUVZZRWJrZ1RrTkRlNVVxb1Ar?=
 =?utf-8?B?RER4MVVpN3VicG9nMUVDaVBDRXM3bVV6dXkvR2hPRkxLVy9ERHd6SnN0TEpX?=
 =?utf-8?B?aU95QU5iVzV0d0p2RWwxcXh5U3UwVXVTWUZNamhMRTFXSHFLS1JJZm1RbWNh?=
 =?utf-8?B?cHloQnhCaUdTUUdlTUNJMCtJOUQ3Tkk1TVZPWG1ZM0hBL0YvcXg1Y294eHZR?=
 =?utf-8?B?MlhxYTB5OWs3UWtrc0xuQ21LWW1abEs5SElIMENzQmtXU25MSDlXak5SMW9n?=
 =?utf-8?B?SFlVTHAzQ2p5MjFZOXkxOUFKOEE2NDlHdW4wcE43UWgxS0dZUGVTQT09?=
X-Exchange-RoutingPolicyChecked:
	Xpvlq/B1ONs23KJyEhdFOSPeursUyTDKufTqXk1QlTNOXAFDFM2pzJ+FE9gC/2RObKQbyo6+5esxEX1csJsKuVhTNR42Kw5t3P3Aj7Wu+XRWyGqQoJJ8QrIMp4chZDMoJxBb4K33eV0nj3euoUEvOg21HjVZMasR1OrDj1d+S0CkmT+6D+D5PW/OU5XcfnIuPTWGy/v58tT8BqvLJZrCgBgPl17OoZYXLNOHnow0D99lRHrtrjuup5GTfoBLxTMCglqLkqEzbA7d5vNojgt/9k47vln2Yfbj3QTUBEuXEh/2IyqpiHUK6pEfHQ0hVVAVQGK3akxHd4mpZFGOwePM7A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qwuMJ7HdQYpHAfh1oI4FHnikU6jtCqEO58F1gGbvu+ea0DuGRTghJ04ux7HxP5L74+BcxSEOz/rG4HYoU2kc4ClyyDze3d+06+z/I+RsSNkTSkI+VqroW3Qf+CX/Kdz9L2mTo5FrK2hl+dZLZZee/qfuU9evxzWgzltu0GRRa7bHmQ/lsAv2qUELUQkvTLjeQu3zJaSWH/4QCssT8HMdOghJKhu3acQFbRoNZMnrXJ9EiDiVCfsV9i/xMa2+LOBlVLHl0eJhzal6VCMVEIzSROaORC/Rj6KfgF+m7MPv7n+Tm7Jp0npjFycpK1lHw/n/RUJ5mbdoH77suKMimrfs1eIYdrt0ZBPdfZpT4Fcl4kEZswPqOk8731ZR6a7AJbofv0cBgtofCXr0LYlQFS3M1evBjuNHjGh9rDEGoAatmZxmiZHoWIPjXTbUuhzj+OiA1+V7brJfjbCqu5rDPr9IqL71hXJQVj5OwQCZMoO1aCs6N0aH6vm2bfTI/B3Om4lheQae8Cdv3wWJDJcF17XxC0vhhwIUOhQLZqmwwqAoZZt946/18MpaZfM8gvuWnsKhRCNvJwsv8QasbfYvmVjTB8dTib91LQCntWEZSsDJn2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70bd272-420c-48b7-1791-08df07fb4cd4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:33:21.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh41uj2fc79hh9++PYj7Q/cKGeTfzOW9QMtCw2+v8tZTvp1IpRT0zbk1HP8LxSRav/WeikGmbw+X5vuVXGtPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609010066
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA2NiBTYWx0ZWRfX36DV7MqvZ7Yz
 MRmrSW0/mZJ4MmKU9AW6cMQsoiJLYgcSWF0WP1AD+lVuGCj8VlNtuin3VatlwtukDots8hHlrqd
 3kzcq2F1hc8kxziHt2Pm+kWsRu7TJAnPuUV/T+cQKECVD6utGiWe
X-Proofpoint-ORIG-GUID: JAjGxZgKEb58cR_0rHIaFbr8gvAkM9jo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA2NiBTYWx0ZWRfX87/GEn+4xXiB
 qZzl2d+lcEidcCds4V/IXYYw0pQFfhRllAPSHhVVl3Wyac9sy8ttm2ljb+RGarMidHfcDG3/683
 pr2TMR8IR3juFcHqkBHO2qf3eU7jdl5hPrYpl/hz3sm20kaUjX9fe6gFEt2BPCfyk5heczk1ble
 V+KqmShRvmFQh0oYaHPvJv4ExEPvQGdYDZCTBsqOJ3t2ad8TzrT9MDfkn9UEoNPVZMGItNbvnyp
 2/K+0qfdgL3xXTOx8vj5nMxNMa2+w6pKTey2Kx4uckzxbBRNb5hgxG8Ocmnsff/f5Pq4zTiVm+9
 kdVNFhwz+CM93F6PJDoQurYAfx6qBY0nHN9CQVwyhqhWUy1hfMMpy5onow5wIH2YkQDPef/uoFL
 hCZ9EO9qImkw6FgYq4eA4YgSxFLBvnyq/hd+SapsyRa9i/wnu64kj9Og7+SNlZziDB63Mj9ISIv
 +iKnpOr8bu8Scc9QsJZ9+ArvuMMXYC+pLFALdHtE=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a967fc5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=pGLkceISAAAA:8
 a=1WtWmnkvAAAA:8 a=-ri8lso3cDEz9-OEAL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: JAjGxZgKEb58cR_0rHIaFbr8gvAkM9jo

On 01/09/2026 04:15, Fuyu Zhao wrote:
> 在 2026/8/31 22:46, Alan Maguire 写道:
>> 
>> 
>> On 31/08/2026 14:38, Fuyu Zhao wrote:
>>>
>>> Add btf_module_names and nr_btf_module_names fields to
>>> bpf_object_open_opts to support selective kernel module BTF loading.
>>>
>>> With btf_module_names:
>>> - when provided, only the specified kernel module BTFs are loaded;
>>> - when an empty list is provided, no module BTFs are loaded;
>>> - when NULL, all module BTFs are loaded as before.
>>>
>>> This avoids unnecessary module BTF loading and reduces BPF object
>>> loading time when only a subset of kernel module BTFs is needed.
>>>
>>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>>> ---
>>>  tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
>>>  tools/lib/bpf/libbpf.h |  24 ++++++++-
>>>  2 files changed, 140 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 514e4e9daa82..e19d0afd2592 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -779,6 +779,9 @@ struct bpf_object {
>>>  	char *token_path;
>>>  	int token_fd;
>>>  
>>> +	char **btf_module_names;
>>> +	size_t nr_btf_module_names;
>>> +
>>>  	char path[];
>>>  };
>>>  
>>> @@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>>  	return 0;
>>>  }
>>>  
>>> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
>>> +{
>>> +	size_t i;
>>> +
>>> +	if (!obj->btf_module_names)
>>> +		return;
>>> +
>>> +	for (i = 0; i < obj->nr_btf_module_names; i++)
>>> +		zfree(&obj->btf_module_names[i]);
>>> +	zfree(&obj->btf_module_names);
>>> +	obj->nr_btf_module_names = 0;
>>> +}
>>> +
>>> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
>>> +					    const struct bpf_object_open_opts *opts)
>>> +{
>>> +	const char **names;
>>> +	size_t i, j, cnt;
>>> +	int err;
>>> +
>>> +	names = OPTS_GET(opts, btf_module_names, NULL);
>>> +	if (!names)
>>> +		return 0;
>>> +
>>> +	cnt = OPTS_GET(opts, nr_btf_module_names, 0);
>>> +
>>> +	/*
>>> +	 * Allocate one entry for an empty list to distinguish it from the
>>> +	 * default behavior.
>>> +	 */
>>> +	obj->btf_module_names = calloc(cnt ?: 1,
>>> +				       sizeof(*obj->btf_module_names));
>>> +	if (!obj->btf_module_names)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < cnt; i++) {
>>> +		if (!names[i] || !names[i][0]) {
>>> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
>>> +			err = -EINVAL;
>>> +			goto err_out;
>>> +		}
>>> +
>>> +		/*
>>> +		 * The list is expected to be small, so a simple nested scan is
>>> +		 * sufficient for duplicate detection.
>>> +		 */
>>> +		for (j = 0; j < i; j++) {
>>> +			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
>>> +				pr_warn("duplicate kernel module BTF name '%s'\n",
>>> +					names[i]);
>>> +				err = -EINVAL;
>>> +				goto err_out;
>>> +			}
>>> +		}
>>> +
>>> +		obj->btf_module_names[i] = strdup(names[i]);
>>> +		if (!obj->btf_module_names[i]) {
>>> +			err = -ENOMEM;
>>> +			goto err_out;
>>> +		}
>>> +
>>> +		obj->nr_btf_module_names++;
>>> +	}
>>> +	return 0;
>>> +
>>> +err_out:
>>> +	bpf_object_free_btf_module_names(obj);
>>> +	return err;
>>> +}
>>> +
>>> +static bool is_module_btf_needed(const struct bpf_object *obj, const char *name)
>>> +{
>>> +	size_t i;
>>> +
>>> +	if (!obj->btf_module_names)
>>> +		return true;
>>> +
>>> +	for (i = 0; i < obj->nr_btf_module_names; i++) {
>>> +		if (strcmp(obj->btf_module_names[i], name) == 0)
>>> +			return true;
>>> +	}
>>> +
>>> +	pr_debug("skipping module BTF '%s', not in btf_module_names\n", name);
>>> +	return false;
>>> +}
>>> +
>>> +static bool no_module_btfs_needed(const struct bpf_object *obj)
>>> +{
>>> +	return obj->btf_module_names && !obj->nr_btf_module_names;
>>> +}
>>> +
>>> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
>>> +{
>>> +	return obj->btf_module_names &&
>>> +	       obj->nr_btf_module_names == obj->btf_module_cnt;
>>> +}
>>> +
>>>  static int load_module_btfs(struct bpf_object *obj)
>>>  {
>>>  	struct bpf_btf_info info;
>>> @@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>>>  		return 0;
>>>  
>>> +	if (no_module_btfs_needed(obj))
>>> +		return 0;
>>> +
>>>  	while (true) {
>>>  		err = bpf_btf_get_next_id(id, &id);
>>>  		if (err && errno == ENOENT)
>>> @@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  			continue;
>>>  		}
>>>  
>>> +		if (!is_module_btf_needed(obj, name)) {
>>> +			close(fd);
>>> +			continue;
>>> +		}
>>> +
>>>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>>  		err = libbpf_get_error(btf);
>>>  		if (err) {
>>> @@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  			break;
>>>  		}
>>>  		obj->btf_module_cnt++;
>>> +
>>> +		if (all_needed_module_btfs_loaded(obj))
>>> +			break;
>>>  	}
>>>  
>> 
>> I was looking at the selftest in patch 2 and was a bit confused as to why
>> specifying just "nonexistent_module" in the module list was a way to test 
>> the scenario where we fail to specify a module that is needed ("bpf_testmod"
>> in that case). I think I see the answer here - we don't look at the module
>> count and check it against the number we asked for after the loop completes.
>> In the case of "nonexistent_module" our obj->btf_module_cnt is 0. Since 
>> all_needed_module_btfs_loaded() will evaluate to false in that case,
>> we keep iterating over BTF ids.
>> 
>> On loop exit shouldn't we check obj->btf_module_cnt in the case we asked
>> for specific modules, and make sure it matches the requested number?
>>   
> 
> Sorry for causing some confusion here. My original design was to
> treat `btf_module_names` as a filter rather than a list of required
> modules. Even if the number of requested and loaded module BTFs does
> not match after the loop, BPF program loading will still fail after
> `load_module_btfs()` if a required module BTF is missing.
> 
> However, your question made me realize that this behavior could be
> made more explicit. It seems better to detect the mismatch and fail
> here, rather than defer the failure to subsequent processing in
> libbpf. I'll add this check and update the corresponding selftests in
> the next version.
>

Sounds good. Thinking about it, it might be good to retain the non-existent
module tolerance optionally somehow (a required_module_cnt perhaps?) since it's
often the case that a module is built-in on one kernel and a module on
another. If a module is builtin ("y" instead of "m"), having a way to say 
"load this if it is a module but don't fail if it is not present" would be handy,
since the needed BTF would then be in vmlinux BTF rather than module BTF.
So in such a case the nonexistent_module test would fail if 
required_cnt == module_cnt == 1, but not if required_cnt = 0.

Others may disagree so let's wait to see if anyone else has opinions on this,
but in general it may be useful to have flexibility around module BTF presence
as it varies greatly across configs.

Thanks!

Alan

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6759391826
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563146; cv=fail; b=hwPhlq5K7VpOfD0/7QUjp+Ug7PF5fjA9Zg8oLxZfqpfXSaP08dY52rgPDwy1HwDJ3sjqmvbu/l0Wbj04+xxgrn1sOucTLcRUNTq9zWhJN5dFc/tLoOFHE4gwtons+ISpPZvfbzVoQJwY6im2u+doCOh9UESBhgPtR2Clx3hgARI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563146; c=relaxed/simple;
	bh=/ymXZ8xNJKH2gjb/+dXNdDfcIRTJ7ZIXA5MC5t/BYGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9CLAN/Fv4L4IdYWhBh+sOeFouQibfKQ8qk4WrI0KIwoT/kXYym4FWF5nO+FYFG5w3GaUA10N1HO19nhymw3cHgzuNvOWEPgAKRgdm9+SM54stLlICRdE+lYchTuckMZh3hBA2uc+B4SE6GSRhm95z4I6RlBDCByAmALwBON3cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dlsm0M2W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PQciY2IR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dlsm0M2W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PQciY2IR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623Hjt6B637530;
	Tue, 3 Mar 2026 18:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NC0aTgEZSr+FVokl1UhHv9njYcZMx24VnP/WzpBG7JI=; b=
	dlsm0M2WhFzvu6hZQcutmABS9lbsT0eMgQV9TWN0nhoeM4LkO968GJbzFDU+Jeu1
	Vg9dAiRUlSlwBu742jbLcJZ8S1jFavU9pyC/qLd4DfDB79aHtkomJpfbh/bB8j5G
	YFFCXdw9EeGONQrXBmNbREsxo/S4KBKx7dEiMmsvj2srhNtNfN65jzFUPzHmY9FS
	oF5VtLuIuQw0V0aAqMeVnaw73CbAnayDuG5T7XmX0WZStVtF6ZIQz93pXucRBUxS
	M8Z5xKEv5fxVXyrAWgiqf5yo5DAf3xQomfFIqjGghXfwap9+aCYLxKzGmBUBUtbo
	OCJD2Ad6SkV6xblMhwZwvg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4b3g2yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:39:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HuQQJ026778;
	Tue, 3 Mar 2026 18:39:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptafdtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4T6pvn+dFIwpicF5TT41Y/kMPcCz+KcfF9+ygnHG9/fQf2BUFiRsCk+r2vs7nOndUCqRBTRQ2F3un2nA0tH4/tCKxn6B2Supnz9fxMMJkHMOCW2NEFjJgnKWTKWJDknj6p7iZiULwmFAq2Yd3fR82yHDMbL1VFHzN0Qs5+cU0ci4TBYNzthrKEmCLPQLSmZ97uo6QZ/McuCzDR43NbgML0zcvBErvSy2LY+qKCAlMsI/Edk2AHdiy6mbDJ50LRHOei9dBVEsrUosPaPAjJXmMp2U2rCxirs5SWdObuCXheY2dkoZ49xBWOtvwtMIiqMO/V+rkt/IM1A4ZVcnOYFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC0aTgEZSr+FVokl1UhHv9njYcZMx24VnP/WzpBG7JI=;
 b=tkP3g3wZ/dQRaTFs+ZkZTlNwixYzldNIwB1AXJjXIzsQ1H6y0Q6oBmoqpQEbgFFY0ALhngW/+1ao5C5zl7pOcHmdRVxS96x+ftnlQLKbMWRanGhx32m8/WN9q/OQ5m62Bko6k/7LkuVNuj1Zvs6lrA4ffaZ7giKQh8qxu+s76ooKGRlastsD087hwVM5Ry+H9wh6xYVBCRDNozVp2XXtyLeXbT8X25vNMNyTIOXaFEeRN4nrRWUCnoVuOs3znpp+PDFBiMXiQbU+vpEvQjaMliga4WuGr8JYPXcJw55oLICdCDF5KzmZNhGoD7ZxwPTgpgFjLMnUSnhaIcWpcZXuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC0aTgEZSr+FVokl1UhHv9njYcZMx24VnP/WzpBG7JI=;
 b=PQciY2IR5TnijQC2hBXjc+A/iSE8vP8kspcTvst7Y10Fb7aFmGSzC5x7WnUtFKaigzY849HKnlsLaAmznLpg7ye2+IeKS/KmgYs9xwLKS77ZwoFa01M5szo9pvyDxeKdwGXSnEbHFqPQNpxI7wOsl5t58gAKVmg0NpEH2ew/MCo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB8151.namprd10.prod.outlook.com (2603:10b6:8:204::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:38:59 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:38:59 +0000
Message-ID: <f45fd58a-5945-48fc-be4c-975c63e28141@oracle.com>
Date: Tue, 3 Mar 2026 18:38:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: tests to non_null ptr detection using
 register operand in JEQ/JNE
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <20260302161736.156685-1-cupertino.miranda@oracle.com>
 <20260302161736.156685-3-cupertino.miranda@oracle.com>
 <f68ad995294f3223d6bf3eef0176193b52ae54f9.camel@gmail.com>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <f68ad995294f3223d6bf3eef0176193b52ae54f9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: a84bcaac-363e-4faf-14ee-08de7954224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	bNXqyRNlpYjuU1VaV8nTcTR2YILVSGLdiKcU/lQBRspPVXi8c+C7NjWJ9IS6DElQRc3KW/x2XD6lE8vewFKKEbCqI1d4I5O3gNkMnxTtKVZptj6Hv4TfYlchmP5Q4zSsP7M/JhCTxAlOhd5ENl2AOw43mICQKqpdkyW6aAsgYghuwhcN2hnQ67GGYb1u3cbURpB/9EBlE6blxqUpRbaGzuYuSxdYqzBmRDHHbpTsbxiUDOwmoL6/w1MZ/giM44104wvFh64w85Nv1rmLYWkBOVSeO0HVpN9qmwL3RGeN2THDhty4ih4xfYXdyQ56W+4RKdMcROjt4XMXBcyJPUiqDtLKW5TwOXdEjmIoImMhrG0Jfkw4xk9ol35rVwETaDD49u87arQduQOmMF+8UaYvjgsBbabQHHG0U4PXO6tIAt6BurRXmhux9oabfVZafsSr6sLL6v3rc0hvpgtUmvFdYfGp1XNgM4zHI1el4P+gOC3XAWOfkqLZDZsOhw0+4XRtCxs20E+zCXlwy0zXoVtux41URiyBifBpZGH8IgXy5JvKSiH2IwQiNVu67+71LvA7F/KuvYgLmrcO28LNNWOBNaPPxjSCs06kDBCM2yRnsPaflNFzizRv2WZ2nrUOz9C1Seb9IU0AMb7WUCTNFiNKJ+SU4JmYAOHCU51GUh42rSodh0qHdbVkqRZYO9WJW23RodMQlG2MBfNiyX47NUUnn0WwYdU1TTZFTMDNA2CVkH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhpVXhKZDVmWWNKZEk1QXVLVlZhRHQ2Z3RFVlgxdGxCL1NoY3MxRDdUR2l2?=
 =?utf-8?B?RjFudmEyZGs1dzlHemZQSHN5Z2NIeUx6MVpqVDl4elZQSzRXMVhnQTF0VkVP?=
 =?utf-8?B?UVFveUhnZVFGWk50NUdvZVBHWUZqd3RVYStUd0hLbFFWUTExYWZPWmxTdEVo?=
 =?utf-8?B?dEcvMDRyNzB3NXZkb0ZVTGhtU0RCSnZBcVZkbUdFN0Y3MGNsamVDYk1jNWd0?=
 =?utf-8?B?SE9PSlhGdk1yNUVUeDRpc05jM1JaVXBvSnRxNEdOQWhhNjV1dVBzVTAzc3A4?=
 =?utf-8?B?QzBOS1crZUpZZ0EramVzOS8xZ0xnU215REhrczFkbDhpR1RNRG9oYlVIdDFu?=
 =?utf-8?B?eFc4eUJuTTU2WEh0TG1xamJVM2tFNGx1Yk44bU0rc21SUG5SNXBVUnNPZS9H?=
 =?utf-8?B?Y0hVaXJzb0RqTUV6Z3ZOSlRMMW1DVHRaZFB1dUx6dURJOVRkaXUzOGJFU0dz?=
 =?utf-8?B?eXpVM1ZzWGI2bEZTcWw3dUVhbWU4NVN3VytvUEYrNU5kNG9QRGdBMjdQVFJG?=
 =?utf-8?B?MGplTE53TzI4Q2lVRlAwbUxoNmdBUXNSQ2U0R21Fb1NwV3AvdG1CZWZUZE1w?=
 =?utf-8?B?MVFLTkdRY0hlVkhkOWJxRzNBNTdHTm10R1lwVDJKUXZ4d0h2RUROeGhSOEdx?=
 =?utf-8?B?RmZJdFNDd2hDOXBpbzFKYUlUTHRVRUdHODAvUWh2NElqTk0vV1MyQWVSa0x4?=
 =?utf-8?B?bHI4VEs1c29WajFzSm5aZ2dCNXVzK2lWS2oyVlZZN3Z6OSswVUVyditxcW5G?=
 =?utf-8?B?eXcwTytZeVBOVWp2QlVBSXBoMlVjYjJXNzhJKzExU0hMTFNaR0dNWUVWMGda?=
 =?utf-8?B?MW9Wc0RiWlZ1UEladU5sM2FnRFF6Wk5VT0xyMlB6Rk9pcjhUUHh2ek5oYVlw?=
 =?utf-8?B?WDdycy9VWUN4SUM4dENwUllLcmR3NlBxVVpGWEd4amQrczkxWTYvb2RsUk9P?=
 =?utf-8?B?MHY0L3RQUll1d1lweGc1WEVEL2h4WmczMktvbXMyU3hjQlNOUmMyVlhSbkJC?=
 =?utf-8?B?L2U2U012SFBjL2RHSkxYclVWeUo2L2lqaVNyT1Bmb0ZaamJJZ2tYRk5rZVJo?=
 =?utf-8?B?b2JDdm5GbUNNUkVWMzRYSUtuU1dmNktSRXFMbkx0TjZIb1UwTFVpYnlwVUlx?=
 =?utf-8?B?bHRFaEtMTWNaWjRTdEEyNndOK2VHRlk5dlhkQmMzVGZnUkZ6Y2YxdmZ2YSs0?=
 =?utf-8?B?T1JKNHN1ajk0aXJmRm9sTVpjRzhIbTRHTVg2dzhZV1IrbVc5MktQNFNoZmQ2?=
 =?utf-8?B?a0xrck11aHZqZnIzcTdVZHNoSGpRL1FDcHVxaGtlSGRyT0FtTDFwZG1qTGp3?=
 =?utf-8?B?OHpVUGxWTXR3KzlwdTg3eCt1TU5yYUFzeXA4ZkRNR0NFZEs0T1lncVAwbEc5?=
 =?utf-8?B?OWtKK2tubXpPbjQyMFdGNnB2ZGZiOHFQWkczanVueENFZENpQVcvMmtkTmRE?=
 =?utf-8?B?dFR3MWsxUXZtQnJpMVQ4VmpwTHZBckR6cXQvRkk0TGIrd3lUU2YyVGo2ekZx?=
 =?utf-8?B?TWk1SjZnUW5mQkJOYkp3bHdsY0taak5oMks0b3RhTFR1UlpNTkhocmIyWkRD?=
 =?utf-8?B?S0dNOGlIa0RTdmtweit2c3pOWlh4WTFqUEhjdXZnU2o5STd6WExOK1RQZzRl?=
 =?utf-8?B?amx0MEwyQkJQYVdEeURZbnFpbTFwTkJYcnROZXpsb3NKeWtvbmZrdUlqRk5v?=
 =?utf-8?B?c0FTbHdId2VVSCtIRkRDVmVzWGNiM3ZoN2h6Q2FWd00rN2FuOCtxU1E5NFlX?=
 =?utf-8?B?c1V2Qk1CcXFDeUlFdEtIcFVRb3o4YWp3TDJWMXZjeVV5ZUlpak4yTXpuZXdW?=
 =?utf-8?B?R3A2MXJaUCs1UHFvU1pScThrZW9nTEU0a2t6VTZIeGJBdHdxc2RQWVhWRnFG?=
 =?utf-8?B?L0x1OFEzTVhPRmh5VmtsT0lKMlVsWVRBTmUyeUExNzNycW5XSmVmZXh3RlRK?=
 =?utf-8?B?MEw3MGxadndwenpLMzJlS2ZpeWNCTnEvYkNJWnhjRFY0WDErMHQ1aFdxNkxP?=
 =?utf-8?B?bHZlNGdTektVbDJzMXZwV1lVS2k1Zm5ONCtqUlB3REdJU0VqQUplb1piM01N?=
 =?utf-8?B?UUhOV045aC9HMWRIRkI3enJqdExRUU80aDBRZU5vbVhGQUlkeXliWko1cHRv?=
 =?utf-8?B?eXk4ZEJ6cTJWbGpQcDhuNXpjRFRTVWdMRDNEUTV1SXhHV29zRVNxQnA3SlQy?=
 =?utf-8?B?ZlF2L3VpckVuaVNKZFNFaXRTa2lKWEsyUjJ6M2w2ZmtjM3IxMnBLY0NZeXZr?=
 =?utf-8?B?ZDcvdlBzODlCb3hxci9WMi9hZXVEQ3g0M2lZWG5NWklMcUVZQVFVSVg0TFFO?=
 =?utf-8?B?bzIwNHpYNThDNUVCZklpTU9DbmpFWTkxZnJGY0F0dlVZVWNyekp0YjB5a0ZD?=
 =?utf-8?Q?TPu2eyqX74GT+XBI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3zVPpBTGUExtMcYdBuhxpfwVmQfuZnf5jCff2mEcg9snmYYCwxO6tdF7WJoqterIWd+IU71idJ3gCkKGG6a3YaZ2drZdu1wnVDdy5ve/NHUdXi5xfJa74vAbFeIwI6kMgqvn4sffnSuo9RyCbbAhqDV3JXvSAv0if4dmA2zvIss89jZg1l23nZ/8DHwDcc9WetGFbKUqZ1H2jxkir9xhK4CARXpFhdMH1nGI4yn/EDaCZnYYsubw5qDBrLlmvEGaGvoX5H5RVm8y1er+d9sekIbwdMG6XymWXgQjrxVnoZT62G+jniCh9sRj03q7L/tV4B1Fc0RN/RbHLTLU4PdA72dMG9+9iTbeAnZ6MGyTTnISavUr9JEgGKe9kar2sSEmjlAeF+HQ1MjoNgaxaO0H18dAFN5HscxKo+TrclBM7Jcxzj737P2lGk6kXiAznMbS2Stcwgz0d5ru4fEhncH+BmPLFm8j8tgNM7lBmBtw6fa3ekLjouALkeYCde+NmlDrjyOQphVDZO3VLLF3piCjSuYNaiABETK9ffOGOKQ8oS3AEbzQWHl5NX4sS0APsLjJmwn+lU+3MJ3x+uqnapa8I/Zm+/mLXrwRSB7TNIA8cmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84bcaac-363e-4faf-14ee-08de7954224d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:38:59.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDHxt8Seu5nwgfeB2v4yCBs/ivnkUOqbN7UqfAXGGaVe+fANG35lsUsOc1KWZmqV5MDkLJS4thgT59C+OgBkqFAl5y0F9cAtORBcJNHebsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1MCBTYWx0ZWRfX2vNBLPoBMbZ3
 Q0mYK41T38MuJT8mM6Uphc2apLFwnHZxYqTqSwZdh4ngSvdxT0w220Rh+A1xbqiMN6R4n4leK2N
 WCluGE23Bjs1gyS8TefmZ1ABrVGJEDtf9dan9fHbhqSKA69K9nX2q4Qw29qbVv5XVk58XwlbvH9
 x6VNyF5MBb0WI7EP4yh2X6O/uCE5WC/D/edPL4n5b8jp8MNonsQzUxDTq+4vZAG7aQt2v7Ct2wa
 6eHt9zMHUCHE5Szs9xJMRpQC+z/YY729l5qtio6VJJ+BT8fnM+mZgr6CrQgtgzx5czfstfoI52r
 tII0D1XfHXxCS+vEo9D8HjelWeAzGI4/fQKJr9tZJ5E62R6mUE57nsBjkOSxtFX9slypZe9ivKB
 uD0JkmMhC6xvFeq0holiSoNb7CBonTpOqzqfDb251UFiFvoGQly4GKKmifQidru1svedc2mJxP6
 M15EfBSvWhydZfaz04w==
X-Proofpoint-GUID: htcAM2TeaUwLxh_Mzn3LTSn0MzvxHaeC
X-Proofpoint-ORIG-GUID: htcAM2TeaUwLxh_Mzn3LTSn0MzvxHaeC
X-Authority-Analysis: v=2.4 cv=GuRPO01C c=1 sm=1 tr=0 ts=69a72ac7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=HP-S6FYkPEYq6p3X8YsA:9 a=QEXdDO2ut3YA:10

Hi Edward,

Thanks for the quick feedback.
Will prepare a v2, soon.

Cheers,
Cupertino

On 03-03-2026 6:12 PM, Eduard Zingerman wrote:
> On Mon, 2026-03-02 at 16:17 +0000, Cupertino Miranda wrote:
>> The 5 added tests are copies of the already existing tests in the same
>> file, but changed to use R3 instead of an immediate 0.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> Cc: David Faust  <david.faust@oracle.com>
>> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
>> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
>> ---
> 
> I think this is an overkill, these tests check nullness propagation
> over id chains etc. For the purpose of this change something like
> below should suffice:
> 
> +SEC("xdp")
> +__success __log_level(2)
> +/* to make sure the branch is not falsely predicted*/
> +__msg("r0 = *(u32 *)(r0 +0)")
> +__msg("from 7 to 9")
> +__naked void jeq_reg_reg_null_check(void)
> +{
> +        asm volatile ("                                 \
> +        *(u32*)(r10 - 8) = 0;                           \
> +        r1 = %[map_xskmap] ll;                          \
> +        r2 = r10;                                       \
> +        r2 += -8;                                       \
> +        call %[bpf_map_lookup_elem];                    \
> +        r1 = 0;                                         \
> +        if r0 == r1 goto 1f;                            \
> +        r0 = *(u32*)(r0 +0);                            \
> +1:      r0 = 0;                                         \
> +        exit;                                           \
> +"       :
> +        : __imm(bpf_map_lookup_elem),
> +          __imm_addr(map_xskmap)
> +        : __clobber_all);
> +}
> 
> And maybe a variant of this with `if r1 != r0` or maybe not.
> 
> [...]


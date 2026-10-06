Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984E380FF7;
	Tue,  6 Oct 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307913; cv=fail; b=KLcGf4XlWAoYlpnkNav97egUcDR67Qr32cEPoZunpV9EK9ihnv3K6TupquZ49h4LPsJR1TWrGt5ub2PYS9NvAZOLsNKKgVq4eQRJXovW0l5fNYbA2aZ+9kNpkznJKlMlVP5df320/1sCMj7xPQYQCNhpYkC2JDSYO20dLxmbVRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307913; c=relaxed/simple;
	bh=PBhs8LL22BdXZ3pfSSO/1RJZAK5ykjqCCV4aSu6L/FM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxwQuxLL8AlDPN1dfcOCbiMoSttO9N5MYjrviVYO81UbUEMPt0vWui1OfdNyRo7JXueGOaZ7D0sCdygFhuF8MKEHGVspEZwfisKIPNGV0A3yPhYthVX3nJISchyN5xD4cZsmB0gKnbELpK5wI47HbBRO+ckIfxOyw2FP8yWVPwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kmm9N5JN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vfr5dxPi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kmm9N5JN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfr5dxPi"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696FXpuX2733922;
	Tue, 6 Oct 2026 17:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d7dYsNTvXL+qZS1QOJk9OcA7Gzf/KoTrBzHm+AMqsn4=; b=
	kmm9N5JNZZIfWb5g9RvuvTLpDRUEkqnV9FftQadvfHFZndQJl5Xbv4cXS9NRRKE5
	6H2rY0Dlhwchaxo1ztA1SXOFCFaTKw2EJqiTJD7Nr8IAC1fW9EKkKwjMKa+lJvP/
	NedtrShRL/hhpnCXMeEg43pp3oW0E5tv7zg6weys6pIqzzYwPOdx66/zB7SGWsw4
	rzZ+GHUBvqN0iLpJsLgZH8zKTiH58rHEO30STE4/MxUYxoM53mXVjape29qh+PVB
	T9gdpzc9IG7KpkvlJKBzaERoOEPkRRWArPpkBeunSh+TamxBg+9w8wtoqod2NOx4
	Xr8kfurR5p0GwtF22bs5gQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r9xvbk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Oct 2026 17:31:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 696HMlb0019053;
	Tue, 6 Oct 2026 17:31:17 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d4vxh1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 06 Oct 2026 17:31:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNQKj/9N+yl/acFa5Fu/BkF8vCia68zfK+0OJab51k3CiYyMA2S/xZTnCrJ7WpFYykgbxh0Rl+qQl0VTrxhf/bK85w8bQZO11h4tDcgKzkYxIBPf18WKvTWYmamOCfOaaeFqEOSo7nmCD9XfYl3UWWopoOFmOiKEmGnHopvv2s7aiFJjCeXv9YSdRF22ZcalWHByE1ASx/EeUz+MZtVHTcovfOfzsfAiRF9t089JsDAijM09DEC87NCTBsX2MHopDC2WgwKtXacDKzS1FY4OaznE+x9KPiqsSZLtkX7+KeTM4+xmehVeLxbwsCeWRnEju/f4qKG4cwQjljgWxT8j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7dYsNTvXL+qZS1QOJk9OcA7Gzf/KoTrBzHm+AMqsn4=;
 b=i8/j+7DWswGDqXDxUBOk6dWbJHstB1t65DiURCs0xpIuBqZ0jMmG81MmUEEhXlK0mhVABhTmLuAWGeFpsprlz/DI4r4DWh4TZZroi932bDaryqP0FHcWN8sadJVgt+blLsMgmtY2E93vfjKN1jgH9IlZACSSiuCpRyK9Mi65G9FOBLYK/LhXqpYHO6EdXSTl3HrfYdchOTioqBJicUVceOCCydVNrZ3TibP+Rs+X696+1JUGbR/lNCnM2L1AQUVxmSfBXXroE50JdLTa6XRekyHfBjDw949pJhrGeu5luwAQ/YDGf9IQvlIUoB+ZD2YDlU6+1g4FIZ18LkNs4oCmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7dYsNTvXL+qZS1QOJk9OcA7Gzf/KoTrBzHm+AMqsn4=;
 b=vfr5dxPi3lTQd7qMKnUArbjRZeY3OnoOwmGbEtn1pTFIEZI9m0O6ECDcRh0yY46ceZJypljbgv3ThN2bT9fS19c5BZG12SdOjY1XqAq6W2Gt+6LKuWGm4G3U8B/MnusJBDowncQpoH00pVLjsFMI3QmYmITSF21S5Y4QYAMWNUM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CY8PR10MB6683.namprd10.prod.outlook.com (2603:10b6:930:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 17:31:05 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Tue, 6 Oct 2026
 17:31:05 +0000
Message-ID: <2734b5d8-b16f-41c9-bd34-467f15cf4e78@oracle.com>
Date: Tue, 6 Oct 2026 18:30:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/7] resolve_btfids: Build separate main and
 inline BTF objects
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org, martin.lau@kernel.org,
        mason@kernel.org
References: <20261003194323.817885-2-alan.maguire@oracle.com>
 <56cb8412ae0f25a42289986ef6005a01b17dcc487692d9d21ae6de977eaee66e@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <56cb8412ae0f25a42289986ef6005a01b17dcc487692d9d21ae6de977eaee66e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0004.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CY8PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: bb093207-f0b0-4dfc-eb2d-08df23cf995a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|18002099003|4143699003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LHsPcNRJS1HPm6G3QIBzGyEVaA6xQ1EB9/JE90wABOJTdM7I420OhBlotELk7bWt6RHhd2iyni1Zdxrpkyjm+ZtUHvP8DSpgJDdtuxccxeQZnrDOlly0Zdc/yFKGmx2B9nPiK+F2U/ItsKhIgzPoDrXW4mtdNJ2giYHHJIrme3QkzgacClPMWOHk/qh9YTuflNFLfhyaogjsPpeqlrMyV0tv1J4QWBdHr4Hr8X9CJUdYgtcx6kT8p7+LuSK9ziu59N5oL2NAWEWtYKWN09dTxqUXeZQltXInzB2mMjmtOt5rjOgmQQLORXRSACde9nzo/I2ga6uRyL+7okqYg/HZXrwEtrNDA4kSh323zDkfFGJ2u4QV7wEhCboxP4u0Pxvgqzan7mPAUIho+rQZHrK32XsizNeOZdVqF11TpQI3bAVNkLrSorwUXPWzffFFSZFbKuVlJL2gSQ1x1KVjIe5GZeq5DiViaWtHhXDtIcigGM3kRurXwpxaPGgP/iLy3riYcvXqTBN5VlyKOlEj6k7vUrVUALaFKFs0NEBAndAchlLXRvMx94gGLnCoFr5mVEHOqQnmY9Djr3O+R2XYe7XiXvzsJmNLcyvGkGgQwFVXsEWTG88zyjXpwW4yC228oV8YoRLSMesfxuzo+sUgxhayrLIKwabECv7MlDAAK1neCV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(18002099003)(4143699003)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkorQXJwNXJhRHlqWEVoR2k4WS9SQ2dPNm54Vm1WZzhTdXNCMksvMFZZalNu?=
 =?utf-8?B?UW4zVU1oS3granQ2TEVwTTJLVTU1SHV2YkFHV1o5NG92UFlJbkpJWGc1Yzc3?=
 =?utf-8?B?d1NxZnhKdG9GVUk1ZGk4OFpGSEUwcnlaczBvVjNiZkgxNUtXSm53RmphaTN3?=
 =?utf-8?B?eVJ0VkFnYnhRZWxzQ29pb3RNblFCNGx4U3ZGV2s5K0x5STBoRmI5NzArRUZk?=
 =?utf-8?B?RzdTZVR4Nm42VjlFU2tlcWhIRGlyeWdrQ01jTEt0UXlKUnNpUFhsU0IvZFVT?=
 =?utf-8?B?WHk2SERoNHgyMHhzM2hKVWdOVlpMZ3FjcytZOVlIMllkS21reStjaWtQS1Bn?=
 =?utf-8?B?cnN3Ly9WS2V6NDQ3TURVUlJaeUlNMnk3NWhKNEtGaGRjODIvTTg5YzdnaGZj?=
 =?utf-8?B?d0M3cUdlU0VwdGI1ckFBUlV5R0F2eWtHcnROWS9TMlFsWkR2Vm1HK1lkRlB4?=
 =?utf-8?B?d2FOamVMcHdKWFp0RUNjVHJOVjFDYXJubjlqZUJGZWNZYWhzK1oyR1dDNzRT?=
 =?utf-8?B?STVhakJlS05UcFU2dmMwWG5KaWF3VFNsRHJBbW1pcXFXK3Q0bjByZ21mWlNF?=
 =?utf-8?B?Q3d5YWtkSnFTNjJVOTlYWWkzZ2oyR0F5UVBkNVcrRU12TW12OVQwT21IMHVU?=
 =?utf-8?B?NmNKNVc2bENnRmc2Yk1ZNi9CZ0ZKZE1KbXRpcGZUSVQ3UkRGeXdKeFprSDBZ?=
 =?utf-8?B?cHIzSFhidGRPaWVmK29LT3Nsbi9ZeDNvV2RQOXN4WW8wZml3ZktPVVNISzRV?=
 =?utf-8?B?NE5rT1V3QmRXYUNDY1pQbDNiSWFDMGNBMjBHRnh6aUpUb3JHc3hYU0txVFRh?=
 =?utf-8?B?SjAramtlVkREMXlpaTlYZkxQRDBZQkdwRXNVL2c0V0MwSWJST3FnNkF6NERq?=
 =?utf-8?B?S2ZxTlBWUEMxbTNOaUlmdC9yNUtCTjlBWkRiLzFmSUVXYU5HcCszaEM1cmxp?=
 =?utf-8?B?dXFDa0ZJVVoycDhBb2o0RmlMT1dlbDFncTczaC8raFlVVE9xK05FWDh3K1Q2?=
 =?utf-8?B?N2oxQ2dDVnBtem9ScEJPcUVtTUtxVDJaQngyYzBicTR0RDBBNHhoaVp3MXZ3?=
 =?utf-8?B?bEtKSTVRMmxTZmlYRjNQRkZ4emF3UzhQalpDd2k2RWptcmhLUWhsU0NDMVds?=
 =?utf-8?B?dkZqb1orM25FQVExMjArNUZWcTVEeWpyQ2cwMDRVZ2hFcFlUV0RDdUpwSWlT?=
 =?utf-8?B?OTdDTnZiYXJWSXFhOTRIbU1tU2tqYkhBZlQyTzFjUW93WVZLSG83ZHFBNXBi?=
 =?utf-8?B?K1dZUmR6NW50UjVrLzFOSTZTRDk5M2JNUWRmQUNuWEpFeklZR2hiYlNMdGgz?=
 =?utf-8?B?YUFYV2t5VFpiWXFuUjFiSVFyN21qdkNsdVlLTDJUZ3FaMkQ0MzdjZWlraFJO?=
 =?utf-8?B?bTIzY1NydnFtQk9RSzYvQ2lJRTNQYU9NcklhaW5FRG1IMFhJZHZoSE43Si93?=
 =?utf-8?B?UDlLNWxzMStIMTg1dDZyNTE1OGgwMWM2SFpwZlVVQTJtMTNlYzlTSlcvb21z?=
 =?utf-8?B?YmYxL3JhT0dQRFJjSVA5Z3BkME9tVnQyZ3ZiNDV2dHB1RFhDVi9JM2NnRks3?=
 =?utf-8?B?M29lTUpPWHIrMWhhNUdSSU84ckxCRWtoaFlueEVZbnNSZ01OZ0k2bk1Ba0FL?=
 =?utf-8?B?WTdsRkRVRWRQOU9hOVZEdjZBV2FWYW5TTEVFbGdoYkdUdjdQcFNWMEVqc2lR?=
 =?utf-8?B?cXp0Z0xhNEdHRUNVOTBpMSsvZjFFZnBKNU5HbW5UdU1jSkJIYUJReFI0SktU?=
 =?utf-8?B?NVdnc1FmeUNURVBBRno1MkpHV2RnNE5wUllxZE5OSnJtbktWL1MwWk1Qb3NB?=
 =?utf-8?B?V1I0UVdVLzl5WTlpWFl5UTNWYTM2WUliRXpPZFZUeG9CbDBsbzRWL1RRUzJZ?=
 =?utf-8?B?TmRCb3dMNE1wVmFGaWliWmFEalQ1OGhEYkdvNHBMU0xSb0RvMTFHeXU5WHZi?=
 =?utf-8?B?K3puaWFWUytjU1FtMlNUclpqVUdPVHVsRXRFUW1uOWg4NEE1bHg1T0FkckdQ?=
 =?utf-8?B?bi9WV3M1NXpBUU1Zd3k0U0I1S1poenI4SmNBeEZ6VmgyckgvdkR0RnE0bzRL?=
 =?utf-8?B?RG9JektRRThQcjZhYXBkZGdOREhZamtOZTBUQjM3dnFwTk1yeVJ2cldxSmk1?=
 =?utf-8?B?RWRhRFBvZnhXcjdCTnlrWU8xanV4dVBCc3Q5WTJYT0ptV1VhM0tKbURuT1ZB?=
 =?utf-8?B?elNzZ2dSbXIzSVgvVHhnSTFQdk0xb1Y0R0RLMEM4ejI2TXlnYXZCUE91cXVk?=
 =?utf-8?B?ZWxMcmlORmZ2QXB6WCtwM0phT2hFalY0UnN5aCtJSCtLZGZWUTNnSnJObVZu?=
 =?utf-8?B?aENRWGdCWjhXamprMFRlbEFPZ1ZVTnlqS1BYOWpyeVNmYzJFZXdDUT09?=
X-Exchange-RoutingPolicyChecked:
	wkN2V7KTLMU4fm7rYbCvIowLla8aR2+VOl1rWC75oZdDg9thtCtQAfEY7vgY2nKGJkpZ3ohU8dGE8AuIx3rG+uKHHrM1HNchXkRQaa05ujkKKd+r+3i97apSUJNVLXh6llDpzmxdPqbMeg9hOWejtRTU3VwmGFW4teFLal3IiOsbqekmN2sNNbqQtj5THDYknG5PzbDH2IGU2dSH8Fc43hTzhYAH6aVtZUbdLXrBbMDh3RHdahMeD6y28fvdiPorKNfq/FKmhhR6SJStobxu+oHupfx+NqoPG9aQZogyWMcpjJZuiasqRX/CWpk8q0HBBzIjd+VaDDtmm+29v85OoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5eXFgt189j3/z5wWM0hQDEwsNvvqg/R6y0rhwHuUb+ZWIhFq+6sKq4aOa4UlzeMSigLuelOMusD9cwID3odPpTNq//IC+Hym8FZ59jlulH4fRHj487KRAH527Nij0zYcvPZYYtSFr7+Zrd3aG27S80FD8HGca3JFib7XRukf4d3CZDzPgxi0aCJMi0QyMyAi8pRew6PqojEAZFre4GSRWglnBfw9OKBVKEM4Ps5SHFMipFNXNia4r2vsl5RnytxvaopjRMpUth/qU2UFPyTrEGQYP5Jxh2E+ObMUSPgg6b3L5TE01Tl4CfNOCxWV0EDsaW1wLchSnlDY7eTg7mrzT5sGIwWMA1bgkM5afq47TNcHIBdYyUl5Z1n/FMjeGte0k6ogHtFWLK/33Cz8Qed4snKvxAcFJbvBIRqu1idbjjxoweL0aihsRtkDZQgu1Y8lFuZeOw48cNDBIneXsEC33XueaYf4fnQTTOcL0vEYPUMwv7LQFCxFoRirmVIBSnQpg4mehHiKYQrPO2CyGdxQdZpn782BrA1VwGRrqQGAiavPMRCARPkrp+0jEWJklfnsPg1mNXAEwQ+au0knWfKcCIYhE+y0nMl0Db6iMFcm/8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb093207-f0b0-4dfc-eb2d-08df23cf995a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:31:05.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDryF2H72HHpHZCUsg4myN1V/TtHwNwk3IlJ9g3rUAVFfZMCmCHg6Vi3giV73JWKj+CttvE6VSRvu5HrO/Y6gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610060069
X-Proofpoint-ORIG-GUID: pyAWxBykGRVkov7aOVXS-og9ukZLZDKV
X-Proofpoint-GUID: pyAWxBykGRVkov7aOVXS-og9ukZLZDKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2OSBTYWx0ZWRfX00TTGCWRGPcE
 E4I+MCiCXKMXou6Tk4rE1BGKbfqR7WbnQvgmklrS73zVho1wlWedAEHklz1l00m0wHGB3W9fhiK
 wi8y+nX8pX80TbDS9uEUSO+PCR08XOlzSBPW3kCmH4i7Iz5DEuBZgCR4ZFRIO5+9qalhllGrfFa
 enBFmNRkzRIWoSCsi0csC8lwDW1YNruAISZQi99b1++fj2fJjzT7XDChx2IlIChk0dlAdnxfZ9I
 dmec+4DGJDF//2W9GhxZv+Fx28OJeG0eC1NwlR8VBZTltdhrHAlQDtHqk3K3OELbyA9ZrN/3v2G
 n8B/ZZkqUTCDfBN3xOl0b3+Sfr8WqZGxGgur09AjxhAXHs5h2nxVp3SRLR4Zd3q4hy9wsUd4QVz
 Te3HbrRD+fJQQ7XorgSTklEjboVYKGSycVSz4XR0JIWwPakrKpH49mNlla5/BNiDIL2Lvt5j/oe
 hnFfXeIU92efEZruCgTQMic2M7ODBxAS065j6EQ4=
X-Authority-Analysis: v=2.4 cv=QbrzLcbv c=1 sm=1 tr=0 ts=6ac53066 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=pOejTwQ38XAPRxKad7MA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2OSBTYWx0ZWRfX1rxWRJfOWSiq
 jHaO3TvRWRYy9yi/Xq7JRAgy3DVfxYgr/BVXUiOXpKZOoeEsVqLiOdRbc+zAzp7v2eMWmyqBYWz
 k90aW8s0MY3+kJeALnoMiCzoAAPiFQ9Gx3DXJyLmQHyN/pWz0KLz

On 03/10/2026 21:27, bot+bpf-ci@kernel.org wrote:
>> resolve_btfids: Build separate main and inline BTF objects
> 
> TL;DR: In resolve_btfids --inline, extract_inline_btf() may free a base BTF
> that the new main BTF still points to, causing a possible use-after-free for
> modules with .BTF.base; in-tree builds seem unaffected.
> 
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 37d7e7224207..dcd289d16faf 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> @@ -1510,6 +1569,85 @@ static int btf2btf(struct object *obj)
>>  	return err;
>>  }
>>
> 
> [ ... ]
> 
>> +static int extract_inline_btf(struct object *obj)
>> +{
>> +	struct btf *btf = obj->btf, *main_btf, *inline_btf;
>> +	__u32 type_cnt = btf__type_cnt(btf);
>> +	__u8 *colors;
>> +	int err;
>> +
>> +	colors = calloc(type_cnt, sizeof(*colors));
>> +	if (!colors)
>> +		return -ENOMEM;
>> +	err = color_btf(obj, colors);
>> +	if (err)
>> +		goto out;
>> +	err = btf_split_by_color(btf, colors, &main_btf, &inline_btf);
>> +	if (!err) {
>> +		obj->btf = main_btf;
>> +		obj->inline_btf = inline_btf;
>> +		btf__free(btf);
>                  ^^^^
> 
> Can this btf__free(btf) free a base BTF that the new obj->btf still points
> to?
> 
> btf_split_by_color() creates main_btf with .base_btf set to
> btf__base_btf(src), and btf_new_empty() stores that pointer without taking
> ownership.  btf__free() on the source also frees its base when the source
> owns it:
> 
>     if (btf->owns_base)
>         btf__free(btf->base_btf);
> 
> libbpf sets owns_base in btf_parse_elf() when the ELF passed to
> btf__parse_split() has a .BTF.base section and no base_btf was given.
> 
> This looks reachable with "resolve_btfids --inline mod.ko" (no --btf_base,
> no --btf) on an out-of-tree module that already has .BTF, .BTF.base and
> .BTF_ids:
> 
> load_btf()
>   btf__parse_split(obj->path, NULL)
>     owns_base = true, obj->base_btf stays NULL
> finalize_btf()
>   distill is skipped because obj->base_btf is NULL
>   sort_btf_by_name()
>   extract_inline_btf()
>     btf__free(btf)
>       also frees the distilled base that main_btf->base_btf points to
> main()
>   symbols_resolve()
>     btf__type_by_id(obj->btf, ...)
>       btf_type_by_id(btf->base_btf, type_id)
>         reads freed memory
> 
> Without --inline the same command works, because obj->btf keeps owning its
> base until main() frees it.
> 
> The in-tree build does not appear to be affected, since gen-btf.sh passes a
> raw --btf file together with --btf_base, which leaves owns_base false.  I did
> not find a fix for this later in the series.
> 
> Should extract_inline_btf() keep the original BTF alive, for example in a
> field of struct object that main() frees after obj->btf?  Alternatively,
> could it reject or handle the case where btf__base_btf(obj->btf) is set but
> obj->base_btf is NULL?
> 
>> +	}
>> +out:
>> +	free(colors);
>> +	return err;
>> +}
> 
> [ ... ]
> 
>

legit issue; we need to keep around obj.orig_btf for after coloring to be
safe. Also worth centralizing all the freeing of btfs in the main out:
path to remove a bunch of goto labels and adding a comment to note the
importance of btf__free() order. Will fix..


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA57494828;
	Mon, 28 Sep 2026 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589675; cv=fail; b=brgUTBvtJ7oAymOkG+gcivrlKHaO0q26uCxYOvSBelE2wnGHbeYaJyt+zFQF+TSUfg9dMJji7wkJd8yd/6+bGp1L6PEG3J89KzAEo13kdkHevE9t2JQI3/avy4f/pRFF9CDNl20tTz8zA9FvRiSzH3fG2p8zw1CSXZeWfKH/Q5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589675; c=relaxed/simple;
	bh=7Sn9j36QhHi/DWAMLuI4FRPu5Ihpd8xZD62z3FXdhE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hnGYqgRrNN/oUNWX8HOWd+B395kPWOfAy5Tn3yX37/YVaq2uahIxe4RSYb4ilb5CAJjq7cs7FWakrVrmuO5QQTpZLidQlOkN6P+/TGP9ln/EQi4FrHbdH1W8dmAuHbXKXuWitPAoR4kArXeDFTQljv4T2vFvdO4LoGcOXxdRwu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YI9RcOZR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iEKrKFeU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YI9RcOZR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iEKrKFeU"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S6o1pV622574;
	Mon, 28 Sep 2026 10:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DZv7XpA38n5dvowCJvB5jH68RKvM3HRm3+Htkp04lRo=; b=
	YI9RcOZRogPfZ4DQljSf+xGxzIoL4qM7+aUdJyTedDEtWFcNXsYEx9QXR9A0unS5
	d1GFTA1RivqQj+kMM9NUi4prxxoT5uQehEcuAPg8oem0945adcoZ5lq79r7CR8Yw
	9dh8bm6HMNRGWa8akzF3Zr8H2syuz2aDXNkvuK2TGmSjLncVlt4TsdHk4F03hQ8f
	widM+iLoGlCUAzVEkbIAa3c0PfmvU/ZEIW9OZgU++HJ4ddqMXYt2mFAmvIV3rQ9H
	krw3CG5QV84pRJfhsc5nTWQh3ntND16eUIoknBOx/gtgwJb4YVgJJ/SvyjfnIIH8
	MiPNxHaLIOnuBkYUqXqNwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5x72bvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 10:00:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68S9nvxM038221;
	Mon, 28 Sep 2026 10:00:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gaem47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 10:00:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8E3pVv4V8AoO/TinLCabjlzz+rzDPWxZ/stVOJz4yMBxReUkDAT/Rv0X1j47zKETgszke96sIU9A4kf4cbXPkCNSwGbwz4XFS8Vl6XFI8bkxt0mO2w7I6I+EZpc+SIpsKzzZWAJqRTNhskOT2ijr6hYHGeHmZhZzHvNYjZ4fbHK3b7ywdVKW4BVCdeOWAwZysKH7+UwQaJEBljx5tfth5HT0JYvOHzDYGymnOpsB0yiiT4ZPMVoMGk2anqNCl5We7HAUsLYjZLVq//qeIMoRSgQwr9wLnw/B2Ea5x15TXHFVPdqiYx37Jvwa9151y1uiJg//bJpFIm0Hl+WcBcGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZv7XpA38n5dvowCJvB5jH68RKvM3HRm3+Htkp04lRo=;
 b=ZIf2urrPIYSAZFe+qI06vP4aY9BqiNw5G160b8uJJbTVRcXenq19SXm4jaECavYvM/xWOHWhOzguc1xR+gplTzDqMWOmslWtBsJIQ4zb9AtKC05KDwSq2FLQDXihclp0uR8osrx8NsOPGgcex9d4p8ZEqdRafc4aCwQixk4UXjosjB5yZh34nL3/eOyxjOXG0S/vGDJRkHlSCHsFphdMl6c6oNyguUcfRhTor4rziwjUFyvODj4mw8meEtPsH3r6LiJWKoWAilRNAiO9NjX0Ex26N8BhlPu8pcU69RWlIYh8AkKwDhLCtSe7gVyxPRq4eL8rrXGA2BGN2C3i1B0SpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZv7XpA38n5dvowCJvB5jH68RKvM3HRm3+Htkp04lRo=;
 b=iEKrKFeUcHUVlWxPHex87S89ABrZNH27BdYeGXoFTEapqYYu8HNsLsy5icArPgE4hBE8w9s2hsnAXF+s4e4mczmF+p9yUw676bxLs5yorIwZGXOVLERvRUg+vfSu9XcWh4hETbAnfWRjLNfyMKXeNYRHfUfCBBd/UJ/ONz5yFFI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Mon, 28 Sep
 2026 10:00:27 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Mon, 28 Sep 2026
 10:00:26 +0000
Message-ID: <de28ce03-67c3-4a03-b452-80b92cdfd243@oracle.com>
Date: Mon, 28 Sep 2026 11:00:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 9/9] kbuild, bpf: allow building the vmlinux
 BTF as a module
To: Jay Wang <wanjay@amazon.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Hazem Mohamed Abuelfotoh
 <abuehaze@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>, Martin Pohlack <mpohlack@amazon.de>,
        jay.wang.upstream@gmail.com
References: <20260925224229.1850-1-wanjay@amazon.com>
 <20260925224229.1850-10-wanjay@amazon.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260925224229.1850-10-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: b39bc21b-1d29-47df-8a44-08df1d475197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|5023799004|6133799003|3023799007|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	G3eJ4aYBRE0vc04sHTWuh2FnJ0M+JYrwgcxWzEcIVCOXr1AuTCOk6qs0BEndwHDeX9nYI/YbfjL3SNgsvWtCEfvms3gdJZd19qdWCYLis6tqH4HYP9zAYkykmyGsWJ1ir/Ko1PE1D4eiSPUFQcjrl5GR8rveBvW2qyfd59rDGkzI5J1+SII18pR7/Qzf3XkPgSL6vzWrUPbH8owVJYwktjzQ1qOQH3lmhHw+JRJYvo5SalQ4L2ZOPI3LHL7szvNgQ+fTH9ZsrGEMkuVpCQRpA1IV2b0nDp5iBjBfcPO9OQ8emW2EVGYwQuZM5cOlOL6FmdflveiUgQAAXzaOE/MsDfKPc8uWWalquVX8x6pozBJAmjFw6XqJAJfZ8Lxm7x3m4iBy5lUflu0xxacyrUUEXSJKZDVfd9UIcIUYvml1/rIrsiWQO44Cv2wU3aCI9GPkGLHfsEENMKSiQI0BiAQsu1em2Kc3JEUnKoXC6Ib0Wg4Uo3ksiDCJKuZFoHfCcJ4iNJOU1WYcZkAYzcZZe6sVA6GpsCyQ0pqE/zX9txJbENOo/OWQk3kWDdTGbAi3oWGcC0M/iApFGRjwuDngQYKjqjgegOvVKRFjcJBvOhfpFxyeiClOAhWB1sy6RHyS8nX1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjE3UlpsZ0EyMFZNSGN4bThQbnN5eVBpU1M1WURHVkNiWUdOYnlGR1JOMDEr?=
 =?utf-8?B?TnFMaWFGeUtaNGdMbDVpdFRWVWJOQWp3NWNGNE05RnZsT3ZpWWdQSWkxeElu?=
 =?utf-8?B?cUVnRjFQTHdpRjIwQUlaT05iUnBBenc5V3lXVGVhNGxJU24xc2V0djlzUU5p?=
 =?utf-8?B?Z1JSekt3WjJEallBeE5JRjFCRGhsOGkxaCtlKzZyZFdsWjlzVlFwYlNVa0ww?=
 =?utf-8?B?MVRLcUdkTWVxNHArK0Q5WVFrTUh5ZHpQKyszMllkbnZBVmk2dHlnY21BWTNQ?=
 =?utf-8?B?OU04L0R4ZWppQTFwd3o0cmNpNm1JTkd2cGVzaktSK0FmN2Y4OXhuLzNnWWhj?=
 =?utf-8?B?c1hqSDVpZXVRZDhVdW9jUWpBNG9jbitPT05RMU9SMWNJTDREOGR5S2ZiQU9I?=
 =?utf-8?B?ajBvU0ROK2U3SXhkZ2c1OWNpWTh5OUJMeW1yU1FUUU01UHQ3aVBpSkJEdGps?=
 =?utf-8?B?bFdhYkYxVWhIcys4ME5CMmJCWjhFNGhXOWtseUVJc0Q0ZDIybnd1bk5Ha3Vl?=
 =?utf-8?B?S2NXb05qT3BmYXhSWU5LYnkxL2wxd0xCM09FRU5BYkhMdzd1VjlDMVVtWGRv?=
 =?utf-8?B?SHAyUTByRWpqVk43dWIxbS9LNnJnYzNtT3pYNUlsUUx3Mk1TZXNLSzFBRlp4?=
 =?utf-8?B?RmdRMUlEWjJOUkF1WmlyV3VuQVhWUTNaTUV0eS9WRWo1Q2hiTy94aDd2MWgy?=
 =?utf-8?B?a2NjbHc3a2hIMkk2R1gxVTU1MUVNYkhMVW1tTXhvWTVhQnlDazB4cHNiK0ZO?=
 =?utf-8?B?TjFNSDhhMjBBRFFFS1ROdU5rWm1Wa2ZkczluR0Y2UnUwUklHc2hWRFAyZGYx?=
 =?utf-8?B?akhzN1JvUVlmMm1QMGZudUltc3BwaTNTT0xFRnNmUkpUT0ZWWldncDdtS0ZQ?=
 =?utf-8?B?cXFQSmFLeHVGSCtvSnVMNE92cXRTUW9nTkh5OWdoT1p3MkdiUnFlY2tZMk4r?=
 =?utf-8?B?UHhFbUlyc3NGYVQ3ODhQa1NkR2JnMkpxTVlMSzdsSXhYekNRQi9rUWUyU0or?=
 =?utf-8?B?NnpicUhRUDRVTDNmL05uWUl0dHYvYmdZOEtHdWFKZ2FCdm5SNnF6QUc5QWQr?=
 =?utf-8?B?bGt4Skdhc29MalFNR01FM1dlNlphY2M2eWR3Qm4vL01FMGRZbzdCTUJtUWJu?=
 =?utf-8?B?blUrSjVrSFJmTHNJVmpUbHovYk1UNG9hOGpSa0dnSzJTaVhwVnE1RkY3dmxp?=
 =?utf-8?B?bTIzcTRZVFovUEU4QlNhOFBTd1YyRWZPQlh2OHpnL0xZNkl6YVIvd05qMkhk?=
 =?utf-8?B?Sm82b3BvM1RBRy9peE4weG1iektYV1hmVGQ3R1J3WWRub2xndWQwRHZXRjAr?=
 =?utf-8?B?cTBHTXNGTlE2dDJFMkxVZmEwV2JYZDE3VkNENTV0UWlKL1JlMVByNzZnQTVO?=
 =?utf-8?B?N2pRbURlaGIrLzZnblZkdUh3eVdsRHE4dzZTcVFGL0dKalBXdXhBc05UbnRG?=
 =?utf-8?B?S05OWjBNL3owN3IybTFwZElxNldGVUVmL3F0bzc3dzZHMlVZb3ZaL0owTTBx?=
 =?utf-8?B?STRxbGMvS3djdjlWY1RUMkFzVGdVL2Y1NnM0T1RSUTF3MElCd20yczJDeCs1?=
 =?utf-8?B?SHJLWjJrd2l0ejlQWk8yYU84Z3cybGxjSGtGek5WWjBjOTFkTFpkWG1BUHhx?=
 =?utf-8?B?cnh3OUtIcGVzbjJGYmw4Z3d4Q2MzNkMxT3BoNU9YWmw1U0FmL1lCN0F3UGhR?=
 =?utf-8?B?OWZlQXB3ZXhxOHV3VmNnbmhJbkFaR0Yyd2twTUx6RklEVi9jYjFFdFN6SmVm?=
 =?utf-8?B?VE1pRHZsMWo1cXd5TzVWekx5dTgrNm94V0hyajdBaVpnZDBweUZ5YTlsOVor?=
 =?utf-8?B?OWhJeEV2ck4rZmFmaXhPd1MwUnhvNXBjWkFkQVQ4ZGR6dkUxRis1Zk5scE9J?=
 =?utf-8?B?VTZEcVRhTmVzMURvUnNGVGhuYTZnZk9ieHRsZUNBODdCR0ZYVkdvMkYvdk8w?=
 =?utf-8?B?eDFtWWRxSjJQb2FudHJhSHpzNk8relNWWEhaMURJTkZxeExZSWp6ZUlTUk95?=
 =?utf-8?B?dEdQVDJmM1dTWnoyVndvSHo4VC9Ra0t5Y21kdDg4MjEzN2cyWHJySnJ0WFVB?=
 =?utf-8?B?enZyam1OQTdmdEVCTnM1SkNVZ0pzdldjS0FSM2VnL2Y1ZklrUkc3dndyLzdG?=
 =?utf-8?B?LzdDcmNwTDBRbnVReDF2UjZqUFYwLzdaRjhJZTJCbUtQMDN0SlV6cXVJdGhO?=
 =?utf-8?B?S3BTZGVuQWFYRnlQdkRJR25TYWViK0FYSEFUdnA1L01laE5MTE8yRUNtQVg2?=
 =?utf-8?B?ZnF0WmxMNk9JQmN5eVNGODBRc3g0aEllZ2tKaExLekVnV1Qyb1B6SVRSbFVB?=
 =?utf-8?B?TndFU2ZPTk5TMzBmNmkzVVhaMTcrbTFIMDY1ek5xNnNYNGZZTS8rdz09?=
X-Exchange-RoutingPolicyChecked:
	dJsNJ0/ahUYsBOXxiue8c/ei3FHhBE9bX2QvU3v5qurwQA4UC0RysaLNViwE52ZclWt+dvdnDHEfMg/9qi/Ob5zUPkvLUbRq3HZ2WSdqwg3Lh2NyGPW7GEPXRkEwZH5On9adsblDGqUWjt8ItZQ0IROJ0MS1AUMEhM67CDBzQ7setNVQIG4gKszG83b+AxgOnerFFJb3O2YrzYAlhh5LuikY2j9/PFmRTsV8SPWwtsq82jGig4bst7k7HCXWDtMKHPZvDmFzfcSSHr7t2QJoeeKA9Gkn2iGhcJ2UGvfdJz1Gr9fvPmeLEAQQtzQzhOuVoM3vCQCYGqI4COwqTylMoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V0ugTFnjtey8rjQ00xNl0e2VfRwHZbh7JlBKyKdewMoOmfuR54l8IhHPyOqQ/qO734iAqykKlTRVEUWScr8D/bghGNsulZ1ADi4UVoSxl1gG58hsFF1PxWhLVR5Agyu2u7j4Ksle4d/C/xHzbI84HYGUzV1KPE589N3d10mRmLuY6t0pei7bCSc2+E8X11FfKr+5xZcfwegkGmKUcHrEICYI5V0c43RG71ngbQd0YYrNfq87tt8g1L15Z0YdBBVQlq5aLVqxHnyQV3jdH5sST2UzH8rnp/ezqmKK4g3d3CaLxCvfSHtY3xG7XSfiy+uD72MADF5EBu24uemLfjQH2B7TRD2/+IMAQBIiyA8LUx49FjC/kNf/CoLUw9UeL9LyP9ZsOIw1etvWW8BrpbubxPbByHVjY/L3mnyaR3o5gTctIZ5mRcN0unMIeAzacLaRVVMTYbn9qxTcCY4DVI0LO2qfZhrQEUWhaUzoXIX5dkwYt22rPhhu4r0AZ0A/Xh53W4fn49bw8Ty1RKcb7FXf5ewg5Py4wGUn+NibVyZ3lHmI8BAWVD2Ng6x9eQWidiRh40HFq1Y/RTi+BwutwMWFpYINSVI3Rsl+RWZQLyUQ1vI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39bc21b-1d29-47df-8a44-08df1d475197
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:00:26.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxg0CEDI3q95xWdQJEi6A+Afqx828ifRqbARDPiBB8DKi8yOPAk0p3mjl4iz1LJHpVcRGdGpRooVpXb5w/emNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609280039
X-Proofpoint-ORIG-GUID: FARTbnFLjWXB_ujXP0ug0Qw1QQOrwPUm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX69W4JdQx7xGU
 IS/rcCej6WvuJ9lU0/8RL8ewYFUDfCjtGAwlWoZunlGuLki9Lcw4e0U6iC9SbGZEWbxlggQloBo
 9iBYILvUpkhY1UyyPfcJSrgxp8o6nY2MRcV7SHnb3m9+IIt2qEZg
X-Authority-Analysis: v=2.4 cv=CP+/zhrD c=1 sm=1 tr=0 ts=6aba3ac1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=CCpqsmhAAAAA:8
 a=vggBfdFIAAAA:8 a=j6eX3ATJ6R02_n907lwA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: FARTbnFLjWXB_ujXP0ug0Qw1QQOrwPUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX3S53C2mEWfds
 XgE9NgON1Vl3kqV1uSEC8J47fTzZ/D/vLrISvPQcZlYoM7Fwtz0187Wt9/qvP17ZGPNkCG8qFLQ
 TKDnKYY7qcFryv8NGn7PDcqj/wdiGSfuADZiJD4g8yoJsiGnUWDPpSZxXC8u+VLRd3E+3TivTXu
 TFLlq61I50YzUkUKL1YFfBx/WbamAz2nnJPylCfpKa+nE/5ZukAiZfNHNrL2jrpJWclcfeTBbCm
 F70m5tPSRiFhCZuPskqwXPu95bRDoXzePjrvMfuk5q6WUQHFx3WYAdYCBw5/nov5U2pjUgKGS6r
 ShfjN3F/dXofT4TmVzHTk1mp0ZJ4D+JAbYiFFclwor/PX6jWmoecXF015NVhQEAKXIg3+/Z66wk
 vO4MY7WlV2WPXM1RiiHpjoD7LVny30gjuIj9OCIxjxBY87sq9ywlC1IwqPbZnA7dA/23WOumjzI
 7ezGhDocApgNsoo3qWg==

On 25/09/2026 23:42, Jay Wang wrote:
> 
> Make CONFIG_DEBUG_INFO_BTF a tristate.  With =m the vmlinux BTF is not
> part of the kernel image: it is carried by a new module, btf_vmlinux, and
> loaded the first time something needs it.  Nothing that works with =y
> stops working; the 5.4 MiB of read-only data (distribution config) is
> simply not there on systems where nothing uses it.
> 
> The only way to save that memory today is CONFIG_DEBUG_INFO_BTF=n, which
> a distribution cannot ship: one binary goes to every user, and off takes
> BTF away from the users of CO-RE, fentry/fexit, kfuncs, struct_ops,
> sched_ext or bpf-lsm.  Whether BTF is used is a property of the
> workload, not of the build, so let the first user decide.
> 
> The BTF is generated as before, but with =m the .BTF section is linked
> as a non-loadable section (like .comment), so the kernel image does not
> load it, and the final step that makes vmlinux from vmlinux.unstripped
> strips it: every boot image made from vmlinux, whether a raw binary or
> an ELF copy, is without it.  Module BTF is generated against
> vmlinux.unstripped, which keeps it.  .BTF_ids stays loadable, the
> verifier needs it once the BTF is loaded.  The object that carries .BTF
> also carries .BTF.meta, the size and SHA-256 of the BTF (struct
> btf_vmlinux_meta, checked by the module notifier); the first link, which
> the BTF is generated from, gets a zeroed .BTF.meta of the same size.
> kernel/bpf/btf_vmlinux.c is an empty carrier module; scripts/gen-btf.sh
> gives it the vmlinux .BTF as its own .BTF section instead of generating
> split BTF for it, so that one module depends on vmlinux with =m; with
> CONFIG_DEBUG_INFO_BTF_MODULES all of them do, as before.
> 
> CONFIG_BPF_PRELOAD is not selectable with =m: its iterator programs
> attach through the vmlinux BTF, so every bpffs mount (systemd does one
> at boot) would load it and defeat the point.  Module BTF is still kept
> when a module loads, as with =y; the saving is the vmlinux BTF only.
> Programs that need kernel types before the root file system is mounted
> need btf_vmlinux.ko in the initramfs; the Kconfig help says so.
> 
> The module has no exit: once loaded the BTF stays, as with =y.  The
> runtime side -- loading the module on first use, checking it against
> .BTF.meta, deferring kfunc and struct_ops registrations and module BTF
> until it arrives -- and the IS_ENABLED()/$(subst m,y,...) preparation of
> the existing checks are in the preceding patches; this one makes it
> selectable.
> 


A few thoughts here; .BTF.meta seems too vague as a name. This is very
like .gnu_debuglink ; should we call it .BTF.link ? It also could be
nicely extended to .BTF.inline (.BTF.inlink.link) where inline info
is delivered as a module.

I also wonder if the right place to populate the section is in
the script? We might run into endian issues etc; why not do it
as part of resolve_btfids? Pass a --btf_link parameter or similar,
and resolve_btfids (which has access to BTF size after carrying
out various operations) can add it and the SHA. resolve_btfids is
already updating other BTF-related sections so seems like a natural
home for this.


> Tested with 1 GiB of memory, same tree, =y vs =m, both with
> CONFIG_DEBUG_INFO_BTF_MODULES=y:
> 
>  - MemTotal is ~5.4 MB higher with =m while the BTF is unused: the size
>    of the .BTF section.
>  - stat() of /sys/kernel/btf/vmlinux reports the BTF size before it is
>    loaded, as the btf_sysfs selftest expects.
>  - With BTF in use, MemFree is the same within run-to-run noise.
>  - Modules loaded before the trigger (ext4, nf_conntrack and its kfuncs,
>    xfrm_interface) appear in /sys/kernel/btf immediately and get BTF ids
>    once the BTF is loaded; a socket filter loads without loading the
>    module; a kprobe program calling bpf_get_current_task_btf(), opening
>    /sys/kernel/btf/vmlinux or BPF_BTF_GET_NEXT_ID each load it.
>  - A carrier module with one byte of its .BTF changed is refused with
>    "BTF does not match this kernel" and leaves no state behind.
>  - After the load: fstat/read/mmap of /sys/kernel/btf/vmlinux, a
>    struct_ops map for tcp_congestion_ops, a syscall program calling the
>    bpf_task_from_pid()/bpf_task_release() kfuncs, and modules loaded
>    afterwards (nf_nat) all work as with =y.
>  - =m without DEBUG_INFO_BTF_MODULES, and =y, build and pass the same
>    tests.
> 
> Signed-off-by: Jay Wang <wanjay@amazon.com>
> ---
>  Documentation/bpf/btf.rst         | 35 ++++++++++++
>  Makefile                          |  5 +-
>  include/asm-generic/vmlinux.lds.h | 31 +++++++++-
>  kernel/bpf/Makefile               |  4 ++
>  kernel/bpf/btf_vmlinux.c          | 23 ++++++++
>  kernel/bpf/preload/Kconfig        |  4 ++
>  lib/Kconfig.debug                 | 22 ++++++-
>  scripts/Makefile.modfinal         | 26 +++++++--
>  scripts/Makefile.vmlinux          |  5 ++
>  scripts/gen-btf.sh                | 95 +++++++++++++++++++++++++++++--
>  scripts/link-vmlinux.sh           | 25 ++++++--
>  11 files changed, 257 insertions(+), 18 deletions(-)
>  create mode 100644 kernel/bpf/btf_vmlinux.c
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 29de1222c3e7..1bd0d35cdb05 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1276,6 +1276,41 @@ format.::
>              .long   58
>              .long   8206                    # Line 8 Col 14
>  
> +6.1 Kernel BTF
> +--------------
> +
> +With CONFIG_DEBUG_INFO_BTF=y the BTF of the kernel is generated at link time
> +from its DWARF and placed in the .BTF section of vmlinux, which is read-only
> +data of the kernel image. It is available as /sys/kernel/btf/vmlinux and, if
> +CONFIG_DEBUG_INFO_BTF_MODULES is set, module BTF is generated as split BTF
> +against it and available as /sys/kernel/btf/<module>.
> +
> +With CONFIG_DEBUG_INFO_BTF=m the same BTF is generated, but it is not part of
> +the kernel image or of the vmlinux ELF file (vmlinux.unstripped in the build
> +tree keeps it, for module BTF generation). It is delivered by the
> +btf_vmlinux module, which the kernel loads on demand the first time the BTF is
> +needed: when /sys/kernel/btf/vmlinux is read or mmap()ed, when kernel BTF
> +objects are enumerated (BPF_BTF_GET_NEXT_ID), or when a BPF program needs
> +kernel type information (an attach_btf_id, a kfunc call, a ksym, a map pointer
> +or a helper that takes or returns a kernel BTF pointer). Until then no memory
> +is used for it, and afterwards nothing differs from =y. In particular:
> +
> +  * /sys/kernel/btf/vmlinux exists from boot with its final size.
> +  * Modules loaded before the vmlinux BTF are exposed in /sys/kernel/btf right
> +    away, their BTF is parsed and gets a BTF id once the vmlinux BTF is
> +    loaded, together with their kfunc and struct_ops registrations.
> +  * kfunc, dtor kfunc and struct_ops registrations of the kernel itself are
> +    applied before the BTF becomes visible.
> +  * The kernel only accepts the BTF it was built with: the size and SHA-256 of
> +    the BTF are linked into the kernel and checked against the module.
> +  * Once loaded the BTF stays; the module cannot be unloaded.
> +
> +If the module is not available (not installed, or the root file system is not
> +mounted yet), the kernel behaves as one built without BTF and retries next
> +time. CONFIG_BPF_PRELOAD is not available with =m: its iterators attach through
> +the vmlinux BTF, so mounting bpffs would load it. bpf_snprintf_btf() and bpf_seq_printf_btf() only use the BTF if it has
> +already been parsed, as they run in program context.
> +
>  7. Testing
>  ==========
>  
> diff --git a/Makefile b/Makefile
> index f561516e1735..7ce5d478abd3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1745,8 +1745,9 @@ endif
>  #
>  
>  # *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFO_BTF_MODULES
> -# is an exception.
> -ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +# is an exception, and so is the btf_vmlinux module with CONFIG_DEBUG_INFO_BTF=m,
> +# which carries the vmlinux BTF.
> +ifneq ($(CONFIG_DEBUG_INFO_BTF_MODULES)$(filter m,$(CONFIG_DEBUG_INFO_BTF)),)
>  KBUILD_BUILTIN := y
>  modules: vmlinux
>  endif
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f66..204a9ee171c6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -674,8 +674,18 @@
>  
>  /*
>   * .BTF
> + *
> + * With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is loaded as read-only data and
> + * bounded by __start_BTF/__stop_BTF.  With CONFIG_DEBUG_INFO_BTF=m it is
> + * linked as a non-loadable section (see BTF_NOLOAD in ELF_DETAILS), so that
> + * module BTF generation can read it from vmlinux.unstripped; it is stripped
> + * from vmlinux (scripts/Makefile.vmlinux), and the btf_vmlinux module carries
> + * a copy and provides it on demand at runtime.
> + * What is loaded instead is .BTF.meta, the size and hash of that BTF (see
> + * scripts/gen-btf.sh), empty in the first link that the BTF is generated
> + * from.  .BTF_ids is needed by the kernel in both cases.
>   */
> -#ifdef CONFIG_DEBUG_INFO_BTF
> +#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
>  #define BTF								\
>  	. = ALIGN(PAGE_SIZE);						\
>  	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
> @@ -685,10 +695,28 @@
>  	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
>  		*(.BTF_ids)						\
>  	}
> +#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
> +#define BTF								\
> +	. = ALIGN(8);							\
> +	.BTF.meta : AT(ADDR(.BTF.meta) - LOAD_OFFSET) {			\
> +		BOUNDED_SECTION_BY(.BTF.meta, _BTF_meta)		\
> +	}								\
> +	. = ALIGN(PAGE_SIZE);						\
> +	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
> +		*(.BTF_ids)						\
> +	}
>  #else
>  #define BTF
>  #endif
>  
> +#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
> +/* quoted: BTF is a macro, an unquoted .BTF here would expand it */
> +#define BTF_NOLOAD							\
> +		".BTF" 0 : { *(".BTF") }
> +#else
> +#define BTF_NOLOAD
> +#endif
> +
>  /*
>   * Init task
>   */
> @@ -849,6 +877,7 @@
>  /* Required sections not related to debugging. */
>  #define ELF_DETAILS							\
>  		.comment 0 : { *(.comment) }				\
> +		BTF_NOLOAD						\
>  		.symtab 0 : { *(.symtab) }				\
>  		.strtab 0 : { *(.strtab) }				\
>  		.shstrtab 0 : { *(.shstrtab) }				\
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 0b7db88f1bed..8a7ad4303c0d 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -43,6 +43,10 @@ endif
>  ifeq ($(CONFIG_SYSFS),y)
>  obj-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += sysfs_btf.o
>  endif
> +# With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is carried by this module
> +ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +obj-m += btf_vmlinux.o
> +endif
>  ifeq ($(CONFIG_BPF_JIT),y)
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>  obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
> diff --git a/kernel/bpf/btf_vmlinux.c b/kernel/bpf/btf_vmlinux.c
> new file mode 100644
> index 000000000000..8d89b4bb3c43
> --- /dev/null
> +++ b/kernel/bpf/btf_vmlinux.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Carrier module for the vmlinux BTF when CONFIG_DEBUG_INFO_BTF=m.
> + *
> + * This module has no code of its own.  Its .BTF section is a copy of the
> + * vmlinux BTF (see scripts/gen-btf.sh), which the BTF module notifier in
> + * kernel/bpf/btf.c recognizes by module name and installs as the vmlinux BTF.
> + * The kernel loads it on demand, the first time the vmlinux BTF is needed.
> + *
> + * There is deliberately no module_exit(): once the BTF is in use it cannot
> + * be taken away again, exactly as with CONFIG_DEBUG_INFO_BTF=y.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +static int __init btf_vmlinux_init(void)
> +{
> +	return 0;
> +}
> +module_init(btf_vmlinux_init);
> +
> +MODULE_DESCRIPTION("BTF type information for vmlinux");
> +MODULE_LICENSE("GPL");
> diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
> index aef7b0bc96d6..b1600bdce7a0 100644
> --- a/kernel/bpf/preload/Kconfig
> +++ b/kernel/bpf/preload/Kconfig
> @@ -6,6 +6,10 @@ menuconfig BPF_PRELOAD
>  	# The dependency on !COMPILE_TEST prevents it from being enabled
>  	# in allmodconfig or allyesconfig configurations
>  	depends on !COMPILE_TEST
> +	# The preloaded iterators attach through the vmlinux BTF, so with
> +	# CONFIG_DEBUG_INFO_BTF=m every bpffs mount would load the BTF, which
> +	# defeats the point of =m on any system that mounts bpffs at boot.
> +	depends on DEBUG_INFO_BTF!=m
>  	help
>  	  This builds kernel module with several embedded BPF programs that are
>  	  pinned into BPF FS mount point as human readable files that are
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 134b15a44625..418025c5e657 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -396,7 +396,7 @@ config DEBUG_INFO_SPLIT
>  	  Incompatible with older versions of ccache.
>  
>  config DEBUG_INFO_BTF
> -	bool "Generate BTF type information"
> +	tristate "Generate BTF type information"
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> @@ -408,6 +408,26 @@ config DEBUG_INFO_BTF
>  	  Turning this on requires pahole v1.22 or later, which will convert
>  	  DWARF type info into equivalent deduplicated BTF type info.
>  
> +	  If built as a module (=m), the vmlinux BTF is not part of the
> +	  kernel image.  It is carried by the btf_vmlinux module, which is
> +	  loaded on demand the first time the BTF is needed: when a BPF
> +	  program requires kernel type information, or when
> +	  /sys/kernel/btf/vmlinux is opened.  Until then, no memory is
> +	  spent on it.  The vmlinux ELF file does not carry the BTF
> +	  either; module BTF is generated against vmlinux.unstripped, and
> +	  tools that read the BTF from a file can use that or
> +	  /sys/kernel/btf/vmlinux.
> +
> +	  Module BTF (DEBUG_INFO_BTF_MODULES) is kept when a module loads,
> +	  as with =y, and registered once the vmlinux BTF is available; the
> +	  saving is the vmlinux BTF only.
> +
> +	  If BPF programs that use kernel types run before the root file
> +	  system is mounted, put btf_vmlinux.ko into the initramfs: until
> +	  the module can be loaded, such programs fail as on a kernel
> +	  without BTF.  Not compatible with BPF_PRELOAD, whose iterators
> +	  would load the BTF at every bpffs mount.
> +
>  config PAHOLE_HAS_BTF_TAG
>  	def_bool PAHOLE_VERSION >= 123
>  	depends on CC_IS_CLANG
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 01a37ec872b9..6a0958cf0e6f 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -38,20 +38,34 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
>  		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
>  
> +# The ELF file with the vmlinux BTF: with CONFIG_DEBUG_INFO_BTF=m the BTF is
> +# stripped from vmlinux (scripts/Makefile.vmlinux), vmlinux.unstripped keeps it.
> +btf-vmlinux := $(objtree)/vmlinux$(if $(filter m,$(CONFIG_DEBUG_INFO_BTF)),.unstripped)
> +
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
> -	if [ ! -f $(objtree)/vmlinux ]; then				\
> +	if [ ! -f $(btf-vmlinux) ]; then				\
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>  	else	\
> -		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
> +		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(btf-vmlinux) $@; \
>  	fi;
>  
> -# Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed,ld_ko_o)
> +# Modules that get a .BTF section: all of them with CONFIG_DEBUG_INFO_BTF_MODULES,
> +# otherwise only the vmlinux BTF carrier module with CONFIG_DEBUG_INFO_BTF=m.
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> +btf-modules := $(modules:%.o=%.ko)
> +else ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +btf-modules := $(filter %/btf_vmlinux.ko,$(modules:%.o=%.ko))
> +# Only the carrier depends on vmlinux, not every module
> +ifdef KBUILD_BUILTIN
> +$(btf-modules): $(btf-vmlinux)
> +endif
>  endif
> +
> +# Re-generate module BTFs if either module's .ko or vmlinux changed
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(btf-vmlinux)) FORCE
> +	+$(call if_changed,ld_ko_o)
> +	+$(if $(and $(filter $@,$(btf-modules)),$(newer-prereqs)),$(call cmd,btf_ko))
>  	+$(call cmd,check_tracepoint)
>  
>  targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index fcae1e432d9a..557db1ee1f3b 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -86,6 +86,11 @@ remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '!.rel*.dyn'
>  # for compatibility with binutils < 2.32
>  # https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7
>  remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel.*'
> +# With CONFIG_DEBUG_INFO_BTF=m the btf_vmlinux module carries the vmlinux BTF;
> +# only vmlinux.unstripped keeps it, for module BTF generation.
> +ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +remove-section-y += .BTF
> +endif
>  
>  remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
>  
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 8ca96eb10a69..d808d0006d32 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -22,16 +22,27 @@
>  #   - ${1}.btf.o ready for linking into vmlinux
>  #   - ${1}.BTF_ids with .BTF_ids data blob
>  # This output is consumed by scripts/link-vmlinux.sh
> +#
> +# With CONFIG_DEBUG_INFO_BTF=m the .BTF section in ${1}.btf.o is not
> +# allocatable, so the kernel image does not carry the BTF; vmlinux.unstripped
> +# does, for module BTF generation, and scripts/Makefile.vmlinux strips it from
> +# vmlinux.  ${1}.btf.o then also carries .BTF.meta, the size and SHA-256 of
> +# the BTF for the kernel (struct btf_vmlinux_meta); "--placeholder ${1}"
> +# produces a ${1}.btf.o with a zeroed .BTF.meta and no .BTF for the first
> +# vmlinux link, which the BTF is generated from.  The btf_vmlinux module gets
> +# no BTF of its own; its .BTF section is a copy of the vmlinux BTF, extracted
> +# from --btf_base.
>  
>  set -e
>  
>  usage()
>  {
> -	echo "Usage: $0 [--btf_base <file>] <target ELF file>"
> +	echo "Usage: $0 [--btf_base <file>] [--placeholder] <target ELF file>"
>  	exit 1
>  }
>  
>  BTF_BASE=""
> +PLACEHOLDER=""
>  
>  while [ $# -gt 0 ]; do
>  	case "$1" in
> @@ -39,6 +50,10 @@ while [ $# -gt 0 ]; do
>  		BTF_BASE="$2"
>  		shift 2
>  		;;
> +	--placeholder)
> +		PLACEHOLDER=1
> +		shift
> +		;;
>  	-*)
>  		echo "Unknown option: $1" >&2
>  		usage
> @@ -60,6 +75,10 @@ is_enabled() {
>  	grep -q "^$1=y" ${objtree}/include/config/auto.conf
>  }
>  
> +is_module() {
> +	grep -q "^$1=m" ${objtree}/include/config/auto.conf
> +}
> +
>  case "${KBUILD_VERBOSE}" in
>  *1*)
>  	set -x
> @@ -79,6 +98,30 @@ gen_btf_data()
>  		--btf ${btf1} "${ELF_FILE}"
>  }
>  
> +# Write one byte with value $1 (0..255)
> +put_byte()
> +{
> +	printf "\\$(printf '%03o' "$1")"
> +}
> +
> +# CONFIG_DEBUG_INFO_BTF=m: write struct btf_vmlinux_meta { u32 size; u8
> +# sha256[32]; } for the BTF in $1 to $2, in the target's byte order.
> +gen_btf_meta()
> +{
> +	size=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$1")
> +	sha256=$(sha256sum < "$1" | cut -d' ' -f1)
> +	{
> +		if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +			for shift in 24 16 8 0; do put_byte $(( (size >> shift) & 255 )); done
> +		else
> +			for shift in 0 8 16 24; do put_byte $(( (size >> shift) & 255 )); done
> +		fi
> +		for byte in $(echo "${sha256}" | sed 's/../& /g'); do
> +			put_byte $(( 0x${byte} ))
> +		done
> +	} > "$2"
> +}
> +
>  gen_btf_o()
>  {
>  	btf_data=${ELF_FILE}.btf.o
> @@ -88,9 +131,23 @@ gen_btf_o()
>  	# deletes all symbols including __start_BTF and __stop_BTF, which will
>  	# be redefined in the linker script.
>  	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
> -	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
> -		--set-section-flags .BTF=alloc,readonly ${btf_data}
> -	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
> +	if is_module CONFIG_DEBUG_INFO_BTF; then
> +		# CONFIG_DEBUG_INFO_BTF=m: .BTF stays non-allocatable, kept in
> +		# vmlinux.unstripped for module BTF but not loaded; the btf_vmlinux
> +		# module provides it at runtime.  What is loaded is .BTF.meta,
> +		# its size and hash, so that /sys/kernel/btf/vmlinux has the right
> +		# size from boot and only the matching BTF is accepted.
> +		gen_btf_meta ${ELF_FILE}.BTF ${ELF_FILE}.BTF.meta
> +		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
> +			--set-section-flags .BTF=readonly \
> +			--add-section .BTF.meta=${ELF_FILE}.BTF.meta \
> +			--set-section-flags .BTF.meta=alloc,readonly ${btf_data}
> +		${OBJCOPY} --only-section=.BTF --only-section=.BTF.meta --strip-all ${btf_data}
> +	else
> +		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
> +			--set-section-flags .BTF=alloc,readonly ${btf_data}
> +		${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
> +	fi
>  
>  	# Change e_type to ET_REL so that it can be used to link final vmlinux.
>  	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> @@ -121,6 +178,7 @@ cleanup()
>  {
>  	rm -f "${ELF_FILE}.BTF.1"
>  	rm -f "${ELF_FILE}.BTF"
> +	rm -f "${ELF_FILE}.BTF.meta"
>  	if [ "${BTFGEN_MODE}" = "module" ]; then
>  		rm -f "${ELF_FILE}.BTF.base"
>  		rm -f "${ELF_FILE}.BTF_ids"
> @@ -133,6 +191,35 @@ if [ -n "${BTF_BASE}" ]; then
>  	BTFGEN_MODE="module"
>  fi
>  
> +if [ -n "${PLACEHOLDER}" ]; then
> +	btf_data=${ELF_FILE}.btf.o
> +	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
> +	dd if=/dev/zero of=${ELF_FILE}.BTF.meta bs=36 count=1 2>/dev/null
> +	${OBJCOPY} --add-section .BTF.meta=${ELF_FILE}.BTF.meta \
> +		--set-section-flags .BTF.meta=alloc,readonly ${btf_data}
> +	${OBJCOPY} --only-section=.BTF.meta --strip-all ${btf_data}
> +	exit 0
> +fi
> +
> +# CONFIG_DEBUG_INFO_BTF=m: the btf_vmlinux module carries the vmlinux BTF
> +# itself.  Its own types are of no interest, so instead of generating split
> +# BTF for it, copy the (non-loadable) .BTF section of --btf_base
> +# (vmlinux.unstripped) into the module.
> +# The kernel recognizes the module by name and treats its .BTF as base BTF.
> +case "${BTFGEN_MODE}:${ELF_FILE}" in
> +module:*/btf_vmlinux.ko)
> +	if is_module CONFIG_DEBUG_INFO_BTF; then
> +		# -O binary only emits allocatable sections; make .BTF one for
> +		# the extraction.  ${BTF_BASE} itself is not modified.
> +		${OBJCOPY} -O binary --only-section=.BTF			\
> +			--set-section-flags .BTF=alloc,load,readonly	\
> +			"${BTF_BASE}" "${ELF_FILE}.BTF"
> +		${OBJCOPY} --add-section .BTF="${ELF_FILE}.BTF" "${ELF_FILE}"
> +		exit 0
> +	fi
> +	;;
> +esac
> +
>  gen_btf_data
>  
>  case "${BTFGEN_MODE}" in
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index ab0b8125c8cb..a9a066267ef6 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -37,6 +37,15 @@ is_enabled() {
>  	grep -q "^$1=y" include/config/auto.conf
>  }
>  
> +is_module() {
> +	grep -q "^$1=m" include/config/auto.conf
> +}
> +
> +# =y or =m
> +is_set() {
> +	grep -q "^$1=[ym]" include/config/auto.conf
> +}
> +
>  # Nice output in kbuild format
>  # Will be suppressed by "make -s"
>  info()
> @@ -211,17 +220,25 @@ if is_enabled CONFIG_KALLSYMS; then
>  	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
>  fi
>  
> -if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
> +if is_module CONFIG_DEBUG_INFO_BTF; then
> +	# The kernel refers to the size and hash of its BTF, which only the
> +	# BTF generated from the first link can provide; link a placeholder
> +	# of the same layout until then.
> +	${CONFIG_SHELL} ${srctree}/scripts/gen-btf.sh --placeholder .tmp_vmlinux0
> +	btf_vmlinux_bin_o=.tmp_vmlinux0.btf.o
> +fi
> +
> +if is_enabled CONFIG_KALLSYMS || is_set CONFIG_DEBUG_INFO_BTF; then
>  
>  	# The kallsyms linking does not need debug symbols, but the BTF does.
> -	if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
> +	if ! is_set CONFIG_DEBUG_INFO_BTF; then
>  		strip_debug=1
>  	fi
>  
>  	vmlinux_link .tmp_vmlinux1
>  fi
>  
> -if is_enabled CONFIG_DEBUG_INFO_BTF; then
> +if is_set CONFIG_DEBUG_INFO_BTF; then
>  	info BTF .tmp_vmlinux1
>  	if ! ${CONFIG_SHELL} ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
>  		echo >&2 "Failed to generate BTF for vmlinux"
> @@ -287,7 +304,7 @@ fi
>  
>  vmlinux_link "${VMLINUX}"
>  
> -if is_enabled CONFIG_DEBUG_INFO_BTF; then
> +if is_set CONFIG_DEBUG_INFO_BTF; then
>  	info BTFIDS ${VMLINUX}
>  	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
>  fi
> -- 
> 2.47.3
> 


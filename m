Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DA37DADE;
	Thu,  4 Jun 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568553; cv=fail; b=kRMrw+Ur/iuPauoa2zCXnayik4YxF3wipwSbnLaDgpcjg8DsxW+tvjopA1K+hIEmWXErctlt3sCqu/hcxepIFoQCU7IK+UCvUXWZx52jFHbxS3Fcx8bIQ6nqCudQw/v064v9h2sK/B/Qwm0wI7052yLSZ+oBJflNrSPqthA/IQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568553; c=relaxed/simple;
	bh=s/moW4IC2s51ffmXABK/Uk/RwA13BXg2hdjRVr/OkLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFYz0vQHQ3JudSKeOdslLMqpf75Y9Zebl2hgdaILb6V4ylQObK8sreDDafRt7+4K8spy3xDdSmc1zfueu8K9duy34BOkzChi6Q+8XJc3yoRftdQ91Al6F0apBA2n4lHHkHI1tlmm/Jg774Vo3Se10xL5I2aZgLk3KoTt5sOrnz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nQIGbrgm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZJXr+k+2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQIGbrgm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZJXr+k+2"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6549DXIW1098163;
	Thu, 4 Jun 2026 10:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PcgbFlZ564v6Db63fsPrnqt81az3CvucWg/x+e+kuzk=; b=
	nQIGbrgm4CjYN2pDxidVFlHHJX1qBzVF7tAetLYEYaMKI0e5RQ6pSEyrd3zWxKBF
	NFeyyuCL+RSVm/DL8SIfTgiozs/EBAqGbofzpJBvRJ+8Eof2csBbCplbb7rxydHb
	dH9yixV6YJbmow/XtYCVIBFsS5XwvO+Jxv2F9d1wYpLlIwaNbbc6Ot3RVELGHfUG
	gx/OfEyLSkbxRTnw7QWpx7pcblnSfG28E9UVEu08Bi+UBSvtOe7x9NahR/bz3u1W
	t0ewoMPXIvC+adQ/L1jSac8Deid3YsicZA9fo6bhLjDNPT7KYOXkgsC3Iy3A4on/
	xf1T4c9O1UedS7Td3q7gwA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efqs6qtr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 10:21:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 654AEuJc020185;
	Thu, 4 Jun 2026 10:21:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbf6j2g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 10:21:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW9sCuNPLCU9LWjDyMdklrM47mQGK8gXlr53RjkevTz1KcKmzSb0YlXkhxhfADED4ZGFH2QHnKq6FjOfsrkN5YJvf1d8Ftnd8OoHFLlbglbmIgTdeC4V7OJaGuCPT4z13pis7fH2f8qfXQLX2LsJAHbpKNeZU0MvGrPsCx0c73nv5t/MhWMDtLiPEyuo9L9pjETVv3utnlAC7rEUfJfgYnd2jerIZEoi+tAPEtNFJBh7VyP6y8Jt32u+HxVCkvBS9ZL4kQ0PZ2pXZ0jZY+Is75KtqVa0fgJo5xP8aAYOr1yhYGTe/EA8KGsfZdV9zHnNOWK7j1PlPPDjpqhGMgCUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcgbFlZ564v6Db63fsPrnqt81az3CvucWg/x+e+kuzk=;
 b=qiJNnnEwaWSv9vN9de8yJJxr6cKVWq/XmEBHI9eYWh9SYZUOyIAQ3CYL9KpzyWv8kIJCla3l04i8IpsGpleUMyKOvJl0blLKWhjZb75j/fwFh/hXpwJ44OQJPZRg2XylO3UA7tlWddKY2CjUjHLGjIpa4ibaqVtNmdkKS69uqMaY8+iQn7Ij4of6h0za2oDN0MijEIOIjr+x4Mn2idO6SsfFjRbHmJasbWruOodWd5w7kpXsoQM0RqHn8VUpDPRAUUZcslTsKqnZurZYgqG2JXgCLBuE72UnyOVkdwQTGHgty+hdPpYcjbZlMmaR8BlgNr8XfN0ato4u74ZJJubUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcgbFlZ564v6Db63fsPrnqt81az3CvucWg/x+e+kuzk=;
 b=ZJXr+k+2k30m021RDxIGWkCnBTMLkSW71KJe1SrG2FMKAPc3NEUmiJhVIXAyZ0fmorqJvb4DHG/oVK5cNdcOQiWoaAKzrWrRQRXTf8To0HdjPNq9k4w+xw6jhcUF485JhlNF2NrgGfJ6UOKFTe4hBalMGXiCXE8TPdxvfC+nJls=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 10:21:41 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:21:41 +0000
Message-ID: <7a9e6b7b-f566-47e6-80bd-6fff7ed55241@oracle.com>
Date: Thu, 4 Jun 2026 11:21:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
To: chenyuan <chenyuan_fl@163.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: eddyz87@gmail.com, yonghong.song@linux.dev, andrii@kernel.org,
        ast@kernel.org, bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
        chenyuan@kylinos.cn, clm@meta.com, daniel@iogearbox.net,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, song@kernel.org
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
 <20260602085827.2562222-1-chenyuan_fl@163.com>
 <20260602085827.2562222-2-chenyuan_fl@163.com>
 <8f2dd2e9-726c-4295-995c-3bdbcda56070@linux.dev>
 <41cc6d1a.8310.19e91e9c5e1.Coremail.chenyuan_fl@163.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <41cc6d1a.8310.19e91e9c5e1.Coremail.chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: 459c2595-aad5-40ba-67e3-08dec22311fb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 eGw6nL50dSNyeUbU86zgQaHROzmyaKCDYqn4ZwmqQaVb4ZOr+AcOL38DzAN++e1+Qf+upcxHMllxHo2TBV3iihYbZb1LH83gTuXaT0+hNty4B2t4H284+I6LngxthFReBgoHTFiGGMU8K1E4hyWV+Hg8ZAAG4N17UHD7IBRrLMK8tIN7oxN6KBAeU+C2EUpj1dHV3sdPdarcpFTabCBDNvY1bD03K2HPrOYy9EBvFWYORP98qQ5nW37Kk65VSG13ZzbqMwWFSv6+U2HWbY3RmYTCIJC+vhDA0jfFPRuFfkLUZMjru4R2ZJl374Uf2iSPoLUl3ZnsuwQMKUDq+SV9glunXbN4aAgz8V5PYmiyA1ks0DZdQlXTrBcimegxhlAhFdPYMo1s/mtsCKvjrRUyszXObHOIoCZEbKPA1FV+IgN6LCKjfbAx6cLfecypoPv4PMM5gjJ8+esHIecxtLqBLWb0pQ12zgwr2I6QV3tDdQaBXXVEEL8zRcjg1NqxAwSMouIiyaJQrFwbVb7SGMdqUYFKtrM2j2R+W4pI6GGDQd8li8dftutuT2BDP64EtX5gmscz4aA6GKUj+3+xBAinK8zcpOJtoRIPCSUi+4sUFwdf4QC/vuwq0NMJjWPfXR/m319+WUIWZ8nzxpfKqXLnljSaUkoyYTFWxIJdGUjDpARemzwTtRgE6n6snmCTPGV4
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T0R1WUZQNy9mNzNSNEJySURjaDZrcVpsN0dOZzlGZDBaT09kQVM2bkFHaXhk?=
 =?utf-8?B?bHZDRnhwZGdFWjhaby9WQVgzd0dGcFlDWS94NU5PbHNQQi95MVE5a3pGZTBY?=
 =?utf-8?B?UXZ1blE1NFhic0dzQW9sNjRYNmhERnVzdkN3N3EvaE1HdlRHVjF4L1RzelRM?=
 =?utf-8?B?eEwvcG9ETmRtNnZ2eDhjemVxK3cwYlc4VXBQNGZCN3ROMm9MQ1JQcnh0ZHB2?=
 =?utf-8?B?em1sUklmRlkzd3pZQmFjNzUwRXRicG5YK054RFFCQTdUYzVGYS9uRWlMVGkw?=
 =?utf-8?B?cTlaenBuTXZuL01HVVhFeWl1RkZuQTRuSitzY1ZkK2JNTDNhOExXb1EzL2dV?=
 =?utf-8?B?MmRvSDMycUE1MTdLbHpEaDNUTHJsRjZFSXRYUi9VZk8xTXkrTHVHdWFaVHor?=
 =?utf-8?B?czlqVnFneEZhNkJkK0VONHlrVDIzRnQwU1JXWVY0bmlJalJqU1RrQlAwdWUz?=
 =?utf-8?B?MVBxaDhKRmk0Skx4ODBYYUxETGhqT2o0WmRKZzlEOGJBNXdlV016cUxodkRm?=
 =?utf-8?B?QW5NcjVXblFIOUFtcHBqc0pMN3FRRUhzKy9UVk5qVzZFV2o0a3U2YWp1Ry9x?=
 =?utf-8?B?bWMrZ3BTUDBGODNxY0RDRnY5Wk5XK1ptRjREQ3ErWUJWQUtsanYyQ3dvZkZ2?=
 =?utf-8?B?Nzg1c1l2WW1QdkpSejdKeTY0alRLRS9McDdYUGJlK2pTVEptVlN2YVp5cmpU?=
 =?utf-8?B?RGlVclFCTUdlRFpkRFhnMkdpY0RCVXIzczZkUFdHMVlOaTg1aTBMVDRGOVd1?=
 =?utf-8?B?KzF2SVFaOUZ0MWkyRWptTXErSGMxZTV3NnFLNXp0Q0RsU3ZQdEhhdGJ4TVI2?=
 =?utf-8?B?OFlBcmMweUlISTBWRUw2SE0wZG5rS3dSSUZiSnhhck5ydzBtcENReGtrQW5M?=
 =?utf-8?B?c0loWWhCZGw4UFVnZGZIeERwNElEZ1I4NlZWUE1ZSFdyVzVtb2dKZDMzM3hs?=
 =?utf-8?B?MDVYNlFMOFhubzlpUGxaSWUvQmMvYzFPa203TzAzbEx2OUU3ajVHS1FhQUp3?=
 =?utf-8?B?Z1JJSy82dEFrMWFmSGRQekFkU0Uxb2c5NUl6QXJud3FVQy9uL0pzdHMwbHJK?=
 =?utf-8?B?OG5uS1BhZVllemNHMmxnR2I0c1ZiTzlBdHdWSkwweTRFMnREYWFNUStwbzY1?=
 =?utf-8?B?YXRUbjc5Sk4rTzRhRnVYbFE2V1pGcHd6Z0R6RGM0TDlQSkJYenhmL1l6V2c5?=
 =?utf-8?B?THY5K0tybFRBTUc4Zmt4VW9GR3RsWEp4VjlKSTh3OCtZZlRoTkVhN0hPbXR6?=
 =?utf-8?B?ZGM2MU8ydzhFcFpRYWRNYTI1ekNZNnF2U2hWd0NKQ293Wlpkd0xUTnpsS3JU?=
 =?utf-8?B?WGhzeXNITXkrVVpEeXBxREVod2cwRTd1VUNqc2ZUYVo1UnVlSEo5a1g1eWRE?=
 =?utf-8?B?MC9wVzBDdDYyOVpUYnhpQzVDMVl0eDlnemVIeTlNUldjU0JaWkFTYk9FeUFu?=
 =?utf-8?B?eWI1aVM1b0NvNVE1QnBUTDcxTG5NQmxsbkYwYnBOQzRMVldiYm1zaXU4VTRu?=
 =?utf-8?B?NGp6YTVYTUZRTWlOYWR4UU85SndCQXBtc29XQTlxb0h4ckp4TW1jTTRzV3F6?=
 =?utf-8?B?VmdnVXpPU044OHRDQWd5ZjNpVXovYU95dHkrZ2RCVVhHODY0dWU3UFBZaldE?=
 =?utf-8?B?ODNISEJKZk1uNDh3cis2TlJVcjZsSHdnSThJNXNUdG1ieFZCNWxtSUVaSmpy?=
 =?utf-8?B?dWR2aVU1RTJlNFBaNXhFZUExbEQ1enpoSWhvZzNFRUVYQ2Ezdm1GTGtuajJK?=
 =?utf-8?B?UERBdXovQWpoeDZJMUFuMmhhMTlkRlB1TnJINW1pcjFqdVY1V3lMc0tObk1B?=
 =?utf-8?B?SC8wb3R6VzlyUU5PT0NMVkZpa0ozMDI1OUlqQk5jVU1mMmwyKzdUTU1XMG5w?=
 =?utf-8?B?dklBUWxuYmlQai9SNnNOMGNmdzdqcWJycDJpdnRoZCtlcjhEN0RVN2hSNEln?=
 =?utf-8?B?NTBNZXo1eGRFU0t2QldKRkhxWFFDWTlvUWJNaTdXUFhZTXVWcmh4dzJRbE9X?=
 =?utf-8?B?dHB2K3g0YThnVzQvdXV5ZG9pQmdmMzl2N0ZBMDJ2QUttcW93KzM2a3U1dDRR?=
 =?utf-8?B?UnVhNElibjNmVU5zc1NSUFdjT0ZBcW9UcUk2WGk4bCtNblA5TEIyVVpUOG5D?=
 =?utf-8?B?MXg3MkNTckh1aEY3Sm5aTWwyTmlFSGJXdlNvVTI3Mng5QlY4VFBLb2J0UG8y?=
 =?utf-8?B?Nyt6UmUvRVpQV1VTQ1F1T2lFUmFabWVXOXJYYjVWeWpOWWFGN2dtNVVmTFVU?=
 =?utf-8?B?SGpjQUlGeE5OZnV6SmIzRnFUMUVyQzlIMkZwMW80UG52RnFLSEZySDlGWGdn?=
 =?utf-8?B?TzhmcEZJTnVrVUxJdFAyZnI3T1JwTEt5VjA4UTNXRVhEcG5LaWI4Zz09?=
X-Exchange-RoutingPolicyChecked:
	UuW9uWrY2bT2AV5+ARzX4iWsf0/Xai83HUr+Ecmr1Ta8udcPy3+u1E4N4PTk4ZfD5d2n6gZTmGPxihsCmqUdkTdMy+cXHocB/tXr4av6JQRRtjul+4A8wvJu/P5T6WLwU79pQp0xUXL1fjrAEKxP4jcTjS0g0kXxTEvnf6SjQZW0PZGBhQs9gTitEzvmmp+OE/orgG/ngNvo+JqwrGRABjpfSTTIsIG8NQhPvE4hzijy/FUDx41kpbSrDZJMgq41h9L1aD0uwZ4XbuAf/Kn1mEnkuWBlXMHFHDngxXR4m9LfZJGS96pAsJnZ8l+hnmDWqFsSteS8ZmVFLFnTLXi3Dg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X4eDUn6WAhHGPKtuduR0mdMXkCXrh4MK4LAIb6QMMyH3stTe6bntPOzxBqjo1CUAFlvqkU3ctFpgX9x0Wr51T7P/R+JpX5U+C2rirPYKdfKgby/9fz/p/YMWEhQHiAzsTSMkp3RZsIYzvocRWO76NtP2Ds98v3FuX6AhhUorHSO7a37Bq3DXwTErwDk/Yd8ZZp7PlUqweKIpeTvLMuhmIVaoCbdkyj/NcTraAnNnnG6hsPJ7xpYDppULiRi8gysD3V0nHAKHmW57yH17IpN9G7aVWdmq1N4Ri7viqib9GCH3uuuoxVV4ycsRdEbVXhM3sMTs+LC2c2bnEPsGDWVP90VAYu7u7o/GQq6Bv85hH0ivD7fsmFzbcTUFTzK1f/sIFdjouNAJCybi9AWWnfRZ3eX919XrDAJi/eTFMZXko4I0yo7hW43KLp/DWBsH8XnzVwGISbR6Q/5hwkLRwJUryZ/LwtZ1RRpgSqCbcAGRp90DSvyOGmzAmlBfD+YJocL6XX/o2krjFOnssoURqMlm+a5c+/DgHRpkP+hiSLrKKXhIG8Oe41oJjHXBn2RX9OtlkVALaUGIaTs6Xe1wITIROsLIfYalR+e+VrCd57+W+jk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459c2595-aad5-40ba-67e3-08dec22311fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:21:41.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZQtPMRmH9yVxUPMdfOpGnQl3TcUETyA5Lz3cVm/rvLZMOCojNB+Kr49sjkHxvo+jmfxMCeaJ1VcCRavnZKEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606040099
X-Proofpoint-ORIG-GUID: 82BlzgA8Qfau3P5YlfW2LPtvcDH6h-Sj
X-Authority-Analysis: v=2.4 cv=POQ/P/qC c=1 sm=1 tr=0 ts=6a2151b8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=TdOZliH1RT9DP61miCcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5OSBTYWx0ZWRfX9EyZdvdVPcde
 4tlTxkDy2/4NbiSYp8xDGja8S1JBn/sJZIlFkpNpFWdPTOpVI6w7jJydxnTBfKDvU1Xj7huaK5c
 ydxM1C93emHaUM1vgi1YcyM5jtSq+NDkAPjQvNU+ATTkABvv09+dgv9zmL2ibHnCJ98pGalLWZY
 M2whSXdv9mQa7/CdIB504XO5r7FCvlUwnDpqxxj0OiQCT7sOL8pPivA8RZFkbxtRblw3v+SnYjm
 JmzWfj2AnSPmTa7o4gDc4A5KSJFxh2eCHk1zbOsJSn1GshqqnfHNGg2N5oTrxVWH8HBTWCZklbu
 Wr29rt/QfZ3XyAx8jqClqPUU6QaTmUUz+jXUCq00wFvRcagMQk4GImR+P1VHqxw+pBA1xKtLzBZ
 8esxh0Da55uXhT9JlleBPsXXxiMj6tCZ5PmorhqHNlmj1q/97m5h6iOwK0m16LgDf8vhGpNe0S7
 m5vKKx2jUslwe+3mSbg==
X-Proofpoint-GUID: 82BlzgA8Qfau3P5YlfW2LPtvcDH6h-Sj

On 04/06/2026 10:14, chenyuan wrote:
> Hi Ihor：
>> Could you please elaborate on the "incorrect type information" generated 
> by pahole 1.30?
> I extracted the .BTF and .BTF.base sections from the same 
> bpf_testmod.ko built with pahole 1.30 vs 1.31 to compare: 
> 
>   # pahole 1.30 — bpf_prog_aux in split BTF, NOT in base
>   $ bpftool btf dump file btf_1_30_base.bin | grep bpf_prog_aux
>     (empty)
>   $ bpftool btf dump -B btf_1_30_base.bin file btf_1_30.bin | grep aux
>     [3172] STRUCT 'bpf_prog_aux' size=2016 vlen=87
> 
>   # pahole 1.31 — bpf_prog_aux in base BTF, NOT in split
>   $ bpftool btf dump file btf_1_31_base.bin | grep bpf_prog_aux
>     [10] STRUCT 'bpf_prog_aux' size=2016 vlen=0
>   $ bpftool btf dump -B btf_1_31_base.bin file btf_1_31.bin | grep aux 
>     (empty) 
> 
> pahole 1.30 places struct bpf_prog_aux in the module's split BTF 
> (instead of the distilled base).  pahole 1.31 correctly moves it to 
> the base BTF. 

Would be worth digging a bit more here I think. To confirm is this
the v1.31 release where it is fixed or the post-1.31 pahole (i.e.
do you know the top commit for the fixed pahole version)? 

pahole uses the libbpf machinery to do BTF distillation in .BTF.base
so if we know which libbpf sync has the fix that will be helpful.

The most recent pahole HEAD is synced with libbpf v1.8, but I
suspect the previous sync that occured just after v1.30 (so v1.31
had the fix but v1.30 didn't):

042d73962d35 ("pahole: Sync with libbpf mainline")

is the one. From the commit log:
    
"To pull in dedup fix in
    
commit 8e64c387c942 ("libbpf: Add identical pointer detection to btf_dedup_is_equiv()")
    
sync with latest libbpf."

My suspicion is that since v1.30 didn't have that fix, dedup failed for 
struct bpf_prog_aux on pahole v1.30 so it wound up in split BTF and base.
v1.31 had the fix so the module bpf_prog_aux was correctly flagged as a
dup of the kernel one, therefore we did the distillation into .BTF.base
correctly.

Does this fit with your observations?

Thanks!

Alan

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99D422E25
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005676; cv=fail; b=Mxsq+2u7giKuEqoGbZw4tM6oCuRSVipQkRF30VwwNBYy4e3xhaJ3dDX73oXuNvzw06VxvLFhuLelYku4NLCusLhilElPA1AwbggHgAYBt97zAoPWkg2xpHPMwWqD7rMae1/Y53gavZ0E+coyi0XgLboAQxWmRWpM2MohgfF8Q/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005676; c=relaxed/simple;
	bh=19VetRC0Buy+q1HnL/tg40fh8mEtGN4FNsn00glynHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gngRnGwbfCkH3b3l/EVeJmNUOPO4C0AnIjeYSsWx7lT8o8dXv7Xy8ZqUEjUMuOyw4SyspIEVMt2OmAncRLLungGNBZo0apq9nXNn2QPJbTFLo3ifP/PS4Xr5PHqNg6zsi1qz56x2Y6oLuj1N78cLm+MBJbV/aHW8+hmnQZhDNiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rvhM/9jU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5l6sCli; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rvhM/9jU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5l6sCli"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6768YFjO602625;
	Thu, 6 Aug 2026 08:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I8L3Ep03/K7ZO6iOETSPlL6guBZCgXo+QOuXTOxLm14=; b=
	rvhM/9jUsLTYoo95wbHzinD5bFGVvmkM4sTg9y+Wx1hHdmJrSKOhZEsDXOzjiPQo
	txXeN7ITa8Av8AX7P6veIip9y80Lk/jodOorQUP5i72c4lEPQnjwq3LTtaOlFvUS
	zSvjImgoCsKgZauMb75+l6US62rJoDbNnbINvmzP4Y4hPXRBmPBmfwAqg6Frcq7a
	kBHjSMVJe6y/uTR/zSrZv9WCJyrMAhvkLCZzSrzeQQ9bFlKBSw84a2ij+yVPrFDC
	vg7PLr3QbYXY4HwRyfOLg15qlVdsPJ82DxFP8WVx2kxTW+luPqtlGOnOzmI8J0zz
	ULESuXEBeMoMJEQNY9lPjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8e54k7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 08:41:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6768eUMn005490;
	Thu, 6 Aug 2026 08:41:09 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78w892u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 06 Aug 2026 08:41:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYwn2nQpLMjkNcMxcVdRD96NY9Zn7nPqI5vnBZj28tvo8Qvz9GBQ6tW6CpDlsLmMCs5eK8QWRZ73gFkmfWoPI8+/Mz7ho3WGuz2IV1UwNWztAOWe9Sd4PtgRZ6+c4IBlRSrYwRy37HnUWJByfSFT0jrXyBABHo3QvQUz5EQb6pkmxKuICuWzQq2ejVeodtIUltLoCdukWlR/DDWAok89B5zOJnR5quV1mkQAgFGEdhLNYxWApeCCbDYBxL79pQ+iVfiq3nwCJlfXCSa1RRah8mbRazznb1HUrRJUN3nCDyVuhvlw1/5VibahiCS7B55z4PQRVKuaHGdeD0j5ap68sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8L3Ep03/K7ZO6iOETSPlL6guBZCgXo+QOuXTOxLm14=;
 b=p5/MqTkUxuPzQ4VhtuXRIa402m+kkX5uEbCwn8/9gObwjAAZWyNwbqQWooHkDjaV/AG6x6hmZtPjrNwHGqeCcMEpXO0+Hh6ZIsJT4scBS+OupP8A8HK5XOrKRdc327685Jvg48r/H3kHeDdNiam9IAJpzPgFwHenQqFwMvCulEVFHWGrxQXusBEPC7OK6+ecahuA8pn7PiNq1glhy6lBVdH79VTfB/MMsgQUNLCuSb4UyEmbIkB2Vh2ewlfNi1IcppoxmOHRoiGhjpRGcFQ+j0J0PHKqftu2e/AuiWVYhOA8vJiyNXZWe4eD8bACncR1dSdSVVk9Ep7DmgmElMTMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8L3Ep03/K7ZO6iOETSPlL6guBZCgXo+QOuXTOxLm14=;
 b=D5l6sCliF/tJvz03XxO0U+3SjUitoJAZChAByTH7XL7SGA69o+SDslvsCzT5LIllMupQd6P/O+DQlOr+vyh2UWoSRHMPgMq6y2p6Ma4OpJHbVeOxHZwDqG1HbDgdDtkIyVjyACHz4HEN8+1vvMy5BmIp18s+oSiFiMle1p+3bLU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CHAPR10MB997745.namprd10.prod.outlook.com (2603:10b6:610:2f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:41:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f629:6f12:8d3c:3924]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f629:6f12:8d3c:3924%7]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:41:06 +0000
Message-ID: <53158355-f12f-4efe-a480-1c375f8583ff@oracle.com>
Date: Thu, 6 Aug 2026 16:41:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/6] workqueue: introduce BPF iterators for
 workqueues, worker pools and pending work
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org
References: <20260728065525.653171-1-imran.f.khan@oracle.com>
 <am6ydQ0kl-KVOf_F@slm.duckdns.org>
Content-Language: en-US
From: imran.f.khan@oracle.com
In-Reply-To: <am6ydQ0kl-KVOf_F@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:220:210::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|CHAPR10MB997745:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b86dfd-225f-4d95-66b1-08def39674ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|6133799003|3023799007|22082099003|18002099003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fPo+rUnRJs/PF/fNcyIDhRi/pLW+73VtpMErk8dKQ1MUIXgLtrm4VmNc2Gk2yVA13VmALWohW1BlRhK6rtspiWaNISk9WpS/2RTu/HEcwjlLIj4IVoS80pRkbHuoraksCM7Ra6fvULkh85HIPggVjo2Xng8hnmRHt7n4uaCw9lLAjwdB1Zs6HzcscsR2XNsSQULnECjfFq9cXm5oPY384U96C/pOF7FlWxJI1vyNrGz3rqg50DNNzrHlB/xL4AWl44WQArU2yrk5MWTFKihBSh3xZqsyV2GghIUUHcpnRyOfo3AjisbNpjOy7fWyxMvVP6zr5MvbijFPvExBWEhK/9+vAjjobFIR8Q0G4cfO9FXicTmucl0HDzWSybIFS9xQ2WN7WDluCoS9ipvTQQJpVj/HofBrEntS44HZqLXuifUS/CQXCEN4QP79J8aexLU+F5xMkqJpPYknsDOKnlWxWSDKfxuXvpoO2ij2CiW7ESlSK8Js3b4j9pzrIaC/3/SHI9NUViF4JSykO/QcpWQMchX7ja11R4kdkSQ7hEQGDKfnhJNT2E/CERcnIR7IZBE9x4d/8CwQeZBwgy/h+8Z+qfJOi4k/ke5n1gEJi4hIGxRVUUuySzd5I0XQZtzaDodyAt5zElO1VTgnzSlFPIsrHTuUkMPBAA6StlowDNSLLAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnh3YktPdjd2ZWk5ODhublN2azJxejAxWm5wL001b3pwVUFTQUhoZ1UwUHRP?=
 =?utf-8?B?SHA0VHE0OFBaNWE5ZHdoWnhEUGN0UksrM2FnOFJZQWFTWS9Sb2NaOXFiZ1Jm?=
 =?utf-8?B?dnNnQXQ4eXUyNU9ML3d2UFRwMUpHaWorZmVDVURKOUxPQ0JHWjdJQ0NBa3Vy?=
 =?utf-8?B?d1N6N3lTaGhZL05la0ZQYlZocTc2eFZEbTBMT3dxYjhJS2dHS2lvZnFNRUJ0?=
 =?utf-8?B?UGcwQmFCSDZpSnQwcXBZd3BKdzVSZGk2ajBobExzMmkySXNmNGZZYitoMmdP?=
 =?utf-8?B?a2RsZWVDZnExemQ0M2JrRkZkWEo0UkdKak55M0FEMWNnMXNHQmlXNXBGaDZO?=
 =?utf-8?B?VHB6Q1B2TlFHVGVFcXVDY2JpSmNpWktWd3NNUlBOTDk5ZGNwQjUwRVdkNVQ4?=
 =?utf-8?B?QnRHM1dZOGpFYjNueDc5WTFHMUZTVU9LY09kbk5tRnYxZWJSeXNweWY4ZXpX?=
 =?utf-8?B?RjhiVHhWSi9ab0pGNTEwV29vM0JPcDVkN1NzR2l6ODhnb29HRHA3RTlyS3Fh?=
 =?utf-8?B?ejFkeHYzaEZhcjVqVXZFam1pYkZYRExaODYzdmlrYzRSb0NtaktkS05yaXd3?=
 =?utf-8?B?ZU0rN2xsa1pPVDVCeiswOXN5UitIR0o5SHE1bjQ3ZFhtWWhkQkpUUzRtRE45?=
 =?utf-8?B?VkIrTkh5QlRvNTdTdHhwWHc4OU00NlZrMDdaWGpOMVBJNDRoZHB1YWFKcWNz?=
 =?utf-8?B?clUxOHJJYUh5aFd3cytlZDJjb0dTUjVSa2VXMUNSQjNXc01mdWRCQjlSVll3?=
 =?utf-8?B?b2xzN1JmVVBjQU1yaW81c2tmWnN6VnA4NjJJb1hPSDg4LzlpOUIzeFowaFh2?=
 =?utf-8?B?VnNEeEtkZW1BdEtCS3AyUHdLSFI2STUvSEwwaFdSNGRyWHBZYzJvOHJtWHJJ?=
 =?utf-8?B?TmJnaEdzL1RMcE1aUm9GN2paZ1ZmVk1NYURPQkV0YTJkTUlxdXBQM3RHMFVw?=
 =?utf-8?B?ci9yZDZ6WnMyUzg2Yk5nMTlKanFoMEdyUWg4MlhrR0NtOVVwVmJBOTlJaFoz?=
 =?utf-8?B?eUh6Qi9XbWt6Q20xcW4rTDVjMlRoS0dQOVlZekJ3bHRxUjE4QXlob2IwYzhx?=
 =?utf-8?B?UjhWOXExMDNiQkkzVVVjeis0TGUwMDIvVDI2TmltVFgrMW00N1AwZ0UxeFdF?=
 =?utf-8?B?Vi9lbEVWcVN3WTlPTlZhcXFQakRhakZ3M2ZmU1haTlVMSHFSNEZyRG5nOXR1?=
 =?utf-8?B?UnpnbWxLeko0VlNjY1FBSDZjdWs0UzZmWnNwcThTQTlYbE9TeHZrcmQ1dDVD?=
 =?utf-8?B?Wm14WlNwZEN4RElOdmxnanNhaFhMZ2VTWVBKUStHeng2VlZnT2xqTUxZbDI3?=
 =?utf-8?B?ZUovSjlSL3RNQVlJNEZXNlpIbW1Mb2hLVTRUR3NEaW5KV1V1R1N3RTVPQm5j?=
 =?utf-8?B?NEw4SFRzRUZhdGFGWktESnFteWZCQjNxUzM1Q3RuTkw0MHNuY2haT3VqWG00?=
 =?utf-8?B?ZDA0RHlRSnU5WWF1MGtNNzMrbzlJbW0xeGpJYm1oUys3RGRZbElYazBUT2t2?=
 =?utf-8?B?ekZjRit0TktnaWhoeTZPVVF3UlJWMFMyN2hTd2Y4ODIzc0hZcGJmb1RhMmEv?=
 =?utf-8?B?Sm1FREY2ajkzVFlDMGlObUg1K2tvZjc0TUFRc1JJNEJtd3didXBZNkg1aVRs?=
 =?utf-8?B?QTkwdlBYU0Vhbk5DaGJNdUNscTRObjd2V0lyeXNxQjZVMkwxVkZOZVROZkt1?=
 =?utf-8?B?bGpzZTBZQThGWis5UVlLd3N4aVJ1ZWZpQXlLRkVKUlRpME52WHlLSTIyRFFT?=
 =?utf-8?B?SVc2aG9iVTBDS3ozMjFnY1dUZ0xybHRVZzY2Ky9hOHdjWlp4SGU3dHp3THZJ?=
 =?utf-8?B?Y3JaVUhyQkZYY3BjdzRGdjN6Q3huNzdMeFdZZk5jdVBUVDlMdFZHVkZxRHNG?=
 =?utf-8?B?bTlDdloya1o3bG5oWTl1Z0d3RFdTVUxTNTFKRFFaSW9YMUlvejVjOUpEazNS?=
 =?utf-8?B?cXZZVDZoWktNR1cyVHZqN1RqaTBpZi83WXR6dWJWTm5pc3loTjQ5UmdPOUVr?=
 =?utf-8?B?Um8yV0wwUm5ER1NaQ0N3VFdqT2l4TDJkSk1LbVNGMUZPUUtTZWFWRUtPdnYx?=
 =?utf-8?B?VFRrdHcvUXpkekdRTDk4WlBoVHZXQXU1M2xQWmw5MmpOUy8rQnpyeVYwTVR4?=
 =?utf-8?B?UjRlN1ZBeVhOOWZtV1NuTG5oYkJRbjcwaXdTajZTTUJaVnhRbHZLbDJoeGtW?=
 =?utf-8?B?STRBeTRydFlsVGM4V2toWjJHM20yRitRd2dwMjVrTlNWbERUT0p2b0laYUNH?=
 =?utf-8?B?NEppVWdwMjl0TDVEd2phNEVUVGV3MHR0QmpKY3YzRVN5TXVkdlgyRjZUSy9T?=
 =?utf-8?B?cUo0TEJaRCszZ3BMUzl3Uk9ha3NKVVFYUGxwTnhoZGVrWk51RWdtdz09?=
X-Exchange-RoutingPolicyChecked:
	k7uR16+6zVmBY3+N4nxLXVHosnP/wA2MgQqJJtnCKZ+6cGqt7IF/wR7jkXvgYNE6chJtWU1F48ElnjvgXmb53Vx8NVw6AHjXatfOsaaLNzcrhMQSvzniv+XVbnnT86O9Q2/VuUDrC3S5m0sbEruALwrO4lHQThn3yJJhNkFW74i3T9Gt+1ZaWAEp78Wrbdlm+GH435xt3SOpbUqBBpSvwZXdCVcBSZ65eeA2bxnUreGFFKawVCuCxnRaqMXUPl4HmW4wpeeBBAOT3a9oa4Do6Jm9IEsix/FkjOoYoGDaAgSOLpR4THsVDTcGipD4i7EdmCt8UhXcQ8hy4gWuZ5kSsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LemxxGAkzINl8APdnAyZwWQiDNhj0v3KXeFTSghlcbeg/Uy67SeoOu9NUz+ZDx23/1I7qrnOteufA/DkFAyhANOOIW7kHSRVM4pR+dkLDjRQ/EaxIymbI7V5RH0td/Dj9y6kUimjMF2jKS8SyZU3CFnwA54+91yr5GNtBoKZ4E8tDSYm6oUvbfAQsBYfptPmm+1AYvIki1P2s+Xux4zODed8j5iQ84GoKuALnLAVbRQ/y10gVzVZGbcr4sVQ18snoxCRY+koMje1J2hqKNegf+AZE+kvAWhX4/St4qG0xSgtZccErHb2npsFUqKV7BT5AaQN6QVywQBgcIDDiLqGhQtcpeu2Ts98LOiyoUIgvltam+TohvthB1wPWm310vkmLod98+YDxU57lhV4frkizKdwxRqSM936f5OPlE5Pmxel9B83vr/1LN9bsYOIBPMV/c9M6yFbfxS520v0aGSobPlj4KYDsCQDGqBSh56e5GV4ptJpjzzz31BK87nivn2VH2xN/cSEzv8U4craNpW5dnhR6KWAA7tSaR6LhfmcbgwkZ9ijrTccoTVqVCjAS+BERvBntl3xtvwSqbR7gNJQNbO/UKwVt0DH7CtxpNe3J4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b86dfd-225f-4d95-66b1-08def39674ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:41:06.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uumKGKBT8Tb6Lz9G1V88ssxjbqM+Yugy65ZnB4PuHh12GGH7BvtChOe148fBuACuWy9UW6cMI1Dv0/7q7iS6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608060067
X-Proofpoint-ORIG-GUID: BPlyn_un05zwcxZgGW6n_QDEaFpCIyk0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2NiBTYWx0ZWRfX3HEI740AgliF
 +Uj/ANRh9qlE339nJ/J+aJSUbD8Z6bZtPspnkf0MhQmOvAMyW0vtNRq8RVGKFsYmFCJMcaA0F5L
 ROjJJ8X7cRq8bR4Wc1MawmayyvpANJw5W3gg/RzSrD0tfZyC+Xpm
X-Proofpoint-GUID: BPlyn_un05zwcxZgGW6n_QDEaFpCIyk0
X-Authority-Analysis: v=2.4 cv=M/t97Sws c=1 sm=1 tr=0 ts=6a7448a6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=Y9VAO08nlLI_KJAap88A:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2NiBTYWx0ZWRfX1hfY0nUyFkuw
 NYYb4gTabjZ+KmJnRhnddsiI603C7FmfksZ6TXbvfnntLKf5MS12eyJw1fWSbGw0Iy0DqoHm+GF
 ZMBZrpUeNJLvGVRrVNF57J+Ljf89ycMYA+OnPhIFbK5NVeXaQqmJyQyD5+eT8J0y03otUiTjoKJ
 5wnu7QPKSNHqIWbCcyXANXL/fkgrtCY34HdGOEmJbXGUFsEUk33KwQbxNkPcWEcN9UFqPgB5FxE
 VwLd6TgUOniTil79lSdIkvcCnFNJrfHQW4x4qNde10zCXtOa+wmZcSs3l/2ZECTUQgUmFE2591u
 r+rgu1Je6qSz1WMb+GpkzwHWKMbW5KwbUf5ofjpx0Anuv4wBJ1QgdorNmN6BYAkp9kWmOTHwFQm
 lqGcidswIcWnc/g56cApT7uUgu4/W5XqzOmiq79YsU7vuBQ0xeuZSLTXZ/xZnRZw/ENLjhBi/3E
 kUC/KXbgE4NYCk8KL+OIE5VyG/IRBXkVLFA3mndQ=

On 2/8/2026 10:59 am, Tejun Heo wrote:
Hello Tejun,
Thanks for taking a look into this.

> Hello,
> 
> On Tue, Jul 28, 2026 at 02:55:19PM +0800, Imran Khan wrote:
>> Nearly every subsystem defers work to workqueues, and their state can
>> already be observed on a live system, just not at a granularity that is
>> convenient to consume. sysrq dumps every workqueue and pool to the kernel
>> log in a fixed format, with no way to select or aggregate; the WQ_SYSFS
>> interface only covers workqueues that ask for it and exposes attributes
>> rather than runtime state; and the drgn scripts under tools/workqueue/ need
>> a debuginfo-equipped userspace and read the state from the outside, without
>> the locks that protect it.
>>
>> This series adds BPF iterators for workqueues, worker pools and pending
>> work items, so that this state can be walked from inside the kernel, under
>> the right locking, with filtering and aggregation done in place and only
>> the interesting part copied to userspace.
> 
> I'm not necessarily against it but what are the use cases here? If for
> debugging, isn't drgn + hooking into tracepoints mostly enough? Can you give
> concrete examples where bpf iterators are essential?
> 

The main use case is being able to peek at workqueue state right when a problem
(where checking workqueue state makes sense) is detected.
One very common case for us is getting RDS TX timeouts because of the the stuck work items.
At the moment I don't have a system where I can both use the patched kernel and
reproduce the Tx timeout issue, so I have tried to explain the same using block
layer and dm-device as affected subsystem.

The bpf program shown below measures block_bio_queue -> block_bio_complete on the dm
device:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>

char _license[] SEC("license") = "GPL";

#define MIN_LAT_MS      5
#define HZ_HINT         1000

void bpf_rcu_read_lock(void) __ksym;
void bpf_rcu_read_unlock(void) __ksym;

extern int bpf_iter_workqueue_new(struct bpf_iter_workqueue *it) __weak __ksym;
extern struct workqueue_struct *bpf_iter_workqueue_next(struct bpf_iter_workqueue *it) __weak __ksym;
extern void bpf_iter_workqueue_destroy(struct bpf_iter_workqueue *it) __weak __ksym;

extern int bpf_iter_worker_pool_new(struct bpf_iter_worker_pool *it) __weak __ksym;
extern struct worker_pool *bpf_iter_worker_pool_next(struct bpf_iter_worker_pool *it) __weak __ksym;
extern void bpf_iter_worker_pool_destroy(struct bpf_iter_worker_pool *it) __weak __ksym;

SEC("iter/workqueue_pending_work")
int dump_pending(struct bpf_iter__workqueue_pending_work *ctx)
{
        struct seq_file *seq = ctx->meta->seq;
        struct wq_pending_work_info *info = ctx->info;

        if (!info)
                return 0;

        BPF_SEQ_PRINTF(seq, "pool=%-3llu work=0x%llx func=%pS\n",
                       info->pool_id, info->work, (void *)info->func);
        return 0;
}

struct {
        __uint(type, BPF_MAP_TYPE_HASH);
        __uint(max_entries, 65536);
        __type(key, __u64);
        __type(value, __u64);
} inflight SEC(".maps");

static __always_inline int is_dm_bio(struct bio *bio)
{
        struct gendisk *disk;
        char name[8] = {};

        disk = BPF_CORE_READ(bio, bi_bdev, bd_disk);
        if (!disk)
                return 0;

        bpf_probe_read_kernel_str(name, sizeof(name), disk->disk_name);
        return name[0] == 'd' && name[1] == 'm' && name[2] == '-';
}

__u64 pending_report_us;
__u32 nr_slow;
__u32 nr_reports;

static __always_inline void dump_wq_state(__u64 lat_us)
{
        struct bpf_iter_worker_pool pit;
        struct bpf_iter_workqueue wit;
        struct workqueue_struct *wq;
        struct worker_pool *pool;
        __u64 now_j = bpf_jiffies64();
        __u32 this_cpu = bpf_get_smp_processor_id();

        bpf_printk("STALL: dm-crypt bio took %llu us; sampling workqueue state now (cpu%d)",
                   lat_us, this_cpu);

        bpf_rcu_read_lock();

        bpf_iter_worker_pool_new(&pit);
        while ((pool = bpf_iter_worker_pool_next(&pit))) {
                __u64 stale_ms = (now_j - pool->last_progress_ts) * 1000 / HZ_HINT;
                int has_work = pool->worklist.next != &pool->worklist;
                int is_this_cpu = pool->cpu == (int)this_cpu;

                if (stale_ms > 60000)
                        continue;
                if (!has_work && !is_this_cpu)
                        continue;

                bpf_printk("  %s pool %d cpu %d: no progress for %llu ms, work_waiting=%d, running=%d idle=%d/%d",
                           is_this_cpu ? "->" : "  ",
                           pool->id, pool->cpu, stale_ms, has_work,
                           pool->nr_running, pool->nr_idle, pool->nr_workers);
        }
        bpf_iter_worker_pool_destroy(&pit);

        bpf_iter_workqueue_new(&wit);
        while ((wq = bpf_iter_workqueue_next(&wit))) {
                char name[10];

                bpf_probe_read_kernel_str(name, sizeof(name), wq->name);
                if (name[0] != 'k' || name[1] != 'c' || name[2] != 'r')
                        continue;

                bpf_printk("  wq %s: max_active=%d flags=0x%x",
                           name, wq->max_active, wq->flags);
        }
        bpf_iter_workqueue_destroy(&wit);

        bpf_rcu_read_unlock();
}

SEC("tp_btf/block_bio_queue")
int BPF_PROG(on_bio_queue, struct bio *bio)
{
        __u64 key = (__u64)(long)bio;
        __u64 now = bpf_ktime_get_ns();
        __u64 lat_us;

        if (!is_dm_bio(bio))
                return 0;

        bpf_map_update_elem(&inflight, &key, &now, BPF_ANY);

        lat_us = pending_report_us;
        if (lat_us) {
                pending_report_us = 0;
                nr_reports++;
                dump_wq_state(lat_us);
        }
        return 0;
}

SEC("tp_btf/block_bio_complete")
int BPF_PROG(on_bio_complete, struct request_queue *q, struct bio *bio)
{
        __u64 key = (__u64)(long)bio;
        __u64 *tsp, lat;

        tsp = bpf_map_lookup_elem(&inflight, &key);
        if (!tsp)
                return 0;

        lat = bpf_ktime_get_ns() - *tsp;
        bpf_map_delete_elem(&inflight, &key);

        if (lat < (__u64)MIN_LAT_MS * 1000000ULL)
                return 0;

        nr_slow++;
        pending_report_us = lat / 1000;
        return 0;
}


The above bpf programs can be attached using following 2 commands:

bpftool prog loadall sample.bpf.o /sys/fs/bpf/dm autoattach
bpftool iter pin sample.bpf.o /sys/fs/bpf/dm_pending
(sample.bpf.c is the name of file containing above code)

When a bio exceeds the threshold it walks the open-coded
worker_pool and workqueue iterators and prints what it finds:

  fio-2409 [003] 1246.736278: STALL: dm-crypt bio took 950434 us; sampling workqueue state now (cpu3)
  fio-2409 [003] 1246.736282:    pool 10 cpu 2: no progress for 935 ms, work_waiting=1, running=0 idle=3/3
  fio-2409 [003] 1246.736285:    pool 22 cpu 5: no progress for 934 ms, work_waiting=1, running=0 idle=3/3
  fio-2409 [003] 1246.736299:    wq kcryptd_i: max_active=1 flags=0x148
  fio-2409 [003] 1246.736300:    wq kcryptd-2: max_active=1 flags=0x168

In order to reproduce the issue easily I had RT threads hogging the CPUs and
thus preventing timely run of workers.

Another limitation with drgn and traces is that often the production systems
don't have drgn and/or debuginfo installed and sometimes the systems are itself
in such a bad shape that running drgn becomes challenging.
For such cases as well, a quick look into the bpffs to find pending works
(like shown below) helps:

cat /sys/fs/bpf/dm_pending
  pool=2   work=0xffff9987afc27c48 func=delayed_vfree_work+0x0/0x50
  pool=6   work=0xffff9987afc67560 func=vmstat_update+0x0/0x50
  pool=14  work=0xffff998484b39e20 func=kcryptd_crypt+0x0/0x310 [dm_crypt]
  pool=22  work=0xffff9987afd67560 func=vmstat_update+0x0/0x50
  pool=26  work=0xffff9987afda7560 func=vmstat_update+0x0/0x50
  pool=30  work=0xffff9987afde7560 func=vmstat_update+0x0/0x50

If the issue happens randomly in short windows of few secs, collecting
the traces for long intervals and looking for data of that short window is
not easy.

These are the use cases/limitation I had in mind. Could you please let
me know your thoughts?

Thanks,
Imran


> Thanks.
> 


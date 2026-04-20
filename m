Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E43A8756
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709842; cv=fail; b=m7dVF+9kk9yPcRYLnsaN3kciA+MiSgD//7fCo9pFmA+pWjJWzlc/Jd5b27rvfmJN8um5aZhC4tg3Hx9GgpuRykOhrlS4t/g5h6O1fBl+BKiRvIG/ZfoY1JwH+gK7l6iINgNvJstGb1G5V1nT+WWouQKWE3wxDkonCHmb6qXeXmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709842; c=relaxed/simple;
	bh=fd28r5TAHGNSjXG+sUE9sUpT2p21iipHzYckgIExx2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pvZtoDJ5ZrGA1+j8IRdEPhjIjlA0eRYR0Ft3DNYbfs1QWEZvKMih5mxuvEi+Rkmvo7/7xOiGi/mW3Ai8UXKHTCW3CxWM5NeA6DNXu8iWEXUcfFhhTpaVV4ktI90VjuNontwovK0dReFgP+FXlo/ZJDZBLD11u3ExTwzTC1IOtx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XKxYGvCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJWOpD6h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKxYGvCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJWOpD6h"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KIMTdx1201384;
	Mon, 20 Apr 2026 18:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dRXWK2a2sbbPqyAdW7G3UfkxLY/if9of/KE18cr0mh4=; b=
	XKxYGvCMLIZDCzm/QYcLLKke7QT6GLBx4h6YzA8HpOaWQFwzcRxQk+NK6Leay40a
	3O1KC+JqTN02G0FazpwFD+w4quA84YOH1+3ZzoSDS5QvEnSQ9IX+I04004uySFBj
	v6oDK2s8RtOwldhTG38SLJHIYzHOxxeL29VoQuGCdG9ttdnNiQWWWFHKEeBLi1Rs
	u45gbovbwkArTDnv5+YXHU9nNHIfvFjUx++kwyprmpMX9nnnoXEIE5B8FLtumCqm
	36KMRE9TrJIrxOZR0+fcXWBkpaGhjXKng7XqIWWC78LZ98Js+cbNZE69nxv6k9wU
	F2MhnuQv6VAKnLo8lVONjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm28xktqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 18:30:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KIQNkN005268;
	Mon, 20 Apr 2026 18:30:20 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1bn1pt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 18:30:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnlkM6HAfMYOM9lINYirFDcWehCK+En1DDWTR4kPojy51hgnckfz8fLWN3u1vDVmvZXD3I2uHnzLx0izgmBXtGJ/7igYTNGcHbTMA5HsGXIvUJWeaQGC1O+EsAaviUzmLvp1PMIeVMfr8pZ0kPqShX4dMFi/LSta5ZsjQDBco/RdncDIzl+lGbsTlkQJuMKiJSOVqyLj+jF0vVu4+W+AB9on4hYVSmCTHvhHzFpRbi34UZvYmIVWUT3v4IXVHbxIUZUwRebaA7uXu/RPkZuNfE617broVLgFi+gshj2taCcmtiYWNup9q9VYtoHc7rnFJrCVSz8eAerIikclxdXWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRXWK2a2sbbPqyAdW7G3UfkxLY/if9of/KE18cr0mh4=;
 b=IvMCqj8VGoVObQn7F4ydTq6ZlQGdNOw63ixinkLx+UWXmAt8jVGH2Eb+Do+SPCqqV7HH6+OlhfYSxXFIo6F/FbbWu5Y6K36BJS96QTMFM4a56hRpHQemqiBBV6vK8lTAMKltYtIXXhRhlKgHMxJD/4JIg3FtfkxhTUT5CedJEvaexk74VSEa9nHbVjNu6DktP9lCJ1FAx2Ei8ij9TwFqQKAPKA2SFU8n83iSdlIrleRhKcOgtISdbRopYMx/jIym2SSk32m+pjd2zyZl3nDkc8Nir1ghdaUTmtuLoKrhV7YkG57OQ4sK3PAtvWMNek5OyOBRSkL/JWwML9rRKxP0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRXWK2a2sbbPqyAdW7G3UfkxLY/if9of/KE18cr0mh4=;
 b=SJWOpD6h5wrCQC6jwpA9pSRWIGKaqmMQU7+CK9xPMbxF39AZB38c6CqEcm4kgp30f6YQlB9OS01GrswZVqtgHKl/xPinRft5WXS5KHOFg/ItAWONASInhKxGpKDFA8igdsDt5vqkys3T6QYXXu7hzsDzPRYPTcn/d06hx20z+/U=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 18:30:13 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 18:30:12 +0000
Message-ID: <1b1dd492-316b-4ece-a3f4-dd26d85666fa@oracle.com>
Date: Mon, 20 Apr 2026 11:30:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        yonghong.song@linux.dev
Cc: martin.lau@linux.dev, eddyz87@gmail.com, daniel@iogearbox.net,
        memxor@gmail.com, andrii@kernel.org, song@kernel.org, jolsa@kernel.org,
        qmo@kernel.org, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <20260417143023.1551481-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|PH0PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: a75bfbef-9996-459d-f281-08de9f0adc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M8EX2JUD+RM+kTi3KIeluy/vHXWVWQSyy2Qoad278ZM1tUhIbfCdovkC/YqQ7sA5TvBu5ZyiVNLQJsaD3MPLed8f+URoataE5LwBVOu/3tLQ1AvV6V02SEP/n28F+9+L+/g5LKhVyKVA1MOKhfsfkcT59mMgn8tlKY8VYtRTjx1HV8hvzYu/H7S5H37f9raAYi2DvYPV9YSlVzAKxjtKO4MpNvZCzAqS0jP1SE7UTxZp9cOv3n+dqu8Y5LwMNJwUD+46DLqxQmv4hlbD38ycQ/nIkItd7OJPnwoXoZAY+X4B6hxY4tfPVMkU7hk0AxP826ckOURZdPhk7tI5M8j8QbUMsR06B+qF2CIYGOY3mHFjhxDEXYUoi4O6BxGYWwyNG8chgnfrZ49cxn74Yvm1WBMw8ByYOsW0O5/dMXh3/hPHSo7L4spsxFdryUgPeTJaVaGNHupNlVnekeBfQrE52djcXurtpTToYtALhU/hMHZjVYzXOhZAJ8O681Tw58tz3JbmiB4UTTFunRuS5d+wSzVGhzyzhIqmphXl25Cqavt11swMObDTdWB11LfFRTczlzo2Tw/C9wWyDkSiPj3o4l+09gT7P54TCqDbIz4TnHhLZN3vKExKQlfSuadV8RBl17hWc9ujYqsNLqkNlYv8dYzQRdJ9Adry//+iv+unb/78+RdFPAVDkkY2Uu7r/th15NMvlJElx3M4sXGL9LQcsZ3THa5ctHjpFMUBHp7+GkP8OhvzP0q+Z6WwpwAHMne1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2kwQ3NnSzVpTjhhblZmYzMyWm1RbERNTzNHOERkVEtXOGdwdTFwQU5FKzBi?=
 =?utf-8?B?M3hZUmZDQmh1dkgvWGFPdm5JaExCTElGblkwUTZhTHBYY0NjdVJHWnk0MzB6?=
 =?utf-8?B?RWE5dDNKVTlhd3h4REpRdDc0UWMrWEtxdjEySGxTcG5HTzg3TTNYOFkzYkVR?=
 =?utf-8?B?NDJaMThxTHdHT0ZkWDBwVXNuQnB4cVZ4SXJvUzhNZFAwMTNzNURlVWRQRDZG?=
 =?utf-8?B?ZGdrZC9NeXo3dzYwdmhwNGlIczhxZjNMbHNKSG16a01xUXE1SHVVY0pEOGxF?=
 =?utf-8?B?OUU3eTQvN1Q4YUlKbzI3NGdNT3M4N29QVnRqSG5IcVB6eU90aHYyeDg1OUtV?=
 =?utf-8?B?eUsxQnV1c1lIajJsOVo5SE1nTnUvV2dsZFd5ZUJzWTlLc0JoNmQ1NjhtT3V5?=
 =?utf-8?B?dFBQUnM3NHFLODNlbkNoZTB2cm1YbXJKSGV5bnJRVWxKeXJRbzBPOS9vTSs4?=
 =?utf-8?B?UFhPV0NETEwwK0Q4Y0FyempnTEVRd0lXbXMrdzJ5NmltSmxUN1RVMGRkc2Vl?=
 =?utf-8?B?TEpzRWlvUlhIQ3NVVWhiVFk2TkJUQnFzRUl0RDA3WUpuTWExTU83RmFLbG9R?=
 =?utf-8?B?S1lLYVJBVU5FK21nM0xrMTFqakZSZiswYnNVNFVEZXdTRFdOQnphUCtXR01m?=
 =?utf-8?B?emhQTGxuMXowQ3M2RzVaSmtZUFprNzl4YldnbmwrNnF6WXlEbjRzYjE5bjRP?=
 =?utf-8?B?YjBzWS9vNFFaaWZLbXRhQjJXek5jYlFlekNIU1JwVGFPZlAzWUw4MXNkUUdU?=
 =?utf-8?B?TkNmM1VwMWJ6KzdLS3Q2NVVNZ2lSc3lkbE45OXBwSEVnV3U1RGwvbUZsVnhM?=
 =?utf-8?B?cmdjc2Vrc0FxRm5kL1lhN2o1azBhVUlwdkJhVEZESy9IL0VYUzJkbks1L0N5?=
 =?utf-8?B?UkVMWlZrZDVKZVlCcVhQTzlhOUo2dDlKUURXenJ6NDk2c09oZGwxNEwvdnBa?=
 =?utf-8?B?TDQzTmpLejdMV1FmNFVtVjJEcUF6aHA3UEdvdjR3bXY5MDhRNWZXb2RqUmFm?=
 =?utf-8?B?REgwMWlISmxIUkkzYmtTd3J2OFAvYVVYRERsM3RNTFdKaDdQSlpGdnRPN2Mx?=
 =?utf-8?B?YmMxKzd5cVkxSGdCWUtOdzFTa0c0ekJFQnFtQXlPM3ZoWTV4NEY5OGZ6VGNn?=
 =?utf-8?B?QUhHY21qQnYrL0lja2ZNTU1Bb2FHaTM1cWM4aWI0bU1ERTNMWkxsV0EveVB4?=
 =?utf-8?B?cnRxcmZidjRmUTg5eFFJQ0NOZENmM3ROQ09ZblhGK1o1SG15cU50YWtwZlhn?=
 =?utf-8?B?TE0wMzhyLzhQazVvT2tBZnB6MjRkVitCL0JYZmhFOVhSdnlSbGdrVGIxd0xy?=
 =?utf-8?B?aExhUFZ3M2JOc2EyRUNiRk1QaFBFWng4U3VGcWNZcnNCT0tGd1owSlRYRW5l?=
 =?utf-8?B?b0V1c3NyTmVuS3dKMnRWbmluOW1GZnM4MFFGUEZWWG9kei82aU1MdU8yckhX?=
 =?utf-8?B?amt1T1dIMHdXaUVIR0hYWVZuUlFsMWdHYm8rVlpDWE8xaTFUa1lpRnpkTGtU?=
 =?utf-8?B?aG41UkNCdzlFdTNzZnI1b2hMd1JGeHlsaXhlV1NpdHNycG5kczBaR3dQaFpv?=
 =?utf-8?B?LzFRemUzaDNOOFcyc0RYcm5UV0lVaThybFhRRWRaaFNCdS8zODRibmFGcTNy?=
 =?utf-8?B?M2xUUjRrVVY0NDNhc3Y3bHBOUzJhM1ZTeTdueEFma3JZVTcvN3BtWjhkczRs?=
 =?utf-8?B?WHZuVDJKMk9tQndWcC9PUVZEdFY4V05IUUE5Uk1NN0lNQjNmak95SjZRcVRu?=
 =?utf-8?B?OEtEbVZZL3p1dXRuQnZoelIxR21KeWZaNkR0YU9IT25pM0hISG5MNVJyYjFU?=
 =?utf-8?B?STlBMUNER0tlYkxhS1hLckZaVDFyM3ZSNFpTbVpiU050akdtQUllcnpSUytn?=
 =?utf-8?B?RVJyWGlvY2NBSFRjMi8wV1lrOUEweERtSW5LaTJldTk4YjV2RldBWVpialk4?=
 =?utf-8?B?bTVtTjRxMlRyM1NzU3pJMVZESEVsZmlBL2tUZlV6ZUJsSXJ6TERUNnpJWGVr?=
 =?utf-8?B?UHJXVHNnVXFRRWZpWEw3MmEzUSs4SEoxY29aTmczc2JoSlhMcnZ0dXVEMWJY?=
 =?utf-8?B?Z0EvZVlXOThIVmlCYlVqbm5DazYvb2lDbXNYTWQ5ZFRXNDQwWTUvK3RpakM3?=
 =?utf-8?B?Wk5nQVhRVm8yOWU4OGM5K1dnaGlIc2ZNbHUydmltZnJFcDJ4TGFXTjZoYjBH?=
 =?utf-8?B?elhuYmZKUFhLT2J4QUp1b1hqYUlYS2xiYjBRRjVRYUJ5czJPZnFXalpMNTM5?=
 =?utf-8?B?OGZDMzIwdUNtcitPVVdxQVpnWGkxSC94cmxIY3FEVWVRWm9zUFNiUmpQYUJP?=
 =?utf-8?B?U01xRGh5UzlEQm5XQ2tjM2I1eHN5WnUwS2NDQVdhalBuQ09WcXZSdz09?=
X-Exchange-RoutingPolicyChecked:
	KIT2G+WFe1Cgh6+voTFIYIERcsYXx2CbrPW1wThmuuL9DYVW4v22DKQHmeJ1WDcosoCOWUvq6DvJmsvn81U0jo7OJZlBBzmzt3lzgjI0bcpNlof0HeHHM1uORZtfE0AY0Jm+kEGPT5LLcVKpsIeSakD9PhGBdb0kHQ3RTC+b+87UkJDXZke+0x2wm7INIb8m2ASDCXiDUHJIRLvZoOD1iexiFICF+HhbBa8l+FvUF8aIAi9mY1LZlXvEhnzY0jZyRr7VD1apEz5rS03A8QL95g2AvSqSzYERwkCo27MRWZrG0tyWBUeEWEQIa2WOuoWKhN9bRRwtw1WNPxgMlD760Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uij0rpF3bfAbeuvLpAGiFIqFzs619djgA5tjPg6NFxjsjB5yQ3/EGlhfNcNnFBB2YwouT+lI6cS0v8fUa0UQ3EwHhLTdfUrwO0fgGMXr/W5t3DAdVloge3/S60nOqJ6OrKqhn/NiWy9/6uK8RnK6LWOB6nDBfsfqUXWdNLUDU9brcPvXp+5scDyezNee6HFTtfg28rhPWXxjfDQKjgTcvWUaIRZvgm8wsGOWtT6QKtgvZRQTaOQrrKb8B3b7DaGD9O3MLIRKrUlpLmsfERLFz3JhLS4zXR0SKpzUnSbFYhm5AwCIQNIdgMnRU92e0m/rpDaAqDsg3mJfQlfXFmrldmFJr0GtBxCyPHPW2ABeXz6LvT/wE7eB3mNtxz75iOVoN2bgJoHYBFQLf9/Uv9jsAe7zool79q30+ZkGicids3n48QzqTlUj2fu1fQcK/U6lSMNOziUXkOx/wU5auqCNI4BwAqagR5nGLYAfETlGXY/f6ydKoK1DYteA0xdlsBuxLQR3uOwpAybWjH38SAKQGPUjO0xcZkPtwiHRIx95bXN2tmzqjA+nXXtnFzwLEPHlnmLFMjnBdQgpAomiI7VFTuInYa0QUJEpELB1uTLYHvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75bfbef-9996-459d-f281-08de9f0adc1e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:30:12.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Elc2utEVqW5zpegkVrgxC1UDBHHGqGln+dn7crMrNfpVGWXeeYp0BAtSKsM+zKcejUby41UeuR0+MDV38fpuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3OSBTYWx0ZWRfX/n3oDXKysM36
 Ao9qOJDaTQaRHz77kUr8jD0XbvZ5i4RRIcnVVpkLQbEwHlMXlXBemnVXFGnGIRswfmItpR1l/ps
 n6Ac7ed4YC2D9sHZlmnLOpGDfCcdeMwRQO0dpadgexHZiE+I/KOtFctMBTLXuH4Ot62F6e1z8iY
 TDlYL5ORJaQwUtGv97K7afZb3SB7CDCWtMdqhZD/fiWRSdU17VXNCyVQu546wTwcSufDHxXMp0j
 +N631Gg2Hto3UgG3NfjaBh8TpnOExItuUSC+mshHaDDFHk9JieqsUv/cguDqgKWYpTU0H/cQfxz
 oPX0IHzbDDTGh4UjUg6LuxaxVznoJg9Dx/lQ7TZGZqH7LKoHzNwXoWoFc9Z2IUNs78oh7ehUwdu
 iRgyBJy/3+SmHuiYDMudU83q+u6Mf0ojSK7Up5OuiDd7/zrxAmDs+VTm7lGMoI8OmlcSS/YTDII
 9E4oB2G6ns6qnm8me6YOQIN2MTRcrr0WizexGZEw=
X-Authority-Analysis: v=2.4 cv=er3vCIpX c=1 sm=1 tr=0 ts=69e670bd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VYRGLH2NoJJrk9D4WmUA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12291
X-Proofpoint-ORIG-GUID: 9AE-4U1Meca1zUiWT8riPtAM04PI56UT
X-Proofpoint-GUID: 9AE-4U1Meca1zUiWT8riPtAM04PI56UT



On 4/17/26 07:30, Alan Maguire wrote:
> Currently BTF types can have a maximum of 65535 vlen-specified
> objects.  While this limit has not yet been surpassed for existing
> cases (struct/union fields, enum values, function arguments and
> datasec), upcoming BTF location information - specifically inline
> sites - will hit that limit.  Utilize unused BTF info bits in
> struct btf_type to increase limit to 24-bits (over 16 million).
> This is more than an order of magnitude greater than inline
> site counts for the kernel (~400,000) so should be enough for
> the near future at least.
> 
> Similarly, struct btf_type uses 5 bits for BTF kind values;
> currently we use 20 kinds, but BTF location information will
> take another 3, and conceivably providing better support for Rust
> types in BTF (now that modules can be built using Rust) could
> push us close to the max of 31.  Use 2 unused bits to provide
> a max possible kind of 127.

Should we bump btf_version in the header for this?
(e.g. when emitting from compiler)

It may be useful to know that the BTF for a given file was
constructed with the new limitations like vlen in mind or not.

> 
> Patch 1 handles UAPI and kernel-related changes.
> 
> Patch 2 updates libbpf to have btf_vlen() return a __u32 instead
> of __u16 and updates consumers in libbpf accordingly.  Also adds
> bounds checking for max vlen.
> 
> Patch 3 cleans up __u16 vlen usage in bpftool.
> 
> Patch 4 fixes up a test that relies on BTF info overflowing
> maximum kind value; fix up the expected error to be an
> invalid kind rather than (now impossible) invalid btf_info.
> 
> Patch 5 fixes up __u16 vlen usage in selftests/bpf.
> 
> Patch 6 syncs BTF documentation with UAPI changes.
> 
> Changes since v2 [1]:
> 
> - dropped backwards-compatibility macros (Alexei, patch 1)
> - added additional vlen bounds check in btf__add_field()
>   (sashiko, bpf bot, patch 2)
> - dropped sanitization check in libbpf as older kernels will
>   reject BTF with extended vlen/kinds using BTF info mask
>   (Alexei)
> - fix more vlen assumptions in prog_test/ctx_rewrite.c
>   (sashiko, patch 5)
> 
> Changes since v1 [2]:
> 
> - added redundant macros to UAPI in case enum switch for BTF_MAX*
>   values causes problems (sashiko, patch 1)
> - updated feature test to use BTF loading rather than vmlinux BTF
>   lookup, in line with other BTF feature tests (sashiko, patch 3)
> - fixed up a few more kernel, libbpf, bpftool instances of __u16 usage
>   (bpf bot, sashiko, patches 1, 2, 4)
> - fixed up sanitize selftest cleanup (Mykyta, patch 5)
> - used unlikely-to-be-used kind (sashiko, patch 6)
> - fixed a few lingering selftests uses of __u16 for kind (patch 7)
> - update btf.rst with new vlen, kind sizes (patch 8)
> 
> [1] https://lore.kernel.org/bpf/20260416143904.1220662-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/bpf/20260414195019.684531-1-alan.maguire@oracle.com/
> 
> Alan Maguire (6):
>   bpf: Extend BTF UAPI vlen, kinds to use unused bits
>   libbpf: Adjust btf_vlen() to return a __u32
>   bpftool: Support 24-bit vlen
>   selftests/bpf: Fix up btf/invalid test for extended kind
>   selftests/bpf: Fix up __u16 vlen assumptions
>   Documentation/bpf: Update btf doc with updated vlen, kind sizes
> 
>  Documentation/bpf/btf.rst                     |  6 +--
>  include/linux/btf.h                           |  4 +-
>  include/uapi/linux/btf.h                      | 26 +++++-----
>  kernel/bpf/btf.c                              | 27 ++++------
>  tools/bpf/bpftool/btf.c                       | 17 +++----
>  tools/bpf/bpftool/btf_dumper.c                |  4 +-
>  tools/bpf/bpftool/gen.c                       | 16 +++---
>  tools/include/uapi/linux/btf.h                | 26 +++++-----
>  tools/lib/bpf/btf.c                           | 50 ++++++++++++-------
>  tools/lib/bpf/btf.h                           |  2 +-
>  tools/lib/bpf/btf_dump.c                      | 24 ++++-----
>  tools/lib/bpf/relo_core.c                     | 16 +++---
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  8 +--
>  .../bpf/prog_tests/btf_dedup_split.c          |  3 +-
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    |  3 +-
>  tools/testing/selftests/bpf/test_progs.c      |  2 +-
>  16 files changed, 119 insertions(+), 115 deletions(-)
> 


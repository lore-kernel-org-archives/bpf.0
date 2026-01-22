Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177CC43C061
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079785; cv=fail; b=iss/3x/zwzLRMJ/n+Iw48OBs8Xsm4OvuFF1gCtOwVU1EaiktzOITAUi8tlxMDS+BYUPu5902sNDn2P6D49O6a08Wzw7loSo5J3/igU/gLhM7edSrd2wTZ9P3muDgRXZ6USgky4qDDVuOX1fEQVCXT3+gdu1+OILXD7dDSHt49VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079785; c=relaxed/simple;
	bh=X4iYcA/lp9CerJZCmPTlk6FdZYNCE65t9coIqwOXvNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOlnQfnVXRfybNpYjZK6hWBjQBCesQMU3AueG0BsX781laokIielql3N6lO14gKmCwZt7fGEgulveakeddlD9V8AsGV223Q9KxytHnkjCKHKL6Vm3V+95Oet1Z/ThKwUNHiRXQAtxcm/EWNUHwYZvEcvNSLPfG1J7JlC4pJvdGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CistXiiG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uHhEoBwl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CistXiiG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uHhEoBwl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LL97E01160809;
	Thu, 22 Jan 2026 11:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ExdwvxfvOue1xFy6Kfft7+jtKxCh8jYxUxKmIzIh7Ts=; b=
	CistXiiG9/uo7ycig5GI5X2mbx6hz3FolJDSfeu1l4iPGsgo53EHOcklYCE1pb9F
	wvkYDuz5ACbwJXpQdAVp3v+CqKGDCgCrskySpBg+7Cj2L0Rq61BPL67gzCK5fyUT
	G+Cv0bOwVlMSiZ0IZvDafYbZZssrIM0TkehJSgJ0gdmWz3Id7Q7qYeT60ewA1aKd
	rks9djAZZNMaOIAi6XYhtLmX1k5NqsAubHeZ5kcPvLccomWAMqo10D0qt7m79kc4
	3VUj0WzK2rFkj5Bv5k3DpfQNs/nrJATsjGJs5xTopXYcT6UWPghbXhUKt0iF/EC/
	NvEwGduo1r4z2nBQVIJPNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qfq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 11:02:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MB0I4Z036772;
	Thu, 22 Jan 2026 11:02:38 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcmwqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 11:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIHl0fzn/w1SqJJVVdhNCsDYgXHql0KsxhknPmMxCmIkPZt1zWGKBg6y/e3xo4oGq9asyOYKbrV/BiHoEfoSyLS6PmBmipRDglrpA2rWDY5CQP5oy1p4teOzAtf6lZb2U0yyU6YKI7cZ/y8FuR6tiCNgBPpCox8rv7dbSjnsauliOZj+qaQnAHzKprFnTNCHD7xK4w+xiJCKHF1flhLxQ3ZumJ81CClYFS42yGiJwVP6QkKdZT8hjsxkbC07TZvCEk73zuS/EBYXqI02Vym795U+0lCfedQPeTbMT1RKNml9Ry0M7VlQoalf6ONWDzEQd0xm15Lf8eaZLt6VOlfOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExdwvxfvOue1xFy6Kfft7+jtKxCh8jYxUxKmIzIh7Ts=;
 b=Z7twp7snc+ZV7y9xCqpcPPrLlTurVjSSnoIK1nYHiXn6+Cq3nuOLQSIv20FuTKlfcW8YF/nAmLlfXXw1E/RqsAxrCmQi9OsawQ7ulgq5PLwSRPwgdwC/ZtHqHTbBXj/cBAx7jkzX8Q+8vrpX+HJ85zKi5Nid+MTEAjta0kYY8bPq7E3RRW5uEUSNlCj/G9PhhbNlQwF7rT2IUmYcXqCcDyUKd0JrHu/Z0MUnir29s5+Uxc6bycON6U5iCorXX0j4YaBilV8dPaN7k9xkcK951WmZzYgmJF2UOdnLLumeChJf6NVDmaIe6MMFQjGjUhHdpo4P5dbnmXDttoEU1Lj/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExdwvxfvOue1xFy6Kfft7+jtKxCh8jYxUxKmIzIh7Ts=;
 b=uHhEoBwl8JS5E9WOAwK4fvfrepzEn8E6ERguQn2zhi7TvmPDcRyJA2Lnvc3htvT6nuYJ3FdQpBCvpk6eNf908G/lzqNtItRO67KF3r/7HHNaxpP79qJjgIEIzJ/0J6N665GP8KAShD338SWgUgo4Ca35C/wrU72p3Q6jG5jG9Tw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 11:02:35 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 11:02:35 +0000
Message-ID: <45c5425c-351c-4db4-b069-9ba0a03a7021@oracle.com>
Date: Thu, 22 Jan 2026 11:02:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Amery Hung <ameryhung@gmail.com>
References: <20260120210925.2544657-1-yonghong.song@linux.dev>
 <20260120210930.2544950-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260120210930.2544950-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: becb6fdb-a9ca-4b5d-8b2e-08de59a5bfcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk52RWhScVJtQmVvTGdzdWszU3FTOXV1c3dMWktsMGlPQ0RkUWsyeU5kNXhq?=
 =?utf-8?B?dGtkSjhMMFE1N1hGNDZPSHFtV0VCanphZzlFRWZFU09ZSXRiQ2M1OHVsYlZh?=
 =?utf-8?B?RW5kUml4UkgvakxjNVovVVdST2huUFZJOXVBODcrNW1JZXVwMzI1aHhpUEpl?=
 =?utf-8?B?SEl5RVFoaGpLdFU1dWw5a01Lalc4NWpuTWNoaXcwUFFLTS91NTU1a2U1Wk1y?=
 =?utf-8?B?M1paZXJHMDl3azlHTTBudTh1ZnFmTFJmaWpEanoxMnNzWmt5ZzB5cFpDZ2c5?=
 =?utf-8?B?c3RMazc2N3NwWW5IZ3FIU3N4M1cxd3BrbElkakpRL29uUVVhbmlwMmQ3WTlN?=
 =?utf-8?B?OC94OWNFQ0FoSTdidytUYUtvbThCeWNJOEZLU0NOZ0NDeFoxcFhsR2YxZkpr?=
 =?utf-8?B?ZnVkSFFZOWR1bGYvajVkUmdORXhBbWttSDlKMCsyZHdjejZPUGRkZjl5VjFl?=
 =?utf-8?B?cmIzMFFQQnp6OGdVVzJTYUZOTGJKMkhoZTFQT1BONFRQekhhbk1tQ20xemxZ?=
 =?utf-8?B?WExHNnowcXZCZTh2YjUyallZYjVvSW53QU9yUTZocjcvOXdGNFAyQWM5TXgr?=
 =?utf-8?B?Umt4VXEwYWpCWTk5bVYwWlU3TDd3QmVwYVhyVEVlaTdyQWJrRjJlczZjN1Z2?=
 =?utf-8?B?eFQ3VVE4UDBvOHZTeUpjTlMreTRiTmluOG1WeEdZTmNDakN2YkJtTlFkMm55?=
 =?utf-8?B?VnRuRmlGTVN4ZzlPbHV4eWFLWWp5SkRnSUFRTzFjTmJRMXB1ajBKMTMrOVll?=
 =?utf-8?B?bW42UTdrUFNCenFDbDMxTUNucWorYk1GMkMxNmxIWHdITGhSNW1lZWkyNFYz?=
 =?utf-8?B?bUg5VFBDRSt6b2RPOWl3SkxVT2UxV29hL0tvWUh2dDFuek12bmVycFdJYnhJ?=
 =?utf-8?B?MGExYlprbk1raXNlRkdMb2xWWjVKN3creHpmRFFJc2x4Q29KV0JLRkE4K0xw?=
 =?utf-8?B?Zlg3eEprakJOUEQwQ1BMKytvRmtyc2RZL0JtMG41U0FwOVRicTNQcE9FQkQ5?=
 =?utf-8?B?RGcxcTkrc1ZadStqM2FORjI4ZjFtQUgrbUxXc2hwck4vZFJlbmxrNFBJZTN5?=
 =?utf-8?B?YWNtdHp4ZUNjclNWVGpKSnkvakQxWFNMM0NNRE9OTHIybnJsTkdPYlF6eXdP?=
 =?utf-8?B?STBSdlB1dTdHaHRmRlpxNGFwYmhzWEZESGpYNC9hMkpBS3h5cWJrdWNEZjd4?=
 =?utf-8?B?RnA0Wml3RTdWQlFQNGt0T0k2N0d6MVoyVHBTU21ublpuZ2MxK21RbTU3L3Yv?=
 =?utf-8?B?Vloydy9RckxOaGZTT2R3ekN6SGFTdnFlb2phdG0yK0JVTjRkMnJycmJ1MkxP?=
 =?utf-8?B?dm9WSCtiRm5PeUZPN0JLRFpWd3J4TVpJWm5aZytmSWM4VVFVK3MvUWl6bmw1?=
 =?utf-8?B?QUJaVGFFMVF2cUUzU0puQWJxYjlidFVYcEppTkUyMkdoSWxsZ1RkdVRmeWJz?=
 =?utf-8?B?QzlPZHZTaGltb2tpUStLNHRjWit1ZkhsczlBSTdNRks4eVdkM2swR3o5amZt?=
 =?utf-8?B?dVNhaHA3UlBjSFowRW92a2dwWmdPYnhxUnR4N2w1ME50NndrNDhjYTBBYUVI?=
 =?utf-8?B?ZlZYN3pTK3paNW9SRmNObE1DYUNDcVZCTHhwUlJubFA5bFExQ0J2elU0Unc5?=
 =?utf-8?B?Ni9McE5TSzBtQXNIaGxlU05WYTlZeDN2TDU1Tk8zMUhXcDI3dHBhRVhXT2NL?=
 =?utf-8?B?Ujh6bnNWTkVadml1YUdmV1ArL0lYMEwrUHpSeDZDeHdZenJuRHAvK0U0VVZQ?=
 =?utf-8?B?U3R6eGtvWlBTOHJybU5VNnpYS2dQQiswL0twdDhOWksvMk5oK1ZzdER2MmM5?=
 =?utf-8?B?YW52cTNmZmhrVzQ3Vmprdm51ODNkZkdEOHhvd3V3VS8vbS9OOUdDenhkcXJ6?=
 =?utf-8?B?YlRaT0ZDNy8zOTE1OVZhUzNiNFBHMzlOcWtNNEVFNisrUDVzbmF4eEdCaXJI?=
 =?utf-8?B?MFhONjRnZk1TdzhEZnVONkZpLzk0Z2p0blJJSlk4ZHhuMnZIbjBmMVBzejRh?=
 =?utf-8?B?QkVFVHJIMlIxdEltemNZeXZ6Y25TTU1xRXFTVy9IK2o2OUU3QzArS3B4ZmJL?=
 =?utf-8?B?MmxMRkFQbm42MGNYYnErcHI0M0FLRHVKWURhNWprc1ppbHdLZlhHVUdnbTVh?=
 =?utf-8?Q?0O6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmhWbUo1alg5Njc2V2N3OEk5YVR2aG9oc3ZZT3hMWjRJajB1ckRjQWxsZzFG?=
 =?utf-8?B?YkdYQVIwajR2Q0JmeUNCMStQb2lhV1FiTlNONG5vUXoyVk1zcVNtdnpRSThG?=
 =?utf-8?B?dDBmOTF0T3JtODZhZE96Rjdic00rL1dxd3JQZWdVbVB2NlRHQlRjWlh1R0lz?=
 =?utf-8?B?R3ZrME5rckZpVmxBa05iUUpJaE5YV21ZVjg1bHZpeW9Ha1NPNFFnUXFJYU1C?=
 =?utf-8?B?SVhIUGdoUVJ5di9McUJaYXNKR0srdWhmYlZSbFhoV2RBRFNPbHJuZmdOcWdZ?=
 =?utf-8?B?Q08wT09LT2tUY1FaWVVLZmtzTzBncTI0b3NONHN1VkZxRXlybnVsdEZHQmtm?=
 =?utf-8?B?NkJDMW5zbjJZSitPWlN6ZGdwdWNGY2hEUWUzZ3FBdHRqTkgxcVljU3dodGRv?=
 =?utf-8?B?SDZjMCtQVGltejM0dG0zL1E4SmJmYzRmdjBOL3gxT1hmdmlpZUNXZGIwK3hu?=
 =?utf-8?B?OUtQd2wyZkhxWkZzZDJ6U1NIUWluMHhaWDQwdWFBV3BDUyszRm1PcUV6UXEw?=
 =?utf-8?B?cUY2akJ6MC93VlFkOEVSTW9WdDZkb0YrQXBxbUJRVW5uYVNpbmd2M0Ewb3dJ?=
 =?utf-8?B?OEZzNlRIQTEvdGxRVHhZanhCbUw5cDZtQzhMUUhNZVF4UU9EdzFhL2djY0k0?=
 =?utf-8?B?a0xjd1lRM2J1aXVTTW85VFpDWUFTSzRENzNwSkk3MmRoM1FaZFRzQ1FpOUdh?=
 =?utf-8?B?OWw0Ky9ML2hYK3NFNXRTdmtlUU8rZDc4dWp0WExmU0g5aERLWVo2WUNJYlhN?=
 =?utf-8?B?VDlUSWFEMitEN3BjdlkxMGdtZEFwbWxKYlczcTF6TEllU3NiUTluSjBkN3Iz?=
 =?utf-8?B?WUV1YVZ3Q0ltYm1TNFhBQkhuUjk1RjYxQ2luRjVudERMNnA0VUQwWFFEcTdw?=
 =?utf-8?B?TXoyMUVFaVFubXBrL1RQY1R2NFpLejN0SDJhYjRiZkVkejYvWmhUL0hudjFr?=
 =?utf-8?B?LzJNTjlMbVdJeG0rR29ZTEhpSGhjOVNMdElsZEQ3RWdPYTErQnpoenJONXNZ?=
 =?utf-8?B?eG5qUHVDSjdEdS8vaDJqME5kRlBPTUdsUVp3T1FWMUxZenliQVFnV1RZZ3FX?=
 =?utf-8?B?T1B5MUlvMGZGczdPalZFMGtDZmlsalVFOCtXVFFES0l4alNDWmZ0QldMRWZi?=
 =?utf-8?B?WTZCK2E2MzlEZ0w3N1A3R2k1YmFVWElLaXBWSkw2cFdXUXAxU0t1YW9xaC9o?=
 =?utf-8?B?SHRSdUV6NmxQZitRMWI4SzljbC92QzhxUHRBV2ZNZTRMb29ScVd0UnVvN2NJ?=
 =?utf-8?B?NXVZZ2cxY2dabkwwQ0pGRG5ObUFwRmgxbGthOXNiUEgwS0FROXU3NkpnSC84?=
 =?utf-8?B?cVVPa3ZsOWZXY1dlcUhaSFhySVNRL0NmUFJRcUExWVFrNXB2clJDZnJ1b3lt?=
 =?utf-8?B?OEtBa3ZtVUdaWGQra3QxbEZuV3hwaTcvUTR2STliNzB6U3ZDT1FpZEV1ZkhI?=
 =?utf-8?B?ZjlUY1FFTjMycGRjdFdJUmhocEYwazROWURWcmJpNmttaTFpaVFQNVpMcDhQ?=
 =?utf-8?B?Z2JUQ2MvZlgrUDJhcE9qY0kzalRnemt1dkZ1SEx2VHdBRDlWdFd5dHl3Wm04?=
 =?utf-8?B?V3B5bThsY1dRbUFwbDhHVmRFVmRjajcrbEtUV1dtc0Z1M3IrTUo2Z0dxZUJU?=
 =?utf-8?B?aVJ2cHozbUE0VG0vRS9KUWU2SnJmZmNkSkxuMTBqbkUrR05Ra3NOZitWV3lM?=
 =?utf-8?B?R3NMODZHdVBDZy9MSzR2YWkxSUlVTENDaWN0akZHU0MrL1dYWktOSmp4UWxq?=
 =?utf-8?B?UFZkdURza2JnWnZsQkgzYnlBUEdYZVdYYjRTQ3RSc1JLN0lrM2R2NWY0bnBq?=
 =?utf-8?B?ZWFWY094enpZWGJHTm5FTWJFZlBWRjFqZDVETlUrS2FheFZNU2FNNVY3VnBI?=
 =?utf-8?B?ZnF0aVViMS9nKzBYWGVOSjdXQWZRbnc2RXk4WktjSFFrTW5FcmFEa09BVjlJ?=
 =?utf-8?B?Zmd4TGE0alQwWW81aVZLUUQwQVRlaThURHV3RzBMNFhWeStyd1RQb3E4cmJK?=
 =?utf-8?B?UEtTVGVPNmY2b20xcE11SXJkWVhENnBWT0QyLytBeWdCcTh3UzVRdFg1UVhW?=
 =?utf-8?B?SDlHS3lNaVZvcEhjZ3VIWlZDcXBWTlVTa21PS01ueUFqMEhVVkpMYkdBb24v?=
 =?utf-8?B?djltVXlzanpHaUlGaTI3SGp4N1Z0MlY1MExZWnBXUkdhSFlnL2ZDMWdHTkJj?=
 =?utf-8?B?TUFMRHlrTHp4MHBadGNTVkd5aWdCMGNwUEg2c2dsRkFFazF2NDBHTjdvT2wx?=
 =?utf-8?B?WWMyL01VMm5kY3AxWThTQlI4YlBHaVFHOEpFNHhYM3dKVGxhQUNxeW1yR1d1?=
 =?utf-8?B?RnFXSk1UTkQvZnczL3ZQRExQd2NuOUFGMWtJa2cvaFBWK3ZRejZ0Zz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qpeRQUcjz/b9LEBfz3cdRYEgi2usLVUHQ+0fbSwlOrXZbc9IOGRxQpJDXzVgCUSKem8Fkz7Dh6pVmvooYzMk1lpCDFc1y7mKQP0yIthATj5EVAdiT0v3dLt3UQruFCcqQ6usg7d8SsfCnWyc5jXGoHqvAYdEjZcogUMiAkV4VgpFF8+nEzs4WY4V6Up8Zj+ni2XQcNqTMfGgL8rKTg4R+ztxq613he2ZlSdobOLzdkKsfZuPzHw4uBiwjrTdDxVMaANUEoM45+sy5yC9NLyReNsWxiAP5+c3qomDHRjWt0BlO/N0igTswN+6w7O1FTBzyvc2qaQhnga9JohHdj/8ICkpLHL/dFL5neNWc11VwRlzkVgoVo/hPg1KkryrQMZmlE3jJ95nDPjVNlpEbs7IjkAy/hKYdEU/HJwI/xmaMfQHS86f16igtcKin4LfFqP5aBu98NAnkePD16rcDbKwThDaN0zWIQ3AV/DUyWom1CNCJ1UMvfhRXa86+6vZ8hR0yO3IyPCzN9TolNQP3iTwY8mzxbA2CKqXNGgDMYm+hIGwDDOeu4wcvhnqkyTSp3fVk/3hnlGANy5BRjcdbU5AXA2F0302lj+VYVfBxmAIGhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becb6fdb-a9ca-4b5d-8b2e-08de59a5bfcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:02:35.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h99hJJpHFRr59FpcNm2VCtKO0740pGnmcK+3DnA80bLOXT0nYBhJJ1fIrYjF09YxcbgaYDiCwfGIHOnoAULcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220079
X-Proofpoint-GUID: uav-MWjmChHVRPMDbnYbyozzIbf7He3k
X-Proofpoint-ORIG-GUID: uav-MWjmChHVRPMDbnYbyozzIbf7He3k
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=697203cf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=F-9yom1K_Cr-TDLq-pIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3OSBTYWx0ZWRfX8Sw7p9KfLa12
 TVP1qJ1C9hNIozyCRXingVlpqai5d53VW41Vtvmv7A3944uOHfASlDZ8n5enAGROasV9H8WUkhN
 cILZjwH2qFDR3vFVkVCkCnblNnX03Hgi6Zj7pNhD+qlwE6zOVpyNMjTkq5J99VCLKfN3lGt+VSe
 a9N8T046/TUCQclbTBH4yEo8QD2DqV66w/ER9oP+AMHQpo1ZAGSYBf7Z+HwoS/2HiighbjHAefo
 DzbuFZfGMLmHmoGbStS9qeURVbMcs4KCv5HoG/iKCvs8jRsKjjjg9MJPqO2Lh4wsJVMfhq1MOwZ
 6JqvYyXyfG3a6h/epwT1RZFgA9e/FU15nm16LqfgQI1OHa7VYgPk3zLuzWcvgv5J+sK8zXxg6VV
 WWaO/voKapYigxTKGR7Kc878WeP9u+LKyGlVyMvsyVWM7DNQeQSrfRtYA+DdqN6uTRePOp7jKE+
 TsL0Qd6yaXN/1EP6B5Q==

On 20/01/2026 21:09, Yonghong Song wrote:
> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
> will close to the page size. On arm64 systems with 64K pages,
> the pull_len size will be close to 64K. But the existing buffer
> will be close to 9000 which is not enough to pull.
> 
> So for 64K page size and selective run_tests(), increase
> buff size from 9000 to 90000 to ensure enough buffer space
> to pull.
> 
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Tested-by: Alan Maguire <alan.maguire@oracle.com>

one optional suggestion below..


> ---
>  .../selftests/bpf/prog_tests/xdp_pull_data.c     | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> index efa350d04ec5..32ac99406d28 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> @@ -8,6 +8,7 @@
>  #define PULL_PLUS_ONE	(1 << 30)
>  
>  #define XDP_PACKET_HEADROOM 256
> +#define PAGE_SIZE_64K 65536
>  
>  /* Find headroom and tailroom occupied by struct xdp_frame and struct
>   * skb_shared_info so that we can calculate the maximum pull lengths for
> @@ -114,12 +115,17 @@ static void test_xdp_pull_data_basic(void)
>  {
>  	u32 pg_sz, max_meta_len, max_data_len;
>  	struct test_xdp_pull_data *skel;
> +	int buff_len;
>  
>  	skel = test_xdp_pull_data__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>  		return;
>  
>  	pg_sz = sysconf(_SC_PAGE_SIZE);
> +	if (pg_sz == PAGE_SIZE_64K)
> +		buff_len = 90000;
> +	else
> +		buff_len = 9000;
>  

nit: should we generalize here and just use 1.5 * pg_sz; i.e.

	buff_len = pg_sz + (pg_sz/2);

that would eliminate the need for the 64k page size #define.

>  	if (find_xdp_sizes(skel, pg_sz))
>  		goto out;
> @@ -140,13 +146,13 @@ static void test_xdp_pull_data_basic(void)
>  	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
>  
>  	/* multi-buf pkt, empty linear data area, pull requires memmove */
> -	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
> +	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
>  
>  	/* multi-buf pkt, no headroom */
> -	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
> +	run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PULL_MAX);
>  
>  	/* multi-buf pkt, no tailroom, pull requires memmove */
> -	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
> +	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_MAX);
>  
>  	/* Test cases with invalid pull length */
>  
> @@ -154,7 +160,7 @@ static void test_xdp_pull_data_basic(void)
>  	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
>  
>  	/* multi-buf pkt with no space left in linear data area */
> -	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
> +	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
>  		 PULL_MAX | PULL_PLUS_ONE);
>  
>  	/* multi-buf pkt, empty linear data area */
> @@ -165,7 +171,7 @@ static void test_xdp_pull_data_basic(void)
>  		 PULL_MAX | PULL_PLUS_ONE);
>  
>  	/* multi-buf pkt, no tailroom */
> -	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
> +	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
>  		 PULL_MAX | PULL_PLUS_ONE);
>  
>  out:


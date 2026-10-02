Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E67446052
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948330; cv=fail; b=Fs7HA2l8yaUbsiFwxagxO9so7QkNIWmn+ay2ToNkcYsTb3+SicTxkPQdJ0lr/DHGBK4NwGT/h8z3g1uG+B+aNh/q8Tbs6iA4Bj/FZlrbrwVDUcSxq/c9phqOjY2Gu/943WCZ4GHBJokezJF9P7iZ5KTnJoO81T0n3iB5V5vAS9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948330; c=relaxed/simple;
	bh=OlMbz103lF/L3hbcn7avcg/KJxMoJm6q2bEs6HS0O0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxvKz/3NoktrTw8fMUEKfBd2m7UpFMCZxQSxZIX/7IJWsFMU4yKm8BZYw5+pf1TXh/hVcvJmPViGmSJvUKJgq4gP7+JISXeViI59EEZDFoKToxXR+Ly0T0FOyz0ugSI69n7rY2rejc63H0OjqkMkhMZNMp72bbnJO5p0sBQm7h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FlyC3VL4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PN1ksGB/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FlyC3VL4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PN1ksGB/"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692Cn0Zn545731;
	Fri, 2 Oct 2026 13:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oUnOMtLY3C3ASXZAnh6nWKtAxPSrHB+Ub0RkEXscqi4=; b=
	FlyC3VL4kZh/prSzlHhC/+daxAhTxxqPixu3t4Hvi5H1NgYfwYFWs6uxgxtfK2dR
	rxMzpyGyFmV2r3op1DWXiDRvPTc2B8t4WRYMXcu5rmktzgKylFBDXOMW0Zm4X036
	ahEz+WALBXD197Uj7bjINKStIMDxlDSGBBXqe1HkBUfaeEMd9La1jkeWqIjYrW3i
	vKD7zQhq9HzocfnyqVX0OWscwctx5QpQCSIH7g/KvBjGyccMGf7LS60nA5KLoND7
	TOi+JdwM0drbwtOnKvxfeELZ/JeTLMkPOyysth+SqBaQBPklKcg3YT5hGWkPE9W1
	+Na30SVdi8WaTSOX8Misfg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c44ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 13:38:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692DYxa1008948;
	Fri, 2 Oct 2026 13:38:28 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gftcuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 13:38:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hbu4V/cDnrEnNHxaIyIsMO4ozYbttFQMO5HzJdvZqmJnht3gAtDtzhiJOB2bl7IHyQRvGTgdpDAzKrVkNlAc3V3FGoSpltsONBaPM4yBZSN7cI/7N7N+ociKmT30LdeYSxIl6gbjNAofxOXVuRDvMPOiPP3iG60QnLidW2DG6r06xywgzzELcYhRX/PYepL9B8U27604ns93Rx6SKZ4xVUpMUb7I+nP7q7RsjcVoYr5giw9vDl8FOz0uE9rqiByNuEY9vF4QIheX4MFuW0ZruB+r/GB1fm0HwMIoTNu1MgNpBU8ifLiNXS1Xt9pzKf3GhED4JxlvaDoHKoU42dKIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUnOMtLY3C3ASXZAnh6nWKtAxPSrHB+Ub0RkEXscqi4=;
 b=fbHL8pZIRkvUdRDpjurxQTU+prIbLyzF7Z0zuQcIj9xy2xjJ4+gr8NQH91v3xCIA+wCUiYVP+Xm1ZPYkeJ6KWYhQrSQqa+w1K3emb9l9vqKkTPo+N+vUhu9kqmKknUZzw0JD0LHvyRuTWmP3/lUBhxq359DzXXRDudCJ3wKRbHS7dM6IMTVLYPbutRbrFtbqzah7B2T3av9A0OyV5pgHgXCFaN3w5CquDSksa4GC01Fh+kgJ1CrKTQK+HWK7c2JAs5OWpncD1YD1wAlz5d6m5LYZ2NVbv/zvbbLcBDdcMpFVqBydJX6vJJlhDKrAd7Hj1mqSDPA1t2U3d02nUqD+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUnOMtLY3C3ASXZAnh6nWKtAxPSrHB+Ub0RkEXscqi4=;
 b=PN1ksGB/mCG/SIRnYp0qBf/ziwzgJMqdlJD3ZDXRZ0V7nRUdN1c7L/yNHx7ywL63387WylrXCLP0REkzWlql1xpIAMl5OCribi/xChaf1PxhYdnW9yazGRafHp75S3AI7wi1SPCmeJ4OoeE+tIz284Y4+G+9Bnt+GAcLqkBqVp0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:38:26 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Fri, 2 Oct 2026
 13:38:25 +0000
Message-ID: <bb31a195-41e1-4a07-9665-2a5d0720b15d@oracle.com>
Date: Fri, 2 Oct 2026 14:38:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/14] bpf: Allow names of Rust types and
 functions in BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
 <82f7ccc5-da2a-4b78-a10a-442acfac1855@oracle.com>
 <DLUCMHNWQ956.7GB7BFNWNPYU@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DLUCMHNWQ956.7GB7BFNWNPYU@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA4PR10MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3440cdbf-b235-4042-1aca-08df208a6f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|32116099003|18002099003|22082099003|10067099003|4143699003|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	CebCwInyOnKL2QZYU21VtRSXI8PeAT9diibb7wxwoYBNx9biQKDTHaEmRI1K67NjcmxwXGYtzhAhopdA+zDtS9bNbQ4kAyH9K8I0IF8GD9S+MguMVHzLrVY2LtCkV0DjArgRE10psx2es5YlkO4xvkpDQEq1aaTVanPrYVWHueLrI1EXT7UvcZ53YSOxrF912yBEnGRqNmsgSbmY6Bq0h6gXfZTeI0cvuqxVe4UPO1289ubnun41KURK7hI0ZpnkSydIXIlQRRUxD27iRnrevsi7NbRrGfAHCBfxB7t0SJ1CmWuBDy6+d8fsFSrMIsHPOs55Dtg4cPWHONT3Rf8rhQsT1xX7OyLY0xzD4jrZy5pZis3CzHvw9lP0RoQ/gUICAHoWSYb1Xarop/xq7utFpL2ItB0fkX9BOTSgjhpUcxUoAEjE/cpdMVyJyz9Nxo708kJvqj53zl9pTlu6XCoi7qK+09plJhFz1eWgPHIWtCpQOuupHlaKXTcwbnyvarX2ksJz2GVeIDhxlmpcXDgp/Jg5nxeLrqN7FYPg9qIjaky8eTp62cJHhMahkbyTkHtmAUPcRMXNizbKDWpPYyWKImUPAVb+5KQEwGdhonMjKrqd85arxVMxO6cO/mdbh95CqGyPUiq60cV/TlMNx7kLmiN3FSW7uTYY/bu3vLE3a9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(32116099003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFhjdTZnYXlWQWExTXROZlk2K2lmNzNlUGRXSHFLR21Nb0VMdmdEcElmMTd5?=
 =?utf-8?B?bnlmQk00ZU5jOXNqSEp2VVArZlpqY1hFOGhrUjEyUmtUa1VVRVp0S09IWWdG?=
 =?utf-8?B?d012UnlxR3lHd3loOXFDNElwWHRRTDZDekdyVjVqUVlkQ09NVDBqKzlUdkE0?=
 =?utf-8?B?dStmMmVlYUtqNFc1ZDNPZW5WZVdYMTgrc0hqTUFaVEdFb3MzNmY3ajdqalRD?=
 =?utf-8?B?WVlUWXA3WWNRRnZTcHMzbG5aaUZLc0RBeWJsV2c4YndBbjFJSHlDWU5PMDU4?=
 =?utf-8?B?S1RxQkVSbVBFVy8rYkQ5UUxxOFBpQU9kL0FoK3NqUlhvNmoyOERwNVhTRWZL?=
 =?utf-8?B?SFFNb0lGQXNKbU5aaUtRcncrdVlqbVg4T2JLTHBFU1MzalhzcHF4RVp0Q2dF?=
 =?utf-8?B?dWpmSzhDM3pWVE1rcTlNMlc4UFoxOFRTYWlUbHFEa0lLMDNMSm1RSWxmWnpV?=
 =?utf-8?B?clB1dEVGNFdtSWNZLzV1SzdGQngrMFU3WFMrcHRxNlRnUjJxelp0cGlqSWQz?=
 =?utf-8?B?UW4rbmNYNEhrTnJUWnE4Q25NYmw3SlUvU2JKNi9Ba2g0b3VVSU1kOUZBeDZ6?=
 =?utf-8?B?MWZneVNaaXRyMDBlSWFtaXVXbHh3eE01STZSNWpmSUUzSlhFc0x4bDdDaTNW?=
 =?utf-8?B?Mk9taFBYSHBWVHREaHhFLzRzd0VaOFRBQjZtZVYzWVRPdHNEMFk1Ris1M2xP?=
 =?utf-8?B?Zk1FREcrTmFTK2h5RGNmWXRKWC9KSDFFN1UyK1QrWVViMlFyYVBwZzRjQytW?=
 =?utf-8?B?TDQvT1BoRDlxWmhVVmFCellHL1RrTE5zbFRHbks1d1BpU2ZXbmVSNU1WUks1?=
 =?utf-8?B?RHNVZzJ2dnFPWWlVYWd4YTNtMHFnTFB6ZXpnYW5LVXl0M0gvNHM2ODhla1Fr?=
 =?utf-8?B?TE5MeWhJVWlyazdpcTZSdGZrNnBNcjBYOUgzOE42ZlhDbzY1dGhqZWNIYjZv?=
 =?utf-8?B?MWFqbGlOTWpOdHdqZ1VFMkZ5M1FEeDdKKzFOZVZiZnJsNmpzR3lCUHhrU3o2?=
 =?utf-8?B?VitpcU1sVHpmenpMTS85SFhxRzhiWWN2cy9YelhxQ0pjQkhFOUdRbHI1SGRn?=
 =?utf-8?B?VHJyRGh2QjJkUkpVeXBsRE81NFVxdnZLbG9wSElTU0Nhc3duLzlNdElscCtw?=
 =?utf-8?B?Ti8zK2JvOHgyYjdjV1d2MVZNelIwcXNBc2U3aUlPUVpmRHN2ZDVmUTBOb21J?=
 =?utf-8?B?dlp4Vm1RTVpNZW5wbGMyUjMwSE5mTlpzVS9RdGF1aE9KaEdwUzBoWEh2SnFN?=
 =?utf-8?B?NFhvR2YwRldPYUttby9reEpVRXR5ekF3WG40SzVNd0ZnZkR3bFUzZkRzNDBZ?=
 =?utf-8?B?MmU0d28yNXVqTUoxcmJvbDFQandKWHJpRStkVXRWRWdMenVpQTl2dkl1ZlVm?=
 =?utf-8?B?RFlHWDQ1a1NQUlNJT0VRa29XeDAvcXJNUTFMY0dkV3JKS1dXK1EvSzNMaVNH?=
 =?utf-8?B?YmxtdG9Dc2FPaXdVQlNjZjZ5L2x5NXFYZmhJQTFEdFBDTjlaUUNXNDJiK0pL?=
 =?utf-8?B?VXFxeExFSkxOWmhQVm1PbUk0Q1RGNjE1Y281bHNyN2x6UDhQdWNSTE1tcGZa?=
 =?utf-8?B?c2Y2NmxVK2RXRG9mL05GWlNKRE8yMFVUUGltRUg1SkI4eFVLNnczRGR3ZTNH?=
 =?utf-8?B?SkpBbFV4RXFzelh0bWYrcWEvMGY5b1JKcG5RUUhFa2JFeUxaT2VwczY1SEha?=
 =?utf-8?B?T2t5WjkzMTVhQnpsSzJucjd2S0ZqSGh2WVZzd1UyOTNsM29yTlJLam5XampW?=
 =?utf-8?B?dm96eVZoVm1Ba2Q5L3BHeGN3b1h6QytTNnJBTTRldllCbnZKUWpLWDlpV1NG?=
 =?utf-8?B?V1VGdzVQYzhySUpaMEd6K1I2ejRmenRWa2lGQVVKVXNIbDFPbGt4VTVkOWto?=
 =?utf-8?B?UkxEc3FGVDFBdjZkTjB6VE42aWVvVVh2aGhtM2kwcmFmd3dBcDJpU09zK3hJ?=
 =?utf-8?B?QUwvZmNVZ1BWenBvS1N0OG9sL3JseXhyaktLeHZ2TkJ2QXJ5djNSZDZQNm1v?=
 =?utf-8?B?di91bEtlWVR0WWFndHlVdWJscHRZZW40SThwQUZLSW90R01NYy85MmNHNDhy?=
 =?utf-8?B?dU8zcjZ0UXQ4alNiTDdvMG42SDJOVXNzNFF1c01tS0lwTFVzSGNicU51bjly?=
 =?utf-8?B?MjhoSHhhRWRzMWEwa2p6MElyZS8yWkRSM01BZ0pIZDVHam5oRmlLTkZWbUdr?=
 =?utf-8?B?bFBRKzBzQjUxSHo3eU45cmV3cERkZ0VoYlZQQVBiMGxzOTlUZW1wUUczSzYx?=
 =?utf-8?B?V1lWNy9vSnYyeDdJRCttS1VQUEo1V0Z6bEhSUFBmbjlnUXpKU2hHaGRuTldw?=
 =?utf-8?B?V05LQjlaUGtLOUlCL1o1dGllRVpibTNZeHg5Z01NUFVmRHF5VnBVUT09?=
X-Exchange-RoutingPolicyChecked:
	RrjczjMhpsesME7yroOP62qV4wRje7gIZW5hPuTqyUytHauSuhji/YwuKSzZjDn6EEaSc71BB0JsjENhMRGGf3W7OVOPuI0PNp5HDR2gki+kVNMrnOXhsGYEXiPQ7755mrptSfiIYHfZNQtufJfYA5dIW8ZJG/dLK9ThC2DxrN7Z0owdnxzjr3G7tglyXM8rmDjREfXwde0CCCy/QaZv+zsgXCkT7dSNPpDS/vYNB3KxNuKaXLe6TzijRUNmPM6479tkZDAC85S95qSdFXjMF+7UoMUicFil35OhiGKV3DakG73LYBipucYPGdcVA8L+pjXAB6pyROH1vMBp/oaeGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ONh5bx+/TKV3IeHXrf7gNIJsEC1px1/yr3cV5537u6S8/DC4CQshOjO/++y427f0bg9Shx8WnCWTf6kRkA6kz0dwpwK2o7krmWBxCkNqyhlF2/qNO7bMQudkIiYN4bRd+7LT0swLf+yFnYaFvp5tpUWfjjVA9quMcD93s2mzK8bh3WQAFe5LsOd030Z2wL6uROZ6//MFHkNwl7ES8Og24+e/eCx68sqZ62/ZXRceSAVjcSa3YozRdOwX1NKKiyx8mU8s/ry3Jw4wFgfWQ+mPINf5nhCKmqREcYmzSVby8Uo4gmx1CI9dcxuwsjxtirUoVPws/ih0pUN+IBGmeo64edFCI4wwPu8E11uMlAcKjFC7AlxRl3EkYeDX+tR9tl02MrAFeXjVg4l4odw/t1JpxxSrWSeli03vBWgIN1nFSRm0hZycgl+rLaO7Zh2DwjASZI2YwXVJx4mD5BD/ObRtWngYvCB7/Zt0xXoE5Xnr9VrQGKc2piLGTpQMgULhjtI7EhIm7nLlP5yGSniaV+NYh20Mr/1+2nRNo2vGnZEWOiYdygPxnORTcjVsIjf+zwVp1tArK/FJAtiMgpSs2Tfw2Ir5Uq/UYrEQ+GFEE5kJKI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3440cdbf-b235-4042-1aca-08df208a6f6a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:38:25.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJMGVM0OeS7O2y5Te9O9WZJuyWPV/RCoDYWlHdRlmHTnj/lBBVhVR4CBJ1N2iF7Z4S8tNIGYxTxfIutdvgli5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=881 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020054
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NCBTYWx0ZWRfX06wD5HrPfXWT
 uUO+7XIxY/ojbXY9IAjoq4Z2YgXNVO4UFWYsxxXxbqSFHDjOTJd1UexTC/INBQwYDIBNwFWoUet
 dyIHgh5eo3C01hvOp6kwqps2cJtvscOpw3hVNLbn2zEYRBSrNss2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NCBTYWx0ZWRfX75MFOXB6AbFd
 Yo6sDAaDkWX+2UI0G2sP7bqB43HNjyLgJ0zRZMJCuD6xfQcor/heq3LdAtWvfYLOVge+0WXhNQl
 lMxMrTY2FCM4Kp+YxNjZ50OkKuKYG6ZvQErBEi6VPtplX5as3eTLYP79ja6Irf263d8DU0Vc+3Y
 /89KSYEWb/wd6CKPdKqj+U/xqbSM9yTFjLvVJSh/Il15WdQeKjOEaPjYz1G3i8ZpdwlBUYO4ouw
 Mq/AiS/F8/Iu/V9LQGQ26SJ93WERD8xSzF/hoBXeucAsFmtjX1Z/Tr/0c8+pziielsGw9rhB/QZ
 AZuYiYQYZ4G2c5GrRkcmgi86R4CfIBnu/ifeiuPmGT9ogtWjnxOzOkMiCTvDXmzHRnMa+lO4AVK
 6VtW6hoMqr8z7LMcJVjJUSWwoEp4go+SxUuhAt+DQM6SmWWAq5bllJzuwh73ki23HAeAHiy8s3u
 iVfeTBGgeLP3BWjrf9g==
X-Proofpoint-ORIG-GUID: -Bn9ix-QCndG7EIdGcSvyZGlHmW6Po3n
X-Proofpoint-GUID: -Bn9ix-QCndG7EIdGcSvyZGlHmW6Po3n
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abfb3d5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=fqEn06p_6-0ak5BQYn0A:9 a=QEXdDO2ut3YA:10

On 02/10/2026 13:24, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 06:42 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>> The idea is that for tracing rust functions you could specify the rust name
>> (from DWARF DW_AT_name) in the SEC(), but to map to the actual symbol
>> address in kallsyms the decl tag that referenced that function could use
>> the DW_AT_linkage name.
>>
>> So the decl tag would have the form
>>
>> <lang>:linkage:<linkage-symbol>
>>
>> and it would reference the FUNC type id.
>>
>> Could we do similar here for the name -> symbol mapping?
> 
> I don't think I got the idea.
> To help with mangle/demangle?
> bpf_prog_<tag>_write_fmt_scx_cosmos__BpfStream_
> is imo readable enough for humans.
> 

Might be more relevant for Rust kernel modules ; in that case a
function like 'fmt<str>' winds up as

ffffffffc0fec430 t _RNvXs5_NtCs1DErgtJhccC_6kernel3fmtReNtB5_7Display3fmtCs7y3Drb9gYub_15rust_print_main	[rust_print]

in kallsyms due to name mangling. So if we want to trace it, we'd rather be 
able to do something like

SEC("fentry/rust_print/fmt<str>")

Then libbpf or other tracer can get the kallsyms name from the decl tag
for attachment.

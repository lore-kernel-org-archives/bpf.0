Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13834F48C
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621407; cv=fail; b=tdwQvYQ1eOZ2p+yHGQ6y33yt2pMg1FWVjlSYRQtj3jEsfl69EFPLPMraXMhjs75JOF9BwsscFAaFg4A8+4FAwQyifn4uoN+2CscqQRlwfS9a1lTKPd8rxVAqW8Ejsgo6nTCZ7H2L2h9HvlQ2se6kuZsNq1sYLEtAxkNVnwqkiGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621407; c=relaxed/simple;
	bh=hU7yD5bXnM3a22207m/77ZIu3piU8gKiCe8PwfWEJME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c49CTjtowBmFvVUhhnDGP9KZbPSJLpOQhLYnO7JQtF4Cq4H15hBhvaOLoMFCCajuaJB4+8lE+x4lexo4GR+cXKdGtcW7DrKSJJA050yFMOZbp/+ysMgZMVzi9IGOwy40GJc+7MmOT7WkeyEdss2jSxDwDM8HbgdE9b845kJINuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LyYYeRLg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LLtOx9gR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyYYeRLg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LLtOx9gR"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGx7ea792945;
	Wed, 28 Jan 2026 17:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HqrT3AMBVqr8qPRYmQLKHYsIvN9YeXqW+UYoXExRQbs=; b=
	LyYYeRLgClIF1Nd/kq3c3ESvA0ye+YaBU1Ul9eBMzUqAN2Q3Om/AZuKJ614tHdyh
	F+5A2CbzDS6hsj7RR+gTdDMM72la+01bEVRbqtMQFqHQcLaNjNFwU6uujwEOLwMW
	aRFSUanSeZTFy6efg7DIBExHK0alMZxJLwhV+m0hy+JNvvH7XutVR6vlzmcg609N
	Y6TnN+yYg0geGFAaZP4b4465zEQRa0EQ+ff+MbiL9jTV2Yy7ZRcOJMW5H2v4XrpQ
	oO2EvRDgcpJK1WIssacHg8wSt4FkQugSAKpL6252hff5cS975tt5evXcSPBKg2it
	1IFSw61dgh6c6SpiEg0WWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by39r9sfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:29:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SG30fC036091;
	Wed, 28 Jan 2026 17:29:47 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhqg7ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYNf0W/2CmtPqBGdbPzMQOqQsOViMtWheWPAvPy50w/0W9jk4E3zEr/mUNj0W5RRge9eLpjGnmHq3YnJZFrRVSzSQ4Rv0Qouy85THG/rJtgENddLoKL6VBTVxrMKau3wtpphFVMbmb61OvaqZFKh8JhnYUTN8TSgh1d1bqH760El4LTpu5Wklx6isWWS+0Jaa6nkNRS08ku0MHXonuotPc1pUKpgHBCILeELH45WJFhSJzm1neF6YKfizauk65co/vrT22wsyJeFwYlONIdLK9CP0pFAb5G5qsIRpNU+MtXAoQ15/gQ4V6SzxlT+z7PmaiGUeTMwRsncIv3MsBrvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqrT3AMBVqr8qPRYmQLKHYsIvN9YeXqW+UYoXExRQbs=;
 b=isuV7uCH6f9nbE2WecWTUw4Otre5I9fy9VRf+iElCrfT6XuBXD1HjvECgHesh2DejY3wX371W/M3os+TBhA4qzJaoTON+2t3f6draTDpWBRHTEj9ksE4UvJt9TvDTdqfwMLKIpJYeNXxOgQaPQHaGkQ0s2SC94JRUZyqkqRcZ9eFPZXE5ttUQjNQQ42CntKpcGJg6DtN54oqbaA77r5cwHhodVt5ELMJmeTtLLGqh+MDDClKFIxo9yKuLfUVRp3ErDTMxNhOwqVRksNft2iYdN4Qnh+x13RQAUar1va7NYGUjIZ0H4HyYMmtIYU3DaPTSg6p2oU5GeXaOOjoRot0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqrT3AMBVqr8qPRYmQLKHYsIvN9YeXqW+UYoXExRQbs=;
 b=LLtOx9gR4jPtDgXAfF1fGCUsOMbFEnnPUTXBzjSSpYi9txTSoZOfkyjZIOgwcHC3qVuAZdOU7ELLVsd8nIJGVnh9pBE8Y8+SD1rr53+oLKUIXj0SlW1Rd+sKBTMCYNMJXXD3MV6VobWlMtWHngTMNuJ7aAiF2ul2X3TQl8Zr9fQ=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:29:44 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 17:29:44 +0000
Message-ID: <44ec77f8-0d77-4ec8-b225-f58307fea951@oracle.com>
Date: Wed, 28 Jan 2026 17:29:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Remove xxd util dependency
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@meta.com, kernel-team@meta.com, kpsingh@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128150435.85074-1-mykyta.yatsenko5@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260128150435.85074-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0606.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::14) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a70b6a8-7dd4-41ba-25f7-08de5e92d370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJzUHY2Wk9RT0RQdzdFeWEyWTk3RFFiY3p6Q0tBeDUzVjdudjA2ZDlYYXVo?=
 =?utf-8?B?T2lsYS9XMHkwQW9YTUM3MW1JOWN2T3RTNDI3bGozbkhGRFBnRElCS1IwYUh3?=
 =?utf-8?B?VUxsaGt3c0gvYmU1N2lIZXI4bk9kb1JUZXNHT3FpbmZNdGZZcnJIK2VPOThV?=
 =?utf-8?B?bVpFQ2k1N2dxV21Qd1FwRGV6amx1U2Qyc3I0VXYrdEJZV3BKR0QxZWNQTVQy?=
 =?utf-8?B?Z043VDZmT0dVUFdWbDY5YUIyRSt5Yjl2cnd3WWdid1lCZjBQdjFVZUQyUDJH?=
 =?utf-8?B?eVRxNUk2ZjFLWVFkc3NMV0lqQzdReHJRQS9CeEI2NG1xdnVoSTY3VTJkc2dO?=
 =?utf-8?B?SEc4N1RmN0tiT01WZlV1Y2FNY2hqOEM2UVY3Zk8xRHdSWUo2eDN6SXpsRXVz?=
 =?utf-8?B?WFRKeTdOTUZGL1MrOHpUdTZndS9MVDFLaFVPYTc3YUNTM3J6bGdhbHAreVVq?=
 =?utf-8?B?akk0WElwM2NtREFsMGxDcjlBQks1OElPNnhyd2wxOEtzVXVzc004ektGbjJG?=
 =?utf-8?B?U293SVF6RG1ZeHZHTUFGd1NuRW00L0FqSTRRTmFQdkJ2VW1pTDc2eGFLMGZN?=
 =?utf-8?B?bHBKbXMxa2MyUHlqbTNqcSt1MDM4dDIzUTA2b1pGV3YvSHpaSEllRy9kbWFM?=
 =?utf-8?B?MjROS2tDRmZGdkVERksvMVRabGNlbDRsbDVuY0U4WWtRc1BrdTJlMzRqQ2pt?=
 =?utf-8?B?V3ptTGtUTVVZMmk3SnkwTXVESTJVRThwb0JTZ1JQL0hzaHl4TXZYVzI1emRV?=
 =?utf-8?B?VENINUxYUENsS1d1bVg2VkVmMWErZ2doQUt2RUZNV1pPSE4vL3JINnl1eldm?=
 =?utf-8?B?ZFRvMTZTQlhKWUplQTNoTGp6MEtLWEtpZFBVYlFKTU5JUWJKZXdSdFhBU2U5?=
 =?utf-8?B?MnZiZ0lQWWFFcS93cDZLTGpKOFVLVEJFSEV6Y2V5cUVwWG4zVnZ2YXMwaEVi?=
 =?utf-8?B?cWVYd1licWwyVnFXVlJlTzF2UTh6ZUczN1lyUW9qZFViVm02bC9pNzRLYXo3?=
 =?utf-8?B?d2pQN1pFak10QnR1VGpjNTYvMGdkdDd4SUp0cGQwbkdVSGJaSFkzandGSjBL?=
 =?utf-8?B?cEpzTlljVVppMmNnUXpMRmdBczNIRHJpd2Q3aUk3OHk5dmV0bEpPMmpxV1Ra?=
 =?utf-8?B?dFczS0JZYXNzUWVPMFRWQmxialhUZHhGNjZuakdrRk9qK2J5RDJMdCtwKzJY?=
 =?utf-8?B?L3grWlREL0pJSFBic2xsRVpDVkI1THBiNnJWZE5jZVBaOC9peGNmL2swc25j?=
 =?utf-8?B?Rk4zUEVBTE9jSXJtSnlXQ0ZFc1JTbkI0cFF5Z2pmd3NCNlJxdzhBTnkyTEJu?=
 =?utf-8?B?R3FBL3VqM3FSR0ZWTzI3N01jcVZWSFNWQ0RVMGpPZGY4NTlhZ29SeUp1VDls?=
 =?utf-8?B?WXRjMlJaNHhnSEtmMzM2ME1wd0ZYLy9Hbm5LSWp5R1NSMnZIMUZxUTZJYzNB?=
 =?utf-8?B?WmE1TDdNbmVONEFobTVJd2VWRUlKQ0lXa2FUb0c0NWlBNUJ0RkdybFg3ejhv?=
 =?utf-8?B?UFhha0FzenkyRzZ1RlAyb2ZScnZKa05oR0RwUncvd3VJaTZoSWc2Vk5pVm1P?=
 =?utf-8?B?VmZld0ZKYnpNYUJMZHY0L0FiNklTYmVvcE9yWXlkcXY0WW1ZUlhETzVYMWRp?=
 =?utf-8?B?cHdqYno0M2lUUXgraTVwKzJzckZPNUJNeWwzZlhmM3hPUGRpRlYvR1hyc2pF?=
 =?utf-8?B?a01LQk9qMWs4T1pRNE1FS3VqQzV4UGdMREdHdVU5RmorcFh3TDZhVkNvU1d0?=
 =?utf-8?B?eTNsWDdZY0RqNGNJeVlWZ0VrNkpERDVSeHh2eE9sYk5IQXRmbURWTGpmVUU0?=
 =?utf-8?B?czBPQ0pURzNqbTdwSFlZZFo3VzJCV3Arb2JhQWRzQ2txUkx4Vmk1MlIwRDBm?=
 =?utf-8?B?RWxIRm5UUHZCQ1BzdlpFSkdLU21YcXk2UTFlZEUwYytMMWd4QnBQQzFFTVBG?=
 =?utf-8?B?STZOcTNzeWJvM3BRc3RONFRZOXBSQnUvTVgxSWNraStsYVIwV2hNZ3NUaVg5?=
 =?utf-8?B?cWs0NlNVbWUrZEZEMytseHJsQXpwSFVZK09Wa0ZaMnBIV3Y1a05iM2Y2RWtz?=
 =?utf-8?B?S0xRTHVWMTdqNEpKc0YxYk01SmxmRnRidEkycmlQRjdWMXZLUEZUUjVxcnhx?=
 =?utf-8?Q?oV7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitpQ05aNFpmRXhybC94UUdreG9BNVkwQ2lFenJESTJoYnVXZk5SV3VPd3hP?=
 =?utf-8?B?d2xQTGtGbml2a3JzL0l3ZytBbDBGWmlQS2dHWFlLWGZzc1lQVE9zSGtKU3k5?=
 =?utf-8?B?YnJZd1NyQlEydWdvN05MakVTcGcrSVJwS3E0QnJWSHlnMmFLQ1NKY3VjNG9l?=
 =?utf-8?B?U2NFNVlySytrMWpmd3FmbkZHRDg3NCtqK1Rkc01pUzlmYk9PWUZVQjB6bTkw?=
 =?utf-8?B?dHhaanl2eXNsOG9ucUtKaFJiT1lnK2UvYmh1ZzFQbXpiM3BmKzJUTG5zN3Ur?=
 =?utf-8?B?SU1qRFpBczhnWGxaSDc2ZVpBMVRHb3JEZ251N05ZTERIT2lqTHYrcHRnVUlF?=
 =?utf-8?B?RlUyY3dvTkFyeVBIaWxzZXk1QW1GTWpxVjFrRWNWRFYzczlBYktnNzJQbkhP?=
 =?utf-8?B?VlpvSlVKbWh1YUJna3VmUnZydVNNWSs4K2NoS3Exc2NiUEpkTFBmVlNhRVpj?=
 =?utf-8?B?clUzU1BudStadWNmYm5xcG9oNW1sa0c1Y0VtamxPN2I3Qi9kYmdwSE9jODVt?=
 =?utf-8?B?YlYybldPVXRRRWg3THQxY1JNOUFXbSt3bjhDOHdjNGFNQ3d0Ly9TMUJVbW1k?=
 =?utf-8?B?eitwOUhPbFdqZ2MzbnZGcHlEVENCWHZhdGhlNzhRZVdTUllLNm1uU2ZreERR?=
 =?utf-8?B?T0JzNTBjTUxzVGVuUjRISkdyd3lHSmllSU9LN0ZCUEN0MDVaR1QyNXkvRW55?=
 =?utf-8?B?VWVDb2Vwa1o1T2xWOHR2UUtUSWpQQlFKbURxdzRBZmhxVHFJcW9SOXZJZEZU?=
 =?utf-8?B?RHgwVVFOa1BEVndONVN1SmpjV0luTlJuZjBrNGJ6dGtKZjFYaXlpa3hmb1Jz?=
 =?utf-8?B?aklScnE2R3Frb2NxRk5BL3VSQnZFcHlkNFhaSmROUFRCV2xlMVJnN0RHQmw1?=
 =?utf-8?B?c09obUFRQ2cyY1dNU1dKSmF2MG1Ra3UrSFB5OWNBOUwvL04ra090SnNRb3o4?=
 =?utf-8?B?NysvbGFtSDhiQUwrVlNiTWErWTdWYW9YYlFOT3ZKdEJ1WTBNQ3BJejh5cVlm?=
 =?utf-8?B?WkR0Y0FZS01lRWpvR3RIZGNjTzh4azMxekRXUVZaQjgrclQ0Zy9UZVpURXZX?=
 =?utf-8?B?dXNrc2VQUE1SME1TOHZ1R0NFRE1USXhIaVpHYUdULzVtei9kOHpOWWRKcFZ3?=
 =?utf-8?B?ZkVBQzlxMTRNczl1TGJMYUZBRU93WGlsS2gvNU5JWlFxQmExUGJzc2MvOWp0?=
 =?utf-8?B?WC9wOUNPWGFTUTNTbWRoOGxvM2d4WU9hMTBkQUhWYjk4dzYvZ1J0TGdTenV0?=
 =?utf-8?B?VmxjWU92Q2drSW5kYUhzNndHeUc5aWZHamtuTnpHT043bU5sZHZ3OG9XczFR?=
 =?utf-8?B?U25PbHQ5N0xjYnhHdkk0TFA1bi81SDNqRWdNRlZuV1luZGcyaXdSYWVuRFlM?=
 =?utf-8?B?ZkhLWGJvOXZPdEpDVndKT2JqemQxa01GZWdKMDZZSW5aOHliMSt0YWJGR2Fj?=
 =?utf-8?B?R0FTcm0rbHpDckhkckVzbkhHLzFwVjJUbHMzUVZqSmo5RmlJOFVrZHNSemFx?=
 =?utf-8?B?N2ZhNklvV0NSQitXeW1OdVpWQTU2bytEWGJhOFNLbXhHSThKeXVLcnViMzBi?=
 =?utf-8?B?MmNMdkVucmlFWmlSYVFpamNUWUs3T3pXMWdoeDVpY3BiQzB0RlBLZDBCY001?=
 =?utf-8?B?eTl0emNJMVlkN2psUGVZSXdxc3doV1hMUzgxUTlweVEvajFQRUJBb2E0RTMw?=
 =?utf-8?B?OUU5dWc2bWMxMHI2RHMySGVxdytROEJMbnpKaU1NbURXT2t2bnlGczkyOGhr?=
 =?utf-8?B?Z1pJOEJUVWJwNWRKMHVCNENVVk10Nlc2bHZIODIwYkpKSWdqSHZSdnBmVk90?=
 =?utf-8?B?dmJXVmowOTUra3JUOVUrSmZXSm91U2RTbTdzcmFDNnpTd1R0bnZxOEFreHVp?=
 =?utf-8?B?Z3lscnlqdlJOREdzV2NEZ0xxMDFjeUJWOFJIRXZwaTRVZVRkSTlMRE9ZblRT?=
 =?utf-8?B?M002aitlWG9lNGxWUTZmbnJOVDdtTnh1Y0JKeGJLckJnRHhXT1dDTmZYYmRT?=
 =?utf-8?B?NUFSeWVQUE01anhIR0VIMjNKek5ycDZmOXYwTW9GSi9uNUtwY0x2K2VHS213?=
 =?utf-8?B?amVGNjRQQ0hLUGFJd1JwSEIwcGp2V3ovUzlrcGVMTkloRnBYVU1qaXJtZGNB?=
 =?utf-8?B?RG84N1pCV0pTZzRGS0EzWTZJL241NnF5SWJzUEl5MVlncjVZQ25iOVNlT0Fh?=
 =?utf-8?B?WFZYNmV3dThnOU5xV1JwbGZjdy9pTmpqemVpR2ZOUUt5SmJvc3U4VkxYNUVH?=
 =?utf-8?B?M2Nua1VjdnJtak4ycWk1OWUxcnFSUTBjWUt4TTBXNXFkSG9vclI4dFFFVzh1?=
 =?utf-8?B?RXBJQzFUMWMvTjZEQUtxaEVwdFhMREdEaUJaYm9ObkpscXhYYXB2QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9m6OwIc2iZAGFFnc7ODU6IatpSHRZpbdGgHf69cmbZzBcXGncrfRigpRBdGpDPMSdYWbmba0uEZ5KSaDH7CNOV8l2HGYAdK3eueQJHhrvDptpuMh6uOGL0oyepQsON0efqombdnJgbjgWj51XAaBMEK6lpnjeNmHn9hkaNFxBJBXeUIcP1i5fjKGD5x8DoOPxxnIN7Gm7s3kh5zibEMlInX/wAp2Z05hz4oX5+QzT1JuvUF4cXkgd1ZYA9TUeYFdY6+JYRQg8zMRrM2uRfvm/8AFjyal9HfU1f+dIuPaWxVycnjGeY8yvCRhi/HwrIeB7bqSH13+gxcQlq4ZsvvcR6+mLnQFVZQY1IVA6gVba+Ja1RMRnYsy+4IR1Hrr/0wp3Io7G8mGNGYThpn5yCyGrLl8qPL2a898spYT88fdZ0FFmxhTNptg9FoUQQhFPDOAN6qKL8MWMguppB4w2Sdm0U+eWDTnBcyHcMND7tyB42zv2lb1jXvj6iCojtDh+lFrqMjOCalm0+NaCZC2t6dDamhuG1cCW/2D6sJglQ9Ta7YVj3aLcuPYgrR4hfRfJ49cllWh6i2zcwJI6+aRljR3NQklb4lCdG9S053+zAVcrs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a70b6a8-7dd4-41ba-25f7-08de5e92d370
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:29:44.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wJXlzyAkmL63H+9VtYBZzip3f8Ebh6N3JcucmIOhMKTKidBLJgBqFeNTBjp5mPpsfeK/Pfp7PZAiwRY4xJpSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_04,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280144
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=697a478d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8 a=DliUwfF3ovEiGOHUbrUA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:12104
X-Proofpoint-GUID: CSk6ZWyL40nFAn4rfU-dpo7LpMqERuYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE0MyBTYWx0ZWRfX+xNpgZYMGPx0
 49cAaL4uvYlBhHFuvls5cehuhpk4PJ1VBpbYSk4ulP7EEGTibNvL01Dr51vyhNzQdL75+rPk39d
 E+6GMVU9h8HNqvgYTr9AkzcCsYm65YvUdzeJ5mKxPhzlxnuoiYojWjOpbIClHtOKXG1phwkOjEy
 ObkaKGwLpHGcDlqvymTitpf4FkBq4p+FWqfmWbfImLz1h6M8ZnpgwtLkKzWC8ZoeU8nOA6sQwoW
 ++pmNbKolfs+BZhO05wQcAQPQAyWb0c5YrGlpLyXOi6YAiXxmjbt7mcofi7Vgc80GDPqrSU2xq2
 YZxq2Geumz0dLx4MQEDMIjg1auWtErueGRV4mWLqyFiyhWL+7Vbcfh7RztziAo2B5Z8wDKIjLJb
 oriX8DhJcQPRyA0AWaFFCqpPP7k1K+f+WoiEl65s40zQQ8bG3i/Nqqw/fZWMKC5XHkOPbsBjhXF
 b2QB/1GUeAima6KA5fuRhqoId0VpEiYR5SYYbZ/o=
X-Proofpoint-ORIG-GUID: CSk6ZWyL40nFAn4rfU-dpo7LpMqERuYv

On 28/01/2026 15:04, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with
> xxd (part of vim-common package).
> As xxd may not be available on some systems building selftests, it makes
> sense to substitute it with more common utils: hexdump, wc, sed to
> generate equivalent C array output.
> 
> Tested by generating header with both xxd and hexdump and comparing
> them.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 2c2f68a171ed..bbcd2101c3d7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -720,9 +720,13 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>  	$(Q)mkdir -p $(BUILD_DIR)
>  	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>  
> +# Generates a header with C array declaration, containing test_progs_verification_cert bytes
>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>  	$(Q)ln -fs $< test_progs_verification_cert && \

I think we can remove the symlinking here too. It was a workaround for the fact that
xxd derived the name of the variable to assign from the filename, so we could not
use $< directly as a result. It would use underscores etc when
representing the path; i.e. something like path_2_test_progs_verification_cert.

Newer xxd had an option to provide an explicit name, but we needed a workaround there
since we couldn't rely on the fact xxd was new enough.

Now since we don't care about xxd we can dispense with the symlinking step.

> -	xxd -i test_progs_verification_cert > $@
> +	(echo "unsigned char test_progs_verification_cert[] = {"; \
> +	 hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g'; \
> +	 echo "};"; \
> +	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
> 

After removing symlinking we would just need to change to using $< above instead
of test_progs_verification_cert I think; following changes on top of your patch 
seem to do the trick in tidying this up:

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b8bf51b7a0b0..a3ea98211ea6 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -23,7 +23,6 @@ test_tcpnotify_user
 test_libbpf
 xdping
 test_cpp
-test_progs_verification_cert
 *.d
 *.subskel.h
 *.skel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bbcd2101c3d7..f559f792c1be 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -722,11 +722,10 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 
 # Generates a header with C array declaration, containing test_progs_verification_cert bytes
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
-       $(Q)ln -fs $< test_progs_verification_cert && \
-       (echo "unsigned char test_progs_verification_cert[] = {"; \
-        hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g'; \
+       $(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
+        hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g'; \
         echo "};"; \
-        echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
+        echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
@@ -902,8 +901,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                   \
                               *.BTF *.BTF_ids *.BTF.base               \
                               no_alu32 cpuv4 bpf_gcc                   \
                               liburandom_read.so)                      \
-       $(OUTPUT)/FEATURE-DUMP.selftests                                \
-       test_progs_verification_cert
+       $(OUTPUT)/FEATURE-DUMP.selftests
 
 .PHONY: docs docs-clean
 
I'd suggest doing something like the above, but I tested both ways and it works
well so

Tested-by: Alan Maguire <alan.maguire@oracle.com>


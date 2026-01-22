Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB424E4D4
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068908; cv=fail; b=lFYqS/tA0/K9OJvvxmPCQmQzu3tqxb/gfwyFyH+ozpkMczQMGWIIujq9L0mMJxBq6xuYKnR42UjQQqyhOQ5Q1XzhdhAxbFgXTTQtdd6jXR+De2/PiGKQaaGYE9Fm+FNU6j4azJ+HMIB91Bg9O1NYKTS551vFnuOC2kp7xIYCKSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068908; c=relaxed/simple;
	bh=UW2l7uoYAiYzrpfv5KjngolRhcOK2O+j01E/1bPtPQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SahV7T0ZSwPqke5alD16/26w5vPxLUdX/6sDwfB3GveYMc1q9C2Sm/bxRgS7RRlAjaQiAHZV3TLtCQMsbR6XdvMvmQn1i11lYtQfXM0MYIeo91sYllNjvlQqSQO51Fvlh8DRJmRp0vd+3xTjS/Vf8OIQS5ArKKtfqSOiOjlX/w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qW3DOcY/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qu6fug77; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qW3DOcY/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qu6fug77"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M2RYWG3032110;
	Thu, 22 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HENVdvAMHNXFMUsAnwLEYf9MTKW4dLnCwYcHBx2sltQ=; b=
	qW3DOcY/9GzfFb/ZMvFYyQevai+MJ7JZr5VGoXhjw1Vp8lXn5yvAk2WHhLpMuXvN
	daSf0RNQ8yk8sgFFlIUn0fbbEqtvxbZqC0cdTLSo85eq/zHyxer5dcvOafvWD1Ii
	4cgA9S+P+zy2iD0mjitG4GIJ+Z3RbfYlN67vmqP8TAQun5MaRcKWpQQpQeWy/HR2
	JNzEUSmggSx+n6RGTpYG3kGZZP/CHGmGvBt/veX9+hLWbzxf2m+Zc/Cnz7OHVvLJ
	tRz8IsqlevK4Z20E1WDGfk3yCj8wQYW5hFznbslRmnSiX6Imww12l+YNBLjCN6VS
	qM1a0UWKjKzD8zpK1PRvoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypy71t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6VN0d018968;
	Thu, 22 Jan 2026 08:00:17 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrtapyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 08:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpJ8rCLjTRLIdEgp6ee3UhpYafJWVb2gBo4ReU6ZY4DKi15MRSj0Cyppe3QGSiQLKZyIwJhsqOmaS0Tm4C0vvFPrc/pbYqy5q557SylbUTzal4I7tCpj5jZyciFgaySB4IGegwStrMLTF/D+MFXUrxlDSSwaKNrONd1c6I7c/tRSa1urK1i/EUzp/hLQ4EXHKof+hsO2xU9Lvh6zSOur8riULtwMmAmaAAP56BcXnduXHBYjYxpR5Bwd7CGnli/93F4gH/izK4XWyLB5ZqGCx4qaEMqPN4EDb1iUMo55Lm7cMNTuL3XY65/zLClxYOikOVq2JK8vyNQ08qj4aCfstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HENVdvAMHNXFMUsAnwLEYf9MTKW4dLnCwYcHBx2sltQ=;
 b=cQlxgmF/PRPu7FisKZikUHHusAIhEQmY7vhsao2tne1BO2Xu/EXwS5FtuPZ5ho1fjNL2PiFvdfidTX9E5tUubaZ+vXof1hNXooMI5x+nH/jNUZuj/cnty9T/+GjG7oe+rOVruxFAH2LMGcPEjMfxVLCPv3bv4P/QqLXe/W8XcgxWH85bSXCCdh5IWA3sHFu3S1x4APPI91VCUUhq3bKWj00Q8OlqhsDDJgH08ldPVVDP5aNo9m5Ipui7x/dILY/mgB2zF36Mzc0lvYYh4xqpUWBMpzjtaX8n+hs6YsWYNjjQ9BxQMjN8RwpPhDaWGJLzEQRQPRFZjNHGsYI4/Co0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HENVdvAMHNXFMUsAnwLEYf9MTKW4dLnCwYcHBx2sltQ=;
 b=Qu6fug77tqt54Fx78T2+lr1jcHUIanINm/R3K2BMJ4PlTw1D0Vz6dAI23qFTvulmAs0gHskgbh76147ZEjNrnNsjxuJLrrOTKM9eq0AG2kLMQMZJZJYBLaPxTe4Vr7/zlpH/+xkF3k16G/RS5g4uSY5y+clGp2mGVKpC2fGpaW4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH4PR10MB8194.namprd10.prod.outlook.com (2603:10b6:610:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 08:00:14 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 08:00:14 +0000
Message-ID: <86d9cea4-677d-4802-9d21-8dcab44bb3f6@oracle.com>
Date: Thu, 22 Jan 2026 08:00:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Fix task_local_data failure
 with 64K page
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Amery Hung <ameryhung@gmail.com>
References: <20260120210925.2544657-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260120210925.2544657-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0446.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::26) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH4PR10MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: c9685b33-1c97-4b46-55cf-08de598c45f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZTdHlIamI1eHQ4aytxSmduSWN6M0hqVEtTT1J1Q1NnZ1hCbWJDQkpVTXJJ?=
 =?utf-8?B?VnFyYi9hSXp2TUZRcmkvVHhudHIyQXF1WkJuVVI1NXBjODVZbzB3cXJWQS9G?=
 =?utf-8?B?RjR5SW9oZ2ZtbW1tZUNGRFNqa1dSSzJUWHVmTkhRYVMrVjRhdXBrZzlSN1NE?=
 =?utf-8?B?dUlNR0xwSWN2ZjhHRE8ySEhUVWNJL2s3M3hVWkNETUJlTmlucjZENDJxMnBI?=
 =?utf-8?B?M0d3d1hjVGJvYURSUDhTRkt2Y2ZwSXZoSHFMaVI5UXZhQTR1Nm5mQXhKcE1i?=
 =?utf-8?B?eDdpaS80TDRLb2JDWGpGb0doTnZyWDBMOGNDOStmbURac2htb05pazIwOEJj?=
 =?utf-8?B?OFgydlNsNk02T2N5U2xIaWVjSENhamtzaVBWWm1CbnQ5V0dOUUE0S2ZNM21D?=
 =?utf-8?B?Q1dKQUIrdjh2Rk04ZW1QYUhhWmg2bTdndmFFVDhqbFQvVEMxbDd0eE5YQnVR?=
 =?utf-8?B?c1ZaSGhQM0hXakd6a2tHL3Voc2Fuc2VaSGlxSjkwRHBYL0MzMjFob1ZsaVNM?=
 =?utf-8?B?bEczNUVIU01FQVdWM2FicVR6UmhINHhQMGdHQWtNaktORmZxaFlOY09jM3pV?=
 =?utf-8?B?dnlWczhPZUpzTGFqdE5EQ25RMFRpWk1kcUtzaTVZYndmSzcwTnV2cmFoYWhS?=
 =?utf-8?B?M1J1b0FSbGx3ZVZZdlQ4TTRPMldQVXpPOEREWVdYaFowVk9qbGxUMW9zV1ls?=
 =?utf-8?B?ZmYyNitkZkk2SHp5SzdVdHRFcXVKR0dqTjUxZHhuZ3lSNU9VWXFHaks4K25y?=
 =?utf-8?B?U1AxWFZ4RldUNlVHQWJhSG1UMnBzY0Q4WGZCajl4TnZEem1yVlhSYlBmYnd2?=
 =?utf-8?B?eWhUbVQzRHhmQUVBbzF3V0JoT1dHRFZmSU10SGRGNDBJbWZDUVNlOGhmVHMv?=
 =?utf-8?B?Tmg0cDRwa1NvV2VodEprYzc2cWc5c3RTb3RqZmxDT0Jnci9EQjNiM3ppaC9m?=
 =?utf-8?B?VjY4L0oyQ040Q3Q3VjIyWnBrMDJxSnFORTZhTnAxS2NKak81a2Fxd01kOTVi?=
 =?utf-8?B?RStqU1ZzUXZLWkpwdVIzWm9UMTluUjhROU85WGxvN2VubzJNZGxYQjZrbHl3?=
 =?utf-8?B?eU5ZVW5TYkNOMVRtQUx5QzR5a2RGbStxUU5maW9HUGRVeTlIcEdScE5VTHlF?=
 =?utf-8?B?bTMyMDI0dk9xejdOMDlaQ1lIV29xUU9nRWN3bzJEQUgwTnZhVDNIU2xnUDl2?=
 =?utf-8?B?MGQyZW53bzIxTEVYUGY2L01HMmY3QmV1ODhwa2hYaVFpOHNrbmtiZTQvWE4x?=
 =?utf-8?B?ZDBTUGVUTTNTRldMVG9iZHZ5Wmt3eEs4MVdWdVFRYVJRSGFNNE13SkFjYktK?=
 =?utf-8?B?WHhnd20yUFZUdFpreGRiSXBzbTJzbTlrQW5RZUVOREJLRnRGdzdhRG0yY3VS?=
 =?utf-8?B?SXlRZGY0dks2MCtPblAyM2lFSC80U2FQU3ZxOVJkUHF0bThIUTZWZFFCeTd2?=
 =?utf-8?B?TTRKRTZ2UkJPZ0NKd2tlZ2dEVGZWd2NEYmZYRXM0ZUp0a2R4RFYxTmtOcHo0?=
 =?utf-8?B?TTJKYS92bXRUc1ZFanpXY2g1cVc1eXgxSFkrTldUZ25VOFFNYWtjMEQ1TnI5?=
 =?utf-8?B?KzZKUkZsekpQWVIzZVcvM0s4TzZZWFUySWhKYUNUai9hcVgxTTdFRitnUUwy?=
 =?utf-8?B?WWRIQW45SVdBcVhVUUhVZ3IxZUJCL0ZER3BNbXc4VEtKK1lHL2VvSWs0eTBy?=
 =?utf-8?B?QlpoMkNGUXFBUUhjaGJuZ2k5K2tRVCtEemdka0N3Z0h2VjF4c0RReUR5QUZq?=
 =?utf-8?B?S2lhVnYySkxNV0VjbVc2Z1RpN2hCc2JQZzJ3WngxT2s5TnRYMUZERFlwWHdZ?=
 =?utf-8?B?cjBmOVNXVHhNLzhqMDNEYmZWclZRSkNqZmQwbkVsQWgxemd4eExhM0tMMlJT?=
 =?utf-8?B?RFJtTzhVc0JNZC9GS1Y5bi9scnpadWliZ1FhNnk1Wnp3clFtd2NnWVd5VU5L?=
 =?utf-8?B?T05GZzVXb0NmdEE1bkJDaFVKRUY2TmNxb1Z2RHVzazVmR2JXZk9STHZVbzd2?=
 =?utf-8?B?K1Ywd3dCMUlWdk80a1RIakdTQ2JvQ21WZzNzc05DRHZwNVhQWnB5cGFmZ0pX?=
 =?utf-8?B?dm9LQksrZFIyWmpEdkVtbWUrNGwraWd3WEpEWGoxTjNnRU9aTmFJUEJCYUlo?=
 =?utf-8?Q?4JKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNVbkRmd24zQjB3TW5RQkJ3RXE5UUFsS2xqU1hpZndBSG5UOEIwUHo3eFA1?=
 =?utf-8?B?WGxmc1hNWWdCS3VNcXdhNExoVHd6Z2FndVBMWUVpR3d6MHA2RS9idXBpbm42?=
 =?utf-8?B?Y24xcFdxU20zNWtmL1lpQkxXZ3V1YlhmcUZSaURyc1JRMEd4dlNVcE1NNy9P?=
 =?utf-8?B?WXBrOHZoTjhiKzFBQjZ1U0RuQ0ZoeWhuYU1LUkZ3b0RPNmJZNy9LZGlYdTFX?=
 =?utf-8?B?SFJ6SWFUeGx4NW8ybDNCYXlON3ZEbGlLL0FLM0E0VmVDTXdMNHg0WXUrS2xh?=
 =?utf-8?B?eUlMWVNaSzV6ZExMcFRhNEhUQUpEU2dLQnovbC95NGt5aFpENGE0UHVxTUda?=
 =?utf-8?B?bEFaUnBkSGhiRXFSR2FtQW5aNEh6ZjVDajBxOFRnaDZ1ZkUxQ2xFSXZKYzAz?=
 =?utf-8?B?a2czL3dQRlRLZng0bWVOelgxemZ2VzZ4UitFM3Y0ZHB1cEdyZ2ZNRHM1c3Qy?=
 =?utf-8?B?cDZocEc1ZUdYb0QxazRaYlIrSm1XZkcxakVObEdENTRUZ0lMQUMzVENzWXRk?=
 =?utf-8?B?RFhObmRuUllIMUNmb3phN2ZjUWF3WGw2azQxQkRhRjQ4NEhpYUhJS0VBNVVP?=
 =?utf-8?B?N2pXUUxNRjUxOHVVZC82eVhqbmhOSGpIaFJhZ0VmNGFWQVFFMGtqa01IVnJM?=
 =?utf-8?B?RWhsa0xhZnJqQU9FUHFhYVBxT0NybXdYRzhUTzkvZzUrRDkvaUxqVC9zWC9E?=
 =?utf-8?B?NlZIdHlUYkNnZE1PSEx5akQwQkFqY2xKLzh6eC9xSzlRdTJyOTBiTTdSMDBw?=
 =?utf-8?B?NFJmRjRJTDNlS2FjM2FiUTdpQnBibnB1OTk4T1lMWWZub21BWkwzTzlYbHkx?=
 =?utf-8?B?RlZQODJLQlJsbldybHQ5V2ZOdHhwMU50ckQzdmdPakhEbllOQU12aU5MeWdv?=
 =?utf-8?B?UVhMY0x2OElQV1VaV0t5ZmpBY1NvRmFUV1FsUjZVbDF5S0hTUEM3ZFI1OThp?=
 =?utf-8?B?TmYza0pkRDZ4WERORDJqajAxZWFrZ0lmaC93SlA0TDhMM21vLzV6M1hMTVdz?=
 =?utf-8?B?bVV4cGdiUDg4T1l6UEtEeXY1SE40TE1NaG1hQUxnSWgyekRzbGdoN2xjY0hl?=
 =?utf-8?B?SDNJMFBuRVdpNlMwWlBuSlJjRkk0bFhqQ1FmcW5lTWZXQk1pRGpzQUcvSjZm?=
 =?utf-8?B?cGJGOG5HMTZPNXQzZUJOd1p2Q25tUVlhckdVcU1la1N0cktXTWtLVkxPbS9E?=
 =?utf-8?B?ZmowdDllQlVzNHErZndNNHJpTmc5YmpSeUxjY0o2RU1lbjArenRoRXJ5YVZi?=
 =?utf-8?B?UGJJT2tKWUJ1YTQ4Zm5HVHk1QUExSE9iZlE1a2FIYUFCZlFnT0N2OGorUmk5?=
 =?utf-8?B?Uk9MTThtem9ZQkNoSFlRUDFmVGczZnZmWmJOSUtEYTBxR09OaXJ1d2lUTkFt?=
 =?utf-8?B?VWhTd2hpZGREcWRSamk3KzB5ZVIvMGQ4aUllNXBMZU9qU1RoWTNoakxnSWJj?=
 =?utf-8?B?V0xXeUFoM1A2dEVBMWpNbGNlbEZRZWMwM2VKVjdtY2d3VTJUR3JrOW1lZGlR?=
 =?utf-8?B?OUY3Rk1nT2txenlCek11bnBxZlRUYmJpaUl0OGV4VjlPMFQyWXV2TStVU2wy?=
 =?utf-8?B?aXpTcEFEajVjczlqQjQ2VXh5VlpKN1dtaG1UY1k4ejVIUFUyalRNd2h3Sndi?=
 =?utf-8?B?SFN0SWI0cUplR3JGUCtPTll0ZkVBcFMwSlZzTDhubXV1TFpUK0wyK3RKUGZ5?=
 =?utf-8?B?MTlBb09kdmJmU2IxdkdFMXZnQlBsbzIvNHpTQkhuSlNwK0dqbHZPcitZbWJT?=
 =?utf-8?B?STVtajYxbzVaSHdPQ1laQ0V1QWk3bno3N094QkU1ekNoUFVtTTZyaFlNWCtT?=
 =?utf-8?B?YXZLN1I3N2hDNTZ5anY1Ly9zUnB5bVpicDduaWxWSzBQUC9OSkVaY3M3MExR?=
 =?utf-8?B?UHY3TEgyR3ZSQ1pEQlFkWWVuZUVJNDkzMVBvd3AxNnZiUWhlRTh6MVBRaWdS?=
 =?utf-8?B?blE4QUdkOVdDZ2V3eFNEWUxNS1VNWkVyemZqcFRNMWZzOWFIM1FyNVFQQTZE?=
 =?utf-8?B?M2tUSUQ0eUFaQk93aEpSNlkvZjl3b3RjeGJsNmdCR2lUTVE0ZkRRbThXWTV3?=
 =?utf-8?B?dUFudUJYcUtJbXEyVG1CWTljS01WdGdmMStLVXpWRGdDWjNJOVYxN21ITjZo?=
 =?utf-8?B?cW94UW0xYXVnbzNvUjZnd2syTS9veC8zNS9OTDBWUElHbDZqUmQ5Q3J6OG9r?=
 =?utf-8?B?cjZ3SW5TczliUkFmY1Vma0xFUEl4c1AwcUpuZVY0N0VOQmxKQW1GR2pXbmc4?=
 =?utf-8?B?VTZxUldYRUYrWHJWRUtnMVFzazZ5d0ZrVlVIbE92VnB4bW5XMjZXOFBCVlZR?=
 =?utf-8?B?OHl6eHlHOElRbGlBS0RZa1NjeHJhV25IcHdYMXBKcE5GSjJoc2tGQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4m3Nj3zctQkjA3QirF3C1tZx7BhkcymSmbxNkYJqd3toiVArVFcBnUV2vziOWSImpSbYCbk9suUVm8vqSm6dR7bx9tPMNDmS5UmuZsEE6P00AAcp+eISPsa5b1hdcbkARXLP0gw0Ej+yBl6o8HO1TLhNcaMJseL+FqIKfmLSAIPnpVUZBApgWqRuV7U0LTAnDQz7PFIoMABiW8BoHNAegAp6WjEF4GRT/NUjx8trc5Bi+O8UlyCCB+U0Oll8tiGL//61imeUJOEBuMr8eoqKcoqP7f2S3/BzLWWif9CDxwipJbGTXro5eHx7aF+Tie+yP499ODEfinr7VsPDcEqepCtUt5BJbfWvej956XU5uBDSmce2UCUPhSqXXqYX9HFsCwG29G/3mYEiFgU5XaKvPW143WEYr0Q1+gRQzwWmGZAIUydL6HlU/Fhhfi5LZ21EIRnAQImBSuVny2sTd6nouH0MZkzNIqgCgWNP1ueJSF/RAlZaAQRgT3f9SRHBDQAoJlbEDa+HFJLWq5gTuX2p48rlpjHCrQ23c2x1Jkj8OAbpGKH6IK+levlitHC63+/sXJr1+yutIH/QiMmAXNW3KbCas7IlFMjB0QNLCGmQTjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9685b33-1c97-4b46-55cf-08de598c45f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:00:13.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0I18vN0ZjhAyjrRsTrn5IY1jViJ+IUMP+F6JXilb/GoCQkN5vUcTwwQfSC810yb107cV13bPViRXDtjgUiB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601220052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MiBTYWx0ZWRfX+fo2LGfRehMz
 +B3GOCxHmUir2i8QWvlscLXikcWtV2zxWp6RZLDUaGAr5d/PQ5a7k227y2h7jrAVR8uEXCpDTyC
 VAaZIOuIrn/aAPLRANHmn4CM+DH+q+RjDT3bAB3k6/Bcnnd5nv9Gf8ittgG+8lyAlmPLheO0jV6
 0dT8f9CaHH7vcZO1dLklEWt+20i+EEOJ13It466UXANj0E0s+JnY0ixfGLyVzp5ZbJ23xlywl0W
 dVrRBJNtDin+me/rxvvlA3CmmUS1q8d1F08BY5bxeBV0h0vPtyxWlQrgFe29HDVY1QFiRFErCQd
 jv9FZtzBZZiIRROKbB1LyZHYgsguu2g4eINJ3v2y3io45ntJTWHF435Bobu2dQMDRHJdF0QRToN
 8QKCxCt0ZeklFexQ9yj2OxRta7CinkKR02vLpsUNI1h1qdqibbIfK+5UeVos7jPEM2B+fj3BHNX
 PXfNXXB0+NQiGQUqCGx31bUAiGqrGW1UA0wwqNKI=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=6971d913 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=2atOAONRzkd61VIkcJcA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: xpA8sMItFS_988bG_L6xgwHR87Yv2ArT
X-Proofpoint-GUID: xpA8sMItFS_988bG_L6xgwHR87Yv2ArT

On 20/01/2026 21:09, Yonghong Song wrote:
> On arm64 systems with 64K pages, the selftest task_local_data has the following
> failures:
>   ...
>   test_task_local_data_basic:PASS:tld_create_key 0 nsec
>   test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_key: actual 0 != expected -28
>   ...
>   test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>   test_task_local_data_basic_thread:FAIL:task_main retval unexpected error: 2 (errno 0)
>   test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected tld_get_data value0: actual 0 != expected 6268
>   ...
>   #447/1   task_local_data/task_local_data_basic:FAIL
>   ...
>   #447/2   task_local_data/task_local_data_race:FAIL
>   #447     task_local_data:FAIL
> 
> When TLD_DYN_DATA_SIZE is 64K page size, for
>   struct tld_meta_u {
>        _Atomic __u8 cnt;
>        __u16 size;
>         struct tld_metadata metadata[];
>   };
> fields 'cnt' and 'size' would overflow. For example,
> for 4K page, 'cnt' will be 4096/64 = 64. But for 64K page,
> 'cnt' will be 65536/64 = 1024 and 'cnt' is not enough for 1024.
> For field 'size', it is okay for value 4K, but it is not enough
> for 64K as maximum 'size' value is '64K - 1'.
> 
> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'
> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
> accordingly.
> 
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++---
>  .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>  tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 2de38776a2d4..4c38f9a7bc90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -94,8 +94,8 @@ struct tld_metadata {
>  };
>  
>  struct tld_meta_u {
> -	_Atomic __u8 cnt;
> -	__u16 size;
> +	_Atomic __u16 cnt;
> +	__u32 size;
>  	struct tld_metadata metadata[];
>  };
>  
> @@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
>  static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
>  {
>  	int err, i, sz, off = 0;
> -	__u8 cnt;
> +	__u16 cnt;
>  
>  	if (!TLD_READ_ONCE(tld_meta_p)) {
>  		err = __tld_init_meta_p();
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 9fd6306b455c..cc4d49222d9d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -4,7 +4,7 @@
>  #include <test_progs.h>
>  
>  #define TLD_FREE_DATA_ON_THREAD_EXIT
> -#define TLD_DYN_DATA_SIZE 4096
> +#define TLD_DYN_DATA_SIZE getpagesize()
>  #include "task_local_data.h"
>  
>  struct test_tld_struct {
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 432fff2af844..e13f239b46b0 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -80,8 +80,8 @@ struct tld_metadata {
>  };
>  
>  struct tld_meta_u {
> -	__u8 cnt;
> -	__u16 size;
> +	__u16 cnt;
> +	__u32 size;
>  	struct tld_metadata metadata[TLD_MAX_DATA_CNT];
>  };
>  


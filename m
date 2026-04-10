Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803F2EAD1B;
	Fri, 10 Apr 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815659; cv=fail; b=tOdeCM+sr82seimiCJS313z4py6n4V50SQgfEJ7bhhsYLvUpYAl/T7goFqIFJ93EAEqa3JhJ6aYgvh4vZhWLKprBYqHg2TCorOQWDgImLiu+WFUIMNC4L/8jNJif/Zm21jWDzR6DNajYyTnXibKENsi9S+qtusSYGXMuyzZmOkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815659; c=relaxed/simple;
	bh=eoHNMgtyVknatLJqiNtJWE9/QlGmGnCgx3Cy0w0O3q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+q+dFkXzX31V3RGGx9M4Iu1HnLjWKtUu9tV5zQCRZ8DuC7DtF2Pi+SfhUQNC6Wytp3cbduqM8cJ267GE0rWf3orSzCSUuyIx1v8jvcW9EM+Yh8GbVZtkNwdzfLzQcUUJOzp/TUN2Q7GP0mxCtvkPbp8HuuJBbryFqGB64KYPZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n7NvhJyJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L8H9SicM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n7NvhJyJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L8H9SicM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A8tWm03970049;
	Fri, 10 Apr 2026 10:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AGcdMPlWf6e1bxCvr0aV9FnCfrjtAD3KfP0ELMRtSss=; b=
	n7NvhJyJMyGLMjuGkapqPcyQ0moc2xE8TFjBgTTBap4UECH+R1XO6O32KL7C/4sL
	Ja/4IJcyAXMUCnne0m241W79yiOhVHdOpFOmDrOb30FYIAaxSLYlKexDmZWAOQ6b
	KUabm9AjrUhcNTj+bLMaqJufMYZwua2KuTRqWu5G/T8pXb86Y1/2C8pdB7lHhhZC
	Cm2zLIY/e7ZM1j6nTUWfcPALoI5dRRHGOV890479DvmzxxKLxdZmJzm4A/vrzwPn
	A9et28uq2ser/+z+o9NY1txgfYI/Us88s5FGe1L1Wjv1PJJC/8nvf3MupYrU9MZb
	V7jc5vbq0n8P2jFTAiZp9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqasg0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 10:07:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 63A7nhAJ011666;
	Fri, 10 Apr 2026 10:07:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnu27b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 10:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPQAnM9GHUW7Ojmdh3W6rhDpergYofKwNpBX/bKbRTch+5w0SY7NQ2H0JuWoOhiq/skKUQWCr73naA5SanhNHOz8CYRUuMxraRKGccV7O9tzIGYW1hKOzp/bbKVK6F7wNBhgduHzqyn33dVRhUDDCXDl7mB1L16DDDburJ8vJjM922T7HgALvNlffYAZwnZycYwMhtyuqzHpmE0ax69Y4pCURJlaMUjlZ3XfP2yrTkzFivfYEchxPVFpltJeLQuW5jTaV0nBZKsSTbc7TTpGWXtKGZV74T7vu3sUUMLuFH5IRY5SoG1EnVbaCztoABRAZZUjxp9PyyyOd8XIla0Wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGcdMPlWf6e1bxCvr0aV9FnCfrjtAD3KfP0ELMRtSss=;
 b=HocTjp0mV1SpyDzKLO6gGKnnlicsRwMzLGIP1I7979X1tchk2fJMAjkjqIBJjYo7gyp2GQgyTMYgB9OdJYeELrNvuMFt0UYFfxiqtr9/hrUrembKGijtUJy0vdcjJjY5g0HnRZH995yEg3FunTKiLHwRXqJlZxFo6zCPwj24V7OKrMhHBVjPcqNpUWCJVFA6O5+6ONkuGbLoUPsNwqXmrE9l0FomhZe150XXACbJTp4O9VTCXJMNA5MD77gpnNOkHFk4G1dCf0yR4vgTdyv2O2ZUryhjjr+7mBPjrv88ziLtEwxOtQt2QgmXox1C+2DZuh0iaysq4vlu77LKhIxh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGcdMPlWf6e1bxCvr0aV9FnCfrjtAD3KfP0ELMRtSss=;
 b=L8H9SicM2Va0B2PnUwFkGh7zHP+NL76x98M/0OfqleUM/7e16pbWJx41mNvrbuJT7rTBOWoq6WZjZCMAsBYn5Wlf6ryWeCUzMuDG8bbM/keZ+2SNsv7ckChCXI8Fk+pUahovbQu7RJl5ET1mL3xYG5k10Waj4dbZOiya9AEaImU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 10:07:09 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 10:07:09 +0000
Message-ID: <00e95867-edbc-4e74-8696-16a8f61223b7@oracle.com>
Date: Fri, 10 Apr 2026 11:06:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] selftests/bpf: Tolerate partial builds across
 kernel configs
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0023.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b1aeb2-cb7a-4c38-2297-08de96e8ed2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	56fUpoFF8KQZu9i7ZtlvKId+Y10d9EzNin/iFUwmXrYZqJEhMoiF4/LNViazHsEsdzSbSqEucNChm5d83FxWkpkkv0tNM2+5D+nRNdAsMKg7zeXw2ygYqGzx6XPAUyNNfAsZ3R4u14yGiaptmdAdSHe1Ocp0bZHJWFQFW1SAhUcfggTK0qPA02CCyDlcDYA92I6xyKkhzfHnM3qNqbXo4/cYDbLBLNSu9QWApG2HYxKRTljqxu1n17dGpxPZCS4nvPc7CEhCV4IrSsu4kuRuMhPXi5JFMD5Bs47sssYCtyTlcyiV7Nlf0lJt2Cy09mDKcNPrfLjZ14/EkY8nGwnR+EDXHqiZwjGcqfAXpJuTMhlOJrVLjgMEqDl2zRs17L7JCUApCwiz0VGsaKkljxNUBYeyn1eN9SUK/8icpY/HV/uDo7rReBL8gDs4Zz3dJ8D3ketAd/LnnPau418f3ToVH/1Q4JG4v6K6p6jINw1aKGbvBD2PaIV7bHW9gmsD1k/ewuSf/sHQe+QuQE4xkLbYLI4EmbibqL1azh2Lp7M6etFDTjNAJc/TIvBUG99cervqYRnw9r1HiIeTX81uSk213fTincBWDmiRhIb4B/tfknik3jj2+EpvIQecjgn0v1HaHa/VGUFNCMFcSXRkhJhSUXXwdQP8y1HXhlR5+VcVUwLeaM7ROB0hkR2f9faU6tD8pSLenFUVUDHG7ZLhz86KtC8sKD+tJaERqlTjJEjXjlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1dsWE5hYWdLMEVoUTE3UXRLV2pwbnp0ckV3NlFvMm5QKzh3ZUE0Z0dhSXdu?=
 =?utf-8?B?ZUxDNGZRclRMb0hrYlllWUw2Qnl1V01zMDhNSXpFeHRnWUFUYXA1ZjVVNWdh?=
 =?utf-8?B?b3FDWnFMSDFGZ1h5eXc0QWY2V1JHWGNHNENhd0toZGpqekx4T2FML3VoU1l6?=
 =?utf-8?B?Rm0zckFScnROV0ZlSUhaZG03VDVmaDZDdFdqcDhYQzF5NmQwVytsYmVkdDND?=
 =?utf-8?B?dWg4WWZBMEROQVBPTTgwNE1tZlNGVWVucm9jYkltRnVrSWpSVDNRVFdoTTRY?=
 =?utf-8?B?eHVZSVJrUUdpaEU1U0RiUldxakpTT2lrdHgvdTdxT1hBQ2V6SnBzQmI3dlph?=
 =?utf-8?B?MkU2NVpSc2RzQk1YOUd3cXNuUXl3K0lQMGxLK2NYd1lWQWVsam1IYlltNXRk?=
 =?utf-8?B?eVpuOEtST3ZoSjJHajZlVjlBWmhMMTBRL2ZENit0TTlGalgva1VHQU9jSWdC?=
 =?utf-8?B?VzA4TkovYmc3ZU1zQktzMFlHNXlTQlVvYk1NLyt1OUFsdXNLYnBiRHdRYW5H?=
 =?utf-8?B?OHN5NmJDdDVWRGVkVkxGU3l4VUdZR2pnb2tMM21CR1o4THBJM2NqMmN2Nm1w?=
 =?utf-8?B?VUpJdWZtS3g1VzU4dlFjRVkzOUI5NGJ6NDdrTTdNZjJlRFlndldlM25oS1Vr?=
 =?utf-8?B?VyttL3krMzA5eURFUURrVkZMSWtvVUk5ejZQbEEyclNaY042cVBrTFNVaHBQ?=
 =?utf-8?B?NWRoMlVQSUpZejFxU0JNdTZPYnFQMnFGb0l0bUloZjBzNUpvOE9tcXphWU1X?=
 =?utf-8?B?SlNvcVU2OWM0L0VFZDVzZ1hlWE1nY2tWWmc3OVZaVjZ6LzluT3dQSGpJZUE0?=
 =?utf-8?B?bGZGd3NkVzZWVGEyWDczOUZXZ2pzQVpSMXAreXI0M3lRZ25Tb3g3RmVlVGlw?=
 =?utf-8?B?Q0dDMlpRK1gwV0lodVdqMCtEb3hnd2wrTU5ZS0taUkxKRmlhNHBDYnFwNlM1?=
 =?utf-8?B?RUxXcmQ5amxUZWJoZUJwNXRtWm0ra0x6U1dBb3p5U1p0eVdRNkpTeGFpZWZM?=
 =?utf-8?B?QitDQ2pXekg1K0dUKzdzZExXRUFBaGoxTHVLU2U1Um9DZ2JYR0FTQjNmZGQx?=
 =?utf-8?B?bjFjQlFKNmJZcytKbTE1NTNCdEgxcU5BSEFWcUlYRDVUc2R3ejJXT2MzblNy?=
 =?utf-8?B?c0xLNXc1cjI2Yks1WjVSbVkzVUpObGJicXF1eVV4SHlTVmZXZ0dKZ1VRNmhL?=
 =?utf-8?B?TDBQZVBxdHdjNGd2aFZqTHgwbHFxTU1hK3RzcENCNkMrL1gzdlB1OUZucHBR?=
 =?utf-8?B?eEVkbTc2WXdBdFlFNGU3b3VmVlVPZGdYclFYMnVmYUNCRExoeC9pei9jKzRD?=
 =?utf-8?B?c0Q1U2dsVkUvclBxang3MG15UnprQkQzemY2S3psM0J2YytIQjRiSXQ4bjI5?=
 =?utf-8?B?eXJibkcxbnU3ZXVWRFlrQzA3UzJRYnBUdWdDa1Q4Lyt1MTZaN3BXREx2L2Js?=
 =?utf-8?B?TUZZb244TmxwZHNsczduU0hDUFpOTVg2NEhweGJlR2JVM0xySE1ZcGpQMEU1?=
 =?utf-8?B?SjNIOVBzMHJzbWhBSXZvWWdNM0RuTmpPdkR4cGxqSDVtNWF6Y2N0RWNwYzVl?=
 =?utf-8?B?UlhwK2F1MTFJdTVKMWVqZ1JlK05IU3B4QWpoWUxpcnVFQnZqdE50eloxK0pz?=
 =?utf-8?B?RE1EZ2xwMXIrQ055eWgzbEVGWUhjcW1CYWVXRHVQNDNxMGxNUGdoclNFUUFJ?=
 =?utf-8?B?ZGdpSHVVY3UyejZGd2Fyb0ttQWdDbEVyVlpSb3NZUndPSGs2UjRub3RBa3Ni?=
 =?utf-8?B?K1lteUhsVGpmOWZFNzlsYytUazJsNmx4MWxXQ0o0aUoxUWFWWVVwQ1V1UWxN?=
 =?utf-8?B?d2lPNGdxbVA4VE5kMDhrckV5SnhsMEdkWndsTjZubjhJZVpMOHZ3Q3N0MFJC?=
 =?utf-8?B?bSs2MTNQbk9jY0RiNU9SbGxPSmxZdlc4dWQrZ2haU3k2UER1Z050TThQRHV6?=
 =?utf-8?B?M2Rmc3JJdDlqR0xTRVlaUks2MUtOTVd4NHc2MnNqNXdEVys5TjNVMFZrTC9s?=
 =?utf-8?B?elNZTkIwUEtXYWhJSXZ6d1RwSGpOQUxrOFdLWVVWa0g5dDN1MjR1VmdiTWkv?=
 =?utf-8?B?YmxJZUVlQ0U3dTllWGpKeEQ1QmFiZ0VWQnZSdzdsY2t5YnZ5cVdadnBRMnl2?=
 =?utf-8?B?eDBGRzY1VmgxS1EvVXNpNmRxbHZpZ2pCZ0hWdXhIbUNhMzduUWJNcXREWllD?=
 =?utf-8?B?UXNCQW9sdEhXNDFPUGVCYjhjVlVkYjlKWUVVU0FDT2xRT1phclc4QURQQkUy?=
 =?utf-8?B?Njc2MFg1MWZrT25vWmdMd0ZaV21UOEFzTUtuTXBuMlR2NWdDYnNQV3ZOYzFz?=
 =?utf-8?B?UEcvcWZWOXFLNTRjLzBBckJtRjdrV2ozaENBY0lwYldIMUlGTUQxQT09?=
X-Exchange-RoutingPolicyChecked:
	F4Dd5HiwQ2D83DecMnRu9wKCPp1wZ8RKJN5QfY/mJA2LTDf+9r6l4stKmeqeLmTHCdJEJQXLfxcLgl7t9KOqsnmmxpp0IuB6ZlHOmPGov9qNpZDgoO8Ud5FHxCnqdNAhTkWjy8Lk4V3CHCw4cW5+z4yPMD1M8W/xtfch5Nt+WNsu8vC2NOPoZcBy+c4K537CVgIQZNdK8cnFE79nNEk0ZXsl+FHdl9LKEKQJvcDmmetbYipV+QQ40HbZAT926KAO7xtpO8xdNkm2HcidxY/gQiwtV70tCyZHrtk2wwhbpB1cGoGrJ7nw+3ZZ7of+ujYDvhvttO/moMi0hC0IKhnVfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y4BZ0ZkYDymVdvOJgelwYPQb9DIbIrTzK3pE2RtsdjN+sDrzYUR2UF1o+aQYpvmg5XVsZCBPS+0UNr/RJ4p8c3Gfn0UAOL5MclF0iftPnNLR++IGriwILtZgDENqIS4b8Z//01pcdQhyhhcxqdTuHUbX8agGdOJvGcASQBKPerzUQVY9Umm9jc2Z0jlrP4mrptf7Fw3MNmElbTBfNsTEXuoNEGOav7CoSQQV4Dcvj9WPlA2Wi1IlM+9d/S3ABHCPY6bqDlcAU//c59yUn6DH+m8+DJCapEqxqRSzhoiIJWnA6Oi+K/9NU/AkTJ3KMoQYjEUM5xcR5OxAluZ9y/shZwEpzgW+9KmBpf2I5TQwVhCUzEKSJwoEWo9mE5094ZJ7n4AxaYtPcsYLsUKIG9HexEiGqfvPh4NtKm1ljwV3FFF9AU/VtyNDwR8bVUjle4t5LJ7Qa6Artgujutr2JoQeOWd8nERj2e/NrFYXzwIWKE0YUmlPPMZwsy4j6dAq5Ybhfp9itQbGgbJg/HPWNWid3pIv7HX6CykijslcUOsWKB4qK5jogLfgc4/VUTF3Uhy0iLkz/X7bKumpKoFeFV7yMA1wT22ucWN9GOcIoP+jpgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b1aeb2-cb7a-4c38-2297-08de96e8ed2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 10:07:09.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHa8Bc+idDzJgjl5uoCN2hzzOy1nKCrzetEObYb8tgcUpBfHkrvFZ2hbalqAA3pmOVF6ELl/XVhml/Zjp74uyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604100093
X-Proofpoint-ORIG-GUID: 3XdMxehVnbwckLKLuOb84RwqCOSWNfmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MyBTYWx0ZWRfX6cI7lh24Vvy+
 j3x8lQ2Aj0c75RDZBHAC8fh4y/oVf6TvG3jgoqYWv/CB080FuBmT3SLtX3kh8tXabBO0hLlOP3X
 P1f/yol6VqlElj9H8mtSAgGZRT5fe5DPoNoemwcSnluCKTvEIyy1lwIT0syB74Okx2layRlfewP
 bvY486n4bviof32n+OvzoP3p5x/hS/vto7Aaa1AEBGMmSgbfLxR/Q4DvuEClgZdJH3FEMSSL8hS
 I6sYrhthIMs3Z8rvqLcwtuuMyZ9dbGVuyqIU5uTPl1sSgNhsGxMccJIXcbjyUcAk7GG1X1/ARE1
 w5T4jO6VLJ7AhljYDPGVADbhXjpMVE/HHD1ZauYWRIhO7Dk5Hzj9fykf5/ut7twTOoUA1zG0cu/
 N5KL3KnUAe4ybnw/tYLRFOzJ8cL31XYUUR8tecgXd0lmoZJosqrOVjKVDIpBJiya+y0RHqg7Bup
 owqemD3arjjEU5aPhHg==
X-Authority-Analysis: v=2.4 cv=AsTeGu9P c=1 sm=1 tr=0 ts=69d8cbd2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=c92rfblmAAAA:8 a=iox4zFpeAAAA:8 a=KSb9T-wMAAAA:8 a=VLc2VSdLAAAA:20
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=MU1CPdLcglX8kbF6PHEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=KF4VuIdXkMyp4E_ug72i:22 a=FO4_E8m0qiDe52t0p3_H:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 3XdMxehVnbwckLKLuOb84RwqCOSWNfmC

On 06/04/2026 19:22, Ricardo B. Marlière wrote:
> Currently the BPF selftests can only be built by using the minimum kernel
> configuration defined in tools/testing/selftests/bpf/config*. This poses a
> problem in distribution kernels that may have some of the flags disabled or
> set as module. For example, we have been running the tests regularly in
> openSUSE Tumbleweed [1] [2] but to work around this fact we created a
> special package [3] that build the tests against an auxiliary vmlinux with
> the BPF Kconfig. We keep a list of known issues that may happen due to,
> amongst other things, configuration mismatches [4] [5].
> 
> The maintenance of this package is far from ideal, especially for
> enterprise kernels. The goal of this series is to enable the common usecase
> of running the following in any system:
> 
> ```sh
> make -C tools/testing/selftests install \
>         SKIP_TARGETS= \
>         TARGETS=bpf \
>         O=/lib/modules/$(uname -r)/build
> ```
> 
> As an example, the following script targeting a minimal config can be used
> for testing:
> 
> ```sh
> make defconfig
> scripts/config --file .config \
>                --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
>                --enable DEBUG_INFO_BTF \
>                --enable BPF_SYSCALL \
>                --enable BPF_JIT
> make olddefconfig
> make -j$(nproc)
> make -j$(nproc) -C tools/testing/selftests SKIP_TARGETS= TARGETS=bpf install
> ```
> 
> This produces a test_progs binary with 579 subtests, against the total of
> 708. Many of them will still fail or be skipped at runtime due to lack of
> symbols, but at least there will be a clear way of building the tests.
>

hi Ricardo, I've been looking at this series and one concern I had was if
tolerating failures to build with incomplete config would create problems
in detecting failures when the config is complete, i.e. in BPF CI. So for
example if say a BPF skeleton didn't compile when it really should due to 
an introduced bug, we wouldn't want to drive on in all cases.

However, from what I can see, CI held up well with these changes in place [1].

That said it might be nice to preserve a "strict" mode which fails when
we hit compilation issues etc, failing as we do today; I couldn't find any existing 
general kselftest concept that fits with that but it would be valuable I think
if possible. Perhaps we could default to non-strict mode when a make -C is initiated
or something like that, and continue to operate strictly when building directly
in tools/testing/selftests/bpf?

I ran the changes through the usual workflow I use - build bpf selftests at
tools/testing/selftests/bpf level and run ./test_progs ; no regressions were
observed, so feel free to add for the series

Tested-by: Alan Maguire <alan.maguire@oracle.com>

There are some comments on sashiko.dev [2] that would be worth looking through
too, in particular the concern about O= and M= mentioned for patch 1.

[1] https://github.com/kernel-patches/bpf/actions/runs/24168181680
[2] https://sashiko.dev/#/patchset/20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7%40suse.com
 > [1]: https://openqa.opensuse.org/tests/5811715
> [2]: https://openqa.opensuse.org/tests/5811730
> [3]: https://src.opensuse.org/rmarliere/kselftests
> [4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
> [5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt
> 
> Assisted-by: {codex,claude}
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
> Changes in v4:
> - Drop the test_kmods kselftest module flow patch: lib.mk gen_mods_dir
>   invokes $(MAKE) -C $(TEST_GEN_MODS_DIR) without forwarding
>   RESOLVE_BTFIDS, breaking ASAN and GCC BPF CI builds (Makefile.modfinal
>   cannot find resolve_btfids in the kbuild output tree)
> - Link to v3:
>   https://patch.msgid.link/20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com
> 
> Changes in v3:
> - Split test_kmods patch into two: fix KDIR handling (O= passthrough,
>   EXTRA_CFLAGS/EXTRA_LDFLAGS clearing) and wire into lib.mk via
>   TEST_GEN_MODS_DIR
> - Pass O= through to the kernel module build so artifacts land in the
>   output tree, not the source tree
> - Clear EXTRA_CFLAGS and EXTRA_LDFLAGS when invoking the kernel build to
>   prevent host flags (e.g. -static) leaking into module compilation
> - Replace the bespoke test_kmods pattern rule with lib.mk module
>   infrastructure (TEST_GEN_MODS_DIR); lib.mk now drives build and clean
>   lifecycle
> - Make the .ko copy step resilient: emit SKIP instead of failing when a
>   module is absent
> - Expand the uprobe weak stub comment in bpf_cookie.c to explain why
>   noinline is required
> - Link to v2:
>   https://patch.msgid.link/20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com
> 
> Changes in v2:
> - Skip test_kmods build/clean when KDIR directory does not exist
> - Use `Module.symvers` instead of `.config` for in-tree detection
> - Fix skeleton order-only prereqs commit message
> - Guard BTFIDS step when .test.o is absent
> - Add `__weak stack_mprotect()` stubs in `bpf_cookie.c` and `iters.c`
> - Link to v1:
>   https://patch.msgid.link/20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com
> 
> ---
> Ricardo B. Marlière (10):
>       selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
>       selftests/bpf: Tolerate BPF and skeleton generation failures
>       selftests/bpf: Avoid rebuilds when running emit_tests
>       selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
>       selftests/bpf: Tolerate test file compilation failures
>       selftests/bpf: Allow test_progs to link with a partial object set
>       selftests/bpf: Tolerate benchmark build failures
>       selftests/bpf: Provide weak definitions for cross-test functions
>       selftests/bpf: Skip tests whose objects were not built
>       selftests/bpf: Tolerate missing files during install
> 
>  tools/testing/selftests/bpf/Makefile               | 113 ++++++++++++++-------
>  .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  24 ++++-
>  tools/testing/selftests/bpf/prog_tests/iters.c     |  10 +-
>  tools/testing/selftests/bpf/test_kmods/Makefile    |  15 ++-
>  tools/testing/selftests/bpf/test_progs.c           |   7 +-
>  5 files changed, 120 insertions(+), 49 deletions(-)
> ---
> base-commit: a1aa9ef47c299c5bbc30594d3c2f0589edf908e6
> change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da
> 
> Best regards,
> --  
> Ricardo B. Marlière <rbm@suse.com>
> 
> 


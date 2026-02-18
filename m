Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4F2F3C3D;
	Wed, 18 Feb 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435739; cv=fail; b=uyO2z3wvhzgJpgBq37tKywm+1EOyKXOXZ0SaGaA2EghRERvx1zjL3YCibt63urFrAXpiHUPogALvV8S5mlwN8RaW87WusU4TgLHf1rSHK6s2jkwYT9K/fAHRGoIJlsFMLSzrZ5UF4mRdAcE9Gd8Gk05NpO4lDuNobNfGrQgvTq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435739; c=relaxed/simple;
	bh=gUBfimuZooFP/Ulym3X+r/HYb1NE0OCFgFtlteIgZP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBVDtdlUF9qG/BhticE+fFnTmnO/QIq7JT32Dj26l8SRfn7tH3wg0J41EavI/2V0CEBwuCvBdGsNi/zInl93milI5vPfiDykWDcUoypCLGDeTnRt6j7/nQcd4FLC6eNbkdiwRBS0Ooj9MP8tbXxwv7MCZ3S3S9V/sCogXZqtJGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bsvunYhN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPtdYkQo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsvunYhN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPtdYkQo"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IGiJ051535448;
	Wed, 18 Feb 2026 17:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Gamkyt6Chb6dHmNh1q3V+B3DDwJFqADwsSv0ufgMes=; b=
	bsvunYhNZ47c4FY4hu4oey1uVk/G1A0ck6HyZI2k28dpZik2o7UVw3BbaQwntPvL
	4FDse/71WC052QM5iaIiOQnfObcF2FJ/3cg26ZCP5nXtlYKnCaNxGgwl++fHTK4V
	Hw9MfW9tB8ObPeJbmXBbZWtwyzjHCL40bzY0THIIqzk/6A5YyBwpkGAce3KNwm1b
	llliMKlkQzXvp0Yfwpq5uSipPLF5vdYgGEZJBf9y943kzKKTbWNIPUwch2u9Yc63
	MYGfmElt6nxc5fA7Z9KU4LiQihS+xCzwk4RLDEO8OpoQfzytAhgcC+MEU+QfLV1U
	n1D/qRIeywZyQsfRapmRCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj3t5yxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 17:28:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHSJf2022917;
	Wed, 18 Feb 2026 17:28:29 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2dv4vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 17:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdUEoOGPbA8xH2laezu22gf5V20L8YJXOMF+erR8HyRGX/iXKc8/hV3HUxQBkL1fK7pRIT0pDEw3nUsVeA1vnFU7xVwRlRRCKlTet6uYypoZsqer3Du9OZHMDO8Elpc/SiPTTzFxm5fGbNPGMOmWbQjgIV0tUsYWSFkhczD6hzLhEvy68WMbdH2gTQQo8dS0dwLJvaNyU3Jz+fs4RbVyzNvy0A5T2iJw6kA28BKFvUqHS318BZUEWj5m4XSDkAdYShEAD4S5ixjZ+VEjU3efZxaqfxMR497vFw/hcIVzzRT9q6PDBWKZGQkeG9/+sRRImQs0jG1uG1eBD3J3tuM6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gamkyt6Chb6dHmNh1q3V+B3DDwJFqADwsSv0ufgMes=;
 b=AdsoYYLYrJTFSnFIlQZY14eYXkB014m1PHznvYm5LiIXw2wy8Q7DezgBH4+vQnqq9Wd73/CY9sGbvoeruM2P3u76KIn21uO+BzQmnnSGZ62RrCf9zjGYuzGfNFphINalM5ihtg8RV2kOyR9TtT9VdaC+Z+jcQZ4Y1t3MECp76FeTIu88b+yYwotWhazvkeu81YFICB+PVrmUlIvyzCVYiJ/BnDcDofOcBbI4lGdDuTjFyPjvbHytxsj0h85nVn7kb4Dn1ZOUqQW7v7VuHnVvv6y6rSt4freCl6xpfaqMnk9DDjP8DT9B1km3v+3TLNP6/kY5QnVxjOb09iL+l5eRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gamkyt6Chb6dHmNh1q3V+B3DDwJFqADwsSv0ufgMes=;
 b=NPtdYkQodbZs435yxBX9v/ZLFaV89A7JabbQcUTaBKvzW/fcTRF4bzPWrJrb8W6uJWwQP5zKmV1uB8JmMjvOWJYy0+VQGryBxcb6E13NKGrJQoSnGgH1DIjNkIsLx4PG4sBHFPEiw970fL2nJ6qgsUQ3m4WGTdCVZwD4pHAtA70=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Wed, 18 Feb 2026 17:28:26 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 17:28:26 +0000
Message-ID: <bec4bb53-2161-47f5-8978-1c4282406a02@oracle.com>
Date: Wed, 18 Feb 2026 17:28:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] selftests/bpf: Remove hexdump dependency
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260218-bpf-sft-hexdump-od-v2-1-2f9b3ee5ab86@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260218-bpf-sft-hexdump-od-v2-1-2f9b3ee5ab86@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: b32208c7-3829-478b-9352-08de6f131f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JNOXd0L21xNm1ORXZvWW9zcnBCMEZjK2dnOFYvYVVxTHRucDRKRllscFpQ?=
 =?utf-8?B?ejVlcHJlczgwK3hNMjNRVmNqa0pnZzU0VkZvNVZTVXBoS3l1a0k4NndBRHow?=
 =?utf-8?B?WGFXMmVySTM1dW9sRkRKTENMWFFsQXNiVThJVExmcWJFVzN0MS9Zam42UzRs?=
 =?utf-8?B?VGJMWEl6VkVQYUxGMW81dWZNTmllYjNYU3Z1NHBHNnZUd2c1REs4Z0cxanE5?=
 =?utf-8?B?czBDR0VuMExQNjJITm1jTEFGcTVqVHhRdEhSaGl0NmNXUWo3YVR1WkRCb05n?=
 =?utf-8?B?ODN6WlJ4RHB4dTBCSjRTU1pjSHY0M3FHR2NyaTFKUFhWUlhiWS9kb2xISyt2?=
 =?utf-8?B?aTBtMVdJV2tYNkZsaUpsZGdUdUpicnhxdzVFSlNzOTlmZ2Q2NDR6b3BJYkQ5?=
 =?utf-8?B?MVpmRmJlQnZRTFZwTEtKc3R4U29zSjZQcGZmaGJ4MS9jMlViTE02NEM4aXlr?=
 =?utf-8?B?MzBjSktyazlGSEkvWjVBVEpRNW9zQmxUcWtNampWNitIQmU0dUlIbFRyTlRD?=
 =?utf-8?B?SWNwTFlkUE1zOHBwZDBJNE9mMVM0aHZmWjNDSnE4NVlqSXMreGx1aVR3ZVBR?=
 =?utf-8?B?cnh5cU1acG9vVE05Sy93ZStHZDlSdTVkQTZQM1JOYjdwRWtvMkNTVWRRVEV4?=
 =?utf-8?B?eUVIMWVERm4yZzlsQmxxVmYrd2EvSWpiRHd6RnUwQUVPQXVEVjdrdE1pVEFC?=
 =?utf-8?B?c2RLb1NyN2RVcWJUV2xqZ01qVVBQOW9TVWxnNkg2Tk5XWGFBTFU4Mm5uRVU2?=
 =?utf-8?B?U2xIYzRDekx2WXZ6UEdSTVdsZFNCK0ZudmlGbkVnYlZSQzREV0x0RWlhbXF0?=
 =?utf-8?B?M1pIamREbHllSjBob3pBSHBKUS9tRjlZcDhIbERReGNiR0lBSEFXOVBJSDVk?=
 =?utf-8?B?NWxuMk9lejJYQXpIdm9WbVlkd2RrVXVyc1l5Tm45cVRvc3FTc0tlWmlrOHox?=
 =?utf-8?B?NU5GdGlJMXRnVlpORnhSSWszRjBJZmM1Nk80Qk1BYS9hUGJpWlBFVEVqeEZ1?=
 =?utf-8?B?Q1dhRE1ZRGJGNjI0T0V4WTVQZG41VzFIZ1NuQlRibmVlWlBOd1R0ZnNaMUxa?=
 =?utf-8?B?eVV5NHU3Y1A3T3I5Q0F5WTlYTFR3dDcwTHNmUDU1R0ptaVRZZXVYazRuMzJK?=
 =?utf-8?B?VU40eXJzL01DNnhGMzlCWGVFUVQrNktpK3p0dDZjd01SWU0xZkt3WDlLR3Bm?=
 =?utf-8?B?VGR6Y0ZsUmtQb29DQ2pia25CVEFUSDhFclRoelZaTzJKQkZJRXpzRWxBQThZ?=
 =?utf-8?B?NS9TNnNjdWdNRCt4MUI1SEhtcC95WTRmNE0vWC85cFZ2ZGZTSytkWVQxd0pO?=
 =?utf-8?B?cVdmazhUcmVySzNPNm0rbEQ2WHVyck5uZ2x3NE1NL0J1bWFZVFc0eUdHUy80?=
 =?utf-8?B?N3ZDS3JPQU56LzhQeG8wOURWYjArd3JESldhdWFqeVREUnJiNDZzMmxJdWZi?=
 =?utf-8?B?YnB5MXhnMmFIdnBJT0diUHpHN2pKZzlyWlZIM1AvUytJUnBGY2hwNlc2M3VQ?=
 =?utf-8?B?dWRwY2ZHOUFrZzNCWTZiaUZIQUNKWHR3WkYwcGkxWnUvM3k0Qkl4TEtnd1Zr?=
 =?utf-8?B?ZXEzTjJHNFdTVEtob0NCMGJFUmxYeDBta1h6RXoxditxS3Z4SkpMQjFNWWYy?=
 =?utf-8?B?UHBuRmwzcTBFRi93Q1AvVXN1WmVnTkFCRjA1ZEhKNHlCa3RFOEhlbVpJaUFH?=
 =?utf-8?B?UHNuckRacnZOMWZxOFl5cVJTek92akdZQ3VvKzZvM0NkYmx5Rjlyb3htTEFp?=
 =?utf-8?B?ek1ZWEx0YjhwbzhPOGZhK2lTRm1OMm5RaEJxUWhxOWNvL3pyVzRRSCtkRC9N?=
 =?utf-8?B?WEVHSjY2ZUIxZDJmYjIxWkpHZmxUUW92cUxWNWJoT0dGSXZuTTlwUkZwY3hv?=
 =?utf-8?B?NmxRcGEzRUxLWmhiWWkzTnJNaWNjVVY3MWpvMFY4UjJDczJzQnliR1lxTUw2?=
 =?utf-8?B?RjRBaGpMcXc5QUJpbmthR05KaGdYTzVlUUxqbmk4TzdndHVORFp6M1lDMXRS?=
 =?utf-8?B?SVh4SjVpTWUxNUo1RkpaOHF6L3pRRE9kMlUwZjBGVkE3K1NUZjh0ZytLdWFJ?=
 =?utf-8?B?T0V1dVNUZVE3RnNrM0l0NDEzdFJTb25TaExQeU1LSU9UemZaQ25FNTdoclBo?=
 =?utf-8?B?UGlQRHdSR1BsRkdqb3JrOXgvcTFFN25QY0tjSWhnZjk5OUpyQnk1VURDNmRG?=
 =?utf-8?B?WVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm52eUxuSDNscUxSS1ZMWEVzVmpoOW9pOE5zSmQvR2kwbEg5OGJOWjFYVkdH?=
 =?utf-8?B?cy9vSzhid2dCNFg3d3FZSjVCblBNVUR1VjcwRzM4ZjFCT0hXVWoxaEQ0cFE1?=
 =?utf-8?B?SFhUQTRLZlA5RkZkTmgxbUpoaVlvVVRlRHBzTDZ5ZzUrWXB6TkthUy9QNzZ3?=
 =?utf-8?B?Wm10S0xoaXRvTUJiNmdmU2dGcFczT0tlVENDT1ZlTWRGSFU4Uk1obnNpUjE5?=
 =?utf-8?B?aE1iaU5EVHMrc3h2RnZZVmt0M1JSTTJLUURsMk00MzZjN2doTkphL0tnNE5t?=
 =?utf-8?B?SW9uemgxSzhMTGtpUFliUXFZYmhYSldWOFBhTmVSSVA2NkI1SVRMbG01aUxi?=
 =?utf-8?B?MmVpUFVqcTl0dUsrMFJVcFJIZXZPZllZMk40eHpNcFU1TCtkaE9McUhNV1Mw?=
 =?utf-8?B?RTdhZGN2S3pKS0ZYcW9DbS9zMGRiYS9VRUdhZ3ZCVzVMT2VsdlJrTlBIc0Zt?=
 =?utf-8?B?T0NnUWxEbW1oSHV5VHJHR2hLMzZocjhUeExyNFZVT01FQTZpalRtbDlSUEhJ?=
 =?utf-8?B?dFhxUUtubDRzUDFhTDdoUFFMRjZQWWhOUWFTdkZFK1kxT3FtT3VJVm5BYmtj?=
 =?utf-8?B?WWpUL3hxWUpQM1AzT1JyVXZlMkRsUGduRy9HWGZMTTZDQnFRZWNjNS90WVJW?=
 =?utf-8?B?MFozOCsyMlUwZm5kcnAzWlVyNldDdnhTUXhidnRaaFVWeUZvSENvbUlNem5T?=
 =?utf-8?B?YytieHpFUnpMZUluRGxWN0lJakpQTlczTHZFMi9NNURmK0hmQ0Y3N0xnU0U2?=
 =?utf-8?B?M3RhN3ZNbzRyWktsM3ltRjdoZHgwbFUvR3pwcnA3c1lNcDRHT1BJcVBWN2l5?=
 =?utf-8?B?NjRpMmFEWWdFcndwd1hSdUxtR2RrVTZCVEZwMUFodVp1M0FZMHhxVEpib1BC?=
 =?utf-8?B?eDhaQXBTMnFJb1d3S21Ia0QxZFMwOVVUS29yblNxSUUzS3FBdC9pWXVGVm9C?=
 =?utf-8?B?bFJ5NVVLQ2NUMTM4aG9RaTkrZlRBRC9vbXlZR01UWmRLVTNyaThWR3BHbWw4?=
 =?utf-8?B?d0t4RG1EVHVzL3ptNFdFQlhkSDBiOFhLdm9aTmw3ZVpjQStKQlRTNmtYclNM?=
 =?utf-8?B?T3FxY0lrVW9OWURFcFlWcG1zbk1IeG1nSkNxYlFrSVhEWU4rVytENnFQUnRu?=
 =?utf-8?B?TFdRaVdENWJjQ3RrQTZnOWNCTitPLzdReUZid0tGbURBVElJaG9jYUowZXFS?=
 =?utf-8?B?WGlzOW9sSXJRVHpsTU5OUEJmVkR3eExZQ2lFWEZkZFdndnlqRExSak5JRW1E?=
 =?utf-8?B?WXVEWmQxZDNsSFlNRDFEL1hiYldxQ3B6Qkx1UGpDZzFnYzN4M0NmV0tMQXNl?=
 =?utf-8?B?Q1UvOVNKMngvOEwrcFZvSURWazNjNFkrQnhNTEdORi9Mc3RVcEZSMUx3UFNX?=
 =?utf-8?B?b1lGeURrRnBmc3ZweGxYbURYei82STJ5RTQ4U0Jnc00vQ3ZrSUY1ZXNPY1h0?=
 =?utf-8?B?aXhNb0dyNUNUQlV3N0dKRVdvbGZxT2ZLTnc1V2pzamhtT1MzaW1BQzVXaDlQ?=
 =?utf-8?B?d2pMQ1ZVcHAwWmxVNDJ1d2ZIdVltU0wyRy9hQzh3a2tyVDJXYm1jQ3RVMTdh?=
 =?utf-8?B?RzZOMGIvd2taU0hQSStHekFIZ0xDeWZ4SkxpTGNWUGRwQkRPSUV6TGttM3g3?=
 =?utf-8?B?c1BpTjJ2NzFmTFJBYWt6ZWdISGZWS3pJUXdZd1J1K1VXdEZibTEwQ3ZwQWl3?=
 =?utf-8?B?WDZ1azQ3eTBibG4yTldRRmxLU1hPUS8zUTZ5UTBGeU1zSGViZHo0aEtJSDU2?=
 =?utf-8?B?RVJScnJXbVlINGU1YUlNWDV4S0xHWGVkWmZkV2lNY3ZGdktkUHFmcWozOFRM?=
 =?utf-8?B?OG54KzJ0SW5GeUs3K28xN2JhWURDUzBRZmpVallhTlZWbjVtcFo0ZDUvNXFm?=
 =?utf-8?B?TCtjRU1pYTB1TEtsRk5YeXkxSTN4Uzd2alFlS3QzR1FDM0RWK29EZ3RhSWsz?=
 =?utf-8?B?aDZwZVJ3azh4SGJYSW8wS05DYWxaYkRyTmpNcC9BdndQcDRyWnpLSnBUdW9y?=
 =?utf-8?B?bkN4a0JIaSt0aHQ0WHpBM3lTUFlPS1hKVmNOQ29KYjU0eFhERnkzMU1YSDkv?=
 =?utf-8?B?Lzg4VmpocW93aGxxR2N2SUhxUFlhL1laaTE3SEcyUjBpcHhoUzArRzUwdTlL?=
 =?utf-8?B?dGxUUGdRWHR3WVpQVHNMSmJrL3pTdXdYRjJYSGxYNWk2cEhkZ1VCUCszZHIx?=
 =?utf-8?B?OFRhMUgyTGE5bnZlSUhuSVkxYjFUVzY3eDY4bjhtOElWdWtZY2FUZTlaWnMz?=
 =?utf-8?B?SGlBalN6dXl2aCtwcDEzRjU0RXozRVJodXM0bFg5aHh2SzR3NWpySkoydi9I?=
 =?utf-8?B?SlBwZUsrTkU2Qng2QWhic3hkbDkyUno2cUZ6WERaRkNkaWlZYzQ5QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gvSItK0iunGexSyN2zHCd76S9eWKnozq3FOSlsDC5Vx9d1hd/6Mj+2jeL8SyDT0zT8DFzahniofsJxPtWrlZ1ALkL00dY8KpuYlxoKmQapJvZX4ZGwl/lHBaEVrvlvE4037PSlVr8PHDPWPe0Vmhn2YkO9ljvAM0yurcGqj5E7W2YyYKVzNr8WMEs5tDEwG9R4srOzB0Blcu3yJQ6Wd/sEvM0CfZPMElSip73TaW9/oYwMLhkkIzwWrrr0prMgTJS9EEh3IgokmUkm6DwB4+YGw+Ptj1Z1gFLcUHs3FFG8oLr2HnwayAimFuCHGIdrJAxy3hVF0s9xQRi+hHJQAwYHAazJbVEfCzbb/pKxV9cpH+fb6Gdvj+80jQFYsxcOJXP1nPIsCE/S8iBF1Z4uIrpWTfG4n8RSJRNX6vZzcVsfGmgc6W2soxNlb0l2f5GeE1YglzWg7MPz6Puatxzu+ucJiSQqqvPGJWvw/dKvDNlWjgK02LLKT6PEivrts4iyz22s8QXc0fq1v/YH1z7Ft/br9YXJm79HDmebgCdjYISDXpMvaRTktYdIcUaImTQn/kJ0uCvq7N/UZEudx05YFjgImipWwfVy/3s4ubZZ2zZMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32208c7-3829-478b-9352-08de6f131f81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 17:28:25.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkXYtfyDWwae6vqumwlmoadP/lzANbqWZXqv8q2H9IHCOVFRSSXP4T/u6unCX0qZT9EdCdZRpd33C/Cl9UsPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE0OSBTYWx0ZWRfX93lGK+Is4LZx
 +yWsRxiMJUxIbi+w7y/dT5YrU7uG04WgZ6uwlmIk0RllpWb13ViuN8hMzjzbRs5vuXd0tiiWRA4
 1gej6buJsH+njvPeNzu+edicQZkhohnkZmjkB9WC+sICjofzANcF3g2Hu9Zy7m5nWKBE4NydLvS
 qxZ4K7yga326toBv6A08pYYAKPjIiCA3cf+A3t1RYXrHrp7c0I19YN+nhjuYP07rhWYhzDyJRS4
 t/mo3L7SwaKYsAkCaAy6QOd7YFRT1+OnjdTYRnTplaYFkc/NxTTNkD//0cmMtoVSuU11Qfy8ZXW
 JsYXWhd7Dhh7PpRarlVvtEHzw6xU0NZxNyMdvQfCEXswNPhO/3GbACHlYlkI624v1NWSicSEKJR
 CoX6mxXnEV8mB5A4xTlkyfTxhKkXomqGygTGW2CvRbsf0Bx4R2Rim+JJwLOBnhetEaSKmgpIvm+
 LauKC25ntsZufkkNqhWff1idXHg79cbzrAJiW/8M=
X-Proofpoint-ORIG-GUID: jZWreZdV0XgLzaMgWJfkKgcTb1jFj3fr
X-Authority-Analysis: v=2.4 cv=b/S/I9Gx c=1 sm=1 tr=0 ts=6995f6be b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=M3IkDgzDCBaXLh53UZ4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12254
X-Proofpoint-GUID: jZWreZdV0XgLzaMgWJfkKgcTb1jFj3fr

On 18/02/2026 12:01, Matthieu Baerts (NGI0) wrote:
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with xxd,
> and a switch to hexdump has been done in commit b640d556a2b3
> ("selftests/bpf: Remove xxd util dependency").
> 
> hexdump is a more common utility program, yet it might not be installed
> by default. When it is not installed, BPF selftests build without
> errors, but tests_progs is unusable: it exits with the 255 code and
> without any error messages. When manually reproducing the issue, it is
> not too hard to find out that the generated verification_cert.h file is
> incorrect, but that's time consuming. When digging the BPF selftests
> build logs, this line can be seen amongst thousands others, but ignored:
> 
>   /bin/sh: 2: hexdump: not found
> 
> Here, od is used instead of hexdump. od is coming from the coreutils
> package, and this new od command produces the same output when using od
> from GNU coreutils, uutils, and even busybox. This is more portable, and
> it produces a similar results to what was done before with hexdump:
> there is an extra comma at the end instead of trailing whitespaces,
> but the C code is not impacted.
> 
> Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

looks good to me, and works well.

Tested-by: Alan Maguire <alan.maguire@oracle.com>


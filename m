Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789338238C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672605; cv=fail; b=YxqUIjG11a1U8jvL0Bb5+j+PzvachhJ5ZMGeyIAJEc2045xdR8S9x+bJEwEL6zbCA4xqfEAs76+h0rqDltL6XJEPR9ZCgEY9y1kg+O3btrWlVcyWoCfCwvk1hu6ujYDPjwJwSDPHrKnppbTPwUzxaZ1tDpMREnLd7TVPV0AY2Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672605; c=relaxed/simple;
	bh=oTWdN6J9xH3oE9enIbotS48OMY83QyK73JFa5EXdTqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDtxgX1Ca3XSGpxTnmxP9qKygUirR2KvSEtXgdPHmtLlZPO/Tgmq0RNHpkTKB9+QUoRZLkCmowcUfIBoJnnGkOLRHNXXpuYFxBlPojvyWI2L4QUegj5rxWkL/2hegCiiNKajrXGNqI6rHOqa5Zu2aou+fr1DRRbBfn7lImMBTCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EmmmcojK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vpOVN/jh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EmmmcojK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vpOVN/jh"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K0AGLo4065153;
	Mon, 20 Apr 2026 08:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=21SFXgNdw6NyOJj74fV7a0Xys3t3Sb0rS7uZBB2y0zo=; b=
	EmmmcojKhuqLTfz0ITEYXpF3mAmLFW5iDuznoy0a2tVTKZYzfCe9julGTVmeuwgo
	T8XCDgf/Nuj+05lgX55FJbGwwKoi7MEvOdO/VHG5qcDvt2VLitTHEowRyyc+AQXH
	C0mW3XBjaZIiWhzPmnaNjTREcptxtnPXE9Fof0JU1/GB6w7UtmlAx9njs1g7flvD
	GYvfuxJrR2IFbvrflUkFdETS7d+PJGcN6Z7M1wruwSLc/CS5tzTFXmCTNEbS3fZH
	ip3GBuLIP/qOgHdmWszDDUI7jAM6npxWUunATf160W6cP4VzsRrxu3FOrtlhCDEB
	5LLvKK5ov1plqXILoclaUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm2a5tupp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:09:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63K81GAu017524;
	Mon, 20 Apr 2026 08:09:22 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1bmb8a6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:09:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4fJpkyIcQGOx1mabLhQJM9F5JNcpcEIlUi13v9sHxzdbRYKQN6s7WHvDM82700EbjrCBtvkjMnefJagiHu6ze/N2f+nlhdC1dIJJDxTx2hrJJYoAw9F2kTyUvkGd+5QjrVjqnOkseAGJeFd1FKmQFMpGTiNg/9rvP8HYAG6jtGEVdYcvOe6+4qkzckEmETWMsCFWhwi4VFbvFAmwQK6lIXdzox373DPFJs6tI4NRQLbDrBIzzJZHQ9N+MYdXFcCdfGYI4vgs1NQdhXvV2Xxoj0C5nOVjgHDGHOMiq3e7ez9ZYKTf0PLSvqf7y18enUhtI74MnWfpZhc6EG+jiAjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21SFXgNdw6NyOJj74fV7a0Xys3t3Sb0rS7uZBB2y0zo=;
 b=LZ/7DgnwNdUYTtAlWnZK6KcTsZyOw0lAQ6IxHnXOe4d2bbyBQUNg7s5U/cQ03A10zqkgxU9PoHLNJLBOi4YbSgYMd6k0cRHoZfiTRy0NO2gth95q7rfq/OMPxMelRT0g+IEtzWylACqEX39WsjcoLzRlBpumNnhts7eJROsdjeNheS8MlupUqE+A6updeZtc5g0UmBUBZzsHP6Kr49BVLnRuMpbw3Lq7ozhL1gNte5OXawi+Sphx2VMMnQBwerE9ZhkgL8iungMlkAXrCHxtKCxOiPPWHQMGjEU8+Bl7f0h5jMkR30WjEW6M8YV9kVRQfXj5m3AlL0Hk8fY7z667/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21SFXgNdw6NyOJj74fV7a0Xys3t3Sb0rS7uZBB2y0zo=;
 b=vpOVN/jhIjKVFH+VTCyo3cLPqllBgYy8N3BahsiJwGNsJqWJwOWbhDduFsloGUGQoUT12wfVOlOCEYRuOZgTNYGceR22hJAh5vV5UwORFoJRu8l6WJJVQGEh+UxEMM29+szVRTCrlMLQBVsy5cK1pMiaY3ScP3iTfZdbmO7H+/8=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:09:17 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:09:16 +0000
Message-ID: <4c95e885-1b21-4e25-b9c5-b6a2c37bcf1c@oracle.com>
Date: Mon, 20 Apr 2026 09:09:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 6/6] Documentation/bpf: Update btf doc with
 updated vlen, kind sizes
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, martin.lau@kernel.org,
        clm@meta.com, ihor.solodrai@linux.dev
References: <20260417143023.1551481-7-alan.maguire@oracle.com>
 <0c04590254c3cf4a4a53803c5c8d613bf2ad288b3eaf2a641794f78d4bf0d5c9@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <0c04590254c3cf4a4a53803c5c8d613bf2ad288b3eaf2a641794f78d4bf0d5c9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2f47e4-5905-4718-84c0-08de9eb41d61
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 IsJp/mjfvBnj8dj38YP8Ma6KqJpT1r2u/ck9PHWuZbu+ewPc1Sq7UWIBANB9zI2ZL4jFsGMdVaZDZhkO5Wj9A0MAtzL8bUsuKEiK5p9FhVl/v4WPaZrp8P652xf46MqUD8WdmUGiozfOLV6HtZYqkV8bszpN1t7z46WgmkmALa2r7iJXg8FECBPHDigczQ20OIM0fWC1fo0Ww/xETDBL5+xyg8hPZqzL4xFcyPIT0kFTqSgEnB5SbY2cdm0FsNyEewduS57Zi2C/qSysxGG2UBAjPWQrusMve8IdIt0gnPzwjKcfhHJGMDcynJfeK1sgLZvRNNzq4Qmf5AfgzTyPqFlu26GaOxHF0If6t6/e2GmgIrhfjVcMxM6Bpv+nivQI25aI3kwqVuz9mkETQ6Ic1WAQCNbOlJC9UU+Ys9OUSu5VBDxGxENe3PM3J0VWMdMyG0Cp7r9H5FA7DjT1x5Cta7OKmCw+JJNakgwHpyob5awzuSYFV2/iGowS18CtOmx+hOAznWLpYedtLNIulvk5eoObAZ7qHR7Y34MkRJp3i9kM3w37Q9x5qlLzZuEYYnaIj3JpqFRZOSCJmqiigCOmQzw30pixfzV0Gww3TTIqaZUVkhtohrI9s5MZlrGIa90uX5aBkrn/yjJVtrEAtSRcJ+MgPBkbtvCmCjVSqyqsTqPlMaT8v9uXYIgt6EfcWq8rfPflwxZjWpU/XMG5pmYKdY+feVBujXezD7a/+uLd37klvkn2lwGDkiwihmivM21z
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZVJZekJmYi95MGp1dlJta2NsblJyUEV3Qk9UeU1Zc1RvZ0tEUFkvRGFheG4r?=
 =?utf-8?B?ckgrMjhvTlJsb3hSVEY5Tk82dnlkUFhvbWlITUJTLzJsRWZiYXlLL2RjblVm?=
 =?utf-8?B?aEVLRDRDSU5DTnEwTlZyTDIzQUM3azZPV1U0KzZ3RjIxaFVHRnBSNnAwbkEw?=
 =?utf-8?B?VEg2QXgzLzBzYXVsaVZHVlhWbnlNUGM2RjAyR2NOc0pnS1BtYUJneDVvanc4?=
 =?utf-8?B?b2tGVVRYWlg1d2FiZC9IUkN2ZUNCdjlRU3VKL3M2dmVjMjdTT0VTeVRIVUJt?=
 =?utf-8?B?V05DWmE0U0syY0x0OHNFaXdRanp1Wkh3OUFVR0cwTzhkT3B4VmtUTlJKMllv?=
 =?utf-8?B?Z210Y3A1ZHpUZWhqZjd0REorZklXTkl4am9URnJHZC82alhBdzd1SDd5VzRC?=
 =?utf-8?B?ZUpqWktVQW5qdVVVbENKdXpuK2JWam8xVUtQc1lZM2FYZnVIZ3FxNmJzbmxG?=
 =?utf-8?B?SlpKT1BFSy9CZGc5aEVKNFFQV2JuVS9aaXFzbXBUTnl4eVFabDZpa0pnZ1Nv?=
 =?utf-8?B?cENFV2JOTHFCQXhXRVR5eXhtVmdwczVYVE5KREw0M3RVaVJvT0sxbzMydE4z?=
 =?utf-8?B?aGpRQkgwYXArT1BRaG5hR0FnTHBYcjhkQmVYdGpmbVhTWDhYcWxBUFEyUlUy?=
 =?utf-8?B?OEE5U1FwZDB6clF1YUZPclFxVzhlZ29Ha1pJT0RSTnVMZW9ITStNbVBUWTJw?=
 =?utf-8?B?SHluMVVVeTdDUGJzSGVVZkovQkJBenFsOTVoL3JVdWpNMm5BS3BtaVgzZE1W?=
 =?utf-8?B?VCtqbVVkOWhnZWdkOER3NHhjekNNbW43R0h2cGFGdXZUUktudUlsTEpndUtj?=
 =?utf-8?B?TGV6RkJ6alhvbFQzM3I4eWV3aEJVa3FJMWQyTHp6RmF0Y1JiWjBpVklZZXZD?=
 =?utf-8?B?N2psbTd6NjZwa1FFV0tXdGFsT1lUREs5eGZUT0dGei9WazgxdVhXcjc1WWFk?=
 =?utf-8?B?Z1FaclA5bXRjSWJJODZQeFZCakVDZHZmeHEvRnlPT2JGRHozWTE4UHhEQVhu?=
 =?utf-8?B?Z1dpQVloL1pCcnBvL1AyN1F4M2VNd0ZqaGE0TzhrNjhocy9OU0JuWjhkWXpU?=
 =?utf-8?B?NU54NEVHalNIcUJpQUFsbU4xNFFJa3A1U0NINVpyVVBCTjQvZHBLcGxKOGFj?=
 =?utf-8?B?SEk5R3pWZjZraElqN3Z4N0xxVnEzbUlMN1hPUnhRSkNGS1l2cERyVm1ZZ2tC?=
 =?utf-8?B?NzZkNUdOZzl1VVFuN3B5Kys2Y2g2RVdYSlJDSGh1NXZuaVF2NTlhS2RNcERw?=
 =?utf-8?B?NVVXWWNJQURXWDd2bGJ2RXJjN1FhQkZQOGxxeUhzeEVXLzFhNktkbklucEF3?=
 =?utf-8?B?ZkJ2Z05Yb0xXMnJCaCs5RWw5ZXN3U0YyYWZ5RndJZURPWDNqVkIvT0NSQ1dj?=
 =?utf-8?B?NjNNbUh2anlDbVJFc2JUb3JqUE5GakN5dm0yd0g2eWcwTnBiWTV0ZXlWRWgx?=
 =?utf-8?B?K0RreHpqZ2dJV1gzU0xVOHFHWThJVWU4T3p6ZzQwckJ2b29Ja3lDLzhZWUFJ?=
 =?utf-8?B?VzVZSlFxc3NhM1E0WDAyK2o2U3dsdzNFTWNaLzFzN0NxS3crVDN4d2J0OEg1?=
 =?utf-8?B?NmhPTkthSWJDSjI5ZW4rTXkxZ1l0NWF1RDhjVVdOMU9JOWhFRGRQa3c4bjB3?=
 =?utf-8?B?WmFwdHJsNmEyNmJWTTZ3Y3JHOTdqellPeUVHTEtQbUZQRXpSYng1RFNTRHpo?=
 =?utf-8?B?eDNFKy9DTkJhanByQ1VCcU5UZmx0QWJGMHBiS0dwNEU5YVc4dGMzM1ZyRlA0?=
 =?utf-8?B?NFpmVUtLc2l5K2UrWTkyTnE4VFJTZ25vVEVGN0FSSkp1cWVxYVZoVWtHK1lU?=
 =?utf-8?B?TUR3WGtmb2hDekVMaGdWakRqdEQ0emZUcUhodFFiMHlaQTBuNUhDK1dxZWNn?=
 =?utf-8?B?THlCT3Z1UUFTU2UyUHFYM3RIczdBVUZYdmYzV2ZmRXZHeG1pOVlqc0JlN0pv?=
 =?utf-8?B?dlpLV1FxK2V6b3NLeDlqZVF5Y1JqKzVKRGhlbmVYT3hxencxUUwzTFlSdk92?=
 =?utf-8?B?Rm01UUtCOTNKdjN0RER6T1ltSDloUjVhWE4xR1lNWHJMWEFESFFycEZkb3cx?=
 =?utf-8?B?QzVoaUF1aUkxUDNtdW5RdldoTUphd2hQOGRaemNYNEhlSEd0YUlkSUROV3Jt?=
 =?utf-8?B?SWVpWmZUZTYzeThZSTdXcGI4eEdESHkxNkVWMkFVZlRoeHhIeDV3NzZFRElW?=
 =?utf-8?B?MktJOU5JMjQyN0JlcWo2NWdIRTE1OThEMG5oWEEyU0RhUDF2V3pBb1lrakgv?=
 =?utf-8?B?R05hNVh5ZUpRNjFrRXFBK2s5bFB2Q2JTZ0tiZG1obUJueHVlN2VYRFo2VkVE?=
 =?utf-8?B?WHZZQzd4aE5oTWk5U1BNM1dHVmFGdFJHU0FWejFvN09FTUNWMUlTZz09?=
X-Exchange-RoutingPolicyChecked:
	f8ksw/5pvecSFKGGTX3cfIfnul1nWwXl0kPHc2aCOuIi1RuRbGHnuP5mS8aqLR3qCMtz8PBwaDPpgCUOyhqc1uFLDBvLL4D69+Md5ZWL5ZDiAYzYJ2ieaPI85zx58oXZYJD3S4/uvCkhQnAIEh5tJnrxbJ9y2QbW0X2GGzi02N7pbMeHnz7h+kZ9hx7fr+70B1SdDXbvaNoBE6sEoEQiTGd4hJncx4MwPtf/OjVebrJ5QB/oJVAVOLlXGvmUpGQenANPhBHvzOqvPl5MjpEnTVtP4tnQwMywMSqgxxRr9WyQfvtc9H1LEU45oeRvDwdjMOQeUtJ6OtYjdv3r2Zoi2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	89uHRcFJzg5JRvxgl7FcV9S3Eee7lJFGXgrQojxJSO7oHgpsoP/Ni0o7wpG9BR6IhTaHDf6ATy7CiM2Hu6kaeGSSvmVVD0gtTjw7jjzDzNtvcQ5x0hTTLZPgcl1Af6m/I41cGEs9THKlj5UT1EU3ntUvyoKbEe/IVAvEStmItAa+lxSMqKp60DpIixL0FzWR2bFMJVjiVSZQIvvCWLV1vWafZSZmPnQc5/fDwN6FD5RX7NKG27Jj5PJproJ0/NVaLIrmf9jtGLTWzemFP39RASZBfjCo82WKA9VZqqw6tjsnRAX7GXAkZsC8Izev2g1/KAP60ud/ugoRNFJRzbNBex9ktOINEBvSR38P7AIKYAL/3AUW6FTk26kY7Tt024JqH/GBfluaDkPIcH/rNVLqaBm2a+zyxvEOGdtTiX1kUqgjmt8gwsyt5bAZeYBcARZjSBGdHk1RBQGfFubkX8LU9gl7Ac+MiCBzaUgWPqNAoxdb4AUxiyvS5nqpxWs+uaWmxp10t1g+iGMyX1vthGct1HOhMS6MVrI6HLt7Ov5lKthgainXyiUPtDGd8xNTTXn2ToL9u0X4manzzE/dSLiCEeyPsaSHwv6xAa/TthnNIOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2f47e4-5905-4718-84c0-08de9eb41d61
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:09:16.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34h6rnn/12nc4CLP5fBepO2GUT12H0ohUOuDiz9G9Qmvn0LxFB/CyTbC4lQ0PUgBTtWsBcNLgUEJUzA6um6gkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200077
X-Authority-Analysis: v=2.4 cv=U46iy+ru c=1 sm=1 tr=0 ts=69e5df32 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=iFABrAoMAAAA:20
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=p7JGKH7OCm9RanBsCsIA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:12291
X-Proofpoint-ORIG-GUID: eVFi1t7d3NPq-6GWcQl-9D8Mb-jrp2Z5
X-Proofpoint-GUID: eVFi1t7d3NPq-6GWcQl-9D8Mb-jrp2Z5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA3NyBTYWx0ZWRfX2p8qoG1REXN/
 sxLfWd5txrT43tJRX/rCx4dqsH8ereCulPgZ1tnYA8mqxfaA6lfUS+CKnd+9QPV3MQ24tes3DEg
 256audIslwGVkOgnXR10gapf8uQlXXLQed7fBxrmx9sBTZE8u9ctlml0nty/yh6sGAh4x7W5FAY
 XBbO4DxF4CaR/zavQ7vQ4Hs9PcEJqbDyY+WFoFT6PRmsWcQpPql3pueviEQvddJZzneCWkaX+m4
 jrfcflwyP36jNiID+o7l/4+t8qXpQBqe6hAn7zWdRcl/apjnnPwvcQY6/4QbWj3RZmI2aAx7Odg
 BIF57+wJnIF4gFvVbYwfaOY5Sunw72mvoQTAothYvl0FcqnJJBlsVxlqODRL+dfWCDJOuSB1/w7
 PIl94sOtHdWAn55AcTwgNXuTfVQE3e3ruB24uZbaT3bEOryJWepVoRe6782K5vc6xXk77DgTAXj
 WsN9hipCwYzPQAtoYVrgDAMaHp3SNUSbdJShxtYI=

On 17/04/2026 16:39, bot+bpf-ci@kernel.org wrote:
>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>> index 3b60583f5db2..3f05f17990ad 100644
>> --- a/Documentation/bpf/btf.rst
>> +++ b/Documentation/bpf/btf.rst
>> @@ -97,10 +97,8 @@ Each type contains the following common data::
>>      struct btf_type {
>>          __u32 name_off;
>>          /* "info" bits arrangement
>> -         * bits  0-15: vlen (e.g. # of struct's members)
>> -         * bits 16-23: unused
>> -         * bits 24-28: kind (e.g. int, ptr, array...etc)
>> -         * bits 29-30: unused
>> +         * bits  0-23: vlen (e.g. # of struct's members)
>> +         * bits 24-30: kind (e.g. int, ptr, array...etc)
> 
> Does the kind field documentation accurately match the UAPI implementation?
> The UAPI defines BTF_INFO_KIND as:
> 
>     #define BTF_INFO_KIND(info)     (((info) >> 24) & 0x7f)
> 
> The mask 0x7f is 7 bits, which means kind occupies bits 24-30. This
> documentation shows "bits 24-30" which appears correct.
> 
> However, checking the actual implementation confirms the kind field uses
> only 7 bits (0x7f mask), leaving bit 31 exclusively for kind_flag.
>

maybe I'm misreading this (I've reread it several times) but I think the AI has
misfired here; it's seems be questioning whether the docs match the UAPI change
while at the same time confirming they match the UAPI change. Again I may be
missing something...
 
> 
> Should the documentation have removed the "bits 16-23: unused" description?
> The previous documentation listed bits 16-23 as unused, but after expanding
> vlen to bits 0-23, these bits are now part of vlen. The current bit
> allocation is:
> 
>     - Bits 0-23: vlen (24 bits)
>     - Bits 24-30: kind (7 bits)
>     - Bit 31: kind_flag (1 bit)
> 
> The patch removes the "bits 16-23: unused" line from the struct comment,
> which correctly reflects that these bits are now part of the expanded vlen
> field.
> 
>>           * bit     31: kind_flag, currently used by
>>           *             struct, union, enum, fwd, enum64,
>>           *             decl_tag and type_tag
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24570998051


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79388221726
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771798595; cv=fail; b=MF+CdJN3F8bFjUTibkizzhQHn20UIQp4HqonKCgVXofxhFuuDVZQtEB9nNklh8gpagpb8N8G/yp1HAJJh/UqNuFu7HLuHbTX4nzzBAhWk2zoz6MSCGFFvTL/CkIy4g/MSlx73hG+1OVLvbyf+Xxc9qbV0Sr9HvTrDfsfe7C9i68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771798595; c=relaxed/simple;
	bh=FWAQdYYEazZD+8toe5KDWTh7iyxNCmrV35QvxOcaca4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJSD8IGySr287AynXN+9bQB+AV/t18t9M4x1+FKFq8k1zXE/1g6U3w167L/2YmAQPaaMy9yPgyHdGSGTdlsdTQNjwSk3S791IiKIFez7gWlQuvH1iiGj9E6nO5/h8u4H85BLfPRd5qsItPhhbPkmVvA1OwFF74Xn2sLxsHaYdkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q15NxmKs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBJmklRw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q15NxmKs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBJmklRw"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ML3rpM013117;
	Sun, 22 Feb 2026 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DD0CV1xY5j8cgaq0P2V+efU1P5CsZg+sQ1lTonD7+Dw=; b=
	q15NxmKs3WwOCrPw1kgz1m3bSl/EaXIYSywcubTyzpNPav0eWnr1jkluDThMsr7j
	RbGHOq9jKnO9jzAf6s7bcJ4khdYZ6OJGHzdyUOgw9aIaDV1GFXF6H6v3SdlaARjj
	cMWbFdww7B0goeP7vT/5wblFeuSCfdjy6KYm7dfUqwswnSE+jFqWFcLARn0Q+hzL
	eqk2HNsDEgIlVf9IqgdxIh/Hjj+PEDgDWERC6aU74PKfIZ+dFQjBn6eueT26ivoJ
	EYY9jtj0MZtqLUvl39+3Xw/E0+VRsAamfBUXVLdt9gLWkkUf5ul0/qiR2o8zNr3k
	zJX983Exw3hsEDgWO2MgbQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7s9h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 22:16:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61MFYPNB027804;
	Sun, 22 Feb 2026 22:16:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cp6s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 22:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNq4H/5RUwPbaEg5vS0DHvnj8/IZ91Dyg2TrKt9bZ2O5gNkWaTFBFvjJqjYTN61i2AMbhqqxQvDXc+rpzE9ldyqS7AbG4m8YHganHXrtgUM741sNwov5NTXsQZsEntIc84WVcD4uKtUbWwR/F3fPBnjQspk0gVmDeUsW28G/mcQHp27ufLfZMDS6i9B7zOFlhNQ7vfO7ShuMOvGB4RiiihuQFoRmBdH/5tvttOfeQa3vXPWpCXEqLWRO5+VfI8keO2Lctpm/uXDxtTQYc9AouTqIrGUjj+1JqqXSOzcII8sPzLQ1VXqPhpSpHbp8uAr1I6GB3qZbiUHVcuSAaGoEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD0CV1xY5j8cgaq0P2V+efU1P5CsZg+sQ1lTonD7+Dw=;
 b=Dit0VMjeHEeVaSgVnXFj+SUVvPiDgIDB98zTGUtxfQoc7ye0ob2aT2UuGqB8ksDCoae5as5tZxEYVzvIRMKuGX+RO2ODtNuFP38Z7gEYeL2yPrEV8nqXgVFj+ie7hK+d9rWOcBKotrptDGEsUhGfa02ZNuWC0Nf8UB5y68xF5BgJIQZl4jhmLUt1WTdRa0/W53xPKdCDXXj1pCfBcRGGOjd6Hl3V3XlixPwJ5dx5y1sm0BkwiqLWmyr5pjHbqRKiOLZW3Fl1mZ/OXJ7vMyHhEwOY67xVhdGCyoGXGU6SOYqFzjiSt2KNr3UUaVysQMOFJOtGOXbUzNDqJlJ70WvNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD0CV1xY5j8cgaq0P2V+efU1P5CsZg+sQ1lTonD7+Dw=;
 b=QBJmklRwJP/0w+dYTIZ/gTmDRbY75jXtpPqe9YW6XoE0EtJWXKNofPzCNmzlA3pCBVuUU6BTXGACaaoad2luUksN8peGr9lFDqDP03kjitzSgbNUq0ZiilCJ3cIACNuoyOfh/yEgUGBSv1MpTwvgJs3p/dSa3JbX9B0sTphjTBU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Sun, 22 Feb 2026 22:16:22 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 22:16:21 +0000
Message-ID: <d3607214-c34d-4662-aa23-d99c66fabecc@oracle.com>
Date: Sun, 22 Feb 2026 22:16:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
References: <cover.1771625484.git.josef@toxicpanda.com>
 <d04e23314b04024a61fe295dfd28a0f215a6449b.1771625484.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d04e23314b04024a61fe295dfd28a0f215a6449b.1771625484.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abe4485-5b2d-4f62-3e15-08de72600274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFlLSjRwQndDWmdRRXo1YWZ0NE5vTWVrd3pPZTYwajNneDMwN3V0RWp4YXhk?=
 =?utf-8?B?V2NNZzR4MC9ydmd0YUpkYTZHZmFuWTZVbW9sM0UxTnVla0sxY3NEaklSRGp0?=
 =?utf-8?B?TFo4WVNMZEEyaS9MNkdXSWd3Ymovbyt5RXZib1hSNzdTcjVvUEZRS3puYzlE?=
 =?utf-8?B?Rk1FajRueUhJblNERVZBUGdZcHlUTkJKa2JuNm1yYTBMZGZjYUlTWjZhdzVt?=
 =?utf-8?B?YVZVM05Edi9aYjZ2N0pwbE90SEg2a0U3bXRuOVdsM25NZStEMkQxVlNOZW8w?=
 =?utf-8?B?MFBnWGdUeEJna3ZOT1h6ZGZSekF4RkM2UWFGKzVycGRadGxLSWxEZTNiaWY3?=
 =?utf-8?B?eE9va1NrdEJMeWpOZCt6ZVdPM0FSNzlucTdOVVRHNTZpVVZPOXhLWEtCTjFQ?=
 =?utf-8?B?NEtJMGl1d0R1bG9zdUV3OUJ3cHhCZi9vU2Vya0VjK3VWSUxmd3NMMmh1Njgr?=
 =?utf-8?B?OENyRmVlRXlsLzAyc3VYalNPU0RTMWpUUkFyZml2b0FtVHcydVN5eDdCUHhQ?=
 =?utf-8?B?OVJGSWhVS2VlUmxqalM3TXRHUk1wUkNGdUl6V2RpTHlORFBxaUJXT1NqaFFs?=
 =?utf-8?B?eFFlU0QvUVVsTk5NM3h6ajdmd3RVak9RMnlDNkY5NStwbzBhRWkyQUFPdzRy?=
 =?utf-8?B?MSttbVBqQ2Roc1lJSFBKQUJOZURuUlJoay9Nb3lVN3VsZ3JFNlhtYVFOUlhN?=
 =?utf-8?B?dHBKZVIweW9pNmhsSDIveHRzV256bEFBUWpYWDB5NENBdE9XVVhRMkIxek5Y?=
 =?utf-8?B?cHFxSnN0SHl1L1FsZ2MrRHFJYWhmbXp2UHpvNHpyVVB1Z1piY09SVytkVEpu?=
 =?utf-8?B?bTJ5UENvY3pCdUdaL3RDNHlRVVhnNVJqQW56MWFyenNtaW42NDlhYlZPbUkv?=
 =?utf-8?B?RklQdUlyN0FUZVY1bDZsbk5YL0FoSzE4UDE1U1JLWWdMRlNkUmRUMkw0dlpK?=
 =?utf-8?B?UjZoZ0s5VVIzVkIrcXlGZUxFL291Tkl3MityaGxNM2htQ1FGYVRLMWNZT0pU?=
 =?utf-8?B?VVNNY1V2clBmUnV4OFlXelM4MThsMVZuWXFibE5EcUNMdnlUOFhkNmR4ZTZv?=
 =?utf-8?B?ak81SWV2aHRELzZxT25wQ3RtdFdBWW16Z3JyY3lqYkFuQ1pMRWcwenJGdEFa?=
 =?utf-8?B?bGxrWmU2eUd5NVE2bm1iM0hOM1BkRzU1K25UN0s5aTZ1WUhOQitpZ09PQTZk?=
 =?utf-8?B?MEFtZW9BVnJkM1hsdzNNUHhuQ3FoZWt0bW9KV0wzVUNBWWlCZjluZ0lOOFov?=
 =?utf-8?B?UzUxMitmdjh0UHFOVGpYWjZuOWMzbzhCN1RncGdpWC85SUQ5OHVNZVAvMVlu?=
 =?utf-8?B?eFZZc2NpNnNjMHdabE16WWVlUjhkREw0QWRQZTF3dHl0ZnBMZkJuVnlYa3VO?=
 =?utf-8?B?ajZVNjJqaU1KZkxPcHFpQnNqMzVPKzc4Rk53TGVkdXU4Z2FXMVVqMEJYdGxr?=
 =?utf-8?B?Wjl4WUFpN0NKVzcrdGtrcFFJUmpaYXdpYnlzSnpTOHp5eXo4Szc3WDFEMTZt?=
 =?utf-8?B?a3dqODVtSjR6MFExL05pcG5nSnlvV0VxeHk5czhlOWVlL1M0K0hZeXZjU3lP?=
 =?utf-8?B?NVZPVmR5Uk1WYmVadEhFT2lYalQ1WmpvbFZlYkhrOHJ0eXllTGNja0VQZmt6?=
 =?utf-8?B?bmRFeXlhSXpmbi9pWlB2TFk2TWpZcFhmWWVxQ3plZ3Y2K1k1NFR6Q1dZTTNn?=
 =?utf-8?B?T2lWQlpibzZsWk94NFhPa1lvZlRuOXEyd2wyNThRekhPSzRwWjNRUjJHYTcy?=
 =?utf-8?B?NEFvbUp5RXg0R3M4OUFlSnNSSDhUenpiSU1mMVN5VUpObjBvdUFlaFlsQ2J6?=
 =?utf-8?B?MWNFWnNxNUJxNUJ1bFVwaGdJdWpsM1VsMHRYVWZ4aENZUjI4RU1tdGdKNGtO?=
 =?utf-8?B?Y3IvaUN4VkpRUlpUbjQ2N2R4eC9CVE1YcityR0xQU1BJN01ZNjVzM0dvVDdh?=
 =?utf-8?B?YkpsNGhvdTFWTGhKN0JFT2xzMHlna1diMitZaTROb0tWUnZxMXJWcjFoSG83?=
 =?utf-8?B?TFBnbEZoYzArQnk0TVlxa3VNNHdnZXBTL2NpaDBlK2h2Y3RoUVFpNmdERHly?=
 =?utf-8?B?KzQwU0FFWERhcFlNT0hPZXFRTytiMkhmV1BLRXd3eUJGRTkwK2Z6b3VPYjJw?=
 =?utf-8?Q?LDnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3BnZ3pZZXRhdk1nSTRpNDltOGFhQlN1dFhOY2czZEhhM2VVYnBCQkEwbHZ3?=
 =?utf-8?B?WjhoRWVtcUpnd3lHZzNaNDFnYW1FYlVXQjBzUDkzNXRSTmpsU2NpNEcxMFlz?=
 =?utf-8?B?VXNvaHFsVnEvMjNQOUY4bW1qYVg0d3ZIUEJtZFBVOG9GMXhVK1BoVjc4eXVP?=
 =?utf-8?B?NkFRMXZlQWdQdkM1a3VjR3piNUxFZ1FYRURuM1pmeFVseXBEbGpXL1VLQjhF?=
 =?utf-8?B?TkVBUThHRlpTVTlMWFUyQWlIWHZqbXdQMW54QjRnUTJRd3E0bFVyWTVHVk9O?=
 =?utf-8?B?czlMUk1tYXB6TGxueDNHZmJIZHJBSVBzQlorbzcxTGJPTjBSbjFQNW5KeFpv?=
 =?utf-8?B?NHhEcU5XRktGYi8wa09tdWMvRUJLUStMVGdkaXp4WHUvekxSTVdRKzUrMDhj?=
 =?utf-8?B?cnllQ1poVzFDNWszTmU4eEFIRTlGNy94QnpnY2x2ajgydWIxV2c1TjlBVllQ?=
 =?utf-8?B?VFRoNTBJT3dubGl2U2U2Nkd4c2doZFhzUXJjd0NydFN1UVova2tHcHI1TTZa?=
 =?utf-8?B?cUdBVElGRXlIVk9IWUQrQ0lkVE45MzJ2eVoyZFdlVEFOdU9jbnllSnlJNExJ?=
 =?utf-8?B?elY5YmhwRlh3TUZiKzBqbUVucnZrY3hhMmFMT2VQbGdNKytMTzQ2MmYweUpo?=
 =?utf-8?B?azRoV1BvUlhCNDNFY0pQVmZzZkRMQzMwdWlxRithVWpFRHp4RytZQ0FhcGlk?=
 =?utf-8?B?TnNCTGM1eXF0d3IvV1RGUDY2OTZHaXNaQzJuUFBKYUdPbUFCYk15MGw2QzRO?=
 =?utf-8?B?LzZWaEpuTzFPNllqYVBla0p6SEhjald5WVlHK1lLTGVLeG05UUNsRm9qS3cr?=
 =?utf-8?B?cWJDVWJCWlhDOTJWLzRERGE2Y0xiQnFINjAyUk9DN3NTeWdneWFmUUk2MmVH?=
 =?utf-8?B?dkFrcWJhNEpIK3lzNnZVTDF0dmNhd2ZUam1lVnJGYWZXQ3AxMVJjbmlRMUdN?=
 =?utf-8?B?QTBPUm9HMGRDTU9SV0Y4WUEyZFhOaDZBSHZlWEFiZlRmdGhJRkNaSFJPRWV3?=
 =?utf-8?B?dm5kVkJkbzErRmt0ZElPa2Y4cExLc3FrZGRyazZpeEtsdlFBaDIvcWh3MDk5?=
 =?utf-8?B?L0JPanRITkVqSlhWV2tUS3dYM2I4bUVYNXo5WFlLblNOdnVTN1o2NEp6OGcy?=
 =?utf-8?B?NkEvcDB3VTZCZ2ZDb1dJQmxpaTB6bitVUFo1WFpTMlZ3NTZKK3FCMXpDTThX?=
 =?utf-8?B?Tzh6Z3BZcjE4TjVlUThad20wL3dLUlFHMVZteGVjYTNMckUyN0RCeXd1QXpU?=
 =?utf-8?B?Y3FlaitkcjZsc3ZkQnArUFprdDYwaG9JLzRJUnN3eU13aXRDcGl6RGF4Rmt2?=
 =?utf-8?B?RkxUK3F5TGxYWG5LQmhUNmtDVXQwNWlkSHhoUC9hSXZIaGcvNGJ5QXVPa2tw?=
 =?utf-8?B?OUgybEZhRzhGcVZ1Z1hvT3JUcWdkbnNhWFlPS0FQT1dBNk9oOTg0NE5OeWo3?=
 =?utf-8?B?MEtJVHM1Tldkd3ZINmRtZ1NaWURRMFhTUlNjU1RUdlZSNUIzdDJvWCt2TC81?=
 =?utf-8?B?RnFSMGJXZUtaaTFKUE5oM3FnNC92T0tMWmdscFZTYmthRkVWanQxclVUZTd3?=
 =?utf-8?B?bHBrQ0VmRVQ3WWFNMk1FNXRMaHFyTHdwc2ZyY1VPbXRXM2JXcHAyanNnczJu?=
 =?utf-8?B?WTJENExEZEIyQ1Yxd0MvRHpRSFVlbElQaG1CNGxhRXFQdG42NGRDcjYvei9a?=
 =?utf-8?B?UWIrTCszSGVZOTcxZXltNFFJbzd0bmhvSEtnWDBPeml3SmE3VHU2TkVSYU4x?=
 =?utf-8?B?ZittOWZsL3dYUDBLeFBFdEw4ZDRsdFRVT3NtbXRlTlZ5YUJidzJ2clFKWlRO?=
 =?utf-8?B?WjUwZ1lMcmhPZkxQUHl1bVV4NDl3K0xjRThiSVNmbnN1alVhR2RzRThsN1A3?=
 =?utf-8?B?blo2d1ZnMmluZGxQZUFzcURkYkZ1ZnVUenNvRUpjVHJENmxkRmtQSjg0QUJC?=
 =?utf-8?B?L3hmZUlOOHptbXZIQTNYNGYreVp5aHNLMjlvckJVTlVyeDVwRW5QSzluZHJw?=
 =?utf-8?B?NDVnQXlXL2VJYmNBV2QyTXRrb0duTm8wT3lmTkoza0orVXRjc1c1QW9tT0ZM?=
 =?utf-8?B?U3plYjE3M0MrZTI5MDJqUjk1UXN1NmVKeUp4RDRtM3dVTjR0Z2ZpU1poS3pE?=
 =?utf-8?B?UDJ6MXpwa3dBZHVSanJpMmhBblRMWHUwNU9YYmNoNnk1RUlKK2VXb0ZnWFZR?=
 =?utf-8?B?QnFWNiswT0ZneUZsRSszdzJQcEZ5bGVTNnNvaEp0Y0oxTzR0eDIvSjFDbldu?=
 =?utf-8?B?eHJlRk5jNkNLcTRKR1Yxb0FaTjNtWVRNdjltY1NCcmJUMTBxMDdtNGZLMkx6?=
 =?utf-8?B?SEh2L1hPWUt1bkE3ajk0YXFLbTNNWUtsbzZJTXRKRWh3YkxXTDlOZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UxhgT7FA2DQxN2Ufh/odVKUXIFRRmh7mbIjmbAJ0vU9HUkVYw8ZQ5zafvpeSk/7QwAbX3fHrzdf3OOE3Ak6p9wNBQPQMpp8A8XJmNq4p7rh4BoJFOfPpfJDopg8rAirLRwR6PnoTvk2i4l15ySqUNWzjkXBFu6ABOg7hDCnhVKhP2d4d5u86HvHKTVJBrXf8vEYt1LIw0BbPo0G5EV18cPdtmKfdp7Jnhcil4laYMNTOwA+a/ygu6s4fOzXOu7BIzWj7FY6opZzbyV2KeyaCqp3C0SV8hfzYL5yV9k+Io7LCRQxpE3ozvbS/A1uIX1nKYOw5amxE0XQiYympXa/rbROZ0DLL+u8b+Lkp2xnWIgRS95HOKsKxj4Y9hH+6LhfGhohY4dllCRC5Fi8nnVXJnIBl8elkkJKXC5E2wcg/0c+Wj7f6JD9RQUtzdoa7LmvMTedJJHhW7inQGrQHY0UxcYjtxLwxMdxMtTajCo3p/yaQkA9DNNiWUrTa/twYuJ6dIvor36FFtY7Oaitr4EH0rW0Y6538R2/Ka65sM4KHmF+4fnXypp21czr8GiDqAm6bSA7HXYsA1X5owl3hOI5AdAoiBTFtJAeEjvOcUC4eSzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abe4485-5b2d-4f62-3e15-08de72600274
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 22:16:21.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l713HVScZ/TGOz0//jvxp2wUmXXIXXX/0bfIDVWmLnc6MnYeoARkqHSj2Ce64E5cfp8xGWKQtkSJcn4dpClNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_05,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602220213
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699b803a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=maIFttP_AAAA:8
 a=6gl_cCoBAAAA:8 a=M0PBXxbRZnotQ0dMn7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22 a=Bor9z-CvbNo2M6AZn8_k:22 cc=ntf awl=host:12262
X-Proofpoint-GUID: DxtFMWVhnlEdvkhRdL3vwQly6ljGKxpW
X-Proofpoint-ORIG-GUID: DxtFMWVhnlEdvkhRdL3vwQly6ljGKxpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDIxMyBTYWx0ZWRfX1LmqoHhAHVbj
 3rxTA6CmjWygvpr1mCkmyzcaMfX2hRpuBhY6h2h4YeFsw8sH3Tnw89BLOHa6j1xqYn3TBfo1y8g
 L9aSGxN9jkFDKDUV2ky6BHqvtGtzWRpua4oKOalHndkf1Dk8GTQdKxXrpTzk1mFonCvFMRW6CIK
 xp9fMYy6dyMn9ABpFxcP8km0kkdXgjYi+CYN2YtvBtUe0FKnFeho07hQ/+l88eSDqq2i70ll/xO
 rsjiPPXXMbsgHb4Q2Eu9+GEc3H5nIIs9tE35ni50UmqcW1/Lphv07ao8ulxFpUCX4ZwKFjAEa0v
 +PrhVB5mJYtIa0+Xd1ScOa0OuvUe4oD8yIweg6GDa2Gkfmbd/q1ukHnyQZqGsewuGwTUeig2P+z
 IOIW7VPtnx7RrGTLPdMJ4N5ndFOurqNMYb+7KNRgldhNPgTY2ukq8qMW+gzZ1EJVZNjOkkYkNGS
 VIDyzHLhtlKOsCYPe3JDg9MIiFaD8PbJRMCmdLuo=

On 20/02/2026 22:43, Josef Bacik wrote:
> Add support for specifying multiple file sources in 'bpftool btf dump'
> to generate a single C header containing types from vmlinux plus
> multiple kernel modules:
> 
>   bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 format c
> 
> This is useful for BPF programs that need to access types defined in
> kernel modules. Previously this required a separate bpftool invocation
> for each module, producing separate headers that could not be combined
> due to overlapping vmlinux type definitions.
> 
> The implementation collects all file paths, then for the multi-file
> case creates an empty split BTF on the vmlinux base and iteratively
> merges each module's types into it via btf__add_btf(). The single-file
> code path is preserved exactly to avoid any regression risk.
> 
> Auto-detection of vmlinux as the base BTF from sysfs paths works as
> before. If vmlinux itself appears in the file list it is skipped with
> a warning since its types are already provided by the base.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

neat idea! some suggestions below, and I think needs a Documentation/bpftool-btf.rst
doc update too.

> ---
>  tools/bpf/bpftool/btf.c | 135 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..16bc1332639f 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -28,6 +28,7 @@
>  #define FASTCALL_DECL_TAG	"bpf_fastcall"
>  
>  #define MAX_ROOT_IDS		16
> +#define MAX_BTF_FILES		64
>  
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
> @@ -958,20 +959,127 @@ static int do_dump(int argc, char **argv)
>  		NEXT_ARG();
>  	} else if (is_prefix(src, "file")) {
>  		const char sysfs_prefix[] = "/sys/kernel/btf/";
> +		const char *files[MAX_BTF_FILES];
> +		int nr_files = 0;
>  
> -		if (!base_btf &&
> -		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> -		    strcmp(*argv, sysfs_vmlinux) != 0)
> -			base = get_vmlinux_btf_from_sysfs();
> -
> -		btf = btf__parse_split(*argv, base ?: base_btf);
> -		if (!btf) {
> -			err = -errno;
> -			p_err("failed to load BTF from %s: %s",
> -			      *argv, strerror(errno));
> -			goto done;
> -		}
> +		files[nr_files++] = *argv;
>  		NEXT_ARG();
> +
> +		/* Collect additional file arguments. Use strcmp (exact match)
> +		 * to avoid ambiguity with file paths that are prefixes of
> +		 * "file" (e.g., "./f").
> +		 */
> +		while (argc && strcmp(*argv, "file") == 0) {
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1)) {
> +				err = -EINVAL;
> +				goto done;
> +			}
> +			if (nr_files >= MAX_BTF_FILES) {
> +				p_err("too many BTF files (max %d)",
> +				      MAX_BTF_FILES);
> +				err = -E2BIG;
> +				goto done;
> +			}
> +			files[nr_files++] = *argv;
> +			NEXT_ARG();
> +		}
> +
> +		if (nr_files == 1) {
> +			/* Single file — preserve existing behavior exactly */
> +			if (!base_btf &&
> +			    strncmp(files[0], sysfs_prefix,
> +				    sizeof(sysfs_prefix) - 1) == 0 &&
> +			    strcmp(files[0], sysfs_vmlinux) != 0)
> +				base = get_vmlinux_btf_from_sysfs();
> +

looks to me like you could avoid the repetition here for the base BTF
retrieval to above the "if (nr_files == 1)" check, since it'll only
be done once if nr_files == 1

		vmlinux_base = base_btf;

		/* Auto-detect vmlinux base from sysfs if needed */
		if (!vmlinux_base) {
			for (j = 0; j < nr_files; j++) {
				if (strncmp(files[j], sysfs_prefix,
					    sizeof(sysfs_prefix) - 1) == 0 &&
				    strcmp(files[j], sysfs_vmlinux) != 0) {
					base = get_vmlinux_btf_from_sysfs();
					vmlinux_base = base;
					break;
				}
			}
		}
		
	
> +			btf = btf__parse_split(files[0], base ?: base_btf);
> +			if (!btf) {
> +				err = -errno;
> +				p_err("failed to load BTF from %s: %s",
> +				      files[0], strerror(errno));
> +				goto done;
> +			}
> +		} else {
> +			struct btf *vmlinux_base = base_btf;
> +			struct btf *combined, *mod;
> +			int j, ret;
> +
> +			/* Auto-detect vmlinux base from sysfs if needed */
> +			if (!vmlinux_base) {
> +				for (j = 0; j < nr_files; j++) {
> +					if (strncmp(files[j], sysfs_prefix,
> +						    sizeof(sysfs_prefix) - 1) == 0 &&
> +					    strcmp(files[j], sysfs_vmlinux) != 0) {
> +						base = get_vmlinux_btf_from_sysfs();
> +						vmlinux_base = base;
> +						break;
> +					}
> +				}
> +			}
> +			if (!vmlinux_base) {
> +				p_err("base BTF is required when merging multiple BTF files; use -B/--base-btf or use sysfs paths");
> +				err = -EINVAL;
> +				goto done;
> +			}
> +
> +			/* Filter out vmlinux from the file list */
> +			for (j = 0; j < nr_files; j++) {
> +				if (strcmp(files[j], sysfs_vmlinux) == 0) {
> +					p_info("skipping %s (already loaded as base)",
> +					       sysfs_vmlinux);
> +					memmove(&files[j], &files[j + 1],
> +						(nr_files - j - 1) * sizeof(files[0]));
> +					nr_files--;
> +					j--;
> +				}
> +			}

would it be simpler to filter this above at collection time?

> +			if (nr_files == 0) {
> +				p_err("no module BTF files to merge (all paths were vmlinux)");
> +				err = -EINVAL;
> +				goto done;
> +			}
> +
> +			combined = btf__new_empty_split(vmlinux_base);
> +			if (!combined) {
> +				err = -errno;
> +				p_err("failed to create combined BTF: %s",
> +				      strerror(-err));
> +				goto done;
> +			}
> +
> +			for (j = 0; j < nr_files; j++) {
> +				mod = btf__parse_split(files[j], vmlinux_base);
> +				if (!mod) {
> +					err = -errno;
> +					p_err("failed to load BTF from %s: %s",
> +					      files[j], strerror(-err));
> +					btf__free(combined);
> +					goto done;
> +				}
> +
> +				ret = btf__add_btf(combined, mod);
> +				btf__free(mod);
> +				if (ret < 0) {
> +					p_err("failed to merge BTF from %s: %s",
> +					      files[j], strerror(-ret));
> +					btf__free(combined);
> +					err = ret;
> +					goto done;
> +				}
> +			}
> +
> +			ret = btf__dedup(combined, NULL);
> +			if (ret) {
> +				p_err("failed to dedup combined BTF: %s",
> +				      strerror(-ret));
> +				btf__free(combined);
> +				err = ret;
> +				goto done;
> +			}
> +
> +			btf = combined;> +		}
>  	} else {
>  		err = -1;
>  		p_err("unrecognized BTF source specifier: '%s'", src);
> @@ -1445,7 +1553,8 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
> -		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> +		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] |\n"
> +		"                    file FILE [file FILE]... }\n"
>  		"       FORMAT  := { raw | c [unsorted] }\n"
>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"


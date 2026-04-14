Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD52BD11;
	Tue, 14 Apr 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776195206; cv=fail; b=nzP6qHXCIrgI/r7VJm8SRuQMw6SKK5vYPW0GezKMtpGAo3ug/Pw5nI/JsiTwkPaKJyzVAyaIL/ZSHwTHPyGYy49e7WDKe6J1WS9x2vO8ySLHALF9Dq4bF2/EgRxmcecGGODh5RdRydGYuEeFcHdODkJzAeZvQfNQltNrUNSLKJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776195206; c=relaxed/simple;
	bh=OXB3G5O64GkB7nVHN5n3sMS78ryPK+XCrsPTzt4eEGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=miEyvyCodA6G12h44WfA6J9Athm9WrSQoF6TpqGvUEZLwNxFBcJNJ7ZMxhlr1pwCXf8GZsmnOGVPRBdgHhhzslPI1Iw9qaTy+GzfoL1JPbGuxI6vE0iImZjkFjnwPNMsKmAwi3nnaHbOaYCyM4wbkmRO0RPCi4VgvbOrDQaTx3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WhxSqsdO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Su3mYflJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhxSqsdO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Su3mYflJ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EIhj1b3230154;
	Tue, 14 Apr 2026 19:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vyWFr6hi6QRC4VFhZO3bZg06H5T7k7Iw5v9RrleiBow=; b=
	WhxSqsdOlRkZThyOa1Rf1AkrcggGOgjd5OGH1mf7KmZnUlmVmmU5Jx9GyosHE0Am
	zoSRGMk0aWkYtT8hJkWJrwWEUcQ7xABv0vpwCxqCiDWC9WITraaFql6nKoq7Jq/x
	FRfWv4vorwT1O1vk84wjZlY9gd4TfVV+avrJXFbH3ddwUvHFGAtC+gdEOKST/N2s
	/lmiSn4k8swsJmM6Ao+4oLppVw0Rg4KUNwUgllNjEdSOUzJHkUpankJjwiZLhS6A
	zPsGoSToQRPnHTZQfelJhI9mazBxlerIIt9FgFTwmhuT9s9UQSuB2u9IYoEW6Q2g
	ekR+qm2YxsqPjIGszoKumQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh867brh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:33:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJTPLT036720;
	Tue, 14 Apr 2026 19:33:03 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nmxh23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:33:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfhRiRgd6uI0+aQ9ancOcviik/uDMAa0bXxQ8Co7f+FGg2zfQMxW08XJrZb31RLLBro+kqr+xtWKxYlR3Ve4jA2oQIASoagPYEaL90LULdk4o01sldpCK3BruomswCsxJiyLSRrqFrTZhPZGxkoSi/soopznm85XvK91+tqWl65acP1IH0B71UVbxWAV3HYAyRuMmmaH+zRx1pygznee+/raz1nmCCQmoZMXl2pDtEXiXGLwpKEDRbfaiKtbqSuxxMmj1aiTLWQRRSosR7DEU8drqHn9Yaqi1wmrYFMNgNcXe+U9TQ9RrO1K93ETDYfTTL5IXNNtyJl8HxRcCNBoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyWFr6hi6QRC4VFhZO3bZg06H5T7k7Iw5v9RrleiBow=;
 b=mrM0RMv2n5q9koM/e/hWqngo+EomN59rH6ZE9v85MG1gz1j1iThajrVpWa06uwoQVXTUHaT6ZtBayIs/NkAvEKBdGQUkipYrdoRRmeC/Z/yinPPtluGupCDxHrbSU2/kJ5RR2WfhBQs41DRXPwr6UMR4AtgmgLtR3R7IEXauqX536+Mr1PYN54+T63tdv7Uj7oinewB4/fwv+w2MLlu0JvmpewtzAYhbPPqIGhRzr0iiInFqoLIVkWdib/Xr9ov5cb6b3r2kWyO5OxmG07UUjXgvfYHkCUHRiDOAThFtfG+mSge6A1aQGi7qVunWZK0Bh7eAkrnkcJIeE57C9PDn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyWFr6hi6QRC4VFhZO3bZg06H5T7k7Iw5v9RrleiBow=;
 b=Su3mYflJWTOT6eCNBhOXcTSSJDoYC8+9TJeJH116avJlP8RnPSEX7n0ZxoqAuu1nzkNOVu/u/bhDRNCd3jQR2W2OZyoajL5NVdbslUD2EABi46Ye4aKw1MW8U9ZReELpkhzZKG6kjrGewyeqiqkzA9bQ/jB2kpYgbXE9Vwx2ang=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 19:32:57 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 19:32:57 +0000
Message-ID: <b22ab3f4-6da7-4009-92b7-aa5f934c4f5b@oracle.com>
Date: Tue, 14 Apr 2026 20:32:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
To: Paul Chaignon <paul.chaignon@gmail.com>,
        Yihan Ding <dingyihan@uniontech.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@uniontech.com
References: <20260414014001.814324-1-dingyihan@uniontech.com>
 <ad5ciqi7KAq0C9A3@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ad5ciqi7KAq0C9A3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH2PR10MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ed4536-2307-4c34-67da-08de9a5ca1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11006099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uaJH2GzJ5C9zVVedrmwPG9R88DLO/PA7mkc8odWpzl97K52LxwgfK6JyitJiryVZZQy+l/X0G49W/1dhfDC0fzECV2N7yPmfvqUlApb/HPOSIWEVpgjADcklIsRggVURxpIVotXx4GXysRv5kRwCDLzeCsWX257NEqHZ7NFPtUDdFkuFA4JCv41We4Ie43Ljc6EBWbypj5J1Sr613CO0TxQWh3fiiMQWOTnFT5x/3tJ9kXZsjTbQXCGrXaFkbfpczYXR7Y7yrJRd1vIzLdKe4DF+7/7bwFa2Pv1yac2Q4OrPLb6cSBo7GBAqEr5HRekGeBOOs+FGKa13AiYjmGrP9Kh5JptTpNT7w0QknYH9//4ZIlgadz7gXUdqgmsP5bArvgi4TEWFiZod6uogNEI5DpQ8YwingZHW6ibL9QzNfVvLV2us+5/bBApPW/o2D5gAL3C3Xa4qDu8TT1NeIM2VCffB1WvoFtYuSItNXwc7BA7vny43SDCGYGFOiMlciOO9f0RgdhUcuxoUGtwCSP2zGUAMRQaSvZmdgJUz3oY+/kmD1RUhmOZutYNHLsCRsfgxYEoXF3eThFtN6kMzEIkHQbE08TXjEiSqb3hT8HHuCrKbdA+1uekUorUTWKiyLlnIQvGIDQR5VwkSvu2vUQfq/Mr0BXGdIJdcDSzgTl0QM7dy5ZoDuql/naYGkH9sqS2BKj/66AK/6GuigPo0N1Jcdmw948kaqtWr7xPC2Sl1hTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11006099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkxLS29RT3kxaEVJNU9VQjNDUU84cjVUVWNsVGNJQldLM2pHK1JaWms5SmVh?=
 =?utf-8?B?SkRXcUR5cVBsd2hYWkRpNG5XN0JoZkxVaWYrWG5NWXAyblhtdGorcUg2NHFu?=
 =?utf-8?B?RnVEOWRsbGZDZVNSU3JLYXJmOWJMRzJWV3MxK0FieUZ0WDRYNWY1RldnNWVM?=
 =?utf-8?B?NWtEYXZvUkJiU3l3LzMzWFBleTA3MFFhVXlBeGVMWlhJMmpucXpiNk8wVWVk?=
 =?utf-8?B?T3NRZVZjMXZ5UTBoMmNiRzgxYzNVQ0JJR2ZxZ0lHSFpUY3BiWGpBSXJKZWpz?=
 =?utf-8?B?MzRNSjZZTmhGV2hoeVpldUpuWTFjeVBmaUdVRzE3dEw4KzFhT1BsZzFhV0Zq?=
 =?utf-8?B?NVk1Z2xjZ2lGS3RsaTRMb1hBWlZ5RUQ3Unk5akl3U1Y4aEYrcHJoeHZhTHY1?=
 =?utf-8?B?Y002WDJ0UUcrTVBMSGtER0R3cXg2ZUJlbnE5WjlpRzhDQkw1QU5Vd1lFaWVl?=
 =?utf-8?B?NXRaVlVhaTg4aG9pU2ZTcHhOZXloMjVYcTBvdjN1QVNwWk5xMytuZkN5Smpz?=
 =?utf-8?B?cGQ4L3czN0p5V1JkUm9xRG1Jd1lENmdQR2NZbU5xa2dWMHFPYk44YldyNXFu?=
 =?utf-8?B?dmRjd01wQ09IWStwZkVLRkUwUWNaNWVJOG9hOFplYU9vcGo5M0RoRGdvajI2?=
 =?utf-8?B?VGxQT1VUMzRuYVNLUElqcUVFYTVwY2wwN1dWeUt1OWptRXJNN0czdTNqb2Y4?=
 =?utf-8?B?UzdLUzdZVUpnQ2dNRFg3LzFiUkVJdlNSbkNybjFXbXBoNVJtV3hLRXEveWdi?=
 =?utf-8?B?bGk3bWtqTXhZRDkyNURiSlh2NDIvZWFZVHYwdCtnVVhibGdXTEN5MjE5MWhV?=
 =?utf-8?B?YmJuSkhOWnlUSVNqUCtpUFBkZllWbzV5MWNtRThmd0U5Q2ZRaFYyY0Z4czBl?=
 =?utf-8?B?emcwcmV6K256aEF6RkpwYzhieWFRMjV1dkRiVmhDVVlpZ2d5cC9HWXo3QzY4?=
 =?utf-8?B?WTdIMEdTUzFFaWQvVHE3TzNIUXBFRUdLVk9VdGhNV3hvNlRxbkdpOGkwaFk1?=
 =?utf-8?B?aW51U05LTWxkbTNOMG52amwyWmFoUEgwR1BHSnhkMGt3dHExMFN3bHhoamNW?=
 =?utf-8?B?SVdvbVlFaVpxVVc2UU5qbzNKbHo5OE40ZmlMQ21wZk1WT0hqcFVacnFPZUxE?=
 =?utf-8?B?UWVGRXpITSs3WlYrTS9qai9PdHZ4ckdHWEVpM3V2Z0xRZG4wbW0xVm94dFgx?=
 =?utf-8?B?NUFoVmxIOHZ4RFJPT2lqVjd6RjJKR0d4VWNEUFF1SmF2cmRVc3R5NlNpWFp1?=
 =?utf-8?B?c3FXSlh6Q1pKeTNLcDlqbjltWjNjZkFaYXFkY3JWcmV5dER2OWZHRlJiNlRX?=
 =?utf-8?B?REVaN1BFNXN3R1h6Uk5mOFJ0eGxxb204WEhPdHRtd1BmZ0ljWTBaUXlnNGI3?=
 =?utf-8?B?c3JnSytMVG42YTNzTnY1ZkR4WGdCNktiWWdKaXVjUWc3TjZwczNWY2FvQ2NJ?=
 =?utf-8?B?Z3BxaDJhRW00akdHbGx6QVVHRGNFcmdmc09mSnphVmllZFh3eStkZVNRTVA2?=
 =?utf-8?B?UmlmQmpXTkxzZHpDb0Nua1NvTk5TMm5EWEhuRmMvNnlVS3pCdDJqRExJdzZv?=
 =?utf-8?B?OGV1YWFuUEtOdFJvTklZWnk5djZqNzdrUFJ0di96UXZGcTRYTGtOaytnM1ha?=
 =?utf-8?B?cWE0VmtHdHNvZE5nclptV1k5RVlFR0YvSUpMaVp3YzNXWWx2UFdMYVowY29h?=
 =?utf-8?B?UnpycWd2NERiMDZPWmR4WldBWWMwYjBsbS9PVWpjRHNITi95emw5ZGo1NHJv?=
 =?utf-8?B?SFl2UFgrbjRtUU9jK0NSU3ZNZVlpY0xqMVpFZmZuSnZqSU5POGpLd2NCcjhw?=
 =?utf-8?B?dVVoYldOQ2VEbTNtYlhEMHkycmdXL0VoakRWaE1Xbzk3Wlo4YkRod2hGUW84?=
 =?utf-8?B?V0UxSFBzUVpXdTlFL3hKMThYc0NBZWJtKy82QTZUbFR5aG0yV2F6cStPb1NL?=
 =?utf-8?B?SmRyNDQwVGtaL3FINk9JQ3VaUmJLOW9RVUc4R1RMaFZNQlRxNkJTK2c3MEZH?=
 =?utf-8?B?U01iQzYydEJaeEF4eCtIRnpad2l1OXlwMnVEdlNNN3NaWHI2TkR3ZlBaeC9P?=
 =?utf-8?B?UWxWNkRmSjZBNWVFdnJGd21vZGxjckoyVGg3MmVjYStCUmh2dVk3REVYeFh1?=
 =?utf-8?B?ZG9aWHFHb2UzZjQrejM0TVN2d1BqWHV0Wm4xSWtPek9CSDhibStzVWptMVd3?=
 =?utf-8?B?ODJSZkt6RUlaTlR0ZFZ6aXFsNVhObFlKRXdPUURmSk5oMVJFU3VmWVp4aVF6?=
 =?utf-8?B?WEROb2IydENjWWI4Um5IMkNYaHIwQzFiME8wK0IyVTlsZFVWNTU4cUxuZnNk?=
 =?utf-8?B?SGtVcEVTYWIxV0x6STRrVkRmUFAyQ3lxNVRuWGx5cEttZnIwVkc0dz09?=
X-Exchange-RoutingPolicyChecked:
	tKe7gm9HDlW5JAaXOyTOzFq6XqADQCpgc65rydbV8TbOY8CT1qF3uwzc2kb11qsnMQifZPZlkxJTFnga74mfoB0gapEGlmzTYSKMLp2/omDq3hnAkkUAbIZ95HfdEz7E6SowZnX60ziSCChD+QWGdq1QErShpWsGdXl1MSzwCrfSIPS0u4bHLSJLSXjfjzvHvaoe2atmhc9rdHzZ5VWYXrbwB9DbYmI8MrvGk85PBDQuwmk2YdMMT6c8UmAIavUg/n3cgQrAKvjSfJ8Se8it88ybQxPDt/LvX+8DBanPWNRMGbe2d8UDXav3UiR2g6+TWXKAIhNu1AEpdVhel7UwXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Gs+cF4KyDJiQCwSQnd8NkKEj8clO/hP9gqf9D+Yp9pB1OhYo5AfFVmbpCqt/c680qrR/8Y/c5X4REdbpmOpG8Z6fuW40HWtci+l/ZdnSgHxjbilGywZlzpDvnb+WN/bHIGs6IJyyDDw7Y6NermXhkPUyLqRTqxGRKfZd67ed8adBkyU3i9L91fu+LCtEdQ3XR8zhp/MildFNK7JdtHaWY6Ttexzpk5q0MNQ68Er0mgSdwntdUjf1t268knmRKvjAktOr+JsbFRiai+QY1OcSyXwTaTL+EpBELUuinBSUiavnMuC9yK2URUgHYGCqJGEwi+afDqx/uzd+vjdIiYcQMP54lOqxHUaQfqUBNUWQMMImcIohPnE1EaJy6EvyyFBI/UVN+RgMs4Im1JtM5/c4qbV4J31nIyO30rv/TwgsFrvAZolSzuWkZUQbiqUPPverIhWj/slm9ojYjhKwuee8JNyyFatSjiYYVObST/NXA+V/JP26osg7evcOcbuE6wV2zXxvyGhHIvQ5yPOLpx646lJ4f8fAAvTxDAZM65WD+McvQMQClA2l1U8GSuzakzvFF9YdmfranreM5fXq3O3Hb6uXD97YdqKwT6tcxRUI8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ed4536-2307-4c34-67da-08de9a5ca1aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:32:57.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WPPrbsxddVPCkqRebTLrdU+HH1z6tSmG0iCvt69O1VHSOqikpwVmyICaIL+BmsTDdqZUxXNQT0jOYV171aUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604140182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4MiBTYWx0ZWRfX1EpyPlcuRrKI
 ufI/Ztc+mBNtQmGlKbZZDYW0eOf63Xc0997YLQBrmrxyOEn/qdI1jkKoSXry03/GeZLmazmPQ33
 XlGil9QiW7DLeiuuF4Gz5avVo9GtTPL4MxneQ+FOVmhHuh3oIojvSWHWP81lX2qbiZyVFock2JG
 Sq7ob7MDWOwiuJJWM3n40iBBXV1r7sISoz97M1ba4LDLZO5OMKX2vTAIpspggwhSRQYIL0ZnrXv
 an8b+NFk86cPMRVDt0jodYTXqYmwaCt+TAOzdN7VFUS26gOFFl96LmMTjGWGCgynylyTFjwUiMc
 03aqQBb6TOfg+jEAwqnk+kFnR/MNECkpFGax5wSa5aLtIBBCAvdMk2TqbEIqu4QRCQHSEykyY7Z
 tmaavDwF4RVPrBRXbWb4s6VeyCrv+lrJ8EyOxKJUHsRUxCgTPluW+H0M8sy82buoANzefWLvC+N
 aJ+B3F/Zhvf1dP1ci2rz5iix3UDA3b9hjYbcOp/w=
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=69de966f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=iHwBjlyiAAAA:8
 a=3B7FWbXHedw8BwKPpVsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uNSKXYNwxGiU6LD0JREI:22 cc=ntf awl=host:12291
X-Proofpoint-GUID: 8tlkScSvvH_OJfKtKD4jH_QZIWbd1vAN
X-Proofpoint-ORIG-GUID: 8tlkScSvvH_OJfKtKD4jH_QZIWbd1vAN

On 14/04/2026 16:26, Paul Chaignon wrote:
> On Tue, Apr 14, 2026 at 09:40:01AM +0800, Yihan Ding wrote:
>> bpf_bprintf_prepare() currently rejects any non-ASCII byte in the format
>> string, such as UTF-8 Chinese text.
>>
>> All BPF formatted output helpers that go through bpf_bprintf_prepare(),
>> such as bpf_trace_printk(), bpf_seq_printf() and bpf_snprintf(), only
>> need ASCII parsing for conversion specifiers. Plain text does not need
>> that restriction, but today any byte >= 0x80 makes the format fail
>> validation.
>>
>> As a result, UTF-8 text literals are rejected even when they are not part
>> of a format specifier. In practice, an ASCII-only bpf_trace_printk()
>> format works, while the same format with UTF-8 literal text produces no
>> trace output.
>>
>> Allow non-ASCII bytes in plain text while keeping the existing control
>> character checks and keeping format specifiers ASCII-only. This preserves
>> the current parsing rules for '%' sequences and allows valid UTF-8 text
>> to be emitted.
> 
> Nice! I can finally print proper French from BPF :)
> 
>>
>> Extend the trace_printk selftest accordingly by emitting both ASCII and
>> UTF-8 strings and verifying that both appear in the trace output.
>>
>> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
>> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> 
> Not sure if this should go to bpf or bpf-next. I'll let the maintainers
> decide.
> 
>> ---
>> Testing:
>> - Reproduced on x86_64 without this patch: ASCII trace output works, while
>>    UTF-8 literal text in bpf_trace_printk() is rejected and produces no trace
>>    output.
>> - Verified with tools/testing/selftests/bpf: ./test_progs -t trace_printk
>>
>>  kernel/bpf/helpers.c                          | 21 +++++++++++++-----
>>  .../selftests/bpf/prog_tests/trace_printk.c   | 22 ++++++++++++++-----
>>  .../selftests/bpf/progs/trace_printk.c        |  5 +++++
>>  3 files changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6eb6c82ed2ee..e2f103297e4a 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>>  		data->buf = buffers->buf;
>>  
>>  	for (i = 0; i < fmt_size; i++) {
>> -		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
>> +		unsigned char c = fmt[i];
>> +
>> +		/*
>> +		 * Permit non-ASCII bytes in plain text so UTF-8 messages can be
>> +		 * emitted, while keeping format specifiers ASCII-only.
>> +		 */
>> +		if (isascii(c) && !isprint(c) && !isspace(c)) {
>>  			err = -EINVAL;
>>  			goto out;
>>  		}
>> @@ -867,6 +873,10 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>>  		 * always access fmt[i + 1], in the worst case it will be a 0
>>  		 */
>>  		i++;
>> +		if (!isascii((unsigned char)fmt[i])) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>>  
>>  		/* skip optional "[0 +-][num]" width formatting field */
>>  		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
>> @@ -881,8 +891,9 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>>  		if (fmt[i] == 'p') {
>>  			sizeof_cur_arg = sizeof(long);
>>  
>> -			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
>> -			    ispunct(fmt[i + 1])) {
>> +			if (fmt[i + 1] == 0 ||
>> +			    isspace((unsigned char)fmt[i + 1]) ||
>> +			    ispunct((unsigned char)fmt[i + 1])) {
> 
> Why is this change needed? isspace and ispunct already cast to unsigned
> char.
> 
>>  				if (tmp_buf)
>>  					cur_arg = raw_args[num_spec];
>>  				goto nocopy_fmt;
>> @@ -958,8 +969,8 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>>  			fmt_ptype = fmt[i];
>>  fmt_str:
>>  			if (fmt[i + 1] != 0 &&
>> -			    !isspace(fmt[i + 1]) &&
>> -			    !ispunct(fmt[i + 1])) {
>> +			    !isspace((unsigned char)fmt[i + 1]) &&
>> +			    !ispunct((unsigned char)fmt[i + 1])) {
> 
> Same here.
> 
>>  				err = -EINVAL;
>>  				goto out;
>>  			}
>> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
>> index e56e88596d64..f7b03dc4eaf4 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
>> @@ -6,18 +6,21 @@
>>  #include "trace_printk.lskel.h"
>>  
>>  #define SEARCHMSG	"testing,testing"
>> +#define SEARCHMSG_UTF8	"中文,测试"
>>  
>>  static void trace_pipe_cb(const char *str, void *data)
>>  {
>>  	if (strstr(str, SEARCHMSG) != NULL)
>> -		(*(int *)data)++;
>> +		((int *)data)[0]++;
>> +	if (strstr(str, SEARCHMSG_UTF8) != NULL)
>> +		((int *)data)[1]++;
>>  }
>>  
>>  void serial_test_trace_printk(void)
>>  {
>>  	struct trace_printk_lskel__bss *bss;
>>  	struct trace_printk_lskel *skel;
>> -	int err = 0, found = 0;
>> +	int err = 0, found[2] = {};
>>  
>>  	skel = trace_printk_lskel__open();
>>  	if (!ASSERT_OK_PTR(skel, "trace_printk__open"))
>> @@ -46,11 +49,20 @@ void serial_test_trace_printk(void)
>>  	if (!ASSERT_GT(bss->trace_printk_ret, 0, "bss->trace_printk_ret"))
>>  		goto cleanup;
>>  
>> -	/* verify our search string is in the trace buffer */
>> -	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
>> +	if (!ASSERT_GT(bss->trace_printk_utf8_ran, 0, "bss->trace_printk_utf8_ran"))
>> +		goto cleanup;
>> +
>> +	if (!ASSERT_GT(bss->trace_printk_utf8_ret, 0, "bss->trace_printk_utf8_ret"))
>> +		goto cleanup;
>> +
>> +	/* verify our search strings are in the trace buffer */
>> +	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, found, 1000),
>>  		 "read_trace_pipe_iter");
>>  
>> -	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
>> +	if (!ASSERT_EQ(found[0], bss->trace_printk_ran, "found"))
>> +		goto cleanup;
>> +
>> +	if (!ASSERT_EQ(found[1], bss->trace_printk_utf8_ran, "found_utf8"))
>>  		goto cleanup;
>>  
>>  cleanup:
>> diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
>> index 6695478c2b25..97afe8b149b0 100644
>> --- a/tools/testing/selftests/bpf/progs/trace_printk.c
>> +++ b/tools/testing/selftests/bpf/progs/trace_printk.c
>> @@ -10,13 +10,18 @@ char _license[] SEC("license") = "GPL";
>>  
>>  int trace_printk_ret = 0;
>>  int trace_printk_ran = 0;
>> +int trace_printk_utf8_ret = 0;
>> +int trace_printk_utf8_ran = 0;
>>  
>> -const char fmt[] = "Testing,testing %d\n";
>> +static const char fmt[] = "Testing,testing %d\n";
>> +static const char utf8_fmt[] = "中文,测试 %d\n";
> 
> The build is failing because you made these static.
> 
>>  
>>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>  int sys_enter(void *ctx)
>>  {
>>  	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
>>  					    ++trace_printk_ran);
>> +	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
>> +						 ++trace_printk_utf8_ran);
>>  	return 0;
>>  }
> > Please put the selftest coverage extensions in a second patch.
>

+1; might also be worth adding a negative test that ensures failure when
using a UTF-8 character as format specifier.
 
> pw-bot: cr
> 
>> -- 
>> 2.20.1
>>
> 


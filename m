Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828F1BC46
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244154; cv=fail; b=ZdP1DDzbkteefxDRNZ7ji08cpvAn0rkoEJGWgiZW5NXr1BuF1H38NdRcxy6riOZ5QvFAd7UcSxLU75Y/uNgu3WnJVchYCL5NloXf9WVD92N2WkbrZdhqbfFnfVnovfGEywDAWBrm49gzRK0RpU8gqqRVRQfoqmcPjjmwNZJKzRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244154; c=relaxed/simple;
	bh=ffiF+S36rjBevvezuTSe1QURk87fpz/cG0sP7hB+PJI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=su89LT98kMR/Bb5QnMwy3zDlaMF9gZPUXdx1ttDm43sXZ0jMPaN3liZfgkg6Yu6L5uy9hKJaVY1B1JmIPjrtMbF5gwt6ZDkT5gI1ZKrbl75x3L9qaqx9AhG1ClsOTUllD4Ovrjewigc8oJbEf84oI0I1Hi4cB7CAGAR9dVccVU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eb38gwbf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tk3C+AAO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eb38gwbf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tk3C+AAO"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434CPaCw027155;
	Thu, 4 Apr 2024 15:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aj06Inu+NWO2ABg/db8OcKKr3pckcjQCKCAE3Ztju/I=;
 b=eb38gwbfWMuqRUosrrHQBCKeROVAiTnspgaOwjickxyWDmmZNRzq+mTxyZ8ObHvpyW/1
 5UjhqFQVKxsgUsY5qyiimMB3jn1bq0ndVyUGZB/OcgndzGP1zRlM4VRQXs2od5wtn9XV
 f1v+WQgYw/x04oh5WI7Ft0Rr54qlZ1rOCBfTX7qCrZQlokac0i8saeyUP9oIHogdM1EI
 DlzGKw81c3tu37JczalAOsbuKkCH0k0IRd6Mz90GdPIrdxANs5xzT71pPq90Y9HZXbKW
 I/kYoiMyXZmD6Ov4iz810dwg9Lu9E2pg4k+rSD0P7KzTxfyg/2d9jPOgbd6RGU/jWGAR Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9en0hgfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 15:22:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 434EedEn009342;
	Thu, 4 Apr 2024 15:22:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emkux54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 15:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGV1zneE8eNh8N/SGJFdttNzJS2yZsSpIz1seK9v51EGUQJyqMvWxpBbfpk2UlwmDMDalYe7HixZh/UVHyMcDvMMMsWxC8pQMtJKL468NtjXuI0APe46gzv9D+0amQiPwTMxhUMKzoYRMfq0TEnS9NLbMs3KwykvecP1AF5txz/ipaCaIN/JayxoBB+JaUO+YO9qxilfdeMb2DVZWjGlsKWMNGtDhvi+rFFLwDcSsvCaLRfc0ca/it1RQioKeqqW+cjOs0AAeSH58YQbQrQtKcUXcL7urnKuFexUxyUl41mZMr3oEH6/dTlcyBhocYqAN7wnWvhCbrUUcsIC4YmHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj06Inu+NWO2ABg/db8OcKKr3pckcjQCKCAE3Ztju/I=;
 b=OtYX2BXZ2w6MTG9A69Vv5latF6+0aNCeYZN/potqqlP8m3wnEBQh+kaSGtFLDhrhqBII7N/tIZAUC+xoS+gXLPApqyxB+KsVntoBvKuybcPF/as6t+Gzi6gqeMzk+xKHp92Q9DJx/ogWTRX36BsItMQ+8rg2X/c1ttGsBO/a/1v3Ct7EW9Xq/rc87s39ztmswKEhbbWdjNqBGjRG10cdG4ogckf41DRkNPwAQNtzODnKPKAEFN89ExoBEBNnM1qNXK0aDrtY3ZasnyAeViWwZCuBWeYRaa2hFo0edtW25C1SARg0QNWLNeKtWkqI2nbZRohW3lzvpZJ2tsgkuArFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj06Inu+NWO2ABg/db8OcKKr3pckcjQCKCAE3Ztju/I=;
 b=tk3C+AAOqQbFBxfXNIsQA2ZMoFmW7CqXKM6fGzS99tAV2ZT/tB9CWOvBFJmDO6pbqwVckJetBoOqHqp2uZAC/c1fPsj1HJ0GspBVxU0+EHm/1LCHnbFi3bysenCe6j7OUrv9HcYqIDC3lIUlBVfhW3ETvbhWYlbmGND7DsB7fF0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB7690.namprd10.prod.outlook.com (2603:10b6:a03:51a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:22:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:22:00 +0000
Message-ID: <fc2a18b6-ea8c-4672-b5c2-05224a9a8adc@oracle.com>
Date: Thu, 4 Apr 2024 16:21:55 +0100
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [RFC bpf-next 02/13] libbpf: add btf__new_split_base_ref()
 creating split BTF with reference base BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-4-alan.maguire@oracle.com>
 <CAEf4BzZ-rezyjmsR2CJdZMbY0LUzp0KBOV1oVfXVDpXgyWMAYg@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4BzZ-rezyjmsR2CJdZMbY0LUzp0KBOV1oVfXVDpXgyWMAYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB7690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zaxqAl3Wc+wZO23ikaETxjwG+jI+/6WRfZbFJx7ZJNEw1nMWjbmBbeyV/rJFHC5IwDYiUaUb56CU4JO+osUWsMopuWv8RskDvoDBrLuRfd3KDoKLTmDIPY1vL6L7AoCGg70tnCl1owBK3s9iBvynG05tbQawlauss1Dz356z//+OJH7Nkt/28vgk2iyfEPXQHY3gcq8cFkox+umoNEwBxCqGrUwjwYej7kC2MLhSVQUkIR7+7bzc1L4TYhnqLAVMUh5Fz70MAitrPmho8e0JLcduETQbfsYhczn6DsDmiuY2SxaT9+iHwuWRPVj6X4z4aultbK1BkHLh4QiJvdIBbn/B3cBHuOkpvR0spUIdi5vXRaYw8l7QDYYCeRZ4i2ghJUPXZ4Y9d6MfBfCD2JRT0GZYX29fjd/NyLAr6uDUqML26HN5q5Tkm/jSIu94uY+TDcoxwIMs9QMTYZgucNCwCss7BFbVJ6RvWCjCKrTee4RQQ/hkfg+FRqR5RdsrQ6q7k5cowCxsSkslGabGm8dJJhLPaGwrCLy8c+X+/IiEYvan3kXif5g+ZAijw28jbEiMbsw29MfYd7JGbehqRt3cVw9HC7M/XAEt6AY5r/qdb2PVlH9bkJYzCgzv3a6mWn/QR3NWUZfLmwR0X1eN6rPbo4ry1K7veQFzeqr+QM4ORDQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0NqRkVQZ1QvZ2hYcWI0elBMOENDQ2FpYSsxUUNPaHh6NjBXNDlPRUVGbVd4?=
 =?utf-8?B?clEvSHM4ZXdYbHowcEJNNEU5SFFONmhiV29QcisrQ2NKQWxxYUVxREtKV1FM?=
 =?utf-8?B?UEVKdDMzcmJUT3FUNnJSQXFrNHVXcWJ2bTJaTklIZXdzZk9NcnZGOXhNMU1J?=
 =?utf-8?B?bVdTRkluUkZxem5qd3JNZmpQeUY5dFBScDNPK0FxU1ZwSGxIY2tGYUlYZEMr?=
 =?utf-8?B?NEEzRWcvWkNuMVFZSzhWWnFGb3pXOWE1QXJXeHVDV0JvZzlpQTZPWHRvemJZ?=
 =?utf-8?B?anVVcU44Y0EvWnhpaGdCK0JJSnZaTVVjVEtQTURwQ1BqekNxanN2c3dBb1ZG?=
 =?utf-8?B?U2hmdGs2ODJSdFgwUnNvQ3lFNS9LaW9LckNzNE1yb3JhVTZjOHgxYnRLWmlW?=
 =?utf-8?B?NmFuMkFzTjVVTWw5cGVZOWJ4SmwyTk1hR01IT2VENTRyWmNrKzkycVZ3anVZ?=
 =?utf-8?B?TlFtcllMbVNDd1c0TlVrK1VJb0MvRUpsbWFVSmhVVFpKdG1DdHBwRThlcXA2?=
 =?utf-8?B?b1BEQkREL3AwaERDZjYyTEQ4TjNZMFlIdEgwViswYm9HWlFxVkMxMnN5UWtP?=
 =?utf-8?B?TGNUaGk2c3I1aVAyUE1HQUhNdFhuYmNoS3ZLc2lsNTdtREdGYURNcWYzZGhF?=
 =?utf-8?B?U2tQbWJpME1DaWRwTXNrS2I5ajR1UUpyMzVtUldYTVNlUkhvZXczWTVPa2I5?=
 =?utf-8?B?R3FDQmUrU2Uwb2g0UXRZVDdUbmhMSzlGb29ncnI4Qm9EbjZ5YTZjeThKTGk2?=
 =?utf-8?B?dkNNMjZISlByT3JGZlRESWJrRE00NGIvc0svbzVHdGRCNlRFTWR2YUcwbkF1?=
 =?utf-8?B?Q0dYZnoxeDg0Rm9veXpSVndKZzNjaGJtOVo2SmFtRjBYaXpYbWhGWC85YXla?=
 =?utf-8?B?dVprMHJMdld2UTR3T1JvZ3Q0YTVXdkF3NENvQzBuamdIdVkyQXMxSHdHaXhq?=
 =?utf-8?B?YlVWV3NkSmszT2NsTzVmc2lDRHdrbGEzaHloSDl6dWV2TlVpbUtqbWUzUnQy?=
 =?utf-8?B?MFRCZEYySUdMOGJVYnhEWEJtNklJaXVLejRnb1poNEpLNis2SDd1aFVLdzdk?=
 =?utf-8?B?bElIbTJEam1MQ1NvK2IxbG1reGQ5MnVZWTVMN0JoNDBUMU5FUDNnQnRzSUd2?=
 =?utf-8?B?ZzRwaDJmK0xCR1hwZGFMODJlcUErTjd2Z1ZDMTRmQ0JVSmJPQlNDTHAvNHJ6?=
 =?utf-8?B?dUlBbGdKSmJ4dTExQ0U4T1RzSGZ2Sm12VTEwTTBLbzVRWWJ2bzh1VnAzMXJO?=
 =?utf-8?B?WFR4RDRGRmQwOVd2RHpYdElCdG8xbWhZSE9zMTZPeHNsOEs4SGhOdGFYM05X?=
 =?utf-8?B?cEJkOTJOQkZuTFZLdnRoejNxRXQ2RlBHb1pNMkdLTmlzeVFLMmplOUtEdVRt?=
 =?utf-8?B?ZU8ydkFHbkl1dy94TW9TNC9UcjhPZW80aEdpc1NkbkZ1YjVIWGZDY0xDcnBz?=
 =?utf-8?B?bE9QbFZEM0JhVlh2MDlMQW5NSjRvSm84SlE3Q2NmN2RJNitNZ1hXSjJkVWRa?=
 =?utf-8?B?eTdGZXpEMEdDL3VIQXV4VnZ5ekg3djNHdFh0Z25DS015dVoyYTFOQklmckxR?=
 =?utf-8?B?MFBUK1VkeFlmRUluZUZGSjRVN0NWYXdwNFVTL3lxZ3VLVGZSTzVtL3oyS0ZG?=
 =?utf-8?B?dmhZb1pxN3JJOGE3KzZINmlVRmVvWXFZYlRJeUM5RWNOYjhGaC9BMVhtL001?=
 =?utf-8?B?N1RDUHQyekI1T0ZpNkJZUDY4WlhSUEpIVnVHaUpvZHFqUTVZYTlGdzkxT2h2?=
 =?utf-8?B?NHpob24wQTBIMkUyVnBDVElPdDVtbjV4bTExeXVJS2NoTm5xd3hMMUR0OE16?=
 =?utf-8?B?WTYxbnU4eDZjVms0L3g5d3J3ZEdpdWVxV0dtUmk0RE1uZW9rd05EdnpDUGZJ?=
 =?utf-8?B?SmljVFZ0ZVRNekk2UHhNRUdYQzV2UUlWU2JVcUdxeTlYaG1oVFQ3cjhaTVpS?=
 =?utf-8?B?U2NGS3lJZ285RGQ1cDlCWXVSU2NHMFpRWGdCOERaUEFEVXE5MG1sZEd0cG1p?=
 =?utf-8?B?US9HeG1mMlQvR1ZpL3pDcCs5U0JsRC82LytMN1JUcTR4WloyaktnQ1lWcEhl?=
 =?utf-8?B?TStDVUZPVWUwaWN4VUVHOGZ2ZjE1QTUzVXU5eFd4bjE1aTI4QW9PRUJTNUpv?=
 =?utf-8?B?Mk9wLzFObzBPMy9SNzhDN1NCc0V2aXV6a1lONFhycCtuM3FSQUhCdkJyZFR0?=
 =?utf-8?Q?vzSKrLZHdgvvyrBNz4e9mpA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hyEOZReLXqTz5lA4krlDN71kmkBOdoG2qp3iA27bUGGpHFSh8W0GV+ky2UCsJFBiCU10A2nw2WSRB95YecUkh4VhMjE8W8gyh0wOmgByAZg+obahV6FI8GmWFC9IBndPD5E4wkktmyyDuhh5iDqSWI0dCBZShKlYkJVbtztqW6sLLepPm2E9AQ+xb/PiRTFMWce9QsAWQ2Y9igqKyyRgzlkPeYcCS5D0kdQpn7gVb9qCYK0WIp1KpuKjDdeHO3BsGEPDPWLFYbuTKz6bGWjVokkGUI7o13in+khNDNeOZXPhi5UB4/pirWh6IgfcB48infqLxnj7KfxNOz3rgbv7jZL7rb+DuCPZNicUCBHNZ85AIkcYfJvqZYYi5KEAjAkUnwWWMKFiriW57TefpBwjNy/hwuN7cSSJBZgShdNlEt8WcQ0N2DHst2ovmJmitZ81JejtegaL2jni5wQ6YkZvy6hR5lbI3xpFgBNQwe1guDZzD4eaSNnr/hLNSOjK2X8kVvj4Rhk/Cx6QmxHZm4MnaoYc7dPP0MhI6vgANT2Gq1/JeFkfn4sQSaELx1qxKij1cYmEBN/BFwxKRioSH1nEJ+xNOJ+Oif6kSURgpmhVpCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ed348d-fc3d-45f7-5c78-08dc54baf985
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:22:00.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkHkbV8+QbAlFZUh3ImcbrNSl6tJnrx/krCEGJGUpnOWtdMXTTTCTu3ondtuoB9N+vm9N2PD7bUFl1GN/WabRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_11,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040106
X-Proofpoint-GUID: jptJnsiOhuJ11ayro7T2Jdf_8o4M6M6h
X-Proofpoint-ORIG-GUID: jptJnsiOhuJ11ayro7T2Jdf_8o4M6M6h

On 29/03/2024 22:00, Andrii Nakryiko wrote:
> On Fri, Mar 22, 2024 at 3:25 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> To support more robust split BTF, adding supplemental context for the
>> base BTF type ids that split BTF refers to is required.  Without such
>> references, a simple shuffling of base BTF type ids (without any other
>> significant change) invalidates the split BTF.  Here the attempt is made
>> to store additional context to make split BTF more robust.
>>
>> This context comes in the form of "reference" base BTF - this base BTF
>> constitutes the minimal BTF representation needed to disambiguate split BTF
>> references to base BTF.  So for example if a struct is referred to from
>> split -> base BTF, a forward representation of that struct is retained
> 
> so you decided to not bother with recording expected size? Remember we
> were talking about situations where vmlinux struct can be embedded
> inside the kernel module's struct. In this case *exact* struct size is
> very important and can't be changed without breaking compatibility.
> Shouldn't we keep track of this?
>

There are two cases here I think. The embedded case - which is rare, but
needs size tracking - and the non-embedded case, where a struct/union
can potentially change size without invalidating the module's
assumptions. In the former, your suggestion about having an empty
(sized) struct instead of a forward would work well I think. The only
question is around the non-embedded case. We could either use the same
approach (but then ignore the size constraints during reconciliation) or
continue to use FWDs. The advantage of continuing to use FWDs is we
wouldn't have to compute struct embeddedness during reconciliation, and
the BTF itself would be a bit more informative about the constraints
(FWD means no constraints, empty sized struct means we care about size
due to embeddedness). What do you think?

>> in reference base BTF, and split BTF refers to it.  Base types are kept
>> intact in reference base BTF, and reference types like pointers are stored
>> as-is.  Avoiding struct/union/enum/enum64 expansion is important to keep
>> reference base BTF representation to a minimum size; however anonymous
>> struct, union and enum[64] types are represented in full since type details
>> are needed to disambiguate the reference - the name is not enough in those
>> cases since there is no name.  In practice these are rare; in sample
>> cases where reference base BTF was generated for in-tree kernel modules,
>> only a few were needed in base reference BTF.  These represent the
>> anonymous struct/unions that are used by the module but were de-duplicated
>> to use base vmlinux BTF ids instead.
>>
>> When successful, a new representation of the split BTF passed in is
>> returned.  It refers to the reference BTF as its base, and both returned
>> split and base BTF need to be freed by the caller.
>>
>> So to take a simple example, with split BTF with a type referring
>> to "struct sk_buff", we will generate base reference BTF with a
>> FWD struct sk_buff, and the split BTF will refer to it instead.
>>
>> Tools like pahole can utilize such split BTF to popuate the .BTF section
> 
> typo: populate
>

Will fix, thanks.

>> (split BTF) and an additional .BTF.base_ref section (base reference BTF).
>> Then when the split BTF is loaded, the base reference BTF can be used
>> to reconcile split BTF and the current - and possibly changed - base BTF.
>>
>> So for example if "struct sk_buff" was id 502 when the split BTF was
>> originally generated,  we can use the reference base BTF to see that
>> id 502 refers to a "struct sk_buff" and replace instances of id 502
>> with the current (reconciled) base BTF sk_buff type id.
>>
>> Base reference BTF is small; when building a kernel with all modules
>> using base reference BTF as a test, the average size for module
>> base reference BTF is 1555 bytes (standard deviation 1563).  The
>> maximum base reference BTF size across ~2700 modules was 37895 bytes.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c      | 215 +++++++++++++++++++++++++++++++++++++--
>>  tools/lib/bpf/btf.h      |  15 +++
>>  tools/lib/bpf/libbpf.map |   1 +
>>  3 files changed, 225 insertions(+), 6 deletions(-)
>>
> 
> [...]
> 
>> +static int btf_add_ref_type_ids(__u32 *id, void *ctx)
>> +{
>> +       struct btf_ref *ref = ctx;
>> +       struct btf_type *t = btf_type_by_id(ref->pipe.src, *id);
>> +       int ret;
>> +
>> +       /* split BTF id, not needed */
>> +       if (*id > ref->nr_base_types)
>> +               return 0;
>> +       /* already added ? */
>> +       if (ref->ids[*id] <= BTF_MAX_NR_TYPES)
>> +               return 0;
>> +       ref->ids[*id] = *id;
>> +
>> +       /* struct/union members not needed, except for anonymous structs
>> +        * and unions, which we need since name won't help us determine
>> +        * matches; so if a named struct/union, no need to recurse
>> +        * into members.
>> +        */
>> +       if (btf_is_eligible_named_fwd(t))
>> +               return 0;
> 
> Let's be a bit more robust here. There are three cases for BTF types
> (kinds) in "base reference BTF": forward-declared (non-anonymous
> structs/unions/enums), copied-as-is (anonymous
> struct/union/enum/func_proto, plus INT/FLOAT; maybe something else),
> but also there is a third kind that shouldn't be referenced from split
> BTF (datasec, funcs, vars, etc). I'd like us to be strict in checking
> that we don't accidentally and silently support the latter. It should
> mean a misuse of this approach and we should error out in this case.
> 

Sounds good. I'll add that for v2.

>> +
>> +       /* ensure references in type are added also. */
>> +       ret = btf_type_visit_type_ids(t, btf_add_ref_type_ids, ctx);
>> +       if (ret < 0)
>> +               return ret;
>> +       return 0;
>> +}
>> +
>> +/* All split BTF ids will be shifted downwards since there are less base BTF
>> + * in reference base BTF, and for those that refer to base BTF, we use the
>> + * reference map to map from original base BTF to reference base BTF id.
>> + */
>> +static int btf_update_ref_type_ids(__u32 *id, void *ctx)
>> +{
>> +       struct btf_ref *ref = ctx;
>> +
>> +       if (*id >= ref->nr_base_types)
>> +               *id -= ref->diff_id;
>> +       else
>> +               *id = ref->ids[*id];
>> +       return 0;
>> +}
>> +
>> +/* Create updated split BTF with "reference" base BTF; reference base BTF
>> + * consists of BTF information required to clarify the types that split
>> + * BTF refers to, omitting unneeded details.  Specifically it will contain
>> + * base types and forward declarations of structs, unions and enumerated
>> + * types, along with associated reference types like pointers, arrays etc.
>> + *
>> + * The only case where structs, unions or enumerated types are fully represented
>> + * is when they are anonymous; in such cases, info about type content is needed
>> + * to clarify type references.
>> + *
>> + * We return newly-created split BTF where the split BTf refers to a newly-created
>> + * base reference BTF. Both must be freed separately by the caller.
>> + *
>> + * When creating the BTF representation for a module and provided with the
>> + * base_ref option, pahole will create split BTF using this API, and store
>> + * the base reference BTF in the .BTF.base.reference section.
>> + */
>> +struct btf *btf__new_split_base_ref(struct btf *src_btf)
> 
> I find this name very confusing, for some reason. btf__new*/btf__parse
> is generally used to either create a new empty instance, or just
> parse/index pre-existing BTF information. In this case I feel like
> it's actually a different operation, where we create a derived BTF, so
> I'd name it distinctively. How do you feel about something with
> "distill" terminology as an action performed here. E.g.,
> btf__distill_base() or something like that?
> 
> The API contract is also suboptimal, given back split BTF where base
> BTF is owned (and has to be freed). Let's keep it a bit more explicit,
> something like:
> 
> int btf__distill_base(struct btf *new_base_btf, struct btf *new_split_btf);
> 
> WDYT?
> 

Yeah, any suggestions around naming are very welcome! My first choice
was "minimal base" but that seems to prioritize the minimization, which
is really just a side-effect of the desire to add context to the
references in the split BTF. "base reference" feels clumsy to me too.
Ideally we want to find a name that signals that the base BTF is a
companion to the associated split BTF, adding context for it. Describing
the operation as distilling certainly connotes that we're removing
non-essential info; so we'd end up with

int btf__distill_base(const struct btf *src_btf, struct btf
**new_base_btf, struct btf **new_split_btf);

...and we could call the section .BTF.distilled.base perhaps.



>> +{
>> +       unsigned int n = btf__type_cnt(src_btf);
>> +       const struct btf_type *t;
>> +       struct btf_ref ref = {};
>> +       struct btf *base_btf = NULL, *split_btf = NULL;
>> +       __u32 i, id = 0;
>> +       int ret = 0;
>> +
>> +       /* src BTF must be split BTF. */
>> +       if (!btf__base_btf(src_btf)) {
>> +               errno = -EINVAL;
>> +               return NULL;
>> +       }
>> +       base_btf = btf__new_empty();
> 
> I was confused, it's baseref_btf or something, we already have
> "base_btf", which is coming from btf__base_btf(src_btf), so let's
> distinguish all those "base" BTFs?
>

Will do.

>> +       if (!base_btf)
>> +               return NULL;
>> +       ref.ids = calloc(n, sizeof(*ref.ids));
>> +       if (!ref.ids) {
>> +               ret = -ENOMEM;
>> +               goto err_out;
>> +       }
>> +       for (i = 1; i < n; i++)
>> +               ref.ids[i] = BTF_UNPROCESSED_ID;
> 
> by now we generally expect BTF IDs to be a positive integer, so I'd
> use int for ids and just use explicit -1, and then a bit more natural
> check for >= 0 in btf_add_ref_type_ids
> 

Sure.

>> +       ref.pipe.src = src_btf;
>> +       ref.pipe.dst = base_btf;
>> +       ref.pipe.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
>> +       if (IS_ERR(ref.pipe.str_off_map)) {
>> +               ret = -ENOMEM;
>> +               goto err_out;
>> +       }
> 
> [...]
> 
>> +                       default:
>> +                               pr_warn("unexpected kind [%u] when creating base reference BTF.\n",
>> +                                       btf_kind(t));
>> +                               goto err_out;
>> +                       }
>> +                       ret = btf__add_fwd(base_btf, btf__name_by_offset(src_btf, t->name_off),
>> +                                          fwd_kind);
>> +               } else {
>> +                       ret = btf_add_type(&ref.pipe, t);
> 
> see comment above, we should detect erroneous uses of referencing
> "non-relocatable" kinds like VAR/DATASEC
> 
>> +               }
>> +               if (ret < 0)
>> +                       goto err_out;
>> +               ref.ids[i] = ++id;
>> +       }
>> +       /* now create new split BTF with reference base BTF as its base; we end up with
>> +        * split BTF that has base BTF that represents enough about its base references
>> +        * to allow it to be reconciled with the base BTF available.
>> +        */
>> +       split_btf = btf__new_empty_split(base_btf);
>> +       if (!split_btf)
>> +               goto err_out;
>> +
>> +       ref.pipe.dst = split_btf;
>> +       /* all split BTF ids will be shifted downwards since there are less base BTF ids
>> +        * in reference base BTF.
>> +        */
>> +       ref.diff_id = ref.nr_base_types - btf__type_cnt(base_btf);
>> +
>> +       /* First add all split types */
>> +       for (i = src_btf->start_id; i < n; i++) {
>> +               t = btf_type_by_id(src_btf, i);
>> +               ret = btf_add_type(&ref.pipe, t);
>> +               if (ret < 0)
>> +                       goto err_out;
>> +       }
>> +       /* Now update base/split BTF ids. */
>> +       for (i = 1; i < btf__type_cnt(split_btf); i++) {
> 
> nit: cache this btf__type_cnt() result, no need to keep calling it all the time
>

Will do.

>> +               t = btf_type_by_id(split_btf, i);
>> +
>> +               ret = btf_type_visit_type_ids((struct btf_type *)t,  btf_update_ref_type_ids, &ref);
> 
> nit: it's a bit annoying to cast t here, given btf_type_by_id()
> returns non-const type as you need it. Just mark t as non-const and
> use btf_type_by_id() everywhere?
>

Sure.

> 
> 
>> +               if (ret < 0)
>> +                       goto err_out;
>> +       }
>> +       free(ref.ids);
>> +       hashmap__free(ref.pipe.str_off_map);
>> +       return split_btf;
> 
> [...]

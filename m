Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FA1EB5E1
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799053; cv=fail; b=WCe5084pRMK5Rc+QnYoE3xP8x+yWc7sD1BH6ZwJVRybU3v9Kw+BlySER+s6AGT/rjP/tcwcWsyfDrl5PJGaNyvepQ1GxciHqp2NzC4ldEqEl1uXxMtUVKJv7aPHuYX7mQiOJtgTa2decyQ8BQJWXSOZeiCc/luMfPAtlutI8pdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799053; c=relaxed/simple;
	bh=5JK7zWkf0+qc0cJDCPZqVK4RkZ8OHv3yqqKoB0uO9eM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iS82Vr0cXyxqqxNAeQntyhzt9JsmzH7tDmDU5reeekXoCGZi/61U6D6GiaG0HrJg1IqM8oGHTY5AhUcckuE9k4/wuI7KAq4uOdZYXlF4lJV+ijztkgzzzayURz2oy/hnUWUdmxkVYUOMfJ9pSNLi0vBEJE1NTFe4JDDNYfGB0RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hgOgHuCt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GvoSK07R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hgOgHuCt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GvoSK07R"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLQptj3616766;
	Sun, 22 Feb 2026 22:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OK4BP62qtxx5JMS/0e69zMbGp9cxDAevNVdnvYqJOvA=; b=
	hgOgHuCt8OyiW96Jez8KoCAMtx3s9CiHwlbaPUIz9mxa8K2YfGVsGLO7caQ8yIAp
	I7DMPUePZ3p3tUVe7+JvsuLkTp0jcqKNi1fEb24qV6Ydv8bkErGkPDxp1nE7FbkO
	ErNw+Kw1MPsrJn2dXQQg0BVpSIgakP8LbFDW/r+lPuj7VVhqaye48kHCFqHrNVmb
	MO6U2NdjKnnlovPd+rXaxs4i6Cy7svejYO0uVLoK9EFFbrokBYZc+49WR76C5Uoq
	koMv+9jDh5O7R797Ma/docr8d38XQV3aOIvwFZOyEpege8JFpgYQ//bk0YQoWtzr
	DlMGh1AoJD9yjs74ff4G4w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf58q97sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 22:24:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61MLRWsj038497;
	Sun, 22 Feb 2026 22:24:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35hww52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 22:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtHFjrh4r90T9YTk7xwKhkzmSXNmwGJYK6n5/S4jtng10kXK8T7p7Hh0pRFsYXplQ+pUmlqblRZ+cgMV/4j0/KXsC+8oJvtpvRDOV/klghYL04Oyho51NrfJrHQ8WDrGpveYdTikRSyCL1fmVmzXDeuC407w6YMjRMOdc8Jvyigb7AsjeXDmNp+KOnG6tLXeB6mbhNw/Mil1e8YB7v3qMz9c+gCmiYW/gNaj27GbyCuT+7W0E04fSly8YiaY8M+6d99ygEmGAnkr4wHKRJQXCqUe9oA5W+qWkuvXTpBWD9ZAewiTlqSMYP4MQ3LL0DPTFRXk2x3V583QaFulN238Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK4BP62qtxx5JMS/0e69zMbGp9cxDAevNVdnvYqJOvA=;
 b=kh+z8RIQ82s1uys4X8Eja7IL6ZidDfvnCROTU7xrVJBeQAuZSrUbgmWSQywmVwKUnnKhL1NVRPxk/52L0uURe+eCBsvgIoKgXqG2ynwk1/TKSxvSwtaZzjA4CafpHjM8l2pJ4JHOTMu5jIKrDo4E1ssVIpslvbii2GWOYgZnKHGYNIYRIAEmtQy3f0YLoBW8pP/AY1/4UD9cDbH84IjTlJv1b4w7Kbpa+pFGJi/n5LbRfiOUDUCPGoALpXaM26T3yMjJlQ0QCJwH7AfKdF5uqC2buHdxQFzK1aMX1Fyk+tLAm69tdTpxoeNkHsCZz87tgBi3zMqGRwWzGjo1zZ0swQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK4BP62qtxx5JMS/0e69zMbGp9cxDAevNVdnvYqJOvA=;
 b=GvoSK07R+SRl8fNA182l/Nbe7qiEr/XrQxbC003j2qFrmyGVubS8jdrxk7fQtDCBMYhjubjb7+kC2matTRxeG7AKaeWZwWFQtRdxvObxprX89/9tBBN6PrPM1Xa1QXaiGw93hl0xiIwygrsITk9ZBf5oZaGCgQ9TLV5idnITWwE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA0PR10MB6868.namprd10.prod.outlook.com (2603:10b6:208:432::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Sun, 22 Feb 2026 22:24:06 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 22:24:05 +0000
Message-ID: <3566d461-8323-4dcf-99ba-54628cd8f001@oracle.com>
Date: Sun, 22 Feb 2026 22:23:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] selftests/bpf: add test for btf__add_btf() with
 split BTF sources
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
References: <cover.1771625484.git.josef@toxicpanda.com>
 <e582d9289c7b7c2682808db22da6bc3ba907d884.1771625484.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e582d9289c7b7c2682808db22da6bc3ba907d884.1771625484.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA0PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: a9528d04-255a-4ef2-e204-08de726116c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enM5eE9WdU44SWpXekhQT2djSVZQMmRIRkpGclBxSU1kaTVVYmhhbXY2SGI0?=
 =?utf-8?B?enRWdklGaTJmczJ0eS9DSTNjTzk0M2hCeFlBVDJXbjZEMXNvNTg3QU1LN25B?=
 =?utf-8?B?eUFLbnliN3FoemlRUzZtSTB5L0R1eDBheXpRUjNNZXQ1bnptYzNYb2dmNWZy?=
 =?utf-8?B?MGZiakg5Uk13Z2xWYkg4ekhUdHl4eVpucjNndS9KWkdKQW5GZzhHQ2QrTk9E?=
 =?utf-8?B?N2xzVEtaY2w3M3hDaXdva3ZuTVRVSGxoVHk1dll0S2hPT3BuT1Rubjhyc1JY?=
 =?utf-8?B?TjM3UVlJRzJFa25iT3R0TU44bmxBQlVmT0VrbjRiMEwzMkN2R0lXRE52UWMr?=
 =?utf-8?B?dTZzcC9YK1E2cVhaZ0g4ejFLQk9YOVVZZGM0aE1VN1J6d25uQXFSaGVBeXdt?=
 =?utf-8?B?aXNZN0dURE53eWxkVmNjRWRWWnJGOTNMVDBabVkwdmJsSDlSclY2V1NMVkZn?=
 =?utf-8?B?M0tOUmpISHc5d3ZzOS9TeEJKbGVrdkgrZm9JQ2pLL1Q1RmdmczFPamVvd2Rh?=
 =?utf-8?B?MW0wZG5jL1VHQTJ4QXJmMDdDZlRXSHpLYnc4SkNEeHNqZEM3WFlMbnowT3I2?=
 =?utf-8?B?VUVFbjgxUnRKL2dxZ3dnZnl6Mkx6MWZTQWM0YVpQaytSSXFSQXVhajFqMFM2?=
 =?utf-8?B?NEs1alNvY09Gc0l5UkxqSGxtSWlJVVg3VCtQejFnc0hSUC9rVEdLUEowa29K?=
 =?utf-8?B?SHFobFhUQUJxYkkxekxIYWNSYlIxNWhTajQrSnBXOUMvb3ZVMnBlbkIzVC80?=
 =?utf-8?B?eSthcTV4S3FwZmo0RkhUOVBpeFJiT3VvbTNjN29VcDM0aWFGTm40VWFJeU44?=
 =?utf-8?B?Q3pZZzNFMjJJR09YSytCMWxGK3U5NVVpQ0tybEtaekRSSzhMbVl2QmZ5QUNv?=
 =?utf-8?B?cmJUUDN5NHM0c00yQTFTc1pXdmk4eTU4aUM3d1o3UzJ6YWpPRGhmcVNjSHZE?=
 =?utf-8?B?NTdCeW1YeUhGSDdWc0p5K055S2RaeE04eWF6R0h0UGMvSk81Qnh1d1VHeis1?=
 =?utf-8?B?YTh0NStnWnZ4MG9qSG9oREhBaTRCRUdpVm9PdWFrSlpBdmhHZHovbzZ3TFdH?=
 =?utf-8?B?OEFCeDFLcGtUSmhZTy9aaVJIa0J4R0xrcFFURm5ub0dGYW5zTDFQOXMzd3dP?=
 =?utf-8?B?Tk02Z0ttaXk2WVBZVStrTnNWQk80NTdoYnJKWDhJRUVHQlU2dnp0WFVRa2xX?=
 =?utf-8?B?dUI0VVdleGw0SWxkM0ZJUTdVZDd5aWdYWExlOXREL0FrQW9UV0JYNkcxU1VJ?=
 =?utf-8?B?STZnd1o4eTQ4SHVacjRCRTVEbnczazAyMThjdFo5NHlySVo4QUI4OEg4a0hU?=
 =?utf-8?B?eUFjUVBWaStNUjNYN1FpRWRySEx2YzM3dWU2NklKK0lBMzIzYXA3NDY1Vy9i?=
 =?utf-8?B?WDFTRWQ0R3h4WFBFakIrbjMxcmVMRGo1N3pEcit0b2FVOUdldWxGcTJJbUdl?=
 =?utf-8?B?S0dsMWVNS3dZM0dJdWxuajJPZXBORmVaY0h6M2Nna2NaQlVFbmR1MWNNNlJM?=
 =?utf-8?B?YUtyRU5XM3lmZXg5R0dtRTVaQUhHaDlLdVNBcjhaZmdGbGtxdGpFaGp1cGNk?=
 =?utf-8?B?UStvK2Rwbm5YTkhEckkxMUh4bmtKb1p1WTh2RnByNHRiVEhZVHlXajNZaUlW?=
 =?utf-8?B?NlB4Wm1kemxOQ0ozaTI0a1V4TnhyOXBTSHdQQXFJSTJVZElRekJiNXREd1pQ?=
 =?utf-8?B?ZkZJaHVJRFdLbUdOWDZHNHowZW1yb3Y1MVJWSkk3NnFJM28vUjQvdmtGblBZ?=
 =?utf-8?B?NU1LbzZ0TSt6WEFpUk02NXZ1M2tCWXM2aEw3Y0IxK2drMEZwVzdUdFN0MVVR?=
 =?utf-8?B?MWdHTGs2WDlTVmRWVW9TRkxmK0NTMUxmTmlxa0tGTm44dUpiL2NOL2l1dERD?=
 =?utf-8?B?clRMcXdLMmlMckNLRCsxRHI4cjJ0TUI0Qkg5TnhHamV5S1Z0QTBiZm1PVGlm?=
 =?utf-8?B?ZHBYcnVTOHhHVDNad1paVERuTHd6SXVtWTJld3Y0R1RMWjNGL3lSSkFnMjJs?=
 =?utf-8?B?T005bTExYk9zRWpSQ3ZkVW5kOXU5Z1JSZjB3TGRrZ0dFRjZKZVlWN3JDQU53?=
 =?utf-8?B?N2xRczVOWGtieVVNN2VmYU5xcnZRb2JuVG9RZW1QeDRkSjdMWHU5djBoaHc2?=
 =?utf-8?Q?/OBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdqK2tLYlVwOFpZQmtudWFsWU1OVFgwa0NUaXlXOGhia0RtcEl0dWZyc1pX?=
 =?utf-8?B?dDZOR3JKOXYxMXdrRjJ6OVBkcFRPREtobHlOeE1UZWlqWUljZS9aVmlzR3kz?=
 =?utf-8?B?bEtaZ2VKMVJsZnZ4cUhjVEFLU1dOMTRYbmVBQlFUUEczdnlEYVUwc2o1djg4?=
 =?utf-8?B?M294b0toVCs1TmUxeHZIb2JoYjN3eWdtWjltVThxcWpjS3N4MGhibzhqaWRQ?=
 =?utf-8?B?b25qRlJEY0lrSHAvc2lTMVV5L3dhbEczc21UcXlXZ2ZhNExGTmp3TG8vaDRz?=
 =?utf-8?B?S3lyaEsvTlluWFhsVndJOVVHVHR5b3dHc1RCYWVnM1dsZnhBcEZHUGc2QUJq?=
 =?utf-8?B?aHRGRmVxN0FSYzVJRjA5bHdZc0NibDZodUVxRlRvcEkxWGVyWG4xcEZKSEt4?=
 =?utf-8?B?S21MTStJSEl0M21SUDVOclltV0JvbWhvQ0wzaGFhanBQd3ZLYlYyN0gyNjN1?=
 =?utf-8?B?N0VBKzhxWVQyK3VvRDQzMXRCK1plaDNHQXV5TW5qODlmaTlCSlBWN0ZKZ2Zm?=
 =?utf-8?B?ZHNmWjlXOGtpdGlPbmd1bEtZd3FBSGh5SDRVVEtRQitlYStQQ25LTVNPRHVu?=
 =?utf-8?B?eCtIaHczWGNjc1crR3lzMU82dWVrVXJUWkZjVnpjVERadEQvRFdDYUN3UWdT?=
 =?utf-8?B?OGNzdEJRWjJTd1lMa0MwQWdPa1JWYWllbldhSWlZMU5iSTByQ3RNVDVlM3g3?=
 =?utf-8?B?bURqSlNOUlhhZzN6N3c4MVNlUU9JcmJoM21YQnVINlNDeW5SWWFOdE81cGFL?=
 =?utf-8?B?RS9Zc1BhWmhWemVpaDNiRnNmcVQzdHhMSVd0QTY3cVUwT1d5VHVXazI5TUxB?=
 =?utf-8?B?NWV1cjJMK1lGZjJKUW1iZHk5VVpDc01UeDVUVHRlNHlJa211TXRjYURTQW12?=
 =?utf-8?B?bmZmVmJYd0JGekhheXpwd2NKUUNWMExhVVR1WE1heEVWS1BsRTVydFdjTkxo?=
 =?utf-8?B?bGErL1hTQ0IxNzE2ejNQWXdLdlRZYmY3KzhBZmY3di82QWo1emFNdkN1Yldm?=
 =?utf-8?B?a3lrT0RDNHR2Qk5mY3FueXNFMXN3VWNHcGZYTHhrWnlkQ01BbVZNdG5xblJw?=
 =?utf-8?B?M0F2cjVpbEo4NWZ6Y1BRKzIydmliMC95QnJyVllidStCV05Oc1oydjdYN3lH?=
 =?utf-8?B?Tm54WlloYVZjUEEzcGw4b1hTSEprY21yeHg2eVZqNzFoQmxGL0lPNnozVTRr?=
 =?utf-8?B?Qm90U09ocXdnYzA3cEw2a3hJWWxTRW1hWDRLRllwY2VTSTVZL1E2UG9mc21H?=
 =?utf-8?B?TXNwTXFnaW5BNmxocnZvMnZsN3Q0c0VGekFMTTBmM0R2WmorQkxQcENTbXlt?=
 =?utf-8?B?K2xUOE9hcTRxUEZidFVxa0ZMWHhRUWdqU3dNL0w1SVU4UWhXUG1JYTVzQlBn?=
 =?utf-8?B?SlN1U3NhQjgrSGxXRGxkeTVSVXNvTy9FMXBUazcxL2lPaFBnRTlFQ1g1N3Mz?=
 =?utf-8?B?YUJsdGZWandBcDRoZnhjUmMwY2RGTkRaMTlKRFVkazFSVS9aZ3MyS05vZ3lM?=
 =?utf-8?B?dktoaFlQUjBLMThoUlRPZlB0MHNnUFpDZTNlS1huem5wVzBNeDN4Q1pBaVhZ?=
 =?utf-8?B?VmJSTUNOU0h5QnJBVTZ1c1B0WEdiblZoVzNsWDBVaGxsNUZhVjlEL3Z1aWI4?=
 =?utf-8?B?WXZBM0Rwb0YvWHh3NmJjTm84dTY2eVRnV3lGSTU5K3BnUzlCWElIOFI4OGdV?=
 =?utf-8?B?MVVhakFYd3V0UStoVW85QXJvR2h1eklwdnY2emZDeWtxVCtGdHo1cXJOUml3?=
 =?utf-8?B?T1dTdGpScUhzbjgwUHJxRVZzNnR0ZGdRVEYwaVpQU0JXNDJtdXNNY0o0SCtS?=
 =?utf-8?B?UXphUTRxVnIvaExGYklhRGREQU9FcDh2TEc0ZXFsVlUzZHl3L2xneW1nSTIz?=
 =?utf-8?B?UlFMeXVuSGk5R2VTa1dKV1NtOEJjaWM3eDEwUXZseVRXMTNxbFVxdjlzTGY4?=
 =?utf-8?B?U0hEck5jcFlJYlU4VVdiZFVndml4bHlVSXVVN1lFS3FQenFLSnhvM2lwcVFi?=
 =?utf-8?B?UVpodE5nZHFYQUZieW1CakNPbkdMcUQvLzJocjJkSmVQa0RCQWY0N0N6OHNw?=
 =?utf-8?B?SUt0ZjR2bDBCOVJ3V0pzMmRiYWFBb0JKUFgvQmp6ZjkzeStYR1lzMnk0T0l1?=
 =?utf-8?B?b1ExODRBZVRUcjNVa0IrTFdMb01OUUx5VVBTZERlZGRhbE9tS0RKOVo1RVVv?=
 =?utf-8?B?ZVZES29CK2k3M010bTI1OGxRWFJ1eCs0YWtQQVorTWFDZEltMzNqeGhZeDBr?=
 =?utf-8?B?M0lhZ2VrcGhPaXM5cE1IOWZpRXdjZjY5ZElWUG95Wmk5dWJMUWlvQU9XTm5w?=
 =?utf-8?B?U2t6eVhBL2hITFZScWVhWGlIZ1hXblpYN2RhUlNrOW1jbyt2OVNGQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZtJxvaLSVS70peyu4zjigoZDItYDarGqrWR8nvyzq4sZ/zI82WjpZvNKlLuliPCwGPJeRcUkajyujSpPPNKBkZYnQtO+6fc7pMtEcmiE3CCVNWCgJuKLNQdkBT+6NYyKHgB0i7Zdp1M6FbcxFNX263OZ1EtZrPy/LJCRIP0vWvIvXmUCZDazcjZ+uCiygyq9UcIgE+uI/OhHyoI9TV1iZqBi3O2fJLyodzvNtK5LHAnMDPagksbK/GAOQ5lArX/GlhLQnyQJAx/vdTgaIu/RBqT8RNlLdvblQmOCknBwWhY0F8yMSd3qYGaYBkFue8AojjzD0RCiOtfiMvFQiypCR7EJnrBxtsSjCNFjReW2YoMfLBXDgfzbw0FpJo1nbAA4DO1X4KaEOOBohPIdNHHdO2z7sJD+5RmJsAjNVc7REXnGr34WDQ8In0JgSFWiFCX627eclkv2SKbAT19axdOZ2A2CCUVzUqIN9O2Has9KJVyJ1V751PW9bsPZTBDnuJACrMlvRA5eBmgHDV8AzTjXILE6ooazurkeY3FRx80C4817qd11Qyq8py8FZ4N4iveLi8cwFQM6WYWfLUES3R2gnVhxEOty3NN9nVhBELSqygM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9528d04-255a-4ef2-e204-08de726116c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 22:24:05.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox/Ow70gU2nPHUdxygWZuqKrHVD92qTbRtZPcF4/xGY5z6AyqqlLAS18fmqElav4f86LeARi+Nu/Dn7V4KQPow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_05,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602220214
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDIxNCBTYWx0ZWRfX84xqlICFE9K+
 yxhJwd3D7234fiwsXyEb2EJvBemEye5ZLvFNax4U8VgZxEC+RQzBJBX/UT86s40xKZ7SsBoUIPX
 iZQqhHuRi7beDtP1zGT9rk7oGokaffj3w6poc/iTuxm4/JwtkbTXu6G/3pmkBmV9qmYrreBAoTm
 Hx4D9JAg6TGC3XwJTN0Ojs+mQOkQaLglEmSyG8fbY4HVeT/97wBBKhuLwGYS1cFPaHpw9dMONko
 4qyP4bp2QeXxRlpo+h9WIZm5U8dlCTiu26uhRFSESRpMNq5/xtPHI38/irg2KXN4sgdKlwVQpOl
 fwisMNAQEs5ZmeJY8CDDFGbn4skO1TPW2Ef+jOZBqv012mRqTp10c21AOJXh6dPXW2hMVxv2f9Q
 XHQVFNHdD9BtYSKc2XqWyvlPL0hC+WdQJLS9AtDz1+lAUoPgCok69CQkEiv8dlNO3N4Y3RRjNAm
 rOjZ7Mz7mj/obXQayUiNDphLZ7iZcEnQNUqxtQHs=
X-Authority-Analysis: v=2.4 cv=XNc9iAhE c=1 sm=1 tr=0 ts=699b8209 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6gl_cCoBAAAA:8
 a=klOExXi0_KWAs9yltfoA:9 a=QEXdDO2ut3YA:10 a=Bor9z-CvbNo2M6AZn8_k:22 cc=ntf
 awl=host:12261
X-Proofpoint-ORIG-GUID: jiMcY7B9Xtq-CWYbvr8vIKPeyOy8b2xK
X-Proofpoint-GUID: jiMcY7B9Xtq-CWYbvr8vIKPeyOy8b2xK

On 20/02/2026 22:43, Josef Bacik wrote:
> Add a test that verifies btf__add_btf() correctly handles merging
> multiple split BTF objects that share the same base BTF. The test
> creates two sibling split BTFs on a common base, merges them into
> a combined split BTF, and validates that base type references are
> preserved while split type references are properly remapped.
> 
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

looks great; one suggetion below..

> ---
>  .../selftests/bpf/prog_tests/btf_write.c      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> index 6e36de1302fc..80353a545cdd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> @@ -497,10 +497,99 @@ static void test_btf_add_btf()
>  	btf__free(btf2);
>  }
>  
> +static void test_btf_add_btf_split()
> +{
> +	struct btf *base = NULL, *split1 = NULL, *split2 = NULL;
> +	struct btf *combined = NULL;
> +	int id;
> +
> +	/* Create a base BTF with an INT and a PTR to it */
> +	base = btf__new_empty();
> +	if (!ASSERT_OK_PTR(base, "base"))
> +		return;
> +
> +	id = btf__add_int(base, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "base_int_id");
> +	id = btf__add_ptr(base, 1);
> +	ASSERT_EQ(id, 2, "base_ptr_id");
> +
> +	/* base has 2 types, type IDs 1..2 */
> +	ASSERT_EQ(btf__type_cnt(base), 3, "base_type_cnt");
> +
> +	/* Create split1 on base: a STRUCT referencing base's int (ID 1) */
> +	split1 = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(split1, "split1"))
> +		goto cleanup;
> +
> +	id = btf__add_struct(split1, "s1", 4);
> +	/* split types start at base_type_cnt = 3 */
> +	ASSERT_EQ(id, 3, "split1_struct_id");
> +	btf__add_field(split1, "x", 1, 0, 0); /* refers to base int */
> +
> +	id = btf__add_ptr(split1, 3);
> +	ASSERT_EQ(id, 4, "split1_ptr_id"); /* ptr to the struct (split self-ref) */
> +
> +	/* Create split2 on base: a TYPEDEF referencing base's ptr (ID 2) */
> +	split2 = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(split2, "split2"))
> +		goto cleanup;
> +
> +	id = btf__add_typedef(split2, "int_ptr", 2); /* refers to base ptr */
> +	ASSERT_EQ(id, 3, "split2_typedef_id");
> +
> +	id = btf__add_struct(split2, "s2", 8);
> +	ASSERT_EQ(id, 4, "split2_struct_id");
> +	btf__add_field(split2, "p", 3, 0, 0); /* refers to split2's own typedef */
> +
> +	/* Create combined split BTF on same base and merge both */
> +	combined = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(combined, "combined"))
> +		goto cleanup;
> +
> +	/* Merge split1: its types (3,4) should land at IDs 3,4 in combined */
> +	id = btf__add_btf(combined, split1);
> +	if (!ASSERT_GE(id, 0, "add_split1"))
> +		goto cleanup;
> +	ASSERT_EQ(id, 3, "split1_first_id");
> +
> +	/* Merge split2: its types (3,4) should be remapped to IDs 5,6 */
> +	id = btf__add_btf(combined, split2);
> +	if (!ASSERT_GE(id, 0, "add_split2"))
> +		goto cleanup;
> +	ASSERT_EQ(id, 5, "split2_first_id");
> +

could we add a duplicated type to both split1 and split2 and call btf__dedup()
on the combination to more closely mirror the bpftool code flow?

> +	/* combined should have: base (2 types) + split1 (2) + split2 (2) = 6 types + void */
> +	ASSERT_EQ(btf__type_cnt(combined), 7, "combined_type_cnt");
> +
> +	VALIDATE_RAW_BTF(
> +		combined,
> +		/* base types (IDs 1-2) */
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] PTR '(anon)' type_id=1",
> +
> +		/* split1 types (IDs 3-4): base refs unchanged */
> +		"[3] STRUCT 's1' size=4 vlen=1\n"
> +		"\t'x' type_id=1 bits_offset=0",      /* refers to base int=1 */
> +		"[4] PTR '(anon)' type_id=3",          /* refers to split1's struct=3 */
> +
> +		/* split2 types (IDs 5-6): remapped from 3,4 to 5,6 */
> +		"[5] TYPEDEF 'int_ptr' type_id=2",     /* base ptr=2, unchanged */
> +		"[6] STRUCT 's2' size=8 vlen=1\n"
> +		"\t'p' type_id=5 bits_offset=0");      /* split2 typedef: 3->5 */
> +
> +cleanup:
> +	btf__free(combined);
> +	btf__free(split2);
> +	btf__free(split1);
> +	btf__free(base);
> +}
> +
>  void test_btf_write()
>  {
>  	if (test__start_subtest("btf_add"))
>  		test_btf_add();
>  	if (test__start_subtest("btf_add_btf"))
>  		test_btf_add_btf();
> +	if (test__start_subtest("btf_add_btf_split"))
> +		test_btf_add_btf_split();
>  }


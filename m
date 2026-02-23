Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1D3385AB
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871900; cv=fail; b=Ea+FebBRfKaL5SA1gWF/mRFPsYqLr3vP+BInZZVhYtKMFleaupqCqMXkvAi68tm79jDWK0MRK6vQgC+gymhldYSO4SK2aimDYYSDFrG+fkRHVEQKn0ND9A8GI5kXrWtoqMm6Jj7o5D7qlf8aM92RtBM90idogcSft53OEz5O9/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871900; c=relaxed/simple;
	bh=BuZWtHPx6xMicM3s+jyNORnKWQtfnfV+15iN4tcJOO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfzvIpuyUjG3ijppfzmyNf+zVqtrKgE4fRCUinj9t3k0ttdvyRaPs957cSfkeMBQfdc1LD0+kAN14AEehQkF7Yzg8P0EmKN3iENusAcWz/ZCP3Vy182O/SYS9vzmrNF5545+Qgkl+vfxxYB/MEqY5bBvghXwDB5+IcvdIq3V/WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FNyx0JQA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DAAFz/W+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FNyx0JQA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DAAFz/W+"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEuqfX1768533;
	Mon, 23 Feb 2026 18:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2x/jNuh6gTWeoxqKzPynCD1ZTse2ot2x4YdAghXMrJM=; b=
	FNyx0JQA/j58U9+StxnPXpfpvnRxg5adK2zDb6i/NEAMhpi0+Kw9a2dhYAzakTqb
	CdrK5nxysx/rBNCWgyE7EaCNzBt6RIItrIKFSc5ZfRxa50VtcAvuhgVRoaEyXFe1
	+v9hz7WAFOsdBYivX4wl807o5yYK/JMsJbwx6iRbnyVCDdxFyos57DpNjncXKQmI
	toBhVnYMmHGMTYgOVPIqmVUJW4t2R/myNfPX8OX7N7Fp3vLzjJu3yfoXAvuGbvFy
	sMXTka8KyOSGF/5SngS19btt+yNFleW4b8PZSiJhNBYGEaJZIddL2lVJ7AOzzVql
	ZY6xXXv69c5NxLHAy27l+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5tts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 18:38:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61NIFoCe038634;
	Mon, 23 Feb 2026 18:38:03 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35jy4mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 18:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x15ACl6LH4PDlU4vvC209MqunPX/QnujVTCu6HQOpk0X7zvwtGUyMFauczUsbTTgKqu6kyRiZTCh/5kyfVeTNd3bmFL3BDRnTLcoT/Wc9zgDi5jN45ayxuEM595ATgzKBRvBKHNzEmErq6NYbiEnqGOe1rsl343x7/FmNzQzXAyrP8lHPKyjL/ReXBUOqNd6JixZezZsWlaKO50kbw8GtjPlQHM2Vns/eruqFHkaF0Mvh+Ay5kwNry43tNEHCLaB2ySzeOWc64mGzTv7J6SNScDEbTKd+8STUOPfnSUieakbDvbx/td8nzdBtQ+B+Ilv19uHcC2NMVy6eGkNvNAl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x/jNuh6gTWeoxqKzPynCD1ZTse2ot2x4YdAghXMrJM=;
 b=ynCuTv7zEgi3knXfyyjuBnPYb5FIVeXLCVEKEXAcOjoFkrsDRy9TwpMlCdlxnDozTscsQQk6NNP5g5RH6ew2YTYAjFxMX9itqy1q+07JQZ/Kt8yypmjZTB+rkkvQYdli8POB0IaMs/QKAfsga6XLvLc7BG3lk6DzJEhgbkFxoEXSW1cH562G8pFAo+HQJnv4XV5cIdLZnWIGr4tKCEg3cWu97g4PqGnw6esyPJQHBq0mfLdpBfquWuBVVyDIkniB0ZznrmtzUwhmHNaFnSfHXGAnyPpqWa40t9UeBxQeM48NMIe6Ld2Dp3Zw9CiNjFiw4/k9HjhDAMyQdzCD16ztcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x/jNuh6gTWeoxqKzPynCD1ZTse2ot2x4YdAghXMrJM=;
 b=DAAFz/W+BAVPIr2gBmnT+5VmtEoCOCHLqlJ9n0cm8+iCr6G5kFB2QrF2sBDiTtY3FnaT9Q5UsVu//z5N6p9NpJxO2+tl8B2p1AYkDjirRNL/hzJTB2rWDiO1+Bi1o+7uhGKHuypL3BJhUph0R5buqVOjmLdux9JTFcHB8E7z17Y=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:38:00 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:37:57 +0000
Message-ID: <a6e20fe7-54be-4c49-a953-c013a4b88a05@oracle.com>
Date: Mon, 23 Feb 2026 18:37:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Recover true signatures in pahole
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <de152bf4-a168-4017-98bc-d5f64b0a01e6@linux.dev>
 <CAADnVQJwJwnwU0uOVqrdfj=n40YBNVt5HpERGw8Lqa3NtvGFdA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJwJwnwU0uOVqrdfj=n40YBNVt5HpERGw8Lqa3NtvGFdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: b312216d-2748-4046-ff6f-08de730aa9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3c5bFphNkFSSmFRNTFNdml5ZjlXSHd0MmhLbkVvRmZTVHhBcW00TFlsSHoy?=
 =?utf-8?B?U3Z1cUhGOWF4bHM4TGhnc1gvb2tWSUNReW5iNGFYZUhydjRHVDlaNjAzWDU2?=
 =?utf-8?B?WHhBNSs5bmVPdTloMHdKSE5OMExDWCt2S3hTdXdwdFFpM24zbTRldVhuMS9q?=
 =?utf-8?B?eXJiQjlMK3B6VjBHaDVoaGk4OCtCdjJCVUdFSENPM2x2RnFzYTg1L1ZsK3pM?=
 =?utf-8?B?NEVCazdkUWJjbmlyaW5kYnlUb1BHaTVaMk9sNUJvY1NyNmFFZHk2WkorV2Zj?=
 =?utf-8?B?UkpydUhDY2ZXT2tEVDV4MnAyL04zSzk1Y0lNZUVvdVk0cWtoUkNhUEVYR2c1?=
 =?utf-8?B?UWhzUXdZeVAydmpsUWZGdEdCQTlaWXFKRC9mWFliU1QyL0FqZDJua0VRUjcy?=
 =?utf-8?B?QWoxNVVwSzRGdmRrUlhtRUx4SWJ3Vk5wOElDUEZxOW9TNkdva2FCb0tYWldK?=
 =?utf-8?B?aHdIenFCMGNOR1pBUTh2d01ydE5MQ0FBTlJFejg1ekVrM25KekNaODREeG9o?=
 =?utf-8?B?QTRndUdHZGJkbXV5ekpnaHhsanlRNVFJeE1CamRHZ0lMTnN5KzA1d1RacnN3?=
 =?utf-8?B?eWttVCtYbklSbmg3RjVibUtWWXB0a2xzRHdabkR2NlhVR2JwSnBNQU9tUG9X?=
 =?utf-8?B?RzNYeW9OdHdwSWVmVkJ0dEVuQkM1TFBzdDVrM3I2cWszWDVzYlkzMHk5dDhq?=
 =?utf-8?B?TWlqb0xnMWs5d3RZQ0Z3MkNWVTFMS0swU1FYZDZta2tNZWpBWS9ad05CTG03?=
 =?utf-8?B?cHhQaVdXNGlnS3ZsRDRadFk4ejI5bWR5Sm1VaktsUHByd25JR0NlcHcveGgv?=
 =?utf-8?B?dlB6RWZkNGEyaDc5UnFmVXlnQTRSamtSNUJXTUgzODNvZUpTbkNlVHFuYzNw?=
 =?utf-8?B?cGVIbmFKbGJ0cXlOdnVmSndhT3RpQzBaTnhHNm5pWTBCbGlPUGE2ZEhvQ1Ra?=
 =?utf-8?B?cXYramhtaU1OVXN0UERZWXl2YmdWUUtKUUltclFoQW9aSGt3YXhUY0hJSHhX?=
 =?utf-8?B?ZU83YWdVNmlxcE5oV2lBOWlUUVRPL1REbEdMaHRoUXd1UDJRaW4yRjRBTEFy?=
 =?utf-8?B?TEJPclEvakZmWU1EdHliTkZTNUlLUWVpbFNsbW5nb3NKa2thNWFEcWtpQXZk?=
 =?utf-8?B?ZnhDQUtROEF3Rm5pZWhRM29rNzdKMWN4bkJMdHFML3NaLzd4NmNwc2JEaHEv?=
 =?utf-8?B?S1RWTWovOU5CekJrU1diTnBhazB6MlpvWVE3ZUpqZ0RUR0JQR1piTWNTcEgr?=
 =?utf-8?B?dERZS0VWR1FuejRhQ1pLNmgwRUZFUjlxakk4TGx2YVNGZzJaUnBleUhkbERt?=
 =?utf-8?B?TitBVUZCb1k2TlkrUGprUDNYdTZVZG5KaEJrc3R1RHFEbkt1R2RyTGs3azRo?=
 =?utf-8?B?cDZCU1BrZUI5NDg2dnJ4WFd0R0FWZTNIbWxwcHExM0RGODNjZ2lqUTZMQUtu?=
 =?utf-8?B?UkVmZWNNMTFqVnc3dWJDSHpaWXAydkNBTGwyUkhjMzJoelpBTSszMHRSTVN0?=
 =?utf-8?B?U0pabEErWE02ZVd6anI1ZEIrbjJFbWlMelZWWDh6cC8yOVNaUDlic2RueU5q?=
 =?utf-8?B?SitVQXVBajZzOHcwNXZBZFFzYjZjcWgrcStnRW9jbk5vVXhpaXNVZ3dWclB1?=
 =?utf-8?B?Zkt4UzViUVo3Vjd3dDdwQ1UwNmxCQ1lLbzUrKzNiTTcxbUhuejlhU1FlUXB1?=
 =?utf-8?B?dy9zcHNReVpkZWNWMElsLy9mVWtVaVRLZzVvNVp4cS81dXozdDZCc1lPYzlK?=
 =?utf-8?B?YkNsaEdTODNKak9uazBhUGdUeW9PU1Yyb0F0TTRtU2MzWVBCTjhJNDducmxh?=
 =?utf-8?B?VGUvdGNhRWZOdFVVcWdwem5CanhXRTZUbnZXMzAwYVJUditnMDhqUmdQaTJU?=
 =?utf-8?B?aWRpSEFNVFBJcVNLYlpCNThvczdRaEVJZ1pkajNMOFlJREl4WHBzYXA2ck41?=
 =?utf-8?B?WkJHYnhhdDJUcDNlbVJqeXdFUGpCSzBDZ3E1SFF1UlZFQW15anNmczdTRmJh?=
 =?utf-8?B?b2xIZlBPZ1lkeFFTZXR2Nm9TN1Q3YUpmSEhHVVd2aFhzZXVDRGZWMURXMXg5?=
 =?utf-8?B?Q2l6T2cyQUwvZWtsNEUvZnlCYmJ2cWNDY0xXVXlEWEFITVNaMzJRV29EVWQx?=
 =?utf-8?Q?BsPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjU1dmRzQ09tb25pWExLanU0ZWhieldSaE1EOE5HNjlITlpYMnl0ODZYQWlN?=
 =?utf-8?B?NHBnKzlabkN6RHVxOGNqeGwwcWprOGI1YW8yWHN6MStST3Uxa294S1hQTTNz?=
 =?utf-8?B?VXQ3a0FjMWZVN0RxL2ZOSFl2M3E0cFkyaTZiaWlVZjd6YWpLcTVObTVhNFNN?=
 =?utf-8?B?RlZGNWkxa1dJdlJSS2NwaldSbm44WVZ1V25KN3JpWDUxUG4ybzdaVDFJSVdp?=
 =?utf-8?B?S0JtcllzRTBXdzlSTWxVTkJYRWR5bHd3eWZBUkl6V3N2YkY1OG9DUTJaNHhZ?=
 =?utf-8?B?d293bjV0K3ZtS0xlMkJPNXV1Qi9jUGw4TDlYeE8xb0x5bkNvZGpxVWlzSjBS?=
 =?utf-8?B?OUJKWTRsRHBFOVRIWnloY1VGdWloV0wvWDluemxwUi9aY3FrZk9PTEYyM3p1?=
 =?utf-8?B?dm1rTUJCdmJOcCtVbWIwQlViL3FKY2NhWDhlNVZ5YXJuUisycVlFbzE0bGZ3?=
 =?utf-8?B?OWNkT0JVNm10YVJCSkFBMWE5cS9ycmJZVGJaT3hJVkQ0OFpFWm5hbE9ubG51?=
 =?utf-8?B?NkMrZFhONEx6MlYwN2VKQ3grWHh5em9UNThEcGJFdStqMVNOdVlmcjlPYTJ2?=
 =?utf-8?B?T21KcHF3QzZGZE1uQTFaWVA1RUY0V0JvWXFwVjBLWG5LdDdTUDh3VDFmTWNN?=
 =?utf-8?B?dmVQQUtqWCs1d0hmQXhhL2tCTXg1cVB2TitHR3hvTGlSL1F2d0ZONGJwb0Iw?=
 =?utf-8?B?VDdITm1QMzF0VFQ1eXZnQlhRL0pHTG9MR2h2MGRYeEZuM3JuMWQyZ05oU01V?=
 =?utf-8?B?dllhdWMrSlI1elQ0Rkc3WkJidWQ0cHd4Y0o2VDRSbzBGZWJXb1ZLVkhTcFpm?=
 =?utf-8?B?cmlpVzlUTXhnUVhHSlZBVDArTFdjaDdFeHZZbUR2REFyUmlocHViODJuMGhu?=
 =?utf-8?B?ZERLcXFWZGZSSGZqKzhUWStmVWZtMDNlY0NkdTRXa3NhSUNMVWlrY3lkTDVW?=
 =?utf-8?B?SUJRd0FwYzYrQVJLN3AwNDAvSyt1WlptU1ZybUd2cC9xMkxDQjkwYkhXZkR0?=
 =?utf-8?B?cG5Leit1L1pKRDNQYnYzMExUVWcyZ2pDVHZnT2RLazFONFRJbk5NYTdGdW5y?=
 =?utf-8?B?L01NYVZ1UEU1RVlsMy9RQUJhNHdiQ0VEV0ZJajc3T1Iya1k3bXEvczhyZVZa?=
 =?utf-8?B?czMrNWJiakZlcDNoUm9NS21laHRscmprWnJCckwrNUJOVTV0NGJUUGVOUEJn?=
 =?utf-8?B?NnkrSVpFUE1aa211V2VHSGdlMThkWlpIK000LzlOQXJkSTJudUNvdUpma0g2?=
 =?utf-8?B?SUhTM3UreWlKNnZQSXEzN3J0K1l3SnB6aEdDT0k3YVJVZitLV0lFLzVzRTVu?=
 =?utf-8?B?WWRsTHoweXRxZHdKbGV3dFI4Y1hibktsQnEweDRJM1ROalY2NVgzRVVUTlg3?=
 =?utf-8?B?K0ZrK0VMUU4ranVGeUMzU3dnc2lmMG0ranBkRWFwQURkc25lckZUczdYdzl5?=
 =?utf-8?B?VnRuckNRazM4clpGRmJ5WWd6d1BRbEYzeG14dXhGaWhOeWNrdnU5RFNmakl3?=
 =?utf-8?B?dkR3Z1dJVjBEYUNEcDJ4c3dsWWFJNlgzZk1xN3ArK2ZiRUJRajV0cUJxdXFM?=
 =?utf-8?B?S0g2WEk2Q0hIck55SlQxR3JyaVNVZ2ZXKzdtLzJnOHh5WHYrTm5rcmEvOWJh?=
 =?utf-8?B?TDA0NG9KaWxoUDhGb2Z5V0NSa25MY3ljbHFnYUwzaldiVk43Q09rbHlieE1D?=
 =?utf-8?B?dERWMUJJKzBtNGIvYVYzR2ZKT1I3RU0rK3Rjcmh5OWRPNHZrOE93TVpDdTlZ?=
 =?utf-8?B?enh3bFlsQzNSMktKMDZtbFVxMWJBbm1ZcjNaZTRtTHh4NkVHQW9laTdwQXRh?=
 =?utf-8?B?NEY5NFRBZ1l5ZmJENlRaTUx2bHVGNXF4MFZhYXBhVXJPY1BVdmN4dWhuVUFY?=
 =?utf-8?B?VWlnSnVucUNVblI2aDhnRnVURVM4akF1OFVtMHArY0Qrc0pFcDZQNmEzSzZq?=
 =?utf-8?B?TXFVc0tyUXRWU0F4d0ppeDJCRUFZbUVWWEtnTE4zdTVFMnVDNENGWVpva29L?=
 =?utf-8?B?UFcyUkVzT2FzMXg2U0U4SUZmVmxSRjFvNStEQmlyZ3l5QU9BRFVtRTdITWJB?=
 =?utf-8?B?TzFYVXE3dC9XSGwwaUh1Wit6ZjhPZmRpb2NTQnJGR3N6M3haN0xRMy9VV29Z?=
 =?utf-8?B?cHRNaXJsbzFadmlES2YrS29xWDNDZ081YWtmOFRGODdIaFRMaHd3STRiQXAz?=
 =?utf-8?B?YWxWSzkwMDVnUFJuamNndHdpSzRjeGZVQnQ3NFB1Vk1aN1FsdTc0Smd4eThP?=
 =?utf-8?B?WHBRMFVOMmIrOURRaklXVmYvOW1LOFJVSjA2bUpVY0lwcVRjbkVpMXltRHpV?=
 =?utf-8?B?c3VGcjhiMUZPc3V1YjZOdUNQUTc0MHd1T1l4RGY0OWljVkExS1hNZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wQenm1ey7tN7scEb6wP1liadWgn9BQ8lWOuTXPca97OPAnNt2P+mh9bS/S0AUZcM6nbTx55Rrg/Gr+AN8rmtM0Vw2WXIpABPxF+rb7FXldx/lxA9iEy5D1lGZa3hLoN99J5CxuYHbt4jJaQ/JJsJPN7LIFacErslySlRx/oo7whXn6I+bQqmpR1Ve1U6nj2+WWfVienPL90ZS5OuBfecMIfL4AJ5nsh9QWvMfsdHzXXXvRUtdxC1Idi2VxnbVXG2QOZzZQH8TL46/EJ9DciTyD9xvgz2hYzwPraxJ3Il7di5DJYi/tGW5PvKK4E0DF+pacXlfXOk8vBxiapwywfEaCE6HWS5tLP9+WL3Mzsm9PjTvfmC6sB/CO6YjIkB8yav++oQYnOhH4YalYNXOx78P+ttp4RMRg3WkfKiJBI9ABLA0TMkPvy4a10/3scS3pCunekr2CFGwpkjB/LAbJUcNmjq5v5EPXLUO71tudq541MzrVwRkxHBdyJ5oi6xUJQgstC9sKi+9+m1IUBkD7V5klQg0k5ssKdTuC++IOdvlNT3RL3obZnmq58TmOMDapq6dpkI9TYD0kYe9lYNKJQ5mWfQjR17nh13QQKKY/Ioalk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b312216d-2748-4046-ff6f-08de730aa9bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:37:57.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOIq4tsbno+bOEB6cZR7ExfNHTxfwuEcCqsOn4vj0bP34RzMJGxUOlFaiNHk5GCr7EmD0Nq83wZXpnl+4bhHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2MSBTYWx0ZWRfX0dfCCb9rDWNt
 VwhlanCeaBp8oe3d/3mptgeYvYQuOMsSVMqi0svx5Q6SI9rVhiJY5tOdSgvk8XyEgOih9tDv1bE
 Y9WA24lDyCpfYlUW6vTSsFupttPvMQH4vXk+QFGZCEx5/CdMsdosT78+G5POksNr/6honH+okm9
 0j6zbhMoCwRnIMI90QQuQGKHFAG99xsYOsMzY7vBuJfGgxjdv4f3Sf+0jYe61rtnSHpHH7C8BGY
 pJZWh2g9KNx41D3LHQrrLyuUwLfFF95k0x4AD3Pko9vRJzfGOra1AZg0mi9/WmAZv4SItdDplcE
 icH/DFE4kh1EkzFWfpYwyUuXRbfiMciL73DRqMvD1A6ZAE9a5LCOqah/civ9Qna45oJixwh/I4d
 odu5D/EY6dlTwRQ00s/atHuTKmwRgwS3L+YTxTsaCYYRzuVoZAMafphRmVPVZIg+mCk7Mp2S+5g
 7CJdl3DBUM3T3tBM3OYm48Dv+Xd+1YAVeCNSpUxI=
X-Proofpoint-GUID: TETLSithzaI15ehalgsBHaK1KVw7X2Xg
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699c9e8c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Rl5k5F__VfvTEUUBYlQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: TETLSithzaI15ehalgsBHaK1KVw7X2Xg

On 20/02/2026 18:01, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 8:10 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> People often trace kernel functions in order to get some insight in kernel
>> from corresponding bpf progs. But if the kernel function signature
>> has changed due to compiler optimization, users may be confused about
>> why their prog won't work.
> 
> This is all good, but what is the status of recording
> inlined and partially inlined in BTF ?
> I think it's a higher priority.
> I'm talking about this patch set:
> https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/
> I think it should be finished first.

Right; that's the aim. That series however depends on the BTF kind layout
work since we are introducing new kinds to support inline info; I'm hoping to get 
the next revision of the kind layout series out this week, I'm working on it now.
That would clear the way for the inline work; I think we're reasonably agreed on 
the rough shape of the inline stuff so hopefully won't take too long to work through.

By the way, I was wondering if there's a way to get AI review bot feedback from
a pre-submission to the kernel patches CI? Would be helpful in catching issues
prior to submission, but maybe it's not feasible?

Alan

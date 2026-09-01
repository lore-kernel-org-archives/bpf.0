Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677554CCDF0;
	Tue,  1 Sep 2026 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238014; cv=fail; b=t4olPrjJRLZ3rkQArllYJ4zuIZAyTzJ2b6N9ub0gaFdyDSS6/N6JAabHOoEodBEOiFNOQDXUpzaQ4IluVe8xbzN7gfwArxAhygjanfAvzmCTGKyzTqm4xXAFNlGHtNKd4E8J1uYNbTkAAR2q2mbrVel26XAU03RW1lW3gj8oMN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238014; c=relaxed/simple;
	bh=ucxAtrB/zfz4leX0H7o+toduuboBlxzaWKYt5RGj+dY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Z1ztxFXnj+UDjZO7NNpOXE4bqKAcEgL9kDLBbdzfyTLaYa6Jd/uIGuHnudLSUIdCX4/LtTpzHIVCT8D6RHnacTHZQw+GyiYLVdChif680tEkMBZPL/GJqoHpOnTzGcOUG7CSk/qqDMA3mf2vFkCSe2eViLmpJUhco5L4PgNGuaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T5ahI2xP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmSYNLS/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5ahI2xP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmSYNLS/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VLC5FT2287504;
	Tue, 1 Sep 2026 04:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bIiUQ9wg5NMfp9JDTd
	+NUuiJ37F2lhaFndj1qkYYCws=; b=T5ahI2xPcU35daEVa1yaFxM0cR+sdn8BBl
	G7bKsX7kyjPpBaks9+bztqv/+H9/zB3Tx1oGjimFQPZbYNAhSLq5DC2afcIV/4CH
	CgNTRVsX3xrA5DRibZ9KElJTS+zc65SCveRJEJT7QLa3Y7HhSLn+CJhrbOY2ckue
	hAZ+T7/rlyVOy0aBffKD0DbBVRNWF73ONJoWR3xjbmNklk8cAn7g0kXEHAKvyZP9
	gfpNVnQuwcnWuzaWrMgF33C3/LXA9yVYcadkGnMRJwJ1KSGPxRxeTLWJWkZTN1IX
	W2aWFCJTHGwHfWtdGDBquv4VHvP/DrPIYfZfSHPb2Upy/xsf/1Uw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72buyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 04:46:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6814ePv9023378;
	Tue, 1 Sep 2026 04:46:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvq4bgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 01 Sep 2026 04:46:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6qUR+tEQ4yhks+fQ6xcpFbtaPqAxkBfkFPTezIlTg9mB8taSQCTu7mCH7NXKRICQKc9xjkyGbLQ/ONwDnTPCrXSqROXz4aQw6fOgHFKZG2v86L62CYdIDYxbvb4R7JX/vcC4W7KHNIEnAu8LcczDTU4aEJnOoHm1YHl8xbVxKuGM8Ihks1W4RZq7lrW8SDEKAbP4CFrPQ4fK9wBWjhLUVBOzv0x2mvbe00JnseZJy3sj3z41sn7y/FxOm/CNNWji1fPMVdYFGlI165mvg/z43UmnF+mSfzzYIcCBcwRTdKFr98IKC2Xa8BUje0TUWVosplbCL/ABPgcx38zelrlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIiUQ9wg5NMfp9JDTd+NUuiJ37F2lhaFndj1qkYYCws=;
 b=ylPUlnqMnri/GNM54x/mpzDUmj9zKVOpkJMS5COESUH2ZN65TFIPlGRPjCHZzw6fJj59Th+BDlaNmoWgCGfTfSx5dkDSggWWB+r8J2h3LHWrgapvGFvEUlAfK6vhteLjLrosJWy6oo7G2zPrcJuFtggWVyRZwjBagZkoOEPUQ2wJXR0KKwVKkmGm3j5P1P3wDsfWFCJTr/pTQOz/itZbEyz2jbDMUJqv2/A2EkswWHtFsfe6+y1kJaSWfBxgd9RuXqAnlpB/a5F7ZqErh+/G3NKMmszO+0B/to/ak8a0tksvE9/PJix9FN9YT0K4bL+SHRv4Od/v/nYSeITXfiE41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIiUQ9wg5NMfp9JDTd+NUuiJ37F2lhaFndj1qkYYCws=;
 b=zmSYNLS/JKbNsE3JPp2j1REcn55gtywyGmYi3Wc5qtDr0vSwAs1WaFl/bAfuL7gAboW6I4dqU1YkmQ1Co1LNDveWo+/rJKz3UjF6HNPin0/cqkgCdfiRQzuZmC8L8e+F77PV8u0n6GB6JPoNp+gBheYeJGzQqXC5MjFAUARntz8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPF1849371D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 04:46:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 04:46:44 +0000
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <20260831232003.7C9101F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <20260831232003.7C9101F000E9@smtp.kernel.org>
Date: Mon, 31 Aug 2026 21:46:43 -0700
Message-ID: <87ld9lzih8.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeefd21-e437-441a-ec71-08df07e405f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4133799003|10067099003|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XDhRloxvDdKNQK4Grpoteb+6E+QgtHI9YC270YkPDrfN+tonADtbA++zUZeNSuOhbAwLOzXdsxf7gXbOH6WdiP14X8W/sGq45LNs0O5Tef8NkpWmD4OB8SK/eBWO+wh2g1cs5iw7Lj3tASSvwQPx22jU1WlIMOIyZFIfTF0rgpYnzyfzC6wnI9U0J3FzMMya7Sm4Sc0uLjiAWnw5h6IbgvD0vd78cBOx1ow/pxTCLr1NV+8GzhggkiOhCwgC8TFhfv69juzXZ8UBOhMjXkKagoAvwsu1CBX8HHUUy7oUn1sLOFpDnWCbLPSbC8D9qLdmUTealarIUb7ogHshsN7f/SjMPCD8+t9bwWDv4ArADrm6f0bL3bRuxvs9QwZid8pD6jrOJRHPhapZ4efQttshCJYzAoN/qDvS9+XlDKMMxQnpQL2SjjMCS5B7sJkO1SicRyK5ykim496xCCuxMtXTTaAIKlCODOY32auHLoYeICRUDyLEuMI/EH564k15ouPu3+TRkwmjm66jazet7kcyYCbHCbY3hxvjPqyOi7pxbwwrJs+Hc95mY965RLVAHHrlrozDTOQhhfRI8Bp6ScbGxo+NZlqp6R7ZBMZH60npedTEF3eYbJTY8062ET0umB0z209UVVxzcIJUVSJRtQuSpKDXaaEgAVXEsBxSxcbJGBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4133799003)(10067099003)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loYUFP7daoIuCT3dgeM/CiQNLd4r1xcXAccpIkn35kcbguFur5Qj5JJNEayy?=
 =?us-ascii?Q?Rq9UlqPcqoGEuMMHBXi9hisiUVyXIgAeYPWsHMciUPEvlATirlM4BqPzPGaD?=
 =?us-ascii?Q?E9A09KwDvUxf4ICZVSHKtTsw19V3hkRAXn/cRX2cL0lI84khRQNTc8D4uMFt?=
 =?us-ascii?Q?IZvteMnN+NjnAV4sGZ/un9ze2dbRb21GcZUIBL0dBH6/00lk9CMp17LgM7lh?=
 =?us-ascii?Q?LSgU054xTHcdgXwm32Iqa8m/PXxMbWPEbNaM7Xedb0DvnHEGQe9NAqjaOjJv?=
 =?us-ascii?Q?Igwxap2S1+YTn+403Hi7vs76R+iFszG/mbSiha7zZ7QBVQPY2+t4vmBkWpXp?=
 =?us-ascii?Q?qVMXoyVt7Xr2UtdEhWTLgIwJXVMBn1d7scqW9Rz2qcBFhwATSI9DqiMc8NCU?=
 =?us-ascii?Q?m7klLTpj9iDf+5dkhEEiEGQqiTSGIhhirS+FjSzDg8Ba66XUs4h4oNUmDWpa?=
 =?us-ascii?Q?sfkFwkhISHbN9re3TcRk8fUvIueSmK2h2FOufbVNQ0+EcW9yhAjPExG9jS8T?=
 =?us-ascii?Q?tinCrCgbmYitD7wlMch35lCDvicy/L4m07vpK06lsT2UocRZY78HO9T/hL/F?=
 =?us-ascii?Q?lsVAxfmG/pIJSXeujG60Ixxol8RCb+ZCl50/GmOI42hAOxZ9/xsrUnDmODXL?=
 =?us-ascii?Q?rVmRtcdVDCQXPiRMIO1HVrfnZPMxt2m+3qR0mrrTaXbfdgiuQCAdG+qwLWOG?=
 =?us-ascii?Q?xJaDh3AjZw3dQ9lZA0496S4jTuUqd11ZjQxXJ5C+malJQCb61VDa4tmkzqfu?=
 =?us-ascii?Q?91i7mXnuKOrZ8LQM59BMdbhPRadAPa3odCeBrZHAdw4pMBNNYtqKLOvjlZLg?=
 =?us-ascii?Q?IwbiUa9CIWr6b4slXFKbwe1o5OHoV2d6UlttGQ1IYtX5VLSS5m6IgYnOGVW2?=
 =?us-ascii?Q?+KU0Aj7o78F8MZGGVUSEvMjCHy4a3x/vyaVxl3ll5kUuYknMEqoc+uHeUXR5?=
 =?us-ascii?Q?ooEw0WqRLaDe9ItO5tHqVAPBmF+ScHSXrV0uE0FYMz3b/PpZZcKJvExl5Ntm?=
 =?us-ascii?Q?ocAWM9lW7vyEPnbhM9tfsK6cma6YrMPhhf2HJsp30p+viy7hOLxS0wbFrtx5?=
 =?us-ascii?Q?3sHgvzkT4+nHH4fuuhGe1Yy59wNtuYRFj1q/ZzTwVPmyISQ08lJLNS4Z7ekj?=
 =?us-ascii?Q?pNPh7F8aajToWBqZQSBHwxvM2lW+r5vD0QE4JAqLJoTSjVukBJmeBT6epJMe?=
 =?us-ascii?Q?qb40tp7/GKF8zavrAzq4Fc3Q045zo3oX1MQqeys+Opg8A6A17+eH0W2KX7yj?=
 =?us-ascii?Q?AUHxkfLKIDu6QWxHPd7LBqoCY/nBL8cyvnaJbEkvjPFRs5BXmNrbQNBFuXpf?=
 =?us-ascii?Q?922SiyF13mdwoz47lcA5R/9NlbZfjJRYa5Ojg38ITceIPUdKw3vuY1dV2hFm?=
 =?us-ascii?Q?Dsx99v188qEoqnvvNWMACx30LvV2n/ZDKwUpxTHiBqtpy09z83sPVITsq+Ox?=
 =?us-ascii?Q?UPVsuBhWkl9XumIOBRXsNggCBcly4O/IflA1ImgFaLiddf8D4pRZmE1zLzAi?=
 =?us-ascii?Q?ojqfl1QZ/DJgtwomYAWrlaWu/1CbQbDijCUOYBqfrF6QZR84J0YqiISR6esX?=
 =?us-ascii?Q?RLrqHccqddeM09xrjQbmV5ll7eq7/YfxVd7dG5gmbgfCrrgDFT8Thb7YELG4?=
 =?us-ascii?Q?EdD3dhKx66qz1EcXf/Cv2rF2uao23ADzICj6WWfSB+CUfxIKptI8bFGgHB2C?=
 =?us-ascii?Q?eslK2Il9WaCk0XQKC9oppTXikgWv/J0s5DmOusrnqsaRZA4msdsrY+bvoHV+?=
 =?us-ascii?Q?RlkEJn1siAql6reEFFKneBHdDkkoowY=3D?=
X-Exchange-RoutingPolicyChecked:
	vmoYBDlUB9a/wEOGmSbzC7gKXWH8eh61pKRMJyrqVOh5l9NIpWJYQN66z4+/+FQQsDXMIa0ZDIGpnBbVi9c/Z3jXrzFHLgPeTHCr/0IJedUT1qJTUVj7WTCHWpQ0AlEDyir3300j6DmuK/zQr4iA1TNrR1MYlOTJG+KhIg6918HomYQLPAevT4iMfH8Qxpj3+VG8yvcFdMCtjM5daXnXHBU9Q/b8KT2Udmub+aahK9KBb6nvsTdDjX//j7DB5rH6EvBD1bK/l3jm8BewirNWjYNflEcWmsFmqHRiWNtxlk74esIAiIuhTqjDyIuYPT3qtDtqo6iI2ovn/AhRAXMFrQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BVHMvLLqh13XWV0Ord8tHbVFfb/M2ql5YoqOIW8C99V5sNyIGJs1iSN+NzPmKxkeH9LJiUmUConcdIfy8BIyZ+c6bP1rnptD+/iBseESzpEhDUX9vmf9JRLOvOzGFKi37ty0WkxJWNQ4XF9jVT70j1u3J19NV5z8wv4DfgI16LymyeaTLYS0PbjTOxH3Wmly232BKjGMt2ftI8ovQgjZvFMaWX/4JdnWCkRFetXMX7LoqCbBTGxXG856ZYW6T+LufwxRkyKbGU7/s+7dPf3Lw+b1ls9yO/cGRLtOa0Z2CQFkZxoVsD9x4g0ignzUhOzqujLnZ9hnrN+JEXjTsSBpD32QBJWXxVgXzl7f982DwE2ZO+tt5uw/V/j46a74zlh92EB5M6JuBeWVd6uj2gVvOFanAQDZ0wTr6iCEDb8NcNWCIgyFLTr9qAlt6joisT+n6BcrfSqioLQuDl4MJeF+gZDMRuoZXgKXvUcXMEFYQ8jqFZpzQ0CtRq2MZKDyYETKcUQA/Y+83QMjZeiJsL1nqhOcWDRO/Sg8/gOr3T+Dcax7+hLSPiDzrL1lUdzRczIISPXQcGH2w/aiAr0sBX8TW2Fw1xz09QBHsqEk5AthAgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeefd21-e437-441a-ec71-08df07e405f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:46:44.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK10AvY5/zZkxPUE3bOl1eY22lMXc106ooC0nTR7nkTNfct7fT6aHNFXFEbe1jLMthQQu516XoDouNoUYgC6mVi5+w/tzOP0hTEVTDi89xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010039
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzOSBTYWx0ZWRfX8yI9XcvXu6Ox
 l9bVJ4QH0hNsnNH3xCG3NH9FjFZikH3DA4u9XTF2g9M12nmtplEkjRSzeXmn+CqTPmYwyLbi+oc
 pXVENX2TVzVZF0zhUIvUBAfM2qRY5DZJad4mTgxtIXEWvl0iALGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzOSBTYWx0ZWRfX8OXfabyYDnfZ
 2CJhC3BBGJRNNWH830BJobrlQ10Ffg/UvIEewfGbt4Y5X2UPNjyxyMcw4wdXdLsnQMkfxQbf+zW
 Cvq4Tq+YkVlw3Qwv0Zu4Y562oFrepIJ3z5YL0vFOaJxYXTFnGtu1zT2QBr8+QobiGZBpIdUeVFS
 alCzu3lQkh8aVHBj5aggSDzmkuUrFJCpplLlfxpyrDm5fK78lcpl1ZDNg0J+ec9FehdrOpaBL7V
 HAU28WHalBQJ2ygzH6RCnIP8m5RbADqBoxFP973c6HnVJKLVc+nAxHnsW1V0UhCMAN4i1+tbhmp
 6h0Nj3fKSEQ0bUgdpnc6+MmxnvN74Do7cpZTQvAXp278PdnsN/yGuAHMcSd0clWHoqW9VAyPXMD
 EkBuor7vEK58ehyZ4/JgJ9YC13/W1fnhedFsWpxLQSx6t9TEiK7DC/YcSiR4C5MO3EALO5KTIOo
 9AWQKEKid6/Utd+8w2bWx+mHYq7xIRphzwBu2DO8=
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a9658bb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=YrL5lrN_cQtTh5FbNIsA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13521
X-Proofpoint-GUID: BHT5gF30CFdizBQY2Jtai0xfF5YtrLzc
X-Proofpoint-ORIG-GUID: BHT5gF30CFdizBQY2Jtai0xfF5YtrLzc


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The timeout for the idle polling loop is erroneously extended because the generic wait macro calculates the timeout start time only after the first 200 spin iterations. Additionally, the commit relies on an architecture-specific optimization that does not actually exist on the target platform.
> --
>
> commit 9b952e08004e7de674a695400c7ab21ff69df4db
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
>
> This commit replaces the manual polling loop in poll_idle() with a call to
> tif_need_resched_relaxed_wait() to optimize idle power consumption.
>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index c7524e4c522a2..7443b3e971baf 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
> [ ... ]
>> @@ -21,15 +20,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>  		u64 limit;
>>
>>  		limit = cpuidle_poll_time(drv, dev);
>>
>> -		while (!need_resched()) {
>> -			cpu_relax();
>> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -				continue;
>> -
>> -			loop_count = 0;
>> -			if (local_clock_noinstr() - time_start > limit) {
>> -				dev->poll_time_limit = true;
>> -				break;
>> -			}
>> -		}
>> +		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
>
> [Severity: Medium]
> Does this unintentionally extend the polling timeout?
>
> When tif_need_resched_relaxed_wait() uses the generic
> __smp_cond_load_relaxed_timeout() macro, it first spins for 200 iterations
> before capturing the start time for the timeout:
>
> include/asm-generic/barrier.h:__smp_cond_load_relaxed_timeout() {
>     ...
>     cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout); \
>     if (++__scl_count < __scl_spin)                 \
>             continue;                               \
>     __scl_time_now = (s64)(time_expr_ns);           \
>     if (unlikely(__scl_time_end == 0)) {            \
>             __scl_timeout = (s64)(timeout_ns);      \
>             __scl_time_end = __scl_time_now + __scl_timeout; \
>     ...
> }
>
> Since the timeout calculation is deferred until after the initial spin loop,
> the total wait time becomes the requested limit plus the duration of those
> first 200 iterations.

Yes, not meant to be a precise timeout. As mentioned in the commit
message of patch-1:

  This also means that there will always be some hardware dependent
  duration that has passed in cpu_poll_relax() iterations at the time
  of first evaluation. Additionally cpu_poll_relax() is not guaranteed
  to return at timeout boundary. In sum, expect timeout overshoot when
  we exit due to expiration of the timeout.

> On platforms where 200 cpu_relax() iterations can take a significant amount
> of time (e.g. ~14 microseconds on modern x86), could this effectively delay
> entry into deeper C-states and cause a power regression for short polling
> intervals?

"Power regression for short polling intervals": would be curious to see
this workload.

Rafael confirmed in [1] that a delay like this (or potentially worse
with WFE on arm64) is okay:

   > Just that with waited mode on arm64 the timeout might be delayed depending
   > on granularity of the event stream.

   That's fine.  cpuidle_poll_time() is not exact anyway.

[1] https://lore.kernel.org/lkml/CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com/

--
ankur

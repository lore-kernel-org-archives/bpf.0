Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2A33C187;
	Mon, 20 Apr 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701235; cv=fail; b=b9R5DK5Wz4ExWMrcpk6gqx9AVv4a0ozVbf/gnu9MA7ATPqEuOsXwk+rbIfPORWI0Th6+2OY1MmWQXVTVX0OTYIp7YQhwT2943yH1Ov3Zi5nU+zJnqVkNLTboCmdU5uGnCdzwcSfX2OydOQbKXeHA770O7M+kkxUzFWx0FOF45kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701235; c=relaxed/simple;
	bh=NXv17RQAwA5Pi4iK4w4o1/xFHvapOI7WMCriVlggGDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxGK41EKR0ohIj4HKBycosIQxTtZ0SqLU4Ilsz2m9L9UEzWPtCkqgKysgoxTnq/0xjKbVEIcCHhAdhjAxFTtEcIdkbKc1bRV2ClE8o+V3x5zu3t/7GAsgpjEhr+h2M48GaBebADodko4pk8Na8Fxg3N6O/dfI3vJ1iUXtqVtTOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OiZBzRw5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oZlHJFaQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OiZBzRw5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oZlHJFaQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8QMWr2860844;
	Mon, 20 Apr 2026 16:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3YJfLgSv9xQVp045YTInilW01B04LCF2XGrghEdy/Z0=; b=
	OiZBzRw5oBpQdCiLz3K4YUA708xaM0t5F7odN2UQ6M18CC9JzxQThVC2gmeXyIFg
	c0JuWuz87RA31MXAd96gOK7KRdd+4J6+QEnbDVuz8ZthsMNKR9Ac34Z4ZX2Oq6ZU
	EVlvnY9SMgJjuABE7KCQ7wnGLqFhNjj4zRz8oidta/BuziTb+jXwz/BqXkokmBxi
	jCTA6bNdU1O2QV+vFggqgax91DbO4KGaQW3Mr/RvmEV8vjw/m8INp0TwOFgMHgLF
	COlbFSNiOGc1H4NpUDEfSU+eV+CD5mUWk2q0n+dFxsM2f+m+FoizKCt4wHqLx8Yv
	9VflvG+FYxMjZy5U7bz1Vw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm2ceuruy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:07:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KFpBkb032214;
	Mon, 20 Apr 2026 16:07:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn176c9tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:07:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paZFo7Ecfss9QxXJ2dxK5uzH4SgKitC/k5/WTvYUxMaUblrTtTxpuu3sXRy9Yh7V2KHTsEj+ywaeABydE++w0EPN2rOIK1KOEUpsvRXQggzFRyxm6VCuDPZOG8+iLRi1E4KjD2ywChdL30N7cON0B3C+6fNR7pI9QQXFSaAjF+/EJ2laoFiK/jddzwoGE4RSiwWsQAdhup03nRsUTYWfAW5ZO/p+OzIOBsLK7biq/oInRGa1PM2nfGTV2tfF2nR//II0zV33v/Y5xG81eqfWq9j5GDlf1xX5/2yHZxMjxPdmDtV/tRbOKYk/lXPgEYXGvJB6BXYL3WIKEGQ0vOPxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YJfLgSv9xQVp045YTInilW01B04LCF2XGrghEdy/Z0=;
 b=V4I20imJJJzo4F7mGbiOq1HL993CclyyyuYmv20iimuuWT+u/XtFMp/yQ/pGpumkiTCuX+Vm3WHo7uzbznD68s2ctYna3CFTLpH9r9p46ZQ4FYleuT1KJYtkGI5gEd8uUDDXHa3x8gE4mzps5nVuXsgS31PE9CYVbqoeYWN1IYbWmBlcowGMF+XlfjuVwDnbg0LCE15+82odQFrE+KlzCZHcd6BFrmr55uVFtDW1shELAtdHMCza0pNYGuC0LyWCFVHKUOj5UAdb0+gv74jiOrh+FEpljfdkzxxAAEqk+dFZye+ewfs4ty1gxYhQ7d/AkhaT4Vmc8LXOthMr6Zhvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YJfLgSv9xQVp045YTInilW01B04LCF2XGrghEdy/Z0=;
 b=oZlHJFaQFwddyHDg0UZC424+1TcsVWQ98M2XJCX2zWs4vmlOBPqVtFr8d1ysPm+sbVSMgccBZk/wqt+c69Ex3c/CCqXvBufvbMQaha64MzK7LJ6DxltEK/zYjt+YUcCv1WaSbGW4ps/jaDqqZcu6HPmuucfZTqiMcl1YwyT4oAE=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 16:07:06 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 16:07:06 +0000
Message-ID: <606ae17f-d23e-4a02-9258-06bcc1aec230@oracle.com>
Date: Mon, 20 Apr 2026 17:07:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417143023.1551481-3-alan.maguire@oracle.com>
 <20260417170712.74E77C19425@smtp.kernel.org>
 <40708ab6-7a2a-4c7a-8943-88f25c13036c@oracle.com>
 <DHY3FCU01RAG.1AACAGEQVBFCY@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DHY3FCU01RAG.1AACAGEQVBFCY@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0130.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::9) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 956db4f9-8e33-4951-c441-08de9ef6de51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N9bTXRtl8La+j3wT7KcBgUwueIknYAP2jH3GlD/mawao4CCFHs8qysdXgvXvu/M0EJAqX4keeUfRUvwwP2zqug2YarNSHzzBGhc1gKYtC4UDQR0bFimdpC50qmaIl2PCFcfidNSp/rpm2MKxPkRxicJYpoPzAs58dfxgL4h8IvvmOuY8gjrcu7Kz3smN5jqmOaStxCgP3ummvHOQKyMIe3LgUNXJUw/BTG7cNOruyGwECcQkFV+i1T2cNenznqiO3tX38bYAJWyKQ6bOp6boXBR5Fi4NJett6pRZXBU11fg8Meul6RZYgeJulm3Kmux9ptQeuVanczGHWrKjZzpTcEgNhqPdhjcYxQPRYSA0g5qG6T0uvcOI+xzKIbTHLRaXq+79jRayBXTicOPGD6wuiBH3kdsK/XeOWFGDU1yaQHP1XgtafFi4DVDfuobdx6c5JHzwyuruUnY7qdOo2LeXnSRqpR7g8cPJa9j26jfDCqmN4raM1WWku5Vj6Gy09o4jbU6GZhpq5fG1BphKjGX4XJ77WUCjDMC9fDUuvy7ShqA1FGjvBrAAHrcSAWkJhgNnxU7CZgg3Vhs+Vr2/7OlrladYUccHxxRHKne5JjLC3ZWhhCfl4btBy+qfPKgAykrk9kCNDWfBn19blpKVn2Ul1ImWOO7CoC6S9hr1S3JrVCQ0y5sCi3kLsRCNdQ/W1Ib1FideAyN5Fi77RGdfXs45PIhUQoxIVAjXWzGqqFR6G4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUsybWo4OGZCckU2MU9uVmdpKzFzR2U4Um14cmxLVXZYM0ZXN09UOUIwRFZB?=
 =?utf-8?B?S0JESGN4VUsrRXNVK3l5Y2xPaFh0Mjc0eXpSN3RBbkhCTXd3eUZMcnVnaG9W?=
 =?utf-8?B?WUc5WTZDaS9ES0phZWNsQXVYTlNVdDhpK0tKaG82bTNKR1liQkFycnpuVmZZ?=
 =?utf-8?B?Y2VwTXFmVjJQckdtQ2FCSkc2LytoN2tYN3RZVllwcjBQRTJxWkFmRDVNZ2V2?=
 =?utf-8?B?QTBPRHJzMVhTczhCczRUTEVjUHBtREE0VzVOQUwxWTZneWhwSHNsZm43THAy?=
 =?utf-8?B?UDlpYzFmeHZQaHVVNmh2NUgvOTN5ZitQaGZReVo2cXhvNXk3OGNPTU56aDl2?=
 =?utf-8?B?ZkFsWG54RUV5azczTkJKU3pudDM3aVdtNThRM3pMbkpGLzFzTXQzbTBHbzR6?=
 =?utf-8?B?MTRWdkxLTjZRK0t3RjUwS1p6QTZEREdheXRFRlErSVRGUmJOWEdVZzc0enFa?=
 =?utf-8?B?eTI3dlI5amRHU3hpdkdHK2xJUW5yaHJXZTFUQkp0Sk9DVS9TTTc1Tkpma2E0?=
 =?utf-8?B?QzUyOFN6OHFSNlg4aTNwbzdzUVZjYitvUUZ2VmZHSjVjek5jaG5uT0Y3U3Vi?=
 =?utf-8?B?UUhmNURBVDluNGtPV0doNGxwbzhqNXd4bDMvS01FRmJOL1d4c3V2NFNRZjl3?=
 =?utf-8?B?bE96dlZmcHZ5K2JFQ0lVNDZKUWpEWGZFUVJpOTNta3BVRUsxdzRQbEg5ZkE0?=
 =?utf-8?B?aTNZaHZ6NEErSTZqb0VYemFiYW1ZQ2pBSHIwS1NvZWlaUW8rRkFIRGRRUHNR?=
 =?utf-8?B?OVRvTkJwRWUrTVpHSjJRN2lJYnNwcTBmWkwrb2RFVEMyMEZvQ2dtZkxDa0lB?=
 =?utf-8?B?WkUxVlJnNjRtd1lFQ0QyRWFNTFZKeXNGcFJTV0ZjdmRienpZUE53c0psTTZQ?=
 =?utf-8?B?TGNrMXZQd1ZSYXIxaU5jODl1QVhPUWErdkVCV2U4Z25aeEZ1R0pJTG5uUFBz?=
 =?utf-8?B?M1JOY2VYMC9XTU8xbndsY3NyWjd1U2JBQ0Q2ejlTYWxiek1USTRGV1ArWFYr?=
 =?utf-8?B?ZCtZZkR0b2g3MjFCNzRNS01ZUkRXN0RzS09MeWxjR2xsRndOdEtxdEQ4aXNV?=
 =?utf-8?B?MXU3bkxMa1RsS1lINlFJZmNIYjQ0TnJndzZGWWtqQkZiMVhKWmNMR1kwZy9z?=
 =?utf-8?B?WmlsWU1GRjl5VWlyK2ZReVZSeEZHNE9oZXVrY1ljaG4wTFpLdHQ3UVA5T1d1?=
 =?utf-8?B?dFJ4WnNKcWxCbCtFRlNoREhSU2FWNkhIYXVCb3Eva253QWlpZGpFN3cxKzZl?=
 =?utf-8?B?bys3cllCN1MzdzMrTFM4aktkZkxhR2N6Z0EwOTRqUzVvb3Z3ZlBhOUJUeGRp?=
 =?utf-8?B?Vzh3bXY2UG1vTzdiczhzMHViWC8ydWZ2MmxQL3NUM2UwSW9BNjVHM3h2eHUr?=
 =?utf-8?B?YlZkOEtrMVVWWFE3WG1xMlRQZmZmM3k1L3pzc3A0RXRNWE9WKzBoQ3AxWnUz?=
 =?utf-8?B?c0NCZnpjNDJoTmtmOU5MT2dONjlweCtWeUVDbDRYNHZGTTVrbGpLTitNd1kw?=
 =?utf-8?B?V2wyMkJOYjJGNXJRU0NaOU1XRkJuWmtERVhLSTNvNm42MmI0V3F3UTNFcWxI?=
 =?utf-8?B?VmxyeWZNMm13Ry9mU1VCSE05cWdLVDBPQW9WcGlmL2ZVS0FzU1h6Nzc5bUNw?=
 =?utf-8?B?QS9jdE5oOXRrNW1GTVZNV1ZnaW1zVHkyaElpWS9obzVwVFJvWnVQSUkxSUdP?=
 =?utf-8?B?UUY1MWpwR3BpL3BySEtJWkdHN3FFK002Tjhmd1ZDVjczdkFxeUpkMVpIWXZN?=
 =?utf-8?B?b1hsYVNuSWdjNytDRTdsTDlrdStqNUMzOFJFRjVOWkRGMUZlUXNBM0oxR1dX?=
 =?utf-8?B?M1plOVk5b0Z1SEoraXlRaThRWjVVZU1maTJsaklobTErVXhPUUM5MVBLbFZ2?=
 =?utf-8?B?QytDcnE1T3BNQnB2NjhrcGE4SHBWZXE5ekdIcWZlNVhTY2E5V3hURldHK3do?=
 =?utf-8?B?bllwY1lBNFFxd2ZocVEya0IwRGg4MUdPcWFrb0hkY2lXaWllWXVFeG9RYVhp?=
 =?utf-8?B?S1hTSEY5OWlrbVFiT2QwL0hibWVtc2YrYVFMM0c3L1A5aXJFVFBPdzRVck9j?=
 =?utf-8?B?dmpkNm8rR0E5a3ZaRnlvdmtKWlcvWG9SM2R6V1NqV2N4SnFRekJ2blhyNCtC?=
 =?utf-8?B?N0RyT1JXa0VxclpRdkFUVFJYVkdlUU1kc2Q5aGdldmdoM1VhMVppNVZ4dkRM?=
 =?utf-8?B?N2FVRHpLZEdJeEptL0pzMitZTG43Y0VnZGFTZDZEOHJGRTc2TzRtZFozcjFV?=
 =?utf-8?B?d0V5dVVxWllLMWdoQW5hVFNPZVN6S2pWRGNHNk80eStsREJVYkd1OGVLYlpC?=
 =?utf-8?B?MjMzREhaNWZldUIzc2NER0Zzdlk5M01LOVltTHNUWitFN0VoQVFWdz09?=
X-Exchange-RoutingPolicyChecked:
	Fu9b5VqC/6mNWhgMRsHGIm9Ib0UPzBOlxUeZjuk6x60U4Z4swE9uNnNf1eZUzq4UXwN6md+/0HDTQNmYlL1rxaaZcY3OP7tpuXR+PjhsMNkYSj+t66zXzey+8LV/+m3tOsoYqPA8NSyhAwHvy9Gzdc4Ra4VVTOJxiQBbG9V2X3RMSgzCV2H9dG/j28jf3+5n2kagDz1JaJ9TwAAIDGCiTdhzm7Hgfaeg2BlcKWyqGLMKi6F3wQoHttRvM8bJS03zNCpwPv7BataA3sQJ6U9B9wofdLPS1V4373d2Sz80MOcP4NvohrMcaT2xWZ1ImTL/Wh+a0fAiwwyOduGpAambtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iGS0tWf/kTfPf/5JGfc6UBmaf1s54L2nkCUQ/F8JAlFgsMNXItLxCYgaRRkbsX3D+tbyzFmpklgAuSIMfk/y6yTf26EByC6yMyepUE6KTnoF7DyJKSnT0FtE+caADU4WdR1rh10rKp/wE8TO3HBLunTq04mNdBTxwT6oVYhRLgjXUEwtyAxZgNthHP+Xsx5Y8gD1eTS7LGJse3f7BCdawsAj5IOu2W6sdCLUJPxVF9hCB2g9QR/RK5EroaARFHsTNSdCRhQjp0a6CHF20BBtRQgZ9oV8kNIJnsXSsnZMCIrYbTz95P7Q8x9Sa6680d8Lp1tAz2v1OaOFYz9ci4ogzQgJQ0WIxNkqfAl/9P2UUreBX71MwjsLNYKe3gPvPfLGkm2kQp6oZXDXwd5tNsOx0GGog3fHlKbsTEYY1lhZTYBMHtRInUgdmm/BZfUz4yYkRKDEPavcj0EOrzpEiEfysazDd+rqxcia/4aFFKFOlSJy9lKFvQYtMBPfh3UlNLU24knrmrfxQcpjClBrIk7KcRsO88c7fW/2kYY90wdE3ASg+I7OVQiWnQ5phdDIe4WzskGKtYv6y4c0hrxsZ7s4wZzY0yEwM2+OPaYL7FPTiVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956db4f9-8e33-4951-c441-08de9ef6de51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:07:06.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2MUWSTmC9+ajfS3MYUVosvrk7AdNLkc9adoS+80iImKskAQw+6dnV6Wt8MmhPIfi9AQvV8+1fbNfurQ2Z81nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200154
X-Authority-Analysis: v=2.4 cv=BaPoFLt2 c=1 sm=1 tr=0 ts=69e64f2f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=z9tNRkFKEiWJI7UlmFQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L4gcLMcC8-sA5A2PwR2KLO0-jjoDnmRv
X-Proofpoint-GUID: L4gcLMcC8-sA5A2PwR2KLO0-jjoDnmRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1NSBTYWx0ZWRfXw/1uEb1YQ4gs
 ZboYBtMBey+u6d4GeWTDlLTOLETzjMbGTQN5V9arVCXGYuS/WFnHBD8bhwYiMIy3V4B71iZJfy3
 SnjkRc27VTNolrFp0RX4nwZ3B0N/D9PQ5gQvo+HQrgNQN2/wFzKkKu4lbskJxRdxmheDAQQUNBv
 y5fpD/6X7xF8Yp7ORR1bREFlZGy8EF8yNBcf2HugeuxwRam+SiMH6alNUv2zHI/9bHQ+OYdB9PJ
 ht+GyHjBlvkixjllBA4J9fTAeeDwnu6Y5p+64bKhoNYRoX2/MGbwKCXPPPiZsRseGsFMW0bE9+N
 LUGu/bvsq1X8RumVkC9WfC4rWj5A9uWB6E8Vc+l3T0pAnEaMwt9nwRnTLDTKA5QQjc/Kdk7eg6b
 RFrFztxFEC5K+ksUVeJtBMIpBGBqQ5g2qm6o35Yu82Hw5tCLeMqaJVXCjWg9AP4OUlrkJunzXyZ
 ZoG1oyPolUOUyjXoNCw==

On 20/04/2026 16:39, Alexei Starovoitov wrote:
> On Mon Apr 20, 2026 at 1:02 AM PDT, Alan Maguire wrote:
>> -       return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
>> +       type_size = sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
>> +       if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
>> +               pr_debug("Overflow in type size %d for kind %u\n",
>> +                        type_size, kind);
>> +               return -EINVAL;
>> +       }
>> +       return type_size;
>>  }
>>
>> Given that this problem exists separate from the extended vlen series, might make more
>> sense to send a separate patch targeting the bpf tree for this issue.
> 
> Make sense to me. Use check_add_overflow() when you do.
> Are you still planning to respin the set ? or is it good to go?
> 

I think it's good to go; I'll send an official bpf-targeted patch for the above with Fixes: tag.
Thanks!

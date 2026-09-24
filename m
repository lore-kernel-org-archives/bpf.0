Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC34A260B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264048; cv=fail; b=tqlK21xiEIxKpz7YuTqukVjvRG7hWvnsCmUgXhlVJ9McVyNxHN0/0pdqUtADfa9zqFiJR0ZB6hWdC9Bom3m0AgmxzT87hLTmHwstY/FWa2MklHQcD0l1W2rIJarIv6ZwexYY7Y15MYDy7ItVLOlZAsel+jevsSbSPn3EnzsqT/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264048; c=relaxed/simple;
	bh=SHV6qp8QaVW3UGbVAJdeWIUBggZOGp0ywgNjkJI0XXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t7QmsYczkze/cObpNMM2jqA46dkM1wz9wYaqE5Uo35MbgSxZEIwABft9DN0YyaavgLQWblFmDjSLW49Fb3YwesYLkMNLHDOnII+zbs2oW42PL2OlRMCaz1pOC6bCPVnZ2KMLGh4W/MbrzdPMmbyYcJ1OU5GXH0Y+4sE78l1bT4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XUaPXO8V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tCzj8UAt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XUaPXO8V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tCzj8UAt"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ODir8J1362146;
	Thu, 24 Sep 2026 15:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wr7aVFfxPAINmkB81mK7vYnVH6F+ppS6/Y7OWh1D7Kc=; b=
	XUaPXO8VbJflbH8HZhWctxW/HM5CBo2iM77/5tywccwuarQb9l/ZLxNaHWUWHUkS
	Z2eqFxgrunc4uzRKxjw00ug4E236snwrAMCClTr6uoT+SGHMqNCeSRtfSmy3eshA
	Kw1G6aXMBJqpTUk+LuMjFC3ojQ2qWJzb8SqZBEaG1SAlVizQmKtQN6GLBdJAPEXW
	9BU/67cKFP2SOycg8xcBpIfuG9fZlPCzkfkXOBd2shAqezpuODuaIZ0yZbeTxfq2
	eOoBGIW/Nk1s81n1j+m3Pk5hZHd6s991qit/Gt6SA+Qkp+RJGrFlYg4R/2Sa4BkH
	ENji5Fl3YOgA+Z1PINH9FQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qfye0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:33:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OFKbIU028531;
	Thu, 24 Sep 2026 15:33:41 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gu1rd2fy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Sep 2026 15:33:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTEZya1DM9+zC/YIkkFl528iP+IAm56JrXYen8s95V3PlZcZIzs5vQy7/7PLyZs26ik7Yb5//XoWxsJN116xImUpP8M6azzV2L4gPy7Kwzcv0166KGDHLH6pfMM2FmGidRy5vGVsSW9OuEk/dM1XF71tjF+wWusVB9J+oRzxgXj3SDnaBaJw3u4okjJ83bMF5lnZg8T2vjVXl0q2QUP411/kvgbotU+Et3EsE5YjBD0Pr7RxG8OFOH/eQ+DRkdBgcSMYcajAmF873fuhnWS+gPeVfPc6wQfzN5v/CgnFMkPn/ZOkWs+mtxJ3dp0fPmDT5sxsrLZNj6dZRlGZzRaZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr7aVFfxPAINmkB81mK7vYnVH6F+ppS6/Y7OWh1D7Kc=;
 b=iira9c8Un9Y6RXP0uHtCGsFpiCRdUUnC3u5u4i8mkMdYil2cRL58CKA3elKVpktr4zJXq+JfMeUnqRh4No0+kHSXKiNU4GHg1jozrod7iIyNK2tOZQqFOObkD85cL+mCj6ojZTLFC9y6uftX3qthVrbqPTfFGJ9d2aQGnWgUy5fUpQu6SR/SV8ivMcGGlt2n2/AyqGBNOgtiLwXGe093NgDkxdJd7JgOYMqdltd/7+LcFLUexhpiPer8kvuAYsYN2dylAK8C8AXtUATy8hSbuinpiBBJmne4NnEbDUOrfuAHU1zuD/pdNMLqpZP4FIZRak5T4ujSWM/n98SzST0hpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr7aVFfxPAINmkB81mK7vYnVH6F+ppS6/Y7OWh1D7Kc=;
 b=tCzj8UAtyBE5d6UmVPd9bgZyxlsjfxjVp4lWoP3n3nUxRAx7AAJXGLTdgr4TuHbQz1sQBDqhaPet7acRoS9JiX7YNjluVVls2eowPpJYjd8tDnsFa3f03qyOHh+Y834M1FIYaPNiLDF6BhL+x8CDBjbpwTIQd7NtPBna0Wy3B5w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 15:33:37 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.005; Thu, 24 Sep 2026
 15:33:37 +0000
Message-ID: <3dc200bd-1e24-40ec-be53-2d94c0feeb14@oracle.com>
Date: Thu, 24 Sep 2026 16:33:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org,
        eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
References: <20260924111428.75957-1-alan.maguire@oracle.com>
 <20260924111428.75957-10-alan.maguire@oracle.com>
 <DLNN9DAADBPQ.18FN1VMU78XSH@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DLNN9DAADBPQ.18FN1VMU78XSH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa80521-29df-4f37-9d5c-08df1a51338f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v+c1EjJv9vijtWoIw5HMIJUCzgvzpAMsLsOSm7I63EIBlVrp/5gzs/WBl+iBp5w3vt53oFwbsqGv9E4o/L6exvdayxIuD82KTmY3myDdgWe5FFs4FU31J1mXbaq3y8DFJiInjbAwgwOjbLfFC0I+GPfwyWb4BUFlyOaRV800KbgtWDxteHrdY00uIXwZKKEz9qkyJfBFChxhwnWfaH8vr4j0/QCR6HPz50FeT0k+qfTN7Y9MyEl79vR+2ySRArORXsEiAcx067DnmhXC2WEmgeDnECSJktIp2bhvc1V27ORyX2qrUf17yop/G45o9bJ2BznPc/ct74muWje3fpc1lCtiHSJqSNwZCZeRJc6eDpHcp/nuitfOYXebXjTnHUKhFla9UJ+hbJJTiyt7GGAbgCANuUdveHJcUfjoSsLN/YPvmrirzDqCbqFS6jZB4e2TaOvmLDHqp3GYsLQi2QfRFpPGvCUqPrjedBf/jO7KHpTHykRBIIce/iX1lYTfbVBerpq1wgs/5oWJKeSVmIW72pwXvqhd/7oXyxxwqiJnOWNQw7PEhy5Dw6i3Tu4cuPnXQGn6Amydl3Wgcyz4idqh+RXgl3ZIcMssR8N5ErSu/pWu5sXik0FUEIs0SlhSFToCd/X1CWTaw2/M3KgOeq/C8zv35VO0IE2J7amDv3HL+7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlZQeE1kT1hSZTN4N1o1YXZSNlZEcUk5Y1Mwdld2cUJuRVRqVFhoYnEzSlNO?=
 =?utf-8?B?dGIyNTdLVHd1YzhvUTBNMDRIMXV0Y3p3UXp1alNaUkF6bFNsN0tVVWllZlRE?=
 =?utf-8?B?VFlHSkdGU0xid2IwZXlXcjN1bmlOSXhKYTJoVEJMeDE3bHlTRHFtOTJacEV0?=
 =?utf-8?B?eWZpRFpIU3Nmek1xNHJwcGx5SThneEVtRDFwYlBrdHJLcVB1aEZlOCtGRDYx?=
 =?utf-8?B?YWZ2RCtJU3NldjdtRFNuNjV0TXlxQjJVbjlUblppQ0xMVmVSUDh4Z3RjbGR0?=
 =?utf-8?B?L1F5V0lyM3BUQ2Z0bDd3K0dIMllrQkMyNEJiRlpwelM5VlR5elpDMjVGZTBX?=
 =?utf-8?B?eGluK1VyTldkSERIL1I5MFQ3cERyQTFObnVBWkcwRUZoeXJSTzl2clNzOFdB?=
 =?utf-8?B?R0hJME1zNm1lQThZVlVoU0MvVEdHK3o0NmhHcFM5TFdLYTRZeHZHTTNVbDVU?=
 =?utf-8?B?RkRHV2ZvMDJQamhIV3B6dXY4YWJ5MjBnQ2laNmF4ZWx4UlMzQUNkclE0Y1dx?=
 =?utf-8?B?ZUdVMWJuZzFnRTBBUmFoZU9vTGNlSll5YllpeGd5cTdtd3pTUHByWU9HeFJ2?=
 =?utf-8?B?YThpY1EvV1NnSWl4eC9vZlZwVTdBSjd6TkNBYy95QUF5OE1FeHVjdVp0OWZW?=
 =?utf-8?B?M3VZQ2VDQ2g3eW1iMVdFY2RQUzBzQU1HNjZ0Q1FRQk0vT21vWHFuVTFnekdF?=
 =?utf-8?B?Z1RQUENnUGJXOTRXYkh5OXg3cGNta0ZoTGg2d2p2b0k3blFVMDlkVk9ZbWZR?=
 =?utf-8?B?ZTBZbnZGUVR2ZThWSXlPNDM5TjlGNWRSZkNDUUI1TmNTSnJwcXpxRGlNd25Z?=
 =?utf-8?B?UWJYZ0pNYU1lalZ6c01Mc2ZBOWwxZmRjN2l4R2IvMnlkMUxiM0xhMnppRU1G?=
 =?utf-8?B?azdFMlFvUklzeXlkVE44d0twQThQeHJUaWIyVmtEUU9qQ1pwNmdFa2EraTk4?=
 =?utf-8?B?bTNhY3FDZ3l1NVdTdlJaZ1Q5a1VlbmpPWEhTdG5tK2JiT2hnTHRhT1EvV1dK?=
 =?utf-8?B?ZVlBc3pNc1czS1ZRNWJtU3ZvdnN1Y2JwTW5iVHZxY1p0emRlV0xtbjgyUE1z?=
 =?utf-8?B?VXZqdXkvSk1mZWdWUk1lOXI4NWV6Yis1TC8yZWxTejNjTVFzTHZSTHM0QmNu?=
 =?utf-8?B?dXN6TzBPa3RDNEs2WU9WZ2JJamY0YzVUb2JWbG5TclJsaUNhK2FMRFZxM0Ur?=
 =?utf-8?B?dGZPbjNtU2owZkJ3aDVqd3FtVStjakFMQXNscExNUER3ZmNPb09lMjZUWmNP?=
 =?utf-8?B?V0VPWlpMTVNVcUhYRDdGVmtZUHU2cFBveENmZUl6SkdhYUxaOUZLNnE1d3RW?=
 =?utf-8?B?emZCVElOdDZ4d3hQUWU2LzNOYS9Ock5WTW9FR1ljczhVYkxWWEl0VUt6aDFX?=
 =?utf-8?B?K1YvdUUzQ1ZwSk5XM2U0Rzdpd2QrT2ZUZjV1S2Q5S044dmZFVk5WUmhwUmho?=
 =?utf-8?B?ZFNPSk5la0VFaFc2NHM2NlhEUHIzOEY1WVJRZlcrdWRMQk1kZ2pvNHhXdmVL?=
 =?utf-8?B?K2dWcCt1Y2NJeXdQOFNyMXhCck9CUklKNmRRZXkyalRETlJIY2JiVzFPck80?=
 =?utf-8?B?OGdsdUY4MGJ3Nm1IRDlpeVZ1Zi9DYnhjYktvUmcwdDEzQmJSWitnODEyVysz?=
 =?utf-8?B?TUFpMTdOTVNqc2hES1R5WDlPZVhxc1BVdXRtTzExTzlpMUlKVWlOR1l1MjRK?=
 =?utf-8?B?ckl4aWFNeE82eWNIQStOMVFwZjdkZkloNXBUTEw1Z0t1c3hEYTNTdk1UZlYv?=
 =?utf-8?B?YTF0dVIrYVcxZ3N3M1lwZGhLeXVyck5scWpXc0pKWnJoeDkxMktSWFJhZDF6?=
 =?utf-8?B?LzNCMmZvYnYyQzRPL09FQzFRL3FrakEvS3VEY0wyVlJtNXJPck1QZ1FIMHN4?=
 =?utf-8?B?d3Q0bGxyK0NKMHh3dGtIbmVUdk5GOE5XZk15QzRPZWhJeTRRMS8yaEVrK3lL?=
 =?utf-8?B?RE5ZMWtaN2JhYWJsVTBveXRHN3RyKzhJbDI5bnJBVDY0RlZsK1J1Q0RjSlgy?=
 =?utf-8?B?TnhQS2RTUmwrTDh4MEw0eHE0ZFFPWWF1T3lVVmF4V1VCWFAzaE12U1NwVGdU?=
 =?utf-8?B?dUgyRVJxekNKMHJtNU9vc2UrNTM5ZG5UVTFUSVUxYkk5QmNjS0l1d3l1WXBF?=
 =?utf-8?B?WUxRR0tOWXVFS2ErUHJGeGxodi91SHRISk9ucy8xL0VYcTFvdlJzL3NNck1r?=
 =?utf-8?B?VlBpdk5ibG80QXJZNEljNk9DQXRmMFBoVkFHeVpSNUdlWTY0cW9VdlZhbUQw?=
 =?utf-8?B?RWY0cXAzL3ZZTkJ0UFFIRWtOY2l5dnhHOWR2bGJ6ZjZRYjFidWJmYW8yMk1V?=
 =?utf-8?B?d3dXNVJNZU9qNG5IZGx4WGs1Z2dpbjJoZHBOYkt3aEw0ZkZmTkh5dz09?=
X-Exchange-RoutingPolicyChecked:
	QcQxQDe8I9kmeFp/zKERDuO0kT/fkiDvq7TxPpEf0Ztc+HUgkauiAwLCuxV4d0KhhO5foB28/F/UB/xu7lppbVjDvt+wJ1SIj47I0ZLY9xCC5W1bwbhuaramk8vDxldiwhf71cOzA93BWcw8txiTn6jW1jaD94jpQl7BUpCZDxzX+AxjUoSxzjU1WAE352dA50ZwYpLiQt31wuPrhfowFb+CKP9/rbYwM9m9EphN2Y46wExtomN947JYtheQl41nY4rjlqct68jy9BO0YYwfG/HNaADpJnre8iJOnvggFFipvQ39wTf1xVUkM5UimVoGT4QTILcMo3vkv2NDyiJMcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7QRA8UF5CvMH2/ewBgMw4bxH4x0Q71+a35XXoRY0cjoUjbU5cvjqRuFSNsC819NVlF3ExIb0dpfc+rpuNp9QHlf7vCRdVSmR/9if+bJVI3K2PDhb7QEYIk79/WftIU2XXulLU15a6zfPIFCK/RLXIdzrpzi4unk1HZcXeG2O7QeQIcqITszg5QZVswNl7DHhe2mGpOlCBdicj+kPBgmBMCh52u48TqaTLroxUa0oDiJXxW7BL7JtJOxoJIibgBPWvRax0NxghzCKj0VbwL+nWoOHjY1HhWehRNQEbtWmoUYnEUyBVTjyRlqxA2uOH2agXE4sA7uyVsLs4A4P374aRRqDuMoXQy9k2u6VwkPy+eLyj6gEMXQDfuZdZo810+037LVrhRU55BUT3vLn0fSKb/Jd0Ou/oSRnnAKKhniLLZ50nF1Kgc+M2l+xrKnArLmCPlxlR9Pz/cEE1ZhoUWp6L2C/2w91hv6tw++TCYwodyFKvaVWXwEBt1BhwF+GfrbDFYNh+iEE+K0KX9YdwY+CR5z7X2HRm2Rx2RSrpQ5M8mDOaUTjoCYCCuDFh3DjasFJrqF/+92nrHENOf7PxfoOztmc5UwGdqTL2nvMDj+FH/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa80521-29df-4f37-9d5c-08df1a51338f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 15:33:37.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eevfTmUstIlaqf04WvHfOjrLmZk7i/2OLQsZYFfaLSxS9cTqcX2gbJJP+/zJ1hFC1zX9prPYAtZw9z5ojyVCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240063
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX+w8ECtbW0zHu
 jNA3rUH+yUxRQIcpKKYdm3YoxvZOFiH+jnEbsdgj1T6+k+SW8sscIO55dBmIegidF/8J2FZ2l9U
 8iS/W8T5e57ntlEpE450Fb0kdbfhOohO2Rg8INxBH7JhDghVBBXA
X-Proofpoint-ORIG-GUID: n1M4WhwJu7W2KGlFEOz41kBdbwmMqtbS
X-Proofpoint-GUID: n1M4WhwJu7W2KGlFEOz41kBdbwmMqtbS
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab542d6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=EwUd0v5pEmvV-QdUe4sA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXwYHuQ73SHdVP
 yY0BO/B+lBFWbm1UIje48Llss1HPQHim4ngeiYa3Ar1YI44wQPLVRT/ft+PCRBk7k4v3lzXO9ZQ
 uMAodIxRReg4Dh+1+KWedH7iVmVdR8cuNQpbqIVZq/a6uEydICxAcqaUFdIs9u7UfCNRGSnwWTV
 EFl5WzIwNglDnvydJN15tRGqLTbRrSO/XTHvSMWB7ska/FDKkVub1ksESo+TdA/09HQ9f8vxl8u
 N1Ms+XK0NSPNl80Uz24Ta+PjiuqjySIw9vPoWBZWljC8milXYfxOUxKEyJzGn/pjttH59FkBVic
 p5oKRfp5Hk1ytu8/tM8M4ZWfno+EeiAPhZG8u7pLGbSz7229kqYqD5fBgF//Uu8cWWg9mmHWui3
 3+WHAheUX7ldTVQR6Z2y1Hlw2zKw9zc/DXj0cNP0JAgwkphWtEX8NMCTgHC4NH0w4SQGVNHDVFX
 ioKkpdLH6gVDlzHODA4G1qT7ShSB4fnrcwERbNV4=

On 24/09/2026 16:16, Alexei Starovoitov wrote:
> On Thu, Sep 24, 2026 at 12:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>> +				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
>> +				       name, locs->func, locs->loc_proto, locs->offset);
> 
> My earlier feedback must have been lost:
> Pls print argument names and where they are held here as well.
> FUNC_PROTO has the names. LOC_PROTO has the locations.
> Something like:
>   foo(arg1 reg1, arg2 *(reg2 + 0x10)) offset=64
> 
> Or is it planned for follow up?
> 

Ah, I missed that, sorry. I added display of LOC_PARAMs for LOC_PROTO; didn't add
the signature for each LOCSEC entry.

I can respin with this and the vlen/flag checking for patch 1, along with anything else 
the bots dig up.

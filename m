Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794893437;
	b=0D2B6ITmsCEr4vx1OK2xqe8R+LWCIpy9WSw3xh+yBPY/DSJiM8FkNXnGDBf2/AaGnfhg
	 dnZPuV8Bzrzffxm3dpLNuPK4Xfju1eac+Xa9g7PL5CJu/rltPNfUXUeIqUx2LMKADh9fB
	 E/LafqrdBb4F36VcN79z7mXTMdG0kERUFbMrkwnwk8lRxCieYuknCMYm3sI3TnlAWEQAZ
	 EaabqQNq6zvvrVHjz3sz0Ry+Sq4/8Yjb+idgLmjuFm9vkglwc4Kbtrn+tJmjecQ8OIG9A
	 kQrXpD0PT661eWGgfG9mQtkqB97VuSfIlVgzoYJFWXXKyjSLQHSwgoLdfDuAJgfO25Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:References:User-agent:From:To:Cc:
	 Subject:In-reply-to:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID;
	bh=YsXq/CosWdJUvPC9WnfESbokXEd1jSNjIaECHoyl4wc=;
	b=RlXv9wDoGWdQAF4o8FL8McOFHU8/s899Gm8dFuaERLDpLy9MK9to2lwjpgumwE1P+YE9
	 sZBc3qEqURpytN95CXSpmXhGBByreV39N9szfuy2VXcUQcempHAvzuh44B6KORsrPOn8J
	 Ac9XWuDFXRPe9quXvepBlBVZmDRcpndLsrbz+dT+HxpjBlBZKbpYYi8HOt0gR/XNZO1mc
	 /PoB7/3az4leDEjKvXYTVzKq7+9j6kqn1FuTM0/H/pE24ldP/SAfinn0VVKq1AydFDiSN
	 nryf88hFg6W4Utn3ZNhQP5/0gOmBIx0Cnzn+U64NJDKtkvBDp3D1yQD3f1/j6qoMRXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Z857jEcS;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VZ5XgsnJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F437606A329;
	Tue, 17 Nov 2026 05:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F437606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Z857jEcS;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VZ5XgsnJ
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGKrJAf2600269;
	Tue, 17 Nov 2026 05:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YsXq/CosWdJUvPC9Wn
	fESbokXEd1jSNjIaECHoyl4wc=; b=Z857jEcSPW2Z0ZISM9qqv+pHmGOSxcdz1C
	lVE9+i6EGLveszNvXOQe3ptUA0P7J05d9jdm0Ai9aB9jG6p7w5oDzUxPi1qMIRr8
	5GxRruRh10cvnSBTDH/XqBSkCBGpv0pGCsZJQELlNUT/6UB5j2Qb1rGMslIuo+xs
	jOHmwvfRPpN3Qcwl6I2zxsRNjQobVy1FA+MXWANBJr5WfWSsJXOtzDE9hQCNa88b
	vm8NBWqon4HpNRpU20bMM8RlrkRIDCnYz+vbRsB0Taa7sPWT8EzdfjHSc2Rj5A7X
	T89y/ySyco+MdD5DqfBB6w/v1P/IgF3paee7qEJ3z5CBacqRVMdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxee43c0e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 05:30:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH4q6Sg1891791;
	Tue, 17 Nov 2026 05:30:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j0g9ah964-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 05:30:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaPMMms3Z+Bq9L9P2AatTHadbPe1H0xC/KjpPgKx9b+0P2kQdxxgftbtAf549oUVa910Pm1GQ7AASaMx+KyXMOQ+Xba0PD+alBvQr22FcSMRmxeMZ+VRf5K+WcIP1No19hrk0J8JCLhgGSZ6FnKFB9+1E7EjpKFgWZeTAZoFlRm9GXDSCcaG/gg/cWdbJMZOOcroe6rQG4OP/SEWxIPPE80lhWoZaJg3Ltn3/cBchH+sJoGXyI+aCkxvk9Iyl79zt/EIMa7D0idqs142FmS2gIfi3OVlx6BwD5WwiFxBHGW4bd5ZOW3JMvU21Ntdoa5LQnHaJqiD2/nahuecSPwyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsXq/CosWdJUvPC9WnfESbokXEd1jSNjIaECHoyl4wc=;
 b=EP9tU0y5aDNqhCDxslg5YDwadpTwd2DDJ68eg7tfo5J0iFh7gM9wXbC6WQtDXOdUa9WIPy46KeY61l1lPF7uLbIuLbWEXn5ylLsi6RR5T2WMi1MztyFf3GTP5OEbW7h1A3xpha4gVYc3l5F3WyXirWxEZBXEQBMO+NQ1zll2dFV0vX9hnXIK9aDkEWNg/tuLmy2uHkQNkSTEvjoLgCR2YRheYMCLoejUxuGlDJsVWusI0z7z9HX5B++EbdlyXRE4AGJIoc4lExmYCESKZWj//dPIsva5y4to6nojJ9tIBBhZE2suBAMQsq2WDpv1H74bv6/6ERys6Ga3xoIyTxLnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsXq/CosWdJUvPC9WnfESbokXEd1jSNjIaECHoyl4wc=;
 b=VZ5XgsnJuQN35ZHt+ue7npDPLCTD72Ao1pxQLuiWjv1xctQWJ8cb6OyrI1ZjHtORMl6JV0LUXJetQssAHIzimhtzAtsztGh4RK+sRAsls0UEsSu5yDD+bHZUuBsJd19UcoUI0FxisnsThoV/bWnjbnlI5qbqxFe2vGnCJ2/wZnk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 05:30:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:30:30 +0000
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-2-ankur.a.arora@oracle.com>
 <sashiko-outbox-216555@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v17 01/16] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <sashiko-outbox-216555@kernel.org>
Date: Mon, 16 Nov 2026 23:30:29 -0600
Message-ID: <87qzgk10ui.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 502e34a5-2601-4cac-7205-08df446be519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	uuUhsr8aA4PBhve+TCay76VE6/ASHpPrcN1PNckkFBVUdHzPld55+K9g5zBZQ3eM5sEM34F2u85fWoJzrcQ4fcMbfn5W3+qdWIwOUKYGUkEO6GJM3jshdnUz3T9hmK8Tt95ru3eXIdN+UPeT8w+G94eqGEbnDUijlUOB8sWpJ8axgwdI4WVdO627O8/jQOR53Yn2LUR5enl2CK1QR7T0aDP/xh+0RPgy9GUbLPI6x8m43n1ZYvGCvGcShlOHp2GFr7amj0D4GndGNVux54GBrBS7tx5+2TjaaDZOK4uPkkkSteYcsT84NzezBd2+wRg4uGS9jxQoMU/Pe7AqnQgQHFlpwipr23I0krRizOa914beLE1sOyFoY7Ej3UqEPfyBHk/pEdR60eXWnusbbvIR9oOlf0tGnffpFCPyfzekqhfxnpMSBAkM4d5jjtsLZ3+8bNj6y7oPnM+Bjp3TDYoGoHGDPXcLZ23tQbERmd2JwBON1OGMDw9l3KMCFVJK4kX85vH5xieJ8yN+JwxBCTBNt0S0MjXpRk0At8h7uu5A7tss1VtabkKwKhvhKO1tfNbsQ54hYQ/IKTLweEe7YXlUDMCJTZYueOy8amUu/ReY3Af2WGZf/OjDZqVv/ytVfwh61i/et4HBv+wZTkXPhwdw3Nxftm6Pgy63vQpdzUF7vIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrcOHlD3E8tzznusYniG0K7usuYCDjd/BM23lBMYnLykBsULCLpif/wnsGW0?=
 =?us-ascii?Q?Otc5jWzhjKD4YXCULtLjTCGoW6evyrKwypAdEMlClUbaqZRkyjYJNBxdwORO?=
 =?us-ascii?Q?pQkVfB9SvtihRVtlrgS7g9SQMRr5Em7j9EfOiK1bwY2S8yYBjW1Rz/nm0fR2?=
 =?us-ascii?Q?F4fxMCr/+uCHFSSOOFMSNzbZATl2PkQof8BBz5FsjMDP1JtZsj6RmkpXhyL9?=
 =?us-ascii?Q?3HrCdD7QDuBK8q4aK2gwAhsNUBlUfYYazMz+vXZA8yf3uHQl0hACpYgmjDm+?=
 =?us-ascii?Q?l06Sb3EpcQjOvFrnYU74U6ZL+N91ZSNghVXb1Yg6e/z1AFi4qV6E0m0JUczv?=
 =?us-ascii?Q?Lk+PS2cLn6gKLEbjgNBKEWIGL4IB637XrORfHC82veY3lObri84W7KdxaTuN?=
 =?us-ascii?Q?2MLET/ygcyjihESNKqiHmw3RJNmLNLPinL/hhHJgkSRzKe/VimPxgGKIPYxc?=
 =?us-ascii?Q?zkvQ40pd9NQKA0OT8C/QXsZoOgtQVqtEeeam1Aua9bj6t1kkWZsI3wEHErPA?=
 =?us-ascii?Q?60dZfzkMgxQPK3317BFKZvtT9ehA60420I8kIFCjtTQAWwEk5YuNDWRQ5mcJ?=
 =?us-ascii?Q?1Lg3goU76YTpERYq8t2DJWSmcxetd6h+oGp4iELO4vOuceoj6SDuJXPHIafS?=
 =?us-ascii?Q?D8prp7ub4MSh8pe/K70G4CXwREES27FrWK5Ju1aCGDzE2RNbeoxSEJWijY4u?=
 =?us-ascii?Q?N6O7p4ym9f1vKB8lXp64KltVo+iG80TVjbQBn2qc/x3Sw7TLvDe6wIqPbIgJ?=
 =?us-ascii?Q?kjFC0QqJOX1IQzh34cTHP+U09hS9oMNCbLB3GSU/OobIy1huezlautHewwQs?=
 =?us-ascii?Q?ZXTSu8p0ZdNr/maWM2doDE5uaPdZ/tO4Umnnhl1UcLfEgjyLy8kJYoXPeOaW?=
 =?us-ascii?Q?ubcwDOzf35DgPujGdOh56sy6t1f7S5zY7Fa9PX4MZwln/pKk1g9WsubM0ztf?=
 =?us-ascii?Q?y/WUqvt9LqQbI3Gd1VMvzZ6yGXkvrCpAXrcdQ2lTpKQbDxD/Bi9F+zijnIy5?=
 =?us-ascii?Q?x/emjL4vTByDx7AAXyUzMgouYrHac3OPs9ZEKXnD180Xafh3pr2y8jrd+MBB?=
 =?us-ascii?Q?EHxNsaNcDKsgTAepCJtvOmYW4m+uLNCBh7DfYBMkImoU3tucPw4ZjUF3DwMD?=
 =?us-ascii?Q?gYrLgG15OSqb/GbA1S4tw2ElsNnViyhtxh1vYkBstW60GOSeTRncLUVuhXmB?=
 =?us-ascii?Q?Sl/nuJC7qfJzklA3RJogMiu50yJE/rrfHbqs9PPeFySPMemGUBSQ+GraJ6ma?=
 =?us-ascii?Q?A/9bye+3TxbIjqrhn+YZRjeHJp/tsZYDCF/E0Uu18RgOKo1nQIlpQuiKcgB3?=
 =?us-ascii?Q?nF/dCjQojO9/H8Jb/2IuWv1GX2gghW7MmVUTRKJA0nbOvJ02yRZFGuz4FA5n?=
 =?us-ascii?Q?4SM4C4hCk3WklwHk2zxzrvdZkwBA/N+2HeLxe/HmQziDAzR/xD+bYVERJWFJ?=
 =?us-ascii?Q?SS9B0rvuUJMLUcyLNWIDoobzSELSnzCpLNuNW9mbRu7ByQZIpv4vkOuV+xzS?=
 =?us-ascii?Q?yJNPNW2we02dchxo/ODHCxJGHcb3NxrWiSrc1oL+g0FXQ+OwN6tjjRacJ46/?=
 =?us-ascii?Q?1SFfyXS5T9TR/9g9D5yA+za+HpL+3M91J7JaoK4iLA6XrFP4rdGgrLQGuXfH?=
 =?us-ascii?Q?iKZwX0oYIKM31xQH04bqBb9L7j7j52mbJpi1mO6/7Z8o6gbWrfdg70Ik6KPi?=
 =?us-ascii?Q?nmlsaMNbrWuEeRx2F/fWMCCxoAtY1J385B1e9zwTgxGiuirwB875YHwnDxES?=
 =?us-ascii?Q?Ii1woXugqBkAVL+rJQjNLdC9eZHAOzM=3D?=
X-Exchange-RoutingPolicyChecked:
	GSaZY4mKbgMv3Vln4taw0YRC/uik/1x/kBGNhIEJB07nIRfntYDtHYaOyVgtDqPMb3C/CMKFZG3w4ujjAznFU3pbDDJ7st+iAms4QfaMN0zkdVraO/RlvyjlXRwjbQNwPZNKel2w16+vgyeIBssn5Ha9BbCesJX2Fz6uW2u4dbrKfsyFzE2sYAClH7RbxCoIG93qMgwwcLbQHnmiMAmavFuGXAYhXN6WXAbRL1tWNLHi09h6JQDmXB2Rd+ry6YBRiPggq68FeS3uWJc/QFB6Rc+SGz8ZQxHc8ufLRp8sqI42cxM8hdSh05q2rtGeYrhNz1bJ6KCjU5xKUVo0KgQWBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RGigOhY8SGKmov/TBCYZQq/bHPlAMi7ATe5h2PpH6o/twQlOXzRthEZHzGd25MdLVH2wM8F+WOYjtvrd4OMJAG4CWBpTGPWs589SvrxdXExm/HlH2/4Ag0C6HL4emsi6zQARjGZuOytMLu1YXNgiLe8E7Yji1+SGxb+Gl1npMkq05OQEIw6viOtwaweECK0fJ7LBqf1+q7+zpQ7vnQ90Z8TG7CpXMeFfLdNwNxfxzA13X3xRWdl4qarYbHuf4c2pnddFJy9sGTi5xVcjUQuneP+QcOJa+j9b7NydCYKrvjHpNrIIc6QfnWKW3s2dRqf8H7knF3tgCGP49+hqSh3Rmnx+5q290P1dfSIqSkcnKxUd03nkHHn0BCABCsW9rnPXYNFWheeUKrl4BXpttcnEyN6OvBL3njgttgi+zRQSOjeRNgdB1J9tH+ZgxNz/QS8nd1Hwaw10vD5My3KCmhV0I4DgXszjVH4pdt6FrWFJez0IbOCyJn09l8xqwTRwu4dKtKMbKkflImdYkUEv7FCs08CG2i83DxwA+2CpH2BZgZeRb1WQ+rvhbELAQFnhXrGI58U2EoCZBNDxnmY9+jQx2Sp16ERXCTPzRjCADdbrCKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502e34a5-2601-4cac-7205-08df446be519
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:30:30.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+/1Y/Qm4ATxyy6tfDNAhN+F5KZyc/ZI4sHr83z+uRdBugzAbmrphq65GZmtV2c5ygxPjf9E+HhXCum2cfoPCaSQdPZU2Z8/ybgfDAO3P6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611170021
X-Proofpoint-GUID: Qg0XmPFYW48i-rrqcD2feVFtif2QDiEN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfX46yrCTSL57un
 0OCYsLkmslPZBKrW8B+i+EFpIgwyzHkh+hEAHjfOQFtkAcOO/DraxBG/MOErLBFTgFXYZ6nVDeB
 qzJqr9sbsp2RIxIdw9tw8Sy468bjkzauGiGKViLJVbNL1YTRHYkN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfX/qqVf/cId8UU
 dhLB/jYzYrWHxfucF+FghxjjJN7TBCs99WXeCWB+EGK6Bf/1yOBH3m/IaFuypZTSKGx3z2HBJdP
 9ZBj18y58kTiDNEev5zvaZlHregA4essLjmnVXql/lJgeDMjK/88kH6XnQV39AZhZiON0jHW3UL
 AEm7es1jJarRqv1gkW6ACAVvs2pXknfJ0yqDCm7BxWfxWMq/kL8ojkmIyXbwGJZjWGTQlpMsEhz
 2Mzb48EOSRvQsOzHLoMRSuRqJDG2c0UFNCiZzeTeywke5cQNGoEWrhowByd8hiSwLJHIMvhXSx8
 vvrB58FMDF6DWHrSd04Ij4Q5WqGY5N/KZ/0ddE+fLVcRFUyA752ClyMZb4keUMr+bZcb7ZD/Sdz
 uKJGbL9zwBWRlH9MAbFV8Zx3vQRLBScl8olkIdSeM3bVQXwtwFmA0hXc0RuqemVksLDgSAL2ckG
 RP5JkpQi61X6CrWvdgA==
X-Authority-Analysis: v=2.4 cv=W7utxhWk c=1 sm=1 tr=0 ts=6afbe67b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FZsDQGZ_PAW49SJFbFsA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: Qg0XmPFYW48i-rrqcD2feVFtif2QDiEN


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] asm-generic: barrier: VAL shadowing in
>   smp_cond_load_relaxed_timeout()
> --
>
> commit 02ca6bf44a71704c43817e6ae9df82d53740b4ff
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>
> This commit adds smp_cond_load_relaxed_timeout() and its helper
> __smp_cond_load_relaxed_timeout() to spin-wait on a condition with a
> timeout using cpu_poll_relax().
>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index b99cb57dfcccc..bafc8eeff1321 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
> [ ... ]
>> @@ -273,6 +274,117 @@ do {									\
>>  })
>>  #endif
> [ ... ]
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns,		\
>> +				      timed_out)			\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> [ ... ]
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
>> +	bool __maybe_unused __scl_timed_out = false;			\
>> +									\
>> +	if (unlikely(__scl_timeout_ns < 0))				\
>> +		VAL = READ_ONCE(*(ptr));				\
>> +	else								\
>> +		VAL = __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
>> +						      time_expr_ns,	\
>> +						      __scl_timeout_ns, \
>> +						      __scl_timed_out); \
>> +	(typeof(*(ptr)))VAL;						\
>> +})
>> +#endif
>
> [Severity: Low]
> Does naming the outer temporary VAL in smp_cond_load_relaxed_timeout()
> cause -Wshadow warnings when __smp_cond_load_relaxed_timeout() declares
> its own VAL in the nested statement expression?
>
> Unlike smp_cond_load_acquire(), which names its outer variable _val,
> reusing VAL here shadows the outer variable on every call (breaking W=2
> builds with CONFIG_WERROR) and also declares VAL before evaluating ptr,
> which would capture any caller variable named VAL referenced in ptr.

VAL is special given that it is referenced via cond_expr. However, in
this case we don't evaluate cond_expr and so can safely rename.

Will send an updated version of this patch (and patch-6).

--
ankur

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B899379C2A;
	Tue,  1 Sep 2026 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238445; cv=fail; b=sLP/C3rzcBfjWEVUa38Pz8QaBk4/4AvMkdL0vbFmkUjg3FYdiUoq/0K81cPvQZDY8U25aU/T2UqjWx5D0jR56FOX/DI461bev4GC3lkcGAwuKBYFDQWODDhDid9vcHHUxsbRRtTVhQYL93/alaUdCbxAP+dfpsV/qaxyxP60qP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238445; c=relaxed/simple;
	bh=sitQ/uPzUUca1KZryeyF83EWaeT/PN7OZGj8TuiOICg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=PBK0fTl5H75z4Lals0IhdZ7aYJi7sTJYJ0XwsIQw32F+WV33qEgywPch3rTtPj7joddgYlgXNy1bTbmRsxJ790SrXFSiBGIStTGMlI39FM5cHVa1gx519Kv96DCkLLReqsJcShBuPMwYrjohS5UBf+o4AR4mOrDA4qrs80hnpZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kgqivy+M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TSHs1jfu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kgqivy+M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TSHs1jfu"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VLC0lx3625787;
	Tue, 1 Sep 2026 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=b1dq6PuHRs0F+F0mXi
	Z0u8YXo6Wpu7xg8FiA430MnNk=; b=Kgqivy+M1jgSTIXE1jsEXLEoQiukf3OOtS
	tTap90aMy3j/efXmN3uz8i1GNSx+Q25cHEQSNR8BvFzpgxQGSvS46EkEmm8hKsq/
	f53X3N3O5XRXNa4/ZIyi/96yif1A16nT+uq9EPtb0Fgibjs+zhtU9zRTzWog9G8D
	3gsw2FuUmwRRCBhH5UH8SeGLWh+j+DWKff1g7ekgmzH4oQ40BvqX4kp1Hiii1U9Q
	DpSGPjwkaaF4Xk/o2XcfDhb9BjK8ps/yuCLf/04tB15fIFryqt6rffY5/sBaWOsn
	nrYmbrkmLCF9dITYrkTJUuTZHa2Mekerqexj8j5ewvnGaA6OFcag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqfc3wdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 04:54:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6814o5l8018336;
	Tue, 1 Sep 2026 04:54:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdwkwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 01 Sep 2026 04:54:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD/rYdRQtjS4v+Cs3BEFL2kc0Sshr0UN2vnP2ETuJAwJaajnQv8p8jnXFnMwvwxFKBGvTHRMTXo35Aoifhvar3H213SA8tDz1VK5DLohMwhTY/4wtKHzWSlOWCFhKzytxkVYuVaSz9hqUy1ECAy2YbLQ/Rs2x8p/vOLpothwqMTcQltoeKuEmgq4EMlmpbBu4LUcHzs0pmrOFs4DEpGUuykvxcxK92fUx59cYYQTHV/ilM5ZLQMAeZjf/k2Ka8eNohiowjz2vzrHLpKETnR/U56XaPEMYA0+8/XQqnemQffpISyUUH4sx51Yt7YPt5AnmZxRnY3WxVyZM1lP6bNz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1dq6PuHRs0F+F0mXiZ0u8YXo6Wpu7xg8FiA430MnNk=;
 b=IKO7zHzukQUqf6QanAjZbAb340NDi3bdjqH+pJfStcKz3IANDA9FPSEmkKU6D+r2XtT+xp7vDykYje111LgN1Ml8H6Am6PnZqeil3AMCdUqGN49c0u75AA6edPAMU+7Gi99CwCqqXt2iaZAuciegABQIVadkKxH3J94dTP67fsfh8KnNSNcsQTcE9rOPP86lkHck+k2zERQARf1HGplL8lX0iANE1J/8kwHMbth07uMoZO+vnu/N2/lhMCwvSzpqnDsvNhHFvkEEtuUJZeMpSnz/2QNdWmvUu+IeO2XZfWouyduwEOPxXPZIIakHEwaU2Lo5p2XTghPIfRqg7VKNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1dq6PuHRs0F+F0mXiZ0u8YXo6Wpu7xg8FiA430MnNk=;
 b=TSHs1jfuNUFLofK6QXa1CzrfO/gZTZ3XT+k7MPFB3wUyUFgN1pj09uYJMGxImrI8qsqK4FlKLorfgd+GZLWOc+hmHn7g3JyMB5I8+Q901eO+b+5yu/KnBW33ZMul6lI21oTfhwgXAqfnva0M3tUcQAqG46yFtmA20Kz580W5/YY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 04:53:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 04:53:47 +0000
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-14-ankur.a.arora@oracle.com>
 <20260831232853.24ECF1F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v15 13/16] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260831232853.24ECF1F000E9@smtp.kernel.org>
Date: Mon, 31 Aug 2026 21:53:46 -0700
Message-ID: <87h5k9zi5h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f73e36-ac27-47f2-1812-08df07e5024c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3r45hgokYHc4jo4v4DO8aPqOt39gN70bKiAmH06nPZ0+uMpGY0rV26TyjfdnLz0eOY2lf1+SqMri6Suc1U/Sp/oIb6ri79II6Kx8tF3h/aQG3T+YwnOqsjzJa0Lprh72MbhTFWznHexnDrymmVa2Dpm77TWVwn8Qy72XtbEg3s+aOClqchWkQn6+InefJuYAXSWvOCf0q/YtaTsON09RK7w1JAXrHQtCFhel24UMfkGWhsLN54rDTLRmXJjQVRYuA4Su50JbJLeMOn8slCtFKBTMs0ModShoXmXiEk8gDw9ExonxlNuDM8fxphqoURlv2N5PGHhHWun3vY5MBoSpsi9VMN/Y8BAUcMACFiqvCFq4LTd+wmQGjEim73EDPiWKY3W2vZANBOxOguZ0h0tMxY78H9644UI3wS17Ge0uOiI+xZEXuc49+vjj46UaiWpr7XPoG2ynByBiiNPfvcI5BewXwAqwveQovyWtZLvV3FTJuZPbd+U5GG5yANSUQ/vD8B45hpWMZjP5kSL7m76UqySw9EfIfNN5Wrj8emDzb/qpn0oo1yavHxs6vtwknzRDsS3oPbOYv8slHswSpzONRtL1wlC1r2e0229bJSnjyYNBCZU8NtLW5JRsOFK+y61uuyN33AcBjeCVSSaDyHkKRA+92go/KSxReKIxXKqJI4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MVcIseiKwEkT0Nv2XIvl/MDqIV2cyz8yLwNsQ+9Sf3yYguyPqkMV7/R89tMh?=
 =?us-ascii?Q?sw7axoQv7KksTnJK7RDAy7Jk7Aq7S5+Aqr/p2G4r/RIaoFi1aJxg6Azg/CYR?=
 =?us-ascii?Q?MsLeSkszWxes3qj84kglDX3WxuKhbuj68va9+WNUZXJ0g1uhAyr78DNLAx/i?=
 =?us-ascii?Q?lDo5dbIAvI0/OYfioUDU/izg29oZt7rh8zo0Yvc6FqSrRS+LNwltScudgzmd?=
 =?us-ascii?Q?aNs8mP5tF+cFifkuEvQiNy2yFf7UaXvxDrI90q8/tdClQ0ffQZuxdFMdwCw+?=
 =?us-ascii?Q?OVbKSiJcvmDG1x9UBBvLFXDrTxk0YNhhpilQcJpWTnOvjN3Y50MzNGEqOcr+?=
 =?us-ascii?Q?t7idyv+jNS6Cn34bzGkEOfuICrrBL7OX2Ys3JxOFSYD0GZ8KQk0fdHFSFrAB?=
 =?us-ascii?Q?ZIFnHvN50BLwlthSdcipHiK3KEukBAeGQmBY3PXzR3IlJClIyD87xiooAN8s?=
 =?us-ascii?Q?Ft0BeeVaikrG4eEzsTK6HFKXvcYG7W+EAKSVjIB2yzNUJEtjnd3cBj1zfpgR?=
 =?us-ascii?Q?c8f4nD5pC0EoWCFkFDfN74R0ET/rxCq3yeBp3brYT1UEKigqZl6dreXfsm3x?=
 =?us-ascii?Q?3W5T8he9tuz1zzCwobhzQ2gUPp00uKCUGUoiP0Cl/v/2m5kRMskzYk8QbNOV?=
 =?us-ascii?Q?J+qLuOAyLRuaxO7YYfHwu/f20a01huoB7hr0qb1rvlt/W+uIt+sEfXtV1iYz?=
 =?us-ascii?Q?AtwKNVvSvNMJBzObbcpJM/F+BU6oPERxu9zABdL3WmZf9vJyj9veUHOpeFp6?=
 =?us-ascii?Q?u9lgQdlI/YpKziZS4YPWdgvmOouNyze8KP40iqSNrZp6Xun8C4JZ6/t5DX4H?=
 =?us-ascii?Q?TqyzZt1S8tT5/SS2CjeOW+xnXAqUcS6pxFe8YGrx70Cd+H+WYHwxbCx5BnC8?=
 =?us-ascii?Q?8pxlzu4blrPLHtsBO23GuDXnwWe4HW2bjvlxMCrm63VM8oqxg5MX4Yp7ctmO?=
 =?us-ascii?Q?jovU74gSg/nCcDFNW8ZE2sDRhVNblqha1TJYBHRwLUCjlDylmzEagyGAG/ie?=
 =?us-ascii?Q?ylMlvxpSxCHZV86MFsy7yLvkP+OMxiqflyEjQqizs04Vrk/MnyfEhn4KUS9b?=
 =?us-ascii?Q?a38Y6UQnAsAjJ3cefbRgKEuQF8EOkYLWpRP1I+n/TA+wi33g7of5OWgl/+UK?=
 =?us-ascii?Q?0k2NJJGKw8T9i1Nfvyc1EZl/3+r2vmGhwBXKvAlupDZO4HZFnh9CtqxZHnrZ?=
 =?us-ascii?Q?QSuDiifKII3t5uKTXXe6nLyIjeocx4G1u40r3nOysPxzKCbMuBdBwJf6B1UQ?=
 =?us-ascii?Q?J1VPcAqxHZw/nT0+TnVlETg/CPMQJs5LWybPNByN69YinKUhxAmZCGnJkeDm?=
 =?us-ascii?Q?qaJTUz7+13V8LNleO/0Th1ZrpYrUvNSk8OM97xjnrVgt4rSUebibiY/il+B5?=
 =?us-ascii?Q?ssovh2AL+hJjYbXpFjwL+3J1trq3lzM2qmvaq6VasVisKej4NcvYTmBArNSL?=
 =?us-ascii?Q?hI7qPHue7n0NmQAizSWdZLZ8hd+FHChewGmc/i0p8IkgsB00snBxUBKdQD0m?=
 =?us-ascii?Q?RiBOgOKTaQJZaopwg3An3vI5Y5zVruzHa6lCG4Dr6F4OnIep564hnkECa/Ex?=
 =?us-ascii?Q?8ZFiGNBivWw9xvd+uCmEvrsr1sz7ofRQXGLALANvBRlpVsvM1m0Y59iXfXg7?=
 =?us-ascii?Q?DGISsUyXam/cDXrrssC6nbDudfdhdrf8mHAvsSGK0tJUapXNhswNN1dZMwNp?=
 =?us-ascii?Q?wX+6syJVvn2+a3x5M74sE7DOzoeMf9Jn2Chva+C6dqt9leAHbAZRslPpdTYQ?=
 =?us-ascii?Q?W6rE3xyvlbeUV9B9KxloEYrTE1J3i/s=3D?=
X-Exchange-RoutingPolicyChecked:
	xUNxx+I96Sm6oEpt9cvBD79r1GHx3LTuSLsCm+287371xtRuxi9z+/J6+GCm4WofNdMXXZneNvFGIbqRHJlDrtCwiWNTggwJlasEYRGna0AzM40FsgOsXetmkbgrM1mXecvdR4oSt8KqohWYEZ96kDODfyA5V3tgpmW5GwRYwFXoKiSfxuo/KTcC4WUnfEm+ifmgru6qoLttPb9muEhmgo2sArwLHH15fu4uia7edvwRwoUXJfEn+EvbgocaLlHTw26O2/tqe6pbT4x+vu4DE2kx1P0gdS37u/SX8I5yCUc2DeRbNPTyvt/M25JOdb9QiWMd9mK0YR4rupOksZ2p1w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qi/F70W6lYmhnCflWiXIauZOg4zF42U4UmvkLaHJPpWX1K+lnPM9ecnmhimFbN+aZM3e7Gkn6OPPLBMkmG+nKb8/5EWSiO2ufq/2K8N2jWFCOevhbwU2VOJcdI8NClhTNSEUEol4c57pD6cFnxTSWFkJAA/08A0iugfI0vY+4T/yxx1b7XT2fAW+PnjkxMhfurs6p4kNin3W0F9nZ4EaQB78fvLmgWqLy+lph3kcwHrOD07paMPbnjkzutaSQztFxzLmxHvKBUNytM77QFmbzh43o7C2vbOjwzFuLkyDM4nlJVA9BepNk7en4ySUzcKB731FovghTO+GlEJN+XcgPd8gCYFMT1qTKb1ypbBBl1qAYP6sSEAEBPF0fmNnoFx4bxQV1Fa3+9X0iaNzwiMgwqSESn7/of8veftbF6kJ1LM2fqFkQF6xPOqlWJ6huMF/adxT8J1Nyd1NPW+D+9G93+OE+TkpA9C/1EW+jmkLQep5WabxZ7hllSeY3upd8uCwCQZnb/uRTNhew1uMd1LOA1eN0MamItyLALTwQXO2gc1/wjh9L10UJSktVL0s1Nsgg7PrTJ7FipRWFVoam9rlOla/wc5PSPGyi2bCcoylusI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f73e36-ac27-47f2-1812-08df07e5024c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:53:47.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSpiPsHmxpMFrC86M5e+QxyTvD5BVWwuR6eJ8eVT5cJsh90Q4aKhmUFvZVX+gVVZmzmd7IjhJRgujIp0WEK0QkuWNC8ecc1pkmqCaZsqGew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010040
X-Proofpoint-GUID: qd9QK9nKXHaOM5ZTV0_LJxTGbXQLeHt7
X-Proofpoint-ORIG-GUID: qd9QK9nKXHaOM5ZTV0_LJxTGbXQLeHt7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX+G9HHRE1jeTO
 GMyE0xyDbKIPftnT2KnCxK2Xm80vYC1nmUNlO8IpMd5JMMuL53osMf1K1xEGpHeY8QhH2ESl4hW
 qsv3+ZXf/6CMsNf9Ni0mfL3hU0s4TcTRSpN7mE9wmZogPAz2HVEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX65vcU9KdqEoy
 pISg8QWlybniy0pHnKAsCqylmei8YdPxYo67nKbp1tp8Wgb5/NhJexbthJLMx3aBTr16WsY/DkJ
 dk3r5Jl/p1E/cyVDypjj4hyE2hm8s91rb1ukC/84RyppfT7Ew6+BSAqgLxD/pUDA9DUsoIw1M5Q
 DvLQd0nvszoV7M1FJmnzVlxGpCkCdf3IxrEaJlKKKKOY3B130aKewdpeq3j2/v2j9/WKX/csGmT
 OcsX8aKrn23Wk5l6kim1kpJ0Gu9uUJfpTjiCxIbke72AyW1dznczTgCvumPYNlONS1wMe1WL8eT
 KHkmwU/oj6wJPACPHYr3FZ1foOd4xhgI/tSlb5SWRS0WYkxkSsk8Va1bhCYyKJFCECrA3QV5vWb
 Go4F3eGG1EeNYsg0ljOd5yzEuHa/h+KtXs5ODLK4GSLsn5GS542t/9K6PGp2sFtOon/y1wQok3R
 /DAzZBkmw9OtjjjHi8g==
X-Authority-Analysis: v=2.4 cv=a9gAM0SF c=1 sm=1 tr=0 ts=6a965a6a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=BmCjGzV0hn_2UIO9GJIA:9


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Conditional export of symbols used by generic inline macros breaks standard module usage.

As mentioned in https://lore.kernel.org/all/87tso9zkv9.fsf@oracle.com/,
smp_cond_load_relaxed_timeout() is unlikely to be used from modules.

If it does end up being used, we can export the symbol then instead of
exporting because of some hypothetical future user.

Ankur

> k
>
> commit 062222b285463a87a0b87a1f19a5112a409a0599
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>
> This enables the barrier tests to be built as a module by exporting the
> internal delay and timer functions for KUnit.
>
>> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
>> index f08eacef2f0a4..20bc2894b65b9 100644
>> --- a/arch/arm64/lib/delay.c
>> +++ b/arch/arm64/lib/delay.c
>
> [ ... ]
>
>> @@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
>>  	guard(preempt_notrace)();
>>  	return __arch_counter_get_cntvct_stable();
>>  }
>> +EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
>
> [Severity: Medium]
> Since smp_cond_load_relaxed_timeout() is an inline macro that expands to call
> cpu_poll_relax() and __cmpwait_relaxed_timeout(), and those rely on
> __delay_cycles(), does restricting this export to KUnit builds break standard
> loadable modules?
>
> If a standard kernel module (built without CONFIG_KUNIT) tries to use the
> generic smp_cond_load_relaxed_timeout() API, it seems it will fail to link
> with a modpost error because this mandatory symbol isn't exported. Would a
> standard EXPORT_SYMBOL_GPL() be more appropriate here to ensure the generic
> barrier API remains usable by all modules?
>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 4adf756423de9..91ab8552ead83 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>
> [ ... ]
>
>> @@ -897,6 +898,7 @@ bool arch_timer_evtstrm_available(void)
>>  	 */
>>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>>  }
>> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
>
> [Severity: Medium]
> Similar to __delay_cycles() above, arch_timer_evtstrm_available() is called
> by the inline expansion of smp_cond_load_relaxed_timeout(). Does this
> conditional export render the generic synchronization API unusable for
> non-KUnit modules that might want to use it?


--
ankur

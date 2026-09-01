Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF43FD26;
	Tue,  1 Sep 2026 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234917; cv=fail; b=s+dH5Ytv7V3qtXV7LOg2/5p/rfi+1/CrWzbFWjfRD14a7r6lmU6I2Q34J6xPc5R5M5JkBXO4LUMj3D//EP4cJQ5+BA+7tL9fWMCXdRFurJ6GOeOEkKAZrZ2gyOPaR3lD236e4/QOhaFyF6EVCgSS+Z82XhnivvC0QdOFGoMV/7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234917; c=relaxed/simple;
	bh=VwSjSzmB94RGx7q+c/FuGCTHFJPcxYJzI5e26t/D100=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=b75sg0u53W3BW7CceIURBpRgmJ3fUyGnnLuABr6MuQqCdHE2hVUpsMs82K5YhF8q9YpX3uUO2OKzj3Y1f4Yp+F3rhauNNLWZrNTOrnhy3+V15G3uypxHgAM/IK02sT1e6XH0j1/22EC6o20MZ/gBPp2a/r/0jD6scB9AFtSnjaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oJ8CHD5m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYpWjirB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oJ8CHD5m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYpWjirB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VLBtBM2287179;
	Tue, 1 Sep 2026 03:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f8gGcLTwraYcvqXaSn
	K8/4g4Dg8rvlMPtr6DSXPJUqQ=; b=oJ8CHD5mbIFGsVeBtsG4GxWr/DHGHRp+aJ
	TjE+aM7czyx29gXSR1hDkbSTSVbtCfmaMzhJABHn6r8ziVk17NqkybnM2MIdVgJJ
	1zX1QcbkRw2TbiCWcHspicAL497ARdDi4pCoB7eua8uzGdvDzAn5ENQntPvLp2EW
	8/iSo284wE5R0RFxZyp9Qzm271sOa8eV/IvhNd6iOuxI0aqQT5W3lvcLh1ekB4QG
	dqRSnpV1pr4odMUxoYvxupvPWDaUXq6kzQLV3RWuhp4sF/EG7x3v/EOPzxyiZ+iv
	4afx58efJUTijsRcX0ybTRHZImyh6IJDQdF/MNehl7LK91BGzHwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72btr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 03:55:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6813o83U025891;
	Tue, 1 Sep 2026 03:55:12 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvduwjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 01 Sep 2026 03:55:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duEILl5cdEzJuUCQ49K/E1R8YL/KTbojc3th74Kj12yxvXcl9XjVwieibzMM/KxsdEf+mp6lN+F5xzEauPeRCuXTmZNtyLSWGVZ/2n0RX05KUHMDBUT9InK68PYKEQnyie2ceibEleJnzL5viwdfT3u3gppN4rBaTiwqQR3XKZa7hw2z4Znn1sWBFj+i/aqwvOaezg4LsDmGVmetXXxs5+1I69Cgg5wWhd/30DKHTeqy5uGRyccyM136btxsP3N1Ak0EPSssgZRVLHvmph576HYb5xYLX8k9wGxlNGL1eA2651fqZnv2ArSYoiV5oG3Qp8Dhgznch66AEj6X78h0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8gGcLTwraYcvqXaSnK8/4g4Dg8rvlMPtr6DSXPJUqQ=;
 b=P9cDDjp+hVxiLe1Hiy2r0xVQqgJE7b2wVth+fEF9VAYpFW/qaD7MfGQd6q+OoMdC2N57ATeyCP6bxin7fTG766qRdCan89v+LvKNZ1j7ojSW4tD8D/2v6kPhrxBf1J0OqVJaKcAHwk1exfhoDv10ESMqFVAV7sGR2FsGZkUbU+YAWEkZBH13RBJEeJLwYETClB+PVN9K/kNP0GiV2TDFRMFcfEXCiowDCMqCd6sdDUQ2D8b8ddLbCBFNmRl50nG7DN/8pCBNkgJXcroI09ZOsWw+/ThnVSXI2LEsFYDffYFuCG4TBgnAgUvGIWM5MutgxbNhAq3DOxCCONd0/Ii0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8gGcLTwraYcvqXaSnK8/4g4Dg8rvlMPtr6DSXPJUqQ=;
 b=HYpWjirBEudpQ3Xp7PLWHe5i+E1a7O+Us9mlZwX4NVyFaz5Vd0P5r/ljPnr0NNqlxr80VVi8VRF+BfBbCXM4/dc2hu4cuFRp1ZRjnQCHLWgMGkFqwA+5sO5mYB9D3xtAzwYYc2M8O4Y3P8eAcT3QNCZ8LUeU0R3/e9O2wvupTfM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 03:55:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 03:55:07 +0000
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-3-ankur.a.arora@oracle.com>
 <20260831215941.B32531F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v15 02/16] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260831215941.B32531F000E9@smtp.kernel.org>
Date: Mon, 31 Aug 2026 20:55:06 -0700
Message-ID: <87tso9zkv9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 847e9b0a-2821-431c-4d95-08df07dcd001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	P20ORCSrVsMZyGx03jyJ+QKATDMbZ1C8DwMewtJ1WMqdZVxpgOHDfwYU6bRHSjyw5m8YHIOKKzzYMkt5M/Tn3bXuPUQNw9P8cs4tU15jQGkAxo2rDWuSF/0tTB8HOAw94T0m22EnqILVO5y9StE+xcP5sbq2wZvj/+FJctAvRldFVx6T/y4V1dka9u8RYn7c5EjSHsZS0IBjJiLXsVcIO0swNEZOwx0BfhGJmDU6iVm92TxXOpTwfcEaantz2uvSibKDRqy8UXb/oog3ojT2P7XsSQgf8SSIzf45dukBKRCaMdXtsZEqOQRwGMH3K8gggMDieriy/hLu55XU8QhyxlanvAeMamn9ShGYueUTjJPEWGZ4WvMNO46iOSpvMDITr6piTtuVJ+/SPji5nHrzLwe8HgaTTXnwvihTldT91W6r+fGmcE7Iu9H+60jbVbUb9uVsSKkfaEMF76BlyUPnVD3/9rAZ6k1S2nerTRWcP4RMI023kgZaR+9Lzc2wnF9BnbZn7yCo316t6ozj6AXBpqsLREcXwRshpxPy9MV2Rb/nN4OOsUAG6oEGpVZOIjDZb++bzl1OK36+m9GxGyDupyrjgm4yrHT7etQu3kfOI19gjs/SeeWGSvd40T2NOO9Ctb32rXswgnySnxW68kxeBgbjBTkKtBYzjEl5aPrpDcE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyrtM7OklAdQ3pDX8FnWJ8OU5jPOg7HxciHSOWx0do6yAkM3Q9GOV6Ab3k/E?=
 =?us-ascii?Q?DqcFTQLaN+azwnv0K5UhO/Dat0gLxZ0hbNi1fDWqOy04A87IEAA/2liEz3kA?=
 =?us-ascii?Q?ADrB2gcoPR0kjNUDdT9dxVL97MoVqmBYRmiyrC/4m9GVKuJYhV3Y1z57mtvw?=
 =?us-ascii?Q?5D+XP5Wo2zmWZVattgetcFxKXoBSxkH6CZKU9eOegFkyGxXjxJgoFc9rLvD1?=
 =?us-ascii?Q?IjNHFfheYHftPC0ywYVeI4H7fv5nQiojPwumV+/cH+J/KJd2hjMc1bBdvMZ7?=
 =?us-ascii?Q?kvDGVVcaECdxC48/gHKQWLlTBYxdqglBdZofcOlOV9aMJo5ASEH3s10pyglB?=
 =?us-ascii?Q?NGWi7I1qtT64A0DseRdB6HopT25zsJXJ3BdovesrLu3t3k+laYq9H0zLaLYE?=
 =?us-ascii?Q?wGhwcWwF+eWdqeDdz9vjvPk+kVSTT3iefr0LFGIKSNpdIwpbJE+PTfMH+BG+?=
 =?us-ascii?Q?NF00kjckGIcmJ+cD14vxHSmJ5U2MNnJ/GlAM9/hLxZWtQWdMVT87N3yv/br+?=
 =?us-ascii?Q?8Qfro0v5MAL6vZJkGKppAfkfHPM7hS3kYCaNhI9GmIaJWL/JzLU+ApQi74p6?=
 =?us-ascii?Q?IPplJtQug6RoyzZs3fCIhO3QW/2r05Lhn1bD8mX3qWirHA3lnKyJycz6u6vr?=
 =?us-ascii?Q?U0RP8FRKHHdiNQashID/Xnyzdc+OnlaUB/MCirCGwHVBAgmQW7wiInGgOExU?=
 =?us-ascii?Q?8GaXgYSQcHDXwcvfUIQFAa1RpukQ9PZTUBC4WEMLkogIrRwUf0IMgw8Nk6Yb?=
 =?us-ascii?Q?m76vnG4KnS0AjewcQsQgpardq0WVFtyiKybb49xIer/c5yUOxUL7x7D2NYFe?=
 =?us-ascii?Q?gRMaeA1OODJTFL6r3ifuhM3DP84ri79CxtDHU2Xitg1onikzt7wW1b0miuhM?=
 =?us-ascii?Q?J8Vw4w9347dvwVMR+nfuRQ11ztqfWOI4Zc5iMyTF2XaiwONOGmW4+h2ZEG9i?=
 =?us-ascii?Q?bPHNsvhpyDL8wQBlitPwgg2nZNfT+1oW75THqW2O1ik1kb0u1eLqI29UZTFu?=
 =?us-ascii?Q?+H2NwsZwMhmdTQ8lJTdg1cF+KETkhVYFiNNn4CIYtbSuZ2Bd4jqGt4JdW8JE?=
 =?us-ascii?Q?AAsTuZfv+mbXBWxmuKE4yiWpubdqgT+8iAOjxYP3olhS/OBZpnEpYyzKjXXl?=
 =?us-ascii?Q?sdNOvQQDJm26wFuowhoSuBadXlRXzpXGO/e+nG8ZewCxQTK4pKEntn4erk1Z?=
 =?us-ascii?Q?9vIGq7OpOLDqMIscExZl2v8mRviuqNoIVZsZ4MQWxCjJH4uptqHc8pUkYd0p?=
 =?us-ascii?Q?fPjrFutnI7G3oKQzschSz7dSz8NV9tLH+h0Nu1vOTMNtqpkoeIu3Ak9Ud/5I?=
 =?us-ascii?Q?6cNqoNNA9AbgsTYYZHpt9SklrhYNjYJ7OacMX5aBzy0PbeauHj75W+Un1nqT?=
 =?us-ascii?Q?5Ih3wKH0/FBm7cNFT/oNEoDeDdAKOq3lOVb4BBYB8HpzbYH6jTV3xm83E+YF?=
 =?us-ascii?Q?73Gj9sMujOscT7G8RXc/qg0mYkYef+oXg5e/AV9xAqwTb9UR3totOK69SKwu?=
 =?us-ascii?Q?8wMlFmwEyeD79A0dE6fCL9CSN9+bFxbVH1rANgV4VRsDSe7jQwmDodRjbbHP?=
 =?us-ascii?Q?Dk5CrFovSVRjYXKenZfm8QFy8japPsoJB3eXEs5xPDIOucFcItcNNlbJGBN7?=
 =?us-ascii?Q?LZ32Uh89+x5MOa/rvooH+Tna5Kx7ttl+dIrUd67LFxtTF/3fEsHJw7xvt+Gt?=
 =?us-ascii?Q?xZMBpTm7dKJt9hV478B6BYDLmrdbZGLwinTqdaNRSB/wUGinvLQ/qcF7MD4G?=
 =?us-ascii?Q?Su1IktxLCXUF8BKnb7UVTUHkvEN623c=3D?=
X-Exchange-RoutingPolicyChecked:
	ZUyU5/zpn7EmVRwRtsH94opDVyI9IecsL1kjkX7+yzEgnm6hkf4mNRtEyjMxPOOYMleQ5jTyYkfNe0oiqtOd9OQxegkWHtqXkRRbzFNa+1insO4wP4i8Wv2U0O6PdLdnVymAxG0aue7Bj4DgQYwllxvtJ0xBxxCSeUMT9mzGS0VyWZY0cao6hLofBneBrTETXdlEBnJ2OJqjeURRTU0g/eo7UDpFCUgMk+FgCDAW3Pxqg59P0jdDItXCybZekWVk2ICnda2jdJ/jJ+odq9/d2fzIWNcX4FC9nR9DdH+qiUZHzSPq8D2jAgu5R6i+HYcta+APfwVoJV7/IYJFw0U3eQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qBktNArEG+TeNcjfrnL2AygkgGg8bkJB919wfOF6Ugde9OMR0BEotXWcxPeIfSgoOpoE1Ry7b5RR8LY4Oaz6IvvbyYsmKDvd8PghPnbymHIbiezGMfNXbASc7Vengk/WWdlwYfxRAiJiRvRhGaTnK/nTj50yRZVig9DtPppXTIGn0B6um3kuVj+vT2QawMT/QBf4DS10Zxqs4eqUCROOgLOPb1OP+9dAz3fp/BYtVpOmRP7oIAdgviO+pTRgkShwrhxT2ncbOUb06km40DSnx8dbrAfVaFMOnEVgPVYLfevcKihnreE/EFbm5dL3u9BU/90s14taPeWAP0piniGhwLWLCuWEn+TcLzQlcF0uBajGk5gRyFlOVg/sWCGPMcyqYFljGp902glN5YZKwlpX99yqn9sHsSSspbcRVML/4ue7IFUr48Z0cSj9tbhuFfqYX5/cD1DjdaFiCVmLoMs4jl4Tbjrdgi325W2HnW8aJFSm6VOlMulr0ODxgBQ05F/7H1phTqEV1PGoTt0BZ/CzWNt7Gh3nWIPW8q6NDrFJWRTmGbeU7TRJvnx4PB/2lkt3ZBTSVTtUCqhrXvyDJu4uGl2CbAsaUhMUI4uN0dmrYsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847e9b0a-2821-431c-4d95-08df07dcd001
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:55:07.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhXtk3d56ltqr9qmDIxJLnShSvibugDfIXgQH2rePlhJkf5XrXgNfw67saSGIM0W/+T6bkKiBHGWRwLI7ABJ9EDIaTX7m9o62ZEREOEujsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010031
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzMSBTYWx0ZWRfX017LirqTx+Gh
 7bEmA9qXSxEopM43E/IJ4vkwW8iiAKgUcI1bkc1G2t92nTTEzaErdfAULT1KG/aRVgkF3mjwiF1
 ZSjQ0vu1liFr4lnQbNSVCprau1KSs69PnnuzvygaJTaIP90vi0/J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzMSBTYWx0ZWRfX6wrTY1wnVGQW
 Te9QrTWHf/BACHtzvglE7iKVVSFbO97CCxj8nBdYT2yo+9CAVQ/mtlzmu7bq6cj6Bp1uITLh4CL
 huAIIKO+4jFjhAkktieMmUkkpdB6K8W3+I7JdYstbPa63OybQvxa3UdDmciYbpRbWaCKs9KvM9P
 HC+daYpF7Uo4fAwu5lyc6qlxaItVuntJZIFOf74y8He5j3w3QgGvcjHFM+mpeaz+YQwcACtCaM5
 gC5EwauwYYfEUr0CIXDHgMSxPZ+aNZ665SL0FuwJf1Z9pNZqdZ0Zqxiypyzw4FyhJSAw7cxsLf8
 sjpT2Bqy3xveD9lhkedZUp/xFcBIQ54YGhkLphfhKdg4HDxzEXn9Zdfn+qP/1HJLJn6fXzo4gC2
 MMAyXM8UjLoliTXbzxCmYbZOlIewk8vef1+QEgA9uIA4e71JAmQj2T6ceH/AWjAeV1BPXhmWyw0
 iIjepYoWTeNo5F6fWVQ==
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a964ca2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=xTVu5D7ML_-Ftc3cK7sA:9
X-Proofpoint-GUID: lSnCML5FKNtE_vy93FyUIwBcYGrXzWpd
X-Proofpoint-ORIG-GUID: lSnCML5FKNtE_vy93FyUIwBcYGrXzWpd


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Module linkage failure due to unexported symbol `arch_timer_evtstrm_available`.
> --
>
> commit 6f96330ea583f1ff6aede67a83cdc552196dad11
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> arm64: barrier: Support smp_cond_load_relaxed_timeout()
>
> This commit introduces an optimized cpu_poll_relax() for ARM64 that uses
> __cmpwait_relaxed() to wait for a value change. It gates this logic on
> arch_timer_evtstrm_available() being true to avoid blocking forever without
> periodic wakeups from the event stream.
>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>
> [ ... ]
>
>> +/* Re-declared here to avoid include dependency. */
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +/*
>> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> + * for @ptr value to change.
>> + *
>> + * State this by defining CPU_POLL_RELAX_WAITS which enables a time-check
>> + * optimization in smp_cond_load_{relaxed,acquire}_timeout().
>> + */
>> +#define CPU_POLL_RELAX_WAITS
>> +
>> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> +	if (arch_timer_evtstrm_available())				\
>> +		__cmpwait_relaxed(ptr, val);				\
>> +	else								\
>> +		cpu_relax();						\
>> +} while (0)
>
> [Severity: Low]
> Will this cause a module linkage failure if a loadable kernel module
> uses smp_cond_load_relaxed_timeout() or similar APIs?
>
> Since cpu_poll_relax() is a macro, it expands directly in the caller's
> code. However, looking at drivers/clocksource/arm_arch_timer.c, it appears
> that arch_timer_evtstrm_available() is not exported to loadable modules:
>
> drivers/clocksource/arm_arch_timer.c:arch_timer_evtstrm_available() {
>         /*
>          * We might get called from a preemptible context.
>          ...
> }
>
> Without an EXPORT_SYMBOL declaration, any loadable module utilizing this
> polling macro will fail to link with an unknown symbol error. Should
> arch_timer_evtstrm_available be exported to support loadable modules?

As mentioned in https://lore.kernel.org/all/87qzkk2hxz.fsf@oracle.com/:

This interface mostly exists (or wants to) to unify spin-wait with
timeout where the waiting can be done via a spinning cpu_relax() or
arm64 style waiting on a cacheline (WFE/WFET).

Currently, almost all of the users of smp_cond_load_{acquire,relaxed}
are in kernel/

$ git grep -E 'smp_cond_load_acquire|smp_cond_load_relaxed' kernel/ | wc
27     145    2191

The only non kernel/ users are in:
$ git grep -E 'smp_cond_load_acquire|smp_cond_load_relaxed' arch/ drivers/ mm/ fs/
arch/arm64/include/asm/mte.h:   smp_cond_load_acquire(&page->flags.f, VAL & (1UL << PG_mte_tagged));
arch/arm64/include/asm/mte.h:   smp_cond_load_acquire(&folio->flags.f, VAL & (1UL << PG_mte_tagged));
arch/arm64/mm/mmu.c:            smp_cond_load_acquire(&idmap_kpti_bbml2_flag, VAL == num_online_cpus());
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:    smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));

So I don't expect this to be needed in kernel modules any time soon.
And if it is, we can export the symbol then.

--
ankur

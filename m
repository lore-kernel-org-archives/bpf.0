Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378915E5DC
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637626; cv=fail; b=ZE2FOzlTazxkRHMuXP3BNuX/5D7V6boBmVRBszSIvWgISvBGBZSJDO9WCFW2j6Y6Mv+1DSLxr+0p1hobq/3ygBbpPdLrh+Ka8aA7CMfV0HtAF7VNUsYrsa0rhVJ9fk0tFAtoaDboRUONOb9IPhezu1xnvYSAk6tpcbDwg3zoZwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637626; c=relaxed/simple;
	bh=nwHQfgKGqHf0T6MBUTE6EYnb6O7S53KO4qX7R1v/Xuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SptLnvpsEM1RIqkc1DR6YqGwdupLnhd0diT4iwtewpqt2UxXcL+mGomZ7IELj8C7jlYI6p9V8nShAXzAcF7vL/IkVBmE7v+1jIgpdmHO5Zj5b2++rmhUItHgnEyFpmSqXaBwSU7aNCnGmVg7oWeTfk2Azpjdmn0eu7EtsVzBNas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jiaKNtzQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P5oKD9ZQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jiaKNtzQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P5oKD9ZQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624EMNMW042980;
	Wed, 4 Mar 2026 15:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iNGSKT+8ofHH3gBDcAi0tX+uNuHkXZS289DOudjpc3I=; b=
	jiaKNtzQlWfBGaNbRxGoUJAC1lVnTL+4eiiHgC0+de0UJG17ispJqsS00k7yni5Q
	W892jokV483y3euRL4S3EwP5Cx52zSVUhoyQ0IDdtxwOGJnkADRhNbS6ZO1HWgmn
	LhY/0rtzhKaWxMDZ6l9liODnfby56HlcKjd9JDDZWnexYci/RzhF7LxLwl1EG74u
	DMWBBeudmjDS07yUMPW+188wbvgZyZTxW6nXcZnKQAFqAhIu/V1ZtMrY7CSArbx0
	grK/bHxftYohoq2Cu/4QIEkEaM222wb67qW6buz+J+vchTRCWiIXIQZBlqeP23Nf
	qx774Gavpy9OGnExou45Yw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cppep03ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 15:20:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624E3ffx029749;
	Wed, 4 Mar 2026 15:20:21 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptbwpuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 15:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOjwn85JHe3iyus/z9LSTQW90SpJ0ZzXvywAk3iLHB4z6RlqSgu68W77ynFmgqcrglsEj832qqa0Bxp2bkMr+aKd2X0zBPmLm3nt3FjKLiIv3OKlpDZsxk2d/+Q2aBZH/oH1U/FEMCzINuhn4okVRNlK8Oo2QdrPwtEWE+rWneHJU0gOSL4YGu0CraareL7GoY9/P3vdTUPZmoIEFneCR+MYyAJLcSmZZX555AAnL32FqD+oCgTy3iEO7+//hPxlDXlafQAIR1005K/v7QY9VDtVffd90JBtFS5aF6zNZjbGqxbzhe0XT/gP2Xu/qJv1AKYSjuS8Z6vGiNR2baziwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNGSKT+8ofHH3gBDcAi0tX+uNuHkXZS289DOudjpc3I=;
 b=Sv+aUs4VnMrZUUPxsO+KtXt2nT3SUjx0bAEvjYCAqkWgzVxlmDiwD1YIIA4EUMzUmEfPFKAR3TqWiMOW75No5hR3aweeu0g6w51hrckVJS07McuR+HJ7dHiSxZzVyInQHZcuo+7/wbcCHaz21IdcEm8iYSFlRIt/kpHPsjMp2B/OacQQ4wNd8uG1dvpE33MUiZ4IsX/xu4/ZoijIguUXN4RaHvyAWrsvCaq15iM+yVLCl/R5WnMIwzBCLJ2mxWG1NWJTG7BaNOhRsMfTtdcr8by6rZs+VrdByXCuBIF0uSKZDgu+vCV/hrGwl3onaSzPsIygOjNTXGPY+69NvO0owA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNGSKT+8ofHH3gBDcAi0tX+uNuHkXZS289DOudjpc3I=;
 b=P5oKD9ZQ4cpoVALsyOQayUZu6LTgK9OvxECunbfju8wROL5S925RksKSyUJCYNOtdQNn3mSxuPiztefXH+iC/q6GCXW8Xbr3AcJYV5ZA5VSnW9lohxuA5E/YQokpMpnGepwmd4QR29EazEbv550KoPwTLs9P3P4gfatTUV0ZLig=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:20:18 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:20:18 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
Date: Wed,  4 Mar 2026 15:19:32 +0000
Message-Id: <20260304151932.177995-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304151932.177995-1-cupertino.miranda@oracle.com>
References: <20260304151932.177995-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 907f916d-4605-4069-60e8-08de7a018b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	4ki6UnXy+0rna0+cI9+8r9ieP7IrXJ5pjs9bMWJ3N7BlWXt/Vq/UjSPs5byfV/YFPBEvBmcx1YviwSomMdaHYM9/vOQxSbjxkoPIuYhaLg4eFg0i4awcEJnE6IhmjeZ6lsE4F5nm8NsEYa3t4KXqlcGTv4almIV6ooFcTBDLSlC58DEciloT4yJldSCKlNNfB048wso4bd4pd+JelLheN/p6iQqE/6RyFt+z7pzEtejTJBZGMSx3rJxT02quQCA+wyOtF7tp0qk/Mareeo1J3Gx4cGdr3hVI2PqlWy5RPtbfqRW+O27H7MrTN/G4P15mE6CRrgato+X9epAKhzVW0TdpcaReZc/ERxlbrTWF9gLNSOdBeeI+bIB02DSJj6VLAPINBgPABD2aU/0QsYfbF1SrZ2JR16Mdxw/iIDlyQJh5LI8F4pKSixpX/Hc5Zc60dKNkS9i3m1iAmmeKigF8QGzDM8H4sHM4G6xbmTjFhVNO18crVOV47mPxq6tkVss3Btk8q6pSEQ9/jYM95kqwGo4odyPjvoUslYik+y2kFH68YQ7Es48CONDOl7io7YEnU90D+6o30kA4VN+h3gemRtEhjiPE7+TEYqQ3dxjowoR9ip2JIjc508HNVksfm7Jtn8EXSYdXZQlkdYxkNO7fgzKCQAxu6/K4YY07z0PWF57AdD/TBxkx8dObqamXc35YUw3KDxDSv7jmJ9is12D+DwCTZ025F0ToEw2zmMciyZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TiufQTkaKq5MueIN25MYMv0DGsWoFFSF1IaGgrJQt9LDxyRS5WMwdHHnBe08?=
 =?us-ascii?Q?5/LNwRvRhcwSYI7ZDSiCOcGX05ZgUgpayixzXuMgnXj3K7I+3XomcdfV7Frh?=
 =?us-ascii?Q?yv/LN/qtz0b0ybRvOMaaRMSjGI2yx2KfhnaOJaE0vfyhiUOyV5xwczhDi4YN?=
 =?us-ascii?Q?/h+aavEuz5S06xcGA+P/7t7Xk6EuQIhTVpW/c1WjHQLbxp2s6UULQNzSl3Ai?=
 =?us-ascii?Q?9AILPWHlKhyGEDU33C1vkbOZ355aJDViPbbbp9iiuaqxMK5sw14dmsCdUZBS?=
 =?us-ascii?Q?Ahrdwsm6L3ILkCS287GCte6uCqdmj4K/WOnDuyiXgzd7nsxZJ1pZWxYmMwmf?=
 =?us-ascii?Q?mQF5UI3le+QxTUm+s3BBGjLoKBGDkFldP1wxyTtbGA05F/1cg/mFFfuFxI77?=
 =?us-ascii?Q?ZC/J9hBBIrbQeejj4i/QdWOHb0QT2yLnuMf3fXgHdwOUTf7Y0dGJpIO3lRLW?=
 =?us-ascii?Q?jstB9wcijdJixK40YL6BifLrJcQfTk4PKADWWGeAIGeZXk6/7p7hNVvzsmLB?=
 =?us-ascii?Q?h/p2axXGYC2VqbipWcsyXtULQ3W8NzSKlmFrfLV7fYyxFQhijbYr/J6qOIYv?=
 =?us-ascii?Q?doUQuOybPOlb742kgINcl72S9OgEY+HxJcwyJ/MQJi5Qi1iK15fqFx2Xnfol?=
 =?us-ascii?Q?kSbyHCcLpzvVp+JnIZ+Z17h73VR3rTY8yO2ErT9VddMbLilLbL6FBcfRgfCd?=
 =?us-ascii?Q?JtckP4b0RItSHOyWAEzmSVdR2evtoPsZ0TY1x2vcjeZ7eB/7T9ZkrkgTuYm5?=
 =?us-ascii?Q?Z2n4Pxn/DKei8WVZxHQpzUF3lN0WnTzneUn6npUmaZnvoUiWVgh4iDW6fZIk?=
 =?us-ascii?Q?km5g2sNTpTZSmVsuO70Yim38XPoZahI9FbFO16dpfchXOhKz5aRrqK997TMN?=
 =?us-ascii?Q?A6jvzc1gs+XFHAxNrWGC1U+SfZucduzm8jNYs0r0HIFjJo4FlKpCYGeERpia?=
 =?us-ascii?Q?tfCyJhpSOQzrMwtkgxrAs9nLOEPeHpUEBPoWBZP6vVGfWoY0ezAXmnw1DOWo?=
 =?us-ascii?Q?sEU0tOlOBDzsTBygZP8hrznbUKtjfDSl82hWvf0X80eancRPJ5le3AlHIfra?=
 =?us-ascii?Q?cBCZAOa89Y60pMJNm/EIhXuX05KMhie4ry191xsV2imeEc59OKLOsMxUfTiQ?=
 =?us-ascii?Q?T+psTkrwnSMtmrTfQW0tn7z6Hul1xdBG+YRGE1JbIeN9tE3h5DSAxODFaAP7?=
 =?us-ascii?Q?8un4M99aPJ9lV8FR0afnlN6wpiw7eAfIt9MC+oTDmxvelqD+mQjZcaTGUrmP?=
 =?us-ascii?Q?cBqjB41I6C60Yg/iRDWXpi78JridAb1dXOTXB91rxUAdZv6IobPNWx7aCgR+?=
 =?us-ascii?Q?GvePgmmyNn+TfM2nNIJt9u++MfL+QRvCq738TrahwD5it2xsp0JAjMWzE458?=
 =?us-ascii?Q?OmT9g/fgauPTZqwYEwyjOEh6JHD9e5ojBLyKifsxvcOa82APaVN5Ongngh8W?=
 =?us-ascii?Q?wP394ZbjmEwq3WtNLS6PM4ovXGcz+ZGBuNWwbEtYmWPTuSdPnzJHtKr/NAEM?=
 =?us-ascii?Q?ofo+kblRV3es1PQ84nZJQ/rIPiwr/kZNxY15+YtbtpEvImJAkIsTLvfS48EO?=
 =?us-ascii?Q?hDjZBe8yOEvYWLkcXfy4z9TS1/FGL+5EduRBrUAPyZL2pe5kGighlxEq75r7?=
 =?us-ascii?Q?ZAOlB6o/oU8MhJimfmJWTJ1dE4vifUxNS1lNS0zGs1zxmiZM191kmpO2D/CQ?=
 =?us-ascii?Q?48UADYRA529pHP/9wMQBFtvCWmwwy7o0Zq3jzBd1lNSj5DS7rYXKclvjeuVT?=
 =?us-ascii?Q?1u4ene7oE9nOn5MXuET+RgAXyasazu0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jtH0YvrF2IkvXIOFbpwQWQ+9oTs9M441pN6h2L8vWvPNWHCwY4Fp956QNyxCjPZhAdt0y/oHk6PYni7SgCxqORZ+fCr2rgaQ9B8rggOgr+7uZ+RwkOdwepXAsPzpIhm6k4x5e651nQkSRbzo/eKznrzqaZt9Nd7ALaE//z/3ALKxodiIYo9W2+8RjgKdYIxbWUzQ9UwDDTzqFVM+gaSX5hwlONp55YEF2FiSY/RcBBqOcDyRhI4J2e85Geip3WE7wR2YeQTCojC70kmYcMRC6caeCNN3GuZZ04VEygxoahI6/hoAYw7dWsCtTCD2wdg5dyvzdnuSrTISD83GU0chmQ9dNb23+yCdcUIb/FuSGzbaUmoFvAOmG3UocAVbZKxx3NB448OHwfsjchPoY8tv1cUAPuT/NVrpEuW7t/pc1KoevyaLGHQsx4JQYkEtYvvdBQVAhm27DmLybMU69ykEMtUW4t5Q0fID5l3MsQJTMmk/YZdmyLET9vAjums73i63GI/xYTikNvuaKprW1v4avaSP5f5Lph7HyxO9CZg9OSSnWjzDlCpGO2KFsE/ee8qz+yy84d3zrq/i7tSmYu3UxLAIbbKdanNcYv/b7Qyr1wU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907f916d-4605-4069-60e8-08de7a018b20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:20:18.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC0m0syxY0MbqrRpA+UxBOvUnQAexNpUJet/UxYBnpbVAhWMWAG4jptWRWrHPK6YGLZ2YYfHtQgPNcH6p2yNZ7tc1tysQoFUc+06bc1ztZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040124
X-Authority-Analysis: v=2.4 cv=fvTRpV4f c=1 sm=1 tr=0 ts=69a84db7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=sH-hGKWHxpH7UWFcF14A:9
X-Proofpoint-GUID: N_TrFKSQIrV4pu6ODP4M92TkVjvZpI_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyNCBTYWx0ZWRfX6EVWnRi4unqz
 uUDbTX1iedEn9y+mERRLgBiMqhsKJK5A/P3zG1aXAIaIzeVTO2IYbolGgoqCoWeWOpxD5XCEg2n
 3JY9QgR6pbTfpBFHt221Tyuab/Fh9A7Pc0jF8FCkJnbuYdPBvXvF9hIC3v1J8/BX1K45kQ4kInp
 BQAfrHeXVlhnHPVHe729r42KA53bnRXzAI185TJcFWlTtT4fiayQbXczBSblxo1303XgGgXLDUs
 ase7QMmwWfiJWBgQ/691u0XYk9TFjKDX5qs7Vbmi2nwzl5dHtxF9rpaKRv4yxQT+vX9pPNEZgCN
 297sFMj/njSATX0rRELZFPXhCwFn+yPIrnTU/7LqhkMngKd5FJrFI0aPC1w1V5mfBv4ggsAvYzM
 r1WHf+5yaI+Y3hCjg7MNXrozizjXnaNSuHXVzkPVbKUmx8bLsIPvRsn24eK+YUznIpK+x7qIvH/
 OyCOAchylhNErgYpbPQ==
X-Proofpoint-ORIG-GUID: N_TrFKSQIrV4pu6ODP4M92TkVjvZpI_h

The 5 added tests are copies of the already existing tests in the same
file, but changed to use R3 instead of an immediate 0.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index bf16b00502f2..3d1e8de4390c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -210,4 +210,58 @@ l0_%=:	/* return 0; */					\
 	: __clobber_all);
 }
 
+/* Verified that we can detect the pointer as non_null when comparing with
+ * register with value 0. JEQ test case.
+ */
+SEC("xdp")
+__success __log_level(2)
+/* to make sure the branch is not falsely predicted*/
+__msg("r0 = *(u32 *)(r0 +0)")
+__msg("from 7 to 9")
+__naked void jeq_reg_reg_null_check(void)
+{
+        asm volatile ("                                 \
+        *(u32*)(r10 - 8) = 0;                           \
+        r1 = %[map_xskmap] ll;                          \
+        r2 = r10;                                       \
+        r2 += -8;                                       \
+        call %[bpf_map_lookup_elem];                    \
+        r1 = 0;                                         \
+        if r0 == r1 goto 1f;                            \
+        r0 = *(u32*)(r0 +0);                            \
+1:      r0 = 0;                                         \
+        exit;                                           \
+"       :
+        : __imm(bpf_map_lookup_elem),
+          __imm_addr(map_xskmap)
+        : __clobber_all);
+}
+
+/* Same as above but for JNE.
+ */
+SEC("xdp")
+__success __log_level(2)
+/* to make sure the branch is not falsely predicted*/
+__msg("r0 = *(u32 *)(r0 +0)")
+__msg("from 7 to 9")
+__naked void jne_reg_reg_null_check(void)
+{
+        asm volatile ("                                 \
+        *(u32*)(r10 - 8) = 0;                           \
+        r1 = %[map_xskmap] ll;                          \
+        r2 = r10;                                       \
+        r2 += -8;                                       \
+        call %[bpf_map_lookup_elem];                    \
+        r1 = 0;                                         \
+        if r0 != r1 goto 1f;                            \
+        goto 2f;                                        \
+1:      r0 = *(u32*)(r0 +0);                            \
+2:      r0 = 0;                                         \
+        exit;                                           \
+"       :
+        : __imm(bpf_map_lookup_elem),
+          __imm_addr(map_xskmap)
+        : __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


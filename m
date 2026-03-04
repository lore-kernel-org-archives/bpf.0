Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3E38645C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653844; cv=fail; b=PfIBBz3DhLM1f5s0gDaxZ0MYXGpHwDW+yMbONQ8HhWfNefAB3XuE09PtlDla2W/QYbVcmf/o+Qpyj80MAG3ZgrT8YzXTAzfhfi1oGhAlgdFP/dL5bynSdY12b35uK1/uj2SzR1fpVVzfYIXbKroR3GdjdI3L4Lj3+D84jzZJE9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653844; c=relaxed/simple;
	bh=D1BktPBc+/exRSGwtbXf1NTumMciGy7euZw7SANm4A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilHamGgW8DRotyLfzeqvrP+8+OsXuVQOZBe11NMYlxMYo2R4EG1dEKSnOW/hWiAGWC7hb6bLGzOzt606+OA+Ss/K7XGd3adPsgiBcf2uixx/7eAdMboOU3LsMKmWsJM1ReS3VAaAgRdJ/LaE238R+Wl4ZVrQcl7PqwxYN+g2DgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jxc+c/Ti; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEo7camI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jxc+c/Ti";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEo7camI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JLhR12349592
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 19:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BYXx6PopxcEDq0R3TX/GNeMv6p+2JkqqNcg4hWFJNgo=; b=
	Jxc+c/TiZZbNqVn+pXTjDRjbZ78xuy1u8rJw20qtBm8ULohDDZJVc+ZCDxYpLaWy
	69ZsXsi2f9lEekMyMFQ06EjJctCJ1qwgAI0yLCOgySlbf9S6U+eaHWof2QR7TzcA
	bkfywuUkSxIMTF/PkoHdUduNHysqbtbG1ylDqr/DMddss0zu6rbCSMXNbDBtG/I5
	SguWTLYb6DI5z80SHJXPLiBlZT33OSUPx37xjI5Kb+GzBD6P5kQiRm1o649ap7iS
	vzf+yFIVAWoWda5dJgSNq+0IlGDaSeMH5kQR6iFdxECeLBcN7KXbsESadIfaWYwb
	KFLbe3vtedl6g2iV3Ma9Iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpttq01pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:50:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624J5DlO034746
	for <bpf@vger.kernel.org>; Wed, 4 Mar 2026 19:50:41 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptg9djp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2linjMDhZb4Bkdrhf/A/NK8OnIkTzEZpngsjqIO219xlsYb9b/XLnqMlsySrrnvs08HATgR8Ufi6zUQOWhNzV1f16Tc1cYlZPYxa4oeq6mzME3jAEuLFud6mIQMwNrK3B5EFJ+/ei4BoR7KsLGaBJe9rdaUt2DB32vDwc3WSJij2asiqs9rwF+PkrQUpMgWExKZa8ENefdJkTb9laC+OOZhNFXEpa3RX08b4hEAtzy/NdURdwYYVKyxRlJpa2W/MtLfeW86HljjTZeOaAh+DSexKq6EKAgCPOecM0AJ9qXLlL6rprFEXBV8xZX1GPZ75ZiIuuJEsoh4Mi+Vki83OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYXx6PopxcEDq0R3TX/GNeMv6p+2JkqqNcg4hWFJNgo=;
 b=NCYujRP4EuXwvqnTR6As3yE6GtHfZFkZ4HUj1XKZgjQZz1f/ouiuu7/PI9WGpQcgDzUtommxbPaH/qV76DDfut5Rlb3W4Jd1iZN4iOj5oRa22jNAe23gIw3aWfo/LiKZ+IaXfzIdiDuMzyteM6qs9g6fnvgU093e69sZQLjmSUiSIISBDhv11mn2d9boQKSGITfv+Ft161rQuKrNkN/D+dfwfQ8QytQD64U0ElbSkMlfJPasELWCvkbheMvHCEYPVCviviecUD1KqOIpjV2JAPT+hDdNvTSf1luhWOVI1SAbYjm8pOLEci+qSnK0Ze7NU0QSerTXVZ8KC3ni4Z5DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYXx6PopxcEDq0R3TX/GNeMv6p+2JkqqNcg4hWFJNgo=;
 b=KEo7camIOuA9PfKEIfejOX2rGVu6vn2gAIZa4820rhTCqb0Gsr9cacwrWWjwv8AS17QmWQLBV8QYmkNDPK5emmhYLAbnO8HfcLq7lB6kFJFpQUJQ74AxJJLXBJrM6Qvjzvf/LCBFDaqGG6pyYFAkE98d29G3vCK2/cNBY2meDWo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM3PR10MB7969.namprd10.prod.outlook.com (2603:10b6:0:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 19:50:37 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 19:50:37 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH v4 0/2] bpf: support for non_null ptr detection with JEQ/JNE with register operand
Date: Wed,  4 Mar 2026 19:50:16 +0000
Message-Id: <20260304195018.181396-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304195018.181396-1-cupertino.miranda@oracle.com>
References: <20260304195018.181396-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0009.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM3PR10MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: efdad82e-6f78-472b-de08-08de7a274e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	pYtYxSyvZ6VixJVM2BAMA83MueGw7dHkhAiTIAc//2nYnsgC6DE/0+qpObkTrSB5wcfimr9It7WpWwdstBKq47VMFc8JjdMJPMzzQGLiYXmKzYNRMAVlkouWZCX9JXXzTYFYsf7tqIxRrOtJbNMXC79A+sAEVf31wId9dsEHOvJ/wIg6bBT1y4U9BthPuy96Ed/EpWc6KSvoKM0HfqsScfn7s4B8NuU13oXovKAOYs0MqnqH8BjYpKzbydszalTStrz/0iEno5cWecQxu77ejVYzRWgnGGBqKbLhnb8Y+GiHW57+qDl2dEu79a/mOtM77ZC2pXvzTrN+/eIJDP2a2Kcmc49JjyHPgQPeWFhX2aMZYQ4KHslo7pW7qVwodd/RBscNiADWR+wNCzf95d7Yml+01zVaabBXo+uul+N3gpq9VIeGiNBgvH+A6Z8zLeHy5z9HTmfKTA6ZrQxd9l7k9tFD5wHEpwo1VixN5KfAZnibGorgHSivFAqdNWrRRNzk7jJpH3P6eB+MzfHaOAvhsEnmp2ap+Lw637AVcsnHXdxVkjIJaAUXo6W17WBsXjHZRes6hSG7pmxpOGEL0E1ZxKIzcAy127EXK0j9BRGWV2Kc1M2SB0vfUkj1Fw19lSJDRAT8btINGH1ccxt4CTXBRhR9Tx+haUWt3S5hUBI86pEOzs4hcM6HsNjJ/HOYj/cUkG+D6NaLMAJAm38gxdAJlVdbbjfd56AEdsF2K4ueO/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMBc4PNM+Xw7/PEkUqTk9PhYxBp9nlnEMlztsq109Enz/Olg9q533c4MeaHU?=
 =?us-ascii?Q?t7Oshw9cPolHHO+cu9Hj4NDNiSt+bOQK5ZJ6+DhlfwV1yDxavMgwD7MELKFY?=
 =?us-ascii?Q?E52iSITlyYqaHUQlt84shYAx8gVW7yBBe3mDQYSYEpBxE34LIOvYlIsf4fPw?=
 =?us-ascii?Q?C2Dd1IFmOcJ3pOC42esM3/MdC5Xhi1zlieP8qpnAkj2RpnzrgbyUaNeNuViB?=
 =?us-ascii?Q?sl4yAYWBYoLAeqOVbsALAaRsF1UrEapsJy5jANnvuPsDiT5UGGaCF9+YMIid?=
 =?us-ascii?Q?dNndkT/+ecddg0TBgaqbJtz6XjGZiLj14VBz/LW1EZJ1TDiG44IJY2L8Wrnt?=
 =?us-ascii?Q?CtTjz/7gOXBl0APwfBPp7hE2ov8RFh+sxl1Hp7GEqwCi4pGh8MnazzaPcM9Q?=
 =?us-ascii?Q?HHdUe9jE3lmAbYBOIF+8UPXDlrnueIYWye4PI4cY7Yh8B5cyD4zu7ARrrzsu?=
 =?us-ascii?Q?cGk+ae4LI6+70+WYyfUMWpoNKxSPGhBgMs6dgx1Ob/hGEtaZcpfyFjnVPEmK?=
 =?us-ascii?Q?qr6AyXHJto9V3r+SYzosCupeMt1UBXqzY120H772KByzP0Vx+xoMqoa3Go3U?=
 =?us-ascii?Q?l3t86r29nQtMW2J+YD4A32QeA/Yx7lBYLn8qHwafMEvSb+WHppXYOfgRldFM?=
 =?us-ascii?Q?xgCyqnr1v6sLrRyCJBmsayBHyo8GKKhyj+GayiFLwK0mVKEfSSV2Ylwj5w1g?=
 =?us-ascii?Q?dHGT1xKYSCJWLmbn4rELQFIsLVNPQ9RSMlJNeGUnkTUjofSxYsJ5BiBAWIRA?=
 =?us-ascii?Q?SncX/7uGN3cWyjfNe7DT/qAIuehJF4QsoVUTkg/rpx24zggHiUevo21qfKOq?=
 =?us-ascii?Q?IhqbBWUz+hTzAjvIekJopYkbDzoZFdUu4V66nO2kvjKWqcBL+LhrzFWr8XiO?=
 =?us-ascii?Q?4x5NEyzz6XRierAujOtCtbxuRgyifMjxCZDY17f4yRHMijGK/Edh+kiO/+fu?=
 =?us-ascii?Q?cSttGp3B0rvX8PMYLTHek6ekVnSk2tuvYosK5aWlHuIlwougfOKsohH1aHBZ?=
 =?us-ascii?Q?oF5pKmvA+6Pw4D4nTcT5xE3mCV4XtjpjeNiiCBnubz4tslKmo/W5xnc/55qY?=
 =?us-ascii?Q?q8g2VRMqvF2By4ihAYKtliiErT0EQuxFpCfpk4zMt3Teen+hM5j7n8haC0+0?=
 =?us-ascii?Q?dq/pg54rjo6aYUaWTnMOt+3Hts/rxYGz4JDK3sQ9DMuRn+eIaTsh60xXVTMa?=
 =?us-ascii?Q?AjbAt6hmoxKlQeADTjS6SPpySdaaPIcdlxP9VE1+proiADKN8odQ7ZH6AMy+?=
 =?us-ascii?Q?J3YG+oQ+NobHE/5tzcgUvgJcMgjaZ6jOU7d10I3PibztkDBurCyW/TD3IhzN?=
 =?us-ascii?Q?dsBG7iFk9VOtK3YkUa+G63kBW8GorJgZhne1UGlHLXDqPj9MfprFNsuQnOKQ?=
 =?us-ascii?Q?njdLTBqjoX6TJUv7/M3TU0qW3ipw1ym9xA+0NitGaj48W19hwSJdnwjUe11/?=
 =?us-ascii?Q?WsenMNnLuLGRpZ1B4bq9sVMDtbx0LKfvQlsK10pDlTs9erSFc+Z6KsKOEm88?=
 =?us-ascii?Q?sLdhMWd6tErtbiQvUYU+y6W1h+CsI2IcjB0hz1kLkvfmH2Y69NWyPRC1gs0K?=
 =?us-ascii?Q?+tDqI8p8crwH4K+/KxUTLirE+aNTTwHDd4hikvEzuM29dfC466G4+k1dr6s8?=
 =?us-ascii?Q?ueDfBqMf6+PeX7zUyQw5wHjmuzTXr7PlSYU6XyRAwe8HuooEDqpXdYPZ5O/G?=
 =?us-ascii?Q?bQ077aFsdaYDEG6/pgWVTdOI/bnDrVx65uCV9GLnCfmNsG5fklbip5wCVsaR?=
 =?us-ascii?Q?ovYb8oxL2QchptrC7vfkoAFYvMPVvZs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CXL9yGsX+++gJhia+nttFLYikt3sWCbWbaaGKhY2nN6MuXsQnjqL6Y/8G4zhHIJfFVZ+7vUqhJIUz66F1Yhlp3mMMDQRmi3VWfLzSORINJD2YUw+KIVse2Q46Ydm+fv0VgqJw8jqRYLYSk+r99/JIoQZJ7TJz3B85XB/6iVg8Nq60BBadfLrTTQRFV8j9ViIVYiYRTljiCZhc6u5LiK0O8hQDztTpZBHpBjNIrccFeoa3nEwYm5n8N9E+qS3gg+LvGBhF27qqGp4p6eGuAIjXAvjaUGTqLQC9sSZ3vUlt5pKreNgM9eJeayL9x9KdlEKff7yOAO2Ixn2J0rk4+ftLmC4csjOHJPA1CWTzndyHx3AoLXP1snef+IA5EifgzmgL7T6PixmfsWGxhyqmVdYKV0q9uMGeuc0Zoz5Hn/h4ktOua3DZTd+fkkv1T/IZEmSyB1XyFKITol7XIfB1DUAbT4eUh/uvJw5BZ3Q4HJ9XPOeRuNkt+PWFS5TXB6n8oczKOe42WASATWtIsTFg/gO1ZIsJcI3UcKluBvYfTX6w2mbYAoFfIRO9Qbn+LEKUqqJg6mOPzQHARlSDB1TfG9ELNU0D1aAv7vNoTvYS2m613U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdad82e-6f78-472b-de08-08de7a274e91
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 19:50:37.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQkGyTCpjPdJmX1nMV/XXa8MK5ATR6TmoS4vyEd12sIi9cky6e8eUFGzexda2B+0rId+hsIKCsHH8fHGpmO5OnWDT1Kvm4qXpRr05QNtmGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040162
X-Authority-Analysis: v=2.4 cv=P+Q3RyAu c=1 sm=1 tr=0 ts=69a88d12 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=UYU2QljogtbhK2u58nAA:9 cc=ntf awl=host:12266
X-Proofpoint-GUID: e58gya2waGi54jAvtp2U3SnZDtVBfwVA
X-Proofpoint-ORIG-GUID: e58gya2waGi54jAvtp2U3SnZDtVBfwVA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MiBTYWx0ZWRfX405pC3r9EsCj
 Z9WaABlvyGJrRBtu5GzZJOVqlYdmv15JZwDRs2o/hbVN+E8HRZ8TVUn6YBYQJUrbClZLlcOOaen
 ouYW1ax0PTwh2dyS4uYoSRXjRWS1p0jD5wpexeZCmc1+pHLvFZHdDpimoWGizZNy9PK/+1n/ZDY
 ahgZmDIXFX2OpB74vfolIGUrZUsAGAscb31uXPg51x2lt0pU/UoxXeX/hpdq6z0HtWg0/bJTnHM
 4AsILo7Dd2waBIDz1LX7j53y1N6toPZt96WGHpMo3Qxii4OfT1nrgBs1Idzw65hoYKZjOX1Bom0
 TIlKuR5JsE0uQuquiGy5sQpeU0UeesiJYIGITSat0cqJifkvKlkeaY9H23bnc1GCEHJP69oS/fl
 IArbZXdJ0vojzlZzt0ra5dHklpzC3eraUsbPCcNGc3+R62jdg71PzU123Opx3tnzQzdwA27Xoi7
 a3COsX8PuHC0N9G/2UGxqO0EtsxQVrfJLlgrf5aA=

Hi everyone,

Apologies for last version.
I have no idea how I added the extra files. :(

Cheers,
Cupertino

Changes from v1:
 - Corrected typos in commit messages.
 - Fixed indentation.
 - Replaced text by simpler version suggested by Eduard.
Changes from v2:
 - Small fixes after AI patch checker complaints.
Changes from v3:
 - Removed extra files. I have no idea how that got added.

Cupertino Miranda (2):
  bpf: detect non null pointer with register operand in JEQ/JNE.
  selftests/bpf: tests to non_null ptr detection using register operand
    in JEQ/JNE

 kernel/bpf/verifier.c                         |  9 ++--
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 54 +++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

-- 
2.47.3


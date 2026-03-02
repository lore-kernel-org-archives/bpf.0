Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179F2EBBA9
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468281; cv=fail; b=lGY+Ps/dmLNcTE/5wnbU8SyOR51HSUgcvQTg6CIjCTWZwoFm3ZLefTEaGxsJxW9D1nr6kMcVRcQe16UqJAi1143sMaEzhMBbyz/mWt7fsjbLYpqm1qeJkoMLZrPkamuvyyrBVNcf7WZwWoPIw/Z6OLIdhQertictnz8yFSc5a0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468281; c=relaxed/simple;
	bh=RBn9lHGnUGo7qFnQmWNCNS3N0dO7lvdppKKhGIjyubI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzdCZzrz6rb+fjYMIDPafT02WUzpbVarcWUiCovsBZsZ+AIK/kmnz+zPtNwvdQpx0jtJIZHObTvo/cRj3Y29ZXJJq24y5ROouM9tFDzXaU1MU5XcO0i2jzYR8meMcMQNTexg4nDVl73Jdup8cQukcVgdQtbWOXsNbbsq3viJf3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SaI4RaQR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WvrW8cOY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SaI4RaQR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WvrW8cOY"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EQdmt1326583
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WS6KmXIhJm+eVpw4g7AN/+TjCyyurB2e83z0fGuqyPI=; b=
	SaI4RaQRZH8Fk8EOFwu00m/y+x0+A4RPfjSxfq+5HbdST5veik8Lz/4a+1lYTC4a
	5EshhuV0F/wnPSsqjV/O6j+Zzw8/mnLHR+RrUwq3t+M1SSQoBbTxUwrEjXOThtXF
	2W8tBDkUeD2bDCcG6W2XHi3iP4c9oejLViRZr7l76yNKcsKnxln68ubLJV3/Bp4K
	Jaci1N3i/htDjfIq9YWN8+bczVjxG0IC3ms3zzADRXM8Mfblmvsgw7uNeKkig7IK
	tts00ZkPFX3Lgi7cfnjuXYVqeCwdfDP7Hppw1HoMlnu7/3Ik6ehXD+MfcDIIpiAb
	ri63pT7gF6rPlOSX8fSfUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnbw308vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:17:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622FpnRU023170
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 16:17:58 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptde7bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 16:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGe8cP9eJnxpuIBzrQW9SYj5E6+zikM8CeJW3p7gYZORLBsMVROB+W8zPClQ29xp0fpgAU4n4uPUNJnm6mMFDpGmOd8+yXaUFdj8uERfNGwCa5NVvaijtOutdeCKygqDpA5uvNBc2VpECV0r04I6gJGCW/BfOk4c/9r6Kedv2JWA0X18dz7w3qNHey+V6NXMIQXpf/K6vT2TeHV3knq4Rw8EeRcHZohFdkD+y8go5du06RU0K92NJmYk/4aAMkZI+mxUdpyGpRFKIJ/n1/JbWMjwV5N6/TaAvHMJ2jJ3PNakg4FENRVR40v16FMA2vitUV7JDNz4cvBoFACMIgst8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS6KmXIhJm+eVpw4g7AN/+TjCyyurB2e83z0fGuqyPI=;
 b=eigSwd6AT1Jy6TQlHxcNAt07roCY4z/NosVL9NoHnkfDPpHzFGv6auQU/jdnCCSiyWBU5cIHntgLN/nKNhqhjBd18Hsii42QrPa2Cxd9TYYoKGBUgUyYJ84IBLrjB2kITyz3yxHZNfJmU4EkEYS2Mv+lvadovOmP3C7ZzaQacg8L2nGkIc9YFV0hi1nxCwRASOWYj4dm95gVHBiCOd3PzUqlYO0++x7t+h3rGhX1FZKnTqs0KkmFsiAfifWOJGtwC2lhkXLu8VXoN0Hszunk6ZengMpFQsXocyTG0OtG1k1E8YwRuXfo8SPQSC42x1rnKUKBBF7OoMJnuQacfsrumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS6KmXIhJm+eVpw4g7AN/+TjCyyurB2e83z0fGuqyPI=;
 b=WvrW8cOYq5vO1UB2q0TgQzk91Gr1mjHPI5oExuvBhHG+ZKiDmdVwqEoJVUgnrE2Vv1LlNPw+Q8VMa51TdycdcHHCAARTsjpx28ZW6vRIhV/EBdu4Ek9YyUqKVcY9oWxHKz9dI4rkQrKw/QsoCjaT1hFIXNFdxq+mQFcumBc/0TU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 16:17:54 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:17:53 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
Date: Mon,  2 Mar 2026 16:17:35 +0000
Message-Id: <20260302161736.156685-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260302161736.156685-1-cupertino.miranda@oracle.com>
References: <20260302161736.156685-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbe137d-d46a-427d-2035-08de78774179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	IXYQ2zI07BevcGvSox34Vk4yaiGom8zyQDcvBA6vxQyyZ1vcHvizQK+uDhervESgeudRIWTVz3yXs1HZDyTQMlZ8y4pYojWSwldi3iukwxiT40kjXAXmqOTx9MCJ4tN4JCNjRE5UH//Uztv46exdQcsrGfwPVixV+hIriI4NmOKM7435Yu/Lh9JdjUlwT9PkU/V9gw66SXLvhdQe05mXDv2P7/Iq0kzO2c1bcZY02obM1S4LNPTBuB5WzgdspflDVCao7ardU739Uo4vFsZH71/ETaqRB5eC22DSgbSHXF40w0Nmfck0Pp/UUfNiBZoPnQmeZyGw1mAc6jdz34aJnZbcPc1Wu6wce5+/LGQMA19d95fovieW4zKMxDmLf/2zhaEct5OanG4tyrGNp7s+EPZEYa6qk1hsRxAu4du54Rhx4HOl5Xks9F7j3rcY28dAeaQ21fqYdQZJ0+58CGKSeQYoiJ2cXQf8v7q7yclzu6BHfcFhRPzoIZjEkGflkipZEYGXrHUCAgkzuXDpwuhbYV+Hsebf3CjwV1SpluHwvwpk+deANcb9fN16YI7R0w2vmB1t8DEbsCO885f7+Z6AgtDnXuC5AIOJsA6fwplLq3LiypeylW2Z+8yQvn8PlI452osKHi3SLIdLvbm7PFE7WmrGrQP8PRjxc8oViI2s7bhblB9UPTk6JNc6K3Yxjp3PMmG2jGBYRHqiilZRe7MF6CoG0yjuStsFS1EL73eI/T0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lH4PZmp6FTWOXgXbOWq1LSdcDBrU7nSRqsv9+QXJr3vPfFKhrPOIUxCayZi?=
 =?us-ascii?Q?sAKsnH4JixTco5VOPvZq0I84nIe07WKZjh4eLrsxUcjx87U5xrtkE2PIV35j?=
 =?us-ascii?Q?E+Be8jKxbFPCzc8oWn6whi2E/u/rTiOJAAkT0V/ug0gju8FToqoU6NMUYTFt?=
 =?us-ascii?Q?CtPcHTLevScadn5lEIk8advXQ68hjnCIcFM8jfOkj1Yj76GSyjtTTutPrQH0?=
 =?us-ascii?Q?xnnvxhL3yhE3mF2dbpewS/2qT1A3EIsjBGMU738l+N54nXlg+wxEmN/GXXc+?=
 =?us-ascii?Q?HRsBpuLi0WikrjcYWyQ8QsSk5Lc710wxKav8vVaePQYWvGcIaMz12b4cHar+?=
 =?us-ascii?Q?erFkIOPUrXhW3vdoePgiTXLlmI87Tkqoq8iNsKXX4UNOWLHzvTK4JJBA8pfZ?=
 =?us-ascii?Q?ifEzb8MtYey5XxDt1Its9xNb8hxYDw+LG0031S9OKJiKR9Fy/7XSk8zmaQyt?=
 =?us-ascii?Q?3lLBkMa2utOQeUsigj6sbabqLGaa7Kzln43pARqZSnzw2EABdUPHWBL23/vL?=
 =?us-ascii?Q?wKoZPmGu4L+VLiRr7jFnUQ6cVeqHlrHMy50YJC7wUQbyvVcmx54lSxbzIXss?=
 =?us-ascii?Q?fp7J/dtvnF3Vsml9lXRRBv5zc4pRQbBxkrJsxzzvAnGI1GcpevOom9z4sZV0?=
 =?us-ascii?Q?glovcBEX8KlD2KaWjONXaDJHGndACsY+9/NEzyeKIWefuApUq81alZsOFiTV?=
 =?us-ascii?Q?3leIIPg+jowlLFkZ7WKvxVWsWkc1Gq5pSDKrBknLz/uFTfiIHcAiy/hZ6gLv?=
 =?us-ascii?Q?3soTT+YN2dp3ySIdWSJIusuJp3AMuahXU36LXNUl5uvF3GlBFSpFyhRV5u1H?=
 =?us-ascii?Q?f0tmGwFJBiweF4TdwPm42+5bIZXKIxWoJvDi7xOdrRI2JmvlfGbG1CKTUjJm?=
 =?us-ascii?Q?4MUZ9ltCHKtjPuLASoU2Raik9rEaufQu3M9YLKyJne7a50Tl6aPmqhaeZrsa?=
 =?us-ascii?Q?pyhjI4vULufZkCDH5j+aRqwJvEBfnCz1fXtoId/3E5gDkTumunB5jZMhTAVC?=
 =?us-ascii?Q?qO+1MzwRzoO1+e/92SrZeGFKtyOTFT/c9llyDcUU8PE5jQQdXrEs79QZYWrm?=
 =?us-ascii?Q?q/vUvis9tyCkTSRUCJ/abpVOwW6IigAa7VOGm9zYRmrRKV4IM26Q5lDcWyCR?=
 =?us-ascii?Q?LwZJp2JLyiQfCRdxua8zhdefWmgPnyeeEst3pA0Y+Zqq47I51dPB2FO8k9Aa?=
 =?us-ascii?Q?VxtTiApXW5W7VWrfsyl9oREP3cFXreIIz5KatJgKi8Ku3GepL0YQ8xtxKeOE?=
 =?us-ascii?Q?qyFUGedoRmRQp2MXmhPS4Zt9hjYf7UGQtRL4fcF/IvQa07qAEZ5R3sQZfmUJ?=
 =?us-ascii?Q?Ltahj/zVMvdwsJqzbaRTJjWd7suFRrCBlF6Oc6Nlmw9rqJRAsOq9tcKSruco?=
 =?us-ascii?Q?JNlHZRXCprjN6XmhXFLBHXK4n9a4uu559/vmbwTjRTCtf96ck50YOlDPA5C4?=
 =?us-ascii?Q?oGQZZUnV6P3kIdMgpxvCE8sYVE8GbLeev1lu9/7jy06W+kreOf0zO1XVooku?=
 =?us-ascii?Q?tPbH234uYL0TujclwNr8gYoif/d5eyMr9ww4ET0APXFma9jazoyNxSqODs0A?=
 =?us-ascii?Q?Xe7U1crNUhmNU7Povu5KrEwWJhOACQ2lNcpIFwhlcbeJgmg2NJFXhA8ZtHXw?=
 =?us-ascii?Q?g2+69vb/NuAKOaNUJgkn99u++/fvopKha/1hXdbSHlSmeysXq2ELsSnNuGQO?=
 =?us-ascii?Q?6zBVIWWhogd4C7fP2Afm+8LKuHgop/wvrYaDKGEJmPiAUTwX4JC7YaDlPChH?=
 =?us-ascii?Q?rcZNpQ6Qyk8c650VqOAAQCtrz0CEIE0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gLYBnBgpwIOMxyvvbmxG975QKuAoDH6odQDJV8nEsV9GHheVv1c+oBqkI6eAojGFTAuEHUVHuwt2i715tWqoYNRpQ2l4bVM4CCztQ57QHy2KcwdZNSnCrSHpUGgmVXkOuxiU81ORKjigdgJRPPLuyasHvF/FsXmj+3G8g9yKOUxsCYEFdlj5zufZAHdgH3nqdWfqS2F9m9qYd3Rat787Dz0G25djOjaXCt1coZotdgYMdQhYR5ZyuWdnlULcch1/4Y5DKUDYpmxiyVhnCG9CVFmIYg6I/gwJ2SynHF8FyKLAcmdCK7tnXwlrlTICHYyKA+db4LYwKiUGEEnFSv7qxR82BJ1bXMCpC7KkWXzFsGRWgC2Oo37RknBGd3AMMWaF5SJvzXxSmlygQ2+aptfwcqV4vgT9qp41vCuxTh2Z1NbE2I33gB9/c1tmJa9+sFnYcLKEG4rForgO8g+IjuACYH2QnvtdncmuKfCg/d9h2rthhP0kNqqlHJJpulz0Q2/ydHGjBvZdiMHv3NVYmTE+d5fz04A2FIXC2zo2e/H+pEvG1nR5MLGW22VpZX/DCYKQ3wN2BZnRIGsISth0bYR8NyvFaTv4NKsK7NBLjz06LUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbe137d-d46a-427d-2035-08de78774179
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:17:53.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWLZXpngzRkQTaKZofcFfFnP/QPV5fKtvpgb/9MCikvTSD1ZygPs38Sgox6H0jqz3V0Q5qHtpNgDpiGGVCg5bNnXNYwVBSNWHQi/lkDEKeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=919 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNSBTYWx0ZWRfX6qnE6Npxlj1B
 yLNkNTFJffz6Oqy4mcOP8aT/bGbVuWwb25tdcmD0E8lk0EOim//LUOZRMbeZxWd8zb2Hr2x+QHW
 x71hxW95bKb4X5WcORCGy71DYFYaG4XbuxRXnoZfFB8viAxQPFZpWMQB+GMsdYKaG3DYIPScwr/
 y1EI3LtIqblOi1OVI9AfCaxPRCeYj/nnT+8slqipgD/0V0RzB2AD47dauF1T3FNVPzuz3q/05De
 DbNFAkyq5flVixyJfg4FyJUUT3RelqY/7baVE2234t/QVKxhFudTuuLNobwTvR+WPhjrkx7MaFM
 XZZA2qJRBKejtzggwdFMQOKKmWfENtJDYxOqgrvESYmt1Eo3t2qHcgZC3kKgiMYMZdswXp7R4F4
 QTSy0CS8bF9AQhOCQDTGhhQm+OgFQxhW9ZrPbyTtcv4WAovNnqVt43FR7KOC3gVmsOjTNdjE3FV
 /WlizQ50An2UD7EMpIr3yEgHpokRhlxdYtQgbA0o=
X-Proofpoint-GUID: v_7fEzUXqwV3PLO9Nm5YjECfJca4ztnT
X-Proofpoint-ORIG-GUID: v_7fEzUXqwV3PLO9Nm5YjECfJca4ztnT
X-Authority-Analysis: v=2.4 cv=DcMaa/tW c=1 sm=1 tr=0 ts=69a5b837 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=wSTVksCdmpodstxb9IwA:9 cc=ntf
 awl=host:12262

This patch adds support to validate a pointer as not null when its
value is compared to a register which the verifiers knows to be null.
Initial pattern only verifies against an immediate operand.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..6e3fcdfa3643 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17608,12 +17608,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
+         * Also does the same detection for a register which the value is
+         * known to be 0.
 	 * NOTE: these optimizations below are related with pointer comparison
 	 *       which will never be JMP32.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
-	    insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
-	    type_may_be_null(dst_reg->type)) {
+        if (!is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
+            type_may_be_null(dst_reg->type) &&
+	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
+             (BPF_SRC(insn->code) == BPF_X && register_is_null (src_reg)))) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-- 
2.47.3


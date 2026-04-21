Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791772EA151
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803010; cv=fail; b=L1hOI6SDOAnymeion5PCi0c86giEcThj7V2ASmTGlR5aoTXoIgctmZ5d1jvhDTqOZ6tSK+tkN1ZlKkTcZibl9SXF4gkirIyT12UR9Akv98H3fKO8b1f2mO0UwK9RjgHmd7GOlXy/agSUsZD6hEBBKYKMQOcVov/vk0lC8L09aRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803010; c=relaxed/simple;
	bh=VtQK92AxwoT8C+e/pcqbuDpvt00npy138NuMPJCQmVI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RoXC5Wp8u8fpL1D2BY1GsnVmTVR72ukCpi4S95UbawKE0yinbyIOxPYPapBPOdDF5bIZuIi1+mFgXnkfHendLOC2l+Fz68ZJwonya+ROQfNufLKSYGJ7sa5y0qUeKzke3M7/JxrWq0vtUbrL6f+iycOYTlEZNbBkhCVB37GQKQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVFgCDN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QMOMz4JB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVFgCDN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QMOMz4JB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIaC5m3737355;
	Tue, 21 Apr 2026 20:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bIyYtNE/ued7ZiNC
	kzVZlsaZg2lU+lmhnVxsu9Kv+9Q=; b=iVFgCDN1vGIOO4iN/v8pGEjbGQEpv/oa
	8UPAa8GSsScsUArSNzaUOrZ8Ze3ZaWIV77EgVU+fNniE73A/zXz0TYLmVW5r7CZ0
	D9CH+7rL0BVN65hTgGLJTBFD4EvwJC2Wp9FQE/8q+4PFahessqn0S4nOa/i1+Ivy
	cdJRn2+XBKdxzxOLhJ6kx6qGuMnKwNSqky9QnQEcx5bO1NXkymP2sWFVoneZ1hWT
	LXOEHtLjHC8fk+heLLOZdbXLgtZlwvQAwQ6griPEqYJNwfcEH4mJazPINVJnm/4d
	WAoWyRvThCdGSNPYTxjx1LTMLxfWLj4gAoTQq6bCzstCyECJ5a7Lsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenj85s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 20:23:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63LKGAJw008803;
	Tue, 21 Apr 2026 20:23:06 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1agj5g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 20:23:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6xj8ewjivGY78uA9cf+KuhtT+7p6D5BN7ZisZyBI0sQwIzhVilwgs2XcMpdPA3ICtFksgON0rPpN2J5ypCrtIydyNQj/+wE0ToYMgA2MxCOTEFLA6jm+otKXeN9oYophk4HsBHXo0mx/O+kVRHUQT+geGR+5aRA/FZkrWwLu0gkVpqaj+Dy+Eg1Y7c507rreCyfQNYSX6rAA2lpV4ZuLOQp1XuprKUKY8s1yEVFmcnforjZU1QYnHT/ayjA4vb1ogeu0kA3ZvAAHrqmCJvumcSePUjQ+3XizT8ig/PgKCj5uGH1ovRKaoPXwjQeTBoGKRLT2lFAjQnEDTKm6vbf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIyYtNE/ued7ZiNCkzVZlsaZg2lU+lmhnVxsu9Kv+9Q=;
 b=Y2M2Z9N8BjDF0BN8HH9OacgHCnZeAuJZdis1SEo6m83haq9wjXeEAUwshRiwHqDKE4GfX/14dBtLfpEnzUNQ0f+VhQ4viBOmkAmoSpeBlKrYmkYKwYmO9QcAa5CJFnUbJVzseQ6ayY4/nqLELwbYUZ5R+4U2A+HL95lsqAgZ52u36zzLb00cr9kpwppfA5QRRHFPW/7COfbfLlXuWvw2vXwDWJeAQdhzzi95uGqvXK7dbWT+Dn12BB8EveTSjD9HFW0Jurjqq4oDtlVEnwlmEBLdWwYnDdSYCd3qLakP8dfAOUPkp5NPyhJ5wwG81/t8xuEmjxQJ8YBLB619rlOwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIyYtNE/ued7ZiNCkzVZlsaZg2lU+lmhnVxsu9Kv+9Q=;
 b=QMOMz4JBPJPnnketX2tISEAqrARYAXUhVqhRd3/d+WUBeRk4JXM2YZb/9+apqp64fRF+Xu9QANQ0Mvdjo42A7sxOHO32V+YuyFHRuXDnHD0Lfd/IosIRdaBULqRaCQBMK6ij3kguo8dYrJZLR3SoiJ4zAOXUD1wbnzyw8dHdbuU=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by PH8PR10MB6575.namprd10.prod.outlook.com (2603:10b6:510:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 20:23:01 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 20:23:00 +0000
From: David Faust <david.faust@oracle.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
        eddyz87@gmail.com, jose.marchesi@oracle.com,
        cupertino.miranda@oracle.com, vineet.gupta@linux.dev
Subject: [PATCH bpf-next] selftests/bpf: remove string.h includes in bpf progs
Date: Tue, 21 Apr 2026 13:22:33 -0700
Message-ID: <20260421202233.528128-1-david.faust@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|PH8PR10MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 491eabfd-9c72-454d-aebd-08de9fe3c89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xoyyLi5h37LhyyEihhpgm4rWg0K1ZCXUqXzSbAQbPuqgMinOFQNN+V72xWJWMAh/sutijm/306uj2WmR3TV6tXKVO7Ra2Rd2hzTjYNcP6+BmGZ6HT7/clzsLPGZnmIKY0SEs5E9iNRSmEF/gnZxwPdveG6KDs3wCMkKfxS6Z9aQ02J65jdRLcAmDMFfRuf1pwMoWYyltfa9PnZ+PjmXYpAiP6DLj9YJuEyqTAc7BoV1Kup/3xPp2R2W1QS9kJvCliFp1TXASX5SzsMMFFRsFCevWn3KBLiTTaXeWZZ6bJW8/WEpyXK4GwaIZyN7QHJbnmo/RnZvv7Tb7pZT/O/vZJZlZzEY9viaSjmsBYEBsfrIijFQ1FMr84T48zb6aGq5w0/k9rFP7giIaqQZly36DqrvBfcjVamon0PHPR/v2fzoVg7uP1I9c6J+Q19L+X1Mr2EnAw/M6TXPc9zjIFAK/S8e154WuIEBwlHjytl//6So8VidVg/MXVhbaDZL90tBD1NQj04Op/JzKe9KUpSmdzCr32PJu6NBYlGRNL+rkHhGbi/UVp/4jhlXa+l3GxzVBR4VAQUyb80IF7xplxZi3IRnaPWOgUic8d2MbNx71n2Txi37785pjo1T4lZG2EyHq+SsC45JqPekBRBktI6+oGm9ag7V111EkCvAamsPpXD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgjaqySqFl2ligSxuDZ9NL+xrPVp/Yz9YwQpdPZ0dkpP9FaxJpbGLQcLSHZB?=
 =?us-ascii?Q?fFWuj6vXlxtq8xBdnbsoWETC6VpiTpGnWjIVw5RaUTSlRlS/7h/Yxon3E1OZ?=
 =?us-ascii?Q?1TEUMsQf1I7iB2hoRx5Vgyq/1ejT/883xhPKnHtP7qjjuOT2PAvODxW7d7Uq?=
 =?us-ascii?Q?/U/BySdr7lIml9YCVtiuE6tHPd55M+PmAjwrKxXOSDqX9NAMT4b8Fmjdul9B?=
 =?us-ascii?Q?sX24tIir6LBHHojwaOWs9ZPBCV5K1V7mzWkVTSLepk5fflVe8ws/AaSnrZkA?=
 =?us-ascii?Q?t2axS+GQ7/9QhgaSz4bvZaVfyq941h0xpV3sz2tpBX1nFwA7KZm0kQZpI2sl?=
 =?us-ascii?Q?tVjD8TXjjapsIzHrdWkO/wYalA2JpgWshsFnnU5LvGIhkZv8Svzc4O+DafeY?=
 =?us-ascii?Q?mi+vceZjl05v8KvbyKKCBRzgzrlutmEpxjv8rURYf4sslAKn8ewEeEZkmM80?=
 =?us-ascii?Q?H9JxvaV+8y2uMLN3zmR4vRxrbA9rVQ+fhSHepAWb2TQHtbVWaKDQwuU3/eS2?=
 =?us-ascii?Q?AUPipftiUAVWO1eQkw1FCe5O4mmHsYLI3e4mjI6qtEvaYzZlKb5xCB7hD5OE?=
 =?us-ascii?Q?M2nkLLnWOSyGbAdga4a8bnzkaLohmum/rwE8XeclYOEig4E/BxMjoMtfDncS?=
 =?us-ascii?Q?Kt50C7N1N0+/VTYU1as8YIIBLi91Q3E71ujPnLlYjAdsSy2/4LcdsZoLEHz/?=
 =?us-ascii?Q?l0K6h16f4h2OZpviF5x7GQgK6wTb3T64aWF3uSelrnlFwM/wjJpvvoOVxrL0?=
 =?us-ascii?Q?5eiyBNuHcJoDHmUnhv9fCMtQ40karewsNAfl10SU6RW2303aEjDk6xiyYKhk?=
 =?us-ascii?Q?aba1qzklnJOwOVKE+GUgi83BniK9E+qB0NqDC0yP0dzN4OhHl9euvWMSRurQ?=
 =?us-ascii?Q?INdDtq0y9T+mwWXqPunva2dlXnNEs6emK1Psp2NvEtoNNIkJCeiv4J5uqe2p?=
 =?us-ascii?Q?ym5tG0RUmJS6YQDmTBp4IgF7hW4b3uMJPfkEfj1WBxmjw98wPMceDybOLzM1?=
 =?us-ascii?Q?EEdOlAbx3dciCoRap6hVyjzo2B3hhIAwqgsuqeNJ4pTsilT8zCK47Z3WIIf6?=
 =?us-ascii?Q?3JoTaqduuJAv1hVNEGChxXeg7vHTPAwbDDxvFVpPdAzHiMAW0GyPODThmanm?=
 =?us-ascii?Q?BMa40r86LbzIPgHd0rtkQI+at8ydW6l+8SizSKufM09n+Z9TBERW7yHHobSO?=
 =?us-ascii?Q?0RkIr+pxzojtHoEySXZIPBsA9oUxg3AaBd5dQYXVVFYBRew4VkYolkJUjPfP?=
 =?us-ascii?Q?5HcRNs+/O8mrVQalVxb0JD3uyixajieKWTiYcZ3yx6zrDy3Fb92/FfThxsjx?=
 =?us-ascii?Q?qBNELkJ9ehTeo9NUXP1Iwxxrj4vXYp+uoa0VxIXeXK/nFClXStfnnFKilLIm?=
 =?us-ascii?Q?DFGfuaOPVbQH9mQxF7wNS3RcAf9aoCqObWlDotbuf8pENqaGKT5gSNr/wjpW?=
 =?us-ascii?Q?ASMALHqePrEqsv0fEHv46ZBk4g+bt3mWjh1ESqw7M6GXNkMpuG07B0q3oGEI?=
 =?us-ascii?Q?oSmjn9zz5pw/V0OkailkX/jV7cP/PJI3tq9IJnLC2UoexXKIA4/jYI6m3O4C?=
 =?us-ascii?Q?2U0duKNtUHD1tGvcWUAFbb8efzLTkzcNbr8ffLocxwk1M7h48lZTvxthF7fq?=
 =?us-ascii?Q?nTFSLUoUvCf3KA9MWSX+x9V44fwP+dd0oy33MSOgyjV19apLsQSnTdAfNqJ4?=
 =?us-ascii?Q?t3qZ3GIqzA5tfAmxtZeNT8l2OoriweQgRM88ZMOsUVnDdYfEzeJ12O1sm+IQ?=
 =?us-ascii?Q?wt1RFXJ25Q=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	tq9P0ZPer2emaiIATUGQVCdZaNlFLV2fr3EiPKM1mfO3E5SmqlHpUZCM7znB8e8wQGQjoWnVq3u+9VzsXBYAhNssmDwuOP1+bzE5GUaTy5+pN3TRByRxNykuDTmb2E8CT99J9ya4ib2pkazwVPAZ6qXGtHA9iF2pCi4aDqwxsPJ9H4k//UthkG8LmFF/lp+92fQj16PG2rWv9RmhFLGAxPLWj4dtBzXaiQyUAZ5lhLp00F6pPUlFQ0FsjTd3eOjK8BDQSI6143+ElCEknIavOzyi2+FrzXBdbksUCbbOiFUi6Sp80CxAog1Jsrf58YU1d7W/j2PlYAlImTU6KQoFmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pnLBiqo0VB8IJYQI4Y45eSzwrrSDmgmtTQFYfKynTtZOvFs8vagDQovi+CJZ+plPlcs2/uVgyW1DzlddR1CAPylfMvpPzld5jGCQuSThR+96MBCYPAzYPcofjImT4SV2BqSkScDVzy4HXTSnw4RDDj7BbVboxYfCnrbFP4JiHNi9KSbFJ9tboyECkFop+r2n4aD9VlnXoMYj5qLribwgI7yra/jJRWzkvoiPqhFltcFXxwn5My1auVemwYq2TjUQwJ436n7Jn7v6ZWoI2I9I+ndhGbHpSMrnJWI9lLwsLnpT6YNIwYLfvL1vlpEO2Z9g1LZuRgoq/AtcUHtVFdc+LUiAN5PEjn0csVG6fr/X+VF687OXKbyBugaqw9vGksQoO2Idk3Dr9D3vh/fdUe4FFX37MOv77U9clDCQ5D0IHeyo5qGBgiUM3cXhVtVjVj3jsTzsaDlwx13uFFKed9a3g2YXf7pgXbSWALfrde6++MWYpBxaMpwp5lOvDpKuTsu05qTT8tNzGp7mVEj6pn0SUj4NjQmp4um50HrUnsq9W0syQV+hIpbWp2Jf1qbAY0gg0lDuvkPXwGixw4mJkZCVDYN3X0lRRHnfqRSQFjaL0M4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491eabfd-9c72-454d-aebd-08de9fe3c89f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 20:23:00.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7h4HPHYtfxTPkr6AdwYX+M49ow83fADyDcpJ1W3iMBkX1KWk7tj8BcESSklWRY2mA3RD0cQ3ibqM8z7Z0oz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604210202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIwMiBTYWx0ZWRfX+MzwNpaHZtLO
 v+ZN2CG6uC1RCMgtOuNBSwzAarmnqsWDePo0OuF6ZIVyIw2jhqm5RJzTz923eRCiPUA8JPB/Ho5
 +llCr0zVWj1nE3D7dq2YI2ergn6q7qMUOFEohLcr+pOR52qVT9TJhOKIKUCj5kAcV91mWSBjOnx
 Bfgexf0u1MfXpFh3ossmwjM/VfY9V0iGn7hYvavaqSGZm7bsgrfJRIw8vJ3oSxGeC6+j25pYzkh
 14wS1ZnUp2z9MMD1oOpdzGHUaMSJ/rArmahcbvSPzK5shM0dj5DWx+PYyNfKrgpT0SjH414XXKc
 UKc+QYF5bbJXf7cYMD+u7vEHH+m62Jei7LzWO+I6w7AKLOaj6rHALEYLhqGh2ezxCB82Ml9O8Mg
 C4FJYrSFt4cj3XigrMd/X0tO2le6l9LXXawFJ89ZMTYneUKYjYsNEnCvrNwavKXlXJtDUjzIaJH
 YK07j+ggsneWZo8XRWA==
X-Authority-Analysis: v=2.4 cv=Xay5Co55 c=1 sm=1 tr=0 ts=69e7dcab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=qN5x4-dDAAAA:8 a=yPCof4ZbAAAA:8
 a=aHK9c76d16DFFZU0slcA:9 a=eRomG03KX0izBQhz49w_:22
X-Proofpoint-ORIG-GUID: ddz5k2GnvLJ2gPoh2RWBcI_mWrAfgt_z
X-Proofpoint-GUID: ddz5k2GnvLJ2gPoh2RWBcI_mWrAfgt_z

Sources for some BPF test programs currently include string.h, which
is a glibc header and not a toolchain header.  Since there is no BPF
glibc, this means it is the native system glibc string.h which gets
included when building the test programs.

In all cases the include is only necessary for the prototypes of
non-builtin versions of memset, memcpy, etc., and in every case both
clang and gcc already replace these with the compiler built-in versions
and expand them inline.

In the case of gcc this replacement happens after initial debuginfo is
generated, which includes the calls to the glibc routines.  This means a
BTF record for e.g. 'extern memset' is emitted, resulting in load
failures like:

  libbpf: BTF loading error: -22
  ...
  [26] FUNC memset type_id=1 Invalid func linkage

This patch removes the includes of glibc string.h, and replaces the
calls to memset and friends with the compiler built-in versions.
There is no functional change other than to slim the compilation units
and eliminate the BTF extern func records, which enables several
more tests to pass when compiled with gcc.

Signed-off-by: David Faust <david.faust@oracle.com>
---
 .../testing/selftests/bpf/progs/bind4_prog.c  |  1 -
 .../testing/selftests/bpf/progs/bind6_prog.c  |  1 -
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  5 +--
 .../selftests/bpf/progs/connect4_dropper.c    |  1 -
 .../selftests/bpf/progs/connect4_prog.c       |  5 +--
 .../selftests/bpf/progs/connect6_prog.c       |  7 ++--
 .../selftests/bpf/progs/connect_force_port4.c |  1 -
 .../selftests/bpf/progs/connect_force_port6.c |  1 -
 .../selftests/bpf/progs/connect_unix_prog.c   |  5 +--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 11 +++---
 .../selftests/bpf/progs/dynptr_success.c      |  1 -
 .../testing/selftests/bpf/progs/file_reader.c |  1 -
 .../selftests/bpf/progs/file_reader_fail.c    |  1 -
 .../selftests/bpf/progs/getpeername4_prog.c   |  1 -
 .../selftests/bpf/progs/getpeername6_prog.c   |  1 -
 .../bpf/progs/getpeername_unix_prog.c         |  5 +--
 .../selftests/bpf/progs/getsockname4_prog.c   |  1 -
 .../selftests/bpf/progs/getsockname6_prog.c   |  1 -
 .../bpf/progs/getsockname_unix_prog.c         |  3 +-
 .../selftests/bpf/progs/iters_looping.c       |  1 -
 .../selftests/bpf/progs/iters_state_safety.c  |  1 -
 .../selftests/bpf/progs/recvmsg_unix_prog.c   |  5 +--
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |  5 +--
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  3 +-
 tools/testing/selftests/bpf/progs/syscall.c   |  9 ++---
 tools/testing/selftests/bpf/progs/task_work.c |  1 -
 .../selftests/bpf/progs/task_work_fail.c      |  1 -
 .../selftests/bpf/progs/task_work_stress.c    |  1 -
 .../selftests/bpf/progs/test_cls_redirect.c   | 19 +++++-----
 .../selftests/bpf/progs/test_cls_redirect.h   |  1 -
 .../bpf/progs/test_cls_redirect_dynptr.c      | 21 +++++------
 .../selftests/bpf/progs/test_global_data.c    |  1 -
 tools/testing/selftests/bpf/progs/test_l4lb.c | 13 +++----
 .../selftests/bpf/progs/test_l4lb_noinline.c  | 13 +++----
 .../bpf/progs/test_l4lb_noinline_dynptr.c     | 13 +++----
 .../selftests/bpf/progs/test_lwt_ip_encap.c   |  5 +--
 .../bpf/progs/test_migrate_reuseport.c        |  1 -
 .../selftests/bpf/progs/test_pkt_access.c     |  1 -
 .../selftests/bpf/progs/test_pkt_md_access.c  |  1 -
 .../bpf/progs/test_queue_stack_map.h          |  1 -
 .../selftests/bpf/progs/test_sk_assign.c      |  1 -
 .../selftests/bpf/progs/test_sk_lookup_kern.c |  1 -
 .../selftests/bpf/progs/test_sockmap_kern.h   |  3 +-
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  3 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c   |  3 +-
 .../selftests/bpf/progs/test_sysctl_prog.c    |  3 +-
 .../selftests/bpf/progs/test_tcp_estats.c     |  3 +-
 .../selftests/bpf/progs/test_tcpnotify_kern.c |  1 -
 tools/testing/selftests/bpf/progs/test_xdp.c  | 13 +++----
 .../selftests/bpf/progs/test_xdp_dynptr.c     | 13 +++----
 .../selftests/bpf/progs/test_xdp_loop.c       | 13 +++----
 .../selftests/bpf/progs/test_xdp_noinline.c   | 37 +++++++++----------
 .../selftests/bpf/progs/test_xdp_vlan.c       |  1 -
 .../selftests/bpf/progs/uprobe_syscall.c      |  1 -
 .../bpf/progs/uprobe_syscall_executed.c       |  1 -
 .../bpf/progs/verifier_subprog_precision.c    |  1 -
 .../bpf/progs/xdp_redirect_multi_kern.c       |  1 -
 .../testing/selftests/bpf/progs/xdping_kern.c |  1 -
 58 files changed, 106 insertions(+), 164 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index b7ddf8ec4ee8..556846fe05c1 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index 501c3fc11d35..1ed793e5dc68 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index b04e092fac94..74b714ae36ee 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -2,7 +2,6 @@
 #include <limits.h>
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
@@ -78,7 +77,7 @@ static __always_inline int export_flow_keys(struct bpf_flow_keys *keys,
 	__u32 key = (__u32)(keys->sport) << 16 | keys->dport;
 	struct bpf_flow_keys val;
 
-	memcpy(&val, keys, sizeof(val));
+	__builtin_memcpy(&val, keys, sizeof(val));
 	bpf_map_update_elem(&last_dissection, &key, &val, BPF_ANY);
 	return ret;
 }
@@ -331,7 +330,7 @@ PROG(IPV6)(struct __sk_buff *skb)
 		return export_flow_keys(keys, BPF_DROP);
 
 	keys->addr_proto = ETH_P_IPV6;
-	memcpy(&keys->ipv6_src, &ip6h->saddr, 2*sizeof(ip6h->saddr));
+	__builtin_memcpy(&keys->ipv6_src, &ip6h->saddr, 2*sizeof(ip6h->saddr));
 
 	keys->thoff += sizeof(struct ipv6hdr);
 	keys->ip_proto = ip6h->nexthdr;
diff --git a/tools/testing/selftests/bpf/progs/connect4_dropper.c b/tools/testing/selftests/bpf/progs/connect4_dropper.c
index a3819a5d09c8..fe483fb389f6 100644
--- a/tools/testing/selftests/bpf/progs/connect4_dropper.c
+++ b/tools/testing/selftests/bpf/progs/connect4_dropper.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 9d158cfad981..15f0ce5032bf 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
@@ -147,8 +146,8 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
 	struct bpf_sock *sk;
 
 	/* Verify that new destination is available. */
-	memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
-	memset(&tuple.ipv4.sport, 0, sizeof(tuple.ipv4.sport));
+	__builtin_memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
+	__builtin_memset(&tuple.ipv4.sport, 0, sizeof(tuple.ipv4.sport));
 
 	tuple.ipv4.daddr = bpf_htonl(DST_REWRITE_IP4);
 	tuple.ipv4.dport = bpf_htons(DST_REWRITE_PORT4);
diff --git a/tools/testing/selftests/bpf/progs/connect6_prog.c b/tools/testing/selftests/bpf/progs/connect6_prog.c
index e98573b00ddb..cdda6abeae19 100644
--- a/tools/testing/selftests/bpf/progs/connect6_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect6_prog.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
@@ -32,8 +31,8 @@ int connect_v6_prog(struct bpf_sock_addr *ctx)
 	struct bpf_sock *sk;
 
 	/* Verify that new destination is available. */
-	memset(&tuple.ipv6.saddr, 0, sizeof(tuple.ipv6.saddr));
-	memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
+	__builtin_memset(&tuple.ipv6.saddr, 0, sizeof(tuple.ipv6.saddr));
+	__builtin_memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
 
 	tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
 	tuple.ipv6.daddr[1] = bpf_htonl(DST_REWRITE_IP6_1);
@@ -74,7 +73,7 @@ int connect_v6_prog(struct bpf_sock_addr *ctx)
 	ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
 
 	/* Rewrite source. */
-	memset(&sa, 0, sizeof(sa));
+	__builtin_memset(&sa, 0, sizeof(sa));
 
 	sa.sin6_family = AF_INET6;
 	sa.sin6_port = bpf_htons(0);
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/tools/testing/selftests/bpf/progs/connect_force_port4.c
index d5be6a559d6a..0f60c4789237 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
 #include <stdbool.h>
 
 #include <linux/bpf.h>
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/tools/testing/selftests/bpf/progs/connect_force_port6.c
index a1a671b39083..047a2462abef 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
 
 #include <linux/bpf.h>
 #include <linux/in.h>
diff --git a/tools/testing/selftests/bpf/progs/connect_unix_prog.c b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
index ba60adadb335..baf9189ca863 100644
--- a/tools/testing/selftests/bpf/progs/connect_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
@@ -29,8 +28,8 @@ int connect_unix_prog(struct bpf_sock_addr *ctx)
 		return 0;
 
 	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
-	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
-			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 0;
 
 	return 1;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219..75c8a949ebbd 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2022 Facebook */
 
 #include <errno.h>
-#include <string.h>
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
@@ -457,7 +456,7 @@ int invalid_write1(void *ctx)
 
 	get_map_val_dynptr(&ptr);
 
-	memcpy(&ptr, &x, sizeof(x));
+	__builtin_memcpy(&ptr, &x, sizeof(x));
 
 	/* this should fail */
 	data = bpf_dynptr_data(&ptr, 0, 1);
@@ -480,7 +479,7 @@ int invalid_write2(void *ctx)
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
 
-	memcpy((void *)&ptr + 8, &x, sizeof(x));
+	__builtin_memcpy((void *)&ptr + 8, &x, sizeof(x));
 
 	/* this should fail */
 	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
@@ -505,10 +504,10 @@ int invalid_write3(void *ctx)
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
 
-	memcpy(stack_buf, &val, sizeof(val));
+	__builtin_memcpy(stack_buf, &val, sizeof(val));
 	len = stack_buf[0] & 0xf;
 
-	memcpy((void *)&ptr + len, &x, sizeof(x));
+	__builtin_memcpy((void *)&ptr + len, &x, sizeof(x));
 
 	/* this should fail */
 	bpf_ringbuf_submit_dynptr(&ptr, 0);
@@ -601,7 +600,7 @@ int invalid_read3(void *ctx)
 	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr2);
 
 	/* this should fail */
-	memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
+	__builtin_memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
 
 	bpf_ringbuf_discard_dynptr(&ptr1, 0);
 	bpf_ringbuf_discard_dynptr(&ptr2, 0);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e467e..e48152da6b87 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2022 Facebook */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 462712ff3b8a..fe07ac37eacf 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..2367cdc01fc2 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/getpeername4_prog.c b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
index 4c97208cd25d..937a874edded 100644
--- a/tools/testing/selftests/bpf/progs/getpeername4_prog.c
+++ b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_core_read.h>
diff --git a/tools/testing/selftests/bpf/progs/getpeername6_prog.c b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
index 070e4d7f636c..1aac19724ed1 100644
--- a/tools/testing/selftests/bpf/progs/getpeername6_prog.c
+++ b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_core_read.h>
diff --git a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
index 5a76754f846b..237633664af3 100644
--- a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
@@ -28,8 +27,8 @@ int getpeername_unix_prog(struct bpf_sock_addr *ctx)
 		return 1;
 
 	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
-	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
-			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 1;
 
 	return 1;
diff --git a/tools/testing/selftests/bpf/progs/getsockname4_prog.c b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
index e298487c6347..34ecf2e492c4 100644
--- a/tools/testing/selftests/bpf/progs/getsockname4_prog.c
+++ b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_core_read.h>
diff --git a/tools/testing/selftests/bpf/progs/getsockname6_prog.c b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
index 811d10cd5525..9cb0962cbd18 100644
--- a/tools/testing/selftests/bpf/progs/getsockname6_prog.c
+++ b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_core_read.h>
diff --git a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
index 7867113c696f..5edf4866304f 100644
--- a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
@@ -28,7 +27,7 @@ int getsockname_unix_prog(struct bpf_sock_addr *ctx)
 		return 1;
 
 	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
-	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
 			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 1;
 
diff --git a/tools/testing/selftests/bpf/progs/iters_looping.c b/tools/testing/selftests/bpf/progs/iters_looping.c
index d00fd570255a..7b6b7f8ae163 100644
--- a/tools/testing/selftests/bpf/progs/iters_looping.c
+++ b/tools/testing/selftests/bpf/progs/iters_looping.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <errno.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index d273b46dfc7c..4925958a33f5 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2022 Facebook */
 
 #include <errno.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
index 1c7ab44bccfa..2af74b3213a8 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
@@ -28,8 +27,8 @@ int recvmsg_unix_prog(struct bpf_sock_addr *ctx)
 		return 1;
 
 	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
-	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
-			sizeof(SERVUN_ADDRESS) - 1) != 0)
+	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
+			     sizeof(SERVUN_ADDRESS) - 1) != 0)
 		return 1;
 
 	return 1;
diff --git a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
index 332d0eb1116f..4d23cc2079f7 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
@@ -3,7 +3,6 @@
 
 #include "vmlinux.h"
 
-#include <string.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
@@ -29,8 +28,8 @@ int sendmsg_unix_prog(struct bpf_sock_addr *ctx)
 		return 0;
 
 	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
-	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
-			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
 		return 0;
 
 	return 1;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..236b58c724f6 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
 #include <linux/tcp.h>
 #include <linux/bpf.h>
 #include <netinet/in.h>
@@ -184,7 +183,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		if (optval + 5 > optval_end)
 			return 0; /* bounds check */
 
-		memcpy(optval, "cubic", 5);
+		__builtin_memcpy(optval, "cubic", 5);
 		ctx->optlen = 5;
 
 		return 1;
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index b698cc62a371..da070b40cde6 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <../../../tools/include/linux/filter.h>
 #include <linux/btf.h>
-#include <string.h>
 #include <errno.h>
 #include "bpf_misc.h"
 
@@ -169,13 +168,13 @@ int update_outer_map(void *ctx)
 	if (!attr)
 		goto out;
 
-	memset(attr, 0, attr_sz);
+	__builtin_memset(attr, 0, attr_sz);
 	attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
 	outer_fd = bpf_sys_bpf(BPF_MAP_GET_FD_BY_ID, attr, attr_sz);
 	if (outer_fd < 0)
 		goto out;
 
-	memset(attr, 0, attr_sz);
+	__builtin_memset(attr, 0, attr_sz);
 	attr->map_type = BPF_MAP_TYPE_ARRAY;
 	attr->key_size = 4;
 	attr->value_size = 4;
@@ -184,7 +183,7 @@ int update_outer_map(void *ctx)
 	if (inner_fd < 0)
 		goto out;
 
-	memset(attr, 0, attr_sz);
+	__builtin_memset(attr, 0, attr_sz);
 	attr->map_fd = outer_fd;
 	attr->key = ptr_to_u64(&zero);
 	attr->value = ptr_to_u64(&inner_fd);
@@ -192,7 +191,7 @@ int update_outer_map(void *ctx)
 	if (err)
 		goto out;
 
-	memset(attr, 0, attr_sz);
+	__builtin_memset(attr, 0, attr_sz);
 	attr->map_fd = outer_fd;
 	attr->key = ptr_to_u64(&zero);
 	err = bpf_sys_bpf(BPF_MAP_DELETE_ELEM, attr, attr_sz);
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
index a6009d105158..78bf283f7168 100644
--- a/tools/testing/selftests/bpf/progs/task_work.c
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 82e4b8913333..85f0b7b0b2c1 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 1d4378f351ef..af853e9eaa4c 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
-#include <string.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 26a53e54b8fa..2f98c0cf9821 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -4,7 +4,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/bpf.h>
 #include <linux/icmp.h>
@@ -533,10 +532,10 @@ static INLINING ret_t forward_to_next_hop(struct __sk_buff *skb, encap_headers_t
 	 * the router, which will send it to the appropriate machine.
 	 */
 	unsigned char temp[ETH_ALEN];
-	memcpy(temp, encap->eth.h_dest, sizeof(temp));
-	memcpy(encap->eth.h_dest, encap->eth.h_source,
+	__builtin_memcpy(temp, encap->eth.h_dest, sizeof(temp));
+	__builtin_memcpy(encap->eth.h_dest, encap->eth.h_source,
 	       sizeof(encap->eth.h_dest));
-	memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
+	__builtin_memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
 
 	if (encap->unigue.next_hop == encap->unigue.hop_count - 1 &&
 	    encap->unigue.last_hop_gre) {
@@ -631,10 +630,10 @@ static INLINING uint64_t fill_tuple(struct bpf_sock_tuple *tuple, void *iph,
 
 	case sizeof(struct ipv6hdr): {
 		struct ipv6hdr *ipv6 = (struct ipv6hdr *)iph;
-		memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
-		       sizeof(tuple->ipv6.daddr));
-		memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
-		       sizeof(tuple->ipv6.saddr));
+		__builtin_memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
+				 sizeof(tuple->ipv6.daddr));
+		__builtin_memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
+				 sizeof(tuple->ipv6.saddr));
 		tuple->ipv6.sport = sport;
 		tuple->ipv6.dport = dport;
 		return sizeof(tuple->ipv6);
@@ -800,8 +799,8 @@ static INLINING verdict_t process_icmpv6(buf_t *pkt, metrics_t *metrics)
 
 	/* Swap source and dest addresses. */
 	struct bpf_sock_tuple tuple;
-	memcpy(&tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
-	memcpy(&tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
+	__builtin_memcpy(&tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
+	__builtin_memcpy(&tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
 
 	if (!pkt_parse_icmp_l4_ports(pkt, (flow_ports_t *)&tuple.ipv6.sport)) {
 		metrics->errors_total_malformed_icmp_pkt_too_big++;
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index eb55cb8a3dbd..b0a521ec9578 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -4,7 +4,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/if_ether.h>
 #include <linux/in.h>
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index dfd4a2710391..cb9355a05441 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -4,7 +4,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/bpf.h>
 #include <linux/icmp.h>
@@ -427,10 +426,10 @@ static ret_t forward_to_next_hop(struct __sk_buff *skb, struct bpf_dynptr *dynpt
 	 * the router, which will send it to the appropriate machine.
 	 */
 	unsigned char temp[ETH_ALEN];
-	memcpy(temp, encap->eth.h_dest, sizeof(temp));
-	memcpy(encap->eth.h_dest, encap->eth.h_source,
-	       sizeof(encap->eth.h_dest));
-	memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
+	__builtin_memcpy(temp, encap->eth.h_dest, sizeof(temp));
+	__builtin_memcpy(encap->eth.h_dest, encap->eth.h_source,
+			 sizeof(encap->eth.h_dest));
+	__builtin_memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
 
 	if (encap->unigue.next_hop == encap->unigue.hop_count - 1 &&
 	    encap->unigue.last_hop_gre) {
@@ -523,10 +522,10 @@ static uint64_t fill_tuple(struct bpf_sock_tuple *tuple, void *iph,
 
 	case sizeof(struct ipv6hdr): {
 		struct ipv6hdr *ipv6 = (struct ipv6hdr *)iph;
-		memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
-		       sizeof(tuple->ipv6.daddr));
-		memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
-		       sizeof(tuple->ipv6.saddr));
+		__builtin_memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
+				 sizeof(tuple->ipv6.daddr));
+		__builtin_memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
+				 sizeof(tuple->ipv6.saddr));
 		tuple->ipv6.sport = sport;
 		tuple->ipv6.dport = dport;
 		return sizeof(tuple->ipv6);
@@ -691,8 +690,8 @@ static verdict_t process_icmpv6(struct bpf_dynptr *dynptr, __u64 *offset, struct
 	}
 
 	/* Swap source and dest addresses. */
-	memcpy(&tuple.ipv6.saddr, &ipv6.daddr, sizeof(tuple.ipv6.saddr));
-	memcpy(&tuple.ipv6.daddr, &ipv6.saddr, sizeof(tuple.ipv6.daddr));
+	__builtin_memcpy(&tuple.ipv6.saddr, &ipv6.daddr, sizeof(tuple.ipv6.saddr));
+	__builtin_memcpy(&tuple.ipv6.daddr, &ipv6.saddr, sizeof(tuple.ipv6.daddr));
 
 	if (!pkt_parse_icmp_l4_ports(dynptr, offset, (flow_ports_t *)&tuple.ipv6.sport)) {
 		metrics->errors_total_malformed_icmp_pkt_too_big++;
diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
index 719e314ef3e4..c9d6c247194d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_data.c
@@ -3,7 +3,6 @@
 
 #include <linux/bpf.h>
 #include <linux/pkt_cls.h>
-#include <string.h>
 
 #include <bpf/bpf_helpers.h>
 
diff --git a/tools/testing/selftests/bpf/progs/test_l4lb.c b/tools/testing/selftests/bpf/progs/test_l4lb.c
index c26057ec46dc..6132df5a16ad 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb.c
@@ -6,7 +6,6 @@
  */
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
@@ -248,8 +247,8 @@ static __always_inline int parse_icmpv6(void *data, void *data_end, __u64 off,
 		return TC_ACT_SHOT;
 	pckt->proto = ip6h->nexthdr;
 	pckt->flags |= F_ICMP;
-	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
-	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
 	return TC_ACT_UNSPEC;
 }
 
@@ -362,8 +361,8 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
 				return action;
 			off += IPV6_PLUS_ICMP_HDR;
 		} else {
-			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
-			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
 		}
 	} else {
 		iph = data + off;
@@ -402,7 +401,7 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
 	}
 
 	if (is_ipv6)
-		memcpy(vip.daddr.v6, pckt.dstv6, 16);
+		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
 	else
 		vip.daddr.v4 = pckt.dst;
 
@@ -428,7 +427,7 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
 		if (!cval)
 			return TC_ACT_SHOT;
 		ifindex = cval->ifindex;
-		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
+		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
 		tun_flag = BPF_F_TUNINFO_IPV6;
 	} else {
 		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
index c8bc0c6947aa..141ef5fbd560 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2017 Facebook
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
@@ -247,8 +246,8 @@ static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
 		return TC_ACT_SHOT;
 	pckt->proto = ip6h->nexthdr;
 	pckt->flags |= F_ICMP;
-	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
-	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
 	return TC_ACT_UNSPEC;
 }
 
@@ -361,8 +360,8 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
 				return action;
 			off += IPV6_PLUS_ICMP_HDR;
 		} else {
-			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
-			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
 		}
 	} else {
 		iph = data + off;
@@ -401,7 +400,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
 	}
 
 	if (is_ipv6)
-		memcpy(vip.daddr.v6, pckt.dstv6, 16);
+		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
 	else
 		vip.daddr.v4 = pckt.dst;
 
@@ -427,7 +426,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
 		if (!cval)
 			return TC_ACT_SHOT;
 		ifindex = cval->ifindex;
-		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
+		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
 		tun_flag = BPF_F_TUNINFO_IPV6;
 	} else {
 		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
index f997f5080748..5c068da63a8d 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2017 Facebook
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
@@ -251,8 +250,8 @@ static __noinline int parse_icmpv6(struct bpf_dynptr *skb_ptr, __u64 off,
 		return TC_ACT_SHOT;
 	pckt->proto = ip6h->nexthdr;
 	pckt->flags |= F_ICMP;
-	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
-	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
+	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
 	return TC_ACT_UNSPEC;
 }
 
@@ -368,8 +367,8 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
 				return action;
 			off += IPV6_PLUS_ICMP_HDR;
 		} else {
-			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
-			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
+			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
 		}
 	} else {
 		__u8 buffer[sizeof(struct iphdr)] = {};
@@ -408,7 +407,7 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
 	}
 
 	if (is_ipv6)
-		memcpy(vip.daddr.v6, pckt.dstv6, 16);
+		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
 	else
 		vip.daddr.v4 = pckt.dst;
 
@@ -434,7 +433,7 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
 		if (!cval)
 			return TC_ACT_SHOT;
 		ifindex = cval->ifindex;
-		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
+		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
 		tun_flag = BPF_F_TUNINFO_IPV6;
 	} else {
 		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
index d6cb986e7533..c29db7866e80 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -21,7 +20,7 @@ int bpf_lwt_encap_gre(struct __sk_buff *skb)
 	} hdr;
 	int err;
 
-	memset(&hdr, 0, sizeof(struct encap_hdr));
+	__builtin_memset(&hdr, 0, sizeof(struct encap_hdr));
 
 	hdr.iph.ihl = 5;
 	hdr.iph.version = 4;
@@ -57,7 +56,7 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	} hdr;
 	int err;
 
-	memset(&hdr, 0, sizeof(struct encap_hdr));
+	__builtin_memset(&hdr, 0, sizeof(struct encap_hdr));
 
 	hdr.ip6hdr.version = 6;
 	hdr.ip6hdr.payload_len = bpf_htons(skb->len + sizeof(struct grehdr));
diff --git a/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c b/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
index 27df571abf5b..b351b3d91d1d 100644
--- a/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
@@ -11,7 +11,6 @@
  */
 
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..ed87887a5cea 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2017 Facebook
  */
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
index d1839366f3e1..2d279b5fb69b 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2017 Facebook
  */
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
index 648e8cab7a23..011adc80f2a4 100644
--- a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
+++ b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (c) 2018 Politecnico di Torino
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 3079244c7f96..d82b57d981de 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -4,7 +4,6 @@
 
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/in.h>
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index e9efc3263022..94b2a02cc539 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -3,7 +3,6 @@
 
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/in.h>
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index f48f85f1bd70..804ad5399efc 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io */
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -148,7 +147,7 @@ static inline void bpf_write_pass(struct __sk_buff *skb, int offset)
 	data_end = (void *)(long)skb->data_end;
 
 	if (c + 5 + offset < data_end)
-		memcpy(c + offset, "PASS", 4);
+		__builtin_memcpy(c + offset, "PASS", 4);
 }
 
 SEC("sk_skb/stream_verdict")
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 548660e299a5..03ba4eb0aa21 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2019 Facebook
 
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
@@ -24,7 +23,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	char name[sizeof(tcp_mem_name)];
 	int ret;
 
-	memset(name, 0, sizeof(name));
+	__builtin_memset(name, 0, sizeof(name));
 	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
index 81249d119a8b..f421468d893d 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2019 Facebook
 
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
@@ -24,7 +23,7 @@ static __attribute__((noinline)) int is_tcp_mem(struct bpf_sysctl *ctx)
 	char name[sizeof(tcp_mem_name)];
 	int ret;
 
-	memset(name, 0, sizeof(name));
+	__builtin_memset(name, 0, sizeof(name));
 	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index bbdd08764789..b434d6231e79 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2019 Facebook
 
 #include <stdint.h>
-#include <string.h>
 
 #include <linux/stddef.h>
 #include <linux/bpf.h>
@@ -25,7 +24,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	char name[sizeof(tcp_mem_name)];
 	int ret;
 
-	memset(name, 0, sizeof(name));
+	__builtin_memset(name, 0, sizeof(name));
 	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
index e2ae049c2f85..25b60731af50 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
@@ -31,7 +31,6 @@
  * blocks "_tcp_send_active_reset" and "LBB0_3", and used in "LBB0_4".
  * The verifier should be able to handle such code patterns.
  */
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/ipv6.h>
 #include <linux/version.h>
@@ -239,7 +238,7 @@ static __always_inline void send_basic_event(struct sock *sk,
 	struct tcp_estats_basic_event ev;
 	__u32 key = bpf_get_prandom_u32();
 
-	memset(&ev, 0, sizeof(ev));
+	__builtin_memset(&ev, 0, sizeof(ev));
 	tcp_estats_init(sk, &ev.event, &ev.conn_id, type);
 	bpf_map_update_elem(&ev_record_map, &key, &ev, BPF_ANY);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index ef00d38b0a8d..495dec0d68e6 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stddef.h>
-#include <string.h>
 #include <netinet/in.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index 8caf58be5818..dfa74aa5a1d6 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -5,7 +5,6 @@
  * License as published by the Free Software Foundation.
  */
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -71,8 +70,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
 				       const struct iptnl_info *tnl,
 				       __be16 h_proto)
 {
-	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
-	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
 	new_eth->h_proto = h_proto;
 }
 
@@ -170,7 +169,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 
 	vip.protocol = ip6h->nexthdr;
 	vip.family = AF_INET6;
-	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
+	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
 	vip.dport = dport;
 	payload_len = ip6h->payload_len;
 
@@ -197,12 +196,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 
 	ip6h->version = 6;
 	ip6h->priority = 0;
-	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
+	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
 	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + sizeof(*ip6h));
 	ip6h->nexthdr = IPPROTO_IPV6;
 	ip6h->hop_limit = 8;
-	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
-	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
+	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
+	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
 
 	count_tx(vip.protocol);
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 67a77944ef29..9c08e76eab33 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta */
 #include <stddef.h>
-#include <string.h>
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
@@ -69,8 +68,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
 				       const struct iptnl_info *tnl,
 				       __be16 h_proto)
 {
-	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
-	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
 	new_eth->h_proto = h_proto;
 }
 
@@ -188,7 +187,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xd
 
 	vip.protocol = ip6h->nexthdr;
 	vip.family = AF_INET6;
-	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
+	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
 	vip.dport = dport;
 	payload_len = ip6h->payload_len;
 
@@ -215,12 +214,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xd
 
 	ip6h->version = 6;
 	ip6h->priority = 0;
-	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
+	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
 	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + ipv6hdr_sz);
 	ip6h->nexthdr = IPPROTO_IPV6;
 	ip6h->hop_limit = 8;
-	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
-	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
+	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
+	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
 
 	count_tx(vip.protocol);
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index 93267a68825b..e1e867ee280f 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -67,8 +66,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
 				       const struct iptnl_info *tnl,
 				       __be16 h_proto)
 {
-	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
-	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
 	new_eth->h_proto = h_proto;
 }
 
@@ -166,7 +165,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 
 	vip.protocol = ip6h->nexthdr;
 	vip.family = AF_INET6;
-	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
+	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
 	vip.dport = dport;
 	payload_len = ip6h->payload_len;
 
@@ -193,12 +192,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
 
 	ip6h->version = 6;
 	ip6h->priority = 0;
-	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
+	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
 	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + sizeof(*ip6h));
 	ip6h->nexthdr = IPPROTO_IPV6;
 	ip6h->hop_limit = 8;
-	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
-	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
+	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
+	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
 
 	count_tx(vip.protocol);
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index fad94e41cef9..d022100ed08b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2017 Facebook
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
@@ -297,12 +296,12 @@ bool encap_v6(struct xdp_md *xdp, struct ctl_value *cval,
 	if (new_eth + 1 > data_end ||
 	    old_eth + 1 > data_end || ip6h + 1 > data_end)
 		return false;
-	memcpy(new_eth->eth_dest, cval->mac, 6);
-	memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
+	__builtin_memcpy(new_eth->eth_dest, cval->mac, 6);
+	__builtin_memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
 	new_eth->eth_proto = 56710;
 	ip6h->version = 6;
 	ip6h->priority = 0;
-	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
+	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
 
 	ip6h->nexthdr = IPPROTO_IPV6;
 	ip_suffix = pckt->flow.srcv6[3] ^ pckt->flow.port16[0];
@@ -314,7 +313,7 @@ bool encap_v6(struct xdp_md *xdp, struct ctl_value *cval,
 	ip6h->saddr.in6_u.u6_addr32[1] = 2;
 	ip6h->saddr.in6_u.u6_addr32[2] = 3;
 	ip6h->saddr.in6_u.u6_addr32[3] = ip_suffix;
-	memcpy(ip6h->daddr.in6_u.u6_addr32, dst->dstv6, 16);
+	__builtin_memcpy(ip6h->daddr.in6_u.u6_addr32, dst->dstv6, 16);
 	return true;
 }
 
@@ -353,8 +352,8 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	if (new_eth + 1 > data_end ||
 	    old_eth + 1 > data_end || iph + 1 > data_end)
 		return false;
-	memcpy(new_eth->eth_dest, cval->mac, 6);
-	memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
+	__builtin_memcpy(new_eth->eth_dest, cval->mac, 6);
+	__builtin_memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
 	new_eth->eth_proto = 8;
 	iph->version = 4;
 	iph->ihl = 5;
@@ -391,9 +390,9 @@ int swap_mac_and_send(void *data, void *data_end)
 	struct eth_hdr *eth;
 
 	eth = data;
-	memcpy(tmp_mac, eth->eth_source, 6);
-	memcpy(eth->eth_source, eth->eth_dest, 6);
-	memcpy(eth->eth_dest, tmp_mac, 6);
+	__builtin_memcpy(tmp_mac, eth->eth_source, 6);
+	__builtin_memcpy(eth->eth_source, eth->eth_dest, 6);
+	__builtin_memcpy(eth->eth_dest, tmp_mac, 6);
 	return XDP_TX;
 }
 
@@ -447,9 +446,9 @@ int send_icmp6_reply(void *data, void *data_end)
 	icmp_hdr->icmp6_type = 129;
 	icmp_hdr->icmp6_cksum -= 0x0001;
 	ip6h->hop_limit = 4;
-	memcpy(tmp_addr, ip6h->saddr.in6_u.u6_addr32, 16);
-	memcpy(ip6h->saddr.in6_u.u6_addr32, ip6h->daddr.in6_u.u6_addr32, 16);
-	memcpy(ip6h->daddr.in6_u.u6_addr32, tmp_addr, 16);
+	__builtin_memcpy(tmp_addr, ip6h->saddr.in6_u.u6_addr32, 16);
+	__builtin_memcpy(ip6h->saddr.in6_u.u6_addr32, ip6h->daddr.in6_u.u6_addr32, 16);
+	__builtin_memcpy(ip6h->daddr.in6_u.u6_addr32, tmp_addr, 16);
 	return swap_mac_and_send(data, data_end);
 }
 
@@ -473,8 +472,8 @@ int parse_icmpv6(void *data, void *data_end, __u64 off,
 		return XDP_DROP;
 	pckt->flow.proto = ip6h->nexthdr;
 	pckt->flags |= (1 << 0);
-	memcpy(pckt->flow.srcv6, ip6h->daddr.in6_u.u6_addr32, 16);
-	memcpy(pckt->flow.dstv6, ip6h->saddr.in6_u.u6_addr32, 16);
+	__builtin_memcpy(pckt->flow.srcv6, ip6h->daddr.in6_u.u6_addr32, 16);
+	__builtin_memcpy(pckt->flow.dstv6, ip6h->saddr.in6_u.u6_addr32, 16);
 	return -1;
 }
 
@@ -532,7 +531,7 @@ static bool get_packet_dst(struct real_definition **real,
 		hash_16bytes = 1;
 	if (vip_info->flags & (1 << 3)) {
 		pckt->flow.port16[0] = pckt->flow.port16[1];
-		memset(pckt->flow.srcv6, 0, 16);
+		__builtin_memset(pckt->flow.srcv6, 0, 16);
 	}
 	hash = get_packet_hash(pckt, hash_16bytes);
 	if (hash != 0x358459b7 /* jhash of ipv4 packet */  &&
@@ -623,8 +622,8 @@ static int process_l3_headers_v6(struct packet_description *pckt,
 		if (action >= 0)
 			return action;
 	} else {
-		memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16);
-		memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16);
+		__builtin_memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16);
+		__builtin_memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16);
 	}
 	return -1;
 }
@@ -702,7 +701,7 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	}
 
 	if (is_ipv6)
-		memcpy(vip.vipv6, pckt.flow.dstv6, 16);
+		__builtin_memcpy(vip.vipv6, pckt.flow.dstv6, 16);
 	else
 		vip.vip = pckt.flow.dst;
 	vip.port = pckt.flow.port16[1];
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index a80cc5f2f4f2..4df385738d2c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -15,7 +15,6 @@
  */
 #include <stddef.h>
 #include <stdbool.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
index e08c31669e5a..623bc177f716 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
-#include <string.h>
 
 struct pt_regs regs;
 
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 915d38591bf6..6692b13de6ab 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -3,7 +3,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/usdt.bpf.h>
-#include <string.h>
 
 struct pt_regs regs;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index d21d32f6a676..e69d3deb6e56 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <errno.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
index bc2945ed8a80..d6c91fc201e9 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #define KBUILD_MODNAME "foo"
-#include <string.h>
 #include <linux/in.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 44e2b0ef23ae..394998bdb8c4 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -3,7 +3,6 @@
 
 #define KBUILD_MODNAME "foo"
 #include <stddef.h>
-#include <string.h>
 #include <linux/bpf.h>
 #include <linux/icmp.h>
 #include <linux/in.h>
-- 
2.51.0


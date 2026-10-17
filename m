Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A643D902D;
	Sat, 17 Oct 2026 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792221498; cv=fail; b=bBBMk3AcEk8YZK3ZyK1cu4f7+faLb9TJEHIatpMlILHD++/yvI88aOT0XzzqvYvNyAAoXKZcItN7s4Nw4KlwtYKcjt58ZStQ1BZpgU7eSc0cDvQKgtbFT0KndlrAdao6UfXn5svhdwpb785US6ccqBYpLa6epxqum/tHusEVQbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792221498; c=relaxed/simple;
	bh=2g1x032ClEXeMWsKrF2YkuDTmbuCXQeatxXWUO7iS6U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=kjz9Tfsokk0broSluf5RoCQ+fIWPv5t7h75S37sxsbj+DAFt+kjO8tY8JGRXvXc+qsWAG+WI4MN3UsNYOx8wLds32w45i3w1lOMdebaErY70x1SoB6/SAdT07lPz5Y17JreNxI6aRWoMEEMKIvjplDqHXfMjRqcsICuFwFaUAJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gdA2Fnqq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gHjNoHgM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gdA2Fnqq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gHjNoHgM"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6kpnO447507;
	Sat, 17 Oct 2026 07:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WjfhXjAXdiOWSeacM3
	b50B1j+VQCek6e9AbqIHysyOU=; b=gdA2FnqquJ1EfufDn1NwihZSZiMV+EL6V2
	5GoZnAt0fEJ9Yx8vBoRT4bllNh7vfMQWgqA8XsTmW2DLCupkOuPj9NKa2Z0eRNzu
	eGv9YYP8FcHAn8gf9GExzSeleciaDa4F/KFFva3cAuHNNvacyAQPgfJQFfXOGr8E
	1PGZV3t8LRTzJl1Cx/W8x2bV0ZOqQ1dT9onu+jdZsGFGrEdvHA2XMwYphIMrhew7
	s7TTHZSt0Z109Hs+TYMV9FUQ9xS+tUKMvU1e1WEzmWMPWoPO19ptH8VvjxedVGTX
	bvKRlws4AIb/gzM0qS2pnvqUCs2oVSPyAdqAsEw2CjnyWwymi5Vg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hbyemr4k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:18:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69H76JsY002225;
	Sat, 17 Oct 2026 07:18:14 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hbyf7518w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 17 Oct 2026 07:18:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFI9btNfT2zzx2Y44nfUoq0v58QErNUdDfxq4Czq9bYEj0gKgqFBewzPy5TIltw5a0JxjvNVCX8Co06CX54u8ZuhdS/+toZH9wzC3kEEMWTvyLinr+DGTdpIqGehZ1CrCNwu3rBsXUGRgnXhSScZgs5msSU+MrqN0/B4rg2xMxPw9LDlE3/MCkngCdEuhDeneO8KgiBzGoXhodmgDnbL5/cZ5IlaEyiDbqPn28oyDhg60fN+ujnjGuuQF9jk0kJsNsFP2daJ1pXt2w+auldsdH8EKG3Tr8YSjwmoK9LEO5/1rWW+QT9lDKTfYPSm5CxNDDZ9HfhCH8MOrLGHmf6eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjfhXjAXdiOWSeacM3b50B1j+VQCek6e9AbqIHysyOU=;
 b=bkSvaNk0WI9G/k6C0w15Y6XgLUiRXgjStiJUVyzsYI0tTf42HuzfrrR6mdT70rgDV3iCoy5UajgJirt93EwqEacVYFmignVQcXyVkyyMgcGZWrlgaeonHuJAR+IzVo15QJ6o5k6+fWxsN+6HG6U8TsBKLeyEAIC8ZLESZxFe8ABdFgSpheY145Tp2FeVXjk92YXscPAqSXEPdULSxqz+ewHl68qG+NafpyMa4Xb+r3Gpl5mWJHvTlWgDzGVWfy+Oo5CHMhsAj6hnu4Ed+FcJ0v5rDAeDF9ND3iw5+2VcWaIqGnE3A52jzcWo8E8T/lDQlOtXeVjik4m2DTxRSNTFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjfhXjAXdiOWSeacM3b50B1j+VQCek6e9AbqIHysyOU=;
 b=gHjNoHgMepBu94rY5kc2UpBRx2A73yIlkhiTYwQr/rBn2uAcpIH8XFtI1UtQXRSGzsFgzryKw6z3cyrObvLMxunAHFhj8l7D2m0ilJQc8oCIyUBwubdzpxy+A+gHv9XVBaUb67QqGgCDJpO/1UUhwXI0g/JVMnzar10z/omUdnQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by AT6PR10MB550683.namprd10.prod.outlook.com (2603:10b6:170:10c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.11; Sat, 17 Oct
 2026 07:18:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.011; Sat, 17 Oct 2026
 07:18:10 +0000
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-2-ankur.a.arora@oracle.com>
 <sashiko-outbox-173919@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v16 01/16] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <sashiko-outbox-173919@kernel.org>
Date: Sat, 17 Oct 2026 00:18:08 -0700
Message-ID: <87jyngre1b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|AT6PR10MB550683:EE_
X-MS-Office365-Filtering-Correlation-Id: 630dea87-4fc7-4150-6bac-08df2c1ecc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|4143699003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	34k6fb2kDNBAiCGW6B5LLVFPND0ZajLk+0Z6cz27CzcQjz5S6J8lpUF5+vCdlJDK1PvcV01JsKm4fLdDCwcTFTOeMgLyxcZxIr/XIVs+UobM4LyvreXxC/CxwE+75qaX0BDT9NbDScmK/ylGBBlpIrjqEQ9UJV5+PEm7dG6bLTQ3oa6cJzs+5/TmZBwStHPPpQZAv53SodtMiRXHO1PaJUVxEEtkSgFF0AY17J/Ws50M4+x28vWRUJfyuLEvKNChES4JAFVgvHHaVu7HR3Vyqh3uqcUfiZXZRkjyPEUCnAQd2kKNcYzRQZ+odhYW+D6ElIMUfe6OLWkK8S+lng26p5zm68b9dVHv9mIIO93DGu9KWDtpNLmGWvOxcXOUeATP3ULiKQzpsAn8L56XJ8O4C94FtlOLbriHckXS7QSnVGgNE4VKL5rFM9x9xcZ4mCGNmfGq6wEXIzYjhsPD7M+SqqEmREgRqfw/MRcFgJ8a9mfBijgDGOnuBlcwsSlkYLS46aPKagGFVSIC0ccXaGWE3u17Exgkn1SFOOmmyS5VpuK5jqFPnyfmf+RgHB1hDSXYVfIYwbiNZJ6i1dIXz0JxX7yQfOXuWAZYUR1XKOhWAc/fnqI4ahBXjRZGU0vS73uwmadJipQbH8QGvFcLNxvvfdyFvsA6PqHFk6idxIsvits=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009221227099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9Wiz4xTevSsxIdUDZVDQ5ZWpQJKPyHivvfv4Wg0uMKYZ3cNGPmsQ6Qpz+i0?=
 =?us-ascii?Q?2W1vx8xUjccZuOwkdGTO4UNNcyLhjS4kHzIUerYAMhQ1kh6LKVVBYJuVQEPY?=
 =?us-ascii?Q?ek6O9r7804I8wPOy4oq2gvE8T/WaEJBvuFl5tw8bwkB7DgqVqVmdeNprJrdz?=
 =?us-ascii?Q?TP8jkGO/EQTVzd/UjVy9fAgzJ7uLszlBe9kgKiTcTprMu7o1etobGp4Y/NqG?=
 =?us-ascii?Q?G1cV0CGuian0DxNmGiSAWFBXbqtdjlU4cG4l4myljGODinZfnZ1V+6lb6cRt?=
 =?us-ascii?Q?sDrIGLo4eI0yDkEpozJ4vYAl8V2vA9pDDcDin84Fk7+M21Rx89Ez1Y8T+kgW?=
 =?us-ascii?Q?rRYrcKXV+BcX5h8C8+DLe7nsPdkLksVgcNhtXfBahFtokDXQHh5Cyq4sNYwG?=
 =?us-ascii?Q?qPofN4K7HMwGtaUqYjqE6X2GXBj9XcQWgw1aM7ViKj16hNcGfp8+l38WsoW/?=
 =?us-ascii?Q?80NlP5iLDxjAi/aAQfVvmS6DDM9QSRht186Sr3zLt4qk/aLQJWvxQgZYBeWf?=
 =?us-ascii?Q?yLAhSSdCeKICDzcAj7mFt4Rgx67holC8CPVqN63/qQ2obcYt5avv7Gi3wQRL?=
 =?us-ascii?Q?gjrmJKxdBO00sXDGUszYp+B+bwj6SJTDXKkyU33fyOWYkFdr6bQWT4i3sn+c?=
 =?us-ascii?Q?QBsSkcCGLTXk6h9d2M6o2dCe0QOlaLTdAtZdCWTbX6re+ery5MUQ/pzdAVVS?=
 =?us-ascii?Q?31+te+yzkB3+Q1QvDBr0y3ilcmYQkVpx6ZN2zzfYVYYwOWtDMgZZuW5i+tae?=
 =?us-ascii?Q?VUwjlugZ5dKL7tfy18PVc+NbJgCSE6H9tpct2zUHT4l3LC0cWZx/oe+krzo1?=
 =?us-ascii?Q?MEexZaNr3ispeCtvV4wm6PmoPznkPsgQDoltF9/aLhhziKDGqnT1z/RnI+el?=
 =?us-ascii?Q?tC75owc/9rwpdFnrGyX6h7nx0qQZis+sy84lU38YhX4eXrAaOjG1Ap3ofDtt?=
 =?us-ascii?Q?t5uMi+LQtREQ/6asz0OeXC+Hwf+bgro6T/KcjYDmarrEkc7F3hcjzlWLtCm5?=
 =?us-ascii?Q?ma3fS0emSFd5Y5UyhbKmAq1HaVOGPmXmWq215/pOEYptAWUAojYGNpqG4jM2?=
 =?us-ascii?Q?+AFq1qFXpMhC5xH3xrUZgSX+wJc2t1i0olJS/GEU956+jXxBVWgXLmM1MyKE?=
 =?us-ascii?Q?Q+YymayC8VWBamPuwJWE6wlJjoUvkTGjpMo2nlk3TEtAZrje40PKtIfLJx0U?=
 =?us-ascii?Q?uS7Nm3IRiVV9u5vu/lFZJE8lqdyB9cRLsqIC/qKkHEnMbwe4oxcwzvlRDpI9?=
 =?us-ascii?Q?lSRRBc+XztHOU5am7yxWexepUU+tmLvHIvud+rkTNsKrYR1ltMC8dpxwaDoA?=
 =?us-ascii?Q?Qxh34i/8S57/gRY8H1CnSa14aqx2PyO7cla9UdR8VYNcLT0BDsYHZTRoEwJV?=
 =?us-ascii?Q?ECa8ugF5ZCmcFnaTUNPkxNY7R6lrRdqw9BkC8ESGRuPBHa/D6GBGvkyrPSqs?=
 =?us-ascii?Q?A67V+fobxTPNR3GW1jIeNDsvQ+LxzhgLk2l6ZgpAznWFV1PVgI9f02mTwMiq?=
 =?us-ascii?Q?hHoloRvwjsYAMC8PPMl3HxlWbBBzYWAd2USEPKuel/fWJWv1p2TOOV0h+0+n?=
 =?us-ascii?Q?59ch6GUEA4RmOP0vbY3j22THOWNX0K4IOpjgDqc49rr1hcN/7DYbRODEmrwO?=
 =?us-ascii?Q?OdMzcE/asL7NLWXl/xC6C3UQ3osTQpPAOpjCau8H/K0XQNB1i0S0akaCl20B?=
 =?us-ascii?Q?CRwDfeNDk8aicqwbhSCtX4Qjvi6Ebh/FyFDQwmnwLKCagSRRqPL6pxOWjknz?=
 =?us-ascii?Q?JzZvCtlLSesrKZxjhB6HJnpeElZMrT0=3D?=
X-Exchange-RoutingPolicyChecked:
	Zx+956YmhaHythYf7QiaZgC/4O9D7rLICbDmwElq1sFU44rED9u9wYTw3CfPMtE3kS/LRFWRbbZKDQ1vU3SWz8lmgyIcZlntmGRRD2k7xWyh3Nhe9S/T+jckpR2KFCwekMopYQPk40PshHZQwRk1y5bv7NSaRcJtcudYRctrst383IiS2PYbrX7kIUYi46mD/ANQuNDEsuRbeo0Varhchr95dWTzFL4f85dIoYIrfY4W30l1TV7l2vZXzvmnpdXiR46OrjaWihIW0VkGd8HlbuK80YgIgJ14a+Bl3sPJ7TqD2Dm+mlv6gcPjluuDFNEGQy3RGNyT0rCifpT6/JRMAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KP1gyW93OC5QLv4jnB65KOF8Ct+Yc8oRseE8uQYdKaHKVoqLt0pquBYWwok5WzYkaV5S7ADzVdB/zCB3BD/w1Da1ZcRkIwdv8miLcOXoOKTl8FMlYmpceQ+GGydrNcOVZ29VKXQ86wzJiMPg6ldrUR5rAjZL29cvuz5767Vq87+Dg06C4aKnySXpO2ScED2mUuneLBTZosjiFJ/Oyugg9i+nzTdVmbv3nUR2u1mv4eQ7BO2SfkmXsUoGJkWGoTNdoAtQg1adtvA3GV0mz0IGdpue1k3fgDjU8uBhi23Cgk7ErLcBTE+iCkNOOBQs44g+5DRGwE4hntvj5zeiae1O2cROVp6m9WZvn69rgJ7YvFxN6Ct5PThyojkr4J+UI0NPfASSJgxn+GvAmk4eVZvnP4udJxy2Cct2GNSVbuy6wLyKyLG2AJOx/6RdVxQFxRBmHNM+mQXcfS6nQVATO+Rk2POF2gy7Hm80D4OHsTD/17VIFx70GT1XC6TdywOvCBBijgkGVlRMk5LmnleNy9gKQX1dNs5Ym1F3CadvtZa0tLT6K7IHs8MFFW3IaPLIzM9KQQTWL9lShQ1VynYwEfjdaAnIzl09qFTp2H0H9cXxH98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630dea87-4fc7-4150-6bac-08df2c1ecc34
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 07:18:10.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY3D6ntiE6envNAcBy1BO/BYXsuHaQCt4vo8nbqHKORriOxhOcvDUm0Q0W8WCq42+m1B60E1HGQoSMIeVBi1zUkleWQsVVRbWYrwyowNYRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR10MB550683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=416 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610170028
X-Proofpoint-ORIG-GUID: v4O6--RCj6wqgUaKQDiexncqarjZ-37-
X-Authority-Analysis: v=2.4 cv=H9VOUOYi c=1 sm=1 tr=0 ts=6ad32137 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=7eEbIDRFi62CbkiOTCsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAyOCBTYWx0ZWRfXyGn1L8s2bUpj
 LAl+QtIYJYLIXqlPZfTr0h7FUC0GvWE+XxszXUaaZL36T2WQIesMbesHYApC8wvGsiZI5EZvuHR
 8fbhucw7B+jcoYzamx/+hQt/XvRyamchlAuwto/pB4DArEHeewFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAyOCBTYWx0ZWRfX8m6YKbqwC0Qr
 s74hyeHcZzBImxxXqYxnp8wEylxXU3L6HHBr2CEsZ0JAu6glQLCjcVGm8f+xjY0BkyAXyBAFTUZ
 9KULQtbrlV36CnmgIlczTW3DDgz85sm7BxcLLBOwnPy/ta4fZfRvJib+C36Lit3ufRCn1Mfn+zo
 XD2LchQJYrDuKAw+A+QDDG/J4udxxb2MIe3HIWrlDYzukLfC6m8+8HZ3sq0HaHbyxOJPyylUYeR
 YDwrFEYYAR5VYRnVKzILdoWtC3K+JI6WlWQV91eB+++VReKnmPm5BPXhBlsp+sQy22iImhJ6zXh
 vuhsZ4yl15NgJI53mUklGz9oMgiAJzTH+x5b/sWebKnDM77cbqXZWdCAXgDEbWMEjQZYr4/wR75
 86dBfcMINR8oRG4rzj9+JEgrIv4aQ0JMnIpqOyPJXnh2Hvt5kEVHoXir/tchbun9lBZiy4D83y7
 Gx/HOMTCtBVedh5dKAA==
X-Proofpoint-GUID: v4O6--RCj6wqgUaKQDiexncqarjZ-37-


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] locking: smp_cond_load_relaxed_timeout breaks control dependency for ACQUIRE semantics
> --
>
> commit 33828050548c87a2007a049070718fdd9167df34
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>
> This commit adds smp_cond_load_relaxed_timeout(), extending
> smp_cond_load_relaxed() to allow waiting for a duration with a periodic
> time-check. It uses cpu_poll_relax() in a loop and defers the potentially
> costly time evaluation to a slowpath.
>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index b99cb57dfcccc..ac0a8b5e0ffe7 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
> [ ... ]
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
>> +	u32 __scl_count = 0, __scl_spin = SMP_TIMEOUT_POLL_COUNT;	\
>> +	u64 __scl_timeout = NSEC_PER_USEC, __scl_time_end = 0;		\
>> +	s64 __scl_time_now;						\
>> +	bool __scl_timed_out = false;					\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr || __scl_timed_out)			\
>
> [Severity: High]
> In include/asm-generic/barrier.h, __smp_cond_load_relaxed_timeout() evaluates
> cond_expr alongside __scl_timed_out. Does this break the control dependency
> required for ACQUIRE semantics?
>
> If __scl_timed_out is true from the previous iteration, this branch is taken
> independently of cond_expr. Because the branch outcome is independent of the
> loaded value VAL, the compiler can optimize the exit into an unconditional
> break, meaning the CPU has no hardware-level control dependency to enforce.
>
> Since smp_cond_load_acquire_timeout() (added in a subsequent patch) relies on
> smp_cond_load_relaxed_timeout() to provide a control dependency on the loaded
> value which is then upgraded to an ACQUIRE barrier by
> smp_acquire__after_ctrl_dep(), this could allow subsequent critical section
> memory accesses to be reordered before the lock acquisition load.
>
> If the returned VAL concurrently satisfies the caller's acquisition check
> at the exact moment of timeout, the caller will enter the critical section
> without hardware-enforced LOAD-STORE ordering.

Yes this is a bit of an open question.

>> +			break;						\
>> +		cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);		\
>> +		if (++__scl_count < __scl_spin)				\
>> +			continue;					\
> [ ... ]
>> +		if (__scl_time_now <= 0 ||				\
>> +		    __scl_time_end <= __scl_time_now) {			\
>> +			__scl_timed_out = true;				\
>> +			continue;					\
>> +		}							\
> [ ... ]
>> +	}								\
>> +	(typeof(*(ptr)))VAL;						\
>> +})
>> +
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
>> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
>> +									\
>> +	if (unlikely(__scl_timeout_ns < 0))				\
>> +		VAL = READ_ONCE(*(ptr));				\
>
> [Severity: High]
> In include/asm-generic/barrier.h, smp_cond_load_relaxed_timeout() handles
> negative timeouts. Does this negative timeout path also bypass the control
> dependency?
>
> Because this path executes VAL = READ_ONCE(*(ptr)); and returns without
> executing a conditional branch on VAL, no control dependency is established
> for the acquire barrier to upgrade.

smp_cond_load_relaxed_timeout() is not called from the acquire path.

>> +	else								\
>> +		VAL = __smp_cond_load_relaxed_timeout(ptr, cond_expr,	\
>> +						      time_expr_ns,	\
>> +						      __scl_timeout_ns);\
>> +	(typeof(*(ptr)))VAL;						\
>> +})
>> +#endif


--
ankur

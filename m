Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7303002CF
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531051; cv=fail; b=uFn4bBn9yTXquJxmD/36filvucmwDkmZdh+FApqym8JMzVFkgdOwQ3qyBDT6tp0Hv9JwoaonRZLhx6d+vQBzKeBqi9Ld/b+uhZmQVE6WqMcRrh+wwIP1f0qGMtxVEafNqVOjgnf+DLLuR51qKOOrgBoDsQfX4hPY4Zzpy8wXU0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531051; c=relaxed/simple;
	bh=R9JqirM8f+lyd8azORe/KuZEXhXumbktj92+OfF5R8A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uocQOAo2L1yecekYx56BwMzIqeX3EHvdG5+vOPpCudw3YOr1pP3z68+fa3oGikSBDfK/1XRPiCiftJ6bdNbe6Q69qQJZA2H3yISSXPRrypKPWR8AFCvCCSn/N/AfpXCbP9PQ5Y5W3GPIddcizpO1GgWOFddcbrPqou0Wz73O7Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qyLbrmq8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DRgZPCuP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qyLbrmq8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DRgZPCuP"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JJDIJF1318664;
	Thu, 19 Feb 2026 19:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=5frOGsnOSv/h80zMVBuj+55f0RwVKhRxVxuSYgnqQE8=; b=
	qyLbrmq8mg7nAnyH9hI3A9ZDLCAqw6quRb0JoBfWrWmQN5WtlBPLLklzyyTdG6qo
	qCanSqOnS3/vdWpbvCI9jSMzot4g5Sh5uIT3RSgbVPq5kn4EppL956jBFIPTf+Vt
	AAr5hGl5TxVSQyzmwsLk/HR1quK8MGg30pyqZug+jnI8e6nnj8Q8C7PqIsS9417C
	Hiosrb0E09ERIdcrtqCnIKFhc10ZthZriMbyWbU59O6xtYcXY8xoePCmHhavqY7E
	CbmerYzmhN8WoAXYwS/EMieW/xF5fJ9ROeeCXwt2squSw40Bggq2Vw9PMWoE3ZjP
	P3+zh75fOEPsYGheWoO3hw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rg4u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 19:57:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JJMGuJ037174;
	Thu, 19 Feb 2026 19:57:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2addmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 19:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8HqkIWH4rtg6Oc1Qs33YX/3TUaCar8aSseF8UAWGsSCl/Tl+7mZmKADE9EpfePIem+cjgT73kBnBwQGnacG/OyVCoACrsBDCLouHrETWRn6LwiY+V0kS7RXlpNvou1Ge0GzEuwID2lQ5hg0uBwSzxKNALGoQjmMN5GD+sf+2UPLw+AaJe12tleEXHgbB7HzvxiDlczckCXdLfrcMic4Vz4O8SnUEpKJSNJ2bAtwa/t8Tu9DLKnrwNBP53eStfP7UuXIhi9pIjTb6Ks5aGFqMWBDaShEUzLOgN3V4Ap/zQP5v0ASdIb4aqeTDLq4LPr/Ea2t06qhMU+BOSUWTtud4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5frOGsnOSv/h80zMVBuj+55f0RwVKhRxVxuSYgnqQE8=;
 b=dK7vVBOYazVjms3L+0WwX9IJyBrgPXaE4ZjHl4AJ0vnbwyStFl/Qp+6Jj5K/4eD9iFcDCgkgOFp4c4sUTtRQALC7RyLcyzsjN4CuazE9t9ydjCFuGwAtHy686LI6pQmScrZpEyNwLYRAd+iScaedBwRYvTLd/WzNadwPmi01VtYPFfY27LE/jKJNAiFHvUJ5CzjgJMbWr3bVFD9IuW7/T0NpDE152lWrjLDat+ZZvmL1i/TKNXaWpeZjaYVXWv4sTv6183fFPCQAOx+huC4AxK7pZ2WZTnZenaYQ27Yu1YNVHwnR78jmkLDFbxbxTsZm6fdwnd1E4wtbd79fYNSqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5frOGsnOSv/h80zMVBuj+55f0RwVKhRxVxuSYgnqQE8=;
 b=DRgZPCuPQH7yTd9yLziIP0uDdxFzn2dsn3Z9OJMRm+AKbiJat64eV4s3fHWoD9Yw0ZKp/sU6BRMUTYtn/k9qFylHt/ZbjRERKC/BxUnmjSswnaIMHuBrO/PUKcB/AI+kUEY744vQDDCFQEv4yYx1Z8722GXY4IQmClp4h9te4kk=
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb) by SA1PR10MB997607.namprd10.prod.outlook.com
 (2603:10b6:806:4b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 19:57:25 +0000
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::7d13:9138:f4b8:e7e6]) by PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::7d13:9138:f4b8:e7e6%6]) with mapi id 15.20.9611.013; Thu, 19 Feb 2026
 19:57:25 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, elena.zannoni@oracle.com, bruce.mcculloch@oracle.com,
        jose.marchesi@oracle.com
Subject: [[LSF/MM/BPF TOPIC] Progress on BTF linking and deduplication using
 the toolchain
Emacs: ballast for RAM.
Date: Thu, 19 Feb 2026 19:57:21 +0000
Message-ID: <87h5rcfqvy.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFA3184E4F2:EE_|SA1PR10MB997607:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d38c8bc-e77c-486b-0246-08de6ff11a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gjfw5F7xVEeyy17mHJu2FDtbSdpkI3t3RQTfAwPN0mBC1NSWL9GAYgAjXeBD?=
 =?us-ascii?Q?tbg3B5d0LJOS3AxAoppyhQiwO9ScB8s9u6A5naUZnfOz5vo7Cv+aJzIkJReh?=
 =?us-ascii?Q?zpA4oETIiWutRrFUaL9WOk3nqohMzEG7rClNHngmrhwax/H1x3Pr6hZ6K1vp?=
 =?us-ascii?Q?N/uAFeguO2In/pz3EJxqRA67Ard0EatoUpsDPDCIJlLHf2k3ILihCMEy0wqL?=
 =?us-ascii?Q?Vy5DcCP9QYng/72dHisQQWhycjjsowUw/wq8hnk7TR+6YqBHTYjhWbYLeJwK?=
 =?us-ascii?Q?O86IjIX5vNjGhrVlsG3Z2QfPk5MOYWVq+ce1dImFKJ1IKBiPo8r31BN2/kDx?=
 =?us-ascii?Q?4tMAZk6RmeOC+lzso43BkRGDBPSUGL3cUPibx47UuvXkNDw7xnKP8zdBZOWR?=
 =?us-ascii?Q?IigBbgYbZ41JUAlgz6AQi2DjwnDjosgMSIK+6/6oerrx+75MgdjN3EPsIET3?=
 =?us-ascii?Q?jFSH8cym/D0kT65VKVuG/5KohGaW2n5ME3eoKyiNpjHBBqJJHi+gY1IHnh4e?=
 =?us-ascii?Q?AsSAKtFN6IRHm69NPkXLt6LnS/R9DFNnSlhYpm4Lu5w5QaJ2Zx/ZEDrbGqI5?=
 =?us-ascii?Q?bTw85WxtZjBSsb+f7YVdnURGWOsBRO3/6wSXDSHA5y+SYb1ZB73KX3DNLVZU?=
 =?us-ascii?Q?xhjYI2duE7oZID71s37jZGTnsKNK6tZ1MmHyU9jDn9RA/PCPR9z5rNiRigcB?=
 =?us-ascii?Q?H/ECSjHWIhChfX2EpyZ0Db8OPpKD1za2S4BqejqFjENtkuiM/W2o5DpbaJr3?=
 =?us-ascii?Q?oXLMGgWiHPZ4I3QbGrG/QbinAlkHoklIjDjSmlh4IE+eLr6p0uj9o/Gb507d?=
 =?us-ascii?Q?06TTdBSRl4LBSx+g3Cy4CHc9U0qhGYhqOSes81qk266//UM/WOiDXUt5M+iE?=
 =?us-ascii?Q?rhJ6YGduzx53LavIGWBVFfRZgNKTYXc7/tg0uCv901hiEzy+g5R99I+U3xqy?=
 =?us-ascii?Q?5uaDOVKjA7xuJm7etYyEuKoreafESCkWvwpQHHwPR6eQyw23A/uz3cfcQvCE?=
 =?us-ascii?Q?XekOPAGXXxSrU50kddhY8gtdE+YxRqSuOZNW/eY7rxxaviLMmaaXdOi8IZug?=
 =?us-ascii?Q?M4E6kRmI9JHnL5vU1gQP1XccUvxVL5R5OihaanXKUyBewSl2OsFd8jGs9KJs?=
 =?us-ascii?Q?tpd7TQmxegBirbikL4aIl7BASwx0cM4GY9x07ROo3+wlPyxoC+1htfedigvH?=
 =?us-ascii?Q?n0E6WsOAybkgyP7tp6IuZ//kNhDteCmKNao6vz7pfzccz8VJ2HVNq0M2arW1?=
 =?us-ascii?Q?EZxhcAp3bJOs9+t7UZDstUXk9Ez1wm7mLWw+nbvahK0Zr7Dnz1BmfFppArIc?=
 =?us-ascii?Q?8ZJWExKHgqmZnTmUDZLbDw50VemH+alOwwodoSLdmReDuAEgUIP8XuPBJSTy?=
 =?us-ascii?Q?QQ+WONUegxCzz8Nm53QzWO8NQZiG9bAhjbATA4dU5GIIX0RT2ATo4Tz42lUL?=
 =?us-ascii?Q?RmlPa4FDY5KUNuNcSbM+97jqd3FraQCt8l3nKc0MIRp6DKNFMVWyA4ME7aLq?=
 =?us-ascii?Q?wjeBFvPyS5FKbug0nc6gAamJh+O/20JwwOkxxPyJuihgdTWhDA+jFQahCmO2?=
 =?us-ascii?Q?MlGCOhz8u+48C2M88RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFA3184E4F2.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sG/A9fxYDBdBmQzmygEL9yPpO7rpco0PwvVo6pHzxoL3yHUBYOZGNSFLXnuC?=
 =?us-ascii?Q?178DmzIoRV0CGXLbinhcepNoAQ+1XRt3UJ2kmVDN4YSm/qyIlvoYVNf7ZRj7?=
 =?us-ascii?Q?MMMViLk8WCNssNroBq5WrAofyI9UO71k07SrxkJVY5+6NXPPw2GXaV0vLqac?=
 =?us-ascii?Q?cEPugYIhbnB75YEqFDRgkCiuT0336Q3Fxa34Qj6/NcH9GwAaOWz0X3iNo/Pp?=
 =?us-ascii?Q?8awXlYuzx37DNhpS+JqoJpY7BWXXffKLsPeXJQSQsQbEgzKmiNgyUXS+ke/c?=
 =?us-ascii?Q?zICRO8jSkbej63YJGdRNM8W4uhDComu/JxcN0jOwuBEMbg5maz31R4CtIMSC?=
 =?us-ascii?Q?sgaPra8Lmm2Xq6BBBvOO7YORkkKf2C1CgtptYBlVRiKTdU4vTotrrmHaTOC5?=
 =?us-ascii?Q?OTr2MVIsnTz5hoXA+32Dx1op4zdaQyCgtkSsgLYNHTIHbFNcBurYq9gGk1/h?=
 =?us-ascii?Q?M9csgvjVAQ0F+ndHH1zafkqpMRH65TA+otKT4e8RTftbHDdzNlplRoa2aWjE?=
 =?us-ascii?Q?o3b1+vSUaKc8Wly/P5nirplqo99tXna08xnEq5AOCXlv8E7CK2QIy6Dpe7Ci?=
 =?us-ascii?Q?/Ro8oV3YgcR2sBozKPaeyOkEWlDhBZAAjcPa/yJDzCQhj8Uu/kUkPCgzPfDL?=
 =?us-ascii?Q?9wVdne3272tG3/cVyFn1oj2EgGWGJvKfqMmVOjPXmYVH3uTT98mxNSPk7tkF?=
 =?us-ascii?Q?N5EgCViVJMnt23cWpEWEHZ4f0GvLLZ9TMoLFgogSf5PSr5wq9cMxGMHowh0M?=
 =?us-ascii?Q?Qp0EhSLd68DXsz31u4gtxVApXVAbUGuJpAcSoHhcNdD7y//E5fYMFUs+Wp6b?=
 =?us-ascii?Q?HCNUP05hBz+DBMYEYRSvidAO9diaCeY/dY9LnUpP227z4f8QWNRO6hplusvP?=
 =?us-ascii?Q?ngeBLNstCw/N6zFdUVlwLfDA77fRuZo8aEmN2Z9j30Oc79hCwSMe4/RalbDW?=
 =?us-ascii?Q?pdcIqV6tCA/51v0LUHAli/Zajmdj+vWS/C1oAfaEdkZklbN6QSN5cq0LVaw9?=
 =?us-ascii?Q?Vimek7eQCjVsouCoQh4LcSeX01zEEGDykx83tOyKW3VDeXV2zgo6nrixucjQ?=
 =?us-ascii?Q?PzmMEFyTVgm7IIHmcLzuydYsoLk2rDp5AdAX9h8cq4qa98OMttZhB8ywJNGb?=
 =?us-ascii?Q?DjkZKOgZhKZ5m535siXSt83aBlZA8YWrw1II1nZg/F6GQBJ6htwBXOeMEm2m?=
 =?us-ascii?Q?hv3nNovr8iNaKoiVLPZycDDSN76ktbBN1LhHr5QPfEG0Pg6+LtbkayFSrGwU?=
 =?us-ascii?Q?nHQOF2A9/Jw1vw6mR4cYzo1OJodZD5nv2dRczXsZDUja5c9jHWqhsZLMwSCf?=
 =?us-ascii?Q?EmB7FYHHeLK+7TZejRhs8serq/aC6OrUNgQLdPkKPHPaDiERQEj9QzBAH0sY?=
 =?us-ascii?Q?+eaed0w84hxtAU5rI0MBRsPacN96Hx+jxkWYZ1JVVVOqNSPncNbAouX1aoEo?=
 =?us-ascii?Q?QeSq1g4TOELO0SRAlb2zrn7x+MsE2aELBePgM1CU/r95R+5QSA+ZSo1zeSN/?=
 =?us-ascii?Q?CLQQ8IwXFulmWQ3NHdjmh7mbSIpu2zPD1ctkbaySYS9rI87BgnRVyIY5E1+s?=
 =?us-ascii?Q?5ELTT8U0rGqgUjsM9SEUlAR7EyEgNkT0pEQaavf698JfT7ujW64kKG2QwgKB?=
 =?us-ascii?Q?qGxXxuvYHDfUuRbW5UcuZuyve2dcJ9GkA3z7GhX2908TGAXh7d4lL7Fv1v9d?=
 =?us-ascii?Q?2EAdob88bV2YSxJ6SGcEeXAHcv1Zlv9wryqF3DCs+HqEuI8nvuf0DDNsVC65?=
 =?us-ascii?Q?PUomhZdhHg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GaFId9Lv+8G4hROSLue2se0cCSrm6KnRstol3TxEbt3pHGbX+oOskcEuIdJxSLERfQBOqA5r4aOiLDUxshzBleYtCjn5rj2HP4cwXV97RvivAvHMuCwffk3i7IjMyioJmduTQZjpE7qerygu7MitLV2PSoYPmCBuh8bgLtROISpPme+EmZge6P5g3qZN0/Wzac9AnOnYjSdchPFoiyZjxrWzDyRtLPLVC0n6O77F0tvQd959bbYqAvJMGYQmwCZdLDgLmZ+rUKLhLeWo4rwV1uLQmDT272t8O9BxPVoXNklyOcGiqfV9wzKPJcO//jsGEOq9P+SSkWGYDKMqpjT+5JwnapLCeXRJkoZFc9Za2UNE6lCjSLdGWLQMR5q/amPJjY3GicOvF++ES1cHn9hZYtiPB3WRGfOOSGojSsSuj5JTJydlIIsrmVOwogCUkWpD1H4DaYj0gLVjkRpgfQ2cft/DQdifyprjkTa6RrvaDbXOnnCpo1utQ+zqvPNdtPYzsTnJWePn9aMF0ifeczPU/cdz2GqkVDrrkHt8Mk7UGgtMfcNRnQ9dl9UgJHw3xALaN3z1kre0BisOg6PagnKN3xRqBPbxO0AX08ANkh+GAxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d38c8bc-e77c-486b-0246-08de6ff11a65
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFA3184E4F2.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 19:57:25.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjvFutDpsslH51gdlhi/35dBRTbfL81aB/lGqnOssBLyaiHT1u4RRFbP+PYAm1grHA88KGyi5oK/ySk4ATMPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=975 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190180
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=69976b28 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=dZjs9n9QF9nCv8rMMFsA:9 cc=ntf awl=host:12263
X-Proofpoint-ORIG-GUID: DOpsp8IFtcWI9zETPhKsVMzRuEm87Mt9
X-Proofpoint-GUID: DOpsp8IFtcWI9zETPhKsVMzRuEm87Mt9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE4MCBTYWx0ZWRfX3zDvhwp630lI
 QBRohmIKkCRpR659/SMBDmRa4H1HC6MPUJCyFgS1uelniKlVQTrn/yZx9x/9AkF+ilLYEbQXz/5
 8u6/BSK9XXQRUv+GRjCsNZ6Oq0sW9GPGjciDr3hs5HedvZSwrCBZVh77O8YqlJhepwCnRCrvgQR
 HoPXCvLfPTOOv237NaH2dfhUA49aVMU7MGjiuIftI5Yq7nKS8yud/06hlXL50N1pGQaW5emJ5cr
 tpuNihWpvKlV7uPTQpC24DK0+ljCqD+gRuKvzUNJNzMXMKQnIxjYEtpjgi5Rk9Vc5TCLugHqEF+
 KvaaLfPZoZuBf3ZfEG++LRKQDZO/G+tJJz1FXClPEHknl4JQlELaVy8XBY1jBI9nC+KpKMB3Ep7
 jyfT+/YuoN7pNfoRT8qBBxOAZtjrhjYXXESOeOQfrDuXhka/sbhJabK/8vcNvF3XQBmoTaOTgD4
 9RLz+t6guk8By1xUQ1lJqn8HnsBxUqlCz3nd+qXc=

This talk will provide an update on the work we have done in binutils and
pahole to support BTF.

We have been working on pahole modifications, intended for use with
GCC-generated BTF information, providing a more direct handling of BTF
without the need for DWARF to BTF conversion.

This is done using libctf from binutils, which as of our latest version (not
yet on binutils master), can read and write BTF in a way that is fully
compatible with the existing mechanism.  We also have added support for
merging and deduplicating BTF in the linker.  In addition we can now dump
BTF with objdump.

We will show comparisons between the old and new approach within pahole,
which will exemplify differences in speed, as well as the lack of
differences in output.

This talk will give a brief overview of how this works as well as a short
demonstration.


(Like several others, I'm hoping I can do this remotely: transport from
the UK across Bank Holiday Monday is something between awful and
abominable.

I've added a couple of other possible attendees -- Cc:ed -- to the
Google form side of this: if this was overstepping some sort of bound,
since I'm not a subsystem maintainer of any sort, my apologies.)

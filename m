Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573C39659E
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715657; cv=fail; b=Wbf8+L4Q4fSTl5PNL3jgmLM5BH0QaJROOgfils3gg/vryh4d6vDXYjQHf1alVotJBtG4qsg6YCHekY7JYdVBoOq6csQOPPw97ikakuQFtpR/hEudsM43SOAhOn4HzWMbUcFYlZV8mhcH2luz6DVr1KaCx9CVV+3YcqZIX/d6NFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715657; c=relaxed/simple;
	bh=VxlBzrbsXgskMxqP8EUsITGduC+Ly3ns2H26hpBGlMc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H2gUyV4HEvr1D/0zbfa3LB3pwEWv3OVxs9xyfZ+AWSz4IuZ7wXVYkjNswDaJIUsGPevS7s1kDxnT66yeITJ1S8qrfN27HNN41JY7NM9r2nPfeFRix46mBxb93pRu3QzoLKk5Edt5PWZdUMskZYYZh541dJCJP5VO+mnYnQvd2jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V8yPERwP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zt/8gu6j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8yPERwP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zt/8gu6j"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625C3IJ0223412
	for <bpf@vger.kernel.org>; Thu, 5 Mar 2026 13:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=DfFMHQjEnozThcNL
	ldjkY5q/IaVk1Eod3+i6BnCEIow=; b=V8yPERwPZyuLGAPriBKejxDS0eSSYBop
	nw+pC7h/OPb413qp8z5c+gHk6EDhlU9r2wZRDiPYCq8XKVf4jImRhKTW2LoTnD/O
	h1sewY5UCJxFq4UIS3hg7Ks5qEmuHkvF6jhyrg+yU06NjTGDY1uUoJ313WXb11YM
	tDIbInsJthZeuxtW9b++puJpNNYtIH6UN8l12vnIQhp5obpQwIQX5F0sc99H95gF
	w6hXweZy2MqoyrSJmTMEO8elCDy3A9OvQaTtkJEAV2iuJbNRWRBtX/bshe+Fxw7u
	+Gf7DIl8imSxkamf8xSZeB2ZuHEnDVn1vM+kYBhY6xbve+1khgYRLw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cq9gh01y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 13:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625CxuVD023016
	for <bpf@vger.kernel.org>; Thu, 5 Mar 2026 13:00:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpthgvm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 13:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOI0Av9uaJ4PcFvqMj/+NqnEf/1eSEPUrql3O4RQ7g6ZW7GEd3zAismNSkRKDkEbdKJ9X8L/DjFfaEbTy3lttRpAuWCpEY1/1p4c8Ys/NqiPzuThVpMcMZaEbejcEg1cE9oY5HoBFSPaqpbduX3OB8sG6pQKN6I1Cd+j4q4XP/b0cwVxnWdp1WYJy92frbHjAeayEl206ScQgkbOLfMXHKg6HXpYAEoaraFMYir8oUmTwpm+6p1qketJZUmVcmZbr/GW7YD+kRsrrI0O+TEumtX95wPFFbTKWsjd2E0E16xwoQiu7uOSMQ0RavuWCzBGsxqXmyl1159OIgSboXeIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfFMHQjEnozThcNLldjkY5q/IaVk1Eod3+i6BnCEIow=;
 b=ZSsjQ0FLqAMQ3TtkyjdgOsGKxwHBbEoFYT+hCs3BCOXX+Hd7zkRDbVAO91+Vf/2yOlhbDh//lqb5IpBxBqSPW3Tiz7PB2YpNP8Zn1qx32bess8pFFs9w3ESlzL7MvKLU7D+McG+JgxeTmOyQI64rhgNQa1Pz3nzVSpQ9FEabXDzKIRHCooc1RZi3ZI457ddZFM597PsSertkrFmjpqgrTvfRlBy30klaMTBzk7bFBQDPchpFUlJIp3DCE1Mr45a+iA+Xj7JN+GHjNWmQ0Q4qUCDc4a+cFJsBE0ySaYmr8W1Y15/H1foWumUfpFmXGWNgRkrCVAJA/QLYORRjXpIBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfFMHQjEnozThcNLldjkY5q/IaVk1Eod3+i6BnCEIow=;
 b=zt/8gu6j1NDcQa+xxCIl47NstxZ+qKqYfuWek77GqXIu29saCxV42iHEY+CcWxcW8vix/cYr+ha+1IfPA8nBI+Gj/x7cKTc62Y5bxOvwExziwyX81URtqovOERYHPWMI6V5YI86s9pA1HiGsK8fE7uqBCgFlm9/w2sA6HKLL0gk=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 13:00:43 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:00:43 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH] selftests/bpf: Enforce definition order for __msg macros in BPF tests
Date: Thu,  5 Mar 2026 13:00:35 +0000
Message-Id: <20260305130035.192080-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0362.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::7) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0126e8ff-7647-4962-193d-08de7ab7357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	TExdJn0NKh0xpuYNxgiofxCmO0vdIRMQXW/GrWBQAYNwpZ9hCOMoroR/zaRsGiGiraAuAjjhx7brVfr+ixDvU5CJU+gzVB4/dvHmsC+nJJuKVFUdFpIYU7pphXPiuB7bO4FcxeEJoHqhPeRoFNIeYp9R4R1A25uK0DDe2tOlyWVPEH5LeScqczRaGwWZf7dEvGuijDhycxjgC0APqiQWKCH1HqghzFFhlCPD4N7SbJngqyWMacKH5JMsUkTy4yOAglKZFxaBJgoj9abOU23YP/HvSnolEIqEk5rD+IfgS5V9VzUbIR5qWRSxQnABWmRTansDQLixZdzSz9OqmipovRP33XPVPVb3Mq0cJmZNgQ894+13gEtNn2U3YYr0ZqMtLUVlP+r94fXfZkd6Ceh0sSCkyW73ugXE6BiXq1KDuMToiTZS7K7SnX962hqUiRh1afKx+3vnv5flp5xqEhZznHnB+qNjX6PG4COvWDILbQhq6HInXpn0jgJVahonhT8Jsn/cRHWTxEFPhR+DPqyYD+rnJNMU7FkvI5gn0gEPSPP8jXQEstfrcAxfFKX/sE6HQMuFwvKrEU9j/hS4N2AVdVjqcBz0vKOZIRbYvWqvxmqC0Rhgmeb3Y/6xRpKmE9bod5pE2Ts7AnA6o6DF0RJs+3Ph/ef888OSYxrykg+HJd0FsZ7V87IetPrYmGrzG4viS23zBe+rM2fHngPczAw9KKaqxUSBtxqFU/0jNy/eg+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ySv+cPQhjoIrpDMg52I1sNzRkNtmrxzQNY4ac0yWpW0BdMG8uC2D148cRMY4?=
 =?us-ascii?Q?m44OUtyVU7yFKu1byDNw0FVzLnzrTNLXZKZBXhAbaPrmoTSqzxJK2tYvJg/8?=
 =?us-ascii?Q?lmRe898rjrxISS9OX4ogZV+YjknZ665jRlYMZFQp1A1MOftgm+zpI3JD3XUQ?=
 =?us-ascii?Q?zRrzDVtg3NATiKBZVBLpiK0jqmDRW34mdcHCbbqxQEnFQWbXZ0KWOnTGZnB2?=
 =?us-ascii?Q?gJPYqUeGqvtjYWod0zQ/2hROV3vs2++udsD3EhY/YKBPVIAp7W9TaSrfNNwf?=
 =?us-ascii?Q?rUgZ3DTs+eNQROY2EmnVaOWEGXby7dpZgL8sytg9LugocTkRRYvBI/zg6ooy?=
 =?us-ascii?Q?OdWO2Bb71qu/LyI/1D3a36W4Rq/tK38+tzdJnBugGHJ5Vjp/khakjBgh1R+U?=
 =?us-ascii?Q?wqwm8qhhE4yU4WFFI5R0FE5D3KpUgU//d9mql0TH3MOlynuLeEXF2o4UpBDC?=
 =?us-ascii?Q?dEiRwF6WQfIN6iVasQCj3eoGvq7S3MWPCvcMx1YJy1ZFisKR2JPh02byy+Jf?=
 =?us-ascii?Q?pv2I8/6LVyqMBremcXKTUi1y4XLcuiLiLHYMerjGWBcqtXQCQ63Sl0w3glNY?=
 =?us-ascii?Q?ns5SXCw//9Ffl07jnliMIOu24IfWq2zWGJbgn4lpf2LXUZ1XHGkKcaje9/X/?=
 =?us-ascii?Q?hIi2bYLUKM7QnmkcInK3vq+Rt/3OgwLtirR2g+wK4HC9Mt8uvQMpzfJ/jDMf?=
 =?us-ascii?Q?9w6/IG2+TjLYNoyXTCDvv1KnKl1FgvitrQRzWQRqu8M69czAaNqQcG7wOGj/?=
 =?us-ascii?Q?OYqT+zlb3NBh1B4UXuir5nESA1DUhw9TQ9bNcSH+Ruzjeu1BKXdArjA9o9Wl?=
 =?us-ascii?Q?v7APKp9Km35KUDJpIKTRbDVCthdh51XzT7CZafmxG+wkyaVVA5Ugr2+lJM6a?=
 =?us-ascii?Q?HV9vervDuQFYUtV47v6VdZyc2GEyev7b9pWO65lVaW6ME+9uoqlFguoWaKGL?=
 =?us-ascii?Q?Thtl5KiAo5QCSiIZFLCmCJ85QWyDbUAqlWFbfOqQx0GAKExJbuMDyj0hRMfI?=
 =?us-ascii?Q?EC6eS26iPqcJNLU3y4bhFKtx35ErMgKoeW2O9ajH3cRx+JThUuJu/LucjbPt?=
 =?us-ascii?Q?uKv6GSVUZ8y8cxgxoVHKcNnbqLZjJ/wBdgmiI97mDHHSLoWoyOAV95SlfTIS?=
 =?us-ascii?Q?nZ4q0gEgJgNnw9V6REO9rFH5stqIM7BruQRrbg2pACmX48uzNsxArXX45gSl?=
 =?us-ascii?Q?HL2lsuFJd41iLyOJF2vKh3u2mT71l9UlI3gQuPml7TAmibAUm95JPpzrRxei?=
 =?us-ascii?Q?JXrv8Yymh+szEG1CAJHepz2OiLv8YBBkl1e46GB1HMB+cm6P2rEG0f5WSecQ?=
 =?us-ascii?Q?lT8xzCxYNv3k2KwxSFTQ11HnxjaJoDCgK9FtTwTEtcNf/XROjhqgPYgWiQxQ?=
 =?us-ascii?Q?45Jcp7zE1EdlNkTtz1OndybUjjy+hL9r3ZcrkXkQw2ul0UrheUYFCVLEWfsz?=
 =?us-ascii?Q?ScMJkKqiUSDMB9nx6Mlmch6+BCVE9N2vdk87u2O8weSIbzHoN8NDVpPFmmBq?=
 =?us-ascii?Q?rO25RpKfbZ2XI2Kv77lc/SmzYtMy3SCVSaPeGacMnv9VZoZku4q0wVWSqu8w?=
 =?us-ascii?Q?bd1VXvw3FNJBtiqWrWwlsFfR0Mas6rXF3Z+qT//jPTjbrm5R8TX/eIV0sV5b?=
 =?us-ascii?Q?MPAnn+/C9gf1cTErt/zDBKsoItKhkerSMN02KWjSo8KOeuNZkUeiR0REt6e0?=
 =?us-ascii?Q?s52o8IrwsTBQdTBw5CoNhq6g0glwFeOzZSNhBh5ejmZ6WmU721aIwlPmbUbD?=
 =?us-ascii?Q?DtR+owg49ZZcHpRKS0eU8QqpePrtDVU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ZY2Cw4TPT4sOZIG19Gz2dTkkKt5u0uPuqKrp2zMCogoXq03nrwqUWBta02N3xHzloEAugXR1UJVGVVCNKEJfAbSuYSXUDNkdO3nhIM2o1jcbmqvyPR7HbJisfBkfCC1knqMW85zOW4UPzdf8tH5NvCq2j14qs4sYCCsOMzkrj9OCM8zkH75zFqo7E1EAIZikGpiHvYnSMehHTIzoTtWo2tXjONtiCjnhJcqBht1o/xO0kvwNcYfvHK4bzEoPIxvQ0D0oEu5RCwK5mwPY86alg5b2B0YBrlIOmOFTF4dSryPqnFeHm7N1nr+5atAFgmBqbQrR7xyHN2QkLQV584Do88GSitmLo/VJov11DQfulfhxevznV2ZgIsjxY2kcYYD8C6bVGYYzHRbXRosUM80sm9YGOestPhohIRZrMz1W93VYoZq+E6OyVC8XdwZlaCJ53lCBnCS/HsZ0aYFDJ0MlPGL5kRPhERBrvQztqu0Oa0keQxQuSFkJFK8e0F3+ni3P5/jYgMdJSdHtKvHhEOVeuqkhZzc0qJuE0SRZ6cu9n49ipzeFexa7Qp/N7hTXKCKaWxCK5wLFkgJoyK35ipWXR2zqR7PfdcK5NCCThCVLnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0126e8ff-7647-4962-193d-08de7ab7357c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:00:43.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89f9JQypz7Viv+S5ZABky4QcTx7swh0Mh82dWUfg9wr1uY0ndV3YRMqqCD5NYOqKxLyqGI7MKke6fPAwpfAvTt3VcucDNg/RZ8JUtYCZWQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEwNCBTYWx0ZWRfX+7ZOQeD6RpI6
 yeDF+9NtsTzRSgY6MfLFVqiYNPgmn/aWEgzQehKcJKsB0vpgCgCGM8BeBx+vN0oQ+BQyW7M9Kdq
 /rvgA0gE6M3t7pLnH0uAIoxicW8ryvthk3hyzOOUAXQZiX8mffnIttqgFwgts0bLquGbriNIrys
 J0xYute7ZnjYJ2p9BCP8OmZWhseYJGEHpQEPoITBhxQPspoSByJ6jWux3R967CcwhOQlP1azL9m
 KKgaJJWFbw20oi5tmaqDpBkEtMpbBRiPuE3ELm1XuwmwJZuKpUQzxAGnp4avhqq9TZLZCl8FSdk
 Fv6h0yfg3a+VnJ7jB1kvovuQOCwyNuGiTgFoDExyCRczGc9qIMYsX4oRGp5PIrqPYYq9WlPZFHt
 t6Lq9Cay9DVdRZoTQtmKvOjO8RLwakP9UyX9uK8KTbHQVneeLZjcYIQfZQIvYbc3ATLnFEOx1aX
 WVgJjjmr/mZ0jOMdqD5qFHmPXaaZlVDP/FWxfs9M=
X-Proofpoint-ORIG-GUID: hA-UKw0gjgHjXHdTFEhPyDOxkZd7to_a
X-Proofpoint-GUID: hA-UKw0gjgHjXHdTFEhPyDOxkZd7to_a
X-Authority-Analysis: v=2.4 cv=Z/Lh3XRA c=1 sm=1 tr=0 ts=69a97e80 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=q9VLTHiycSd2siSYSrQA:9 cc=ntf
 awl=host:12267

Ensure that __msg macros, and similars, used for BPF test validation are
processed in the order they are defined in the source code.

Neither GCC nor the C standard defines the order in which function
attributes are consumed. While Clang tends to preserve definition order,
GCC may process them out of sequence. This inconsistency causes BPF
tests with multiple __msg entries to fail when compiled with GCC.

This patch fixes the test runner to explicitly sort or process these
attributes to guarantee predictable matching behavior across different
compilers.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 tools/testing/selftests/bpf/test_loader.c | 76 +++++++++++++----------
 tools/testing/selftests/bpf/test_progs.h  |  1 +
 2 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..fd9d41917de8 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -208,11 +208,12 @@ static int compile_regex(const char *pattern, regex_t *regex)
 }
 
 static int __push_msg(const char *pattern, bool on_next_line, bool negative,
-		      struct expected_msgs *msgs)
+		      struct expected_msgs *msgs, int index)
 {
 	struct expect_msg *msg;
 	void *tmp;
 	int err;
+	int i;
 
 	tmp = realloc(msgs->patterns,
 		      (1 + msgs->cnt) * sizeof(struct expect_msg));
@@ -221,11 +222,15 @@ static int __push_msg(const char *pattern, bool on_next_line, bool negative,
 		return -ENOMEM;
 	}
 	msgs->patterns = tmp;
-	msg = &msgs->patterns[msgs->cnt];
+	for (i = msgs->cnt; i > 0 && msgs->patterns[i-1].index > index; i--)
+		msgs->patterns[i] = msgs->patterns[i-1];
+
+	msg = &msgs->patterns[i];
 	msg->on_next_line = on_next_line;
 	msg->substr = pattern;
 	msg->negative = negative;
 	msg->is_regex = false;
+	msg->index = index;
 	if (strstr(pattern, "{{")) {
 		err = compile_regex(pattern, &msg->regex);
 		if (err)
@@ -243,19 +248,19 @@ static int clone_msgs(struct expected_msgs *from, struct expected_msgs *to)
 
 	for (i = 0; i < from->cnt; i++) {
 		msg = &from->patterns[i];
-		err = __push_msg(msg->substr, msg->on_next_line, msg->negative, to);
+		err = __push_msg(msg->substr, msg->on_next_line, msg->negative, to, msg->index);
 		if (err)
 			return err;
 	}
 	return 0;
 }
 
-static int push_msg(const char *substr, bool negative, struct expected_msgs *msgs)
+static int push_msg(const char *substr, bool negative, struct expected_msgs *msgs, int index)
 {
-	return __push_msg(substr, false, negative, msgs);
+	return __push_msg(substr, false, negative, msgs, index);
 }
 
-static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct expected_msgs *msgs)
+static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct expected_msgs *msgs, int index)
 {
 	int err;
 
@@ -263,7 +268,7 @@ static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct exp
 		*on_next_line = false;
 		return 0;
 	}
-	err = __push_msg(regex_str, *on_next_line, false, msgs);
+	err = __push_msg(regex_str, *on_next_line, false, msgs, index);
 	if (err)
 		return err;
 	*on_next_line = true;
@@ -359,13 +364,19 @@ static void update_flags(int *flags, int flag, bool clear)
  *
  * And the purpose of this function is to extract 'foo' from the above.
  */
-static const char *skip_dynamic_pfx(const char *s, const char *pfx)
+static const char *skip_dynamic_pfx(const char *s, const char *pfx, int *index)
 {
 	const char *msg;
 
 	if (strncmp(s, pfx, strlen(pfx)) != 0)
 		return NULL;
 	msg = s + strlen(pfx);
+
+	errno = 0;
+	*index = strtol(msg, NULL, 10);
+	/* Make sure to always return a valid index.  */
+	if (errno)
+		*index = INT_MAX;
 	msg = strchr(msg, '=');
 	if (!msg)
 		return NULL;
@@ -443,6 +454,7 @@ static int parse_test_spec(struct test_loader *tester,
 		const struct btf_type *t;
 		bool clear;
 		int flags;
+		int index;
 
 		t = btf__type_by_id(btf, i);
 		if (!btf_is_decl_tag(t))
@@ -474,59 +486,59 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
-			err = push_msg(msg, false, &spec->priv.expect_msgs);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX, &index))) {
+			err = push_msg(msg, false, &spec->priv.expect_msgs, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
-			err = push_msg(msg, true, &spec->priv.expect_msgs);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX, &index))) {
+			err = push_msg(msg, true, &spec->priv.expect_msgs, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
-			err = push_msg(msg, false, &spec->unpriv.expect_msgs);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV, &index))) {
+			err = push_msg(msg, false, &spec->unpriv.expect_msgs, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
-			err = push_msg(msg, true, &spec->unpriv.expect_msgs);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV, &index))) {
+			err = push_msg(msg, true, &spec->unpriv.expect_msgs, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX, &index))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__jited used before __arch_*");
 				goto cleanup;
 			}
 			if (collect_jit) {
 				err = push_disasm_msg(msg, &jit_on_next_line,
-						      &spec->priv.jited);
+						      &spec->priv.jited, index);
 				if (err)
 					goto cleanup;
 				spec->mode_mask |= PRIV;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX_UNPRIV, &index))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__unpriv_jited used before __arch_*");
 				goto cleanup;
 			}
 			if (collect_jit) {
 				err = push_disasm_msg(msg, &unpriv_jit_on_next_line,
-						      &spec->unpriv.jited);
+						      &spec->unpriv.jited, index);
 				if (err)
 					goto cleanup;
 				spec->mode_mask |= UNPRIV;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX, &index))) {
 			err = push_disasm_msg(msg, &xlated_on_next_line,
-					      &spec->priv.expect_xlated);
+					      &spec->priv.expect_xlated, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV, &index))) {
 			err = push_disasm_msg(msg, &unpriv_xlated_on_next_line,
-					      &spec->unpriv.expect_xlated);
+					      &spec->unpriv.expect_xlated, index);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -615,24 +627,24 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX, &index))) {
 			err = push_disasm_msg(msg, &stderr_on_next_line,
-					      &spec->priv.stderr);
+					      &spec->priv.stderr, index);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV, &index))) {
 			err = push_disasm_msg(msg, &unpriv_stderr_on_next_line,
-					      &spec->unpriv.stderr);
+					      &spec->unpriv.stderr, index);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX, &index))) {
 			err = push_disasm_msg(msg, &stdout_on_next_line,
-					      &spec->priv.stdout);
+					      &spec->priv.stdout, index);
 			if (err)
 				goto cleanup;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV, &index))) {
 			err = push_disasm_msg(msg, &unpriv_stdout_on_next_line,
-					      &spec->unpriv.stdout);
+					      &spec->unpriv.stdout, index);
 			if (err)
 				goto cleanup;
 		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index eebfc18cdcd2..dc4b3aeb1137 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -553,6 +553,7 @@ struct expect_msg {
 	bool is_regex;
 	bool on_next_line;
 	bool negative;
+	int index;
 };
 
 struct expected_msgs {
-- 
2.47.3


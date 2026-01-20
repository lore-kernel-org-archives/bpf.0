Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA93D525A;
	Tue, 20 Jan 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946307; cv=fail; b=d0IMD47Xi+ZlBL2nawMJNXUaR0QQ5SKbudTdHPCd8dN+T3BoxzdDEf0bj1MQH4NFkir0lN4/pIzzGqw6p0IkLQILGeU0KBIP22tAJiOoM6fdch+PbvhBPbYEtqFJSJWQMbzger0KIDh+vcXLA0q5kbib5SHbuYX9W0Nor1A099I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946307; c=relaxed/simple;
	bh=BmkHdYLWFBfyrrMmQyXmJDe3cNPrWSvB0jr9ZvisnK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AheYfpDkPfsuMRHaD6vcG776eexOt5qnWCH/4mwDJiCpr4ECdh+mxPRoLU4Tdk2FAa6xr59iaIdyC5yAZg9GPhJ66tVS0Q3AKkiPeN8ojEMIp97L+YTKI0yKEnjlIbPQJpSuDQHgWoCqLBN3K19uVtAhaljRa5w6WCdu4Slbmio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHsuYZ3w; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHsuYZ3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGORhjI9m1NPsLmVdSCrHIU71Sfcle5aSC3H7jLmi0einJiqZIb3E5CPsecuAKHpxRw//HEKb3QqOs+cV+t9WnoMtf5FScxR5TyfhcG/jaEMBGdYzsqGMGawGFjPxLc0Ianuf//5RQfOSsQNBHEyxe6BI/E70tGT67beguZClvCl5GA/02oAzkD/floRGd0zd8eJwy3JUDd7KIU5mgUTxCNe7i7R7zj4Xd1gDDQ0zz+4fRlMh160gIQIJU6QyNdx0MezNS+LpIzUBY7Ah9SKKGRL1O/wfSvop3g6u9MemavVTEzZeUTjHfibj0iyqHY6487uoxR2Dc4c5y3c18sOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSJeo1S3vrKu9onggpOej5a0rArfIa9KVFLO3X9ku70=;
 b=BOvaHaVXqfM91UreK+W1O88xtQesHqvDrm4s6ehfcK+wIars3cQiSqZ4YXToqdPFOb683GpY1FjZOq2AG6Q8AtTf7uM2xzfx6hhOjwme5gmdXGDxwgwVS/U+89Ck4umVVD30u77wGAbVjRD2k1Vv5dhtdcp1Ru+GCWL8R4uq/290E1XArWv8r69cfAJvkE8qL3Ktk3duLWOjpoNP7sJ8AHXX97uyxWxjY4txBECT6Hpxxz5pDuGkMRqD1xKnaUb4ORXrNuyzT+pC+tocSRVQBc8us0Djtd3xpDBd5rpZHZYjPq2y0fqgjIpnbNs+Aq28kQ5oHKW+jhrsEpZwTGx94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSJeo1S3vrKu9onggpOej5a0rArfIa9KVFLO3X9ku70=;
 b=DHsuYZ3wdkZ51bHNpP8cmNokBU++qmIWzetjxDZFwHKFEsQIcG83z5rkBlZc8qOMwbZKRI+qh+ygWTBudCr67ooGH4/OyZ9AqBFQPyPX2A7TZG0Hnw6/EbQWUKgQyH2iH++MZClaLlUYn3rc+dxk793iueyf4e2E3Gfx9vIVs0l8MZH1SQlXrqi6RS22MxTxHo2w/z4xrHyQaS5lYOCehRAQj99PkaGBBhCXxEnvC24IaUtG3mbMpvkYLbfnTDZZtbLHGjZ1dR91pL/+gxjk0iJl5IIfRFdnsugIMTvHSYr5qGW5uEtw4gEq3Dls8IM2hc9X9wqIRvmSQtyZq4NQkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:58:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:58:18 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/7] sched/deadline: Clear the defer params
Date: Tue, 20 Jan 2026 22:50:32 +0100
Message-ID: <20260120215808.188032-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1ae623-4362-4b62-4f77-08de586f0538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uK1mCd/656xDbEfO3+tQGczj3tubCp7VpNLXbIsvbO7/4W6m2B1OGS743qY5?=
 =?us-ascii?Q?1Z6CP9fbfbXapjQIkSkFVvLzC8b7G219dRkTJ9zP78t3xrYsTl18XQFscdwg?=
 =?us-ascii?Q?zm1uiw9XoUrSyqsZBXUDuFAHUnZhn/ufdwZwdvIspMuLEdfZ7rNn8G9RLtAe?=
 =?us-ascii?Q?TecSa7PiejBEFVP5vCd5er+6QXIr8I3y5/RqrMEs8RK8SOAaDv46n1Xy0Fx/?=
 =?us-ascii?Q?INce+/EzxX9OBd2JwqLNxw6exr2yVgA8Zp7hUXzA/kE8q2bCVo3b7GFWY1Gv?=
 =?us-ascii?Q?ObJOkAZjrd2rErVRp2u6lsLqfOCEMe9bCY+W6ajOmNWcoRltgr6Kh6BXgiuq?=
 =?us-ascii?Q?oCv5zmUk54x5TzjgzGOswOBCic8bfEvyTdC2++rwDs+SrpfcemHyrbbcHGAB?=
 =?us-ascii?Q?qBQMaZC3ScMRy4S8ggZ8TIUmGj9Sdll/96y2k0iAoYI0zcjpedKwKPeEfzm0?=
 =?us-ascii?Q?hlRrVaVskai3+JnE81kY3q/1/adUHjVDhmbKEkhRLxtnemhnY7T2GFRCrD3n?=
 =?us-ascii?Q?odVUfWKUHrQjA6mxbTKd36/WC9IVgkZspkpuEtn14fmXISlW9Y8RoN1Beo+v?=
 =?us-ascii?Q?ZDfDNZnPM6EUdlLJlgN+7jwyrmsF1TqaA7JHJnObkWrAciBIdlGRFvq1hCnJ?=
 =?us-ascii?Q?qfQIbGhoLq7H4xJIGBnu0XdQUk4YuCwwF6svrsbWvafJGeatKGkoOKeLaFMB?=
 =?us-ascii?Q?Yax7rHZNOavCxTY8vkEN/v/C+y1w3JA28RQhi0bqkFyImBdL/Q1KfUZrZrMB?=
 =?us-ascii?Q?0SyLf0SDBikJqmhKExtSG6BcMWFU44xO3yxSvjD9mWhRnYowK/SqBWXi+7SH?=
 =?us-ascii?Q?0+920P956luFd/Q+av5groAGUnszvo578biHWM1O4QwgdgR+YsK2dy6ZFdV+?=
 =?us-ascii?Q?UiRZoze3QcKExeEb2YJrnG+Kqr+xCHaUGW7MS7V8HXAo48/9HMvFhS/5cYdl?=
 =?us-ascii?Q?Ff8I65WqIGIHxCvYLbXqXzztOlZLQzM9r6uPRkrwzAIM8pv+yHbcJM/3x9ot?=
 =?us-ascii?Q?KHDQ2Lgs1f487efpmCBCzqBcZP/6ig6vhxN5B6D9x6blz9j6auQAw/w9zkQX?=
 =?us-ascii?Q?gTYAjHIViVsfor+uybWJs9vp9OiqBfS9LxxBELxqBWz9R95eo8Lsa8bJlCm4?=
 =?us-ascii?Q?YSWp2LWAHKPQmye6+kEnB0NIfvkzb5AUI/ESuT5+fMbip8qP4myfIvECMvtI?=
 =?us-ascii?Q?zcs3kAkNlEKrqmbiXZpQ1Eq0XBsg/Ug5fsof9DpmEnMQXRwV1sZyOGkeoGLH?=
 =?us-ascii?Q?I0Ef3jbn8bsVGawPTfYOAguIyMh9EBP0kc5Il+07SozWJn+M9L3QGKqw6iDE?=
 =?us-ascii?Q?1UtvR/huKynMxE5WG1vN+nYCJRIj7CMSxxRXawvfh+zFfX1zLdqQ9hLZ2usE?=
 =?us-ascii?Q?mS2Giw0fyLLsOMzvMCYjKRGHIx0FYQrzSaHGfKZLmECC6VpPrRYtq+eBXSZl?=
 =?us-ascii?Q?6i1FUzbX8+q1Qh0iRTC/UVxLLab8T75g76PMbzSnmnQsgGqzgBaZKscAAY6d?=
 =?us-ascii?Q?cBmubmiCfmxrSmNL42EHYI4mGFEQyeiSB+Phs1j0E4BECcKiHhh2h8E26GeZ?=
 =?us-ascii?Q?dDk7rC6V9LYB3v9fcpzIxTDejERK6XjBRrn1cQIoIhyFIXSXlLTgsSAaoFRb?=
 =?us-ascii?Q?yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWDcwEIB8mzOcaXbElhiI6yfKWC6v2ZDOmdjujBS/Ga56SVRjfZfUJwBkKEI?=
 =?us-ascii?Q?4RfsV17yLp9+qGo0lPjhtUme1neuWPTOFxr9SaMl8l3IR9TTMvWgzHGlxJbo?=
 =?us-ascii?Q?tqrrYPofneqs9jlG3NgrkYCPuUsunCt1Y3sDtjF+lIhhiwvAXH01ZGInO30S?=
 =?us-ascii?Q?nZHsoL8vEYiPm6gQrsaQCMn+kgfmFEv0nBUqx35d3zGGEqbbwb/SXOmHdDeK?=
 =?us-ascii?Q?VmSZzO3CZFJnGT64LM4YYgKmGIKeUuUnUOiQ5J7b0z0aPW35J2NhdmFL2bTC?=
 =?us-ascii?Q?G6K6VunPGEiclRFM1JWAJUwHXoa+PRXKYtdsweMvAN5e3eQ9LY6QeB4aKjYk?=
 =?us-ascii?Q?8OaPomgmuWl4B/W1uHlovL85Fqh18mi2dgaBfOMY1w+XCiujmHtyMLUhE/Th?=
 =?us-ascii?Q?A6LzRASq+oUqZZ6/rsai8ks3O7LC9bCrz1m7ZE+4bCfzi07zVgGhCjl5uL17?=
 =?us-ascii?Q?/i/ixR3ar6JYMqO1s+gV2nC+zxIfbKYrtrT77bVPJe4JdGua8c63EdnyhoEX?=
 =?us-ascii?Q?nUkwwerdDevXK5N11l1Q+QBk33pNXkXg0kiJ4ey/y6mgONL9YXX6L5U3ZiAQ?=
 =?us-ascii?Q?B120bl2sFyMFJDsLdUyZ76yh8MXAcDhSKliKjysSjQPEKaK4ILeLwOsz4Lvg?=
 =?us-ascii?Q?joPK/dvd995nISOS3qic7Sr8ko5b0xn7AWjztv4Cc246w8pSQCVXZW7gokJm?=
 =?us-ascii?Q?pi5nR1T4aqIJ4CdjZDzwmi1o5402QZuCrsPG7wP0SfakL+kjxWPH3KChmjfv?=
 =?us-ascii?Q?oLyDaor3H3NZP/EKPclxZdvq9x/k2DJxDNVXKLkWvcIVDN3ISXCfOzzGu5NG?=
 =?us-ascii?Q?TTaEkjqaJ7w+ZjfOtNGlJKdqNeemdo1oQrvM2gXYdYcwxuzW2J1UcXsfpoEU?=
 =?us-ascii?Q?VZ3np6TSnOCWN6a2geWvvtX5lDjtHThJYoE2OVG6i7Yacazs0H5AJNR59ZMf?=
 =?us-ascii?Q?2VsI346g0bGsyI5ciuQf2j2eT0SfHh4S2Gyg9YDGXLFH8p+NCNthpJiY2o/8?=
 =?us-ascii?Q?Y0f2K0CJsFbM257nSmEb7CrJwuC1g1UatCJ5afR5BkOlOsyfXYqNh9R+Of7Y?=
 =?us-ascii?Q?TwRG0/lfeL1ftPxoi1lfhOoZpQwjj0JaoSSMSMDkfGNAYDcc4FWuPFCzTUSk?=
 =?us-ascii?Q?heniM7hcYeeEa3Kp60+LIy4C2BQobebyZuamTZS0eIlzGkVAvr29M+F7j9Y0?=
 =?us-ascii?Q?r/jVFxelRQwARuo4pxGoRnKQCceP46t82wUjuyNFc1AIXNu73J7hP1tHfEEC?=
 =?us-ascii?Q?PuJGuNbMrSv/sxrh46LTQZ+JNrwKYOdE0btHzvWyzK+Aku00gqP1kE7b75Ij?=
 =?us-ascii?Q?Joa9N/U3QpLVgsGjkVR5L1fGNfEi25WnKXBBa944E4cDdcPrjuu8W05vc6ep?=
 =?us-ascii?Q?11GPu4zvSG370xXUlwg9e3zgkRqNggRZzoiIr29jndYnE1I0fcI4RqHuc3mL?=
 =?us-ascii?Q?xy7pLbxAzXwWroJl7Um5+QKXVaVbH8NVeeVcaIBbxdgduzxcz2INY5GjP6rY?=
 =?us-ascii?Q?4IgPrvlI5SxgQ3f7C+ClfRVbNnn1gfHgIi9jfRINDY4n+PcOCVwIy6HKv2dO?=
 =?us-ascii?Q?/mzrUsGn73zvisy/Kkw/WEBWl4J0X+zj3yoorhr1W5K/+sq4DpWykR5m6QYm?=
 =?us-ascii?Q?/7A1zearA/8riZjI/NobWckhihxdxfUxhAH5Eao1CVacCIoWb+77aPqA1tvN?=
 =?us-ascii?Q?ak3rrwXQl8H0LvXWxqNcHL8OUwpzqE6snlSf9l5g//8EvADI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ae623-4362-4b62-4f77-08de586f0538
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:58:18.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv3m6SiHkaUvL+fEjQRhl5Runhzrct4KBJiazi6tT9hA3UgAfh7Kfbn7oH4LLmspTXWyJc4cBinVBXk6rZLNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

From: Joel Fernandes <joelagnelf@nvidia.com>

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c509f2e7d69de..71b58a25e2a91 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3644,6 +3644,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.52.0


Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47D31F9B9;
	Fri, 20 Mar 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016788; cv=fail; b=SYwiJmgOOp6kdJeleijVIiCnIyaX8WvcGLuf81C7rw0ppFlkLuBXYZXpkYj98Az5QEq1uBCfOR++JkrxeW0XZKqWVLuhqzcl3HpaKGYe6NziwMtLzvulwYYZmJ2qqJOLOg9FQ4q9qIeyBjQkKzPuIjpyxtDNLfUsEE7FDnQK2uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016788; c=relaxed/simple;
	bh=LDnGTLaGh/uty6sEO+FTkonVBazlYmz9cjX3/X+u6l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvRsc+fxQSKcDrx/XI5sD5wWfEtto6GePgmqCu2SQ/AaSidhn//XCaUmTfLvngeqDpPdvlW2kIOJtrroYEb/X5+6S1IibTWiPK/YoaQDqgrHUzlf0In0BqW0tPmdqDqxlKJe4tl7Y+8JBgCpnHA0SEFIFFxHeKKNJggX5JwWgq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEnHo8D4; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEnHo8D4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4/gwdl7jbWRTonbsEqWaObbGb2+yOdCBqvr1LAtL2EuwiK/ofywMte0Ar15f9hJcax4VudUziHZxV75hBcGu5n6DHV+hrE9nTq+I84aP2c4dxGtYSGwfTTD9sj8F+S3u6u6MLzGhXm9XHURx7sUTh5WCuKHVm0eYPIOcMsTnf2Ol7mGOpc/Q2ewA5QyFyt/B2Zit6z5T/j8Y0CD3N/iE5djpcRxuUuhM4Ej1uE37AGGVjXdo3Rq1YfKvGyCl9FL+AfJaMMqwg7WjBEDnP/Bb2q9w+J4e/B4ivuFUQXIjjGPNcqMMqdMzWnCAPeVS5EibHfEpgvJEv2Mlk6NImqTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCCNKgSGeEB3xvqqD/+BmNyonVPTkEAQYM+BHVt7uU4=;
 b=qw7nUGtl22YVKeD72iNaf7EWp2pGU1o7MQh4w7Z2HqUevPaKb1mT6qUy4XJMklAEguCauBqX5mdf8c4s6LS4AjRJSE2uF1oaTDDVHOB98l57Mpvb/Gv3iudAfVGYtqXHLK+LMpNHrAEhu3Os1YIJ3yjX2t27VNUqPe0Uw7pB+jJMQDtRzL6s8gUjhbzDITd0Deb6hfO8I7KSehoDbJ9juITV5CRgjoohbWDMUtVE8lizE2DP1LggJLXV8zWVHmIsmIOWSCgCSqUztwJWbxSJ9ddJE+jXPJ/KeqA/di3u5eTRXPn0Bo1ZTC6INANvjwMeTKcp+4ZwGGAqOBvw3q5b2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCCNKgSGeEB3xvqqD/+BmNyonVPTkEAQYM+BHVt7uU4=;
 b=QEnHo8D43BHX+jim/aweSohkWygDIfRPBgAQi7JD4vpVj6uxaWG3Q7IE8UzkjmInqgj72Mll3ZyiGdM0P1iEFccGQXw4SyLxYicOHORKyLgc2nVXKKyMdKk8DMRYUMWzb+YgIfzSR+mvKK7HPCPYAXELiw0JGZ6GnNbosl0kqxvEK/arKCFkuMsMVSSGWsqRDnGEDE5C3nw9aKQMwYewhEvecrN4eIuMnKzqYLleALuCdUqdQ410nqdZc3Lh4m51ZQrBJifw63uatTEDtMiS2FzRizEwkrIk9NswFGrlVG6fMWXaAlItVUjykG32aTi3SBltrGsULhXnHHtlRdDIoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Fri, 20 Mar 2026 14:26:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Fri, 20 Mar 2026
 14:26:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Ryan.Roberts@arm.com,
 david.hildenbrand@arm.com
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Optimize
 __free_contig_frozen_range()
Date: Fri, 20 Mar 2026 10:26:11 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <DC90BDB1-31E4-448B-A94C-AC3D28D26C83@nvidia.com>
In-Reply-To: <20260316113209.945853-4-usama.anjum@arm.com>
References: <20260316113209.945853-1-usama.anjum@arm.com>
 <20260316113209.945853-4-usama.anjum@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: a32d9558-cc76-40a9-b13a-08de868ca5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BF5OV6ZYkgAh70SW9z0mXpBJh+YQZVKs7eH3CsNZkDi1TTGLUbqiOgCA31ZXzrWuPhoVviLF34l9qLn3D2YSpWGwLt4O1XEbGvlco1rg4fo7JdguCPaxb1dgztTCErc0NtNF+silabe/0b78xxhQlad4k6ixVCFPfyQ67lwS68LT/KpbIZCRftN64F8AV4sJV0VUy4SCXPNwKVCuSEjWThITu39naGA6xbHMcQ2ZJ+Ft3lR7Ab829tYcZ+zcWOBy0fkLOkCt+75T5Nn2NG1wMQTBC/lui9IpVxJcxy2EZWPwtAGb8INURTxI1Cv5XO9asPG5fQ3pVvVBMPZ3+9yXag6LxYJAMEV1WoUhyE6lzWXRDigJ76mPMVAK78v94AW5dxvi794XCOVmz3J58SEVOft8r0BGpA0kjuHcyI5JYic17Hbw30nX1tERr8ek8sCMW7WCRiiOcsdm0UMmFvL2ZIsKz9T4Czc7beJ5LZuPliMWGnfk7gtyo96cbhD7yHnfncgn0j70lTOjGb3Uv6jA1yksNqyVdp6XttxEjm0lmT5L0RIKgZGDRktcqo15R+KTp7xy4u13mfc9aZt2QNZBJ9wxWxdnrqN2fYIHxAONTa42VEH9ziqlYFYeOHNOdnD+o237E9Bs/SWwRECHSKGvOluOE/O9n7flGzNxmVH2jnvJLQTKDvc/Ets6gWokiqqgot2Btm/QAs2CpRUuKAiNDpIUIoy3AEXXfw6fLLAW+Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XORPX015gryBHuq/nXpbsOI2AJubA60cMQmlC6vwEpVmZ8WpRYaPns8FkMh4?=
 =?us-ascii?Q?JM4xzJjZh5jFtm+IroG/3HBQogGPqau8Vp3wdLVWwmhLvxj2A7F6h34L7fk+?=
 =?us-ascii?Q?45rj+K3he0YkJqFdoAlOtA3kFMpQrBDCBh3pw1iKJuhWGnnfAmXD5jNHMC3w?=
 =?us-ascii?Q?8Mym1dcs7dCzyhJfs662RSHMLOkfsBDAS5ObRjd8646krNZKu7yHEG0VPwDS?=
 =?us-ascii?Q?h1KTmT7XqtjcGnp07+ztY/mErKzWUkumrd1lOKsmzVLegBHkn2sG4piAPlxy?=
 =?us-ascii?Q?uhgNpNBgzcZXL0EGfGgiFuj46qW/Iwur4XKC8obJd6oMHkCzilRwzlanJIsf?=
 =?us-ascii?Q?3RYAv/eI3CvrqJ2cmNFEXFe4plVEN1UXsuqy0uIKSDJiSNBIE6tpzSD6DbPi?=
 =?us-ascii?Q?AETh35dT19RMYj4tySFYnmoEG62sByCPStJsspULFVgCSqKR/VxqY9Vbzx4n?=
 =?us-ascii?Q?g80xa6FB/p3/UzK2R3YOklitenZ8yUsmKbNfpUWqpMbo0T3hswpmtz6t4Drf?=
 =?us-ascii?Q?gtnjCzWzXBBV7fGltFvRXGRKyWxsSsP5YQJHHw8+XdTDjdny2nlQv+qR+OXD?=
 =?us-ascii?Q?Jab9Ao6jk99d9zCKmhVjcSQlJXR14hbUYkOJEog8NfK1SEuVdjvI+2ygbMwW?=
 =?us-ascii?Q?JuhMgXmCSLaI739LYmD7xlPlLbc6xs/Z2vc25z4ZTeo4CQ+LqXtRp37UgwX7?=
 =?us-ascii?Q?roT3OzeIzXaAyuu5J96DxRTWB4XMnkFbcLpS7eHw92waNrvJwvtnHsgmAdG5?=
 =?us-ascii?Q?n45y8SGBQn1PtMOqGAunpI7cHvDZ4p9eNsE+K0Ov/wH4m6KdM3bAZ5Mp25Su?=
 =?us-ascii?Q?0SSHBhx7Q5tgKQ3Xr5ydaCWuHn69IOVa0NQyWWtyHzzUH6UKtBL9QI+35vKJ?=
 =?us-ascii?Q?rD7IdF5RaNudP9xM740Pr9u1ERbZ+2Niv1KwVd9fXKPJyrJGtJBYMCoWcQlE?=
 =?us-ascii?Q?Ktd9Ra65iuSv2ZmEtFpYP4Z2VOyYy/xc8wBHR6syGxYsqSQ6yJsDhHeoGaxO?=
 =?us-ascii?Q?eN2PlS42Aap22Ee8sVtiBmAOKmeCIWq38pFQ2e1tmLcGrPu9h85O3+2wBX12?=
 =?us-ascii?Q?Uiwr+oDt40Sj7M1DdSZPds2G0bKSLpW+dMVZGD1CObT6rWatMm/IELh4G7G/?=
 =?us-ascii?Q?/W8WQt2eYDLY1ElN4F3wdmGqRsSat5w+LDdnieEYHo1vh4W9QEwANTX4b56Q?=
 =?us-ascii?Q?t7K6KEBnUcznFNfp2XzbROUitRmi3rfrmYdGolU5oIYv4CmDc+Uyxuw13OEP?=
 =?us-ascii?Q?dfrDYx/xflgpei/WlDouuvqhSu6bLvScoioX/5s3UDb0Q9EFFpQLVg2Qd5UU?=
 =?us-ascii?Q?2th3jMaSuKktd/okMpVgigZGXnj1ERV+0ayVy8EF4LZppPmkBLK7TyiQP/7+?=
 =?us-ascii?Q?g9wuXTueKwroWxJtMH+Qlgwr7Rh4LT8RaEYpvYULgGqJVSAaQJ+q0yG2D5WN?=
 =?us-ascii?Q?zmBAf387sBEibNMpfKHmTk22p1YcLGay5UzD8nWW4m61UXiojnjeIh8AtiNX?=
 =?us-ascii?Q?4xiSNB8VF2jzYekRgdldGHZ2wgQf/C1Hvgltjp5G26vFWLcd01V/NzYQ7Gd2?=
 =?us-ascii?Q?XD73jBi+lmj0a56CymRRLn2qJjfQ+NHq/jLPGnH48ezocswZnPGwg8DPnXEq?=
 =?us-ascii?Q?wPgtDQ7d0oGVcYZy4A4aS7EmGI5O/v/B44KWPsmzmlTFq+9ZmSVgXjLzqIcc?=
 =?us-ascii?Q?Ce5cEi/P+GhxoawCvn+r6o306FxZEBdVOf6BExekGid9U4+aEzPlPqHp+L50?=
 =?us-ascii?Q?hf0I2g9ECQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32d9558-cc76-40a9-b13a-08de868ca5df
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:26:17.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQCUM00t/kqSd2SUNceE4Y07Jt8zZp1NjT82CPEKkRDKLooI2CPbCcFkVGtijaih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645

On 16 Mar 2026, at 7:31, Muhammad Usama Anjum wrote:

> Apply the same batch-freeing optimization from free_contig_range() to the
> frozen page path. The previous __free_contig_frozen_range() freed each
> order-0 page individually via free_frozen_pages(), which is slow for the
> same reason the old free_contig_range() was: each page goes to the
> order-0 pcp list rather than being coalesced into higher-order blocks.
>
> Rewrite __free_contig_frozen_range() to call free_pages_prepare() for
> each order-0 page, then batch the prepared pages into the largest
> possible power-of-2 aligned chunks via free_prepared_contig_range().
> If free_pages_prepare() fails (e.g. HWPoison, bad page) the page is
> deliberately not freed; it should not be returned to the allocator.
>
> I've tested CMA through debugfs. The test allocates 16384 pages per
> allocation for several iterations. There is 3.5x improvement.
>
> Before: 1406 usec per iteration
> After:   402 usec per iteration
>
> Before:
>
>     70.89%     0.69%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>             |
>             |--70.20%--free_contig_frozen_range
>             |          |
>             |          |--46.41%--__free_frozen_pages
>             |          |          |
>             |          |           --36.18%--free_frozen_page_commit
>             |          |                     |
>             |          |                      --29.63%--_raw_spin_unlock_irqrestore
>             |          |
>             |          |--8.76%--_raw_spin_trylock
>             |          |
>             |          |--7.03%--__preempt_count_dec_and_test
>             |          |
>             |          |--4.57%--_raw_spin_unlock
>             |          |
>             |          |--1.96%--__get_pfnblock_flags_mask.isra.0
>             |          |
>             |           --1.15%--free_frozen_page_commit
>             |
>              --0.69%--el0t_64_sync
>
> After:
>
>     23.57%     0.00%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>             |
>             ---free_contig_frozen_range
>                |
>                |--20.45%--__free_contig_frozen_range
>                |          |
>                |          |--17.77%--free_pages_prepare
>                |          |
>                |           --0.72%--free_prepared_contig_range
>                |                     |
>                |                      --0.55%--__free_frozen_pages
>                |
>                 --3.12%--free_pages_prepare
>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
>  mm/page_alloc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

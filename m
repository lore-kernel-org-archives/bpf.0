Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA92FBDFD;
	Tue, 24 Mar 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363597; cv=fail; b=KNZllhsPtOlCQZhTAxq0bXdHunFP2W2wTRvctodMbVengx7JxfZXvoCBp97reefGneLLY1ptByTGox3kb5JJdzEs8mf6uo8Az5GusvZSfyUKalLOQ/3urLwUiNMpgOpqua4RnWbydfeev8ud+o9LoCDtPA8QWuINN86EQn5zdHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363597; c=relaxed/simple;
	bh=XuZZ1gkBrBMEXKahBpdCuOaHsUaEdHsXmtiailwrwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjmP8EaYhgRxPVQbPoFBKGSiIFXQiQoh8x8Ho+Yr0CIvG0a8yaK+aGBvVmN+M28DHvQ6tWAA3SmCxCxZDiTuvgcVnzoCGlWKJuBcuMRN/W0VCgVCuE4NobSy8VnW9spdP2vc9twapLUat4CHH6BlG3NRX4ZIeSPAVxg3ksu5Hrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSPULzik; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSPULzik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8vBY78aenB1+m+16gsYyqyHwNkWNDgURftD2tF/LsP5mHEg/36EBxGJpIUUh25eoLJi0n3o5EJZWGcOB/P4eDIc209ndbVG9rJcdkP/wTzUnCrU9H8OuXPI2NIuNy+rSrjP3U5lTKliILSMKtH5nQz431+lNc6qeRgKVj/GNWw18n+xw4hdMY92nmRwM1ABoMBKodaKQfX0uALT//5371eAz8du4PQ02dtQAA+mQXVOJFceCIIDPo+Dg5JsTJb+QAM3op/D9XP5pjUf4nNqK31/0VE7ed4ok2OgIGrYzsVlgBFH5YPNqGdguXyWcBVzLcKDj3onBFuMJnWjkXKnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwM05oW5mYKdIx98a/yghhSDjO5VMC1WT0iUiOnQN2k=;
 b=jgNqwGGi+ekNqidu0KFilvfGFf6pQoSuK7L7i7Vm5feLXfq2giMLYTVaNW7ZE3MiF1rK9hw3/kTobHpf9y7Ko7G9qkGvEQTDOMowqSBypxgXX0RLOMKpfAnQWeayole2KK7Q933l7I1TjZXAl/3TUkl8rQcufFdV6tccMoBzmNn9jgjzbbRMaU0JYv8TOKtuPLi9rQodrvkcmK/uO9YtYXE4rU1W/pqAL7cfLE4AzEb5OumUjS+jfI85qVa4lEna4cs27N2P07KebpkWjmiDM3xxLD0E0ehNfRJOnxDHyvupnKrKRiZSjo8HHYuiPCUo4uKSr9o9K0+3+ID7Mw5xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwM05oW5mYKdIx98a/yghhSDjO5VMC1WT0iUiOnQN2k=;
 b=KSPULzikxeAp6JDUqVE+UndhtXYrf6UYFFVSJDC7nJx0YZURa8Q6pxfDHsZ3RnXUcBa7Sz/gvo0xPT9eMVXTq0dnUBvvYEe1CJM1V5zAzMr32t2STr5RFN+iVWwZsT8V21qLuyYPCAV6rVdU9T8EZ7ztCS19nut3iKVw+H679kKPRWVKpK2LIjHkpshb1C9qsHL5nFno5DKvDikJlUlAx+NYJwngDjWPzi5QXwHyM/FyOqNz3twxXRgJY7rpttq4OVj5WNZBF8A2VWErQNRfFm3SprVuelD7GoLTJtLyMQxP33FpEnfyDck9xImUITlhR7W6+PvPhBTXEjzbSnciaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA5PPFAB8DFE4E8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 14:46:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 14:46:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 1/3] mm/page_alloc: Optimize free_contig_range()
Date: Tue, 24 Mar 2026 10:46:20 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <E976076E-68B6-4088-BA67-AF4ACC0D3E7E@nvidia.com>
In-Reply-To: <20260324133538.497616-2-usama.anjum@arm.com>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-2-usama.anjum@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:a03:54::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0a2efe-0ad6-4749-cb47-08de89b42052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I+Gp/TKpz801Msl0nSTLTwIj77lKBP0Jb9JRxbMOuSpwnbsa/mQu2RbGeCo6Ibq8ezY5dIvGLTlK7ISpnTViSlCbzt4txDckuLgILt3/D4pyArXAIeNC7bE1Fa5Tfb6Q+q/hH4YlJbwWIon7liR+Fn09zzbNvhekI+1UJHapvH1fgf+iPp5OPvkvv/aNNij64+GlgF38uKw8cblehGtpiOi2DEDbcncBevAvyl7C+n649PPaLfzaz+j21YAfXasRDOsD5L9P6PC3YZvv0wD39uzAO5HzViyKELXDxUiKbph8MAaIqxrmsCJgDf+YY6WQ0wxVj+0vTEjVBrpCdFsmOk8BUFZ0T554OQHyXQIYj1ndXPYDpN+0opXaUlczquATYigab+7gnhrzfQbQfA9Bvnd98J23kVHcX5WytXTarAJE9BwRUyURmWK2ali13RPRHU0PWS2y/lC7Hz3A1DN1Ob4EEz9q34BpKhbPWO0uRrO24PViBZLSE7WRoWdYM+QypQeVvho3R3tYN/zRwtUr9doaW7S30NV3fwNmUjBUXgHxJlaM6Mnm5F4NssUoHzrFjhtNMiwsz0bVONTFPoqNQ/TOp2RQxT1IUuX1vY9RPKQ98yJdDCUAnvpYrlfTUwLZWzSoiWjU9lLhvG+ydhtIDW4RnwZfSNpdNcKYkXYB/U7+gBqA0f3932ar34/EZYt3tBTbpLE2s2uAJqUxv7TU2Mq6mFF1WQAQOBFdAdmjeDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrPx7ibb2wlT2hqpdGHWKYTvXR1lKrw1bEmjuJn3M9ve4wYtSzfvSxf1zqvd?=
 =?us-ascii?Q?vm5oMLM60kbM7U4VnsfrWbVA9FEMnnt0K6kkUaC1HB9Ds4KDvIsVDpS/Fvaf?=
 =?us-ascii?Q?6Z1/nXUsdDi5tdoP5vMQZFoVhJ6bKj4MkCh7Hb9JPthofigQ8OuRo5CM21w7?=
 =?us-ascii?Q?AWeeAF1Cli9dcdJvXID5WlNm5DzxEN9ovIg5mwsunmJzw1ftW3xXS9AfkKOD?=
 =?us-ascii?Q?OiNoN7GBrFZptYKSyB0Ekoirv55Ct5napDVlxMWWIHdgGbRox3t1GRIaOe3Q?=
 =?us-ascii?Q?8G5V1dmQmSWM8kIf/vJHY4tIp1VI/7XkGQK1rc9aqOObqNnVZ1vPDHjzQwQZ?=
 =?us-ascii?Q?5tLwqL+t9i5ZTJ4ytgHNj/odAcOlHLmL6JNNWW3HWvV2D9Ew1uwPqAfkue2o?=
 =?us-ascii?Q?OUc2MeSXQkaCNcVPl0Z4SpP58lgFrpaceDYEbVqKKEsWo0ZZcP1OrpMSjWCy?=
 =?us-ascii?Q?9S/DU+GDfoctIRaRv8+NaM2/euKX00tWFcTimDMBsibNsq0cGum7hDfuBWp1?=
 =?us-ascii?Q?C8DwFtHdBh6K6idF2blpbFivrOHPvKVkQh9z89AoFLPyRJutxWCPqAMAyd7b?=
 =?us-ascii?Q?yCJ+M2oHf/d5pNjH4rd6+4vDYyVNpppkQSTSRiJVlJtJtfqLf1xnn5ZBHNS8?=
 =?us-ascii?Q?KcRP1wne6T+FAK8PMcGqOmdOT28TigsUYjL+Ip9qfY5iUmOj37y581auHIu+?=
 =?us-ascii?Q?rCJ4UsvRyyPYQVZTZXvyJHwyaGepx0ZIAzvrBGgWysG58FJIsWCp+wyZK55E?=
 =?us-ascii?Q?4+7mFWDueZZBlgj+jRysk3lQBX5T+bTwKLoFOs1V51ugaYcz8AnbUK1MNo6O?=
 =?us-ascii?Q?HBYbeGwc+vFs30cQ/F08fX0nvxXl/4verdptVHmCzWg9EeIUc4MQmBtYxieW?=
 =?us-ascii?Q?mBMwriWod8JB7QGn5cmhi3JRdztcH5sA1ywakrpFznORu9r5rXPvQtrNHY3t?=
 =?us-ascii?Q?UbahH4Yc3O4ikDOvvb1EL8Y7CKFoIljdhrJ9LVzj5W6JI12GMlMl+nlrfsiu?=
 =?us-ascii?Q?mrAxIWDenRWBt6xYNKQlFdzl/Wu8Hq4kDXDlWqeIfezsVBdde/yPDCrLfmII?=
 =?us-ascii?Q?bqcGlQrSp1nsi1ngrp+7hmvjm755LDPzzWidk1BL1RQdR6hjtnHenbtOuK1J?=
 =?us-ascii?Q?ORO4YvPUCxtu5uyaI+dl/Ficug9NSbzHTS6ojW5ZMx6HKGyGQKuqbZj9Wswy?=
 =?us-ascii?Q?nBAILaTdTzXMAwHChviKb7emmOkV1mQlM3v0lTawNgcJAV49XusZ5sZVPJ7X?=
 =?us-ascii?Q?bNwJF35aSOK7vVgUvPHXFDz8yQgfzqhKGqts8Mix5cWqQTYuNApDWzw1oYZF?=
 =?us-ascii?Q?Dzsp7Z73yr56VZ2MsuQ00zzssCvbjgI1Wr8FxZfz+vXRPAmUa1jAhaBdow1N?=
 =?us-ascii?Q?/ZtPLgm0KtgjF2C9zT1n+l4jgfCbYg+fFC7EkESDssSqhkv+buK0p81rD8YE?=
 =?us-ascii?Q?+MGWrKOyWYc5zRc9NKHHGZZ9XRUcsJm/oKGEjdHj3wU5rSUhED+GI8yRrrxd?=
 =?us-ascii?Q?MQTD3oWvpoIKOeFQ4BE7zwIoMMakygS7igDKH66s88fEXXgXnx2AfoztJdSF?=
 =?us-ascii?Q?Bi/7de0nUpkOmKq/BkmitQQQwvHGZY3yr99+8rI6//tbtPz59oQZovFs/C6D?=
 =?us-ascii?Q?DItwudqLwSVkXpF1ZTKpin77JjFDkj6hHy2YeWfet31OBIEsBAV+0vCfBw9Y?=
 =?us-ascii?Q?3J13fBfsKXBqpOEcHG/WnmraQC+yGu19gKf5SyOypiqp8ui4ts9R3IioLG2l?=
 =?us-ascii?Q?6kebCok6NQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0a2efe-0ad6-4749-cb47-08de89b42052
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:46:26.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6XPCD/yui/qI4mg9k7MqA77hggJrWoNmpxzui5dSjMykvuUa4FUy4/a/XtzTIAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8

On 24 Mar 2026, at 9:35, Muhammad Usama Anjum wrote:

> From: Ryan Roberts <ryan.roberts@arm.com>
>
> Decompose the range of order-0 pages to be freed into the set of largest
> possible power-of-2 size and aligned chunks and free them to the pcp or
> buddy. This improves on the previous approach which freed each order-0
> page individually in a loop. Testing shows performance to be improved by
> more than 10x in some cases.
>
> Since each page is order-0, we must decrement each page's reference
> count individually and only consider the page for freeing as part of a
> high order chunk if the reference count goes to zero. Additionally
> free_pages_prepare() must be called for each individual order-0 page
> too, so that the struct page state and global accounting state can be
> appropriately managed. But once this is done, the resulting high order
> chunks can be freed as a unit to the pcp or buddy.
>
> This significantly speeds up the free operation but also has the side
> benefit that high order blocks are added to the pcp instead of each page
> ending up on the pcp order-0 list; memory remains more readily available
> in high orders.
>
> vmalloc will shortly become a user of this new optimized
> free_contig_range() since it aggressively allocates high order
> non-compound pages, but then calls split_page() to end up with
> contiguous order-0 pages. These can now be freed much more efficiently.
>
> The execution time of the following function was measured in a server
> class arm64 machine:
>
> static int page_alloc_high_order_test(void)
> {
> 	unsigned int order = HPAGE_PMD_ORDER;
> 	struct page *page;
> 	int i;
>
> 	for (i = 0; i < 100000; i++) {
> 		page = alloc_pages(GFP_KERNEL, order);
> 		if (!page)
> 			return -1;
> 		split_page(page, order);
> 		free_contig_range(page_to_pfn(page), 1UL << order);
> 	}
>
> 	return 0;
> }
>
> Execution time before: 4097358 usec
> Execution time after:   729831 usec
>
> Perf trace before:
>
>     99.63%     0.00%  kthreadd         [kernel.kallsyms]      [.] kthread
>             |
>             ---kthread
>                0xffffb33c12a26af8
>                |
>                |--98.13%--0xffffb33c12a26060
>                |          |
>                |          |--97.37%--free_contig_range
>                |          |          |
>                |          |          |--94.93%--___free_pages
>                |          |          |          |
>                |          |          |          |--55.42%--__free_frozen_pages
>                |          |          |          |          |
>                |          |          |          |           --43.20%--free_frozen_page_commit
>                |          |          |          |                     |
>                |          |          |          |                      --35.37%--_raw_spin_unlock_irqrestore
>                |          |          |          |
>                |          |          |          |--11.53%--_raw_spin_trylock
>                |          |          |          |
>                |          |          |          |--8.19%--__preempt_count_dec_and_test
>                |          |          |          |
>                |          |          |          |--5.64%--_raw_spin_unlock
>                |          |          |          |
>                |          |          |          |--2.37%--__get_pfnblock_flags_mask.isra.0
>                |          |          |          |
>                |          |          |           --1.07%--free_frozen_page_commit
>                |          |          |
>                |          |           --1.54%--__free_frozen_pages
>                |          |
>                |           --0.77%--___free_pages
>                |
>                 --0.98%--0xffffb33c12a26078
>                           alloc_pages_noprof
>
> Perf trace after:
>
>      8.42%     2.90%  kthreadd         [kernel.kallsyms]         [k] __free_contig_range
>             |
>             |--5.52%--__free_contig_range
>             |          |
>             |          |--5.00%--free_prepared_contig_range
>             |          |          |
>             |          |          |--1.43%--__free_frozen_pages
>             |          |          |          |
>             |          |          |           --0.51%--free_frozen_page_commit
>             |          |          |
>             |          |          |--1.08%--_raw_spin_trylock
>             |          |          |
>             |          |           --0.89%--_raw_spin_unlock
>             |          |
>             |           --0.52%--free_pages_prepare
>             |
>              --2.90%--ret_from_fork
>                        kthread
>                        0xffffae1c12abeaf8
>                        0xffffae1c12abe7a0
>                        |
>                         --2.69%--vfree
>                                   __free_contig_range
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v2:
> - Handle different possible section boundries in __free_contig_range()
> - Drop the TODO
> - Remove return value from __free_contig_range()
> - Remove non-functional change from __free_pages_ok()
>
> Changes since v1:
> - Rebase on mm-new
> - Move FPI_PREPARED check inside __free_pages_prepare() now that
>   fpi_flags are already being passed.
> - Add todo (Zi Yan)
> - Rerun benchmarks
> - Convert VM_BUG_ON_PAGE() to VM_WARN_ON_ONCE()
> - Rework order calculation in free_prepared_contig_range() and use
>   MAX_PAGE_ORDER as high limit instead of pageblock_order as it must
>   be up to internal __free_frozen_pages() how it frees them
>
> Made-with: Cursor
> ---
>  include/linux/gfp.h |  2 +
>  mm/page_alloc.c     | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 2 deletions(-)
>

<snip>

> +
> +/**
> + * __free_contig_range - Free contiguous range of order-0 pages.
> + * @pfn: Page frame number of the first page in the range.
> + * @nr_pages: Number of pages to free.
> + *
> + * For each order-0 struct page in the physically contiguous range, put a
> + * reference. Free any page who's reference count falls to zero. The
> + * implementation is functionally equivalent to, but significantly faster than
> + * calling __free_page() for each struct page in a loop.
> + *
> + * Memory allocated with alloc_pages(order>=1) then subsequently split to
> + * order-0 with split_page() is an example of appropriate contiguous pages that
> + * can be freed with this API.
> + *
> + * Context: May be called in interrupt context or while holding a normal
> + * spinlock, but not in NMI context or while holding a raw spinlock.
> + */
> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	struct page *start = NULL;
> +	unsigned long start_sec;
> +	unsigned long i;
> +	bool can_free;
> +
> +	/*
> +	 * Chunk the range into contiguous runs of pages for which the refcount
> +	 * went to zero and for which free_pages_prepare() succeeded. If
> +	 * free_pages_prepare() fails we consider the page to have been freed;
> +	 * deliberately leak it.
> +	 *
> +	 * Code assumes contiguous PFNs have contiguous struct pages, but not
> +	 * vice versa. Break batches at section boundaries since pages from
> +	 * different sections must not be coalesced into a single high-order
> +	 * block.
> +	 */
> +	for (i = 0; i < nr_pages; i++, page++) {
> +		VM_WARN_ON_ONCE(PageHead(page));
> +		VM_WARN_ON_ONCE(PageTail(page));
> +
> +		can_free = put_page_testzero(page);
> +		if (can_free && !free_pages_prepare(page, 0))
> +			can_free = false;
> +
> +		if (can_free && start &&
> +		    memdesc_section(page->flags) != start_sec) {
> +			free_prepared_contig_range(start, page - start);
> +			start = page;
> +			start_sec = memdesc_section(page->flags);
> +		} else if (!can_free && start) {
> +			free_prepared_contig_range(start, page - start);
> +			start = NULL;
> +		} else if (can_free && !start) {
> +			start = page;
> +			start_sec = memdesc_section(page->flags);
> +		}
> +	}

It can be simplified to:

        for (i = 0; i < nr_pages; i++, page++) {
                VM_WARN_ON_ONCE(PageHead(page));
                VM_WARN_ON_ONCE(PageTail(page));

                can_free = put_page_testzero(page) && free_pages_prepare(page, 0);

                if (!can_free) {
                        if (start) {
                                free_prepared_contig_range(start, page - start);
                                start = NULL;
                        }
                        continue;
                }

                if (start && memdesc_section(page->flags) != start_sec) {
                        free_prepared_contig_range(start, page - start);
                        start = page;
                        start_sec = memdesc_section(page->flags);
                } else if (!start) {
                        start = page;
                        start_sec = memdesc_section(page->flags);
                }
        }

BTW, memdesc_section() returns 0 for !SECTION_IN_PAGE_FLAGS.
Is pfn_to_section_nr() more robust?

> +
> +	if (start)
> +		free_prepared_contig_range(start, page - start);
> +}
> +EXPORT_SYMBOL(__free_contig_range);
> +
>  #ifdef CONFIG_CONTIG_ALLOC
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>  static void alloc_contig_dump_pages(struct list_head *page_list)
> @@ -7330,8 +7424,7 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  	if (WARN_ON_ONCE(PageHead(pfn_to_page(pfn))))
>  		return;
>
> -	for (; nr_pages--; pfn++)
> -		__free_page(pfn_to_page(pfn));
> +	__free_contig_range(pfn, nr_pages);
>  }
>  EXPORT_SYMBOL(free_contig_range);
>  #endif /* CONFIG_CONTIG_ALLOC */
> -- 
> 2.47.3


Best Regards,
Yan, Zi

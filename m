Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87213A3ED;
	Fri, 27 Mar 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626904; cv=fail; b=MM1sFxLaoQ2YGXmdYSUoJrKdMg5uNUzFw5AxgZkI6Qurboe7r6CcFJKKTmjciE0sDje7evwzumWw307yr4to+9WhdvYSx4BEOK++9p0Rrh/IkkkTxT9RkwV+JQfdCiwfT6E3RcdRfhcnObnrOngysP0hiRxbDW1Xcy5n4zegkT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626904; c=relaxed/simple;
	bh=xr92k36GT9qydz00myKSW1+rPBvBLdCKB1bRACsMgQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0qj74Qn0kx3V6CkvEAge/idY/uK9AsYCWwyMxeSz+HWAosqVXB/NcR8LJRe6mALVIyqJMotxiKgt01XIpffWqpaokh5cgQF3OjqGdrDJm/b4S4zQjI9u4bw9dbQG14lh6EMYO+RDeaKFuFkudw3h2afMqxQgK/NDK1dcLxY+Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GVHgPLJd; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GVHgPLJd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snLJrOZMyUq3F+rI7G9jnJmHGTdHCj7ggOKpRri4m1yGz2mgqgJcfwh8TignWLU2gX5ABWBLm84Q475SMBN6/flIWkjnmnqnTClPaMiOCwOnnvsVwUCBg7m0CYusQdTBEgThu5WpnLcxV7ip7UCaxPhMJALSbq7WE9C1brj/ugIC/i38L9xhOD6MZ0rAD+05emXzmPVKTf9YyYNUXHADK2diTNx7uGdgeAxIkHKthGeJyFAT8ubzTJabBzsppz/PdFC9BFYh4CHQAtKDY0AR66LuKu/D76H0S9FTTLMo3Ay4hKsFVs2ruydNcHehikvRcnBlKcK4QOTz+PupySKAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaMNDyM+MKEnRreRcceZ5082DWAX+vKrp5QESLkgnBc=;
 b=SSjGOx7iyceoJSt3mvSzLFMnZ2EPIUbE9Nw46PoANU0hU8Rl4/ycagThu9xnetPef62p9U0JEVv38J6nl/IPCDQLxB6fXlevihFab8OrYxvvosnyst4KpIjYk7Kk8eHHH70H6jPEAGeHGWemEx5gf40YTLjj7ls1v/gcFXqUxlZTLGZvIKZ5c+J0epWiZLDpZql7Hb86C2yzpRHGfY41FPQcOvsyqlDhtMWf78+EbB/BsULm4gP7sPWeV7OM4nCXrFS4mBWdRUFf8FN1X+YJ80/LDn1FEyrXcqNqSV7S5cBBy3ur1Y4AjWtnKpC4wrZTVUvl2z6OxlUB0jfzD+5Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaMNDyM+MKEnRreRcceZ5082DWAX+vKrp5QESLkgnBc=;
 b=GVHgPLJdiF5TqhGtG50O6y84xnwzcfkwtjv1+jnQr6kWHn6ol2NmUkumjSvnwdg14P7Apdz4XMBEzDkomgNTFcFEQvNGSWvONIS8FWQAT6qZ0kXlcKLgaoKjUPmRk7Yc+VPBSxxpUdwTAJYLfQtPTELAvKay2VdT+B8n0v7TiN1D3EPkgaEcK+8oxXxqRfKhRTLrh4GkM5XW/4NSd7zq2P28xsGDkNI0XpP6pIU5DZjzi/mq/IeA9fMIceOpYmXxD2gBHtrNxRRHEP5uAJpHPfcZXBCcRDRIZSzf2oGw4LEIhAc9cLO70kBj5TbS85LUKrRVPMbaYveLarP1PUtICg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Fri, 27 Mar 2026 15:54:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9745.007; Fri, 27 Mar 2026
 15:54:58 +0000
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
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Optimize
 __free_contig_frozen_range()
Date: Fri, 27 Mar 2026 11:54:51 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <333A8F88-342B-48A7-8097-AF55EBBC5C2F@nvidia.com>
In-Reply-To: <20260327125720.2270651-4-usama.anjum@arm.com>
References: <20260327125720.2270651-1-usama.anjum@arm.com>
 <20260327125720.2270651-4-usama.anjum@arm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 5777a100-21db-42a4-4fbc-08de8c193276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HndC8ThBIvm8g0mgRsNTdbhW56cmzj9tAjyoOuycLQIIhTPit72UqzZFs2E4jJDBIb5jSLdstc575CoiI4f+6OLpUydVRDRIHKGo0dNofeL/Zc+Gqo5dO3+ef3xpU5V1tk9MrV75f+7fQhWFK9YVT3l4mMKTQfq9huIokzpcGPJ0dYd49pPM9oOvVppsEpnni3/4DbwfbjNs0JOZCtMO06qokZHQfHPYjDMO6ijVVovmEyqLZ3KTfRpK3YL9f6TR372/4GaSTuZZ3OPLe7gxedWdv5iMuJ41t8QachOq9cYESfn067t7cfim0pyYZzxwOqNvSQfgqtFMEgOPJG0Bu7QxOxVm0PffCF1RQbOZJD5yPdyJgKRNk6nDmCmRapRHBV2QYiSb3+iVyFXKagnWOI73S/meRY8exEE2r2MdhULnJmFfkFEp1Kq1V1TgGVXt5qTX0H2ftiFSDDQy2EaaZEoNLoOt3de+J0lSGLyPff4dV9SRLg0BSC5GbxqUWz79tfFu9m7AORk+m0k612fAb/ZgfL6BTww+hXAjsCveF/yCJyTKj2G40uIhcQs7bWHTaRP/X+5pA5nv1q0LsFqs5aTaZaEfnN/fbOTmgGonGdC6CT7hHmXGg1Zo/AEvn8oNFjC1Twg7Zf0oqedge/L+KYFXvWYJR/TBrFr7lovzyrn0vX0M0xKGxx48dtWOkcVmwGNiw4Qxj5LZIQM6f4gnG/tHLZiL062gKUJSZPhoiQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrvGBJz3u6VBiKzlDXAFU0HJZQ9KSae3wt7aMFyzeUIA3v3QtsfYkmSmBDLw?=
 =?us-ascii?Q?GqXhfYK5/qSb3I4rlURvLCgLDyQ3XOlcfezp8F4BwU2MdhfW8EPCXy2SF86H?=
 =?us-ascii?Q?Cv/VmTFqaEy2ZRbHYmrFlG2ux2y6iaO6b+BfzV4M5/exOgyQVqKnaCfpPtUi?=
 =?us-ascii?Q?25KM7cAD8yaClLj6dY0CJpRyIdGuFyTuYaKCo0ZipHxOi8mWJ2Ci0MJr1w7p?=
 =?us-ascii?Q?30HC7rvsZvDlLRCCEBVP9Y7RNr9KXz8Qs7+LeYTG17Er6eZiBZCKXBWPaPHX?=
 =?us-ascii?Q?b3m3/gWz5crEsW1GJueiA8zL/UH2KJcROJFksZ//5iLg13aGoPWd+McSY/C2?=
 =?us-ascii?Q?wdP6/BxIJ587bePDqP46VHFI2J5RBIiA+09P548U13mVlNXVTe1v7BsGdgtN?=
 =?us-ascii?Q?zwDWtr/slbZq5Zo2EGlEJ9sJVBqCHweS+PeVwJ/cjdhoaeILIUkSe80cFBXW?=
 =?us-ascii?Q?r9WX0/lLEbwqiDa6gRDN7aorK4hBh/KwMKjW5Zb1KvIJXAIiB6VSDCPQxsdY?=
 =?us-ascii?Q?uxRG9Z/Zg7IM0qU5ql6iAeLZIYHzRgQ8AE89jTzyJdvfOhfJuePL99crCGjN?=
 =?us-ascii?Q?oGVQ38Rlf16Gzx9N0N8JvKOZc/qCAFbExfAjkHEVL90+8NpkJRKLuqiJSCj8?=
 =?us-ascii?Q?NXNNE5myeodIfWGyn908rEBKHWt2uRrmFiBoq1rXDLK57Uo9YpSVlizh2n7O?=
 =?us-ascii?Q?M7djkv3/G6Ahd9353EDKcZ69nEDR0J3i3y+kroFl0sK0MxmY1ZxdnqzmHrLV?=
 =?us-ascii?Q?xaFEG/X5+LuZod8ynrnR8O2VJTztHVt7tTSDhrt36i/aJ62e1veP+2OnacrU?=
 =?us-ascii?Q?bTJ/SbrWZQoo1MbP5fAU4T9J03sy/PIwqV8GjKPN7o5UjiL46CFTDIR2s+19?=
 =?us-ascii?Q?h7eLaPzUHEh5sPjCPM+f1qI1atvJycKzUcFQuoiGom77BBZLmPd08MuFlJHS?=
 =?us-ascii?Q?X5Sai6LHk9uolh+mJ+RQE/mznXTymcBoigOjAlb62piVG8j2ukeBCgCVGdLG?=
 =?us-ascii?Q?XhEdu0sAfa66BL9LNlrkBGGoq0S7EuYZJyLCW6hVmOkOQV3FDe2uIdcHFbiu?=
 =?us-ascii?Q?Na/UxPWvfyBRs+o/k3OJ1iUheH01mskgMAchuxNhB3to89XmDlzERQvQF96H?=
 =?us-ascii?Q?aAlPKsu6yGtaTMlNqDtutOxJuAj7+TqmCRPhVbMktzqjMaoxWPGfq/Gz3UDh?=
 =?us-ascii?Q?2zzO5xcpj42GN2KtAzWe55KfuPdH+bZML8u5JOx6S8YW/NIBLnPMBolgPSeB?=
 =?us-ascii?Q?KDvpKefmllc+0bT8pctc/baTFfwZvSDiwkoIPMk2W1J28/867nh83huxxmEZ?=
 =?us-ascii?Q?J/ZUthYTJ3Rlp/ZUwcA7wrqKiz86NLMeaB505yBdo55mfTPB66xenMOd5G8a?=
 =?us-ascii?Q?O9GAPtQXyL6snVGcLarSgPMo09xDVfO+Vwye9+FnuBozbutEde6MWutcleBg?=
 =?us-ascii?Q?SeYFZxGhHMXOEMFa9b9THjSwk/V7CVVkHxSOfOgMeFUmFGU4oD+DA2IiGLQ9?=
 =?us-ascii?Q?Q1D1LKmQAYlNlW3p3jitN3BB68RBnqDeNZJXHkQ9vS4UkR1lEv5HgpbnKDEx?=
 =?us-ascii?Q?I4T8wKbbsZ9ppdentY1t3s/kRJaMFn2BTVDI4qft5FrCiyIEaqlbUNRFp3fY?=
 =?us-ascii?Q?Kv9vdXzDbx5xz1mvD1+3vJB/hzCj2B3Wd+Gtv9dzk288nPMGqVLsuAzMrDxi?=
 =?us-ascii?Q?h6DxnxRZYS6D2WXR3OELUhcjeCBHkfMrtNiRAqUUxBCsllNgv+WzFroO/GXK?=
 =?us-ascii?Q?j3rM1nbATg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5777a100-21db-42a4-4fbc-08de8c193276
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 15:54:58.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9Co9PI3SfopTL9K4/t3Hk3FYomk7h0F1ScWQ94etffLx3VEVNQqgM1zxJ+Lj4wO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On 27 Mar 2026, at 8:57, Muhammad Usama Anjum wrote:

> Apply the same batch-freeing optimization from free_contig_range() to t=
he
> frozen page path. The previous __free_contig_frozen_range() freed each
> order-0 page individually via free_frozen_pages(), which is slow for th=
e
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
>     70.89%     0.69%  cma              [kernel.kallsyms]      [.] free_=
contig_frozen_range
>             |
>             |--70.20%--free_contig_frozen_range
>             |          |
>             |          |--46.41%--__free_frozen_pages
>             |          |          |
>             |          |           --36.18%--free_frozen_page_commit
>             |          |                     |
>             |          |                      --29.63%--_raw_spin_unloc=
k_irqrestore
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
>     23.57%     0.00%  cma              [kernel.kallsyms]      [.] free_=
contig_frozen_range
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
> Changes since v3:
> - Use newly introduced __free_contig_range_common() as the pattern was
>   very similar to __free_contig_range()
>
> Changes since v2:
> - Rework the loop to check for memory sections just like __free_contig_=
range()
> - Didn't add reviewed-by tags because of rework
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 64be8a9019dca..110e912fa785e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7059,8 +7059,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t g=
fp_mask, gfp_t *gfp_cc_mask)
>
>  static void __free_contig_frozen_range(unsigned long pfn, unsigned lon=
g nr_pages)
>  {
> -	for (; nr_pages--; pfn++)
> -		free_frozen_pages(pfn_to_page(pfn), 0);
> +	__free_contig_range_common(pfn, nr_pages, true);

__free_contig_range_common(pfn, nr_pages, /* is_frozen=3D */ true);

is better.

Otherwise,

Reviewed-by: Zi Yan <ziy@nvidia.com>

>  }
>
>  /**
> -- =

> 2.47.3


Best Regards,
Yan, Zi

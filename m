Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BE388E7E;
	Sat, 19 Sep 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857994; cv=fail; b=G5dlIM3F4n3lAgDDThJVh6hze55c9HYk2fBNihtDNdWRRHr6doC9ihd1NtCQriyYmpKQwSBEb/PlprNvqH4iAiznROHP7XOKuyZCSrm6HXtrl3aJXHujga33yCWVG3sgKLOhr/JW862ndy1zelJB85UNinVrGFwrVPg3PVFysnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857994; c=relaxed/simple;
	bh=F1Tt+XpWCFSJ0kvmtdNxWMMC1asbPrY+2C1SaqTB27g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G1/YRfWLuXVgx0RCdcqerUXb/aft/T4vYSWO37O0jiD9CAxVoPXhmo++b1RVavCWU/kH0MBg/9R/hhfoPD4wXJbaaKO6FT6Gu7wgknnSG/MS+nwZkT0GUoaBNX90/CVugzkHI8kLBcD48C25RqHwbzQEWkeDExo5M9gD2Gda/U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UDgwhx7r; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UDgwhx7r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhzNDd5vGnQ9aMrpisve4ZWnX7OCQRY0xphJA2XPehaSRawIuf5GhyusmyAU+MsZAwdOJLdUWBpHWbXJ5un8hlz2VScPCzz2AGwmdUUUd71F3EULb6B6KNy3htx689W2Bw94Y4BVcYmp3cXcNymSQ9IGFukKnD/Nyoyb6QYTYM+yfwLz3CgpZtUjJqfZ2tCrbjTzEP1HQmJ7CfGjjX+r89ciBzhfKC6LcJvXQCkmHZrl+6r/AwSQAYCsBharPBb9qxwYReugAb8font7te3ISvpMQmDfqBVbftFmIcbHPn1U7auJgA/QCjmnWKns7H0pGbCxbOB2hDUDML32z53owQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nORYyKozVZUeCsXcu43vSUDKmLffZw3wWYXyR3/Bj9U=;
 b=bZFC07KsvN5iWTi6XRSSKd8Xs9iRQe9IFs1WHLXAKZ2MIAfvPBqZwX2w10w0xhSgp7M9WIdAtk9TZ/xietN8A+tU9J4kn2epC1s9o+aeATBUKcUvMZoHX61l7387o6Q9rR2oQSGmnztUFbd+wkvfNV+33nMn44OcUYIe8dNtNbusQrh6fKTW8ufDBsoc9bb92SGY6izwXEPhnGCpfZfP77e+bF3n2KBiC87RkR4878psXpWfLFgDRLcgYR6unr6gAv19Sv3WRueCa4sQO4N00XqHE4cJWaPdhny3PHn4BynAdRSWSacrQMKfapoDIpOZl7GrMtWlaqqt7TWypLTmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nORYyKozVZUeCsXcu43vSUDKmLffZw3wWYXyR3/Bj9U=;
 b=UDgwhx7rTlJJ/VWRPblCBh984lR6zGgfHwUZgU6V7B7bVgX+ggvo/45Nu3kwLiqmpiLnPF8gqM5v+ywTWPaFkeMCMuDkASmDANQ+mw9H2xnjGuRdMAVZE1JfSR0v+eI4Vaupe6Wzl8yRCrI2+sCQuyYAgzhSBqA0DshYw/gBsPTgt++mm1MSfMpVOR45VBtiFfe1a3LPUYFmIQo/G77sthoFWcl86PlL/0sfxdXKvjEZNYOAo/5I9yUjBeZgwuXNYjBYCnXfz97arh8K0io7+CrJvXmL6ncaLN5qqgaUnBQ9J6n6lXpBRjUpoKXSsFFT0bKtp9Pgmh5qXmF/eNRsKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 22:46:27 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 22:46:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: arena: Flush stale TLB entries before reusing ranges
Date: Sun, 20 Sep 2026 00:46:16 +0200
Message-ID: <20260919224616.3123513-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d74806-1d28-45de-4cf6-08df169fd656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|3023799007|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qtj5oSTukte114Gt1kiikX5zpzXoeZ6JnxFXTH1bVH7dhDRkoxrwO6E4sS8JJMYtL9OW46pJiOYQVC7keg2euY/h08j+hF+jGtaLQCGTAqMK3A/e4l2IGyuswYsMeKXQXGJq6S9p2LbUwF4T9m7orkP4qCnYI6hWFa8z13TsQo2Kn5BDnheOVhoO4zapRO9VY7+0h0vubfJbVn70spl/So1Wa/Tw/kKPvtZZktIdf9jnE/TRLV2vupsDxa9unfvV7jSaT5rDsIL7SHk8NKPwmYDJ5snOs90M0KWP6MUFBaxxjYYaj8V0JtfHo96AEZbFVgTCR/WYCTh4G7GUKzVwfRmamiSgYWlSZB5legRoboKv/U2zPgvF1qIL6JIs5DLL7WFkZMQWGIrA0TM3vbxgq2fTBseaqOtkcjHIBlNYowi3aVxH8MJRviXMxbdsquuMPf76nzT7w27PJgvKvlVUN2ZazJLfGHG7dj4Xia54VgLJ9pDLADJKPbCWsLZizyNnt1MFDPtvWtHKyBuz7gWSRbbljdRtbCo3FogwQtJ2EscjOrAGwt0ZHCJWcIhQsO979691mgRgETlkLi5dsmiPVlMNg2MA6z84KVynyYEapVBNBcbBQNqVQhzezx/ifDTQl+c0KnWhth27bpv/X/XJlnP0gfe8TM6fuWFjWC0a7+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQzNHEXG2Gq7sRDX36AZqFmW90HPPYCWOCbtZMia9B0XPJk+8+4eRfDE9Yy4?=
 =?us-ascii?Q?j2Xd3PBkiaox3qzYRSNKJm31wYBQ/A7snMMTRgWGF8qAjfrIq/uRj3g/obGY?=
 =?us-ascii?Q?HBWYqB0qE/Y3ElMP2fK2aeG0to5pwbnAJVLLkxhhT6aiBuMjbK2I75Wgj+PS?=
 =?us-ascii?Q?QOaxEV5Sb21VCwUin5QhjHUPKWoqJAYLOGwE5YraEJZUR7lmfP74kJZcvIy0?=
 =?us-ascii?Q?Fx7SGr0OHyJxxASZOguzvFxiDJ7BrPsYKMc68ghFBWL2vJytaZa96rsJ73Xk?=
 =?us-ascii?Q?feJC7tItTD/UaTn2q/C0BhdxBB9RzKNkje47kwXowthTjCFccmSGyuyK4keB?=
 =?us-ascii?Q?/2yh6Oeil24q1tijnEyXS1H+1NAHYx+un/1aYdW3hbxrrwHsRqizUQ8tpRVW?=
 =?us-ascii?Q?+/oINmgJw5O6oHQTuWQTBanQPXNim3fm5N9Zv7csIa5T7w7J5gV9hYlQJCor?=
 =?us-ascii?Q?ZFoxpK80gPfRWFfLvlRZk8MuXvUEmgeEpHK+bSHASECMSPrTVC5uyHEfFsNw?=
 =?us-ascii?Q?4uzOCeVESolJa1oDNImcA7/4pCLkRAL9Y8eUYUnB48hDHV4tTKrmLQNoXdZV?=
 =?us-ascii?Q?pt/vqV5sxII/avzJuppFFs928BHmXA9HwqyVGM8VcayZEnH/2fziEnFuPylh?=
 =?us-ascii?Q?sKnscqYikr+wGnxV0jhKM7LKXu6dcjS/4HaUposvarLlK5NwqrRDuS4cwzpO?=
 =?us-ascii?Q?KSQGRhQB0Dm3V6Kv3YbXjIOTPXzSqjbfPd9p9w98NUWGvX9S+tTbTlJI78gi?=
 =?us-ascii?Q?YRkZPZAD/yLDpnZEvJ588pi6nylZuGQC4vkjWJSnUHBzZNrkfv/568hERb5b?=
 =?us-ascii?Q?S4KG3CeA9wwI+okEXX5Xv8L6u2U4SpX4I5LQnzDt8+oxXU2HkkeDFDt5b0wO?=
 =?us-ascii?Q?b6igv/Rte50TDqjW1r3OE7kJRS+VX36YbfNhE0TheUBxQoL5viggIDNsua4K?=
 =?us-ascii?Q?R3YptORpbLxsw6nekYp/cXDtScQZa68RdQw/rbz6LVVIwn8h9yTNx0XNlcLu?=
 =?us-ascii?Q?gUEp6Ackc4IWtwzV22f4mZkjcardfjZRLRK0YzFNS9sebT3uueJGKGI2LwYE?=
 =?us-ascii?Q?IN5TWTP5C9YRKz7LTyk55lfMc3p3uMCmWqq7qNhNqvYaAi8gC5TEPQ9ywpft?=
 =?us-ascii?Q?5gAokcpxPPhgcgTCBV7em8NMUNu0PrWppHsMuUHHJ84zdUAHmalQFN/TFyDN?=
 =?us-ascii?Q?Kv6FqeFATG7lgYQPVQ/SLnk9Qlo20I/m5bol6PezDCamwfwnh1VoSPOuERYd?=
 =?us-ascii?Q?DqCpR+mf/LrYv/AW0d7k9J5Cws+0dlSb1aD/xkhlzqAKj0D9CSalZ+WzHMGO?=
 =?us-ascii?Q?H1jhdjG9oIwpaLiR1LuppdeY+N6i9L1kdDeTxUi7jDk9XCR85FA6jC68BzFx?=
 =?us-ascii?Q?Ykk6ddPkiIc1Nkoop/1p16xrxdXUarGUcmoC6Uz815zhgeLfFcclRP6dFMmt?=
 =?us-ascii?Q?jzRsMNc1GIGj0dvrFhgFRt35IBrwM/qwCo9BqYt4YeKvhp9rJ5i0m24hTZEM?=
 =?us-ascii?Q?RRFBvq/9MgYX1rUUOC0qdcysxxOkCBV75c7BoDK4ovQduxHmXnw0YzjtQaor?=
 =?us-ascii?Q?fk+oqvpxWiqINVlGWkBsE8ouj3V+tI4uVzOS+/izBzeaKmXAzDPCh8UifE/n?=
 =?us-ascii?Q?vkuQ5HjjTfBcHsKspj+3JrNcmMTbajZgPC1F8GPocfgLLgs1MoG2WaEs1Q6r?=
 =?us-ascii?Q?j8lgMTQhGdbNFey09nCEWJGUPXaBEltdpFRaAbumxvPEAD2QJfgqS8P37a0f?=
 =?us-ascii?Q?vVyUiAk6Dg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d74806-1d28-45de-4cf6-08df169fd656
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 22:46:26.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrA9HFwWfjUcjzlv1B+7SjYpJBJil+S2sSrpnaJFIAA+OytYiDCi2RlyDIgsrzF9pszkxyX+K8rJnyraqaXAqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

arena_free_pages() returns a virtual range to the range tree before it
flushes stale kernel TLB entries for that range. Once the arena lock is
released, another CPU can allocate the range and install new PTEs before
the flush completes.

An allocator running with a stale translation can then initialize the
old page instead of the newly installed page. The freeing CPU
subsequently invalidates the translation and frees the old page, leaving
the new page zeroed despite the allocator having initialized it.

This corruption was observed with scx_eevdf while repeatedly running
stress-ng --sleep 0 --timeout 10.

Keep the range unavailable while clearing its PTEs, invalidating kernel
translations, zapping user mappings, and freeing the old pages.
Reacquire the arena lock and publish the range only after teardown is
complete.

After page teardown, reacquire the arena lock to return the virtual
range to the free-range tree. Resilient spin lock acquisition can fail,
so defer this final step when that happens. Record that teardown is
already complete so the worker only publishes the range instead of
trying to tear down the pages again.

Also add a selftest that primes the old translation on multiple CPUs,
races a free against concurrent allocations, and verifies the contents
of the reallocated page. Exercise both sleepable frees and frees
deferred from a non-sleepable context.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/arena.c                            |  98 ++++++++---
 .../selftests/bpf/prog_tests/arena_reuse.c    | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_reuse.c | 113 ++++++++++++
 3 files changed, 356 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_reuse.c

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b431..73a3103a401b5 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -76,6 +76,8 @@ struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
+	/* PTE and TLB teardown complete. */
+	bool publish;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -873,15 +875,13 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	if (!sleepable)
-		goto defer;
+		goto defer_free;
 
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
 
 	/* Can't proceed without holding the spinlock so defer the free */
 	if (ret)
-		goto defer;
-
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+		goto defer_free;
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -890,10 +890,9 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 				     apply_range_clear_cb, &cdata);
 
-	/* drop the lock to do the tlb flush and zap pages */
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-	/* ensure no stale TLB entries */
+	/* Ensure no stale kernel translations before publishing the range. */
 	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
 
 	if (page_cnt > 1)
@@ -911,11 +910,17 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
 	}
+
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret)
+		goto defer_publish;
+	range_tree_set(&arena->rt, pgoff, page_cnt);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	return;
 
-defer:
+defer_free:
 	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	if (!s)
@@ -928,6 +933,21 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
+	s->publish = false;
+	llist_add(&s->node, &arena->free_spans);
+	irq_work_queue(&arena->free_irq);
+	return;
+
+defer_publish:
+	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	if (!s)
+		/* The pages are gone; leaking the unavailable range is safe. */
+		return;
+
+	s->page_cnt = page_cnt;
+	s->uaddr = uaddr;
+	s->publish = true;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -977,7 +997,8 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
+	struct llist_head completed_spans, free_pages;
+	struct llist_head publish_spans, teardown_spans;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
@@ -991,41 +1012,51 @@ static void arena_free_worker(struct work_struct *work)
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
+	init_llist_head(&completed_spans);
 	init_llist_head(&free_pages);
+	init_llist_head(&publish_spans);
+	init_llist_head(&teardown_spans);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
 	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		if (s->publish) {
+			range_tree_set(&arena->rt, pgoff, page_cnt);
+			llist_add(&s->node, &completed_spans);
+			continue;
+		}
+
+		kaddr = arena_vm_start + s->uaddr;
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set(&arena->rt, pgoff, page_cnt);
+		llist_add(&s->node, &teardown_spans);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	llist_for_each_safe(pos, t, __llist_del_all(&completed_spans)) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		kfree_nolock(s);
+	}
+
+	/* Tear ranges down while they are still unavailable to allocation. */
+	llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
-		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
 		kaddr = arena_vm_start + s->uaddr;
+		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
 
-		/* ensure no stale TLB entries */
 		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
-
-		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
-
-		kfree_nolock(s);
+		s->publish = true;
+		llist_add(&s->node, &publish_spans);
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1034,6 +1065,33 @@ static void arena_free_worker(struct work_struct *work)
 		__free_page(page);
 	}
 
+	list = __llist_del_all(&publish_spans);
+	if (!list)
+		goto out;
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		llist_for_each_safe(pos, t, list) {
+			s = llist_entry(pos, struct arena_free_span, node);
+			llist_add(&s->node, &arena->free_spans);
+		}
+		schedule_work(work);
+		goto out;
+	}
+
+	llist_for_each_safe(pos, t, list) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		pgoff = compute_pgoff(arena, s->uaddr);
+		range_tree_set(&arena->rt, pgoff, s->page_cnt);
+		llist_add(&s->node, &completed_spans);
+	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	llist_for_each_safe(pos, t, __llist_del_all(&completed_spans)) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		kfree_nolock(s);
+	}
+
+out:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_reuse.c b/tools/testing/selftests/bpf/prog_tests/arena_reuse.c
new file mode 100644
index 0000000000000..9ac4b7ffe3b8d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_reuse.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdatomic.h>
+#include <sys/sysinfo.h>
+#include <test_progs.h>
+
+#include "arena_reuse.skel.h"
+
+#define MAX_ALLOCATORS 15
+#define ROUNDS 20000
+
+struct reuse_ctx {
+	pthread_barrier_t start;
+	pthread_barrier_t done;
+	pthread_barrier_t next;
+	atomic_int err;
+	int prime_fd;
+};
+
+struct thread_ctx {
+	struct reuse_ctx *shared;
+	int action_fd;
+	int cpu;
+	bool allocator;
+};
+
+static int run_prog(int fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(fd, &opts);
+	if (err)
+		return err;
+	return opts.retval ? -EUCLEAN : 0;
+}
+
+static void *reuse_thread(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	struct reuse_ctx *shared = ctx->shared;
+	cpu_set_t cpuset;
+	int err, round;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(ctx->cpu, &cpuset);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+	if (err) {
+		atomic_store(&shared->err, err);
+		return NULL;
+	}
+
+	for (round = 0; round < ROUNDS; round++) {
+		if (ctx->allocator && !atomic_load(&shared->err)) {
+			err = run_prog(shared->prime_fd);
+			if (err)
+				atomic_store(&shared->err, err);
+		}
+		pthread_barrier_wait(&shared->start);
+		if (!atomic_load(&shared->err)) {
+			err = run_prog(ctx->action_fd);
+			if (err)
+				atomic_store(&shared->err, err);
+		}
+		pthread_barrier_wait(&shared->done);
+		pthread_barrier_wait(&shared->next);
+	}
+	return NULL;
+}
+
+static void test_arena_reuse(bool deferred_free)
+{
+	struct arena_reuse *skel;
+	struct reuse_ctx ctx = {};
+	struct thread_ctx tctx[MAX_ALLOCATORS + 1];
+	pthread_t threads[MAX_ALLOCATORS + 1];
+	int nr_allocators, nr_threads;
+	int check_fd, init_fd;
+	int i, err, round;
+
+	nr_allocators = MIN(get_nprocs() - 1, MAX_ALLOCATORS);
+	if (nr_allocators < 1) {
+		test__skip();
+		return;
+	}
+	nr_threads = nr_allocators + 1;
+
+	skel = arena_reuse__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	skel->rodata->deferred_free = deferred_free;
+	if (!ASSERT_OK(arena_reuse__load(skel), "load")) {
+		arena_reuse__destroy(skel);
+		return;
+	}
+
+	init_fd = bpf_program__fd(skel->progs.init_page);
+	check_fd = bpf_program__fd(skel->progs.check_page);
+	if (!ASSERT_OK(run_prog(init_fd), "init_page"))
+		goto out;
+
+	pthread_barrier_init(&ctx.start, NULL, nr_threads + 1);
+	pthread_barrier_init(&ctx.done, NULL, nr_threads + 1);
+	pthread_barrier_init(&ctx.next, NULL, nr_threads + 1);
+	ctx.prime_fd = bpf_program__fd(skel->progs.prime_tlb);
+	atomic_init(&ctx.err, 0);
+
+	for (i = 0; i < nr_threads; i++) {
+		tctx[i].shared = &ctx;
+		tctx[i].cpu = i;
+		tctx[i].allocator = i != nr_allocators;
+		tctx[i].action_fd = bpf_program__fd(tctx[i].allocator ?
+						   skel->progs.alloc_page :
+						   skel->progs.free_page);
+		err = pthread_create(&threads[i], NULL, reuse_thread, &tctx[i]);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto join;
+	}
+
+	for (round = 0; round < ROUNDS; round++) {
+		skel->bss->alloc_wins = 0;
+		pthread_barrier_wait(&ctx.start);
+		pthread_barrier_wait(&ctx.done);
+
+		if (atomic_load(&ctx.err))
+			goto next;
+		if (skel->bss->alloc_wins > 1) {
+			atomic_store(&ctx.err, -EUCLEAN);
+			goto next;
+		}
+		if (!skel->bss->alloc_wins) {
+			for (i = 0; i < 1000 && run_prog(init_fd); i++)
+				usleep(10);
+			if (i == 1000)
+				atomic_store(&ctx.err, -EIO);
+			goto next;
+		}
+		err = run_prog(check_fd);
+		if (err) {
+			fprintf(stderr, "arena reuse corruption at round %d\n", round);
+			atomic_store(&ctx.err, err);
+		}
+next:
+		pthread_barrier_wait(&ctx.next);
+	}
+
+join:
+	for (i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	ASSERT_OK(atomic_load(&ctx.err), "concurrent arena reuse");
+	pthread_barrier_destroy(&ctx.next);
+	pthread_barrier_destroy(&ctx.done);
+	pthread_barrier_destroy(&ctx.start);
+out:
+	arena_reuse__destroy(skel);
+}
+
+void serial_test_arena_reuse(void)
+{
+	if (test__start_subtest("sleepable"))
+		test_arena_reuse(false);
+	if (test__start_subtest("deferred"))
+		test_arena_reuse(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_reuse.c b/tools/testing/selftests/bpf/progs/arena_reuse.c
new file mode 100644
index 0000000000000..232a7961c3ab0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_reuse.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+#define PATTERN 0x5a17c0decafef00dULL
+#define PAGE_QWORDS (PAGE_SIZE / sizeof(__u64))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+void __arena *page;
+__u32 alloc_wins;
+const volatile bool deferred_free;
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+static __always_inline void fill_page(__u64 __arena *p)
+{
+	int i;
+
+	for (i = 0; i < PAGE_QWORDS; i++)
+		p[i] = PATTERN;
+}
+
+static __always_inline __u64 __arena *get_page(void)
+{
+	__u64 addr = (__u64)page;
+
+	if (!addr)
+		return NULL;
+	return (__u64 __arena *)((__u64)arena_base(&arena) + (__u32)addr);
+}
+
+SEC("syscall")
+int init_page(void *ctx)
+{
+	__u64 __arena *p;
+
+	p = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!p)
+		return 1;
+	fill_page(p);
+	page = p;
+	return 0;
+}
+
+SEC("syscall")
+int prime_tlb(void *ctx)
+{
+	__u64 __arena *p = get_page();
+
+	if (!p)
+		return 1;
+	return p[0] != PATTERN;
+}
+
+SEC("syscall")
+int free_page(void *ctx)
+{
+	void __arena *p = page;
+
+	if (!p)
+		return 1;
+	if (deferred_free)
+		bpf_rcu_read_lock();
+	bpf_arena_free_pages(&arena, p, 1);
+	if (deferred_free)
+		bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+int alloc_page(void *ctx)
+{
+	__u64 __arena *p;
+
+	p = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!p)
+		return 0;
+	fill_page(p);
+	page = p;
+	__sync_fetch_and_add(&alloc_wins, 1);
+	return 0;
+}
+
+SEC("syscall")
+int check_page(void *ctx)
+{
+	__u64 __arena *p = get_page();
+	int i;
+
+	if (!p)
+		return 1;
+	for (i = 0; i < PAGE_QWORDS; i++) {
+		if (p[i] != PATTERN)
+			return i + 1;
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0


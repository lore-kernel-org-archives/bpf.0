Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94B418361
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627211; cv=none; b=ZpHkieySaFsAQgl+R+DkN7mQMykFe+JBbyA5mzq0Or68JhJA6TFJ1Bkig8r9z27XUun1XKi9JTi9Xu97MebSoouZjmgFw0QPurKsdLvPaFF/yUHNZ1OYA8AG+3KZ0OB1J69nLJvzfFIT+wpMqHQ9d53sS2EfiLA57cEdgnNRB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627211; c=relaxed/simple;
	bh=dwzgsSSrbh7K4DWNZBxxX6JiMkcVaETenOkAdEnQo+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEYAzjrP6ubiFYig6ESsyyoSFGUF4ra0mM94BqzpwMrcIrJJ9XrKyIEOqhJg+O0xLX+x+mwH3Lt857cGQdrrWZHTVQr4gvCIlboGThHt6fEE/tS9ZtUpWYun3vF+UlgszLgAOVU19qVSgrjC57n6JQRGYYDaGhR6SdDbpZCYNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sdZipZiT; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sdZipZiT"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so1062454a91.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627210; x=1791232010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=sdZipZiTPivmZ27VnkXEE1CPfhequq0Kxh48hIMaL0M0m/6I0LmX1lAX5gSCDFHisa
         rExULco9zzdFIj7z6JGrkld+TQSbMEcVOsWPpD6mnEG3Q7opK5jvkjXZx8CpnfAvaRSF
         SRR1h8g/wKe47zny6N7+u8MFbvf0V/OoMsB8afqRA+8cqSDJhWl1BL6iHaazPYbNpKhg
         1oPYuuAi+6shBRfSW0Lqg8bk863QehXXPes2CPtl4sx03Y/wOtrBP5uX7rChRag9p7mO
         iNbeZVS4CwrOHWftGla7q00XIrQvR6n1uSYm/LtqLx8bPMQb/0PQSk4zKNSph1SjudLk
         agrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627210; x=1791232010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=mtnm3l1PMHqXLtxH3WADtv/h+skaGn+bcbR2zg2kWT7uJ4NzLxMTYbqzZ16cIFFQMG
         ixuOJEtkULhgVsMliW03hUae/i6VHS4cBzOPVp9ep1rKTj307RBRqJCrzJPvWd4tIa0g
         30+24MKr+OOXw5mHSJix9CMz2qb5C76p6wcVZg6MCdM58uYH+V3wUjNbF5O25GKSxVOR
         VwE4vttR82PjSKEbUZ+RolQfq8TICG7GHfhygRX3dDJ1XjRHGRYhJGyOmsfc0wQEOhj3
         pCJjVkIEOAth0XJl+iC4IDO3/SFvwsBptb+53KwF71XoBNedncjfNmukdsI1rVQG3mUo
         XytQ==
X-Gm-Message-State: AFq9FYJN4w9R5JKixhsvG9TGEtVwuR7uXEwvEJrgkaTmHWsg6RqMzxxK
	YREg0xX0OURgmoCDLpdG2JIXPqZ8FbZKL7zB9f3PtXpNl7VK5ktJqg3sg7vwZlFUzNcgm4K3YFB
	g3OfXF1c=
X-Gm-Gg: AYBFou0ESd6jlI1m3g0CnLoSdfUZy9C8im92S9AO6uqCJ5+GdqQ8ueovwjyCVUNE6X7
	pSnogXpLU42rvG64QqWz+kS1W/oUzsQ8O7DYuFXxQR0I2TyKkxdq5GSFrjoRg/dyjoqOZSmO622
	sF/HkP+xZZZzVqmpyBj/ErznYW9H/ELT9Omk1FZsSpmlpR9J+hwstF550k05zowV9acCVaUblKP
	IVwv87CCBtVM6ac4s7NZXSeN1MPSMsIvuBDwXeBYiRMcSCtRLr2MFWvCXOVLUroUax/zu7XoDF3
	o3MloGvVUkFNOBVOSM6rpyymnO0MH1P12yGyX8ocUF+CA2urMvELREpG4A68ybnB0RcQNOas2F0
	rOW+enMhtKZKzWtmAG7NNZe9ZmpTfFG0aouK2MIl7ZFTlvPUu46zVXG6HV7wIjiLgvux3Rk6o/V
	P6Bai084mHsKR3Bipqw53cR7Je/pABavfPpcxtSwR77/VKE8c80WFdjzKdfsEcPOhI8Q42Q5VnR
	FIr3st6oN2g1v1OVtVQtr4FhCXSZHkS7fE0GO+bzvU=
X-Received: by 2002:a17:90b:1dc2:b0:3a4:8c41:facf with SMTP id 98e67ed59e1d1-3a48c4202f8mr825380a91.41.1790627209800;
        Mon, 28 Sep 2026 13:26:49 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 2/7] bpf: Add sleepable argument to bpf_alloc_pages()
Date: Mon, 28 Sep 2026 20:26:38 +0000
Message-ID: <20260928202643.9114-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928202643.9114-1-emil@etsalapatis.com>
References: <20260928202643.9114-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_alloc_pages() currently decides whether it may use the
blocking page allocator from the current execution context
alone. Let callers further restrict that choice by passing
whether their context is sleepable.

Use the blocking allocator only when both the caller and
runtime context allow sleeping. Add __GFP_RETRY_MAYFAIL so
this path can reclaim without invoking the OOM killer when
the allocation is charged to another memcg. Existing
non-sleepable callers retain the no-lock allocation behavior.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h  |  4 ++--
 kernel/bpf/arena.c   |  6 +++---
 kernel/bpf/syscall.c | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 904b539810c7..670eb9f3f20a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2902,9 +2902,9 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 
-struct page *bpf_alloc_page(int nid);
+struct page *bpf_alloc_page(int nid, bool sleepable);
 int bpf_alloc_pages(int nid, unsigned long nr_pages,
-		    struct llist_head *pages);
+		    struct llist_head *pages, bool sleepable);
 void bpf_free_pages(struct llist_head *pages);
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index de4f7c7f68f5..c556df7730c4 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -317,7 +317,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	INIT_WORK(&arena->free_work, arena_free_worker);
 	bpf_map_init_from_attr(&arena->map, attr);
 
-	arena->scratch_page = bpf_alloc_page(NUMA_NO_NODE);
+	arena->scratch_page = bpf_alloc_page(NUMA_NO_NODE, true);
 	if (!arena->scratch_page)
 		goto err_free_arena;
 
@@ -550,7 +550,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		 * The probed page was freed meanwhile or preallocation failed;
 		 * try the non-blocking allocator, we cannot sleep here.
 		 */
-		new_page = bpf_alloc_page(map->numa_node);
+		new_page = bpf_alloc_page(map->numa_node, false);
 		if (!new_page) {
 			fault_ret = VM_FAULT_SIGBUS;
 			goto out_err_locked_memcg;
@@ -771,7 +771,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
 
-	ret = bpf_alloc_pages(node_id, page_cnt, &pages);
+	ret = bpf_alloc_pages(node_id, page_cnt, &pages, false);
 	if (ret)
 		goto out;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a5df15a6cd51..ef8fb2f6e6e3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -602,14 +602,14 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
-struct page *bpf_alloc_page(int nid)
+struct page *bpf_alloc_page(int nid, bool sleepable)
 {
-	if (!can_alloc_pages())
+	if (!sleepable || !can_alloc_pages())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
-				| __GFP_NOWARN,
+				| __GFP_NOWARN | __GFP_RETRY_MAYFAIL,
 				0);
 }
 
@@ -624,13 +624,13 @@ void bpf_free_pages(struct llist_head *pages)
 }
 
 int bpf_alloc_pages(int nid, unsigned long nr_pages,
-		    struct llist_head *pages)
+		    struct llist_head *pages, bool sleepable)
 {
 	unsigned long i;
 	struct page *pg;
 
 	for (i = 0; i < nr_pages; i++) {
-		pg = bpf_alloc_page(nid);
+		pg = bpf_alloc_page(nid, sleepable);
 		if (!pg)
 			goto free_pages;
 		llist_add(&pg->pcp_llist, pages);
-- 
2.52.0


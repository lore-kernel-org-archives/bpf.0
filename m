Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FF5383E5
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707174; cv=none; b=luDBUviCYldSgJfsrpicBQmefOlNLt+/McQXc9ODHUnSu6VibxVuJ1dMrL+JLCJSCxRdXf5dlZn4R4DCiJG6ez0WABFw8TMFqWTL8eQowPDaWgZGoLbXZGMzHpA1eTEF2WI69uDNsPegmfwqRvEI47qtzsUkLqNAIlRBWq1aaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707174; c=relaxed/simple;
	bh=dwzgsSSrbh7K4DWNZBxxX6JiMkcVaETenOkAdEnQo+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAq0dx7QqFWxt8FMsDpR8gPA1BmmdBuA9udBir1fUcuUYJJLZBBs25aiFoeB5ZmL/34HMbW0F0an4SVbGXnbSP4TWwd05smZ4lzLYx651V/Dj/+atJbx6I1Pz37WxwXqPsIoSEpzAAcVBxG9bEyRu8I4O9f9R5xRwG4Igh7VsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=o0PAl2zi; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="o0PAl2zi"
Received: by mail-pj2-f18.google.com with SMTP id 98e67ed59e1d1-3a4c276e1c7so1506a91.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707172; x=1791311972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=o0PAl2ziqKvxv3jW+ywFZpa0cHCytvIvh1U0oqeCvcoUvtADB0je5bgB8/FZ7LkZtX
         mJuj2bWE5ZgjsfnEL6CqjkzxP2sKP6tetI082qTtNYZgJKwTUo1XDEngr6lRYmYJTgkU
         NuZuxAANNMRyKsG4IstdzkTY/RNxOmh/VMGVPPC++gWZw9JumaIkB0M83y4CJEMrKuC6
         XF/VqI734RdbCoPrYdEx9jm5T9WX94h0bLCDiDFYO/rtgCrm+Z/wP+NIFkaa00bLq0uq
         Tw/wV9aWDfiKjJKwjzwOR3InFowx6F65zC+OpLbKWYgGEcdrflGbSpZzmYEwdRVbpoKG
         Ziqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707172; x=1791311972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=lfCpV5Jd0ertkID5vLimI3AMu6+KHvmH2sTu6yfbFqU3lJ3CeU6OLA7/oIlnRSwnsF
         q+72S/Zbq+v7YDXBOKhSFviy+63UFSCyDdP0tzfyIB5JvqTv8Eq5dYpxQBt/GzTZ6Jx1
         xS62C/uvJM+VxV09cZ/68G80SvBdB8ZOq4H33LITwb2xIwxpHKBN62rp8am0Bz6fSnyX
         DJ74uDdqUt+wPnHxaMbnWktHL9X4UtjJQLG7QkfWJKU1xV5CvcGaEg89mHqqwMr2/5ul
         NnOudhxLkQyw8jl2pYXsnc1ASmQEKP+DL5KBqyC/AgY7dKUvnj+VjMNkIzWjX57z/Tyz
         GSdw==
X-Gm-Message-State: AFq9FYJvNMk0Zqi1gur4lFmoxRzoGg6wjRsb0e9iLlsYEnivCrXLR2bs
	YMtxvMZYSTw9FMNrBhFU9Rq528nkrkOgiR8mZyIDFRBw7exElrNo9VpyVlicDiGkle23l7SsBkk
	8UY5H9JI=
X-Gm-Gg: AYBFou3jrxb/twRUunLfU3larW15RlaahHEr9PuTR2S7jfEtjmp1ocGDmbRMdQThbnm
	oU1fISCz8NUx+uyfuKvy6Zlv9YusvfWndvwPkCGr8MKa+MirF5KJAJmqwUMpsBqHw3EiVLY24Oc
	MptknSxyprXa0XWlZbaGqupjgDroWdCutVZEBuPXOywdQ9Nb3xfcOO46grpe3J8Pfv+gUtLY380
	ATEngUZckIWtWyDxQNUUk2rA0cZ2FhgsGi0ngffHN7x3z8mJFq1fIybAt/zUqhvxYpRDeIpG5WA
	iLgfsnnY/pXPg1E2zvB1ZvCwwybCg31qBX1m8euGfEwjIgXwp9aKr6j4KHDPT9E14xnieK9RV+T
	m/8VM99QesRPks3rqAJxX0stHNcCHBYxb6CtUX+SSgM/95ptmU2VZ3a1qoSJ9/iSVHGK0111y2j
	mUhdM7k1u6/PBx46nXS7ZbhylSSk6IjQLbQtwOOr+To1xh/yS3PQroO6Uap0psi3CJ2njPhyLoV
	kKHoJP2eDkX8hKmxoYCk3QwqYyrZ012rAczvWq3An8=
X-Received: by 2002:a17:90b:5343:b0:3a1:66fd:94af with SMTP id 98e67ed59e1d1-3a4bfe94b96mr105342a91.37.1790707172262;
        Tue, 29 Sep 2026 11:39:32 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 2/7] bpf: Add sleepable argument to bpf_alloc_pages()
Date: Tue, 29 Sep 2026 18:39:23 +0000
Message-ID: <20260929183928.4896-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
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


Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DA4854E1
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938347; cv=none; b=WhhqNitWkORCGearU7z7v3Q7VbFuwwCLtLfLNpwqKrOY3PSnm3l3auLYYs9W403N9gK8L8YVA54tymZYcQx5+rgSzOVFu8QF1rYQT6a+PFYZJE/NzfN5pUCqq8QDay/xrt9z9CJKhQn5x4fHZ8jSNG9x/oRGxo2e4u/oVpWQv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938347; c=relaxed/simple;
	bh=dwzgsSSrbh7K4DWNZBxxX6JiMkcVaETenOkAdEnQo+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoNuoElnbdT7uyoxPvfHDPBdI2W08muUmDVOTaqh3Qz8DJNSnEjalIJRNcTCdEp6bdusrgUQyBUfTdal+FBQIYj4XbM0WsTBFtyBgjGXYuDvU2crYpoosxPmyV7yn90vMQIkNYfvYxjP6mAnnMSFcXTjTQhkIYs/LzM4CwPjjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=DaPI2kdw; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="DaPI2kdw"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so59848985e9.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938343; x=1791543143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=DaPI2kdwZHIRXQTFEAp4iIc8eHD4FS89xB5knu0caKeSJYVU45GfUrULbrNuIJQ/Vk
         CLEvdi3SDRbGnXhMlNIPco2q5KKWJIAqXYoYvsKpF+9G7kCjwbj7+eBNDxg9I3zrs+l7
         ifrUsX05GWNCgMKFgTyXcnHfQgmKGMg4KcoPjRmwtL2zsoBNIFWJiLepV1T/R51AbDNw
         3lNdOGbwfVwjLIhYF1I/05MmYnAeYZlox/786z7ev5TWsqJDJQAmcaDVFnwXeNbtK41b
         YiRYgpI1OvmvW3ctkEWz7DWIR1HZjiL+reKewDae4tw9e4sjEb9rs3SYAIN7hOYscqW3
         X2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938343; x=1791543143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2mAY0jCm8atcrUhCsd9t6pu2Vra6gZ8qEFo6aEEseQ=;
        b=cB5WN2plLBWLJ31yIJCXV8praPz/WBKxeU7Z1mRzbkQc78OZu3g68Bkf8ekLBUeQ4d
         /hDM+LgPS7zAWxZPWg9p47HNkAu9opV/6JsFQ/2mucZqQ9QIBf7h7yk6LWuGw/zjhvbR
         fY+NXj6uFE3jhqLUlElLrJVaclAzMq3Gu2GNNXc2Y1d+HYdd9S/vaUaron1W7anCZDuU
         iZ/9Ap0p123uuG/ElLE2OUT4EwIX3ikKRAGgZCEtQwDNOb+kvV4sqQKPZ3uSVm5mtYGp
         64aBiON+UKimCDuOtr9yMOOIOzjQWCPG9OOBB3Gq0HgQrOyZkBXNBC6bFDktav2hJEdn
         PwRA==
X-Gm-Message-State: AFuF++lS7bPyHIgpjUAWadWN4clrYXoQOqyARBzJH1MJXrmeWG36UoR4
	68HS+yLeJNOEqUE0wuuF2uC25xgQ2LYnQ1sZcJ2f2geSPtMPz7H5JQlkbYGNT4pXAJ7ue4yo3xz
	ygJ3NFLE=
X-Gm-Gg: AYBFou2S1oHeiRQ2b8o0WblSXO2ZCA9OJdRJ5EQMtJVn75rq05FcJM6JYu0FLQXajgA
	D3c2FoH9ZiXuKQDcfOiaXcsNO3IyuAUVAWLGgIUyQbUiIiL9QZvrBqkwNeWk28qBkHsDDHHypI8
	OMppikaDi/yR/2cy7NzO+sd67dQSMB6EltGKnfgGSjGpGMPo1W7lCYAzrXNLGH/ILnIleLvmOPe
	ZeLgS+jAAgPA7zTu+GkqkZu8wlvQy+3WAP0GiLVFqVaet7IoFKSkf3E1vYNR+A4DAecoK3Ykjkr
	IHxo222ofJGec2miIJepJcaB+tQxyxZzOwD51nztDgytEnuWoolA394HZBaazsA5K+qOIuixIEu
	/HUFYs2Xytd5IevaA9QUpAT4xuDAOFPl+h8x7ZxOhq9rtnqCg0GeKu7nA9RKexQAJ9HgnKz1K05
	XMLYUMG+BROZAAFOpgrDh18peyjIS+z07c9BfFt01/TVW7jZuszds24832zw==
X-Received: by 2002:a05:600c:b8d:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a0276b40a9mr37351995e9.33.1790938343321;
        Fri, 02 Oct 2026 03:52:23 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 2/7] bpf: Add sleepable argument to bpf_alloc_pages()
Date: Fri,  2 Oct 2026 10:52:13 +0000
Message-ID: <20261002105218.6171-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
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


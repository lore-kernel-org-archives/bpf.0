Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30B4E8E1E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368787; cv=none; b=eH8mifDrirwBnimQ9v/50BPd6cf57Qq9jHb1habjaznpPJjiwLvQP5cvuwdLMK9ngz4inYbmVlr3mxoQ1j2nhWlr6kj7xwhQatDvSmc/mL7PQ6b3N/YxtZKS5RXce8F5JLtxihGacAMTvu7Qkdp0o61EBXe4uizaVL6TZ4p9K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368787; c=relaxed/simple;
	bh=DWC2T8Y94nfA0W+VqCFP1OI2BqT71bBKqvV9dn79Sp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4NVRQb9gRIYcMVOuRhC5igxTRHQS0rImi9/48aar5k8VE9LdZT4BgTtcifUWKhbW2Im7Y58VIz9vbcknGnsrK2ibgzoC3KGprHU6UTw/9Lbr/g2uwKZhw73a0XHuOqsD1uzG43a0gtJ5kkmCloei4tH6o3xiYP6GNSsT5epl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CDf53puO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CDf53puO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so741886a91.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368786; x=1790973586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7OmEAOFZwPq6seI/lYcduTsPBVcMiX5acoTW7XQ81M=;
        b=CDf53puO7QKEQzgeJPHhHjah6QdUNpUPWzoyGoZ78EZA+a1h0VBvsucb6LsgjaoLV2
         u+PZcJqwm0PtZEVIYwtAC5AnwBQh+HolmTsxfdrZXSQZ+4OTgqDjS3YoXgMiIGwseFof
         8JGB6BCazSaBToZ5wNnb5EyckbEObdbxqQe0SznzjuGNAxP3A+GHMZq8a9XewDTYGAhC
         i20I0t+tU+ut9Hy+PRTJFeAUsZa5t6SOQzSs314fO2bOAbtuMNlSm1Nb9YNo+Oig+l4H
         +05ZpGFW2nmAT1hD541upq27LbueWcIeATVcsYER/QL+5De4CSIQnQJNOBnTuTmx0XJR
         jN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368786; x=1790973586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7OmEAOFZwPq6seI/lYcduTsPBVcMiX5acoTW7XQ81M=;
        b=daD1+ESKGWyuxzaOSNt6Z2FfXwjhk+bniamOPtaobcr+ozjzunA3/PGKwOmnF6NNgh
         5xNoJABed+pVgObgAbRJLXaFMswWamoZcAOLPY1BCmPQJA4P1+TPo9d8Va/5eXH4ihJP
         lCnk3ef4tOSUxzeeJujxGns3H/5uc1LxNV1bRKFtwyc6bX75flZVPIcr4UJY6HZnKG+G
         aUpykJ0sW2cOoejRFOomt8DnOOqWhh086UVwcI/cR2XvLb+ah1lEgDc+BFZBE9WfjWaf
         1qy2YVM6l1EmBEK/Wm1c1Z7xjGATZFDO5aHjU2/uR37dvYi9Qtc1wH86OfMLCwUHQnZ/
         ABPg==
X-Gm-Message-State: AFuF++mfBF0rPiBEQAmEeXBz7OY9RD+eVPiQ+tdFJfIXYlJLf7vWPzd+
	ALDS0ytTl3MxT9LD2sLuGGd5pIdg3JmoAVYYSjAPMWiteLGa11fnNR3wxcWJHxSw21MMyHzorpe
	OJBimweQ=
X-Gm-Gg: AYBFou3zd6KPArRpTYljhlxjeH4YfYqG4HVAeEr+rY6xUh2FSoLXemlkQtFIxehWbSJ
	QF/HtqIU3L3W0miVIMhDWGn08c0P6odpdV0i6VGgEc1D7wSne5NeDrjlfETfACp2TXuIHzrfnJU
	rKTDeU6paHqBlwpnbmku7ewrZ4UwWq9MWetb6mEH2VeyAn4Fa57pT0o2cSo3Ob8nisV8w/BqP91
	qpQ2iPnjTYD1toZ6F/tllxJq33EHEojKEtyfGa18trk4gwD8RGiWK9MexiUl4ANFn44QfS22OIe
	PClYg2OxbpVR4pG8vuVKOpd8Dw4VzS1o3QnQvUJmptk8sOOoQVXyJQpR5w1wYKk6e+XAHfsBVuO
	saTOo+ijQDSkUv98BdAqhxG/JepVAUF4N3qp/OuROHI+08THmx2TPgjLrtPid6B5N2EX3YMX97S
	kgmSNfDldeoYzVybNfHVQR3E6zW5erNHEzvgx3StCnj2YKrnZAGA1lHBc0LToK4Wxu5RqO5nyOe
	r61vNfIwoe02WxHaqqPPiEG1gT93wTEPQ7YqdY3YA==
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c80:f67f with SMTP id 98e67ed59e1d1-3a098983faemr5806297a91.30.1790368785603;
        Fri, 25 Sep 2026 13:39:45 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 2/7] bpf: Add sleepable argument to bpf_alloc_pages()
Date: Fri, 25 Sep 2026 20:39:34 +0000
Message-ID: <20260925203939.4105-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_alloc_pages() currently decides whether it may use the blocking page allocator from the current execution context alone. Let callers further restrict that choice by passing whether their context is sleepable.

Use the blocking allocator only when both the caller and runtime context allow sleeping. Add __GFP_RETRY_MAYFAIL so this path can reclaim without invoking the OOM killer when the allocation is charged to another memcg. Existing non-sleepable callers retain the no-lock allocation behavior.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h  |  4 ++--
 kernel/bpf/arena.c   |  6 +++---
 kernel/bpf/syscall.c | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 52242d88cb51..7df74e47ecb0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2884,9 +2884,9 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
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
index 80cae0979c23..b3b0cd349eef 100644
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


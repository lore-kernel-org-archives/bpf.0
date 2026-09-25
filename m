Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78043495ADB
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379346; cv=none; b=tNIt8cU5bxIstxLuD5+P437aUcotZfuyVfOOvsk/AnOBhXOC8qUFFQhr0JP9yXXUnxdZF5533Mkmj50G+L6C47kUuAeJ+C+4uCjv24WwUpzpp78gshy89FoWN0sr5YWrSNOvara3VKx9Vp2iu470nsvxOEDFIBE6EbFCxEjTpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379346; c=relaxed/simple;
	bh=HFaWg42UaM/VVUzVO9dEtDTQbS8JeaaYQBVv1YSmHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5QRQUf8KIJ68gHN8CTeDf0o+Rkq16xjrcgFV6WB0rcV1p0342UNwGGBrOiFhcmAlHaH8XJwbA5GodbGo56VysEHGErBLNI8jlcnnC3bdBCVG0pkGiAjn0fnoyvXO9aGVzf3BtFYsrD0Q2ERN5pEGGLVdhJIpeiY01xKC3aIjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qJiVAfyS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qJiVAfyS"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1062355a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379344; x=1790984144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFd2a0W5+sX2I+9b1SFzojNRIJ6oYDONHd/edAbj+Ss=;
        b=qJiVAfySgC3cCtoY6kIjSOsVkvrVwt22qJdzgr9Ta3JoRr7SvJhZF7I53OMr93f9k8
         OfZ0hPqo3AQF6Ibja81gFzQn1sJuzUEWwoVR5uJ/QpHpVm87qiRZ9xcVBiubVblMiIxy
         lS+dohzrYozFtyWFXWapCu9BumNDs4dKgPGTd1jHU00Q343+rF2W6BmZk8Vf4sCK5Rm/
         Xyc9oNLjTd7BtGSJSzoKOf2Yrh4katjy+GccUyAPpohGO/V6pi+rD+Q/Hr98wGtQxPCa
         pDfo0H66MFgHxdUdeBHecrJQM7hnV1bpA9EPChQYnigpcn358sF2HxdF2VH7tAnAa9Cg
         wgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379344; x=1790984144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFd2a0W5+sX2I+9b1SFzojNRIJ6oYDONHd/edAbj+Ss=;
        b=Fp5aiSZrPsgq4xK273oPEQUgf8nXgDyYYRd5HwwuO1E4PIAebF8yMtwrMiQhflyE91
         AkLCLn1sM74FwVvpqGOtNttyDLLb6MC+dymXyOjcuwM8AjuQmYwG/uGzX8xUEHF6WmIv
         vxaZ1n6g8ATUmz4RxRUJQOmtgjbzKfe0PVBRNgIk56U0JudpgqbNVvQXGQhae8WzQ9M9
         HlgEey5HnxYQ4O0SnKxhLTN2AK+sNAZjPrhPFMkqNdKHT9j/bnxvVnuBR+1jEbvefu00
         cSrAqdhgp9alQzJELqzlMBNoDRCxrWzMG2bizNkg53hYHzhlHL8Nb44dIGsh2MOeRIg7
         2h5g==
X-Gm-Message-State: AFuF++nGjE4zGo1dq7lDxhddtjDt1/dzBnbrobZfLniechNdlvtJsa24
	cuodk43E34Ryy3hFEEobIezwZGr4JhnUGn7+c2tHScyqB2C16eW9azdoMYn5iLrbufFdWyn9uJq
	gpCUsq0M=
X-Gm-Gg: AYBFou1Rf4NWcz3B+AByrxULaWQx+R9EF2ayiQ5mHm9hZNOyyBqbvIw5PoA2BHC/8mK
	jfvrPTdkUldk4OocHqXwF23aA7RHiPNy6VRcFx5cKeuEFzgfyH+R2xjduThMl+JzwAqINWsBwmk
	Buw/Xzz4go46CG17fIm0wnjwKFOF4rfJ50u3ftIDrXASCeC5Mww1gOp4etT+v6Knorm7HmwWgPD
	QS2inI15wHRG1W3GsutVP7R4JybqjacTcgHiGfNJhFSQcrl9vvYVX5UWMbZ1TBx260hKnIKHZwd
	yPNTAHAcFzMXckkLRH+qBxoRzlM6cbOs9I15Gy/SX1MCroM/CCGhnHCIIIhCegERKZ+VyoyAnJI
	qnjMzTuP8WGX/5s9P6nMCth08gyS8blQc471f5sOhkpBgYDEQq7XBYGqjaQet1O33O88ac8CaDs
	TJnNvzVuTqcawxNKGkqTWteeUR4FMP/t2Ed/hGTv7/tZ5b+Zzcjkx+JqbwxcFQND36NUFgHvuWS
	kkXlTizv71wxsAQfAArdC8+nC7UemoKMZB2xPTkFdoF9bJJCpAn
X-Received: by 2002:a17:90b:3a08:b0:3a0:7d5b:8d56 with SMTP id 98e67ed59e1d1-3a0bb599f07mr2710348a91.28.1790379343706;
        Fri, 25 Sep 2026 16:35:43 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:43 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 2/7] bpf: Add sleepable argument to bpf_alloc_pages()
Date: Fri, 25 Sep 2026 23:35:33 +0000
Message-ID: <20260925233538.5708-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
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


Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E653F0AAC
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651415; cv=none; b=dlfi31QTqQWdE9vFWG3hKQTFck4JU08alXJA6dwwra9TIpB/2SlQK7VVEipUvHPgDKVGqfdYEogbHjcsyP3NGIv3yEuNA7NLFN6LoFj1Hg7nRXuIJWCR4py+CCSD7DpMX1dImUVKd8QZNYihyL404TTrKQlGs4M+SoTfyo0gYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651415; c=relaxed/simple;
	bh=nCIKMze/nePG9edrgFsirG3py5omd/Tnqbe3SwzpmlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY7sKpifAnOVK3/EMMs+wztTYWlbCX7wMwHnI7X8olV31BZBnSFW4zFxC7h/0LxsSXTuihjNy1BV3MO43bqF28f8Ig+FeNnZ2VCVX9oE9bg63bs2+ZixhkeEIjoxfLC6zM4VHIS3T3PuVLhEC2JXkwJqhfOH6ZVyLDkz019FxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sf42y449; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf42y449"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc149372c14so3316794a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651412; x=1788256212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGkExxMyhBiKuGkp4+FT/b5oczqhluEeBce3FhXEQbg=;
        b=sf42y449qxRSJY/PxMS4Pu5UnI6EhxDpFgALuCg5SfMpF80Vnkp29z7NVsM+QX0T0u
         7+WUyKEh7chdyAlacI7WPKfYJ7oGrvRvKz0WdFjnvLTn1W+hemC07WJuftOmhoXORZos
         QcqzAcXHtl7bes0hjxTv8SjCAOAA/Z4tdLJ8jWW04u1Kjlab0TQ9WKh/J9kH5KWtUBhw
         cUMMWbmiGF9b5doYOD2uDuXlCltxGsQnxzoVUaqc+1UJfWq81SBzgycWp81aLV77zs2R
         n+ZJBImOLs456n/eR5TCdFC+5xg/SIVZZs2y6MJ5PEXpVsQWwm7Pzk2NJt1aq2l9QTHg
         B4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651412; x=1788256212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGkExxMyhBiKuGkp4+FT/b5oczqhluEeBce3FhXEQbg=;
        b=O7vXg3/0GrAIacVyeS6Ne3ZuVyiJ1FS6LjqplHJ1tjBB7OYC0McxH4Jev9q1ZQX1Ca
         0z9PEi7levaM1BGyctR2eG/9uWjKOsnynOeBGa4mLxIH8zEbGfYhtxIp78ZAWLB67PoL
         pvjgq3Fj7DYUffp/llnPALi24woslT+kIZsQwZPG0h/lx1hn+S17li7ZlMzT8zfTagwQ
         tMSsrIrvYddHdVJTXmfgZHFP2XaGHL5Rwjn907LLmvTl6/R+6sSSEMKf6dJI8dCvbngN
         peoTivQOt8AGplivEoQup7ek54wQFJSang9aV9qOf4vFV7u0fuLX4Fw3mco2GPmIPEwH
         vXpw==
X-Gm-Message-State: AFuF++mOkEZ6v73ges+e6kjRILxY9VWNfWTCHSRvljqXZGKnzuQ+kz2+
	XxnLtUNYaSrOC23sQ0P/MetU9g2iDnGxLMOIE2HPMGgAOTOOYFOMCAe26YObiCsDDr4=
X-Gm-Gg: AR+sD1167PcdLB4pGakXKcEHDyKl9ew9JNjoDo/zm0W82vm/pDymBMd1VxXXLyuonXT
	3vuf14E0ujrh2z3599DSdTBbqO5J1677+FGWqdJ/r8340xndS31mR56MsyWzTgFy6tcHEe1trU/
	5j9aZYJW9hpZTRvke3ll0eJj/+AizFc7efS578h5fvOQ3nXqDNk5EX4wLF2cv4+3XSDjX3XJP63
	/A83KTR1r1Lcxpf0TXEJuZzjd6TOy/XT33RSPtIEAwI1FSNK0SUb2bFhQHHKGUULsGh8IHdOwF2
	XQ002ZYDBKx65RiEdUNixhq+UNNss93dwGrpPDDT4/kS3G3xW8HpR6ueGEF68f7l2AnlA2fKepR
	SfhxjxoTEFMyTFjxQ1l9z0Tix4j++eZjaCeyYNG9KVOzZd2PzADRVmd3eNGlTuAJCCNbJNgCN+l
	ybBK6rkwnqEXdu7oyNvfGcKpd/uxhzkt9tceNBgYJ2WrBo70wT5PaX+214hADIem24WR8bIf/Vk
	67bmd2LiE9KXDiypCltniQHAmHwz4/NG18=
X-Received: by 2002:a05:6a20:ce4f:b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cd90fbd2admr11259855637.3.1787651412251;
        Tue, 25 Aug 2026 02:50:12 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32827662702sm5923062eec.10.2026.08.25.02.50.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:50:11 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next v6 2/4] bpf: arena: allocate the fault-in page outside the lock
Date: Tue, 25 Aug 2026 15:19:53 +0530
Message-ID: <20260825094955.83240-3-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

arena_vm_fault() allocated the page while holding arena->spinlock, so it
could only use the non-blocking allocator. Once the memcg is at
memory.max that allocation just fails, the fault turns into
VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
arena address. Hitting memory.max is routine (e.g. page cache from
reading a big file), so this kills innocent processes.

Rework the fault handler:

- Preallocate the page before taking the lock, like do_anonymous_page()
  does, so it can sleep and go through reclaim and the memcg OOM killer,
  instead of turning a routine memory.max into a fake segfault.

- On allocation failure return VM_FAULT_SIGBUS. The allocation already
  ran reclaim and the OOM killer, so the failure is non-recoverable. For
  a task faulting its own arena this changes nothing: the OOM killer
  already picked it inside the allocation and it dies by SIGKILL, the
  SIGBUS is shadowed by the pending fatal signal, and the memcg OOM is
  still reported. VM_FAULT_OOM would instead be retried by the fault
  path and can livelock when the charged memcg is not the faulting
  task's (e.g. a shared arena) and its OOM killer cannot reach it.

- A lockless probe skips that preallocation when a page is already mapped
  (e.g. allocated by the bpf program), so the common case wastes no
  allocation. The rare race where such a page is freed before we take the
  lock falls back to the non-blocking allocator under the lock.

- Return VM_FAULT_SIGBUS for the other non-recoverable errors (lock
  failure, range-tree and page-table failures) instead of
  VM_FAULT_SIGSEGV; only BPF_F_SEGV_ON_FAULT, and a scratch-page hole
  under that flag, is a real user addressing error and keeps
  VM_FAULT_SIGSEGV.

- Tidy up the error labels.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 kernel/bpf/arena.c | 90 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b..fa462a0ff1 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct page *page;
+	struct page *page, *new_page = NULL;
+	vm_fault_t fault_ret;
 	long kbase, kaddr;
 	unsigned long flags;
 	int ret;
@@ -489,59 +490,106 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+	page = vmalloc_to_page((void *)kaddr);
+	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
+		/*
+		 * Preallocate outside the lock with a sleepable allocator so it
+		 * can reclaim and run the memcg OOM killer, which the
+		 * non-blocking allocator under arena->spinlock cannot. A NULL
+		 * return is non-recoverable, so fail with VM_FAULT_SIGBUS;
+		 * VM_FAULT_OOM would be retried by the fault path and can
+		 * livelock when the charged memcg is not the faulting task's.
+		 */
+		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+		new_page = bpf_map_alloc_page_sleepable(map);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		if (!new_page)
+			return VM_FAULT_SIGBUS;
+	}
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		/*
 		 * A failed lock means a possible deadlock was detected. Don't
 		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
 		 * the fault path would re-take it on retry and deadlock. Fail.
 		 */
+		if (new_page)
+			free_pages_nolock(new_page, 0);
 		return VM_FAULT_SIGBUS;
+	}
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
-		if (page == arena->scratch_page)
-			/* BPF triggered scratch here; don't lazy-alloc over it */
-			goto out_sigsegv;
+		if (page == arena->scratch_page) {
+			/*
+			 * A scratch page marks a hole. Segfault only if the user
+			 * asked for it; otherwise we could lazy-allocate but
+			 * choose not to over a hole, so report a bus error.
+			 */
+			fault_ret = (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) ?
+				    VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
+			goto out_err_locked;
+		}
 		/* already have a page vmap-ed */
 		goto out;
 	}
 
+	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
+		/* User space requested to segfault when page is not allocated by bpf prog */
+		fault_ret = VM_FAULT_SIGSEGV;
+		goto out_err_locked;
+	}
+
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
-		/* User space requested to segfault when page is not allocated by bpf prog */
-		goto out_sigsegv_memcg;
+	if (!new_page) {
+		/*
+		 * Very rare race: the bpf program had allocated a page here, so
+		 * the lockless probe saw it and we skipped preallocation, but it
+		 * freed the page before we took the lock. Now we do need one;
+		 * sleeping is not allowed here, so fall back to the non-blocking
+		 * allocator and give up if it fails.
+		 */
+		ret = bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);
+		if (ret) {
+			fault_ret = VM_FAULT_SIGBUS;
+			goto out_err_locked_memcg;
+		}
+	}
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
-	if (ret)
-		goto out_sigsegv_memcg;
-
-	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
-	/* Account into memcg of the process that created bpf_arena */
-	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked_memcg;
 	}
+	struct apply_range_data data = { .arena = arena, .pages = &new_page, .i = 0 };
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		free_pages_nolock(page, 0);
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked_memcg;
 	}
 	flush_vmap_cache(kaddr, PAGE_SIZE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+	/* new_page was consumed */
+	page = new_page;
+	new_page = NULL;
 out:
 	page_ref_add(page, 1);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	if (new_page)
+		free_pages_nolock(new_page, 0);
 	vmf->page = page;
 	return 0;
-out_sigsegv_memcg:
+
+out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-out_sigsegv:
+out_err_locked:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	return VM_FAULT_SIGSEGV;
+	if (new_page)
+		free_pages_nolock(new_page, 0);
+	return fault_ret;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
-- 
2.54.0 (Apple Git-157)


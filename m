Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248350;
	b=LokaHwF6ZziK7QMs3gVSh5aeXVXslnw5vJ2tIyP1QTbAt5F6KVt0ZVBpIjMVViQueFZv
	 htxBVnWhKyEEi4T08MP6lAUSqCGEX3/ixtO0+7zt5ZLMlL21DhQkjUH/Cbb/e/sPJJ+fa
	 xcivBM6uOnwzWJhzHiUKbQBYMv+cSv7zGUEuTchx0RJQ8CXox+BUomoMtdPgD9AWQBDlN
	 Nd28hBHwXoLuXKRwEetnSygbuB7bgJPirZnyL+r1sC+014KR1QpYKPUBjc0QogwBK6VNB
	 Bm7bppv0E/LeSfgNqzC254KM4BpaxevuMsDxUc/ZHCK9fF8VA6wXOFE5ptqqcjpSHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SnSwQ1QUgZ8QL9dm1VJuCXQJU4bCrQkn8yQZFgj6/qw=;
	b=N00BfGMn1rBLq3Xk9lIJ2gFoSegUs520qQSesBsJeDa5rr89jLy+XlWdXUYE94gZQpb0
	 diEs90+DsbvJhHNhE+UB1i2FhpQFLzrS974gY/6vDN2EomT6Q/UifljA3dzNLgohyGK4H
	 J/Emf1OeGUaasSa/CVRg3Y3f7l51pX7bh725CjO6R4YZBVpxrjUsEkphMibPbd8B+saqq
	 p6bq5jLlxljebguqGGIs7z+eleCHwYshd0u/QKI8kG0wYsKuRQapAMNttDFfAcZKRywtF
	 ejXyG1ctpqLci90tBk9vTX7LuXiQxp/ypJeNPfJJjwyWsXidWhCg/rtxNue//WkpttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=lQBEhLYq;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C6606A331
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694C6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=lQBEhLYq
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso609719a91.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248350; x=1794853150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnSwQ1QUgZ8QL9dm1VJuCXQJU4bCrQkn8yQZFgj6/qw=;
        b=lQBEhLYqVshCV2mkNhrVIB1mLDDv/cSLvOVI5bMqL8acG/kVymDN1iEJuYwCDgCz+F
         J+k1sXsC9ZPbJQXydKmEa1W0F4WzLHcIuLjMYfHNBF1NC1Q4Xspbw6bkRxnPuGIZW9FM
         cp86N9KgNyRy7mSUxJGHA3p0cffzFccV7H//+N6FPbotMPY99fExQham1cWANEEQfRhX
         Fvi4kfDoUlLQwDHND1b+naVKQp6KRWzVTGdr4jIbLhgjSpFIloPBNwn1zGUBiVQxpGe9
         DtG99QfJdLeaXSW2ZHMw9RJhCgt/nQId46Er6+ADNZ8Dxzw0i+sVS9apoDk093HOzjCH
         bgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248350; x=1794853150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnSwQ1QUgZ8QL9dm1VJuCXQJU4bCrQkn8yQZFgj6/qw=;
        b=jz+FKprItSLnkianGyWyB3xzrHVej8umx1QoSN2+xmSv2rMccR2f8qwVKNJffm80zW
         BLmjYM7oF/njBIYJmAycxla6Z/2G1FaTorMrqwpFYRBMCYxcD717RLTTVVou82wRgYDh
         OKYEC8xMXeFgjFSaYACLugmCHZqzY0Ju7YyilUFNBXasgw/lIyHujlS1gCDdWmgHbfjb
         wOVG7y+C1Bgav1GWoGs4Ps+NX4DIcbV1oy22lEXVuyQIg+yn5t8hb0/PmxibcJgHVhYA
         xooyZ6+3n/nuZVlNyw0KdRpUrihtUf8lqbytTljvtvuvsnQWHo/1D89KDho+URiLVJqF
         ActQ==
X-Gm-Message-State: APuU4Z+i5TpCQ0PBOgI6AdYztBF1o44YMAbSuLbW0VLuhY/rDsmQjIgR
	TrPt16CPRFrm8e82xgcgPJahPLhQJisM5Rj5XUQ2qwFkfx9OsV/2Au7kDdcXsuR7w+oKrMEhUur
	QZJO8D4A=
X-Gm-Gg: AYBFou3UPphxXwDOaCvyGlgsT4eAIdMtRSvx8e/CFPiRTTnrBtnbci0kLLJZnoJSqwC
	NOZltWBUiXYU6q4DRIXcKEzqEQ865S/hhweY5rJCiVIjfJz4qZb/olKmZY+ErYX25YjSOM0JWHy
	TeOJ+jLEkBjOlpw5zTHasIYpwFrjqC1c6usZ3kgM0fa2YSbDZUjTzj5KFA5sDi2hDK7gpsJp1F6
	IhSqNPEY3y+5FXfW8nTCDl6PHK2ZV4jR3PKz1CdaayN7a0qXmCcLlQNrjm2AM4BmvM7Vtg6i6uE
	LUFEItMGh+L8797sTbSc1tCKQZljl5LnThp5SHEXk6KlaRUXgci8dagRiPj+U6FFiaV6u7NinaH
	SCOBjV3JmMKccD1hktr5KdBzPt0cWGiA5h+9Y3Jon1PM+W1zlOgylp5nmyUZafb20tfK8odz5qK
	qjUzOHNW0UGMpnhLrn+Hxor8RJTlpWF05G5T4BE4eitY1M/E21QNsIYDbcdA0ikQ4qkwENRAjga
	EuD6oBJ7YHt2FLZuhYLmnh6S5AxjsFmQCkyekrr8IMHhyHb73ufrPgvukRIeztlKzsBXTC3M7Gs
	0Thfp3CipB0VrWUcLNXZgYRdhhOvaJU7GoIapmJMQ3b3OMpbTkIY2Z99XGczWbcLrjcfpODdTou
	VJdND/vPYPCruYaXi7uTAKei5zCU=
X-Received: by 2002:a17:90b:2e49:b0:3ae:8106:6074 with SMTP id 98e67ed59e1d1-3b166c92193mr444506a91.16.1794248349754;
        Mon, 09 Nov 2026 10:19:09 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b937sm481075a91.4.2026.11.09.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:19:09 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <htejun@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: recover page faults across all arenas
Date: Mon,  9 Nov 2026 18:19:05 +0000
Message-ID: <20261109181906.7350-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109181906.7350-1-emil@etsalapatis.com>
References: <20261109181906.7350-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current arena fault handling code accounts for
misbehaving BPF programs that free arena memory
while it is being accessed by a kfunc as part of
another BPF program's execution. This scenario
triggers a kernel page fault that is intercepted
by BPF arena-specific code. The code confirms
that the fault is within the BPF program's arena,
installs a scratch page, and marks the fault as
handled. This is necessary to prevent BPF programs
from being able to trigger an oops.

However, the protection against misbehaving BPF programs
is currently incomplete: Arena memory is accessed by
kernel code not just as part of a kfunc, but also from
non-BPF paths. This is the case with sched-ext that
includes non-BPF code paths that access arena pointers.
These paths do not have an arena associated with them,
and a fault there causes an oops. Such a fault can be
triggered by a misbehaving BPF program by unmapping the
pages nominally owned by the genpool allocator used for
cid management.

Extend the kernel arena fault handling to consider all
arenas in the system. The handler now scans a global
arena tree till it finds an arena that includes the address,
and fixes up the address. Retain the stream-based reporting
code for when the faulting call stack includes the BPF
program that owns the arena.

Fixes: abdc2516f100 ("sched_ext: Convert ops.set_cmask() to arena-resident cmask")
Cc: Tejun Heo <htejun@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 119 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 366c4c2b6a41..aff231922e11 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -11,6 +11,9 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+#include <linux/rbtree_latch.h>
 #include <asm/tlbflush.h>
 #include "range_tree.h"
 
@@ -47,10 +50,15 @@
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
+static struct latch_tree_root arena_tree;
+static DEFINE_SPINLOCK(arena_tree_lock);
+
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
 
 struct bpf_arena {
 	struct bpf_map map;
+	struct latch_tree_node tnode;
+	struct rcu_work destroy_work;
 	u64 user_vm_start;
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
@@ -142,6 +150,33 @@ struct bpf_map *bpf_prog_arena(struct bpf_prog *prog)
 	return arena ? &arena->map : NULL;
 }
 
+static __always_inline bool arena_tree_less(struct latch_tree_node *a,
+					   struct latch_tree_node *b)
+{
+	struct bpf_arena *arena_a = container_of(a, struct bpf_arena, tnode);
+	struct bpf_arena *arena_b = container_of(b, struct bpf_arena, tnode);
+
+	return bpf_arena_get_kern_vm_start(arena_a) < bpf_arena_get_kern_vm_start(arena_b);
+}
+
+static __always_inline int arena_tree_comp(void *key, struct latch_tree_node *node)
+{
+	struct bpf_arena *arena = container_of(node, struct bpf_arena, tnode);
+	unsigned long kbase = bpf_arena_get_kern_vm_start(arena);
+	unsigned long addr = (unsigned long)key;
+
+	if (addr < kbase)
+		return -1;
+	if (addr >= kbase + SZ_4G + GUARD_SZ / 2)
+		return 1;
+	return 0;
+}
+
+static const struct latch_tree_ops arena_tree_ops = {
+	.less = arena_tree_less,
+	.comp = arena_tree_comp,
+};
+
 static long arena_map_peek_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
@@ -360,6 +395,10 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	if (err)
 		goto err_destroy_rt;
 
+	spin_lock(&arena_tree_lock);
+	latch_tree_insert(&arena->tnode, &arena_tree, &arena_tree_ops);
+	spin_unlock(&arena_tree_lock);
+
 	return &arena->map;
 
 err_destroy_rt:
@@ -400,6 +439,26 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 	return 0;
 }
 
+static void arena_map_destroy(struct work_struct *work)
+{
+	struct bpf_arena *arena = container_of(to_rcu_work(work), struct bpf_arena,
+					     destroy_work);
+
+	/*
+	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
+	 * It unmaps everything from vmalloc area and clears pgtables.
+	 * Call apply_to_existing_page_range() first to find populated ptes and
+	 * free those pages.
+	 */
+	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
+				     SZ_4G + GUARD_SZ / 2, existing_page_cb, arena);
+	free_vm_area(arena->kern_vm);
+	range_tree_destroy(&arena->rt);
+	__free_page(arena->scratch_page);
+	free_percpu(arena->stacks);
+	bpf_map_area_free(arena);
+}
+
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
@@ -413,23 +472,16 @@ static void arena_map_free(struct bpf_map *map)
 	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
 		return;
 
+	spin_lock(&arena_tree_lock);
+	latch_tree_erase(&arena->tnode, &arena_tree, &arena_tree_ops);
+	spin_unlock(&arena_tree_lock);
+
 	/* Ensure no pending deferred frees */
 	irq_work_sync(&arena->free_irq);
 	flush_work(&arena->free_work);
 
-	/*
-	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
-	 * It unmaps everything from vmalloc area and clears pgtables.
-	 * Call apply_to_existing_page_range() first to find populated ptes and
-	 * free those pages.
-	 */
-	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
-				     SZ_4G + GUARD_SZ / 2, existing_page_cb, arena);
-	free_vm_area(arena->kern_vm);
-	range_tree_destroy(&arena->rt);
-	__free_page(arena->scratch_page);
-	free_percpu(arena->stacks);
-	bpf_map_area_free(arena);
+	INIT_RCU_WORK(&arena->destroy_work, arena_map_destroy);
+	queue_rcu_work(system_dfl_wq, &arena->destroy_work);
 }
 
 static void *arena_map_lookup_elem(struct bpf_map *map, void *key)
@@ -1357,35 +1409,46 @@ static void __bpf_prog_report_arena_violation(struct bpf_prog *prog, bool write,
 
 bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsigned long fault_ip)
 {
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				     DEFAULT_RATELIMIT_BURST);
+	struct latch_tree_node *node;
 	struct bpf_arena *arena;
 	struct bpf_prog *prog;
 	unsigned long kbase;
 	unsigned long page_addr = addr & PAGE_MASK;
-
-	prog = bpf_prog_find_from_stack();
-	if (!prog)
-		return false;
-
-	arena = prog->aux->arena;
-	/* a prog not using arena may be on stack, so arena can be NULL */
-	if (!arena)
-		return false;
-
-	kbase = bpf_arena_get_kern_vm_start(arena);
+	bool handled = false;
 
 	/*
 	 * Recovery covers the 4 GiB mappable band plus the upper half-guard.
 	 * Lower guard is unreachable from kfuncs; an address there indicates
 	 * a different bug class - leave it to the regular kernel oops path.
 	 */
-	if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
-		return false;
+	rcu_read_lock();
+	prog = bpf_prog_find_from_stack();
+	arena = prog ? prog->aux->arena : NULL;
+	if (!arena || arena_tree_comp((void *)page_addr, &arena->tnode)) {
+		node = latch_tree_find((void *)page_addr, &arena_tree, &arena_tree_ops);
+		if (!node)
+			goto out;
+		arena = container_of(node, struct bpf_arena, tnode);
+	}
+	kbase = bpf_arena_get_kern_vm_start(arena);
 
 	apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
 			    apply_range_set_scratch_cb, arena->scratch_page);
 	flush_vmap_cache(page_addr, PAGE_SIZE);
-	__bpf_prog_report_arena_violation(prog, is_write, page_addr - kbase, fault_ip);
-	return true;
+
+	if (prog && prog->aux->arena == arena)
+		__bpf_prog_report_arena_violation(prog, is_write,
+						  page_addr - kbase, fault_ip);
+	else if (__ratelimit(&rs))
+		printk_deferred(KERN_ERR "BPF arena %u: %s fault at offset 0x%lx, IP %pS\n",
+				arena->map.id, is_write ? "WRITE" : "READ",
+				page_addr - kbase, (void *)fault_ip);
+	handled = true;
+out:
+	rcu_read_unlock();
+	return handled;
 }
 
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip)
-- 
2.52.0


Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8343DED1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109708; cv=none; b=UxMPRasNe2eaE1wK+GJscatAYoqkiW6rsBUlvVg9rlUkB0xdY2SolhAVVpZB8XMPtLolnUU8Z7XWDoYjMznKoQi3yICJV/JffRdpi8GOQ8JdqQzS7s7lmSAgZi5R7GOoZ+TKgxyKo/9fMu2AxaHu1RwRlCpJoPRLcXE7PW5WwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109708; c=relaxed/simple;
	bh=HqR7s3vQLZ9vK/aXfNwyAY3Ue8dGuUVfLEDhbAmwzno=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vd+4U1zQoSQqCnXKzBUSivFsDJZdrp5R9537wsmoUlZZKkkipgbTCrGr2me/3F3O4pWWnrsKc61FfXIg5EpNX9Ky4PEzo0WS3jAMGuz2b3AYqbSM8nFo3NjwmSIqY7Igy0xkR5BwJdsoWdVOzznn6GiTsOgozwMZjBpzPtulaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hh4yd4SwvzYQtgS
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:54:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D2A3740577
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:54:57 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBXhgG+paNqcC8vBg--.11483S2;
	Fri, 11 Sep 2026 14:54:57 +0800 (CST)
Subject: Re: bpf: BPF_MAP_UPDATE_BATCH into a fresh NO_PREALLOC LPM trie /
 hash map returns -ENOMEM at element 2 on AWS Graviton5 (bpf_mem_alloc refill
 IPI races the syscall)
To: musthaq ahamed <amusthaq56@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com
References: <CADxQDVrOwfhz8B_ijEzTqFj7CG7TLQacALd1Odv2Tyc3x21Z-g@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1ccc1901-f171-e44b-835f-1e9482956183@huaweicloud.com>
Date: Fri, 11 Sep 2026 14:54:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADxQDVrOwfhz8B_ijEzTqFj7CG7TLQacALd1Odv2Tyc3x21Z-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXhgG+paNqcC8vBg--.11483S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ur4DXr4kuw18JFWrJFW5ZFb_yoW8WryrKo
	Wfur48CF4rKry7KrykC34DJrW3WF1kGw1DJr4xKry3JFyrXry5t34UGryak3y3XF18Kr48
	Jr18J34ruFWkJFyrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 9/8/2026 6:59 PM, musthaq ahamed wrote:
> Hi,
>
> Bug report with a reproducer and an untested RFC patch. Amazon Linux
> asked me to raise it here
> (https://github.com/amazonlinux/amazon-linux-2023/issues/1129).
>
> Symptom
> -------
> On AWS EC2 generation-9 instances (Graviton5, Neoverse-V3: m9g, m9gd,
> c9g) running Amazon Linux 2023 kernel 6.18.41 (arm64, PREEMPT_NONE,
> HZ=100), a single bpf(BPF_MAP_UPDATE_BATCH) of 7 elements into a freshly
> created BPF_MAP_TYPE_LPM_TRIE (key_size 260, value_size 8, max_entries
> 128, BPF_F_NO_PREALLOC) returns -1/ENOMEM with batch.count written back
> as 1. The node has >100 GB free, memcg limits are unset, nothing in
> dmesg. It fails on 99-100 % of attempts on every CPU of every such
> instance we launched (8 instances, spot and on-demand, 3 AZs), and one
> host in ~8 fails only on a subset of CPUs.
>
> The same call passes 100 % on Graviton3/4 (m7g, m8g, c7g, c8g) with the
> same kernel image, and 100 % on Graviton5 with kernel 6.12.100. A
> BPF_MAP_TYPE_HASH with the same key/value/flags fails identically on
> Graviton5 on BOTH 6.18.41 and 6.12.100 and passes on Graviton3. Seven
> single BPF_MAP_UPDATE_ELEM calls, a batch of 1, or elements <= 256 bytes
> never fail.
>
> Analysis
> --------
> kernel/bpf/memalloc.c: for unit_size > 256 prefill_mem_cache() seeds ONE
> object per CPU; the per-CPU free list is refilled only from
> bpf_mem_refill() in an irq_work raised through a self-IPI when
> unit_alloc() sees the list below its low watermark. unit_alloc() has no
> fallback: an empty list returns NULL and trie_update_elem() /
> alloc_htab_elem() return -ENOMEM. generic_map_update_batch() stops at the
> first error and writes back the count.
>
> Since 3d8dc43eb2a3 ("bpf: Switch to bpf mem allocator for LPM trie") the
> trie leaf (296 bytes for a 260-byte key) comes from this allocator.
> Element 1 of the batch consumes the prefilled object and raises the
> IPI; element 2 runs a few hundred ns later in the same syscall.
>
> bpftrace on the failing hosts: arch_irq_work_raise() takes ~170 ns on
> Graviton5 and the IRQ-work interrupt lands ~715 ns after the raise,
> after element 2 has already failed; bpf_mem_refill() then runs exactly
> once per failed batch. On Graviton3 the same raise takes ~1.5 us (the
> SGI write exits to the hypervisor) and the interrupt is pending when
> the guest resumes, so the refill runs inside element 1's
> local_irq_restore() and element 2 succeeds. IRQ-work IPI counters
> advance on both, so no IPI is lost; the refill is late, not missing.

Thanks for the analysis. To summarize the problem: on Graviton5 the
raise of irq_worker is fast, but the running of irq worker is slow due
to async IPI. Do you know why is the IPI asynchronous ? Will it be fixed
?  The similar refill problem also exists for PREEMPT_RT, because the
irq_work is running in a per-cpu kthread. In my understanding, bpf mem
will be replaced by kmalloc no_lock variants and the problem will be
solved eventually although I don't know the exact time.
> Interrupts are enabled for almost the whole path between the two
> inserts (bpf_map_update_value() uses migrate_disable(), not IRQ-off), so
> this is a latency race the batch loses on a platform with a cheap
> asynchronous self-IPI. Kernel 6.12 is immune for LPM tries only because
> its trie still uses bpf_map_kmalloc_node() directly; NO_PREALLOC hash
> maps have taken >256-byte elements from bpf_mem_alloc since 6.1 and
> fail there too.
>
> I believe this is the same class as the Feb-2025 thread "bpf: Add a
> retry after refilling the free list when unit_alloc() fails".
>
> Reproducer
> ----------
> Raw bpf(2) via Python ctypes, fresh map per iteration, one CPU pinned
> per loop; inline in the GitHub issue above. Results (100 iterations x
> 32 CPUs):
>
>   variant                                  m9gd 6.18.41  m7g 6.18.41
> m9gd 6.12.100
>   LPM key260 batch x7                      3192/3200     0/3200       0/3200
>   HASH key260 NO_PREALLOC batch x7         3117/3200     0/3200       3183/3200
>   LPM 7 x UPDATE_ELEM                      0/3200        0/3200       0/3200
>   LPM batch x1                             0/3200        0/3200       0/3200
>   HASH key8 batch x7                       0/3200        0/3200       0/3200
>
> RFC patch (untested)
> --------------------
> Attached to the GitHub issue: on the bpf(2) syscall path,
> bpf_map_update_value() pushes a run context so map implementations can
> recognise "syscall, no program running"; trie_update_elem() and
> htab_map_update_elem() then call a new bpf_mem_cache_reserve(ma, cnt)
> BEFORE taking the map lock, which tops up this CPU's free list with
> GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT objects charged to the map's
> memcg (the same allocation the irq_work refill does). Nothing changes
> for BPF programs and nothing allocates under trie->lock or a bucket
> lock. I have not built or booted it; I am reporting rather than
> submitting. Happy to test a fix on the affected hardware.

Have checked the patch in github link and paste it below:

> >From 99356e7bc9b90770fb0eeb1d216a47aa71f029fa Mon Sep 17 00:00:00 2001
> From: Musthaq Ahamed <redacted>
> Date: Mon, 7 Sep 2026 18:15:34 +0530
> Subject: [PATCH 1/2] bpf: Refill bpf_mem_alloc synchronously for map updates
>  from syscall
>
> A BPF_MAP_UPDATE_BATCH of 7 elements into a fresh BPF_F_NO_PREALLOC LPM
> trie (key_size 260, value_size 8, max_entries 128) fails with -ENOMEM at
> the second element on AWS Graviton5 instances, with more than 100 GB of
> memory free:
>
>   bpf(BPF_MAP_UPDATE_BATCH, {batch={keys=..., values=..., count=7,
>       map_fd=3, elem_flags=BPF_ANY}}, 56) = -1 ENOMEM
>   batch.count written back = 1, one element in the map
>
>
> +
> +/* True while the current task updates a map on behalf of the bpf(2)
> syscall
> + * and no BPF program is running: task context, and the innermost run
> context
> + * is the one pushed by bpf_map_update_value(). A program nested inside the
> + * syscall (fentry, raw tracepoint) pushes its own run context, and
> interrupt
> + * or NMI context fails in_task().
> + */
> +static inline bool bpf_map_update_from_syscall(void)
> +{
> +    return in_task() && current->bpf_ctx == &bpf_map_update_run_ctx;
> +}
> +
SNIP
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 7f8e029..014f72e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1134,6 +1134,9 @@ static long htab_map_update_elem(struct bpf_map
> *map, void *key, void *value,
>           */
>      }
>  
> +    if (!htab_is_prealloc(htab) && bpf_map_update_from_syscall())
> +        bpf_mem_cache_reserve(&htab->ma, 1);
> +
>      ret = htab_lock_bucket(b, &flags);
>      if (ret)
>          return ret;
> @@ -1287,6 +1290,12 @@ static long htab_map_update_elem_in_place(struct
> bpf_map *map, void *key,
>      b = __select_bucket(htab, hash);
>      head = &b->head;
>  
> +    if (!htab_is_prealloc(htab) && bpf_map_update_from_syscall()) {
> +        bpf_mem_cache_reserve(&htab->ma, 1);
> +        if (percpu)
> +            bpf_mem_cache_reserve(&htab->pcpu_ma, 1);
> +    }
> +
>      ret = htab_lock_bucket(b, &flags);
>      if (ret)
>          return ret;
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index b051806..fdd5b08 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -338,6 +338,10 @@ static long trie_update_elem(struct bpf_map *map,
>      if (key->prefixlen > trie->max_prefixlen)
>          return -EINVAL;
>  
> +    /* The update may need a leaf and an intermediate node */
> +    if (bpf_map_update_from_syscall())
> +        bpf_mem_cache_reserve(&trie->ma, 2);
> +

You ensure __alloc() is invoked under syscall to prevent the possible
dead-lock caused by locks in mm subsystem, but it only handles the
syscall path. Why if the bpf update helper is invoked from a bpf program ?

How about invoking irq_work_sync() when an irq_work has been queued ? so
when unit_alloc returns the refill must have been done.

﻿From 179bf9721f26842630ed9ef5a38c914b0dde79ca Mon Sep 17 00:00:00 2001
From: Hou Tao <houtao1@huawei.com>
Date: Fri, 11 Sep 2026 14:47:40 +0800
Subject: [PATCH] bpf: Wait for asynchrous IPI

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bc9b4b3d9c3a..44cc8ec0a338 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -446,9 +446,20 @@ static void bpf_mem_refill(struct irq_work *work)
     check_free_by_rcu(c);
 }
 
-static void notrace irq_work_raise(struct bpf_mem_cache *c)
+static bool notrace irq_work_raise(struct bpf_mem_cache *c)
 {
-    irq_work_queue(&c->refill_work);
+    return irq_work_queue(&c->refill_work);
+}
+
+static void notrace irq_work_wait(struct bpf_mem_cache *c)
+{
+    /* FIXME: the wait might sleep */
+    if (IS_ENABLED(CONFIG_PREEMPT_RT) || !arch_irq_work_has_interrupt())
+        return;
+
+    /* Wait for asynchronous IPI if any */
+    while (irq_work_is_busy(&c->refill_work))
+        cpu_relax();
 }
 
 /* For typical bpf map case that uses bpf_mem_cache_alloc and single bucket
@@ -795,6 +806,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 {
     struct llist_node *llnode = NULL;
     unsigned long flags;
+    bool wait = false;
     int cnt = 0;
 
     /* Disable irqs to prevent the following race for majority of prog
types:
@@ -820,13 +832,17 @@ static void notrace *unit_alloc(struct
bpf_mem_cache *c)
     WARN_ON(cnt < 0);
 
     if (cnt < c->low_watermark)
-        irq_work_raise(c);
+        wait = irq_work_raise(c);
+
     /* Enable IRQ after the enqueue of irq work completes, so irq work
      * will run after IRQ is enabled and free_llist may be refilled by
      * irq work before other task preempts current task.
      */
     local_irq_restore(flags);
 
+    if (wait)
+        irq_work_wait(c);
+
     return llnode;
 }
 
@@ -838,6 +854,7 @@ static void notrace unit_free(struct bpf_mem_cache
*c, void *ptr)
 {
     struct llist_node *llnode = ptr - LLIST_NODE_SZ;
     unsigned long flags;
+    bool wait = false;
     int cnt = 0;
 
     BUILD_BUG_ON(LLIST_NODE_SZ > 8);
@@ -865,19 +882,23 @@ static void notrace unit_free(struct bpf_mem_cache
*c, void *ptr)
 
     if (cnt > c->high_watermark)
         /* free few objects from current cpu into global kmalloc pool */
-        irq_work_raise(c);
+        wait = irq_work_raise(c);
     /* Enable IRQ after irq_work_raise() completes, otherwise when current
      * task is preempted by task which does unit_alloc(), unit_alloc() may
      * return NULL unexpectedly because irq work is already pending but can
      * not been triggered and free_llist can not be refilled timely.
      */
     local_irq_restore(flags);
+
+    if (wait)
+        irq_work_wait(c);
 }
 
 static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
 {
     struct llist_node *llnode = ptr - LLIST_NODE_SZ;
     unsigned long flags;
+    bool wait = false;
 
     c->tgt = *(struct bpf_mem_cache **)llnode;
 
@@ -891,8 +912,11 @@ static void notrace unit_free_rcu(struct
bpf_mem_cache *c, void *ptr)
     local_dec(&c->active);
 
     if (!atomic_read(&c->call_rcu_in_progress))
-        irq_work_raise(c);
+        wait = irq_work_raise(c);
     local_irq_restore(flags);
+
+    if (wait)
+        irq_work_wait(c);
 }
 
 /* Called from BPF program or from sys_bpf syscall.
-- 
2.29.2


>      /* Allocate and fill a new node */
>      new_node = lpm_trie_node_alloc(trie, value);
>      if (!new_node)
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index bd45dda..8e48c9a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -1005,6 +1005,45 @@ void notrace *bpf_mem_cache_alloc_flags(struct
> bpf_mem_alloc *ma, gfp_t flags)
>      return !ret ? NULL : ret + LLIST_NODE_SZ;
>  }
>  
> +/* Make sure the free list of this CPU holds at least @cnt objects.
> + *
> + * The refill done by unit_alloc() is an irq_work raised through a self-IPI
> + * and is asynchronous. A batch of map updates from user space can find the
> + * free list still empty at its second element and fail with -ENOMEM.
> + *
> + * Only for the bpf(2) syscall map update path: task context, IRQs enabled,
> + * no map lock held, so a non-sleeping slab allocation is safe.
> + */
> +void bpf_mem_cache_reserve(struct bpf_mem_alloc *ma, int cnt)
> +{
> +    struct bpf_mem_cache *c = this_cpu_ptr(ma->cache);
> +    struct mem_cgroup *memcg, *old_memcg;
> +    void *obj;
> +    int i;
> +
> +    if (WARN_ON_ONCE(!bpf_map_update_from_syscall()))
> +        return;
> +    lockdep_assert_irqs_enabled();
> +
> +    /* Racy read like in bpf_mem_refill(), it doesn't need to be
> accurate */
> +    i = READ_ONCE(c->free_cnt);
> +    if (i >= cnt)
> +        return;
> +
> +    memcg = get_memcg(c);
> +    old_memcg = set_active_memcg(memcg);
> +    for (; i < cnt; i++) {
> +        obj = __alloc(c, NUMA_NO_NODE, GFP_NOWAIT | __GFP_NOWARN |
> __GFP_ACCOUNT);
> +        if (!obj)
> +            break;
> +        /* unit_free() reads the owning cache from the object header */
> +        *(struct bpf_mem_cache **)obj = c;
> +        unit_free(c, obj + LLIST_NODE_SZ);
> +    }
> +    set_active_memcg(old_memcg);
> +    mem_cgroup_put(memcg);
> +}
> +
>  int bpf_mem_alloc_check_size(bool percpu, size_t size)
>  {
>      /* The size of percpu allocation doesn't have LLIST_NODE_SZ overhead */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e92fd2b..c20e5de 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -56,6 +56,8 @@
>  #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
>  
>  DEFINE_PER_CPU(int, bpf_prog_active);
> +/* Marks map updates done on behalf of the syscall, only its address is
> used */
> +struct bpf_run_ctx bpf_map_update_run_ctx;
>  DEFINE_COOKIE(bpf_map_cookie);
>  static DEFINE_IDR(prog_idr);
>  static DEFINE_SPINLOCK(prog_idr_lock);
> @@ -247,6 +249,7 @@ unpin_all:
>  static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>                  void *key, void *value, __u64 flags)
>  {
> +    struct bpf_run_ctx *old_run_ctx;
>      int err;
>  
>      /* Need to create a kthread, thus must support schedule */
> @@ -265,6 +268,7 @@ static int bpf_map_update_value(struct bpf_map *map,
> struct file *map_file,
>      }
>  
>      bpf_disable_instrumentation();
> +    old_run_ctx = bpf_set_run_ctx(&bpf_map_update_run_ctx);
>      if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>          map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>          err = bpf_percpu_hash_update(map, key, value, flags);
> @@ -297,6 +301,7 @@ static int bpf_map_update_value(struct bpf_map *map,
> struct file *map_file,
>                  bpf_obj_unpin_uptrs(map->record, value);
>          }
>      }
> +    bpf_reset_run_ctx(old_run_ctx);
>      bpf_enable_instrumentation();
>  
>      return err;
>
> Real-world impact: an eBPF egress agent for CI runners makes exactly
> this call per pod; on these hosts every pod loses DNS.
>
> Thanks,
> Musthaq Ahamed
> .


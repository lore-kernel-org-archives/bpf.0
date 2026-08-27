Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599393B6BF1;
	Thu, 27 Aug 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819720; cv=none; b=O5CTSa/K6G1oAZBw6Ofiln05fmiQHVWfjopqY8V7Mwwndpw8XB78wSnDwtkIr/CPUn8CDrawytTkf4iKQw1nPQHfG6F854flCbaeCmopqqlLEwMwHHBelrEdhbsNTZku7z7Z/sYvtaBYvHPllM9f7dpc0d3IyNBenfeiwzdGsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819720; c=relaxed/simple;
	bh=itB94wTQlwNYicYIyKZFxxm65o+9Hyfh28OpfKFQB+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aguw793ysCxM5K+3RRRblW/dWeqXiHNoz5h6/CZJnR+6hgTGBKCcoAaTNGNLxlzsdUhT//PG08VLj3htyT3wHAeqVPwt7GAKIqA980kzkupUj96AGviJ8/jFAwYsIh4dJWkAKhbwAPuaCkCCQoOkF4HLNOCnqQEX+oFYj3kFibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hVvvW66F7zKHMqg;
	Thu, 27 Aug 2026 16:34:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C1F464057D;
	Thu, 27 Aug 2026 16:35:13 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCHdUTA9o9q6DNYDw--.35223S2;
	Thu, 27 Aug 2026 16:35:13 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
Date: Thu, 27 Aug 2026 08:40:13 +0000
Message-Id: <20260827084013.1062816-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHdUTA9o9q6DNYDw--.35223S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4fur1rXF1Uur4rury5twb_yoW3XF15pF
	WfGr95JF4rZFWI9a4Iqrs7CwsxZw40qa43JayUur9a9r15Zw1qqFyfAry7uFyY9rWIyFW3
	tryvgryxCr4UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller repeatedly triggered UAF splats related to nodes in
waiting_for_gp_ttrace within the bpf memalloc:

BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
 ...
 llist_del_first+0x85/0x110 lib/llist.c:61
 alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
 bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436

Freed by task 14:
 ...
 __free_rcu kernel/bpf/memalloc.c:281 [inline]
 __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
 rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
 rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
 rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651

Initially, we suspected that alloc_bulk() lacked RCU Tasks Trace
protection when accessing waiting_for_gp_ttrace. However, explicitly
adding rcu_read_lock_trace() did not help.

This is expected because, as noted in commit 57b23c0f612d ("bpf: Retire
rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
(and will continue to imply in the future) a normal RCU GP. Since
alloc_bulk() runs in an RCU read-side CS (!PREEMPT_RT runs in IRQ
context, PREEMPT_RT runs with guard(rcu)), an RCU Tasks Trace GP cannot
complete while alloc_bulk() is accessing the list. Thus, the callback
__free_rcu cannot run concurrently, ruling out missing RCU read-side
locks as the cause. And same for free_by_rcu_ttrace list.

Further investigation revealed that the UAF does not occur before the
RCU Tasks Trace grace period expires, but rather during the execution of
its callback. When the callback invokes llist_del_all to reclaim
waiting_for_gp_ttrace nodes, there is no synchronization protecting
against concurrent alloc_bulk() calls. If alloc_bulk() operates on
waiting_for_gp_ttrace simultaneously, a race condition ensues, as
illustrated below:

CPU0                                           CPU1
                                               __free_rcu (RCU Tasks Trace callback)
alloc_bulk (RCU read-side CS)
  llist_del_first(&c->waiting_for_gp_ttrace)
    entry = smp_load_acquire(&head->first);
    do {
      if (entry == NULL)
        return NULL;
                                               free_all(llist_del_all(&c->waiting_for_gp_ttrace))
                                                 llist_for_each_safe(pos, t, llnode)
                                                   free_one(pos);
      next = READ_ONCE(entry->next); <-- trigger UAF
    } while (!try_cmpxchg(&head->first, &entry, next));

Since alloc_bulk() operates on waiting_for_gp_ttrace under RCU read-side
CS, Fix this by introducing a raw spinlock to synchronize the concurrent
consumption (llist_del_first vs llist_del_all) on waiting_for_gp_ttrace.

Note that free_by_rcu_ttrace does not suffer from this issue as it only
has a single active consumer during normal operation.

Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/memalloc.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..58296e92a4fe 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -119,6 +119,7 @@ struct bpf_mem_cache {
 	struct llist_head waiting_for_gp_ttrace;
 	struct rcu_head rcu_ttrace;
 	atomic_t call_rcu_ttrace_in_progress;
+	raw_spinlock_t lock;
 };
 
 struct bpf_mem_caches {
@@ -207,6 +208,7 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
+	unsigned long flags;
 	gfp_t gfp;
 	void *obj;
 	int i;
@@ -228,12 +230,14 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 	if (i >= cnt)
 		return;
 
+	raw_spin_lock_irqsave(&c->lock, flags);
 	for (; i < cnt; i++) {
-		obj = llist_del_first(&c->waiting_for_gp_ttrace);
+		obj = __llist_del_first(&c->waiting_for_gp_ttrace);
 		if (!obj)
 			break;
 		add_obj_to_free_list(c, obj);
 	}
+	raw_spin_unlock_irqrestore(&c->lock, flags);
 	if (i >= cnt)
 		return;
 
@@ -279,8 +283,14 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
+	struct llist_node *llnode;
+	unsigned long flags;
 
-	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	raw_spin_lock_irqsave(&c->lock, flags);
+	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+
+	free_all(c, llnode, !!c->percpu_size);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
+	unsigned long flags;
 
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
@@ -307,8 +318,10 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	}
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
+	raw_spin_lock_irqsave(&c->lock, flags);
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
-		llist_add(llnode, &c->waiting_for_gp_ttrace);
+		__llist_add(llnode, &c->waiting_for_gp_ttrace);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
 
 	if (unlikely(READ_ONCE(c->draining))) {
 		__free_rcu(&c->rcu_ttrace);
@@ -535,6 +548,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			raw_spin_lock_init(&c->lock);
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -557,7 +571,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
-
+			raw_spin_lock_init(&c->lock);
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -609,7 +623,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 		c->objcg = objcg;
 		c->percpu_size = percpu_size;
 		c->tgt = c;
-
+		raw_spin_lock_init(&c->lock);
 		init_refill_work(c);
 		prefill_mem_cache(c, cpu);
 	}
@@ -620,6 +634,8 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu = !!c->percpu_size;
+	struct llist_node *llnode;
+	unsigned long flags;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -629,7 +645,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
 	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
-	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
+	raw_spin_lock_irqsave(&c->lock, flags);
+	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	free_all(c, llnode, percpu);
 	free_all(c, __llist_del_all(&c->free_llist), percpu);
 	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
 	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);
-- 
2.34.1


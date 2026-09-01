Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F091411FA4;
	Tue,  1 Sep 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274700; cv=none; b=G+Iz4s2VEXm2ZKZq4rSIntowZR0mG0SZ7NoVjmXKcO18UN0E/Yv15lhLIqjgKVWr3C7BRhBOSVf7pLwtkDQZI/btdMtTOxK3O8uZ0zEHZM/3prswd0iDEttGoqJNECugsgbIYKOgtlE9MRj3JubSCYizEmOz7vDv1JCvKVXbtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274700; c=relaxed/simple;
	bh=THbZKuaaAcQ9iUriPTfKOlUNhALwS5Ep7mvPftVX6Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNHHL5UxzzvMJmBCF2lLsLLLLBACXJ5/lt5OQ7Yx0BCdZ5voA4NLZmSr/4YuENteVG2Q+qn/YK8LZcdJ5Zm7ANa/gKSEiKtQ0RIFjU1TlDZcFHvkfrl2sdxXDf0ulQPpwlf8ASVakQIw8Ou5feFwfAuSUqTiij+v6mGjVq+BAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZ88p3F5WzKHMMW;
	Tue,  1 Sep 2026 22:57:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 61B7E4059A;
	Tue,  1 Sep 2026 22:58:03 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgD3a7n655ZqqlR_AQ--.38292S2;
	Tue, 01 Sep 2026 22:58:03 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH bpf v3] bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk
Date: Tue,  1 Sep 2026 15:03:07 +0000
Message-Id: <20260901150307.3474349-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3a7n655ZqqlR_AQ--.38292S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4fur1rXF1Uur4rury5twb_yoWxKF1fpF
	W3Jr98XF45ZF4av3WSqr48Cwsxtr4vq343Jay8uryS9r1Yvwn0gFyfCry3uF9IyrZ7ua43
	tr1qgry8AF4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
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
complete while alloc_bulk() is accessing the list.

Instead, the UAF occurs after the GP expires: when the __free_rcu()
callback runs, there is no synchronization protecting llist_del_all()
against concurrent alloc_bulk() operates on waiting_for_gp_ttrace,
leading to the race condition below:

CPU0                                           CPU1
                                               __free_rcu (RCU Tasks Trace callback)
alloc_bulk
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

In addition, there is also a theoretical race condition on the
free_by_rcu_ttrace list. This race requires two preconditions: an
in-flight Tasks Trace GP keeping c->call_rcu_ttrace_in_progress == 1,
and concurrent cross-CPU frees repopulating c->free_by_rcu_ttrace with
new nodes. Under these conditions, the following scenario triggers UAF:

// CPU0
// irq work is still busy (on PREEMPT_RT)
alloc_bulk()
  llist_del_first(&c->free_by_rcu_ttrace)
    entry = smp_load_acquire(&head->first);
    do {
      if (entry == NULL)
        return NULL;

        // CPU1
        bpf_mem_alloc_destroy()
          WRITE_ONCE(c->draining, true)
          // wait for CPU0
          irq_work_sync()

                // CPU2
                do_call_rcu_ttrace(tgt(CPU0))
                  if (c->draining) {
                    llist_del_all(&c->free_by_rcu_ttrace)
                    free_all()
                  }

// CPU0 continue
      next = READ_ONCE(entry->next); <-- trigger UAF
    while (!try_cmpxchg(&head->first, &entry, next));

Fix this by introducing a raw spinlock to synchronize the concurrent
consumption on waiting_for_gp_ttrace and free_by_rcu_ttrace.

Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v3:
- Fix concurrent issue also for free_by_rcu_ttrace. (bpfci and Hou Tao)
- Use scoped_guard. (Leon)

v2: https://lore.kernel.org/bpf/20260827084013.1062816-1-pulehui@huaweicloud.com
- Use raw spinlock to fix concurrent alloc_bulk and __free_rcu on
  waiting_for_gp_ttrace after GP. (Hou Tao)

v1: https://lore.kernel.org/bpf/20260826103615.932094-1-pulehui@huaweicloud.com

 kernel/bpf/memalloc.c | 51 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..5927943c765a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -119,6 +119,7 @@ struct bpf_mem_cache {
 	struct llist_head waiting_for_gp_ttrace;
 	struct rcu_head rcu_ttrace;
 	atomic_t call_rcu_ttrace_in_progress;
+	raw_spinlock_t lock;
 };
 
 struct bpf_mem_caches {
@@ -214,25 +215,25 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
 	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
 
-	for (i = 0; i < cnt; i++) {
-		/*
-		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
-		 * done only by one CPU == current CPU. Other CPUs might
-		 * llist_add() and llist_del_all() in parallel.
-		 */
-		obj = llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj)
-			break;
-		add_obj_to_free_list(c, obj);
-	}
-	if (i >= cnt)
-		return;
+	scoped_guard(raw_spinlock_irqsave, &c->lock) {
+		for (i = 0; i < cnt; i++) {
+			/*
+			 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
+			 * done only by one CPU == current CPU. Other CPUs might
+			 * llist_add() and llist_del_all() in parallel.
+			 */
+			obj = llist_del_first(&c->free_by_rcu_ttrace);
+			if (!obj)
+				break;
+			add_obj_to_free_list(c, obj);
+		}
 
-	for (; i < cnt; i++) {
-		obj = llist_del_first(&c->waiting_for_gp_ttrace);
-		if (!obj)
-			break;
-		add_obj_to_free_list(c, obj);
+		for (; i < cnt; i++) {
+			obj = llist_del_first(&c->waiting_for_gp_ttrace);
+			if (!obj)
+				break;
+			add_obj_to_free_list(c, obj);
+		}
 	}
 	if (i >= cnt)
 		return;
@@ -279,8 +280,12 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
+	struct llist_node *llnode;
+
+	scoped_guard(raw_spinlock_irqsave, &c->lock)
+		llnode = llist_del_all(&c->waiting_for_gp_ttrace);
 
-	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	free_all(c, llnode, !!c->percpu_size);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -300,7 +305,8 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
-			llnode = llist_del_all(&c->free_by_rcu_ttrace);
+			scoped_guard(raw_spinlock_irqsave, &c->lock)
+				llnode = llist_del_all(&c->free_by_rcu_ttrace);
 			free_all(c, llnode, !!c->percpu_size);
 		}
 		return;
@@ -535,6 +541,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			raw_spin_lock_init(&c->lock);
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -557,7 +564,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
-
+			raw_spin_lock_init(&c->lock);
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -609,7 +616,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 		c->objcg = objcg;
 		c->percpu_size = percpu_size;
 		c->tgt = c;
-
+		raw_spin_lock_init(&c->lock);
 		init_refill_work(c);
 		prefill_mem_cache(c, cpu);
 	}
-- 
2.34.1


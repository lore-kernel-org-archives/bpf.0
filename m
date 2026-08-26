Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6C3BD62E;
	Wed, 26 Aug 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740289; cv=none; b=sHmadB54V6pbTlTO4elCfXBbk89JubJWnXqrGgrpNG6qYY5Na4Lzihk+/E+NKPM+BzYLGzN2tOoh7jb2unny8psAJYkt3cFGrmXPmvcIdsoG8epdP+TOAO+wuQUbn6aoWDuDCrLNu3Vha6nS0zSu11mI/jmWyit85ab/1uJ9Sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740289; c=relaxed/simple;
	bh=9vmGLlfwpar/mNP6iSNqSKJ8brCLNvAlHjMKlQcJJpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GbdLeamN7Yax434CqOFVC6riXp5lcb9s3WncRF78EYNavYXSm5Sggku7RPCSA4fwf5I2DxxkkQOdFLZbvh8vnrCcBcRaUoqp9iczmCsmMYhT5+6kQCCS4/XmnuA1V1dZcQ1fQI36pnU+7dV/jLoLEnaIBKG/uw6y0FOdnMkH9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hVLWv4JH9zKHMNM;
	Wed, 26 Aug 2026 18:30:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0A3B14096B;
	Wed, 26 Aug 2026 18:31:16 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDXEUFywI5qhrrlDg--.24234S2;
	Wed, 26 Aug 2026 18:31:15 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
Date: Wed, 26 Aug 2026 10:36:15 +0000
Message-Id: <20260826103615.932094-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXEUFywI5qhrrlDg--.24234S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr47Kw1rWr4rKF4kuF17Jrb_yoW7GFyrpF
	WxJry5Jr4kAFWIkas2yr4xCwsxZwsYqa43Gay8u3sIyr1Y9w1qgFZ7KryavFyavw4FkFW3
	tryqkF18Jw4Uu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller repeatedly triggered UAF splats related to nodes in
waiting_for_gp_ttrace within the bpf memalloc:

BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112

CPU: 2 PID: 5112 Comm: syz.4.470 Not tainted 6.6.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <IRQ>
 ...
 kasan_report+0xab/0xe0 mm/kasan/report.c:581
 llist_del_first+0x85/0x110 lib/llist.c:61
 alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
 bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436

Freed by task 14:
 ...
 __kmem_cache_free+0x15d/0x330 mm/slub.c:3885
 free_one kernel/bpf/memalloc.c:262 [inline]
 free_all kernel/bpf/memalloc.c:271 [inline]
 __free_rcu kernel/bpf/memalloc.c:281 [inline]
 __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
 rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
 rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
 rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651

Initially, we suspected that alloc_bulk() lacked RCU Tasks Trace
protection when accessing waiting_for_gp_ttrace. However, explicitly
adding rcu_read_lock_trace() did not help.

This is expected because, as noted in commit 57b23c0f612d("bpf: Retire
rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
(and will continue to imply in the future) a normal RCU GP. Since
alloc_bulk() runs in an IRQ context (serving as an implicit normal RCU
read-side critical section), an RCU Tasks Trace GP cannot complete while
alloc_bulk() is accessing the list. Thus, the callback __free_rcu cannot
run concurrently, ruling out missing RCU read-side locks as the cause.

Further investigation revealed that the UAF does not occur before the
RCU Tasks Trace grace period expires, but rather during the execution of
its callback. When the callback invokes llist_del_all to reclaim
waiting_for_gp_ttrace nodes, there is no synchronization protecting
against concurrent alloc_bulk() calls. If alloc_bulk() operates on
waiting_for_gp_ttrace simultaneously, a race condition ensues, as
illustrated below:

CPU0                                           CPU1
                                               __free_rcu (RCU Tasks Trace callback)
alloc_bulk (irq context)
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

Since alloc_bulk() operates on waiting_for_gp_ttrace under irq context,
fix the issue by deferring the node reclamation. In __free_rcu callback,
detach the waiting_for_gp_ttrace nodes to a local list pointer and invoke
a normal RCU callback to free them.

Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
Another potential fix would be to invoke llist_del_all() on
waiting_for_gp_ttrace before call_rcu_tasks_trace(), but that would
defeat the purpose of reusing waiting_for_gp_ttrace in alloc_bulk().

 kernel/bpf/memalloc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..fb1e733bfb82 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -110,7 +110,9 @@ struct bpf_mem_cache {
 	struct llist_node *free_by_rcu_tail;
 	struct llist_head waiting_for_gp;
 	struct llist_node *waiting_for_gp_tail;
+	struct llist_node *waiting_for_reclaim_gp;
 	struct rcu_head rcu;
+	struct rcu_head rcu_reclaim;
 	atomic_t call_rcu_in_progress;
 	struct llist_head free_llist_extra_rcu;
 
@@ -276,12 +278,28 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
 	return cnt;
 }
 
+static void __free_final_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct llist_node *llnode = c->waiting_for_reclaim_gp;
+
+	c->waiting_for_reclaim_gp = NULL;
+	free_all(c, llnode, !!c->percpu_size);
+	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
+}
+
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
+	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp_ttrace);
 
-	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
-	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
+	if (!llnode) {
+		atomic_set(&c->call_rcu_ttrace_in_progress, 0);
+		return;
+	}
+
+	c->waiting_for_reclaim_gp = llnode;
+	call_rcu(&c->rcu_reclaim, __free_final_rcu);
 }
 
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
-- 
2.34.1


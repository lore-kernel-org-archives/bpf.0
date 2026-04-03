Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538921D3E2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203060; cv=none; b=kFIRg5nHpDv/t2VsaLQNuj7ycG/iUyeNDOBYh4Ld2kFlbq/aCweWW2idU5ghYrsBAYulPgyj9YxJ3r1Cn4RRyZAJcHEiBdOtE9Np5hX13hsThFfiUdKmS063pF7Uda23Cnn79SSFNkPWJVXWbEq1U6sx46Ju5FUdOGT3Jckaza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203060; c=relaxed/simple;
	bh=EgBJjHMmBWZvqcnX0gGeKSnIsHrOB4EpzurCM9OC2XE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv/h57oSFl5dRk4iS95lZaX1IDtoCRmzDHIBG7a7Wxf5ssmKMpmqAjbjEMaN1mCI5t+PMeyNMKikzB1tp6xa2Qn+6IlMUvE4taST6WXg9OI/tgMhm5kN6oDOE5dEnZ3/eTGlRSlPSXPipuTbVPKdA8/hZP7ZIIHn1nyMe6CmXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r3aTsgWb; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r3aTsgWb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GH8Sughbk0Mcjz51carqskpRGUx8Vct26sRb9dLZZL8=;
	b=r3aTsgWbLuatX7L7gZx65sgur7Pz8oaNcYNSEySuzZ0HlmCdIIHAMsROBDu+H1FFY/RwG7+CT
	n5vFHaDwAx9NfSRvChcMsKYKHQFSRGubn+tSZL/Q/lr4+W19mBRs0ZgH4PQUIkO6QWLd2o8uTW0
	Us/lr4MDzPMdovlUb2ncalg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fn9sX5t1tz1T4sq;
	Fri,  3 Apr 2026 15:51:44 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 757C040572;
	Fri,  3 Apr 2026 15:57:28 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 15:57:28 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 15:57:27 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <kernel@openeuler.org>
CC: <tanghui20@huawei.com>, <quzicheng@huawei.com>, <quzicheng315@163.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>, "Alexei
 Starovoitov" <ast@kernel.org>, <bpf@vger.kernel.org>, cheliequan
	<cheliequan@inspur.com>, Luo Gengkun <luogengkun2@huawei.com>
Subject: [PATCH OLK-6.6 212/451] sched_ext: Implement DSQ iterator
Date: Fri, 3 Apr 2026 07:29:27 +0000
Message-ID: <20260403073326.3096906-213-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403073326.3096906-1-quzicheng@huawei.com>
References: <20260403073326.3096906-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100012.china.huawei.com (7.202.195.195)

From: Tejun Heo <tj@kernel.org>

mainline inclusion
from mainline-v6.12-rc1
commit 650ba21b131ed1f8ee57826b2c6295a3be221132
category: feature
bugzilla:  https://gitee.com/openeuler/kernel/issues/ID7HLY

Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650ba21b131ed1f8ee57826b2c6295a3be221132

--------------------------------

DSQs are very opaque in the consumption path. The BPF scheduler has no way
of knowing which tasks are being considered and which is picked. This patch
adds BPF DSQ iterator.

- Allows iterating tasks queued on a DSQ in the dispatch order or reverse
  from anywhere using bpf_for_each(scx_dsq) or calling the iterator kfuncs
  directly.

- Has ordering guarantee where only tasks which were already queued when the
  iteration started are visible and consumable during the iteration.

v5: - Add a comment to the naked list_empty(&dsq->list) test in
      consume_dispatch_q() to explain the reasoning behind the lockless test
      and by extension why nldsq_next_task() isn't used there.

    - scx_qmap changes separated into its own patch.

v4: - bpf_iter_scx_dsq_new() declaration in common.bpf.h was using the wrong
      type for the last argument (bool rev instead of u64 flags). Fix it.

v3: - Alexei pointed out that the iterator is too big to allocate on stack.
      Added a prep patch to reduce the size of the cursor. Now
      bpf_iter_scx_dsq is 48 bytes and bpf_iter_scx_dsq_kern is 40 bytes on
      64bit.

    - u32_before() comparison factored out.

v2: - scx_bpf_consume_task() is separated out into a separate patch.

    - DSQ seq and iter flags don't need to be u64. Use u32.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: cheliequan <cheliequan@inspur.com>
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
 include/linux/sched/ext.h                |   3 +
 kernel/sched/ext.c                       | 192 ++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 3 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index eb9cfd18a923..593d2f4909dd 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -61,6 +61,7 @@ struct scx_dispatch_q {
 	struct list_head	list;	/* tasks in dispatch order */
 	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
+	u32			seq;	/* used by BPF iter */
 	u64			id;
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
@@ -123,6 +124,7 @@ enum scx_kf_mask {
 
 struct scx_dsq_list_node {
 	struct list_head	node;
+	bool			is_bpf_iter_cursor;
 };
 
 /*
@@ -133,6 +135,7 @@ struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_list_node dsq_list;	/* dispatch order */
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
+	u32			dsq_seq;
 	u32			dsq_flags;	/* protected by DSQ lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 12263ccf9aa9..98c52f96fa0f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -930,6 +930,11 @@ static u32 highest_bit(u32 flags)
 	return ((u64)1 << bit) >> 1;
 }
 
+static bool u32_before(u32 a, u32 b)
+{
+	return (s32)(a - b) < 0;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1070,6 +1075,73 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
+/**
+ * nldsq_next_task - Iterate to the next task in a non-local DSQ
+ * @dsq: user dsq being interated
+ * @cur: current position, %NULL to start iteration
+ * @rev: walk backwards
+ *
+ * Returns %NULL when iteration is finished.
+ */
+static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
+					   struct task_struct *cur, bool rev)
+{
+	struct list_head *list_node;
+	struct scx_dsq_list_node *dsq_lnode;
+
+	lockdep_assert_held(&dsq->lock);
+
+	if (cur)
+		list_node = &cur->scx.dsq_list.node;
+	else
+		list_node = &dsq->list;
+
+	/* find the next task, need to skip BPF iteration cursors */
+	do {
+		if (rev)
+			list_node = list_node->prev;
+		else
+			list_node = list_node->next;
+
+		if (list_node == &dsq->list)
+			return NULL;
+
+		dsq_lnode = container_of(list_node, struct scx_dsq_list_node,
+					 node);
+	} while (dsq_lnode->is_bpf_iter_cursor);
+
+	return container_of(dsq_lnode, struct task_struct, scx.dsq_list);
+}
+
+#define nldsq_for_each_task(p, dsq)						\
+	for ((p) = nldsq_next_task((dsq), NULL, false); (p);			\
+	     (p) = nldsq_next_task((dsq), (p), false))
+
+
+/*
+ * BPF DSQ iterator. Tasks in a non-local DSQ can be iterated in [reverse]
+ * dispatch order. BPF-visible iterator is opaque and larger to allow future
+ * changes without breaking backward compatibility. Can be used with
+ * bpf_for_each(). See bpf_iter_scx_dsq_*().
+ */
+enum scx_dsq_iter_flags {
+	/* iterate in the reverse dispatch order */
+	SCX_DSQ_ITER_REV		= 1U << 0,
+
+	__SCX_DSQ_ITER_ALL_FLAGS	= SCX_DSQ_ITER_REV,
+};
+
+struct bpf_iter_scx_dsq_kern {
+	struct scx_dsq_list_node	cursor;
+	struct scx_dispatch_q		*dsq;
+	u32				dsq_seq;
+	u32				flags;
+} __attribute__((aligned(8)));
+
+struct bpf_iter_scx_dsq {
+	u64				__opaque[6];
+} __attribute__((aligned(8)));
+
 
 /*
  * SCX task iterator.
@@ -1419,7 +1491,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		 * tested easily when adding the first task.
 		 */
 		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
-			     !list_empty(&dsq->list)))
+			     nldsq_next_task(dsq, NULL, false)))
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
@@ -1451,6 +1523,10 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
+	/* seq records the order tasks are queued, used by BPF DSQ iterator */
+	dsq->seq++;
+	p->scx.dsq_seq = dsq->seq;
+
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
@@ -2109,12 +2185,17 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 {
 	struct task_struct *p;
 retry:
+	/*
+	 * The caller can't expect to successfully consume a task if the task's
+	 * addition to @dsq isn't guaranteed to be visible somehow. Test
+	 * @dsq->list without locking and skip if it seems empty.
+	 */
 	if (list_empty(&dsq->list))
 		return false;
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
+	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -5709,6 +5790,110 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
 	destroy_dsq(dsq_id);
 }
 
+/**
+ * bpf_iter_scx_dsq_new - Create a DSQ iterator
+ * @it: iterator to initialize
+ * @dsq_id: DSQ to iterate
+ * @flags: %SCX_DSQ_ITER_*
+ *
+ * Initialize BPF iterator @it which can be used with bpf_for_each() to walk
+ * tasks in the DSQ specified by @dsq_id. Iteration using @it only includes
+ * tasks which are already queued when this function is invoked.
+ */
+__bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
+				     u64 flags)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_scx_dsq_kern) >
+		     sizeof(struct bpf_iter_scx_dsq));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
+		     __alignof__(struct bpf_iter_scx_dsq));
+
+	if (flags & ~__SCX_DSQ_ITER_ALL_FLAGS)
+		return -EINVAL;
+
+	kit->dsq = find_non_local_dsq(dsq_id);
+	if (!kit->dsq)
+		return -ENOENT;
+
+	INIT_LIST_HEAD(&kit->cursor.node);
+	kit->cursor.is_bpf_iter_cursor = true;
+	kit->dsq_seq = READ_ONCE(kit->dsq->seq);
+	kit->flags = flags;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_scx_dsq_next - Progress a DSQ iterator
+ * @it: iterator to progress
+ *
+ * Return the next task. See bpf_iter_scx_dsq_new().
+ */
+__bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	bool rev = kit->flags & SCX_DSQ_ITER_REV;
+	struct task_struct *p;
+	unsigned long flags;
+
+	if (!kit->dsq)
+		return NULL;
+
+	raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+
+	if (list_empty(&kit->cursor.node))
+		p = NULL;
+	else
+		p = container_of(&kit->cursor, struct task_struct, scx.dsq_list);
+
+	/*
+	 * Only tasks which were queued before the iteration started are
+	 * visible. This bounds BPF iterations and guarantees that vtime never
+	 * jumps in the other direction while iterating.
+	 */
+	do {
+		p = nldsq_next_task(kit->dsq, p, rev);
+	} while (p && unlikely(u32_before(kit->dsq_seq, p->scx.dsq_seq)));
+
+	if (p) {
+		if (rev)
+			list_move_tail(&kit->cursor.node, &p->scx.dsq_list.node);
+		else
+			list_move(&kit->cursor.node, &p->scx.dsq_list.node);
+	} else {
+		list_del_init(&kit->cursor.node);
+	}
+
+	raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
+
+	return p;
+}
+
+/**
+ * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
+ * @it: iterator to destroy
+ *
+ * Undo scx_iter_scx_dsq_new().
+ */
+__bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+
+	if (!kit->dsq)
+		return;
+
+	if (!list_empty(&kit->cursor.node)) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+		list_del_init(&kit->cursor.node);
+		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
+	}
+	kit->dsq = NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
@@ -6142,6 +6327,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 965d20324114..20280df62857 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -39,6 +39,9 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
+struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
+void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
-- 
2.34.1


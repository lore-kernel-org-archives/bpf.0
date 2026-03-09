Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AE3D648A
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071725; cv=none; b=tAyZRDUsXN4VKpurGUBiaxKBqn+n5C/timRhwTJUyj3S5iUZjagY9XnYujwIqiaEh9cRady1VjR1GVfjsLUqF5NMDvUwDfGEw/jHcD8nXM1Fzqg+BWnjj5in3uTVwhFvwa2S2gn9kaQwrSuwvqFD4QUnY38Rae4mDnlwrPz11RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071725; c=relaxed/simple;
	bh=5zgy6VVKvQE+FX74kIsWabqkjp5D/gOOpk1wuNUamzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/RA1BCXxiCNCmOJwZh2W6VFhhsWGbgPjK2QvuAxLlJp8BXKTnhVqLInRdXhpVPXr38Vz4U9x2N1WIh/Z5wHwjjb14Zr4LS0WXWnxiyntMeT+STJw0FwDM5e5hP+gV/CW2KJDcyD3L1/qAN9CmH+5WDI0N4xc8374mCQyd8YWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B49LuVeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B49LuVeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB54C4CEF7;
	Mon,  9 Mar 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071724;
	bh=5zgy6VVKvQE+FX74kIsWabqkjp5D/gOOpk1wuNUamzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B49LuVeJhVCtsDRqGykQF0QCfN/uS0jsakQgRxkZEesw3HNrBxSTDvVH5C1M4yF0b
	 RMOfni8hX4hU17RWaFlURlkVxFkoPRM1gT97YWUzHMRZmoshrR45djB3TatN8DQRXE
	 mRQ5liohjZ674om7r7nW+6rbBkUSHCj4mc/WhcKQNsK5yEtpgSGGtUVWLmIOuIgf7d
	 jzQMLJcnKjaTYcXUdQQlk1MEg7vHbwzONegngT39t6OzBkBD7qHvrc9yEegQ/kwBYM
	 4HyOXDCJhV4uXkTaf5POkFwpBiMZ9TPQod0cbzkhqTR/pkjp+JgRgAhID46fDYcahV
	 Ws1FU/cWKGsAg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/4] bpf: rename mmap_unlock_irq_work to bpf_iter_mm_irq_work
Date: Mon,  9 Mar 2026 08:54:55 -0700
Message-ID: <20260309155506.23490-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309155506.23490-1-puranjay@kernel.org>
References: <20260309155506.23490-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will be reusing mmap_unlock_irq_work to do mmput_async()
in irq_work. Rather than creating a new structure, rename
mmap_unlock_irq_work to bpf_iter_mm_irq_work and reuse it.

This is only a rename with no functional changes.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/mmap_unlock_work.h | 12 ++++++------
 kernel/bpf/stackmap.c         |  2 +-
 kernel/bpf/task_iter.c        | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef..ba8e860f1180 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -6,13 +6,13 @@
 #define __MMAP_UNLOCK_WORK_H__
 #include <linux/irq_work.h>
 
-/* irq_work to run mmap_read_unlock() in irq_work */
-struct mmap_unlock_irq_work {
+/* irq_work to run mmap_read_unlock() or mmput_async() in irq_work */
+struct bpf_iter_mm_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
 };
 
-DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
+DECLARE_PER_CPU(struct bpf_iter_mm_irq_work, mmap_unlock_work);
 
 /*
  * We cannot do mmap_read_unlock() when the irq is disabled, because of
@@ -21,9 +21,9 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
  * percpu variable to do the irq_work. If the irq_work is already used
  * by another lookup, we fall over.
  */
-static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **work_ptr)
+static inline bool bpf_mmap_unlock_get_irq_work(struct bpf_iter_mm_irq_work **work_ptr)
 {
-	struct mmap_unlock_irq_work *work = NULL;
+	struct bpf_iter_mm_irq_work *work = NULL;
 	bool irq_work_busy = false;
 
 	if (irqs_disabled()) {
@@ -46,7 +46,7 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	return irq_work_busy;
 }
 
-static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
+static inline void bpf_mmap_unlock_mm(struct bpf_iter_mm_irq_work *work, struct mm_struct *mm)
 {
 	if (!work) {
 		mmap_read_unlock(mm);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..7ef1042a3448 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -166,7 +166,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
 	int i;
-	struct mmap_unlock_irq_work *work = NULL;
+	struct bpf_iter_mm_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
 	struct vm_area_struct *vma, *prev_vma = NULL;
 	const char *prev_build_id;
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..7c302ee78f7e 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -751,7 +751,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
 {
-	struct mmap_unlock_irq_work *work = NULL;
+	struct bpf_iter_mm_irq_work *work = NULL;
 	struct vm_area_struct *vma;
 	bool irq_work_busy = false;
 	struct mm_struct *mm;
@@ -797,7 +797,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-	struct mmap_unlock_irq_work *work;
+	struct bpf_iter_mm_irq_work *work;
 	struct vma_iterator vmi;
 };
 
@@ -1029,22 +1029,22 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
 
 __bpf_kfunc_end_defs();
 
-DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
+DEFINE_PER_CPU(struct bpf_iter_mm_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
 {
-	struct mmap_unlock_irq_work *work;
+	struct bpf_iter_mm_irq_work *work;
 
 	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
 		return;
 
-	work = container_of(entry, struct mmap_unlock_irq_work, irq_work);
+	work = container_of(entry, struct bpf_iter_mm_irq_work, irq_work);
 	mmap_read_unlock_non_owner(work->mm);
 }
 
 static int __init task_iter_init(void)
 {
-	struct mmap_unlock_irq_work *work;
+	struct bpf_iter_mm_irq_work *work;
 	int ret, cpu;
 
 	for_each_possible_cpu(cpu) {
-- 
2.47.3


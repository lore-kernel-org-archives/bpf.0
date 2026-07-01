Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFF21B191;
	Wed,  1 Jul 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904447; cv=none; b=oZH9Uoe3KF78hiUQ6gDjybNPyy4QQJk8uuUobHN4CDxmUtKE00/iRCJ2hzcxkGo4gM1u6Up1159aF7GZbn7j362Kt+hQB+6PBA2XZ0bBk4WXgy2cx5ral7Og7fqlIMbkaDNycAk6PcQv8cKv4ikU+HO3CZUI6llsYDp09Z7Bdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904447; c=relaxed/simple;
	bh=DzYv9kQU7J1fEfwbYNXhxfvK8KwLO2v/VV5Qbkut43w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+w4aKN1ct/S+J4su6ikBKIZv6KR577jEF44VbUKRjHubzKK4/EPoBk9CNH7WJNKYMkuJkov0iMvWmBdOZUGGcxGxIEJQ3dVOB4/ozzj4fwRHnDDMqk6knf7I0spu2A/3sIiDLbuhlzfkRBrgCdyepi5/iaFF5CutKVeN4CHpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WARVai9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WARVai9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7717F1F000E9;
	Wed,  1 Jul 2026 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904445;
	bh=FAowrYr5F8VZJrsEbPgQLCe9D0YxUoyTmT4KLks/BtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WARVai9cDWn39/7o04CwSndhkSk9i3OrQVYQkCyv5cq0FRTFzyEGHDdSHfX+qa573
	 S4e/HnveHc4mYGqOc6J5O/3YgGlg7sT3Z0fGyLiLHsjcftP8lZnKJUyRZf6jiJPj8q
	 OSZcOg9dlT05DewQZiVYSgldWJ4oCkBArSXkOYcy3erN8I111cNpUEBoRLvC2uXufK
	 +mDD4YXs/nKeArVPvFXuD3j/ZDAq6HLbUIP9p6ohKHHB6D6zdNDZau/exCrWamts8/
	 zJM1Rkzl2Z7zMuNIQM6j5eU6RS42KZEpxc7bkMsfNrVDyDAMreY3/p+KhWCUT0ARtE
	 wKyvroDqvM2CA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 02/13] uprobes/x86: Remove struct uprobe_trampoline object
Date: Wed,  1 Jul 2026 13:13:26 +0200
Message-ID: <20260701111337.53943-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing struct uprobe_trampoline object and it's tracking code,
because it's not needed. We can do same thing directly on top of
struct vm_area_struct objects.

This makes the code simpler and allows easy propagation of the
trampoline vma object into child process in following change.

Note the original code called destroy_uprobe_trampoline if the
optimiation failed, but it only freed the struct uprobe_trampoline
object, not the vma. The new vma leak is fixed in following change.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 106 ++++++++------------------------------
 include/linux/uprobes.h   |   5 --
 kernel/events/uprobes.c   |  10 ----
 kernel/fork.c             |   1 -
 4 files changed, 22 insertions(+), 100 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 2be6707e3320..d2933cf77cd3 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -631,11 +631,6 @@ static struct vm_special_mapping tramp_mapping = {
 	.pages  = tramp_mapping_pages,
 };
 
-struct uprobe_trampoline {
-	struct hlist_node	node;
-	unsigned long		vaddr;
-};
-
 static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
 {
 	long delta = (long)(vaddr + 5 - vtramp);
@@ -682,83 +677,28 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	return high_tramp;
 }
 
-static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
+static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-	struct mm_struct *mm = current->mm;
-	struct uprobe_trampoline *tramp;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 
-	if (!user_64bit_mode(regs))
-		return NULL;
+	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	for_each_vma(vmi, vma) {
+		if (!vma_is_special_mapping(vma, &tramp_mapping))
+			continue;
+		if (is_reachable_by_call(vma->vm_start, vaddr))
+			return vma;
+	}
 
 	vaddr = find_nearest_trampoline(vaddr);
 	if (IS_ERR_VALUE(vaddr))
-		return NULL;
+		return ERR_PTR(vaddr);
 
-	tramp = kzalloc_obj(*tramp);
-	if (unlikely(!tramp))
-		return NULL;
-
-	tramp->vaddr = vaddr;
-	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
+	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
 				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
 				&tramp_mapping);
-	if (IS_ERR(vma)) {
-		kfree(tramp);
-		return NULL;
-	}
-	return tramp;
-}
-
-static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
-{
-	struct uprobes_state *state = &current->mm->uprobes_state;
-	struct uprobe_trampoline *tramp = NULL;
-
-	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
-		return NULL;
-
-	hlist_for_each_entry(tramp, &state->head_tramps, node) {
-		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
-			*new = false;
-			return tramp;
-		}
-	}
-
-	tramp = create_uprobe_trampoline(vaddr);
-	if (!tramp)
-		return NULL;
-
-	*new = true;
-	hlist_add_head(&tramp->node, &state->head_tramps);
-	return tramp;
-}
-
-static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
-{
-	/*
-	 * We do not unmap and release uprobe trampoline page itself,
-	 * because there's no easy way to make sure none of the threads
-	 * is still inside the trampoline.
-	 */
-	hlist_del(&tramp->node);
-	kfree(tramp);
-}
-
-void arch_uprobe_init_state(struct mm_struct *mm)
-{
-	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
-}
-
-void arch_uprobe_clear_state(struct mm_struct *mm)
-{
-	struct uprobes_state *state = &mm->uprobes_state;
-	struct uprobe_trampoline *tramp;
-	struct hlist_node *n;
-
-	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
-		destroy_uprobe_trampoline(tramp);
 }
 
 static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
@@ -1111,21 +1051,19 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
 				  unsigned long vaddr)
 {
-	struct uprobe_trampoline *tramp;
-	struct vm_area_struct *vma;
-	bool new = false;
-	int err = 0;
+	struct pt_regs *regs = task_pt_regs(current);
+	struct vm_area_struct *vma, *tramp;
+	int ret;
 
+	if (!user_64bit_mode(regs))
+		return -EINVAL;
 	vma = find_vma(mm, vaddr);
 	if (!vma)
 		return -EINVAL;
-	tramp = get_uprobe_trampoline(vaddr, &new);
-	if (!tramp)
-		return -EINVAL;
-	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
-	if (WARN_ON_ONCE(err) && new)
-		destroy_uprobe_trampoline(tramp);
-	return err;
+	tramp = get_uprobe_trampoline(mm, vaddr);
+	if (IS_ERR(tramp))
+		return PTR_ERR(tramp);
+	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
 }
 
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f548fea2adec..18be159bbc34 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -186,9 +186,6 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
-#ifdef CONFIG_X86_64
-	struct hlist_head	head_tramps;
-#endif
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
@@ -238,8 +235,6 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
-extern void arch_uprobe_clear_state(struct mm_struct *mm);
-extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 extern unsigned long arch_uprobe_get_xol_area(void);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..b5c516168f84 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1806,14 +1806,6 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
 
-void __weak arch_uprobe_clear_state(struct mm_struct *mm)
-{
-}
-
-void __weak arch_uprobe_init_state(struct mm_struct *mm)
-{
-}
-
 /*
  * uprobe_clear_state - Free the area allocated for slots.
  */
@@ -1825,8 +1817,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	arch_uprobe_clear_state(mm);
-
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 13e38e89a1f3..00b52c7314d1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1064,7 +1064,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
-	arch_uprobe_init_state(mm);
 #endif
 }
 
-- 
2.54.0


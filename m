Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446222F28FC;
	Tue, 26 May 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829145; cv=none; b=hEdeKUM+Ng5RD869tmtUMwxz8N51IzIhEjwNAa2peHw6v3vXfm0T3FgSaL2blG4MRvcJdXYxUkvKuomREbTc/uADZK2KXTJLdAbrnUBbXdzpINJpK2SuFjxfYB5hPYFEjHvpBcIldeun0CyZZ3SeuxDVpfsfCOVNb6c5Yru37YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829145; c=relaxed/simple;
	bh=qG9X64lEIhEtiBvLjmiiwLtQtISW9zzFPrGPtKYeedY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsIj2xgomeRZ8rhCFYuBFgswrLiUf29tx3F3NGRzhRWdWKAh4Y63htko1OTLrkdyhGf7/7TEqkMMzZHJzFygeYg7fZCA+iEzIo7eRfmlCjhcwLnGxeFGVR/HEVkM9d2+tBn4O10+y+mrk/UQMj+XCr8xnjen1yxBCEy/SlXL3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es+n5VKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es+n5VKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12AA1F000E9;
	Tue, 26 May 2026 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829143;
	bh=BVFlQ5tyc16mlxEmFd1gvubGYMF8GYb+iy6+zutCGHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Es+n5VKZGZT/dpsnnJ7jEP6W2awo+3Vd0SLLgPMorq/MUKF1kTi0k77Fhyfkkwc1U
	 iyfLWzOnB0FS7mbBpwplUzSgt+jtYqBuc0w2ZMU9hq7KFaaBeOgbWmBPqvVmcwLO3M
	 GLe8XjnLR0qbml3JjTfX6i+gHHXOw//J/KpeHILhCy3cKK3Im5akLrShC8D/vsoFEg
	 zb4cNFDofE96Bi/lElGUBqVZ5aVopg9wbBr7WPv3vwoJ6nCyX4F0GLcHHF7Ze0XiTT
	 0KqU27xokRpsh9ZPeLPHIWw+LHXAC9AAbwIuJ4g0HetmSpvqpugZ1vmJOHp6IqjSP1
	 q9tJyDsCBUiyA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline object
Date: Tue, 26 May 2026 22:58:29 +0200
Message-ID: <20260526205840.173790-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 105 ++++++++------------------------------
 include/linux/uprobes.h   |   5 --
 kernel/events/uprobes.c   |  10 ----
 kernel/fork.c             |   1 -
 4 files changed, 21 insertions(+), 100 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 2be6707e3320..733655bc610e 100644
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
@@ -1111,21 +1051,18 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
 				  unsigned long vaddr)
 {
-	struct uprobe_trampoline *tramp;
-	struct vm_area_struct *vma;
-	bool new = false;
-	int err = 0;
+	struct pt_regs *regs = task_pt_regs(current);
+	struct vm_area_struct *vma, *tramp;
 
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
index 5f3fdfdb14c7..9c6baabdc961 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1059,7 +1059,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
-	arch_uprobe_init_state(mm);
 #endif
 }
 
-- 
2.54.0


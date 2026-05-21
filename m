Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F713F9267;
	Thu, 21 May 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367477; cv=none; b=NH0qkEsB/UFBLk6DL2vQ0OCKKNeen3d59H9eK48MuDB0hkKOnTOmnNAFuJRBuNWgbeWpVYj1C5FhHr1q5OkUefxhQyjQwSEsC1n32iPOXWrFCKT8qSPnWEf4rnoj9aRw49DKlEYH3RprByjlp7eCq0FSv1rVkJbmjW39fhV5CTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367477; c=relaxed/simple;
	bh=2xSrBu/c8wWczGL3jZBVt/0objszfwNaR+yicNLDXmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdJHpkLB4LApa5/g5nXJhf1MDRvzlJUKZ8Vg02dsJIRyWZMdiTJcQAKQLgdhJmezCE8U8RNIouoR67eKCgYkDoTd6diRZ9O0OFVG+nneWBTT6TGzxp802QkDbX6n9VSAEnvdBBGXpwqzCnb+LUjexkDYacbP2RX4ew66XzASu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU6LlxGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU6LlxGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B41F000E9;
	Thu, 21 May 2026 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367475;
	bh=o4DVZs59wA3i1XrKTGtD6gEBWwoMwAOsWOssLzGeE1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kU6LlxGO5zAaTcIypAm98vt+5L7e1P0TGErGWtn3e7cY2aXVgqgsA/JqrX3xGzlDm
	 zyBi0F/yUt0bZNCEIlsZqw8oTVUGnlnaMCVND7y9zKj5/ZuuwxJkhJgVj8aH3OMBGw
	 btHOpHygNKhExiB+IGwqja3qQjSfasszCvtFNVEj+ektrhMA5sbqEX7pazyxLvEtcC
	 74GiP8YozK3eYA/8AFqKfhW6Z41eYi4Ez/4lfGE3RPik4TZu0DuGJZ1SUioMXmbpq6
	 fTS54r2W30bgeU8wlc/z4CzEAPtJDCZdL/yOH5dCvRiDkcwC1aL4q0qsEhPHzaYN3u
	 /lVVtEMMPb9gQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 02/12] uprobes/x86: Remove struct uprobe_trampoline object
Date: Thu, 21 May 2026 14:44:01 +0200
Message-ID: <20260521124411.31133-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
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
object, not the vma.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 102 ++++++++------------------------------
 include/linux/uprobes.h   |   5 --
 kernel/events/uprobes.c   |  10 ----
 kernel/fork.c             |   1 -
 4 files changed, 20 insertions(+), 98 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 2be6707e3320..6824376e253d 100644
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
@@ -682,83 +677,32 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	return high_tramp;
 }
 
-static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
+static struct vm_area_struct *get_uprobe_trampoline(unsigned long vaddr)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	struct mm_struct *mm = current->mm;
-	struct uprobe_trampoline *tramp;
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma;
 
 	if (!user_64bit_mode(regs))
-		return NULL;
-
-	vaddr = find_nearest_trampoline(vaddr);
-	if (IS_ERR_VALUE(vaddr))
-		return NULL;
-
-	tramp = kzalloc_obj(*tramp);
-	if (unlikely(!tramp))
-		return NULL;
-
-	tramp->vaddr = vaddr;
-	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
-				&tramp_mapping);
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
+		return ERR_PTR(-EINVAL);
 
 	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
-	hlist_for_each_entry(tramp, &state->head_tramps, node) {
-		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
-			*new = false;
-			return tramp;
-		}
+	for_each_vma(vmi, vma) {
+		if (!vma_is_special_mapping(vma, &tramp_mapping))
+			continue;
+		if (is_reachable_by_call(vma->vm_start, vaddr))
+			return vma;
 	}
 
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
+	vaddr = find_nearest_trampoline(vaddr);
+	if (IS_ERR_VALUE(vaddr))
+		return ERR_PTR(vaddr);
 
-	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
-		destroy_uprobe_trampoline(tramp);
+	return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				&tramp_mapping);
 }
 
 static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
@@ -1111,21 +1055,15 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
 				  unsigned long vaddr)
 {
-	struct uprobe_trampoline *tramp;
-	struct vm_area_struct *vma;
-	bool new = false;
-	int err = 0;
+	struct vm_area_struct *vma, *tramp;
 
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
+	tramp = get_uprobe_trampoline(vaddr);
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
2.53.0


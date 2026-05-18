Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9B481FA5
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120309; cv=none; b=LWhfuQ/XouPstLLHFPgeL9eQF/3tjJTy8wxqYn2hLLc8QklqW1UFFvnMv4jtwSTOVzXfcy1tEhhgKgLqi8XzDgQqbmQUJq/RtB7ERp1YS8XWyDSd4sRBoaYsCPUDMhjl6GEpjKAafmPoJFugdcG0trHQrZ7WEC7ALrx3GVLEuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120309; c=relaxed/simple;
	bh=qMo2h68N+JrWSJO/RZ8Kho5+FZTjs7X8pRv0HUWBMYw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd4TruGV9/Xyrvp/iHNoVmdN6pkR2EIt4KROucCGc3WP5GIQzoqtfFsWwWDbwnPg+aBeSTB+FyZPBla+0OFuL8VL+gb3NGyY2R8CZbX/uZirk7n3UyXl/sqPt51WtjiNf5KaBSsR6ltFJVBLryUFus4HRsJwR1bGDlDOAEHX7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBWlOUsw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBWlOUsw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so29903775e9.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120298; x=1779725098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VGgz8O/vKdGfNaGXkWUrfuoXq2xq9PVhrs10AnzG/A=;
        b=hBWlOUswxaVjRAWafsHjSVhQ+dH8s0Rl/2lb43D15L/aoWVNG//caWFwd6SPExFd/C
         t+SbY0tCw+lTRXa/WNeuWF0c7C6vJmCKtLpco8a8Hss2Hj1ubq6K7ebC7BXqLVk9jR8n
         anetXfdjQVFXBWU5zsN2ASCnlAAwG51auGeEc5kMpKoo5HusOzUF74wFXVp0+p5HHPgR
         f647sMWcJ7x9fQyJekUlKpuKs57xxCwwDzKnx7liFDM7oUfvcEbVAiIZvSa17lyVHAn/
         9GV/T1Q06dhQhLR3t4tB2amjUowmSHfUb68AESpYpPYLyHVzXIP36zGrkxcbNWf7R1Pi
         hzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120298; x=1779725098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VGgz8O/vKdGfNaGXkWUrfuoXq2xq9PVhrs10AnzG/A=;
        b=l/nUS+jxFj9oPG4rWxydY77sn6umQeIR79Gh+5mJ9CTNwen2LgwoGw4AvI2vtpwElG
         GJ0F9ZBKwB3XH3u1I+pUF9Hu7Md9UIyvITMOGVAaW+m17mC0w3u705V072XorSqvyFj+
         JMZcVLGfwJ0ASu1S/k2byZVMUjS5jf8PIIEwXU3cl8KHZ+g0GUbN3byjm+xm99SbDUPk
         Y0Di5BesBfvvkZQi7POR5mLSoFAfTpUixaKqVq62bGy4dc4fZinli59HRgOmdVbpmY5Y
         0j2/rbvs0Eb8sm73IQKAETRmnjYrcSAooTTdUqiVK9TDTbrm/Hx5lbzmKZdEThbvwh8j
         T4UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bkjv4Ni/j2yXk9yDB6obdjOnr2OjWsfPprIalOlcc659tIDOxJpOkO+4VY0M+ZGaWD58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzuyoPKdhpf4aNHFvVR/xFwkYPM6MLnRw57XzW2kB7sL6w65+
	kxJuI6aiyZaII1Rm9ZberK/oKpnQ50EOhR55baFZNpE2PTJk2eo5wJWM
X-Gm-Gg: Acq92OHD1r7OHx4rBfQP0RJS6DUssLkFnpWcjsRhiCBkbVovmgp+uGa82G8Hi8kK0OX
	Fjz+ot9zJzwTMgPT5XSvGximwlWNr7OVGRDrzr968GdSBazidV99nytZ+u7dLBhV4aCy/uX0Rhu
	4/vc+MdaabTSYVGtkMlBgdObe1XMYTdhEGCxZYmkhrPjpu76+KFkayH2mXJm8r/kEc6n8qtGZrv
	MwKcIwOEcFxITSCwYaMKQ4DhG1BojcZo1heaZcfP5MSrmixwNhJDTnkArrpTIAuwQnwXds1ILl1
	3RnCq/sDpd2G4nv46iAeXsTU5cJwWC7EUgc2a0+km1kbdpZQpgP7SsNVHStZEtFqeW7tEa90X9d
	JRmywaqwG5G21x9oMrN0HqkBATpfnxrt8C1vaHPtXu2Lbgc0tIA8hFRRG4fZ9u4iZ2MKgsDpIbr
	x2z9UT0sKRaxc=
X-Received: by 2002:a05:600c:3f1b:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48fe60e7fa1mr247507865e9.13.1779120298029;
        Mon, 18 May 2026 09:04:58 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm97591015e9.9.2026.05.18.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:04:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 18:04:56 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCHv2 02/11] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <ags4qIlqFBvgZ3UP@krava>
References: <20260518105957.123445-3-jolsa@kernel.org>
 <20260518114208.CE128C2BCF6@smtp.kernel.org>
 <agsLH2G2DPxD3g12@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agsLH2G2DPxD3g12@krava>

On Mon, May 18, 2026 at 02:50:39PM +0200, Jiri Olsa wrote:
> On Mon, May 18, 2026 at 11:42:08AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Critical] __in_uprobe_trampoline uses current->mm instead of the target mm_struct, causing kernel crashes and instruction stream corruption during uprobe_unregister.
> > - [High] Removing VM_DONTCOPY without synchronizing the uprobes state causes a linear VMA leak across fork chains.
> > --
> > 
> > commit be0e6254bd9df4f56adce23d7a5e24a78c286291
> > Author: Jiri Olsa <jolsa@kernel.org>
> > uprobes/x86: Allow to copy uprobe trampolines on fork
> > 
> > This commit allows vma uprobe trampoline objects to be copied on fork to
> > the new process by removing the VM_DONTCOPY flag.
> > 
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -702,7 +702,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> > >  
> > >  	tramp->vaddr = vaddr;
> > >  	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> > > -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> > 
> > Does removing VM_DONTCOPY without synchronizing the uprobes state cause a
> > linear VMA leak across fork chains?
> > 
> > When dup_mmap() copies the uprobe trampoline VMA to the child process during
> > fork(), the child's tracking list (mm->uprobes_state.head_tramps) is
> > initialized as completely empty via mm_init_uprobes_state(), meaning the
> > parent's state is not duplicated.
> > 
> > When the child process executes a uprobe, arch_uprobe_optimize() calls
> > get_uprobe_trampoline(). Because head_tramps is empty, it fails to find the
> > VMA it already inherited. It then falls back to create_uprobe_trampoline(),
> > which calls find_nearest_trampoline(). Since the inherited VMA is already
> > mapped, find_nearest_trampoline() finds a new unmapped area and installs a
> > second duplicate trampoline VMA.
> > 
> > In a deep fork chain, each generation inherits all previous VMAs, has an
> > empty head_tramps list, and creates a new VMA. Can this cause a linear
> > accumulation of redundant VMAs, eventually exhausting vm.max_map_count and
> > virtual memory?
> 
> I don't think it's big problem, because it's unlikely you'll insert extra uprobes
> to child process.. but perhaps we could go away with struct uprobe_trampoline
> object and operate directly on top of vma objects, it could event make code
> easier, will try

ok looks like we could go without struct uprobe_trampoline layer (below),
that should address the comment, will do that in next version

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 2be6707e3320..c87079e53946 100644
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
@@ -682,12 +677,10 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	return high_tramp;
 }
 
-static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
+static struct vm_area_struct *create_uprobe_trampoline(unsigned long vaddr)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	struct mm_struct *mm = current->mm;
-	struct uprobe_trampoline *tramp;
-	struct vm_area_struct *vma;
 
 	if (!user_64bit_mode(regs))
 		return NULL;
@@ -696,69 +689,26 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 	if (IS_ERR_VALUE(vaddr))
 		return NULL;
 
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
 }
 
-static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
+static struct vm_area_struct *get_uprobe_trampoline(unsigned long vaddr)
 {
-	struct uprobes_state *state = &current->mm->uprobes_state;
-	struct uprobe_trampoline *tramp = NULL;
+	VMA_ITERATOR(vmi, current->mm, 0);
+	struct vm_area_struct *vma;
 
 	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
 		return NULL;
 
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
+	return create_uprobe_trampoline(vaddr);
 }
 
 static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
@@ -1111,21 +1061,15 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
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
+	if (IS_ERR_OR_NULL(tramp))
+		return PTR_ERR(tramp);
+	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
 }
 
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f548fea2adec..43d950f444cf 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -238,8 +238,6 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
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
 

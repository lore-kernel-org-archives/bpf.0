Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6753DDDB9;
	Thu, 14 May 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766836; cv=none; b=tJc5MPOpavhSFKWRIMX53vmIpgnRkkYkCvxKRC2+ECY7tAFQaDiKoDS3bwozW+LZDBrWJpWIEPH5xTEYWtuA/loFWf6xsOIRFeoARKv7MUUbiYrH8TCj2wHocf6WeUpvwWgNnsp0if+/U8rIn5LmNhS79lPKR4Xz2wqqzkTXBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766836; c=relaxed/simple;
	bh=kVVZno89j5J9uM8cdi6t6eaD93yE+XrzOIo6hZ1j5Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwpMGrI9F6ukZwTOXIn00WAJMdD5CoRj1QLhPA+fand93Lk49+NV5qp4aSK6rEPdhQCE86YJgU9vYtFyCfmSTcHPesLfHVdHpYJK7EGqeMA94f8BRasif1Nyjr4S1yiQ+mdsw6Ans0LlKVZmk31av1UNy4PYS/8NYUaUpakREck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv7PImP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv7PImP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B349C2BCB3;
	Thu, 14 May 2026 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766836;
	bh=kVVZno89j5J9uM8cdi6t6eaD93yE+XrzOIo6hZ1j5Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lv7PImP7G0NAK9xh9zYJkV3ASKizEONiamrMh3hEJ+vvvriEKp0VWtBmQnzC2NZ+I
	 BSKUIn3vRnmCFyqi+HfKGGAemQgkfRQfEUj2OxApjWnyaygfCbWjdLmk2Egk+STE0s
	 MNwLjpmsDJ8Ny8SfApjvcbVlRYsVXB+g0RiSeLCD76FM5Fvpor9oNg8Q7ankObKO93
	 tvno9OKizbtaNvbFLNYO/XwKycVTWZafIY3dyKRsyCRRjBfBcSetsLWDHVaSyIiae3
	 G/XS99WpcDxHKxK/B1R+NqGTHs2TNisSncLj558j/2E9Xsax+1JwLGxhb6xD36lJDv
	 kLEh5pjdzFwwQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Date: Thu, 14 May 2026 15:53:36 +0200
Message-ID: <20260514135342.22130-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514135342.22130-1-jolsa@kernel.org>
References: <20260514135342.22130-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andrii reported an issue with optimized uprobes [1] that can clobber
redzone area with call instruction storing return address on stack
where user code may keep temporary data without adjusting rsp.

Fixing this by moving the optimized uprobes on top of 10-bytes nop
instruction, so we can squeeze another instruction to escape the
redzone area before doing the call, like:

  lea -0x80(%rsp), %rsp
  call tramp

Note the lea instruction is used to adjust the rsp register without
changing the flags.

The optimized uprobe performance stays the same:

        uprobe-nop     :    3.129 ± 0.013M/s
        uprobe-push    :    3.045 ± 0.006M/s
        uprobe-ret     :    1.095 ± 0.004M/s
  -->   uprobe-nop10   :    7.170 ± 0.020M/s
        uretprobe-nop  :    2.143 ± 0.021M/s
        uretprobe-push :    2.090 ± 0.000M/s
        uretprobe-ret  :    0.942 ± 0.000M/s
  -->   uretprobe-nop10:    3.381 ± 0.003M/s
        usdt-nop       :    3.245 ± 0.004M/s
  -->   usdt-nop10     :    7.256 ± 0.023M/s

[1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..f7c4101a4039 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -636,9 +636,21 @@ struct uprobe_trampoline {
 	unsigned long		vaddr;
 };
 
+#define LEA_INSN_SIZE		5
+#define OPT_INSN_SIZE		(LEA_INSN_SIZE + CALL_INSN_SIZE)
+#define OPT_JMP8_OFFSET		(OPT_INSN_SIZE - JMP8_INSN_SIZE)
+#define REDZONE_SIZE		0x80
+
+static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
+
+static bool is_lea_insn(const uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
+}
+
 static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
 {
-	long delta = (long)(vaddr + 5 - vtramp);
+	long delta = (long)(vaddr + OPT_INSN_SIZE - vtramp);
 
 	return delta >= INT_MIN && delta <= INT_MAX;
 }
@@ -651,7 +663,7 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	};
 	unsigned long low_limit, high_limit;
 	unsigned long low_tramp, high_tramp;
-	unsigned long call_end = vaddr + 5;
+	unsigned long call_end = vaddr + OPT_INSN_SIZE;
 
 	if (check_add_overflow(call_end, INT_MIN, &low_limit))
 		low_limit = PAGE_SIZE;
@@ -826,8 +838,8 @@ SYSCALL_DEFINE0(uprobe)
 	regs->ax  = args.ax;
 	regs->r11 = args.r11;
 	regs->cx  = args.cx;
-	regs->ip  = args.retaddr - 5;
-	regs->sp += sizeof(args);
+	regs->ip  = args.retaddr - OPT_INSN_SIZE;
+	regs->sp += sizeof(args) + REDZONE_SIZE;
 	regs->orig_ax = -1;
 
 	sp = regs->sp;
@@ -844,12 +856,12 @@ SYSCALL_DEFINE0(uprobe)
 	 */
 	if (regs->sp != sp) {
 		/* skip the trampoline call */
-		if (args.retaddr - 5 == regs->ip)
-			regs->ip += 5;
+		if (args.retaddr - OPT_INSN_SIZE == regs->ip)
+			regs->ip += OPT_INSN_SIZE;
 		return regs->ax;
 	}
 
-	regs->sp -= sizeof(args);
+	regs->sp -= sizeof(args) + REDZONE_SIZE;
 
 	/* for the case uprobe_consumer has changed ax/r11/cx */
 	args.ax  = regs->ax;
@@ -857,7 +869,7 @@ SYSCALL_DEFINE0(uprobe)
 	args.cx  = regs->cx;
 
 	/* keep return address unless we are instructed otherwise */
-	if (args.retaddr - 5 != regs->ip)
+	if (args.retaddr - OPT_INSN_SIZE != regs->ip)
 		args.retaddr = regs->ip;
 
 	if (shstk_push(args.retaddr) == -EFAULT)
@@ -891,7 +903,7 @@ asm (
 	"pop %rax\n"
 	"pop %r11\n"
 	"pop %rcx\n"
-	"ret\n"
+	"ret $" __stringify(REDZONE_SIZE) "\n"
 	"int3\n"
 	".balign " __stringify(PAGE_SIZE) "\n"
 	".popsection\n"
@@ -909,7 +921,7 @@ late_initcall(arch_uprobes_init);
 
 enum {
 	EXPECT_SWBP,
-	EXPECT_CALL,
+	EXPECT_OPTIMIZED,
 };
 
 struct write_opcode_ctx {
@@ -930,17 +942,18 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 		       int nbytes, void *data)
 {
 	struct write_opcode_ctx *ctx = data;
-	uprobe_opcode_t old_opcode[5];
+	uprobe_opcode_t old_opcode[OPT_INSN_SIZE];
 
-	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+	uprobe_copy_from_page(page, ctx->base, old_opcode, OPT_INSN_SIZE);
 
 	switch (ctx->expect) {
 	case EXPECT_SWBP:
 		if (is_swbp_insn(&old_opcode[0]))
 			return 1;
 		break;
-	case EXPECT_CALL:
-		if (is_call_insn(&old_opcode[0]))
+	case EXPECT_OPTIMIZED:
+		if (is_lea_insn(&old_opcode[0]) &&
+		    is_call_insn(&old_opcode[LEA_INSN_SIZE]))
 			return 1;
 		break;
 	}
@@ -963,7 +976,7 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
  *   - SMP sync all CPUs
  */
 static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		       unsigned long vaddr, char *insn, bool optimize)
+		       unsigned long vaddr, char *insn, int size, bool optimize)
 {
 	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
 	struct write_opcode_ctx ctx = {
@@ -978,7 +991,7 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	 * so we can skip this step for optimize == true.
 	 */
 	if (!optimize) {
-		ctx.expect = EXPECT_CALL;
+		ctx.expect = EXPECT_OPTIMIZED;
 		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
 				   true /* is_register */, false /* do_update_ref_ctr */,
 				   &ctx);
@@ -990,7 +1003,7 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 
 	/* Write all but the first byte of the patched range. */
 	ctx.expect = EXPECT_SWBP;
-	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, size - 1, verify_insn,
 			   true /* is_register */, false /* do_update_ref_ctr */,
 			   &ctx);
 	if (err)
@@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			 unsigned long vaddr, unsigned long tramp)
 {
-	u8 call[5];
+	u8 insn[OPT_INSN_SIZE], *call = &insn[LEA_INSN_SIZE];
 
-	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
+	/*
+	 * We have nop10 instruction (with first byte overwritten to int3),
+	 * changing it to:
+	 *   lea -0x80(%rsp), %rsp
+	 *   call tramp
+	 */
+	memcpy(insn, lea_rsp, LEA_INSN_SIZE);
+	__text_gen_insn(call, CALL_INSN_OPCODE,
+			(const void *) (vaddr + LEA_INSN_SIZE),
 			(const void *) tramp, CALL_INSN_SIZE);
-	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
+	return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true /* optimize */);
 }
 
 static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			   unsigned long vaddr)
 {
-	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
+	/*
+	 * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
+	 * end of the 10-byte slot instead of restoring the original nop10,
+	 * because we could have thread already inside lea instruction.
+	 */
+	u8 jmp[OPT_INSN_SIZE] = { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
+
+	return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, false /* optimize */);
 }
 
 static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst, int len)
@@ -1049,19 +1077,21 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
 	struct __packed __arch_relative_insn {
 		u8 op;
 		s32 raddr;
-	} *call = (struct __arch_relative_insn *) insn;
+	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
-	if (!is_call_insn(insn))
+	if (!is_lea_insn(insn))
+		return false;
+	if (!is_call_insn(insn + LEA_INSN_SIZE))
 		return false;
-	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+	return __in_uprobe_trampoline(vaddr + OPT_INSN_SIZE + call->raddr);
 }
 
 static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 {
-	uprobe_opcode_t insn[5];
+	uprobe_opcode_t insn[OPT_INSN_SIZE];
 	int err;
 
-	err = copy_from_vaddr(mm, vaddr, &insn, 5);
+	err = copy_from_vaddr(mm, vaddr, &insn, OPT_INSN_SIZE);
 	if (err)
 		return err;
 	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
@@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		  unsigned long vaddr)
 {
 	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
-		int ret = is_optimized(vma->vm_mm, vaddr);
-		if (ret < 0)
+		uprobe_opcode_t insn[OPT_INSN_SIZE];
+		int ret;
+
+		ret = copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
+		if (ret)
 			return ret;
-		if (ret) {
+		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
 			ret = swbp_unoptimize(auprobe, vma, vaddr);
 			WARN_ON_ONCE(ret);
 			return ret;
 		}
+		/*
+		 * We can have re-attached probe on top of jmp8 instruction,
+		 * which did not get optimized. We need to restore the jmp8
+		 * instruction, instead of the original instruction (nop10).
+		 */
+		if (is_swbp_insn(&insn[0]) && insn[1] == OPT_JMP8_OFFSET)
+			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
+						   false /* is_register */);
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
 				   false /* is_register */);
@@ -1131,7 +1172,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn[5];
+	uprobe_opcode_t insn[OPT_INSN_SIZE];
 
 	if (!should_optimize(auprobe))
 		return;
@@ -1142,7 +1183,7 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 	 * Check if some other thread already optimized the uprobe for us,
 	 * if it's the case just go away silently.
 	 */
-	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+	if (copy_from_vaddr(mm, vaddr, &insn, OPT_INSN_SIZE))
 		goto unlock;
 	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
 		goto unlock;
@@ -1160,14 +1201,24 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
-	if (!insn->x86_64 || insn->length != 5)
+	if (!insn->x86_64)
 		return false;
 
-	if (!insn_is_nop(insn))
+	/* We can't do cross page atomic writes yet. */
+	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < OPT_INSN_SIZE)
 		return false;
 
-	/* We can't do cross page atomic writes yet. */
-	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+	/* We can optimize on top of nop10.. */
+	if (insn->length == OPT_INSN_SIZE && insn_is_nop(insn))
+		return true;
+
+	/* .. and JMP rel8 to end of slot — check swbp_unoptimize. */
+	if (insn->length == 2 &&
+	    insn->opcode.bytes[0] == JMP8_INSN_OPCODE &&
+	    insn->immediate.value == OPT_JMP8_OFFSET)
+		return true;
+
+	return false;
 }
 #else /* 32-bit: */
 /*
-- 
2.53.0


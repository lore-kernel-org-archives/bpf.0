Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650703D9DA1;
	Thu, 21 May 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367499; cv=none; b=PhRstxk8XHm0fYWhUocL6iaVyKR+9S33BtdOZMWPSRjH3kZqf/KOgOJVrWaIESJk/OBf3nhB/dJvK7ZvPVDhiXDv9smjzRpfBS7EzcdUekLYRlkatxeaehlHd28CeR2AAv+EdWoFI9tG4/DxXswu6QHnfAlRXO9om2slqv3CwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367499; c=relaxed/simple;
	bh=mBXwVtubccBmPFU4yYPfbd/zEzOoaonKdIoq77cCffE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olBsnjm2Xd2cjV8VTduwSDZyd3B2PvaRwJMPZvK0SZBnT6nvfGzfKkuzFvXOaRxjpMvkE87JNy32xHa3sNpVW0ghWDQLzt5gySIKlvRy8nBQYox4+IrdMxm8vIPD0oajelP9Yqs1eawTRk7uleK4hGEkkHXDkst4ImzI3N3MGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0AesM4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0AesM4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE91F00A3C;
	Thu, 21 May 2026 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367495;
	bh=DiOPHpJ4/TzzyCvLRuPXLTpTi7Nuo4wxPRv1T9Rrw58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0AesM4kShsgyGaxsdU3GZ6u4f2sB4D5fWWZp8Z3VZ4ZluJBI37nRaaD9qk3Oaxyq
	 XMZVePlzeC+cVP/deNgzcYJMTgKnAtZRTlvnyqqm8gPMTqc2yLe6b2rdh4jeJL2+96
	 yecsYsfk/hUgf/P0itMYeUHi+gQ2wni7ZeU6LFJKP7tslInTWWYuIIEYAhYe6rI+gb
	 ISrxAMly68TWVhS3fiOZjw6MoY1zuFx8X3ya6GVlqsPhlrDKisDdNXTl4FtJkCU6OZ
	 ui/1JShgTI70Tl4sqwRYoui/KFWkrm8msAfuZTRlDmY7N+InN35qGMUvx0Wo6wdUDY
	 OiEFNUyw0lyTw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to nop10
Date: Thu, 21 May 2026 14:44:03 +0200
Message-ID: <20260521124411.31133-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
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

We use nop10 and following transofrmation to optimized instructions
above and back as suggested by Peterz [2].

Optimize path (int3_update_optimize):

  1) Initial state after set_swbp() installed the uprobe:
      cc 2e 0f 1f 84 00 00 00 00 00

     From offset 0 this is INT3 followed by the tail of the original
     10-byte NOP.

  2) Trap the call slot before rewriting the NOP tail:
      cc 2e 0f 1f 84 [cc] 00 00 00 00

     From offset 0 this traps on the uprobe INT3.  A thread reaching
     offset 5 traps on the temporary INT3 instead of seeing a partially
     patched call.

  3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
      cc [8d 64 24 80] cc [d0 d1 d2 d3]

     From offset 0 and offset 5 this still traps.  The bytes between
     them are not executable entry points while both traps are in place.

  4) Restore the call opcode at offset 5:
      cc 8d 64 24 80 [e8] d0 d1 d2 d3

     From offset 0 this still traps.  From offset 5 the instruction is
     the final CALL to the uprobe trampoline.

  5) Publish the first LEA byte:
      [48] 8d 64 24 80 e8 d0 d1 d2 d3

     From offset 0 this is:
        lea -0x80(%rsp), %rsp
        call <uprobe-trampoline>

Unoptimize path (int3_update_unoptimize):

  1) Initial optimized state:
      48 8d 64 24 80 e8 d0 d1 d2 d3
     Same as 5) above.

  2) Trap new entries before restoring the NOP bytes:
      [cc] 8d 64 24 80 e8 d0 d1 d2 d3

     From offset 0 this traps. A thread that had already executed the
     LEA can still reach the intact CALL at offset 5.

  3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
     and byte 5 as CALL.
      cc [2e 0f 1f 84] e8 d0 d1 d2 d3

     From offset 0 this still traps. Offset 5 is still the CALL for any
     thread that was already past the first LEA byte.

  4) Publish the first byte of the original NOP:
      [66] 2e 0f 1f 84 e8 d0 d1 d2 d3

     From offset 0 this is the restored 10-byte NOP; the CALL opcode and
     displacement are now only NOP operands.  Offset 5 still decodes as
     CALL for a thread that was already there.

Note as explained in [2] we need to use following nop10:
       PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)

which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
attribute in is_prefix_bad function.

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
[2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Assisted-by: Codex:GPT-5.5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 281 +++++++++++++++++++++++++++++---------
 1 file changed, 217 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 11ec6b89b135..16d9c584b995 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -266,7 +266,6 @@ static bool is_prefix_bad(struct insn *insn)
 		attr = inat_get_opcode_attribute(p);
 		switch (attr) {
 		case INAT_MAKE_PREFIX(INAT_PFX_ES):
-		case INAT_MAKE_PREFIX(INAT_PFX_CS):
 		case INAT_MAKE_PREFIX(INAT_PFX_DS):
 		case INAT_MAKE_PREFIX(INAT_PFX_SS):
 		case INAT_MAKE_PREFIX(INAT_PFX_LOCK):
@@ -631,9 +630,29 @@ static struct vm_special_mapping tramp_mapping = {
 	.pages  = tramp_mapping_pages,
 };
 
+
+#define LEA_INSN_SIZE		5
+#define OPT_INSN_SIZE		(LEA_INSN_SIZE + CALL_INSN_SIZE)
+#define REDZONE_SIZE		0x80
+
+static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
+
+static bool is_opt_insns(const uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, lea_rsp, LEA_INSN_SIZE) &&
+	       insn[LEA_INSN_SIZE] == CALL_INSN_OPCODE;
+}
+
+static bool is_swbp_opt_insns(uprobe_opcode_t *insn)
+{
+	return is_swbp_insn(&insn[0]) &&
+	       !memcmp(&insn[1], &lea_rsp[1], LEA_INSN_SIZE - 1) &&
+	       insn[LEA_INSN_SIZE] == CALL_INSN_OPCODE;
+}
+
 static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
 {
-	long delta = (long)(vaddr + 5 - vtramp);
+	long delta = (long)(vaddr + OPT_INSN_SIZE - vtramp);
 
 	return delta >= INT_MIN && delta <= INT_MAX;
 }
@@ -646,7 +665,7 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	};
 	unsigned long low_limit, high_limit;
 	unsigned long low_tramp, high_tramp;
-	unsigned long call_end = vaddr + 5;
+	unsigned long call_end = vaddr + OPT_INSN_SIZE;
 
 	if (check_add_overflow(call_end, INT_MIN, &low_limit))
 		low_limit = PAGE_SIZE;
@@ -754,7 +773,7 @@ SYSCALL_DEFINE0(uprobe)
 
 	/* Allow execution only from uprobe trampolines. */
 	if (!in_uprobe_trampoline(regs->ip))
-		return -ENXIO;
+		return -EPROTO;
 
 	err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
 	if (err)
@@ -770,8 +789,8 @@ SYSCALL_DEFINE0(uprobe)
 	regs->ax  = args.ax;
 	regs->r11 = args.r11;
 	regs->cx  = args.cx;
-	regs->ip  = args.retaddr - 5;
-	regs->sp += sizeof(args);
+	regs->ip  = args.retaddr - OPT_INSN_SIZE;
+	regs->sp += sizeof(args) + REDZONE_SIZE;
 	regs->orig_ax = -1;
 
 	sp = regs->sp;
@@ -788,12 +807,12 @@ SYSCALL_DEFINE0(uprobe)
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
@@ -801,7 +820,7 @@ SYSCALL_DEFINE0(uprobe)
 	args.cx  = regs->cx;
 
 	/* keep return address unless we are instructed otherwise */
-	if (args.retaddr - 5 != regs->ip)
+	if (args.retaddr - OPT_INSN_SIZE != regs->ip)
 		args.retaddr = regs->ip;
 
 	if (shstk_push(args.retaddr) == -EFAULT)
@@ -835,7 +854,7 @@ asm (
 	"pop %rax\n"
 	"pop %r11\n"
 	"pop %rcx\n"
-	"ret\n"
+	"ret $" __stringify(REDZONE_SIZE) "\n"
 	"int3\n"
 	".balign " __stringify(PAGE_SIZE) "\n"
 	".popsection\n"
@@ -853,7 +872,9 @@ late_initcall(arch_uprobes_init);
 
 enum {
 	EXPECT_SWBP,
-	EXPECT_CALL,
+	EXPECT_DUAL_SWBP,
+	EXPECT_OPTIMIZED,
+	EXPECT_SWBP_OPTIMIZED,
 };
 
 struct write_opcode_ctx {
@@ -861,30 +882,34 @@ struct write_opcode_ctx {
 	int expect;
 };
 
-static int is_call_insn(uprobe_opcode_t *insn)
-{
-	return *insn == CALL_INSN_OPCODE;
-}
-
 /*
- * Verification callback used by int3_update uprobe_write calls to make sure
- * the underlying instruction is as expected - either int3 or call.
+ * Verification callback used by uprobe_write calls to make sure the underlying
+ * instruction is in the expected stage of the INT3 update sequence.
  */
 static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
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
+	case EXPECT_DUAL_SWBP:
+		if (is_swbp_insn(&old_opcode[0]) &&
+		    is_swbp_insn(&old_opcode[LEA_INSN_SIZE]))
+			return 1;
+		break;
+	case EXPECT_OPTIMIZED:
+		if (is_opt_insns(&old_opcode[0]))
+			return 1;
+		break;
+	case EXPECT_SWBP_OPTIMIZED:
+		if (is_swbp_opt_insns(&old_opcode[0]))
 			return 1;
 		break;
 	}
@@ -893,48 +918,134 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 }
 
 /*
- * Modify multi-byte instructions by using INT3 breakpoints on SMP.
+ * Modify the optimized instruction by using INT3 breakpoints on SMP.
  * We completely avoid using stop_machine() here, and achieve the
  * synchronization using INT3 breakpoints and SMP cross-calls.
  * (borrowed comment from smp_text_poke_batch_finish)
  *
- * The way it is done:
- *   - Add an INT3 trap to the address that will be patched
- *   - SMP sync all CPUs
- *   - Update all but the first byte of the patched range
- *   - SMP sync all CPUs
- *   - Replace the first byte (INT3) by the first byte of the replacing opcode
- *   - SMP sync all CPUs
+ * The way it is done for optimization (int3_update_optimize):
+ *   1) Start with the uprobe INT3 trap already installed
+ *   2) Add an INT3 trap to the call slot
+ *   3) Update everything but the first byte and the call opcode
+ *   4) Replace the call slot INT3 by the call opcode
+ *   5) Replace the first INT3 by the first byte of the LEA instruction
+ *
+ * The way it is done for unoptimization (int3_update_unoptimize):
+ *   1) Start with the optimized uprobe lea/call instructions
+ *   2) Add an INT3 trap to the address that will be patched
+ *   3) Restore the NOP bytes before the call opcode
+ *   4) Replace the first INT3 by the first byte of the NOP instruction
+ *
+ * Note that unoptimization deliberately keeps the call opcode and displacement
+ * in bytes 5..9. Those bytes become operands of the restored 10-byte NOP.
  */
-static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		       unsigned long vaddr, char *insn, bool optimize)
+static int int3_update_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+				unsigned long vaddr, uprobe_opcode_t *insn)
 {
 	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	uprobe_opcode_t opt_int3[OPT_INSN_SIZE];
 	struct write_opcode_ctx ctx = {
 		.base = vaddr,
 	};
 	int err;
 
 	/*
-	 * Write int3 trap.
+	 * 1) Initial state after set_swbp() installed the uprobe:
+	 *    cc 2e 0f 1f 84 00 00 00 00 00
+	 */
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * 2) Trap the call slot before rewriting the NOP tail:
+	 *    cc 2e 0f 1f 84 [cc] 00 00 00 00
+	 */
+	ctx.expect = EXPECT_SWBP;
+	err = uprobe_write(auprobe, vma, vaddr + LEA_INSN_SIZE, &int3, 1, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	memcpy(opt_int3, insn, OPT_INSN_SIZE);
+	opt_int3[LEA_INSN_SIZE] = UPROBE_SWBP_INSN;
+
+	/*
+	 * 3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
+	 *    cc [8d 64 24 80] cc [d0 d1 d2 d3]
+	 */
+	ctx.expect = EXPECT_DUAL_SWBP;
+	err = uprobe_write(auprobe, vma, vaddr + 1, opt_int3 + 1,
+			   OPT_INSN_SIZE - 1, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		goto error;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * 4) Restore the call opcode at offset 5.
+	 *    cc 8d 64 24 80 [e8] d0 d1 d2 d3
+	 */
+	err = uprobe_write(auprobe, vma, vaddr + LEA_INSN_SIZE,
+			   insn + LEA_INSN_SIZE, 1, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		goto error;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * 5) Publish the first LEA byte:
+	 *    [48] 8d 64 24 80 e8 d0 d1 d2 d3
 	 *
-	 * The swbp_optimize path comes with breakpoint already installed,
-	 * so we can skip this step for optimize == true.
+	 *    From offset 0 this is:
+	 *      lea -0x80(%rsp), %rsp
+	 *      call <uprobe-trampoline>
 	 */
-	if (!optimize) {
-		ctx.expect = EXPECT_CALL;
-		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
-				   true /* is_register */, false /* do_update_ref_ctr */,
-				   &ctx);
-		if (err)
-			return err;
-	}
+	ctx.expect = EXPECT_SWBP_OPTIMIZED;
+	err = uprobe_write(auprobe, vma, vaddr, insn, 1, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		goto error;
 
 	smp_text_poke_sync_each_cpu();
+	return 0;
 
-	/* Write all but the first byte of the patched range. */
+error:
+	/*
+	 * In all intermediate states byte 0 is INT3, so EXPECT_SWBP covers every
+	 * case.  Restore original NOP bytes 1..9 in one write.
+	 */
 	ctx.expect = EXPECT_SWBP;
-	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+	uprobe_write(auprobe, vma, vaddr + 1, auprobe->insn + 1, OPT_INSN_SIZE - 1,
+		     verify_insn, true, false, &ctx);
+	smp_text_poke_sync_each_cpu();
+	return err;
+}
+
+static int int3_update_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+				  unsigned long vaddr, uprobe_opcode_t *insn)
+{
+	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_OPTIMIZED,
+	};
+	int err;
+
+	/*
+	 * 1) Initial optimized state:
+	 *    48 8d 64 24 80 e8 d0 d1 d2 d3
+	 *
+	 * 2) Trap new entries before restoring the NOP bytes:
+	 *    [cc] 8d 64 24 80 e8 d0 d1 d2 d3
+	 */
+	err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
 			   true /* is_register */, false /* do_update_ref_ctr */,
 			   &ctx);
 	if (err)
@@ -943,13 +1054,31 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	smp_text_poke_sync_each_cpu();
 
 	/*
-	 * Write first byte.
+	 * 3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
+	 *    and byte 5 as CALL:
+	 *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
+	 */
+	ctx.expect = EXPECT_SWBP_OPTIMIZED;
+	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
+			   LEA_INSN_SIZE - 1, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * 4) Publish the first byte of the original NOP:
+	 *    [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
 	 *
-	 * The swbp_unoptimize needs to finish uprobe removal together
-	 * with ref_ctr update, using uprobe_write with proper flags.
+	 * From offset 0 this is the restored 10-byte NOP; the CALL opcode and
+	 * displacement are now only NOP operands.  Offset 5 still decodes as
+	 * CALL for a thread that was already there.
 	 */
+	ctx.expect = EXPECT_SWBP;
 	err = uprobe_write(auprobe, vma, vaddr, insn, 1, verify_insn,
-			   optimize /* is_register */, !optimize /* do_update_ref_ctr */,
+			   false /* is_register */, true /* do_update_ref_ctr */,
 			   &ctx);
 	if (err)
 		return err;
@@ -961,17 +1090,25 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
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
+	return int3_update_optimize(auprobe, vma, vaddr, insn);
 }
 
 static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			   unsigned long vaddr)
 {
-	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
+	return int3_update_unoptimize(auprobe, vma, vaddr, auprobe->insn);
 }
 
 static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst, int len)
@@ -993,19 +1130,19 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
 	struct __packed __arch_relative_insn {
 		u8 op;
 		s32 raddr;
-	} *call = (struct __arch_relative_insn *) insn;
+	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
-	if (!is_call_insn(insn))
+	if (!is_opt_insns(insn))
 		return false;
-	return __in_uprobe_trampoline(mm, vaddr + 5 + call->raddr);
+	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
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
 	return __is_optimized(mm, (uprobe_opcode_t *)&insn, vaddr);
@@ -1069,7 +1206,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn[5];
+	uprobe_opcode_t insn[OPT_INSN_SIZE];
 
 	if (!should_optimize(auprobe))
 		return;
@@ -1080,7 +1217,7 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 	 * Check if some other thread already optimized the uprobe for us,
 	 * if it's the case just go away silently.
 	 */
-	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+	if (copy_from_vaddr(mm, vaddr, &insn, OPT_INSN_SIZE))
 		goto unlock;
 	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
 		goto unlock;
@@ -1096,16 +1233,32 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 	mmap_write_unlock(mm);
 }
 
+static bool is_optimizable_nop10(struct insn *insn)
+{
+	static const u8 nop10_prefix[] = {
+		0x66, 0x2e, 0x0f, 0x1f, 0x84
+	};
+
+	/*
+	 * Restrict this to the 10-byte NOP form whose last 5 bytes are
+	 * SIB/displacement operands. Unoptimization keeps the call opcode and
+	 * displacement in those bytes, so other NOP encodings are not safe.
+	 */
+	return insn->length == OPT_INSN_SIZE &&
+	       insn_is_nop(insn) &&
+	       !memcmp(insn->kaddr, nop10_prefix, ARRAY_SIZE(nop10_prefix));
+}
+
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
-	if (!insn->x86_64 || insn->length != 5)
+	if (!insn->x86_64)
 		return false;
 
-	if (!insn_is_nop(insn))
+	if (!is_optimizable_nop10(insn))
 		return false;
 
 	/* We can't do cross page atomic writes yet. */
-	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= OPT_INSN_SIZE;
 }
 #else /* 32-bit: */
 /*
-- 
2.53.0


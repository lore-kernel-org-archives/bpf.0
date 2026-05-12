Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AB03D79F6
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605592; cv=none; b=TReGzi6+tT+hNnIkWE/CPojZrRmk8AW/9GLr38XREHEmh/2KYG9jTKzWlDWdwN1tPEEZzUoGqxpUB1+UYxKB9TR+bay18MIEEel2dbIMMc/0+dPvZ72q8NsPffz3tH2hcA09ekiitXEAmLDYZgMTsZ7RPMTM2bNH5LP1JE1+WWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605592; c=relaxed/simple;
	bh=5NKnh+9NRaVgN+WMfT2O/l/orB8LNlDax+pD/PsaX6c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TapVegrkBiqhvnDYgGjE2tAFQmai+UzibYwtPvc+PvgJLlO4OaIN9YHFJc/C+XQx36ZZRDP9zBaTMhkmVN9UZ463lMgfz7EPLUPNOFMSPnHvp4gMnSr4wXSJFhc4NdN3feJLIDnFBoMNickG+4m++e/D+v2fJHehJ4bAOxnCqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zsp7iaVg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsp7iaVg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso66749575e9.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605589; x=1779210389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CsBdMULzYpxL3Kn6EioOEUhiC87hHkNyBZCKpZbNhCw=;
        b=Zsp7iaVgXt9H87CVdyAbZ50Y5BLLIzjGzOI4HDIaLHqr4dfJVVYffLooctgqqb2gHg
         Zhy6RCwOXDW81JYUHNCVzn4JLJTRK5GXh7cEqDhCyxrafRqCJ9zBDlfGjm4Kp0vXZGfu
         dLg4Gw9vse9t3m6EK294IQGrB7YzEYFVzWgeJv3xZrGTsxF3FBSY2+6USO3+FcF5gVy8
         GZZl3buvaQn/DaBi7NJdN26uQc5RF971E2WtNv6ziR6CfV5667X340wWiN/kG4CjZrLY
         fmrzP8XHKLSofJ7mxLdLsNIkGCfNL5UObA8MkfXqdRFcijWLodOj0lSta+QoLsBe8J13
         unOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605589; x=1779210389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsBdMULzYpxL3Kn6EioOEUhiC87hHkNyBZCKpZbNhCw=;
        b=qtz0Ll9XA9QaFr9duL/R4iB67WX3zxQs17hQK4NgdZuqoXTXq+nsmH2GKwB7LR/1OJ
         C4ds099wvWoxJwHhzNnnLsznKA61wXgPjkBIoZhmsbUz810DaXovNJGfj5e2jI5JkI9x
         Bz40GogO1RR0P29ujTJcm2o5K4P05/YIpVStI2875CpUud3Ino2tudPF4LEw+wxbeLjY
         UX/WmfQ4smkEyM4fatCPK1YsLadzTkNNCp3ZL5xbSXWrwcNg3fbKDOquaLSyFYIC/TXV
         tX7e39i7F2rGHZRe9yEDi1yCI7T3jSjm6UyqQLeHkFbt1uGBXX7VAXE0Q006ilFEF3Jd
         s5BQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NVQ/wfBz678Hx9pMeh2rxKyAnqr8WSFbJteHbSvUULLaSO+Nlzb38uqwn4CQ1nhj2MOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqCS/vYeJLrlBqM08W8fyTvPcLGmv986Ksb3Xi/IwnGAiDR3s
	Tit99pAzyAVV6xBgLoUUkDMd/vOtdBOteL/n2AMEOAw0fYQiTCheBL0X
X-Gm-Gg: Acq92OHlhMex0Y5nBD7oTOvvjRtZoEDmiK9rsbI6UzmsKBMg7VigbGWBX8Mc60B4naG
	GJAV00LWh6cvc5vQ5oEBG2Pyq8m211aUyUMlOA2V8lyhUzrsbYxXV3fCxWvD2C7L5i5Hg6cFnTz
	KCLqsQa0bI+9D0TgFb76dWbMJ/islJK3ZAT2R8AGbVgAh/Wc5j27mMDHUNvNcgVMRUHV6p5AvZY
	5cYqz9WtB6/d1gMa663wdgAvF0GxLJDIn21H4YddD6ku4TA8FNLtvriJAAtjYR2qaroDiqsfFjG
	wXzQt8hmDttijBhyWU5ZHFttDWpudsflkh6RzFrlfAL4Elk5KPBtpwdmVi8BaeeKZjJ4IKVbKrY
	uqtG3WDMI6waYu1HV4W7sWJiWQq9b0mzWAGyTXeR9HzzoZB65cZmE3mFBfJJhGhhHD6XCwcT1cD
	nUtZHVNgHlBnQ=
X-Received: by 2002:a05:600c:a305:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48e51e08362mr315443155e9.2.1778605589214;
        Tue, 12 May 2026 10:06:29 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm33640764f8f.14.2026.05.12.10.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:06:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 May 2026 19:06:27 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	oleg@redhat.com, peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agNeEzjiThzmJHiP@krava>
References: <20260509003146.976844-1-andrii@kernel.org>
 <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512141431.a70375744fdae263bda5b722@kernel.org>

On Tue, May 12, 2026 at 02:14:31PM +0900, Masami Hiramatsu wrote:
> On Sun, 10 May 2026 23:25:26 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Fri, May 08, 2026 at 05:30:56PM -0700, Andrii Nakryiko wrote:
> > > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > > probe site with a CALL into a uprobe trampoline. CALL pushes a return
> > > address to [rsp-8]. On x86-64 this is inside the 128-byte red zone, where
> > > user code may keep temporary data without adjusting rsp.
> > > 
> > > Use a 5-byte JMP instead. JMP does not write to the user stack, but it
> > > also does not provide a return address. Replace the single trampoline
> > > entry with a page of 16-byte slots. Each optimized probe jumps to its
> > > assigned slot, the slot moves rsp below the red zone, saves the registers
> > > clobbered by syscall, and invokes the uprobe syscall:
> > > 
> > >   Probe site:   jmp slot_N              (5B, replaces nop5)
> > > 
> > >   Slot N:       lea  -128(%rsp), %rsp   (5B)  skip red zone
> > >                 push %rcx               (1B)  save (syscall clobbers)
> > >                 push %r11               (2B)  save (syscall clobbers)
> > >                 push %rax               (1B)  save (syscall uses for nr)
> > >                 mov  $336, %eax         (5B)  uprobe syscall number
> > >                 syscall                 (2B)
> > > 
> > > All slots contain identical code at different offsets, so the trampoline
> > > page is generated once at boot and mapped read-execute into each process.
> > > The syscall handler identifies the slot from regs->ip, which points just
> > > after the syscall instruction, and uses a per-mm slot table to recover the
> > > original probe address.
> > > 
> > > The uprobe syscall does not return to the trampoline slot. The handler
> > > restores the probe-site register state, runs the uprobe consumers, sets
> > > pt_regs to continue at probe_addr + 5 unless a consumer redirected
> > > execution, and returns directly through the IRET path. This preserves
> > > general purpose registers, including rcx and r11, without requiring any
> > > post-syscall cleanup code in the trampoline and avoids call/ret, RSB, and
> > > shadow stack concerns.
> > > 
> > > Protect the per-mm trampoline list with RCU and free trampoline metadata
> > > with kfree_rcu(). This lets the syscall path resolve trampoline slots
> > > without taking mmap_lock. The optimized-instruction detection path also
> > > walks the trampoline list under an RCU read-side lock. Since that path
> > > starts from the JMP target, it translates the slot start to the post-syscall
> > > IP expected by the shared resolver before checking the trampoline mapping.
> > > 
> > > Each trampoline page provides 256 slots. Slots stay permanently assigned
> > > to their first probe address and are reused only when the same address is
> > > probed again. Reassigning detached slots is deliberately avoided because a
> > > thread can remain in a trampoline for an unbounded time due to ptrace,
> > > interrupts, or scheduling delays. If a reachable trampoline page runs out
> > > of slots, probes that cannot allocate a slot fall back to the slower INT3
> > > path.
> > > 
> > > Require the entire trampoline page to be reachable by a rel32 JMP before
> > > reusing it for a probe. This keeps every slot in the page within the range
> > > that can be encoded at the probe site.
> > > 
> > > Change the error code returned when the uprobe syscall is invoked outside
> > > a kernel-generated trampoline from -ENXIO to -EPROTO. This lets libbpf and
> > > similar libraries distinguish fixed kernels from kernels with the
> > > red-zone-clobbering implementation and enable nop5 optimization only on
> > > fixed kernels.
> > > 
> > > Performance (usdt single-thread, M/s):
> > > 
> > >                   usdt-nop  usdt-nop5-base  usdt-nop5-fix  nop5-change  iret%
> > >   Skylake          3.149        6.422          4.865         -24.3%     39.1%
> > >   Milan            2.910        3.443          3.820         +11.0%     24.3%
> > >   Sapphire Rapids  1.896        4.023          3.693          -8.2%     24.9%
> > >   Bergamo          3.393        3.895          3.849          -1.2%     24.5%
> > > 
> > > The fixed nop5 path remains faster than the non-optimized INT3 path on all
> > > measured systems. The regression relative to the old CALL-based trampoline
> > > comes from IRET being more expensive than SYSRET, most noticeably on older
> > > Intel Skylake. Newer Intel CPUs and tested AMD CPUs have lower IRET cost,
> > > and AMD Milan improves because removing mmap_lock from the hot path more
> > > than offsets the IRET cost.
> > > 
> > > Multi-threaded throughput scales nearly linearly with the number of CPUs, like
> > > it used to, thanks to lockless RCU-protected uprobe trampoline lookup.
> > 
> > hi,
> > thanks a lot for the fix
> > 
> > FWIW we discussed also an option to have 10-bytes nop and do:
> >   [rsp+0x80, call trampoline]
> > 
> > we would not need the slots re-use logic, but not sure what other
> > surprises there are with 10-bytes nop
> 
> Does this mean we have to update UDST implementation?

it's the optimized uprobe code, that's used for usdt that emits nop5 instead
of single nop

> 
> > 
> > I tried that change [1], it seems to work, but it has other
> > difficulties, like I think the unoptimized path needs to do:
> >   [rsp+0x80, call trampoline] -> [jmp end of 10-bytes nop]
> > instead of patching back the 10-byte nop, because some thread
> > could be inside the nop area already.
> 
> Yeah, but at that moment, we know where the modified code is.
> Maybe memory dump shows different code, but that is also true
> if uprobe is active. So I think it is OK.

hum, I'm not what you mean.. I attached the kernel change from my changes,
if you want to comment on top of that

the whole change including user space changes is in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=redzone_fix

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..a6db7b76cb49 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -636,9 +636,20 @@ struct uprobe_trampoline {
 	unsigned long		vaddr;
 };
 
+static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
+
+#define LEA_INSN_SIZE		5
+#define UPROBE_OPT_INSN_SIZE	(LEA_INSN_SIZE + CALL_INSN_SIZE)
+#define REDZONE_SIZE		0x80
+
+static bool is_lea_insn(const uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
+}
+
 static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
 {
-	long delta = (long)(vaddr + 5 - vtramp);
+	long delta = (long)(vaddr + UPROBE_OPT_INSN_SIZE - vtramp);
 
 	return delta >= INT_MIN && delta <= INT_MAX;
 }
@@ -651,7 +662,7 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	};
 	unsigned long low_limit, high_limit;
 	unsigned long low_tramp, high_tramp;
-	unsigned long call_end = vaddr + 5;
+	unsigned long call_end = vaddr + UPROBE_OPT_INSN_SIZE;
 
 	if (check_add_overflow(call_end, INT_MIN, &low_limit))
 		low_limit = PAGE_SIZE;
@@ -826,8 +837,8 @@ SYSCALL_DEFINE0(uprobe)
 	regs->ax  = args.ax;
 	regs->r11 = args.r11;
 	regs->cx  = args.cx;
-	regs->ip  = args.retaddr - 5;
-	regs->sp += sizeof(args);
+	regs->ip  = args.retaddr - UPROBE_OPT_INSN_SIZE;
+	regs->sp += sizeof(args) + REDZONE_SIZE;
 	regs->orig_ax = -1;
 
 	sp = regs->sp;
@@ -844,12 +855,12 @@ SYSCALL_DEFINE0(uprobe)
 	 */
 	if (regs->sp != sp) {
 		/* skip the trampoline call */
-		if (args.retaddr - 5 == regs->ip)
-			regs->ip += 5;
+		if (args.retaddr - UPROBE_OPT_INSN_SIZE == regs->ip)
+			regs->ip += UPROBE_OPT_INSN_SIZE;
 		return regs->ax;
 	}
 
-	regs->sp -= sizeof(args);
+	regs->sp -= sizeof(args) + REDZONE_SIZE;
 
 	/* for the case uprobe_consumer has changed ax/r11/cx */
 	args.ax  = regs->ax;
@@ -857,7 +868,7 @@ SYSCALL_DEFINE0(uprobe)
 	args.cx  = regs->cx;
 
 	/* keep return address unless we are instructed otherwise */
-	if (args.retaddr - 5 != regs->ip)
+	if (args.retaddr - UPROBE_OPT_INSN_SIZE != regs->ip)
 		args.retaddr = regs->ip;
 
 	if (shstk_push(args.retaddr) == -EFAULT)
@@ -891,7 +902,7 @@ asm (
 	"pop %rax\n"
 	"pop %r11\n"
 	"pop %rcx\n"
-	"ret\n"
+	"ret $0x80\n"
 	"int3\n"
 	".balign " __stringify(PAGE_SIZE) "\n"
 	".popsection\n"
@@ -930,9 +941,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 		       int nbytes, void *data)
 {
 	struct write_opcode_ctx *ctx = data;
-	uprobe_opcode_t old_opcode[5];
+	uprobe_opcode_t old_opcode[UPROBE_OPT_INSN_SIZE];
 
-	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+	uprobe_copy_from_page(page, ctx->base, old_opcode, UPROBE_OPT_INSN_SIZE);
 
 	switch (ctx->expect) {
 	case EXPECT_SWBP:
@@ -940,7 +951,7 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 			return 1;
 		break;
 	case EXPECT_CALL:
-		if (is_call_insn(&old_opcode[0]))
+		if (is_lea_insn(old_opcode))
 			return 1;
 		break;
 	}
@@ -963,7 +974,7 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
  *   - SMP sync all CPUs
  */
 static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		       unsigned long vaddr, char *insn, bool optimize)
+		       unsigned long vaddr, char *insn, int size, bool optimize)
 {
 	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
 	struct write_opcode_ctx ctx = {
@@ -990,7 +1001,7 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 
 	/* Write all but the first byte of the patched range. */
 	ctx.expect = EXPECT_SWBP;
-	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, size - 1, verify_insn,
 			   true /* is_register */, false /* do_update_ref_ctr */,
 			   &ctx);
 	if (err)
@@ -1017,17 +1028,35 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			 unsigned long vaddr, unsigned long tramp)
 {
-	u8 call[5];
+	u8 insn[UPROBE_OPT_INSN_SIZE];
 
-	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
-			(const void *) tramp, CALL_INSN_SIZE);
-	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
+	/*
+	 * We have nop10 (with first byte overwritten to int3),
+	 * change it to:
+	 *   lea 0x80(%rsp), %rsp
+	 *   call tramp
+	 *
+	 * The first lea instruction skips the stack redzone so the call
+	 * instruction can safely push return address on stack.
+	 */
+	memcpy(insn, lea_rsp, LEA_INSN_SIZE);
+	__text_gen_insn(insn + LEA_INSN_SIZE, CALL_INSN_OPCODE,
+			(const void *)(vaddr + LEA_INSN_SIZE),
+			(const void *)tramp, CALL_INSN_SIZE);
+	return int3_update(auprobe, vma, vaddr, insn, UPROBE_OPT_INSN_SIZE, true /* optimize */);
 }
 
 static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			   unsigned long vaddr)
 {
-	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
+	/*
+	 * Write JMP rel8 to end of the 10-byte slot instead of restoring the
+	 * original nop10, because we could have thread already inside lea
+	 * instruction.
+	 */
+	u8 jmp[UPROBE_OPT_INSN_SIZE] = { 0xeb, UPROBE_OPT_INSN_SIZE - 2 };
+
+	return int3_update(auprobe, vma, vaddr, jmp, 2, false /* optimize */);
 }
 
 static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst, int len)
@@ -1049,19 +1078,21 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
 	struct __packed __arch_relative_insn {
 		u8 op;
 		s32 raddr;
-	} *call = (struct __arch_relative_insn *) insn;
+	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
-	if (!is_call_insn(insn))
+	if (!is_lea_insn(insn))
 		return false;
-	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+	if (!is_call_insn((uprobe_opcode_t *) call))
+		return false;
+	return __in_uprobe_trampoline(vaddr + UPROBE_OPT_INSN_SIZE + call->raddr);
 }
 
 static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 {
-	uprobe_opcode_t insn[5];
+	uprobe_opcode_t insn[UPROBE_OPT_INSN_SIZE];
 	int err;
 
-	err = copy_from_vaddr(mm, vaddr, &insn, 5);
+	err = copy_from_vaddr(mm, vaddr, &insn, UPROBE_OPT_INSN_SIZE);
 	if (err)
 		return err;
 	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
@@ -1131,7 +1162,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn[5];
+	uprobe_opcode_t insn[UPROBE_OPT_INSN_SIZE];
 
 	if (!should_optimize(auprobe))
 		return;
@@ -1142,7 +1173,7 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 	 * Check if some other thread already optimized the uprobe for us,
 	 * if it's the case just go away silently.
 	 */
-	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+	if (copy_from_vaddr(mm, vaddr, &insn, UPROBE_OPT_INSN_SIZE))
 		goto unlock;
 	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
 		goto unlock;
@@ -1160,14 +1191,23 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
-	if (!insn->x86_64 || insn->length != 5)
+	if (!insn->x86_64)
 		return false;
 
-	if (!insn_is_nop(insn))
+	/* We can't do cross page atomic writes yet. */
+	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < UPROBE_OPT_INSN_SIZE)
 		return false;
 
-	/* We can't do cross page atomic writes yet. */
-	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+	if (insn->length == UPROBE_OPT_INSN_SIZE && insn_is_nop(insn))
+		return true;
+
+	/* JMP rel8 to end of slot — written by swbp_unoptimize. */
+	if (insn->length == 2 &&
+	    insn->opcode.bytes[0] == 0xEB &&
+	    insn->immediate.value == UPROBE_OPT_INSN_SIZE - 2)
+		return true;
+
+	return false;
 }
 #else /* 32-bit: */
 /*

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C11DF980;
	Tue, 12 May 2026 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562874; cv=none; b=gF/TUF2GV1Twl+g9F03RkmLTOHFkWhZD67dAImZ2A/+q7+WjMs/kslozmZQbFZ7swnKVPOgaZzhAUbAVvHOKO5lAY2uZXI5I36yY0wIl/ryUPwd3YkxWr2Nel5Oiz9DU3XFfjX69Jg19YqYu64tdKf/gsT17nK+OCDMXYDv8fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562874; c=relaxed/simple;
	bh=oBZBVzAOEhCw9YLog4ieJYBNZ4QrfQdPUaf7WdwydnE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NHd2L74JR15B/FeN6WMU60zfPXW6qD2X5y/0lC/IiWRoG0N8pJ6pMnJLIhwYPW7jVxxlaqMRgTfPrifhosyhvhZF0tmEIpxpylI69/hYhI9M7gprNnjXJvSi/xOuY1vEDHuTI3DovymQez36u63556xGjZlTL2o+CWWzx9uQowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epNtpv82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epNtpv82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A40C2BCB0;
	Tue, 12 May 2026 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778562874;
	bh=oBZBVzAOEhCw9YLog4ieJYBNZ4QrfQdPUaf7WdwydnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epNtpv82Jnxgyt0VHIz0xYgtZDor5G+ejTDQXcyudstEiJt2pSR1wstn6Nw9e2geN
	 GTwjL2mTM+mk/+JgfiPtwSYNGZRiTdBrJxmzvR1KNdCFwzXO1Mp0jPKkEPqdRhxTHQ
	 QD42DRcIkssNjcSuPkOqFE/ZdKdDlTxvvIGzTm6/Inl+pyTpN58Zj9cpcBel+UREEG
	 P36+4RWcFa27J4KNchN94mnzPoCZslwfYt1cavgpqSee/S7a9mDun9pjo3mdOxSJEI
	 TQ7DJT1KIigQGaSXjZUMbAHxeGxH+ARL4yAorGveCVdIYHO80AsNX6dCP6QVAYCBmS
	 H205yHd8MALOw==
Date: Tue, 12 May 2026 14:14:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org,
 mingo@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-Id: <20260512141431.a70375744fdae263bda5b722@kernel.org>
In-Reply-To: <agD3xq2MUyskd7X-@krava>
References: <20260509003146.976844-1-andrii@kernel.org>
	<agD3xq2MUyskd7X-@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 10 May 2026 23:25:26 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, May 08, 2026 at 05:30:56PM -0700, Andrii Nakryiko wrote:
> > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > probe site with a CALL into a uprobe trampoline. CALL pushes a return
> > address to [rsp-8]. On x86-64 this is inside the 128-byte red zone, where
> > user code may keep temporary data without adjusting rsp.
> > 
> > Use a 5-byte JMP instead. JMP does not write to the user stack, but it
> > also does not provide a return address. Replace the single trampoline
> > entry with a page of 16-byte slots. Each optimized probe jumps to its
> > assigned slot, the slot moves rsp below the red zone, saves the registers
> > clobbered by syscall, and invokes the uprobe syscall:
> > 
> >   Probe site:   jmp slot_N              (5B, replaces nop5)
> > 
> >   Slot N:       lea  -128(%rsp), %rsp   (5B)  skip red zone
> >                 push %rcx               (1B)  save (syscall clobbers)
> >                 push %r11               (2B)  save (syscall clobbers)
> >                 push %rax               (1B)  save (syscall uses for nr)
> >                 mov  $336, %eax         (5B)  uprobe syscall number
> >                 syscall                 (2B)
> > 
> > All slots contain identical code at different offsets, so the trampoline
> > page is generated once at boot and mapped read-execute into each process.
> > The syscall handler identifies the slot from regs->ip, which points just
> > after the syscall instruction, and uses a per-mm slot table to recover the
> > original probe address.
> > 
> > The uprobe syscall does not return to the trampoline slot. The handler
> > restores the probe-site register state, runs the uprobe consumers, sets
> > pt_regs to continue at probe_addr + 5 unless a consumer redirected
> > execution, and returns directly through the IRET path. This preserves
> > general purpose registers, including rcx and r11, without requiring any
> > post-syscall cleanup code in the trampoline and avoids call/ret, RSB, and
> > shadow stack concerns.
> > 
> > Protect the per-mm trampoline list with RCU and free trampoline metadata
> > with kfree_rcu(). This lets the syscall path resolve trampoline slots
> > without taking mmap_lock. The optimized-instruction detection path also
> > walks the trampoline list under an RCU read-side lock. Since that path
> > starts from the JMP target, it translates the slot start to the post-syscall
> > IP expected by the shared resolver before checking the trampoline mapping.
> > 
> > Each trampoline page provides 256 slots. Slots stay permanently assigned
> > to their first probe address and are reused only when the same address is
> > probed again. Reassigning detached slots is deliberately avoided because a
> > thread can remain in a trampoline for an unbounded time due to ptrace,
> > interrupts, or scheduling delays. If a reachable trampoline page runs out
> > of slots, probes that cannot allocate a slot fall back to the slower INT3
> > path.
> > 
> > Require the entire trampoline page to be reachable by a rel32 JMP before
> > reusing it for a probe. This keeps every slot in the page within the range
> > that can be encoded at the probe site.
> > 
> > Change the error code returned when the uprobe syscall is invoked outside
> > a kernel-generated trampoline from -ENXIO to -EPROTO. This lets libbpf and
> > similar libraries distinguish fixed kernels from kernels with the
> > red-zone-clobbering implementation and enable nop5 optimization only on
> > fixed kernels.
> > 
> > Performance (usdt single-thread, M/s):
> > 
> >                   usdt-nop  usdt-nop5-base  usdt-nop5-fix  nop5-change  iret%
> >   Skylake          3.149        6.422          4.865         -24.3%     39.1%
> >   Milan            2.910        3.443          3.820         +11.0%     24.3%
> >   Sapphire Rapids  1.896        4.023          3.693          -8.2%     24.9%
> >   Bergamo          3.393        3.895          3.849          -1.2%     24.5%
> > 
> > The fixed nop5 path remains faster than the non-optimized INT3 path on all
> > measured systems. The regression relative to the old CALL-based trampoline
> > comes from IRET being more expensive than SYSRET, most noticeably on older
> > Intel Skylake. Newer Intel CPUs and tested AMD CPUs have lower IRET cost,
> > and AMD Milan improves because removing mmap_lock from the hot path more
> > than offsets the IRET cost.
> > 
> > Multi-threaded throughput scales nearly linearly with the number of CPUs, like
> > it used to, thanks to lockless RCU-protected uprobe trampoline lookup.
> 
> hi,
> thanks a lot for the fix
> 
> FWIW we discussed also an option to have 10-bytes nop and do:
>   [rsp+0x80, call trampoline]
> 
> we would not need the slots re-use logic, but not sure what other
> surprises there are with 10-bytes nop

Does this mean we have to update UDST implementation?

> 
> I tried that change [1], it seems to work, but it has other
> difficulties, like I think the unoptimized path needs to do:
>   [rsp+0x80, call trampoline] -> [jmp end of 10-bytes nop]
> instead of patching back the 10-byte nop, because some thread
> could be inside the nop area already.

Yeah, but at that moment, we know where the modified code is.
Maybe memory dump shows different code, but that is also true
if uprobe is active. So I think it is OK.

Thanks,

> 
> jirka
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=redzone_fix&id=74b09240289dba8368c2783b771e678b2cc31574
> 
> > 
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/include/asm/uprobes.h                |  18 ++
> >  arch/x86/kernel/uprobes.c                     | 262 ++++++++++--------
> >  tools/lib/bpf/features.c                      |   8 +-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c |   5 +-
> >  tools/testing/selftests/bpf/prog_tests/usdt.c |   2 +-
> >  5 files changed, 181 insertions(+), 114 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> > index 362210c79998..a7cf5c92d95a 100644
> > --- a/arch/x86/include/asm/uprobes.h
> > +++ b/arch/x86/include/asm/uprobes.h
> > @@ -25,6 +25,24 @@ enum {
> >  	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
> >  };
> >  
> > +/*
> > + * Trampoline page layout: identical 16-byte slots, each containing:
> > + *   lea  -128(%rsp), %rsp (5B)  skip red zone
> > + *   push %rcx             (1B)  save (syscall clobbers)
> > + *   push %r11             (2B)  save (syscall clobbers)
> > + *   push %rax             (1B)  save (syscall uses for nr)
> > + *   mov  $336, %eax       (5B)  uprobe syscall number
> > + *   syscall               (2B)
> > + *                        = 16B, no padding needed
> > + *
> > + * The handler identifies which probe fired from regs->ip (each
> > + * slot is at a unique offset), looks up the probe address from a
> > + * per-process table, and returns directly to probe_addr+5 via iret
> > + * with all registers restored.
> > + */
> > +#define UPROBE_TRAMP_SLOT_SIZE	16
> > +#define UPROBE_TRAMP_MAX_SLOTS	(PAGE_SIZE / UPROBE_TRAMP_SLOT_SIZE)
> > +
> >  struct uprobe_xol_ops;
> >  
> >  struct arch_uprobe {
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index ebb1baf1eb1d..7e1f14200bbb 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -633,16 +633,25 @@ static struct vm_special_mapping tramp_mapping = {
> >  
> >  struct uprobe_trampoline {
> >  	struct hlist_node	node;
> > +	struct rcu_head		rcu;
> >  	unsigned long		vaddr;
> > +	unsigned long		probe_addrs[UPROBE_TRAMP_MAX_SLOTS];
> >  };
> >  
> > -static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> > +
> > +static bool is_reachable_by_jmp(unsigned long dst, unsigned long src)
> >  {
> > -	long delta = (long)(vaddr + 5 - vtramp);
> > +	long delta = (long)(dst - (src + JMP32_INSN_SIZE));
> >  
> >  	return delta >= INT_MIN && delta <= INT_MAX;
> >  }
> >  
> > +static bool is_reachable_by_trampoline(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +	return is_reachable_by_jmp(vtramp, vaddr) &&
> > +	       is_reachable_by_jmp(vtramp + PAGE_SIZE - 1, vaddr);
> > +}
> > +
> >  static unsigned long find_nearest_trampoline(unsigned long vaddr)
> >  {
> >  	struct vm_unmapped_area_info info = {
> > @@ -711,6 +720,21 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> >  	return tramp;
> >  }
> >  
> > +static int tramp_alloc_slot(struct uprobe_trampoline *tramp, unsigned long probe_addr)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < UPROBE_TRAMP_MAX_SLOTS; i++) {
> > +		if (tramp->probe_addrs[i] == probe_addr)
> > +			return i;
> > +		if (tramp->probe_addrs[i] == 0) {
> > +			tramp->probe_addrs[i] = probe_addr;
> > +			return i;
> > +		}
> > +	}
> > +	return -ENOSPC;
> > +}
> > +
> >  static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> >  {
> >  	struct uprobes_state *state = &current->mm->uprobes_state;
> > @@ -720,7 +744,7 @@ static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool
> >  		return NULL;
> >  
> >  	hlist_for_each_entry(tramp, &state->head_tramps, node) {
> > -		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
> > +		if (is_reachable_by_trampoline(tramp->vaddr, vaddr)) {
> >  			*new = false;
> >  			return tramp;
> >  		}
> > @@ -731,7 +755,7 @@ static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool
> >  		return NULL;
> >  
> >  	*new = true;
> > -	hlist_add_head(&tramp->node, &state->head_tramps);
> > +	hlist_add_head_rcu(&tramp->node, &state->head_tramps);
> >  	return tramp;
> >  }
> >  
> > @@ -742,8 +766,8 @@ static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> >  	 * because there's no easy way to make sure none of the threads
> >  	 * is still inside the trampoline.
> >  	 */
> > -	hlist_del(&tramp->node);
> > -	kfree(tramp);
> > +	hlist_del_rcu(&tramp->node);
> > +	kfree_rcu(tramp, rcu);
> >  }
> >  
> >  void arch_uprobe_init_state(struct mm_struct *mm)
> > @@ -761,147 +785,153 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
> >  		destroy_uprobe_trampoline(tramp);
> >  }
> >  
> > -static bool __in_uprobe_trampoline(unsigned long ip)
> > +/*
> > + * Find the trampoline containing @ip. If @probe_addr is non-NULL, also
> > + * resolve the slot index from @ip and return the probe address.
> > + *
> > + * @ip is expected to point right after the syscall instruction, i.e.,
> > + * at the end of the slot (slot_start + UPROBE_TRAMP_SLOT_SIZE).
> > + */
> > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe_addr)
> >  {
> > -	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> > +	struct uprobes_state *state = &current->mm->uprobes_state;
> > +	struct uprobe_trampoline *tramp;
> >  
> > -	return vma && vma_is_special_mapping(vma, &tramp_mapping);
> > -}
> > +	hlist_for_each_entry_rcu(tramp, &state->head_tramps, node) {
> > +		/*
> > +		 * ip points to after syscall, so it's on 16 byte boundary,
> > +		 * which means that valid ip can point right after the page
> > +		 * and should never be at zero offset within the page
> > +		 */
> > +		if (ip <= tramp->vaddr || ip > tramp->vaddr + PAGE_SIZE)
> > +			continue;
> >  
> > -static bool in_uprobe_trampoline(unsigned long ip)
> > -{
> > -	struct mm_struct *mm = current->mm;
> > -	bool found, retry = true;
> > -	unsigned int seq;
> > +		if (probe_addr) {
> > +			/* we already validated ip is within expected range */
> > +			unsigned int slot = (ip - tramp->vaddr - 1) / UPROBE_TRAMP_SLOT_SIZE;
> > +			unsigned long addr = tramp->probe_addrs[slot];
> >  
> > -	rcu_read_lock();
> > -	if (mmap_lock_speculate_try_begin(mm, &seq)) {
> > -		found = __in_uprobe_trampoline(ip);
> > -		retry = mmap_lock_speculate_retry(mm, seq);
> > -	}
> > -	rcu_read_unlock();
> > +			*probe_addr = addr;
> > +			if (addr == 0)
> > +				return false;
> > +		}
> >  
> > -	if (retry) {
> > -		mmap_read_lock(mm);
> > -		found = __in_uprobe_trampoline(ip);
> > -		mmap_read_unlock(mm);
> > +		return true;
> >  	}
> > -	return found;
> > +	return false;
> > +}
> > +
> > +static bool in_uprobe_trampoline(unsigned long ip, unsigned long *probe_addr)
> > +{
> > +	guard(rcu)();
> > +	return resolve_uprobe_addr(ip, probe_addr);
> >  }
> >  
> >  /*
> > - * See uprobe syscall trampoline; the call to the trampoline will push
> > - * the return address on the stack, the trampoline itself then pushes
> > - * cx, r11 and ax.
> > + * The trampoline slot pushes cx, r11, ax (the registers syscall clobbers)
> > + * before doing the uprobe syscall. No return address is pushed — the
> > + * probe site uses jmp, not call.
> >   */
> >  struct uprobe_syscall_args {
> >  	unsigned long ax;
> >  	unsigned long r11;
> >  	unsigned long cx;
> > -	unsigned long retaddr;
> >  };
> >  
> > +#define UPROBE_TRAMP_REDZONE 128
> > +
> >  SYSCALL_DEFINE0(uprobe)
> >  {
> >  	struct pt_regs *regs = task_pt_regs(current);
> >  	struct uprobe_syscall_args args;
> > -	unsigned long ip, sp, sret;
> > +	unsigned long probe_addr;
> >  	int err;
> >  
> >  	/* Allow execution only from uprobe trampolines. */
> > -	if (!in_uprobe_trampoline(regs->ip))
> > -		return -ENXIO;
> > +	if (!in_uprobe_trampoline(regs->ip, &probe_addr))
> > +		return -EPROTO;
> >  
> >  	err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
> >  	if (err)
> >  		goto sigill;
> >  
> > -	ip = regs->ip;
> > -
> >  	/*
> > -	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
> > -	 * - adjust ip to the probe address, call saved next instruction address
> > -	 * - adjust sp to the probe's stack frame (check trampoline code)
> > +	 * Restore the register state as it was at the probe site:
> > +	 * - ax/r11/cx from the trampoline-saved copies on user stack
> > +	 * - adjust ip to the probe address based on matching slot
> > +	 * - adjust sp to skip red zone and pushed args
> >  	 */
> >  	regs->ax  = args.ax;
> >  	regs->r11 = args.r11;
> >  	regs->cx  = args.cx;
> > -	regs->ip  = args.retaddr - 5;
> > -	regs->sp += sizeof(args);
> > +	regs->ip  = probe_addr;
> > +	regs->sp += sizeof(args) + UPROBE_TRAMP_REDZONE;
> >  	regs->orig_ax = -1;
> >  
> > -	sp = regs->sp;
> > -
> > -	err = shstk_pop((u64 *)&sret);
> > -	if (err == -EFAULT || (!err && sret != args.retaddr))
> > -		goto sigill;
> > -
> > -	handle_syscall_uprobe(regs, regs->ip);
> > +	handle_syscall_uprobe(regs, probe_addr);
> >  
> >  	/*
> > -	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > -	 * just return via iret.
> > +	 * Skip the jmp instruction at the probe site (5 bytes) unless
> > +	 * a consumer redirected execution elsewhere.
> >  	 */
> > -	if (regs->sp != sp) {
> > -		/* skip the trampoline call */
> > -		if (args.retaddr - 5 == regs->ip)
> > -			regs->ip += 5;
> > -		return regs->ax;
> > -	}
> > +	if (regs->ip == probe_addr)
> > +		regs->ip = probe_addr + 5;
> >  
> > -	regs->sp -= sizeof(args);
> > -
> > -	/* for the case uprobe_consumer has changed ax/r11/cx */
> > -	args.ax  = regs->ax;
> > -	args.r11 = regs->r11;
> > -	args.cx  = regs->cx;
> > -
> > -	/* keep return address unless we are instructed otherwise */
> > -	if (args.retaddr - 5 != regs->ip)
> > -		args.retaddr = regs->ip;
> > -
> > -	if (shstk_push(args.retaddr) == -EFAULT)
> > -		goto sigill;
> > -
> > -	regs->ip = ip;
> > -
> > -	err = copy_to_user((void __user *)regs->sp, &args, sizeof(args));
> > -	if (err)
> > -		goto sigill;
> > -
> > -	/* ensure sysret, see do_syscall_64() */
> > -	regs->r11 = regs->flags;
> > -	regs->cx  = regs->ip;
> > -	return 0;
> > +	/*
> > +	 * Return via iret by returning regs->ax. This preserves all
> > +	 * GP registers (including cx and r11) without needing any
> > +	 * user-space cleanup code. The iret path is used because we
> > +	 * don't set up cx/r11 for sysret.
> > +	 */
> > +	return regs->ax;
> >  
> >  sigill:
> >  	force_sig(SIGILL);
> >  	return -1;
> >  }
> >  
> > +/*
> > + * All uprobe trampoline slots are identical: skip the red zone,
> > + * save the three registers that syscall clobbers, then invoke
> > + * the uprobe syscall. The handler returns directly to the probe
> > + * caller via iret. Execution never returns to the trampoline.
> > + */
> >  asm (
> >  	".pushsection .rodata\n"
> > -	".balign " __stringify(PAGE_SIZE) "\n"
> > -	"uprobe_trampoline_entry:\n"
> > +	".balign " __stringify(UPROBE_TRAMP_SLOT_SIZE) "\n"
> > +	"uprobe_trampoline_slot:\n"
> > +	"lea -128(%rsp), %rsp\n"
> >  	"push %rcx\n"
> >  	"push %r11\n"
> >  	"push %rax\n"
> > -	"mov $" __stringify(__NR_uprobe) ", %rax\n"
> > +	"mov $" __stringify(__NR_uprobe) ", %eax\n"
> >  	"syscall\n"
> > -	"pop %rax\n"
> > -	"pop %r11\n"
> > -	"pop %rcx\n"
> > -	"ret\n"
> > -	"int3\n"
> > -	".balign " __stringify(PAGE_SIZE) "\n"
> > +	"uprobe_trampoline_slot_end:\n"
> >  	".popsection\n"
> >  );
> >  
> > -extern u8 uprobe_trampoline_entry[];
> > +extern u8 uprobe_trampoline_slot[];
> > +extern u8 uprobe_trampoline_slot_end[];
> >  
> >  static int __init arch_uprobes_init(void)
> >  {
> > -	tramp_mapping_pages[0] = virt_to_page(uprobe_trampoline_entry);
> > +	unsigned int slot_size = uprobe_trampoline_slot_end - uprobe_trampoline_slot;
> > +	struct page *page;
> > +	u8 *page_addr;
> > +	int i;
> > +
> > +	BUILD_BUG_ON(UPROBE_TRAMP_SLOT_SIZE != 16);
> > +	WARN_ON_ONCE(slot_size != UPROBE_TRAMP_SLOT_SIZE);
> > +
> > +	page = alloc_page(GFP_KERNEL);
> > +	if (!page)
> > +		return -ENOMEM;
> > +
> > +	page_addr = page_address(page);
> > +	for (i = 0; i < UPROBE_TRAMP_MAX_SLOTS; i++)
> > +		memcpy(page_addr + i * UPROBE_TRAMP_SLOT_SIZE, uprobe_trampoline_slot, slot_size);
> > +
> > +	tramp_mapping_pages[0] = page;
> >  	return 0;
> >  }
> >  
> > @@ -909,7 +939,7 @@ late_initcall(arch_uprobes_init);
> >  
> >  enum {
> >  	EXPECT_SWBP,
> > -	EXPECT_CALL,
> > +	EXPECT_JMP,
> >  };
> >  
> >  struct write_opcode_ctx {
> > @@ -917,14 +947,14 @@ struct write_opcode_ctx {
> >  	int expect;
> >  };
> >  
> > -static int is_call_insn(uprobe_opcode_t *insn)
> > +static int is_jmp_insn(uprobe_opcode_t *insn)
> >  {
> > -	return *insn == CALL_INSN_OPCODE;
> > +	return *insn == JMP32_INSN_OPCODE;
> >  }
> >  
> >  /*
> >   * Verification callback used by int3_update uprobe_write calls to make sure
> > - * the underlying instruction is as expected - either int3 or call.
> > + * the underlying instruction is as expected - either int3 or jmp.
> >   */
> >  static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
> >  		       int nbytes, void *data)
> > @@ -939,8 +969,8 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
> >  		if (is_swbp_insn(&old_opcode[0]))
> >  			return 1;
> >  		break;
> > -	case EXPECT_CALL:
> > -		if (is_call_insn(&old_opcode[0]))
> > +	case EXPECT_JMP:
> > +		if (is_jmp_insn(&old_opcode[0]))
> >  			return 1;
> >  		break;
> >  	}
> > @@ -978,7 +1008,7 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  	 * so we can skip this step for optimize == true.
> >  	 */
> >  	if (!optimize) {
> > -		ctx.expect = EXPECT_CALL;
> > +		ctx.expect = EXPECT_JMP;
> >  		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
> >  				   true /* is_register */, false /* do_update_ref_ctr */,
> >  				   &ctx);
> > @@ -1015,13 +1045,13 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  }
> >  
> >  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > -			 unsigned long vaddr, unsigned long tramp)
> > +			 unsigned long vaddr, unsigned long slot_vaddr)
> >  {
> > -	u8 call[5];
> > +	u8 jmp[5];
> >  
> > -	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> > -			(const void *) tramp, CALL_INSN_SIZE);
> > -	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
> > +	__text_gen_insn(jmp, JMP32_INSN_OPCODE, (const void *) vaddr,
> > +			(const void *) slot_vaddr, JMP32_INSN_SIZE);
> > +	return int3_update(auprobe, vma, vaddr, jmp, true /* optimize */);
> >  }
> >  
> >  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > @@ -1049,11 +1079,17 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
> >  	struct __packed __arch_relative_insn {
> >  		u8 op;
> >  		s32 raddr;
> > -	} *call = (struct __arch_relative_insn *) insn;
> > +	} *jmp = (struct __arch_relative_insn *) insn;
> >  
> > -	if (!is_call_insn(insn))
> > +	if (!is_jmp_insn(&jmp->op))
> >  		return false;
> > -	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> > +
> > +	guard(rcu)();
> > +	/*
> > +	 * resolve_uprobe_addr() expects IP pointing after syscall instruction
> > +	 * (after the slot, basically), so adjust jump target address accordingly
> > +	 */
> > +	return resolve_uprobe_addr(vaddr + 5 + jmp->raddr + UPROBE_TRAMP_SLOT_SIZE, NULL);
> >  }
> >  
> >  static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
> > @@ -1113,8 +1149,9 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
> >  {
> >  	struct uprobe_trampoline *tramp;
> >  	struct vm_area_struct *vma;
> > +	unsigned long slot_vaddr;
> >  	bool new = false;
> > -	int err = 0;
> > +	int slot, err;
> >  
> >  	vma = find_vma(mm, vaddr);
> >  	if (!vma)
> > @@ -1122,8 +1159,17 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
> >  	tramp = get_uprobe_trampoline(vaddr, &new);
> >  	if (!tramp)
> >  		return -EINVAL;
> > -	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> > -	if (WARN_ON_ONCE(err) && new)
> > +
> > +	slot = tramp_alloc_slot(tramp, vaddr);
> > +	if (slot < 0) {
> > +		if (new)
> > +			destroy_uprobe_trampoline(tramp);
> > +		return slot;
> > +	}
> > +
> > +	slot_vaddr = tramp->vaddr + slot * UPROBE_TRAMP_SLOT_SIZE;
> > +	err = swbp_optimize(auprobe, vma, vaddr, slot_vaddr);
> > +	if (err && new)
> >  		destroy_uprobe_trampoline(tramp);
> >  	return err;
> >  }
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index 4f19a0d79b0c..1b6c113357b2 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -577,10 +577,12 @@ static int probe_ldimm64_full_range_off(int token_fd)
> >  static int probe_uprobe_syscall(int token_fd)
> >  {
> >  	/*
> > -	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
> > -	 * from the outside of a kernel-generated uprobe trampoline.
> > +	 * If kernel supports uprobe() syscall, it will return -EPROTO when
> > +	 * called from outside a kernel-generated uprobe trampoline.
> > +	 * Older kernels with the red-zone-clobbering bug return -ENXIO;
> > +	 * we only enable the nop5 optimization on fixed kernels.
> >  	 */
> > -	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
> > +	return syscall(__NR_uprobe) < 0 && errno == EPROTO;
> >  }
> >  #else
> >  static int probe_uprobe_syscall(int token_fd)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 955a37751b52..0d5eb4cd1ddf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -422,7 +422,8 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
> >  	/* .. and check the trampoline is as expected. */
> >  	call = (struct __arch_relative_insn *) addr;
> >  	tramp = (void *) (call + 1) + call->raddr;
> > -	ASSERT_EQ(call->op, 0xe8, "call");
> > +	tramp = (void *)((unsigned long)tramp & ~(getpagesize() - 1UL));
> > +	ASSERT_EQ(call->op, 0xe9, "jmp");
> >  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> >  
> >  	return tramp;
> > @@ -762,7 +763,7 @@ static void test_uprobe_error(void)
> >  	long err = syscall(__NR_uprobe);
> >  
> >  	ASSERT_EQ(err, -1, "error");
> > -	ASSERT_EQ(errno, ENXIO, "errno");
> > +	ASSERT_EQ(errno, EPROTO, "errno");
> >  }
> >  
> >  static void __test_uprobe_syscall(void)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index 69759b27794d..9d3744d4e936 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > @@ -329,7 +329,7 @@ static void subtest_optimized_attach(void)
> >  	ASSERT_EQ(*addr_2, 0x90, "nop");
> >  
> >  	/* call is on addr_2 + 1 address */
> > -	ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
> > +	ASSERT_EQ(*(addr_2 + 1), 0xe9, "jmp");
> >  	ASSERT_EQ(skel->bss->executed, 4, "executed");
> >  
> >  cleanup:
> > -- 
> > 2.53.0-Meta
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

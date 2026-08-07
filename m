Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384439B48D;
	Fri,  7 Aug 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111049; cv=none; b=aj0ExRxRABE3pBjYGthiCcJpbuPg97l68ouEc7jmBV2BQPSmDeRo972NaS1LtQ2xBqbGO9jF6wVRkGQKkc1NFDzGBTf65ZoN2XyXjbAYXwSXfzmbynl+5w7jbAFg06WxzhVHCnHdLCxg+UTLwRP675puhEn+PYP11ajCffZOL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111049; c=relaxed/simple;
	bh=Z72ieCKGBrnJ1R0wWPsVqo7s6jCtOFoq1qgV6zt/2gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBlU8qCd+5WBP6Lux534B404uck1ilJlcNZexmNeSSG39s7Z7G2OONz1TpKyUF90hLnOloXoohME9Qye+1b91E2uuZEqIsPDjCT+TFJoZNMRGZqg4TADtpdXiqSPod5enh4SLmWGs+csYkJZHVNMR9WuTaBteab2AFcTtQwy5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dU5zKa0E; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dU5zKa0E"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7133B1BCA;
	Fri,  7 Aug 2026 06:57:18 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F14F3F86F;
	Fri,  7 Aug 2026 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786111042; bh=Z72ieCKGBrnJ1R0wWPsVqo7s6jCtOFoq1qgV6zt/2gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dU5zKa0EcEAsEnfu2Qy+ka5i4OThCAavFl2jizuDYKelhfqyW1HHNUFulz8XCapzy
	 HwfqsNnquDrJYICvLpWU626Hy7j6DOx/cgspynRPglFNEsKzZHz2opDvjB1eJJPm+4
	 Ia35TUaRtaKop6hDUgt4+4qfmzBVlHCuVcfqfPlA=
Date: Fri, 7 Aug 2026 14:57:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <anXkO8YpoadRzm07@J2N7QTR9R3>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>

Hi Breno,

On Fri, Aug 07, 2026 at 04:45:31AM -0700, Breno Leitao wrote:
> Running retsnoop on a kernel with GIC priority masking and
> CONFIG_ARM64_DEBUG_PRIORITY_MASKING=y trips the ICC_PMR_EL1 sanity check
> in __pmr_local_irq_disable():
> 
>      WARNING: ./arch/arm64/include/asm/irqflags.h:63 at arm64_exit_to_kernel_mode+0xb8/0xc0, CPU#40: retsnoop/31805
>      CPU: 40 UID: 0 PID: 31805 Comm: retsnoop Not tainted 7.2.0-rc6-next-20260805 #7 PREEMPTLAZY
>      pstate: 234013c9 (nzCv DAIF +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
>      pc : arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63)
>      lr : el1_abort (arch/arm64/kernel/entry-common.c:323)
>      pmr: 000000f0
>      Call trace:
> D)    arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63) (P)
>       el1_abort (arch/arm64/kernel/entry-common.c:323)
>       el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:449)
> C)    el1h_64_sync (arch/arm64/kernel/entry.S:589)
>       copy_from_kernel_nofault (mm/maccess.c:52) (P)
>       bpf_probe_read_kernel (kernel/trace/bpf_trace.c:268)
>       bpf_prog_db21a1730c2407e5_calib_exit+0xf0/0x160
>       trace_call_bpf (kernel/trace/bpf_trace.c:147)
>       kretprobe_perf_func (kernel/trace/trace_kprobe.c:1750)
>       kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1875)
>       __kretprobe_trampoline_handler (kernel/kprobes.c:2116)
>       kretprobe_brk_handler (arch/arm64/kernel/probes/kprobes.c:422)
>       call_el1_break_hook (arch/arm64/kernel/debug-monitors.c:244)
>       do_el1_brk64 (arch/arm64/kernel/debug-monitors.c:266)
> B)    el1_brk64 (arch/arm64/kernel/entry-common.c:427)
>       el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:481)
>       el1h_64_sync (arch/arm64/kernel/entry.S:589)
>       invoke_syscall (arch/arm64/kernel/syscall.c:49) (P)
>       do_el0_svc (arch/arm64/kernel/syscall.c:140)
>       el0_svc (arch/arm64/kernel/entry-common.c:736)
>       el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:755)
> A)    el0t_64_sync (arch/arm64/kernel/entry.S:594)
> 
> This is my understand of the current situation:
> 
> A) A task enters the kernel via a syscall.
> 	* PSTATE_I_SET becomes set on the live PMR
> 	* regs->PMR doesn't have PSR_I_SET set

At this point, regs->pmr will be the value of PMR when we were executing
in userspace, which should be the value of regs->pmr the last time we
returned to userspace. That should be GIC_PRIO_IRQON, as configured by
start_thread_common().

The entry asm will set PMR to 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET', but
that should be reset to GIC_PRIO_IRQON when el0_svc() calls
local_daif_restore(DAIF_PROCCTX).

Within invoke_syscall(), we should have DAIF==0 and PMR==GIC_PRIO_IRQON.

> B) A BRK fires at EL1 and that is what leaves the live PMR
>    with PSR_I_SET.
> 	* At this stage PSTATE_I_SET is set on both on PMR and regs->PMR

The value in the regs->pmr should be GIC_PRIO_IRQON, without
GIC_PRIO_PSR_I_SET.

As we don't unmask anything during BRK handling, the live PMR should
contain 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET'.

> C) A nested synchronous exception happens (Not sure why -- BPF related)
> 	* Now both the live PMR and regs->pmr have PSR_I_SET.

The presence of 'el1_abort()' in the trace suggests that BPF tried to
access memory which faulted. That looks to be a result of
bpf_probe_read_kernel() and copy_from_kernel_nofault().

Regardless of BPF, we can probably trigger a synchronous exception with
a WARN() or similar, so we will need to handle synchronous exceptions
from the same contexts.

In general, probing kernel VAs is fraught with danger even with a fault
handler, and IMO copy_from_kernel_nofault() is a dangerous and poorly
conceived interface. For example, if you're probing an arbitrary kernel
VA, you have no idea whether you're about to poke MMIO and crash the
system.

It would be interesting to know what the BPF program is doing, in case
it could crash the kernel in other ways we can't prevent here.

> D) On the way out, local_irq_disable() → __pmr_local_irq_disable() warns.
>    It detects that PMR is different than GIC_PRIO_IRQON and GIC_PRIO_IRQOFF,
>    given live PMR and regs->PMR have PSTATE_I_SET ORed.

Only the live value of PMR is important here, and the value of regs->pmr
is immaterial.

The warning is here to capture the fact that if
__pmr_local_irq_disable() were to set PMR to GIC_PRIO_IRQOFF, it would
effectively discard GIC_PRIO_PSR_I_SET and change the masked priority,
which has a bunch of secondary impacts for things like idle.

We'll need to work through those impacts; we might be able to relax the
check.

> How to fix it? I don't know very well.

The complete fix (which Ada and Vladimir have both been working on) is
to get rid of GIC_PRIO_PSR_I_SET entirely, which requires structural
changes in a few places/

I don't think we'd realised there was an extant bug of this shape, so
we'll need to consider what we can do to fix this in a backportable way.

> I am not certain that we want to have PSTATE_I_SET ever be sent to
> regs->pstate. Do we ever need PSTATE_I_SET in regs->pstate?

I'm not sure what you mean here. PSTATE_I_SET doesn't exist, and I'm not
sure whether you're asking about the PSTATE.DAIF bits saved in
regs->pstate, or the PMR value in regs->pmr.

Regardless of pseudo-NMI, is is essential that regs->pstate holds a
complete snapshot of SPSR, including the I bit.

With pseudo-NMI, it is essential that the full PMR value (including
GIC_PRIO_PSR_I_SET) is saved into regs->pmr.

However, as above, AFAICT only the live value matters here.

> In the current patch, I found that disabling IRQ in case it is disabled,
> would solve the warning, but, this seems more a hack than a proper fix,
> perhaps.
> 
> Fixes: ae654112eac0 ("arm64: entry: Use split preemption logic")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/arm64/kernel/entry-common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index ceb4eb11232a6..fcce9ccd37108 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -55,7 +55,13 @@ static noinstr irqentry_state_t arm64_enter_from_kernel_mode(struct pt_regs *reg
>  static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
>  					      irqentry_state_t state)
>  {
> -	local_irq_disable();
> +	/*
> +	 * Only irqentry_exit_to_kernel_mode_preempt() needs interrupts masked,
> +	 * and it returns early when regs had them disabled. Skipping the
> +	 * disable avoids clobbering a PMR the irqflags API does not expect.
> +	 */
> +	if (!regs_irqs_disabled(regs))
> +		local_irq_disable();
>  	irqentry_exit_to_kernel_mode_preempt(regs, state);

I think that might happen to work as a bodge, but I don't think this is
a proper fix, and we'll need a clearer explanation of what's going on.

Mark.

>  	local_daif_mask();
>  	mte_check_tfsr_exit();
> 
> ---
> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> change-id: 20260807-arm64_fix-47cad8fb6323
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

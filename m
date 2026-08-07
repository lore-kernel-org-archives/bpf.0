Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF942C504;
	Fri,  7 Aug 2026 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110054; cv=none; b=JPvQZ23ksR6ywLDLU1NZuW6zP2EZdEpNZmlLwBJqSiFRk/0BidK0+KGAjtoK6k+1d8K0dP/ESXu6eRe2dGVu63i5PbFU3/tcJafnzxKpOOCCIun0Qiyp2u+/Tmmevq4PqtgYaTAHYhLW5GoncqbyrTZY6qXt5Mz8qAJ/Ri+7sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110054; c=relaxed/simple;
	bh=R5wdvPWpKY9RLphQaT1IeOM+uqI3FE4B7uqXxnYz4Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCpbPwLOtCLAZJgJVfJxvLB+GJAvTzp+krREp5SRuER4qJHeGPmEiIRR8s8jJo+CEfJNycWwQW1hR+osSdBLv4aayZ23baDo2qMBxg9ZBqtzpx9KCYvxMgsvlPwk5LFA6KPnQ1Nffwu6KWrCkQUDX3KKGrUIxE3aQhQLRApnDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJM++DOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJM++DOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FAE1F000E9;
	Fri,  7 Aug 2026 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110047;
	bh=qWcEwYyqe5hrFTNnhE11BNIc5KZLRQFFbwVnoconO7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJM++DOXHhLpKcNav0vg9Imj1ZZzDfF3xIhg7gqSJPnohxj2qO72tfGZ3GQrG3eon
	 w2aQ2xHmqH/M5hfYeRiW4yxi7ce78ajhNxeFQQaLuHmV0NFoqJEL+SDkE5o70Zm+O4
	 ZWgr//PGdB0vXfqpxW4DcVRysaLuJnAh204rTraHbYRyYuxFECgOxkz8Aj7l+nGwIO
	 fJU6xtYhVALhRCPfOF63oEABAGw5n2npg4kkoP27ou0xdM300PqT1xz09dnoIfEl4f
	 5Ji14B3paJi9fX9qWS55b/Gi4TwEayOIwnQGtFRLwZMZV1BBRLe5zZOQKI+umduKtO
	 Kz5M7jUm14BbA==
Date: Fri, 7 Aug 2026 14:40:41 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
	maz@kernel.org, ada.coupriediaz@arm.com, vladimir.murzin@arm.com
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <anXgWRmcjwPKG7N5@willie-the-truck>
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

[+Marc, Ada and Vladimir]

On Fri, Aug 07, 2026 at 04:45:31AM -0700, Breno Leitao wrote:
> Running retsnoop on a kernel with GIC priority masking and
> CONFIG_ARM64_DEBUG_PRIORITY_MASKING=y trips the ICC_PMR_EL1 sanity check
> in __pmr_local_irq_disable():
> 
>      WARNING: ./arch/arm64/include/asm/irqflags.h:63 at arm64_exit_to_kernel_mode+0xb8/0xc0, CPU#40: retsnoop/31805

That's warning because we're trying to disable interrupts in the PMR but
the existing PMR value is not IRQON or IRQOFF. The implication later is
that GIC_PRIO_PSR_I_SET is set.

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

Just a couple of nits that might help others:

  - The description refers to PSTATE_I_SET, which doesn't exist
  - The steps refer to 'regs->PMR' as though it's always the same memory
    location

> A) A task enters the kernel via a syscall.
> 	* PSTATE_I_SET becomes set on the live PMR
> 	* regs->PMR doesn't have PSR_I_SET set

Hmm. My (possibly incorrect) reading of the code here is that the syscall
entry path will clear GIC_PRIO_PSR_I_SET in the live PMR register when
unmasking interrupts via local_daif_restore(DAIF_PROCCTX) ...

> B) A BRK fires at EL1 and that is what leaves the live PMR
>    with PSR_I_SET.
> 	* At this stage PSTATE_I_SET is set on both on PMR and regs->PMR

... so the EL1 debug handler for the BRK shouldn't save a PMR value with
GIC_PRIO_PSR_I_SET into the regs. We leave interrupts disabled for debug
exceptions, so I agree that the PMR register retains GIC_PRIO_PSR_I_SET.

> C) A nested synchronous exception happens (Not sure why -- BPF related)
> 	* Now both the live PMR and regs->pmr have PSR_I_SET.

That looks like it's the case and local_daif_inherit() won't change
anything. I wonder if we should drop GIC_PRIO_PSR_I_SET when writing
the PMR there?

Will

(retaining the rest of the mail for the folks I've added)

> D) On the way out, local_irq_disable() → __pmr_local_irq_disable() warns.
>    It detects that PMR is different than GIC_PRIO_IRQON and GIC_PRIO_IRQOFF,
>    given live PMR and regs->PMR have PSTATE_I_SET ORed.
>
> How to fix it? I don't know very well.
> 
> I am not certain that we want to have PSTATE_I_SET ever be sent to
> regs->pstate. Do we ever need PSTATE_I_SET in regs->pstate?
> 
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

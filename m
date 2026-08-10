Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B23B27E7;
	Mon, 10 Aug 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365901; cv=none; b=VJrfouuNhWdSgw2EObBOfFvDPmhut6Rx+Dm5Y3ht1ciwq7bysO7gCWV/7mHx3u38wTwJBvQuMXyZqxFdTqLewpJ9OQv3VOIcRYQz2T3zzybQDUgzTIem8cisBIv/tsAYmRHldZqVTuciRczCvMf11+bDg0B1W6LC102x0gMHoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365901; c=relaxed/simple;
	bh=GEenzlBQc6KKaziZ3PMcsNF1AWWp53n8YN+QE7aTmcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVsZcVsgJ99IiEzL/5Qb/sBNjPsTClOM2e277YUGgrtDlvgGXK2Wq+oDUXQLoLOFGx6Rz0JlQTB6iMom/VR9IznAc6uEpy5zqXA6vpPAGeVgvmxDaK8c7d1CWb9hou5YwgrAEM9Urhkd55qenFfG1PLO9bunJnjIzh0ePyBEuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J7QUo6iK; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J7QUo6iK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RqJkZU7NaXl+U7FK5NGU95QDJ/WwisA1feCPvABBOc8=;
	b=J7QUo6iKuODH/rHgatCwi3i7F81+lizMxx50XqcCLQtrWmGXs5jMoAT+ZRehXvGaIqUK2xrGl
	IgQzlsX6DqoXikzeZDFJ5ebhdlzbikrHzciEt31YYDZI7I7+VV2stpeem6fKhFaW6+HA4PHu8aC
	IHSn39VeIUW5+Zd4RT0tYNU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hJZ2X0cwFzcb3P;
	Mon, 10 Aug 2026 20:34:44 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D9B0D4057D;
	Mon, 10 Aug 2026 20:44:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Aug 2026 20:44:46 +0800
Message-ID: <7b16d183-86d5-481e-b212-977ad0598ac7@huawei.com>
Date: Mon, 10 Aug 2026 20:44:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Vladimir Murzin <vladimir.murzin@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Breno Leitao <leitao@debian.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <rmikey@meta.com>, <kernel-team@meta.com>, Ada Couprie
 Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <0c47125b-6a5e-41c9-b31c-d78643cbe6bd@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <0c47125b-6a5e-41c9-b31c-d78643cbe6bd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/7 22:49, Vladimir Murzin 写道:
> On 8/7/26 14:57, Mark Rutland wrote:
>> Hi Breno,
>>
>> On Fri, Aug 07, 2026 at 04:45:31AM -0700, Breno Leitao wrote:
>>> Running retsnoop on a kernel with GIC priority masking and
>>> CONFIG_ARM64_DEBUG_PRIORITY_MASKING=y trips the ICC_PMR_EL1 sanity check
>>> in __pmr_local_irq_disable():
>>>
>>>      WARNING: ./arch/arm64/include/asm/irqflags.h:63 at arm64_exit_to_kernel_mode+0xb8/0xc0, CPU#40: retsnoop/31805
>>>      CPU: 40 UID: 0 PID: 31805 Comm: retsnoop Not tainted 7.2.0-rc6-next-20260805 #7 PREEMPTLAZY
>>>      pstate: 234013c9 (nzCv DAIF +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
>>>      pc : arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63)
>>>      lr : el1_abort (arch/arm64/kernel/entry-common.c:323)
>>>      pmr: 000000f0
>>>      Call trace:
>>> D)    arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63) (P)
>>>       el1_abort (arch/arm64/kernel/entry-common.c:323)
>>>       el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:449)
>>> C)    el1h_64_sync (arch/arm64/kernel/entry.S:589)
>>>       copy_from_kernel_nofault (mm/maccess.c:52) (P)
>>>       bpf_probe_read_kernel (kernel/trace/bpf_trace.c:268)
>>>       bpf_prog_db21a1730c2407e5_calib_exit+0xf0/0x160
>>>       trace_call_bpf (kernel/trace/bpf_trace.c:147)
>>>       kretprobe_perf_func (kernel/trace/trace_kprobe.c:1750)
>>>       kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1875)
>>>       __kretprobe_trampoline_handler (kernel/kprobes.c:2116)
>>>       kretprobe_brk_handler (arch/arm64/kernel/probes/kprobes.c:422)
>>>       call_el1_break_hook (arch/arm64/kernel/debug-monitors.c:244)
>>>       do_el1_brk64 (arch/arm64/kernel/debug-monitors.c:266)
>>> B)    el1_brk64 (arch/arm64/kernel/entry-common.c:427)
>>>       el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:481)
>>>       el1h_64_sync (arch/arm64/kernel/entry.S:589)
>>>       invoke_syscall (arch/arm64/kernel/syscall.c:49) (P)
>>>       do_el0_svc (arch/arm64/kernel/syscall.c:140)
>>>       el0_svc (arch/arm64/kernel/entry-common.c:736)
>>>       el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:755)
>>> A)    el0t_64_sync (arch/arm64/kernel/entry.S:594)
>>>
>>> This is my understand of the current situation:
>>>
>>> A) A task enters the kernel via a syscall.
>>> 	* PSTATE_I_SET becomes set on the live PMR
>>> 	* regs->PMR doesn't have PSR_I_SET set
>> At this point, regs->pmr will be the value of PMR when we were executing
>> in userspace, which should be the value of regs->pmr the last time we
>> returned to userspace. That should be GIC_PRIO_IRQON, as configured by
>> start_thread_common().
>>
>> The entry asm will set PMR to 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET', but
>> that should be reset to GIC_PRIO_IRQON when el0_svc() calls
>> local_daif_restore(DAIF_PROCCTX).
>>
>> Within invoke_syscall(), we should have DAIF==0 and PMR==GIC_PRIO_IRQON.
>>
>>> B) A BRK fires at EL1 and that is what leaves the live PMR
>>>    with PSR_I_SET.
>>> 	* At this stage PSTATE_I_SET is set on both on PMR and regs->PMR
>> The value in the regs->pmr should be GIC_PRIO_IRQON, without
>> GIC_PRIO_PSR_I_SET.
>>
>> As we don't unmask anything during BRK handling, the live PMR should
>> contain 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET'.
>>
>>> C) A nested synchronous exception happens (Not sure why -- BPF related)
>>> 	* Now both the live PMR and regs->pmr have PSR_I_SET.
>> The presence of 'el1_abort()' in the trace suggests that BPF tried to
>> access memory which faulted. That looks to be a result of
>> bpf_probe_read_kernel() and copy_from_kernel_nofault().
>>
>> Regardless of BPF, we can probably trigger a synchronous exception with
>> a WARN() or similar, so we will need to handle synchronous exceptions
>> from the same contexts.
>>
>> In general, probing kernel VAs is fraught with danger even with a fault
>> handler, and IMO copy_from_kernel_nofault() is a dangerous and poorly
>> conceived interface. For example, if you're probing an arbitrary kernel
>> VA, you have no idea whether you're about to poke MMIO and crash the
>> system.
>>
>> It would be interesting to know what the BPF program is doing, in case
>> it could crash the kernel in other ways we can't prevent here.
>>
>>> D) On the way out, local_irq_disable() → __pmr_local_irq_disable() warns.
>>>    It detects that PMR is different than GIC_PRIO_IRQON and GIC_PRIO_IRQOFF,
>>>    given live PMR and regs->PMR have PSTATE_I_SET ORed.
>> Only the live value of PMR is important here, and the value of regs->pmr
>> is immaterial.
>>
>> The warning is here to capture the fact that if
>> __pmr_local_irq_disable() were to set PMR to GIC_PRIO_IRQOFF, it would
>> effectively discard GIC_PRIO_PSR_I_SET and change the masked priority,
>> which has a bunch of secondary impacts for things like idle.
>>
> 
> That matches my understanding of call trace
> 
> Call stack                    |live DAIF:PMR  | regs DAIF:PMR
> --------------------------------------------------------------
> <exception>
> el0_svc                       | DAIF:IRQ_ON+I | daif:IRQ_ON
>  - local_daif_restore         | daif:IRQ_ON   |
> <exception>            
> el1_brk                       | DAIF:IRQ_ON+I | daif:IRQ_ON
> <exception>            
> el1_abort                     | DAIF:IRQ_ON+I | DAIF:IRQ_ON+I
>  - local_daif_inherit         | DAIF_IRQ_ON+I |
>  - arm64_exit_to_kernel_mode  |               |
>    - local_irq_disable        |               |
> 
> where:
> - DAIF is DAIF_MASK
> - daif is DAIF_PROCCTX
> - IRQ_ON is GIC_PRIO_IRQON
> - I is GIC_PRIO_PSR_I_SET

It's the same as what I understand.

> 
> 
>> We'll need to work through those impacts; we might be able to relax the
>> check.
>>
>>> How to fix it? I don't know very well.
>> The complete fix (which Ada and Vladimir have both been working on) is
>> to get rid of GIC_PRIO_PSR_I_SET entirely, which requires structural
>> changes in a few places/
>>
>> I don't think we'd realised there was an extant bug of this shape, so
>> we'll need to consider what we can do to fix this in a backportable way.
>>
>>> I am not certain that we want to have PSTATE_I_SET ever be sent to
>>> regs->pstate. Do we ever need PSTATE_I_SET in regs->pstate?
>> I'm not sure what you mean here. PSTATE_I_SET doesn't exist, and I'm not
>> sure whether you're asking about the PSTATE.DAIF bits saved in
>> regs->pstate, or the PMR value in regs->pmr.
>>
>> Regardless of pseudo-NMI, is is essential that regs->pstate holds a
>> complete snapshot of SPSR, including the I bit.
>>
>> With pseudo-NMI, it is essential that the full PMR value (including
>> GIC_PRIO_PSR_I_SET) is saved into regs->pmr.
>>
>> However, as above, AFAICT only the live value matters here.
>>
>>> In the current patch, I found that disabling IRQ in case it is disabled,
>>> would solve the warning, but, this seems more a hack than a proper fix,
>>> perhaps.
>>>
>>> Fixes: ae654112eac0 ("arm64: entry: Use split preemption logic")
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>  arch/arm64/kernel/entry-common.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>>> index ceb4eb11232a6..fcce9ccd37108 100644
>>> --- a/arch/arm64/kernel/entry-common.c
>>> +++ b/arch/arm64/kernel/entry-common.c
>>> @@ -55,7 +55,13 @@ static noinstr irqentry_state_t arm64_enter_from_kernel_mode(struct pt_regs *reg
>>>  static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
>>>  					      irqentry_state_t state)
>>>  {
>>> -	local_irq_disable();
>>> +	/*
>>> +	 * Only irqentry_exit_to_kernel_mode_preempt() needs interrupts masked,
>>> +	 * and it returns early when regs had them disabled. Skipping the
>>> +	 * disable avoids clobbering a PMR the irqflags API does not expect.
>>> +	 */
>>> +	if (!regs_irqs_disabled(regs))
>>> +		local_irq_disable();
>>>  	irqentry_exit_to_kernel_mode_preempt(regs, state);
>> I think that might happen to work as a bodge, but I don't think this is
>> a proper fix, and we'll need a clearer explanation of what's going on.
>>
> 
> Agreed on the need for a clearer explanation.
> 
> Perhaps local_irq_disable() isn't the right API here, and we should
> use local_daif_restore(DAIF_PROCCTX_NOIRQ) instead?

The local_irq_disable() here is pair with the local_irq_enable() in
preempt_schedule_irq(). So I think it is not correct to replace them
separately.

The pseudo NMI does not consider how to do local_irq_disable() /enable()
when the interrupt is masked by the DAIF.I bit as I reported before.

7544 asmlinkage __visible void __sched preempt_schedule_irq(void)
 7545 {
 7546 >-------enum ctx_state prev_state;
 7547
 7548 >-------/* Catch callers which need to be fixed */
 7549 >-------BUG_ON(preempt_count() || !irqs_disabled());
 7550
 7551 >-------prev_state = exception_enter();
 7552
 7553 >-------do {
 7554 >------->-------preempt_disable();
 7555 >------->-------local_irq_enable();
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 7556 >------->-------__schedule(SM_PREEMPT);
 7557 >------->-------local_irq_disable();
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 7558 >------->-------sched_preempt_enable_no_resched();
 7559 >-------} while (need_resched());
 7560
 7561 >-------exception_exit(prev_state);
 7562 }

https://lore.kernel.org/all/alTYgMwLaG5sk-P4@J2N7QTR9R3.cambridge.arm.com/T/#m0b7b781a10c06c46296ec8a35be4be1c4ca343a0

> 
> Looking ahead, making an early decision on whether to preempt based on
> regs_irqs_disabled() seems like a reasonable approach. That's what
> I've done in [1] (though keep in mind that I forgot to update
> el0_irq).
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20260727163453.7969-10-vladimir.murzin@arm.com/
> 
> Cheers
> Vladimir
> 
>> Mark.
>>
>>>  	local_daif_mask();
>>>  	mte_check_tfsr_exit();
>>>
>>> ---
>>> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
>>> change-id: 20260807-arm64_fix-47cad8fb6323
>>>
>>> Best regards,
>>> --  
>>> Breno Leitao <leitao@debian.org>
>>>
> 
> 


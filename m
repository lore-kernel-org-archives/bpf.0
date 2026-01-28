Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF9340A6F
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639626; cv=none; b=SVP4RjxYQ1PgW/9yMoniMwLnOKxC0x82lvtKsI8B0QZy7yXQ50HbAs4rB5+drCW5Be7ulTkcfjZxV8oZFZeIPKNWotDyzQsTsyph/eRJ58LTTVE/Ae1qlpuDwoPX38iTu4jwXqclYzP+hp5OFNH9VDNiDv1RXP6Dwm0YCRUXB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639626; c=relaxed/simple;
	bh=B1kyEwD3mpoUFrGRBWb8CY/lp6PB1RhkLIpq/4aJOsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nExTjZe30YveE7GOf+DdAf9HMiMCMkLPfCFF2o350OLtPlDE41lU4XlFNgGgrk8vKevG9QpMvxDvWgjNA/Gh9b78OFG2GOANLwSlSFaN4ly2DgvnQkpCToeYiv1zorqCoXy0m8VpHsjqRf4viMPJrFVkMy9/2D2rOYDOmnfdxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fyc/HMgz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fyc/HMgz"
Message-ID: <70335ad4-59b6-45fd-8a76-bd91d9658810@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769639621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LkpFq9hmJDRWtvAXA5WrB8I/NBN3bpPKMxo6rmc+Hs=;
	b=fyc/HMgzM7WRmW38LnB+GRiZ3vrSlJnGihgkVxtGtrX+q+47UZQF6UZaX+MaJmHBiMO5cM
	DAhKH6SSyTGBmhuqZcxLpesyDvq46i50X82uaXH11BpR1rndriT/FZKtFyxRdx38Tzokea
	QCWU5p8dbdKiWzeAMmEHUgNqWBCHVhU=
Date: Wed, 28 Jan 2026 14:33:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
To: Thomas Gleixner <tglx@kernel.org>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, bpf <bpf@vger.kernel.org>,
 sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan
 <puranjay@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev> <877bt29cgv.ffs@tglx>
 <bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ibm.com> <87y0lh96xo.ffs@tglx>
 <87jyx1ml3h.ffs@tglx>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <87jyx1ml3h.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/26 2:24 PM, Thomas Gleixner wrote:
> On Wed, Jan 28 2026 at 14:56, Thomas Gleixner wrote:
>> On Wed, Jan 28 2026 at 18:28, Shrikanth Hegde wrote:
>>> On 1/28/26 5:27 PM, Thomas Gleixner wrote:
>>>   watchdog: CPU 23 self-detected hard LOCKUP @ mm_get_cid+0xe8/0x188
>>>   watchdog: CPU 23 TB:1434903268401795, last heartbeat TB:1434897252302837 (11750ms ago)
>>>   NIP [c0000000001b7134] mm_get_cid+0xe8/0x188
>>>   LR [c0000000001b7154] mm_get_cid+0x108/0x188
>>>   Call Trace:
>>>   [c000000004c37db0] [c000000001145d84] cpuidle_enter_state+0xf8/0x6a4 (unreliable)
>>>   [c000000004c37e00] [c0000000001b95ac] mm_cid_switch_to+0x3c4/0x52c
>>>   [c000000004c37e60] [c000000001147264] __schedule+0x47c/0x700
>>
>> So if the above spins in mm_get_cid() then the below is just a consequence.
>>
>>>   watchdog: CPU 11 self-detected hard LOCKUP @ plpar_hcall_norets_notrace+0x18/0x2c
>>>   watchdog: CPU 11 TB:1434903340004919, last heartbeat TB:1434897249749892 (11895ms ago)
>>>   NIP [c0000000000f84fc] plpar_hcall_norets_notrace+0x18/0x2c
>>>   LR [c000000001152588] queued_spin_lock_slowpath+0xd88/0x15d0
>>>   Call Trace:
>>>   [c00000056b69fb10] [c00000056b69fba0] 0xc00000056b69fba0 (unreliable)
>>>   [c00000056b69fc30] [c000000001153ce0] _raw_spin_lock+0x80/0xa0
>>>   [c00000056b69fc50] [c0000000001b9a34] raw_spin_rq_lock_nested+0x3c/0xf8
>>>   [c00000056b69fc80] [c0000000001b9bb8] mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
>>>   [c00000056b69fd00] [c0000000001bff34] sched_mm_cid_exit+0x108/0x22c
>>>   [c00000056b69fd40] [c000000000167b08] do_exit+0xf4/0x5d0
>>>   [c00000056b69fdf0] [c00000000016800c] make_task_dead+0x0/0x178
>>>   [c00000056b69fe10] [c0000000000316c8] system_call_exception+0x128/0x390
>>>   [c00000056b69fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
>>
>>> I am wondering if it this loop in mm_get_cid, which may not be getting a cid
>>> for a long time? Is that possible?
>>
>> It shouldn't be possible by design, but it seems there is a corner case
>> lurking somewhere which hasn't been covered. Let me stare at the logic
>> in the transition functions once more. That's where CPU11 comes from:
>>
>>>   [c00000056b69fc80] [c0000000001b9bb8] mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
>>
>> The exiting it initiated a transition back from per CPU to per task mode
>> and that seems to make things unhappy for mysterious reasons.
> 
> I stared at it for a while and found the below stupidity. But when I
> actually sat down after a while away from the keyboard and tried to
> write a concise changelog explaining the root cause I failed to come up
> with a coherent explanation why this would prevent the above scenario,
> which hints at a situation of MMCID exhaustion.
> 
> @Ihor: Is the BPF CI fallout reproducible? If so, can you please provide
>        it?

Not reliably, unfortunately. I saw it at least twice (out of 100+
runs) this week.

I added `hardlockup_all_cpu_backtrace=1` to get more logs.  If there
is anything else I could set up (kconfigs, debug switches) that may be
helpful, let me know.

We have a steady stream of jobs running, so if it's not a one-off it's
likely to happen again. I'll share if we get anything.

Thank you for investigating!


> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10664,8 +10664,14 @@ void sched_mm_cid_exit(struct task_struc
>  			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
>  				if (!__sched_mm_cid_exit(t))
>  					return;
> -				/* Mode change required. Transfer currents CID */
> -				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
> +				/*
> +				 * Mode change. The task has the CID unset
> +				 * already. The CPU CID is still valid and
> +				 * does not have MM_CID_TRANSIT set as the
> +				 * mode change has just taken effect under
> +				 * mm::mm_cid::lock. Drop it.
> +				 */
> +				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
>  			}
>  			mm_cid_fixup_cpus_to_tasks(mm);
>  			return;


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB683B0AD8;
	Mon, 10 Aug 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379999; cv=none; b=EMC4RPFnhN6ELm0QdfnSvyG29ssrkxaIyr9sSI3iS6UznbP43RD09Ap/0J6DGjI/mqkKgApkMpx24R2NMSnPDHibUH+tutwMOz89tXUld0L2maVtHnhXMrQWeu/vMkcGGrsjoK/lUplvPa8xE4rsvaGETj8LC/PMTEvPsBqSy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379999; c=relaxed/simple;
	bh=WKCQbGP9SiDhEpOg5eWYTMaL6MWaimf9g6vwuwJjDBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLouCvtBzLPaHjXgcfe17ZWqfHkN4blqAbnu3f/G8mFTCO9uiJV5Oc7E6AlDhkkb6b4hybxZDLOV2tliWpo0Os2w2wSopA3AUgmM7oXG0ztI/oHxX6oMDaiBM3EdCYoJS+EepfSjuuUIkSJjjCvvB8RO011etuKwBl8XZjuZ8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HgRN1Gj0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HgRN1Gj0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D782014BF;
	Mon, 10 Aug 2026 09:39:52 -0700 (PDT)
Received: from [10.1.34.163] (e121487-lin.cambridge.arm.com [10.1.34.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 491EB3F86F;
	Mon, 10 Aug 2026 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786379996; bh=WKCQbGP9SiDhEpOg5eWYTMaL6MWaimf9g6vwuwJjDBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HgRN1Gj0zbXrqcMDqWuW1BiGk+VKjACyu6nvx6ZB4QYbHKUHlOmKiPwfJXmyPuJnx
	 mHJL2wTum5B7eaergJeyQSTSfD+fVrT2JkvSNP94o7Fx6Bem2t6k7GW7OQmto/Ncw0
	 +YZHTBHjSzr7OwhyGaJ0vJVwn9ed1XTMZ4Fh+iUY=
Message-ID: <9b06f274-8db1-48e4-839e-e387c050d328@arm.com>
Date: Mon, 10 Aug 2026 17:39:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com,
 kernel-team@meta.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com> <anm5T9FazACqOWXF@willie-the-truck>
 <2a97f777-d33a-4b3d-8c8c-6f6894f04c29@arm.com>
 <annoxlkkq1NpujsP@willie-the-truck>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <annoxlkkq1NpujsP@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 16:05, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 01:42:15PM +0100, Vladimir Murzin wrote:
>> On 8/10/26 12:43, Will Deacon wrote:
>>> On Fri, Aug 07, 2026 at 09:29:12AM -0700, Breno Leitao wrote:
>>>> On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
>>>>> Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
>>>>> a better grasp of the states machine we are in (probably on Monday).
>>>> It seems LLM found a very easy to reproduce this:
>>>>
>>>> 	bash-5.1# dmesg
>>>>
>>>> 	bash-5.1#  cd /sys/kernel/tracing
>>>> 	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
>>>> 	echo 1 > events/kprobes/pmr/enable
>>> Nice, that triggers straightforwardly in QEMU for me. The diff below
>>> (which implements my suggestion from [1]) seems to fix the issue, but
>>> it would be good to hear feedback from one of the Arm folks.
>>>
>>> [1] https://lore.kernel.org/all/anXgWRmcjwPKG7N5@willie-the-truck/
>>>
>>> --->8
>>>
>>> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
>>> index 795b35128467..691ee5f86dbe 100644
>>> --- a/arch/arm64/include/asm/daifflags.h
>>> +++ b/arch/arm64/include/asm/daifflags.h
>>> @@ -132,7 +132,7 @@ static __always_inline void local_daif_inherit(struct pt_regs *regs)
>>>                 trace_hardirqs_on();
>>>
>>>         if (system_uses_irq_prio_masking())
>>> -               gic_write_pmr(regs->pmr);
>>> +               gic_write_pmr(regs->pmr & ~GIC_PRIO_PSR_I_SET);
>>>
>>>         /*
>>>          * We can't use local_daif_restore(regs->pstate) here as
>>>
>> I have no strong opinion on the change, but I struggle to see how it
>> fits into the big picture.
>>
>> Specifically, I have difficulty explaining this change in isolation.
>> Everywhere else, we try to keep DAIF.I and GIC_PRIO_PSR_I_SET in sync,
>> so it is not clear why we should allow them to go out of sync when
>> inheriting the exception state from the previous context.
> Yeah, I think you're right, and looking at it some more it means we
> end up with the pmr in the IRQON state which will break
> arch_irqs_disabled().
> 

Ahh, nice catch!

>> At the same time, IIUC, the only reason we call local_irq_disable()
>> (which also causes the states to become unsynchronized) in
>> arm64_exit_to_kernel_mode() is for preemption path. So avoiding
>> local_irq_disable() (and preemption) when we interrupted a
>> non-preemptible context seems easier to follow.
> In the past, we only preempted when returning to EL1 off the back of an
> IRQ, but that was changed in ae654112eac0 ("arm64: entry: Use split
> preemption logic") which I think is where this bug was introduced.
>

I believe we started allowing preemption from EL1 exceptions other
than IRQ when we moved to the generic IRQ entry code. It turned out
that, unfortunately, this is not safe in some cases, which is what
Mark's series addressed.

I agree that the change mentioned above introduced an unconditional
local_irq_disable(), and if we want to backport it, it should be
recorded under a Fixes.
 > So we could probably hack something as you suggest, but maybe the best
> option is to take patches 8 and 9 from your FEAT_NMI series? WDYT?
> 

Whatever you prefer, tbh :)

Patch 9 codifies my understanding of how things are expected to
work. That said, I accept that I could be missing something, hence the
RFC tag.

In case you decide to take it, we probably need to:

- extend the commit message to cover Breno's report (right now, the
  commit message makes it look like a refactoring)

- add Fixes tags if we want it to be backported

Alternatively, I can respin the patch separately with the suggestions
above applied - just let me know ;)

Cheers
Vladimir

> Will
> 


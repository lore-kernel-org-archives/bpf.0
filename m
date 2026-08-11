Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03D346A18;
	Tue, 11 Aug 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436334; cv=none; b=shwSYbnD1AS6sLKlg4E7ufeXCLqG3haQMdlXdPd0ztFGk0sx/b5c33u8y1UCAz8z1USsQStZOUciN/l6Qt06jASgL/psprCaiBc3Id0uZVWM5M/WwUBSq8CcfYJ3jnl8RnMTKmp1yreKWJbXYF9soIVya+jOdyqAiPfIc+qH8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436334; c=relaxed/simple;
	bh=8moHjI7fKAAhoK29cxA112fLWHn5wifKLAir2LIKSfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFZT1M0IGsEkwFReCc+kldFy4VYMWVHq9O2GIdTVKZ0BIMDKkYgQA8gv7lcWMb8HkQBmHUjvWR6k6XRJEpyhREhtE0Ycg699m99O2dNjKPoIUMOmFcK3ucB0ysQNeGOT556Hp/D13PsD0xtvsAY8zdVwrFpCbmKW2D7B0YfqfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=narF+GyV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="narF+GyV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9CD1516;
	Tue, 11 Aug 2026 01:18:48 -0700 (PDT)
Received: from [10.57.68.120] (unknown [10.57.68.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D8D3F673;
	Tue, 11 Aug 2026 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786436332; bh=8moHjI7fKAAhoK29cxA112fLWHn5wifKLAir2LIKSfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=narF+GyVC4Q/fzrghTVc+nyDaF4Y3IUB9PAV3VRo16QzW01jXryrMz8PTQeO9v4oJ
	 7he4UtXllLggJeyA51FxrTAOlInIjDuFJ3LFnSlTemt+hCNhL5jzU1G2T1YuKat4Je
	 6fBTi078tPfkd/QULMqTbHJUQ4PEY9L/zaHjc0Bs=
Message-ID: <e2325b50-882c-4948-ae0c-d84a39e50331@arm.com>
Date: Tue, 11 Aug 2026 09:18:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Jinjie Ruan <ruanjinjie@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <0c47125b-6a5e-41c9-b31c-d78643cbe6bd@arm.com>
 <7b16d183-86d5-481e-b212-977ad0598ac7@huawei.com>
 <3e5f1532-ea17-4994-8cd0-5ce1d42e9049@arm.com>
 <77080aa8-7df1-43f0-8c82-1096db05f745@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <77080aa8-7df1-43f0-8c82-1096db05f745@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 03:47, Jinjie Ruan wrote:
> 
> 在 2026/8/10 21:04, Vladimir Murzin 写道:
>> On 8/10/26 13:44, Jinjie Ruan wrote:
>>>> Agreed on the need for a clearer explanation.
>>>>
>>>> Perhaps local_irq_disable() isn't the right API here, and we should
>>>> use local_daif_restore(DAIF_PROCCTX_NOIRQ) instead?
>>> The local_irq_disable() here is pair with the local_irq_enable() in
>>> preempt_schedule_irq(). So I think it is not correct to replace them
>>> separately.
>>>
>>> The pseudo NMI does not consider how to do local_irq_disable() /enable()
>>> when the interrupt is masked by the DAIF.I bit as I reported before.
>> Unless I missed anything local_daif_restore(DAIF_PROCCTX_NOIRQ) would
>> clear DAIF.{IF} and set PMR to GIC_PRIO_IRQOFF which is the state we
> Hi, Vladimir,
> 
> Yes, local_daif_restore(DAIF_PROCCTX_NOIRQ) does indeed clear the
> DAIF.IF bit and then set the PMR to IRQOFF.
> 
> But there is a side effect that will clear the DAIF.{DA} bit. This will
> cause `arch_irqentry_exit_need_resched()` to bypass the DAIF check.
> Originally, it could not be preempted, but after this fix, it becomes
> preemptible.
> 
> As the below comment said, If DAIF.{DA} is set, we may be handling an
> NMI or debug context, and preemption should not occur.
> 

Yes, indeed, it is why in my other reply I added

"if we believe it is OK to downgrade the inherited context"

... and it seems it is not OK.

Cheers
Vladimir

> 30 static inline bool arch_irqentry_exit_need_resched(void)
>  31 {
>  32 >-------/*
>  33 >------- * DAIF.DA are cleared at the start of IRQ/FIQ handling, and
> when GIC
>  34 >------- * priority masking is used the GIC irqchip driver will
> clear DAIF.IF
>  35 >------- * using gic_arch_enable_irqs() for normal IRQs. If anything
> is set in
>  36 >------- * DAIF we must have handled an NMI, so skip preemption.
>  37 >------- */
>  38 >-------if (system_uses_irq_prio_masking() && read_sysreg(daif))
>  39 >------->-------return false;
> 
> Best regards,
> Jinjie
> 
>> expect from local_irq_disable() so we can do local_irq_{en,dis}able()
>> later on.
>>
>> Cheers
>> Vladimir
>>


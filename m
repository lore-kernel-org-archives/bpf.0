Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459013D9DC7;
	Mon, 10 Aug 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365743; cv=none; b=HXUfXsiU4gHJwsLb9zTF5SPN2tjrG029bPXYDZmLOsZ8JqoAeNQ4ZM7LXPyoKkNMr+epH+GN5JWioH3h6NEvqNMpkdurTpF9pLOBFdfRMmdML97uiwlacxt/t5dOR+OGFTYbx6rNGBFcRm8Ei9D8XXH3aa7gHNs54YtZeJzFwTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365743; c=relaxed/simple;
	bh=LfJqW5tpDOzFHBapUGs2MDgPQl1V/FtAeE1FZNBfIGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc8umY6ZxNH8Sgs5VzNNMFZmmnGxwRAY1qN8ctupIdIeWWCQ3lzdCJfy7gR4uEzrVlHRp4dvVeoMoIhDaomrQQft5gCUuSKhtXmuKm6ylMJ0ug6wliuR8kIXeeuGlN9x901PZI/4Ak0lHyKdtLUDX7Dqf4LHezjGk2mXnW7mUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ISeTa5nr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ISeTa5nr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BC49143D;
	Mon, 10 Aug 2026 05:42:15 -0700 (PDT)
Received: from [10.1.34.163] (e121487-lin.cambridge.arm.com [10.1.34.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0530A3F86F;
	Mon, 10 Aug 2026 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786365739; bh=LfJqW5tpDOzFHBapUGs2MDgPQl1V/FtAeE1FZNBfIGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ISeTa5nrufIkRolP9n8jeKaqRxnpZylF8jHYbBhn9QKqpGQyxayN7079KPL3QFBRR
	 xv1T7sUzVLOIFjhKo6WhKLN2GUa5xsnPf9wUjM3ovXtRgKKuKTLhYgt7jog1pTQ58U
	 mcH06Navhqr5PvcnAXX0PdEy+2K8oFCODp/aj2Ks=
Message-ID: <2a97f777-d33a-4b3d-8c8c-6f6894f04c29@arm.com>
Date: Mon, 10 Aug 2026 13:42:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Will Deacon <will@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com,
 kernel-team@meta.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com> <anm5T9FazACqOWXF@willie-the-truck>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <anm5T9FazACqOWXF@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Will,

On 8/10/26 12:43, Will Deacon wrote:
> On Fri, Aug 07, 2026 at 09:29:12AM -0700, Breno Leitao wrote:
>> On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
>>> Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
>>> a better grasp of the states machine we are in (probably on Monday).
>> It seems LLM found a very easy to reproduce this:
>>
>> 	bash-5.1# dmesg
>>
>> 	bash-5.1#  cd /sys/kernel/tracing
>> 	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
>> 	echo 1 > events/kprobes/pmr/enable
> Nice, that triggers straightforwardly in QEMU for me. The diff below
> (which implements my suggestion from [1]) seems to fix the issue, but
> it would be good to hear feedback from one of the Arm folks.
> 
> Will
> 
> [1] https://lore.kernel.org/all/anXgWRmcjwPKG7N5@willie-the-truck/
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index 795b35128467..691ee5f86dbe 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -132,7 +132,7 @@ static __always_inline void local_daif_inherit(struct pt_regs *regs)
>                 trace_hardirqs_on();
> 
>         if (system_uses_irq_prio_masking())
> -               gic_write_pmr(regs->pmr);
> +               gic_write_pmr(regs->pmr & ~GIC_PRIO_PSR_I_SET);
> 
>         /*
>          * We can't use local_daif_restore(regs->pstate) here as
> 

I have no strong opinion on the change, but I struggle to see how it
fits into the big picture.

Specifically, I have difficulty explaining this change in isolation.
Everywhere else, we try to keep DAIF.I and GIC_PRIO_PSR_I_SET in sync,
so it is not clear why we should allow them to go out of sync when
inheriting the exception state from the previous context.

At the same time, IIUC, the only reason we call local_irq_disable()
(which also causes the states to become unsynchronized) in
arm64_exit_to_kernel_mode() is for preemption path. So avoiding
local_irq_disable() (and preemption) when we interrupted a
non-preemptible context seems easier to follow.

Alternatively, using local_daif_restore(DAIF_PROCCTX_NOIRQ) directly,
if we believe it is OK to downgrade the inherited context, would
achieve the same effect as local_irq_disable() while keeping DAIF and
PMR in sync.

Cheers
Vladimir

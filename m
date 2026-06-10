Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FD287263
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116159; cv=none; b=LSTBQrY88emVxSAD84Ez1C/UJmitAJ6mBCyUKCTnTNTB+qLHAB7WovJGwzf4rhxhDPDCTd6G7YPTELORTb5xR5ZwKmGurlIE0s9svFqzywiQLooszZc3Ig3k3/mQJjhgiwY8OjFfZnhGRVT37yupB1cPlqPSnnzdeiktRo7b75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116159; c=relaxed/simple;
	bh=vq893cOoOr0gmJwGksL9/IPCxUYijv8aAcMAtsu7ZdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0kXHWxrvrtAkOxeGvx8U2X0b859x/sKHuBo6gOHZl/zGbqDa3qT/ApsfsdCVQPjSV55VGeRD9NQrkA4syGQT7qdnuCPUNMH3V6ZJrq4C4st8Tjgc7bW2BdyrfqNlDqZ1K7TNqBH6OCAFErtOEJOzqaHA6pwESaNE8zcrZfLWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeZRgg04; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeZRgg04"
Message-ID: <7b6d449f-c70c-4e8e-bfc4-a2f75517395c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781116145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXkcVBBhkoIwVA3JoPxsNhVcRJ8opaaDptjillfXcwU=;
	b=TeZRgg04L4P22kmKlGOqqUeha4QGT0mcVOGrY9mmaHcjfK5JD/R3LAbGjT4m2VXJCfYaGZ
	qMkMNFuIaxY7oNxTl+Upwj5RZjHb9v8PikutOHsjkABctjr9tcbssfFHVf2/u+q/mAMWQ8
	2bDD4ghbdRzz236h5TmLH+/1IYsO6HE=
Date: Wed, 10 Jun 2026 11:28:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <20260610181729.7F44C1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260610181729.7F44C1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 11:17 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Incomplete fix and architectural layering violation via x86-specific macro in generic KASAN code.
> 
> Pre-existing issues:
> - [High] Unhandled root cause: CPU feature flags are non-atomically cleared while interrupts are enabled.
> --
> 
> commit 5a28adbdf7cd811d1903c7692ad3799adc4606f3
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> kasan: Fix false-positive wild-memory-access on x86 under 5-level paging
> 
> This commit attempts to fix a flaky false-positive KASAN splat on x86_64
> with 5-level paging. It addresses a race where the LA57 CPU feature is
> temporarily cleared during boot by defining USE_EARLY_PGTABLE_L5 in the
> generic KASAN code.
> 
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index 2b8e73f5f6a70..b5f430f2dbb68 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -9,6 +9,13 @@
>>   *        Andrey Konovalov <andreyknvl@gmail.com>
>>   */
>>  
>> +/*
>> + * check_region_inline() and addr_has_metadata() can run very early.
>> + * For example, in an interrupt taken while identify_cpu() has the CPU
>> + * capability bits temporarily cleared.
>> + */
>> +#define USE_EARLY_PGTABLE_L5
> 
> [Severity: Medium]
> Is it appropriate to place the x86-specific USE_EARLY_PGTABLE_L5 macro in
> the generic KASAN code?
> 
> Since this macro is only defined locally in generic.c, other generic KASAN
> files like mm/kasan/report.c remain unaware of it.

Correct. Setting USE_EARLY_PGTABLE_L5 only fixes the particular issue that I
stumbled on. AFAIU there may be a slight runtime performance hit when using
this flag, so we might not want to set it more widely.

I'll defer to KASAN maintainers to comment on this.

> 
> If a genuine KASAN bug occurs during the race window, wouldn't print_report()
> miscalculate the shadow memory addresses:
> 
> mm/kasan/report.c:print_report() {
>     ...
>     if (addr_has_metadata(addr)) {
>     ...
> }
> 
> and fail to print the memory metadata because it uses the 4-level paging
> start address instead of the 5-level one?
> 
> [ ... ]
> 
>> The root cause is in generic KASAN not seeing
>> cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
>> in identify_cpu() when the offending interrupt happens [1]:
>>
>>   memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
>>   ...
>>   get_cpu_cap(c);                       /* re-reads CPUID, restores it */
> 
> [Severity: High]
> This is a pre-existing issue, but does this approach leave the underlying
> race condition unhandled?

Yes, the underlying caveat that x86_capability is cleared within an 
interruptable window remains. Potentially any other interrupt handler that
checks for any other CPU capability may run into similar problem.

That said, LA57 and KASAN feel like a special case. And I don't see an obvious
way to fix this on identify_cpu() side. Disabling IRQ is clearly an overkill.

I'm very open to alternative solutions though, I am a tourist here.

> 
> In arch/x86/kernel/cpu/common.c:identify_cpu(), boot_cpu_data.x86_capability
> is cleared non-atomically while local interrupts are still enabled. This
> can occur because arch_cpu_finalize_init() runs after local_irq_enable().
> 
> Because alternative instructions have not yet been patched at this point in
> the boot sequence, cpu_feature_enabled() dynamically checks
> boot_cpu_data.x86_capability.
> 
> Could any interrupt handler that fires during this window and checks a CPU
> feature spuriously see it as disabled, potentially causing core subsystems
> to execute incorrect fallback paths? 
> 
> Would it be safer to disable local interrupts during the boot_cpu_data
> initialization in identify_cpu() instead?
> 


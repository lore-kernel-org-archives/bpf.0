Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B4355819
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525225; cv=none; b=oMtB2++s3vok05bSjnDWRQhRPTeUIHub3HXfBfLxRcemESloyIKHk1+CMuBrv1kgoXpQm8/k9jBawjb2C7a0JA0KfXdg/0WM2Wv2GQWRFo5Q9WFhED5WvxWmNNQ0ewpt+euQRd4zLlYFK1fuyrPdvlgxfWNSyVq5o1K8zrvE3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525225; c=relaxed/simple;
	bh=OqL8VyxUr+ybF1+Pet4IQHR6D2FEKlj8HJng/FJHiZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VR+S73mGSCEmgEc9jSLfCukmaiqrMarJ4l4bwEMiuQrPzCDNahwgpZvqIMt8qz50BT+4pjvYfgi73PASW0dxGhShhBMSE43n+dOk5TomYLcde3dtRv/jb0aYMyeX8ej/+WtwtAX5NHq4Pa0Yrl+iixw+8OBYT/qP4PWc+KTiVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=khZ82Zzf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="khZ82Zzf"
Message-ID: <7772a849-0faa-46b9-b30b-3523af581d1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785525219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+/IlSQdEk6FwfnjejmyThzGdDfoncjciaxKcBusmd4=;
	b=khZ82Zzf/raPAkLwtS7hRQZpAZJ1eKcFyqYEO8mr9ToABHzWhXmobe2dLFpQoX2oWHwHQw
	IIyY/T5BVjUSJHV99WiibTSn7LiCd0ceOUBZUVjKKMAJbmwhosrzDoGtanGKCqfVfAEK94
	tx5+oBES1745ltSMA7OWZEYlRmIlRNI=
Date: Fri, 31 Jul 2026 12:13:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 5/5] x86/cpu: Don't reset boot CPU cpuinfo in
 identify_cpu()
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 bpf@vger.kernel.org, kernel-team@meta.com, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
 <20260704002046.3859585-6-ihor.solodrai@linux.dev>
 <20260730212613.GJamvBdRJ5H98hTWS8@fat_crate.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260730212613.GJamvBdRJ5H98hTWS8@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/30/26 2:26 PM, Borislav Petkov wrote:
> On Fri, Jul 03, 2026 at 05:20:46PM -0700, Ihor Solodrai wrote:
>> identify_cpu() used to rebuild c->x86_capability from scratch:
>> init_cpu_info() memsets the capability array to zero and
>> identify_cpu() then re-reads CPUID. On the boot CPU identify_cpu()
>> runs after local_irq_enable() and before alternatives are patched. An
>> interrupt delivered in the window between the memset() and
>> get_cpu_cap() therefore will observe cleared x86_capability [1].
>>
>> However the boot CPU's capabilities have already been scanned, with
>> interrupts off, by early_identify_cpu(). So move the init_cpu_info()
>> call out of identify_cpu() into its callers, and skip it for the boot
>> CPU on 64-bit.
>>
>> Secondary CPUs call init_cpu_info() then identify_cpu() from
>> identify_secondary_cpu(), with interrupts off, exactly as
>> before. 32-bit still resets in identify_boot_cpu(): it relies on the
>> reset for the no-CPUID cpuid_level default.
> 
> Ok, this commit message is all over the place. Please structure it something
> like this:
> 
> 1. Prepare the context for the explanation briefly.
> 
> 2. Explain the problem at hand.
> 
> 3. "It happens because of <...>"
> 
> 4. "Fix it by doing X"
> 
> 5. "(Potentially do Y)."
> 
> And some of those above are optional depending on the issue being
> explained.
> 
> Also, do not talk about what your patches do - that should (hopefully) be
> visible from the diff itself. Rather, talk about *why* you're doing what
> you're doing.
> 
> In the patches where you do only mechanical movement, add
> 
> "No functional changes."
> 
> to the commit message to denote that.

Thank you for the review and the feedback. I'll respin.

> 
> 
>> [1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  arch/x86/kernel/cpu/common.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 8f093c6c7ccc..cd3d7c37c174 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -1986,8 +1986,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>>  
>>  	c->loops_per_jiffy = loops_per_jiffy;
>>  
>> -	init_cpu_info(c);
>> -
>>  	if (!cpuid_feature())
>>  		identify_cpu_without_cpuid(c);
>>  
>> @@ -2156,6 +2154,13 @@ static void identify_cpu_32(struct cpuinfo_x86 *c)
>>  
>>  static __init void identify_boot_cpu(void)
>>  {
>> +	/*
>> +	 * The boot CPU's capabilities were already scanned in early_identify_cpu().
>> +	 * However 32-bit still needs to init_cpu_info() here for the no-CPUID
>> +	 * cpuid_level default.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_X86_32))
>> +		init_cpu_info(&boot_cpu_data);
>>  	identify_cpu(&boot_cpu_data);
>>  	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
>>  		pr_info("CET detected: Indirect Branch Tracking enabled\n");
>> @@ -2178,6 +2183,7 @@ void identify_secondary_cpu(unsigned int cpu)
>>  		*c = boot_cpu_data;
>>  	c->cpu_index = cpu;
>>  
>> +	init_cpu_info(c);
>>  	identify_cpu(c);
>>  	identify_cpu_32(c);
> 
> Also, when you look at the final version, do you see how identify_cpu() and
> identify_cpu_32() are soo close together so that you can basically move the
> body of identify_cpu_32() to the end of identify_cpu() and then you don't need
> that helper either.

I actually did notice that, but I guess I fixated on the idea that
32bit part should be encapsulated. I'll fold identify_cpu_32() into
identify_cpu() in the next revision.

Thanks!

> 
> Other than that, the flows do look better. 32-bit still needs dealing with the
> no-CPUID case but that's for another day. I can't really find it in me to
> care, actually, 32-bit needs to go away and we'll simplify a looot of code. Oh
> well.
> 
> Thx.
> 


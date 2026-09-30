Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C0331ED5
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732059; cv=none; b=WrC92QqBcbn90Nb1YdpHr2rKw3eKmpTwbrwZo0bMju+7c+l4UWTYg5J38IcqygwyEoluO/B2bVIj9FwUZEVUcI0pmdouIWcN/6cTOML2j1r0F6R1AqMgCGcxgFSO9e6eA1Cg6j8gdN8gUBW9OR5GjCiBnP99uB3CqekvUmC55ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732059; c=relaxed/simple;
	bh=5QL2XutwcNraGW2+IuSz3WkhNGt2+jFEZrdcSrDs1jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxXULKUcTBge8C0ozRZlI/7nc4YH5Yo3sqezurJ7xcWr9aJTBTYocufyMEgAfLm4JK36J9Hs/XMHL3GfS5GAiH05HjeC2VyGjtEjxP3N7RBX0k2RCrftX/Oaeoe/nZYcDcbxpTAqfIliRAaMW7uxI7DkCRyz49I1h7jCWBYIFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A0+lpvJb; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A0+lpvJb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5QL2XutwcNraGW2+IuSz3WkhNGt2+jFEZrdcSrDs1jA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790732055; v=1; x=1791336855;
 b=A0+lpvJb5Je5xTQ1AGdKr6z2PYmR9XscmobGjue3yGE2Uf4S/Lc4zztp6Wuer0JeUsFNc3m8
 4Dy47xr1JtVttLR+BPUXy3sp3i9Ek89u0YVJbzPV9e//tzdKrBt1vzScn7PUce0+PgbWqX3BB3E
 LGioZthuNFmUJItQ6tPsHEis=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7bafeff122540951;
	Wed, 30 Sep 2026 01:34:15 +0000
X-Mizu-Trace-ID: 7bafeff122540951
X-Migadu-Flow: FLOW_OUT
Message-ID: <e771ec2c-1821-40db-abe3-b25b5f876013@linux.dev>
Date: Tue, 29 Sep 2026 18:34:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 12/22] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001704.3251543-1-yonghong.song@linux.dev>
 <20260929003055.812791F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260929003055.812791F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: exception unwinding aborted when bpf_unwind is traced via kretprobe
> --
>
> commit f3ba2238caee72a50c097a775a0290b3b66ab98b
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Dispatch exception cleanup pads at run time
>
> This commit updates the BPF JIT on x86 to dispatch exception cleanup pads at
> run time by writing directly to the return-address slot. It introduces
> arch_bpf_stack_walk_ra() to support unwinding alongside the ORC unwinder.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 6c7a0578760e7..d4feade5b5c72 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -4614,6 +4628,34 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
>>   #endif
>>   }
>>   
>> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp, u64 *ra),
>> +			    void *cookie)
>> +{
>> +#if defined(CONFIG_UNWINDER_ORC)
>> +	struct unwind_state state;
>> +	unsigned long addr, *ra;
>> +
>> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
>> +	     unwind_next_frame(&state)) {
>> +		addr = unwind_get_return_address(&state);
>> +		ra = unwind_get_return_address_ptr(&state);
>> +		if (!addr || !ra)
>> +			break;
>> +		/*
>> +		 * A traced return: the unwinder recovered @addr from under a
>> +		 * function graph or kretprobe trampoline, which is what the
>> +		 * slot itself still holds. Writing there would skip the
>> +		 * trampoline and leave its entry for the next hooked return
>> +		 * to pop.
>> +		 */
>> +		if (READ_ONCE_NOCHECK(*ra) != addr)
>> +			break;
> [Severity: High]
> Will this unconditionally abort the unwinder if a kernel function like
> bpf_unwind() is traced via a kretprobe or function graph tracer?
>
> When a BPF program triggers an exception, bpf_unwind() invokes
> arch_bpf_stack_walk_ra(). The unwinder processes kernel frames first. If
> a user has legitimately attached a tracer to bpf_unwind(), the stack return
> address slot (*ra) for that frame will hold the tracer's trampoline, while
> the unwinder recovers the real return address (addr).
>
> Because this evaluates to true and breaks the loop, it seems the walk stops
> completely before it even reaches the BPF frames. Could this result in a
> silent failure of BPF exception handling and resource leaks (e.g., unreleased
> spinlocks or memory) since the cleanup pads are never executed?

Will add a WARN_ON_ONCE to expose the failure if it happens.

>
>> +		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *)ra))
>> +			break;
>> +	}
>> +#endif
>> +}
>> +
>>   void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>>   			       struct bpf_prog *new, struct bpf_prog *old)
>>   {


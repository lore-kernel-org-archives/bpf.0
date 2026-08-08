Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA18309F08
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786205297; cv=none; b=oCrUA4ODIf3fc7I9qMdzbou+lKkzwQOuN2ehkBdYIesoZN1NHJFvZbREG3dgP7+drZQetYo6kfZ0WJCff23KvvJYVSETOzaBQr5YsWyfEgzg5KZ+8x/wHCigqDfBYxZddhDOnXOu9/e0Hykr/AnzxGKSqq3WLimkxiT1XAxz/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786205297; c=relaxed/simple;
	bh=dfl8gpcfQUXz2gO95hFYGw8Np9EFr5FXQB6/QU4Vur8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBsTeX4oQGqYO7N7ryfsejtKRee2AfknlLr1IlYorvBw7VxjLOXZPS/NO2x9H1F2/dHV+Qb8Potr/xJUglUbHUxg9MWEFzBRdDikmruWrevOREicPXFLDpQcVwtQQoIt2pPfH0X13+sq+cwD+SNLYJXtQxoEsKxrKVRRo/8hQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmJZCSSQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmJZCSSQ"
Message-ID: <df7b5afd-d012-437a-8cb4-8095fdb52752@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786205293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+vlreat5ZEJUL+O1ujJeOU9gYQKiL5alpysgKi7NrA=;
	b=PmJZCSSQS8gk1isFdj66i9f3kwLVhRMxeIoa1P6Akz45kgRKnpDvNoZqemKiYfhEPEVJpo
	YDEIDSvlhv3U8S4x5UULJrHX4PVWqhg39hDu4R688PLl+27WxjGSf6MKS8kCUp0wsDCOBQ
	VrCklNlKb6octFvbTO8wv8xM0jYi8c0=
Date: Sat, 8 Aug 2026 09:07:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203558.1873903-1-yonghong.song@linux.dev>
 <20260804205219.D44AC1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260804205219.D44AC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 1:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Kfuncs returning 9-15 byte structs leak uninitialized kernel memory via R2 because the verifier bypasses zero-extension.
> --
>
> --- Patch [7]: [PATCH bpf-next v2 07/13] bpf: Add verifier support for 16-byte returns in R0:R2 ---
> commit 5c235db7cbd600a1b91b24fbad96652d702b6b3a
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add verifier support for 16-byte returns in R0:R2
>
> This commit adds verifier support for returning values in two registers
> (R0 and R2) for structures between 9 and 16 bytes or __int128. It adds
> handling for subprogram and kfunc returns to map the second return
> register to BPF_REG_2.
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5584178a0e1c7..60b9e587e0947 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -10859,6 +10901,22 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
>>   	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
>>   }
>>   
>> +/* Mark the register(s) holding a @size byte kfunc return value as unknown
>> + * scalars. All of them are processed the same way, only the size differs:
>> + * a single register may hold a sub-register sized value, while both halves
>> + * of a register pair are treated as 64-bit wide.
>> + */
>> +static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
>> +				struct bpf_reg_state *regs, u32 size)
>> +{
>> +	u32 i, nregs = ret_regs_cnt(size);
>> +
>> +	for (i = 0; i < nregs; i++) {
>> +		mark_reg_unknown(env, regs, ret_regs[i]);
>> +		mark_ret_reg_size(env, regs, ret_regs[i], nregs == 1 ? size : sizeof(u64));
> [Severity: Medium]
> For kfuncs returning a struct between 9 and 15 bytes in size, does
> forcing sizeof(u64) for both return registers bypass zero-extension for R2?
>
> If the native compiler only populates the lower bytes of the second return
> register (e.g. RDX on x86_64) for a <16 byte struct, the upper bits will be
> left uninitialized. However, setting the size to sizeof(u64) here sets
> subreg_def to DEF_NOT_SUBREG for R2, which treats R2 as a fully initialized
> 64-bit scalar.
>
> Since the verifier's zero-extension logic only supports zero-extending the
> destination register (R0 for calls), couldn't a BPF program performing a
> 64-bit read of R2 leak up to 7 bytes of uninitialized kernel register state?

This should be okay. The bpf prog return value will be handled properly in
bpf prog, e.g., if the value (R2) is an int, the bpf prog will do proper
32-bit sign extention.

>
>> +	}
>> +}
> [ ... ]
>


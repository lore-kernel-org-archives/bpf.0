Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08833DCD95
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088121; cv=none; b=WobhwPs1j+K0QetHaZBw+tB08juoM9f4P2Y922VUMhtYwkf3E7DW57IAgbYtYHHRbZVuKZCj+P2z883Yh7T245WXSK9+m5JcYQdNALSfQR8RcbbIGalhDr6RvkchUjp9ORaSvjz0PF5+6O8VNgZUqaHh3OwRMgH0nWRlH0bV+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088121; c=relaxed/simple;
	bh=TS9PfMuVvpQaG0ClF+suZAUnUuSUBbAn8MmbL2i8tFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAMZm+YZwUUx3EyqWOFc5YLHejvumSPrSbhmxzejSNZd/4frJvkfXX8zUJw89gmGd2Gr2sB6Geymf6wr1AbB3RVULMEYfgF68mB841wgXbhp/m6UnxlSojhELL7SL9TZmEAw0zTggpv+DJ9iMaUds2qzCbdX22E9Hdi0fUQNi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hpSWupzq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hpSWupzq"
Message-ID: <ed816369-e1f6-47aa-9532-5f3ccf6d6794@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783088106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7Kybu0lGe03pYWCZKIx76wa/pKwq+CCmvTJJYIikvI=;
	b=hpSWupzqK9dmwGJ2MmTfaCrzzpG18CooPtfEtRarBF4VrGv3BprLoqeRFzjzod6uz+RdVd
	PoCgq3P9owt7LP+ObC9MNGSpye69k/ZfXb2qW8zcxk+se7vqyA3/ol6215l5Vxs7D2/X8V
	o7Mhw/88Qlagt7NMGnUUxySJMA22U7k=
Date: Fri, 3 Jul 2026 22:14:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
To: Tiezhu Yang <yangtiezhu@loongson.cn>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 KaFai Wan <kafai.wan@linux.dev>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <20260702145855.07C6B1F000E9@smtp.kernel.org>
 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
 <42e59c6f-5040-4b50-91ce-10066551a32c@linux.dev>
 <c6aca1e2-1f7a-7e01-62c8-81d0658a20fe@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c6aca1e2-1f7a-7e01-62c8-81d0658a20fe@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/3 14:59, Tiezhu Yang wrote:
[...]
>>> ```
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index f496b45b9da4..1f5824c1c691 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
>>> *env, u32 func_id, u16 offset)
>>>
>>>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>>>   {
>>> -       return !!prog->aux->kfunc_tab;
>>> +       return prog->jit_required && !!prog->aux->kfunc_tab;
>>
>>
>> When 'prog->jit_required' is used for JIT-inlineable helper call, this
>> change could also cause false positive for the above pruned kfunc case.
>>
>> If you don't want bpf_fixup_call_args() rejects the program with -EINVAL
>> for the pruned kfunc case, suggest moving 'if (!func_id && !offset)'
>> before the tab allocation in bpf_add_kfunc_call().
> 
> How about this:
> 
> ```
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..c34cc524651a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2770,7 +2770,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
> *env, u32 func_id, u16 offset)
> 
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>  {
> -       return !!prog->aux->kfunc_tab;
> +       return prog->aux->kfunc_tab && prog->aux->kfunc_tab->nr_descs > 0;


NIT: drop '> 0'

Looks better.

>  }
> 
>  static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> ```
> IMO, there are no side effects for the following four cases:
> 
> 1. Pure JIT-inlined Helper
> 2. Pure Pruned kfunc
> 3. Pruned kfunc + Inlined Helper
> 4. Active (Unpruned) kfunc
> 

This change allows pruned kfunc + interpreter fallback and pruned kfunc
+ bpf_fixup_call_args(), when CONFIG_BPF_JIT_ALWAYS_ON is off.

Does it look like a pre-existing issue?

Pls read "Support kernel module function calls from eBPF" [1] to
understand the background of introducing func_id=0 kfunc.

[1] https://lore.kernel.org/bpf/20211002011757.311265-1-memxor@gmail.com/

Thanks,
Leon


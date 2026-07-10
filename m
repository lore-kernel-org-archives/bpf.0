Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E2331EC4
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704889; cv=none; b=K8ySaAsYvH/fhe0QZeY3+yZBhXUpEOy7JVkiq1ljYw48JzbVCk2GMRqOOnbPWDXHoBr4n8Ux3/VIaSkgeM408ALR/9izqyyy9GXyp2EakO2rWMkAujamxP55XHYUoThObNT+Wj5Mw3TiouWQfXnWd1Y3z9yxqtbWQokEPsYHvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704889; c=relaxed/simple;
	bh=ICG5PYu+dLFMP0xjcxozbcoMTn1WvweqdtojniIMawQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKWnzHol7fqEbT2J4QkEam08rwxdmw5dbLKPqRWnAkUd3YRlIVfFdiyi//x+vq8pDhw2lx+Sq/VUNVUM3LBu3W9Emc0YTT6NY9sZp7nkd5l1X2l6S7bntT+q0ZtC7c1uXwUSUUo7aE4yde6NNAq420+U7Pr3HbSUcqhMDAJ3KLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ct90uAeN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ct90uAeN"
Message-ID: <7a5bb678-4fab-44c8-98b5-272124e08847@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783704885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YtIjyFM2vSqXcvUf8ZxdADa5amnRS+FdkPTHI+ToH0=;
	b=ct90uAeNCriiuutrANW0E4LINkS+sGVSOGbYkiKW+OtJB9JAenr+wE7yNssYHxXiIZR6rg
	9UxoPccq33esVUDr32CqBp7rRDEkzee9kDeBy92In6vybBKzGzPXPx9db0cHYBqhxYMa8S
	yzEvTLLo78S5iS8QAU8LRC9tZv1ckhs=
Date: Fri, 10 Jul 2026 10:34:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit args
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
 <20260710012112.577F31F000E9@smtp.kernel.org>
 <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>
 <DJV2D826YVRY.WSTQ4Z6CFX1I@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DJV2D826YVRY.WSTQ4Z6CFX1I@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 10:23 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri Jul 10, 2026 at 7:08 PM CEST, Ihor Solodrai wrote:
>> On 7/9/26 6:21 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [High] Accessing `btf->kfunc_set_tab` without holding a module reference causes a use-after-free vulnerability.
>>> --
>>>
>>> --- Patch [1]: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit args ---
>>> commit 13df91bf669b3a55c459c1663fbf726f9f52bc5c
>>> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>
>>> bpf: Fix tracing of kfuncs with implicit args
>>>
>>> A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
>>> (such as bpf_prog_aux) that the verifier injects at load time.
>>> resolve_btfids strips those from the kfunc's BTF-visible prototype and
>>> keeps the real kernel ABI in a counterpart _impl prototype.
>>>
>>> Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-4906694106
>>>
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 64572f85edc83..20aeca6b4f95c 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>> [ ... ]
>>>> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
>>>>  	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>>>  }
>>>>
>>>> +/*
>>>> + * Return the union of a kfunc's flags across all hooks.
>>>> + * Unlike btf_kfunc_flags(), not restricted to a calling
>>>> + * program's hook. Used when attaching to a kfunc for tracing.
>>>> + */
>>>> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
>>>> +{
>>>> +	enum btf_kfunc_hook hook;
>>>> +	u32 *hook_flags;
>>>> +	u32 flags = 0;
>>>> +
>>>> +	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
>>>> +		hook_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>>> +		if (hook_flags)
>>>> +			flags |= *hook_flags;
>>>> +	}
>>>> +
>>>> +	return flags;
>>>> +}
>>>> +
>>>>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
>>>>  				const struct bpf_prog *prog)
>>>>  {
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 6515d4d3c0032..fde11a2f6869a 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>> [ ... ]
>>>> @@ -19121,8 +19146,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>>>  		if (prog_extension &&
>>>>  		    btf_check_type_match(log, prog, btf, t))
>>>>  			return -EINVAL;
>>>> -		t = btf_type_by_id(btf, t->type);
>>>> -		if (!btf_type_is_func_proto(t))
>>>> +		t = btf_attach_func_proto(log, btf, btf_id);
>>>> +		if (!t || !btf_type_is_func_proto(t))
>>>>  			return -EINVAL;
>>>
> 
> Also, why not do it for BPF_TRACE_ITER case as well? I just feel keeping it
> consistent may outweigh figuring out whether it's necessary in that case or not,
> etc.


I mentioned this in the patch description:

  The BPF_TRACE_ITER case distills a registered iterator's
  prototype, and bpf_struct_ops_desc_init() distills the
  function-pointer members of a struct_ops type. Neither is 
  a kfunc, and so can't have implicit arguments.


> 
> Please supply a cover letter in the next version too since you're sending
> multiple patches.

I used the first patch's message as a cover letter, since it's
just a fix + selftest pair.

The series could be split further into refactoring changes, but I thought
it'll be easier to backport if the fix is in a single self-contained patch.

I think we want the fix to get into 7.2, and backport it to 7.1.

If it's ok to carry separate refactoring patches there, then I'll split.
Kartikeya, wdyt?


> 
> Thanks


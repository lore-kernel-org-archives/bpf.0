Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931C3890E0
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154644; cv=none; b=jJNs+ctk2cqPdaaafaq9mbFd+fS4zXxGLkSsQsMu3w1cxRyB5q9K7UqyGMJHE6QdQYLaVS644Ed3ixqofYu1tbrNTsSmTas4gkaopOK9mroyoVGagI7VUr90z2oolgzjAZPNl+Moti99DEMHT4cwPDYqNcV8XTWHJDqLku0WoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154644; c=relaxed/simple;
	bh=pmc3rgjTX9WWxQeyhGNjCXEOqtOtWKs4p5J6EHAGhEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg0pABoZULHvPUGGWSH6/uCTZ3lT0VarDw1NPKM+yKq1XKKzgOHA/z5VdcF7P3BHdEru/cu7P3MvOu4aHlI6fYYzEENj5CCEaDo7ZxVxcMVJTwyz4RUCEfyUQTwEC9rijhl++Y1D0OhIZ0wgWQCmEh/uMA+mL0GHjYDODPO7DiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rEeWtYRO; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rEeWtYRO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pmc3rgjTX9WWxQeyhGNjCXEOqtOtWKs4p5J6EHAGhEE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787154640; v=1; x=1787759440;
 b=rEeWtYRO/b6b3OMv9vDz9PEaR0U690jNLmKP2jhwSq+CQAw2wlVeiSgguyRPH1K1r23M/BgW
 hF02Q1XQRUXHWbRjNFtWItUjppujG6jMI0fReAmiweT7oAOH07vyUJ5FtMzoRdIVFTYnorkgugz
 aUue1yCWwzc4WgK4wwgOL9Xk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id 594093d243d35417;
	Wed, 19 Aug 2026 15:50:40 +0000
X-Mizu-Trace-ID: 594093d243d35417
X-Migadu-Flow: FLOW_OUT
Message-ID: <b6fbcaf1-295f-43de-a794-7fb546fd4785@linux.dev>
Date: Wed, 19 Aug 2026 08:50:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055249.3295283-1-yonghong.song@linux.dev>
 <20260819061746.0DFE71F00A3A@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260819061746.0DFE71F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Extension programs (BPF_PROG_TYPE_EXT) are mishandled because `bpf_compute_subprog_ret_regs` skips subprog 0, failing to set up `ret_reg_pair`.
> --
>
> --- Patch [2]: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the R0:R2 return register pair ---
> commit f6c1f4f14c6e8bda9545fe1b82f42648b4f3c475
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add helpers to describe the R0:R2 return register pair
>
> This commit adds bpf_ret_reg_pair() to determine if a BPF subprogram returns
> a value in the R0:R2 register pair. It implements
> bpf_compute_subprog_ret_regs() to compute this flag based on the BTF
> prototype of each subprogram, intentionally skipping the main program.
>
> Link: https://github.com/llvm/llvm-project/pull/190894
> Link: https://github.com/llvm/llvm-project/pull/206876
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d8bf897460eae..2b5e88fdda07e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>> +{
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	const struct btf_type *type;
>> +	int subprog;
>> +	u32 size;
>> +
>> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
>> +		return 0;
>> +
>> +	/*
>> +	 * Skip the main program: its return value is the program's exit code,
>> +	 * read out of R0, so it never uses the register pair. An extension does
>> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
>> +	 * refuses to replace a function returning more than 8 bytes.
>> +	 */
>> +	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
> [Severity: High]
> Does this code mishandle extension programs (BPF_PROG_TYPE_EXT)?
>
> The comment mentions that bpf_check_attach_target() refuses to replace a
> function returning more than 8 bytes. However, for extension programs,
> prog->expected_attach_type is 0, so attach_uses_trampoline_retval(0) evaluates
> to false, bypassing the size check.
>
> If an extension program successfully attaches and replaces a subprogram
> returning an __int128 (16 bytes), skipping subprog 0 here means ret_reg_pair
> won't be set. Could this result in the verifier failing to enforce the
> initialization of R2, potentially leaking uninitialized register contents to
> the caller?

But the comment needs update for this version.
    bpf_check_attach_target() -> btf_check_func_type_match()

>
>> +		type = subprog_ret_type(env, subprog);
>> +		if (!type || btf_type_is_void(type))
>> +			continue;
>> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
>> +				    "cannot size return type of subprog %d", subprog))
>> +			return -EFAULT;
>> +		if (ret_regs_cnt(size) > 1) {
>> +			subprog_info(env, subprog)->ret_reg_pair = true;
>> +			env->prog->jit_required = 1;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}


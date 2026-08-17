Received: from mta1.migadu.com (out-156.mta1.migadu.com [95.215.58.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162C2D877A
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937291; cv=none; b=mxvDy2JIGDu59S+SzowOpFYbZYRAoea8TBFfXbNPkp6MSBovIJdJ0m4lvrIDS9IiwGdI05SFOp0EZ7UxH117ycRsTxx1FZnmC7oEDbN5QPlC4emAEOngsGYVaq6OmK8J34p+nqfcpDUZ8D6UhwEJxXiJTCbiyLU7VxpuJFU/BZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937291; c=relaxed/simple;
	bh=wzWxiny4+aXzM19gnJ/cPgL79jGcNy0MrXNmLDEzZXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZuXToUKssYWA4GkSnwsiRvobQ7nro0HDZkl+cS2UOBoB1pPYqdwWXGEnJtWRMoNniUiif8rmLbFgINpzPu3HWMPpAX/KOYordXQTfakIzulDxqAjEwVwHQ5FFA+dYOCgGGbLF+mA1uj8ya7+AD4uSIvZg9HUDe9bGG/0Qc+Kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ialdoler; arc=none smtp.client-ip=95.215.58.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ialdoler"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wzWxiny4+aXzM19gnJ/cPgL79jGcNy0MrXNmLDEzZXE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937287; v=1; x=1787542087;
 b=ialdolerbfcxORX/fLkRz8NC71/ti4HDXO+TpPpnQ0SMHSgxozY8PeSRm0uSN+ecBFq8KOwu
 ispbpc9ukXeBmxQaaf1jVyED3YanI5K3QAWGSVYIflTgBAe1hMcG+cbO4nbXHgCYTCPrcNkW+B7
 i3duID78jnjcGD9N+VmAb2Jc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id f6369f370491aca7;
	Mon, 17 Aug 2026 03:28:07 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <58594769-a399-4e8e-b796-e0dc7ea06f90@linux.dev>
Date: Sun, 16 Aug 2026 20:28:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 02/11] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200220.1994468-1-yonghong.song@linux.dev>
 <82a2bfbf1173867428d43edb65c9d32b9a61e90d.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <82a2bfbf1173867428d43edb65c9d32b9a61e90d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/26 3:43 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
>
> ...
>
>> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>> +{
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	const struct btf_type *type;
>> +	int subprog;
>> +	u32 size;
>>   
>> -	return btf_type_is_void(type);
>> +	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
>> +		type = subprog_ret_type(env, subprog);
>> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
>> +			continue;
> Is the check '!(btf_type_is_struct(type) || btf_type_is_scalar(type))'
> needed after v4->v5 migration?

Yes, the condition is similar to btf_validate_return_type().

>
>> +		if (IS_ERR(btf_resolve_size(btf, type, &size)))
>> +			continue;
> Let's propagate this error instead of ignoring it. Or add WARN_ON_ONCE().
> After BTF validation it shouldn't really happen.

Okay, will propagate the error.

>
>> +		if (ret_regs_cnt(size) > 1) {
>> +			subprog_info(env, subprog)->ret_reg_pair = true;
>> +			/*
>> +			 * The R0:R2 return convention is only implemented in
>> +			 * the JIT: the interpreter propagates BPF_R0 alone out
>> +			 * of a subprogram, so a caller reading R2 would see a
>> +			 * stale value.
>> +			 */
>> +			env->prog->jit_required = 1;
>> +		}
>> +	}
>>   }
>>   
>>   static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
> ...
>
> Regarding the bot comment:
>
>> Additionally, should jit_required be set for subprogs whose BTF prototypes
>> are marked unreliable?  btf_check_subprog_call() can flag a mismatch with
>> prog->aux->func_info_aux[subprog].unreliable = true, and check_func_call()
>> only aborts on -EFAULT, so a static callee with an aggregate return can
>> load today without using the BTF return type. Subprogs subsequently deleted
>> by bpf_opt_remove_dead_code() (which runs after this pass) also don't need
>> jit_required set.
> It seem to be correct. As prepare_func_exit() unconditionally copies
> r0 and r2 to caller's frame, the verifier would conclude that r2 is
> initialized; while interpreter won't copy it. One option is to force
> nregs == 1 if there is no jit.

As suggested, we can just do nregs = 1 (returning registers) if there is no jit.

>
> (Or derive this information not from BTF, I'll comment on that later).


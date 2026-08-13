Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9438734A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645418; cv=none; b=KNkwWeQNtF47x/LhcPANb3p5KR3noNYaDpoLzPxB1z/Ayr10rVJQXzJVSchrbPBT7W1smU3s7pGG3aYHvvuj8b3T8ff13hEzpi7U6dWo+FrfVQ6XrzkXlyYs2L0mSUL99WTaJgjLMtq/Ttahixn1hZASffrcewS59/lDTdqNsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645418; c=relaxed/simple;
	bh=JXvz75aLjksnQa1A+IrcazXDv4dfcbSRsug0vjDdijM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaorSd93wwdlCd4iteKuXf+qwkcM1fXdOT/xZEqEIZpUwcQHwb9J9mUY0LvirejJ1EIWjwdtV7FzpT4vGQY+nzaVexMPj+u69+obG7F+PXdlOKu04/ea1+noJUCuC/mjSbWnSim7MPQar2LzO/MTCMg/vUN51tamux4zD7ndm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T21IxILL; arc=none smtp.client-ip=95.215.58.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T21IxILL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JXvz75aLjksnQa1A+IrcazXDv4dfcbSRsug0vjDdijM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645414; v=1; x=1787250214;
 b=T21IxILLPXWx8/FKtd/jxPENVwexVbW/uOM82XMjFtYURWNQRzqwVjNXbX45d6vXe0lfBshL
 KpODtETPwGA301eQqYgC9m8uxR4dVacKOS0Me1tWpGguw4Bh9WH5b85aDXxaL/Ia5OQsNHjxUZj
 3W1+gvpq6QrS8+oEe0y1RD3U=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id 1c1ab2398c8cbec6;
	Thu, 13 Aug 2026 18:23:34 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <ed5b21ef-eec2-4977-9ed0-c480bb82da2f@linux.dev>
Date: Thu, 13 Aug 2026 11:23:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 09/13] bpf: Enable aggregate return types up
 to 16 bytes
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000957.2382783-1-yonghong.song@linux.dev>
 <09a1229f680ad7b6e2d44aea142f76df94a69be7.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <09a1229f680ad7b6e2d44aea142f76df94a69be7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 3:47 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>> Relax btf_distill_func_proto() to accept a by-value struct or union that
>> the R0:R2 convention added in earlier patches can carry:
>>
>>   - a struct or union larger than 8 and up to 16 bytes, returned in the
>>     R0:R2 register pair, matching what LLVM emits for the BPF target;
>>   - a struct or union up to 8 bytes, returned in R0 alone.
>>
>> A >8 byte scalar (__int128) was already accepted and is unchanged.
>> Everything else stays rejected: a return type larger than 16 bytes, and any
>> type that __get_type_size() cannot return in registers at all (e.g. an
>> array), which it already reports as ret < 0.
>>
>> btf_distill_func_proto() also builds the trampoline (fentry/fexit/fmod_ret)
>> and struct_ops function models, so relaxing it widens what those can attach
>> to. A >8 byte return stays rejected on every path that reads the target's
>> return value: commit c48796aa6c39 ("bpf: Reject >8 byte return values on
>> return-reading trampoline paths") covers fexit, fmod_ret and fsession plus
>> their _multi variants, and struct_ops, and an fentry-only trampoline never
>> sets BPF_TRAMP_F_CALL_ORIG so it does not touch the return value at all. A
>> struct or union of 8 bytes or less is newly accepted for those paths; its
>> single eightbyte is returned in R0 like any other scalar.
>>
>> btf_validate_return_type() is relaxed as well, so that it accepts a
>> by-value struct or union up to 16 bytes in addition to void and scalars.
>>
>> With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
>> verifier, JIT, precision-backtracking and live-register support from the
>> earlier patches becomes reachable: this final patch enables <=16 byte
>> aggregate return values end to end.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> ...
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 6606187ed4f4..5551abcea1d3 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7592,7 +7592,12 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>   		return -EINVAL;
>>   	}
>>   	ret = __get_type_size(btf, func->type, &t);
>> -	if (ret < 0 || btf_type_is_struct(t)) {
>> +	/*
>> +	 * __get_type_size() already restricts a non-negative ret to void, a
>> +	 * pointer, an int, an enum or a struct/union, so only the size is checked
>> +	 * here.
>> +	 */
> Nit: I'd drop this comment.

Will do.

>
>> +	if (ret < 0 || ret > 16) {
>>   		bpf_log(log,
>>   			"The function %s return type %s is unsupported.\n",
>>   			tname, btf_type_str(t));
> ...
>
>> @@ -7988,6 +7993,35 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>>   	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>>   		return 0;
>>   
>> +	if (btf_type_is_struct(t) && t->size <= 16) {
>> +		/*
>> +		 * A >8 byte struct/union is returned in the R0:R2 register pair.
>> +		 * A global function is verified in isolation, so its caller models
>> +		 * the return as an opaque R0:R2 scalar pair; it must therefore
>> +		 * contain only scalars, otherwise a pointer field would be
>> +		 * laundered into a scalar and escape provenance and reference
>> +		 * tracking. That requirement is enforced here: do_check_common()
>> +		 * propagates the error for global functions and for the main
>> +		 * program.
>> +		 *
>> +		 * A local (static) function is verified inline and its R0:R2 are
>> +		 * copied as precise register state (with the JIT forced on when
>> +		 * the pair is consumed), so a pointer field stays tracked and needs
>> +		 * no such restriction. Accepting it here is not by itself what
>> +		 * makes it legal: btf_check_subprog_call() drops any error other
>> +		 * than -EFAULT. What it avoids is needlessly marking the
>> +		 * subprogram's BTF unreliable.
>> +		 *
>> +		 * The main program (subprog 0) takes the scalar-only path as well,
>> +		 * but its return value is the program's exit code, so a >8 byte
>> +		 * return is rejected separately at BPF_EXIT.
>> +		 */
> Nit: the comment is way too long, I'd drop the justification.
>       Especially given that at the moment btf_validate_return_type()
>       would only be called from main/global subprograms/callback subprograms.

Will do.

>
>> +		bool local_func = subprog && !is_global;
>> +
>> +		if (local_func || __btf_type_is_scalar_struct(env, btf, t, 0))
>> +			return 0;
>> +	}
>> +
>>   	return -EOPNOTSUPP;
>>   }
>>   
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8f0c4aed0781..f8294359c85d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11088,9 +11088,9 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>>   }
>>   
>>   /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>> -static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> -					const struct btf *btf,
>> -					const struct btf_type *t, int rec)
>> +bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> +				 const struct btf *btf,
>> +				 const struct btf_type *t, int rec)
> Nit: since this function is now exported, let's drop the '__' prefix.

Will change.

>
>>   {
>>   	const struct btf_type *member_type;
>>   	const struct btf_member *member;
> ...


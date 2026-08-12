Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB739A80E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566593; cv=none; b=hdo53Ay6wbVG8oYuuVpXKrY15ujRz+tqUQ2n/NSWAwo75J4RRMa7KMRcNGMlkmyUH1WWeMy19sVHpsh6d7K5brG4DZctXEvUH+xl6N3HMTNhmgWU7DCqAcKAv7poSDi/z2I4qfHn1C8lZ7Dvo/0uXBS5IGE6AK1ZO6SVK6Ek1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566593; c=relaxed/simple;
	bh=bDdaH9yMsH2eJeN8RZCR5CMJbclJoFR9x5ABItjX9yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7C14Qbf0Bgio6vMzKobB5AHOn6hYY0N0DUMCzsKnFm5VwMBCae/nDwi22tqn+C3BahYaKRDF0Ksl67g3+nhwuHBNTz6jv3YPz1IWBAVn375fPjDC3LcM393lsDr8xExf0RC3vjtHbocyyLZldnhZ9Puc/xXuIvNqRdp5dJvSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MS+oAqez; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MS+oAqez"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bDdaH9yMsH2eJeN8RZCR5CMJbclJoFR9x5ABItjX9yo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786566588; v=1; x=1787171388;
 b=MS+oAqezp2Uj/clqZwIlQsYj7GAKGA2mdaB63tqvI5uI+qkhm1HIxdbnozXJCZPaTI7IfYuv
 n+iCc7BMeCffDt41LWIsii2lCvZJt8GHzeEJWlKt73o0vo/SqrFcKrWvBy7OgiHFArjxBozc9cu
 4JWFI692Wed1p9pmDB8F4Ehw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id 62a0b18aae1bcbe8;
	Wed, 12 Aug 2026 20:29:48 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf7fe702-6f29-4137-a589-39974d5fca88@linux.dev>
Date: Wed, 12 Aug 2026 13:29:41 -0700
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
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000957.2382783-1-yonghong.song@linux.dev>
 <e9d300a2448796c238e4f3b84d45e7abdbb5fcda4f4912fd3361437836bcd27d@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e9d300a2448796c238e4f3b84d45e7abdbb5fcda4f4912fd3361437836bcd27d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> 8 bytes, R0 alone for <=8 bytes), enabling the R0:R2 register-pair return
> convention end-to-end.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 6606187ed4f43..5551abcea1d39 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>
>> @@ -7965,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
>>
>>   /* Check whether the type is a valid return type. */
>>   static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
>> -		const struct btf_type *t, int subprog)
>> +		const struct btf_type *t, int subprog, bool is_global)
>>   {
>>   	u32 tags = 0;
>>   	int err;
>> @@ -7988,6 +7993,35 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>>   	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>>   		return 0;
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
>> +		bool local_func = subprog && !is_global;
>> +
>> +		if (local_func || __btf_type_is_scalar_struct(env, btf, t, 0))
>> +			return 0;
>> +	}
>> +
>>   	return -EOPNOTSUPP;
>>   }
> Does the comment accurately describe the enforcement mechanism?
>
> The comment states "do_check_common() propagates the error for global
> functions and for the main program." That's true for global functions but
> appears incorrect for the main program. Looking at do_check_common() in
> kernel/bpf/verifier.c:18624:
>
>    if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
>            ...
>            ret = btf_prepare_func_args(env, subprog);
>            if (ret)
>                    goto out;            /* <- error propagated */
>    } else {
>            if (env->prog->aux->func_info_aux) {
>                    ret = btf_prepare_func_args(env, 0);
>                    if (ret || sub->arg_cnt != 1 || ...) {
>                            env->prog->aux->func_info_aux[0].unreliable = true;
>                            ...
>                    }
>            }
>            ...
>    }
>    ret = do_check(env);
>
> The main-program arm (subprog 0 of a non-EXT program) uses the return
> value only to set func_info_aux[0].unreliable, then unconditionally
> overwrites ret with do_check(env). The -EOPNOTSUPP from
> btf_validate_return_type() is therefore discarded.
>
> Concretely: a program whose entry function returns a pointer-containing
> struct like 'struct { void *p; }' (size 8) now takes the new struct
> branch, fails __btf_type_is_scalar_struct(), but the resulting error is
> silently dropped. The program continues to be verified.
>
> No memory-safety hole results: check_return_code() still refuses a pointer
> in R0 at exit ('R0 leaks addr as return value'), so the pointer-laundering
> scenario the comment worries about does not actually occur for the main
> program. The issue is that the comment states an enforcement mechanism that
> does not exist.
>
> Should the comment drop "and for the main program" and point at the
> BPF_EXIT check instead?

Yes, will do.

>
> Also: "btf_check_subprog_call() drops any error other than -EFAULT" is
> slightly inaccurate. btf_check_subprog_call() actually returns the error
> and marks the BTF unreliable; its callers, check_func_call() and
> push_callback_call(), do 'if (err == -EFAULT) return err;' and otherwise
> continue.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762


Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08048665F
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155961; cv=none; b=HKVqtQALhVt0mo7KVKqU95uV9VJVlDklfgpIybRZGaC5kDZILq/PGJylBpaguMNhZpky2POOq81W1GKAFt+zsU22hj4FO4o6TSmdQK0f2qQjKVx1B0XcSHDPZRZnXNIY4Ppy1QXtLt9XzxkvSK3GXJq3Lu2buWdIOs1+h3UUwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155961; c=relaxed/simple;
	bh=L4fbrUNEcU1E/VfdCxYyBK8AVhHpYPGUmT30pdI80vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMa7wIoqsSAMUsEwsDyExBJPkVNPRqIsfcaF1ZCNb1bR7rJDnOk11cW/VIu7Ii6xUR9jdvJEzOIWAVmFVjm3/b4yNTa33W83lBDnDgE5ym7J6V/aEzjFWP7J/RA40m/rgk/c2eET6YkP/i70oefn41dsYKo+YJDkLVEhEo5TVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2TKSYIr; arc=none smtp.client-ip=95.215.58.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2TKSYIr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L4fbrUNEcU1E/VfdCxYyBK8AVhHpYPGUmT30pdI80vI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787155956; v=1; x=1787760756;
 b=T2TKSYIrBsW27GZRuoczYUIncV9RON8siLQvpXxya8BOs8c8Ur3qMVnNt2M3tPQUDkzph+8y
 4EYOjIQiYOwDtMQVkq/m9xQj0REXoN8aiNaDVh6A1lz/63gRpTGUujXlgxXE9AI6fl9qDEHWSPE
 M76rEZ8GULSkkdcCrdJtficU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id 1af64b58419d0250;
	Wed, 19 Aug 2026 16:12:36 +0000
X-Mizu-Trace-ID: 1af64b58419d0250
X-Migadu-Flow: FLOW_OUT
Message-ID: <e39f49b4-6e5c-490d-a629-c13d95e33c6c@linux.dev>
Date: Wed, 19 Aug 2026 09:12:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types up
 to 16 bytes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260819055314.3298664-1-yonghong.song@linux.dev>
 <96066402806a298adc4f6c068695e3d79b3157cf141fd243a54413de855f1d16@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <96066402806a298adc4f6c068695e3d79b3157cf141fd243a54413de855f1d16@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:50 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 953d8191563a..004b06785521 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1488,6 +1488,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
>>   struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>>   void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>>   bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struct btf *btf,
>> +			       const struct btf_type *t, int rec);
>>
>>   int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>>   bool bpf_is_throw_kfunc(struct bpf_insn *insn);
> [ ... ]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 5e9f6a487524..58b81c6f5288 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>
>> @@ -7970,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
>>
>>   /* Check whether the type is a valid return type. */
>>   static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
>> -		const struct btf_type *t, int subprog)
>> +		const struct btf_type *t, int subprog, bool is_global)
>>   {
>>   	u32 tags = 0;
>>   	int err;
>> @@ -7993,6 +7993,19 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>>   	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>>   		return 0;
>>
>> +	if (btf_type_is_struct(t) && t->size <= 16) {
>> +		/*
>> +		 * A global function's caller models the return as an opaque
>> +		 * scalar pair, so it may only return scalars by value. A local
>> +		 * function is verified inline, so a pointer field stays tracked
>> +		 * and needs no such restriction.
>> +		 */
>> +		bool local_func = subprog && !is_global;
>> +
>> +		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
>> +			return 0;
>> +	}
>> +
>>   	return -EOPNOTSUPP;
>>   }
> Does this code reject enum64-valued fields in scalar structs?
>
> Nine lines above, btf_is_any_enum(t) accepts a bare BTF_KIND_ENUM64
> return value as a scalar. However, btf_type_is_scalar_struct() calls
> btf_type_is_scalar() (include/linux/btf.h:361), which only matches
> btf_type_is_int() or btf_type_is_enum(). The latter
> (include/linux/btf.h:286) covers BTF_KIND_ENUM only, while
> BTF_KIND_ENUM64 requires btf_is_any_enum() (include/linux/btf.h:291).
>
> This means a bare 'return enum64_t' passes the bare-scalar branch above,
> but 'return struct { enum64_t e; }' - a struct of one scalar - fails the
> scalar-struct test and gets rejected with -EOPNOTSUPP.
>
> The commit message describes 'a struct or union up to 8 bytes, returned
> in R0 alone', and the series documentation (7ba16e29a69f) says the
> aggregate 'must be composed only of scalars (recursively), where a scalar
> is an integer or an enum', so enum64 members appear to be intended.
>
> The same gap affects kfuncs: check_kfunc_call() gates struct returns
> on btf_type_is_scalar_struct() as well and logs 'returns %s %s that
> is not composed of scalars'.
>
> Could btf_type_is_scalar() be updated to include btf_is_any_enum(), or
> should these two call sites use a different helper?

It is rare that we have enum64 in a struct, so I would like keep this way.

>
>> @@ -8080,12 +8093,12 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   		return -EINVAL;
>>   	}
>>
>> -	err = btf_validate_return_type(env, btf, t, subprog);
>> +	err = btf_validate_return_type(env, btf, t, subprog, is_global);
>>   	if (err) {
>>   		if (is_global) {
>>   			bpf_log(log,
>> -				"Global function %s() return value not void or scalar. "
>> -				"Only those are supported.\n",
>> +				"Global function %s() has unsupported return type. "
>> +				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is supported.\n",
>>   				tname);
>>   		}
>>   		return err;
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d79f0c069795..7a939dfa3797 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
>> index ac44d60e5066..9708efb93683 100644
>> --- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
>> @@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
>>
>>   SEC("?tc")
>>   __exception_cb(exception_cb_bad_ret_type1)
>> -__failure __msg("Global function exception_cb_bad_ret_type1() return value not void or scalar.")
>> +__failure __msg("Only void, scalar, or a scalar-only struct/union up to 16 bytes is supported.")
>>   int reject_exception_cb_type_1(struct __sk_buff *ctx)
>>   {
>>   	bpf_throw(0);
> Does this updated expectation still pin the function being tested?
>
> The old assertion string included both the function name and the specific
> reason: 'Global function exception_cb_bad_ret_type1() return value not
> void or scalar.' The replacement now matches only the generic second
> sentence of the message, which contains no function name.
>
> This means the test now passes if the verifier logs an unsupported return
> type error for any global function in the object, not specifically
> exception_cb_bad_ret_type1().
>
> The new bpf_log() message at btf.c:8099-8102 still interpolates the name
> ('Global function %s() has unsupported return type'), so a more specific
> assertion form was available:
>
>    __msg("Global function exception_cb_bad_ret_type1() has unsupported return type")
>
> The later selftest commit in this series (8b8a84ddcc3e, selftests/bpf: Add
> tests for aggregate return values) does keep the function name in its
> equivalent expectations.
>
> Could this test retain the function name in the assertion to avoid
> matching unrelated failures?

I think it is okay.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339


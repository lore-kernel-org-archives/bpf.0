Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1AF379ED6
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661416; cv=none; b=ZP9w8JMLgORUAJWW1phnMPsjR1fce0IoCxFYIVP5yCgidPIrwFbQrz8su/ogdeYEoMuT2SIkC9G/VjwYImmUDGu8VVpu968oWUOzu2ykDgs0Q+7h8hqCwkKm0xwMW950tduyZzZBtbFoK4p/83UeMOZDDpNz7IAdycBpI58sSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661416; c=relaxed/simple;
	bh=CHMd1SXw/ISn9rTYVdsIJCJTzvm91K4fBgbe4eULXlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9LBjDVr2PMz2gSfHQ11lYCT735HRVwfYMWtMULDG9HMuCIb00ydA8u90fJ72jTz2UW5XJuRrUdA2PmcqHPhWvJO0OPtmIdWm1SqXYS3tESVytcFAIc7iORbw36/lQF4tbNW8sssGGoFy/ERvRqpvnfGVKzyGMmT3HEOFFmKJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PreHqK+C; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PreHqK+C"
Message-ID: <352a5fed-03cd-4224-9abf-b6465373f4ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783661412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Rk74YxBrdZM+pXM0tJQi5b89Zk6ySk5xx1kZKaSuBI=;
	b=PreHqK+CAITH9uLtzX0tWmhmauzJeCuc1eNBfZ4fH0ziAUGXLKX4NawEXkB6ma2iXW8eeD
	G/+HGv3joxqkrum2gCgjT+74tvhdWQBDBGE90lCUCCgCnUTSZS9+/MwGerHHwxZ6eBoM91
	aO6kA8wR1lCoOEyxp7/voMvuskFU0MA=
Date: Thu, 9 Jul 2026 22:29:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return types
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201020.2160131-1-yonghong.song@linux.dev>
 <c15584d5097e1dbbfd358f02eb27459af0f7d643.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c15584d5097e1dbbfd358f02eb27459af0f7d643.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 5:45 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
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
>> and struct_ops function models. Allowing up to 16 bytes here is safe: the
>> previous patch already rejects >8 byte returns on the return-reading paths,
>> where the trampoline preserves only 8 bytes of the return value.
>>
>> btf_validate_return_type() is relaxed as it accepts a by-value struct or
>> union up to 16 bytes in addition to void and scalars.
>>
>> With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
>> verifier, JIT, precision-backtracking, live-register and trampoline-guard
>> preparation from the earlier patches becomes reachable: this final patch
>> enables <=16 byte aggregate return values end to end.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>   include/linux/bpf_verifier.h                       |  2 ++
>>   kernel/bpf/btf.c                                   | 14 +++++++++++---
>>   kernel/bpf/verifier.c                              |  6 +++---
>>   .../testing/selftests/bpf/progs/exceptions_fail.c  |  2 +-
>>   4 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index fa255f326240..ae4dae8e57f9 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1433,6 +1433,8 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>>   bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>>   bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog);
>>   int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id, u16 offset);
>> +bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struct btf *btf,
>> +				 const struct btf_type *t, int rec);
> Nit: maybe remove the "__" prefix?

Good point. Since it becomes a global function, we probably should remove "__" prefix.

>
>>   
>>   int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>>   bool bpf_is_throw_kfunc(struct bpf_insn *insn);
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index dff5c0d91641..bab82d1c8cb9 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7572,7 +7572,12 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>   		return -EINVAL;
>>   	}
>>   	ret = __get_type_size(btf, func->type, &t);
>> -	if (ret < 0 || btf_type_is_struct(t)) {
>> +	/*
>> +	 * __get_type_size() already restricts a non-negative ret to void, a
>> +	 * pointer, an int, an enum or a struct/union, so only the size is checked
>> +	 * here.
>> +	 */
>> +	if (ret < 0 || ret > 16) {
>>   		bpf_log(log,
>>   			"The function %s return type %s is unsupported.\n",
>>   			tname, btf_type_str(t));
>> @@ -7968,6 +7973,9 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>>   	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>>   		return 0;
>>   
>> +	if (btf_type_is_struct(t) && t->size <= 16 && __btf_type_is_scalar_struct(env, btf, t, 0))
> Nit:	if (__btf_type_is_scalar_struct(env, btf, t, 0) && t->size <= 16)

Yes, this is simpler.

>
>> +		return 0;
>> +
>>   	return -EOPNOTSUPP;
>>   }
>>   
> [...]


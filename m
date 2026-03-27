Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01738194098
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774570603; cv=none; b=TJa27vZsbRHxcCOCQQzE/LgqktUwE2/bjZS4IXKA+4pL1PiQ/hryKW0fKVoPifUwme9E1DZa7F1OJPGtEXrCPO5HVKvn3Fey0EQ6uhbo67WTC5jHGFzcO8hGHTOOnPAFmxcEvgR3qLKXxjShwfAwSu5k6McRFrdkrnIl0v22n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774570603; c=relaxed/simple;
	bh=aFNp2pbBrYyDUMvtoLzBKIFTvbk3gR9NaGIC128wjq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8tjWTXIeDl4x4iEYH/3YjfNLlaqvgBd9OfKaXcbiSN3sGyfJoYKpHWZC5KVyCneo6woqeZ+PajSf4+klXskwHAsNy0SoJdU0bXfxxBnJnEquctLc3LPxPmyu7fHcePWIYJ6qVKVApnYUWBVzC1bgSdb5DcFo+ZmZD0gTIb8bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n2DjFxwM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n2DjFxwM"
Message-ID: <44cfca58-e524-43e2-9560-2bfb52d7fb44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774570598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYDbdSeQDqAEOwb+0YPewCNkxuZJ8OaHYNkLUjGMdRI=;
	b=n2DjFxwM3Pl7BAoT046QbhgmGjR7zNQi3yLdSwxOoBThBNr7CuWwb3m5PTvW9ic1qkBqXD
	nhBltzGn7V6G6bq5+p9ZDrm8osTgvbmzm5RYv7N1GzCkWQRL+cfjDI64yHAIgkHM9eiGV0
	FnccHDyLGbDiyVObv/SqTgqy9QD8sOE=
Date: Thu, 26 Mar 2026 17:16:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <87tsuajyak.fsf@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <87tsuajyak.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/26 8:49 AM, Mykyta Yatsenko wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> writes:
> 
>> [...]
>> +/*
>> + * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
>> + *   - the _impl prototype with full arg list (this is meta->func_proto)
>> + *   - the BPF API prototype w/o implicit args (func->type in BTF)
>> + * To determine whether an argument is implicit, we compare its position
>> + * against the number of arguments of both prototypes.
>> + */
>> +static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
>> +{
>> +	const struct btf_type *func, *func_proto;
>> +	u32 argn, full_argn;
>> +
>> +	if (!(meta->kfunc_flags & KF_IMPLICIT_ARGS))
>> +		return false;
>> +
>> +	full_argn = btf_type_vlen(meta->func_proto);
>> +
>> +	func = btf_type_by_id(meta->btf, meta->func_id);
>> +	func_proto = btf_type_by_id(meta->btf, func->type);
>> +	argn = btf_type_vlen(func_proto);
>> +
>> +	return argn <= arg_idx && arg_idx < full_argn;
> The `arg_idx < full_argn` condition is not necessary, is it?
> arg_idx is always less than full_argn because full_argn is the number of
> arguments in the _impl variant of the function, which is supposed to be
> greater than non-_impl variant that arg_idx tracks.
> arg_idx >= full_argn is an invariant violation, not the implicit
> argument condition, if I understand this right.

Hi Mykyta, thanks for the review.

Yes, I think you're right.

I don't think this helper should error out on arg_idx >= full_argn,
since that would be an error caught in check_kfunc_call(). And returning
an error will make the helper a little more complicated.

At the same time, it seems logical to me that the answer to
"is arg 6 implicit for kfunc with 5 args in _impl proto?" 
should be false.

Do you have a specific suggestion?

> 
> The rest of the refactoring looks good to me.
>> +}
>> +
>>  [...]
>> -- 
>> 2.53.0


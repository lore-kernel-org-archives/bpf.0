Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4435A93C
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939155; cv=none; b=BlTlB83SgwJOhD39Ip3v2ccuuJKYxIryMjJIslw6gi7bFCw9vWtEjqRjj34RfyDC6P01aVKCZ+YfJ11u/SECj7kNUGQwGp4oubzd56cOyXOKHDFD9bWxifUqckweuVemX5L8IkyvdCFMVblvqWzBBVqr9ktCWjOHCeE2FWGhF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939155; c=relaxed/simple;
	bh=4RfgTxcgX2F6kkCgKHYwlmcrYYmLll4I/JONSbOqXbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwGgyR+qzdhMLuT0dZQZB6u2UtKlfGSAy1rbMUdsFVZuQin2ZBBssltlrFIpB0xwFtY4y284PEyOjR1cxGQgxFM4gGvu/CcN/gtd2r9AnOY3fpzBHK+Kg//THHszi9n3RaMo4op8moPLV7RGkEDxEmF/CZ4jIPBt0kRUVfGnn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lK72iSoy; arc=none smtp.client-ip=91.218.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lK72iSoy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4RfgTxcgX2F6kkCgKHYwlmcrYYmLll4I/JONSbOqXbE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787939151; v=1; x=1788543951;
 b=lK72iSoy7veIQ2MnhylgxZR3Ic1jcz40Vz7ObbYvheWY/6HRO8ZMytVEbpiMrkg7lYjm4NHj
 lUXLL8DAVGmPaGPeIR+kfAqf/xJo/gmxgh+e+ilohfVNbovOnfwQPjDi0AA0Ngo3BLQlbjdOY0Y
 g/Opj248cg85fryRI32N3Lo4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff66cf6dabd8a8c4;
	Fri, 28 Aug 2026 17:45:51 +0000
X-Mizu-Trace-ID: ff66cf6dabd8a8c4
X-Migadu-Flow: FLOW_OUT
Message-ID: <6577c990-f491-43fd-bcef-314160ea5c77@linux.dev>
Date: Fri, 28 Aug 2026 10:45:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Report which member makes a kfunc
 return type unsupported
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260827061140.2516974-1-yonghong.song@linux.dev>
 <a9b017abf99b3c4062bdb77e8fbbfbb7dff502ddf0b6f0b4bc459cb28a4cac8e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a9b017abf99b3c4062bdb77e8fbbfbb7dff502ddf0b6f0b4bc459cb28a4cac8e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 90139f1b78d10..967ad010b3222 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11646,6 +11646,15 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>>   	return argn <= arg_idx;
>>   }
>>
>> +#define BTF_MEMBER_MAX_DEPTH	4
>> +#define BTF_MEMBER_PATH_LEN	64
>> +
>> +struct btf_member_path {
>> +	const struct btf_member *member[BTF_MEMBER_MAX_DEPTH];
>> +	int depth;
>> +	bool too_deep;
>> +};
>> +
> [ ... ]
>
>> @@ -11676,31 +11686,42 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
>>
>>   		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
>>   		if (btf_type_is_struct(member_type)) {
>> -			if (rec >= 3) {
>> +			if (rec >= BTF_MEMBER_MAX_DEPTH - 1) {
>>   				verbose(env, "max struct nesting depth exceeded\n");
>> +				if (path)
>> +					path->too_deep = true;
>>   				return false;
>>   			}
>> -			if (!btf_struct_member_walk(env, btf, member_type, member_kinds, rec + 1))
>> -				return false;
>> +			if (!btf_struct_member_walk(env, btf, member_type, member_kinds,
>> +						    rec + 1, path))
>> +				goto bad_path;
>>   			continue;
>>   		}
>>   		if (btf_type_is_array(member_type)) {
>>   			array = btf_array(member_type);
>>   			if (!array->nelems)
>> -				return false;
>> +				goto bad_member;
>>   			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
>>   		}
>>   		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
>> -			return false;
>> +			goto bad_member;
>>   	}
>>   	return true;
>> +
>> +bad_member:
>> +	if (path)
>> +		path->depth = rec + 1;
>> +bad_path:
>> +	if (path && path->depth)
>> +		path->member[rec] = member;
>> +	return false;
>>   }
> [ ... ]
>
>> @@ -14077,17 +14114,46 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>>   			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>>   	} else if (btf_type_is_struct(t)) {
>> +		struct btf_member_path path = {};
>> +		const char *member_note = "";
>> +
>>   		/*
>>   		 * The returned struct comes back as raw register bits modeled
>>   		 * as an unknown scalar, so it must contain only scalars:
>>   		 * otherwise a pointer field would be laundered into a scalar
>>   		 * and escape provenance and reference tracking.
>>   		 */
>> -		if (!btf_type_is_scalar_struct(env, desc_btf, t)) {
>> +		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
>>   			verbose(env,
>>   				"kernel function %s returns %s %s that is not composed of scalars\n",
>>   				func_name, btf_type_str(t),
>>   				btf_name_by_offset(desc_btf, t->name_off));
>> +			if (path.too_deep) {
>> +				member_note = bpf_diag_fmt(
>> +					env, " It nests structs more than %d levels deep.",
>> +					BTF_MEMBER_MAX_DEPTH);
>> +			} else if (path.depth) {
>> +				const struct btf_member *bad = path.member[path.depth - 1];
>> +				char bad_name[BTF_MEMBER_PATH_LEN];
>> +				const struct btf_type *bad_type;
>> +
>> +				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
>> +				bad_type = btf_type_skip_modifiers(desc_btf, bad->type, NULL);
>> +				verbose(env, "member '%s' has type %s\n", bad_name,
>> +					btf_type_str(bad_type));
> For an array member, does this report the type that the walk actually
> rejected?
>
> Looking at btf_struct_member_walk(), when the member is an array it
> resolves the element type before testing it:
>
>      if (btf_type_is_array(member_type)) {
>          array = btf_array(member_type);
>          if (!array->nelems)
>              goto bad_member;
>          member_type = btf_type_skip_modifiers(btf, array->type, NULL);
>      }
>      if (!btf_member_kind_allowed(btf, member_type, member_kinds))
>          goto bad_member;
>
> The walk stores only the struct member itself in the path, discarding
> the resolved element type. So for a kfunc returning:
>
>      struct s { void *p[2]; };
>
> the walk rejects the element type PTR, but this diagnostic derives
> bad_type from bad->type (the array type), printing:
>
>      member 'p' has type ARRAY
>      ... Its member 'p' is ARRAY, not a scalar.
>
> That contradicts the rule documented earlier ("An array member counts
> as its element type") and the accepted behaviour of __u64 a[2], which
> passes. The same issue affects struct inner arr[2] (reported as ARRAY,
> real reason is the element is a non-scalar struct) and zero-length
> arrays, whose rejection has nothing to do with type at all.

This is indeed a problem. Will fix.

>
> This is confined to verifier log text - the accept/reject decision is
> unchanged - but the message the patch exists to add is inaccurate for
> array members.
>
>> +				member_note = bpf_diag_fmt(
>> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
>> +					btf_type_str(bad_type));
>> +			}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525


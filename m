Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12A38F251
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604281; cv=none; b=mGyzANr94vmyVYBpibO0IQPFaqbngjvU0wR6y1D8fO0nqJt50H43km3K+jRbUQe6AMC2Yeqq3ZG7i1DpuviyVBFzAn7utFvlx/QdNhVa0wcy5DQBtDf3pyptSXXLxngCj4lFuJk05plx64mvm4g1mNk/Eh4e233yhY2NyHK9GfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604281; c=relaxed/simple;
	bh=5nA/fRtCSR4KLqzF4PwZXE2rf3z/kOL/iYgTx4Jd9B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcQVYRzIBfMdbOgKvEbxz0lQ0EANxFfhGIczI0HRtQy1+DTj1hs9L9wQmkKgYlI07o+yMjHSDbMeew1qMGnRwrkzbvKKeSQWD+pO+b98C2hPLwJrcX+0TF/3Jxq7KJf+oVB6itxgt8CEFDjNWcEcbK+npp+MTZx2xqbRRK3ao7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bstgo8vT; arc=none smtp.client-ip=95.215.58.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bstgo8vT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5nA/fRtCSR4KLqzF4PwZXE2rf3z/kOL/iYgTx4Jd9B0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787604276; v=1; x=1788209076;
 b=bstgo8vTl1TI6SaZKbc/bua21eAxPPbWOfSRLCzrAbFf6AGFIYW1/dRkLSw3zjBqbSaPZuB+
 7hc0ltUYOrt8BqtzFFLA3qVP+wZTcMINghbQWO64rb3AWnaM1IZ8H8C734SxSxiFSzsrCDFgTKf
 /iV4mNpN9nnfLDf5dhp8S0lU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:d615:1a9c:14b5:6794:fad4:7620] (2600:381:d615:1a9c:14b5:6794:fad4:7620)
	by smtp.migadu.com with ESMTPS id 1e3a1eff3c0ecf52;
	Mon, 24 Aug 2026 20:44:35 +0000
X-Mizu-Trace-ID: 1e3a1eff3c0ecf52
X-Migadu-Flow: FLOW_OUT
Message-ID: <5667dbc2-a71e-4050-8592-39d735fc4f40@linux.dev>
Date: Mon, 24 Aug 2026 13:44:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpf: Report which member makes a kfunc
 return type unsupported
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260824144943.991316-1-yonghong.song@linux.dev>
 <20260824144948.992324-1-yonghong.song@linux.dev>
 <5add32b3e212f7bcc01eb920c51749ae6d2aafcd.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5add32b3e212f7bcc01eb920c51749ae6d2aafcd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/26 12:27 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-24 at 07:49 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9aa29c367008..c6aecba6437a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11623,10 +11623,14 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>>   	return argn <= arg_idx;
>>   }
>>   
>> -/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>> -bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> -			       const struct btf *btf,
>> -			       const struct btf_type *t, int rec)
>> +/*
>> + * Returns true if struct is composed of scalars, 4 levels of nesting allowed.
>> + * On failure @bad, when given, names the member that made the answer no, so a
>> + * diagnostic can point at it rather than at the whole type.
>> + */
>> +static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const struct btf *btf,
>> +				   const struct btf_type *t, int rec,
>> +				   const struct btf_member **bad)
>>   {
>>   	const struct btf_type *member_type;
>>   	const struct btf_member *member;
>> @@ -11644,23 +11648,35 @@ bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>>   				verbose(env, "max struct nesting depth exceeded\n");
>>   				return false;
>>   			}
>> -			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
>> +			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1, bad))
>>   				return false;
>>   			continue;
>>   		}
>>   		if (btf_type_is_array(member_type)) {
>>   			array = btf_array(member_type);
>>   			if (!array->nelems)
>> -				return false;
>> +				goto bad_member;
>>   			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
>>   			if (!btf_type_is_scalar(member_type))
>> -				return false;
>> +				goto bad_member;
>>   			continue;
>>   		}
>>   		if (!btf_type_is_scalar(member_type))
>> -			return false;
>> +			goto bad_member;
>>   	}
>>   	return true;
>> +
>> +bad_member:
>> +	if (bad)
>> +		*bad = member;
> The bot is correct about the nested types, would be nice to return the
> containing struct.

Sounds good, will do.

>
>> +	return false;
>> +}
>> +
>> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> +			       const struct btf *btf,
>> +			       const struct btf_type *t, int rec)
>> +{
> Nit: all callers specify 'rec == 0', hide it as well and remove the parameter?

Ack, will do.

>
>> +	return btf_scalar_struct_walk(env, btf, t, rec, NULL);
>>   }
>>   
>>   enum kfunc_ptr_arg_type {
>> @@ -14030,17 +14046,41 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>>   			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>>   	} else if (btf_type_is_struct(t)) {
>> +		const struct btf_member *bad = NULL;
>> +
>>   		/*
>>   		 * The returned struct comes back as raw register bits modeled
>>   		 * as an unknown scalar, so it must contain only scalars:
>>   		 * otherwise a pointer field would be laundered into a scalar
>>   		 * and escape provenance and reference tracking.
>>   		 */
>> -		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
>> +		if (!btf_scalar_struct_walk(env, desc_btf, t, 0, &bad)) {
>> +			const char *member_note = "";
>> +
>>   			verbose(env,
>>   				"kernel function %s returns %s %s that is not composed of scalars\n",
>>   				func_name, btf_type_str(t),
>>   				btf_name_by_offset(desc_btf, t->name_off));
>> +			if (bad) {
>> +				const char *bad_name = btf_name_by_offset(desc_btf, bad->name_off);
>> +				const struct btf_type *bad_type;
>> +
>> +				bad_type = btf_type_skip_modifiers(desc_btf, bad->type, NULL);
>> +				verbose(env, "member '%s' has type %s\n", bad_name,
>> +					btf_type_str(bad_type));
>> +				member_note = bpf_diag_fmt(
>> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
>> +					btf_type_str(bad_type));
>> +			}
> Nit: since we are going into some details with this message,
>       it seems appropriate to handle the case when bad == NULL,
>       but btf_scalar_struct_walk() returns false, saying that
>       the structure is more then 4 levels deep.

Okay, will handle else branch as you suggested.

>
>> +			bpf_diag_program_structure(
>> +				env, insn_idx, "unsupported kernel function return type",
>> +				"Call a kernel function that returns only scalars by value.",
>> +				"%s() returns %s %s by value.%s "
>> +				"A by-value return arrives as raw register bits that the verifier "
>> +				"can only model as unknown scalars, so e.g. a pointer may lose "
>> +				"the provenance and reference tracking that make it safe to use.",
> Nit: I think this description adds more confusion. I'd say something
>       like "Only kfuncs returning scalar values or arena pointers, or
>       structures composed of scalar values and arena pointers are
>       supported".

Okay.

>
>> +				func_name, btf_type_str(t),
>> +				btf_name_by_offset(desc_btf, t->name_off), member_note);
>>   			return -EINVAL;
>>   		}
>>   		mark_kfunc_ret_regs(env, regs, t->size);


Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFF40A937
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767175; cv=none; b=AKuW8FtAuWv7AyRSkwCa84V29E/I0UtarWTy4YyeVwriEP9BLtckOVjEOhnm7ENF1JoKPoMyIMzoExHrEaMt2HbFfysaoRsAwru0RaRzHY5TxY2tGQrv11aMrYTTklABUQ5ya3J4A358fnbmLVIW+DIkA0hlbLzvS2WJfnQRnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767175; c=relaxed/simple;
	bh=rbv3yZenR6gx9LrI02E5755BqoS4plLBjI5CAhdjpQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUaxDmk/tRM9ADb1DeACD+LAVyuw3vGCy+QhzEJZ3F7t5NJUn/dQggHCvRRG8SCPDQTCsAqcIJXVecW6deBfk0MeQTgei29uhsino2DpuI7dX3YzgQ2Tn7mImDpSdM0wd21FyLDRzESIfC9Mssu6Fr47Crhj+PWdo4pfOHHXtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O33umzt+; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O33umzt+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rbv3yZenR6gx9LrI02E5755BqoS4plLBjI5CAhdjpQQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787767164; v=1; x=1788371964;
 b=O33umzt+KjJu8IR2Rg8BXCYSKN50QW07/wE99SjjIioHO6C9DZLixwWlVw1FcdxE7S9rHjJb
 fEormuDqdtb5ARjXuN3WnKuzIFPegYfwA1pMVZQVYHGvz2hS6RBMcsHlb7j+0OjIZZVhGTiZxdw
 vAwInJeGcb/SFZrjS4+SWKzg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:2cdc)
	by smtp.migadu.com with ESMTPS id ed3b4452ee3c9774;
	Wed, 26 Aug 2026 17:59:24 +0000
X-Mizu-Trace-ID: ed3b4452ee3c9774
X-Migadu-Flow: FLOW_OUT
Message-ID: <ee7d4b97-2ef5-4eba-a942-e3102ca44ea5@linux.dev>
Date: Wed, 26 Aug 2026 10:59:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 05/10] bpf: Report which member makes a kfunc
 return type unsupported
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205438.1323042-1-yonghong.song@linux.dev>
 <c7418e1614ca78be0edb20a77ae33f1cf6b4a851b6e8b786d4bf70899caf131a@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c7418e1614ca78be0edb20a77ae33f1cf6b4a851b6e8b786d4bf70899caf131a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> A kfunc that returns a struct by value may only return scalars, and the
>> message that rejects one names the type but not the member at fault:
>>
>>    kernel function bpf_kfunc_call_test_ret_ptr returns STRUCT
>>    prog_test_ret_ptr that is not composed of scalars
>>
>> For a large struct that leaves the reader to find the offending member
>> by inspection. Record the member that made the walk fail and name it, so
>> the verifier also dumps:
>>
>>    member 'p' has type PTR
>>
>> What is recorded is a path rather than a single member, because the walk
>> descends up to 4 levels. For
>>
>>    struct outer { struct inner { void *p; } in; __u64 tag; };
>>
>> naming 'p' alone would send the reader looking for a member struct outer
>> does not have, so the message reads "member 'in.p' has type PTR".
>>
>> The detailed diagnostics for this failure:
>>
>>    Verification failed: Program Structure: Unsupported kernel function
>>    return type
>>
>>    Reason:
>>      bpf_kfunc_call_test_ret_ptr() returns STRUCT prog_test_ret_ptr by
>>      value. Its member 'p' is PTR, not a scalar. Only scalar values, or
>>      structs composed of scalar values, are supported as by-value kernel
>>      function return types.
> Does the Reason text shown here match what the verifier actually emits?
>
> The code at verifier.c:14120-14128 uses this format string:
>
>    "%s() returns %s %s by value.%s "
>    "Only kfuncs returning scalar values, or "
>    "structures composed of scalar values are "
>    "supported."
>
> which would produce "... Only kfuncs returning scalar values, or
> structures composed of scalar values are supported." but the quoted
> output says "... Only scalar values, or structs composed of scalar
> values, are supported as by-value kernel function return types."
>
> The first two sentences of the Reason and the Suggestion match what the
> code emits, but the third sentence appears different. Looking at the
> forward range through 6ab11e51f544, commit 37ffe60f491e5 changes it again
> to "... or arena pointers, or structures composed of scalar values and
> arena pointers are supported." but still not the wording above.
>
> Could the changelog be updated with the actual verifier output?

Okay, will update the commit message.

>
>>    ...
>>    Suggestion:
>>      Call a kernel function that returns only scalars by value.
>>
>> A type nested deeper than the walk descends has no single member to
>> blame, so that case reports the depth instead:
>>
>>    Reason:
>>      bpf_kfunc_call_test_ret_deep() returns STRUCT prog_test_ret_deep by
>>      value. It nests structs more than 4 levels deep. ...
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5ea95e75e726a..edbc48a1fdc8f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -11635,10 +11644,11 @@ static bool btf_member_kind_allowed(const struct btf *btf, const struct btf_type
>>
>>   /*
>>    * Returns true if every member of struct @t is of a kind listed in
>> - * @member_kinds, 4 levels of nesting allowed.
>> + * @member_kinds, BTF_MEMBER_MAX_DEPTH levels of nesting allowed.
>>    */
>>   static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct btf *btf,
>> -				   const struct btf_type *t, u32 member_kinds, int rec)
>> +				   const struct btf_type *t, u32 member_kinds, int rec,
>> +				   struct btf_member_path *path)
> All external callers (btf_struct_is_composed_of() and check_kfunc_call())
> pass rec=0. Could the rec parameter be removed from the public API and
> initialized internally?
>
> This was raised by Eduard Zingerman in v1 and acknowledged with "Ack, will
> do" but the parameter remains in v2.

I would like to keep this one. btf_struct_is_composed_of() is a global func
without 'rec' parameger. The recursion is for btf_struct_member_walk(), a
static function.

>
>>   {
>>   	const struct btf_type *member_type;
>>   	const struct btf_member *member;
>> @@ -11652,31 +11662,42 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
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
>> @@ -11686,6 +11707,18 @@ static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>>   	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
>>   }
>>
>> +static void btf_member_path_str(const struct btf *btf, const struct btf_member_path *path,
>> +				char *buf, size_t buf_sz)
>> +{
>> +	size_t len = 0;
>> +	int i;
>> +
>> +	buf[0] = '\0';
>> +	for (i = 0; i < path->depth; i++)
>> +		len += scnprintf(buf + len, buf_sz - len, "%s%s", i ? "." : "",
>> +				 btf_name_by_offset(btf, path->member[i]->name_off));
>> +}
> Can this handle anonymous struct/union members correctly?
>
> BTF allows struct members to have name_off == 0 for anonymous members.
> When btf_name_by_offset() is called with name_off == 0, it returns the
> empty string (the start of the string table). The walk descends into
> anonymous struct/union members since btf_type_is_struct() at
> verifier.c:11664 returns true for both BTF_KIND_STRUCT and BTF_KIND_UNION.
>
> For a kfunc like:
>
>    struct ret_anon {
>            union { void *p; __u64 v; };  /* anonymous union */
>            __u64 tag;
>    };
>    __bpf_kfunc struct ret_anon bpf_kfunc_ret_anon(void);
>
> the walk would fail on 'p' at rec == 1, so path->depth == 2 with
> path->member[0] being the unnamed union and path->member[1] being 'p'.
> This would produce the path string ".p" since the first component is empty
> but the separator "." is still emitted.
>
> Would it make sense to skip empty components or substitute something like
> "<anon>" to keep the path readable?

Let us skip empty components. If anything wrong, user will look at
struct itself and can find the member sequence easily.

>
>> +
>>   enum kfunc_ptr_arg_type {
>>   	KF_ARG_CONST_MEM_SIZE,
>>   	KF_ARG_MEM_SIZE,
> [ ... ]
>
>> @@ -14053,17 +14086,46 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
>> -			verbose(env,
>> -				"kernel function %s returns %s %s that is not composed of scalars\n",
>> +		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
>> +			if (path.too_deep) {
>> +				member_note = bpf_diag_fmt(
>> +					env, " It nests structs more than %d levels deep.",
>> +					BTF_MEMBER_MAX_DEPTH);
>> +			} else if (path.depth) {
>> +				const struct btf_member *bad = path.member[path.depth - 1];
>> +				char bad_name[BTF_MEMBER_PATH_LEN];
>> +				const struct btf_type *bad_type;
>> +
>> +				verbose(env,
>> +					"kernel function %s returns %s %s that is not composed of scalars\n",
>> +					func_name, btf_type_str(t),
>> +					btf_name_by_offset(desc_btf, t->name_off));
>> +				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
>> +				bad_type = btf_type_skip_modifiers(desc_btf, bad->type, NULL);
>> +				verbose(env, "member '%s' has type %s\n", bad_name,
>> +					btf_type_str(bad_type));
>> +				member_note = bpf_diag_fmt(
>> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
>> +					btf_type_str(bad_type));
>> +			}
>> +			bpf_diag_program_structure(
>> +				env, insn_idx, "unsupported kernel function return type",
>> +				"Call a kernel function that returns only scalars by value.",
>> +				"%s() returns %s %s by value.%s "
>> +				"Only kfuncs returning scalar values, or "
>> +				"structures composed of scalar values are "
>> +				"supported.",
>>   				func_name, btf_type_str(t),
>> -				btf_name_by_offset(desc_btf, t->name_off));
>> +				btf_name_by_offset(desc_btf, t->name_off), member_note);
>>   			return -EINVAL;
>>   		}
>>   		mark_kfunc_ret_regs(env, regs, t->size);
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405


Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBD39FCBC
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770650; cv=none; b=I686mMGJxl6M4KuN6p38p2NOnYEognLksyi8n7pG6AZDmUW/vj2vhc0qTtDGDveDFG3ufCqzubHzmlJfsw4R8i6detrIEWaeW//kCwhBffklF9/J0ewSdpaipQNhwOSnxGxUhTXidGRtSojKZE6kOPJRAucJcWti+gfdW2LVYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770650; c=relaxed/simple;
	bh=y3e61zM25m8gwkyBVSEgHqKXN5KIFgrtWOTw1B1BD+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/c4C137tosHz5OuSrhOliTbHCZI/Qptc9M3/IofCJ/9R69vxC/OMqL1ZbJt/NXkYRqR31czC2aDXtS1Eq8Y1m0nCqkMqQ7sl3PdD6z0wjuRP7n8j5pP276FJTc6S1G+n9o8xc0Anr3fvkrpL3FgEoMcAl082f3YgMBbam6lvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hb0lda1N; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hb0lda1N"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y3e61zM25m8gwkyBVSEgHqKXN5KIFgrtWOTw1B1BD+4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787770639; v=1; x=1788375439;
 b=hb0lda1NfmEI8Dev8mzEN4PjjtRx7XVA29uOzR8xiaM4HBEvZFW/5zxcmHUU2IooOt6NpLBK
 dtVR82pw7dMm3+J4VP7Nj0Vg4a783A7LzAuIXMgfov3nNF/q8aBAhbkixAqyEP+7qESyBZ6cFGw
 h14HKExBw4u6am0IcJwXhEbY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:2cdc)
	by smtp.migadu.com with ESMTPS id 6145313aa72cfd8e;
	Wed, 26 Aug 2026 18:57:19 +0000
X-Mizu-Trace-ID: 6145313aa72cfd8e
X-Migadu-Flow: FLOW_OUT
Message-ID: <e7433f26-4d81-49e7-bdf1-ce5c731d85ff@linux.dev>
Date: Wed, 26 Aug 2026 11:57:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 07/10] bpf: Allow arena pointers in a by-value
 kfunc return
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205448.1324569-1-yonghong.song@linux.dev>
 <78325e93a25b9a6cb4ed57afdafd0db5560e504e0a1e56eceac1c5bba029c0a2@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <78325e93a25b9a6cb4ed57afdafd0db5560e504e0a1e56eceac1c5bba029c0a2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/25/26 3:13 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index edbc48a1fdc8f..0c2181d587489 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14090,12 +14090,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		const char *member_note = "";
>>
>>   		/*
>> -		 * The returned struct comes back as raw register bits modeled
>> -		 * as an unknown scalar, so it must contain only scalars:
>> -		 * otherwise a pointer field would be laundered into a scalar
>> -		 * and escape provenance and reference tracking.
>> +		 * The returned struct may only contain scalars and arena pointers
>> +		 * as its members. Otherwise, any other pointer would be laundered
>> +		 * into a scalar and escape provenance and reference tracking.
>>   		 */
>> -		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
>> +		if (!btf_struct_member_walk(env, desc_btf, t,
>> +					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {
> The rewritten comment drops the mechanism that justified the rule and, as
> written, gives a rationale that contradicts the new behaviour. The
> previous comment was:
>
>    /* The returned struct comes back as raw register bits modeled as an
>     * unknown scalar, so it must contain only scalars: otherwise a pointer
>     * field would be laundered into a scalar and escape provenance and
>     * reference tracking.
>     */
>
> The new text keeps the 'laundered into a scalar' conclusion but deletes
> the 'comes back as raw register bits modeled as an unknown scalar' premise,
> and then asserts arena pointers are fine. A reader is left with an
> inconsistency, because an arena pointer member is laundered into a scalar
> in exactly the same way -- mark_kfunc_ret_regs() marks both R0 and R2 as
> unknown scalars regardless of member kinds.
>
> The actual reason arena pointers are safe is not stated anywhere in the
> change: a laundered arena address is only usable after
> addr_space_cast/cast_kern, check_alu_op() already lets a program
> cast_kern() any scalar, and cast_kern is lowered to a 32-bit ALU mov so
> the result is confined to the arena window at r12. One clause noting that
> arena pointers need no provenance because they are re-derived by
> cast_kern would restore the invariant explanation.
>
> Also, 'Otherwise, any other pointer' is redundant ('otherwise' plus
> 'any other').

Okay, I will adjust comments then.

>
>> @@ -14106,7 +14106,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				const struct btf_type *bad_type;
>>
>>   				verbose(env,
>> -					"kernel function %s returns %s %s that is not composed of scalars\n",
>> +					"kernel function %s returns %s %s that is not composed of scalars or arena pointers\n",
>>   					func_name, btf_type_str(t),
>>   					btf_name_by_offset(desc_btf, t->name_off));
>>   				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
>> @@ -14114,15 +14114,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				verbose(env, "member '%s' has type %s\n", bad_name,
>>   					btf_type_str(bad_type));
>>   				member_note = bpf_diag_fmt(
>> -					env, " Its member '%s' is %s, not a scalar.", bad_name,
>> -					btf_type_str(bad_type));
>> +					env,
>> +					" Its member '%s' is %s, not a scalar or an arena pointer.",
>> +					bad_name, btf_type_str(bad_type));
>>   			}
>>   			bpf_diag_program_structure(
>>   				env, insn_idx, "unsupported kernel function return type",
>> -				"Call a kernel function that returns only scalars by value.",
>> +				"Call a kernel function that returns only scalars or arena pointers by value.",
>>   				"%s() returns %s %s by value.%s "
>> -				"Only kfuncs returning scalar values, or "
>> -				"structures composed of scalar values are "
>> +				"Only kfuncs returning scalar values or arena pointers, or "
>> +				"structures composed of scalar values and arena pointers are "
>>   				"supported.",
>>   				func_name, btf_type_str(t),
>>   				btf_name_by_offset(desc_btf, t->name_off), member_note);
> In the bpf_diag_program_structure() reason text, 'structures composed of
> scalar values and arena pointers' reads as a conjunction, i.e. that a
> supported struct must contain both scalars and arena pointers. The
> accepted set is a disjunction: BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR
> accepts any mix, including all-scalar and all-arena-pointer structs. The
> other three strings in the same diagnostic use 'or' consistently, so this
> line is the odd one out. Would 'structures composed of scalar values or
> arena pointers' match?

Sounds good.

>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> index d6b422ae9784b..f10e5cf6fd890 100644
>> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> @@ -71,7 +71,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
>>
>>   SEC("tc")
>>   __arch_x86_64 __arch_arm64
>> -__failure __msg("is not composed of scalars")
>> +__failure __msg("is not composed of scalars or arena pointers")
>>   __naked int aggregate_ret_kfunc_ptr_fail(void)
> [ ... ]
>
> This commit relaxes the by-value kfunc struct return rule from
> BTF_MEMBER_SCALAR to BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR and updates
> all four user-visible verifier strings accordingly, but
> Documentation/bpf/kfuncs.rst section 2.9 still documents the old contract
> and is now factually wrong in three places:
>
>    - 'A struct or union returned by value must be composed only of scalars
>      (recursively), where a scalar is an integer or an enum'
>    - 'A struct or union with a pointer member is therefore rejected at load
>      time' -- a struct with a 'void __arena *' (btf_type_tag("arena"))
>      member is now accepted
>    - 'A kfunc may also return a value larger than 8 bytes and up to 16
>      bytes -- a scalar-only struct or union, or an __int128'
>    - 'A global subprogram is verified in isolation, so its by-value struct
>      or union return is restricted to scalars just like a kfunc's' -- also
>      invalidated by patch 4 of the same series (ba9c98e6fb9db, 'bpf: Allow
>      a global function to return arena pointers by value')
>
> This paragraph is not boilerplate: it was written specifically to explain
> this restriction (it even paraphrases the code comment that this commit
> deletes), so it is the authoritative reference for the rule being changed.
> Looking at the range 37ffe60f491e..6ab11e51f5443, no commit in the series
> updates Documentation/, so the documentation stays contradictory after the
> whole series is applied.
>
> Could the paragraph be extended to say members may be scalars or arena
> pointers, and explain that an arena pointer member is likewise handed back
> as a scalar which the program must cast_kern() before use?

Okay, will update doc properly.

>
> The new acceptance path is reachable only through an annotation mechanism
> the kfunc ABI does not currently offer. btf_type_is_arena_ptr() matches
> only a kflag=0 BTF_KIND_TYPE_TAG named 'arena' and explicitly skips
> kflag'd tags. The established way a kfunc declares arena pointers is
> KF_ARENA_RET / KF_ARENA_ARG1/2 plus the '__arena' parameter-name suffix,
> which tools/bpf/resolve_btfids emits as a kflag=1 type attribute
> 'address_space(1)' -- deliberately not matched here. resolve_btfids'
> arena_tag_ptr() also only tags a func proto's return pointer and its
> parameters, and errors out with 'arena type is not a pointer' for a struct
> return, so KF_ARENA_RET cannot express 'this returned struct's members are
> arena pointers'.
>
> So a kfunc can only hit this new path if its declaration carries a raw
> __attribute__((btf_type_tag("arena"))) on the member, and no kernel-side
> macro exists for that. The follow-up selftest commit 6ab11e51f5443 has to
> invent its own '#define __arena_tag
> __attribute__((btf_type_tag("arena")))' in
> tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h, guarded by
> __has_attribute(btf_type_tag), plus a runtime BTF probe
> (testmod_has_arena_tagged_member()) that test__skip()s when the build
> toolchain did not emit the tag. That is evidence the code is live but also
> that no supported kernel-side spelling exists.
>
> Would an in-kernel __arena macro (or teaching resolve_btfids to tag struct
> members under KF_ARENA_RET) make the feature usable by real kfuncs and
> testable without a skip?

Good point, let me check this __arena macro is preferred compare to
   __attribute__((btf_type_tag("arena")))

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405


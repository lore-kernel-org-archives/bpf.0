Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C442F6918
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841426; cv=none; b=a1tX8/oO+JorUWBosPxxgPzMkWjoNTCX3H2i1JzJ98XW4xrPwbdbi0+mrm2JHIlQHD5/tVztk894hyrltXcjZnBRRSHm2NZT3Ap/Inm5Yk5+KLx8qCDBdzihRj+k1wvdK1zF4tuwr0GpQzMUBnJ4ecokBzKN+UBsbJ2sGUO4NQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841426; c=relaxed/simple;
	bh=LfxLBJgZuyYQCaAaWh8nzEEflKZOe2DYm/r4xFihm48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2GWLHShMAHJd8hbV/7LHPy1otTvTFWgV/+U9dLpEUGMZQuvDzB53BQ2qEBlV4+WNRuvVJEaaFIm2Zd9yHDLdftjsQJvsaEEjJlBrpS07hOI5H08YMB4Yd2oNsrtBBn+oYzzp+hPgRnt5poPRg6GU+eibCsvVp5N9jJ2od6eRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IMHe2FSG; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IMHe2FSG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LfxLBJgZuyYQCaAaWh8nzEEflKZOe2DYm/r4xFihm48=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841422; v=1; x=1789446222;
 b=IMHe2FSGGlpGeskFrk17eYCyhaqrqwPTwtrLmaO84EUw3/kSjjl131xsvoPtTCF3e2QQc4hB
 Om9R/IGIShHKKw5ROB/MyAqi6VNjl39LlWOJ+hYERkfN4enDuAudw48g3xR2rQBZxERgSMZcqbQ
 T8Jeo4+W8yoU7g3KGuqmuJGU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0e3692f958464a3;
	Tue, 08 Sep 2026 04:23:42 +0000
X-Mizu-Trace-ID: a0e3692f958464a3
X-Migadu-Flow: FLOW_OUT
Message-ID: <8e59b431-3124-46a4-b6d6-1e1ae59f08c4@linux.dev>
Date: Mon, 7 Sep 2026 21:23:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/12] bpf: Support by-value struct and __int128
 kfunc arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051023.3979415-1-yonghong.song@linux.dev>
 <b596aa791c607e639b08d2e6bd6a4a3a9ed28e39bade2364e4b77a2e01678cdc@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b596aa791c607e639b08d2e6bd6a4a3a9ed28e39bade2364e4b77a2e01678cdc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 11:24 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 17e576c7b757..030fb37c22ef 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -12792,29 +12904,34 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>>   	const struct btf *btf = meta->btf;
>>   	const struct btf_param *args;
>>   	struct btf_record *rec;
>> -	u32 i, nargs;
>> +	u32 i, k, nargs, proto_slots, slots_used, nslots = 0;
>>   	int ret;
>>
>>   	args = (const struct btf_param *)(meta->func_proto + 1);
>>   	nargs = btf_type_vlen(meta->func_proto);
>> +	proto_slots = kfunc_proto_slots(btf, meta->func_proto);
>>
>> -	ret = check_outgoing_stack_args(env, caller, nargs, func_name, btf, args);
>> +	ret = check_outgoing_stack_args(env, caller, proto_slots, func_name, btf,
>> +					proto_slots == nargs ? args : NULL);
>>   	if (ret)
>>   		return ret;
>>
>>   	/* Check that BTF function arguments match actual types that the
>>   	 * verifier sees.
>>   	 */
>> -	for (i = 0; i < nargs; i++) {
>> -		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
>> +	for (i = 0, slots_used = 0; i < nargs; i++, slots_used += nslots) {
>> +		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slots_used);
>>   		const struct btf_type *t, *ref_t, *resolve_ret;
>>   		enum bpf_arg_type arg_type = ARG_DONTCARE;
>> -		argno_t argno = argno_from_arg(i + 1);
>> +		argno_t argno = argno_from_arg(slots_used + 1);
>>   		int regno = reg_from_argno(argno);
>>   		bool btf_id_fixed_off_ok = true;
>>   		u32 ref_id = args[i].type, type_size;
>>   		int kf_arg_type = meta->fn->arg_type[i];
>>
>> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>> +		nslots = kfunc_arg_slots(t);
>> +
> This converts the argument walk to slot-based indexing, where 'reg' and
> 'argno' now come from 'slots_used' rather than 'i'.  Before this patch
> every parameter took exactly one slot, so parameter index and slot
> index were the same number.  After this patch they diverge whenever a
> parameter takes two slots.
>
> The KF_ARG_MEM_SIZE case, ~500 lines further down in check_kfunc_args(),
> was not converted.  It still resolves the buffer register by parameter
> index:
>
> kernel/bpf/verifier.c:check_kfunc_args() {
>      ...
>      case KF_ARG_MEM_SIZE:
>      {
>          struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
>          struct bpf_reg_state *size_reg = reg;
>          argno_t buff_argno = argno_from_arg(i);
>      ...
> }
>
> For a kfunc such as
>
>      void bpf_x(__int128 v, void *p, u32 p__sz);
>
> v occupies slots 0-1 (R1, R2), p slot 2 (R3), p__sz slot 3 (R4).  At
> i == 2, slots_used == 3, so 'reg' and 'argno' correctly select R4, but
> buff_reg = get_func_arg_reg(caller, regs, i - 1) selects R2 (the upper
> eightbyte of v) instead of R3, the pointer the length actually
> describes.  The same applies to a 16-byte by-value struct parameter,
> exactly the shape this patch exists to enable.
>
> The consequence is a validation hole, not just a bad diagnostic.  R2 is
> a SCALAR_VALUE, so when the program passes a __int128 (or struct) whose
> upper eightbyte is zero -- the common case for any value that fits in
> 64 bits -- bpf_register_is_null(buff_reg) is true and the case breaks
> out early:
>
>          if (bpf_register_is_null(buff_reg))
>              break;
>
> check_mem_size_reg() is then never called, so neither p nor p__sz is
> checked.  The pointer's own iteration does not cover it either:
> get_kfunc_arg_type() classifies a pointer followed by a __sz parameter
> as plain KF_ARG_PTR_TO_MEM without MEM_FIXED_SIZE, and that switch arm
> only validates size when MEM_FIXED_SIZE is set.  The program therefore
> loads and the kfunc runs with an unbounded length against p.  When the
> upper eightbyte is non-zero the failure inverts into a spurious
> rejection, since check_mem_size_reg() is handed a scalar as the memory
> pointer.  buff_argno = argno_from_arg(i) is wrong in the same way and
> feeds the wrong register into the diagnostics and into
> mark_stack_arg_precision()/mark_chain_precision() via
> check_mem_size_reg().

Yes, I missed this one. Will fix.

>
> At this commit gen_kfunc_arg_proto() gates every nslots > 1 argument on
> bpf_jit_supports_kfunc_arg_slot(), whose __weak default in
> kernel/bpf/core.c returns false, so multi-slot kfunc arguments are
> still refused.  Within the stated range
> db649eef61418e5d0289d88bcdd663e510756589..9ad88f2069ccb8b9d464230a3d04082baaffe4e0,
> commit 2924cde3ca70 ("bpf, x86: Place kfunc arguments per the SysV
> calling convention") and commit e958bc6f838b ("bpf, arm64: Place kfunc
> arguments per AAPCS64") enable the path, and no commit in that range
> touches kernel/bpf/verifier.c again apart from db9461ba111c adding
> btf_type_align16().
>
> Both uses should be derived from the slot walk, e.g.
> get_func_arg_reg(caller, regs, slots_used - 1) and
> argno_from_arg(slots_used).
>
> ---
>
> commit db649eef61418e5d0289d88bcdd663e510756589
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>>      bpf: Support by-value struct and __int128 kfunc arguments
>>
>>      A kfunc taking a struct or union by value is rejected today, and one
>>      taking an __int128 is accepted but mis-counted:
>>
>>        Unrecognized R2 type STRUCT
>>
>>      Give the kfunc argument walk the same slot count a BPF-to-BPF call now
>>      uses: one argument register per eightbyte, so a 16-byte value takes two.
>>      The outgoing stack argument count at the call site follows the slots for
>>      the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
>>      aggregate argument only supports tbe composed of scalars.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for kfunc argument handling introduced in
> commit 1690dcf27c73 ("bpf: Classify scalar kfunc arguments from BTF"),
> which added get_kfunc_arg_type() that only handled scalar and pointer
> types, causing struct/union types to be rejected with 'Unrecognized R2
> type STRUCT' and __int128 arguments to be mis-counted.  Should this
> include:
>
>    Fixes: 1690dcf27c73 ("bpf: Classify scalar kfunc arguments from BTF")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551


Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AB30DEA3
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233201; cv=none; b=E6BduO77Q7allffHyn9FC36HZ9f7zpdlE7DFvnZ5N5MbfnexdlTiZZeElZld43fEkWQ+IIVm1q9O7jqhmYAiNHeifBIiVpll+XKL8/AGP175qyvZgqx3L3vPYeDmZwsAdKESSA1tXYXkVlEZy6ZyKQAvhR7UdmLpSQ3T3+p3BFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233201; c=relaxed/simple;
	bh=OAPaw3J0/rCygPzOJwlLjucLuEGFUMt+RM1orCn81rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHbwL6D/g7Ns8o09KfsIFt9MXXss0507FBJLQ+pHqGmSUEOb+jApMtBqLjkkgqEaG1TLINDK1nvIqLd76KVeZFizsQY/W/mWEM9avjx0FPf0IBfGsyJpA9mYS/a6EoLb30HepOUprBuzr6buOS7fgk7/P5cnmwbjBZ7knYsDP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbgr1doM; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbgr1doM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OAPaw3J0/rCygPzOJwlLjucLuEGFUMt+RM1orCn81rw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789233196; v=1; x=1789837996;
 b=sbgr1doMxsOMU/UOlCRjFI000wTz6Hl0aY4usMX6XfE+E0xaJWpMhdef45W9kVay2v4HP13p
 M/ibIZPaNJ6d0tb34CIis1Jn2qmyXzpzIPqtOr6SPb/6qPOtpuyveccODDjq+3tC+P+BL2Svd3w
 8Zmgwx+06xqiUdQAFwsDK09k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02a9444df0ec142b;
	Sat, 12 Sep 2026 17:13:16 +0000
X-Mizu-Trace-ID: 02a9444df0ec142b
X-Migadu-Flow: FLOW_OUT
Message-ID: <754a6f66-7304-47f8-92fa-5c57d454109b@linux.dev>
Date: Sat, 12 Sep 2026 10:13:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Recognize by-value struct and
 __int128 kfunc arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260911154954.2008505-1-yonghong.song@linux.dev>
 <255ff7973d5971f95d7a43241872424eac7694cf5c8fd3d2c86030e04ba63fcb@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <255ff7973d5971f95d7a43241872424eac7694cf5c8fd3d2c86030e04ba63fcb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 9:47 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Recognize by-value struct and __int128 kfunc arguments
>>
>> A kfunc taking a struct or union by value is rejected today, and one
>> taking an __int128 is accepted but mis-counted:
>>
>>    Unrecognized R2 type STRUCT
>>
>> The kfunc arguments walk the same slot as a BPF-to-BPF call:
>> one argument register per eightbyte, and a 16-byte value takes two.
>> The outgoing stack argument count at the call site follows the slots for
>> the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
>> aggregate argument is only supported when it is composed of scalars.
>> Everything that maps a kfunc argument to a register has to follow the
>> slots too.
>>
>> An argument of a single eightbyte lands in the same place under every
>> calling convention, so those are taken. The conventions the JIT has to
>> reconcile do not agree on where a larger one goes, so refuse it for now
>> with
>>
>>    Function f arg#1 type INT cannot be passed at argument slot 1 on this
>>    architecture
>>
>> which the next patch turns into an answer from the JIT. The paths that
>> handle a two-slot argument are therefore unreachable until then.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for kfunc struct argument support. Should this
> include:
>
>    Fixes: 0ab8eb34abe4 ("bpf: Support by-value struct arguments up to 16 bytes")
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c520c37bb3c9..9e70995c763f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -12892,29 +12978,35 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>>   	const struct btf *btf = meta->btf;
>>   	const struct btf_param *args;
>>   	struct btf_record *rec;
>> -	u32 i, nargs;
>> +	u32 i, k, nargs, proto_slots, slots_used, prev_slot = 0, nslots = 0;
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
>> +	for (i = 0, slots_used = 0; i < nargs;
>> +	     i++, prev_slot = slots_used, slots_used += nslots) {
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
>>   		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
>>   			/* Reject repeated use bpf_prog_aux */
>>   			if (meta->arg_prog) {
> [ ... ]
>
>> @@ -12986,6 +13076,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>>   			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>>   		}
>>
>> +		/*
>> +		 * The first slot is checked in below KF_ARG_ANYTHING.
>> +		 * The rest of it has to be a scalar.
>> +		 */
>> +		for (k = 1; k < nslots; k++) {
>> +			ret = check_kfunc_scalar_arg(env, caller, regs, slots_used + k,
>> +						     insn_idx, func_name);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
> This isn't a bug, but would it be worth rewording this comment to name
> the KF_ARG_ANYTHING case explicitly and speak of the remaining slots in
> the plural? The phrase "checked in below KF_ARG_ANYTHING" is a bit hard
> to parse, and "the rest of it" refers to slots while the sentence subject
> is singular.

I will update above comments to be clear about 'below KF_ARG_ANYTHING'.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527


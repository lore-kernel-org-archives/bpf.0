Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65823D810F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975436; cv=none; b=rQZbGX3EQFq5FhwR7OYCiA2CSXeqKEBmjkvF5t9ogVjbxZilE4o6I1QFMoKdTSIfWB9gAggZ4L+XxKMH4PS79klU4qOdhC3bHFc4QH90bHZwlexgqQi8bPJsukkXa0iDHWhFU5ZyU6me7A/lgI4W5epUAk0ehNWT1hGZK7nuWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975436; c=relaxed/simple;
	bh=yCw6xXyOZGegyFbAV2WEaZa8j1Ob77m6e29E3NYbfvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGNmlkZZNTkkYER3CAsiWwhXtoI3zhlsqMKfFCYp8qC9AP/w1CHcrnNIKvxTVakZNkGbyzuSuodOHN9PtoHsS8dXoSV57W2Vbn1Q3f8ABgDQCxJZ5S7QWXZoycvvQMg+o1SjS8bijOxlCVubs1y4vm59PFmhSMWvHB0DeN9OQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAl03MG8; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAl03MG8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yCw6xXyOZGegyFbAV2WEaZa8j1Ob77m6e29E3NYbfvM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790975431; v=1; x=1791580231;
 b=xAl03MG8SdOhXc0XjMLtn8I7mY4AWjIWtCLC63rDelScxbGscsfIlzltaA3thU0lWkPk7mb9
 LPZwAbQ+Sft+PTThb1FN8/fC34Wh+8cXHsMMpUqHsv/uStweyJ8aeEd5Iu2XX7QOrgofmSNwCCj
 Qc2mGsIyo8pbbsxy3gZRquEE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75ff3fc86023e63b;
	Fri, 02 Oct 2026 21:10:18 +0000
X-Mizu-Trace-ID: 75ff3fc86023e63b
X-Migadu-Flow: FLOW_OUT
Message-ID: <f6bd483c-a6ec-41f0-87cc-771cea8cf38d@linux.dev>
Date: Fri, 2 Oct 2026 22:10:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 08/22] bpf: Require an unwind to leave a frame
 holding what it entered with
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261001133047.1339752-1-yonghong.song@linux.dev>
 <a203a496c37cc672ef89f2e95a82b48c4a19863d832a055a3bfda60e3fd206ec@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a203a496c37cc672ef89f2e95a82b48c4a19863d832a055a3bfda60e3fd206ec@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 7:31 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Require an unwind to leave a frame holding what it entered with
> TL;DR: call_may_unwind() treats every callx as possibly unwinding, so the
> verifier may wrongly reject valid programs that hold a reference or spin lock
> across a callx; the exact target is available from the register.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c7a350be538e..a7b25ab04051 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -19244,6 +19245,32 @@ static int unwind_out_of_global_call(struct bpf_verifier_env *env, int call_idx,
>>   	return INSN_IDX_UPDATED;
>>   }
>>
>> +/* Can an unwind come back out of this call? */
>> +static bool call_may_unwind(struct bpf_verifier_env *env, const struct bpf_insn *insn,
>> +			    int insn_idx)
>> +{
>> +	int subprog;
>> +
>> +	/* Which subprog a callx lands in is not known here, so any may be it. */
>> +	if (bpf_is_callx(insn))
>> +		return bpf_prog_may_unwind(env);
> Is it true that the target of a callx is not known here?

This is way to conservatile as if *any* subprog is marked as may_unwind, then
it will return bpf_is_callx(insn). The best thing is to follow callx itself
and find whether it is possible may_unwind or not.

>
> call_may_unwind() is reached from check_unwind_through_call() in
> do_check_insn(), just before check_func_callx().  check_func_callx() takes
> the exact target from the same register state a few lines later:
>
> 	reg = reg_state(env, insn->dst_reg);
> 	if (reg->type != PTR_TO_FUNC) ...
> 	/* PTR_TO_FUNC is a pointer to a static subprog */
> 	subprog = reg->subprogno;
>
> and check_func_ptr_read() pushes one state per possible table target, each
> with its own subprogno.  So each verified callx has exactly one target at
> this point.  Only the CFG pass has to be conservative, and
> mark_callx_might_unwind() already marks any target that itself contains a
> callx.
>
> With the current code, an uncovered callx is refused by
> bpf_exc_check_frame_balance() whenever the calling frame has changed its
> RCU, preempt, IRQ, spin lock or reference state since entry, as long as some
> unrelated subprog in the program is marked might_unwind.  For example:
>
> 	foo():
> 	    t = bpf_task_acquire(...);  /* id > entry_id_gen */
> 	    r1 = vtable[i];             /* PTR_TO_FUNC -> bar, no unwind in bar */
> 	    callx r1                    /* no cleanup record covers it */
> 	    bpf_task_release(t);
>
> 	baz():
> 	    bpf_unwind();               /* makes bpf_prog_may_unwind() true */
>
> Before this patch this program was accepted.  Now it is refused with "an
> unwind through this call keeps the reference id=N the frame acquired", even
> though no unwind can pass through that call.  callx is also explicitly
> allowed under a spin lock, so a frame that holds a bpf_spin_lock across a
> callx is refused as well with "an unwind through this call does not leave
> the frame's bpf_spin_lock state as it found it".
>
> Could this look at the register instead, something like:
>
> 	reg = &cur_regs(env)[insn->dst_reg];
> 	if (reg->type == PTR_TO_FUNC)
> 		return env->subprog_info[reg->subprogno].might_unwind;
>
> and leave it to check_func_callx() to refuse any other register type, as it
> does today?
>
>> +	if (insn->src_reg != BPF_PSEUDO_CALL)
>> +		return false;
>> +	subprog = bpf_find_subprog(env, insn_idx + insn->imm + 1);
>> +	return subprog >= 0 && env->subprog_info[subprog].might_unwind;
>> +}
>> +
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096


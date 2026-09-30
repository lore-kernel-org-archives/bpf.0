Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0457343D7F
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730580; cv=none; b=uOpw9wCYwJHTfCC/+ZxtH1rdZslo1kYxKzAUk1s6fAz9gK83MAhmbrEG9/GWo34UxfTPZhB1D/Oa5okUsQSiXth1j67GvjgtU6nF6nu/iI07tAEX1MRQiicFNAGJ+gcsx8cB6HbbTiKAiaTyd/7slPJAmpODvhdjmqrxJUjQm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730580; c=relaxed/simple;
	bh=sI1D2ep9dYGTQ4J5tLZoATKKAmcMxx3PeQ+xN0rhHps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxOSzRZ4drn1k486GxIyDIA6iEXuGt5FHIm9SCIjpbIZdnQSySraTPDsSVExGJZlYOoaylnVapKOY05tz2fELsNWjnfmJE6IkVcgaJzlR0qahjnCLH1gjiCmziZuNDkwvf3CETnOU949DxilkFNlxo6R3PbFzSDQEjzYbqtg2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbAvEIFV; arc=none smtp.client-ip=95.215.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbAvEIFV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sI1D2ep9dYGTQ4J5tLZoATKKAmcMxx3PeQ+xN0rhHps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790730574; v=1; x=1791335374;
 b=TbAvEIFVbTAQDHLH2DB2HcL7RDMt5lqWD+XCnR5juFhNRkaEswPHF7T8t8odJuMqUXphqrWn
 XYHbqv6f/gmwTV1gRTh/iGZRD1GG2nCBNyWYGD7YTFF6isBfcXpqKOgLnyEwUsDjFuQ/bPYRlKG
 9v/mJmVXelQq/TX3F6Aj3+9E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8121d26f7cf1fabd;
	Wed, 30 Sep 2026 01:09:34 +0000
X-Mizu-Trace-ID: 8121d26f7cf1fabd
X-Migadu-Flow: FLOW_OUT
Message-ID: <b2cf2368-a562-4569-b466-b70baa35205d@linux.dev>
Date: Tue, 29 Sep 2026 18:09:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 08/22] bpf: Require an unwind to leave a frame
 holding what it entered with
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001643.3249386-1-yonghong.song@linux.dev>
 <20260929003638.8A1181F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260929003638.8A1181F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] bpf: type confusion and memory corruption due to stale cleanup pad state
> - [High] bpf: lock corruption and double-unlock via missing identity check on unwind
> --
>
> commit 585aa50d9e8811792b9a816a4d1ad6cd51d63ea7
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Require an unwind to leave a frame holding what it entered with
>
> This commit updates the BPF verifier to record what locks and references
> a program holds when a frame is entered. It enforces that an unwind must
> leave the frame holding what it entered with, ensuring that landing pads
> verified against pre-call snapshots remain valid.
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 0143688896b0e..75e572a8a1bab 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -339,6 +339,18 @@ struct bpf_func_state {
>>   	bool in_async_callback_fn;
>>   	bool in_exception_callback_fn;
>>   	bool no_stack_arg_load;
>> +	/*
>> +	 * What the program held when this frame was entered. An unwind leaves
>> +	 * the frame without running anything below it, so the frame has to put
>> +	 * these back to what it found before it goes -- otherwise a caller's
>> +	 * landing pad, whose state was taken at the call, is wrong about them.
>> +	 */
>> +	u32 entry_active_locks;
>> +	u32 entry_preempt_locks;
>> +	u32 entry_rcu_locks;
>> +	u32 entry_irq_id;
>> +	u32 entry_id_gen;
>> +	u32 entry_acquired_refs;
> [Severity: High]
> Does this structure need fields to record the identity of the lock held upon
> frame entry? Without this, it might be difficult to accurately enforce the
> correct lock state on unwind.

Assuming the bug in patch 7 fixed.

Verifier flow should match lock/unlock with the same identity. Otherwise
verification will fail. I think we are okay here.

>
> Additionally, is it necessary to update func_states_equal() to compare these
> new entry_* fields? Without comparing them, could the verifier unsafely prune
> states with different entry locking conditions?

I think we are fine here. There are already some lock checking in refsafe(),
assuming patch 7 bug fixed.

>
> [ ... ]
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index c1779d2d02f05..c0b0b8478af51 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -12,6 +12,72 @@
>>   BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>>   BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
>>   
>> +void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
>> +				struct bpf_func_state *frame, u32 id_gen)
>> +{
> [ ... ]
>> +int bpf_exc_check_frame_balance(struct bpf_verifier_env *env, const char *prefix)
>> +{
>> +	const struct bpf_verifier_state *state = env->cur_state;
>> +	const struct bpf_func_state *frame = cur_func(env);
>> +	u32 i, held;
>> +	const char *what;
>> +
>> +	if (state->active_rcu_locks != frame->entry_rcu_locks)
>> +		what = "bpf_rcu_read_lock";
>> +	else if (state->active_preempt_locks != frame->entry_preempt_locks)
>> +		what = "bpf_preempt_disable";
>> +	else if (state->active_irq_id != frame->entry_irq_id)
>> +		what = "bpf_local_irq_save";
>> +	else if (state->active_locks != frame->entry_active_locks)
>> +		what = "bpf_spin_lock";
> [Severity: High]
> Does this code adequately verify lock identity? While it checks the count of
> active locks, it appears to miss checking the identity of the lock
> (active_lock_id and active_lock_ptr).
>
> If a BPF program acquires lock A, passes it to a subprogram which unlocks A,
> locks B, and then throws an exception (bpf_unwind()), could the unwinder
> accept the frame balance since the active_locks count is still 1?
>
> The exception would jump back to the caller's cleanup pad, which assumes
> lock A is still held. The cleanup pad unlocking A could potentially cause a
> double-unlock of lock A and leak lock B forever.

This should be okay once v7, patch 7 fixed. That will be able to
avoid double unlock.

>
>> +	else
>> +		what = NULL;
> [ ... ]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ee074d4a936b5..4bdee3f02fe9d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -19512,6 +19554,10 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   			mark_reg_scratched(env, BPF_REG_0);
>>   			/* An unwind out of this call resumes at the pad. */
>>   			err = push_cleanup_pad_branch(env, env->insn_idx);
> [Severity: Critical]
> Does taking a pre-call snapshot of the verifier state for the cleanup pad
> incorrectly ignore valid memory modifications made by the callee before
> unwinding?
>
> For example, if a caller spills a valid pointer to its stack and passes a
> pointer to this stack slot to a subprogram:
>
> - The verifier schedules the caller's cleanup pad branch by pushing a snapshot
>    of the verifier state (including the stack) taken BEFORE the callee runs.
> - The subprogram overwrites the caller's stack slot with an attacker-controlled
>    scalar and calls bpf_unwind().
> - At runtime, the exception jumps to the cleanup pad, which loads the scalar.
>
> Because the cleanup pad uses the pre-call snapshot, does the verifier
> incorrectly assume the loaded value is still a valid pointer, potentially
> leading to type confusion and memory corruption?

You are right. See comments in patch 7. Will fix.

>
>> +			if (err)
>> +				return err;
>> +			/* Or, with no pad, leaves the frame for good. */
>> +			err = check_unwind_through_call(env, env->insn_idx);
>>   			if (err)
>>   				return err;


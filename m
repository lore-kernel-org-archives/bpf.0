Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C12222D0
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839403; cv=none; b=NB6tl9j0kwFLJ78ssNGWvipjwSZo/IM31sAD0j/L0avWF+EykYShoelPABdcPTd3EnZNyFIlFvbq1QQifAjr1M8aV2RVxgF1i/Ac2Jq5QeMFFqzuUKHL6dCTWJ1z/5CbNawtzzQXxa1hDyq5FrdNiYDdUtDLYyuTSjuQAs+/e4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839403; c=relaxed/simple;
	bh=U38Iw/2vKuoLzTQ/D8ZGvPG1K807Xm6Cb82OUf2zUEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBdyi3G0EXj9jTVw9Bp2hFrmQS9crqqmXKv+NrxL6uH4ErCbCmUKdYXoopqCigfYYeHGDUOGrxyau+tk/uG/OwMYTV93CfKsU8JhfdNPfONrcb4Wk3MxeVa2pup/vbAw6CdbV056XjWR6jVfol/m9gnMnCOLm+Y8UH7grgjdd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aUsUvQzr; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aUsUvQzr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U38Iw/2vKuoLzTQ/D8ZGvPG1K807Xm6Cb82OUf2zUEA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789839398; v=1; x=1790444198;
 b=aUsUvQzrLv1L9H6VbyhZPPBWnJiTQOejFtuNs5/odBceqaPjT7eX01ILGZKv/QM0+YijfsXa
 rHHIs6IutoScscg3etMmGr1b12pcyGMQFvVQHN/JPfrxRWwmAdjX4mH2DSl1uVHyfoherb35ENr
 bYsKxs3OaZli9L4vlqmlDt40=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 240152e082fadb14;
	Sat, 19 Sep 2026 17:36:38 +0000
X-Mizu-Trace-ID: 240152e082fadb14
X-Migadu-Flow: FLOW_OUT
Message-ID: <1387e30f-8793-4c92-b726-22c0ac0f3d2c@linux.dev>
Date: Sat, 19 Sep 2026 10:36:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 08/20] bpf: Walk the exception unwind in the
 verifier
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055726.3930930-1-yonghong.song@linux.dev>
 <DLJ0YT6G4EZK.22FEDYYMKS4E0@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLJ0YT6G4EZK.22FEDYYMKS4E0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 9:57 PM, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9cbdb8339701..a3b34ded1392 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [...]
>
>> +static int unwind_step(struct bpf_verifier_env *env, u32 callsite, int *insn_idx)
>> +{
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +
>> +	state->unwinding = true;
>> +	for (;;) {
>> +		int pad = bpf_cleanup_pad_of_call(env, callsite);
>> +
>> +		if (pad >= 0) {
>> +			unwind_enter_pad(env);
>> +			*insn_idx = pad;
>> +			return INSN_IDX_UPDATED;
>> +		}
>> +		if (!state->curframe)
>> +			return unwind_finish(env);
>> +		callsite = unwind_pop_frame(env);
>> +	}
>> +}
> robot voice:
>
> mark_chain_precision() doesn't know about this edge. The jmp history
> gets (bpf_throw in frame N+k) -> (pad in frame N), or (resume in N+1)
> -> (pad in N), with no BPF_EXIT in between, and backtrack_insn() only
> switches frames on E
> XIT and pseudo calls. So bt->frame stays at N
> while it walks the callee's insns backwards. If the callee wrote its
> own r6 the request for the caller's r6 is cleared there, the caller's
> def of r6 is never marked precise, and a later state with a different
> r6 is pruned at the call site checkpoint even though the pad does
> r10 + r6 with it. If the callee didn't touch r6 the walk reaches the
> static call insn with r6 still set and hits
> verifier_bug("static subprog unexpected regs"). For a throwing global
> subprog it's verifier_bug_if(idx + 1 != subseq_idx) right away.
> The unwind transition needs its own jmp history flag and
> backtrack_insn() has to bt_subprog_enter() once per popped frame,
> like it does for BPF_EXIT.
> Pls add a test that does a variable offset stack access in a pad
> with the offset coming from r6-r9 set before the throwing call.
>
>> +static int process_cleanup_resume(struct bpf_verifier_env *env, int *insn_idx)
>> +{
>> +	struct bpf_verifier_state *state = env->cur_
> state;
>> +
>> +	/* A pad entered by ordinary control flow. */
>> +	if (!state->unwinding) {
>> +		verbose(env,
>> +			"bpf_unwind_resume() at insn %d reached without an exception in flight\n",
>> +			*insn_idx);
>> +		return -EINVAL;
>> +	}
>> +	if (!state->curframe)
>> +		return unwind_finish(env);
>> +	return unwind_step(env, unwind_pop_frame(env), insn_idx);
>> +}
> unwinding is one bit for the whole state, so once a throw happened a
> bpf_unwind_resume() is accepted in any frame, not only in the frame
> whose pad the walker dispatched. The in_pad rule from patch 7 doesn't
> close it: take subprog S that never throws, has its own record, and
> whose pad is just "call bpf_unwind_resume" reachable by a plain branch
> from S's entry. F's pad does "call S" and S branches into its pad.
> Here the verifier pops S, finds no pad for the "call S" site, pops F
> and finishes, so whatever follows "call S" in F's pad is never walked
> in this state. On x86 S's resume is a bare ret, so at run time it
>
>
> returns into F's pad right after "call S" and keeps executing it with
> S's leftover registers. On arm64 br x23 ends F's pad early instead.
> Remember the frame unwind_step() entered the pad in and reject
> bpf_unwind_resume() when curframe doesn't match.

Yes, this is a real issue for backtracking. The problem is stated in
the above curframe doesn't match for frames after unwind_step(), mostly
due to backtracking from landing pad insn to bpf_throw. Will fix.

>
> pw-bot: cr


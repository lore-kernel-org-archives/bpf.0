Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CD3C141A
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541614; cv=none; b=SL03bs/OKXbZmsp4GsET2KMcgan1WbCZ5M290n6fk/PaBxTfcwbeONZLUuhpxuTPxzyAzS6iY1vFDN6yReGTdhjbq+8yk1BDqzk909R1IdIbbuYpnhyDE7RD/vfU9zPJ0UqP/A/9yIhPWmejdsFb6WczG8hTlv/okkvCdna6hXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541614; c=relaxed/simple;
	bh=tG2iAKuk7188K3FTTYTlQgAOoeV7Pc59UvXeE6/6aTI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l7ZTgs5Q8G8Rqbe0ySFlQ6yXk5BKvtXMYzMiRZFelDsSrc3P+0OEtIso5ew3ZhEieKkInXNx7iLloVBq0C/IOT0tT6FDRu8XAB5+dfUEaG0xIV9LEd1mvPPiANh412LJ2cb533AvIoXg2tvtBrRW+5Vhrnaz+OzuddIXQ9TTY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzk9noen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzk9noen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641BC1F00893;
	Sun, 27 Sep 2026 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541613;
	bh=AR48SjPli235EmoBfNxPIUD5s768MO3q++y9ztfQM1Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vzk9noenC2C5EU5WnIO6GD14ZSW+d0wNfOVd8czsxfI/QL4lxTIbWyuPFW/N6RyIc
	 W+Oq6tsT7pw0+8VwgfK1UjIwRuxOI7cn7K+lARdB6cfM/1byCHb1tqrN+IL27ScBYd
	 ni8AMIyddIk9IxmPV4IBhGolESoUPel1ag7IMyIrqqyKLlzJhqA6ZsGgWfwgZQvN5u
	 cUWzNTfCNwLRFY7DrOHE4SDVZR2xsRrnX73Nu5z30OeMlU7IZgcgPyfZ6n1E9PRDFA
	 zqVv6G5LWj8ItDU+HrfjQ0lzda0Bdy+uXxQoqb88OdXmm2++uWDIbL2UMcULhM/f41
	 2f+aCauEXSB6g==
Content-Type: multipart/mixed; boundary="===============3600823588351378068=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e99037a0f0459c6d3e4c30ae417dff917a74f23163785f10598ef953425347da@mail.kernel.org>
In-Reply-To: <20260926050047.2216836-1-yonghong.song@linux.dev>
References: <20260926050047.2216836-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 08/21] bpf: Refuse a landing pad that does not resume
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:40:12 +0000 (UTC)

--===============3600823588351378068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0143688896b0..4174c7d0177e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -339,6 +339,8 @@ struct bpf_func_state {
>  	bool in_async_callback_fn;
>  	bool in_exception_callback_fn;
>  	bool no_stack_arg_load;
> +	/* an unwind reached this frame and its landing pad is running */
> +	bool in_pad;
>  	/* For callback calling functions that limit number of possible
>  	 * callback executions (e.g. bpf_loop) keeps track of current
>  	 * simulated iteration number.

[ ... ]

> @@ -698,6 +700,8 @@ struct bpf_insn_aux_data {
>  	u64 non_stack_access:1; /* instruction can access non-stack memory */
>  	/* true if some jump or call instruction targets this instruction */
>  	u64 jump_target:1;
> +	u64 in_cleanup_pad:1; /* reached with a landing pad running */
> +	u64 outside_cleanup_pad:1; /* ... and the other way round */
>
>  	unsigned int orig_idx; /* original instruction index, initialized once */

Do these two bits grow bpf_insn_aux_data by 8 bytes per instruction?

Before this patch the u64 flag word held 31 bits (nospec through
jump_target), fitting in the low 4 bytes, so orig_idx went at offset +4
inside the flag word. Adding in_cleanup_pad and outside_cleanup_pad makes
it 33 bits. Bit 32 lands in byte 4, so orig_idx moves to offset +8, and
every later member shifts by 4 bytes.

The 4-byte tail padding was already used up by cleanup_pad from 97f5b1e363fd.
The struct therefore rounds up by another 4 bytes, for +8 in total. Measured
from the start of the flag word, the tail goes from 64 bytes to 68, padded to
72.

da01eb889d50 (Suggested-by Eduard Zingerman) was written to cut this struct
from 136 bytes to 128. On those figures this patch takes it back to 136. The
array is allocated for every load as __vmalloc(array_size(sizeof(struct
bpf_insn_aux_data), len), ...), and bpf_patch_insn_data() memmoves and
reallocates it on every patch.

The two marks are only read and written by bpf_exc_check_insn(), which runs
only when env->cleanup_info_cnt is non-zero. So programs that never use
exception tables pay the cost.

The cleanup_pad_head bit added later in the series makes the word 34 bits and
does not change this. No later commit in the series restores the size.

Two possible fixes: narrow alu_state, whose flags BPF_ALU_SANITIZE_SRC
through BPF_ALU_IMMEDIATE occupy only bits 0-4, so the word stays within 32
bits; or keep the pad-membership marks in a side array allocated only when a
cleanup table is present.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 1ed0370a171b..86fdf847d33e 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -12,6 +12,15 @@
>  BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>  BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
>
> +int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog)
> +{
> +	if (!env->subprog_info[subprog].might_unwind)
> +		return 0;
> +
> +	verbose(env, "subprog %d may unwind and is used as a callback\n", subprog);
> +	return -EINVAL;
> +}
> +
>  static void mark_call_sites(struct bpf_verifier_env *env)
>  {
>  	u32 i, j;

[ ... ]

> @@ -69,6 +78,78 @@ bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
>  	       insn->imm == bpf_unwind_resume_id[0];
>  }
>
> +/* Is an unwind in flight: is this frame a landing pad, or below one? */
> +static bool unwinding(const struct bpf_verifier_state *state)
> +{
> +	u32 i;
> +
> +	for (i = 0; i <= state->curframe; i++)
> +		if (state->frame[i]->in_pad)
> +			return true;
> +	return false;
> +}
> +
> +int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
> +{
> +	bool in_pad = cur_func(env)->in_pad;
> +	struct bpf_insn_aux_data *aux;
> +	u32 i = env->insn_idx;
> +	const char *why = NULL;
> +
> +	if (unwinding(env->cur_state)) {
> +		if (bpf_is_unwind_kfunc(insn)) {
> +			verbose(env, "insn %u starts a second unwind while one is in flight\n", i);
> +			return -EINVAL;
> +		}
> +		if (bpf_pseudo_call(insn)) {
> +			int subprog = bpf_find_subprog(env, i + insn->imm + 1);
> +
> +			if (subprog >= 0 && bpf_subprog_is_global(env, subprog) &&
> +			    env->subprog_info[subprog].might_unwind) {
> +				verbose(env,
> +					"insn %u calls global subprog %d, which can unwind while an unwind is in flight\n",
> +					i, subprog);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	aux = &env->insn_aux_data[i];
> +
> +	if (in_pad ? aux->outside_cleanup_pad : aux->in_cleanup_pad) {
> +		verbose(env, "insn %u runs both inside and outside a landing pad\n", i);
> +		return -EINVAL;
> +	}
> +	if (in_pad)
> +		aux->in_cleanup_pad = true;
> +	else
> +		aux->outside_cleanup_pad = true;
> +
> +	if (!in_pad)
> +		return 0;
> +
> +	if (insn->code == (BPF_JMP | BPF_EXIT)) {
> +		verbose(env,
> +			"exit at insn %u ends a landing pad: a catch pad is not supported yet, only cleanup pads that resume\n",
> +			i);
> +		return -EOPNOTSUPP;
> +	}
> +	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_tail_call)
> +		why = "is a tail call, which replaces the frame";
> +	else if (BPF_CLASS(insn->code) == BPF_LD &&
> +		 (BPF_MODE(insn->code) == BPF_ABS || BPF_MODE(insn->code) == BPF_IND))
> +		why = "is a BPF_LD_[ABS|IND], which can leave through the epilogue";
> +	else if (insn->code == (BPF_JMP | BPF_JA | BPF_X) ||
> +		 insn->code == (BPF_JMP32 | BPF_JA | BPF_X))
> +		why = "is an indirect jump";
> +
> +	if (!why)
> +		return 0;
> +
> +	verbose(env, "insn %u %s, and is in a landing pad\n", i, why);
> +	return -EINVAL;
> +}
> +

The commit message states "bpf_unwind() and the branch pushed at a covered
call are the only ways into a pad, and both mark the frame they enter." Does
bpf_exc_check_insn() also verify callx (indirect calls)?

mark_call_sites() only sets aux->cleanup_pad for bpf_pseudo_call() and
bpf_unwind(), not for bpf_is_callx():

kernel/bpf/exception.c:mark_call_sites() {
	...
	if (!bpf_pseudo_call(insn) && !bpf_is_unwind_kfunc(insn))
		continue;
	env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
}

So bpf_exc_pad_of_call() returns -1 for a callx inside the covered range, and
push_cleanup_pad_branch() in do_check_insn() returns 0 without pushing a pad
state. The CFG and liveness successors add no pad edge for it either.

The verifier walks the callx into its static callee through
check_static_func_call(). If the callee's bpf_unwind() is not covered in the
callee, process_bpf_unwind() returns PROCESS_BPF_EXIT and the path ends
there. The caller frame is never continued, and the pad is never explored from
the state at the callx.

But at run time the unwind does reach that pad. bpf_unwind_rewrite() matches
each frame's return address with bpf_exc_pad_for_ip(), which is a pure ip
range check (begin < ip <= end) over ranges that bpf_exc_fill_native_ranges()
builds. There is no filter on call type. The callee's return address sits
inside the covered range, so it is rewritten to rec->pad. The callee's
epilogue then restores the caller's r6-r9 and stack as they were at the
callx.

Example: a covered range holds call sub_a (pseudo call) with r6 = a valid
pointer, then r6 = scalar; r2 = sub_b ll; callx r2. The pad dereferences or
stores through r6 and then calls bpf_unwind_resume(). sub_b calls
bpf_unwind() unconditionally. The pad is verified only with the state pushed
at call sub_a, where r6 is a pointer. At run time sub_b's unwind resumes the
pad with r6 holding the scalar, which gives an arbitrary kernel memory access
from a program the verifier accepted.

The same entry also gets around what this patch sets out to refuse. A pad
reached only by normal flow and by the callx is verified with in_pad false, so
it can end in exit (a catch pad), use a tail call or LD_ABS, and pass the
"both inside and outside" check, because no in-pad state ever reaches it.

No later commit in the series marks, refuses or filters callx.
mark_call_sites(), push_cleanup_pad_branch() and bpf_exc_pad_for_ip() are
unchanged in this respect, and neither the x86 nor the arm64 dispatch patch
handles callx.

Possible fixes: mark bpf_is_callx() sites in mark_call_sites(), so
push_cleanup_pad_branch() and the CFG treat them like pseudo calls.
Alternatively, refuse a callx inside a covered range when the cleanup table is
checked.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============3600823588351378068==--

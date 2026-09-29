Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742E18C332
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642200; cv=none; b=ihaYf0g1VdFE50QeRSt5xllAVqec8jaAk7Ul2LD39ePF2hTUxT7vajgWg4Swt23uKglf0jLwqELM+23uyp63Vr6Cy4Xj1jQpyH6nAyIWjxeYT6DnFpIbbOZj2Xmk/WS75InS+K2lAZ4vYPzzB1c7sm++q/Kgh/OFJurPpp9QY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642200; c=relaxed/simple;
	bh=Yugi+axIXSSbushcqE4Zfyb3l3WI8SBPEsaUdprg5mU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhB7hxnpS0Rp84E6tqqFzum8dJN8N/zzxrtfv0EKbORKTovjUjAAy+2lFblEdrDt3Izxoa1kXZ+Kt0LB3kU1apLVCs/HfOtw35I1apijWkGvC9Pv4eIFgeclXfR3JOjyNzkUSNV1/tmYbsnscu5U8l16vr5JCO8GLASaIZEcNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwcDHYmb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwcDHYmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1181F000FF;
	Tue, 29 Sep 2026 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642198;
	bh=spIAtcrw3c60m39m1UmwkqLdzGa1+guh9Mt2yz2Yg5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwcDHYmb4EuQFWgjMHWi4iTNOuMX19cP12wB8XjY39vBBQLwjRdcltxnyGdXr1SRY
	 UVSs+RRbLjDskiAvwIhPKkgyYPKuzvgNopOiBPM0sqymjbuBExgc42lPueKZUcckXD
	 CsWKvRQM1kHROQiGXfRqC91U2ieW1Hm7csiob+XUHKSXBQcF6J/IBBufOrX0ckp9qd
	 RBNnVog1d3SgurCPokCwfBGx0L6qv3xuoP7fe0CTw3bsMTcbkBhwKv/rF8kylRhkOm
	 HJR7dTXTN7P/cimhiX6t6qmutmTiO39kv6ZRS3xgcVoYvzBr7iJjFT49rOmX4oJimP
	 JTvmH48AW4u0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 08/22] bpf: Require an unwind to leave a
 frame holding what it entered with
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929001643.3249386-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001643.3249386-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 00:36:38 +0000
Message-Id: <20260929003638.8A1181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: type confusion and memory corruption due to stale cleanup=
 pad state
- [High] bpf: lock corruption and double-unlock via missing identity check =
on unwind
--

commit 585aa50d9e8811792b9a816a4d1ad6cd51d63ea7
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Require an unwind to leave a frame holding what it entered wi=
th

This commit updates the BPF verifier to record what locks and references
a program holds when a frame is entered. It enforces that an unwind must
leave the frame holding what it entered with, ensuring that landing pads
verified against pre-call snapshots remain valid.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0143688896b0e..75e572a8a1bab 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -339,6 +339,18 @@ struct bpf_func_state {
>  	bool in_async_callback_fn;
>  	bool in_exception_callback_fn;
>  	bool no_stack_arg_load;
> +	/*
> +	 * What the program held when this frame was entered. An unwind leaves
> +	 * the frame without running anything below it, so the frame has to put
> +	 * these back to what it found before it goes -- otherwise a caller's
> +	 * landing pad, whose state was taken at the call, is wrong about them.
> +	 */
> +	u32 entry_active_locks;
> +	u32 entry_preempt_locks;
> +	u32 entry_rcu_locks;
> +	u32 entry_irq_id;
> +	u32 entry_id_gen;
> +	u32 entry_acquired_refs;

[Severity: High]
Does this structure need fields to record the identity of the lock held upon
frame entry? Without this, it might be difficult to accurately enforce the
correct lock state on unwind.

Additionally, is it necessary to update func_states_equal() to compare these
new entry_* fields? Without comparing them, could the verifier unsafely pru=
ne
states with different entry locking conditions?

[ ... ]
> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index c1779d2d02f05..c0b0b8478af51 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -12,6 +12,72 @@
>  BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>  BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
> =20
> +void bpf_exc_record_frame_entry(const struct bpf_verifier_state *state,
> +				struct bpf_func_state *frame, u32 id_gen)
> +{
[ ... ]
> +int bpf_exc_check_frame_balance(struct bpf_verifier_env *env, const char=
 *prefix)
> +{
> +	const struct bpf_verifier_state *state =3D env->cur_state;
> +	const struct bpf_func_state *frame =3D cur_func(env);
> +	u32 i, held;
> +	const char *what;
> +
> +	if (state->active_rcu_locks !=3D frame->entry_rcu_locks)
> +		what =3D "bpf_rcu_read_lock";
> +	else if (state->active_preempt_locks !=3D frame->entry_preempt_locks)
> +		what =3D "bpf_preempt_disable";
> +	else if (state->active_irq_id !=3D frame->entry_irq_id)
> +		what =3D "bpf_local_irq_save";
> +	else if (state->active_locks !=3D frame->entry_active_locks)
> +		what =3D "bpf_spin_lock";

[Severity: High]
Does this code adequately verify lock identity? While it checks the count of
active locks, it appears to miss checking the identity of the lock
(active_lock_id and active_lock_ptr).

If a BPF program acquires lock A, passes it to a subprogram which unlocks A,
locks B, and then throws an exception (bpf_unwind()), could the unwinder
accept the frame balance since the active_locks count is still 1?

The exception would jump back to the caller's cleanup pad, which assumes
lock A is still held. The cleanup pad unlocking A could potentially cause a
double-unlock of lock A and leak lock B forever.

> +	else
> +		what =3D NULL;

[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ee074d4a936b5..4bdee3f02fe9d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -19512,6 +19554,10 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>  			mark_reg_scratched(env, BPF_REG_0);
>  			/* An unwind out of this call resumes at the pad. */
>  			err =3D push_cleanup_pad_branch(env, env->insn_idx);

[Severity: Critical]
Does taking a pre-call snapshot of the verifier state for the cleanup pad
incorrectly ignore valid memory modifications made by the callee before
unwinding?

For example, if a caller spills a valid pointer to its stack and passes a
pointer to this stack slot to a subprogram:

- The verifier schedules the caller's cleanup pad branch by pushing a snaps=
hot
  of the verifier state (including the stack) taken BEFORE the callee runs.
- The subprogram overwrites the caller's stack slot with an attacker-contro=
lled
  scalar and calls bpf_unwind().
- At runtime, the exception jumps to the cleanup pad, which loads the scala=
r.

Because the cleanup pad uses the pre-call snapshot, does the verifier
incorrectly assume the loaded value is still a valid pointer, potentially
leading to type confusion and memory corruption?

> +			if (err)
> +				return err;
> +			/* Or, with no pad, leaves the frame for good. */
> +			err =3D check_unwind_through_call(env, env->insn_idx);
>  			if (err)
>  				return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929001601.3242=
665-1-yonghong.song@linux.dev?part=3D8

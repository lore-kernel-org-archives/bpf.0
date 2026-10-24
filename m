Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792801639;
	b=ZG3qIw1Hm9yXm5BIpgbuBUQh6b4DU+/eQ5sLRVQ6TGdUJS4mhYCaPEhOoS+ximgytZUK
	 35J6DD7BnA3Uh/8+S0nc3sDzP0+Z7yDBn5L5wQTZwtIxgNtJn+gUqiMKyC09NHe+I+jkI
	 ONmanbFudJH0q3RAs1f25QPwUGchO2sa79fzAYuNkuy2IK2S7/SAkK14LerKY9tBS0SyV
	 c6QTVBadOij1zBlQrE6Uu50JspAN51Z2AZ/gea9r8E11fGIfQKJyhaU4sXHhPZylxITWy
	 GEKPMkk+gLOXdlIylpwzcLNy7VFXKkLrkUL6EcMTXLGMtAll6zPO079xLYwyMz9D45g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6SG3wx8m3rJE08LeUxdFVqARqL8l7bSJBZIDCVAPEns=;
	b=gKlxKhLzhOknROBAnjYQefsw6xEeJFZMXkZ1JeoexLfYLr9+WUQTsNowuWzIk9rthgH2
	 qPjdU6jF0nNk7VPgIqEAferS2tX2vV/mhSDsIHfS4jq8yA0tdgioqwsE5bWn3hZplxm5a
	 bNAOxtCmSefyBvZkVd7+Te2m2B6yzkNfQmKEOofRRQZQuDhkT0tvNwJbzbdu2QrcsIaAk
	 cydqS0tNkqsfVMAszzm1IHy3PTQTMYEXTwF8MwOiawjAPyziOROSzdc2ydxCK59lDJXon
	 T+H0VMhBWCo5cbglStXHUk5Lb56bF3eFIehUR0R528z9PSJe93NFBA9R5zExikFqqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3eWaD+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126C606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3eWaD+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7659D1F01825;
	Sat, 24 Oct 2026 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792801638;
	bh=6SG3wx8m3rJE08LeUxdFVqARqL8l7bSJBZIDCVAPEns=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=j3eWaD+9vzKicEViua/d0wAlmy2JRQfP97norW3rkqZ4HM2COjRp0KyawN2uj9gl8
	 /RW42+R+Y7mWVF3BeUT8TfoiJK1DMaBOEPz5vAfFhMC0hdvS8qV0CrWrmlPGLpxi2h
	 dAlJHLh4wu4XSrtI24DHqp1ytHo4rAhskXviQi8yZCuUnoHYHK8b5EAKSbOf0k4Cx5
	 buyCpLkSK0I2H4dQmViQRbt0eRchGSBT7XVN9H6G/WtNwT7MixKgVoPqSFtxsCEqRP
	 0JMnHqoo7YX4WrNxZT8wMksIMFwNo7ztJLd8pbDFDUKxl3av96mCzV86zUDXgUjhhT
	 5Gxd02Mt75QoQ==
Message-ID: <sashiko-outbox-183459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 03/11] bpf: look for current loop in upper
 frames in states_equal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261023-scev-simpler-clamp-v1-3-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
 <20261023-scev-simpler-clamp-v1-3-d43a07eda7af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 00:27:18 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: current_loop() ignores outer loops when inner loop is re-en=
tered
--

commit 999e70b9b80c780cef9257c5cc41cf3820aa644f
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: look for current loop in upper frames in states_equal()

This commit updates current_loop() to search upper call frames for an active
loop entry when checking if the current loop exploration terminates in
bpf_is_state_visited(). This allows checkpoints inside callees invoked from=
 a
bounded loop to be pruned and to skip false-positive infinite loop checks.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index d7df6632a5c47..306ad208a8e41 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1361,10 +1361,14 @@ static bool need_loop_checkpoint(struct bpf_verif=
ier_env *env, int insn_idx)
>  static struct loop_stack_entry *current_loop(struct bpf_verifier_state *=
st)
>  {
>  	struct bpf_func_state *frame =3D st->frame[st->curframe];
> +	int fr;
> =20
> -	if (frame->loop_stack_cnt =3D=3D 0)
> -		return NULL;
> -	return &frame->loop_stack[frame->loop_stack_cnt - 1];
> +	for (fr =3D st->curframe; fr >=3D 0; fr--) {
> +		frame =3D st->frame[fr];
> +		if (frame->loop_stack_cnt)
> +			return &frame->loop_stack[frame->loop_stack_cnt - 1];
> +	}

[Severity: Medium]
What happens if a terminating outer loop enters a terminating inner loop
(either in a callee or nested in the same function) on a subsequent outer
iteration without having been pruned at the outer loop header?

On each fresh entry into the inner loop, handle_loop_entry_exit() allocates=
 a
new entry_state via bpf_split_cur_state():

kernel/bpf/verifier.c:handle_loop_entry_exit() {
	...
	/* Create a loop_entry checkpoint before widening */
	err =3D bpf_split_cur_state(env);
	if (err)
		return err;

	entry->min_header_count =3D iters.min_header_count;
	entry->max_header_count =3D iters.max_header_count;
	entry->entry_state =3D cur->parent;
	entry->terminates =3D true;
	...
}

When the outer loop takes its backedge into a second iteration (for example,
when a 32-bit stack spill becomes STACK_MISC during iteration 1 so the outer
header does not immediately prune) and re-enters the inner loop, the inner
loop receives a distinct entry_state from the one recorded in the first out=
er
iteration's checkpoint.

Because current_loop() unconditionally returns the innermost active loop en=
try,
bpf_is_state_visited() only compares the inner loop's entry_state pointers:

kernel/bpf/states.c:bpf_is_state_visited() {
	...
	old_loop =3D current_loop(&sl->state);
	cur_loop =3D current_loop(cur);
	if (old_loop && cur_loop &&
	    old_loop->terminates && cur_loop->terminates &&
	    old_loop->entry_state =3D=3D cur_loop->entry_state) {
		if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
			loop =3D true;
			goto hit;
		}
		goto skip_inf_loop_check;
	}
	...
}

Since old_loop->entry_state !=3D cur_loop->entry_state for the re-entered i=
nner
loop, this check fails without noticing that an enclosing terminating loop =
in
the same or upper frame still has a matching entry_state.

Execution then falls through to the infinite loop check, where
loop_stack_safe() does not compare entry_state:

kernel/bpf/states.c:loop_stack_safe() {
	...
	for (i =3D 0; i < old->loop_stack_cnt; i++) {
		if (old_stack[i].loop_id =3D=3D cur_stack[i].loop_id &&
		    old_stack[i].max_header_count =3D=3D cur_stack[i].max_header_count &&
		    old_stack[i].terminates =3D=3D cur_stack[i].terminates)
			continue;
		return false;
	}
	...
}

Won't states_maybe_looping() and states_equal(env, &sl->state, cur, EXACT)
then match the inner loop checkpoint from the previous outer iteration and
falsely reject the program with an infinite loop error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-scev-simpl=
er-clamp-v1-0-d43a07eda7af@gmail.com?part=3D3

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939921;
	b=fWs/+ygYaweT3YnztByfaB4iKNmaHc5lQM12Ok7TI1T7iT8iYLb51CqbytOdqqZ/Pvcs
	 0JfqKCIZ37+M7T7ev0bU5T7Ze093GPdY635JI8s7XGwKwNPcUijWrwnHlcaMNMRbWazeU
	 CTItRKKstDLNj2UB1MZNFCzVWD+PvOa51hWVoy8Z3e7cxT7uPZzaoxrhqYz9OJAFBUuDC
	 b/VZHhxkJPnAjQuX0LhEtiH/Daviqydj0MrZaXroWeahMh77cDp/aUJ8R9MI6wJ7ji3zY
	 u17uIcqf42c4OlY0vLkd9UxGQQnwDe459eWLYP0D1UxI/WWLMkbr+7AEVDOzfSqahcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939921;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lTAJlXZNBTQLfNwL2wPAlWC+ZIVRv1KpxuJyI/RNDJI=;
	b=tywXP2bQE4Sf63MSLENotYOkxnY/PCEDghcYvNCGQamBpsvA5Im/Z3XO/E55GYysSw6V
	 5DpF0K7CoCvh1JPK0dsKS+6ATuXmvfTk/O1FdanlQI56DNcSyYRTPp8wIh2qayXAOoDXz
	 9pt+ZsPq5FLT5cxS5doau8hhV8b9vdVxvIhp7SQ12/WewZ9SVo8ylyJeUy6km7ol3OdVA
	 TSYLRYeGETe0AtPm4BbjFDqUOINvjNMx5hv83mzaBVGlpVDSoWlLbOH9p5vMzHHU1GNu8
	 7RpBcLuHWcRaSgjQ77asl+bVvdm7UhFsxqx3s0aIMImXTX439uzBg0Uu7rdvqqZAbQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIqHzTgL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96D606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIqHzTgL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA751F0089F;
	Fri,  6 Nov 2026 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939920;
	bh=lTAJlXZNBTQLfNwL2wPAlWC+ZIVRv1KpxuJyI/RNDJI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DIqHzTgLQzvFWNrNe7OcG3IDpNt/oiXuRP+zEg2xzFfWjPnnJguKuObWThoZAtcdZ
	 uQfDRm2eA/VED3YnATgjmHurY2woFmEFVJ9CbXmkTuReyDCbcbADg2j9HFRdKjkKpq
	 XBkDyXXRWYv7g846nHOX25UMd4+eifftgB+IqP4KGvLo6Yyhd83kGYOz42iD+xO7s6
	 NEI9P0QZ/XzQ7Cigu85KCLrtpEtP0IvecgSM5Dlun3QnhyX7U9su26BjhAyKamCWjG
	 1/faXWMkj3k/giKFHqV6TULCJuf/cDVwYyY20BXB32aE/Ew/Om7+MNB062wTpgf6db
	 iKptMX9yJ5TEg==
Content-Type: multipart/mixed; boundary="===============1233823264114106379=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c3e4141f7257c7d61c550f3223dbbbbfa80d49d9b9d9dbf11a80304234f747a6@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-18-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-18-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 17/45] bpf: Enter and leave loops in the main pass, build flow.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:40 +0000 (UTC)

--===============1233823264114106379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Enter and leave loops in the main pass, build flow.c

TL;DR: The allow_uninit_stack (CAP_PERFMON) gate in flow_try_walk() may skip
loop walking for CAP_BPF-only loaders, so their loops always get may_goto
(possible early stop at run time) or are rejected; commit message doesn't say.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int flow_try_walk(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
> +{
> +	struct bpf_loop *loop = env->insn_aux_data[entry->loop_id].loop;
> +	u64 factor = flow_walk_factor(env->cur_state);
> +	u32 patience, *walk_insns;
> +
> +	patience = env->allow_uninit_stack && !loop->rt_bounded &&
> +		   (!loop->has_calls || loop->has_guards) ? BPF_FLOW_MAX_TRY : 0;

Is the env->allow_uninit_stack term intended here?  That flag is
bpf_allow_uninit_stack(token), i.e. CAP_PERFMON, and has nothing to do
with loops.  bpf_compute_loop_iters() already returns 0 early when
!env->allow_uninit_stack, so a loader with CAP_BPF but without CAP_PERFMON
gets neither the count nor the walk from bpf_flow_loop_enter().

For every loop that is not rt_bounded, that loader ends up in:

	err = flow_try_walk(env, entry);      /* patience == 0 -> returns 0 */
	...
	if (!loop->rt_bounded) {
		bpf_flow_loop_gets_guards(env, env->insn_idx);
		entry->guarded = true;
	}

and the state is then widened in flow_merge() (FLOW_CYCLE).

Before this series such loaders had bounded loops checked by visiting each
iteration in is_state_visited(), which 6228cec8147e removes.  Once
58e4d8b43844 wires bpf_flow_loop_enter() into do_check(), a CAP_BPF-only
program (a socket filter, or tc/XDP with CAP_BPF+CAP_NET_ADMIN, or a token
that does not delegate CAP_PERFMON) would see two changes:

- Every such loop gets a may_goto, even one that a walk would show to end.
  The comment of bpf_flow_loop_gets_guards() says the may_goto can be out
  of budget in the first trip, so the loop can stop early at run time
  where it did not before.

- A loop that needs the per-iteration constant is rejected.  The
  netif_receive_skb example in the commit message is one: "After a join i
  is unknown: math between map_value pointer and register with unbounded
  ..".  A loop with no place for a may_goto is rejected with "loop at insn
  N never exits".

None of the later commits up to b3ce1aebb13f remove the gate.

Could the commit message say that loops of loaders without CAP_PERFMON now
always get may_goto, if this is intended?

> +	if (loop->walk_failed)
> +		patience = 0;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============1233823264114106379==--

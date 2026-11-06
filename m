Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939091;
	b=JdVtyFRs0sTn4OgXDVld8mTr/C9c4BZbtIbMVRM+qjJcw+5O++6edWdLoEv6ITkV4BsU
	 6iwg8ocm7fWIka27NhiOFxLLYAv1sh+8qffCjREmdZuaJ4RkyGSzBwGa1/MCJiPgqkmSU
	 /KiT43r7fOElunNkvwVUJ46OiVJjZFLToN9W3EgMiLwJtW3BAOlpOSh4Aurh7c2OaTb7z
	 OD9EyV7E4T6KUsMxRrQYQVjF+J/V4SoC1PbCZZwwWdSaaLESeAY9ru5mF2q5gkqKmRd/5
	 tx3v+ziA1jDvVNvbnPYA6syjsqUBNZadNlDnw6OylLhN/3nuzg/E83+p5HEzhcmBbIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939091;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YFdBu6J9UXyqxeHFHX6P0OKPs4Y1BHcyeawN4JCMGrU=;
	b=j/Z2BucUQjp+jZwn5ACRpyHsjFJXd1URCdQfoenVPRL14I8A2knH3JR6kyEQXES36EQX
	 Tcu/K/SZ/P1rsSwSrxgKp5uqNKZvwb/qVcFjLHagQgGfAPQCVi4FWTbHAi6W8JazrS4OH
	 /tLjcTGpKDqoDJNjC3zDNohofcfCSlvUSjZ65OXwY9HpuKLBpZ9WX4NsWMGBWstQZArf2
	 m3UgUjbrZPeuAue+LPUNhaCKuZXEAwl1OpYgM/5L2NPcFgDa4UHRJzreAbs7JBPLBzqJF
	 1D5R2r/Ixp2BtgExY9gZhc/jIbEJx9ccWog3pRMoGrZR3YXLfw5Em3MAcHsIjJ9BuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFCM4ZWc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76EF606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFCM4ZWc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F44B1F0089F;
	Fri,  6 Nov 2026 04:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939090;
	bh=YFdBu6J9UXyqxeHFHX6P0OKPs4Y1BHcyeawN4JCMGrU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hFCM4ZWcohZrW5FcDZtNaLJT3fIpHxbe1H1SMf+OJvsHbCGDcHEG/kCMeXtsPGHah
	 XMKopxzazRDhDNoR4USLdu9reAQJGBY2ZlMgRNtMMGuk8+Rx5Rjn1tONvlwMKx5rd9
	 EBEuMz59cSkeKNZolUvtUNUDuqMH36iEl94d+6YsBOUEiphl22g6NYRPD5P08WuiYE
	 qGCJ+8Zn5YRuraI82u2HRJlduZIrJdxTOuZsXawPi8mhMZPoNNA7Lo2lOEeI/FJ8+f
	 5gbl2iA/d5ucXa0Ask5+wiJI9cNdZCG14jWChoub9y9eJhBOXKX+o7FjIULqqApSWb
	 dthmQ4g7Ejrnw==
Content-Type: multipart/mixed; boundary="===============1109924140750832451=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f8bb7186e19cc1828d4873631823e81deb432abae859d867136959ce3fa9330b@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-15-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 14/45] bpf: Merge the state that arrives into the set at an insn
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:50 +0000 (UTC)

--===============1109924140750832451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Merge the state that arrives into the set at an insn

TL;DR:
- flow_merge() may widen away a register set only in the loop body, so the
  verifier could reject valid programs; the fix is later in the series
- commit message omits that states are also dropped by trip sweeping

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +		if (!widen && flow_cmp_pkt_range(s, t))
> +			continue;
> +		if (!widen && flow_has_room(env, *nr_states) &&
> +		    (flow_unset_differs(&t->st, &s->st) ||
> +		     flow_join_makes_up(flow, &t->st, &s->st)))
> +			continue;

When a state comes back to a loop head (cycle == FLOW_CYCLE), widen_all is
true, so this check is skipped and flow_unset_differs() never runs.  Can a
state where a live register is NOT_INIT then be widened with one where the
register is set?

bpf_states_join() -> join_reg() makes the result NOT_INIT whenever either
side is NOT_INIT:

  if (ra->type == NOT_INIT || rb->type == NOT_INIT) {
          if (pass == 2 && ra->type != NOT_INIT)
                  *dst = *rb;
          return true;
  }

So the joined state at the loop head loses a register that only the loop
body sets, and a later read of it fails.  For example:

  bpf_for(i, 0, 64) {
          if (v[i] != want)
                  continue;
          last = bpf_get_prandom_u32();
          found = true;
  }
  if (found)
          bpf_printk("%llu", last);

The state that enters has found = 0 and no 'last'.  The state that comes
around has found = 1 and 'last'.  They are widened into found = [0,1] with
'last' NOT_INIT, and the load fails with "R7 !read_ok".  The old verifier
accepted this program.  Outside a loop, flow_unset_differs() keeps such
states apart while flow_has_room() is true, but at a loop head it is not
consulted.

The path is bpf_flow_deliver() -> flow_add() -> flow_merge(env,
&flow->states[insn_idx], &s, backedge ? FLOW_CYCLE : cycle).  flow.c is not
built at this commit, and the path becomes reachable in 58e4d8b43844 ("bpf:
Verify programs as a fixpoint over the control flow graph").

This is fixed later in the series by 37b41439b09a ("bpf: Don't widen away a
register that only the loop sets"), which changes the condition to:

  if (flow_has_room(env, *nr_states) &&
      (flow_unset_differs(&t->st, &s->st) ||
       (!widen && flow_join_makes_up(flow, &t->st, &s->st))))
          continue;

Should that change be folded into this commit, so that no commit in the
series rejects such programs?

Regarding the commit message:

>     A state is dropped only if a state of the set covers it. Thus the verified
>     states cover each execution of the prog.

The commit message says a state is dropped only if a state of the set covers
it.  flow_merge() also drops states through flow_sweep_trips() ->
flow_sweep_trip(), and no state covers those:

  static void flow_sweep_trip(struct bpf_verifier_env *env, struct flow_state *t,
                              const struct flow_state *s)
  {
          if (t->pending || !flow_earlier_trip(&t->st, &s->st))
                  return;
          flow_unlink(env, t);
          flow_free_state(env, t);
  }

This removes states of earlier iterations of a loop whose iterations are kept
apart.  The coverage argument still holds, because only states that are no
longer pending are swept, so their successors were already explored.  But the
changelog does not mention this second way to drop a state, or the
not-pending condition that makes it safe.  Could the changelog mention it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============1109924140750832451==--

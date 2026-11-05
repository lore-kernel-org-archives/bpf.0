Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914521;
	b=qslmHDtMj4H3gDZF58PnRuWAJk0Te5Y0eiujc4zSVUT1/5OJVgS16h1mn1bHL34Zd1Sf
	 sYMTTiVt396kOeBWWPFm6Xml6TdEcYxk5YPtGOps4PfItL8zdJPWDoVjmBCrhiUvviRY9
	 I/TH9Gbddo7+qRYrjVPpg/+lnoIRoCS110gryRxbE1NLw84W6f4k7eHvm94KtsQuCD/RH
	 SJQ9vUjVALQWv9A0OcWCg+AyCl77z7gLhABJmsem4O1Xd7GiU2aoJUwGoLOkb+bGwwS7l
	 JDqRq5xjyDpHkE8Bff6ke/x9dUJLwobTH+rqp3cZUQTLF7ImceLlQuX4ZDB90Z+3dNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914521;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=yK1r3VhxLgsb4Q+B+bvKVZGIxWJTTuMJpLavEV7P0Ps=;
	b=X+c690qJv67BprNYdsMbG8rRaJbFPIrDb0CD6Mb/nazLU7ZtQGLw2XVRUQepiw3KiJ28
	 ptsFjC/M3ERjIy7zGuFowX4qGOjyyKMq8WWecE1+bpUmFwSeCgQRuIrEE8aiswSkAHQuo
	 ggkNSmxQ6w6IrCqYGsYGyhPZ0dmd62o/VDyNN8g30o/uwhzNgktpvBc11q7+mAE5xpMek
	 XAes8c/MY1FEKo+SZDx+zgY1eB9pQ2OXMZ66NwrpyDbwsqRUCxAleQo4jwklS9EHqNl/k
	 QNMIn4Vx/0ZSqr52m6ogMXapgq1kuwZXHjTLySBcBNlULsMaKBHbFgX/k8fepXuMVjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDNlVI8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81607606D806
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDNlVI8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8271F0089F;
	Thu,  5 Nov 2026 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914521;
	bh=yK1r3VhxLgsb4Q+B+bvKVZGIxWJTTuMJpLavEV7P0Ps=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NDNlVI8ibbbNrTNzS4zJwSQJ8cjW9wdq1eiQSDzzb4i/D6c8oWS+lLtyD74+0sr9Y
	 uM7XW+E1NBSrclbQMYXnqyyIOCwn4UDAyvMzmqBhQ/5uYdhfItFjqOcpSTBXaoSfxx
	 yVxLXPLrYejHaTGKubDOZIZwT5foiwvHZBoZZrQUB7mVGeWZLUyxKOYTaXF9FCjH9K
	 SDsygrUK7eEyr0Tz5eodbsp908vrwb7MUQ6YlakCpU6N/azHmKhkrAyGwmkaQ+I4TD
	 OFWxp4Hj/wXcdWmoIdNtq0va/3IN1Q8Q85OL6sCnpDUUwl4jfwYzauwUHodvyXNut7
	 GqfIdLZwDXZXQ==
Content-Type: multipart/mixed; boundary="===============7457293908775248651=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ee77c73bff0b56a40098080a5335d5fd5e4d8592ac15afe769c1c4661f026576@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-5-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/35] bpf: Add join of registers and stack slots
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:20 +0000 (UTC)

--===============7457293908775248651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add join of registers and stack slots

TL;DR: In join_reg() with explore_alu_limits, dropping an unmatched ADD_CONST
link zeroes dst->delta, so the join may fail the subsumption check and make a
previously loadable program fail to load (-EFAULT, verifier_bug warning).

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> --- /dev/null
> +++ b/kernel/bpf/join.c

[ ... ]

> +static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
> +		     const struct bpf_reg_state *ra, const struct bpf_reg_state *rb, int pass)
> +{

[ ... ]

> +	switch (base_type(ra->type)) {
> +	case SCALAR_VALUE:
> +		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
> +			return false;
> +		if (pass == 1) {
> +			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
> +			return true;
> +		}
> +		join_range(js, dst, ra, rb);
> +		/* a link that exists on one side only is dropped */
> +		if (ra->id && !jid_good(js, ra->id, rb->id)) {
> +			dst->id = 0;
> +			dst->delta = 0;
> +		}
> +		return true;

With explore_alu_limits set, can this build a join that bpf_state_subsumes()
then rejects?

In that mode regsafe() compares scalars bytewise up to 'id':

    if (env->explore_alu_limits) {
            return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
                   check_scalar_ids(rold->id, rcur->id, idmap);

'delta' sits before 'id' in struct bpf_reg_state, so it is inside the
compared range.  join_reg() only allows the join when reg_value_equal(ra, rb)
holds, so ra->delta == rb->delta.  But when the id pair is not good, the
code does 'dst->delta = 0'.

If ra->id has BPF_ADD_CONST, ra->delta is non-zero (adjust_reg_min_max_vals()
sets 'dst_reg->delta = off'), so dst->delta then differs from both inputs.
join_check() -> bpf_state_subsumes() -> regsafe(dst, a) fails the memcmp, and
join_check() reports:

    verifier_bug(env, "join of states at insn %u does not subsume input '%s'", ...);
    return -EFAULT;

bpf_states_join() returns that error, flow.c's 'if (err < 0) goto err_free;'
fails the load, and verifier_bug() fires BPF_WARN_ONCE.

A pair is not good when, for example:

- the same base id pairs with two different partners: state a has r1=X,
  r2=X|ADD_CONST64 (delta 1) and r3=X; state b has r1=Y,
  r2=Y|ADD_CONST64 (delta 1) and r3=Z.  jid_note() marks (X,Y) bad.

- the ADD_CONST flags differ: 'r2 += 1' on one path and 'w2 += 1' on the
  other give X|ADD_CONST64 and Y|ADD_CONST32 with equal value bytes, so
  scalar_link_consistent() is false.

In both cases reg_value_equal() passes, because unknown or equal ranges give
identical bytes before 'id'.

This needs a loader with CAP_BPF but not CAP_PERFMON (bpf_capable is needed
for the ADD_CONST linking, and !bypass_spec_v1 for sanitize_ptr_alu() to set
explore_alu_limits), and a program that does pointer arithmetic with a
non-constant scalar.  Nothing in flow.c skips the join when
explore_alu_limits is set, and before the join existed these two states were
explored separately and the program loaded.

The code is unchanged at the end of the series (e9cbd02faf11).  The join
becomes reachable with c523034aa289 ("bpf: Add join of verifier states") and
b195aa29eeee ("bpf: Merge the state that arrives into the set at an insn").

Should join_reg() return false when an ADD_CONST id would be dropped under
explore_alu_limits, or clear only dst->id and leave dst->delta, which equals
both inputs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============7457293908775248651==--

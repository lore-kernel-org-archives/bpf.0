Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211497;
	b=Wq96WjPV2PmwZKszWkUf9lwYkjzKwJ4E7VIeiDV3745L6oo0wfpViJUllQgMI4I2V5hO
	 kIgg9iVG6yftb4KSjpNJE9DTEdG+RICdm0v6oGqjDZgk+N1dz1P8h2yhuqsUP6RKvo28z
	 oaH5CAiENPBbgaxm70B5Mks9dVPrSoA2b7YipTJ7FxiZzU2Dr7/seafS7hgwt/YdFH+Q8
	 4LiBBpdTs1zpQX5IOm7TmEgJqWEPNWCQ4SgplhaaqI8CpXCqbgrpuIM5YCwddtUqLniQy
	 asSROuY9w/we96WbcAoQvzCOLX7lGUrwTubVTNDbJgHeLspoq9weznEIIwiDvfIBYvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211497;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ih0A8k1nIZNOjT/YveZdfG9t3gXiro7tqbGzng4rTV4=;
	b=FeXUivnzSHCCmUsA0uS0UamKiOniBJRDEE5LeJJr1pmVPDGXW3OEOqL/S+aQg1p0U/9D
	 z/Peao6FRn7nNYAy7ugXpbPaNN5qQsSWUASzPN7+lJYJWAIh8ro5QOBiT75tU96EWW9sa
	 jND6hXpqqGMDVe8l720uazy/YqHGqHvsj3HVfh383urkqivyRJ72G1WEWcugddC0tpwQ/
	 T6ikXBm1TiXhBIwjK0YBiFh5XGDKw4up9ixoPqGaO3znJxXPYRZnKn529V7kYCK2lpGDi
	 DfySEYPOgmvG2AQIY5NCoQBRZJJwqSLHQ7OoXQRYjKu4tCE3tWUHv1SIwVM3bNrWV8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwioxiES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEC606A680
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwioxiES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D618E1F000D0;
	Fri, 20 Nov 2026 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211497;
	bh=ih0A8k1nIZNOjT/YveZdfG9t3gXiro7tqbGzng4rTV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NwioxiES9QpzQYuGNwStXHBiTCgVJ+8vaMCrO8vK47Xl9NJ2x2F/5WCQkvVCy+5v9
	 N1AxwpX3x4a0WeFNE2wnmaOLU60ZEWUCZKrkjRcxNHnJO01qtKME3BDYNPCAt6ZJZg
	 kODYNn0I0KVSZpAmLy92DoZfj9nEj63RjIobIbdU/j2Bi9BpkUSQQTLJY17a0xi/VX
	 37sfICzqnchYhR8EtAbhbWKt6eDJ0WlcPUeXyc0WVnSqn6h4lZND2HDIEIY1k+Mj/J
	 qbzcEc99+lU6BbnzZejk5tblBPsv+Y652pGyyWYIa8TGcs+K1XE3sN+Uz+lngDpQlY
	 r68DKM+gTAR+Q==
Content-Type: multipart/mixed; boundary="===============2790038836090330668=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e3e07bc6d3d6997ed4eeb94498b29fc2fb46d7eaabc1104fab528e3c89ce9c76@mail.kernel.org>
In-Reply-To: <20261120204959.614908-41-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-41-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 40/49] bpf: Check the body of a counted loop once
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:35 +0000 (UTC)

--===============2790038836090330668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check the body of a counted loop once

TL;DR: merge_origins() may keep an xreg exact after sibling-path or
nested-loop writes, so the first-trips guess can be wrong. Not unsound per the
review; it may cost the trip count and fall back to may_goto.

> diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
> --- a/kernel/bpf/equation_join.c
> +++ b/kernel/bpf/equation_join.c

[ ... ]

> +static void merge_origins(struct scan *scan)
> +{
> +	struct origin *old, *new;
> +	u32 i;
> +
> +	for_each_set_bit(i, scan->written, MAX_BPF_XREG) {
> +		bpf_add_cost(scan->env, 1, BPF_COST_COPY);
> +		old = &scan->before[i];
> +		new = &scan->xregs[i];
> +		if (old->xregno == new->xregno && old->off == new->off && old->exact &&
> +		    new->exact && old->shifted == new->shifted)
> +			continue;

Can this shortcut keep an xreg exact when it was changed on another path?

The comment in scan_loop() and the changelog say an off-spine write makes
the xreg inexact, but this check only compares xregs[] with before[], which
is the state from a single walk of a single path, and before[i].changed is
never consulted.

Sibling paths: flow_compute_order() walks the jump target before the
fallthrough, so with:

  0: r2 = r1               header, spine
  1: if r3 != 0 goto 4     spine
  2: r1 = r2               fallthrough, walked last
  3: goto 5
  4: r1 += 1               target, walked first
  5: r1 += 1               spine
  6: if r1 < 100 goto 0    spine, leaves the loop

at insn 4, r1 = origin(r1)+1 and before[r1] = origin(r1) with changed set.
At insn 2, merge_origins() makes r1 inexact, and then r1 = r2 sets it back
to an exact origin(r1).  At insn 5, old and new are equal and exact, so the
shortcut fires.  The scan ends with r1 = origin(r1)+1 exact, and
find_steps() keeps the jump at insn 6 with step 1, although the r3 != 0
path adds 2 per trip.

Nested loops: insns of an inner loop are off the spine, but the walk goes
through the inner body once and ignores its back edge:

  0: r2 = r1               outer header
  1: r1 = r2               inner header
  2: r2 += 1
  3: if r2 < r3 goto 1
  4: r4 += 1
  5: if r4 < 100 goto 0

At insn 4, before[r1] and xregs[r1] are both an exact origin(r1), so r1
stays exact and is_invariant() is true.  steps->changed_xregs and
steps->nonlinear_xregs miss r1, although a second inner iteration sets
r1 = r1_hdr + 1.  So bpf_xregs_are_partitioned() can pass even when a
partition needs r1, which the changelog says blocks the guess ("a partition
needs an xreg that the loop changes").

The joined state only grows and the returning state is still compared as
before, so this does not look unsound.  The cost is a wrong first-trips
guess, which per the changelog "can cost the trip count.  Then the loop gets
may_goto."

Would it work to also mark before[i] inexact on a mismatch, require
!old->changed on the shortcut, and not keep an xreg exact if it was written
in a nested loop (bpf_loop_at_index(env, n) != h)?

> +		new->xregno = new->xregno < ORIGIN_CONST ? new->xregno : old->xregno;
> +		new->changed |= old->changed;
> +		new->exact = false;
> +	}
> +	if (scan->on_spine)
> +		bitmap_zero(scan->written, MAX_BPF_XREG);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============2790038836090330668==--

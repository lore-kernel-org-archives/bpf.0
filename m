Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636318;
	b=pTT7HzHdraJuxljR2xbGDqK/slzK+Oz+xc7MRmzcifwesBO1qgU50uj+agRYNnDe8rgz
	 Q+rWVgH2WqVX1LST6wQCSy8PRuJFqJLcH1wxLjqlVwHaitxzxa/aZJc/Wc58rDg79ZfLv
	 kgxdwIh6wMbCRbzufQpRBVPzkoyvAr9feQtUPKkQ9AuVuSlE2pynMyPyLARi2f0HvXcIT
	 ZKHpYjBLxMlSbgu8YDCvtIBixEEo2ZVUZRCpGlPyRLHxSSXFkv7AHtCdxBNnlG7It9kzi
	 6o8qk46X4eay8exEpkRC2L2laAa1WUc+nyUjyFAfhFh6kC9MNBdfrkL+EmbJ6NnN35Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636318;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Adb9FHChsSQ+xm0rqzte2dA6EU95VOhm8NVCpxGanNo=;
	b=PvCJl0B7c8snbUWTcbF7jX9BOLnSpqzq/wmgCrpYvCL6BwNTCvMtnJfqvESbSVE5XhJ5
	 0bRpVKQ0C2/cgrv8w1A9AfXPsryk9Q/sgI+ANMuS4EGzibN6zuKRpw8HEUEhgye0sJ2zl
	 G0ML3Oi5VnY9etTKu5aaPcKAf04WQQsw0U9DmjS5jLNWpcEaWdCRWdpbBWMDEPMPeVamj
	 qWDGQ41UehoSnA9hgCS3DSGUTaz5zCrw8SdvOSnKqHj0a6j7fWAVv3uZBCY6J4D/dDDtK
	 G4QEhrWwHl7e8KI4uq4Mh612E+hhC7Cni1Rd2GPk2LuVJKDEMpTXoKwtvKXSHa9yx9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nt5e1abb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7D606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nt5e1abb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4891F000C4;
	Sat, 14 Nov 2026 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794636317;
	bh=Adb9FHChsSQ+xm0rqzte2dA6EU95VOhm8NVCpxGanNo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nt5e1abbvkBLR781yr3Wf59XQnl1SVutn+l9asLMHq9SqcHFX7veptyB3buASqLEf
	 ssMc2S8o8g9H+hfN3ikMGq1nAf4eseGDu7Y+Wt7HoANYjfsy2dAWCiYivvIYRLyZpi
	 zKi83CdPp0bfosCPYg8VyTQOA/YHF83c8d38ekB2OWvc60pWmqAYbzpEeLAXu/j2D8
	 T38UMEjpiFLrcPXvcxHkFKFHYW1M3IL9xCMESSZhjgcD2IDv9T0tG83fVx7a/N2M5/
	 t8veL9d5FUuiSJLZBjTZrBYdjuHQfl47YEfVNTqK9jP5PwlpJJO+zPxGR9ZJ3H5sp2
	 xOLWjirNFrByA==
Content-Type: multipart/mixed; boundary="===============5896059209891492302=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c986875c5e7fd09ea087346a83cada5e27f15e73b8531acb817eaac3cfbf5092@mail.kernel.org>
In-Reply-To: <20261114051805.683966-9-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/11] resolve_btfids: Don't list an error that follows work on an argument
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 14 Nov 2026 06:05:16 +0000 (UTC)

--===============5896059209891492302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Don't list an error that follows work on an argument

TL;DR: In resolve_btfids, solve_forward() may not reach blocks behind computed
branches (jump tables, static branches), so an error may stay listed for
fmod_ret after an effect; no regression, but the documented limits may be
wrong.

> diff --git a/tools/bpf/resolve_btfids/text_flow.c b/tools/bpf/resolve_btfids/text_flow.c
> --- a/tools/bpf/resolve_btfids/text_flow.c
> +++ b/tools/bpf/resolve_btfids/text_flow.c

[ ... ]

> +/* Sweep from the first instruction to the last one until nothing changes */
> +static void solve_forward(struct text_flow *flow)
> +{
> +	const struct text_reach entry = { flow->args, TEXT_CLEAN_PATH };
> +	bool changed;
> +	u32 i;
> +
> +	memset(flow->reach, 0, flow->nr_insns * sizeof(*flow->reach));
> +	join_reach(flow, insn_at(flow, flow->entry), &entry);
> +	do {
> +		changed = false;
> +		for (i = 0; i < flow->nr_insns; i++) {
> +			const struct text_insn *insn = &flow->insns[i];
> +			struct text_reach out = flow->reach[i];
> +
> +			out.based = transfer_based(flow, insn, out.based);
> +			if (insn->pointers)
> +				out.path = TEXT_EFFECT_PATH;
> +			if (insn->kind == TEXT_BRANCH || insn->kind == TEXT_COND_BRANCH)
> +				changed |= join_reach(flow, insn->target, &out);
> +			if (insn->kind != TEXT_BRANCH && insn->kind != TEXT_RETURN)
> +				changed |= join_reach(flow, next_insn(flow, i), &out);
> +		}
> +	} while (changed);
> +}

[ ... ]

> @@ -172,6 +236,11 @@ void text_flow_solve(struct text_flow *flow)
>  		if ((insn->kind == TEXT_BRANCH || insn->kind == TEXT_COND_BRANCH) && insn->imm)
>  			insn->target = insn_at(flow, insn->imm);
>  	}
> +	/* Where do the pointers go? A call which gets none is not an effect. Then the paths */
> +	solve_forward(flow);
> +	for (i = 0; i < flow->nr_insns; i++)
> +		flow->insns[i].pointers &= flow->reach[i].based;
> +	solve_forward(flow);

Does this filter work in blocks that solve_forward() cannot reach from the
entry?

The forward pass only follows direct edges.  A computed branch is
TEXT_BRANCH with imm 0, so text_flow_solve() gives it target TEXT_NO_INSN
and join_reach() ends that path.  Two cases where this happens are an
arm64 switch compiled to a jump table ('br x10') and, on x86, the
out-of-line block behind a static branch whose jump is a nop until run
time.

The blocks behind such a branch keep the memset value
reach[i] = {0, TEXT_NO_PATH}, so:

  1) based is 0 there, and
     flow->insns[i].pointers &= flow->reach[i].based
     clears the pointers of every call in those blocks;

  2) transfer() no longer does out = (struct text_facts){} at that call;

  3) scan_func() only skips flow->reach[i].path == TEXT_EFFECT_PATH, and
     the path there is TEXT_NO_PATH.

Example on arm64:

  static int f(struct obj *o, int cmd)   /* called with o->lock held */
  {
          switch (cmd) {                 /* br x10 through a jump table */
          ...
          case 3:
                  spin_unlock(&o->lock); /* bl _raw_spin_unlock, x0 = o + off */
                  return -EINVAL;
          ...

Every path from the entry to that return goes through _raw_spin_unlock()
with a pointer based on o, yet -EINVAL stays in the tag.  With e0f57028de9a
("bpf: Allow fmod_ret on tagged functions and check the return value"), an
fmod_ret program can return -EINVAL and skip f(), which leaves o->lock
held.  That is the dup2 problem this commit describes.

The parent commit listed these errors as well, so nothing gets worse.  But
the rule in the commit message and the claim in fmodret_scan.h ("Leave out
a constant if each path from the entry to its return has an effect ...")
do not hold for code behind a jump table, and "The tool does not see"
names computed callees but not computed branches.

Would it work to skip the filter where reach[i].path == TEXT_NO_PATH, so a
void callee with pointer parameters still counts as an effect there?  That
would cost some targets in exception-fixup blocks.  Otherwise, could this
case be added to the documented limits?

No later commit in the series touches tools/bpf/resolve_btfids.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43561939812
--===============5896059209891492302==--

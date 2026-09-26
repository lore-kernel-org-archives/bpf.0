Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDE305683
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433122; cv=none; b=iVRIAbF41JKxSvcPdLaiUtZgwZc9GPf47wFHGgJf6O/VuC4WOeRWnxBw1QB0fyXsFra4uUjwip3BI9OLqOeMXj/7F2BUzHSVnwmN0ZKhJE0b0+lGYS8JuTOLJ/skgVmwIoR6Xekj5U0oSr+EhAzXIdSHA5W/o+jdbWAziZLH72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433122; c=relaxed/simple;
	bh=ir8Tw+70pAcW+nNj6YUp1+F2r+RdqoNSOMNHZUu7CNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=it6lo3Ss3E+CDupqLHwPZiql84LfFBH0sQMP1QmL7/USM1eTHyGdwD5eaibxOotpJNo9kXU3JSWcdmsbyuPzvLLZJ5Od/jedj6ne2fsDhmDcpgZzDW2aXVgEHNbrHAN/IFrooMhMM143DkeVvw0ChwCp3ZgbW2ARWmFEY9DDfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBMLgL+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBMLgL+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CC1F000FF;
	Sat, 26 Sep 2026 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433120;
	bh=c1yE3VA8G90+NrEjFdIm3T9PjjyiJ04RSqwzpY71exU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBMLgL+1y7Wk90ks06+dJ0JP7Oj7XQbaHzcTNwKp76kHqq6ic1JdSxHNy0amKndN8
	 tzwKCxDQIYfitJchRQV9gfdV7BlaF2wu7i7G+7X6wLqyA0/+1fn/uQ8/8V8tsfwZvV
	 IoCon6ucH62KHuHzT7dQUCIVnF4B5Z4FTxGT/woqu5JhLf6fN3VmAehIU5qSmU35/w
	 gbKXLg+RlfGENMTe2/tpB7kLePUXkjYQw6PWOXw3YZOQDUvTDIOR3f6XLJc3iqqdrt
	 XQ3SC1XDWFhPTZuWL/lqb2CtPBqG0tKjY73dPfOHfdMtV18EZt9oR3Cc4TR+KakWuC
	 hldXHlLYHyZfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 16/36] bpf: save DFS postorder numbers for
 program instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-16-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-16-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:31:59 +0000
Message-Id: <20260926143200.6E6CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: memory leak of env->cfg.postorder_nums in bpf_prune_dead_bran=
ches()
--

commit 3333ceb14d7fa72313c9d88f2f43fc886dbdac3d
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: save DFS postorder numbers for program instructions

Dominator intersections and SCEV worklist scheduling need to compare
instructions by their DFS postorder rank. Save per-instruction
postorder numbers alongside the existing postorder sequence.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index b0bd9ba951dfb..bd771efec66a3 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> @@ -774,43 +779,52 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
>   */
>  int bpf_compute_postorder(struct bpf_verifier_env *env)
>  {
> -	u32 cur_postorder, i, top, stack_sz, s;
> -	int *stack =3D NULL, *postorder =3D NULL, *state =3D NULL;
> -	struct bpf_iarray *succ;
> +	int *stack =3D NULL, *postorder =3D NULL, *postorder_nums =3D NULL;
> +	int subprog_idx, stack_sz, cur, s, cur_postorder, start;
> +	struct dfs_state *state =3D NULL;
> +	struct bpf_iarray *succ =3D NULL;
> =20
> +	postorder_nums =3D kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUN=
T);

[Severity: High]
Does this code leak memory when bpf_compute_postorder() is called multiple
times?

If a user loads a BPF program that contains a dead branch determinable at l=
oad
time, it can cause bpf_prune_dead_branches() to successfully fold the branch
and call bpf_compute_postorder() a second time:

kernel/bpf/const_fold.c:bpf_prune_dead_branches() {
    ...
    kvfree(env->cfg.insn_postorder);
    env->cfg.insn_postorder =3D NULL;
    return bpf_compute_postorder(env);
}

The array allocated here unconditionally overwrites env->cfg.postorder_nums
without freeing the previously allocated one. Can we add a call to
kvfree(env->cfg.postorder_nums) in bpf_prune_dead_branches() to prevent a l=
eak
of up to 4MB per program load?

[ ... ]

> -	env->subprog_info[i].postorder_start =3D cur_postorder;
> +	env->subprog_info[subprog_idx].postorder_start =3D cur_postorder;
> +	env->cfg.postorder_nums =3D postorder_nums;
>  	env->cfg.insn_postorder =3D postorder;
>  	env->cfg.cur_postorder =3D cur_postorder;
>  	kvfree(stack);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D16

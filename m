Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB13B7B8C
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827198; cv=none; b=eB7JmQK6MtbCyHmFwOiAzWwFlpJyB1C0jG6QU2gY5B2ZH2DHbyN6qI+mF1NnOEBQZ9U4HmFIV6wEhh/lF5pVu145MXUponpWkMI958bzjbSaKnLyEkt07G8LywOJA9nQitpVCCcFdA4iseJtmijc2n33ktW+mq03P4q94VY8n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827198; c=relaxed/simple;
	bh=1nQJUb3aodjb+tscZeuS/4VsZxKUjP2hTx46U9AyZGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M1LjFqmL7As474jSTbroHigSBhhCYdl9lsUHWl6z/TEvYxMb9CgG1ohHjG/tKHNN4OoF++0yD0FLlj02Vxj1rVPxMeqSLa8gbUtAifrPJcZQk+iqQ/rUu/kkMHUe39I9343j2nEiexJKQdfhoKYieKuQgoTTSFstzWv4Y2+Z/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5OsiJ64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5OsiJ64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC91F000E9;
	Tue, 26 May 2026 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779827195;
	bh=3jzL65umVSS96WF7aPRzk3jxKvqamlj8L/30hQ61WyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5OsiJ64J+NypTEpX3gwetgLwXwbvVB40kXOw+XBLJf7Wc4+u+qvyOSTQfFM/Gbg9
	 d4SgD3C2wOHv3vspPeRWXGBa7+SUusOkfRiMGdFYFnZl/DKS2tKD1nqCNgZ1D4f9MF
	 Ezqrk3tFLM2B7rp9RKAfaj1MfBD/EUBwrHAfFWVcHjVFK8AhbUwbVIS/QTqYurNJ5p
	 bstLedtyjhk0vNiov0IZ4qY1/0Hp/keP4xyzP1U8wDU6TuZO8f4ASoay02EPnXdElN
	 5XKFJjwHmN4iCwhSDGOQtAUwb4BnQNzwU+mZnBG7M7NxUcZ4/79YO8d+3EE74eJriX
	 Y/hKwZXYI7fPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next v2 2/6] bpf: compute loops hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v2-2-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-2-e7ec61c45d41@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 20:26:35 +0000
Message-Id: <20260526202635.6FBC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Worst-case O(N^2) algorithmic complexity in assign_header() lackin=
g cond_resched() leads to soft lockup.
--

commit 5ba437ec70f22b36c162a26467753448539086e8
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: compute loops hierarchy

This commit introduces an analysis phase to the bpf verifier that computes
the loops hierarchy using a non-recursive adaptation of the Wei et al.
algorithm. It records the innermost loop header per instruction to be used
as sampling points for callchain profiling.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 0000000000000..1f0b10c57957a
> --- /dev/null
> +++ b/kernel/bpf/loops.c

[ ... ]

> +static int assign_header(struct bpf_verifier_env *env, struct loops_dfs =
*dfs, int n, int h)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int *dfs_pos =3D dfs->dfs_pos;
> +	int err, nh;
> +
> +	err =3D mark_header(env, h);
> +	if (err)
> +		return err;
> +
> +	/* Don't encode self-loops, otherwise can't reflect loops nesting struc=
ture. */
> +	if (n =3D=3D h)
> +		return 0;
> +
> +	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
> +	while (aux[n].loop_header !=3D -1) {
> +		nh =3D aux[n].loop_header;
> +		if (nh =3D=3D h)
> +			return 0;
> +		if (dfs_pos[nh] < dfs_pos[h]) {
> +			aux[n].loop_header =3D h;
> +			n =3D h;
> +			h =3D nh;
> +		} else {
> +			n =3D nh;
> +		}
> +	}

[Severity: High]
Could this while loop lead to a cpu soft lockup under specific pathological
conditions?

With deeply nested loops and cross-edges, it appears possible to force
repeated O(n) traversals of this header chain for O(n) nodes without
actually modifying the chain. Given the 1 million bpf instruction limit,
this worst-case O(n^2) algorithmic complexity might result in a massive
number of iterations.

Because neither this chain traversal nor the surrounding search algorithm in
compute_loops_in_subprog() seem to call cond_resched(), does this risk
stalling the cpu core long enough to trigger a system soft lockup or a
local denial of service?

> +	aux[n].loop_header =3D h;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v2-0-e7ec61c45d41@gmail.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45C3CF1FF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220389; cv=none; b=Xa3ufAAnLkxsGbWew/rdg/yXud85revmdwPe7q8e1XA4DsdIgBx0NO4dfm65pxJflqn7ImP780zhjH0yeH+anfsP+7TXpA8BeIK+WsdXQAsgC/eqI2BH8sWkDaIhM/9cH5EnNlHNE0b3z3gwA6G5TkOD6foQmywbuZYp2WnDQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220389; c=relaxed/simple;
	bh=+vi9ey3dJcyRUpDdXhdjp4/GIJ1JgeJMgze7gXkAnTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhI7fTuvd5cLdo1h2JuRJDnSWsDbHf45U49qWkD3qbfiUfSDjxV13MkQqHFmBf6JAog1+xaRpF1RrrQqK+jnyVunqwVa0Ur1qN04fPP0njeB6c9ooZrAMc/lgDkDn31vw6Iilmay3CW66kO2dFiYJGJJEDqFkgsePRHuZE3KK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKLit8AO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKLit8AO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CF1F00893;
	Thu, 24 Sep 2026 03:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220388;
	bh=tGGaUaTVFG0aCmCz6kPug8Ny+RFAV/AV9yrgNfcMhfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKLit8AOY8+3zJadio8SciP3kO2hMJPEF8wFU8e6WyRvVM2BR14b0Fv7ilCYZud4L
	 E+qt9MOP2WVpJdqDey+KGqAItCjJGaWZOFV45Fwf3SEwFIEA7jQc2K2ROaaaOpsEwF
	 3GILccviEWzgDzbtq9YvO3X5HzwYf6CkxzkPYSuoBdBQOpOqzeLWS58OO4MPA27eHK
	 1OKx0dPSmPnaPTu9K2GK6wpq7xm19mNaF5nxYBIkAtddNXNUMeRis3Vae9msv8F/To
	 h1mn068cNeh8XDXhEc43LR5zxuLN3DYCN+GIOxxhpxgbQq7AQ2IwRzUxmf4QBlKJtn
	 m+hTWSq6lBqWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/17] bpf: Add callx calls to the call
 graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:26:27 +0000
Message-Id: <20260924032628.795CF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: sort_subprogs_topo() misses callback edges, failing to dete=
ct bounded recursion
--

commit 1cc83e74951c3df35b0b794cf4a90e325a1cff05
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add callx calls to the call graph

This commit updates the verifier to record caller to callee edges for callx
and sync callbacks during the main verification pass. It then uses these
recorded edges in sort_subprogs_topo() to detect bounded recursion via
indirect calls, and in check_max_stack_depth_subprog() to walk the callees.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb014bf6a2e87..d00d0ecab17cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3195,12 +3233,22 @@ static int sort_subprogs_topo(struct bpf_verifier=
_env *env)
>  				int idx =3D insn_postorder[j];
>  				int callee;
> =20
> -				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
> +				if (bpf_is_callx(&insn[idx])) {

[Severity: Medium]
Does this code miss callback edges when checking for cycles?

The commit message mentions that sync callback edges are recorded, and
check_max_stack_depth_subprog() checks both bpf_is_callx() and
bpf_calls_callback().

However, this condition only checks for bpf_is_callx(). If a BPF program
uses a sync callback (e.g., bpf_loop) to call a subprogram, which then
recursively calls the original subprogram, and neither subprogram contains a
callx instruction, would sort_subprogs_topo() silently ignore the callback
edges and fail to detect the cycle here?

Should this condition be expanded to check for bpf_calls_callback(env, idx)
so that callback edges are correctly registered during topological sorting?

> +					/* find a callee that is not explored yet */
> +					callee =3D -1;
> +					do {
> +						callee =3D next_callx_callee(env, cur, callee + 1);
> +					} while (callee >=3D 0 && color[callee] =3D=3D 2);
> +					if (callee < 0)
> +						continue;
> +				} else if (bpf_pseudo_call(&insn[idx]) || bpf_pseudo_func(&insn[idx]=
)) {
> +					callee =3D bpf_find_subprog(env, idx + insn[idx].imm + 1);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924031042.1690=
890-1-alexei.starovoitov@gmail.com?part=3D6

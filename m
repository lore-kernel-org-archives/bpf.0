Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F23D9035
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987428; cv=none; b=gq4gaQpuOgsRbCuzPV+aCiKKfFHsS+hzdwRiARcs4X8maY7gjQUKXJy6e3+Lsgm5FdO+66xKulvAZM461+9EZDMUTm3oZg/e4MnPLi4RZ9rCtAVigg2xuAyVZunEqi4d43hXicuCg3wYCNDGcsTj2MqV4vJ5+ZJjRotWODzyJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987428; c=relaxed/simple;
	bh=FjR34F2PTKNTkp9PlqPjYBD0Gkg7qLzANLo4nSP2Y2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJHedYUdUvpUSzC/WN52TpvwuT1+cYqMqccBfNiVE4DfTjqRW+HlZYqFJoDaS+2cBIPdB0P6d9n0vOACO96s7JQbipACu+nQSC7akcpjCMVlcacUJj44qEZ7yHMlcedAFmr2nmUEIsu4M9WwP4Dbz8tHPFJAWdCMSE0APP3fvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llawDMx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llawDMx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C76C1F000FF;
	Wed,  9 Sep 2026 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987422;
	bh=xMYp+DlEsgHi2yepZt5Cojeii/CVJM7kFlOw7MeGnkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llawDMx9T4QvL/4it8nmtJyvbYiw8dMn69kFi80nzm6Y6KJ7fmpZCr0guQhbtVx3u
	 6y1W7B9OJd1irn16VFqJpKXVHemhWsQPKma+Fe3KCAb8XuERmgw+0Q9pq3c+v+udGf
	 xdH3bG/Qw7BSfP4AF2e6dgbVP13BM7oolrEqDDkVlCdvYcj7UQzls35oerPJKDBvfS
	 QfTG1KvtW0mYC2vx+Xguu9aycUCfOBDPGtm0bl54Joyji8uQ83jbPpzGUTtjYZxN/H
	 5NBPUCLyMXDrpV2cAy414lHzBL8AxAU7W07PAqJeKbPY6weYnFnHhEOdcZsf0zHnYV
	 oJ2olR7iEUU8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/6] bpf: Bound the number of indirect jump edges in
 a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909204035.24289-2-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 20:57:00 +0000
Message-Id: <20260909205701.9C76C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in jump table size calculation leads to massi=
ve out-of-bounds memory access.
--

commit 4185a35dbc8e33f3114fd8855cb5ca01b0ecf5a9
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Bound the number of indirect jump edges in a program

Bounds the total number of gotox edges across the program at
BPF_COMPLEXITY_LIMIT_INSNS to prevent excessive memory and CPU usage
during program loading.

Reported-by: STAR Labs SG <info@starlabs.sg>

[ ... ]

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 081f7003eae66..e9910228da587 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -388,6 +390,19 @@ static int visit_gotox_insn(int t, struct bpf_verifi=
er_env *env)
>  			return PTR_ERR(jt);
> =20
>  		env->insn_aux_data[t].jt =3D jt;
> +
> +		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
> +				       &env->cfg.gotox_edges) ||
> +		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
> +			verbose(env, "number of indirect jump edges in the program exceeds %u=
\n",
> +				BPF_MAX_GOTOX_EDGES);
> +			bpf_diag_program_structure(
> +				env, t, "too many indirect jump edges",
> +				"Reduce the number of indirect jumps, or the number of distinct targ=
ets they can reach.",
> +				"The program has more than %u indirect jump edges in total, counted =
over every gotox instruction.",
> +				BPF_MAX_GOTOX_EDGES);
> +			return -E2BIG;
> +		}

[Severity: Critical]
This isn't a bug introduced by this patch, but it is a pre-existing issue
in the CFG discovery logic that remains unfixed in this patch series.

Can jt_from_subprog() in kernel/bpf/cfg.c overflow the shift operation
when calculating the size for memcpy()?

If a user with CAP_BPF creates an INSN_ARRAY map with a very large
max_entries (e.g., 0x20000000) and populates it, jt_cur->cnt can be up to
map->max_entries.

In kernel/bpf/cfg.c:jt_from_subprog():

    memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);

If jt_cur->cnt reaches 0x20000000, the expression jt_cur->cnt << 2
evaluates as a signed 32-bit integer, resulting in -2147483648.

When passed to memcpy(), which expects a size_t, this negative value is
sign-extended to 0xFFFFFFFF80000000 on 64-bit systems. memcpy() attempts
to copy over 18 exabytes of data, causing a catastrophic page fault.

Additionally, if max_entries is 0x40000000, the shift results in 0,
leaving jt->items uninitialized before it is passed to
sort_insn_array_uniq().

>  	}
> =20
>  	mark_prune_point(env, t);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204035.2428=
9-1-daniel@iogearbox.net?part=3D2

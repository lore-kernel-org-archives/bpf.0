Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582030D402
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893177; cv=none; b=dpWiGnvRHeVKVsHK2dsM8HzD+oWNVqea52rJ/26vXMRLNX7oUNEpXHsf4gccRZevEkDqEvcYZOmgM/pkuObPWS0nChkwD5K7mm/sbg2gx+PeElB9Ohs7M+jWUjzolghN6sWZxAOiTQ0ahBE4/PGm6kwXkucOd8rkpysE19AA0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893177; c=relaxed/simple;
	bh=6U5QQD9aZRV8PO4nL8YfKTEn/IGYVKiD7uknPrFYSIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IpKhAtZpa4svIdRbbNvbPWTGbQEue3az28IXnCoqjp0LniYDAqDdZ2f0xlt+DErL9xLehfx5mR8z16L6IglZcKrEeFs6E7+tmZQ0DlWeNo6Qqll4STtiX50/sbVrX3J1JLYG3hT84eIDSoUbE0tJ9GP5r+CVVhdnyaa9O9prBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU8fPJ76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU8fPJ76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F99C1F00A3A;
	Wed,  5 Aug 2026 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785893175;
	bh=Vg8KIFbb9nSJi2wiosqopZruWGGm/mwfhVI5tCqTsas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FU8fPJ76woKIKDO9WcGdGyhSy0yjI0/cq8ArXsmRVqM8/GjM29wjjakMspfjpwgNE
	 HhzrysBWJuqah9Z3yEM/WnJ3eJbWnlftPMBgNpbnFoXqzzzBX18Ed6ZRLTk17n3H2T
	 5HMcmMCFMlcAByfLyy2jcADiDv9FS8Otd0cCNS1RUa1jQV5INFm2dzVI67X3T1hwNV
	 u8BmovfCGsE1G6kT68E+/J7/X4lH6KEwQ19k1L4IWJZPjsLJ6XzjSqEEE6GkqrQGpF
	 DldLvdho3E/rLWJS1psUp8EL6kBNlMzsROHnwiGEZMZOPzwU6aPwS/M4WNrET4lgNe
	 M6f5rJS0JTwLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 1/6] bpf: Track verifier instruction stats
 for each subprogram
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805011517.1717238-2-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
 <20260805011517.1717238-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:26:15 +0000
Message-Id: <20260805012615.8F99C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A NULL pointer dereference occurs in `account_current_path()` when=
 handling an allocation failure during `pop_stack()`.
--

--- Patch [1]: [PATCH bpf-next v6 1/6] bpf: Track verifier instruction stat=
s for each subprogram ---
commit 026daf56a558e1775b6ccd02d21953d3b59b6a28
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier instruction stats for each subprogram
   =20
This patch tracks verifier instruction counts for each subprogram
independently. It records both own and inclusive instruction counts,
updating the subtotals during function returns and when a path terminates
or is pruned.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7439afdc851a7..88e7ea6fbe73a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9807,6 +9809,37 @@ static int set_task_work_schedule_callback_state(s=
truct bpf_verifier_env *env,
> =20
>  static bool is_rbtree_lock_required_kfunc(u32 btf_id);
> =20
> +static void account_processed_insn(struct bpf_verifier_env *env)
> +{
> +	struct bpf_func_state *frame =3D cur_func(env);
> +
> +	env->insn_processed++;
> +	frame->insns_subtotal++;
> +	env->subprog_info[frame->subprogno].insns_own++;
> +}
> +
> +static void account_processed_insns(struct bpf_verifier_env *env,
> +				    struct bpf_func_state *callee,
> +				    struct bpf_func_state *caller)
> +{
> +	u32 insns =3D callee->insns_subtotal;
                    ^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Could `callee` be NULL here on error paths?

If a memory allocation failure happens during `pop_stack()` (for example, if
`kzalloc_obj()` fails while allocating a new frame during the verifier state
copy), the state can be partially copied, leaving `state->frame[i]` as NULL
for some `i <=3D state->curframe`.

When `do_check_common()` handles this error, it unconditionally calls
`account_current_path()`. The loop in `account_current_path()` iterates up =
to
`state->curframe` and passes `state->frame[frame]` to
`account_processed_insns()`, which would then unconditionally dereference t=
he
NULL pointer.

Should we check `if (!callee)` before attempting to read its subtotal?

> +
> +	env->subprog_info[callee->subprogno].insns_total +=3D insns;
> +	if (caller)
> +		caller->insns_subtotal +=3D insns;
> +	callee->insns_subtotal =3D 0;
> +}
> +
> +static void account_current_path(struct bpf_verifier_env *env)
> +{
> +	struct bpf_verifier_state *state =3D env->cur_state;
> +	int frame;
> +
> +	for (frame =3D state->curframe; frame >=3D 0; frame--)
> +		account_processed_insns(env, state->frame[frame],
> +					frame ? state->frame[frame - 1] : NULL);
> +}

[ ... ]

> @@ -18680,6 +18717,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
> =20
>  	ret =3D do_check(env);
>  out:
> +	account_current_path(env);
>  	if (!ret && pop_log)
>  		bpf_vlog_reset(&env->log, 0);
>  	free_states(env);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805011517.1717=
238-1-memxor@gmail.com?part=3D1

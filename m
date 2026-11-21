Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795239850;
	b=iuiee5xBiYOC20FB3xSmFsWn02TqwkfTb4EdKl1RMk+XCTFLPWxvK/LtWCHCZDsJdm8l
	 31az8LohL9udOfBtLLNCZJDpAj0F8lRTr24IWxoD7f8aZI2Tg8MgjgJfiHK94CMcqQGNf
	 G0FVPuScSfMpAUFDro2lO5Io1RhjUa3OAdG80KfXoDFNuhiHM6VZDLe/ocUAuOvykeKkd
	 p0PQ2cBWiPTh2gFxSFFfoFZedLCsM7XPd+X6oOPKTb4BoiCpnBzrB0RIdWdJY3Tj+PsDk
	 EQeUOesQXwozq7BPhAL4Wf2z8myVn/xMyGhdjPWv539SCBdlmH+LNxcd5giiUtNQ7Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795239850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0wD0bhuxMPpq3q0RLl2Xm+LF7jMK1tDc06gwx/ZB6cw=;
	b=CBv4Gj0+go78/ajmgLkXiSdpmkLrDDCQ7euItMBmO47mJxg3a0ZuDrDVOQ0H1TDtGUvU
	 EEBIpNk6JPrLClZ7D/lrDx5XdY5Rbodgf5s70qmrK/1okMq4tlPGcER5G+bBEOhJbEh7B
	 z59lu+14fUj0sssdqgX4doB0UOF5fN2QP/Gcu1iDK5B07xV5CV2Scnv8dC8tqaDRDEttX
	 mHiGOTNLZV/m62+TVLYis9wskn9DQZN83zWPw799lp4ZNA60f4pPp3fhlBw0dbkzQuk7K
	 GdUIDu4GCEMVwq34/sL2Mkq9Xn/TvEnNdyBK4XLXX5JIvymKvm1NRFfPAPQZibDufBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0H7R8LU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531F606A338
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0H7R8LU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A27A1F000C0;
	Sat, 21 Nov 2026 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795239850;
	bh=0wD0bhuxMPpq3q0RLl2Xm+LF7jMK1tDc06gwx/ZB6cw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=o0H7R8LUoifJtpYcZM1qQp2Wjs3K/7EZtTaNwMdiaCo6wPOjHZ2IUhqVwkVfKHP4A
	 grZQtJoDhWRY8VH3ETb/IrGbc0yjOI0/e7hDHWfGQEN80Io/auNcqzrCt75/FT/D7n
	 0YUgYstQxIPuvGhz6OUHA8w1P12c45ACME7wj70DLT+TAeCmIm7ICrrDmcZf0n2W8U
	 mBfjQ2enuZCcxjXHLOz3kzk49AcWyZ9HgRxd4uzof9enn9FlC1JR1p+FZrPnF1M0br
	 3fItQqFcxRb160p9jiIn3Vjpg5PSyH03VoCEo1TCkreaTDBJVREwUPx9GI7FnR/B66
	 cc6IaOc0TIEMg==
Message-ID: <sashiko-outbox-226658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 37/49] bpf: Verify in passes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120204959.614908-38-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
 <20261120204959.614908-38-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 05:44:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: cost limit not bypassed during repeat run in
  log_failing_path()
--

commit 57a53f1fbdfbf66fd6d495ccd155fb967701e9d9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify in passes

This commit implements the multi-pass verification loop in do_check_all(),
running iterative partitioning passes and path-sensitive checks with cost
and memory budgets while re-running the final pass or failing path to
populate the verifier log.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f34c010138497..92b0f4bbf8955 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -23466,40 +23488,202 @@ static int find_failing_path(struct bpf_verifi=
er_env *env, struct bpf_snapshot *
>  	}
>  }
> =20
> +/* Level 2 has the log of all passes. Else the log has one pass, or the =
failing path. */
> +struct pass_log {
> +	u32 level, len_max;
> +	u64 pos;
> +};
> +
> +static void restart_log(struct bpf_verifier_env *env, struct pass_log *l=
og)
> +{
> +	env->log.level =3D log->level;
> +	/* the log is dropped when a function is found to be safe */
> +	log->pos =3D min(log->pos, env->log.end_pos);
> +	if (log->level & BPF_LOG_LEVEL2)
> +		return;
> +	bpf_vlog_reset(&env->log, log->pos);
> +	env->log.len_max =3D log->len_max;
> +}
> +
> +/* Repeat the last run. The verdict does not depend on the log, so it ha=
s no cost. */
> +static int log_failing_path(struct bpf_verifier_env *env, struct bpf_sna=
pshot *initial,
> +			    struct pass_log *log)
> +{
> +	u32 insns =3D env->insn_processed, states =3D env->total_states;
> +	u64 cost =3D env->cost;
> +	int i, ret;
> +
> +	restart_log(env, log);
> +	ret =3D run_path_sensitive(env, initial, true);
> +	env->log.level =3D 0;
> +	env->cost =3D cost;

[Severity: Medium]
Can the repeat run in log_failing_path() hit env->max_cost in
bpf_check_limits()?

log_failing_path() saves and restores env->cost around
run_path_sensitive(), but neither rewinds env->cost to its value before
the unlogged run nor raises env->max_cost (unlike the env->for_log replay,
which sets env->max_cost =3D 2 * env->cost).  During the repeat run,
check_funcs() charges the path's cost a second time on top of env->cost
and checks it against env->max_cost:

kernel/bpf/flow.c:bpf_check_limits() {
	if (env->cost <=3D min(env->max_cost, env->pass_max_cost) && env->mem <=3D=
 env->max_mem &&
	    !env->over_limit)
		return 0;
	verbose(env, "BPF program is too complex: cost %llu of %llu, memory %llu o=
f %llu\n",
		env->cost, min(env->max_cost, env->pass_max_cost), env->mem, env->max_mem=
);
	env->over_limit =3D true;
	return -E2BIG;
}

When find_failing_path() succeeds near env->max_cost, the doubled run cost
pushes env->cost past env->max_cost.  That logs a complexity failure, sets
env->over_limit =3D true so env->err stays 0, and makes log_failing_path()
return 0 instead of err, losing the failing-path log.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120204959.6149=
08-1-alexei.starovoitov@gmail.com?part=3D37

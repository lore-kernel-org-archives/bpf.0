Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162968;
	b=Em3cyVN5wrwTr2zsFXf9nxotlI3AbW4hiXfULyEp8Gl61peT05xnmO1wrJFGsm8pk03N
	 vhns+kzjcEF0LkbMmM18J19t3U2WM4dELkEya3E4MZaN7ikt3iTorPcnV0l+D/BoieQFp
	 f7cfODjxHNFYwjDWszXwT7gkB7dLPWCb/NvpvHN+N6ny2bEj2rOGAWIB3q8hAobPG5w5q
	 6/3A2PEF+RPDc6swwVwRvtrdwOyDe4Z68HF3zHrAWorfEGVO9KUkMFXL3SyKX7Lx3Epla
	 XIpr2IWiaOHy5shShi4V5AWgf0rDH9jfQtznoiSs9urwFSJZIQea2Em54R21XtwMU0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O/hsnTeEYxy1O9yJzUhRdcN6MOdQIOoHhccbavUT6uc=;
	b=oS5apR4mBYZ80fY8u0RnQQiYMszCnA4VXy8MhTLNfWzdpWl5TZXX3aiUws7R8wOuu0Be
	 p6Fw1ULbhJ678oXHtumwSXRibnoKb7bEou0UrMqh2+nbzA/PqpjRoyjh5GCRU/mxYImkY
	 3an57HDpNUXKJJxjS2eh/CcKeThU6t3eKhuurY+IwsgfjRDi1vHFHfin8sKX2F8N+jOzh
	 8Cw43LDuBIwbQU4X+jcTth+tF8xBxzqU4MC2WGjGGBDuodVrbkSpkKuD7VVtkHUI40sXH
	 8wiaqqmxFsuQsMPjQ2843zeu9LEmm5QKW7+Vd+O0trgoDXCE+Bb3LQ1d6beYKk3FHVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvNi8Da+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D60606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvNi8Da+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7F61F000C4;
	Fri, 20 Nov 2026 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162968;
	bh=O/hsnTeEYxy1O9yJzUhRdcN6MOdQIOoHhccbavUT6uc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IvNi8Da+f8/IntOV2D7zf8IqOzXkJwPHW00Wh7zFPjZlwJvOrycCb4a9JqYxaUEPL
	 ntbVDJLgGQR96c/902tzHTiQUC5sJ+v9TSSq0SKKKurt5F13EcUNZk4iwWJxrPqKvV
	 D9Y6bBQujneOA7MVP8z2RjSPmlv9i8SQ4K/8oil8LJYcMornDxamdGp3sxTo1Eb5IN
	 dLHhdi9AxqkWGgthr2g8p6NU8w0fc/66G/Zy3SL1d5J3IpTcZK4ubFq5FHpNTZTl5A
	 sX3HbCib2Q1vJmRa/WaNvBA0KsXN4LA1ERmWuRFFx41DqfeOJJlAQCCkDzatrSk2Mz
	 b7asEN7pfHeQg==
Message-ID: <sashiko-outbox-224722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 30/49] bpf: Get the trip count from the trip
 index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-31-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-31-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:22:47 +0000
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
- [Medium] bpf: empty trip_index range and desynced var_off in
  bpf_equations_next_trip()
--

commit 162fc0fc6e39fa252359de4313f88c4f96f4dc62
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Get the trip count from the trip index

This commit tracks each loop's trip index as an xreg, collects induction
variable thresholds from conditional jumps, and widens the trip index at
loop headers to bound the loop trip count.

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> index 3d9df6e684528..fc05ca7dd6068 100644
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c
> @@ -1132,6 +1132,91 @@ void bpf_equations_fill(struct bpf_verifier_env *e=
nv, struct bpf_func_state *fra
>  	env->eq_env->fill_bits =3D size * BITS_PER_BYTE;
>  }
> =20
> +/*
> + * The state came back to the header of the loop at @depth.
> + * A trip count or may_goto ends the loop long before the trip index get=
s to 2^63.
> + */
> +void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *st, u32 depth)
> +{
> +	struct scalar *trip_index =3D &st->frame[st->curframe]->loop_stack[dept=
h].trip_index;
> +	struct bpf_xreg_equation *xreg_eq;
> +
> +	scalar_add_const(trip_index, 1);
> +	trip_index->r64 =3D cnum64_intersect(trip_index->r64, cnum64_from_urang=
e(0, S64_MAX));
> +	scalar_bounds_sync(trip_index);
> +	xreg_eq =3D bpf_find_xreg_equation(&st->equations,
> +					 bpf_xreg(st->curframe, BPF_XREG_TRIP + depth));
> +	if (!xreg_eq)
> +		return;
> +	xreg_eq->off++;
> +	refine_sym_from_xreg(env, st, xreg_eq);
> +	propagate_bounds(env, st, false);
> +	bpf_equations_clean(env, st);
> +}

[Severity: Medium]
Can bpf_equations_next_trip() leave trip_index->r64 set to CNUM64_EMPTY
with a desynchronized var_off?

If trip_index is widened to the fallback [0, S64_MAX] range and a jump in
the loop body refines an induction variable equal to trip_index to
S64_MAX, trip_index becomes the constant S64_MAX.  When that path takes a
backedge, bpf_clean_verifier_state() -> bpf_equations_clean() drops the
trip_index xreg_equation because trip_index->var_off is constant.

In bpf_equations_next_trip(), scalar_add_const(trip_index, 1) then wraps
trip_index to constant S64_MIN, and intersecting trip_index->r64 with
[0, S64_MAX] produces CNUM64_EMPTY.  scalar_bounds_sync() immediately
bails out on range_bounds_violation(), leaving trip_index->r64 empty while
var_off remains tnum_const(S64_MIN), and bpf_find_xreg_equation() returns
NULL without marking st->equations.infeasible.  The state then continues
into flow_prune_or_join() and passes CNUM64_EMPTY to cnum64_umax() and
cnum64_umin() in join_trip_index() and trip_index_safe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D30

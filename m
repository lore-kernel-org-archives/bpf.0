Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026066;
	b=w8Vt8LgbTYcXtn/rCWwF/pgct0OLzXjJI2CuIo7rEgdjruPvRYgDutoIB8XIorGLI4qi
	 4MPElFwJZtF1kYN22IPcviykB2Hafj27mgihOWYdHogcv9sK0ZCWF6tUj8A80mxV5PhhD
	 Qr0Bz3vUD6StDPktHGwisCthm9do63MYOuwVhyucAoRctSpkkiIWZNU0TVpDFrRWj5JxL
	 piPydNersHxH4QLpeD7ExCjp4+SsTuM6pFIwMVgwxzNrCC/4YwbIVoX3kYZOL4OQWmf5w
	 r3f1l/DErVGNR2Z1IbuluduNsbqWcGzQzOITVvF7GnqQfwcaLvS816R2qvgVtbA1rSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ai2vO/B1Cw6OukYmu7EB047nSw+H5LgUsTl8U3YsbB8=;
	b=TG9PCgLGnR8U0ejjn7ZaQB6pvTVyJsFS5Pl5M+vVptuFjNgWHsvoekJWH9FypvGliqDR
	 MfVrxlc6zw19gqYOEeInJMdlgPGmPb+dYMm8ickvKbxJhD/P437v4ZIA6q9b5ucY3OcTz
	 lg5UTqJR4E2xmIwwZ0kyd1WtGg3yJPuL20tc1Nb9fvFuu4li7xmLD3D/WhPK4y0vNvjYf
	 l46V30b128yTptJW7DzeMkp/QSZ5NfN90i7KAdLfAhjxmY4UwMsScgQvNvSwh8LwiynVl
	 vfCtf/c+KJwYissqUUJjnhvU6zEXqiiz2v/FvzWq5qqwdWBD1KSJBElPdS+bzVuf0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3fRsKtP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3fRsKtP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179721F0089F;
	Sat,  7 Nov 2026 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794026065;
	bh=ai2vO/B1Cw6OukYmu7EB047nSw+H5LgUsTl8U3YsbB8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N3fRsKtPnNxobs3ik6pZLOKpU9uHPq1C6LwJcTbmTRyVHh3yJd98oAdUnNWY+2s+L
	 6dCEIh3QAQTA+dansRXUzFolw55dojjbvq0AVEHmdbIfO1I9+dcMso4iJQm6TwLbsK
	 Zjh0clpkwa00ukcAzpFTt/djCD4MXI7ZdKIJqI2F6/proT1e6J5ngMWrBNk3EItiyJ
	 wr6j8TH+E/71ZFJtWm3PwfJsvbgUJA85A8h+xqfM+pTSjmDSmXVWLk0ZdYi0oZIsuA
	 FpKWKrm6gXyY76IGRaggGcpdP0ZducklK1W6D39suoOW1+UvQqeMF34rzKZicBFV/N
	 Sy/na9/4AaYTQ==
Message-ID: <sashiko-outbox-202588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 29/46] bpf: Keep the first iteration of a
 counted loop apart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-30-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-30-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:34:21 +0000
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
- [Medium] bpf: false rejection of counted loops due to expr_is_fresh()
  on loads
--

commit 161a1c1a744b39f1b6247cc6557f53d0f033b91f
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep the first iteration of a counted loop apart

This commit verifies the first iteration of a counted loop separately when
live registers are computed anew in each iteration, using the state returni=
ng
to the loop header after the first iteration to stand for the remaining
iterations.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 9377b0907f215..d8c847efbd7f3 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
[ ... ]
> @@ -3578,7 +3604,23 @@ int bpf_compute_loop_iters(struct bpf_verifier_env=
 *env, struct bpf_verifier_sta
>  			walk =3D true;
>  			continue;
>  		}
> +		/*
> +		 * What is loaded from memory in every iteration is the same kind of t=
hing in all
> +		 * of them. One iteration tells what. There is nothing more to find ou=
t when
> +		 * iterations are looked at one by one.
> +		 */
> +		if (expr_is_fresh(env, header_env->reg2expr[r])) {
> +			__set_bit(r, iters->fresh_regs);
> +			continue;
> +		}

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v3 [1], can continuing here without
setting walk =3D true cause a regression where the verifier falsely rejects
valid counted-loop programs?

Every non-FP memory load gets OPAQUE_EXPR_ID in maybe_load_fp(), so
expr_is_fresh() marks any loaded register as fresh and bypasses the walk
check below, returning 1 instead of 2 from bpf_compute_loop_iters().

For a loop that indexes a BPF_F_RDONLY_PROG map (for example, idx =3D
rodata_table[idx]), the offset in the first iteration (entry->first =3D=3D =
true)
is still a known constant, so check_map_mem_read() constant-folds idx to
rodata_table[0] instead of [0, 255].  When the first iteration returns to
the loop header, bpf_flow_loop_enter() clears entry->first and entry->apart
and leaves idx at that constant.  The second iteration then joins against
that state with widening enabled in flow_merge() -> bpf_states_join(), which
widens the upper bound of idx to S32_MAX whenever the new value exceeds
rodata_table[0] and causes subsequent bounds-checked array accesses to be
rejected.

Similarly, for a short counted loop that loads a nullable kptr into t and
tracks it with a scalar flag (have =3D 0; if (t && t->y > 100) have =3D 1;),
skipping the per-iteration walk causes bpf_widen_scev_regs() to widen have =
to
[0, 1] via union_any_reg() on the t =3D=3D NULL path after the first iterat=
ion,
so a subsequent if (have) sum +=3D t->x in the next iteration fails on a
NULL pointer dereference.

[1] https://lore.kernel.org/r/19e3280680aa046388274873789d649eac600b99eff26=
33376ba2a073fd30acd@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D29

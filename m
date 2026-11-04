Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751717;
	b=CDgdgxQ/YA+/29cnf2HKPl5YhvqZ3sSoTRWV+0CGZz8Xgp+tx4dmErGV0VPWs3T8uzcF
	 sHBzVotqYP32iXN6BaF9TZ5gJLvmFe/KJ/fSAD4DUOVUbUF1HHR6c392xnYuskf7/l6QD
	 r2aTD6u+IU4arzlZ8fPttm795oBC+BKDHldKTgngLg8X83Sp4JFKNKOffjnQJzzVgy8+/
	 FV01ggZx8ct/XcSDDaKtVP7O90HYl3AHLypXMn6fwg2Z95M4QwDfBRlQrivMyBQnymc2T
	 rm0I9/T2p4HaXqWEZjqvTnpCZFFIA+OP3KfuTIR15LZQ/kbEF+XDYbxXThhRgatc1Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BPMg9RayCRLxGMG3i10iYJvVqa1MP6cKsQX1zNKJ/gg=;
	b=aQcsWZtPAtv2aDPaQLbdRY7U5dZRBURhBBXJqFbIfEQ3EkQpn5Pilv3ghi2qE2cMRTtB
	 /avbBBY/7yzGtnsPQV/DyYEaua9r9WV7ifWP1wn9QVymjdH1Ut50oKsxpj+HRDtVj5yAK
	 t1IUBilLyMFLqcfofVVBXEdYtRM6G/PZ/P8m40R0FyP5Hk4wgVdgZeEyafqJxQr9ot0q2
	 4I+atmvq6RWAQQxEHjHIqrKXBXVPX65GsxKszFps8U8qv5rLRqlzD15aieLgbzD501eop
	 TpOrcO6asx8JuGlwVNcRndK6FrCAUt8UbBpfjWBVcxm+vDxphGR1am7Phyfb7k8XkEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8oIVGiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67D606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8oIVGiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF161F000C1;
	Wed,  4 Nov 2026 00:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751717;
	bh=BPMg9RayCRLxGMG3i10iYJvVqa1MP6cKsQX1zNKJ/gg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l8oIVGiHx4R6tmo3wqEO+Ei9ZxbMn8gQcWtTGLFFjgKoGnXBxn7n3QnPxtuHSSRyc
	 F8tarcuVmb0Z+HrGBhRdhNOVExRFJ3YRNCkn//kQea+uCuR7YYxbPlygjaMtQ1OD0s
	 cW0VBnA/vHQhupBQZLvodqxHJmkFl4QqyXqE1KqWb4jZBCoQVr5ZhXn0YnDhNcQbUv
	 cpJhQvPS6P7f5mPUKE7Yvd5vzb1z5e2KsBG0QMKC4t7+D/QhZ1o8tDWyTmFQm7dNYq
	 t943cwyGE03Ce8jlaS22nI0qji2/miG/EiN8orjcQPI7H8akJMnFncXOkopwen4tHw
	 A11IwV7MtrvTw==
Message-ID: <sashiko-outbox-196303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261103234104.208239-17-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
 <20261103234104.208239-17-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:21:55 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: iv_bounds() leaves bounds->r32 un-narrowed before log_bounds()
--

commit 2f96c458caf20b2679374f41e2e5031f644f1eb1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Count loops whose first value or bound is a range

This commit extends BPF scalar evolution (SCEV) to compute upper bounds on
loop iteration counts when the initial value or latch bound is a range rath=
er
than a constant, and narrows the induction variable range at the loop header
using iv_bounds().

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 8662205a3b594..eac792dc7b103 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
[ ... ]
> @@ -2626,6 +2935,14 @@ static void linear_bounds(struct bpf_reg_state *re=
g, u32 max_header_count,
>  	out->r32 =3D r32;
>  }
> =20
> +static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
> +{
> +	struct cnum64 r64 =3D cnum64_intersect(bounds->r64, iv_range);
> +
> +	if (!cnum64_is_empty(r64))
> +		bounds->r64 =3D r64;
> +}
> +
[ ... ]
> @@ -2925,6 +3244,8 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *en=
v, struct bpf_verifier_state
>  			if (err)
>  				return err;
>  			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
> +			if (r =3D=3D iters->iv_reg)
> +				iv_bounds(&bounds, iters->iv_range);
>  			if (log->level & BPF_LOG_LEVEL2) {
>  				bpf_log(log, "loop header at %d, widening ", insn_idx);
>  				log_reg(env, r);
[ ... ]
> @@ -3005,6 +3328,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *en=
v, struct bpf_func_state *cur
>  			continue;
> =20
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> +		if (r =3D=3D entry->iv_reg)
> +			iv_bounds(&bounds, entry->iv_range);
>  		if (log->level & BPF_LOG_LEVEL2) {
>  			bpf_log(log, "loop header at %d, clamping ", insn_idx);
>  			log_reg(env, r);

[Severity: Low]
Should iv_bounds() also narrow bounds->r32 when bounds->r64 is narrowed?

When widening or clamping a 32-bit induction variable (coefs.zext32 is true)
with a range initial value or bound, linear_bounds() populates both
bounds.r64 and bounds.r32 with the wider range computed from
max_header_count (for example, 0..32 when initial is 0..16 and bound is 17).

Calling iv_bounds() then intersects bounds->r64 with iv_range (narrowing
bounds.r64 to 0..16), but leaves bounds->r32 untouched at 0..32.

Although bpf_set_reg_range() later synchronizes reg->r32 from reg->r64 via
reg_bounds_sync(), log_bounds() is called in bpf_widen_scev_regs() and
bpf_clamp_scev_regs() before bpf_set_reg_range(). Because bounds->r32.size
is less than U32_MAX and cnum32_smax(bounds->r32) differs from
cnum64_smax(bounds->r64), log_bounds() at BPF_LOG_LEVEL2 prints the stale
un-narrowed 32-bit subregister range (for example, "0..16 (s32 0..32) step =
1").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234104.2082=
39-1-alexei.starovoitov@gmail.com?part=3D16

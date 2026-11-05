Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913363;
	b=Sn8R6EjIfmaJsVyhM6HqqgQMRqShJywwtWUMMPfkOcWiNWt7WgT10yj7hBCBAaeEKhty
	 hcFngAZxG6cI3ohNutnNI7x6IDnXrRbie3+U8OSdMwB6Nr9lxxTvPvUUXfUL0eccZGr5i
	 vURJECewHZZE7eUw8hRZh3PyEQ0ZwAezoUjLrgI5a0LllMZQKmM12ZGtAyq8yi8OmoVt+
	 BX7XhJrsX5l4uaDyN+yd5Ry4kkhFop94kI8X4AMCH6FpnxotDpAOOlD/MX5NLvftPz6pp
	 FC/tGmp5GDLtfrHO4UqbbOtDkoQqHnjabHlAJzsPLpDl0olRoFEuXiy9RUC78xFGydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qaAnRrtHKEydu31ltb3ae9DiwfzmYC1CS+6NtBNoDp0=;
	b=VWH5JkIadNkA0sEy8bXKTxDa1Vs4/Evq2VHVSxoNDlFs4H+BM6ihgk8E+KICxtGMVJ/v
	 yEaRWVyCdli+F5rqd+G4ZNylvUwMT7cRDqEHbbtty2CdNTcHEJKUyG27FPyWJIvI5kX3u
	 mKSn8lDxgwlR9oKne19yyL/oveVv24B4sc178e0OQaS9OsNeqFu3W6LW7n4uIPBM1rLD8
	 DMd8fEdOVpa9uBsXOHhI9IrDL9CwjjmKz0PHSBWfpuYX0OstfpPWpGr7W0tr7mvQ6GdSL
	 hpAEddMgCApZi+OPi4hP9XH3Gd1LQojRyn4LURUtvIwAXLhh18CpdZJpIAJPBYTz53A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVk6rYaS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B41606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVk6rYaS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA991F0089F;
	Thu,  5 Nov 2026 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913362;
	bh=qaAnRrtHKEydu31ltb3ae9DiwfzmYC1CS+6NtBNoDp0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nVk6rYaS9EznKQCrDQkF1RY5eQX3VMsT39StfAoy4a/ZLZfNEocjsuTxA0dIihZMw
	 UXnVkXNb580+DWo6B1N2P63H69gr1jJ+KOQW3k30brW+gmeZHJGbk/WCd7okq4qM4k
	 Wr82FatOtf6FV/gvKIh1kBVS/+mDd9wA58tjQ1Fv4XA13BBvNURfp2A9YCsarECKW0
	 kHMe8ckvUh8wX0mHXSXl20tbWGSlgh/6hRW/GvPjzIIzEa68WswH7hTLNv3u/f5y6k
	 si2xXsI0wvUmeewKko+FrAzDg6fi9filFa9hh3LfoHBNQYLxcmwehzoETpOG3fqC5t
	 v2INw0djK3uJA==
Message-ID: <sashiko-outbox-200209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 04/35] bpf: Add join of registers and stack
 slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-5-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:16:02 +0000
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
- [Medium] bpf: join_reg() zeroes dst->delta under explore_alu_limits, fail=
ing regsafe()
--

commit 0a4e5dc6a51300431e525f23f800662f55dec8e9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of registers and stack slots

This patch adds the first part of verifier state joining, covering ID
bijection tracking, register ranges, stack slots, and loop linear-register
detection for widening.

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> new file mode 100644
> index 0000000000000..fe513b7a8e884
> --- /dev/null
> +++ b/kernel/bpf/join.c

[ ... ]

> +static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *ds=
t,
> +		     const struct bpf_reg_state *ra, const struct bpf_reg_state *rb, i=
nt pass)
> +{
> +	if (ra->type =3D=3D NOT_INIT || rb->type =3D=3D NOT_INIT) {
> +		if (pass =3D=3D 2 && ra->type !=3D NOT_INIT)
> +			*dst =3D *rb;
> +		return true;
> +	}
> +
> +	if (ra->type !=3D rb->type)
> +		return false;
> +
> +	switch (base_type(ra->type)) {
> +	case SCALAR_VALUE:
> +		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
> +			return false;
> +		if (pass =3D=3D 1) {
> +			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
> +			return true;
> +		}
> +		join_range(js, dst, ra, rb);
> +		/* a link that exists on one side only is dropped */
> +		if (ra->id && !jid_good(js, ra->id, rb->id)) {
> +			dst->id =3D 0;
> +			dst->delta =3D 0;
> +		}
> +		return true;

[Severity: Medium]
Can zeroing dst->delta here cause bpf_state_subsumes() -> states_equal() ->
regsafe() to fail when js->env->explore_alu_limits is true?

If two states have a SCALAR_VALUE register where both ra and rb have
BPF_ADD_CONST set with identical values and the same non-zero delta,
reg_value_equal(ra, rb) succeeds. However, if their base IDs do not form a
valid bijection across the states, jid_good(js, ra->id, rb->id) returns
false in pass 2 and join_reg() sets dst->id =3D 0 and dst->delta =3D 0.

When the result is subsequently checked by regsafe() in
kernel/bpf/states.c:

	case SCALAR_VALUE:
		if (env->explore_alu_limits) {
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}

Because delta is placed before id in struct bpf_reg_state:

struct bpf_reg_state {
	enum bpf_reg_type type;
	s32 delta;
	...
	u32 id;

memcmp() compares dst->delta (0) against ra->delta (non-zero) and returns
false, causing the subsumption check on the joined state to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D4

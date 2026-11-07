Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025109;
	b=n2Pt400QZIcF+YVCFRSATbh3FybVzkzlRbzB+s0pNR1xiFQrS8/JNl5HeGEHriCZc7+8
	 mv2PPm7Yq1KgWhfsm0mBLtvyugZ2t1V8qqS8tg9PPJkzm1POi/XO7BijlpzGwt9yHMjl0
	 eQl5R8GzyMBAPGV6UfIE/U/d2jSHPpcp4Lm4AHmQDeTZZEPTsNCGMc7EVfPa/6TMM3+fk
	 7+9aWN7sqhh1R/HB1w/04ZKeqenvPsWFhkhVPPhXQtTwlNQpFb5+DbAeo4Jm2YIBb6SmV
	 X0V8sIpngqoF+ZCPzIiFti8/z2FDMU7yYSkpjAnL3UJTvGl2NiaV/ty9AlASprdmwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OGz5Mc0MppHaFbNwUrne2f8BSiENJVaHiXUlSAvj9YU=;
	b=5UCAl6M5OmsrHFB4mpuPBZQ4RrbXrfPdfzS9tj9rZ1CjzPmW+3MC8Nmh3ApR4IZ6R/qF
	 KWdBkS2su8KBBzi7P1B19lQO6lW5rJJwdQp6UWbNMByeTwLj93+iAodDWY+86m7JPM9LZ
	 JItf2GVgx5DPmfgyhjZ05H1GpJDmP1meM12qp5DvRusBDXvLxxkZrX4w9BoaOlNFK1xLY
	 sYj+51RiJjXTJ/zQiU4IxMslIj9XJmj2o11XRwzgzd671kCuK4DpSB++/Ro2zUzEabd34
	 hWT2Y6/xjGLmGkQE1G+j4LuWQIzMd3aPkeUDksP1Awd1Z7qeAyMYxdNfXEdJg0xe/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNy5pyAv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2635606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNy5pyAv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670A1F0089F;
	Sat,  7 Nov 2026 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025108;
	bh=OGz5Mc0MppHaFbNwUrne2f8BSiENJVaHiXUlSAvj9YU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BNy5pyAvnj/bqLPd6KrDZ9bxySk2Dd7vlkEppr8wLZ4izkO+bpI7+FAfmiTVM08oW
	 PO5bxy/c/0ChMynEhIbNacXvBIHEAbQOyLvGF8ixnzPv0GC22S9Ns6eKYToHrUlqmE
	 phmXxDJ/rBKCAafFiKf+xdUGb9YsX5WFj/Nfnlj/JFsdVH48BBc0kYuiIV0jeQQVvZ
	 MNS0KMCvPYMQww+zrH+D88KJWxghLwLfmJ+zY/4Okv7Z2pyG/ppGItylRViAXbC7vP
	 q1wevBz8NoKUWQxsqKccYGHa5tsPbgUyRdjWLF+CrfC4rJNpDifHRFICmgu3R87xQb
	 mI4sTRC4i11iw==
Message-ID: <sashiko-outbox-202568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 04/46] bpf: Add join of registers and stack
 slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-5-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:18:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: join_reg() zeroes dst->delta under explore_alu_limits,
  failing regsafe()
- [Medium] bpf: loss of STACK_POISON in join_slot() when joining stack
  slots
--

commit b2b35d77649236d79410bf6f82762993660918fc
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of registers and stack slots

This commit introduces state joining for registers and stack slots, along
with SCEV tracking of linear registers for loop-head widening.

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
As reported by bot+bpf-ci@kernel.org on v2 [1], when js->env->explore_alu_l=
imits
is set, can zeroing dst->delta here make the joined register fail regsafe()
against ra and rb?

When ra and rb have matching non-zero deltas (BPF_ADD_CONST) and identical
ranges, reg_value_equal(ra, rb) succeeds, but if !jid_good(js, ra->id, rb->=
id)
drops the link in pass 2 (for instance, when one path sets BPF_ADD_CONST64
and the other sets BPF_ADD_CONST32, or on an ID pairing conflict), dst->del=
ta
is cleared to 0.  Because s32 delta sits before id in struct bpf_reg_state,
regsafe() under explore_alu_limits compares delta via memcmp(...,
offsetof(struct bpf_reg_state, id)), causing bpf_state_subsumes() to fail,
triggering verifier_bug() and rejecting the program with -EFAULT.

[ ... ]

> +static bool join_slot(struct bpf_join_state *js, struct bpf_stack_state =
*ds,
> +		      const struct bpf_stack_state *sa, const struct bpf_stack_state *=
sb, int pass)
> +{

[ ... ]

> +	for (i =3D 0; i < BPF_REG_SIZE; i++) {
> +		u8 x =3D sa->slot_type[i], y =3D sb->slot_type[i];
> +
> +		if (x =3D=3D STACK_SPILL)
> +			x =3D STACK_MISC;
> +		if (y =3D=3D STACK_SPILL)
> +			y =3D STACK_MISC;
> +		if (stype_is_invalid(x) && stype_is_invalid(y))
> +			res[i] =3D sa->slot_type[i];
> +		else if (stype_is_invalid(x) || stype_is_invalid(y))
> +			res[i] =3D STACK_INVALID;

[Severity: Medium]
Does this overwrite STACK_POISON with STACK_INVALID when joining a poisoned
stack byte with STACK_INVALID, STACK_MISC, STACK_ZERO, or a scalar
STACK_SPILL?

For example, when only the low 4-byte half of a slot is live,
__clean_func_state() leaves the dead upper half of a 64-bit constant-zero
scalar spill as STACK_SPILL in one state while marking it STACK_POISON in
another.  Degrading STACK_SPILL to STACK_MISC and joining it with
STACK_POISON produces STACK_INVALID, which allows subsequent reads of dead
poisoned stack slots to succeed under allow_uninit_stack instead of being
rejected.  Checking whether x =3D=3D STACK_POISON or y =3D=3D STACK_POISON =
first and
setting res[i] =3D STACK_POISON would preserve poison tracking while remain=
ing
compatible with stacksafe().

[1] https://lore.kernel.org/r/ee77c73bff0b56a40098080a5335d5fd5e4d8592ac15a=
fe769c1c4661f026576@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D4

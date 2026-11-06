Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939942;
	b=F7FxJqbkEJ3PT/6mcG77ASuFlidlFg+kbEQnzzvb1f3k3FMeSv5Bxsktn1nHDr13I2BO
	 7qkTDQvAzm7FRZkuUU216BcDIaOl5eQOXs5jYFaFUezbk9pl3WWJjYaq1cUsn0TnJzmcI
	 r0y65+RUBlIs80cSI/SqreeT8QuvX8LdhKq/+RbtNM59maUftI6gitpG5EZldEJl43B+E
	 dF2yzZD9yswbgmVcAQ57Bso0bXsIROZLUDsYz+oR657L33XxTU0iB3JPr65/LE7SqFc/g
	 kCG/h03bQ/vsrhzurhSw8I1QpmMGsydVpHDUYt8dvOhk5CXMzAMRfDqRJTa8Ej21iow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VOJjBzn4AV9PRW1uo3Xv8K0iClZahjuRJTiWVNiR7qU=;
	b=zzfksmLJ1kBEsrGugazZESTLgf7sNGKfYv6XO3brS9m4VpIsJuOqO5oHDbUF+raDBsr5
	 xBwQRgNf9ZIPc7pmka2O6tFSzZrGByXHOGFSXb6rd6T53Ewgn0+kDpXunwIZOZfqUSgm6
	 f6k1FFVXuvT2sbPyTL0B4DEgDwBLBRZ2ADsKDTuullTQSkEkD+5IH0t8obrN6+TcNJMHq
	 AJN4/qhdVuWAZFr/ypzwIy2cjcF/rh+FaqipWvOx7txdFGgwokOncMaXejXXpzSCmwTKf
	 98pdfamsdc1q9v1GNbOTAiVf2OhKeEvLB79kq+LiqhJP37KKUzbzk1IIuuDiEZ6izdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfeGFUdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CC606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfeGFUdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821CE1F008A1;
	Fri,  6 Nov 2026 04:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939941;
	bh=VOJjBzn4AV9PRW1uo3Xv8K0iClZahjuRJTiWVNiR7qU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZfeGFUdKf2IRCb4jM4Z1hrui+nAwDsOZcomP4bnKNKqFmiL3rHMsjlZ30yHHHfk+v
	 0denOCh3T38J1SoYbFnPH5Flc+nuV352ilJqadowF07neZdA/fRDqpf8/OkETInLaS
	 SkIHRAnw0BtughvJeUonHwp/ZA04c20CSoMM4I1SyiCfP8izq6e17yCuC83DAL6Nnh
	 6XcwSE0TombIFCIWoHI+YnFlZm1r3dCu1rkFx9e+1k5PYNIM6x8D9zobSggVgwV4Eo
	 30whZ87YZ9KFiOKMrIGVwQrqx8bh9hyaVwjfytitMaIHSQBRxSuLVVNtBm6VrufllF
	 Ex4/4gg8eJ4hg==
Message-ID: <sashiko-outbox-200746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/45] bpf: Add join of registers and stack
 slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-5-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:39:01 +0000
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

commit 909a8651c00556d259164c0f04d677d2fd83cfc0
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add join of registers and stack slots

This commit adds the first half of verifier state joining in
kernel/bpf/join.c to merge scalar registers, pointer variable offsets, IDs,
and stack slots across execution paths, along with linear register tracking
in kernel/bpf/scev.c for loop widening.

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
As reported by bot+bpf-ci@kernel.org on v2 [1], in join_reg() in
kernel/bpf/join.c, can dropping an unmatched or inconsistent scalar ID link
under js->env->explore_alu_limits cause the resulting state to fail the
subsumption check in regsafe()?

When js->env->explore_alu_limits is true and two SCALAR_VALUE registers ra
and rb have identical values prior to id (so reg_value_equal(ra, rb) is tru=
e)
with a non-zero constant delta (ra->delta =3D=3D rb->delta !=3D 0), pass 2 =
of
join_reg() zeroes dst->id and dst->delta if jid_good(js, ra->id, rb->id)
returns false (for example, when one side has BPF_ADD_CONST64 and the other
has BPF_ADD_CONST32, or when the base ID is paired with a different partner
in another register).

However, in struct bpf_reg_state in include/linux/bpf_verifier.h, the delta
field is located before id:

struct bpf_reg_state {
	enum bpf_reg_type type;
	s32 delta;
	...
	u32 id;
};

When bpf_state_subsumes() checks the joined state via states_equal() ->
regsafe() in kernel/bpf/states.c, the explore_alu_limits path compares all
fields prior to id with memcmp():

	case SCALAR_VALUE:
		if (env->explore_alu_limits) {
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}

Because dst->delta was cleared to 0 while ra->delta and rb->delta are
non-zero, memcmp() returns non-zero and regsafe() returns false, triggering=
 a
verifier bug warning and failing verification with -EFAULT.

When js->env->explore_alu_limits is set and ra->delta !=3D 0, should join_r=
eg()
refuse to join the scalars if jid_good(js, ra->id, rb->id) is false?

[1] https://lore.kernel.org/r/ee77c73bff0b56a40098080a5335d5fd5e4d8592ac15a=
fe769c1c4661f026576@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D4

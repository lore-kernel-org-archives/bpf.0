Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295C2D780E
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457057; cv=none; b=n81hF6fVHU+gtqq61jjLlSPDK5cDw6JDveLZlIp3vFjKlykYCs/c696jne0DggJIfxojVk2ermyhfTCLDvmBLfjtSh6alayKsxmvG2jeY23yV6zXtMXwmJzv1PJud/466Y61U7Xn6NayPQI2irhRXk0CZ2fY94aDWbZPRtg3GzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457057; c=relaxed/simple;
	bh=RaWo0PxJ9CyUsyxoJN8tmp5zP63k1aQMEK7JGE7q/OQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PNdUr/3RELe9Yz2OheugHGwyvQxBJScX71mQLjT0wcpffveQRPz0rKPp6n/toTTty0BTy8/deOyLc7jYgM86CdmDjd+G3KtOELLMiy3cVjwfKzx5qRS099+ZuOS9+iwQdXZq+Xu0ZdIPVyM9XFAXr0is9736WbodRZflPEgQ7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZm2RdK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZm2RdK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901CB1F000E9;
	Sun, 14 Jun 2026 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457055;
	bh=1i+rsmGE7K/o2w/oeLHuZQucao4M/sRK4VhcRV1fjjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZm2RdK6elVwlC3eNoQGxrbe1uQF/x2YnMTgBJjKR9O4FAvMrPH1ucQj81k9eitj2
	 4fMVJpavdK++VnNHojE3tbmmO/J63MIkZNKbkRZ+mHazToQMM0xmgetdLZtd9CmfHX
	 WUOFjSuZFu8/CuAppOkWSKdW5fzXEAF6FBwE3Ms/3iC2PmADsXAV4cvbypeA/1DzQF
	 eUPtQwAobZ4NWZJbk4+Lm8d5ZeeYvR85BoGgdxWF07+ZDDOGTng6e7yJsacc+s519s
	 J4PjyC53mcXZ/CyzRcdkZNgFpwbm8RgE1S4ItQFa16tRT99EQ8buMTcbShzit+nLy1
	 DNpdJ/AH3x2ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
References: <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 17:10:55 +0000
Message-Id: <20260614171055.901CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Flawed tracking of linked registers in collect_linked_regs() waste=
s array capacity, leading to silent clearing of valid scalar IDs and precis=
ion loss.
--

commit 1fe1c2de8417cc37930a0c9654b28c2004c45842
Author: Eduard Zingerman <eddyz87@gmail.com>
Subject: bpf: Track equal scalars history on per-instruction level

This commit tracks registers updated by collect_linked_regs() during
conditional jumps using jmp_history, and propagates precision via
backtrack_insn().

Link: https://lore.kernel.org/bpf/20240718202357.1746514-2-eddyz87@gmail.com
Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_=
Lf0kcFEut2Mg@mail.gmail.com/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14699,19 +14699,78 @@ static bool try_match_pkt_pointers(const struct=
 bpf_insn *insn,
>  	return true;
>  }
> =20
> -static void find_equal_scalars(struct bpf_verifier_state *vstate,
> -			       struct bpf_reg_state *known_reg)
> +static void __collect_linked_regs(struct linked_regs *reg_set, struct bp=
f_reg_state *reg,
> +				  u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
>  {
> -	struct bpf_func_state *state;
> +	struct linked_reg *e;
> +
> +	if (reg->type !=3D SCALAR_VALUE || reg->id !=3D id)
> +		return;
> +
> +	e =3D linked_regs_push(reg_set);
> +	if (e) {
> +		e->frameno =3D frameno;
> +		e->is_reg =3D is_reg;
> +		e->regno =3D spi_or_reg;
> +	} else {
> +		reg->id =3D 0;
> +	}

[Severity: High]
When the array capacity is exhausted (which could happen prematurely due
to the duplication and cleanup issues mentioned below), this silently clears
reg->id =3D 0.

Could this precision loss cause the verifier to unnecessarily reject valid =
BPF
programs that rely on equal scalar precision propagation?

> +}
> +
> +/* For all R being scalar registers or spilled scalar registers
> + * in verifier state, save R in linked_regs if R->id =3D=3D id.
> + * If there are too many Rs sharing same id, reset id for leftover Rs.
> + */
> +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 i=
d,
> +				struct linked_regs *linked_regs)
> +{

[ ... ]

> +	for (i =3D vstate->curframe; i >=3D 0; i--) {
> +		func =3D vstate->frame[i];
> +		for (j =3D 0; j < BPF_REG_FP; j++) {
> +			reg =3D &func->regs[j];
> +			__collect_linked_regs(linked_regs, reg, id, i, j, true);
> +		}
> +		for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
> +			if (!is_spilled_reg(&func->stack[j]))
> +				continue;
> +			reg =3D &func->stack[j].spilled_ptr;
> +			__collect_linked_regs(linked_regs, reg, id, i, j, false);
> +		}
> +	}
> +
> +	if (linked_regs->cnt =3D=3D 1)
> +		linked_regs->cnt =3D 0;
> +}

[Severity: High]
Does this correctly discard isolated registers if the array is already
populated?

If linked_regs already contains elements from a previous
collect_linked_regs() call for src_reg, adding a single isolated dst_reg
will increase the total count beyond 1. This bypasses the linked_regs->cnt =
=3D=3D 1
cleanup logic, leaving the isolated register in the array and wasting capac=
ity.

[ ... ]

> @@ -14899,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  		return 0;
>  	}
> =20
> +	/* Push scalar registers sharing same ID to jump history,
> +	 * do this before creating 'other_branch', so that both
> +	 * 'this_branch' and 'other_branch' share this history
> +	 * if parent state is created.
> +	 */
> +	if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCALAR_VAL=
UE && src_reg->id)
> +		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
> +	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> +		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);

[Severity: High]
If src_reg->id and dst_reg->id are identical, does this sequence append
all associated registers into linked_regs twice? Since LINKED_REGS_MAX is
only 6, this duplication might quickly exhaust the array capacity.

> +	if (linked_regs.cnt > 0) {
> +		err =3D push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked=
_regs));
> +		if (err)
> +			return err;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781194510.gi=
t.jt26wzz@gmail.com?part=3D1

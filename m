Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F52AD2C
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401415; cv=none; b=Uq4LMj7Ekhdcq6a+ndY8EJVcFijYx4fC2E1ZFKjCecZspv7tEJ1SvX7gpxTmmvnMercUmU5ZYp6kHMBk+RYeQRNYq/8NspsW3jOm24L5ENFQfTmH70ozzhcMxvffXc6s7hBmOAIwk6q6MLxGS0SqHBtIfH6dN2sTmsMgav8Yehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401415; c=relaxed/simple;
	bh=I0qNCSyrd+YUtaGrWY2ke6Cah1Dnfal2rp3Bnz3mjCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZkmLQjtJ4TnNZdGn05QNzngA8qxeuZOj34Ixlu6jWnC2YgB4e9FNijGi2NKDGcb+rIJHcMF4VKs7Q+6lljelnuLLbmpOydUgwUBfeN9mvl14o/CubsPmpDPZQ64VKQaadRq0Y/XP64m/D36T+4eGozp2O/RYk1j+40OoN0lnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoprak/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoprak/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE60C19425;
	Fri, 17 Apr 2026 04:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776401415;
	bh=I0qNCSyrd+YUtaGrWY2ke6Cah1Dnfal2rp3Bnz3mjCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Eoprak/w/0gcKExDOmSx6MTpg1sI9yFjFSoJYkCCTjbphQkRjJV9gnQjJ3/unRjA4
	 eqznwHNUhCYSlO+YvWltaE3QJqkEknA83BBaTJGqskozpUTdkyoVN+Sda8J9ktzknu
	 jrzzVb7TFM4WR83qliyYwnk+rW6SJ8Gjts1NWKyobJH60SU+yitlDJ7Zvaf280GAnk
	 05Oty2OGoOe6WWlgoLctTpNGVUOh+CBbCu5457TbxwVY+hnVDJYfdNDewBnrrzUn7o
	 AxPl8accncfhWmDSkG3JyGyH5IaflSpTmQ1Gt5E2hpysX2zxubx3mxRgrN8QxsfXlC
	 1rR1XRa7efyZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 06/16] bpf: Limit the scope of
 BPF_REG_PARAMS usage
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034729.2629367-1-yonghong.song@linux.dev>
References: <20260417034729.2629367-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:50:14 +0000
Message-Id: <20260417045015.4CE60C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Early returns in dataflow tracking passes skip necessary state=
 updates for the destination register during BPF_LDX using BPF_REG_PARAMS.
- [Critical] Permitting BPF_REG_PARAMS causes severe out-of-bounds memory a=
ccesses to the `regs` array during the main verifier loop (`do_check_main`).
--

commit d68722297de575b838cc2f76141cf9c052e63448
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Limit the scope of BPF_REG_PARAMS usage

This commit restricts the usage of BPF_REG_PARAMS (r11) to specific memory
load and store instruction forms. It also adds early returns in dataflow
tracking passes to prevent out-of-bounds accesses for stack arguments.

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index db73c4740b1e1..09db7fdb370fd 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c

[ ... ]

> @@ -51,13 +51,18 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>  			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>  {
>  	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
> -	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> -	struct const_arg_info *src =3D &ci_out[insn->src_reg];
> +	struct const_arg_info *dst, *src;
>  	u8 class =3D BPF_CLASS(insn->code);
>  	u8 mode =3D BPF_MODE(insn->code);
>  	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
>  	int r;
> =20
> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
> +	if (insn->dst_reg >=3D MAX_BPF_REG || insn->src_reg >=3D MAX_BPF_REG)
> +		return;

If we return early here during a BPF_LDX instruction where src_reg is
BPF_REG_PARAMS (11), doesn't this skip necessary state updates for dst_reg
(e.g., registers 0 through 9)?=20

Since dst_reg is not marked as unknown, won't it retain its stale tracking
state? Could bpf_prune_dead_branches() rely on this stale constant to
incorrectly rewrite conditional jumps, allowing verifier safety checks to be
bypassed?

> +
> +	dst =3D &ci_out[insn->dst_reg];
> +	src =3D &ci_out[insn->src_reg];

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 332e6e003f270..0c7eef3385513 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -1068,11 +1068,16 @@ static void arg_track_xfer(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>  	int depth =3D instance->depth;
>  	u8 class =3D BPF_CLASS(insn->code);
>  	u8 code =3D BPF_OP(insn->code);
> -	struct arg_track *dst =3D &at_out[insn->dst_reg];
> -	struct arg_track *src =3D &at_out[insn->src_reg];
> +	struct arg_track *dst, *src;
>  	struct arg_track none =3D { .frame =3D ARG_NONE };
>  	int r;
> =20
> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
> +	if (insn->dst_reg >=3D MAX_BPF_REG || insn->src_reg >=3D MAX_BPF_REG)
> +		return;

Similarly, does this early return skip clearing the arg_track state for the
destination register when loading from a stack argument?

> +
> +	dst =3D &at_out[insn->dst_reg];
> +	src =3D &at_out[insn->src_reg];

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff0c55d803117..f25a56cfabaca 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18487,13 +18487,22 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
>  		return err;
> =20
>  	for (i =3D 0; i < insn_cnt; i++, insn++) {
> +		u8 class =3D BPF_CLASS(insn->code);
> +		u8 mode =3D BPF_MODE(insn->code);
> +
>  		if (insn->dst_reg >=3D MAX_BPF_REG) {
> -			verbose(env, "R%d is invalid\n", insn->dst_reg);
> -			return -EINVAL;
> +			if (insn->dst_reg !=3D BPF_REG_PARAMS ||
> +			    !((class =3D=3D BPF_ST  || class =3D=3D BPF_STX) && mode =3D=3D B=
PF_MEM)) {
> +				verbose(env, "R%d is invalid\n", insn->dst_reg);
> +				return -EINVAL;
> +			}
>  		}

By permitting BPF_REG_PARAMS (which equals MAX_BPF_REG) to pass this valida=
tion
check, won't this cause out-of-bounds memory accesses to the regs array
(e.g., struct bpf_reg_state regs[MAX_BPF_REG]) during the main verifier loo=
p?

When do_check_main() processes these instructions, functions like
check_reg_arg() will attempt to access regs[11], which overlays verifier
internal state.

I note this regression is fixed later in the patch series in commit
6ec4a3fcb5e83 ("bpf: Support stack arguments for bpf functions"), but it
appears to introduce an issue in this intermediate patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D6

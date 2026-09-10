Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9353B5E3;
	Thu, 10 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062756; cv=none; b=HnUDaDsZb/adaZrNAEcyLo02+93stS3aCX17EmN6dpireZ6eCuYhBhotPkoicTUIfgfCANP+oaLYA6tpKuIFIB6PEdNyA+Xnt7GPRHRnGVF1jftmLjT2rgVWFfcw7UecFu2RmVGdAaFzA4H2R+exXoXd7KKckHMt/5RoHXeBNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062756; c=relaxed/simple;
	bh=xaUIP7n1vRovqFFarET0qSQmfFa91wnH3xTLRR96a/s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oE01S6GSc60Wam3GxmRhI7A8deBDBcqT7AwSJQMV7OZO8ouSfxgmAjzWMA0Ku/p9JHaa7wu6a23Vdf42mfnWhif5vwyUp1KBPTdo+1jVK0x0VBTay+dpdJ6N7pzb6Un4zLL9Yx0RqvXBLloZx+VhR8doJ55I0kUidaIFc7VcpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk/MPjbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk/MPjbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882BE1F0089A;
	Thu, 10 Sep 2026 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062739;
	bh=qqvn6SX16yUt3ZvxTs86qVtzcoYy6wgfsp1EjnqBJa8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fk/MPjbveeULQfCifG6gUd0yT3jL3M7rGZRioZ/V41Cd5OcgLsb4SS/W2wwrlRVJ+
	 Z+trqQ07nmhRotODgj+WVWNIDJvPIPU/vIZQ+RPMgIvmm34nuEXXtYmwymlE6/kPsa
	 BybRO3uiPmLqdZChrwkjYYNDVchf2ckWnnJuhRnAUJ5VvgSw95ag7gqyhT0kEEtiBv
	 M7rc7HUfEHbrCCwq39smEOfdHDH8b9R/1KRIfHir18jR+0lTgsBTAOD9JtXDv1HBbN
	 wH3lczzdej/7hS8PYueNGZNcM57/6TUeyBvBNZRKQ624dIiPuU/TcLcauEVXcoJPqq
	 J1XIcrbS6RycQ==
Content-Type: multipart/mixed; boundary="===============0634230615040165694=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <654adc93a03b1bbeef530ffb6adb9a2d204e5bb01d7707dc0b16889fb05fc3dd@mail.kernel.org>
In-Reply-To: <20260910164635.459558-8-vineet.gupta@linux.dev>
References: <20260910164635.459558-8-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 07/13] bpf: track low-32 scalar equality across sign-extending movs
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 17:52:18 +0000 (UTC)

--===============0634230615040165694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb093194e2a3..308ff53232f0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -16248,12 +16258,23 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  						return -EACCES;
>  					} else if (src_reg->type == SCALAR_VALUE) {
>  						bool no_sext;
> +						/*
> +						 * A 32-bit sign extension keeps the low 32
> +						 * bits, so record a low-32 link as the
> +						 * zero-extending mov does. A self-mov
> +						 * qualifies only if src is already linked.
> +						 */
> +						bool subreg_link = (insn->off >> 3) == 4 &&
> +								   (src_reg != dst_reg ||
> +								    src_reg->id);
>
>  						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
> -						if (no_sext)
> +						if (no_sext || subreg_link)
>  							assign_scalar_id_before_mov(env, src_reg);
                                                        ^^^^

Can widening this guard drop an existing ADD_CONST link on the source
register?  With 'no_sext || subreg_link', assign_scalar_id_before_mov() now
also runs on src_reg when !no_sext, and that helper discards the source's
delta tracking:

kernel/bpf/verifier.c:assign_scalar_id_before_mov() {
	...
	if (src_reg->add_const)
		clear_scalar_id(src_reg);
	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
		src_reg->id = ++env->id_gen;
	...
}

clear_scalar_id() zeroes id, delta, add_const and subreg, and the following
statement then mints a brand-new id, so src_reg is unlinked from the
register set it was tracking.  Before this commit the !no_sext arm left
src_reg untouched.

For a BPF_ALU64 | BPF_MOV | BPF_X with insn->off == 32:

	r1 = r2			/* r1, r2 share id N */
	r1 += 8			/* r1->add_const = ADD_CONST_64, r1->delta = 8 */
	r3 = (s32)r1		/* r1 is wide -> !no_sext, subreg_link true */
	if r2 < 100 goto out	/* sync_linked_regs() no longer reaches r1 */
	... use r1 ...

At the mov, r1 loses its ADD_CONST_64 / delta = 8 link and gets a fresh id,
so the following 'if r2 < 100' compare no longer refines r1 to [8, 107].
Is that the intent?  This is the compiler idiom described in the comment
above adjust_reg_min_max_vals()'s delta handling.

The clear also does not look necessary for the new link: since !no_sext, the
SUBREG_SEXT link is established through the freshly minted id.

Would excluding add_const sources be enough, something like:

	bool subreg_link = (insn->off >> 3) == 4 && !src_reg->add_const &&
			   (src_reg != dst_reg || src_reg->id);

The zero-extending arm added earlier in the series uses the same guard
shape, so a fix likely wants to cover both.  Looking forward through
2c5433cf9fbb..1d3c4a0831be, the later commits extend the same mechanism to
narrowing stack fills and spills and reuse the identical guard, so none of
them change this.

>  						*dst_reg = *src_reg;
> -						if (!no_sext)
> +						if (!no_sext && subreg_link && src_reg->id)
> +							dst_reg->subreg = SUBREG_SEXT;
                                                        ^^^^

On a related note, for 'r0 = (s32)r0' where r0 carries add_const,
subreg_link is evaluated before the clear and sees the old src_reg->id as
non-zero, so it is true.  assign_scalar_id_before_mov() then clears and
re-mints the id, and SUBREG_SEXT is applied to a register that is the sole
holder of that id.

The changelog says:

> Unlike the zero-extending arm, a self-mov can form a link here, but only
> when src is already linked: r0 = (s32)r0 is how a sign-extended int return
> lands. On an unlinked register there is nothing to link to, and minting an
> id would leave the register describing itself.

bpf_clear_singular_ids() drops singleton ids before state comparison, so
this does not look unsound, but does it match the rationale above?

> +						else if (!no_sext)
>  							clear_scalar_id(dst_reg);
>  						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
>  					} else {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282
--===============0634230615040165694==--

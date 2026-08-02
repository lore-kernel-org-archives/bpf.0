Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F625B092
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704863; cv=none; b=sX9vO7EkWFHMv+IR/p2+vhJcGv23iXwBczdAqnx3JIUsbBjSeybI6abvMtMuOoP7RsglKcuhhC/5SWAzOjzUJaDvItkO/BYiDmZ8ILZZzIk9PBC8yGDh5GYvkn+Tbo8Lp9AZY6b4H2BML/lB3SBSusrMmemQJTWBpz8zt3l2Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704863; c=relaxed/simple;
	bh=I9/fei0vBP8PFJ7xBbdHJf7hDAbUV1xCK6+kXn40ni0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBrdqs/OBji7uBpsYlXjNelaE0QzZV5o49qHc0KjeKH7BfKB9OobopmTYs9IWDj8dEG+peg+PCcurJtCgGM0SB6tyTVIXXNelgiRNvhA76bGHSmuUjGNy8Dm4xMMKLob3rFn3v+OdbbxGg7D9b6XNUo8DQdgiDB7z8aIoXMwf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=firN65F/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="firN65F/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10C21F000E9;
	Sun,  2 Aug 2026 21:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785704862;
	bh=9kWfrDQ7Ef2r8Pt/iMW+NFKddy2FiHxBVrPtkti+zQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=firN65F/LQXafYdSk+91U/lVJuMLBDy1MqlyBoEnU62j5cgG6veVYDBHNUGxLZJHk
	 36DbVI2pjZaycHKVUekLNxyvfY5SZCRwDDEEdaWecUEr3xfVW6ziFVRKIywZXLl448
	 jsJ0qiUi9FTSQ1v4ONDGpAIXBNO0svFSY/76YIy8wrtf6zmJcvwNL/um2AlQPU4NWY
	 p9O3jo6Mj1Er3Hd9gLvaMaHxTi9yOj6/Tdhv1pO6R9ynpRFVkxQ8hZRcYK4sDub+oT
	 CoIT4394FHC/kgHGe5OXuz/0uZeeL8t/ltLlJjzMRBwvCusY19UXYVhFJlB+Rfb3sT
	 Pdh3bWWI6DbdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] bpf: infer zext_dst based on static
 register liveness analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260802-static-zext-v3-3-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
 <20260802-static-zext-v3-3-3456b2604574@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 21:07:41 +0000
Message-Id: <20260802210741.D10C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing zero-extension for BPF_ADDR_SPACE_CAST allows out-of-b=
ounds arena access on architectures needing explicit zero-extension.
--

--- Patch [3]: [PATCH bpf-next v3 3/5] bpf: infer zext_dst based on static =
register liveness analysis ---
commit 740202f3328f4855ad10128ef188400086445fa9
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: infer zext_dst based on static register liveness analysis

This patch replaces dynamic subreg_def tracking with a static computation o=
f=20
zext_dst during register liveness analysis. The verifier now tracks the usa=
ge=20
of upper and lower register halves separately to infer whether a 32-bit=20
subregister definition requires explicit zero extension.

Link: https://lore.kernel.org/bpf/CAGKGUv=3DsOuqQtA1Ub-5JXfA4FPosJFYKAQE4B7=
9cK+P1erxqtg@mail.gmail.com/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 896bc5aaaaaff..e51cf5238f60a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -15026,18 +14941,14 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  				if (insn->imm) {
>  					/* off =3D=3D BPF_ADDR_SPACE_CAST */
>  					mark_reg_unknown(env, regs, insn->dst_reg);
> -					if (insn->imm =3D=3D 1) { /* cast from as(1) to as(0) */
> +					if (insn->imm =3D=3D 1) /* cast from as(1) to as(0) */
>  						dst_reg->type =3D PTR_TO_ARENA;
> -						/* PTR_TO_ARENA is 32-bit */
> -						dst_reg->subreg_def =3D env->insn_idx + 1;
> -					}

[Severity: Critical]
Does this missing zero-extension for BPF_ADDR_SPACE_CAST allow out-of-bounds
arena access on architectures needing explicit zero-extension?

The patch removed the dynamic dst_reg->subreg_def =3D env->insn_idx + 1
assignment here. Since a BPF_ADDR_SPACE_CAST instruction is encoded as
BPF_ALU64 | BPF_MOV | BPF_X, the new bpf_insn_def32() function returns -1,
which evaluates zext_dst to false in the static liveness analysis.

Because check_alu_op() handles the cast but does not manually set
aux->zext_dst =3D true (unlike how it was handled in adjust_reg_min_max_val=
s()),
the subsequent zero-extension insertion pass is skipped.

On architectures like s390x, wouldn't this leave uninitialized garbage in t=
he
upper 32 bits, allowing arbitrary kernel memory read/writes when the JIT ad=
ds
this register to the 64-bit arena base?

>  				} else if (insn->off =3D=3D 0) {
>  					/* case: R1 =3D R2
>  					 * copy register state to dest reg
>  					 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-static-zex=
t-v3-0-3456b2604574@gmail.com?part=3D3

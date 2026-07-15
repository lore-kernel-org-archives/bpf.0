Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA272877E8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122439; cv=none; b=Nb+r90GbkzBQ60DjnNMj9s2IdZgPbWJ8SoXeEvrArtmVGtE6c3sTZByXOFmlQJEPhakkFGGtDG0op6rztfyxyoFnIL2u0pDld6wfGPIwzm5WHcYZMKxTnxmIlIep79QK1g/67prA2XPsgdQZHPBpn6UqsPfyAO1ziizAwDthH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122439; c=relaxed/simple;
	bh=MYGH258/PHU7QaQv4S4hHO3mBM25h/p+WtrhvnUqE0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5VUfF5lIB8//IK+qHuUDLTkbrgFQyz/vbfmY0Id+FBHYHf8+Rj/sTzFr7jfMMjmlO4qEkhxJVreIibaBe7i0f8Zhrky/sYWBKvsHboYmRYsvSGXd3AMRGU3IJzUjfVoCk0EcpF1CD1PC8pKJ/e5oT7DT3cfCgbaNJTCnIpgy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjLkkTnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjLkkTnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCAC1F000E9;
	Wed, 15 Jul 2026 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784122438;
	bh=7iJhT1gTn0+A9j3TtmaPUxEeX4UwgXhgWESi0J0LqnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjLkkTnq3zx0RXe9KiTh+ChVwhqz7R+n9kJJ5UAm8FVDCbZtPOJP+O+mUefXwgzFy
	 WhwsZNWKoU4sPnoKWyL5xdR69M41CfSXppQIsXF+BHk+WGRXVuRA38B0KGk+YQlx82
	 4XHpUFTNk1YGNGCK+fCqz5Jhu22Wo9T05uHUdKKMYOhBUGLl7BYtd4wD/TTybLe16k
	 2jJ+dHU1T67/YHHNPcx0Xv61z8FGWlDNDRccspQPsU3XS8xZdLh1gOWOYba9gu0A8W
	 ZTSEO31fCUN/6KCnBJthyxRmBKusGdUnukCQ4DwcCLE6ccnAoH8p6gBHzuXXa7SQe4
	 xTNh01qEr0udA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf: Inline bpf_iter_num_new() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715130430.318421-2-puranjay@kernel.org>
References: <20260715130430.318421-1-puranjay@kernel.org>
 <20260715130430.318421-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:33:57 +0000
Message-Id: <20260715133358.0CCAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The inlined `bpf_iter_num_new` emits CPUv4 `BPF_MOVSX64_REG` instr=
uctions during the post-verification fixup pass. On architectures whose JIT=
 compilers do not natively support CPUv4 (e.g. x86-32, MIPS32), `BPF_MOVSX`=
 is miscompiled as a standard zero-extending 64-bit `MOV` because they igno=
re `insn->off`. This breaks the iterator's loop bounds check and causes a d=
enial of service (unbounded BPF loop).
--

--- Patch [1]: [PATCH bpf-next 1/4] bpf: Inline bpf_iter_num_new() kfunc ---
commit a284b42200c5d5b485b4d27a28c08c05022dfa70
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Inline bpf_iter_num_new() kfunc
   =20
The numeric iterator kfuncs bpf_iter_num_{new,next,destroy}() back the
open-coded iterator macro bpf_for() and are emitted as regular kfunc
calls by the verifier. bpf_iter_num_new() is small and only touches the
on-stack iterator state, so the verifier can open-code it and avoid the
call overhead of setting up an iterator.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de816063ae63d..f578cebbade4f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19715,6 +19715,40 @@ static void __fixup_collection_insert_kfunc(stru=
ct bpf_insn_aux_data *insn_aux,
>  	*cnt =3D 4;
>  }
> =20
> +/*
> + * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 a=
nd R3
> + * hold the (int) start and end arguments. Keep in sync with the kfunc in
> + * kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
> +{
> +	/* if (start > end) goto einval; */
> +	insn_buf[0] =3D BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 9);
> +	/* r0 =3D (s64)end - (s64)start; */
> +	insn_buf[1] =3D BPF_MOVSX64_REG(BPF_REG_0, BPF_REG_3, 32);
> +	insn_buf[2] =3D BPF_MOVSX64_REG(BPF_REG_4, BPF_REG_2, 32);

[Severity: High]
Does this code emit CPUv4 instructions (BPF_MOVSX64_REG) into the instructi=
on
stream post-verification?

Since inline_bpf_iter_num_new() is called from bpf_fixup_kfunc_call() after
do_check() has completed, the verifier will not reject these instructions on
older architectures.

On architectures whose JIT compilers do not natively support CPUv4 (such as
x86-32 or MIPS32), BPF_MOVSX is miscompiled as a standard zero-extending
64-bit MOV because they ignore insn->off.

If start is a negative number and end is positive, start will be passed
zero-extended in the 64-bit register. A normal 64-bit MOV fails to sign-ext=
end
this, and the subsequent subtraction r0 =3D end - start yields a large nega=
tive
64-bit integer instead of the actual positive distance.

> +	insn_buf[3] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_4);
> +	/* if (r0 > BPF_MAX_LOOPS) goto e2big; */
> +	insn_buf[4] =3D BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS, 8);

[Severity: High]
Could the signed comparison BPF_JSGT fail to enforce the loop bounds if the
subtraction yields a large negative number on older JITs?

If the distance calculation evaluates as a negative 64-bit integer, this ch=
eck
would evaluate to false, bypassing the BPF_MAX_LOOPS limit. This could allow
a BPF program to loop up to 4.29 billion times, potentially hanging the
kernel.

Since the if (start > end) check already ensures end >=3D start, would it be
safer to use standard 32-bit arithmetic? A 32-bit unsigned subtraction
(u32)end - (u32)start evaluates to the exact distance and correctly
zero-extends into the 64-bit register for the subsequent BPF_MAX_LOOPS chec=
k.

> +	/* s->cur =3D start - 1; */
> +	insn_buf[5] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
> +	insn_buf[6] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
> +	/* s->end =3D end; */
> +	insn_buf[7] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
> +	/* return 0; */
> +	insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insn_buf[9] =3D BPF_JMP_A(5);
> +	/* einval: s->cur =3D s->end =3D 0; return -EINVAL; */
> +	insn_buf[10] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[11] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
> +	insn_buf[12] =3D BPF_JMP_A(2);
> +	/* e2big: s->cur =3D s->end =3D 0; return -E2BIG; */
> +	insn_buf[13] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[14] =3D BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
> +
> +	return 15;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715130430.3184=
21-1-puranjay@kernel.org?part=3D1

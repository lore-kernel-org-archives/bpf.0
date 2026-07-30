Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A23D7D8C
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448218; cv=pass; b=rGjf36fTbDmVo1HQlkcoVDOY0qBr5PhIkkUmugPE3/+/TsuO6oxzAwHrk+lmsJC9vbBhRlnU6/STYHw6ff4RLyKiRUz9qkJPASlu3O9mndnH/5L9de2mtFnK6Qpos1NhLGwj+lJY6gmarTh/Sd0eHNJwygWSPIkqiVTABh49xxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448218; c=relaxed/simple;
	bh=YypbZ73Z7/uW+UtWfzlJezx6v2qbamtUbBQaBZRlDd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4zsr3aDdpNWrx0ojV230ndW9ql+QA0UjOqTVXj2nrVAhAa/qAIbj0Br9vxKN42hInN+uGwcP6JCRqiHC4RZFWecCDet6YWPr9LPk+GBeWkNyyWq9+6A07E+bWTsrY/apuffBGVQgwsckEcaUa7Tp6fcngPjl66cNLnzY84A7ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rox8Prq5; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rox8Prq5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso461927b3a.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 14:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785448217; cv=none;
        d=google.com; s=arc-20260327;
        b=KTqFBF3A4X/aa8qgXWI5wcvzHfqHKJqa8c6JmpBdmTtfaNoE9IyakfPaw9nRLRjX/T
         ieizlgW4GCoBRV9jv5Xa5B56CJT1Eqidmd0gFqmoMBtc8AogIrD+XHpsvRE0KjMhHWYc
         5A2nwq1jKMocwqiy7q0MQM5lt9CYNQLHCbLk3eQwjO5XUbA2h3xC6ZBo6ZZRbr0gt5g1
         yqOXcC+SftVZaaDAnjapH7ZYztalx9EF6yd97pI1rw5LOu3DRxqc4usyv2kmxwysDZcn
         Ufchzu4oYwKGE3TdT6uciJn9zWgd0G9qojFCagabhHH1xbrRRnTJaa1qkOxaEuVXlqhO
         jj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D27wHhCmrY44Xt5OkfDSJ5lyG186HxaYusQa0xEozBQ=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=Hvl7TBSJ/eR2HU3sK87OZgAAEUgnRjpMxLWStKeU1ZiG6omKaCOZeeXIP04vZ8yD5b
         xtmw5LZO+wICvExr6BHB+fcMoRnNZPkRNmWc+omGi+unq4E3lVhsAs3zfBs2g1e+0C8m
         6rUGmKg5oF9RDYKttcJoTiVW7xT0F1zJsn0JMYmlE/6MqVJONRs+8avHYG7mJCezIWVQ
         DMl8XdfH6uh0HYK/xSVn/bnPIeWjVLgnmpoaCM1Ya1K1728H0bNBhN3iaP8WPNuasD7e
         9JUwGGpWU1UM2QoVpJ/6Y115rWObzayeN0ihQXtjxMx/wftgnnaDlWhRV3itQGb+Rlvc
         23FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448217; x=1786053017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D27wHhCmrY44Xt5OkfDSJ5lyG186HxaYusQa0xEozBQ=;
        b=Rox8Prq5EmT1IhRc2jtM8WtfHrYelNQSj39/fBq8DjVQJ0/O70AeHD1nQenMlth8gX
         qc1yO2sxOal8v8tZ6NNwqACyujrvH1quHyVCPb1D2H6l45wjid1TZ3MR/tP6bFFHOZqo
         of6juHzCqVdpz2JqjPRh/dRqR2HqwlrhwYNgc68Qi+oYw5atxu/S+ynCOb1eyA9tTkpq
         eBZZdpC/UhxUjnSqIVGJhs0BdFKa8JfCO5yI8ssoZCrfIH/Fal57x6ZubAKJCGoaCBkU
         XG8DoeE2FZywR+BqUEigqriGrWnEJu2KmEgukXULQqgW5gpR0aGmwNFqAqsK5yJKN4Jt
         bKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448217; x=1786053017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D27wHhCmrY44Xt5OkfDSJ5lyG186HxaYusQa0xEozBQ=;
        b=Yy7P6hcGY0nw3j2AWPkp9pVbL9N07gurogWs78WhtKh+Rk/BZCnxEDZb160QGS0RIS
         B2CYjLRNpMZKRdY/17p5mDHJ6uy1ISpRzk91fc/rdJ6WWD10LhACySrp7cS0+jJ9f/PU
         0ujbTIX4I7SrmloBu0JuoVU70FYytpGkguCKS6/K2H49Kx9/s2WpS+YmqffB0zjezB73
         kwK8yqHCVwxHrvanTbSSYjDc9O7LUdjFeuYBPsVMx1nqiOKI1W1LcfK4OC8WJAqS+DAl
         Z3mWeXpB6T4YeZHsOp2UuxmPmu7L+JilcczKIfPm0xXehwAYjA8I46wYOkqMJ2wDwdgr
         3ZJA==
X-Gm-Message-State: AOJu0YyOJQ6ZXk7wdG2SiMm2amPYDAd2SxMVsRUrA9UUsQ6nI8JMBGr4
	3I7d5Zv3hP8dJeXTDIMM7LXoxE75Fzs4O4r/Sfbab0Wjp51PB6hwWcco9yMeul3Kqnb4SKQgNcn
	a7E/kI0a7eB3gPdsqPBkIx3m6ymjNfzc=
X-Gm-Gg: AR+sD11zalkXR3CIZS+o5ruSZGeU/XOCoJsN+4GuBVGEeMGv2/ePJ2ArYT8lypiYXBB
	CDBMvCs9uhCZsKX7a4XTwSNG8vOwxaQD2NNyCEvpsJEC/L8K+cV1fuFlMGAUViKhu5FUrYLzG1J
	/uL9Sm6RrKDQyYU4Hx8qxLy/ltW8/OSlVCTDxg/6gdmXMZzSmEJKtoTrKAMjQStY7NU4wdbSnLK
	tRUbPVjCUNU6D1HCltKPIhjmsY0QV5XxgbDtsck9Mrngm46exxnooqJeKmLlVSVM5bPI4h7C6K8
	hX5VH+ASOH5lP5OtNw3GbSV/5EvLng/oyc0tVQDfAZBD0NLF6LZuEjJodXdgfOJLInmZIqeAIU7
	UgPSrja0B5VfzaLecd0KWeIp1aBgluEPpuzOQjIrc3A==
X-Received: by 2002:a05:6a00:4518:b0:84e:17ef:5460 with SMTP id
 d2e1a72fcca58-84ebc3dddd9mr3730503b3a.40.1785448216629; Thu, 30 Jul 2026
 14:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729203633.213973-1-puranjay@kernel.org> <20260729203633.213973-3-puranjay@kernel.org>
In-Reply-To: <20260729203633.213973-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 14:49:59 -0700
X-Gm-Features: AUfX_mxld2ZJOXUQUa2IUpm6RMobINjPCymc_RLlpDJA7yl_TF9AvDast1w3l6w
Message-ID: <CAEf4Bzb_bYH_vXh-i145JMjcPDev_ALkf0-KH7J8EFk03HwYZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Inline bpf_iter_num_new() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:36=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> The numeric iterator kfuncs bpf_iter_num_{new,next,destroy}() back the
> open-coded iterator macro bpf_for() and are emitted as regular kfunc
> calls by the verifier. bpf_iter_num_new() is small and only touches the
> on-stack iterator state, so the verifier can open-code it and avoid the
> call overhead of setting up an iterator.
>
> Inline it in bpf_fixup_kfunc_call() by replacing the call with an
> equivalent instruction sequence. R1 holds the pointer to the on-stack
> bpf_iter_num, while R2 and R3 hold the start and end arguments. The
> arithmetic and the error paths mirror the kfunc exactly, so a program
> that inspects the return value keeps observing the same -EINVAL /
> -E2BIG / 0 results.
>
> The kfunc guards against overflow with a (s64)end - (s64)start range
> check. The start > end case is rejected first, so start <=3D end at that
> point and the range end - start fits in a u32. The inlined code computes
> it with a 32-bit subtraction that zero-extends the distance into a
> 64-bit register and compares it against BPF_MAX_LOOPS as an unsigned
> value. Sign-extending the operands with movsx instead would emit a cpuv4
> instruction after verification; JITs that do not implement movsx (e.g.
> x86-32, mips32, sparc64) decode it as a plain move and would miscompile
> the check.
>
> The emitted instructions are plain BPF and are handled by the
> interpreter, so interpreter fallback stays correct and no jit_required
> marking is needed.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e6f35f4e715b6..7400515ae1296 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19773,6 +19773,43 @@ static void __fixup_collection_insert_kfunc(stru=
ct bpf_insn_aux_data *insn_aux,
>         *cnt =3D 4;
>  }
>
> +/*
> + * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 a=
nd R3 hold the (int)
> + * start and end arguments. Keep in sync with the kfunc in kernel/bpf/bp=
f_iter.c.
> + */
> +static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
> +{
> +       int i =3D 0;
> +
> +       /* if (start > end) goto einval; */
> +       insn_buf[i++] =3D BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8=
);
> +       /*
> +        * start <=3D end here, so the range end - start fits in a u32; c=
ompute it as a 32-bit
> +        * subtraction that zero-extends into r0 and range-check it as un=
signed.
> +        */
> +       insn_buf[i++] =3D BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
> +       insn_buf[i++] =3D BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
> +       /* if (r0 > BPF_MAX_LOOPS) goto e2big; */

should we update bpf_iter_num_new() implementation to have the same
u32-based comparison to keep everything in-sync (and leave *brief*
comment on why this is ok)?

/* start <=3D end, so (u32)(end - start) fits u32 without overflow */
if ((u32)(end - start) > BPF_MAX_LOOPS) -> E2BIG ?

?

> +       insn_buf[i++] =3D BPF_JMP_IMM(BPF_JGT, BPF_REG_0, BPF_MAX_LOOPS, =
8);
> +       /* s->cur =3D start - 1; */
> +       insn_buf[i++] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
> +       insn_buf[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
> +       /* s->end =3D end; */
> +       insn_buf[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
> +       /* return 0; */
> +       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +       insn_buf[i++] =3D BPF_JMP_A(5);
> +       /* einval: s->cur =3D s->end =3D 0; return -EINVAL; */
> +       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
> +       insn_buf[i++] =3D BPF_JMP_A(2);
> +       /* e2big: s->cur =3D s->end =3D 0; return -E2BIG; */
> +       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
> +
> +       return i;
> +}
> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
>                      struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19902,6 +19939,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 insn_buf[4] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG=
_1);
>                 insn_buf[5] =3D BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>                 *cnt =3D 6;
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_new]) {
> +               *cnt =3D inline_bpf_iter_num_new(insn_buf);

all other kfunc inlining logic is inlined in bpf_fixup_kfunc_call,
let's keep it that way, drop inline_bpf_iter_num_new

pw-bot: cr



>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>

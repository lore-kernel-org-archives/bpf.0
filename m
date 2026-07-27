Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516D3CB55D
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196586; cv=pass; b=W9OBqHG/V/CwfSiX1zznBPtdPCFZaX5C8Ns6K1yINOV6p/EqEgM1iYtsHuNSRfJPA6mA+sd+rpKvv2XAKhp4Oy8iLY73lTuw0F2i4T5apUGD7j8AS7jRgWDectacaZBerwXTlV5WIpa8xD6FzQOJO4l1EIyLBoPNpfpH0YQsmb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196586; c=relaxed/simple;
	bh=q4TUVPS/IhreF40firNWmqa/nrpyXhFogDoHOzlt5Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urYNwKrYZMpQI9jg4knecZXX6x5doVFy42qS8uU8B0GcZkxngPRG+tAsYRP4VRP98J2ECtBfKLKX+A2i0bW4NyRbzsl9yPxhDbp5BkDnz08AmUIOILW9o9T5c0oHaJUXOmKtk8Od8uPJYDKXkYWEqOA9junMkcZ28vfeFO1hhF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i11LvlQy; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i11LvlQy"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848595b338cso3577225b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785196584; cv=none;
        d=google.com; s=arc-20260327;
        b=PQGZtvSH9VzZIxKvC37h9MW5SLeS5Jl26yDL/n574kX7wePD2Rj0JFOqTWJWyQgPgg
         Y1Tji+FGLX3oNk4Y1p8BA5ws+mzmV8T7V/FapPQJKLNXAxsjBNtLcaoDvsFj5B/xWa7p
         6jglfFjsFnZfY9aDJnafDm82X2exnOKTX25XeO68l1z9gVDqbHHMjOzVbPMAamYvsEu7
         AawLghdnjxoxAi31uSbI4cXwn5L/kr7j7YTuP3wo2gRyjMMnOtXn3f6vHwHu+phF075M
         ad1yvIEKDeh/sk07QcUjcbMBqJ7+nqy+5h26/h4l7iMfej1+Nmvd/8ITjoPxgbr9eJT0
         WJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayvswQaCM96v2NVZPSUpqrzCKLT+rlX3C0a3IGSo6dU=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=Rg7DPJkA2/MHHC+Dw8Igfx+R2xXR8y47WoJqkF+LUd3HCyRe3cAAHavOnp8rksxglZ
         P0GR/jVFnnX4qkJriBzh3GyIXPvZO/EncF3vUQ8ne7B6aebN2iEqCJzm0T4Jrd3edQsR
         4NvFKjt++NdlMfG8H90mX22cnEYWIhj2nzvr5crcvBXp4M+j4p7HNFKFrV2OE3d4RQo3
         F1vazJSvES4rKTrEwrNhX0BrXRlrhM7X9dF90egPtCNvCABC8w2cjr2dJc1uifQuHqN7
         rXpp8NAxfCyVkMkpGEBaEHv6Bucy5sBaZ0p973wukbqSPrzVPlEbJnZDZ1AE2wbKFLHl
         VKaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785196584; x=1785801384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayvswQaCM96v2NVZPSUpqrzCKLT+rlX3C0a3IGSo6dU=;
        b=i11LvlQyYJLBYYWi2GxEtMJ92/CCEPPRgDBOZ088d3lPm6zyTSQLOS+ZNKjE3CoMoY
         1w1YRLLvHjFOVoDih0P57y5OewkP1iMB51OCOCr0eQdPQcn+IAj+X9wPrblNNgcZDGDQ
         OOg6aOIdDWIxMfUP4IHqx8ALacu6kmEfsd1e+NBJ8I++7QMXRFpwa3GGmwvy4MoLaytg
         EerivJgkwlbBJ9SShail2NBLq+g5QN2VZnFACVlRQhhbE0Fm7mHxgNyfJrHvF0dgs+M+
         B/TE+Lt13yHh+LJtAG1LmRqJPLYIjTFZGr/B7kwTz03EgQYonRNbmCPFmMYCZFe9/sdF
         vHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785196584; x=1785801384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayvswQaCM96v2NVZPSUpqrzCKLT+rlX3C0a3IGSo6dU=;
        b=XXBxrJU/stQN9hnBcBKc+gIjwhLjUk86S7Tf+HVguQjZfRMuMVA5yl2qLzGXuv2fjA
         gwC79OJE7NyfK/nqDoJMD5BPXyZqbPr8tt6omtRFw8xhrSGR2DfO1x6IQCkkVgS9dEG6
         bS5Ae3ePefEmPhMbnImtUtOfA8hQ1U6XRXswKWLgTzWcDPlEK4NvpYW8gib4xCOkzwq9
         zyLORRzNClgqE72/h5sI2g6lCbJ89bDJ7Xr9TE80XDdbr6XdtO2OlvYMpXoOFJCIs3qh
         4MpO/uXdowYWhsCoduqxSzjsJBnizlg/VY72JIBKuM34kRInUesnmWQtsFeNkhzTEl2O
         EA2A==
X-Gm-Message-State: AOJu0YynKUW9bEy8hfiAHFdmjCwGf8+ruJ0avZVobEXlkcG2ZkgnjUAc
	abGUxWnCl9i9JlEmR6s3Io+9JleePNu671FrUZL2LvgAzLLSIgSIJ2bp3GFcK3OL9e+8hscU1qL
	j1k5CEaQYbaFULnk9HY2v5jo6HHCLkhI=
X-Gm-Gg: AR+sD11LkQrYFlwKBI/1IQGsi/ciSUQJWIAT0MzW/GEv5HiZVhNqU+MhRZjewq5Kqul
	L3S8T21ACVbMflK3kFFFsrXxJNk8+FMp61fPqDQ21HpP88/xxxApV2tU6jAJN/vMOf+918sACrF
	1LiQbvV9FJ2z/2byifUWrUUPlZMsNVS3N3NaTwqLSQDrUBjM+TuwCupwB2dvp8WN50+KUB1cnT2
	8VLe0pGEnQfqfa0o7b22sNBqNbyVewCgx3ANkqs9QAVuNhSxT4cYECQlxlOizxNy6+SJng7YueT
	LXwbbgRvO5zouMr9Ws5j+RjJO1mEgR3oA4dUrhbbjOiLjQpfKuoVQQE4uQ==
X-Received: by 2002:a05:6a00:460e:b0:845:e440:d0ca with SMTP id
 d2e1a72fcca58-84e931f6a9cmr39472b3a.8.1785196584156; Mon, 27 Jul 2026
 16:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <20260722132424.450230-2-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:56:08 -0700
X-Gm-Features: AUfX_mydqzlw0Y8d1E0j3jAqqLuD52lCoNOhNNKXtwdM_KCsbsc6kWZBRoRVTzI
Message-ID: <CAEf4BzYdaSV0wYXW4a2aMukn_TCrFAOk3w-KbrQbRbGY4faPQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Inline bpf_iter_num_new() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
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
> it with a 32-bit subtraction that zero-extends into a 64-bit register
> and compares the result against BPF_MAX_LOOPS. Sign-extending the
> operands with movsx instead would emit a cpuv4 instruction after
> verification; JITs that do not implement movsx (e.g. x86-32, mips32,
> sparc64) decode it as a plain move and would miscompile the check.
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
> index 52be0a118cce0..ff76a1ed04556 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19770,6 +19770,43 @@ static void __fixup_collection_insert_kfunc(stru=
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
> +        * subtraction that zero-extends into r0.
> +        */
> +       insn_buf[i++] =3D BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
> +       insn_buf[i++] =3D BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
> +       /* if (r0 > BPF_MAX_LOOPS) goto e2big; */
> +       insn_buf[i++] =3D BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS,=
 8);

this should be an unsigned comparison, no? Otherwise INT_MAX - INT_MIN
=3D -1 and this check will (erroneously) pass, or am I mistaken?

pw-bot: cr



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
> @@ -19899,6 +19936,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 insn_buf[4] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG=
_1);
>                 insn_buf[5] =3D BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>                 *cnt =3D 6;
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_new]) {
> +               *cnt =3D inline_bpf_iter_num_new(insn_buf);
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>

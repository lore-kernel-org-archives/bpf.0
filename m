Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC652BE057
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955913; cv=pass; b=f/mR8g2Q4gr33hsMlYj7QuqjeMbZHF8z23S7TWL90fQh0ChwrTkn2783QPyb10N1LJdaJ4Rx0rQgA9xKGSHHRWSrNAZoatn5LftihUUcOvCSm0i3PML5W2KYIOUUT0A9FlzuK8cRDQ0bB1tbgKzW4lktfsIRdAi56Z5qcINVNrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955913; c=relaxed/simple;
	bh=NFo91oSEGOWfmGH3XSbPOll8PTFduiKL8a1//KR2rRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA9LerLlGWhAHFjeELfLG0k41BFHwS9ueoCHxn1ZfAX98n9WcO82aIPjgSiz0n5nsIN4Z/C2oKdQs8kI8M+9JOr0qOGT2BuH7xT3wAUruARjpOJLpL8E3b9RCaVee7fSIdIEcrcNaBUFMqkdy+jFIrLiISr4DYPx86FAFH4Rdks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyys/5nK; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyys/5nK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7786d7895so6898345ad.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955911; cv=none;
        d=google.com; s=arc-20240605;
        b=k6/m6W73WKG/Odw/F+krY5/4Hi7iebr7i3/mA6aX7/PRmurfjj4Oatg71znywFJCJ8
         f2Ehh1IFmzgaOkQW4CvT3lbxNBL0EWS4nS34pRnA2InAskUwHCoib0RBotQTXqJGHFde
         o4Ko/f5qmMJb4H6az9r6HKDEVBEAnlDNS+C7M1lynjaC10Mmbhz3WcGxg9LI4gR9mT/L
         e2nI8/0G1tZ3jY0uE/1P1uPTC7mr8rFyJwdU4ONI3dhCs3h3OtB0t5DwaQfu5/toNDtg
         Yw6GTcQLBBq6Tad1clds+r+WiT5rSKrpSq/RZ3utx41Ga5HwqAYPB2z6a8p3GeTWLq9Z
         f8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1BD/hHPIdij4CKcLLe3CpSjmZbyhIbFHMp+STIIZ+8=;
        fh=e5LZ4Di+Lhe0lus7XBuHDUnq1rIxygGQOeIRjH9sFes=;
        b=bR5mk5l/kaqZH5Tr7h9PnOz/6kIrdXCgvLsHZM22BzEa3YYDp0pcv9J6yjJMGUpmFq
         FSMv4cu3HpYaK1Wl0UpyH0FKsnbC5Z76nlLcOmw6FoopbfJa25M7td0gZ8lJ8dgZ7gym
         MpRXAN67ZKX4O8fLrVeBHW1Jeug7/DD8DoHGw55gcw4xGWduEKIk2C+iTr+XG67JgV/L
         nBBJYgc37/tIEHL1nbat2tDHo5PTnQcUNxX6bhQwQTc/zOKRwwtgY5jnIkqQe1Dy2Ip2
         gQqZq/4aAsktexnBw30v8FqiMC51M+y/4DyvaIJUJmeLNCFHPrOvrtPQ3ZtbtFTO0CIc
         khKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955911; x=1769560711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1BD/hHPIdij4CKcLLe3CpSjmZbyhIbFHMp+STIIZ+8=;
        b=Wyys/5nKJ2vkkCgfI/8H8owJQF5+cYqqK+tZgKzteq5c7yG8w8q+9vUX4I4a3FF1+S
         jA8Nj7//bPwcYTqs97HxVWvoNKbNKELwcdSWZVbDdPaMl9Oe+2F3tNq4alznRnT9VQB3
         k5jTySRw1C8lLS9CWho3gJhaJGzLmjx/INnmumgAzTB8tsXq8eYgKlnijGIY794HDsKk
         p6eWDzVIs1QaJYSU4Q/kpLf3O+M6HlAz5KtzaacwMRvpJIntjZS0wKOyKIuXUzbod8lz
         saRv/08HwYZu9x2bICxknnkZwhUfVExsMzrgJgyG2iYuy++IfbDfdTKulwyswEh/COn5
         LnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955911; x=1769560711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1BD/hHPIdij4CKcLLe3CpSjmZbyhIbFHMp+STIIZ+8=;
        b=iFEHqyBaWnN0CPZ+ubif14qhHcF2lioT4lmgs2aLxdnp6stHUEjJoejnlT2GylKEWP
         vLDifXPm0Hcsy57N8aDHoYlcPm4MSXGTNLZrIc45txMHwhTcp/mz0ql736flOoY3fxwx
         oopYUuJIdhOJ+OLotqvLGC8XjtWHv+rtKsMQxX/Hu7wAyAInYpo5aMj/Y9ua3H5xiev8
         I7Y/kgzORVZ6PJxXhSmjrCJET1WtFkYXNXHfOFjLGBxGBiNCLVhQPTFKBt8vPQ0dTA6u
         YRQB0GA03ooLbLbsjjCY8K34MiordEAH73XyMcoPWynOUh8TPcYlXk/G00DcvdAu+Y+g
         2d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVre3I/1xqyGqwixWBlxO4N17V1ExU9yoPunY6pmAB4tUZQs69AbJoLgKLqOkNhJkRCG+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymS0H8WUhzPG9cTNgSttA51NDPNVLo5HDnCVB4sYs+mjyr7bss
	QcVNkWncAGn9Wda4FXW3rJsk4fTlg/079CRgIEy442nsR+2UujBAQYwgp8o4bQw1oJxQpvi5Q+L
	RFZf/cCC58CqWZzHU9KYaXqQUIPXcMcE=
X-Gm-Gg: AZuq6aI0gyzqip+Wl/v29qXExoHJHbQerc5HG8BJsO+G+ineh6B5SNyuTPzhihwkPg+
	28OnCSCT6fSX/uawtBlkD6cTUwqXH6nC456fTkcp6MINhu0ZtASfOrHVeHEC0mFYCrvq3gwv9Tm
	A5lb4U6OZoLrZQURIg5NcUwv316AT/Gu9dZe9riglf6brw0PndSIv2D8TfMbhLt+AJ08kk9sUNp
	EBflh/5vSosuGPj8ok66sMUBJ2eDGP5vMTLZIWfZWfDQBBlevYUIg0z5QsAi0KEzy74FrPaHbuL
	hP3x37xFxP8=
X-Received: by 2002:a17:903:1206:b0:2a0:c58b:ed6 with SMTP id
 d9443c01a7336-2a7188fd7c9mr145258605ad.29.1768955910721; Tue, 20 Jan 2026
 16:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120073046.324342-1-dongml2@chinatelecom.cn> <20260120073046.324342-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260120073046.324342-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 16:38:18 -0800
X-Gm-Features: AZwV_QgQxOYMjxO4nYabaPaUeeiBXA4-85SN2FU8fWCD6tlO5Q4-0HKOF21OwlM
Message-ID: <CAEf4BzZUA+5jsYGN7dA1qEXyZKZvBnESX=8fuJHYmhOVm0_QEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:31=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported b=
y
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
>
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
>
> v3:
> - remove unnecessary NULL checking for prog->aux->attach_func_proto
>
> v2:
> - for nr_args, skip first 'void *__data' argument in btf_trace_##name
>   typedef
> ---
>  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |  4 ++++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>

other than stylistical choices, looks good to me

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..0b281b7c41eb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args =3D btf_type_vlen(prog->aux->=
attach_func_proto);
> +
> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args--;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);
> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>                         insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
>                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
>                         insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> @@ -23376,8 +23388,20 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement get_func_arg_cnt inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg_cnt) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args =3D btf_type_vlen(prog->aux->=
attach_func_proto);
> +
> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args--;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);

nit: isn't this just a very verbose way of writing:

int nr_args =3D btf_type_vlen(prog->aux->attach_func_proto);
/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);

even if you want to preserve nr_args-- for clarity, at least make that
4-line comment into a single-line one, please

> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, 1);
>                         if (!new_prog)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f73e08c223b5..0efdad3adcce 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,10 +1734,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_d_path:
>                 return &bpf_d_path_proto;
>         case BPF_FUNC_get_func_arg:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> +                       return &bpf_get_func_arg_proto;
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
proto : NULL;
>         case BPF_FUNC_get_func_ret:
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_=
proto : NULL;
>         case BPF_FUNC_get_func_arg_cnt:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> +                       return &bpf_get_func_arg_cnt_proto;
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
cnt_proto : NULL;

hm, wouldn't "has trampoline or is raw_tp" a more logical grouping?

if (bpf_prog_has_trampoline(prog) || prog->expected_attach_type =3D=3D
BPF_TRACE_RAW_TP)
    return &bpf_get_func_arg_cnt_proto;
return NULL;

maybe you'll need to wrap that condition, but still, at least no one
has to double check that we return exactly the same prototype in both
cases, no?


>         case BPF_FUNC_get_attach_cookie:
>                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> --
> 2.52.0
>

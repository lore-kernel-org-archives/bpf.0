Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545535F600
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168778; cv=pass; b=nHF5EzjZpJAVfqHZUD4qHFRfVJkeXxn/7PUU5Gj9q5uMu4bO0vwtaS2hZrbqVfwpVwoCGdbkQXgv+5VOeENUq94B8Ag4QbyflQEyvV10gCXk8cnEEISBUJXO/RwXs0YGqSdStdqVQ3TOfzUenR2ZlFaqWSMU9OmSBWTQT3mww1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168778; c=relaxed/simple;
	bh=ZqjNWJbJmQ8nL1bGclL7WbJjk1MqSuCTT8nfhtiSkcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAsHo4WGssUAwmNjnIWyxAIcQcAB6+2+DZbAz9XMUmN7b41pYJs0P+CcNHfNdCVdJOZNP7aZJMYggYw/yzVbS0OQrORp0B32+BFF7ZAUR4XKv+bUt8KGgW+4MWYIOrtGAnkkPQL5+pQ45TrnNCQ2xsR8yuLhmALxoBqzq5ROpGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv+oNrYM; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv+oNrYM"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a2ee65171so20778667b3.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 15:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775168776; cv=none;
        d=google.com; s=arc-20240605;
        b=Gity2RfI+OXJXN311y0BIX509sQWrXpFMwWIgncSTq+PUyV7/IMjkLHJ/Isav25mvW
         LH5MetISorlyC1CdDK1lckOm1YHyeLqeOPlEgfzJzh5H1ZNqB8I/nJPREQfDS+oPMre6
         F6FqwIVuAu5ybFC1j7I4PRcAe8/BxA+qOriUH8S+00GPqwUtKLz5I3vrQv90rMMadKxq
         IWD91SQ/EMVhx1Wl0MttI67JVA08KhvLxbuSotsDJUBHiV/eEGqaY2MoXu5D+KfjM53V
         erVBT2IpS9QURWETSOePFUuNOWZlYDDz0h1ZkcB6QP7u2h5NqtTjGmIGyhW3gv50R2ca
         PwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6LHEI3WW8FiopucHtwh0ed4WUaNTj18F5QHAJf1RK/4=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=GqGaudNJ4xt+vDaEb9q8IxorrJ8KrgWuHTbwwhZJ+9P2JS76+ZWTILgh8qwKZ1NDoK
         KYUHRHtsCs4RZEYMVs5d+JvvUuDrKGE1VmIBH8w+zzBwJeL+9dAmZv+2i9aIJefu110D
         gOVszf5/bsrBh50pB/EAB/M4HYzE09yX/WmhvWXDc9UwFQqLU2tX5zJkbkkl4LIpUD99
         7OwBN6qSdaF/NBMBIjID8vS1FnwkdH1M7tgcarlPo3Wk3ByVv3FG1OroHoi+hlnDXr59
         RVZ57fUpqO83FLI+K6XPWH9daX+jCxl3vYOotH8Iv8gg1hKoQCyQBqYI7DoE6h0UNgM6
         tppw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168776; x=1775773576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LHEI3WW8FiopucHtwh0ed4WUaNTj18F5QHAJf1RK/4=;
        b=mv+oNrYM1sC4mTs+8g4fYA9bwwWhc5WdyF+H6EHUegheLlA0r5LeDNu9xbEqnuR7cH
         RRzKeAqJ5h5w3LX1dJof9htHpLkYr3EMpCvKj0LF6q4ecttkIoDNdeuEavOn7P98X+gJ
         x9TC9jn/TckPFmwz8F3lWMt3ioxTqDd88cyCKPPk2wsRWoGzJ3RyzCv/poYA2slEU0Vd
         J13z1xLMT5L0edJmtoOfPQIkZALH4caYH+3kOQHwyPTR4UJjSwU6EpDgYmP0TqvoxBn1
         TrtGrAJN/sQJTK6VTHSlCIVOloBHIBkFk2yeUO+rfVIjk4V/wDEd4/xCiZsKFtL2NVmk
         862g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168776; x=1775773576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LHEI3WW8FiopucHtwh0ed4WUaNTj18F5QHAJf1RK/4=;
        b=jVogK2xlj2UiGHsHhejV47NzIzeJ0zpqDYOf1esIKxm3yKTnmW6ShY4OeXDWISXDR4
         1mJ/D+embWA4LIuHfSVBzqBeTD77V7LUUYyAxehuxVMs1bRZRp4Nbmw4fw+7LwcFfRLS
         zpqlrZWRPRlPJk0T67ESQO9YJ1d2W5pNmAr+4FHl6ZI+y0JAJLzBB2PSMNACXZHYN2um
         UXB+fGCcweroFcy6SJ+RUg+CcZ5/CehtpmFT0ET8HQSRz+M0Wd9rH9zVgXyda2K/frIf
         jUoPk5KDc7x7Kfy1ZZTRdJAGErTKrSMNvWDBXqA444pvB3dDkFt4DbIPJbvzNA3SsoiT
         RC4A==
X-Gm-Message-State: AOJu0YxwRSJoYwP+En+pm4u0q2hn650LocpdF8X2f9Sc8Tr3fCvxuu3f
	E3KQU7QrPidNFk+ok19TvUWZMmPTDyh4v++tEo+6OHS08PjDoEMXtQoUL7lpIX6sgjlvUu2BulA
	DwuyoLYrOzh9bMmhHe41bitOl7B2W+l8=
X-Gm-Gg: AeBDies2j/Sr127NScYAmgu7f0biBV+vBv62jdl/D5phVSIX2vabdPJjzieJaMJVngG
	D55fnI1E3IF+FyAnfL9/G8Ezw+n1NThFkQomKNshoDd15reAb0TtW0LkFqukjubAZLUqVgq9a8a
	bBskDWNC77AQnIN+f3HJHZDj627NFOIsqAUIy6X4EbyJMSdO4Af0/RvdxWuCjT9M/05nXvKfM8k
	lrrocnFcRgS/kyyjW8yS4t7tF03gI4he5WrQ5azYPuBhGjMf9CDZ+2UA0dmcKeUVbNFMJSFlFcG
	/L3fxEw=
X-Received: by 2002:a05:690c:2609:b0:79a:b409:b62c with SMTP id
 00721157ae682-7a4d3dc879cmr13014277b3.22.1775168776348; Thu, 02 Apr 2026
 15:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012803.3920450-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012803.3920450-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Apr 2026 15:26:05 -0700
X-Gm-Features: AQROBzBdJq2-XiLjLgt30VfVNynbwGHKWOM6xJF7qawMTZsea0kXEH08SiJQe-4
Message-ID: <CAMB2axMGn8wWTWDiDQUTAS5A2Ey0FGMxEu-FryvaLAv_UBhrTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf,x86: Implement JIT support for stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>

[...]

>                 case BPF_JMP | BPF_CALL: {
> +                       int off, base_off, n_stack_args, kfunc_stack_args=
 =3D 0, stack_args =3D 0;
> +                       u16 outgoing_stack_args =3D stack_arg_depth - inc=
oming_stack_arg_depth;
>                         u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
> @@ -2449,6 +2549,29 @@ st:                      if (is_imm8(insn->off))
>                         }
>                         if (!imm32)
>                                 return -EINVAL;
> +
> +                       if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_st=
ack_args > 0) {
> +                               n_stack_args =3D outgoing_stack_args / 8;
> +                               base_off =3D -(prog_stack_depth + incomin=
g_stack_arg_depth);
> +                               ip +=3D push_stack_args(&prog, base_off, =
n_stack_args, 1);
> +                       }
> +
> +                       if (src_reg !=3D BPF_PSEUDO_CALL && insn->off > 0=
) {
> +                               kfunc_stack_args =3D insn->off;
> +                               stack_args =3D kfunc_stack_args > 1 ? kfu=
nc_stack_args - 1 : 0;
> +                               base_off =3D -(prog_stack_depth + incomin=
g_stack_arg_depth);
> +                               ip +=3D push_stack_args(&prog, base_off, =
kfunc_stack_args, 2);
> +
> +                               /* mov r9, [rbp + base_off - 8] */
> +                               off =3D base_off - 8;
> +                               if (is_imm8(off)) {
> +                                       EMIT4(0x4C, 0x8B, 0x4D, off);
> +                                       ip +=3D 4;
> +                               } else {
> +                                       EMIT3_off32(0x4C, 0x8B, 0x8D, off=
);
> +                                       ip +=3D 7;
> +                               }
> +                       }

Do we need to make sure RSP is 16-byte aligned before passing arg
through stack per x86-64 ABI?

>                         if (priv_frame_ptr) {
>                                 push_r9(&prog);
>                                 ip +=3D 2;
> @@ -2458,6 +2581,14 @@ st:                      if (is_imm8(insn->off))
>                                 return -EINVAL;
>                         if (priv_frame_ptr)
>                                 pop_r9(&prog);
> +                       if (stack_args > 0) {
> +                               /* add rsp, stack_args * 8 */
> +                               EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
> +                       }
> +                       if (src_reg =3D=3D BPF_PSEUDO_CALL && outgoing_st=
ack_args > 0) {
> +                               /* add rsp, outgoing_stack_args */
> +                               EMIT4(0x48, 0x83, 0xC4, outgoing_stack_ar=
gs);
> +                       }
>                         break;
>                 }
>
> --
> 2.52.0
>
>

Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807739281B
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297987; cv=pass; b=CsmtStLTjg7UsqLqaMqdRQZmHbpPVvMZM8lCb4g/tPzb2U77qPbzGM5h9tL6ttukSnc83vcUGtch/+dRk0UlI9vgyAYyJYVd4S8J+R8cAV+M6bZUxYV6xrEtLZ+TNsaKZV2BeyGX3HLOfjUThD52gUbZbrbw31JQiFef8HTwu7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297987; c=relaxed/simple;
	bh=WDzlafYqcPtRvqgt2YDKsgLzfkFYYrLvme2Ey1+af5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ4k0yBq/pn2EMYk6yHmXlETSOMw56Ao6FrKPIwZ6168H2jWhwf2G1UZA5BAlJjVFMtJhNd0nVFX48DQTf0s02E1/d0n2H7aGDaguxsnVH2w07hhrF49vP6KlA9DM8i95AehJVow2Ye6hT0JLHpRZGuDzPHcufMY081u5QGlur0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBncbm+j; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBncbm+j"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d5468673so488197066b.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297984; cv=none;
        d=google.com; s=arc-20260327;
        b=Gy7gr6LxgyjBUJhEH5kIRCXYdpyRXwjE1Xxqcxu9VDrlBnqpkg9Riw36+wnKDEsTNn
         VKdd++vD+XvSpU3F3XeJbUUXPIZJ779pI0kolPZT6F91lMwEyT+PXkYOT6Yn5njC43C0
         lylWbkelyFku82mNrhXhKZgngrN5OrPb44PG4uBet2yLqEI4rRbI8tP6uo5V83qT9MQd
         EbEKlAmHMjn/UQCIWDvjdQtJq3uxVux8eXebJ7eK9EjGCzev3DwarzpH37ueFvrlADOB
         LWt/gwzzw2wCQiLLgfYfA2DHD0Rk1qn+WLEJ33MLkdaR23V+DQggKExknJ1HhwDgLNwz
         hGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUWqjUspAj+aYJTA8/Zllzt9Grl1pde1TqS54zhQD18=;
        fh=z7d8yaISeREwZF+P99U78KFTrwnbWYSlMju373c1WsM=;
        b=Jq9VzSZYFwEgFGAyRWSuJpzzrVwapS5WySBd8OoMpCg8MitOFg2O1f4/jJSAWN/sKg
         cWT0nqcwLf2woTwVZDBv55SE80fwJ78M/+DkYk/vyk3QUOvV6uyaiixoE4TljIM3j0Zn
         ZIl5l0fCadWf9M0ttR6qBtywCzs3LGd7joB083U4WDlYaFxOIXjU2i0sDjEy1uypC3oa
         UXKzR0Ql/SMlXZhAailTz2zvzqHCLtV7OcEWSEuI7N8fbfJ1WWX2LM1h4huRgD0sbvo0
         voef4HHb888KQBmnPqU03x2iVXEH9+w00DwrKnl8xqsSk50b8vMd81puQLekuMECuLwP
         Vl+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784297984; x=1784902784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUWqjUspAj+aYJTA8/Zllzt9Grl1pde1TqS54zhQD18=;
        b=nBncbm+jVOi5etXvnHHm8vUc9Xm+lIbkewTYdfaLAMAuo5cJBSGOglau9oBz2etcTW
         h/ooM1C7offrppW1mExAtrZGMEv3hkY3Q2+O3chM2m7B3qmPpQW4BCtScIindwZrySF9
         uaWXAqOJgBrojwWi2TsDnABKYHJGewwBCxgftPUFZKhujhbBRsafD2hRUfwLdXuFPaRD
         DkfWuFtmBQjCKMwlkyEXRFfMU2r9IRhxf5o9nV0Ghew0c7r5q9pi5ihdY53O4TfUBYcp
         sL3XL30tsL1lsS9TdHbeabIvjicdAH4ctAOEBgNv+q8hWcd7sq/14cwp1/xglb31Bq8A
         qluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297984; x=1784902784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUWqjUspAj+aYJTA8/Zllzt9Grl1pde1TqS54zhQD18=;
        b=qt2g0FGULgQDv/66uPiuePFMNIwNKbx/cDYWa1H38K2C1A+jURLp4dbzaJoXsgyoRT
         MJJTQZRwDa1GUQew98D1c/TN1EChXmpxVct31QrnFwzU0akAE58XXtEai+2Ze4TmpNnS
         /NOxDdNZeV5hgQrhUA41FTBdtuRHLt3Tw15V9O37A+S43ScAbOKJcGM33AFz4VeJvNCS
         20BAfO+sueC0ZUhYJefls5EJAL5QvNBaRKyjNC+M/eHhcbDFsWfHj04cGUVu5VsXrd36
         Tz+cdMANEKtF0fQ6kyiY9Mm0eSlPSM24EHsqiMZqZ56P43YFg3AIV45efMOV74zySZfo
         SFHw==
X-Gm-Message-State: AOJu0YzcFbbgEsWCPr6dtr02Y/HN2eY3Ht3omyx14okDFn5X1xjkjEqP
	zaAtOfA7ZXtt5I6Oku6wRPEiDWMhI7yBktK6jMwdg+HXnZJlzHg1VqKjn3sX3DBV0S5yGKVUsKy
	3y73l/OGaP/6MebUIf2hzrzhaWSyp40yFGjdZ
X-Gm-Gg: AfdE7cmz1Bt//UVkxd/8l0auRwIr17sJqWmbpuBCDdiXXU8LYHktGcnBn9OnXN/D8hG
	YLCsy/4aJ+mFvff23ptvxa0LFX1gxCrzrqWOPOXEucSihsCcIbcGoVZWlvu5Xn0O9gEHxyezURq
	JyQpWWeLUbMsy1b9Y3YvadN7fmhRR1Wx+XG2Yz/sfZ0V+m5Eo2ATupaUsk+paP6+T3sboZkSEs4
	W5c9VS4/U78or9OdQEjx1rXqMfxnDT7SzU+d4fPHfmVZhnOGH/2KUuIJIAS43aIaeBuea6M/cgW
	4w==
X-Received: by 2002:a17:907:d11:b0:c16:5897:566d with SMTP id
 a640c23a62f3a-c16b4884786mr133897366b.38.1784297984410; Fri, 17 Jul 2026
 07:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717134817.2868291-1-puranjay@kernel.org>
In-Reply-To: <20260717134817.2868291-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Jul 2026 15:19:31 +0100
X-Gm-Features: AUfX_mwwQMRDyAjclmpoTjRwL-uqBMgRWlzKx9zsZQrrViAKbgAiPYTEbY88H_I
Message-ID: <CANk7y0iWkFe1=0hg6_h7YgMp+LK1HGGMheyPR6syPFDinRWafg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Optimize cast_user code generation
To: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Xu

On Fri, Jul 17, 2026 at 2:48=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> cast_user converts an arena offset into a user address by combining the
> low 32 bits of the pointer with the upper 32 bits of user_vm_start, while
> keeping a NULL pointer NULL. The current sequence always emits six
> instructions: it materializes user_vm_start >> 32 into a register, shifts
> it into place, and ORs in the offset.
>
> The upper half of user_vm_start is a constant, so it can be written
> directly onto the offset with MOVK. Move the 32-bit offset into dst
> (which also zeroes the upper 32 bits), then MOVK the non-zero halfwords
> of the upper address, branching over the MOVKs when the offset is zero so
> NULL is preserved.
>
> This emits at most four instructions, and only one when the upper half of
> user_vm_start is zero. The generated code is equivalent.
>
> Before:
>   ; bpf_addr_space_cast(page1, 1, 0);
>   7c:   mov     w10, w8
>   80:   mov     w8, #1
>   84:   lsl     x8, x8, #32
>   88:   cbz     x10, 0xffff800087b80c20
>   8c:   orr     x10, x8, x10
>   90:   mov     x8, x10
>
> After:
>   ; bpf_addr_space_cast(page1, 1, 0);
>   7c:   mov     w8, w8
>   80:   cbz     w8, 0xffff800087b80c28
>   84:   movk    x8, #1, lsl #32
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index b0075ece4a6e7..c6756b964c843 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1284,12 +1284,25 @@ static int build_insn(const struct bpf_verifier_e=
nv *env, const struct bpf_insn
>         case BPF_ALU | BPF_MOV | BPF_X:
>         case BPF_ALU64 | BPF_MOV | BPF_X:
>                 if (insn_is_cast_user(insn)) {
> -                       emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov cl=
ears the upper 32 bits
> -                       emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, =
ctx);
> -                       emit(A64_LSL(1, dst, dst, 32), ctx);
> -                       emit(A64_CBZ(1, tmp, 2), ctx);
> -                       emit(A64_ORR(1, tmp, dst, tmp), ctx);
> -                       emit(A64_MOV(1, dst, tmp), ctx);
> +                       u32 upper =3D ctx->user_vm_start >> 32;
> +                       u16 upper_32 =3D upper & 0xffff;
> +                       u16 upper_48 =3D upper >> 16;
> +                       int nr_movk =3D !!upper_32 + !!upper_48;
> +
> +                       /*
> +                        * Build the user address: the low 32 bits are th=
e arena
> +                        * offset, the upper 32 bits come from user_vm_st=
art. A
> +                        * zero offset must stay NULL, so branch over the=
 MOVKs
> +                        * when it is zero.
> +                        */
> +                       emit(A64_MOV(0, dst, src), ctx); /* 32-bit mov cl=
ears the upper 32 bits */
> +                       if (nr_movk) {
> +                               emit(A64_CBZ(0, dst, nr_movk + 1), ctx);
> +                               if (upper_32)
> +                                       emit(A64_MOVK(1, dst, upper_32, 3=
2), ctx);
> +                               if (upper_48)
> +                                       emit(A64_MOVK(1, dst, upper_48, 4=
8), ctx);
> +                       }
>                         break;
>                 } else if (insn_is_mov_percpu_addr(insn)) {
>                         if (dst !=3D src)
>
> base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
> --
> 2.53.0-Meta
>

Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451F125B9
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254474; cv=none; b=CgmdIJyEsJR9okZoHqy5pKPl/Sk3cm6fRIHvZxNlZLUiIRwIOBsJxl6MxHpXT2ZKQE1bi7l00g3rBPXyZuFjENKL4xxbOD9kgPsID7ZO8nQRNVNkjkdVaYRtwuq4rUfI6h0FdmwbzATHrOGHnrtgzzYAjbLeWfU4fkW37YNNSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254474; c=relaxed/simple;
	bh=xC+znJRCv2fngTk9Bp1e8cykr7DSs4zI7DcasUpfn2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMvKIcGlPG/+csBHua9xm7IaAxyoxkBm4dCODOr0C7YZmBE3OV0F0/VUqV4D9iC4aLuO9aAoyKT9bM+MEzHgcEPN/kvXIzQMByfnn4SND0ss9E69USlIIkawlegDDYDL0vWYBhUh9K1SefxguG31cy4Qgj+iTprwoLEaFS5r84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDjlutJD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjlutJD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3438d7a05aaso820383f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712254471; x=1712859271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yItK4Eh+A2kj0Xu5d7eP9bqGVKHTs1G/+wxDBOt6iR8=;
        b=TDjlutJDzED+axKHKKwNjEMb4cQiX/vtfDk9/aZpMlyI1CqsocKOx6Kikerzk1n7Gt
         jovH3F348B3b4hSzlKxktP+/81oYixYJd7lwCLlam1Ky9LqdLpUpUikROZtmYrniZC9p
         FxiZl57iO/hZ2mTwMnC3X70IGLA/LEVeVYfIaAF42mblECcEOeezmwCs/EadCCj0BV1H
         hb0hucIWdYV40nTGl7notW4Pa1B3bH+VWVKmc9BF38b3lvIydJl/WBnjamwSh5PWN/Hr
         RzeaYx4bgkBJ1E5pLoiOaPWlb4RMWEqpAFNAxU+bJnCzKnnW2vKl3qhgoqVJfoN7HBI4
         n/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254471; x=1712859271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yItK4Eh+A2kj0Xu5d7eP9bqGVKHTs1G/+wxDBOt6iR8=;
        b=rEw7qQ3TOm+M4XVAHfDiwg90uWkxG/MlXqBH7bjamIVnUXL0sHjbmjS1oNeceeiYBB
         EqS0kwQDolgQLEcuKqRAgnMAt7cBjuhFGGuTEnYDYEcDMMSx0hatuZJrT658khZTT/nK
         DuT1G7ObXu738EjZzWmpPwTxKbHceLIn+6ankUGI/ZelnxF4Y6a26uyDyQa35U+dEeHy
         TyIsNfGCaxqnlu+kuRcSMusZb/IxTG9ptAXFV3h1aF+tY29fIs6/Xt+fb1GDOFPFh5y0
         E0b5PDiH+BA7BtBAFZ7pGVjK4p3uiFmCC20toOeJ3SKy/sNT04AnDK3ijchUXCsj1N5G
         a5JQ==
X-Gm-Message-State: AOJu0Ywv92tyxTcvoY78+BNXiyM/j3erBu8O5fpAmUf1uAIMCUHkJJ+H
	Pe/Pfo5/KiOnIXovhgTS7lOCLPK5erSJA+exGHHlX35GewmC2dgjrwzTIAkpJfrtg4dFIKZWHV8
	Hkd40D4C4t+SI0ddXtCq3Wa0u7Xs=
X-Google-Smtp-Source: AGHT+IF+6AO+QszYKoEN2viIxkS4wHtmzYKItAv4OsDVYBR8YMLN8j/HOd/qGqJf/28GP29WEHrBohAdCwgGMaB7sF0=
X-Received: by 2002:adf:f9c7:0:b0:33e:c91b:9083 with SMTP id
 w7-20020adff9c7000000b0033ec91b9083mr197721wrr.16.1712254470778; Thu, 04 Apr
 2024 11:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404002640.1774210-1-andrii@kernel.org> <20240404002640.1774210-3-andrii@kernel.org>
In-Reply-To: <20240404002640.1774210-3-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 11:14:19 -0700
Message-ID: <CAADnVQKc9QgOxvru-tqii0GO7H5+QD_=_v3O7_ant4BU1cNmKw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:27=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> inline BPF code which calls directly into underlying callback of
> perf_snapshot_branch_stack static call. This callback is set early
> during kernel initialization and is never updated or reset, so it's ok
> to fetch actual implementation using static_call_query() and call
> directly into it.
>
> This change eliminates a full function call and saves one LBR entry
> in PERF_SAMPLE_BRANCH_ANY LBR mode.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17c06f1505e4..2cb5db317a5e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20181,6 +20181,61 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> +               /* Implement bpf_get_branch_snapshot inline. */
> +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> +                       /* We are dealing with the following func protos:
> +                        * u64 bpf_get_branch_snapshot(void *buf, u32 siz=
e, u64 flags);
> +                        * int perf_snapshot_branch_stack(struct perf_bra=
nch_entry *entries, u32 cnt);
> +                        */
> +                       const u32 br_entry_size =3D sizeof(struct perf_br=
anch_entry);
> +
> +                       /* struct perf_branch_entry is part of UAPI and i=
s
> +                        * used as an array element, so extremely unlikel=
y to
> +                        * ever grow or shrink
> +                        */
> +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> +
> +                       /* if (unlikely(flags)) return -EINVAL */
> +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0=
, 7);
> +
> +                       /* Transform size (bytes) into number of entries =
(cnt =3D size / 24).
> +                        * But to avoid expensive division instruction, w=
e implement
> +                        * divide-by-3 through multiplication, followed b=
y further
> +                        * division by 8 through 3-bit right shift.
> +                        * Refer to book "Hacker's Delight, 2nd ed." by H=
enry S. Warren, Jr.,
> +                        * p. 227, chapter "Unsigned Divison by 3" for de=
tails and proofs.
> +                        *
> +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^33 + =
1) / 3 =3D 0xaaaaaaab.
> +                        */
> +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaa=
ab);
> +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_MUL, BPF_REG_2,=
 BPF_REG_0);
> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_2,=
 36);
> +
> +                       /* call perf_snapshot_branch_stack implementation=
 */
> +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_query(p=
erf_snapshot_branch_stack));

How will this work on non-x86 ?
I tried to grep the code and looks like only x86 does:
static_call_update(perf_snapshot_branch_stack,...)

so on other arch-s static_call_query() will return zero/einval?
And above will crash?

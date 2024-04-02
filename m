Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6A1E531
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100160; cv=none; b=i6QAOq8G1UmzHSJ2+DmeI7u0YTF5dq/oqZPsDuDrSNMduybzhjGZL92ftZd7oG0Z7H1StSn6iaJV26cXqS5dbzjYZe+oNHjdqkJQwtH78uT0vkHcc4WJzu7KxJFD+aeljHGrTXXmtYbJZ7TvOdWkEOKLZyMJwYOiigEq0AneFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100160; c=relaxed/simple;
	bh=f2Y2UyFRgV6IRbEXrwqUh838nP/Uv1K7YqPTC9HhOgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy6P7eq+XY56zH0pke0fKVish0CX0k6hW3rVwVfK5JQUfyQAvhXW9pxixE+8vjogA2EplPcXanN1XR9ARCcEBZbtBLc4r5e3QVQNGLXMKCEOjP8eGSoP6kacPZvT8fu7Enntayc06xPbDCMpe18D3UZI8695jRNssLFWLsrzDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyIW4GWf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyIW4GWf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5443948b3a.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712100158; x=1712704958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy+aXs/fZMafeXSBVhJnEsX+j0urVXp+Og0PWOpUCas=;
        b=FyIW4GWfJiXAv2iC6zX5wgSd7P4zynOvqxyXSsym+GIFXjipIGtBpacg/KTgG+G4SW
         b87GV8nAYUpdEBEa6ujIxambbhS5K265LeamcR5/tK8xlgYn+Vu1gRkQeoW+iJspdkCd
         ILWJOTYVW8H/RghPikZng5rNRwHOipsvcLfafM+5fejUqs+5C1vQ2GRsgiwT9zmNkuVt
         sul/HoZOYHVq8kSNEQmDhbFoqH8R7VB3iFthAy4w1Ik/dMbOZGkRpwk3oljPCSNaSsi1
         bUSlMm6wGCoOkJ1AU4LJ26OnEEPp489YBpCa3jidsCzrHZg3QTEIo7TGOj/LhfQ6LOrX
         3azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100158; x=1712704958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy+aXs/fZMafeXSBVhJnEsX+j0urVXp+Og0PWOpUCas=;
        b=ULXh4lDBH+qetnVOWM/ZbXj4vyVTV2R+pKCC2hA9kRtg2Es7yawETQ5t+KDLxXGn54
         pmUawiOaROD4bK9yIKlPpBG3ePD5o4QURl2/UivT3N/PwdpzZdV/Wk7zsFZLJYFbaOoV
         oT3ldCs7/kfVEGtmgCXGeMhnxA97RNQ1lX/Fu7YTqu7TyF9nXPsYmQwMwh5szIJEWkc+
         aOUvK8TMHHrTkPKJJauqFt+ed1lboXIae/N2FIfiEmj+nfeSSTSDdkS5LotP9xvBi/+6
         No3mOdD99XHky8fSGXZaVZpcBZ3gKMN+cE8nGpB0j6RK42vTyUd3IYnLQypRUFSKSG9d
         Umew==
X-Gm-Message-State: AOJu0Yy6uusomO168sfiy0DxA92C+Ynnv5NYKU9jCDwlfRwZxAjl4y8I
	Bn2l0tXPJhkblPFIAzyuV9MfOkk1S1aIQ1h4KLj/7rOigvQAI5h0tQL+ox3ZjG5smxSRQfkejdy
	KSjnfDYBsHrLMAqr0tu6/Sp6CKM4=
X-Google-Smtp-Source: AGHT+IFcfrE8EBkTx1akU0S6nJM4TXZXgk3uFjiD6qEIBqzpuItiQTvQ4C5Qzf55bdM0ps3JL2nBQ8OMTTUciE3FlOI=
X-Received: by 2002:a05:6a20:d705:b0:1a5:7979:3349 with SMTP id
 iz5-20020a056a20d70500b001a579793349mr16604699pzb.6.1712100157588; Tue, 02
 Apr 2024 16:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402190542.757858-1-andrii@kernel.org> <20240402190542.757858-3-andrii@kernel.org>
In-Reply-To: <20240402190542.757858-3-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 16:22:24 -0700
Message-ID: <CAEf4BzZ_6hzWoniF+6jb6cOXK48EHNMH0ziZ1o26KW+Zo7OKyQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:05=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
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
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcb62300f407..49789da56f4b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20157,6 +20157,61 @@ static int do_misc_fixups(struct bpf_verifier_en=
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
> +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_REG_2, BPF_REG_=
0, 0);

Doh, this should be:

insn_buf[2] =3D BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);

I'll wait a bit for any other feedback, will retest everything on real
hardware again, and will submit v2 tomorrow.

pw-bot: cr


> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_2,=
 36);
> +
> +                       /* call perf_snapshot_branch_stack implementation=
 */
> +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_query(p=
erf_snapshot_branch_stack));
> +                       /* if (entry_cnt =3D=3D 0) return -ENOENT */
> +                       insn_buf[5] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0=
, 4);
> +                       /* return entry_cnt * sizeof(struct perf_branch_e=
ntry) */
> +                       insn_buf[6] =3D BPF_ALU32_IMM(BPF_MUL, BPF_REG_0,=
 br_entry_size);
> +                       insn_buf[7] =3D BPF_JMP_A(3);
> +                       /* return -EINVAL; */
> +                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> +                       insn_buf[9] =3D BPF_JMP_A(1);
> +                       /* return -ENOENT; */
> +                       insn_buf[10] =3D BPF_MOV64_IMM(BPF_REG_0, -ENOENT=
);
> +                       cnt =3D 11;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       continue;
> +               }
> +
>                 /* Implement bpf_kptr_xchg inline */
>                 if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
>                     insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> --
> 2.43.0
>

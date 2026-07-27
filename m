Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668A3E2AAF
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194725; cv=pass; b=qg6UnbUHVbqyyUAQcAi4F5OiJ5rLOFHiqGBm23LtotUNFUJsuuInQWEVNLN2gLyfqNeFWjd9POV5yAtsaXq5Immq02IGOXQ40hbtbjC72zG5/K1q/44L9QQ4oyo+ZTcmO1jPaNwx9Cn1RiLNaShn2iS2o6CLTnZaNxR7lyUNtjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194725; c=relaxed/simple;
	bh=cOHpzjT1IEM+2lfpWEsTkc9ByX1KEhogznLDJEelk9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiBnWiszc8WJyUhANlU46VKd/Sup3gg521FxgihuyKUO73BTx6S2H2zuMWxo9FNpKuPZiocY13xRG04Bi2g5f9RnbbP/LFZVLfGeZWSvd7FrS3hPETj5XeeVIB+Myfxlqi2H+gW34sRHsii2W1+Tx0WVeWyfxUIU5uaEFnreBK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2TSo2GK; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2TSo2GK"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8486672f03cso3184232b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194723; cv=none;
        d=google.com; s=arc-20260327;
        b=r8XJiXHOQ7IMGDOYP868RFG0gsb3aBWxj1mEvP1650C9ps068ctEDn4Hm9Og4pdEm0
         AylUSb8h+PHuFqhmI4dn9bH2ATvpm/weTMrmEMdXI2vikxIL2k9ymhBZ7UQbunWLqQC5
         V/21NbBNJX2npVN/cLXfjU6G5FnmUfwh+HmUO5nzrYnGlVmui9JLKDN3Vi4Xq0lz+nlx
         GXk7JU28XsrHO4jbLliE1QwTV7WQi4dEpIzOWeQzbmsyo58ynEGFYxQkwdhYy/QZPW+y
         NZVijI8PuI267nlJ3d0Y4LTE/voAU6xgQxzCw605N0GjRKr6+kGfcYdPU/Zel1BbvpDK
         8mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/SPPiad4dm+qHp+5/RH0lY5GD5SzTTfZ6tTuWYxR0M=;
        fh=w3JJtTNRsxqpJwK33t0JV0HpJg2jhEgYK9hAgRRg/Ls=;
        b=prgctxlzhTD15wKdwIBAnJlUbZFYiKtE4iEp/o7hp+e4huHO0I9sVe/XKv8yrzF1Vg
         VOeklGULCMv0W1p1PLmyOWcd1rDYuzza6/GDJOdihJRSQSHof9Z4JSLRAbFXqYHrpw/W
         BKr850iINmPOTrHMIImIEvUMq58CnJde4R8pURGx+weF9aBKXazBzdbsxWKbcyTF3fHH
         YznesG56BLNcxHaLOYA4ZkcosQ51sAgP3iT+LkQsm41IcoJnw5/Lw1gYUQSdZENzoSno
         eq1Za3kyrVmeMmUa1JEqymyVj1TZWuQ/CbWLN3m8lnscc+J/8nSb4yoMDVb0beu3sQVs
         YJrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194723; x=1785799523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/SPPiad4dm+qHp+5/RH0lY5GD5SzTTfZ6tTuWYxR0M=;
        b=W2TSo2GKPix263PnPxh9WICliclKxMCCzRrubDtMTSIBq+O0FvZJwl3ED9ZqTc5Zig
         PmAW5dPXAbIsxKCneVbq7/y3CHqZAJBWxRRlcSEiVPCLtEoaTkfwFb6o/t77LMB55Jvq
         v6ATjEtBnXjYg5LJFh49/Klbbxyg4b5GMNvU1sj/HM9kVEQ4i7wlTmybH2eAH1k8eEtE
         ZfOQmP66+v+suUjpNy4WYY85lzcRsMlL/IvO3fTQQlLvaReoX8ucsKzjDFIX6FB9DH0y
         R9RiPJ4O8zfDbQvH1bN0W71BZBqiMlLgMeO1k8c1UjTgJxjgVWt57JW9rBUaL7xLtTF8
         oj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194723; x=1785799523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/SPPiad4dm+qHp+5/RH0lY5GD5SzTTfZ6tTuWYxR0M=;
        b=H7OX184z1VouPmSNnQcJd4V4SOrjFcs8WHAUXi9ylFH3JNDODgSQ+wUQJaHW7uLRCH
         zhVw37bsHZJJREvhjoZfUVgTNNaR9FB3tV9hdRCXSk4uY2bvCOLMPrKVcbGRmq98kNof
         13PpDwZWpkdjAPzWwD4cn0tIVPwGwTtk5+xmGK8hNBJzL/PJ4u954p32vcMsn0uDoGv7
         vXKTTXHAFNQ6F/KrHmGuXrV1pG7ToNqWLrgrKkCY8mKZd4/6UeJPta7HJhRv33kXamBy
         e0GLQbwSeX7Re/wC+TU8EOGDXb2VhNUjN6unkOUP/3M4hEZphvduFgjEJpr3ZTOABkFD
         8Zpg==
X-Forwarded-Encrypted: i=1; AHgh+RquvLrstIddmhPjKLIGnocw1cdYHaUdOliILLYqqWR7CSmnZB7gLCsrmZy+LImAeI1yUg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1nOIq7xRQEAvcT5hzXiS27OXvYHLfL9Tr08nhYaCkh4zRq9a
	owD/I6wwmCHxPY7BP2L13cOCbc/vKJtYuPx2FuC9d5N8BNDAPDTz+LVGWeAz79kz4HfUSHhf919
	zbnk1p0s7KOaWJir5pVNEVgLoA2zVYIU=
X-Gm-Gg: AR+sD12eM2LAOF8PPdNOzB9nk5DBvtOJ7rnZy1feyodCP4o3nqiShvE13oN4kiA47lc
	ehdqenGKdm9QRNstvpNuAeuhCPNHxVXrOnCcT3Vtp/lfAvnVmq1eWInHnpYd+0XazBDWMhKTuup
	ycdAAfKizQMtWOGZiBfYjF0szBXsfWZgIvxRWouNbJUsF3x3n+m1AN1gtdH3sECOHgltxYOllIL
	s6BHiiD/yMdn2iQIzmxZBJHZtnU5uUEQNWgS9FsZPqtF7aNPuP4XnqntrHgh0UB2mN/IAUzNHtn
	PSHcu6kyWEkBdihJ+8Tr5b8xwklKyH8JL/r3/HCo4pcm2VmOKXOkgIittQ==
X-Received: by 2002:a05:6a00:331a:b0:842:6849:2180 with SMTP id
 d2e1a72fcca58-84e5954354emr8328718b3a.37.1785194723534; Mon, 27 Jul 2026
 16:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-bpf-lskel-fixes-2-v2-1-1ec545c6861c@google.com>
In-Reply-To: <20260722-bpf-lskel-fixes-2-v2-1-1ec545c6861c@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:25:08 -0700
X-Gm-Features: AUfX_mxOPVHL4NwdRvbXYxOP22Wj4tcAIihOVRw56mXTOYAsc1RPet3sDtb5F7w
Message-ID: <CAEf4BzbAjP_r7T_7dV4YMJTb0GnuVi0Ed_Oj7r8hia2xefv=ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: poison unresolved weak kfuncs in light skeletons
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 4:41=E2=80=AFAM Siddharth Nayyar <sidnayyar@google.=
com> wrote:
>
> When the light skeleton generator (gen_loader) fails to find a BTF ID
> for a weak kfunc, it correctly clears the immediate value (imm =3D 0) to
> convert the pseudo kfunc call into an invalid instruction.
>
> However, the generator fails to clear src_reg (which is set to
> BPF_PSEUDO_KFUNC_CALL). This leaves the instruction looking like a valid
> pseudo kfunc call with a zero BTF ID. When the target verifier's
> add_subprog_and_kfunc encounters this, it unconditionally scans all
> BPF_PSEUDO_KFUNC_CALL instructions, sees imm =3D=3D 0, and panics or

panics? as in can crash the kernel? overstatement or it's actually that bad=
?

> fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks

also, I think we intentionally do not fail for kfunc with btf ID zero
eagerly, so if subsequent dead code elimination logic proves this
instruction is unreachable, it should be ignored anyways.

can you please double check, this sounds suspicious. invalid helper vs
invalid kfunc call shouldn't matter much (and if it does, we should
fix *that*)

pw-bot: cr


> the verifier's dead-code elimination logic which expects to cleanly prune
> branches protected by bpf_ksym_exists().
>
> Furthermore, when the generator processes subsequent references to the
> same unresolved weak kfunc, it copies the imm and off fields from
> the first occurrence but skips the src_reg field, meaning subsequent
> calls also retain the poisonous BPF_PSEUDO_KFUNC_CALL flag.
>
> This patch fixes the issue by explicitly clearing src_reg for both the
> initial occurrence and all subsequent occurrences of unresolved weak
> kfuncs, converting them into standard invalid helper calls that the
> verifier's dead-code eliminator can safely recognize and discard.
>
> Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC rel=
ocations")
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> Changes in v2:
> - Rebased and added Fixes and Acked-by tags
> - Link to v1: https://lore.kernel.org/r/20260622-bpf-lskel-fixes-2-v1-1-0=
04d72cba5c2@google.com
> ---
>  tools/lib/bpf/gen_loader.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index d79695f01c87..a08071114347 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -783,10 +783,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen=
, struct ksym_relo_desc *relo
>                 return;
>         /* try to copy from existing bpf_insn */
>         if (kdesc->ref > 1) {
> -               move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm)=
, 4,
> -                              kdesc->insn + offsetof(struct bpf_insn, im=
m));
>                 move_blob2blob(gen, insn + offsetof(struct bpf_insn, off)=
, 2,
>                                kdesc->insn + offsetof(struct bpf_insn, of=
f));
> +               move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm)=
, 4,
> +                              kdesc->insn + offsetof(struct bpf_insn, im=
m));
> +               /*
> +                * jump over src_reg adjustment if imm (btf_id) is not 0,=
 reuse BPF_REG_0 from
> +                * move_blob2blob. If btf_id is zero, clear BPF_PSEUDO_KF=
UNC_CALL flag in src_reg
> +                * of call insn.
> +                */
> +               emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1));
> +               emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
>                 goto log;
>         }
>         /* remember insn offset, so we can copy BTF ID and FD later */
> @@ -804,10 +811,12 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen=
, struct ksym_relo_desc *relo
>         }
>         kdesc->off =3D btf_fd_idx;
>         /* jump to success case */
> -       emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
> +       emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 4));
>         /* set value for imm, off as 0 */
>         emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, =
imm), 0));
>         emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, =
off), 0));
> +       /* clear src_reg (and dst_reg) to convert pseudo kfunc call into =
invalid helper call */
> +       emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
>         /* skip success case for ret < 0 */
>         emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 10));
>         /* store btf_id into insn[insn_idx].imm */
>
> ---
> base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> change-id: 20260622-bpf-lskel-fixes-2-758036ae9911
>
> Best regards,
> --
> Siddharth Nayyar <sidnayyar@google.com>
>

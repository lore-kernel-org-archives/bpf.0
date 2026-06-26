Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9513B7AE
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434764; cv=pass; b=fX6DWGbjntR2r1thbAvG4xgxG1Ortw3Jsu8zlT7/9nU3P3rtXXexBqjsYf69RjRz4iPXooVbgJl51BUQWqJzICmnvrjaqf7g5k10qigy+AXJt7LdOfk5fTCbhrlyfXNQoT9880qvl6qdI7i/Oc/nMBQ/u/XHe2QdxEQ4d8y/U6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434764; c=relaxed/simple;
	bh=UkFAFs/KfpdGrOZkfeMJzNBsdoM6/W8MduVEazJi6/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vlt6ndDuoHL6A32s8MnT9IXI4LYrJG+cIBsu1SIJpYkYa2RiWMBDHemkk6fmvixpLIK+K67cjA1cmvSVH93K2KMUK06gShlSasY2r3Vh3u5G5MO6HRgRc6KKVKg95qbBq2efhHgtWsD/kRji0GjVRxC03XAhRfli4i6KACxwvtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQOx6G16; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQOx6G16"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845c38dee22so178163b3a.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434763; cv=none;
        d=google.com; s=arc-20260327;
        b=eSMgpEpKa+d+v6e5MpWTVb1NWSLmMO/xXiK2/SKCqdSI2jVGtc57k3g6XfF7p1Phnl
         wxYlGM7I18FhHOEG6oDmaeuLmg6VNWK1S3WuwDyRtlQezqSrL49DQ7lMO8DvlcrWxCF8
         4pIoIAVo/TL8hT2snIk7wew4OaEssSUCiLtJxcCFExHZpNzww/twB+K5OzLg+iJMa+1Y
         oYKdkI/sNeF5pEk3lcX1p0jv6SZXFTB7Zz3W6Xo6zPztSRHsKU1dJS1MakTL7NcnxHqH
         nPRCWvHEmHoCT9xL0+AfL+tKwep7eGfsnMfASiyoycR0oCDb7biHPrBdaTEdvsxyXDxO
         tryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/EjW+41A3AZWNzPdaLYW00HPRy4vmJx41QQJk44Pu6k=;
        fh=Vn5JcdPgPLbvGqizooFcLCApiFmOYyo9JniqzE3O2Ew=;
        b=XZPy9OkR5U9PJ8JoaLhIhR6rV/weYHcu/X6xUhCKuZ9wRSTdi1ydhKdv/67FEcVV0U
         YBWrMN3gO0Lyc+ISUpk0AFgaMXtnHjN5e2lUYcyszYQ0vttqBSXKuXV3SkqG1EqWsfrf
         yyzjFw89V7lFkfCIRrAN4rX5KciGGNHwEmmkCcyOvjyIlHn9Y+c5cqBWULeodKdnDYZo
         SeIC8pw2IRBVMJRTuP45NSiecV4D2ActCKKt8exg3o17Xi4XAPF/4syyQ7ZJ+MhkjoSY
         GhwyMqS2m/tcYARRuvg8JPRmFhz+um3SczJgqdCTPnA9cNp/INosCQxWe2SZCbCuDFvb
         fsow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434763; x=1783039563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EjW+41A3AZWNzPdaLYW00HPRy4vmJx41QQJk44Pu6k=;
        b=SQOx6G166D8IAcyAlV2B70gFpntXCT4dHZx7BXJg/zxmTLc+ieX5b6e+Zb2acWEo0G
         kp2P+FlKO7C5IicRMC57mBDUGA5sfuPGev56w53/OHvU3xGyK6oKgMPrS23tAiItOuJr
         uOC4E3YvjwvyKMKAX1HNYLBe9s/nzuO4wH4fzmQxAGGXA8lqFfwbQep3YZlSLoBj+sLl
         LJjHkwHNRyyXd3UCYXRg16SsBf+x9teytHLqK96xCrZ9S31eHImy1Fxx9nQMhgBjRlY3
         a9lYV2nl/ogjQamhDkW8n1W9oPCxT7i5cZQJfV2zHX9z3wZNeqTbXRupApzghVmZXTIX
         hlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434763; x=1783039563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EjW+41A3AZWNzPdaLYW00HPRy4vmJx41QQJk44Pu6k=;
        b=Rgco/nfenGIzzVKm77SLV1e0mQ4FAuyM+tB6Atl0Aj6R9n1Liv5EBHf/u/IjuhqXAb
         TvuvGLCSIFJYjgvZq1+76b2DE47BeadpICcc2Zpp1IDaYa/+BrVxK0iUIsNqKGNDGxMX
         EGKt8nQy/mh2PwuG/5jPU9wSk39sbvuugAc/K9hCn/7ZzqhWqLWrcbDCu+rnBW+n3NzA
         ivG50wK1CYlU5ow2Whh9rhGz0kTSRtBd9msmn/hV1PNcWOsWf4W4Y3z+czNsz3Zk1lgS
         n25g5ArurnGn2A/QhR5m8WNbtKxyRT3iKU3UujupzC3iPij+88HfNOlT1TSfiezm2OBH
         U2tw==
X-Forwarded-Encrypted: i=1; AHgh+Rrruw2u7EuGTzcIFgEsGslKsTpsRu/WbhqagdTWH84R2GlfVe7qSeZr8EL4Ix7bIZtOUu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWEodu9/gwbJOfCekfXVQNChRR2STDYIERceTpYplekmi8AaWd
	/K1e1KBaUO3Tf7X0XaLZsM/dH9AY3sLgqNdIir9jp34PIvQtlP/gUc6aAkcqlWSx8ei1z/el6+n
	W5VKAbrIMFVvNUSRhNaT5+YqAO2VRQog=
X-Gm-Gg: AfdE7ck3iVEEda/Oz+oQotD85mS4+Zx9VxYTUOr/gMw3AmcAjj3VfDl7v7vD5eCym+y
	Uwo3E+U669nBdamryjNIu52N8qWOdF2HrBgJzRwXT/UqC6iNSNhLLMd/fKyJ2gLJWpLOIJ4I93W
	lC49UlbQMh/j3bo5ozadgPw5/Zbamc+g1BxL9Gb1K/mxewlXFZk6FiSqbE0DzWnkejjKW9duMDp
	eYHnbXMaggk6Hy+F6l7IxuipP/ph4726swzYG7nbdEz/Y+M6/OeWDb9ePk5Dg2aaDXtJnsUO/gz
	y3zL9ZfaihNSaBDLA2Xfo8pxTA6QYUXk16tZyPqqNAG3/GVTJdD9jpLtmGdOQsKCrxRRU0GCdVi
	ghnnPMkMuEi3B
X-Received: by 2002:a05:6a00:2d16:b0:842:614e:cc97 with SMTP id
 d2e1a72fcca58-845b3aae7b5mr5168870b3a.23.1782434762667; Thu, 25 Jun 2026
 17:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
In-Reply-To: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 17:45:50 -0700
X-Gm-Features: AVVi8Cdl-Rd3rAQEeE1aZoOlET-TCvlpOICGSaQN3m1nJHgleOZDWl8_X63y9fQ
Message-ID: <CAADnVQ+VzVJVLgFHaXTSisa_tKHMYzVXcYUvX9E2o0xLnuPAfA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: poison unresolved weak kfuncs in light skeletons
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Giuliano Procida <gprocida@google.com>, 
	Matthias Maennich <maennich@google.com>, Tiffany Yang <ynaffit@google.com>, 
	Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:04=E2=80=AFPM Siddharth Nayyar <sidnayyar@google.=
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
> fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks
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
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
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

why did you change the order?
Looks like an unrelated change.

pw-bot: cr

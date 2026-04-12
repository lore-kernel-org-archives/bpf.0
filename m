Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6C1DFFD
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002638; cv=pass; b=C9nGtY16tEKRfXERQZC8kZmoQmbXqi1u9BVYADARcuYRz1K5h+CI9p6NKyceALPJTcr/tuY/CzJPzDhieVbWBWf6772YRlt7DrCX3bMwcPXFHmO0AK3GQPUP/4CaXsSqKEAX1CMpj2bWjbW9y7WIQCtfe5qB2CQo23175MyRxEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002638; c=relaxed/simple;
	bh=AnR8L4v/sXZ2V5ByFDs9rqpOPJNXmPmJceLHkDjYMjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQOB7y+cZwBWipiYeE5/3wXQEx9sMUt2zLr4Rt2TEC+rUmaxTh29EPBbPoeBgxymW4pM5h4KHu5PQnw7U5X1TLFyH/IILdO6XUQFEjvaPpQqk4J1vs8X7r6R3nwANgnipQ6KMsb+EZBRq6FywjV5GCTo5AByVeD1Cps6RCUb9GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2+fkoqw; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2+fkoqw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2100069f8f.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 07:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776002635; cv=none;
        d=google.com; s=arc-20240605;
        b=az30qo5M68cOJEeXuo6Yar4Fe2kr8Io0yYRqUJ35ZPkKBHqGwV1vDRqxBBOUwjgVU/
         L3vUsWdo5q6763LR2FLSnwuOOHlUfmufFuvpSzad3lp1jArzKLriJnYCyJa3q0kTzJ4B
         2OHtI/lz4pm+wygcnlt04j6WMJhAFj6TbmSNYSpUNQb0GOF1KUzDEHZaiq8CGfHiimuz
         pLEscJpt41CZd+pbJrUi61kuZPF3ZZu99fOSxI7Msqjuh/5/zlVWb+MMefBwQbS+K6Vg
         DUaw1Yb9xp3UU7BRSALel3rUxvsljq+ndurFSGtaFxsDrZ4JA+GCmJ8JFS10OtMTCPup
         IlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cq1Z75/e0D+5hRu+2USCP4K8G8uQUiZVQU8i07jGzks=;
        fh=+N1dkzuK3ETw8TZOK5BpA0225SwbBmIcySC5++hI5qs=;
        b=be1uKRa30ytksQkpiPHts5Jedu56NrIgRgXVCLiCurq3Da02CT0rp0MumIWJiL3Ina
         E63VVEJ5QjkvB02uWaVdcb15vA4me4mE/zDWEhQVv2plWfvtAMUlYLSh1aLep9Q992yZ
         K9zvkWFx8nD9ZRPo7FZ8TSZiWbPlCypQYTUkZmnDkF/NDfWGDf41vxWcLqpLnkhDr2TR
         lzBP326T+FS8oizsWTOCcyWdE0GbLlAsPBTdscY82NBPb7nng+kRGJkGAbwfMx0LyL7+
         3g6hm9KHdPaId3ToBRqRkzxNmZtEwvzq9/TTKFmT4VwsLzG7UghDqZRyqGPjRbH/YpFe
         abCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002635; x=1776607435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq1Z75/e0D+5hRu+2USCP4K8G8uQUiZVQU8i07jGzks=;
        b=l2+fkoqwgleggBsNf2OJLSpIN+IjFEjazZN6WaMbT7jTxoHz8s0r5i1jrQSdqFcwkH
         xRIADSL3XzySPfaAeDL8JlXlGHJxHG7vRuSRE/5pmrUVsSRSC9PXBXAYwpn5gh78/JGY
         ZLttkHx6Uhf+Dh1Ji1PlVEopeaf7yvnYFMV76OuXDPGgCoGms8ta7xycjFWSAJFfVI+w
         AFSH41ladnpPim0oNAYi00i7c74Og2U7+U3UDunQrIuH1NZBvnciWjkbJ0IcBk6Nk/uO
         n4FrUV58Lm2kV2TgzBuv7BXt8g8y6Kc3Z3WG4SfCDKxysH8MiLjLgwKJu4ClAWLEbihv
         oPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002635; x=1776607435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cq1Z75/e0D+5hRu+2USCP4K8G8uQUiZVQU8i07jGzks=;
        b=a+UEB37MKIYGZ7VomWqi13fnxmV3FnPSgqqamFsdTqHcP0kNXoUAQ60+LHz8H/NJ3q
         MK4eQObB6d/31e1ZiB1l2Dlop1KzPFkSsfyrCKH1VckGru412sCJRddjBmns00tiWpOB
         sE2+zR2qBZrn/MUI7krPMji6APLYlGJgjo6ayAwbZQH+gk4rZ4K5U3SqRat2VodHmD+a
         znzdCKphu/IlmIMMFLT2f8iDvgYV0uWKWw0W3Lg1nITeZhXlkGq3idOZBLQ6cbdnBUjR
         hVFjB7ZSTxfANcVgbVaB1nxmwWTrTe3ePNL/PTe8inoof1bkAD3xFfZUFc13yAO/BFgD
         grxQ==
X-Gm-Message-State: AOJu0Yzpry0eiq7KzB+HgeutFI6rrMRZPXd7umVkg/EFobTbxY3OlnBG
	3ZDRCY2/q9AbAXB8AFBqdwTCkwRBhbIrXOyQeR2BEuAB9fBjZT57FFLkdsWpHKrDZSCI4H/i68C
	XsjXtdB/Y4z7Z2ICmmrfWcBPJPDsGOMk=
X-Gm-Gg: AeBDieuSfpx7EGvYFJ3siIj2FgpymTyHciWxVcEVDd+hrjLpEqERYVKyXb+klOSrC7z
	Y/Hvs7qTaITjAWdtNckFfpF3M20kydBfCjSQBvz9qHflp6zVb3nhGcJh7dI5Fg55Crat5UleWt4
	K1dHgFbfDFrMFWqLtWAeKY/InWB3F2S9r7L2TJ02QfXLRytM/RYLyp947gtgr6neIheOCWKuV/L
	M6rSeNBlY1rbDpn9YafBaauijHHOlneUCTNCLOOvn6ssftwI0pMrx0DlqCuaqdCDvn64r4/4WX6
	6DlIJr4Oh1CuK0gE0PuSqwjVBLwC0g8oQmyZOXz8pp6WQpH4QuSiMDKkDyyEef+vT7ntLpudjEj
	fNJh+hcJBYe5uIigw4Q5VwEqKXyH3e+SD/BVQ
X-Received: by 2002:a05:6000:2908:b0:43b:8fa4:1937 with SMTP id
 ffacd0b85a97d-43d64255170mr14522520f8f.5.1776002634891; Sun, 12 Apr 2026
 07:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412035945.46916-4-alexei.starovoitov@gmail.com> <2ff758e4ce8ee3924f231e2ca37a08b833b3b95160344e01c623e71c35a3e0db@mail.kernel.org>
In-Reply-To: <2ff758e4ce8ee3924f231e2ca37a08b833b3b95160344e01c623e71c35a3e0db@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 07:03:43 -0700
X-Gm-Features: AQROBzCG1GItiSA-Dfn3oHiu2qi2U54XSbBUqCLFvMgSMqQZ_Q05WAWh6skgZRE
Message-ID: <CAADnVQJ40wUS0Ak8WbSw5k6fgCPGY4Ekrb7di4sOt9S9PkKtww@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Move check_cfg() into cfg.c
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> > --- /dev/null
> > +++ b/kernel/bpf/cfg.c
>
> [ ... ]
>
> > +/*
> > + * Compute strongly connected components (SCCs) on the CFG.
> > + * Assign an SCC number to each instruction, recorded in env->insn_aux=
[*].scc.
> > + * If instruction is a sole member of its SCC and there are no self ed=
ges,
> > + * assign it SCC number of zero.
> > + * Uses a non-recursive adaptation of Tarjan's algorithm for SCC compu=
tation.
> > + */
> > +int bpf_compute_scc(struct bpf_verifier_env *env)
> > +{
> > +     const u32 NOT_ON_STACK =3D U32_MAX;
> > +
> > +     struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> > +     const u32 insn_cnt =3D env->prog->len;
> > +     int stack_sz, dfs_sz, err =3D 0;
> > +     u32 *stack, *pre, *low, *dfs;
>
> [ ... ]
>
> > +     next_preorder_num =3D 1;
> > +     next_scc_id =3D 1;
> > +     stack =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> > +     pre =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> > +     low =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> > +     dfs =3D kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
>
> The commit message says "Mechanical move. No functional changes." but
> the original compute_scc() in verifier.c had extensive algorithmic
> documentation between these allocations and the main loop that was
> not carried over. The removed comments included:

Yeah. In v2 I accidentally squashed them into patch 4 instead of 3.
Fixing...

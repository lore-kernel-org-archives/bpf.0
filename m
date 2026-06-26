Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD53F9F48
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491375; cv=pass; b=fPTgorKbt0Xt7ZAZ0/mM6Ig9u2gmFt9m+aU5tOu9Y3IKwq3LLVPqKzvfDYerHRcCRq2yG22HXc4am1wUR3jlXC9NXEmVqwsDzL7tuiWAhOMOHqVAfmwNqk1HlbhohKdcfWYr1CMqkdRQQ8jVasZFFmlTI5KnGpuzuS2PEcm5G1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491375; c=relaxed/simple;
	bh=z2jtaD8+k4Zw+O/hlhoj92Qi5algxNN1jWq0p2ROiEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyGWqQzHPbjYkDUECrAArlzIRHGFsHY4FHP+RAww4jNEtCPGwxFKUI3eWRUGFeIhHB+gf9vAX2I6P3+ecRu2Tq0K3TXsrtGey2nZ/E1BoD5oGXOcR6dW/RlX0RqxzHsZX6ZB5WR5Auea8OAr2bto6oQMiTMRI3VpP18J77fSIbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJ7ejFvR; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJ7ejFvR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80a1fb0c683so14313267b3.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782491373; cv=none;
        d=google.com; s=arc-20260327;
        b=qu/jftFz8XnTldh5M+7JMRcZ1ytT3ubt3hUmu04WyRicygdlWTBE7znsBS1yiFCF/g
         LUpQKPp9NH6cZ0c4g/Ha0NxQHibYds7bZB+puW4vmIU/C8JBmAK+6L5H4oyztU14FECc
         e8Kfmud6wkp7q2+i91610xNY/NMHzLeWVuum3S5StjGdecLU4JjvGKXlOc2YvcV6CjHj
         f2PduixC0iJAQqytsZ7Jx4FA9RDxbyyPug9zep3ItEG3LZVujttvHWU+9Razqc9y+jSh
         i4o3y8WBmu1BdG+TZd5jZiSbenKyVZG2LYxbXNVjQomdv/evuf042kfJlWNKU4poz31y
         Nqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxBZilEreRqq6aI4WNlUN6rIz269dNlVpMdlZBKFg8Y=;
        fh=rLwpehQrxVwlGsdxItxehwuni/MB9u5bIGNjg+w1gcw=;
        b=n2GZ9e49Kl8vbTMccEEzN3s6G2fXXSl+Kmu9lND0tkiqV4wU9gyO6fbP52s1uylULP
         TSVZiFYjTAJoQrD0O3EyzQxuLGKEqlTzJnGMLRtkH7IcBFoDod2f3zfU7nYc7OLPo0T7
         c7y5++mpkcHriMgbBfJYG/QBDXhezCfUIbD+oMEf/SqEm+7H9Mr0io9R4oooR8oN1V4y
         951j/HsXDQAr2IDm97kGMagPwkeTWgulzFrFJRwMISsTqlqBvG6TTaH75y9e0nSC/hIe
         EuxRmp76kV+zmrd3CxXBtahrsRqeyLJCvbtCC4Wi6esTg/8Jd3zt9ueTXIIPPzI36T0j
         QG1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782491373; x=1783096173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxBZilEreRqq6aI4WNlUN6rIz269dNlVpMdlZBKFg8Y=;
        b=DJ7ejFvRPNPoi218aDDq2BNSgVxdMmjtNuyGIeV6MxOfeUFlTivvQnpNdOx+GdRstR
         mWWx0KUOlvXYWTf3YjBvDrfEmYZlEsqyNMTo558wJG+RojlAc2u+Mat8HMUSLxAHFa7u
         +QvOEUS9iEaKlGKAax342bVxeWazemNLkPA5CXUnfNw2Fhk0v1zVt8Ed5X5tRpjd8bil
         SyqdEdWA0BXveqF/FPw34o63atWR6PJ8wPiS0WTrZw3ZF+lSbv6pjayiZQ5JU6zQRKPb
         AgE2snhzxeUyzdmefu+CNjNPfsy24zBn7ZZqEjNHZ4dBP7VysKwPedJZw788/d3I5rcR
         AXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491373; x=1783096173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxBZilEreRqq6aI4WNlUN6rIz269dNlVpMdlZBKFg8Y=;
        b=gdVQODlYsRYwvR3Z66ihuo98ZBuvEj2ZjYHtCJxXTS42CIWdncqV+We18IOUSoLdSA
         OKE70TOye9oLyc3f89WTQMEXeJK/+aZG0NjXk3OxuJPIj2CFExIrWcfZkjmys6eUxPNX
         EM2CRAGhjauAPpJU7Aii2WTPk8icFg/IaVNikL3p+KOmowJtzQyrT77h0VaqaVQXNbHJ
         3C97804YtQImCeTRypZiErYnejR6pNHzk7OzzNSuvSl14ErMX2Xg+WwZXQpu923Hcoqe
         d4UhkoAqoYN2BDQaMh6UbTpzuFbbWHZc7yaCTtB+Ojh+hLPWFyi0U95zRuXSxYo/OBXd
         itCw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4nnuD2ot5DeZeGs7qqNkEV2aLaD+oIJ/YCSMPbLVEvF0VcxCPl91gzC5s6DhrAItJA3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8xDF9x+WZ2SpXwRlzU0onDgHMPBDIJnI6e/iqPOKvO/1gqOw
	JpS15m0sei/mK4aJI4Hu1s2XtpQ5fw62OR/oQU9ud5p6fDj12O8nN96FsyLxvcmYnDr4u+/Mj4w
	tg4pDp1FrWWZVTQetZzS1ZMm/uY6dAPYClPf5tZWZ
X-Gm-Gg: AfdE7clvZHRdIfCCKKNSTPBND+Vb2fekUutpczSVmh20t2lRguuNkYSOaAZH28TJzb9
	+wgJmf0zheBvNM1f+7+rL8MJ0mNB97bV64KS9qu0YKeUM1PlN8s5KZq+8UWEwnEXS7j3+2F3Xik
	437s7a0FIee1GDuJwuD4gpNnRfrk/x5OO8bx1oPkUDFJ/5LXZEkeyM4kkFsryf08cSlrCz9B8bR
	YsYVdkRrAdMvj3nzX5Sqiv6XrcjDbFZR1RMecI43MXVgSWLhe8b5HC7bWXeem4T1dHl/INf/5K2
	bAsi1+Nz0aPjTCmvJygHayuN0kQ=
X-Received: by 2002:a05:690c:6710:b0:7ed:737a:d193 with SMTP id
 00721157ae682-80c71a57fccmr11650427b3.3.1782491372579; Fri, 26 Jun 2026
 09:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com> <CAADnVQ+VzVJVLgFHaXTSisa_tKHMYzVXcYUvX9E2o0xLnuPAfA@mail.gmail.com>
In-Reply-To: <CAADnVQ+VzVJVLgFHaXTSisa_tKHMYzVXcYUvX9E2o0xLnuPAfA@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Fri, 26 Jun 2026 17:29:20 +0100
X-Gm-Features: AVVi8CfuML0qadhD5vdoA5MDMU54t1Y2OVkcNcQD1L4KLU8EbA0sfqibCtFFnzY
Message-ID: <CA+OvW8acn229oyecj8dSJRCtneqtOyr=SL9-5SK45DS2gMs_zg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: poison unresolved weak kfuncs in light skeletons
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Fri, Jun 26, 2026 at 1:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 4:04=E2=80=AFPM Siddharth Nayyar <sidnayyar@googl=
e.com> wrote:
> >
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> > @@ -783,10 +783,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *g=
en, struct ksym_relo_desc *relo
> >                 return;
> >         /* try to copy from existing bpf_insn */
> >         if (kdesc->ref > 1) {
> > -               move_blob2blob(gen, insn + offsetof(struct bpf_insn, im=
m), 4,
> > -                              kdesc->insn + offsetof(struct bpf_insn, =
imm));
> >                 move_blob2blob(gen, insn + offsetof(struct bpf_insn, of=
f), 2,
> >                                kdesc->insn + offsetof(struct bpf_insn, =
off));
> > +               move_blob2blob(gen, insn + offsetof(struct bpf_insn, im=
m), 4,
> > +                              kdesc->insn + offsetof(struct bpf_insn, =
imm));
>
> why did you change the order?
> Looks like an unrelated change.

Changing the order leaves the value of imm (rather than off) in
BPF_REG_0, which the next instruction consumes when checking if this
value is zero. If I don't do this we will need extra instructions to
load the value of imm before we can check if it is zero.

I hinted this in the comment just after the move_blob2blob() calls by
stating "reuse BPF_REG_0 from move_blob2blob". Please let me know if
this is unclear, I will expand the commentary if necessary.

Regards,
Siddharth Nayyar

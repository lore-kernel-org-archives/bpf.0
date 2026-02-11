Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E66F2F2
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845313; cv=pass; b=QF73jPOGwk/rFBk+eHlapgwMzApZvA0jKJBOCRMJVmrH0n8OLNfI8dz/dkzj6QarxrdFSOKLy9K/ssCjoGlBIqvCIDupVhBhEXRMMK6WfHklIeS0f6qwMZ3rKEODyDZf3I1gzZrFW38kR2Tp4SLjzFDmAR5JuOsaheEmEX0LzTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845313; c=relaxed/simple;
	bh=KuCIVLvdDNnKNRZQQzjobSvmP6FxBIR3hKhQpN+acdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbAqadZMpNMvi9cRzbbGRsaU6O+/F//viMp1IymhiMW7b1uhSD8HNe2Riadje/PB+NzK9m2PIZBkFafgPoti9Fa+0XSgMvPEDq43de0NUVX9uvNo6ku2gSzqCW6qBnDZAcb29FNisCkmvgxcrxHPI/F4JHnxxfrRTJLwj4RKy1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMOPFYFS; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMOPFYFS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso940722a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845312; cv=none;
        d=google.com; s=arc-20240605;
        b=V1Tfn39GjehEqFYGT30NRsRDjJXtGMXmWAdIePzlz2uQXzJ0siQj0UmTTp1s1bPMkx
         azApt40A7+UrcRIUoFbN0UqQZFcwVYjjkSiP1hZyjvPyB/OjfqMCbwXpfYF8AZdrlnq8
         u6R3gloJXLipIacqVvZXB3yrzJ36mW29a+nJ4Rfm9Sb7qcd47YVWFt9m1p0Hpl8PiNGl
         S2GIHuzisB8pmyU4TS5+bZse5YefHMcgaYBjGYaa3LVk4ohJ+VC4bvrYFtSmj/1GMEHP
         zfWc4aMJTg7KV7gidt2tOlDN7WRVPhQZxskZ9HvBXBh+3b4iZT39//nE+us2acHN5H4B
         sUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3LyzeTYjk/aozxENlII5MtSiJ1rf+EsjccZeddQK9Q=;
        fh=YXhxD3wyK33+PQ10KTCk2H4vVOOakTCPA9bwY3a/OaM=;
        b=aSsch2TwOs5L+3R9cLb+f9XfP+uBqybOvsuBpYFUTJYt0QwMo+wsoslBceoT4mFPwP
         +QaVSJ/9OM48PyJGc2zdl/o9ivus168cwkEO4aVZ83R1kBKSAsDZt0Ws7vxQsNcO6RMe
         cZ2WY3k+xdJp4dPG8330J2MScOehSMC6RuxEoVoxEZVlDDx8H4QbbV9HNz+SqTf4ssK6
         rO6KhR/dHr8kYR5LqLoi3aei1ABiK5EN7g6HDGER7nEYAriWrRJdpF4gK8z5AebuSGPv
         sQGJPMGF8wzCBBhwpAuBSs8WR8L5pUO6pTZ+z4t0d02zc1/fpmYMlroD+8C4KwXMdL5B
         6fRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845312; x=1771450112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3LyzeTYjk/aozxENlII5MtSiJ1rf+EsjccZeddQK9Q=;
        b=FMOPFYFSJqUd+aMb4pySZuKJ7luvt399v6Vdxsdn1jCvg1ZJPkmGwnS49kplDT4d7v
         7SCa/PUnLi33/ucg/JBG+XgfObyde/SdBPh0+AHJ0C6plsiME13fAcUEtANYrCK/H13q
         n+kt1y1Drz0181LQ62AKCnimJgBs9HSO6Kryl9a3rzwdQQ0DqtAser/wgxWI4pagdsTD
         JeHEODjbRef1T2IBRA2ybptaouXh5JEZ2YLgXMaXkb40U8P5qv56B1tohZHha/9JpnN8
         ybxxhLzOK8fOpKcgcnYje4xWVKJFT28EUHl/+hQ48A8JchNRLtEwzlanXYlmczh05Mq7
         oF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845312; x=1771450112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3LyzeTYjk/aozxENlII5MtSiJ1rf+EsjccZeddQK9Q=;
        b=SSl2Xc4lOOhQii/oHE0/2re1v2V5tfdSqfWuRm2rlgQlLa7Tv35XJSkAtBvay4dVuG
         ybvOt5Gh0Igw9xWgE0bpPstgNim7cIYqW8AtTkRRoF7srZ9g4Y25CLguIkbgp3UqSSUR
         C0ZpVlV6ywgwNeRBdPA/b2yH+i6OPGawChkczh5eefwcwHt4J2ZTYdHfyjKaHbCkCXhI
         sfW20waDmFTenR/mjBkQwOtr3ij2kHhznd99X304AI1x8mt1PgfeI7wwXi5tpIj6yYbj
         H41trtvNVIWS3kUo6A9nAO/5pBYvxjoLTdAcDYu7WlYAZLoIPkr9u15LpEgNxW0xJBFE
         ss6A==
X-Gm-Message-State: AOJu0YxpZUxWRIZaAdUFnj68pcHc1h/+OcJAyitssLS3x6bV4sWbOJ0t
	trVmjQLBFNqn/QvbzqBFmKlqm7F615PJCHZTJvuQIeHitLtEfni0hMlro61IFzT7Z3O+lvuvx0S
	309aqvRd5ZGHVd7V2mXKMgfpA4wP9Xts=
X-Gm-Gg: AZuq6aKGcud4qMy2NTIl6d2YyvPpJJFbN3aw1+cVwSlN800DmbewdcaDWmN2r4DxNvq
	fzZxJXRQVkDvomyCT/33XAgvGNoe8EaYPd2vgOAynIPAMGlIrDsxdwvd0WIFvMu5UD3nRIHkZ0t
	q/Iv3/m5lbHdINQzgNNAVVd8dZj620P68B1FLbKh5Cibe9AK3gxc2JPtZ2WjBy6EHjXa3NpWLhq
	+9oJOwx/zfLGJIaTBoxqhYluff6ZpuUGqZmoDEWM5ppSX57bZcaF587leEq0r6rF5WKsDeG+jeX
	Hh5iReu1mQSn0i+XyktkbUk=
X-Received: by 2002:a17:90b:548f:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-35692c6ab98mr201328a91.8.1770845311785; Wed, 11 Feb 2026
 13:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com> <20260211163927.665785-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260211163927.665785-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:28:18 -0800
X-Gm-Features: AZwV_QjaAXG7wyisolMZ34Wr7TOQmyzY_b4M8yNoEicuzDtXFG6EquNwV3W8W8E
Message-ID: <CAEf4BzYZUnansvKncz=8MFYmjdodu2zd0ZPWskkq45otpqv0hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Use kmalloc_nolock for
 bpf_task_work_ctx allocation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 8:40=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
> allocating and freeing bpf_task_work_ctx. Now that kmalloc can be used
> from NMI context, it is the right generic mechanism for memory allocation
> in BPF kfuncs, even in restricted contexts like tracing programs.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

BTW, file dynptr is also still using bpf_mem_free, consider changing
that to kmallock_nolock as a follow up as well, please (and I guess in
general we should do an audit pass on what are the other bpf_mem_alloc
places that should be converted, but Alexei is a more authoritative on
what are the remaining constraints that would prevent some
functionality to be switched to kmallock_nolock).

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 414e5b55cd37..d25aa51c80d3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4165,10 +4165,7 @@ static void bpf_task_work_ctx_free_rcu(struct rcu_=
head *rcu)
>         struct bpf_task_work_ctx *ctx =3D container_of(rcu, struct bpf_ta=
sk_work_ctx, rcu);
>
>         bpf_task_work_ctx_reset(ctx);
> -       /* bpf_mem_free expects migration to be disabled */
> -       migrate_disable();
> -       bpf_mem_free(&bpf_global_ma, ctx);
> -       migrate_enable();
> +       kfree_nolock(ctx);
>  }
>
>  static void bpf_task_work_ctx_free_rcu_tasks_trace(struct rcu_head *rcu)
> @@ -4295,7 +4292,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetc=
h_ctx(struct bpf_task_work *t
>         if (ctx)
>                 return ctx;
>
> -       ctx =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work=
_ctx));
> +       ctx =3D kmalloc_nolock(sizeof(struct bpf_task_work_ctx), 0, map->=
numa_node);
>         if (!ctx)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -4309,7 +4306,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetc=
h_ctx(struct bpf_task_work *t
>                  * tw->ctx is set by concurrent BPF program, release allo=
cated
>                  * memory and try to reuse already set context.
>                  */
> -               bpf_mem_free(&bpf_global_ma, ctx);
> +               kfree_nolock(ctx);
>                 return old_ctx;
>         }
>
> --
> 2.47.3
>

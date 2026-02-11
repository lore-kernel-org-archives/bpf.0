Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888F361666
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845110; cv=pass; b=KIuToB7YaM3C//vP4hc5vYejQRXC7GQTqKmFnxmKWmcMQU1qw2mmIimYZimozGyqhcBC/DfAV6eXMJblwPjEKn4SEfGPcSSP7vcmHby5F5RddMEI8klPXAKiRdzaNSLgZlaQ8ciWktLwk89vHv+45j4uNuoaMBO6NEhQIouMXXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845110; c=relaxed/simple;
	bh=Z0OTIUhB6oMThuJP6cZpUqYXH0Rd4HhheFONX4SSDPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVpEQpEH2GztTe6X4wSc6Zy9uc/iqZXDrx4r5qUmol8uu9u+bV5n36EXDNXwad1PUqsLdy+Xj7tE5+YFolxnqs7QaIN7EHdbRcfUDVUh+EON+AmwJmkakxxpHiR8mz6HTRM4nqnLTSWXF6DGOydHt9mjcYiHl5fi4lY28hewmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY2g5mYU; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY2g5mYU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1086061a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845108; cv=none;
        d=google.com; s=arc-20240605;
        b=Jkkpm2LsfPPCPkIXyS3/BT51j2/ohRfJ19ZjzGUcD2avFUtZgSK/y+4gdVcTjSARS7
         74DUFZnDV7jLxPsPeEQDAUoEfyRcF72Qg8ZafFV8rVIxTFVIjfHP7+LNpxoLAkAR7cdz
         y0CPCvoAiXRmpukE/LxLMjZ9MnlzSa5g6dRFRxlh1NTwkN57oaoezW7GHj/90DGcDsuo
         QDyFeYoEmJTilPGkxj859XTFgQ12ooc8urNpx0im5SPPywR2PyxdFtYkc5iI+0eofLqz
         MzlcSq24oPhIMLUbv/aaclrbZQrLUA+SHQtXb73B8Zls52xDNRPZxCzv4KQodZy+pu9/
         i5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FC1+Uq9kZcycgBmVoQIFYLC8r1zb+Gop8iN4yiG7IBU=;
        fh=YXhxD3wyK33+PQ10KTCk2H4vVOOakTCPA9bwY3a/OaM=;
        b=C3HfqPFvvVjYuhKpGFcfZW82yjjcxDsDbO6Py552rPbXInq6poZqLYnIXZnyC2/9bb
         GK/nr6w8RYFOdnSFm50JwfdQ7dfmiXHeuWTJ2QjaSIOxFjuG/AHxYwHt+56T9D85P0pb
         AcCLtlJphQOgUHFCLcDvloAvBxeVEM4vaJ7Rg/DHmdeGMu4x8lFYIGwMgPvAqZTPoGCf
         0UpUQSfDlMxhjN6pZtj3LhDSKaB4OadIDVezdN8fRlpEXLszG6j9g2m0BfNyICAspH8i
         13ZAKvYnvOloxcf/JB1+pXGILCIl8N/1pqHAvhoff5+nQ5TCAp66/5A+4giHWVylcST+
         S2Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845108; x=1771449908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC1+Uq9kZcycgBmVoQIFYLC8r1zb+Gop8iN4yiG7IBU=;
        b=kY2g5mYUv5obEV2rTh6VptK36og4jnRwZpcNri+tCcEPMyAigd8uaPAkLgTswUJnMm
         kLUlLSWigg68AM5AzhE3KQmkb/dV3ycwJsWXlbHPnnqvOKoW2lrRxCBpfb44xpP2n0Nf
         cti6eX9i/2jGc0OqQizZf4U+FYu5h4L0fAVpr7kRHCm3gam42/oiQba4zNhc/AcsoKzS
         JvNCt5+jKQ3Vhp88M7hL17Y4LbKtuDSm050tYX297hKQ886uOmVjwoWKsnqvSd3ceP9U
         U0lZjtoYGSVlaK+o807DhDlATUsWY2K8ozkx1J6QOSQaBrG/O2stQ8NsUA37J6WKUdCj
         RhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845108; x=1771449908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC1+Uq9kZcycgBmVoQIFYLC8r1zb+Gop8iN4yiG7IBU=;
        b=EDijhbQPViFEI62UHkQHWVQ72hATUMQdVMHYQ/iQ+mxGy78oPsgUfalEUFSG7R0U50
         nlHTSadKxUtZ2OSwD93Oky0xmVrY4msVlh5XgiFj1mE8rqGNmYKFTDY36dgfagBHwyFo
         t3+obMqpBQnD6bHq5JwdUkAJ9mosJ8poyR816QWi1ZQuC9yI5HlGLO8EN24sTuOLMGZT
         jVo/FCZAiaJj26GEej8kKWfEubSEN9+vQNHeCitwQHxhOI5nCmcpgpE17Z+XULOREvXm
         j84Xm3SAshVFu1SsMpZSfEjylSoOTdhUzAbBQ4UxVxG1e/6jvkSAW3CFPSZbh7JlERSg
         CoEg==
X-Gm-Message-State: AOJu0YwqlXaRhqPkX/MMo6PNKtSYkWh2owlOlg8M87jzZu2n7WA6lD9L
	kbV3BEAYAniHb/jRQqWESxXhu5ZWrm55O6PWdHxuklBGEioQCRUUUZpM+0HI130tsRr1mgrx6yF
	+XhezHWplwys5XKGHq029dLcknyO19rg=
X-Gm-Gg: AZuq6aLbMESBIIENfC0nkwu0SWlE28nooGLgSKUW8HkcfAoBuQ+xNRO8Jjp6cACni+H
	uE+3e5k4rD8gh/uciu/djCrJQbsCIWCVPhwYg8O943mXyYBXI0bIrK2UEmgwhQT8svQYzxDBeKE
	Xlhr5K6YP8MhfMKpw6qolOR3mj4bMswGoerlv42tVrwWqiF6lqC+jPF2w9BlThtcz8zEaUlRBWM
	Kmc4ZbZOtoNIkDO6atozUzYYYP7nGuiKfe/t4+hX+rFLGSi4EGUeEaNUY/EEOjh/bRC6ptPtLAy
	a4k8RBV3RNF0DYHEfYcVik9UzMgJEaPYaA==
X-Received: by 2002:a17:90b:2584:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-35693ccf631mr34918a91.16.1770845108305; Wed, 11 Feb 2026
 13:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com> <20260211163927.665785-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260211163927.665785-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:24:56 -0800
X-Gm-Features: AZwV_QgjADhpHS-by9dA4CGLUPyiMhu36shcIGralYC6Kqm52o9-u6jaND0Cnx0
Message-ID: <CAEf4BzaZb1vkUAnq1DR147FZawn1FdtTDy23GefQJELuofVaSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix use-after-free in
 bpf_task_work_ctx freeing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 8:39=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Current code frees the context immediately when the refcount drops to
> zero, without waiting for any RCU grace period. This is unsafe: a
> concurrent BPF program calling bpf_task_work_schedule() may still
> hold the ctx without a reference for a very short period of
> time in bpf_task_work_acquire_ctx().
>
> Fix this by deferring the free through two RCU grace periods:
>     call_rcu_tasks_trace -> call_rcu -> free
> This is similar to bpf_async_cb freeing.
>
> Since bpf_task_work_ctx_put() can be called from IRQ-disabled context
> (e.g. NMI from tracing BPF programs), and call_rcu_tasks_trace is not
> safe there, use irq_work to defer the initial call_rcu_tasks_trace to
> a safe context.
>
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 7ac32798eb04..414e5b55cd37 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4160,6 +4160,31 @@ static void bpf_task_work_ctx_reset(struct bpf_tas=
k_work_ctx *ctx)
>         }
>  }
>
> +static void bpf_task_work_ctx_free_rcu(struct rcu_head *rcu)
> +{
> +       struct bpf_task_work_ctx *ctx =3D container_of(rcu, struct bpf_ta=
sk_work_ctx, rcu);
> +
> +       bpf_task_work_ctx_reset(ctx);
> +       /* bpf_mem_free expects migration to be disabled */
> +       migrate_disable();
> +       bpf_mem_free(&bpf_global_ma, ctx);
> +       migrate_enable();
> +}
> +
> +static void bpf_task_work_ctx_free_rcu_tasks_trace(struct rcu_head *rcu)
> +{
> +       struct bpf_task_work_ctx *ctx =3D container_of(rcu, struct bpf_ta=
sk_work_ctx, rcu);
> +
> +       call_rcu(&ctx->rcu, bpf_task_work_ctx_free_rcu);
> +}
> +
> +static void bpf_task_work_ctx_delete(struct irq_work *irq_work)
> +{
> +       struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct b=
pf_task_work_ctx, irq_work);
> +
> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_ctx_free_rcu_tasks_=
trace);

with timers we already hard-coded assumption/guarantee that RCU tasks
trace GP implies RCU GP (Paul is going to or already did codify this
guarantee going forward), let's drop this extra hop here as well


> +}
> +
>  static bool bpf_task_work_ctx_tryget(struct bpf_task_work_ctx *ctx)
>  {
>         return refcount_inc_not_zero(&ctx->refcnt);
> @@ -4170,12 +4195,12 @@ static void bpf_task_work_ctx_put(struct bpf_task=
_work_ctx *ctx)
>         if (!refcount_dec_and_test(&ctx->refcnt))
>                 return;
>
> -       bpf_task_work_ctx_reset(ctx);

it should still be correct to put prog and task here, even from NMI,
so let's do this here early?

> -
> -       /* bpf_mem_free expects migration to be disabled */
> -       migrate_disable();
> -       bpf_mem_free(&bpf_global_ma, ctx);
> -       migrate_enable();
> +       if (irqs_disabled()) {
> +               init_irq_work(&ctx->irq_work, bpf_task_work_ctx_delete);
> +               irq_work_queue(&ctx->irq_work);
> +       } else {
> +               bpf_task_work_ctx_delete(&ctx->irq_work);
> +       }
>  }
>
>  static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> --
> 2.47.3
>

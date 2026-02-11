Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC7260565
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845617; cv=pass; b=FIp5CGY/eOMHeUMkGYOK2gD9OaONccvwshrAsihQyalMulX8kIYDdMhLKXm3s4hpD4iRtNDRQyeuPfC3L3SWRLlwvPkdkUcLOVR6W1ilJPjlgnegrgtT7cMSt10R6+StKE2Es3M1l2o15M3x8GbP8jRuGzDKcAN1rijMGNPh0T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845617; c=relaxed/simple;
	bh=qLPo5zEcoieWxfDcmEbFPTlrm3UQXVJ+QSn569nZFGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8g+d/idn07VBzkCU+4HFVTnE1iIJrQ7CDtWQ7Hav4lzXVTmGqsLQeM0RYeMKHPomcjXAsJ/ydadB+5T+KiNSzDF+nR9+M91aqBmR80d6M8k4L7Vq1dt2AvaSWbNCKBf+N4t+ZyCwSb6MrmNRtsl9csd2icKFLvgN70ACk+vzh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg7OrcnF; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg7OrcnF"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-437711e9195so2762266f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845615; cv=none;
        d=google.com; s=arc-20240605;
        b=DM35d1wX417Lk/r1AqqJ4RD0t33l9kQocGTmPW2uNQR+jtQl6aLDG2CSIJEm6M6H7+
         XOMcxJxE83QYvunWbKR8Xu7Fg2S/b3hP4tI6jHzsCyWRo0vwvMyfiGwr50bX84pL57yo
         7mlMN9WilLTBhwgFiCGhEFuNE5cuH1GdVsF7gyajWU8VvE/xLIqckDwA7ikfFbj1pfMc
         HUmApM6uZCBRjG8CMnack0G1st9GZDNScXr+mjnhlVAQ0fdFuGWXRBA+Nnh39EBL9e9Q
         BVGPTqv3Ru4gNEtSFas+aMotJmt2kcxZ4g6u1vZEk0L+DpBU1MwVv6dqxCiHzXGLs8fj
         gcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YGP/xVOY2zadAetySSD2ikQylzULnFmWyu+qkg95jyI=;
        fh=oEMtQAMr3zPZpaJG5v1tfpkLsv0x83ljrknzlFra+uA=;
        b=egCP4etPmxfTmiFHD+TTUAkE0iqYsrk2M41+l4Wm5eXepv5c/BvbLLd5vXcDvYhRtK
         WxGMO0EFnd4K1PBO0v3/izCFZMSwlhkNx4p2eCuDkMvL2ZwCrPxzQA+cP6yKLjUiE1W6
         O6RIuBy++nBstu+SvWG8HdxLLNdT/Ep5kkuL2+cJ3wkm/0+/ojoU1IBp0PECwS6qnUMF
         hx1a5wlTwXGxT3gA2iwk4GEvlgFjjui0ZCZ5bbRMoLygUkrgUo49eaGPSWpYac1tXExb
         1vGxXtwtr6qBxh2MMS8mosr9wdzS+0PcdAEV4xeYWTQHQFpFkTBG40KDQkhFMN0hoOUM
         /+Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845615; x=1771450415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGP/xVOY2zadAetySSD2ikQylzULnFmWyu+qkg95jyI=;
        b=Jg7OrcnFq6XA+viFyl+iIXTo2iGIv4tQ9x1EM18JvDsrBNa/3nKqFtz8SIGFIEW81A
         H0xLVTI2+knP/+FPPvd3m73M6Jo1sNs7grbayeoJrVBZu2w6NMJXkyUFSOCNwZuv8IeT
         h4THYvQNxSLonbe7ZPdUINDNb6/71mHMbakiWMjRul7OyPKaxAzTtPctJJazZiAYy7YA
         VUumiZHBaBtnA1QqtCVEioN4MCV09Oey4KTOe6jp22it+Qp7jf0aSPentLfVd2AD4x8n
         Bprj6+Sj6j+JnV8yUW+3u3I9eTxaX5p+aXC9hFXjqsRWLIH84y7RV+0SPyN3xcCB/dgU
         jz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845615; x=1771450415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGP/xVOY2zadAetySSD2ikQylzULnFmWyu+qkg95jyI=;
        b=O+teSSXledyj9CdQ1I2BeqdpcXfquPDCV5EVDb9i+fpSD3eaz3eyApWuZ2R/a7Vk+E
         XkCwxHHlgjyUZ+ImkhsgdNUBEmIke75ckcAIRirNmjCf9F1ltJcFOwwE8rw/4izzCkt7
         MVgIEDX/epQFlNpvwmoS/kp3ZZ1m7PShWwnZ+8QD1JcM1BSz1jb0cMuoFPTsZMkswuaq
         y+kkcnMq8Uu5sO4ENF2wvHqIHsqOep++5IWkB68r5O1bV25ONQO7qY6K8ETUKWy5tsZc
         YU34Wa7ArqgfvBqbFmMagAyK162+d3tHlwhOlRlYQ1R9UBkKfqbDl/frOBczoT2dvP5+
         P3Wg==
X-Gm-Message-State: AOJu0YzcjIFXf0BnixWUMKwlpz2lgTts8t47sUwOyMgxXDk8gtJpISn/
	ZDmyyLzjuRmzynvZgIx1ItsVcs4aEXd5/Uo/Ixpdp8l4PmnMlH93j2DushHb6dUqnRjq1OknIa8
	dLjyHAPLD0Yf2uhUyTnuq+cNsF26ldkY=
X-Gm-Gg: AZuq6aKqo4Ary/R57UaclXlGqA1id+PeWG6SzEbNrjDeIaZ2zm3APvmXdGSIgFY9cF7
	du2pjRRq1xvpnpIUet60ALqOxRz+lwYM+chjoNLxyJq+lqqq0t0D6/4/3B3W0kFPcOZP3eB4LS7
	qFlovLalD4tByDjwSZ0hXcmx7Yobg3JAbHZYnaz4V+uY8XkZZUqKyM8LSMexspOXlDy7bq/l4PL
	7GgZEngtjWuCUY1PdZYvN0tS9h7ZA2E/ZRmQ75O9QWbG0MVGojQnKsqDUBZsai7VlyzAjH/5p23
	gMCe79MVu/OjewouEebpedfaq6IqXcFvjuQRci2PsCsDUJ3CxszW71ehUXZyOaJjygBUsWN3aL6
	4wZOZ6M/yCOm1pAYfneNnWR87Rg==
X-Received: by 2002:a05:6000:2305:b0:435:9d70:f299 with SMTP id
 ffacd0b85a97d-4378aa1266dmr1456896f8f.22.1770845614728; Wed, 11 Feb 2026
 13:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com> <20260211163927.665785-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260211163927.665785-2-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 13:33:23 -0800
X-Gm-Features: AZwV_QjwDXBXK6z-FcD3SuR5AoUVNhp4onW4WOfJOYP9V9qygP0knSUpFsrCpkE
Message-ID: <CAADnVQJjpvbFGYe+E10MZGacT7jdnHkwHnwRhDhC9OPBYeoGVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix use-after-free in
 bpf_task_work_ctx freeing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 8:39=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Current code frees the context immediately when the refcount drops to
> zero, without waiting for any RCU grace period. This is unsafe:

This statement is misleading. It's correct and incorrect at the same time.
bpf_mem_free() adds to linked list for immediate reuse
via bpf_mem_alloc(), but it doesn't actually free it to the slab
for the rest of the kernel to use until both rcu_task_trace and rcu GPs.

So I'm not yet sure what immediate reuse of bpf_task_work_ctx
can create problems. Probably,
but the commit log should describe the exact scenario.

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

rcu machinery disables bh before calling callbacks
which I think prevents migration too.
Pls check with Paul.

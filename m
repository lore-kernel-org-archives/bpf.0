Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048539EF2A
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370699; cv=pass; b=WL+WN+O3qWMzz6ZPG1nEl2OloLnZejrhiBufTED8KRA095iSf3CNPaRW/UyOca2WFIW6sEnavnbQN4cjuFt1kPQ5Y56yZxkcaceObWvl29dDPgdjfRKrdOaGaAJ0MA0dH24QYDG2u+sNaWz/GPyFrIZzxv35Xc441e3/LFdZSko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370699; c=relaxed/simple;
	bh=aQefb5KGUUtBew9fCgJ/HSm0at5w/RtJ4qdMArEgBms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dln2Q3BWyqGoJumDyHSKQD8mevUkz0egVfsA9X6tyY2TOVu1OH0r0lZb2Iy1IztCBD9ahQFspS5ezpLGvnkJuCjH2HoEu5r9xWFspetvLDGigv0ntEzTOc+qq7FCw7KCv+QZxEcgWzyfJzPQ/ok2FzvMl48ftcDVCkY5rb9dC8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Rdg8OL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Rdg8OL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso297597966b.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 07:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370696; cv=none;
        d=google.com; s=arc-20260327;
        b=VyV9X4J8/DzlIxRHKJ4aJnVGYkwF1EYpfx9wB57aEEg35BeBCqVH27jePilbvhh/yS
         PICJZuOKv/NUGLHw5QIA/4aiNL98TFVi/gc0zHJIkSWAWTjJkhGU1dZj8zpu7zARKgP6
         vC6Ya/6zVxbKnYnIcOxAAjHcc5GpZzeA2FERzDOfBm5a+p4/xo+ZtNR5mfa4Z91+Xnnq
         ZfSLR6gykqf+/YZ1izCNEIFhXSeIQC224ozPm+A/qTTeLLRvf7KjjnCM64N+MHAWsK44
         HrkqE9XsNmQNzjieW6v7/5OyYDDT8tQwOdiNan6w0NVgNkxTd7Kha251vRkxQIh662WV
         OTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        fh=Xv1ikkwfBPl3gemhJlTkonZg6YOUPyjPLCV1T+5wWjM=;
        b=KJOOogqGPclwHIVC3CB/6u3KA7/nzGYFJIASGL/aNiKeQanKIxwrvyOe6cUv4qPKTp
         vbDYRt/87nG++sVfjZJkKSQUs1LQPYquPnmpF17i070laqDmReOeZNzo7+Ma2qlnV2bN
         PN24s+2feBUKZo1Yuuin9cG+10HWnY4wWdOMzg7yc5aoCOqluCo1g7dCKaE+LHncOsrI
         TzR63/W9lNLe7UuWjlSj4vW8NssuuhsOi8F61f65+nSNPv2jFP/s4q/D4mZDPz7SD3Zu
         DjH/qY5GOfec4qv5NVKPpbphDoCPSLqPJrJpuXu4Wkq63LcK61BnIKZUaqsdSwbG7b0z
         xCnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786370696; x=1786975496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        b=A0Rdg8OLXwK8/HbarErIwN2gyK2KHHOKhgForv3iXhXBzI8GTB4QrVml67u++NHgnN
         Wsc8x+ybChd4OFIu52k1kEZUBEjT8DyZIzQqxJxZgE9kgOqa8UQYd730rEpYjXz3tm9/
         1OjvD96j1Zf46xQV2llqBBbOiHc0SC9e04BmpUDXVcRc/xuAs5ieV7KF8KH7XXoi7MOz
         IydtcsnJki3ZaWiPgBGvxn4XYjJkbafAtjl+LfPRNm9IYD3eh7hF7bINeZDtb2dl/MEO
         TqATcuehk7ljYMkIERTX8WRzbQ3FW+ueWOKZ4GKB7Ay3DP0s7DqEMmBhvy3/9/lW1EeX
         h+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370696; x=1786975496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        b=lPmaCeYqqod63RRt8anM4AjzjTTgDJFXFJ9NHNhJHPt2VrySAsI5Na5oyVgnLIuDcl
         Sm39OtM7UI8K9NCGo3WLNx41bC8iJwqt6dCzHxPjpWYoj0/FW9VpNrtCjSuF7etFxPmI
         qCt5VbL45XF6OIYGrCOi84UqOe2P/ajS/K054pr6Vvxv6BJBata11L18+ZR745VbM1/l
         ThOmxCp0ue9MAfTXzafPExFn+j+KLPGLRFLzIAxReIH7hW36A4ovdMXoPg06MFcp1Xll
         2cH9WtORPurl9DTwexbvjqOnb15yd5i9IHUW2MhcUg8SzycKKe6Zea7Bp9zhpnJevxM+
         kzXg==
X-Forwarded-Encrypted: i=1; AHgh+RoMvwCKROU1iUfIJJlQwXx5/AVVJ/dcMiijgu4Q1o7D7+/2DFUSTysvl3Wt6ZDbJUK4tRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyagPJ8/5zIlxkWiv8sLVo98fxmCYKh0xes42/xGF9KCsY19/
	RgYGNoOIdKTT/AA2SwFbgoIAYAfcaND8gcMhbSpVW4OnO5iDxqUqNYG/A6FZBHWlW8qcRQ4O09e
	UjZnXRn8Ai9FiIJ7xZVEsDwTpHdA0Hrw=
X-Gm-Gg: AR+sD10Z4dz3Xfj5RJuItYw1YgN9OgtG8KD8dXNq8RInZCNNF3dTISWE+dzaJhPhsuL
	e2f3wSBD1KmS2TGB3yLsOEQD6sOslUcWVoPljAVD+sIzgwKReeNlP2X22fqs+IAmx5d0KUOPgQp
	lcYYpWCspBrB+LH44q51yOR/o7AxVS8ze4vj+fiA2DtCnSBzQaR3lqG6DOklvkE9K7WTVUXGxHC
	WyT2Zq3i88Ki6psDFc6oO4XEVuT/tTak+618hyE9ps7TmnO84c160oH1Q/+EjsiBYhsTWjZLgWv
	mFICV93zi/+NbnYn2mplAY3JnABYeJFenErF0q1yK3A+8/Ze2bGNHKuIyf6R4HqjJlt5DLc=
X-Received: by 2002:a17:907:8e96:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c20c67e6fd9mr99288466b.12.1786370696006; Mon, 10 Aug 2026
 07:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <20260810133540.1947118-2-puranjay@kernel.org>
 <20260810140306.C1D721F000E9@smtp.kernel.org>
In-Reply-To: <20260810140306.C1D721F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 15:04:42 +0100
X-Gm-Features: AUfX_mzW0QQd2n7jimcEIfkUiJMD2Japtfg5KrPbI5Jksmx_wgWQIhzjSqo4ogE
Message-ID: <CANk7y0gUp5-Rqt-CCmfh1W5o2sMHW+Z=oGrjLYXdS81ZLE-TaA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Per-CPU PMUs missing `sched_task` callbacks during context switc=
hes if a task context exists.
> --
>
> --- Patch [1]: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->=
sched_task() ---
> commit 333df3e02c2d6b54e5bd528f91779820677d118e
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
>
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> cpc->task_epc is only non-NULL while a task context is scheduled in on
> this CPU. This patch passes &cpc->epc instead, which is the CPU-wide
> context for this PMU, avoiding a NULL pointer dereference.
>
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index ba5bd6a78fe7b..c372213ffc883 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3907,7 +3907,7 @@ static void __perf_pmu_sched_task(struct perf_cpu=
_pmu_context *cpc,
> >       perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >       perf_pmu_disable(pmu);
> >
> > -     pmu->sched_task(cpc->task_epc, task, sched_in);
> > +     pmu->sched_task(&cpc->epc, task, sched_in);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the early return in
> perf_pmu_sched_task() skip callbacks for CPU-wide PMUs?
>
> If a system-wide PMU event is active (sched_cb_usage > 0), and a context
> switch occurs to or from a task with an active perf event (meaning
> cpuctx->task_ctx is set), perf_pmu_sched_task() returns early:
>
> kernel/events/core.c:perf_pmu_sched_task() {
>         ...
>         /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
>         if (prev =3D=3D next || cpuctx->task_ctx)
>                 return;
>         ...
> }
>
> It seems to rely on perf_event_context_sched_out/in() to handle the
> callbacks. However, perf_ctx_sched_task_cb() only iterates over the task'=
s
> pmu_ctx_list:
>
> kernel/events/core.c:perf_ctx_sched_task_cb() {
>         ...
>         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>                 cpc =3D this_cpc(pmu_ctx->pmu);
>
>                 if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
>                         pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in)=
;
>         }
>         ...
> }
>
> If the task's perf event is for a different PMU (like a software event), =
the
> CPU-wide PMU won't be in ctx->pmu_ctx_list. Does this mean the CPU-wide
> PMU's sched_task() callback is completely skipped during the context swit=
ch,
> potentially corrupting hardware tracing or leaking branch records across =
tasks?
>
> >
> >       perf_pmu_enable(pmu);
> >       perf_ctx_unlock(cpuctx, cpuctx->task_ctx);


Next patch fixes this exact issue.

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CE3264D1
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112146; cv=pass; b=CdPd0HMppWBnTtSX6ww0GVMBa9/36jtAh+iroNu+ggQNZeGtcF9x6IhlR5z9wjfySe73v9hzUZlecFr/ksjdongINAgrQNxOYbr1XQ0e/t91v1/xk1ePo6VB9ggd6JOQEQf9Oqp1ZOV6f2GTlqLZB2kBSVbGC81a5QM8BEAcG1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112146; c=relaxed/simple;
	bh=8nIgFryYz2DrargIZD0GNMzp+E0YqW98PtHpUo3w5m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEmSi5emdt1WwdwfjM3lLja7qvlO1mJj8Ee7/kPaSnycv9tye5j3RgBko1rgzYLv/PXFcTHltPiXJxJXNN0VrCYI+cj/zT4PSvgLWj6Cmix/OUnUmgGNQaYrrQANhd0Cck4uepprRldersnHZj0DBGhU2xhYl9D5Pu5FEw1UqT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxqrp1H3; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxqrp1H3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15c42a45adso313093266b.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 07:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786112135; cv=none;
        d=google.com; s=arc-20260327;
        b=E8k/G6WNlqk6OkB4p2Vzc/wPNdyalN9FieRaCRGtEXOLNURJ+wS0GViV7WFMzTyrY7
         Wr5HBRinxZcwMBtpuXVS+BqzBhioXJ/Bw0oj+zTnSK4MSgUhgva01Y7O5u1y8szqmFSd
         tDLFsIQfJGZt4XzFEooV/+zdu5FxknQHHTZu1rHTW4NuXC+dAVF+3RFpwZDuMhvHJclF
         rPVCvzIUdtRYCeNGy3UkUmt66RYpetQI3X1RzJNZTpiM/g6bXbTXTjykeSf7eFn9Utmf
         oNMQIOj32b5F8EbNSfT2t0OdZVxSCZUBoDMydx329VTqQqCm0KH1MOYcKsF7B46+c6rC
         x/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        fh=J/qLS+48N0gD8/ODjNds/7rrIHM7COTr0B4SrJcA4yI=;
        b=k0lrI0mp2gTs6aHMWHc9yCJcnjfbWXFEsoATDz8UZoTIwdjkKb1CV7K7lFPVswx1oR
         nfSr2RAbuA4yrLwEau7Ig9EltLv1u2Dubr2VOYwlhkP6GZ8LUZmQ7f4iJgFSnDVrPq9V
         sEtkaEODI/ON7FfovYyyructSiQa5TVrhjqwFnFWQgLEq3ml/dUKFzAMDkQVP5ikVw8G
         PfnkbY8p7UADGFT4fcq0AeOJMLBIIr7/FKYgb0TFdYjK42V1eL0H+SywnHg+jT/NvfOK
         U/vDUjvH6CTJnIDhZp4JhHjTW8eQJospf8pNQpfKu0zFBEqF8RCHtpRNRQXrXhsJTrID
         ia0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112135; x=1786716935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=Vxqrp1H3W7lDss+3/JdOl8YpDjax42CqChmA8tp84UAvP5jrpNRTVzvrdklCi3hlq9
         aqdkIGC0jMlPRwyEWktr1QlsqhR7bbCnQ3XGjsHSuJ77RKohnyUc9ObKajFp2lfPCsw7
         YuhAhTDZ8TE6CljHcBlNLz32EgW2YC0Tl1hnYSNy1rN++3RbYydMCWbirw6ljPTyKZJV
         t8ypbtuzfC9mvLl4fIhCi26bmqcrgfeBVNqhPzLsNDMQ/cO1klvovGlN5OuGenmtJanj
         Jm32TEx1fxBT5u3Ow7EGRB023C+B//BkstwuClXXIZHCZ/H4RMJJw1dZ7CfPdxRizZIV
         LAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112135; x=1786716935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=tFgq9jXseZGu1AwrP5mYj9KzV4vb7uXum+M3uzaHWa/0nxixGRcBM2r2OV8jQ6l3eQ
         lwn2SG6RCUEaj84pMioYAshqXQozesv+HugRbvdufoKNfGCV1+fa9sDY3/5sLwTKs+tt
         c00S3jTwwPxZcbqjjFSKQPJ/dZ3ldBNmSR51XGBYP9Pz4iJFPiP46wFxVfccPzMkm2sE
         UumDaAvhc8kn1ptS4GZZLt3sLE24BBSU1ugs5mEgqowvCAxqcZpyFLpPiXsy8aNk9Ey1
         gjeAFpewPhW5XZYtSvghIVMlAAXYn7C0dNrVLJN6vx0eZxy0RtIqj6U0kKyzibDmUQxB
         lbmw==
X-Forwarded-Encrypted: i=1; AHgh+RpkgTlWKV3RnI9hnRyfWDIxPhnQ/7rt5tbbu4HtwbZb+WjiIz1k1uFL5WsP3lgur3aJX+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywroa+aSJNiRQOmbVT0bdlJOX3gQdBM+V0pJVfHBQpP1NZy0onC
	ZkadJiG+aKrW8p5CgYsgLUKheyTSN8mUGjq/Py5zb/hFz3Jeu8o1M1dhZ6B2aNYe8qSeAOG57zf
	8UiGGFwcx3av81NbqDVyBxyUpsfBe4ok=
X-Gm-Gg: AR+sD10BTOzp9qpX15INWS7fl8eqIdd/hqRtXns8rzLDwwJfMQFsAEMdGX+/KhnYBJR
	otDFFhX6P4U95LJ6wukhNlGKU0qb+ZvRRxCctwIyl7etE1iXoKzpKi2DqqCrmOmNEAwhhyINKHg
	rIQjUvjbfI8MYCNGTdgJbtPiOVgYJw45OoVNIfj/PYz+0R8iqKJYxn+VB41FWXXmGSHRdJaC6hq
	NyuwYQ6Z5w/XZlT/eCUDEbhYPgHJgHe908iozxpXXMyG9lqh9EvLUiQzg3ldP0cQVuM4bj4pxB6
	Tl7g2b8RPOMxoOdyLLMZsMja3fgH5DfvTkGxeIwZVPrWXBJv3YqttnOyMRQq
X-Received: by 2002:a17:907:a606:b0:c1f:df40:1d83 with SMTP id
 a640c23a62f3a-c2057e093demr807232966b.5.1786112134646; Fri, 07 Aug 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-2-puranjay@kernel.org>
 <20260807093951.GS776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807093951.GS776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 15:15:21 +0100
X-Gm-Features: AUfX_mwZEiydqK_HU1_ia3MF27eq51puWHtYC7ZlluNhh2_0hfgI6nV6cPYk91Q
Message-ID: <CANk7y0hq3w+bRNmuT1PWvhZb=ob=6Y5keN7-25vRSbx5nxakNA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:21AM -0700, Puranjay Mohan wrote:
> > perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> > cpc->task_epc is only non-NULL while a task context is scheduled in on
> > this CPU. __perf_pmu_sched_task() therefore always passes NULL:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
0
> >   pc : armv8pmu_sched_task+0x14/0x50
> >   Call trace:
> >    armv8pmu_sched_task+0x14/0x50 (P)
> >    perf_pmu_sched_task+0xac/0x108
> >    __perf_event_task_sched_out+0x6c/0xe0
> >
> > Pass &cpc->epc instead. __perf_init_event_pmu_context() sets its ->pmu
> > when the PMU is registered; ->ctx stays NULL until a CPU-wide event
> > attaches. That is enough here because armv8pmu_sched_task() is the only
> > in-tree implementation that dereferences the argument at all, and it
> > only reads ->pmu. The oops therefore needs BRBE, which arrived in v6.17=
.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Cc: stable@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b282de3e7d7ca..9815894b67e77 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3907,7 +3907,8 @@ static void __perf_pmu_sched_task(struct perf_cpu=
_pmu_context *cpc,
> >       perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >       perf_pmu_disable(pmu);
> >
> > -     pmu->sched_task(cpc->task_epc, task, sched_in);
> > +     pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> > +                     task, sched_in);
>
> This can be written like: cpc->task_epc ?: &cpc->epc.
>
> However, if cpc-task_epc is always NULL, then this all seems like an
> overly complicated way of writing: &cpc->epc. What gives?

Nothing, you're right, it should just be &cpc->epc.

I wrote the ternary expecting patch 2 to make cpc->task_epc reachable
here, but it does not.

Will fix it in v7.

Thanks,
Puranjay

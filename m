Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12001FECBA
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441382; cv=pass; b=ILxntbb7W/lsPPDkiVOOiH8rE3133KTVBlc8mp1nw7r+ySiDIJvK+pRB3UrBxiSSYcOvl2CnkHtq69/AABFrbjO52tGnQXjUvc2I2vMPeGA0qo438LNVs9JDHnJw2AigiQzA7lOef01R1ozOJI/lfRc9Dxnj4oJd9SmENxOLH1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441382; c=relaxed/simple;
	bh=8h9uuvioLmMzyjoC2PDlkvIO7nOSrqldyopjlTG22tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptycYzUrqcg8BZyZcUiSGRB0PvA88uLI1ef4RxSRVihTwNpHoaB6D4TDg/eiWyrMuuMhdMmPCnfwZu9JO2qrGFq8eR9mscsmE4RffZtUB0YPFb8wxdrGWnvtormcm2pnMlGoe8cHwEEVYs0t5nnpCmAwV18Tk8Wimtugw5WiVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFAuRFFM; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFAuRFFM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso63358b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 12:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441380; cv=none;
        d=google.com; s=arc-20260327;
        b=HT+5REV1YKBzOgwucetln/5cRycxpn0UCbtNt24ZLYDlg2QA/4XV5IHIFzLS5DtRIk
         lap3TZXY1PAJevwrgIRTXf4UepdoePPD9gacCxkT+lhpi0MDC9eA3zWDq4eJWZvg+F4Y
         bPJTfSoVd+jCvPMazzxB1wSuPrh2QtXgKyetlnx6BEN9ysaHwRI0eyh3nrDSPD/6lSEK
         VrTwVDXXsUI22CG0UAMTOyKDT9VVhr7MnZrqqj0stWZHYGE+5pigiey95VEcY8O3WAwC
         WyvcxHwG6NQlEaymha5jRangh0omTzxcYbKe2HArUgJtDkqfbZGaILV4ctD7VB+X4brU
         gqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        fh=zcacSPFvlegjO+A4FF3sBYM25AfmqvX8Inq6efZKLm0=;
        b=NGyygfE+h1J+sUZKKc2O7N3leMJsWQQ91HEiOn4I/01ODCI0OIMoRm6nfpQLmLaUvN
         OVW0Q73opgVX7vL5vf07qNQC8+kY7vlFpSyjFBJyQ+3ILpjyPtIj41Y/iSjNrrkzxEPC
         SXzELtuQMr12qNJNIn2Mc2WBXF4HqU45v7xPsqfLAoeRwjI0Y+Lgzl6h/RGMHSk60cRg
         yMaxhRLcDP2EhRWLHZAXhzEvN61p+lVTQ6o7DHrR8zh+cQgRytdZZqzNjxGO9V5LA3Gj
         BT6Q2FKg0aliHOLbCJMyr8MWLkxj04FEH+NHSZJbtbebL9lUWJ3kBNzvSsPsTCMTL6RH
         cOaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785441380; x=1786046180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        b=kFAuRFFMcGTtFSWlDoDw0YcOhlQeFMimBQU3AS0Lton5OG62fk3rksWzL6pIUGaesX
         d8K50qteJAawQXSX7rbD0eDnRHawW+cgKH+OuHHNnQy0uI6SBeHKWrjZbs5QyURzdZpJ
         cxaE6bzzXL9nYzTvNTFPRu6+2iX/Q2LeHWT7lIJ0I5RmGp36B4wzH0/li7HnDCtb5Dc2
         xtNyDX1x509QApVd5YpFwXwr5vDHWardXnKvTFNtwG6tFd6p32VWe+ZMilk59GgNbsI8
         UZTLTINsFtpLDxKnXWOpqNrW3CS4hA1oQ603vgqY8U95eCVv/cI8hmag3NeZut43ECU0
         nYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441380; x=1786046180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        b=gBtBFvTGxH9ry8AJWkDHTqEpQxeZ31PgzNGtXEGkbjl7BKMTjnCSuZw/kfZBKeJCBx
         o12UcBXqoq4GM5QoQyvD6xNAxDturuE0WPekf/P4jJyUMit11fUoJpu7TmguPWAOPnrB
         3LoT5SJZs6f2/hvMJPnqpS4Iltthu5klh+Wjrqol945AWUcX6zPk3ukgBqlCeoK0CJyM
         3DZx5ymFzHN/LIfGpsBxiy1qlADyrRTcW7ZdYUy3dF0QqKsnIsFMnxN7J/qr5rEc1N/g
         ovW09WQgpoSmqF+IAeY+Iy0EN0pRaoX2jXEoOP8VNC7fZ4kAuS55Gw8HJSNaQx5HZgbc
         0lHw==
X-Gm-Message-State: AOJu0YyM4bsEP9CcaKaOvk11g7YwORzcBkL3qEg79VsLYYbwCE3w2RSZ
	E3RKDC7MffyIcI8qJZtzZ1Cq8oI8b73WgFmqUc9WQM20IykpTvEfgP77KKGyjUFq9WGn05D8A0P
	g+Xp9DmrP3GNZ2Cybz/gczOBR+OFm7ts=
X-Gm-Gg: AR+sD12PV+U452EIzjXDsVfgQEDGYcgUqngdEQ26PVhje5bOU/olgvjAeqZ1GXT8Eb9
	1czcj5U6CtQy7/csWuqtab7RCei5hPy1MNhoKb4pV7GYRyxHJkL9kYJdOXy1dbZeJhaR+IMMA4Q
	MPJNXl+L2XdluKLZ32ffV8F2E/Xe8DW+fb6oZHeGRNqvholF+AqDHqxtJwY7HswaGV3czSiUCT0
	ISdyiHSDPxKHN5b6JFpr1APWLyYWJIqGJHnnS7hrEVHdsf05Mi+orQ6kuqmPVN2PdK43B8ucTCQ
	FOxrDm7PmPCZZfNVaqtmgmDPOaBdqpcr7uZa6kzx4Dpxkea1dedIQqX/gy2nfVdkRsaUtDBieZq
	aXgJdBdhrFXZFn3msXKzoYFhoirGQSSyAMXXl/SeNKw==
X-Received: by 2002:a05:6a00:b53:b0:845:df5c:2567 with SMTP id
 d2e1a72fcca58-84eca755270mr1251616b3a.25.1785441380230; Thu, 30 Jul 2026
 12:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-2-puranjay@kernel.org>
In-Reply-To: <20260616155716.2631508-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 12:56:03 -0700
X-Gm-Features: AUfX_myauPf-9BUS4q5KaEKx2Sh46ySRXTd0ms5asoEI3-_AoZYC3_ia32CZLHo
Message-ID: <CAEf4BzakTaTr16F4xRF4wti46Gfq7Csky=drai=aE_aUSOFbTQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] perf/core: Fix sched_task callbacks for CPU-wide
 branch stack events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 8:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is non-NULL,
> deferring to perf_ctx_sched_task_cb() in the context sched_in/out
> paths. But perf_ctx_sched_task_cb() only walks the task context's
> pmu_ctx_list -- PMUs that have only CPU-wide events are not on that
> list and their sched_task callback is silently skipped.
>
> On ARM64 with CPU-wide branch recording:
>
>   perf record -b -e cycles -a -- ls
>
> armv8pmu_sched_task() is skipped whenever the scheduled task has an
> unrelated perf event (e.g. a software event), and branch records leak
> across task boundaries.
>
> A second problem exists in __perf_pmu_sched_task(): it passes
> cpc->task_epc directly to pmu->sched_task(), but task_epc is NULL for
> PMUs with only CPU-wide events. When perf_pmu_sched_task() does reach
> the loop (because cpuctx->task_ctx is NULL), this causes a NULL
> pointer dereference:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 00[=
.]
>   PC is at armv8pmu_sched_task+0x14/0x50
>   Call trace:
>     armv8pmu_sched_task+0x14/0x50 (P)
>     perf_pmu_sched_task+0xac/0x108
>     __perf_event_task_sched_out+0x6c/0xe0
>
> Fix both:
>
>  - Remove the blanket early return in perf_pmu_sched_task() when
>    cpuctx->task_ctx is set. Instead, skip individual CPCs that have a
>    task_epc (those are handled by perf_ctx_sched_task_cb()). CPCs
>    without a task_epc are CPU-only and must be handled here.
>
>  - Fall back to &cpc->epc in __perf_pmu_sched_task() when task_epc is
>    NULL, so the callback always gets a valid pmu_ctx.
>
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/events/core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>

This looks like perf core bug fix, Peter/Ingo, would you like to take
this directly into your tip/perf/urgent tree?


> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..6604f6e8f352 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3906,7 +3906,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_p=
mu_context *cpc,
>         perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>         perf_pmu_disable(pmu);
>
> -       pmu->sched_task(cpc->task_epc, task, sched_in);
> +       pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> +                       task, sched_in);
>
>         perf_pmu_enable(pmu);
>         perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> @@ -3919,12 +3920,20 @@ static void perf_pmu_sched_task(struct task_struc=
t *prev,
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
>         struct perf_cpu_pmu_context *cpc;
>
> -       /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
> -       if (prev =3D=3D next || cpuctx->task_ctx)
> +       if (prev =3D=3D next)
>                 return;
>
> -       list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry)
> +       list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry) {
> +               /*
> +                * PMUs with per-task events are handled by
> +                * perf_ctx_sched_task_cb() via perf_event_context_sched_=
in/out
> +                * when a task context is active.
> +                */
> +               if (cpuctx->task_ctx && cpc->task_epc)
> +                       continue;
> +
>                 __perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_=
in);
> +       }
>  }
>
>  static void perf_event_switch(struct task_struct *task,
> --
> 2.53.0-Meta
>

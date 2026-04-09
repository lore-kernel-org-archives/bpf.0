Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA733D4E9
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734251; cv=pass; b=fk3aICbRvPvq7au+/O9r9jm8+OyCI9z5tKkZu6PV/XnE3MBiX2YwnVeeIBmVLbQNfTZ9rnRTP2gCtfq8DU7WIgtv7ZO0MoBA1L2OIG4OnGo39gDkkPiTJ381Es01wCl2EmMETSB8xpMz/wVhAaE4lINClR2a4yCinUmFIgIC340=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734251; c=relaxed/simple;
	bh=G/7I3x0QjIqDpJ1DUaO/7ft5e7RW7ciCg+Tgmgila2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etff8M8DhPDskGYg9PD78G3aaqy8Hj8be1WjN80jB0HPYyoSIuoq5kVu7EYuRxi63Q66cJjT1XBH7aEwIej6w2T5ba8Br5PCEQAJleT25Nz3gMCE8n2r9r8lvMzULg6rAWYeompHRyHcKoZTQdq4G60JNf/Ylh1wRk4CkqcbXZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N669kqF3; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N669kqF3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so1266651a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 04:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734248; cv=none;
        d=google.com; s=arc-20240605;
        b=TI3AUoC17UYml7OY2wS5J+eevxDu4LUWII52pCay9QC2Z9SVdbggVqjy247lnzk6jh
         UnusnG7fyfpcaE0T09L24h/Sqw2pjgDoEdVsEdBkAsahGYvDeoUAaJpIPs6ctMgt7AfA
         k4PgRE54T6Whq7sR71D4GqjakZ7DG6hN3nPXM6p0NmmgqgqNjoARK5Z10Ywf7Z9TqPHe
         zgvyv9/1zFFxrYXLz7ReXTRLIrS2oLNw9dd6QTHArzn6cAEfrT00gRRkZPTHNLF/mOp5
         dCB7AeZmhkjZrMk89+uzFqaW+SdvAdDgC1TJlnQ7rULnTsb16HJWrJbriYPjqM7ml9gi
         VJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        fh=BJXmDH4t1QQNj6C+00bkfOMWpONmN9n+5lGGnR6Z2/4=;
        b=Df5DKFKhxD5HmDJhzT2qDcI0/xLlC9iZVOeCENl8DAH9rQjn2IosHeP/IcW6MpAp00
         9Ap+36JRzc8Ix/kkdvUBvgWp5UtUBoiF3r+FFuq2fGPdV8AEBtdZPtpADuq8hAGdWYmv
         ImyMPFmRLVG0NRwbYQBH2bRY5ayZJ8a323eENEWkqHgKOivkU/qp0JSOaFrvzVT7V2A1
         DkzcbghHUdVCJL/IjqgJJM/n+LqEQ88261+8o4hL/SbEQMY4ib5iY3jaPPzqcSsC7f6E
         FwtwSfoETU8IVz6XmgJUzgSyt9JfEQFaex+OrIce4hWmibS/Zb6YUweKmj2vQccNGue4
         apgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734248; x=1776339048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        b=N669kqF3cGysKCN/r1YChJiD6tDI0qbALNGklsU/hzk0FXAxrhp2vL7ypd9z7apFCZ
         3FfrXOtBmeUerVasXzFBDGRRHY3/lwEMz6bK7u7fJyyXwPepYs9BIzMf4yqDXEdvLm2a
         fEgDjDAcIeuLH3patrxBsDeEHCFA9s5i3TucR3h5MQoHQUCiaoWUcuCzaIaFZLMERe1+
         5njsd7Z9KhmIr+Xr8e39wpnOXvzAzYlcKrPPhwcMgUkhFU5l/rRdacIxP5Z+vuAcdrWU
         bUbrUGTMMTtPAx3lSCflrApux3wS3HTnD531mIuUbkBllNO9EPOlWT2ECpFWFjmcGD3j
         WNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734248; x=1776339048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        b=lY0EpdT/rd448/pU6n9jVkjmA9zj3CsxQgn4fAjySU5gpKXgyRqqoX62twvVTlNRde
         zXzYe2bK0i0q/fw8iaVN3WQ4BqUe6BHlgxohLITdd9jI/ZKyyXLq82De4lUWUcIA0v+C
         sbvll6vpU+yES6OtOgswjEbgaK3FGPzeSHnho5Nx/cO9pgUiNjP9mK8WjmdGozAdREBq
         zMWzTLFNSoq6Z3m0IAVgY0qCYuJLyiIP+EhABEbc6gaqDFx4IRy+qz6XhUmMhWrG5Sn7
         BhZY00mM63Tmtf7cQOA4Az8pHlVzu5l3Xf37dqGUN9PnKxos9LO1DFEdxIzxWfHvVuTB
         lJAg==
X-Gm-Message-State: AOJu0Yye+mO+Gr9vkhOhnWaJsqq/yUKqMjaqpRKqsUfVlcQsrVzw3LmS
	MFeeNkfqirrqIl1IExZw91RAIoV7ZODfyX9oKPe0eUqxXLEHZOwux48wEgxRwWwzu9B0Wo38pw/
	9hmCGHu/T1Yoa9LoNf9WwizLXOITZFig=
X-Gm-Gg: AeBDiesKgmz/i5nuV4PiJRJmc8+AovbBsoKtq9G80gOV+isUWmCeqBluepupEO+VM3O
	SWbgKUBGjAtrr7ocj/tNpEXXB7d4iICcelTZ3KzuumBkt+RZgvFChELl0UOcmYSUckE/dU+9INa
	+lRS4tCzJD1YDoQiGBLaqA7JFljH7yC/egrK6Z/925Jx+3Ex+w94z8+wYGwbHKhtQZGUGCV6NtJ
	f9YytWnamWWJiEVIqUqB/zr0UGovaylDvuEy3I7FAWLDfSeJt0w5AWlP+I4f0S3NExzFEdwDrif
	yOiBWpaehqWSVjGq8YZt8qB3gBs96S7eVQ==
X-Received: by 2002:a05:6402:35d4:b0:670:13a3:646a with SMTP id
 4fb4d7f45d1cf-67013a365f5mr1353530a12.15.1775734247839; Thu, 09 Apr 2026
 04:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171706.2840512-1-puranjay@kernel.org> <20260318171706.2840512-2-puranjay@kernel.org>
 <20260409112453.GR356832@e132581.arm.com>
In-Reply-To: <20260409112453.GR356832@e132581.arm.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Apr 2026 12:30:35 +0100
X-Gm-Features: AQROBzACqmc9E5pVvwSPdWHo6z5Px611puIK_CexByaqynTStVAf-jkD8nOFqkU
Message-ID: <CANk7y0j972j3rk25PVprcTB4E8HOysoJOJNRV25iDK03995AOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
To: Leo Yan <leo.yan@arm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <robh@kernel.org>, 
	Breno Leitao <leitao@debian.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, kernel-team@meta.com, 
	James Clark <James.Clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 12:24=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Puranjay,
>
> On Wed, Mar 18, 2026 at 10:16:55AM -0700, Puranjay Mohan wrote:
> > This is easily triggered with:
> >
> >   perf record -b -e cycles -a -- ls
> >
> > which crashes on the first context switch with:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
0[.]
> >   PC is at armv8pmu_sched_task+0x14/0x50
> >   LR is at perf_pmu_sched_task+0xac/0x108
> >   Call trace:
> >     armv8pmu_sched_task+0x14/0x50 (P)
> >     perf_pmu_sched_task+0xac/0x108
> >     __perf_event_task_sched_out+0x6c/0xe0
> >     prepare_task_switch+0x120/0x268
> >     __schedule+0x1e8/0x828
> >     ...
> >
> > perf_pmu_sched_task() invokes the PMU sched callback with cpc->task_epc=
,
> > which is NULL when no per-task events exist for this PMU. With CPU-wide
> > branch-stack events, armv8pmu_sched_task() is still registered and
> > dereferences pmu_ctx->pmu unconditionally, causing the crash.
>
> Would not this is a bug in perf core layer that it should properly
> pass &cpc->epc for CPU wide trace?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 89b40e439717..a8cd0a26effa 100644
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
>
>
> I checked other archs, most of them don't use the parameter *pmu_ctx
> so the issue never hits.
>
> My understanding is that for CPU-wide (or system-wide) tracing, we still
> need to invalidate the branch record on a task switch so that a branch
> stack is recorded within the same context.

Thanks for your review, and I agree with your reasoning, I will change
the patch to use your diff.

Puranjay

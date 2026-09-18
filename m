Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710551A140
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750225; cv=none; b=G8Iwof4TKDFmqzw3tJGAI2yZ76/uUCB9YQTk04ycKEjIiPlpstApVaUiqTnwb/LfXTbH1u7n3J1s/7Fmdt3M0UnraeTXhODa6W0IrQLLxZ+Fx9ne0LqU/lWzAoCqKA1w3h6bO6F7XtbSTPeX9SyulJmx3GrAXh8OF41WoKFmc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750225; c=relaxed/simple;
	bh=unm3LTrJs+azdJYb/rn/8iNe/ALUCcCQNyUcn+PMCRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt8JRkBppa/eu16AXmaAfFYSiSVnbfRdaU1KBGjL2Ctpu811xxL13FGSQO+zTQ2dedL1RwPzGqJFshZniffyFVptmhu2fkGJA+iuZjy9HirQeUeIMDEqFJqMiZy2Nyp7WxkQjhu7X+HBYs0iVtwVqAcgedkQkE4kCR2fhSPl2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU7Qqd6B; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU7Qqd6B"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so5705875e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789750221; x=1790355021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14eKgF/ZgTy9NxwrQcItxASl1tsc6lkKw8cF3LPOCH0=;
        b=dU7Qqd6BEtDfXHprMxFIYWdIKqvqCSl5RZWMfzedElAcqBUc5Bw5U+IjhRl9A8Qoe/
         aoM4tZWVIld05TPF7yqAIJoSBzN6IhWPdZB+G7px6zTDQ/BNovmBd37oLsIKuVil72wW
         7KWsQ+doCLbnW5KrPDphRq2oykeGaBGRGrPoPfDyVSWhmhut/21dY6Ls27uRvT2F43Ag
         Ud15tb7GbrqpxQIdHPJtovEMmgRCRSnt8oYhilSgot0qZqlRz3pxbraZTguzHR97DJ/6
         wmS4PZJ8frtGxwSHbVzdUTBuvbxRAbea4bdz/5BUSO558sZj6A65zpZ/0lAh/lm7dX4e
         ocOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750221; x=1790355021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14eKgF/ZgTy9NxwrQcItxASl1tsc6lkKw8cF3LPOCH0=;
        b=FppnZhZzTOelRRFp1GOvv84UcLu/2T9oA97PXwh1SdEVmSYhj8HKdd7u2RGWQ1bWVY
         qGWlVwYu1D5p712SVPCqewwKN2vBNfODmL01qusDIxbZ5LMcm2dVTDzhYXmk3Xs9W1Ch
         Xm7qLaD/d+Lw0kgtw4QvgzRLFjn14Np36TtdU3pg27UNxODkjIlhevQjCzu4CA+rJobp
         juPfk/3A7LOlXELCzcApXabgVnjXEG2zWXPNcPVf+eZHG/p7UWOrPWGhEIL6QWM5D6sZ
         VgOnT1gJeufY9rYEhI5oksGtYnAeIgQKe74t9y44Sn2Fb+L/NueLZqsuJoEsfoCWT7iw
         iYNA==
X-Gm-Message-State: AFuF++kUsAp500EJu9GIO50u8Dqj0VTF4eCUUqtXkRaOb7iA0IUWuD/d
	IyWb0vnBGgIQOY2o5NkQNz+Wqz6YWjOzpvpccyX7LYga6kzH+yIja3J4jzWCvLBefwo=
X-Gm-Gg: AYBFou1f+Ge1ffOLyEa3G0R6aRvtHvXqD5fGxi1GHqscE2mAVPbYZgDhXG4Zz7wx3Cf
	WxpEIryV8MNlb/H3+OhPBwvjaFLr3+iqaurNoGPdrkU1kRnX47RoRIGPbrpjDyA5akumZ9yNsR+
	MPeyo9LFkHqHi6qWd1SFu7vSoY/hUyqJFX0Wi9ghQNvV1h3SzMNdBgDnsYNDscQUTYXQpzT5UF8
	fFgu0SV7TWtJ45oYvmiHubkEWal4BMPuMKJu5zztUQxmSwYqXeN2rMpeo/sDxOSNk2gholfTRYI
	M8RrzbGaEvxuQe09LauvlUnDbfK95J2hmEelwrquSYtKTY3ZSRm/mg6LaFK60aaHeLTZtTqo7mE
	7a7ibJAYxlsic/Ptsflis2fdgqNVjFEqzoWj4Tf9SmEWepUH7fZtzYD7FeS7ecTaS01zIGEIF3/
	GfqSNjaOpyUAAL21ycdCMWBu+3kWQkWysaHQfqd3YTt5jw/KBsIsId0Ru1EyJnapLUEY+IVY8bT
	n2GpRnlPseQFyG9KrYSlqCn0ts+RB0kbhvD
X-Received: by 2002:a05:600c:6305:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fc56719a8mr15706645e9.4.1789750221029;
        Fri, 18 Sep 2026 09:50:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a888:e521:9904:1dbd? ([2620:10d:c092:500::6:24b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm4623325e9.7.2026.09.18.09.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:50:20 -0700 (PDT)
Message-ID: <e530342b-8f21-43c9-a3bb-695e6b63c019@gmail.com>
Date: Fri, 18 Sep 2026 17:50:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix task work round ownership race
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org
References: <20260918080014.54012-1-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260918080014.54012-1-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 9:00 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> This series fixes a race in the bpf_task_work scheduling kfuncs and
> adds a regression test for it.
> 
> A task_work callback scheduled for a task running on another CPU can
> complete before bpf_task_work_irq() regains control after
> task_work_add().  The callback's cleanup releases ctx->task, so a
> concurrent map value deletion that publishes the FREED state makes the
> resumed irq_work handler call task_work_cancel(NULL, &ctx->work),
> dereferencing task_struct::task_works through a NULL task (RIP at
> task_work_cancel+0xd, RDI == 0, CR2 at the task_works offset).  The
> same cancellation is reached when the deletion wins before the
> callback runs and the callback's bailout path drops the last ctx
> refcount, clearing ctx->task.
> 
> Patch 1 gives each scheduling round an ownership count: the irq_work
> scheduler, the published callback and an asynchronous canceller hold a
> reference while using this round's task/prog/work, and only the last
> user releases them, before the ctx can be reused from STANDBY.  The
> count is zero based with the STANDBY -> PENDING transition acting as
> the zero-to-one gate, so a finished round cannot be revived: a
> canceller either pins a still-active round (ctx->task guaranteed
> valid) or declines to cancel.  Separate irq_work objects for
> scheduling, cancellation and deferred destruction avoid reinitializing
> an irq_work that may still be queued or running.  FREED remains
> terminal and the scheduling path stays atomic-only, preserving NMI
> safety.
> 
> The race window between task_work_add() and the SCHEDULING ->
> SCHEDULED cmpxchg is only a few instructions wide, so the fix was
> verified with a deterministic reproduction that widens exactly this
> window with a debug delay, while scheduling cross-CPU and deleting the
> map value concurrently: without the fix the kernel panics reliably;
> with it, all interleavings complete.  A 900-round stress test rotating
> through ctx reuse, deletion after the callback and deletion right
> after scheduling also runs clean, with no leaks reported by kmemleak.
> 
> Patch 2 adds a selftest that keeps steady pressure on the
> interleaving: it schedules cross-CPU, deletes the map value at
> different points of a round, uses READY/DONE handshakes so scheduling
> errors cannot be missed, and tags every callback with a generation so
> a late callback cannot satisfy a later round's assertions.
> 

I could not reproduce the kernel crash on my computer, the test is also
very flaky:

./test_progs -t task_work_race
serial_test_task_work_race:FAIL:round ready unexpected error: -5 (errno 2)
#513     task_work_race:FAIL

Could you please share a bit more on how to repro the crash, feel free to
share your config, arch, any details on how you run it.

> Yun Lu (2):
>   bpf: Fix task work round ownership during cancellation
>   selftests/bpf: Add task work round ownership race test
> 
>  kernel/bpf/helpers.c                                  | 123 ++++++++++--
>  .../selftests/bpf/prog_tests/test_task_work.c         | 283 +++++++++++++++++++++
>  .../selftests/bpf/progs/task_work_race.c              | 125 ++++++++
>  3 files changed, 503 insertions(+), 28 deletions(-)
> 


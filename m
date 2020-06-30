Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C966C433DF
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327422078A
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 01:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI1tHnAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgF3BZu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgF3BZu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 21:25:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C09C061755;
        Mon, 29 Jun 2020 18:25:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so17175774qko.7;
        Mon, 29 Jun 2020 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHHO1/s+KcAJZl8plSzZePPHr61XW6/FU8wj+hanOag=;
        b=AI1tHnAOc0T3nNg1Pq0TME2im0KlJiwhCIfSpesUfHxJQFRYJ6WY1Ivnf7sb8ysiWA
         kK0xxhOdZt/xA0XUoWbnIeIfa0mS1hBzq5E0T+np1Qpku495WdOhRE1t7DknhzRdG9xb
         js7HJTKblLfftHy4R5E1hMcUtdS9U4CISasdZJh/Y2eJpegCnrvZEExmSP5oaSFJQ0Xy
         DJCD45pksSZYliu6XFf1Afyg4vBVCDUZqOXdgfUZ1JACUJ4qy18gx9WhhOLHTppWUo3r
         hSd9sE8v0C+w7CySlqQ2my8bCvbTBZumTTTYFLn6KffxgDrzuiDuehB+7YtBbJtx5KyI
         G2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHHO1/s+KcAJZl8plSzZePPHr61XW6/FU8wj+hanOag=;
        b=DgPpiDmKTNpp3Im7arwt8BASK6UY+q375ZZC+uvh5gf4rGs0Erv8U9winPkCb5UYBe
         o9NWQPX9PbZhk/V5ZGp7kv+hM1/crhOh469tmrHVBFuD1fxVarGc4PJ9M3LybGV0kpZQ
         8ihDcAuKTX5t2ins6HDwMUcCvsAFtblBwMfk6qD47k75nQMRtjVIYEfw1C8kdvX4fNir
         Cj32sdSUhFwhs7yrsQI8CNPrHengoUUI9KtlTvVG6TFyoInhZdSsiap0nzX0xMeKzJ2F
         pmKeV4i1a47II0YnEnPip0OCIlv6Z+o/lSNWwmxSsNOLrofBSgeKxHpUHofzLX2ORD1q
         kzUA==
X-Gm-Message-State: AOAM530xf3nfJPBOFt2Lyp22EiJu+qrAirU03ELv14SfhI/uORW4YKB0
        8Wey6hlS08JkSzVPIoo/QOtuvDTjf1wuUFg8gcI=
X-Google-Smtp-Source: ABdhPJzmni681BES0Ghmq/qreIqv8IU76HJR+692CiltUzx2VOEJNJ2BJWnCjP0uF2uPxaljfJBd5WpGqD2kqLD2d8M=
X-Received: by 2002:a05:620a:2409:: with SMTP id d9mr18401354qkn.36.1593480349328;
 Mon, 29 Jun 2020 18:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200630003441.42616-1-alexei.starovoitov@gmail.com> <20200630003441.42616-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20200630003441.42616-6-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Jun 2020 18:25:38 -0700
Message-ID: <CAEf4BzaH367tNd77puOvwrDHCeGqoNAHPYxdy4tXtWghXqyFSQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/5] selftests/bpf: Add sleepable tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 5:35 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Modify few tests to sanity test sleepable bpf functionality.
>
> Running 'bench trig-fentry-sleep' vs 'bench trig-fentry' and 'perf report':
> sleepable with SRCU:
>    3.86%  bench     [k] __srcu_read_unlock
>    3.22%  bench     [k] __srcu_read_lock
>    0.92%  bench     [k] bpf_prog_740d4210cdcd99a3_bench_trigger_fentry_sleep
>    0.50%  bench     [k] bpf_trampoline_10297
>    0.26%  bench     [k] __bpf_prog_exit_sleepable
>    0.21%  bench     [k] __bpf_prog_enter_sleepable
>
> sleepable with RCU_TRACE:
>    0.79%  bench     [k] bpf_prog_740d4210cdcd99a3_bench_trigger_fentry_sleep
>    0.72%  bench     [k] bpf_trampoline_10381
>    0.31%  bench     [k] __bpf_prog_exit_sleepable
>    0.29%  bench     [k] __bpf_prog_enter_sleepable
>
> non-sleepable with RCU:
>    0.88%  bench     [k] bpf_prog_740d4210cdcd99a3_bench_trigger_fentry
>    0.84%  bench     [k] bpf_trampoline_10297
>    0.13%  bench     [k] __bpf_prog_enter
>    0.12%  bench     [k] __bpf_prog_exit
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/bench.c           |  2 +
>  .../selftests/bpf/benchs/bench_trigger.c      | 17 +++++
>  .../selftests/bpf/prog_tests/test_lsm.c       |  9 +++
>  tools/testing/selftests/bpf/progs/lsm.c       | 64 ++++++++++++++++++-
>  .../selftests/bpf/progs/trigger_bench.c       |  7 ++
>  5 files changed, 97 insertions(+), 2 deletions(-)
>

[...]

> +
> +SEC("fentry.s/__x64_sys_setdomainname")
> +int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
> +{
> +       int buf = 0;
> +       long ret;
> +
> +       ret = bpf_copy_from_user(&buf, sizeof(buf), (void *)regs->di);
> +       if (regs->si == -2 && ret == 0 && buf == 1234)
> +               copy_test++;
> +       if (regs->si == -3 && ret == -EFAULT)
> +               copy_test++;
> +       if (regs->si == -4 && ret == -EFAULT)
> +               copy_test++;

regs->si and regs->di won't compile on non-x86 arches, better to use
PT_REGS_PARM1() and PT_REGS_PARM2() from bpf_tracing.h.

> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> index 8b36b6640e7e..9a4d09590b3d 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -39,6 +39,13 @@ int bench_trigger_fentry(void *ctx)
>         return 0;
>  }
>
> +SEC("fentry.s/__x64_sys_getpgid")
> +int bench_trigger_fentry_sleep(void *ctx)
> +{
> +       __sync_add_and_fetch(&hits, 1);
> +       return 0;
> +}
> +
>  SEC("fmod_ret/__x64_sys_getpgid")
>  int bench_trigger_fmodret(void *ctx)
>  {
> --
> 2.23.0
>

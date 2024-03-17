Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7517A2A
	for <bpf@vger.kernel.org>; Sun, 17 Mar 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710707944; cv=none; b=WMEBbnIDoL4u7tPrBQKcfoywJiblPQG+ifcQXS7CnHmxjElzTio56gPqvfIUB38r2U3ye/29rwvFErc14u6T+jIIRihENDLnxGGuTVqK+v1qqYdN3GnPP7gNpuHLNcORyO8nBSfAIKAnNrTs9hXiYMkJ1wsSV9lkLLBik2vfbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710707944; c=relaxed/simple;
	bh=6ol9QjyqJ5fjzC/km4vpD5Xptu55NfKtTF53hZ/XRp8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb5bo2Ff4vbhOfz2/rWKgxMDXpZg1YmjawQUl1l5gwuC8Dncpa3F0oyupo3I7zgDSfhlQVZ9C0RGp3mY4XuFQtHrzo9BUxE6bExW6KJT3gBy24oPW3uDA5kMNRC61Ogx4jLIvgE2C5PBhql/mWv6vQM4fnAGUt1zh9Nn3atNv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm8R/zu1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm8R/zu1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso2053445f8f.0
        for <bpf@vger.kernel.org>; Sun, 17 Mar 2024 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710707941; x=1711312741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5WTgoO0ZH3+SgvEiDrbHquvEfY3h3VInRoCaJLUaelQ=;
        b=Pm8R/zu16NA1zVdYFlVWN6GLXFxpbW3X0r8RysJIoih1Xfw6evrqegLcYJ4tDPuMJW
         7EBRI5x4c2FOmQ6PxIb8vVD7QcSmQ6or9a+izNlbMNXyPa1fkkoV6hOKRdMfdwdKw3A/
         MkxIABEKvEb+rxH9cOCcr8d8sqcXs2tZIb1384xKOYxfRf83q6B3p1n5/K0I1JEmhuat
         TIX2gDqM5aolCf3hG4O1PZ2ZOZB6eT7hwojm1fSveGa++M7JrJFUB1HStuNaCBH2BbCE
         H6dKuG3Binm4fdp+V5tgGOwAvD3pStRq3k2EOYyqQJaOtLV3EPPOBk6BWk++HxBLvOaT
         8zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710707941; x=1711312741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WTgoO0ZH3+SgvEiDrbHquvEfY3h3VInRoCaJLUaelQ=;
        b=a1d1Xk9rfPU76jc+FLAfwJnO6BKl97asEFcnw/pLL3V33Gm4SLQH8wHQhF5lKeUkJC
         oEZ/M7fVxO55sQ4fJHDj1ohaC5A0D84cFcoGFPF4Ew27p0g7vt/u+wrNlXukh7lQ0jP6
         9Hk55QPc76N12O/FzPoYKGi3EvTyaPRWXXw9wt5w4fOI+oRhsvGrzHPKCFKeqc9RIfWn
         BIogTBSqp6fI4PrDwul4TNuhBOfHU7LSh7iKUxkEEZcHHpPwX32ivfyLogUGNnE0kKLY
         vz7lYjZE/YSTgnX3b+zGwrB1wMgYcstIzZ5RC2/+thakro0DqjtP0JeygZOe/hv7d3k2
         R1hw==
X-Forwarded-Encrypted: i=1; AJvYcCXAJYu6n0dHLp44usnuxV9CZvdKbsJqbQscIRMiQC+MheAgSMiBZIe8583LxLBdQ5K3Pn4P5LLJ9tdbGH+MB7HpsoUX
X-Gm-Message-State: AOJu0YyEv+7Ws0iMKXr9UcxRAudgQanSG5QE7N92wxRSmCNpgVbJ7mJ6
	Br7TkuvjvitqIXP6Kn/E51uuyV+0t8EJCr9GKzxfB1KEYsRkeFoc
X-Google-Smtp-Source: AGHT+IGzolPzzIM7u69NyCXth/xuvIzIJNw1vx8sLqOEnZHsjD0kUjkm19Of+v48KMPC63oEElrXoQ==
X-Received: by 2002:adf:a395:0:b0:33e:83a1:227e with SMTP id l21-20020adfa395000000b0033e83a1227emr11708055wrb.7.1710707940672;
        Sun, 17 Mar 2024 13:39:00 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b0033ec94c6277sm8202545wrp.115.2024.03.17.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 13:39:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 Mar 2024 21:38:58 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
Message-ID: <ZfdU4ordMYOGP0BQ@krava>
References: <20240315051813.1320559-1-andrii@kernel.org>
 <20240315051813.1320559-2-andrii@kernel.org>
 <ZfQQeyPu6gi4Bx9V@krava>
 <CAEf4BzayNECKkmc4=XfLW5fzsPozMnjqOEmGO+r2UmEQXt1XyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzayNECKkmc4=XfLW5fzsPozMnjqOEmGO+r2UmEQXt1XyA@mail.gmail.com>

On Fri, Mar 15, 2024 at 03:22:29PM -0700, Andrii Nakryiko wrote:
> On Fri, Mar 15, 2024 at 2:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 10:18:13PM -0700, Andrii Nakryiko wrote:
> > > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping between
> > > one syscall execution and BPF program run. While we use a fast
> > > get_pgid() syscall, syscall overhead can still be non-trivial.
> > >
> > > This patch adds kprobe/fentry set of benchmarks significantly amortizing
> > > the cost of syscall vs actual BPF triggering overhead. We do this by
> > > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
> > > which does a tight parameterized loop calling cheap BPF helper
> > > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > > attached for benchmarking.
> > >
> > > This way 1 bpf() syscall causes N executions of BPF program being
> > > benchmarked. N defaults to 100, but can be adjusted with
> > > --trig-batch-iters CLI argument.
> > >
> > > Results speak for themselves:
> > >
> > > $ ./run_bench_trigger.sh
> > > uprobe-base         :  138.054 ą 0.556M/s
> > > base                :   16.650 ą 0.123M/s
> > > tp                  :   11.068 ą 0.100M/s
> > > rawtp               :   14.087 ą 0.511M/s
> > > kprobe              :    9.641 ą 0.027M/s
> > > kprobe-multi        :   10.263 ą 0.061M/s
> > > kretprobe           :    5.475 ą 0.028M/s
> > > kretprobe-multi     :    5.703 ą 0.036M/s
> > > fentry              :   14.544 ą 0.112M/s
> > > fexit               :   10.637 ą 0.073M/s
> > > fmodret             :   11.357 ą 0.061M/s
> > > kprobe-fast         :   14.286 ą 0.377M/s
> > > kprobe-multi-fast   :   14.999 ą 0.204M/s
> > > kretprobe-fast      :    7.646 ą 0.084M/s
> > > kretprobe-multi-fast:    4.354 ą 0.066M/s
> > > fentry-fast         :   31.475 ą 0.254M/s
> > > fexit-fast          :   17.379 ą 0.195M/s
> > >
> > > Note how xxx-fast variants are measured with significantly higher
> > > throughput, even though it's exactly the same in-kernel overhead:
> > >
> > > fentry              :   14.544 ą 0.112M/s
> > > fentry-fast         :   31.475 ą 0.254M/s
> > >
> > > kprobe-multi        :   10.263 ą 0.061M/s
> > > kprobe-multi-fast   :   14.999 ą 0.204M/s
> > >
> > > One huge and not yet explained deviation is a slowdown of
> > > kretprobe-multi, we should look into that separately.
> > >
> > > kretprobe           :    5.475 ą 0.028M/s
> > > kretprobe-multi     :    5.703 ą 0.036M/s
> > > kretprobe-fast      :    7.646 ą 0.084M/s
> > > kretprobe-multi-fast:    4.354 ą 0.066M/s
> > >
> > > Kprobe cases don't seem to have this illogical slowdown:
> > >
> > > kprobe              :    9.641 ą 0.027M/s
> > > kprobe-multi        :   10.263 ą 0.061M/s
> > > kprobe-fast         :   14.286 ą 0.377M/s
> > > kprobe-multi-fast   :   14.999 ą 0.204M/s
> >
> > hum, I see that as well:
> >
> > uprobe-base         :  230.624 ą 0.527M/s
> > base                :   16.320 ą 0.087M/s
> > tp                  :   10.057 ą 0.122M/s
> > rawtp               :   14.851 ą 0.300M/s
> > kprobe              :   10.993 ą 0.104M/s
> > kprobe-multi        :   11.053 ą 0.038M/s
> > kretprobe           :    6.679 ą 0.015M/s
> > kretprobe-multi     :    6.466 ą 0.015M/s
> > fentry              :   14.949 ą 0.064M/s
> > fexit               :   10.530 ą 1.275M/s
> > fmodret             :   11.145 ą 0.245M/s
> > kprobe-fast         :   20.080 ą 0.468M/s
> > kprobe-multi-fast   :   17.603 ą 0.102M/s
> > kretprobe-fast      :    9.943 ą 0.056M/s
> > kretprobe-multi-fast:    5.185 ą 0.022M/s
> > fentry-fast         :   46.697 ą 0.260M/s
> > fexit-fast          :   19.250 ą 0.108M/s
> >
> >
> > I even see decline in kprobe-multi-fast:
> >
> >   kprobe-fast         :   20.080 ą 0.468M/s
> >   kprobe-multi-fast   :   17.603 ą 0.102M/s
> >
> >   kretprobe-fast      :    9.943 ą 0.056M/s
> >   kretprobe-multi-fast:    5.185 ą 0.022M/s
> >
> >
> > I've got some IBT related code showing up in the perf profile
> > and when I disabled it I got better results for kprobe-multi-fast
> > but kretprobe-multi-fast is still bad
> 
> ok, I think it's a self-inflicted false alarm. Note how this benchmark
> is using bpf_get_smp_processor_id() as an attach point? Well, guess
> what, each triggered program is then calling
> bpf_get_smp_processor_id() again to get the per-CPU counter to
> increment. So this benchmark was effectively heavily testing recursion
> protection, and I guess kretprobe hurts the most.

heh, nice :-) that explains the bpf_prog_inc_misses_counter hits
I see in perf profile

     1.46%  bench    [kernel.vmlinux]                                              [k] bpf_prog_inc_misses_counter
            |
            ---bpf_prog_inc_misses_counter
               kprobe_multi_link_prog_run.isra.0
               fprobe_exit_handler
               rethook_trampoline_handler
               arch_rethook_trampoline_callback
               arch_rethook_trampoline
               bpf_prog_7790468e40a289ea_bench_trigger_kretprobe_multi_fast
               kprobe_multi_link_prog_run.isra.0
               fprobe_exit_handler
               rethook_trampoline_handler
               arch_rethook_trampoline_callback
               arch_rethook_trampoline
               bpf_prog_db14b3b08bc9e952_trigger_driver
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               do_syscall_64
               entry_SYSCALL_64
               syscall
               start_thread
               clone3

jirka

> 
> I realized that when I moved to bpf_get_numa_node_id() and seeing much
> higher numbers:
> 
> BEFORE
> ======
> $ benchs/run_bench_trigger.sh kprobe-batch fentry-batch
> kprobe-batch        :   14.018 ± 0.333M/s
> fentry-batch        :   31.470 ± 0.791M/s
> 
> AFTER
> =====
> $ benchs/run_bench_trigger.sh kprobe-batch fentry-batch
> kprobe-batch         :   19.391 ± 0.868M/s
> fentry-batch         :   48.785 ± 0.932M/s
> 
> That's when I realized something is off here. Now results make a bit
> more sense (machine on which I test is different, so absolute values
> differ from before):
> 
> $ benchs/run_bench_trigger.sh kprobe kprobe-multi kprobe-batch
> kprobe-multi-batch kretprobe kretprobe-multi kretprobe-batch
> kretprobe-multi-batch
> kprobe               :    8.114 ± 0.199M/s
> kprobe-multi         :    8.739 ± 0.052M/s
> kprobe-batch         :   19.379 ± 0.709M/s
> kprobe-multi-batch   :   24.969 ± 0.226M/s
> kretprobe            :    4.859 ± 0.027M/s
> kretprobe-multi      :    4.940 ± 0.083M/s
> kretprobe-batch      :    8.460 ± 0.044M/s
> kretprobe-multi-batch:    8.761 ± 0.282M/s
> 
> 
> >
> >
> > uprobe-base         :  234.024 ą 0.225M/s
> > base                :   16.383 ą 0.029M/s
> > tp                  :    9.973 ą 0.017M/s
> > rawtp               :   14.889 ą 0.047M/s
> > kprobe              :   10.970 ą 0.011M/s
> > kprobe-multi        :   11.640 ą 0.009M/s
> > kretprobe           :    6.667 ą 0.005M/s
> > kretprobe-multi     :    6.704 ą 0.005M/s
> > fentry              :   14.968 ą 0.024M/s
> > fexit               :   11.860 ą 0.012M/s
> > fmodret             :   12.656 ą 0.036M/s
> > kprobe-fast         :   20.340 ą 0.043M/s
> > kprobe-multi-fast   :   21.203 ą 0.019M/s
> > kretprobe-fast      :    9.956 ą 0.021M/s
> > kretprobe-multi-fast:    5.611 ą 0.006M/s
> > fentry-fast         :   46.825 ą 0.041M/s
> > fexit-fast          :   19.746 ą 0.024M/s
> >
> > slightly better:
> >
> >   kprobe-fast         :   20.340 ą 0.043M/s
> >   kprobe-multi-fast   :   21.203 ą 0.019M/s
> >
> > still almost half perf:
> >   kretprobe-fast      :    9.956 ą 0.021M/s
> >   kretprobe-multi-fast:    5.611 ą 0.006M/s
> >
> > jirka
> >
> > >
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/bench.c           |  18 +++
> > >  .../selftests/bpf/benchs/bench_trigger.c      | 123 +++++++++++++++++-
> > >  .../selftests/bpf/benchs/run_bench_trigger.sh |   8 +-
> > >  .../selftests/bpf/progs/trigger_bench.c       |  56 +++++++-
> > >  4 files changed, 201 insertions(+), 4 deletions(-)
> > >
> 
> [...]

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DF17F5
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710536837; cv=none; b=aWs0Wo7nJCchDl/u67QcIsYoMm7uLUdehH3IEeCg6FK5w3BSpUF3Hw0lG15VUP2eftCC42jPs36f1rDwMHj3oAWZZwhGB/PH4UADVrVMj9gEnVDqrBhXfDM6JXsWAkgWEO/4sJ4m/SuWDTGw+S0sVfIyHMM1uC2132TLicfXj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710536837; c=relaxed/simple;
	bh=0p31RczpRrtBHqWlTPWUSAr5T1lZttwvxM4YLGqBBG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxfX/YDjMgx23WPf5xamzzJuIPDyW/riTrw7646D/HwIzEajMeGHIzLWn6Ha0NwgAOMBk6z2J1zhwoY3VZ2pIL+Mab0eSJdvVBjdhau3dDrc2QFrclo+0g34TRBqtu1nPbnzl6ZDviIONh0oCwmHeKDCSb2DnmaXDVC27HkEaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwWWxDzo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwWWxDzo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def2a1aafaso7299735ad.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710536833; x=1711141633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEvsej7Ta2qkdjzsg5dv2TQze2XzeQtDar7fl8SfNHA=;
        b=IwWWxDzoCdVBXMGbov7+2Wte6hqajpQjqwGXLxcbq2kPQbGYAwarmJsmCehr2IUHvw
         e4UY+9Ytx1tONfoSU6r2xA98gtiVvlxlJVu/tgm5UgkATUkTjmvVpIfosIBEb48LDesa
         ifMzO5QNO4/8QnlCsKWknzPwQgRy0uwaRd/ypP1iJwDHCm35UYQiTtICYlQEptTZkREg
         iLCJl+ezL4VkThDipjNaMg5N2RXzqbp2WeBTa/fEnp9j2LBwd8vINIknVy7g1C5TlyXH
         zOlVMLV1N+7Gz7FDoVrXqryed7oY4MfmNPQG0DqlvBjo4wreOajjQ/wG6iwSPHXOE+e6
         O5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710536833; x=1711141633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEvsej7Ta2qkdjzsg5dv2TQze2XzeQtDar7fl8SfNHA=;
        b=jcx5jP/wyBDudMK4BBLdaQ5F/txsNWhuUOtnoDPNFc4ZNUK8MC3PNSO5E4toeHLcWX
         0e9DguAKecQPkrpr+VojuklhdH5KL2//IT5I0k5lr22p3kALtgd7yzkhRv/m/HEko4bF
         Y89WSL2QfDYRXqasBY68TBO4kBBxh6ZqJWSFs/31bI9Hz7sM82twqwXiAKWL8Gor3hHv
         VGAsSpqEIv95dQ5P922UqRIVWtmWpwJYRc+tJQrVk3bn3TymVB5iykqglR8Nl97I4MwV
         ro2B3l+ulbocu4VgDlbI/zEtXF/2HqSfFpb1yKn9JTE+C1arp4ukExO7aLsjoeORyECk
         KtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoKneu5VZzeAsbujF+0qBXN15riMjqZGOl9vsoMi9FdotKaM8y0XC7CMKDjgtx/GHQ9u41EC2z0NndSfg+ZDGC3kQ
X-Gm-Message-State: AOJu0Yw1ypfGgMJjzQDGxCSgTN+azwpETELz3ws8/aCdXx6KkDBaBJSf
	8czgCvMjVN6UeEL/r3/bFUsdXamBv5mYIZM+XU74uzbsZlNIKH78yVwofogQKcFLKAFuuRXZmi/
	8ZCOnTjbLN4mVVrQxGCuv6dEwBynmWS4c
X-Google-Smtp-Source: AGHT+IGVeHjPEwaNm7To+Ndlz1PkLEXKRYromCSMGPuMN6d3+poPAVkdgsv0tJZPl8D78rdU8rHYpW/DjOgI2G7EvhI=
X-Received: by 2002:a17:902:f64d:b0:1dd:a16e:dea4 with SMTP id
 m13-20020a170902f64d00b001dda16edea4mr5622876plg.67.1710536833480; Fri, 15
 Mar 2024 14:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
 <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com>
 <CAEf4BzYuMJVoEhK=wHhzDN2193ZvTupG6i+Ya6YjZNWohdADxQ@mail.gmail.com>
 <CAEf4BzY433C4NJog_mQLQC0oK_7k5zs2xSgxx9qQ7f+QsST5cA@mail.gmail.com> <CAADnVQKYDLEkcfWCfs6xzBc_gfn-dSX39WynoKV629Q-Kw1aQA@mail.gmail.com>
In-Reply-To: <CAADnVQKYDLEkcfWCfs6xzBc_gfn-dSX39WynoKV629Q-Kw1aQA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 14:07:01 -0700
Message-ID: <CAEf4BzYsWuYHQnUW9qLQtRzWL3tphXABuM-dyvQscugN0adNtA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 15, 2024 at 9:59=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 15, 2024 at 9:31=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Mar 15, 2024 at 9:03=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@ke=
rnel.org> wrote:
> > > > >
> > > > > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping =
between
> > > > > one syscall execution and BPF program run. While we use a fast
> > > > > get_pgid() syscall, syscall overhead can still be non-trivial.
> > > > >
> > > > > This patch adds kprobe/fentry set of benchmarks significantly amo=
rtizing
> > > > > the cost of syscall vs actual BPF triggering overhead. We do this=
 by
> > > > > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp pr=
ogram
> > > > > which does a tight parameterized loop calling cheap BPF helper
> > > > > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > > > > attached for benchmarking.
> > > > >
> > > > > This way 1 bpf() syscall causes N executions of BPF program being
> > > > > benchmarked. N defaults to 100, but can be adjusted with
> > > > > --trig-batch-iters CLI argument.
> > > > >
> > > > > Results speak for themselves:
> > > > >
> > > > > $ ./run_bench_trigger.sh
> > > > > uprobe-base         :  138.054 =C2=B1 0.556M/s
> > > > > base                :   16.650 =C2=B1 0.123M/s
> > > >
> > > > What's going on here? Why two bases are so different?
> > > > I thought the "base" is what all other benchmarks
> > > > should be compared against.
> > > > The "base" is the theoretical maximum for all benchs.
> > > > Or uprobe* benches should be compared with uprobe-base
> > > > while all other benchs compared with 'base' ?
> > > > Probably not anymore due to this new approach.
> > > > The 'base' is kinda lost its value then.
> > >
> > > naming is hard. base is doing syscall(get_pgid) in a tight loop. It's
> > > base compared to previous trigger benchmarks where we used syscall to
> > > trigger kprobe/fentry programs. uprobe-base is just a user-space loop
> > > that does atomic_inc() in a tight loop. So uprobe-base is basically
> > > the measure of how fast CPU is, but it's unrealistic to expect either
> > > fentry/kprobe to get close, and especially it's unrealistic to expect
> > > uprobes to get close to it.
> > >
> > > Naming suggestions are welcome, though.
> > >
> > > I'm not sure what the "base" should be for xxx-fast benchmarks? Doing
> > > a counter loop in driver BPF program, perhaps? Would you like me to
> > > add base-fast benchmark doing just that?
> > >
> >
> > How about this.
> >
> > base -> base-syscall (i.e., "syscall-calling baseline")
> > uprobe-base -> base-user-loop (i.e., "user space-only baseline")
> > and then for "fast" baseline we add "base-kernel-loop" for
> > "kernel-side looping baseline"
>
> I think "base" part in both doesn't fit.
> Maybe
> base -> syscall_loop
> uprobe-base - user_space_loop

ok

>
> since the first is only doing syscall in a loop
> and the 2nd doesn't even go to the kernel.
>
> >
> > Or we can use some naming based on "counting": base-syscall-count,
> > base-user-count, base-kernel-count?
>
> Instead of fenty-fast -> fentry-batch
> sounds more accurate.
>

ok, -batch it is

> But in general it doesn't feel right to keep the existing
> benchs, since we've discovered that syscall overhead
> affects the measurement so much.
> I think we should bite the bullet and use bpf_testmod in bench tool.

This will worsen the logistics of using it for any benchmark so much
that it will be pretty much a useless tool.

I can try to find some other way to trigger tracepoint and fmod_ret
without relying on custom modules, but I'd rather just remove those
benchmarks altogether than add dependency on bpf_testmod.

> Then we can add a tracepoint there and call it in proper kernel loop,
> then add fmodret-able empty function and call it in another loop.
>
> Then bench tool can trigger them via bpf->kfunc->that_looping_helper
> and capture as accurate as possibly overhead of
> tp, raw_tp, kprobe, fentry, fmodret.
> And all of them will be comparable to each other.
> Right now fmodret vs fentry are comparable, but both have
> syscall time addon which makes the comparison questionable.
> Especially consider the kernels with mitigations.
> Overhead of syscall is even higher and the delta is smaller,
> to the point that fentry vs fexit might measure equal.

It's still useful to be able to do this, even if syscall overhead is
very measurable. Because when profiling it's easy to filter out
syscall overhead and compare purely fentry vs fexit overheads.

Even with mitigations on the differences between fentry and fexit are
measurable. And bench is a nice tool to generate non-stop work to be
able to capture profiling data conveniently. While a custom test
module will make it much harder.


> A benchmarking tool should be a gold standard and accurate tool
> for performance measurement.
>

This was neither a goal, nor do I sign up for that aspiration :) It's
first and foremost a small and useful tool for doing local performance
optimization work when it comes to BPF-related functionality in the
kernel. And its portability is a huge part of this.

> The trick:
> +       for (i =3D 0; i < batch_iters; i++)
> +               (void)bpf_get_smp_processor_id(); /* attach here to bench=
mark */
>
> is neat, but since it works for fentry/kprobe only
> we need testmod to generalize it for fmodret and tracepoints.

see above, I agree it would be nice to have (and I'll look for some
other ways to achieve this), but is not really a required property to
make benchmark useful

For now, I'll drop this patch and re-submit the first one with
__always_inline removed just to get those prerequisites landed.

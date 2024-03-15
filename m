Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105A5490F
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541365; cv=none; b=CKIuy/UGDXZg1PhBANl33gIQIQPnREOeMcvP6rtz+5Ks48MkmII8nW2ID6W9/PpKWBT1mLjdihuShXWCkAwrGfbzhBw7oVylZ9m6WpM12CaYOddBqio/7/0xsIszu3A2vTrVAm/UZwYmCWEr55JrpUmgesRkUyhkHIc/YdvZVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541365; c=relaxed/simple;
	bh=pR5tQvvjoWDTuDNa8SZw5yBb4VJ9wTO5I1kljgxSXOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+vg6BN/AYD2dowqXVhVhfbmXF4wadlNq770UV7HQjWXjFxSvNtjRyu8Ht4BDg+VsH4ltSzFikUFjZFZxtym5B2tjbfw8zMlWSGxI9MDms2BQPBRV5sGZo93kMEgyqTV7HOQEPTYvO/eJDqBP+ECmKOb70u79lOGFPUOAiKfh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmjunUoq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmjunUoq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dddad37712so24222335ad.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710541362; x=1711146162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGbuQ8RpD0zxTJTFrBl/PGYYnhznw5T9sKuZ7wiz98Q=;
        b=dmjunUoqILAh+0du2Htycup53hQnjmtBUSqXCi0swXefJB3iomLact/zAThluh9b/V
         WQBWLpwrvK6EYcEDVuxicYanwpqbLj3a0cSYtuuEK8tAn31nRr0SKu9tkH+OXsSArt3g
         oumZ+czrOte5lXK83hDgyYeTPA6kbGcyQrks4/xMxUrqBV1E7x6hxwGHeMQYZ2JXSBrG
         t8m2qYXnXs/Cn0K60TMjjSVijSE++Iw7WKZal73q+vQp/j6HgCl3jR52KR27qFZeju4s
         ognMVPoOkPIEeqGqQf50eNcGoc0mcaWQN1YqCOm1Afu2wYv+q7r1u8dQ0FalxNquJESm
         7Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541362; x=1711146162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGbuQ8RpD0zxTJTFrBl/PGYYnhznw5T9sKuZ7wiz98Q=;
        b=DT5lHW1IBow6v+iyOtWtqEQ8AeZzevKtnZPAJ7OZqG8Ptm3J360O6a+xd02n/vbZBW
         Yh8aUNlEfPaIdtLWDezVhzdoKGafTCMX67EvgvNH2BjZw61MJwn2MUtnFN2b7PnXTqdE
         vn2GzUPOUkJxWoRQSmu96wyuuogweenh7Mb3STG4FvvPEel1tiF3pefnG38v5o8mRNP0
         EB4uVuJieK0buETGKAMj+BU75TsikVhCGgFv+gPez/NKyJ/KxaZ6oZ0pe+z8HfdKfIQp
         82Ei7CwY37awufYdPkEY1fDTSAPnJdxVR0N2bomu5M9pOjANUhiN1cXvFuao0+dji+at
         IC+A==
X-Forwarded-Encrypted: i=1; AJvYcCU2SSe39J1Zi+WrMaoWwvalqCWcjocXudW7yoiXoWemAZAZAZVllWjfuFHtOPYD5B30exz511aVxKlZJKPkPs9WGQ8u
X-Gm-Message-State: AOJu0Yxa3fFba50OrNSirUZ6bXBKa+GXSJj6PYu9ahVnZZNEitonup+3
	zwAevfRekXaSSO1N2ewPCnuVzLssTmVTqra5nt/Zn+rm4pFOWC6q/aCNVoV/ncSRJHioWtv3jq/
	hb5i72x1dSy1qn/MVvci3JCkn6Dx1jGlR
X-Google-Smtp-Source: AGHT+IGPXGWNfUlzYlvqtNuqBk7OETglj8ogp+msfN7plmiGU0yyIAALJNGTDRyh/kN3Xu407qOKkmPbA++SjdV7yDg=
X-Received: by 2002:a17:903:2309:b0:1dd:8ff9:40b1 with SMTP id
 d9-20020a170903230900b001dd8ff940b1mr7923554plh.59.1710541361752; Fri, 15 Mar
 2024 15:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
 <ZfQQeyPu6gi4Bx9V@krava>
In-Reply-To: <ZfQQeyPu6gi4Bx9V@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 15:22:29 -0700
Message-ID: <CAEf4BzayNECKkmc4=XfLW5fzsPozMnjqOEmGO+r2UmEQXt1XyA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 14, 2024 at 10:18:13PM -0700, Andrii Nakryiko wrote:
> > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping betwee=
n
> > one syscall execution and BPF program run. While we use a fast
> > get_pgid() syscall, syscall overhead can still be non-trivial.
> >
> > This patch adds kprobe/fentry set of benchmarks significantly amortizin=
g
> > the cost of syscall vs actual BPF triggering overhead. We do this by
> > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
> > which does a tight parameterized loop calling cheap BPF helper
> > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > attached for benchmarking.
> >
> > This way 1 bpf() syscall causes N executions of BPF program being
> > benchmarked. N defaults to 100, but can be adjusted with
> > --trig-batch-iters CLI argument.
> >
> > Results speak for themselves:
> >
> > $ ./run_bench_trigger.sh
> > uprobe-base         :  138.054 =C4=85 0.556M/s
> > base                :   16.650 =C4=85 0.123M/s
> > tp                  :   11.068 =C4=85 0.100M/s
> > rawtp               :   14.087 =C4=85 0.511M/s
> > kprobe              :    9.641 =C4=85 0.027M/s
> > kprobe-multi        :   10.263 =C4=85 0.061M/s
> > kretprobe           :    5.475 =C4=85 0.028M/s
> > kretprobe-multi     :    5.703 =C4=85 0.036M/s
> > fentry              :   14.544 =C4=85 0.112M/s
> > fexit               :   10.637 =C4=85 0.073M/s
> > fmodret             :   11.357 =C4=85 0.061M/s
> > kprobe-fast         :   14.286 =C4=85 0.377M/s
> > kprobe-multi-fast   :   14.999 =C4=85 0.204M/s
> > kretprobe-fast      :    7.646 =C4=85 0.084M/s
> > kretprobe-multi-fast:    4.354 =C4=85 0.066M/s
> > fentry-fast         :   31.475 =C4=85 0.254M/s
> > fexit-fast          :   17.379 =C4=85 0.195M/s
> >
> > Note how xxx-fast variants are measured with significantly higher
> > throughput, even though it's exactly the same in-kernel overhead:
> >
> > fentry              :   14.544 =C4=85 0.112M/s
> > fentry-fast         :   31.475 =C4=85 0.254M/s
> >
> > kprobe-multi        :   10.263 =C4=85 0.061M/s
> > kprobe-multi-fast   :   14.999 =C4=85 0.204M/s
> >
> > One huge and not yet explained deviation is a slowdown of
> > kretprobe-multi, we should look into that separately.
> >
> > kretprobe           :    5.475 =C4=85 0.028M/s
> > kretprobe-multi     :    5.703 =C4=85 0.036M/s
> > kretprobe-fast      :    7.646 =C4=85 0.084M/s
> > kretprobe-multi-fast:    4.354 =C4=85 0.066M/s
> >
> > Kprobe cases don't seem to have this illogical slowdown:
> >
> > kprobe              :    9.641 =C4=85 0.027M/s
> > kprobe-multi        :   10.263 =C4=85 0.061M/s
> > kprobe-fast         :   14.286 =C4=85 0.377M/s
> > kprobe-multi-fast   :   14.999 =C4=85 0.204M/s
>
> hum, I see that as well:
>
> uprobe-base         :  230.624 =C4=85 0.527M/s
> base                :   16.320 =C4=85 0.087M/s
> tp                  :   10.057 =C4=85 0.122M/s
> rawtp               :   14.851 =C4=85 0.300M/s
> kprobe              :   10.993 =C4=85 0.104M/s
> kprobe-multi        :   11.053 =C4=85 0.038M/s
> kretprobe           :    6.679 =C4=85 0.015M/s
> kretprobe-multi     :    6.466 =C4=85 0.015M/s
> fentry              :   14.949 =C4=85 0.064M/s
> fexit               :   10.530 =C4=85 1.275M/s
> fmodret             :   11.145 =C4=85 0.245M/s
> kprobe-fast         :   20.080 =C4=85 0.468M/s
> kprobe-multi-fast   :   17.603 =C4=85 0.102M/s
> kretprobe-fast      :    9.943 =C4=85 0.056M/s
> kretprobe-multi-fast:    5.185 =C4=85 0.022M/s
> fentry-fast         :   46.697 =C4=85 0.260M/s
> fexit-fast          :   19.250 =C4=85 0.108M/s
>
>
> I even see decline in kprobe-multi-fast:
>
>   kprobe-fast         :   20.080 =C4=85 0.468M/s
>   kprobe-multi-fast   :   17.603 =C4=85 0.102M/s
>
>   kretprobe-fast      :    9.943 =C4=85 0.056M/s
>   kretprobe-multi-fast:    5.185 =C4=85 0.022M/s
>
>
> I've got some IBT related code showing up in the perf profile
> and when I disabled it I got better results for kprobe-multi-fast
> but kretprobe-multi-fast is still bad

ok, I think it's a self-inflicted false alarm. Note how this benchmark
is using bpf_get_smp_processor_id() as an attach point? Well, guess
what, each triggered program is then calling
bpf_get_smp_processor_id() again to get the per-CPU counter to
increment. So this benchmark was effectively heavily testing recursion
protection, and I guess kretprobe hurts the most.

I realized that when I moved to bpf_get_numa_node_id() and seeing much
higher numbers:

BEFORE
=3D=3D=3D=3D=3D=3D
$ benchs/run_bench_trigger.sh kprobe-batch fentry-batch
kprobe-batch        :   14.018 =C2=B1 0.333M/s
fentry-batch        :   31.470 =C2=B1 0.791M/s

AFTER
=3D=3D=3D=3D=3D
$ benchs/run_bench_trigger.sh kprobe-batch fentry-batch
kprobe-batch         :   19.391 =C2=B1 0.868M/s
fentry-batch         :   48.785 =C2=B1 0.932M/s

That's when I realized something is off here. Now results make a bit
more sense (machine on which I test is different, so absolute values
differ from before):

$ benchs/run_bench_trigger.sh kprobe kprobe-multi kprobe-batch
kprobe-multi-batch kretprobe kretprobe-multi kretprobe-batch
kretprobe-multi-batch
kprobe               :    8.114 =C2=B1 0.199M/s
kprobe-multi         :    8.739 =C2=B1 0.052M/s
kprobe-batch         :   19.379 =C2=B1 0.709M/s
kprobe-multi-batch   :   24.969 =C2=B1 0.226M/s
kretprobe            :    4.859 =C2=B1 0.027M/s
kretprobe-multi      :    4.940 =C2=B1 0.083M/s
kretprobe-batch      :    8.460 =C2=B1 0.044M/s
kretprobe-multi-batch:    8.761 =C2=B1 0.282M/s


>
>
> uprobe-base         :  234.024 =C4=85 0.225M/s
> base                :   16.383 =C4=85 0.029M/s
> tp                  :    9.973 =C4=85 0.017M/s
> rawtp               :   14.889 =C4=85 0.047M/s
> kprobe              :   10.970 =C4=85 0.011M/s
> kprobe-multi        :   11.640 =C4=85 0.009M/s
> kretprobe           :    6.667 =C4=85 0.005M/s
> kretprobe-multi     :    6.704 =C4=85 0.005M/s
> fentry              :   14.968 =C4=85 0.024M/s
> fexit               :   11.860 =C4=85 0.012M/s
> fmodret             :   12.656 =C4=85 0.036M/s
> kprobe-fast         :   20.340 =C4=85 0.043M/s
> kprobe-multi-fast   :   21.203 =C4=85 0.019M/s
> kretprobe-fast      :    9.956 =C4=85 0.021M/s
> kretprobe-multi-fast:    5.611 =C4=85 0.006M/s
> fentry-fast         :   46.825 =C4=85 0.041M/s
> fexit-fast          :   19.746 =C4=85 0.024M/s
>
> slightly better:
>
>   kprobe-fast         :   20.340 =C4=85 0.043M/s
>   kprobe-multi-fast   :   21.203 =C4=85 0.019M/s
>
> still almost half perf:
>   kretprobe-fast      :    9.956 =C4=85 0.021M/s
>   kretprobe-multi-fast:    5.611 =C4=85 0.006M/s
>
> jirka
>
> >
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c           |  18 +++
> >  .../selftests/bpf/benchs/bench_trigger.c      | 123 +++++++++++++++++-
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   8 +-
> >  .../selftests/bpf/progs/trigger_bench.c       |  56 +++++++-
> >  4 files changed, 201 insertions(+), 4 deletions(-)
> >

[...]

Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596227456
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171313; cv=pass; b=nUyYhhgbQXOhzxbZ5iYYAyq/1Fq7lZhQtHkZpMBsvvRdcW1R2Atlqk3vuD7admkRWNkNqs16JzTeC5th8O3B6nEP/9P0H4VTojrdarBQ3B6jfAlBjunLU5tvHbePWm0mBViJ+s+dFzyn5gSXuT9mDsS5WkyZlMZ0zQ6ju74JB28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171313; c=relaxed/simple;
	bh=5M2oHN4/W1JGsvbBCdQgXkIjf8uLcHrDn7UMqzwGc3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4KZLpztqpO1ZFbgc0gQC123D/1uarKcrKO069fq5JDwdaJ5PKVebwTOQvbfVxNl8++UMYdRuCskHFF3lg/ck1w0Pbu4C7RYpz2XzEYoa/Eledd4ChTVuqeoJnrdns50EWNkL83VvQVGvqBKrATN+Sjum5etQfgvV7uOVuN/ygo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjt3ujcY; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjt3ujcY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91ded8174so14493505ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789171311; cv=none;
        d=google.com; s=arc-20260327;
        b=CGx5SS2qPq5+KmtlnGvzyqkvGsgOhMC4sTzMZahTtXqox03LR3HwIzaSIqgWcp+tts
         C4mSNebm2Bg0DGd52q1qfnOhhMqdreNTL1H2XLAOE0aoD4Hs96/ZmE0R1ePmQFYdtzdQ
         ytdgRIpdXNkZmbS3adyCviiQfBz5BWAN/ui68/kAjTq4ncAok0TYiXi/M1SwBNSOZTO3
         PIibgJNTbqCC0V0yaqWY85GlC4aVxVb5Puzn4YbYnlTk3kYcWodmo4QwkH6pnBNlsx7U
         PuCU1XyHI35gFrHwr+hI+SUV67/HLYwudyX8NxO1vADg74A8zF0vV+aqScKXzQdK69wZ
         c8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mqspz0MSddOMVm8ijD7vhkD6xckejL/H1ihnEfK5syA=;
        fh=A2o1Vx4ZLd+A2Zx0NvPI/qz//F2+c6xPgeap4Yu/3O4=;
        b=Uj3EpQDZN4lDDkGakpPez9AcavH/G3u68lXRyixWGSerRwNbGEijwDjTF4O4uJ4Cl6
         SjXKrw2G7oEMh69Z1NYP9e7DDykzGk4Q3BSdEUwv6XXzCD+1szu1aIki/FsF7cVB0Med
         ftKAcAu9LgjzVY7tsZ0gkSSrODVYcPkcOXvqV4GRG6kZrnYLlLvTXsEPFqUORSBPNIOz
         L158/0Z2Y8xmZrcoAndhmUmXPWi9Kz9FCzPP0A59iKYejWDQDHpVB4IQIRdYzSONAPLG
         TMWaApoVLiLB+r8g0CF4i1f823UEUOqn90eeOj9GGgzzuy/heXqjilT9g1Z0Mtq/sRFg
         22og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789171311; x=1789776111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mqspz0MSddOMVm8ijD7vhkD6xckejL/H1ihnEfK5syA=;
        b=Tjt3ujcYZIDQHIdXSYSiCSsSw4ytaVK1xwwL5OabKZsnhJkmp+PRlz6AQvB5/5V7Ua
         2voxpcUFBHnRsZD7rCUYC2YzRmC4UiSau9h0ZeA2bTiUYEUbl5OPtcspRVC39zn00eQR
         dPzNowH3IwrOB0ADmS0p17JUuM/KTpnYD4emuFnlJixCv6vv5F/TmU6g5mDpenLcfp95
         O/01EdTvCVZ/feoTvYMpUWul+K6YhloFXvtQqOM/EBO/8IHmP7eMWyBP6x9ULU/6yVNC
         DrsIvYXkEafHjfXNLyt/do7hUHhbbUh3Z5I5Va3ceFFAIFMmR5ftlOdqSPfs7CwwQlyw
         gAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171311; x=1789776111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mqspz0MSddOMVm8ijD7vhkD6xckejL/H1ihnEfK5syA=;
        b=inrscYdu/eg7BEQSuIenaihgOLPpm/MTpfvuUSMc4iYICGkixI1dpUZsrdayEFUyIv
         iF/5PtiQlOvc3niIAQeqZZN65Npqz1Yrt9MEX1/YGoKc0L4xynaGS9LBrvPGuK3/4d3R
         +nTsSgi35jf9hF6EfQve6FlUzrcTaoglGZM7OZ0T9I7jQq52J11NbQByC7T9FKRWLtm1
         YwHxLnZzbKB1J+X9yWKNaSjFBZTSF05z4p8uIofk/g8rMFdg4SoLCtt5AYiXpBgC8KS9
         tJxSou32aXKm8aukSGxO9lzY6ePx/mchaRlGKKlY/4dE8VNTke0+GGnnW9cTR9noNW6m
         QOKA==
X-Gm-Message-State: AFuF++lEnGyqo9i4wiHOaU1xlpX6D/XCGVpyJLn9i5er+B3IcoIoP2GK
	vLinaJkP59XDrHTX0ZH4D/PDirRavzHs6oPz8phb6ZpJ284LV8j/0yc4MSXPJqeo6gVK2iHVAZ5
	VE7iEaM66Udmu6nex1vv9y/iSPXqbBuc=
X-Gm-Gg: AYBFou1c6ki7ZGajvzaI0Ea5EkEHLHXMgx1PrB5v3Z8xVzeKMMTTDmVGa8x5lkyuba8
	12mAkkMBv1p5tD7/cDPkN5dqk9baHKoAYcyjYs/BqSLZ1D8EKxufWMrn8gzI1B3TAHzCWK96BlH
	2Sfb+eRo4pfU0b/gJGUvuM3TGFTrFMuNyuLPfEXWfHShL2R/riFK1cqSJIGpRoZph17EgxtqM00
	9+hBkkMI7P5lKAdN5Vew8VrpYdLHjGuVGaFft/Fn1FiCydg5xTRB5dZUOuVcXLIAZkLZzxjr/T7
	b1/WgGzzVmq03U1GmeDxY5Z1U9wsgUmkOm26D7Nw0oURaNHXOrDujwvx4rddWajSPXlYBON+N9c
	044AHp0b/ZX6gZlwd5hS71hz1lgpjm9G/Cz7y
X-Received: by 2002:a17:90a:da8f:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39d9bc1007dmr9476969a91.5.1789171311109; Fri, 11 Sep 2026
 17:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
 <CAEf4BzZ0GwQS3vHDywzkLPo_FspsuPYeYEXsZ9q5c5Mp6nWVjQ@mail.gmail.com> <0e948aae-bdbd-4a18-bb87-bdc00d147ef4@gmail.com>
In-Reply-To: <0e948aae-bdbd-4a18-bb87-bdc00d147ef4@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 17:01:38 -0700
X-Gm-Features: AcwNN1X3mVNpzPFoDtvhSrUNqep122vu5cd8AMXvtEw4ZxtkCcf2NgeS6YldKXw
Message-ID: <CAEf4BzYLdA8THKAHaTTGueXXpSwgkyXhnhvwcdFzycLrL+xn=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/9/26 1:02 AM, Andrii Nakryiko wrote:
> > On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Perf counters can report too few events when the PMU multiplexes them.
> >> Scale each per-CPU value before aggregation.
> >>
> >> Use the same CPU set for derived ratios. Report cycles per included
> >> program run, and preserve the total run count in JSON.
> >>
> >> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
> >>  tools/bpf/bpftool/prog.c                         | 159 ++++++++++++++=
+++------
> >>  2 files changed, 133 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/=
bpf/bpftool/Documentation/bpftool-prog.rst
> >> index 90fa2a48cc26..0108a1c8be4d 100644
> >> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> @@ -217,7 +217,16 @@ bpftool prog run *PROG* data_in *FILE* [data_out =
*FILE* [data_size_out *L*]] [ct
> >>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
> >>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds o=
r until
> >>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not =
specified,
> >> -    the profiling will run up to **UINT_MAX** seconds.
> >> +    the profiling will run up to **UINT_MAX** seconds. Plain output s=
cales each
> >> +    per-CPU metric value to correct for perf event multiplexing. When
> >> +    **cycles** is selected, it also reports cycles per included progr=
am run. If
> >> +    a selected metric was not scheduled on a CPU, all metric values e=
xclude
> >> +    that CPU so that ratios use a consistent CPU set. The **run_cnt**=
 value
> >> +    still includes all recorded runs.
> >> +
> >> +    In JSON output, **value** is raw, **value_scaled** is scaled, **r=
un_cnt**
> >> +    includes all runs, and **run_cnt_valid** includes only runs used =
for metric
> >> +    values.
> >>
> >>  bpftool prog help
> >>      Print short help message.
> >> @@ -360,7 +369,7 @@ EXAMPLES
> >>  ::
> >>
> >>           51397 run_cnt
> >> -      40176203 cycles                                                =
 (83.05%)
> >> +      40176203 cycles          # 781.68 cycles per run               =
 (83.05%)
> >>        42518139 instructions    #   1.06 insns per cycle              =
 (83.39%)
> >>             123 llc_misses      #   2.89 LLC misses per million insns =
 (83.15%)
> >>
> >> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >> index 8c2f9255b36d..9e126f3823ad 100644
> >> --- a/tools/bpf/bpftool/prog.c
> >> +++ b/tools/bpf/bpftool/prog.c
> >> @@ -2062,37 +2062,52 @@ static int do_profile(int argc, char **argv)
> >>
> >>  #include "profiler.skel.h"
> >>
> >> +enum ratio_metric {
> >> +       METRIC_NONE =3D -2,
> >> +       METRIC_RUN_CNT =3D -1,
> >> +       METRIC_CYCLES =3D 0,
> >> +       METRIC_INSTRUCTIONS =3D 1,
> >> +       METRIC_L1D_LOADS =3D 2,
> >> +       METRIC_LLC_MISSES =3D 3,
> >> +       METRIC_ITLB_MISSES =3D 4,
> >> +       METRIC_DTLB_MISSES =3D 5,
> >> +};
> >> +
> >>  struct profile_metric {
> >>         const char *name;
> >>         struct bpf_perf_event_value val;
> >> +       __u64 scaled_val;
> >>         struct perf_event_attr attr;
> >>         bool selected;
> >>
> >>         /* calculate ratios like instructions per cycle */
> >> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) *=
/
> >> +       const enum ratio_metric ratio_metric;
> >>         const char *ratio_desc;
> >>         const float ratio_mul;
> >>  } metrics[] =3D {
> >> -       {
> >> +       [METRIC_CYCLES] =3D {
> >>                 .name =3D "cycles",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HARDWARE,
> >>                         .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >>                         .exclude_user =3D 1,
> >>                 },
> >> +               .ratio_metric =3D METRIC_RUN_CNT,
> >> +               .ratio_desc =3D "cycles per run",
> >> +               .ratio_mul =3D 1.0,
> >>         },
> >> -       {
> >> +       [METRIC_INSTRUCTIONS] =3D {
> >>                 .name =3D "instructions",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HARDWARE,
> >>                         .config =3D PERF_COUNT_HW_INSTRUCTIONS,
> >>                         .exclude_user =3D 1,
> >>                 },
> >> -               .ratio_metric =3D 1,
> >> +               .ratio_metric =3D METRIC_CYCLES,
> >>                 .ratio_desc =3D "insns per cycle",
> >>                 .ratio_mul =3D 1.0,
> >>         },
> >> -       {
> >> +       [METRIC_L1D_LOADS] =3D {
> >>                 .name =3D "l1d_loads",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HW_CACHE,
> >> @@ -2102,8 +2117,9 @@ struct profile_metric {
> >>                                 (PERF_COUNT_HW_CACHE_RESULT_ACCESS << =
16),
> >>                         .exclude_user =3D 1,
> >>                 },
> >> +               .ratio_metric =3D METRIC_NONE,
> >>         },
> >> -       {
> >> +       [METRIC_LLC_MISSES] =3D {
> >>                 .name =3D "llc_misses",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HW_CACHE,
> >> @@ -2113,11 +2129,11 @@ struct profile_metric {
> >>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16=
),
> >>                         .exclude_user =3D 1
> >>                 },
> >> -               .ratio_metric =3D 2,
> >> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
> >>                 .ratio_desc =3D "LLC misses per million insns",
> >>                 .ratio_mul =3D 1e6,
> >>         },
> >> -       {
> >> +       [METRIC_ITLB_MISSES] =3D {
> >>                 .name =3D "itlb_misses",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HW_CACHE,
> >> @@ -2127,11 +2143,11 @@ struct profile_metric {
> >>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16=
),
> >>                         .exclude_user =3D 1
> >>                 },
> >> -               .ratio_metric =3D 2,
> >> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
> >>                 .ratio_desc =3D "itlb misses per million insns",
> >>                 .ratio_mul =3D 1e6,
> >>         },
> >> -       {
> >> +       [METRIC_DTLB_MISSES] =3D {
> >>                 .name =3D "dtlb_misses",
> >>                 .attr =3D {
> >>                         .type =3D PERF_TYPE_HW_CACHE,
> >> @@ -2141,13 +2157,14 @@ struct profile_metric {
> >>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16=
),
> >>                         .exclude_user =3D 1
> >>                 },
> >> -               .ratio_metric =3D 2,
> >> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
> >>                 .ratio_desc =3D "dtlb misses per million insns",
> >>                 .ratio_mul =3D 1e6,
> >>         },
> >>  };
> >>
> >>  static __u64 profile_total_count;
> >> +static __u64 profile_valid_count;
> >>
> >>  #define MAX_NUM_PROFILE_METRICS 4
> >>
> >> @@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char=
 **argv)
> >>         return selected_cnt;
> >>  }
> >>
> >> -static void profile_read_values(struct profiler_bpf *obj)
> >> +/*
> >> + * Filter out CPUs that have any selected metric not scheduled for th=
em. This makes sure all
> >> + * metrics are using the same CPU set, as a result ratio metrics are =
consistent.
> >> + */
> >> +static void profile_filter_cpus(__u32 num_cpu,
> >> +                               struct bpf_perf_event_value vals[MAX_N=
UM_PROFILE_METRICS][num_cpu],
> >> +                               __u64 *counts)
> >> +{
> >> +       __u32 m, cpu, key =3D 0;
> >> +
> >> +       for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> >> +               if (!metrics[m].selected)
> >> +                       continue;
> >> +
> >> +               for (cpu =3D 0; cpu < num_cpu; cpu++) {
> >> +                       /*
> >> +                        * CPU has hits, but this metric never schedul=
ed, set counts[cpu] to 0
> >> +                        * so other metrics ignore this CPU too
> >> +                        */
> >> +                       if (counts[cpu] && !vals[key][cpu].running) {
> >> +                               p_info("%s not scheduled on CPU %u; ex=
cluding %llu runs from all metrics",
> >> +                                      metrics[m].name, cpu, counts[cp=
u]);
> >> +                               counts[cpu] =3D 0;
> >> +                       }
> >> +               }
> >> +               key++;
> >> +       }
> >> +}
> >
> > was this suggested by AI or we actually ran into issues due to this in
> > practice? this looks perculiar
> >
>
> Suggested by AI is a bit of a simplification:
> The initial problem was scaling counters, the counters are collected
> and accounted per CPU, so it sounds like a right thing to scale per
> CPU as well(?) Because we divide by running, we need to check it for 0.
> Now it is possible that some counters have running 0 on some CPU, but
> others dont, will it make ratios biased?
>

So you are talking about IPC (insns per cycle) calculation, for
example, right? Where we need two PMUs to both be present on a given
CPU. I think a bit more proper solution for this is PMU groups, so
that they are either both scheduled or both not scheduled. In this
case seems like we'll want 4 PMUs in a group, we'd have to try and see
if that's a problem in practice, but I'd try PMU group first as a
solution for this.


[...]

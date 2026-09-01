Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08094242D67
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306737; cv=pass; b=OrK+AdG0WVzZMziPb8RETaFV3VMZ91O/k66WhxuykBh96Xl5dxlTSCI8JRK/jkblxpUJ0JnjD2PRJ9rk65fo2kpKtPWDsstE2hYAPU7Ja2cjJXAO+utHVmGqfPqKEjRrosKih87NWx1ueylYAmAsJNjkqqXyFUI8/dH/cghPk24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306737; c=relaxed/simple;
	bh=gn/C02Cb6gNvIAcEYYXxprqvVdf+yd4p6kjvL3QJp24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiICx9UiSNrWatlkXhBwg3VUdmeQ4Hj9LJL1lFts/CLaCnbLTy7x9GFBklvJH2Knzvmm5bZc71BDJfZJ/QezA5pTzewLSnVv092gM0hC8z/eHfmY9kWOidpbXT0RBK2PhjQxoHFF2tolv8kKkoNiEiXP9gPoirEAVnIiO+n9Sew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfIkWE4y; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfIkWE4y"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so433286a12.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 16:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788306735; cv=none;
        d=google.com; s=arc-20260327;
        b=irsCLTNv7VQiUbDItyDyEsj05KCfv5ZjUMs7/7aoFC3KbQZs2WJWL1M7ucherWqYaf
         h31fpnoGt7pXTEh7UK2/AAUijZr0JolZuTAjOSCje3pqR98qJr9prSuoeEsA141DueLk
         L780EO++zwtqWve4UpWdzXe7eJXIxEP6wowC+jFzyC9C6mdTPZwT0vyOe1sxr4g5arNc
         cTy1pNsgZFhWHKXoKPFxofgZBmrbjD+B8KpTGsO5C7IEP0XH0nBLrFK5bmauNHMSTzkb
         YnobBWA82CuIDSw972XgLHvIjGYpJ47WMxhfty3j5lzwbGA5y4Z+hBFlYaG6c7s0CG90
         qw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GpURvBRw5m3w+DIjFv1LNIQPqf6apMVy4uAIRo+qDlk=;
        fh=hw+CxGwdyRSj5wqB4GX6f0WZPJRsYCeoip6ZrYfIa8U=;
        b=Qv+VJT01Mr0uvGewQZ23M10mf4oxwAfftpZjxWYYTzPVItSfzfErEYbYrjfJLLgJLy
         Qnz1AMvyy8QRPMwGEOmFF2ysV0j/dafbf8yCoX2tA31dHTj6dr/V0n+9/lfBBMUtPnNt
         rrAi9UW/rdOp8TMRi3Wl3kLijHlWFUyhH7z/52Bcqm06JGD6GlPdVFC2mLaS+27nxLIs
         a8yhGtZbW/9l15Ea4B9vuKfEFhzRVZmqY9EcgSQRJCHlP6XjqgNTKbi5erfUhjzNa0Bp
         +9slb5p2ZJkbpNM+1i0Ee1isiAi/18ljVjOkEjhjEFgWTk1Fqhldoc2C0yGStdkCS0+H
         BuFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788306735; x=1788911535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GpURvBRw5m3w+DIjFv1LNIQPqf6apMVy4uAIRo+qDlk=;
        b=HfIkWE4yKuHVkJzu8Ls5HTMy9gWHNHLJ2Qf7zqyRGq10j3Cea4WmN7+hbdu+HS3Co5
         5+dfQWONG7tVi8Gvq9Beux2jvfOsc6DXfdVfiRaAyVmhTqKGF0mivgqJpnNrp9cbfcYD
         YkBc1vVGzbkdVgSS0IGQbEo/G+90/qrkoDvgk5jw+ai6SgUcGWFvt6BdpX8utz2UodNW
         kRU2I1Ajusp7d/mOBzFKTWosxHHFx5wJMCUdpjDtgRAPfs9PQ19KxLIpFFmwndL/l/4O
         2NYn93puEX8XfsZ+d2/Zib3SHxrzv9QAAXd0fAccOjrKALOrUFbUOCz9wJuBin/gLAEa
         RYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788306735; x=1788911535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpURvBRw5m3w+DIjFv1LNIQPqf6apMVy4uAIRo+qDlk=;
        b=gIPfUN65YHwcoPZd75uL2UYI/fjlmWAv1Z5EiBoczVSldywjgYBD9Dhn0H8ChBH9rN
         M4bGuzkTO9KGxaIYrwXyUSRdIJHjTkfKhoMigWo3urlxu5jNjSuSizZjkZnS2oTB2M4v
         IdZwcylO6Tfmlp1b/77g3JPpt5zR62OLbMTW6Wnt1httPgVFXJ1pVcEI5CUU62RyTdn+
         r0MnubJ5KjkZUXxIMOd768iZYtdsAEldxLdY2V56IEL2JmkLCzqR/815Ze/G6Umm4X3m
         NAVjD1adqZ67KkEENGdbRTTGj2E0Ny7tuD0iocTQuVrv+WzsQm0jV+IPAQ9dTUYdp7sW
         vm7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr1CF0n8Egdq65chJXrNdoXyeS1MjXzr1COzuDJml1uHZAl0XhSoUVBO1oCRAlSUqsXbAA=@vger.kernel.org
X-Gm-Message-State: AFuF++n97OKDGUcTc7qEOXuitNV60LhWu8TBjIruWqIVToX82oFZo1Xe
	LRloUCpEODo6dLaWRys2NEZ35QyqpzOyuwwg5uKyub28CKUFcR8nZ8f4KaKOL/FIf08kiWz3wnD
	PrOeBNH63TNG0f+1nRkNdnTDKNtunRhw=
X-Gm-Gg: AR+sD11HXnlJ2w8zEwC9hLXO8PLeQU4fTaN43qAUfs1jIfOe8yxSsWOxdaC/pSUchvH
	0JALWoC1uZ7LUPfDUqF7jUigpSPHY7xm0pJpkx0aHMamzqhYsSwzopnbn8PN6BaQ0mfs7gQZvge
	ROkVRDxQBEGaRFAM6Hb3gszhbCNqNB+KW7rmlPbPajDKSr7MGz+8JStoTkZTRh4mrRqLxjOKDQY
	viWcLLW13ivDOozCqeFssVp84gHgFiwNurkSP90lTkS63kXcZspv871La47BPJuLp8iCFhbvh75
	t6VI9xLsPYts8Cx5ENOLUPLuDEOVSyUmMxxEcNNHOTuYUloeIqhXHx9lBfn4scfd0URCjS/OlcW
	CPQXlYf/kT7dXvG5Gb4Jtku+aPcv0ZeGIKb2Ie9Ve8A==
X-Received: by 2002:a05:6a21:a510:b0:3d1:c99f:efbf with SMTP id
 adf61e73a8af0-3d9adcc8667mr1161712637.14.1788306735285; Tue, 01 Sep 2026
 16:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
 <3258a85d-3578-4982-bd4b-bd516d9bc8b5@gmail.com> <02e9a006-4543-479b-aab1-f4310e59aafb@gmail.com>
In-Reply-To: <02e9a006-4543-479b-aab1-f4310e59aafb@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Sep 2026 16:51:58 -0700
X-Gm-Features: AcwNN1WNRC7ckk1FxIkdWI0Tt3RrA0CuPqLgyJ2XgNt_Rfj82OiXkQ7hfU3jBj0
Message-ID: <CAEf4BzY_TdLFKHG2QTtf2R7LHbzs61-kzMe1W3JFdvgOthMWNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in profiler
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Suchit Karunakaran <magneto712003@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com, 
	eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:28=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 8/28/26 7:46 PM, Suchit Karunakaran wrote:
> > Hi,
> >
> > On 8/27/26 8:59 PM, Mykyta Yatsenko wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Total cycle counts are difficult to compare across workloads with
> >> different run counts. Report cycles per run to expose the per-invocati=
on
> >> cost directly.
> >>
> >> Example:
> >> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
> >>
> >>              423256 run_cnt
> >>           947413975 cycles              #  2238.39 cycles per run
> >>           333965846 instructions        #     0.35 insns per cycle
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
> >>   tools/bpf/bpftool/prog.c                         | 18 +++++++++++---=
----
> >>   2 files changed, 15 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/=
bpf/bpftool/Documentation/bpftool-prog.rst
> >> index 90fa2a48cc26..2280dc4492c0 100644
> >> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *=
FILE* [data_size_out *L*]] [ct
> >>   bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
> >>       Profile *METRICs* for bpf program *PROG* for *DURATION* seconds =
or until
> >>       user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not=
 specified,
> >> -    the profiling will run up to **UINT_MAX** seconds.
> >> +    the profiling will run up to **UINT_MAX** seconds. When **cycles*=
* is
> >> +    selected, plain output also reports the average number of cycles =
per
> >> +    program run.
> >>     bpftool prog help
> >>       Print short help message.
> >> @@ -360,7 +362,7 @@ EXAMPLES
> >>   ::
> >>              51397 run_cnt
> >> -      40176203 cycles                                                =
 (83.05%)
> >> +      40176203 cycles          # 781.68 cycles per run               =
 (83.05%)
> >>         42518139 instructions    #   1.06 insns per cycle             =
  (83.39%)
> >>              123 llc_misses      #   2.89 LLC misses per million insns=
  (83.15%)
> >>   diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >> index a9f730d407a9..8935508f955b 100644
> >> --- a/tools/bpf/bpftool/prog.c
> >> +++ b/tools/bpf/bpftool/prog.c
> >> @@ -2069,9 +2069,9 @@ struct profile_metric {
> >>       bool selected;
> >>         /* calculate ratios like instructions per cycle */
> >> -    const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
> >> +    const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) =
*/
> >>       const char *ratio_desc;
> >> -    const float ratio_mul;
> >> +    const double ratio_mul;
> >>   } metrics[] =3D {
> >>       {
> >>           .name =3D "cycles",
> >> @@ -2080,6 +2080,9 @@ struct profile_metric {
> >>               .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >>               .exclude_user =3D 1,
> >>           },
> >> +        .ratio_metric =3D 0,
> >> +        .ratio_desc =3D "cycles per run",
> >> +        .ratio_mul =3D 1.0,
> >>       },
> >>       {
> >>           .name =3D "instructions",
> >> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
> >>       for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> >>           struct bpf_perf_event_value *val =3D &metrics[m].val;
> >>           int r;
> >> +        __u64 ratio;
> >>             if (!metrics[m].selected)
> >>               continue;
> >>           printf("%18llu %-20s", val->counter, metrics[m].name);
> >>   -        r =3D metrics[m].ratio_metric - 1;
> >> -        if (r >=3D 0 && metrics[r].selected &&
> >> -            metrics[r].val.counter > 0) {
> >> +        r =3D metrics[m].ratio_metric;
> >> +        /* r =3D=3D 0 is a special case for run_cnt */
> >> +        ratio =3D r ? metrics[r - 1].val.counter : profile_total_coun=
t;
> >> +        if (metrics[m].ratio_desc && ratio) {
> >>               printf("# %8.2f %-30s",
> >> -                   val->counter * metrics[m].ratio_mul /
> >> -                   metrics[r].val.counter,
> >> +                   val->counter * metrics[m].ratio_mul / ratio,
> >>                      metrics[m].ratio_desc);
> >>           } else {
> >>               printf("%-41s", "");
> >>
> >> ---
> >> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
> >> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
> >>
> >> Best regards,
> >> --
> >> Mykyta Yatsenko <yatsenko@meta.com>
> >>
> > I think val->counter be normalized for counter multiplexing before divi=
ding by profile_total_count? val->counter contains only the cycles observed=
 while the event was actively scheduled on the PMU, whereas profile_total_c=
ount reflects all program invocations across the full duration. When val->r=
unning < val->enabled, dividing raw val->counter by profile_total_count und=
ercounts the true cycles per run. Should we apply scaling before computing =
the ratio like below?
> > if (val->running > 0) {
> >     double scaled =3D (double)val->counter * val->enabled / val->runnin=
g;
> >     double cycles_per_run =3D scaled / profile_total_count;
> > }
> >
> > We can actually see this in the example:
> >
> > 51397 run_cnt
> > 40176203 cycles          # 781.68 cycles per run (83.05%)
> > Here, 781.68 uses the raw unscaled count during the 83.05% runtime wind=
ow. If we scale it to 100% estimated coverage, the true cost is closer to ~=
941.22 cycles per run.
> >
>
> Not sure if it's a good idea to scale just this metric.
> I understand the existing metrics and ratios have the same problem.
> I think we should scale all or none.
>
> bpftool on its own does not use too many PMUs, so most of the time
> this problem should not manifest: it only bites when other profiler
> is running in parallel. Andrii, Quentin any thoughts on this problem?
>
>

we should scale all pmu metrics, IMO. In our production this is
actually an almost guaranteed fact that we'll have PMU multiplexing.

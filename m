Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D325B08D
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934823; cv=pass; b=mEfa0uYocJfJ7j62tUQHggYTEK+LbEMIAFK9qZs8/t9csIPure+/XhAWZpwDtjxs5E+ZEmbQ017RjWVMTUc9qQkfFjRxX4aQQ1zwPvAey4pic6iV7wssN+0t4hkqB3Z+F9UeGBi8HZoh6WCFdd81IcjyM/wtyRn1VGhYHo3z9GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934823; c=relaxed/simple;
	bh=uXJEGZ7C2nTWwCdZbKtvn+qXAEOS28piw43PGwcEo44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPC4KquiQfhFctOUZDzZZ/jvBlYZO+1rZ1zgOStjHWANspDXzRiJ941dhyzDHQkU01UPgSwNb7LH1cl1kuqQ5v+aslwoYRh3f755R7Mweob7bA1p4Euwrut32xmUFqoe9+/K7h1uoBH9j6nPP+ScN+ljptvH1r6owgU8MYcfq7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbmK8F0u; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbmK8F0u"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so1024136a12.3
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787934821; cv=none;
        d=google.com; s=arc-20260327;
        b=b+WYwF0fLipmpZkVP8kUaNkeDSTaVcTzp+Kzxx8PNV+eDwzVZiESf5uuwMGRQYnftX
         OtOdjbM3bhQ7Gbxcc70iTA93uqR34Kv+uxTWkKsMeYm+BNYgzlWDGULfyXNP8Mozth1a
         l38qTvECQgjk+XfYs2E1xKzc0hKsor2mTqtSK3/dt0HtX2DjBSsFbgA4Wen8q8bKQE9h
         5tyrFeSINHJr9r8Eyp+17aNNR7iHMLK3vCcWWrcgwgjUhIJ56oXh3VHd4frjN+xNsc9y
         mlbeecbiEfHXToPUXf/FzKM39HxwC9DbBc+CNX2xJmqPpskG4qukTpZ5nVIe0XnH0bcw
         FfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nPVPSGSGzhshVuR+BI/uVZuAl34n42L0WhViu78Iw1w=;
        fh=IhN3luBD9UgyHzLP1M9ci3veL00rEY3LMquC5lVUaeY=;
        b=NyA/x7KGdjzMeoLf6Pc6BWlkTr7JHGdvMF9E0m5FCawKNucO+jBsnFEa8ZJmky6VFO
         PYfFsHMKmWxi2m8LHF55yw1QE3z8OgZ2gDl0yDU0EBfuj4Mye1e24NRnmcSUxO3lKHiz
         wTvdn44ZWrKm/zK7QufD/YYcWM5qZIroY46UNBK9aDI+G8DRjoWoz0KAvXTNUyIUGfTg
         Z1BWcrdqwHOFxNbVyY6meMfFaHQvXs3SN0SZ8ducMUN4QIh9qjCjs+Nifps/G+Tr9CyZ
         z3A739gSw4UGMwNf0XIuI0cwpiUziEBO/mHSF/HPo581qX27AgE/tJOWMwKtlio/8vIQ
         fXjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787934821; x=1788539621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nPVPSGSGzhshVuR+BI/uVZuAl34n42L0WhViu78Iw1w=;
        b=UbmK8F0uQ3D5VSDMT2U4jnP0Z4dPetV9MpFuSlmNTIzpTpwbIVf54CCnXB4s3waZue
         gIta1wIGwZHi/V+NvWVos58dddasJAU8ewBXxquU4SUzpnMt1CKOS4e1QVITuy2w342p
         J5IrVKyboTGb/+ra0YznAT12tugsEnyieIKdgpL1VxLg+d0rB5QDGHF6rN55OF7c1Mwd
         rOcyLkAVhu4Dyd6lyuwofXUlT5/88OlQMFOAAFY4F90UYOswRmp3RNSTDAOJlMWypEeW
         IgtUTENQVJ0BcrJytPdClf4Qf6HfmnCsUbeeGVHqERvdBR9sZ7ahnO5UKWBoG8Ksiwho
         f5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787934821; x=1788539621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nPVPSGSGzhshVuR+BI/uVZuAl34n42L0WhViu78Iw1w=;
        b=YU6bJ2Y4L1CDAw7Wo3+3arTYcIP+WqW9nC4ayWBy6g8gM5kN0gAXLntefuIjdsyX58
         t3ZjBPm8UEd8LX5K4pwOpNkoBA9Dcmi57Jj3UfJki8I3VeJyiHqveOCPu5kELnqusnYf
         jisT3kiq1WhnY3/NK8sWT+z49EEYdhUatR+tY313iAlbwU3K/ZAU5BaDMyggsMJhbESq
         M733Q0gLP2h4S3Oa9YZBSKfQaP/siob108jbMWI5uVM7nk2WzRtdRPV2EX0ddvAzO5sF
         pZ8JtKb+2Ox5/778psoZUMjAwwqTp3tTmcR2Ucv0mgLwvpd4Pnfak3jBeJ8tbnl6XiTs
         XjmQ==
X-Gm-Message-State: AFuF++nb74N6OQCC6uD+j2OjdWAarQdUJTAmJFQvoTqatNfwkDxSuKOM
	AhBCKU52+86WyJWyC076v5ygySsmiiIqvXTDXAOm/9XeUBI/72goTzmFdA6Pkj/cAoqRZnp0He7
	/x0Wye+PjeMCSq7zlos4B6xcQXxEamQc=
X-Gm-Gg: AR+sD134aEk0+FNP7UNk5H9un6teHnfq68i5axK+k/l6goKgyqRhM1wN8Ww+wsZpP0D
	6iCezZA8otMCpKQQnKsVQGN5ToRE9NBD+XrNNzKY5QnZeUr1bk6R44FiTrLLVP7Vg/1vV4+lKfJ
	8wc0HphoGaWkQXTm+FmkUXAvz+bJh6iynD8Gc2Qs9yUmVhPN4K6MPjd/WsuQOAvfhaHXo6K0lB4
	ES+UPo3o6VZ1XdCQo0UPsMl3x9ISziU72BtWOZ9tbQ1UsPMQzS8GzjGRr3y7xFrCildXzcc731n
	W+VT7d0EImmzmRrwiC92IecLEW8e6rVC7J3NnFbenjh1+hCXdfzhFft9odZL28jfrd3tbTv236o
	6m0qhLGsl6ejb5b39wdiOYF8SiAK4HjC5w5QsXlXTlg==
X-Received: by 2002:a05:6a21:594:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3d2681a3f3cmr18039190637.13.1787934820819; Fri, 28 Aug 2026
 09:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
 <CAEf4BzaKFk9yu10P9bXOE9i=hD8SO+_XfvPbnEBU7cd+eLDVCw@mail.gmail.com> <6e864df5-4fd0-4ae5-a8c6-d2abb9f818d7@gmail.com>
In-Reply-To: <6e864df5-4fd0-4ae5-a8c6-d2abb9f818d7@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Aug 2026 09:33:27 -0700
X-Gm-Features: AcwNN1Wrjn05h7J7qUE_JOP0Qq6Q4UFGuLfI8nuOOMvhksEQT-eWsyaIfTeHxdo
Message-ID: <CAEf4BzamFa3MebxgsBMN4pfgMnwj_Wz21cJpfE2couTVpDUj6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in profiler
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 4:01=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 8/28/26 1:30 AM, Andrii Nakryiko wrote:
> > On Thu, Aug 27, 2026 at 8:29=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
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
> >>             423256 run_cnt
> >>          947413975 cycles              #  2238.39 cycles per run
> >>          333965846 instructions        #     0.35 insns per cycle
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
> >>  tools/bpf/bpftool/prog.c                         | 18 +++++++++++----=
---
> >>  2 files changed, 15 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/=
bpf/bpftool/Documentation/bpftool-prog.rst
> >> index 90fa2a48cc26..2280dc4492c0 100644
> >> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> >> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *=
FILE* [data_size_out *L*]] [ct
> >>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
> >>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds o=
r until
> >>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not =
specified,
> >> -    the profiling will run up to **UINT_MAX** seconds.
> >> +    the profiling will run up to **UINT_MAX** seconds. When **cycles*=
* is
> >> +    selected, plain output also reports the average number of cycles =
per
> >> +    program run.
> >>
> >>  bpftool prog help
> >>      Print short help message.
> >> @@ -360,7 +362,7 @@ EXAMPLES
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
> >> index a9f730d407a9..8935508f955b 100644
> >> --- a/tools/bpf/bpftool/prog.c
> >> +++ b/tools/bpf/bpftool/prog.c
> >> @@ -2069,9 +2069,9 @@ struct profile_metric {
> >>         bool selected;
> >>
> >>         /* calculate ratios like instructions per cycle */
> >> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) *=
/
> >> +       const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycle=
s) */
> >>         const char *ratio_desc;
> >> -       const float ratio_mul;
> >> +       const double ratio_mul;
> >>  } metrics[] =3D {
> >>         {
> >>                 .name =3D "cycles",
> >> @@ -2080,6 +2080,9 @@ struct profile_metric {
> >>                         .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >>                         .exclude_user =3D 1,
> >>                 },
> >> +               .ratio_metric =3D 0,
> >> +               .ratio_desc =3D "cycles per run",
> >> +               .ratio_mul =3D 1.0,
> >>         },
> >>         {
> >>                 .name =3D "instructions",
> >> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
> >>         for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> >>                 struct bpf_perf_event_value *val =3D &metrics[m].val;
> >>                 int r;
> >> +               __u64 ratio;
> >>
> >>                 if (!metrics[m].selected)
> >>                         continue;
> >>                 printf("%18llu %-20s", val->counter, metrics[m].name);
> >>
> >> -               r =3D metrics[m].ratio_metric - 1;
> >> -               if (r >=3D 0 && metrics[r].selected &&
> >> -                   metrics[r].val.counter > 0) {
> >> +               r =3D metrics[m].ratio_metric;
> >> +               /* r =3D=3D 0 is a special case for run_cnt */
> >> +               ratio =3D r ? metrics[r - 1].val.counter : profile_tot=
al_count;
> >> +               if (metrics[m].ratio_desc && ratio) {
> >
> > this ratio_desc-based thing looks suspect. We used to check .selected,
> > why did you change this?
>
> We checked .selected on the metrics[r] (denominator metric), with run_cnt=
,
> it does not exist.
> Checking ratio for zero, merges 2 checks into onet:
>  - verify no division by zero
>  - if ratio is not zero, that metric[r] has to have .selected =3D=3D true=
,
> otherwise how did we bump it.

ok, makes sense, thanks for explaining!

> >
> > And tbh, this whole ratio_metric would be much better done with enum,
> > where you can have -1 as "NO_METRIC", -2 as "RUN_CNT", 0 - cycles, 1 -
> > instructions, and so on.
>
> That'll do. But feels a bit awkward:
> metrics[] =3D {
>   ...
>   {
>     ...
>     .ratio_metric =3D 1, /* But really mean METRIC_CYCLES which is index =
0 */
>   },
>   {
>     .ratio_metric =3D -1 /* But really mean METRIC_RUN_CNT which is -2 */
>   }
> }
> The core difficulty here is that .ratio_metric default initializes with 0=
 and
> stands for NO_METRIC, then all indexes in .ratio_metric are shifted by on=
e.
> Alternatively we can explicitly set .ratio_metric for every element, but
> that makes default initialized not safe (.ratio_metric =3D=3D 0 means cyc=
les, but
> .ratio_desc is NULL).

I personally think that explicit .ratio_metric =3D METRIC_NO_METRIC or
something like that is just fine to do and not a problem.

But if that's a problem, I'd still do enum, just make zero a "NO
METRIC", and shift everything else by one. So basically what we have
today, but explicitly named (and with small comment next to enum we
can explain that shift-by-one convention).

Your choice, my point is that plain numbers make it hard to follow
what's going on, and really here we have a limited set of explicitly
connected things, so enum is the way, IMO.


> >
> > then in definition of metrics array you can use explicit
> >
> > [METRIC_CYCLES] =3D { .name =3D "cycles", ... },
> > [METRIC_INSNS] =3D { .name =3D "instructions", ..., .ratio_metric =3D M=
ETRIC_CYCLES }
> >
> >
> > makes everything consistent, explicit, easier to follow, wdyt?
> >
> > pw-bot: cr
> >
> >
> >>                         printf("# %8.2f %-30s",
> >> -                              val->counter * metrics[m].ratio_mul /
> >> -                              metrics[r].val.counter,
> >> +                              val->counter * metrics[m].ratio_mul / r=
atio,
> >>                                metrics[m].ratio_desc);
> >>                 } else {
> >>                         printf("%-41s", "");
> >>
> >> ---
> >> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
> >> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
> >>
> >> Best regards,
> >> --
> >> Mykyta Yatsenko <yatsenko@meta.com>
> >>
>

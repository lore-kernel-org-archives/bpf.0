Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B6277007
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231903; cv=pass; b=iwmRgZN9vM5OyhBmXFXN8rqAUAkgmG+634vuYvnELJBWOQm/ot/lcBNkZ9bZQlAIGBoXU5LbdSWIL3m7oX/Vgx+fnVPA6T9c9K3HAviKUsP26V+T4g05cd+Kmnva+GUYMbsyI34Z3Q1k6L93nt8rjxn6u9fG1wDF1eD69E8ggL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231903; c=relaxed/simple;
	bh=nI1iEGPoPDhrBGtUeSsTwShs2u+PpmiWdlssb+sfvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZNh4tszQs3dpzJ0QBupGISsVCpOxYBGrB47YIeDJBzEfC26mnvmVRzry6gbEV+QKoY5HqGCasLBwJ9SEAHw+lkZVkx5OcDwlZxD4c9Xpcyy1QvP15f1wMNDbaW6a6DrvVonMD+ZnmsqcA6/EzcXRjKtbAd4RWvUj6J7pwrmk/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgp2ZYL2; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgp2ZYL2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so63975ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 08:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775231901; cv=none;
        d=google.com; s=arc-20240605;
        b=CqRBffUH5pNalQ0wZKYPhxXOCRkllF4HsK54AtuRaD7U4x9Ra1iOXalroQNwyLkGm6
         93XBDrFTgoZxoAP7ZefcBa9UV8kNsn+aMfCnu4ZJsibKP4Gq7i+KCfWrncNuqUNcgXxj
         FG+V1rSeOxg0R5Ve/cJfK0kFI1yHwTRel72FAe6R9PXYH5rF2eYK5+jbpUbjjhSpsYoN
         L2Gr9BW+3wqpKUNR4RXWsl1p9410zk99adS13CQGakP2516nVXCAE8UXQSUvYMARb7e/
         FC42xc4OQC4rP+zLmrKbz3AnKx32ww3KI02NMz4ig1PjrMSfaWcVpTv7Kbi9GQrFFSae
         PBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        fh=Rlt5QTEFHyd3a03Vem7gdCncENmVp+HX/ORgVANEoII=;
        b=V4jD30Sl+F6T5g6IbeA+udYIucByc2LErtkdF5I35TTXFC02JISuN+hV/YVfbiyqVy
         igL/X0/ODBfizaaUuRrr7OQUDQyem5Qx3lHm9/fqRaknCWJvuw+hNCzELvmN+21QzuZw
         C/EfMSRayBRAVO5vspcFXCnJh7TxDN3gi6cKJOfReWwfNR73kfEGUJ+8ZmA9qZiQvoD/
         RVyWpTwrbj8S3B8GqFVOrhCMQWH1xl0C6wbXJl7lIbLCD8GoT022SoqDmFu9DNybTm02
         cX5U9fjfcC4tY46EVIQUI1t747WrPRVkFn7cPQdWBjyqcbkMCd8oPI+uASKE2Dzu7AtJ
         hN2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775231901; x=1775836701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        b=bgp2ZYL2XaL8jS+dZb7O74sTtTkZhFgcZ76ETWRzhFKqufgN0vhpuVt8pPQ/8QOrfe
         j/FdmpekHrV+Hb5cTd6uxVhzz3iRocQV0VQNvNVTNeyrjQVPWEja2QWYtynNz/v+WMwC
         eWVwvBMRP8VIh0E3M3tCFEDVGmG7KZ7XEdPKvaXvdaqRzv/Y5ldpi39urI+LnrS2WVRL
         9BLG+h8shEA6RDBzrk/dvbscmdflTzq1Soi5hoR58FcP4Ht2iEaz4sEMTUBhYqr+cGdD
         DbGvrSELvEmvuOnX+v03dJk8mEx0blSa0HZl0GLjEOiUOznVaAESTOG0Kw4H0uJqXJsh
         4Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231901; x=1775836701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        b=lRJWvitl7+/a6Y/62r72pXlOxCiND6f+k6pCgXH6osR55OynsIw6IDHyllwe2q4HP1
         QD+1/cv15rUYCep0BV9F9mDvHTkZ9i7iuFHhHTRVQ8ZmcnEgSrTH1YOGm73KRJVKKMhq
         IBQqFz4EcUuTOxNTA6/fNHlkHxIOvZ6ZN8Ei3aSpld5vc2S+a9n3QkaDmR2BnnfI4/KB
         se7rq3uT8FSTMetcnO0Dp17IT4kdGOFtye+F3EwXuCyYZjNe62D0hjNhXjZn+thjBbj9
         n5iU4YL6DAYZIzoXiwtAu+eK+HCPLNvvz2+hrwbkOkw/8y8c2S9FJ2Xq6+6C0EtdnQRT
         WGbg==
X-Forwarded-Encrypted: i=1; AJvYcCXw0pUN7upRA2IAq1Np/3uJ2+jI6fRo2eSud1K7i7p4m69UDAE3ubrSUfj9yPtMs3aAf4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqiLVz67D+8u230G6pxGoJobuvKBMXbtdfo+L7lQ188QaO4C2
	yB7u+YxU4q7dLFh2JIvgVVSEffNGxOrU65v6MOKv+W9hUFk4rfj+VbXLC3C/OvpFhQ1z42aCVyq
	5Bk0vje5MCEw3IFAUyjXd7CG60S5elZouNxy3wFCi
X-Gm-Gg: AeBDieucP/VGKQcJlRzHEIzpCOq/E+WXKDIn47JlKpPQ+W0ohdnCiUMLSeBDCrXCySc
	cUVwQ+uoNeVYZdC83oyhNPURFWYOJjG9UAltThpagv1rJkrGnsLecP2oTV2V9V6jsOrPviOcyWu
	JZ0bQgy3a48bgMkJUx+tl3Olg7c10MN2GJLvv94eYnCDTxyY7d24ifIDsvHgWNFaMD0YGSL0J21
	Gsl3ahqlZlbuuJUh9sbkXAKKXBFSgqh9NixzF0P7esISe/pw+deFx+y9qRmEFiJyg6H2suFBPym
	zS5tG5FS
X-Received: by 2002:a17:902:d584:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2b282f49b59mr2451425ad.16.1775231900710; Fri, 03 Apr 2026
 08:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402215727.980993-1-irogers@google.com> <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
In-Reply-To: <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:58:09 -0700
X-Gm-Features: AQROBzAYe8ExiGqlU-TQ_5Ya_l_UNn7S3fy3_HzKDMFBPNiXN-zc1_TT-NJAxs0
Message-ID: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
Subject: Re: [PATCH v1] perf cgroup: Update metric leader in evlist__expand_cgroup
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:33=E2=80=AFPM sun jian <sun.jian.kdev@gmail.com> =
wrote:
>
> On Fri, Apr 3, 2026 at 5:58=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > When the evlist is expanded the metric leader wasn't being updated. As
> > the original evsel is deleted this creates a use-after-free in
> > stat-shadow's prepare_metric. This was detected running the "perf stat
> > --bpf-counters --for-each-cgroup test" with sanitizers.
> >
> > The change itself puts the copied evsel into the priv field (known
> > unused because of evsel__clone use) and then in a second pass over the
> > list updates the copied values using the priv pointer.
> >
> > Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/cgroup.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 040eb75f0804..1e0fef283826 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
> >  int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool=
 open_cgroup)
> >  {
> >         struct evlist *orig_list, *tmp_list;
> > -       struct evsel *pos, *evsel, *leader;
> >         struct rblist orig_metric_events;
> >         struct cgroup *cgrp =3D NULL;
> >         struct cgroup_name *cn;
> > @@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, co=
nst char *str, bool open_cgro
> >                 goto out_err;
> >
> >         list_for_each_entry(cn, &cgroup_list, list) {
> > +               struct evsel *pos;
> >                 char *name;
> >
> >                 if (!cn->used)
> > @@ -467,21 +467,41 @@ int evlist__expand_cgroup(struct evlist *evlist, =
const char *str, bool open_cgro
> >                 if (cgrp =3D=3D NULL)
> >                         continue;
> >
> > -               leader =3D NULL;
> > +               /* copy the list and set to the new cgroup. */
> >                 evlist__for_each_entry(orig_list, pos) {
> > -                       evsel =3D evsel__clone(/*dest=3D*/NULL, pos);
> > +                       struct evsel *evsel =3D evsel__clone(/*dest=3D*=
/NULL, pos);
> > +
> >                         if (evsel =3D=3D NULL)
> >                                 goto out_err;
> >
> > +                       /* stash the copy during the copying. */
> > +                       pos->priv =3D &evsel->core;
> >                         cgroup__put(evsel->cgrp);
> >                         evsel->cgrp =3D cgroup__get(cgrp);
> >
> > -                       if (evsel__is_group_leader(pos))
> > -                               leader =3D evsel;
> > -                       evsel__set_leader(evsel, leader);
> > -
> >                         evlist__add(tmp_list, evsel);
> >                 }
> > +               /* update leader information using stashed pointer to c=
opy. */
> > +               evlist__for_each_entry(orig_list, pos) {
> > +                       struct evsel *evsel =3D pos->priv;
> nit: since pos->priv stores &evsel->core above, could we use container_of=
() here
> as well? Or just stash evsel directly into priv?

You're right, the perf_evsel vs the evsel is out-of-sync here (and
this was missed by Sashiko). I'll fix in v2.

Thanks,
Ian

> > +
> > +                       if (evsel__leader(pos))
> > +                               evsel->core.leader =3D evsel__leader(po=
s)->priv;
> > +
> > +                       if (pos->metric_leader) {
> > +                               evsel->metric_leader =3D
> > +                                       container_of(pos->metric_leader=
->priv, struct evsel, core);
> > +                       }
> > +                       if (pos->first_wildcard_match) {
> > +                               evsel->first_wildcard_match =3D
> > +                                       container_of(pos->first_wildcar=
d_match->priv,
> > +                                                    struct evsel, core=
);
> > +                       }
> > +               }
> > +               /* the stashed copy is no longer used. */
> > +               evlist__for_each_entry(orig_list, pos)
> > +                       pos->priv =3D NULL;
> > +
> >                 /* cgroup__new() has a refcount, release it here */
> >                 cgroup__put(cgrp);
> >                 nr_cgroups++;
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >
> >
> This patch makes sense to me, apart from the nit above.
>
> Acked-by: Sun Jian <sun.jian.kdev@gmail.com>

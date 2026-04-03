Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0B322B6D
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197999; cv=pass; b=AqPmuffaoZEL3P20AbuFNB3tI/5hAnE9wzj36UF6YSuL5ICFvpiw+ZcwOoHGgw5NFASD7iijdt+wvFLYMcGDTaI+Gmj6LZgxaYY9jiNm7H84wGiwoTh/oszG3dDiUSLUEz5bn9V2KLAGtgV4YepZRNRoqgjO757bHyq/14qRuMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197999; c=relaxed/simple;
	bh=7XyVqM3OP7aVREUb8TMPamvd/LiQ3M0zu1HVrbJEqGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwRjDBu36dG+g4dVIj9YbQVUXZljiwzv+yruCTLISFY5FQBYzeYNgNz1BeFh51CZy29+lX5bJtyGeQxhVU7g3diIZ3mrs/eIS4x3+QykTQ74sxHz7Jf2pGpBZV4kELBxHhY4OFRheTM/63EG7r0YUGgfn1AbqvH5N/nperAqcMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn9y4v5+; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn9y4v5+"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79827d28fc4so14732987b3.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 23:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197997; cv=none;
        d=google.com; s=arc-20240605;
        b=AEHv6BBDwnOak5sJ24Kv98n6Clf8O8IRfnwXnXdbraPVmdjvhPh9cpuib4uMqD7dY5
         th832+PMamSpy7yHy/Rjmyb2mRJFk+kbmoUMwVYsaMnXTmAUtIAIuiXsrr+56lW/S5FS
         uLIWcYTbLS7DSVce7gcAPwkUnJol2gOysfqGgLLS0O8LCI3hc/x+BAvbDl6hQyLih/mF
         ifgeXGJ1htVnNkdrZqjaHQ9A53HQhm0Q8yZ5LDsTqMhrp41rsbyV5MluYT+V4nH9wb4v
         vH9dgNqKy2u1Wd8b5uTBNC6YuFg/Yn0ufhrmdhn81Shsj+tAompTmplPPdteojWyE+uL
         UyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        fh=yDocmaE12FZi/A+HZyKEe+TzX/jE1oa7mxrg2E+OYb8=;
        b=ctzlKMQm+1+czD4C9doEBoDoobCNdCjmABaQo6H7a72r8YKLyaxAbXDFzVXnz8cAXa
         LHI7BfwAvMfd8dENLDnKqF6rD7Xuoqnui3cGOb7FuYVaSgsnZvuj/AmcmQqcCdVVkf/U
         YNFFHM8ElB0YUVmsw7T/wjrQTF1OqVshDTJfK2JMTqga0yVBAPCkZu7EFvTQY27oji1L
         OTQ7shzr5nWgWTN7JU2PiKGQnIZ2N0XQIbQdFAmLPWvzKEXeAwjFppq9KubnkbnU6X6N
         HPar6tZLL0nCZ0nK5jpFiQQ+3UTkpIBuGuogu2jqiDkCndQGlLLAvmyJe2b7IiIM9ukZ
         ogrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775197997; x=1775802797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        b=Sn9y4v5+i7lVZFVkMeqXkS6rSc7GQrnTwamqLDMAajKBbu/lk6aB729YNE9sZcUTwR
         Gkx1/rJuOf68CArGOk+BZ4rN1fpBOkRQENhmEUc8y60JKXu0RCCpL5jGK3DxqjPuKe5P
         BPR+toRQtMJafmW45sOgE2i6djTx3ptL7XL+vjlWLu/tcd2B8M4vEmZu64p6hKz96nha
         MU3f6YA1ozpUuwXKpS38jhiaoHnFV71g/Ks0VkcXtVmH6lLIDocvROMDLJ+wtfOMM5/Q
         gHC3+uvoWnL2eZyy/Zy0vwtrPuTrneC1cxiNC2BlRmxXgiWZ44vkjj+l16+bhknl6WNk
         oM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197997; x=1775802797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        b=LCLS0VIloduE6dPDYM3aSKdNusxpKG1rAu1shLDNju5j/qhVAZFfx36pXm3eIX7tDq
         zqzCdSr/5wgjM1e0cDCojjAcJNYN0l5ohuGUeOMtSGbZoriRL+NN2QW1i3BsZoOd5p9H
         O3VlrsaQt1ipHLSKLyL9fL/kQwh5v0Hup9jvl7pBrb3+ChBmhCt9Z5zRV5ZVah73zCuW
         BT0XjmSR9a/giCrCOJZkFd3d7pzcIKlacP6JKqD1naHuw8L3u1Hd9vv1OA8nRGZB/YBw
         DbEf9dQHuYzq7pFV3VW4/D0okwL3z3/v/fW23LPBmMF0HicQ3mi65wfbw/CwAw2LwwXo
         R08A==
X-Forwarded-Encrypted: i=1; AJvYcCUT9f+26RDMvxYi/k++L9Tr7OjmkSknIr9CAvpz9tov9pTErVJYxyE3A6mJLQzFnbDSM3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFOXe7c3ztX4qFrb/rDiCbvTHlbo5kyX3O5P5RPlcK15t3ADa
	X+bIQKTrnS+ksbkqtuUvNVRRBcsG8MJC8X2RPkrrcPJbz1SHF9XpGbAUJEvn8fK52SUZPGN6ibF
	u2meDeAjkpWdLxh9r3jJKa3CpEPuzA7Q=
X-Gm-Gg: AeBDiesjZluL2V92Z4/iCsUPgmmyMt1iRCPopuJKFa0wGnP4yV8e4pZSuI9ZSOrv/uh
	h6XSmLF8tbtnJn9aAFtv3BVlN31onkHjwf4+u3wH0ye5ctIV/1CX3NcKMRjZUBFte9wCMkcdE3f
	rWjHg1CTNXQBTeXG6bOBv6RbpDwUNotaItAuDyrMQB1XXsQhq8BA9viQw1JE/SpOFNrY81I+3A1
	aXOPxY4jrtGq28Pov/vAh4zH1QFKOagbLla8fq4W1dcbJrl77ElRfwmRrDhTjVquYdEI+R8UgG+
	b+Rj7Dwzi0kepGNHEYyu8HuiDmg9y0K6QlPJadxcwsFuh6/+5RRO3/69mJejSlqAOXuQNg==
X-Received: by 2002:a05:690c:e654:b0:79f:7972:f88c with SMTP id
 00721157ae682-7a4d64480eemr13226287b3.11.1775197997378; Thu, 02 Apr 2026
 23:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402215727.980993-1-irogers@google.com>
In-Reply-To: <20260402215727.980993-1-irogers@google.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 3 Apr 2026 14:33:03 +0800
X-Gm-Features: AQROBzDHLi377LEU70OoLL7LQcZ2-j_I8HrwDSkBlgiNIkIIP9iu5gBB5h_oE8k
Message-ID: <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
Subject: Re: [PATCH v1] perf cgroup: Update metric leader in evlist__expand_cgroup
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:58=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> When the evlist is expanded the metric leader wasn't being updated. As
> the original evsel is deleted this creates a use-after-free in
> stat-shadow's prepare_metric. This was detected running the "perf stat
> --bpf-counters --for-each-cgroup test" with sanitizers.
>
> The change itself puts the copied evsel into the priv field (known
> unused because of evsel__clone use) and then in a second pass over the
> list updates the copied values using the priv pointer.
>
> Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/cgroup.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 040eb75f0804..1e0fef283826 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
>  int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool o=
pen_cgroup)
>  {
>         struct evlist *orig_list, *tmp_list;
> -       struct evsel *pos, *evsel, *leader;
>         struct rblist orig_metric_events;
>         struct cgroup *cgrp =3D NULL;
>         struct cgroup_name *cn;
> @@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, cons=
t char *str, bool open_cgro
>                 goto out_err;
>
>         list_for_each_entry(cn, &cgroup_list, list) {
> +               struct evsel *pos;
>                 char *name;
>
>                 if (!cn->used)
> @@ -467,21 +467,41 @@ int evlist__expand_cgroup(struct evlist *evlist, co=
nst char *str, bool open_cgro
>                 if (cgrp =3D=3D NULL)
>                         continue;
>
> -               leader =3D NULL;
> +               /* copy the list and set to the new cgroup. */
>                 evlist__for_each_entry(orig_list, pos) {
> -                       evsel =3D evsel__clone(/*dest=3D*/NULL, pos);
> +                       struct evsel *evsel =3D evsel__clone(/*dest=3D*/N=
ULL, pos);
> +
>                         if (evsel =3D=3D NULL)
>                                 goto out_err;
>
> +                       /* stash the copy during the copying. */
> +                       pos->priv =3D &evsel->core;
>                         cgroup__put(evsel->cgrp);
>                         evsel->cgrp =3D cgroup__get(cgrp);
>
> -                       if (evsel__is_group_leader(pos))
> -                               leader =3D evsel;
> -                       evsel__set_leader(evsel, leader);
> -
>                         evlist__add(tmp_list, evsel);
>                 }
> +               /* update leader information using stashed pointer to cop=
y. */
> +               evlist__for_each_entry(orig_list, pos) {
> +                       struct evsel *evsel =3D pos->priv;
nit: since pos->priv stores &evsel->core above, could we use container_of()=
 here
as well? Or just stash evsel directly into priv?
> +
> +                       if (evsel__leader(pos))
> +                               evsel->core.leader =3D evsel__leader(pos)=
->priv;
> +
> +                       if (pos->metric_leader) {
> +                               evsel->metric_leader =3D
> +                                       container_of(pos->metric_leader->=
priv, struct evsel, core);
> +                       }
> +                       if (pos->first_wildcard_match) {
> +                               evsel->first_wildcard_match =3D
> +                                       container_of(pos->first_wildcard_=
match->priv,
> +                                                    struct evsel, core);
> +                       }
> +               }
> +               /* the stashed copy is no longer used. */
> +               evlist__for_each_entry(orig_list, pos)
> +                       pos->priv =3D NULL;
> +
>                 /* cgroup__new() has a refcount, release it here */
>                 cgroup__put(cgrp);
>                 nr_cgroups++;
> --
> 2.53.0.1213.gd9a14994de-goog
>
>
This patch makes sense to me, apart from the nit above.

Acked-by: Sun Jian <sun.jian.kdev@gmail.com>

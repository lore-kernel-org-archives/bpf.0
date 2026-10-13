Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF331618B
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882894; cv=pass; b=CqP8wxjF/XF9TUo9bSlZ0YQdTFuNanB3ZBvlW6ZCRksbLpI7nD4oQJoa1cqtSkRMnVpEdTD2Ipf7LJ+bESnrFZ7fjVQ5X5RWRIRKN446hWufbFl4l3VpbFjOl3eX+nN/iX7+y4R/+MaWcS7s8wRaX2sTJ15rq+XLia+qXlL/G+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882894; c=relaxed/simple;
	bh=/ZDx0qigdFSyCGhZXlqU3OErEYAQKoc8EV1Ldj229UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOMa+pqw8Me3M6NgnDb45q3VNPckLkb2D4jg55yCYOYFV/zs7tThHp95p+9+GvaK7VxHbSceMWL5M27jRND1uQCOO2SxIeHM90sFZsmSbUyaZMt7J5IhwnwsaTtwBykRy5Ghyys8Q8m8vnDSi/xqbWuG8tL1YunY+NCGLj2j7kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZnJLfpJ; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZnJLfpJ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8565d77c277so16961037b3.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791882891; cv=none;
        d=google.com; s=arc-20260327;
        b=ddwSBq/xvSOF7lSzPxxIFdhXuVA9qP5hIvaKt8wKxgBJ05ii1NIRBsP9Ihvxpu+EtF
         xImjRxqxbYeNbIGPbsgW2TbScOczhPunzftOEH5WLaXk+R9ajVDFc5yHW8FmzRPIXt+b
         cfU7rVA5Ewvcz12b9oqOln8BnZPJe3IWA1XRfACb8tQN8F3xsu9dDcS6ZcWYr72q0qmI
         NwrYQGaylG3DMKdj8DmdH5+dVN+3XCfoHzwOOYnaSRL3e0ekvbV9fMSZJlKK6S19riGY
         uI71I/cGq3/Okc5sXAr7VYwbXYz88GLPJfAnXHD6t6IzOs47c+I0mnawiqkvzfxeegkd
         S3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=68MXMWga95CH1/6xessB7F2BXfoCEeSgQgXov6Rw+cY=;
        fh=y+KI6IXgGn2ZnxBcTHp/oo8KJJ0+7W3QSOzvkA+0QbM=;
        b=mLzseld0I+zrYqsPdsvo0+wBcgz1vYNWfFGnDJ1FR8eYfFh7mz14VnCbfI0JCsSQcA
         Lkuzmx+r0Kxo1mu6tgE5ygrJiIgfKuy94poKN8Hse1fOUpqQG5vBejK635aaiBuEOOPs
         r5pMdB6T/MB0NKH2IIopJxkUmy2E8rIja6fH4SCOvBkTanB9M8OxJlc+7Gu8A4IeKqDX
         CgtOu/JPTALVAxFJUh+X9uylKwfITKVHPnSAtFMGYpn0QDKl7r/i1Yf0a4PVkkTOQBGb
         OlRw3Dqw4CsqKU2aDpSPG0AHv+CJlhMpbuJuJQLJO2i99d9tPyWW2dZ6Ne1DdAyf1Jl9
         5ZJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882891; x=1792487691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=68MXMWga95CH1/6xessB7F2BXfoCEeSgQgXov6Rw+cY=;
        b=FZnJLfpJ8e3L/C7a9A3Pw6TbT0U3CixM1NRdnXYpbOrg/qJxUzQoq8EBkruxqmk6kg
         nN2ilGcyPiK91JQJAYktOTGw75qk7Fb/0jsEf8zZtCtmLfd2F2R3kaGq2RE6rRruPiIk
         aqEVueK46bXUhu0mFn71yHTDpnrAsE017Z+lN5OOjDSYEPciC8lRWGlxbG0Oa9/8H71O
         4ukjDJmnC4QJLGuQzlPOWYF00rDMOqPDs4hi7RCzqRlo5BG+2XFYgsKcFDJ/DOSfkcBz
         /sANET4r060IxjbT9BlvH/f1Jl91CUgFh2vB3gGI4VHZmjqvBAe7Lnf+RcPEg1L/np5Y
         JATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882891; x=1792487691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68MXMWga95CH1/6xessB7F2BXfoCEeSgQgXov6Rw+cY=;
        b=2Byb96sYolWW4VXjHzACv4Lvu6nsnZe9+GGdX71xbfRTPFhZj26JMYuBSwx99B1laQ
         cKDnSg9D080nnM5FSPsWr71gLrq5LOTxF5iHdjSnbQ4pjaIcGUfx/Nmjg/C3XRpxpgjv
         a+rZNY8js2Bc1cYtgkCsAO4qSQSCUWWFHf7tXvrDadz3cVaDhDkLZdRwr2i1w58INt3V
         eBk5zQR8Hd8bjDWi/YKBCVstFRD2fQuV23XG/TkSJlS10CAtDjJypTucqrHvVIzugpg7
         BL4yhi3q9ii3DCnfao6tpbLD8wlze07GtlOPS57W/gu5RHOBbYWOlScCdmuLLJnA851t
         QpdA==
X-Forwarded-Encrypted: i=1; AKwUvByKktAnHupXOpurfpvivmuWA6mWiaTx01MTahZCz5Uu2sMbQ6dD2B7jylLU7ASmBBv6hCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzyAyj57l1ziVkF9lLkxDi7ZMz0sm5b/TIV9Jo2t0s4RUdzbdi
	ffC+Ovkxw7A2mKqO+PxNaT/4yk/qeR9fbDvUmpwZ6hh/kQxPOV5222GeMGht54FldDQdP5fui+L
	xmjqZ4tFXC4bjempUg+n/Fv8iL9tty5s=
X-Gm-Gg: AYBFou2JMU5lTYnH2C7C1GGgWCeVD4o/0M5gYG0YVFqu2DWLEiw3+H52BheNTutRLzs
	KmVFfe86+lKtgfQ0cgTZ6GEtML8h+hH/Xk01k5VRT5MaMuZKBBjIrI6kifS7v05k+sddoGHb1pr
	GCyX9gdwv84FRQfVmRtDmAfvxlIYPhweJ0fwQrc+mOBFf6QY53eSrWpoEpD5KcuOeTRVkXMujGG
	hkq4bN2x5Nuy4Ce/bGXcz/Jr5cBg64TbnIdBOQrkK8ERb8Icepwk6KyYYqmZOtUCzetkx4qNqLD
	rqeIynGl2Eytnm0/ooiQhFYIbuT9u2KUoSVjmMeFc0SwUWNJ6WvGYnGHrX0a+3ijYPANY47qZgv
	f1Vx1Cy7c9g==
X-Received: by 2002:a05:690e:43c6:b0:675:3d40:3c2c with SMTP id
 956f58d0204a3-679362ba7e0mr2295954d50.81.1791882890519; Tue, 13 Oct 2026
 02:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <20261012120438.52849-2-laoar.shao@gmail.com>
 <96324eec-d307-4bbf-975e-3c9b3dd5e190@kernel.org>
In-Reply-To: <96324eec-d307-4bbf-975e-3c9b3dd5e190@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Oct 2026 17:14:12 +0800
X-Gm-Features: AclHuK93g_25NJAT6wXES6RLREaNoHaav4Z0uWW89g_0G4Uh0XP2UqZ1IpTsXuI
Message-ID: <CALOAHbCOZdYe6E-_atuyT3UvOQt+j01Ru0ErknVutF8kR=L1Fg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] sched: add helpers for numa balancing
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:38=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/12/26 14:04, Yafang Shao wrote:
> > Two new helpers task_numab_enabled() and numab_mode_tiering() are
> > introduced to replace the scattered direct accesses to the
> > sched_numa_balancing static key and the sysctl_numa_balancing_mode
> > bitmask.
> >
>
> I'll only comment on the new exposed helpers. Some of these might make se=
nse
> even without the bigger series.
>
> (obviously, minus the task change)
>
> > No functional change.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/sched/numa_balancing.h | 31 ++++++++++++++++++++++++++++
> >  kernel/sched/fair.c                  | 16 +++++++-------
> >  kernel/sched/sched.h                 |  1 -
> >  mm/memory-tiers.c                    |  3 ++-
> >  mm/migrate.c                         |  7 ++++---
> >  mm/vmscan.c                          |  6 +++---
> >  6 files changed, 48 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched=
/numa_balancing.h
> > index 52b22c5c396d..353772b49c5f 100644
> > --- a/include/linux/sched/numa_balancing.h
> > +++ b/include/linux/sched/numa_balancing.h
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/sched.h>
> > +#include <linux/sched/sysctl.h>
> >
> >  #define TNF_MIGRATED 0x01
> >  #define TNF_NO_GROUP 0x02
> > @@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
> >  extern void task_numa_free(struct task_struct *p, bool final);
> >  bool should_numa_migrate_memory(struct task_struct *p, struct folio *f=
olio,
> >                               int src_nid, int dst_cpu);
> > +
> > +extern struct static_key_false sched_numa_balancing;
> > +
> > +/*
> > + * Whether NUMA balancing applies to @p.  The @p argument is unused fo=
r
> > + * now: a later patch will consult a per-cgroup BPF policy with it.
>
> Talking about later patches in a function doc is ... wrong.

Thanks for your guidance.
I will update it.

>
> > + */
> > +static inline bool task_numab_enabled(struct task_struct *p)
> > +{
> > +     return static_branch_unlikely(&sched_numa_balancing);
> > +}
> > +
> > +/*
> > + * The global sysctl state, for the system-wide tiering machinery: thi=
s
> > + * reflects kernel.numa_balancing_mode only and takes no task.
>
> The latter part doesn't make a lot of sense in this documentation.

I will update it.

>
> > + */
> > +static inline bool numab_mode_tiering(void)
>
> The function name isn't really intuitive. Should this be
>
>         numab_in_tiering_mode
>
>
>         numab_tiering_enabled
>
> or something like this.

Agreed, thanks.  I will rename it to numab_in_tiering_mode().

>
> > +{
> > +     if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> > +             return true;
> > +     return false;
>
>
> return sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING;
>
> ?

Agreed, will simplify as suggested.

>
> Both functions could directly have proper kerneldoc if we are already
> documenting these.

Sure. I will update it.

--=20
Regards
Yafang

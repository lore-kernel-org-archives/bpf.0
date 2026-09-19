Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8636DA00
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857391; cv=none; b=NCOY6bKxtOvgqa6X3u1MahNq8/J/L98v6caqVMmmy4rgwzosCOg74NzNI+cmFCfZtRFM+qa+smtU4/M8aCorCfix7mXEkPNjkuak35sRSvVp2Z26hYL9u1sLMZWol+jGYsCQhdgDBgKpjwLmBAtOh/TWDMDAFcUYX/spHVWhoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857391; c=relaxed/simple;
	bh=bPEvA2A4ZpKwIHJPbmB+FxxnRtX8BqDaGq2Qwt6JLK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7KlrYb3xMsxRbJmtmfvt1i7gLwiGhA8kJQuNs5db3ErKgdphyEgIIbN6/hQFYU10TDi88P4fXvrhhbnylbxYJO7mx3Kkv1gQa6O8uTtQGAMmELh6ikL7vW22tEX0KesT1s+5IGz2FZdbaFeLGnFFrEinLWx+NTVyFTt1xIPxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilHVXshj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilHVXshj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0501F008BE
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857389;
	bh=fOnejZtZ70+DKIPLXePAGmfZNKSXLHPlt3aY/hwoAA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ilHVXshjQfbUx4z8E+/LSAwQAGYONhpJwcU2y94p+xhWI+S9srA5RD3Z/M1lzZ5De
	 hyHwqkDMea+fm6m3E/2400AFZe0VFVbPdFN72ZMN8+mvJENkIoT9wC6fiVamLAwkJv
	 f2Bb4Zt/ntOosM2gdEQpY6S8MVKUspGkkWAK6r+RDUZS/zQ1KJDx/9ApM59rRmpDur
	 a11yTkmo0BR3DL1pt8QSOyUr8mP8whSOqsB2ICPI2Y1SElNBf8A9zVqOtfd0u172nR
	 CEYXa9W1b8gWr+bUlp/B8yvYWsmju0Km/kWvl5b8XjyzhUh8pn/LqLURHlsdHYV3gi
	 0u8yBYAqOMsNA==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c8so224983985a.0
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 15:36:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzc7iEWk/kGEdgjl3cHVf6cCwRaZFb8qeJxsiAldFiCwn3HeH6ToTfCvL34zq8kH9gYEus=@vger.kernel.org
X-Gm-Message-State: AFuF++nnRx/ai8nOw3aQ3LQjdsNbon9z1sgMZqZ8Eikij270fkJULeuf
	/c5sQAAWQ6Uf+N6KPnNL7MmZYmpjaBeVGBHpCTIQDBirV2a9lLAD9GuOgbXuclosZFDiCc7W9dP
	3TEVT2gAk6HcahKaJ8MDfEZvNhYkSpjE=
X-Received: by 2002:a05:620a:1d03:b0:939:a199:45b4 with SMTP id
 af79cd13be357-93bf5731ad3mr305110885a.39.1789857388560; Sat, 19 Sep 2026
 15:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789714023.git.zhuhui@kylinos.cn> <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
 <b115ece2-33a1-412e-ac25-38f339a13599@gmail.com> <aq2bo5Q-YUj7lkxn@linux.dev>
In-Reply-To: <aq2bo5Q-YUj7lkxn@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 20 Sep 2026 06:36:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wauwY1-xRdM4aVb7FkSttKYzsKsWH4pF4i=Sspri0-jw@mail.gmail.com>
X-Gm-Features: AcwNN1VZWalfWGDIaTagEHYpKVctjCpRyPqfufx6tRrX4Dk2SxYyw4KLGYnYEYE
Message-ID: <CAGsJ_4wauwY1-xRdM4aVb7FkSttKYzsKsWH4pF4i=Sspri0-jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 4:15=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 18, 2026 at 12:45:01PM -0700, JP Kobryn wrote:
> > On 9/17/26 11:58 PM, Hui Zhu wrote:
> > > From: Hui Zhu <zhuhui@kylinos.cn>
> > >
> > > BPF programs can observe memory pressure on a cgroup, e.g. refault
> > > stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> > > triggering reclaim requires writing to memory.reclaim, which BPF
> > > cannot do.
> > >
> > > Add bpf_proactive_reclaim(), a sleepable kfunc performing one
> > > proactive reclaim pass on a memcg, like a write to memory.reclaim
> > > but without retrying until the target is reached, so that when and
> > > how hard to reclaim is BPF policy rather than hard-coded thresholds.
> > > The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> > > as high_work_func() does for memory.high; reclaiming more is left to
> > > the program, which can call the kfunc once per bpf_wq callback and
> > > stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
> > > other sleepable programs may run with filesystem locks held, on
> > > which the reclaim path could deadlock via filesystem shrinkers.
> > >
> > > Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
> > > macros to an enum so that they are emitted into BTF and usable from
> > > BPF programs via vmlinux.h.
> > >
> > > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >   mm/bpf_memcontrol.c | 62 ++++++++++++++++++++++++++++++++++++++++++=
++-
> > >   mm/internal.h       | 10 +++++---
> > >   2 files changed, 67 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> > > index 716df49d7647..c5d7f29ade85 100644
> > > --- a/mm/bpf_memcontrol.c
> > > +++ b/mm/bpf_memcontrol.c
> > > @@ -8,6 +8,8 @@
> > >   #include <linux/memcontrol.h>
> > >   #include <linux/bpf.h>
> > > +#include "internal.h"
> > > +
> > >   __bpf_kfunc_start_defs();
> > >   /**
> > > @@ -159,6 +161,48 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(stru=
ct mem_cgroup *memcg)
> > >     mem_cgroup_flush_stats(memcg);
> > >   }
> > > +/**
> > > + * bpf_proactive_reclaim - proactively reclaim memory from a memory =
cgroup
> > > + * @memcg: the target memory cgroup to reclaim from.
> > > + * @size: the amount of memory to reclaim, in bytes, clamped to
> > > + *        MEMCG_CHARGE_BATCH.
> > > + * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS=
,
> > > + *              SWAPPINESS_ANON_ONLY], or -1 to use the memcg's own
> > > + *              swappiness.
> >
> > The ANON_ONLY enumerator shouldn't be included as part of the range. I
> > would change this to [MIN_SWAPPINESS, MAX_SWAPPINESS] and then specify
> > that ANON_ONLY is a special mode like -1 is.
> >
> > > + *
> > > + * Performs one proactive reclaim pass on @memcg, like a write to
> > > + * memory.reclaim but without retrying until @size is reached. Call =
it
> > > + * repeatedly to reclaim more than one batch.
> > > + *
> > > + * Only available to BPF_PROG_TYPE_SYSCALL, because other sleepable =
programs
> > > + * may run with filesystem locks held, which the reclaim path can de=
adlock
> > > + * on via filesystem shrinkers.
> > > + *
> > > + * Return: The amount of memory reclaimed, in bytes, or a negative e=
rror.
> > > + */
> > > +__bpf_kfunc long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> > > +                                  unsigned long size,
> > > +                                  int swappiness)
> > > +{
> > > +   unsigned long nr_reclaimed;
> > > +   unsigned long nr_pages;
> > > +
> > > +   if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
> > > +           return -EINVAL;
> >
> > Related to the previous comment, you treat the special values as part o=
f
> > the range. It works currently, but creates a layout dependency on the
> > enum. I think it would be more future-proof if you did:
> >
> > if (swappiness !=3D -1 && swappiness !=3D SWAPPINESS_ANON_ONLY) {
> >       if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
> >               return -EINVAL;
> > }
> >
> > The previous comments I brought up are now resolved, so assuming you'll
> > make the changes above you can include:
> >
> > Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
>
> Hui, please make these changes and just send this patch in next version.

Hi JP and Shakeel,

This feels a bit weird to me, since 0=E2=80=93201 are all valid
swappiness values.

201 (`SWAPPINESS_ANON_ONLY`) is just as valid a swappiness value
as 200. In contrast, -1 is a different story, as it indicates
completely different semantics.

If 201 is treated as a special value, then 0 (`MIN_SWAPPINESS`)
should be treated the same way for MGLRU, since 0 means file-only
reclaim there. This isn't the case for CLRU, where swappiness 0
can still reclaim anon folios.

If possible, I'd vote for keeping Hui's current code :-)

Best Regards
Barry

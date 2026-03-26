Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D02BDC27
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555363; cv=pass; b=rRmIPDDIzNBa84kYDxgoog4I1OeXlS2VFl/+B7nBVo71gU0Ut59XWn1iuWQ/lgcypanGlz+LZJtOZhCpHOUuOIDGKVdO6NUOW+XQP3ALRUk4rr3V0V6fakkS3FSd9BqKG2oHI3JE298RWNhFy5nfhcf2/RSrHV17W0dDb5gQIn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555363; c=relaxed/simple;
	bh=NDSAPwx46dtZYtvDYK49WlDy9nBLLs0NxjcjyMSucmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4KAJRrt9cz2MBQP3jYsQlqcwtqboTrzrfwxuUM/Msrsg+fVkiNdKRkk+ubRipf27RnU16Z9aECNZQK+Sgko5PmY0U6uuxLF6cw9UlI6CU6RYo5Dbm73jh8antUMDPxFmRulT5aVcWoQ67ILxX53DqhQ3J/09ZSrXh7E3mfnXGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQ6y1L3J; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQ6y1L3J"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so2812a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774555360; cv=none;
        d=google.com; s=arc-20240605;
        b=RedYhPq7uEyAjCGolikRDVPAElmVaW3m10FAozYiDCfwVRugCvXLqcVSqwGDXB2NbE
         ftMwn3KBH+OkQuCzMr/39PrNlHbpHAL2mix5VoIikvPTTOL6LsnaYDV4cv8Q1336PIwp
         8up6PMMNNCQrtf87vVWL6I/xTq6ZJAGcfEYI3z65Ii9vQa3iFbUeum0SAYCFZRjOb+OC
         oEIQwcp/rXrPjrvw/tBaN5xfLzpY3N5KE9eZUqtLlFpHSgxlN7zXyyDzfQ0YAnzlgSIz
         dMmmk5JvwMTQkksEU8KdUrchYXeg0F8jaQOfGmBljKjydfVdtZd1gkH8W9tOhVzKpO9b
         PWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YcCJsLGawkrffaMXgThFopnLf3sG41HR7iXKRErTNqU=;
        fh=A32IGSdw9CT+jW+2R5iceJX+qEUBy7vZ79hHIzU1EYg=;
        b=SYoq6WTqH1pJdnJ1goc6fkuFpkTubL7a4Z/5N+Cb1bm+bvgd2/9iZqXRDDYeiZSs19
         eGziCdAFk2hbr59k8vnMJxT1EjNmiGKriXkw59q4yDkmhGERD+CeVkBjlIklhx9lC/DL
         5wJIUNz8dn3c6bnEdsd+ViSKYNz9Wt5+orzPiZTHMAQVQ6NTpArGXAPgOsvBEXy8Z1fP
         zzgT/+tXNzxTsKjc5RQGrXXJyS11USZwu7pCuz4VrJzBsl5KEQSjUEvd8CDj5AhINfeU
         QnHFnG2kFmauTdlvl5P/xcc1AdG1K6va9Lrs8WyXmfxiLpxrkkTEen1adpe1Egafsu7b
         PiuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774555360; x=1775160160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcCJsLGawkrffaMXgThFopnLf3sG41HR7iXKRErTNqU=;
        b=YQ6y1L3JOCoT+DZ5kN+Ya/TMp//Uodlvt3mMKh8GMvp7yKIaFIcAEiQxojw6bA/hFf
         euYoujv23LV/K2ja9uvgH0iG16Ij0H+xKY31Ls8wrSHbwlG2MMrHNFBnxT3KPZ1B8485
         prLib/eBwhe0AM6p7MM/5Ld/QzNGBTlyU/QJoKf8ZL078Zn4lphw053//wSaPHAfla+8
         rEQ8BHIoloCyctuIEO2uk4RS1VUK3ZlU3H50ugwAOjZZRmmIyJhsENyRL/8ow1DuJ51w
         C3/324RqUNn4h+qlHkM8rX94jxgFCoZqwZTRX489SASt59l38OFM5wQxJImcOvdk9dzt
         u8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555360; x=1775160160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcCJsLGawkrffaMXgThFopnLf3sG41HR7iXKRErTNqU=;
        b=ODI3pyfc3B5o1JH92wndeBlXKXCtCXCaz1lXd6vopnwEHECKZ5bnrashbuM4BFMw9y
         INVjFPovMegNaYfCbQKFt4/hvOJ3ui46UiTh2FGSZEZJjoWqZMOQO9sn079KqiEYS0Hp
         tZXdapzPxddOaZctJ+u43aDUkuuuUbU08R2snj6DllIKB1WX4aCNrmHV285PvXpCuQy3
         kfZF0kvMSNjkes2QuQsKnyDZPnpnV8ZX39KSUCeXpe7TiYuzZBStQX7D+KfeGeso90Cm
         XjqMV7aE7WpYYC67D0y+Ce875wFhL+DZZ/2f+BW1quxO9daoQs60qphyk7skGpzbqKbZ
         2NVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAd5xk1DGm3KqnScHrae3NkPp36Z5awuwwfpx4mLVMwFLYJdi4Xrm6EUVouX/aEkU/aYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6q5TcmOKQ0l/c+3oEQI+WAv9lABx39a0q7KveC2jkqSBB6cZ
	F4W2yydv5XVGnTkdXyETBHdl8Uzga+RV12VNmVf8FX2JNo7W1DnU6TewebApYDliAB7tcUv1LYP
	H2U8xZuDoblRVTHf6sUrw/mesNxBzQI54QPw7riWv
X-Gm-Gg: ATEYQzz/GWDsq7aGxSX3Gl/x9T+dyacwcAv/XraMgDTTuwbr0vzIdYB7wEen19iPf10
	qjLD+eOdQ67nR+TKMatUmIYCkblpfG0LmCA+1tC1QZdlS1DATJDLvt97SUvlXAyfgZwvI5KLsNF
	0+OKkGG6f9T5P5U1TvOU2r8IuPp7Ne9NQAvtvy5Mvwa0uxJi/5UCaaXqW5LVaE3kTDSKw4/ZVVA
	QXUwLi6l7Wnt0bi9nMvIiqYBfcfo+Svdv3wRtuzojzeIw+BQrLE8x5x+0bhwekAgZ1HzUK5yEG0
	GrFmzwP235Jwc8JdZD1sQ29uMKN9KR1TD9tQqkRhJimReMQ=
X-Received: by 2002:aa7:d51a:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-66b19d0164emr13748a12.2.1774555359373; Thu, 26 Mar 2026
 13:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka> <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
In-Reply-To: <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 26 Mar 2026 13:02:02 -0700
X-Gm-Features: AQROBzDWo0U0wUaqkKSuyqmT4EN_BjNNpF8nBBEpcH6xGqdHAo0H0pRxhZHomSQ
Message-ID: <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim (reclaim_ext)
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:02=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
> > On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> > >
> > > > We should unify both algorithms into a single code path.
> > >
> > > I'm here to ask the questions which others fear will sound dumb.
> >
> > Not dumb at all and recently discussed here https://lore.kernel.org/all=
/CAMgjq7AkYOtUL2HuZjBu5dJw=3DRTL7W2L1+zVv=3DSCOyHKYwc3AA@mail.gmail.com/T/#=
u
> >
> > > Is it indeed the plan to maintain both implementations?  I thought th=
e
> > > long-term ambition was to knock MGLRU into shape and to drop the lega=
cy LRU?

I think one thing we all agree on at least is, long term, there isn't
really a good argument for having > 1 LRU implementation. E.g., we
don't believe there are just irreconcilable differences, where one
impl is better for some workloads, and another is better for others,
and there is no way the two can be converged.

On that basis, I would be hesitant to add some complex abstraction
layer / reclaim_ops to facilitate having two. It seems ilke it may
make things a bit cleaner in the short term, but long term might make
that end goal harder (because we'd add the task of cleaning up this
abstraction at some point).

My preferred way would be more like:

- Look for opportunities where we can deduplicate code, but without
adding abstraction (e.g., factor out common operations into common
functions both impls can call).
- Identify gaps where MGLRU performs worse than classic LRU, and close them=
.

We could go the other direction, where we identify places classic LRU
can be improved, and port particular MGLRU features over to it. I
prefer the other way for a couple of reasons;

- My sense is MGLRU is "close", meaning as Kairui said in "average"
cases it is substantially better, and the gaps are both fairly narrow
/ edge-casey, and very solveable.

- Leaving classic LRU alone leaves the option for existing users to
maintain the status quo. If we start porting MGLRU features over to
classic LRU, we may introduce new regressions and break existing
users. Using MGLRU as our working base means we can iterate on it
without as much risk.

> >
> > Yes, but MGLRU is not there yet and with development pace last year or
> > so we are not much closer than at the time MGLRU has been merged
> > unfortunatelly.
>
> I'm quite concerned about maintainership, as it seems the MGLRU maintaine=
rs have
> not been all that active, and the MGLRU to me at least is currently a bla=
ck box.
>
> I'm not the only one who's raised this (see [0]).
>
> That'd very much have to be resolved and the community reassured that MGL=
RU is
> _actively_ maintained before we could even contemplate it replacing the
> 'classic' reclaim approach IMO.

Very fair concern. Time will tell but I think things are on a much
better trajectory now.

Barry's and Kairui's work here has been great. Suren's team (Android)
is dedicating a full time engineer to MGLRU this year, as I understand
it. I'm planning to do the same myself. I started by spending some
time reviewing some patches last week, and I'm hoping to send some
patches of my own in the next month or two.

I realize just talking about it doesn't mean much, action is needed.
I'm hoping in a few months' time everyone feels much better about the
state of things. :)

>
> I hope that Kairu, Barry, Zicheng and others who are interested int it re=
solve
> this, however!
>
> Thanks, Lorenzo
>
> [0]:https://lore.kernel.org/linux-mm/aaBsrrmV25FTIkVX@casper.infradead.or=
g/
>
> > --
> > Michal Hocko
> > SUSE Labs

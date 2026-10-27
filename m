Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135038;
	b=2nc/u/++bExp26w1n3PMyLnbYyOy+/7dJsXlYSAfX6Xmx8J/5rvrLspm7b+7AdZ9fQsz
	 WPHbPCQZDJvm7bxKWbztbGWAfoiJHxgs0OmD/zJwELtOG+tPl6GKp0uovEYIxY44J5ib2
	 mI2apatkbXZwVI5jXo8+YB/6eqbTCAxoqUIGAKB+AelRcSATZaXL3i9kXcPZplniIZKBt
	 39Wcj3Id/lZh6NQjCki0upsX1aIEkjJEhBMgifSoRtlSNvDJR/Nla9Dr2tIECqHr2lDk6
	 FtMxcQeJSbPXuWee6aiKZWyRQ8THa/viPkLTxUU+/WyalfdZZIzjeWgdrrb1Rk9qyHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TBlSo3SUmsFznCzjJdl8PMSorjj9RIHYlB5MBggf8Ow=;
	b=jrPXUI5LaaKJgaYKpzWs2iZBp7S6LoZM8Aijg/ziT2A2F8Q8uzO+OldlZ5gYOZPgAyYD
	 9dluRYwFYMZRxlyZgtMRdFqGmdBFi7eb/w9Lvd00IG+ftviNbWaUAwsqLNSAqE08KjTKC
	 VJzity+p55OcjkocrsBbedDRgBN2swI+ZlYi+tdahQSJB+PSQNBoEjv26KfWvKD1bIpIj
	 OcsZ2p4TNiO8eMX76MK/Tp0myPg9uqHOtLBu2hCbq5FGZKieXzdidYt8VHlZ6N8W0N2fo
	 rRCh2UoOyfZYhZChEhpmpK2zHMkwbLk3ZiCnDqx9WzUzBGNb12vpNtcwb/hkd5/a5Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Jr6oj9xf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D305606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D305606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Jr6oj9xf
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677af43eed4so387154d50.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793135037; cv=none;
        d=google.com; s=arc-20260327;
        b=SC486VQw3msMvx9LUmWtIIZPFjoXwO3ENjuMgiiMVKbRmQho/jDYCW7ho4wH03/i3O
         xuLaEvEirijqEyXJCCif+0ONgzP3pOYKMu6CeZaltuQR7ruTEz16QKgCYzcVP7AP86vw
         vZAL9/QEaQ5QSqI3yn+359KIlSdHXDXf5B0Sd6n0XaziC3x1MPTcm5te9KZEGNLNa4AJ
         WtG2nP3S8SSUd5dCvWKi0PtnE4RNLLBpQyyx0V7vZ4SV+N+79qnSLc43exgtm/bHTlxX
         JrwRE78RuLR3G6v+KiXrIG9a6VdfW6IQCdoG85lhvEZHhuXlApnjbglxLnuSsIOZk2Ix
         Oqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TBlSo3SUmsFznCzjJdl8PMSorjj9RIHYlB5MBggf8Ow=;
        fh=GsizxCaGQ2nVZN5bHfNu+gnasnbmBAOTZ+FBDFs+xqE=;
        b=LkQ2HF8CJchUNJojNfUAbYOXtnOoASiAS7vTEK6Gq77ZZFlCzr9WBFqA+c82Bs+U9P
         KFdlpLl1iZ5b3+pXLGd5iq79gdWTJbnYKkKD+jhNTFB9M3Dt/ztPXmvWbz3nSQ+2Rp26
         PtfEEiEWTQt2QAuQITn2LHSISUMz6emar9gysCw8mBRbVSiSN0GJpqpJVZVdvLHuG5/O
         GXS18nWopA4EpOqhyMPfh4eNak/7Ovh4LQhmRA/ZgaqzRfXMbErOBQYsgtWHC4VQGAPi
         +ZgDVcrV3xeei4/stDFoIOkMNDXabzEZmTqfsu+9bRbDrBaoEaIHRWjvOhN5arglE5zb
         gOFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793135037; x=1793739837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBlSo3SUmsFznCzjJdl8PMSorjj9RIHYlB5MBggf8Ow=;
        b=Jr6oj9xfI0dB9CnjS4P+jjqlVZUCru7kcy1UZ0MjHh7gPYMij3jWzLpl7Gk9mK6H+f
         9jKx/1GnydU3L22bs3tAD2JSumf68n7OFfheAfU7gztrb0bKUAxdKCGNWx5OuiCaaPIj
         zHl/i9VcAcTqs19A70czGltKIxsvTPMJva1wHmPxrO2yYj7saHfpg+7hBN72bquojpzX
         KUUPQDKoomwdNrTIVqeENsJn5eybj/4ZF1hpE9UCE+wUy8aDdyompxd0TdHyji91iLEe
         /bAWhxBGO1eIR7q7Yr+bNWn+6W9GzUpoSrvUqV6i1zVOUrcStyg+fAvWiT2jNK7LPtaL
         IcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135037; x=1793739837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBlSo3SUmsFznCzjJdl8PMSorjj9RIHYlB5MBggf8Ow=;
        b=d+zu7pfsxHbi7bIzjLg4NPgVv5enq+rJ64Ym/AqLSMrIL3afIpZgHwSFNIMgrUk1h+
         MN/NmNH321DwWjzNhCmJVT8vdz4TfoIPAs7f0EbG0xLaQAoZQqp2HFBPkjscvZ59JrL2
         dUoaGZ5ycSQ7stFjb/ClBtH0gZqVChXc+LJr2xVOOOlpQ+GhlA798TRvGZHNlRH9ymuB
         Uwpas/ekTsETxcxii+mXcHybOaDMLnWeXSBsOlZh1zUX8yKiUdr168zyYNGDl+KJHT/e
         cOefHoGv01376XWe7kTebHuRC8BJAqJ8Timr2+Y8sRUoPCYZR65+/9uKwWMVdIK8Wxgl
         Xrxw==
X-Gm-Message-State: AFq9FYK98yN3aX8TvHWIfsENeitvRRIj+Q4W0Izi3nRpN4t1TH+TS0dG
	r+cA+IB5A339d0kLYUHnKTvYmat6AOL6z53DzsdeXsIuAdPasIESHg4L9YECa3gF6/PRx77phif
	Hl0V1TYQvEeJNcbkR43Hz05LzOlNqVnJfNEt7tCCiAA==
X-Gm-Gg: AYBFou0lqV2veSw5a/oQy7HYOmmMAl6MLcPgsh+tpTnrPN/w70AggJHyYa9VCxvH1Kk
	1/dMQJWZU1wnqblXIUxBcKRvOxr5cdYwnPoXNpt0I5WDkWLyYJm6wW/MI1fExvFnrUz12UL9lWJ
	us8TF4Qt9VZsL7wdpa1iNmdgVq01XDSriB0dk6z9m3Mhka6DRRkWWNmkEe8puqNsC5OldPvWxIE
	gXjdwPw7W2AEGM6ckDA90Wn11Xnwn3tZSvzOLSM09mJXfE3uszhT4HOxctGkRAtK2yF9i6auZI1
	Hs9u4GeOFUFbXpusP4ql09kZFsNg1QuaQgFksVXxOJCtSapPNBWZ9UVeZHByu3Gahn2UygTdvch
	kRphgdUkJautHkhTOdHbjHhE44z5NBd2nhlh4spZ+p4BlIhbnkvrmLNHbqctqtU9QRAzwqnxW8g
	==
X-Received: by 2002:a05:690e:1918:b0:676:7f47:5e19 with SMTP id
 956f58d0204a3-67a7bebed56mr771547d50.93.1793135037063; Tue, 27 Oct 2026
 14:03:57 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-5-emil@etsalapatis.com>
 <DMFVQMBXF65Z.11AGYWHTHCP4G@gmail.com>
In-Reply-To: <DMFVQMBXF65Z.11AGYWHTHCP4G@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 27 Oct 2026 21:03:45 +0000
X-Gm-Features: AclHuK8eUI0iv6BYa9FcQvp5sebWHF-GPwmq03yEVvq7EpZruLztd5lDt0bJRhU
Message-ID: <CABFh=a4dT_Ae3Qpzp2pynoR-9WqN2+VaD+1GeLeuFNpndQofLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] selftests/bpf: libarena: Handle NMI reentrancy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
> > An NMI can interrupt the buddy allocator while it holds the buddy lock,=
 so
> > code running in NMI context must not take that lock.
> >
> > Allow an allocation from NMI context only when the local cache can sati=
sfy
> > it without taking the buddy lock.
>
> can we take the buddy and transfer locks with arena_spin_trylock()
> in NMI instead ?
> It succeeds only when the lock has no owner and no waiters, so it's safe
> in NMI. Every caller handles a lock failure already.
>
> With this patch nothing refills the caches in NMI, and buddy_cache_init()
> leaves them empty. A prog that runs only in NMI gets NULL from every
> buddy_alloc().
>
> With trylock an empty cache gets a refill and a full cache spills.
> When trylock fails, buddy_alloc() returns NULL and buddy_free() defers
> the object.
> Then bpf_in_nmi() is in one place instead of five by the end of the
> series, and no need for buddy_deferred_free_start_bulk().
>
> Something like this (not even compile tested):
>

This makes sense, I will try it out when respinning.

<SNIP>

>
> [...]
>
> > +     do {
> > +             head =3D buddy->deferred_free;
> > +             if (!head)
> > +                     break;
> > +             old =3D head;
> > +
> > +             /*
> > +              * The cmpxchg is safe because we never pop from the list
> > +              * without holding the buddy lock. The next pointer of
> > +              * the element then cannot have been gotten invalidated.
> > +              */
> > +
> > +     } while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
> > +                      old, NULL) !=3D old && can_loop);
>
> Also one __sync_lock_test_and_set() takes the whole list.
> No need for the loop.

Ack, will do.

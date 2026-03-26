Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F03FF8A5
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539244; cv=pass; b=Gh5LeOql75VynXvlFRHvE7GrUd3IOkPY3/watojUfq/eq7h/WsxU0Svf1DTcqjT3Z9cPOxnFO1qQy7So69AkjaO4jJpTI7bX/HcQsyZmCHEUR6alBd7Z8w+fgh+MdTDbJKEOVsFEe0eujnsIN7XiYgBnI7NAqSGiBvmy7I1ecsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539244; c=relaxed/simple;
	bh=sKkanCxaJMQ3CTTg7Vchv71yrFh0Ujf+cD5GOhi/lwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV0JNVQLfqJoF3HSHZ/2wi6PZ3iEM9yLny03XSzsVaoxJM+9BA7mIAj7iw1DUmtmsB6biQJVTorf+DvaFs7uVckNu1eeIlGfY9x5vr5leHa5LnxMiklUnZzFIW8qaBbSWJYbTJ2UXIT7EQDDYkemKJqOPWCjfi0fMySt5VxQYoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l99xMclc; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99xMclc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so2080862a12.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774539241; cv=none;
        d=google.com; s=arc-20240605;
        b=J2wgM9GCqMFI3NAc7R5fribX3JiNQ1ESrBwt19aFGFTKRLOTYGjKYBEZS1+dg9f362
         56rFuS1GccJ5ceYGMGutWeYSJyUwYyjqDyEn/+VyUhcZaPlWk6TBsEt/8NHoYiE7U9D3
         lYJg0rf2G+SbChrYFyjlBV0eO9tLdjAf/5PgBnRPDadbDfT+KK4FU9aYRR5m3aXqz9Qs
         abeozbZE+gMGv+Q4KUtJrHP5NDjs10HXRBMQgE/yLVVqWr4esW4gsNIE9NkH0Gi3JWtb
         iX4jbSE5tcjz1bfKykLqfjJR/naAB/pIC5LJFYgtdox2SkgZwvxyamJ60YDvOjrF4Fsg
         hz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CNqK21CdlNhPw2osEY0xHzkQ12SMd6y8C+ANlrI7Bjo=;
        fh=+Q6xNezob5vgQmUDVCNiPlHwrpId8TfzDmDu7Ud7z34=;
        b=HyVW9qYknMV7aIeyWfgBJC06Jh3MnxKhwf5CJrHObOPgyqpY0xZs45KL65FgFRtX19
         yVqqSIHTd62VUvt8j+j3k45MN0JyNmux/pjHEaxHLJN1XlBvJXkkTcSXqBUO2u0V+7pL
         iTlUmtZ36nTpgfFdWeO+Jp1OjScJ+a2FXT+BGpkJCXbETOqwo1oaZ5zgUZ1QwwT9quFV
         WXEZYWzGTp71HOFjcnTGup7MvfEAnKnmSNJJpNIByxKcGhUhozm6reZZvacmy8DvrtdM
         EhWZKpHZWhCTBxHZwiQd0gw/whS2xPW/GFO55U8PvGom31Ra3oy2r7fRVTlSHr3js7KF
         wQRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539241; x=1775144041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNqK21CdlNhPw2osEY0xHzkQ12SMd6y8C+ANlrI7Bjo=;
        b=l99xMclcy8+sx8gJQgKezS3JFvUEoRJYmjHhsEQJA0s4NCvC8t8jiHqVhzcggxTTrw
         i50DhS1RVWM1B2ctXoqGKU2VEmyN74RGe6F+XIeQDFABqgrg34zkqLlnShKA5hIPSkQ8
         JMvPkwt2djGf//4AfST/KvRZZR7v6jv5O+ymsnGzvhEXINQlWzQWNGHmjMfU04M1h3Qi
         7HUkg29lgTNumZtBTK1NnnqY67t0jKRoZzsnf1Qo1S6FQA6fHVaMqPEQYyYB1SMqdaK3
         BHnT2o37hb6omokrl89j6zP1T5PeWA2GjtUUuyrJf61SwPLq/8foyB5KF4DiEur3w2iL
         xBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539241; x=1775144041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNqK21CdlNhPw2osEY0xHzkQ12SMd6y8C+ANlrI7Bjo=;
        b=dylgC7/CSNDjVTTYxSakCUBIi7ZPzB2GQJwv+GkByHMGHJgbt415Ei2ZWFiWYtKz9j
         0dwMA61KPNrmGf8UHOZrsKdzyMutAoUApMH9E7MoUHWG96MwiqcZW2BYWOzWumj/9l8n
         Jqrlq1yQg0FeFxl6Fyw+kmQr2GjfFRP2SIJmij+LUvgPc5frJmgRePP706BLmEak/hxB
         eh7o5jiCH5M43jfg8Jr0P4aUmyJZCC3Tr+XJvXDEOdLBrnd5cZuHgEhNrFkCy2shfB7g
         HoEYw+VUyTZVz8J/Smnstd0Hj0jIEgNKpchvenGxc0xeiSva0UR/MVwotgG+A74pJs+z
         xXjw==
X-Forwarded-Encrypted: i=1; AJvYcCXLyT+rlA9Ikbn8RfnZ6MqRkY1iDHfaw1LVXjLOMWLgwgapCTZZfFCJALHVEs1GcOeSg24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNx3wfRLxawAAvkya4XB4oC+xAenwSTnN2vT9ons8EbhAMcnKs
	khCMdgH/EufRLWnCl2P1/XwktwbLyCTAU4tQ04i8a6culUOtqOgzUnxscODbsgwQiHBcxUwh3k5
	Uv1ZUGWwnymINvTwBjtH1NYiXaw/lAUlPRycxNBJKPkWS
X-Gm-Gg: ATEYQzyuk6pd+RIK8b3TQw/UEYiwpB+JChCJFk2Z63z5279IdPRX5X1i0KwDKXc6VhJ
	AI+1A8/AQPe6tkJxUrlqje64n2TwkMtZGvdT0KJElF8NlTm4aIIZU3ggtikOUApkwWq1y/gifNW
	clLaXd4d9R8N6gjLZos+NYE24aa/MQEBy+Aywzvk9xXfmwliBFt79CopmUqvfzNacczHED8wZlx
	J6Ut880ewNPSBrcAPS84TG0++/7O8Z06XX1U1li86uffgRORREHX85FR13ES3YMOirULYxFcpSt
	D1j0NQNYmoZ2HgFTkHS+BBI=
X-Received: by 2002:a05:6402:448a:b0:665:a417:3ed8 with SMTP id
 4fb4d7f45d1cf-66a8266681amr5353358a12.16.1774539241213; Thu, 26 Mar 2026
 08:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com>
In-Reply-To: <87qzp6ipc7.fsf@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 15:33:49 +0000
X-Gm-Features: AQROBzC94dp_SwF24UKeka7rqYW_BsdaglNP_GnBcM5oX7pFlukd_lzojRwT5bM
Message-ID: <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update path
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:26=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Puranjay Mohan <puranjay@kernel.org> writes:
>
> > Aaron Esau <aaron1esau@gmail.com> writes:
> >
> >> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> >>
> >> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
> >> for in-place updates.
> >>
> >> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
> >> bucket lock, then dereferences the element via copy_map_value_locked()=
.
> >> A concurrent htab_map_delete_elem() can delete and free the element
> >> between these steps.
> >>
> >> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
> >> the object to the per-CPU free list (not RCU-deferred). The memory may
> >> be reallocated before copy_map_value_locked() executes, leading to
> >> writes into a different element.
> >>
> >> When lookup succeeds (l_old !=3D NULL), the in-place update path retur=
ns
> >> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not tak=
en.
> >>
> >> Race:
> >>
> >>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
> >>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
> >>          ...
> >>   CPU 1: htab_map_delete_elem()
> >>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 htab=
_unlock_bucket
> >>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
> >>   CPU 1: htab_map_update_elem (new key)
> >>          alloc_htab_elem =E2=86=92 reuses E
> >>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused ob=
ject
> >>
> >> Reproduction:
> >>
> >>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
> >>      (max_entries=3D64, 7 u64 fields + lock).
> >>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA...=
)
> >>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
> >>   4. Threads C: same as A (pattern 0xCCCC...)
> >>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
> >>   6. Run 60s on >=3D4 CPUs
> >>
> >> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
> >> I observed ~645 torn values in 2.5M checks (~0.026%).
> >>
> >> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
> >
> > Although this is a real issue, your reproducer is not accurate, it will
> > see torn writes even without the UAF issue, because the verifier thread
> > is not taking the lock:
> >
> > So the torn write pattern CCCAAAA can mean:
> >   1. Thread A finished writing AAAAAAA (while holding the lock)
> >   2. Thread C acquired the lock and started writing: field[0]=3DC, fiel=
d[1]=3DC, field[2]=3DC...
> >   3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=
=3DC, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
> >   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, field=
[6]=3DC, releases lock
> >
> > This race happens regardless of whether the element is freed/reused.  I=
t
> > would happen even without thread B (the delete+readd thread). The
> > corruption source is the non-atomic read, not the UAF.
> Have you confirmed torn reads even with BPF_F_LOCK flag on the
> BPF_MAP_LOOKUP_ELEM_CMD? I understand there must not be any torn reads
> with spinlock taken on the lookup path.
>
> The reproducer looks like a good selftest to have, but it needs to be
> ported to use libbpf, currently it looks too complex.

Yes, I have confirmed torn reads even with BPF_F_LOCK on
BPF_MAP_LOOKUP_ELEM_CMD, the results given below are with BPF_F_LOCK.
But this is expected behaviour, BPF_F_LOCK performs a lockless lookup
and takes only the element's embedded spin_lock for in-place value
updates. It does not synchronize against concurrent deletes.


> >
> > If you change the preproducer like:
> >
> > -- >8 --
> >
> > --- repro.c     2026-03-26 05:22:49.012503218 -0700
> > +++ repro2.c    2026-03-26 06:24:40.951044279 -0700
> > @@ -227,6 +227,7 @@
> >         attr.map_fd =3D fd;
> >         attr.key =3D (uint64_t)(unsigned long)key;
> >         attr.value =3D (uint64_t)(unsigned long)val;
> > +       attr.flags =3D BPF_F_LOCK;
> >         return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
> >  }
> >
> > -- 8< --
> >
> > Now it will detect the correct UAF problem.
> >
> > I verified that this updated reproducer shows the problem, the followin=
g
> > kernel diff fixes it:
> >
> > -- >8 --
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index bc6bc8bb871d..af33f62069f0 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab, s=
truct htab_elem *l)
> >
> >         if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
> >                 bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
> > -       bpf_mem_cache_free(&htab->ma, l);
> > +       bpf_mem_cache_free_rcu(&htab->ma, l);
> >  }
> >
> >  static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem =
*l)
> >
> > -- 8< --
> >
> > Before:
> >
> > [root@alarm host0]# ./repro2
> > Running 10 threads for 60 seconds...
> >
> > Total checks:    49228421
> > Torn writes:     5470
> > Max torn fields: 3 / 7
> > Corruption rate: 0.011111%
> >
> > Cross-pattern breakdown:
> >   A in B: 8595
> >   C in B: 7826
> >   Unknown: 1
> >
> > First 20 events:
> >   [0] check #42061 seq=3D39070 CCCBBBB
> >   [1] check #65714 seq=3D60575 CCCBBBB
> >   [2] check #65287 seq=3D60575 CCCBBBB
> >   [3] check #70474 seq=3D65793 AAABBBB
> >   [4] check #70907 seq=3D65793 AAABBBB
> >   [5] check #103389 seq=3D95745 AAABBBB
> >   [6] check #107208 seq=3D98672 CCCBBBB
> >   [7] check #108218 seq=3D100387 CCCBBBB
> >   [8] check #111490 seq=3D103388 CCCBBBB
> >   [9] check #140942 seq=3D128894 CCCBBBB
> >   [10] check #164845 seq=3D151828 CCCBBBB
> >   [11] check #163993 seq=3D151828 CCCBBBB
> >   [12] check #169184 seq=3D155453 CCCBBBB
> >   [13] check #171383 seq=3D158572 AAABBBB
> >   [14] check #179943 seq=3D165425 CCCBBBB
> >   [15] check #189218 seq=3D173926 CCCBBBB
> >   [16] check #192119 seq=3D177892 CCCBBBB
> >   [17] check #194253 seq=3D180562 AAABBBB
> >   [18] check #202169 seq=3D187253 CCCBBBB
> >   [19] check #205452 seq=3D189021 CCCBBBB
> >
> > CORRUPTION DETECTED
> >
> > After:
> >
> > [root@alarm host0]# ./repro2
> > Running 10 threads for 60 seconds...
> >
> > Total checks:    108666576
> > Torn writes:     0
> > Max torn fields: 0 / 7
> >
> > No corruption detected (try more CPUs or longer run)
> > [root@alarm host0]# nproc
> > 16
> >
> > I will send a patch to fix this soon after validating the above kernel
> > diff and figuring out how we got to this state in htab_elem_free() by
> > analyzing the git history.
> >
> > Thanks for the report.
> > Puranjay

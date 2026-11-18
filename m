Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794998963;
	b=kvP/oFW/JcsvEDV2HlysOTrP9CJ/obDlTvoqCp7FufK+ZCHukEqkTNKa+lfEw1Re/FxZ
	 nOcu4v2muj/z0XaX6f2cE/zUJmXGGTxKeNZ6nT5LyBgNl7gwLjgnphSHh8OThzW0MzfGH
	 sZiZKLF2qWju3NxnWoFggE9myAYpDtFLQw0qzoFKp49z5FUS2XA0QfdnUoChNIUpRwvDB
	 5Gaq5IqH1iHxxO9cmporxN18ae2Huw4qC3s4NqNm6gRw2MCnr/Yfm90XPiriCxd4fmzLW
	 b36to0MXwqqR0pvH4qadVobK94fr/aHy7EWPf1G5cTAs21WgaO63QqqbwuVFbV5sufQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NP7Egg2cK3GLjKZj5C+bpsjhrjuI4KFrET45ncq+pos=;
	b=gVG7J3ONS/gSAZLjQfQlCHehTjx0fAhPpmkFrUP3TYeCPWKjJStKAOZJR4lcBhmVLK6h
	 7UWSItNhNu9pW3VmB9gK6gZh1kFvS2RHMat0DiT8SZZls0Dgs/bcHCGL6doByxEJmp7Du
	 BxK0RbwWNtQdlQe2/M8GTZEVGjVTZnVNXv7AT3WoUXDPZoRplJFQf3KRw6np6vms9n1fu
	 L9LvwYFurizRVpfGgtdbnYR7D5Imtfh0hA27Zp/MKLFkqipRWFQ/2ApLbb+Va4/MeTTI4
	 Xdn8+Ax+Tsv83cSf5Q2bkiiuKDJWoV/2prM2nPQ9V7mRedxljiHvdn3Mcu6bFYrTeug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nh9L+sZA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B71606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nh9L+sZA
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-949680e6d82so111863385a.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 02:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794998962; cv=none;
        d=google.com; s=arc-20260327;
        b=eyxuEAlJtstWHMDs1jwoN8HcIFrVOgPgyr/Ijqw5n6ZrJV979RaVSnJVUs0FXblE40
         Sow51p53h+BkVmxvNA4vJxe476jkLfKO5t9ehzAMLsTMBIJwzy7cKKRLS4p3CJEbHti5
         5aEEdGhULinrnYXGQc1JMbalU/Y5vLvvSclMWBo6dmIPrYk/W/YzsHoQZVT6DS2iSUPU
         aMexWzQmZ1Ei20N/Rj3R0G6wHEkzjo+matWixJaQyeCNp2jIKUfM2cRspugdv56VteG3
         PbEmu7RrBTS3kMNwlNt87PsynR+DBJeOMhWWSFFyfYouS7sxz8X65pGrcaLtHmpQGBpG
         eLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NP7Egg2cK3GLjKZj5C+bpsjhrjuI4KFrET45ncq+pos=;
        fh=QJ5FRsQddOeV06htW7c4yt0IT9pGvuAApj6W9ppkw54=;
        b=mywhaC6KuPvdG4HBOM59E5IBss75YCtngyMeHzoUzjrYCRWxBPVCxc2y0Wz4WeIGOY
         L41qR1Gf3XhK+s1SquarGFgQPRJgGd3Xc2jXMl7XL3RO7I6TwST+2boHgetyMxzhriU4
         UxibodhJ3WZHwU21qSZcuR+p3lCnesFrlaBUgA3Cpq/FusGqd8LKDS0FG0H8/RTr4Dye
         H70bZIjItG15d7uaq+0uNeVHOv8fboZqHRZ/aw4HsLsaZztNxo4woVDvDAcAKf/V//IM
         lVfB4OggtugqY+S3NPOhjf19UPK+nwZ86qq0/i5ZOQ6Haf7xln5z6+Cro5FjSlZ11b2F
         NZUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998962; x=1795603762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NP7Egg2cK3GLjKZj5C+bpsjhrjuI4KFrET45ncq+pos=;
        b=nh9L+sZAKj6IQtN+LfWEmsirV1p1oEUtYfGLlqqw28edH4eq6yqTyFW3qjxIlyYFK/
         4eOvtMPpVBVYoY1CIPaGCeFw4zpaONJ/JJLsR97ENjgDGmDH1pepKRX9ivdOLSLp+eZ+
         CpRA1z95LV1DNsv2AVxCJTAwOsfbiDG6FBMgju0ap28Pe645QEtD9wO733jcodWGGnXE
         IpEhpDo02xuoIvJ3pAdlvz0NMsn2Tg+V9hXNVjszc+14crYhtIvQyxAFsZhP9beFfESX
         bRCzKFM78VqZ8uTSg8tzYrdCZ3qJnn+Uh/xJ0yeT+vo8En9qB/4xB1gSVu7ya7dML5wB
         jnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998962; x=1795603762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NP7Egg2cK3GLjKZj5C+bpsjhrjuI4KFrET45ncq+pos=;
        b=2B6ejlrsp+OlA4U9l/79BMY9c6bXQBUVcxmHK+da9xbl6TDxS2J1qD4GomtHgSdztJ
         kgtRG5DHCgkEP2tx6//jfkGJkkym8ZwbOkMn1vEjYYQhkNxtPoJAibcZDnuwKz9mlAA8
         ev/iAnsgy9k5G7Pa4PTvlngJYAJ4//uSJb7Js55QckvOg2fKAl0Kp9TKDOBiBHWUIqKl
         LrZ+RsG9RGWWNDgvL6ir4wlY4+ivq4HwIH96Ty6P/S/iNorOOEZH6wl7hUPmH497Fj6U
         69U2uVyvPW5bYyjixoMDpxj7EXmCSSNTRWNV4E/z57E5GAHbsOhG5xDWUGXHYZUUneDo
         MlAg==
X-Forwarded-Encrypted: i=1; AL+hErHv+hcQW1bN99F6Y0CQ8r2X4joZ9WKqOi5wdSHpcbqs+PthsWdQWuD/n8Kpp4lXNBj5654=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j58IEqYkJUP9F0FdGp2GN1eJWm8cGOIcgj/Ejc1xzoPFxNcnb
	dHgso1aLgFNEsLCdh1qKNp6nh9qLIC7h5+o+KBU+SPqKmYW/ZP+j9Ey3hQypOEFbPjQwZSeool6
	AJzbEPbsixtZAvqyDknzzyzreZ+SbWVg=
X-Gm-Gg: AYBFou35DiBDtDHuQuPZ7J7qhKRSVOimj7TBJwE+uxD+0F6c/nkyLOr0pvvZQy6O+OR
	fS/hJ+AjhrmWCZi2bbiOA+Buo5W0XbXmX8Y++Ryeafqg/+/kUDXX539qg4XJQJnIWwQfgFkYNdt
	3wdBfCYbOcUqjwLafpBjSH2eMH3rmSnwozCTFf09eFL2cLFm/e+P2W+ZyfPzW7sGUUhHL2QoH+g
	y+t8a/Q4jmI0OrQ5O7yxcj3+LRhV5fXh6GS4M0xwkxeBH/Kk94JYAkBYw5oHhWm9ijt3RjhtZws
	yX5IAFJkZ0FhxriXHzcK7aahmEXqPHfGP/K0AKJiaIC9wFKllOxu3gG/Uhp9JEORs+t95Owqlh5
	v1ZMcRWkcUri71zcvaWb6/VCOOtu8d/HwNbViZGMjsIjk2q3L825kNzMMtT1j57H7Hvw1sL91+r
	6IE7FMJUn0BjGFfVsTlnhT7mmnhOp4bSSZFivRRhMoiiDUEIJVkwBsXwZICNjqD3gaYqFuaFIxl
	QvYbdzyBzWHRzm4h45uQFRaEZOkyFgWJ2MOeLGrR+fa5iv+t724THMOKRNFOMFGJnEydj5LvQ1j
	FtM1NKd/uyk=
X-Received: by 2002:a05:620a:4590:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-9499957e2b7mr413791385a.18.1794998961991; Wed, 18 Nov 2026
 02:49:21 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117225023.36660-1-jain.sm@gmail.com> <DMY9Q4RMBKLM.2F6A6DVPXCTOH@gmail.com>
In-Reply-To: <DMY9Q4RMBKLM.2F6A6DVPXCTOH@gmail.com>
From: shashank Jain <jain.sm@gmail.com>
Date: Wed, 18 Nov 2026 16:19:11 +0530
X-Gm-Features: AclHuK9Fbf94bhZ0Ylf6POnlloUaZD5LKtE05H2BzWQ6S0Es351CCw68RVTKCWk
Message-ID: <CA+FWx==oaq5LEOOkwSvvwVkSrfq5XHrHSjVapY78EtOd3OgpMA@mail.gmail.com>
Subject: Re: [PATCH bpf] rqspinlock: Reset tail if no waiter queues behind the
 queue head
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Kumar. Your version has no violation in the model (the NMI
trylock and AA cases that hang without a fix), and the userspace
replay of the interleaving completes with the lock word clean. v2 on
bpf-next with your diff and no Cc: stable:

https://lore.kernel.org/all/20261118104758.98620-1-jain.sm@gmail.com/

Shashank

On Wed, Nov 18, 2026 at 4:05=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue Nov 17, 2026 at 11:50 PM CET, Shashank Mohan Jain wrote:
> > When the head of the wait queue claims the lock and its cmpxchg from
> > n,0,0 to 0,0,1 fails, it sets the locked bit and waits for node->next,
> > with no timeout. The comment, taken from qspinlock, says the cmpxchg
> > can only fail if somebody queued behind us, or if a waiter set PENDING,
> > which will then see our tail and queue behind us.
> >
> > In rqspinlock that waiter does not always queue. After clear_pending()
> > it goes to queue:, and two paths return -EDEADLK there before
> > xchg_tail():
> >
> >  - the trylock fallback for an NMI waiter whose per-CPU node is busy
> >    (in_nmi() && idx > 0), or when idx >=3D _Q_MAX_NODES;
> >  - check_deadlock_AA(), when this CPU already holds an entry for the
> >    lock.
> >
> > For example, with the queue head H alone in the queue:
> >
> >   CPU 0 (H, head)                    CPU 1 (NMI, idx 1 on another lock)
> >   reads lock->val =3D=3D H,0,0
> >                                      queued_fetch_set_pending_acquire()
> >                                        sees tail H
> >   try_cmpxchg(H,0,0 -> 0,0,1) fails
> >   set_locked()          -> H,1,1
> >                                      clear_pending()   -> H,0,1
> >                                      in_nmi() && idx > 0, trylock fails
> >                                      return -EDEADLK
> >   waits for node->next ...
> >
> > H now owns the lock and spins until another context queues on the same
> > lock. For a lock that is rarely taken, such as a hash map bucket lock,
> > that can be a long time, with interrupts disabled, so it shows up as an
> > RCU stall or a hard lockup. The same happens on v6.17 and v6.18 for any
> > NMI waiter, as the trylock fallback was used for all of them.
> >
> > The AA path needs the interrupted context to have taken its entry for
> > the lock and not to try the lock again, so it is much narrower.
> >
> > While waiting for the successor, reset the tail if it still points to
> > us, as the deadlock and timeout exits already do, and keep the lock. If
> > the tail has moved, a waiter has done xchg_tail() and will link into
> > our node, so keep waiting for it. try_cmpxchg_tail() reads the lock
> > word first, so the loop only adds a plain load while a successor
> > finishes linking.
> >
> > Found with a TLA+ model of the slow path. A userspace port of the slow
> > path, driven through the interleaving above, hangs without this change
> > and completes with the lock word clean with it. I have not reproduced
> > the hang on a running kernel.
> >
> > Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waite=
rs")
> > Fixes: 087849cca31d ("rqspinlock: Precede non-head waiter queueing with=
 AA check")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> > ---
>
> I am aware of this one, but I don't think it's that serious (of course, n=
eeds to
> be fixed). I was going to send it in a couple weeks with some other chang=
es for
> rqspinlock. For the next version, let's drop Cc to stable and target bpf-=
next.
>
> How about the approach below instead that I have? You could check whether=
 the
> violation in your TLA+ model goes away. The benefit is that we don't pena=
lize
> the loop that waits for next, for this very rare condition that is not li=
kely to
> be hit.
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 111ec80ea958..f6a938ee7ab4 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -624,20 +624,23 @@ int __lockfunc resilient_queued_spin_lock_slowpath(=
rqspinlock_t *lock, u32 val)
>          * Otherwise, we only need to grab the lock.
>          */
>
> -       /*
> -        * Note: at this point: (val & _Q_PENDING_MASK) =3D=3D 0, because=
 of the
> -        *       above wait condition, therefore any concurrent setting o=
f
> -        *       PENDING will make the uncontended transition fail.
> -        */
>         if ((val & _Q_TAIL_MASK) =3D=3D tail) {
> -               if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKE=
D_VAL))
> -                       goto release; /* No contention */
> +               u32 new =3D _Q_LOCKED_VAL;
> +
> +               for (;;) {
> +                       if (atomic_try_cmpxchg_relaxed(&lock->val, &val, =
new))
> +                               goto release; /* No queued successor */
> +                       if ((val & _Q_TAIL_MASK) !=3D tail)
> +                               break;
> +                       /* A pending claimant can abandon before publishi=
ng a tail. */
> +                       new =3D _Q_LOCKED_VAL | (val & _Q_PENDING_MASK);
> +               }
>         }
>
>         /*
> -        * Either somebody is queued behind us or _Q_PENDING_VAL got set
> -        * which will then detect the remaining tail and queue behind us
> -        * ensuring we'll see a @next.
> +        * A different tail proves that a successor will publish node->ne=
xt.
> +        * Preserve pending while installing ownership; a racing claimant=
 may
> +        * still be undoing its speculative reservation against this queu=
e.
>          */
>         set_locked(lock);

Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CE41D204
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276914; cv=pass; b=XmL2RFETkKOoqsxDhlTawbCUwSb9+GgBt1fRnAsKVhB4yym4TBUSwEIwVHLR0SnIJyt7rLvLcnv2xB/Oq1PVVguy0Xm5u2KEHRhxFmY+/ZTwf1j+oE6WZuYnw4P1EG5oemjSE5dWWFOzLlbny4ZCuR07z9t7d9SJ18Ci7sX+ixc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276914; c=relaxed/simple;
	bh=p4o/PFxmcf1cw0fA+hWE0I24aTc4CgN148CXk4vFOfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOwyKRRf9rL6mh6AGDBqNkmdF1cZ/Bl96CIFMSNZwOCnhAjXcPWsR2AEXV4pzQPVotDc2tGg9Z6yoc/3Y05QVNe8vf3RLeEUO8sXeqawbz4kx6I9x1tzKjhqtuL//5K4o6cehW/8b8glAR/16XpudGdyVt/J53yYuCPUsI+1ZKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XMaBokww; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XMaBokww"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac6090so2099067b3.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790276911; cv=none;
        d=google.com; s=arc-20260327;
        b=RDom4hMyoO/kJEcjYwVEYBP5cajFhlVo+CVg+A/e/EfXNns7pXjXwIzB4WEOK+8aqD
         XePfMzsu902XYBT86GecmjrAxxFBS+PvSqAs0TBwtEaRkX+Oe5uOMrSU+qDwoojJvfqv
         gns4WsuC9hJ1/sdgCtkhfqqeObgxbXsYHOfZNStThMNO8yl6BkLmIbpEDyPhtuAf088m
         J9168yxt71b0D2T9CF8DLkzKnBDya5pASs5efMihowTmFUF3ev1YU1iDq1EZHSKey8tN
         GcE5DExViZMxs9EFK12Epv7rWGXUlCkHd89igWd+TU1Lk7hVQ/IJ7g3uhTrSvSdpSahd
         6XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+hfiMOSyTBh95u2RokMxMUMGhmDYOuZDqkUOfJBbVUE=;
        fh=wdPUE/Sics1qhwgU3/93bfTngLbZm6dm7hjvSket9OI=;
        b=kvXGRxxhgDc+4j+EgPicID9au0KqII6ilQUuQugyVu/nHLVJTtxLpJ37WTv6OUr7yr
         1vHaTqj2gIcWiNbk9YFN+ndCP74NoRRw28zZl+7MFYDUnL3XApZTrpyS0/FEzC/cfJdD
         18hxm/p6q/LTAiKsGph6bLHZt6VDcN403JUc9IYQcTlCcoahLdfS6QfeksDaG2+DyViM
         2Bi5Uelok1vCFjNEkWmEPBolPTqTNOxXp7t6uxCvUlis864Jm914ZwZVt3q51vfJBGe5
         xb9CQ4sTkGKBFEsfkKTbF2c4EDwPvOEesmfym/9vIQe2D5DL5sQotPfQJanAEg3dZEk3
         NDZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790276911; x=1790881711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hfiMOSyTBh95u2RokMxMUMGhmDYOuZDqkUOfJBbVUE=;
        b=XMaBokwwcESGqpmcWSoEootAxWVFmRkvmwzo/03Amv+6q4FZ+sP8shwzs2eSmQo3te
         cKiMrzNYqkm+2DiWft+K0wB3eHPd6Ko3V+ugvkqkJ4F9SaH1km0bBufeym6Wly0CXWhY
         /IPVcjQraWzLV1QfLXiu7KLZN//xpoTp/gBaRkBS/I1RzDYpJN0/mo6wv1eDRlundccd
         4gkaS/U/kjbA5NAmfFilUplg7jrTU4BMxJGiEGcsqtVH/8beGALQnkij+X1Dn/6eZgEW
         Ctc6jz6RX3cKjt/Tj5Mp1CQYlbnMDuaULLxieEF6rUUCQImAIPF+LScvFZmzZH409f41
         W9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276911; x=1790881711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hfiMOSyTBh95u2RokMxMUMGhmDYOuZDqkUOfJBbVUE=;
        b=aadkjSKIJERBUCQyCKT3tDQ7uNNxmSsH7REhZv9DCvf1sHjaRi7L38ifq0estZGHyF
         V7G2wiVlbs3HfhcQ2LKTAYPZCHu2CZ9pTHhsdryQBSEfTE3jwPcXH3ltLDo7FpFsJzQZ
         IQ5QYOxIDDtQgidfEP7FHxEKCZIJFWbB4WdSrcVjgej2+TR5bhB9kWqxeipMiyngHnJc
         vQc/nRpv0FtS2u5MY7tQOgavoBkAKlpFT8YzY4K2Oc1l4WKbiWK/JVfdef2NTP41EOJT
         RP8evG2M7+X/6HlKxeBZnTi8UUcIvKTQSFIwgwDf6yOGq6lawM/MHGSxVVSGGq1FzTtx
         H+ug==
X-Gm-Message-State: AFuF++l5EA6fOQfYqoidVfPM2UlmWaHOXeqt8CE3bFaFJLB0XaxVEFkA
	ubgRewb437m+Fk632QLD6LCSSHVZoG8/sswGoDCOfHzYdjrjD4uEise/hel3IpZE17WdyyYnnhH
	Arb7JItfZ2Zh39kJy7WdJCufeytYuMns3yQpoLFiJ6w==
X-Gm-Gg: AYBFou0K92EV0wIKuwRNEPE/JLqBku6FQD7Gzm114VLGtGpc1l5TL38vSD2zJc8fwGg
	AnQfZLd9GmQuze3E2DQriNgnppwCF+MCwRYl4mPTqBknzPNzrCnxNdbWZBBEPsmHtGQHxpEr3+w
	+Q60wZ0n1dvkYezEyR775hC1csKUy/kbDXwCbDzPPICyra4KrkF4juds0GuZwByVYelvKr5CWyC
	rbR8AgOcqDy6rcjIFO6ioam84DlAaxI2QlHLcZpm77GeA4GEyLVPBBKiT6P0PrbGjCR9ucjQV8D
	Bpod97yKdnAm1IkibawHJCRgm7LAmC8DiUbn4K8yvW/zpvn3WhP6KmV8
X-Received: by 2002:a05:690c:dc5:b0:88c:b863:e405 with SMTP id
 00721157ae682-8a64af572c9mr24168737b3.38.1790276911582; Thu, 24 Sep 2026
 12:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923191125.5311-1-emil@etsalapatis.com> <20260923191125.5311-4-emil@etsalapatis.com>
 <DLN2450HFL9V.1JUQ5FJMYCMM0@gmail.com>
In-Reply-To: <DLN2450HFL9V.1JUQ5FJMYCMM0@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 24 Sep 2026 19:08:20 +0000
X-Gm-Features: AclHuK9zWiXL9HXKC1IT_Ueboi5YZVmWjjnucjToYgjRhlPEPMdv2qrW3LAf1EY
Message-ID: <CABFh=a7z3pdJy6LW+Kc3sQ+chp7iun8t3x+XH2OmuSKNFN6icg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Fix arena race between page free and
 alloc leading to incoherency
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, 
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 07:11 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
> > Solve this ABA problem by preventing range reallocation until
> > TLB invalidation/unmapping is complete. First, mark the range
> > freed but unavailable. Afterwards, drop the spinlock and
> > flush the kernel TLB and zap user page tables. Then pick up
> > the lock again and mark the ranges as available once again,
> > completing the free operation.
>
> The range is allocated in the range tree before the free.
> can we keep it allocated until flush_tlb_kernel_range() and
> zap_pages() are done and call range_tree_set() only after that ?
> bpf_arena_reserve_pages() creates the same 'allocated without pages'
> state. arena_vm_fault() shouldn't populate such range, I think.
> Then there is no need for the 3rd state in the range tree.
>

arena_vm_fault does populate reserved ranges, we designed the reserve
to just touch the range tree without preventing the range from being popula=
ted.
If we did prevent arena_vm_fault() from doing so, afaict we'd need a marker=
 very
similar to the 3rd state we're introducing in this patch.

More generally, a lot of the complexity stems exactly from the fact we
are allowing
the page-fault based and kfunc-based population of arenas, even though
doing both
at the same time would be weird. If we disabled bpf_arena_alloc/free_pages(=
) on
arenas without BPF_F_SEGV_ON_FAULT we could treat each API separately and a=
void
half these races. Right now we're doing the equivalent of populating a
file with mmap()
and read()/write() at the same time.

> [...]
> > +             unavail_node =3D range_tree_set_unavail(&arena->rt, pgoff=
, page_cnt);
> > +             if (IS_ERR(unavail_node)) {
> > +                     ret =3D PTR_ERR(unavail_node);
> > +                     /* Kick off another attempt at the end of this ca=
ll. */
> > +                     if (ret =3D=3D -EAGAIN) {
> > +                             llist_add(pos, &arena->free_spans);
> > +                             retry =3D true;
> > +                             continue;
> > +                     }
> > +
> > +                     /*
> > +                      * An -ENOMEM failure is the same failure mode as=
 in
> > +                      * the defer: path of arena_free_pages(). Do not =
treat
> > +                      * the leak as a bug.
> > +                      */
> > +                     if (ret !=3D -ENOMEM)
> > +                             WARN_ON_ONCE(ret);
> > +
> > +                     kfree_nolock(s);
> > +                     continue;
> > +             }
>
> This makes it worse.
> Unavailable ranges don't merge, so range_tree_set_unavail() always
> allocates a node. When kmalloc_nolock() fails the span is dropped
> before the ptes are cleared and the pages stay mapped until map free.
> Today the worker unmaps and frees the pages and range_tree_set()
> failure costs only the address range.
>

The kfree_nolock(s) path is only if we fail to somehow grab the range we ar=
e
freeing from the range tree. We can still go ahead with apply_range_clear_c=
b,
but it is not clear at that point what we are unmapping because this case
should not happen during regular execution (unlike -EAGAIN and -ENOMEM).

> pw-bot: cr

Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451512C534
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396274; cv=pass; b=fls33pNiY/1OMuoA+7LrSch4cKv/3uSq7S4oJV71XysiV7bfPHs0DlLdksHUqQEg0GctDgnXUTxhtROsyZCw/EpppP+NKiNWgJIw6HwQewHbDvRaBLuDFd6NbQc5JPG+muilJJWuanAESQbOKoARLlquQTxsRPvO4TSCPRBbPVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396274; c=relaxed/simple;
	bh=mKoQB2K1zd59bCFIuaYSj0ang9r2+p7Fgc4CdLQkv+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loJKoI9toSZifHcffpkBd8QlJw9LOyGrcAq86Hd4Hg4/iPjhuTKYYUjO8pK45GV+eVdPULIQAcFWhXuYUZUqvBFRts2zLiaC4yxFWXY4h6ZolwwGpZoAWHerIhPhy/yHDhaxqsG0dzhrt0Fys+vt7oAVPYJduR0N0cKJ32vNCdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ylbn4f5S; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ylbn4f5S"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8a8f3f7ff7cso3077757b3.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790396271; cv=none;
        d=google.com; s=arc-20260327;
        b=UBSUKjgUMcEzY76sVFwRV6Q88S6yl1XsDUAstg4Fu4azwK/CU1EkN2KJz3cMCUa5oa
         jshIbOQ7TzootVEMlqudSZPXmwCKmHNfeMamTVfFaElMyzK1Xq/z8iZColOcYDeK/DuO
         v3ql8ItsNATR5i2nB5wLGYVVENprTulebah1SjZVHGYwWPkheO+zdw7uGdv/VLZh9DH5
         tZenuOFaXcxKNoXwUvdocnDgezQ2pIQeJr3NS6eKyxiKSABp9jjcyLSqLGn4Fz5ixvpu
         /L92ZmiIGJsz9APl+3+azxGrYe8I2croZ4vj1VkQCpGYVlZsRxoKjyWyQe5IsROV40Bo
         Cw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snWcYVIbuHCJCEzCM2a0sbOXAcXL63CZ9fKsTCFnAx4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=A4Md8WwFf7dKwML7MvWxEenf5TCCl6VLr0eqyP9xEwqyiacNvSMAm90RjsXqlnzwJ3
         AZsfRhKW8u6fsrVNahlR1qhF0zyCBmwPwRCC0Qxz+XCgVMTBTDUqJLHCvIkvM/4GTuD0
         SHW+pLfGYkf3ivby6N02z+Nsx6vH6hmU3z0izW5eti+q8YEuYbAzHYrWaN90/Cb7byx1
         BGAtJW1w6K9NGjXHsf3ZNgQTecoouYRzBJYaSNYBleo3eidjvLj3H2x1/J9TU3ufRxtY
         ZzDxJDLuJOgIypvPgusueow6biGCy5gVQWjFr2wHtQ7K2SMO5KdqUhdwW5UeM3CRWdI7
         xiSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790396271; x=1791001071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=snWcYVIbuHCJCEzCM2a0sbOXAcXL63CZ9fKsTCFnAx4=;
        b=ylbn4f5SL8ru5s9k8q2IIPtS8UCbH1d7wGeutB6AOrJRrQOK6Mj4b9IJcnOMdmnavg
         gcu9HXDg3kc1UmlbrNh3zuW9cw51CJRihmH9ouK7XNvdV2BM6x+xS6TxOAhwYSuswrkx
         Bl291rBc7rl8UGWsMfDDAX4HiAzo66WuBl3M0QSR9v5B+4MEa9OsliHqq5IVwhuKIsbz
         4lGehOEdvaw2t6+lTWTDrBuHogJmGf+iggZz6gNfin6PDG8tkiEACJPU21CxTJ9oj51X
         TuuU87OJHca6xvoobKi9aggtolivPtzTVLhAk8l4y+mkTAlkQ2Hj8Lz7S6cTIPR6ERzU
         GQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396271; x=1791001071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snWcYVIbuHCJCEzCM2a0sbOXAcXL63CZ9fKsTCFnAx4=;
        b=jhXHEFbEsVNC3AlrQT+8xOO5rxTDRviUbgEZnPrLXjZBmEF1XL5nWqLr/gVzvGHqY7
         Zo+mZtlE2l/6SWqfit8/HTxJNFz9a2XfpQL66Xtr+feS1zgxubSZHVJ44AYlJ9HjSQrW
         USWiccQOOd4UWltefxA5ka2xmHafBHKP7GpBqHvLoSYSEiTnR4TID617V7wJZGDJ1iEp
         TqK0orDaY8983b/HK9jKYd8ZTm4Xjdmj6lL3b1u1UjSc+ffzuaWqVukVBAfiVMOFaT9L
         ++CulltLn0p+kY9HYt7+vptzYZl3iQUPvbRnBPug9o+A1L99lKlfbhhD8p8hR4UxgQJL
         rClQ==
X-Gm-Message-State: AFq9FYIV/cHaKVIoar4v95T0DbIf1x1LMVS5lAQoDFnWvJV9mP3sJAXS
	1dh+hBKqXjI0f4wehyH1qCL2jnQRhVSBthD0wd9HOqDQ4rUsf8QkVvaFJ8Tg1mSi9sCDftjPGIN
	xNBnDnmNzFKWkJxGWsIz9JQtQ5kSHgfAAEKZIIOV+44Dwg+Kx/DAdGio=
X-Gm-Gg: AYBFou2OfaqrNfq2xYj60x7Mo1blN7ohh3uAN+gFONzx/rgvHS+umPvgc9/7ltVxoTG
	cxwv1B5cxTLwc4SGj2SKYUvjiPpNTAJU9m/Nktjc9zjRicjtXlvGWGg0Ia5Op37+4KEEL8gL1IT
	Tfw0cZ0Vju4ohVETtX4ryo/6fvkE5GtHBoGCRMpuTKeNjr9qJtRE4w6Klz1FBWJEb8tZz6wCdYw
	RCkCLznT8RHE1xDRzcfZ3j5OiF+6WfnX4YKINVgXlLyjC4StX2fP5u5vMp7x+U66ZKwY86i3PtU
	Lh5bkuVY2qGEv0Ruoiygzz3SRWq83xXwZq+1UP1FXh+GmSXHeV0vC3kVsg==
X-Received: by 2002:a05:690c:c4fa:b0:8a8:7688:2d99 with SMTP id
 00721157ae682-8a876885069mr21726147b3.26.1790396271119; Fri, 25 Sep 2026
 21:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925233538.5708-1-emil@etsalapatis.com> <20260925233538.5708-4-emil@etsalapatis.com>
 <20260925234633.AC33F1F000FF@smtp.kernel.org>
In-Reply-To: <20260925234633.AC33F1F000FF@smtp.kernel.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Sat, 26 Sep 2026 04:17:40 +0000
X-Gm-Features: AclHuK860xoyleu-slraLZST313n0NY2IiJuy1wJUsr-r0xjKr3KqEvsXl3X80s
Message-ID: <CABFh=a4w_SM+XBAHXzcPa_vPcr_CBdZFTRuzQM+V12bqT9X5jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Add sleepable arena page allocation path
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: CPU lockups and memory pressure due to massive page allocat=
ions before range validation
> --
>
> commit 0ff0c13da92aa5b627b22373d01f9a6a0085c43f
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> bpf: Add sleepable arena page allocation path
>
> This commit modifies the BPF arena allocator to allocate physical pages
> outside the spinlock. This allows sleepable BPF programs to use the
> blocking allocator slow path when under memory pressure.
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
> > @@ -747,8 +769,12 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
> >                       /* requested address will be outside of user VMA =
*/
> >                       return 0;
> >       }
> > -
> >       bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> > +
> > +     ret =3D bpf_alloc_pages(node_id, page_cnt, &pages, sleepable);
> > +     if (ret)
> > +             goto out_memcg;
> > +
>
> [Severity: High]
> Could this early allocation trigger system instability or CPU lockups und=
er
> pressure?
>
> By moving bpf_alloc_pages() before the arena_adjust_tree() check, a BPF
> program can request a huge page_cnt (up to the entire arena size). Becaus=
e
> the physical pages are allocated before we verify if the requested virtua=
l
> address range is actually available in the range tree, this could result =
in
> massive physical memory allocations and blocking reclaims.
>
> If the requested virtual range is already occupied, the allocation will j=
ust
> immediately free everything when the range check fails under the lock. Co=
uld
> this be used by a BPF program to induce excessive memory pressure?
>
> >       data.arena =3D arena;
> >       data.pages =3D &pages;
> >       data.i =3D 0;
>

This scenario is handled well enough as we discussed in the previous versio=
n.

As an aside, the set has  a merge conflict because it is being routed to th=
e bpf
tree but the patch series is based off of bpf-next. I think it may be bette=
r to
target bpf-next instead, otherwise we're going to have a conflict merging
the two later (bpf-next is further ahead arena-wise so to speak).

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925233538.57=
08-1-emil@etsalapatis.com?part=3D3

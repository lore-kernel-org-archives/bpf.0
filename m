Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EED326938
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446044; cv=pass; b=Lsl9T/4FOAZE+vxZsVUD8X/GZyZtfc+FZ3JRashNxIvN1YpKra0a6y6A4okOsGRe/KCcK90VBURsn8m9iv2qnmoHbFeP5liffJPbMRXENZd91yMX1DNWETKxMdzcyLXVFsOfQPI5IDChOYUi4jPz97Iiuk/WvX72DHozS1Myx6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446044; c=relaxed/simple;
	bh=06kMpxCm8ISCJ1snCCoGJXMkyB97GUyzLbPodOtLGjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoJZ91bi2VW3iInZYtOfo+U6LIEsDyRNRlJ0uvOVqGChbET09vcQjpdfkwSIh5szS96VJO6Zq+mHeEIvP3na/oW6ezQt64V6Dk94LStYBAYiNz+7J4nOE56cZ/4aUDZ35upW0Ywl/rNyYxcP+tsbOLLJIkG1oEbmigDa1zBlk9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr+V+abZ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr+V+abZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-672c23aa064so1652640a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776446040; cv=none;
        d=google.com; s=arc-20240605;
        b=jkOcn6+C6COplRnBrR8poXkeX2nWr5O0MSU6plj+dP7GmMXuTd/A1+7Kjk1XCKEHPq
         /fuY/0FW80BI0xMwrl0HanXUcN5neBhyuy7p0yw3jfwDjpifII2jsGAL6D8pKpIaRrFn
         1vKIlJMkvyAo8qzX1PqBxrqFXK1MSqPDBXKoXIy/lKDuKntZU+wOQ6phvT7MEYfo+cRg
         RexBXZ+hZNer6BMXpQvSBrjR5qFg4TctmHpAGif3rSCn0kbG/nVLJaM5CZtGpFMGMAFp
         PiG/IhdCjTEweTY0m4vCCTaYy7tXCKgQv6QANdxpGMEbAyu+FYhRr/lotJkEdG7b4eed
         VKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vO0QlmUSScuGL60aZNWbsgf9uqeV6j4ThnI5lW9t5sg=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=iF0heh3c4oxuANASLk4ccffAsiBNXG6fw8wTXUA/B/QZgfxL9HhgJFlEnfCIwHg5EJ
         Fw1XdY+akqBF/6I4YS3LwFmzHAJgbdvz87hJLVxFcEiaNefva3afF19lOn4jkOHcKQ/U
         HF3BfU9PVo9ZpvhImPH5/0yAg/Lk/ZAb/lVG+6F4VtvQb4TrC/ku6DP5aQkWWgscz3TV
         cKGjhtHKPydz+kf7/YWuCgrCgdO0g7cN72xWstoAYM/T32tMi97gzh/hJ3N13dcXErus
         leo+41OyCixscHSefR38SFa9NobnuRomMomsMmN3FQGAViMjb87Ua+evqiMRsvlJNlQ7
         su1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776446040; x=1777050840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO0QlmUSScuGL60aZNWbsgf9uqeV6j4ThnI5lW9t5sg=;
        b=Fr+V+abZKcPbM1cOk7NCQxnrFRE62qIY2Am3ZKo3BM5RR3+RjCDutZ9siWxrak2sVW
         8ac8xjJaiPEP7rcPN33JAIPPTuA+x3js/ewahScnN61C2RcJB2WZQt2axM7ZkFPY/ipc
         9fyNUlvG4ODIGHmpt99k7XIGTXjEPURMIbjYF9QXwZX2QOvksG1WmLO2DrxnPy3DI58e
         oT7mzhUfVfOLqZFmhuPZlB7hTcydndB72byynI5wcvrKHt5QZxip3lo+bc1wlxSFBCU1
         LkqrOPzio6Ivob5QI7fnW9Cumv0xdFQaG2ArkhUx6+sA3zyND93A4v8kOpUZtGUB0xSH
         Vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776446040; x=1777050840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO0QlmUSScuGL60aZNWbsgf9uqeV6j4ThnI5lW9t5sg=;
        b=YfmJNflEVTBT+xHMFpaUI1mBorJPhnX/lV3waqD7FiwVcTaM4ozqk7T8NMM8wxICqc
         HnUuYI2Dp2iy4vCGxItcQsSg71dXESA4gm0/1rGJ7XQ/DC/vrYO0qg3DdfAjIRuHvwzl
         F+PSyk8Bq4OQSZv8bW+TPBk2T6e0SWBytKEbGr0ZnEIOfAEmTHm4aSq8JAXQYwtvTLjs
         PGCm3zOObnPGsTZsh2WbU9U58pW16AAi8xuEd0MgduXvYDXTYZIoTGgYjfUy3833rw75
         KF+HD2ATim9m6xD8fH2W53WLUwi8MARIiXMPRyWPYQk9QpYtERtvDPyl2OOYjU31iAzP
         uOFw==
X-Gm-Message-State: AOJu0YziGvcGCGtyWt0WoP4q6Q1MyLlfWv4PWWwwz+1cCy02ZqgWHUuO
	jRXt1l+Lm7A2QxPGnoXdxFgXDtVP60Sa5mdhOx0HbeXhX3abxIDttSHk7O9rMtfKYp0pGypnyFi
	xdaaEwWqWBGMN91uDygl7JVkI4HWzyb8=
X-Gm-Gg: AeBDieumfe7JvcU5EbiT6rKHY+vQnqVOZirbJUM0vXyXuEVDxRVxwwSCf9QzkEAKr/5
	sdedzzjRIM0iovaTzOxI9R2pFRPW936VPfBc8ec5tVGTiLG/2m9GErxXI0buNluuG3ielk6Mv+J
	fuqqQV5xncGrej8ttKQ9aZPSAJTYt82kEeeiBxDcFsy4Dr/J+GtRvL6BkIYkX5Jerp/4wWwSbdO
	JBxCXFo2OEWeJ4p/ZCLR1zgiHQfOzGGPWWPQ08A9usmhkdwlcxxyQoHwcrWfypugIr8ACkex93D
	QLmM2QxP4niMO35EWtSt0pmiDUtuBBVZJQ==
X-Received: by 2002:a05:6402:3048:10b0:670:8d21:dcb with SMTP id
 4fb4d7f45d1cf-672bfdd8356mr1551240a12.19.1776446039632; Fri, 17 Apr 2026
 10:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417152135.1383754-1-puranjay@kernel.org> <20260417165515.63952C19425@smtp.kernel.org>
In-Reply-To: <20260417165515.63952C19425@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Apr 2026 18:13:46 +0100
X-Gm-Features: AQROBzCdPwmEe49XyOn_2cCFXB4mKHxUeyJiKM4HIoEe6cwlCfUGb06ABItgwlU
Message-ID: <CANk7y0hkC8D-8LTb4yc6c9m=qBj0gYk2rc3sFrai6LG6s9278w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Validate node_id in arena_alloc_pages()
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:55=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] This problem wasn't introduced by this patch, but apply_to_page_=
range() is called within an atomic critical section with IRQs disabled.
> - [Medium] Validation of user-provided NUMA node ID uses node_online() in=
stead of node_state(..., N_MEMORY).
> --
>
> commit 312a17d46d0e6285c5b29bc93a445829df8c62c7
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf: Validate node_id in arena_alloc_pages()
>
> This commit validates the node_id parameter before passing it down the
> allocation chain in arena_alloc_pages().
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 9c68c9b0b24ad..523c3a61063bf 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -562,6 +562,10 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
> >       u32 uaddr32;
> >       int ret, i;
> >
> > +     if (node_id !=3D NUMA_NO_NODE &&
> > +         ((unsigned int)node_id >=3D nr_node_ids || !node_online(node_=
id)))
> > +             return 0;
> > +
>
> Should this check use node_state(node_id, N_MEMORY) instead of
> node_online(node_id)?
>
> A node can be online but memory-less, such as CPU-only nodes. Passing a
> memory-less node down the allocation chain could ignore the user's
> placement intent and cause unexpected allocator fallback.

That is fine I think. it is just a hint.

>
> This issue isn't introduced by this patch, but looking at the surrounding
> code in arena_alloc_pages(), is it safe to call apply_to_page_range()
> while holding a raw spinlock?
>
> arena_alloc_pages()
>     if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>         goto out_free_pages;
>     ...
>     while (remaining) {
>         ...
>         ret =3D apply_to_page_range(...);
>
> Since apply_to_page_range() can sleep when allocating page table entries,
> could this cause a sleeping function called from invalid context panic si=
nce
> the spinlock disables interrupts?

No, the page tables are already allocated we just do
set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL)); in the
callback, so it is fine.

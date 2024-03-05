Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96E7F
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599140; cv=none; b=r38cidAo4e0/pSOaUZBAPVQuz6TtsI+GfdFv/LdicD/cfUhLAooAQH/JxwVTWwAcJLwuByraWyZBkOpbcQ0qXRDlxowzhdCcroxa+9Xx+yDYd31Jw6WC8zU4MLHQIwaVf/Ux/dApre93IOPNpJl9DyXCp96gxrM6ArlyXzYnJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599140; c=relaxed/simple;
	bh=pE/HJJHxoI8oSX8QIfvjz3rKFl/qWzRuw0gGjdoZRC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhEpr2MQw+qGlWN4LrFQVvRDBom+UgBCyVcW/mVSkOtqjOX5Xol8bKu6tN6OVfNiMyFUJUO+7cUZKDQ7DN+DTZwTThbc+SnGq3dLHzp7kaOe+IwKREjZLX1YpjXU6Q1H6KPZjjT1KCGmlDPR9wYMx/Kk6ev11NaXZvQ5TQmNL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqx1Xscf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqx1Xscf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412e8c63f23so6744525e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 16:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709599137; x=1710203937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj5zoTI69PLp3cR+V6/5ODnZceaydtC6xTdxHYis12E=;
        b=nqx1XscfmH09BinLqkR8HLyHWckzE1hJnYvnN/HO+dv9J+1aXYeoeUnuuVJrgrxUOi
         a4klzaY4cR0vtWNkzSjaelS09j8jIAB0HpQPO+VS2bcwriuB9v8+0V69AEHt0NRP5t3B
         mbggUA7Twyyz+6f0o2SdxxVyEXLliQSAUU8hIi54hkVbTeBWuKKIRbAXnsYECxTTawTC
         f+D0Z37vTlCbaJtrXBTtBDEOR72AM4jdO+sG57XW1zgQG3UAoaqIPRTZYGnviqwPDmxA
         C8vPJDFrptGQSjAnS9mrwleFip3jOPkZEAozT1fQI5HbeRVJoTJ/vP9mjH7kGBoKdnqJ
         cDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599137; x=1710203937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj5zoTI69PLp3cR+V6/5ODnZceaydtC6xTdxHYis12E=;
        b=Z9nV1S2qO07M5Pxc4RJVvQAcbCGHLSn4q4XqzYuw5OpCCm+XO0oR/e6+PMWXPbOztk
         Q/23LsuxIhde74ARMBGQ9HrvCjokiuCRDEzHfaU/K87ureOJsktdbfQuH7Lf0Ei1uuni
         MXWRZAu6tRrQ1atdVa+1FS8q7ZeT19I6PhC2tIVQ82MijufnS7JJQHukU76jHwuVqSD/
         VX+RcBLGYMXQy8SSaIJh7p7KwBS8IJHpdpbvA3Hl2bsrEQ4WfKpw2NP0eNYrVkEyRojp
         c0v2Cc0oIVFgzK3r9A4hFnPWLid1qd/nUxaodb+CfNCNe/LRYef4mFy2L8NFvinV7wZJ
         tpFQ==
X-Gm-Message-State: AOJu0Yy/WHEnPcQsiFrifx+PMJua8c5Q4G1fjeal8HmCIlaJRAShNOuv
	zOEP0oKba3JGd32+LlZkqfgYLzLyF7jXHVyODNkbOSIZw4puMvBmzCVw7S42H1SD+R1zVuJA4lj
	TNGL/aMlMKlajifKmpdKFPBLkey4=
X-Google-Smtp-Source: AGHT+IHPuUlqp1ldZ1+USNRqTG8hjmjknNCOaSaQz6ztGJruA1SPY5lwFtYqj/d3Q7KwH/p72Add+tEiks5hC80Uxqg=
X-Received: by 2002:a05:600c:444e:b0:412:ecc4:3c3a with SMTP id
 v14-20020a05600c444e00b00412ecc43c3amr154280wmn.40.1709599136434; Mon, 04 Mar
 2024 16:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-3-alexei.starovoitov@gmail.com> <ZeV-IE-65yiIwFSY@kernel.org>
In-Reply-To: <ZeV-IE-65yiIwFSY@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 16:38:45 -0800
Message-ID: <CAADnVQL4iEhc4nAoeE57Q3=X0_uh37ZDW_SOw1CicD1L7eTU6w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] mm, xen: Separate xen use cases from ioremap.
To: Mike Rapoport <rppt@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 11:55=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Feb 23, 2024 at 03:57:27PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > xen grant table and xenbus ring are not ioremap the way arch specific c=
ode is using it,
> > so let's add VM_XEN flag to separate them from VM_IOREMAP users.
> > xen will not and should not be calling ioremap_page_range() on that ran=
ge.
> > /proc/vmallocinfo will print such region as "xen" instead of "ioremap" =
as well.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  arch/x86/xen/grant-table.c         | 2 +-
> >  drivers/xen/xenbus/xenbus_client.c | 2 +-
> >  include/linux/vmalloc.h            | 1 +
> >  mm/vmalloc.c                       | 7 +++++--
> >  4 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/xen/grant-table.c b/arch/x86/xen/grant-table.c
> > index 1e681bf62561..b816db0349c4 100644
> > --- a/arch/x86/xen/grant-table.c
> > +++ b/arch/x86/xen/grant-table.c
> > @@ -104,7 +104,7 @@ static int arch_gnttab_valloc(struct gnttab_vm_area=
 *area, unsigned nr_frames)
> >       area->ptes =3D kmalloc_array(nr_frames, sizeof(*area->ptes), GFP_=
KERNEL);
> >       if (area->ptes =3D=3D NULL)
> >               return -ENOMEM;
> > -     area->area =3D get_vm_area(PAGE_SIZE * nr_frames, VM_IOREMAP);
> > +     area->area =3D get_vm_area(PAGE_SIZE * nr_frames, VM_XEN);
> >       if (!area->area)
> >               goto out_free_ptes;
> >       if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr=
,
> > diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xe=
nbus_client.c
> > index 32835b4b9bc5..b9c81a2d578b 100644
> > --- a/drivers/xen/xenbus/xenbus_client.c
> > +++ b/drivers/xen/xenbus/xenbus_client.c
> > @@ -758,7 +758,7 @@ static int xenbus_map_ring_pv(struct xenbus_device =
*dev,
> >       bool leaked =3D false;
> >       int err =3D -ENOMEM;
> >
> > -     area =3D get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_IOREMAP);
> > +     area =3D get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_XEN);
> >       if (!area)
> >               return -ENOMEM;
> >       if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index c720be70c8dd..223e51c243bc 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -28,6 +28,7 @@ struct iov_iter;            /* in uio.h */
> >  #define VM_FLUSH_RESET_PERMS 0x00000100      /* reset direct map and f=
lush TLB on unmap, can't be freed in atomic context */
> >  #define VM_MAP_PUT_PAGES     0x00000200      /* put pages and free arr=
ay in vfree */
> >  #define VM_ALLOW_HUGE_VMAP   0x00000400      /* Allow for huge pages o=
n archs with HAVE_ARCH_HUGE_VMALLOC */
> > +#define VM_XEN                       0x00000800      /* xen use cases =
*/
> >
> >  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) &=
& \
> >       !defined(CONFIG_KASAN_VMALLOC)
>
> There's also VM_DEFER_KMEMLEAK a line below:

Ohh. Good catch. Will fix.

> I think it makes sense to use an enumeration for vm_flags, just like as
> Suren did for GFP
> (https://lore.kernel.org/linux-mm/20240224015800.2569851-1-surenb@google.=
com/)

Hmm. I'm pretty sure Christoph hates BIT macro obfuscation.
I'm not a fan of it either, though we use it in bpf in a few places.
If mm folks prefer that style they can do such conversion later.

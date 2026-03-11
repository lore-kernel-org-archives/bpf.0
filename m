Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7029B8E8
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247743; cv=pass; b=bkBCZRzwafCGiwZ13gcUlibgIG31tz4b0hcW9GI8wqVjE6xplQvDLBZEeuISZbesUVYu4mIEweKBYAjizSIptN5BRGEqtdyLFwtPgz38i9OtfQ0HzjdYNDm8kd5T35CQYSgEr1Oo3GyPl4KuP5oS9taEpQ6Zf4BO4UekITjwXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247743; c=relaxed/simple;
	bh=aF2d1FG/AJhKqk1/FPhm3JdXDg5IwJTmVDCruVRl+og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=giWKhxIocVW/SR/G/36XHohhQqTiAVLAdlffhYi1NVzKPaq6+t2Y52hYWx+V24MyWo3xx0x1O4tjOwxla4SM4zyLlY0TDTfewKl1NKsDaF3P1+oKwygKTfnyqdJf0Hy7khuYgXRKmgcWKZq4vePjq/87oKJm+4hV1GnYrqko7Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbWvqcyI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sqknam5Y; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbWvqcyI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sqknam5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773247741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3v+UPQnqofsHvXnJzYf1erLJ+408CusvMF2aj07tYsA=;
	b=bbWvqcyIEZwJvuMfwqoLuzdjgTb+gRJFRElMXl97Bn80tXtRxPJsdODdQRo+QJXP0a09dM
	KRYP4wUKaKRbEMTYc7h0gPfPwjXlSxhkjk4XIhyH5VbNKB+9Hd+hGPcS9feq3K+i0On41b
	2SRJsG+9tc/38u7EY6am/B//PkLjHDQ=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Vu5wMRw5MWayrSKJM0MHqg-1; Wed, 11 Mar 2026 12:48:59 -0400
X-MC-Unique: Vu5wMRw5MWayrSKJM0MHqg-1
X-Mimecast-MFC-AGG-ID: Vu5wMRw5MWayrSKJM0MHqg_1773247739
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12711ec96fbso978303c88.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773247738; cv=none;
        d=google.com; s=arc-20240605;
        b=aH++jWHVhxp73Yndd4y2iE6YnIMZrrWsBjIAk7NmFgNufN89bviLwf3d5xd9vE7h0z
         1sVxl5X8T57KVtMUhw9f9GDjiZxzt+8RdgpIg4R8htTvVgMv6c2ycUZdnl93Qc0Z3L9e
         PCZuJ21QlzRnYg8YjqKsmzrgz3ZweZQK75rlgCEhOPmsFeCttZstRfXc3qJ0mXNJZiHa
         0OAlFFV12YnZtRCB0He0TsHSjItV4j4yrIjnecyBP26K9u21fLRKzY4N0eaRP1W8D0HX
         Wfkyr+MaDMBPiAwM+bzuQyOHR6uNMCGeFce1iVOpY5MHBvXBVvIZjo1OSeHNkLRVL/UK
         RH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3v+UPQnqofsHvXnJzYf1erLJ+408CusvMF2aj07tYsA=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=WJVArgGi3m9szKSFtgPHapjdgQ8KJok8ekgaL7YiFp9C7wCO3mm3UMoLc4HYu9n4pT
         IpBMqhHMeLX6OME5KqyoUAPaw7VqTc0I4A8HASQBSf7GUy0cB5AVdqlLyYf1mlkDi8Pd
         cPQcXHOJMHbWAPoKdY3GbTkvQCD4/6Jy6+oN4Je20krwcGnL3MzBncOlFVrk3nvuWLUT
         JrIkdQskKt7rIOcgV9+1mTry2b0h27M0MRPMhZvSDh+pbH4mbrF7dh3zEoEx1EQ1dvR+
         WK6lxMjp6MhK17KAzjDxkvBxzd0ihMv4k+GV1Bp8Bxnk4TP50znvRmPD34I+zz4GSDqj
         0Geg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773247738; x=1773852538; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v+UPQnqofsHvXnJzYf1erLJ+408CusvMF2aj07tYsA=;
        b=sqknam5Y7kDi/4NEtN55bp+ABbStHNb6IbnugRh06AZjjR52LE405DQ+GTaseXFKTq
         yUPkP3eX6CsXyMFLF4yTFDiwWKR7Tog6z3NUYkKO4dfAU4c2mOaFPmjnXXPvHmVsZowK
         Oi6ifZAB1f0FblKc6HQPyyLv05vyFVVmlx/tPrKjBhhiqHiFujMeet9p8dxT+9JHNPe2
         wPyWGwsLbDl+WRhspuKGbW3fz1KmRY2bpdnkz/frEwQetBoOEyI5UXf3fSi7ZSrXmRd/
         rg6IRvT8KG+nVHr/zhjxtGsqOBaGrrcGzLoKEl0eIKHpff2JSBjk1FSfIKDFmsThDhlv
         XbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247738; x=1773852538;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3v+UPQnqofsHvXnJzYf1erLJ+408CusvMF2aj07tYsA=;
        b=FojqvWybkpsE60rlqeOpfmga/sakTQRI4le2qqK+GgoqyfwlEnY867dYEOvE8TQJVN
         SleIQ3PXD3J7Q90ujFCc/+M0JI45UCP6NgPV6TuvlbrBXt6s1Oa7kjn0jau3ny6fTzks
         rvpxXnFhTLSfQQfNy9leYooBCTv8TL7fTlR8KxaTtqfLjg/K9582/ktRI+IufjOzpxbN
         hvNxh+i9eVTlHC63RzMnD7uW2kryH5c1RttGDuJD26dNpj16PcK9f78VAITRQ1ZHybq/
         nntRVUDgEXIYWQrbykgjUVXNozTIIZ5jLliYN63FuhbGqLNuBZkrSGHlWf09dOH0R/Mq
         w9Hg==
X-Gm-Message-State: AOJu0YxY5gPnQGlANMyoKQp4+96fQEF7NdBT2TdgHYgvROMiLIR3DTIv
	VAgRanH0Oj8skVceXZ0wzofl+i2AYMxjvVjoo5whCiiKyW/FptGw8FA9phCKVpfcEuFBi39FpiC
	/qpdFfkGWvsVM36uApZyYX7H818dP7FEi4bWYB88H5bKY+oxyi9Ut5mii8LFgPwHCNC5lr0nwzM
	1RBTuR1NG/zIe5M/vdivDAZQ2wYI9NWcJj64kdm3bLzQ==
X-Gm-Gg: ATEYQzwIy0qbqW2fjDmKwegqtxPceGXPOSSHS3SUGSHqhLNEi0OvguCohGQyCi8FWtH
	XScFzYHGd2YYJUxoBJTeLOwEGuGSMYYoGzBLrY60Zx2YbpHMS9V6uAXb1QtxTRv/zRA7E+4tk5N
	ByjGYXBW64H1bFrWOWegNwXW+cUfRmypE8kbw9LKItYIkjGpXKFIrShKKM3aOZu+wqYRRdDVLpe
	/MLBol/CFcdreDfCp8th/8wRPKrKlDQ9kokRVA=
X-Received: by 2002:a05:7022:1a81:b0:127:1492:e370 with SMTP id a92af1059eb24-128e778a222mr1779711c88.5.1773247738193;
        Wed, 11 Mar 2026 09:48:58 -0700 (PDT)
X-Received: by 2002:a05:7022:1a81:b0:127:1492:e370 with SMTP id
 a92af1059eb24-128e778a222mr1779696c88.5.1773247737595; Wed, 11 Mar 2026
 09:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
 <20260311130321.1055808-1-memxor@gmail.com> <CAP01T76QJoMnMKNp8KrJ7NnShe78HQOoADXZTZVqAnpSbyzYfw@mail.gmail.com>
In-Reply-To: <CAP01T76QJoMnMKNp8KrJ7NnShe78HQOoADXZTZVqAnpSbyzYfw@mail.gmail.com>
From: Greg Bell <grbell@redhat.com>
Date: Wed, 11 Mar 2026 12:48:45 -0400
X-Gm-Features: AaiRm516nDKV4hofLh-0wNdyb5w0xkmELuFHiwxunq6qyT-NDLkDxdE04IM41DU
Message-ID: <CAJvyaJ+znQeDw-+64mdcY5K+eT8TxGXrywB1MvELYOYjo2xn0A@mail.gmail.com>
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for this Kumar! I confirmed that this does fix the bug for us.

>> +static bool btf_is_module(const struct btf *btf);
>> +
>
>This probably needs to be 'bool btf_is_module(const struct btf *btf);'
>, i.e. without static.
>I didn't get a warning in my build, strangely enough, but nevertheless.

For what its worth for me it did throw an error for the static
declaration and I had to drop the static keyword:

kernel/bpf/btf.c:1886:13: error: static declaration of =E2=80=98btf_is_modu=
le=E2=80=99
follows non-static declaration
1886 | static bool btf_is_module(const struct btf *btf);
     |             ^~~~~~~~~~~~~
In file included from ./include/linux/bpf.h:29,
                from ./include/linux/bpf_verifier.h:7,
                from kernel/bpf/btf.c:19:
./include/linux/btf.h:219:6: note: previous declaration of
=E2=80=98btf_is_module=E2=80=99 with type =E2=80=98bool(const struct btf *)=
=E2=80=99 {aka =E2=80=98_Bool(co
nst struct btf *)=E2=80=99}
 219 | bool btf_is_module(const struct btf *btf);
     |      ^~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:289: kernel/bpf/btf.o] Error 1

On Wed, Mar 11, 2026 at 9:26=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 14:03, Kumar Kartikeya Dwivedi <memxor@gmail.com> =
wrote:
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 09fcbb125155..d18e218049ed 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
> >         refcount_inc(&btf->refcnt);
> >  }
> >
> > +static bool btf_is_module(const struct btf *btf);
> > +
>
> This probably needs to be 'bool btf_is_module(const struct btf *btf);'
> , i.e. without static.
> I didn't get a warning in my build, strangely enough, but nevertheless.
>
> Gregory, please give it a spin and see if it fixes the bug for you.
> Martin, please let me know if this looks ok to you.
>
> >  void btf_put(struct btf *btf)
> >  {
> >         if (btf && refcount_dec_and_test(&btf->refcnt)) {
> > -               btf_free_id(btf);
> > +               /*
> > +                * IDR for module BTFs is freed when module's BTF refer=
ence is
> > +                * dropped, which may happen before the final put.
> > +                */
> > +               if (!btf_is_module(btf))
> > +                       btf_free_id(btf);
> >                 call_rcu(&btf->rcu, btf_free_rcu);
> >         }
> >  }
> > @@ -8383,6 +8390,12 @@ static int btf_module_notify(struct notifier_blo=
ck *nb, unsigned long op,
> >                         if (btf_mod->module !=3D module)
> >                                 continue;
> >
> > +                       /*
> > +                        * For modules, we do the freeing of BTF IDR as=
 soon as
> > +                        * module goes away to disable BTF discovery, s=
ince the
> > +                        * btf_try_get_module() on such BTFs will fail.
> > +                        */
> > +                       btf_free_id(btf_mod->btf);
> >                         list_del(&btf_mod->list);
> >                         if (btf_mod->sysfs_attr)
> >                                 sysfs_remove_bin_file(btf_kobj, btf_mod=
->sysfs_attr);
> > --
> > 2.52.0
> >
>


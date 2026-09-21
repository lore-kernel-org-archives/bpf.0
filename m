Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672742EEA3
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022098; cv=pass; b=fIsMEj3bhez2BspyoKV31NoGf4pwFxzQYLwjwCFJv92Ift60fWO+05M23lNdDQ8zVuFdznuI14jI3neKZRy9/t0eXGoD09BhYzHQ8TYHRQ/ZJBqUDbmLuL9DZUPOI05DYcrKna0yLGTSIOCvfY94z+0+qo1vcCnzyoJs0X3CffE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022098; c=relaxed/simple;
	bh=HL0EylvTbIIIOAHary5gB77Cp4l7ZXs2o2z9aqarAwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO8+Xkkdibpi+q7IrGUx64k8SLzejP2PvgxFtOx+Pjft7EyTK4K0fFSesNwYRG21Zi4Fe/onpt0U/T4GEPDFFSZHyp3hi1A5UJrVfoJ3Njb0j6+N/wc2pujknJPjcdP6im1aWk1UjtTOyAnGK4v1Ugdy95NR3ouhUKlcJy6bUJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2cPv2MP; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2cPv2MP"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so4910847a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790022095; cv=none;
        d=google.com; s=arc-20260327;
        b=U57SDVzVtOufOqV+DuGwftP3B5Apiw5S5Se0awP9m9x+qxQYCmr8EoW97ZEnDMS6ma
         HL8JLjIDVHvhFRE/1h14d+peLzHaLjUzFfWlcCf0N3VIocGvT7T2oFLpA1U+S2fSfmSS
         dHf7hU8MHzwuTvd2kV9j+MbmyaaPoURnmapE1VRnuB82v9FmlVI/CmRkyCy/j0TrWJXL
         FWgilYv/TowloZ5yDx2Mlp8P6sdPWPoerWQAeRIbgUHTU6gu2QUm47vk3/5A4CX5xZLy
         B79QQO6wyEga6djSKsNQzauhMsFBbQa+y4pmu9saOtHA0GkMPo0pMsrlqrvjM4F4+OuO
         nabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        fh=Z7vfaMqTDPhrGOC5uAsUKKmXnKJd622tFSQcicnk51c=;
        b=ZQ2b+Mu+qD95WqBNvtHys1I3aVxRMcdso3HP8rPzHPC+aHhGRgj4gEiuunm45IFrvZ
         I9PkpGn9qkemVfTFfcMAyUGb3UdXPEvz1SQIMFyGZAG4juQS2ebW2fW10BqwuMp50SpA
         9LSJOoDonKCZHs3X0dBOP6qWJJ6Zjj5/3uLq2ajk74xN3nb35CWazGP8/3NmyP20MG0r
         uud7xe0ZJ2FwQBVhGG6cQEEa/LE+h1T2ZeWqmIH9zzoJsFC9VvkQcibT4aeONtWLqIH2
         4dOAmAE+98RZNwmLwoO0AUaFj7TX8DI4oQ8OPnyPdOL6AVwETAY+/os/ZNWwNBAp6vS6
         BE1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022095; x=1790626895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        b=Q2cPv2MPpIG00WN3pYPNgVdxPPTXsHF178Vgvkri5Oe3j+7XSLEjbTRLz1eKjhL36s
         sYJQJAwb0pofVuuwhCFvYZyXsDRWwuvy82hB6jvFdAqchH3HRQZQmFTImNONyiSbXSWa
         xjT4ECFLwM4i+nbXiwtc/IT1PgBp8N+k/5xMBNlqrfGfSZfSK4JH0zYvMifAo9HdV9gl
         s3aCSQYkSjwBkwkGjNK2yngf/424fDmAs7hNPRXwF023zB+I7d7qlirOaM3a++BaYOUQ
         SdEwyUtc5rQs26+0+jn3+T/oscO/QRS8yH1BZSXFXHk0ahfNcxuNHvjNI85lZq2MxjjY
         tFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022095; x=1790626895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        b=OYY6dz8ZRfS+Yut0mtwVrsslDgtIzRht0H5O39OJ3MlvTPCxGV333x1xu2Tcw/vOj0
         dJ7YMPEJsiEcp/hA/+51TOu1vT1QrStD+PymJG7esY3S9MxrsmehpHwX3b1JF/QQnbX6
         gZOmhpDK1rwpAsF4ndDkIE+HzA/pV2ejuiPm4HFgLLWq0ECKettNGZIf3SscmQxdOvBY
         WbFa0UvvP7EMD1tH7KUr1qOIgVZZ6fDvb9/VbXru6GyfpdqIwbTEU3d0MaFRu9bngyqt
         3IivltIX7WnaVKtlaP0b+QBOvz4Y5jx/R64PqbtSmrUyiuoArKmGpA+uP7WUs5rG3ckc
         aR/A==
X-Gm-Message-State: AFuF++lKSSlvNMn65gZC+3mprComVe+eahguu6fvaBQBYpgORCW+Q+4s
	QzuObbwREdV0yoEc0/+yPtKjqBZ3CjDiOjMAS6dfAb0mYmQwzUAgBUAI9ZEdQNwhAEgWX9m10AD
	KeX8kC8ONxsOcQkP8YlDpS9GXwrpKtto=
X-Gm-Gg: AYBFou0xR7z39nFYcfMwfLxjNgzoXDcLrWzmIxnT66oJTOsydZ0eHNqFarW+kuTh2vG
	yE6+ZxWz7Qc3EDmGWp4ZlsjvADag8MCI9Uv/ZaRkZE/lOZfCC8mSAfLDulPgwx343ehHDoeb3pI
	9HyYMZcXegbLzi6ITQHwxSNc09sx58sn+PMEfLlqB6kRm/4/G6dMpVDFwBVOljhuiFQniANf/ZS
	HPXLnlXdOauv8LrSzOmwUIg80FMKJNvwfol9AJ8YvK3DO2KUkOKElh90LpqH6EIfr1KFoQ0O6l2
	/3nBOU1f5a1fNF4AkbLGvCZbyQBrmmZY8/kuJqm88BphIidDR2H9sS8RkafRt7SbWwAHUA==
X-Received: by 2002:a05:6402:2355:b0:6a9:d93f:2a4c with SMTP id
 4fb4d7f45d1cf-6aa545f836emr9135400a12.3.1790022094908; Mon, 21 Sep 2026
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191407.1742386-4-puranjay@kernel.org> <41b3ffb9922beb0c24d302a85752d4f82ed168fec13f6b1926e34274d9e31338@mail.kernel.org>
In-Reply-To: <41b3ffb9922beb0c24d302a85752d4f82ed168fec13f6b1926e34274d9e31338@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 21 Sep 2026 21:21:21 +0100
X-Gm-Features: AcwNN1XPjU1fOESZgtZBq0kBMbCasuLeG6oILzP9OmaEMLjg5Ejgd9Ky--3Ydvk
Message-ID: <CANk7y0ijFB95gtQVRdjCb7uXGrKyjOpBnyjL+YZWrvFR4aOxcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	harry@kernel.org, paulmck@kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 8a01dd4058a03..301b35bd85c8a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4838,21 +4838,10 @@ static void bpf_rcu_run_callback(struct rcu_hea=
d *rcu)
> >       bpf_prog_put(prog);
> >  }
> >
> > -/**
> > - * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> > - * @rh: struct bpf_rcu_head in a BPF map value
> > - * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the val=
ues
> > - * @callback: BPF subprogram, invoked as callback(map, key, value) for=
 the value holding @rh
> > - * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> > - *
> > - * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held =
by neither a process
> > - * nor bpffs, or -EBADF if the calling program is going away.
> > - */
> > -__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const=
_map,
> > -                          bpf_rcu_callback_t callback, struct bpf_prog=
_aux *aux)
> > +static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map=
, void *callback,
> > +                       struct bpf_prog_aux *aux, bool trace)
> >  {
> >       struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> > -     struct bpf_map *map =3D map__const_map;
> >       struct bpf_prog *prog;
> >
> >       BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf=
_rcu_head));
>
> This isn't a bug, but why does __bpf_call_rcu() take 'void *callback'
> instead of keeping 'bpf_rcu_callback_t callback' like the kfunc
> wrappers? The two call sites both receive a typed bpf_rcu_callback_t and
> pass it into the void * parameter, which is an implicit
> function-pointer-to-object-pointer conversion (accepted by gcc/clang only
> because the kernel doesn't build with -Wpedantic). Keeping
> 'bpf_rcu_callback_t callback' would preserve type checking at the two
> call sites and match the cast pattern used elsewhere in this file
> (helpers.c:bpf_timer_set_callback, bpf_wq_set_callback_impl) without
> costing anything.
>
> > @@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_hea=
d *rh, void *map__const_map,
> >               return -EBADF;
> >       }
> >
> > -     rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> > +     rhk->callback_fn =3D (bpf_callback_t)callback;
> >       rhk->map =3D map;
> >       rhk->prog =3D prog;
> > -     call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> > +     if (trace)
> > +             call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);
> > +     else
> > +             call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> >       return 0;
> >  }
>
> This isn't a bug, but would passing the call_rcu variant (or naming the
> flag 'tasks_trace') read better than a bare 'bool trace' parameter? The
> only behavioural difference between the two kfuncs is which queueing
> function is used, but it's carried through a 'bool trace' flag that the
> reader has to trace to the bottom of the helper to interpret. The name
> 'trace' is also ambiguous in a BPF file where 'trace' usually means
> tracing programs rather than RCU-tasks-trace.
>

No, I think "trace" is good enough, the readers know what this means
so we don't need to over explain here. Of Course if others think
otherwise I will send another version for this.

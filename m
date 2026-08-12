Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3940EBA8
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532102; cv=none; b=P83QKG7KEUkZ2+U/Ne4+n5kiJSvUxNWKga5Kj0qHX1/rztD+gheEuC4ur7Wjs+KSGvf47OLxAqjaTp99brHvbQH8agfSh+pgYuAu9cAHyMCtWwQ5Y1ytZo3lmOB2TqMaSgr/VzKPJbGH2NlUyrtLIJN2IPMqsn7e0gBRdSg8NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532102; c=relaxed/simple;
	bh=mkEMYvOBUBP9mf6ujt+QKJ5QLBLaIUpjlgZ/Ors3prw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs/9iwIJ4UsjKGcqwn4yu32Mdtpy2exZDtlC3G7hE/ogri1LhKoEZp8JJLRKfN9ftHrceVLzaO2S8NTbOSGaXHe77FaIFAU+6L4X6AQKVviZ8bADKY2Bp7b6zln1FixaT9b/pVQDjbGLAR9XE4vQGr3sS/sw1HCGLubo+CJMSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjso+IZh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjso+IZh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956242332dso7145365e9.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786532099; x=1787136899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TaYIQ7M4HH4um0m6rcSdrPMZwoKevqKb8one0oMaoa4=;
        b=Yjso+IZhIFy+sY5mZynvoyBe1fN7/1wgxreJnAfd14UUXF1rfO+D6wJb3Hh/rizC1g
         hgNDc0pUkWwAH7q3cgHcE7DTb/pC1F71O/aPdUQHgCJai1Kcegi6zCRFPCK3JwLxwz6n
         gM1PVv1j0YyNexRyWOAVrOKcu0wmxTa5R6FPy5ATvnWPb2d9dDw00S88njf739HK3Rot
         7SPxErqGp1A1dzqFjUYkmiEzgkPThPinILBspkPDCAEREW6sFAEcLbaPzD0io5eyLI97
         xSwfI8CEbRY3E39qtKB2DGsy0YUmAeSr4+q0NiMBZRP0FBZlL5MA7NdRm6sLe0I69Dwf
         eg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532099; x=1787136899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TaYIQ7M4HH4um0m6rcSdrPMZwoKevqKb8one0oMaoa4=;
        b=iFQNeigJP2XT5YpCRPDvrwq/RoUzEYwD20MPc9fBLcpUOD7ZJz1LfRN0McC7HhN1JK
         deKvYX55avEvRD3sPN2TW1/KuqnHk4N2XrdiKIUoGfa8E6OLXNqG7WLtl5nbOYHod9Yx
         h2VDqtIFWJOV0R+iwC5vTx3pR9cXS/R9kyBTZ743x2RzivtR+qlsITUcD4Yo6HdijfBI
         JCEaGSCFkkTuyy5gb8B1gf6qY91llW76puLnRYcYUgJZliqC7Jkqttad9Zx9wIqRRbWu
         LzTPsAnLd72DC7F9TO1264tSal3nIUKNyt+VChYg1ahyLubf/yp2FVFkPT6XBA0ufJ87
         6GPQ==
X-Gm-Message-State: AOJu0YzyaIquUVgkquSlzKtvuMwA4VgcZq+mQZKPJ/T8RpxZln4oFLkN
	d03odsxrvTZOjmwXGrV3q9I/DdlQJM2GeR/t26nWoJsdzZtnoO9zyVcw
X-Gm-Gg: AR+sD13eeodJ4Q4ppsti+vd7rQ09vZ7w2XbcfSPhaF4qJLiWk7lg37sI90rQr5qNtqF
	jiHgHkma4/QN9RLmVYOzHC5Aa4flGMwcrCyO+oNDngIn8R0He7XoE4glFW6umY1AZg7j5onHYR7
	5vbvUyA0NdMoLUoEya9VL4kmJOUuC1/4eOmMI3UD4cJCDHSk0hiXEYP8LYpy7UUOh7hR+iJPjd1
	ObSxjILI12tBh7AuSDmF4Yw+Uu3J31b2DMa37+fbUjVYWZjLY8YmmouYyB+N1KOx6d7TD0MKNVJ
	2O7GI1kx8+fNrrDKLuAEMXcDXjNvIyZzXdZ54Y78g3sOznN3cBaiCjtGMg8FLBtquBszG4Gfyv7
	ywcuegSarxASy0AGWPc5/8BtKlvgUY0BwBuaUuuYpG1e5EyqwRPlqMonxK5gh20TdcEkEHztmaM
	qkt2HZW7vdUge2n81LvdhmAu1pxs/b36KWvrLQKs4v/8ovySOBiBGIJYBJgiu+OFE4OsDewKYTb
	L9yGq8mJ8XqFPGM6b0zxDhHz45GmuQ=
X-Received: by 2002:a05:600c:470d:b0:499:4d4d:822a with SMTP id 5b1f17b1804b1-4997c16007cmr42417015e9.17.1786532099258;
        Wed, 12 Aug 2026 03:54:59 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d72141sm6559541f8f.36.2026.08.12.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:54:58 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:54:56 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, memxor@gmail.com,
	jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add ksock kfuncs
Message-ID: <anxRAIXU5lLOIo7O@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-3-mahe.tardy@gmail.com>
 <CAAVpQUDeiDOQa6i03juWO64vyz0TnFH6mqB_vNo0ZeqA0-otxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDeiDOQa6i03juWO64vyz0TnFH6mqB_vNo0ZeqA0-otxw@mail.gmail.com>

On Mon, Aug 10, 2026 at 09:24:38PM -0700, Kuniyuki Iwashima wrote:
> On Fri, Aug 7, 2026 at 10:15 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> >
> > The API consists of five kfuncs:
> >
> >   bpf_ksock_create()   - Create a socket (sleepable)
> >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> >   bpf_ksock_send()     - Send data through the socket (sleepable)
> >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> >   bpf_ksock_release()  - Release a reference (cleanup via
> >                          queue_rcu_work since sock_release sleeps)
> >

[...]

> > +
> > +/**
> > + * struct bpf_ksock - refcounted BPF kernel socket context
> > + * @sock:      The underlying kernel socket.
> > + * @usage:     Reference counter.
> > + * @rwork:     RCU work for deferred cleanup (sock_release may sleep).
> > + */
> > +struct bpf_ksock {
> > +       struct socket *sock;
> > +       refcount_t usage;
> > +       struct rcu_work rwork;
> > +};
> > +
> > +static void ksock_release_work_fn(struct work_struct *work)
> > +{
> > +       struct bpf_ksock *ks =
> > +               container_of(to_rcu_work(work), struct bpf_ksock, rwork);
> 
> nit: if you need respin:
> 
> struct bpf_ksock *ks;
> 
> ks = container_of(to_rcu_work(work), struct bpf_ksock, rwork);

sure!

> 
> > +
> > +       sock_release(ks->sock);
> > +       kfree(ks);
> > +}
> > +

[...]

> > +__bpf_kfunc struct bpf_ksock *
> > +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> > +                int *err__uninit)
> > +{
> > +       struct bpf_ksock_create_opts opts_copy;
> > +       struct bpf_ksock *ks;
> > +       int err;
> > +
> > +       /*
> > +        * sock_create() derives the network namespace, credentials, and cgroup
> > +        * from current. Kernel threads, including BPF workqueue callbacks, do
> > +        * not carry the context of the task that invoked the BPF program.
> > +        */
> > +       if (!bpf_ksock_has_user_task_context()) {
> > +               err = -EOPNOTSUPP;
> > +               goto err_out;
> > +       }
> > +
> > +       if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> > +               err = -EINVAL;
> > +               goto err_out;
> > +       }
> > +
> > +       opts_copy = (struct bpf_ksock_create_opts){
> > +               .family = READ_ONCE(opts->family),
> 
> I'm not sure if we really want to care about such an arch, but
> since you mentioned unaligned access in bpf_ksock_connect(),
> is READ_OCNE() safe here ?

To my understanding, there's no issue regarding alignement here since
these four fields are __u8. The READ_ONCE is only used so that the
compiler does not do smart things like moving load or reloading a field
between time of check and time of use.

> 
> 
> > +               .type = READ_ONCE(opts->type),
> > +               .protocol = READ_ONCE(opts->protocol),
> > +               .reserved = READ_ONCE(opts->reserved),
> > +       };
> > +

[...]

Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08902396D21
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936073; cv=none; b=bfVlI+aSigwOF/6craaZekhml3RQgxxfmziYi2DH0t+hhdJ25tiZggotNsmiksd4QIMVgbNggNhdhYSI2fewFPoXlCvU6pGKmnmZR/N3eg+RcPNJWUDvle8cXROJaYFLivvOtK8Z08J97A7d1akUqgJmgfUuUI7ChSXpqJAsJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936073; c=relaxed/simple;
	bh=jnGgGDtJaiHTpWedHcitax5pKAZs4Ve8ImdmxNgaMww=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIt0yK6SAgfuq94MamHgJahStv20sLgVVlSQiXaVHJ9Z9VESJJaUmmSoSJe3aj0WCEZW9H6ovey+mg5Eg8GdoVrFWyI6cciNzTd+C8+IoDiTUkz4iEyyGD7OhqDtOXz99J9fOpYgm2ojOw9VzHHqaq/TVZYOP4zM2t+3VgYC0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjcp12jw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjcp12jw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4362507f396so5177927f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771936069; x=1772540869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdA67fxGAODEvD0mlOn/T3/ZTarPD6vhJPnIAbEKHSY=;
        b=Cjcp12jwMQsTNfxT62TKJsDi001zrwZmIamFsJ5VvFl6kTlxJ8cAHwbYdmC73+LcPj
         tZS+S73lbSC4uMZh+WrrhH4s8yriDKB3WC2B0gKIkiOVhxc9pUESSfO8NkgRRZuRJ4Ca
         mBIiAnH46L0xlPa0DLamqapdFYbflckdYpPTQnH/NniZJAtiOfsUEZ0yiUpoPnR0W15E
         tfUrrNZagFj5BTjBMmL2lSgcv90fx7qDwCn7PCua0G2tjqdHQbVrXmP6VBmLYhBpl9ha
         /3pSUSWTy4gqfFCdmH8gEKh4HiNGgHAi4E5s4ktDp2YoX+qFVV/1RCdsKadwWB02CqSd
         SnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936069; x=1772540869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdA67fxGAODEvD0mlOn/T3/ZTarPD6vhJPnIAbEKHSY=;
        b=Qp48b/tvKlXG42aGEu+05hwv9C93+C8BWUQKW++fiaIJKopf9W/YFmi5OMsCKw+TIw
         XSpHJZ3k7OoA1120EXkEjIURJDjrs5Vj5AojL1sSjcYzp/O5MUUhTHHx3UNT9KiXvzhM
         ZCsWiNtVa04I1eZ7uXAv7Mq7hFoUlLDIPn9cCVvQMuTNDPEF1dBKyGVHeWKhJld54Nu3
         GkClfCJOxZ8VJXiKZQHhFotypXmfPNFLtr9DWyYsCWpc3kIvMgl16w41o+bIfx2FQqDJ
         WKrp4bNX4dM3SdxORT+X0d3AGIpxvkmiolUda+57kPn1pJu251a8fXSdeT4H2H1c4WGi
         ng/A==
X-Forwarded-Encrypted: i=1; AJvYcCWRD/9mhowimPQPtGBVfedB2Hj59u4VuLzZUw2Cu3F555yYdywtr9FWXVomAgFVX9uGUdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQJp0ley14THVFhwfpcsHdntfjMNWgfF04BebIPV01IAJKZOW
	eXgEJzlhkmC/QjAmeA3M92swFohGcSjKI1wQFZ25UujOA0OMEBtbKCpN
X-Gm-Gg: ATEYQzwgLT/R+b/Jiwet+LqDiN3fgkohPdD0+t0a23mcYXF+lWM1pYqm0ug3CXZig54
	Se2TpIqwg32XYN0/lEbOj6kjol885HX19GJP774bpR9L6/iiWIW9G+Cx72qH+4Uwtj3QwL5PRQR
	9aoKFG1kpuTHMqjbl/SitjRsJ6aY1VnMWdGfA+vQK4e+eAEN8dbKrH/Y0yphg1o88oQrUE6hILh
	+M9qFmPGHE1sFJL2iDfAVnZLPpSuhEJPe3QKMD3uMb5O2Od6wMxeE/ry/ICBVJ5yUIJQTDpJ4XY
	vxhn9Ue2d/VHmd8UXdRZXHiiP8r6k1hbB1QIE8iXXMZo2exRtV45rXJuUZTN8j03M+OYSQlfTgJ
	NQqD+vo5xvBFaxiLWJfMUvCvtFFr2TrlHzLT/cabxQoT7SCh9JY4oUtPOvPJSph/mBL9OY0st
X-Received: by 2002:a5d:5f43:0:b0:439:879f:f8f3 with SMTP id ffacd0b85a97d-439879ffaf9mr3265620f8f.16.1771936069016;
        Tue, 24 Feb 2026 04:27:49 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c96csm28661352f8f.30.2026.02.24.04.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:27:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 13:27:46 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aZ2ZQnBHPz3UO1wr@krava>
References: <20260220100649.628307-1-jolsa@kernel.org>
 <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>
 <aZsT6_3tkli3SPsI@krava>
 <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>

On Mon, Feb 23, 2026 at 11:35:29AM -0800, Alexei Starovoitov wrote:
> On Sun, Feb 22, 2026 at 6:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Feb 20, 2026 at 11:58:13AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Feb 20, 2026 at 2:07 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding mutex lock pool that replaces bpf trampolines mutex.
> > > >
> > > > For tracing_multi link coming in following changes we need to lock all
> > > > the involved trampolines during the attachment. This could mean thousands
> > > > of mutex locks, which is not convenient.
> > > >
> > > > As suggested by Andrii we can replace bpf trampolines mutex with mutex
> > > > pool, where each trampoline is hash-ed to one of the locks from the pool.
> > > >
> > > > It's better to lock all the pool mutexes (64 at the moment) than
> > > > thousands of them.
> > > >
> > > > Removing the mutex_is_locked in bpf_trampoline_put, because we removed
> > > > the mutex from bpf_trampoline.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h     |  2 --
> > > >  kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++----------
> > > >  2 files changed, 56 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index cd9b96434904..46bf3d86bdb2 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1335,8 +1335,6 @@ struct bpf_trampoline {
> > > >         /* hlist for trampoline_ip_table */
> > > >         struct hlist_node hlist_ip;
> > > >         struct ftrace_ops *fops;
> > > > -       /* serializes access to fields of this trampoline */
> > > > -       struct mutex mutex;
> > > >         refcount_t refcnt;
> > > >         u32 flags;
> > > >         u64 key;
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 952cd7932461..05dc0358654d 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
> > > >  /* serializes access to trampoline tables */
> > > >  static DEFINE_MUTEX(trampoline_mutex);
> > > >
> > > > +#define TRAMPOLINE_LOCKS_BITS 6
> > > > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > > > +
> > > > +static struct {
> > > > +       struct mutex mutex;
> > > > +       struct lock_class_key key;
> > > > +} *trampoline_locks;
> > > > +
> > > > +static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *tr)
> > >
> > > select_trampoline_lock() ?
> >
> > ok
> >
> > >
> > > > +{
> > > > +       return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
> > > > +}
> > > > +
> > > > +static void trampoline_lock(struct bpf_trampoline *tr)
> > > > +{
> > > > +       mutex_lock(trampoline_locks_lookup(tr));
> > > > +}
> > > > +
> > > > +static void trampoline_unlock(struct bpf_trampoline *tr)
> > > > +{
> > > > +       mutex_unlock(trampoline_locks_lookup(tr));
> > > > +}
> > > > +
> > > > +static int __init trampoline_locks_init(void)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       trampoline_locks = kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZE,
> > > > +                                        sizeof(trampoline_locks[0]), GFP_KERNEL);
> > >
> > > why bother with memory allocation? This is just 64 mutexes.
> >
> > ok, I could probably use __mutex_init directly for static key
> >
> > about 64.. not sure how I missed that but there's lockdep limit for
> > maximum locks depth and it's 48.. so we'll need to use 32 locks,
> > which is probably still ok
> >
> > >
> > > > +       if (!trampoline_locks)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
> > > > +               lockdep_register_key(&trampoline_locks[i].key);
> > >
> > > why special key?
> >
> > if we keep single key we will get lockdep 'recursive locking' warning
> > during bpf_trampoline_multi_attach, because lockdep will think we lock
> > the same mutex
> >
> > there's support to annotate nested locking with mutex_lock_nested but
> > it allows maximum of 8 nested instances
> 
> yeah. subclass limit of 8 is there for a different use case.
> 
> 
> I guess you never validated your earlier approach of "let's take
> all trampoline mutexes" with lockdep ? ;)

nope, the rfc had workaround for lockdep ;-)

+#ifdef CONFIG_LOCKDEP
+	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
+#else

but I overlooked lockdep config for this version

> MAX_LOCK_DEPTH is indeed 48.
> 
> See fs/configfs/inode.c and default_group_class.
> It does:
>                         lockdep_set_class(&inode->i_rwsem,
>                                           &default_group_class[depth - 1]);
> 
> the idea here is that the number of lockdep keys doesn't have
> to be equal to the actual number of mutexes.

I see, thanks for the pointer

> 
> I guess we can keep a total of 32 mutexes to avoid making it too fancy.
> Please add a comment explaining 32 and why it needs lockdep_key.

ok

> 
> I thought declaring all mutexes as static will avoid the need for the key,
> but DEFINE_MUTEX doesn't support an array.
> So since we need a loop anyway to init mutex and the key,
> let's keep kmalloc_array() above. Which is now renamed to kmalloc_objs()
> after 7.0-rc1.

I don't mind either way, meanwhile I used this version:

static struct {
       struct mutex mutex;
       struct lock_class_key key;
} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];

       for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
               __mutex_init(&trampoline_locks[i].mutex, "trampoline_lock", &trampoline_locks[i].key);

thanks,
jirka

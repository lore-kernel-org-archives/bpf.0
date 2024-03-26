Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0C5788E
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421824; cv=none; b=A78fMfnBo5PQ7GzGTyYpz/daSgpSe6enTqeyf432tY3uAJ6M8Vk+W3+02i8mvwHRD9tL6V4ylL5OXrNuAGhJPojZ20XrLV82Abd81B/ZG3/q+jLdBjMLOad9M4vw2ScahmhrQje/WRJf9If0KoEaC168Y8INyxhgcBjB1sNC25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421824; c=relaxed/simple;
	bh=vaBPeKWaUkKISF93ene3R19zi28nkv03VTG0Psh1FBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhz5p/BFGRUYQqw19rrmo615m2Cpp/2uTXHvTWYFB+ru9ePQ2JCTs2uocaqdNrcx5rf7K5IejPDNz38IXLjCR5y8qAdMhO4uT0jOj6aEVJfrhduFBM+gRg2hFbtwgWfZ2BpDP/9xr52FKB+wBaXWge21roEVBRf2Kn7w93QUEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+SQSMvH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+SQSMvH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso8872039a12.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421821; x=1712026621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAwWRbX7O1TYgrEt1XM2smkIb60cZnL3OgWHvU+K26A=;
        b=l+SQSMvH0ubfUKZZQDQmB8fAUDr3sQlXCIM0kQW0NbQcRpA5Za5Nl8feZdnJZWq+zk
         gEJW1K9zg9j8Yw/2rZEtAGxl1666heD23M6RxqIz/ULz7nZ++cq64AF9oqLgJDTw2SEU
         X4sJT3B31MlybVJlFqPPoPpcMDAg46lZ82vHUmWXkl02uNSC7IHmfA1pSXsmLW6uJ6QM
         EF5QwruJGMt6uhs7yTmmL6mMLvFRV8xxooBM7oCysfQS0GrkAV3gqJL6UCfxDjSPQpPN
         k2XdDuLNZPc5w0OKkXIImFB7R8ssFkBgrFUvS+Cyxw/qsOXiKgCNdDTZlBApBNyELL4g
         P8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421821; x=1712026621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAwWRbX7O1TYgrEt1XM2smkIb60cZnL3OgWHvU+K26A=;
        b=G7lwijWuIGpuQ6uQXPyg4TZ4GhJnP7WItXhW8Cvawpv6uv19590l3cXUecLM3xqFBb
         dqpZBrG7CI966SLuqTwyt0GILDFjV9VQcw/yOyIvOZnswr4TGwt2FsBoYPDtDVMKQTLV
         Ps36BE9m3hPFyPHTDX06upA1gfZ1fzaurMcb1rjndgipcqvZYxtVJ5y6cFoOTnib36nB
         78gQAZzmEjfAOyvSm1LOcdUSwzG8//EVAnvHIBkyU8Z9QTMg9c/CH3ZnACxSEk5ayGMG
         ehbSzgHNSiftwPCADgXEHQiD71fHgPQV+FIqdYXjmJKcagbkN/3ocoLcoq7ZeOAE+qyB
         BO0w==
X-Gm-Message-State: AOJu0YwDu6MJsfN1T69KFUvObeOk4RRXDJmlaQ6kaSZFLaNBAOt2joQ1
	jFnaK8N8tW/7Fh7SJXVVqghSFCcKAKy6xZoRv8q+JkuJtOwaKniykDFBRJvifSCSVIWVkNJy6Tw
	kvkWj2i356ji0DfnJVwZZ+xjpY3E=
X-Google-Smtp-Source: AGHT+IEMh1BI7keGfRp4679dNkXu+fkB7cinLrGlISJyQQc8Ox4CK1iz8FiwOYVEeS7J9YdiHS7F81UW9l1ehb6LbmU=
X-Received: by 2002:a50:951e:0:b0:566:6a9d:6147 with SMTP id
 u30-20020a50951e000000b005666a9d6147mr180772eda.0.1711421820519; Mon, 25 Mar
 2024 19:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324230323.1097685-1-andreimatei1@gmail.com> <CAADnVQLouo7SwAsgbA_ELaZ_qsdD3RzhFvLH5xwifBFNyotURg@mail.gmail.com>
In-Reply-To: <CAADnVQLouo7SwAsgbA_ELaZ_qsdD3RzhFvLH5xwifBFNyotURg@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 25 Mar 2024 22:56:49 -0400
Message-ID: <CABWLses6z5wgyAWzKmGafW9eKqRi3EyQGQ0SSgpGis9c4cbDTQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Protect against int overflow for stack access size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 9:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 4:04=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > This patch re-introduces protection against the size of access to stack
> > memory being negative; the access size can appear negative as a result
> > of overflowing its signed int representation (the respective function
> > arguments is sometimes converted from a u32 and u64 without any overflo=
w
> > checking), and causes out-of-bounds array accesses in
> > check_stack_range_initialized(). This patch causes the verification of =
a
> > program with such a non-sensical access size to fail.
> >
> > This check used to exist in a more indirect way, but was inadvertendly
> > removed in a833a17a.
> >
> > This omission was found by syzkaller. I have failed to actually create =
a
> > program that triggers the issue (different other protections kick in fo=
r
> > different code paths). The syzkaller program is opaque and I failed to
> > fully decipher it; from what I gather, it declares a map with a huge
> > value type (0x80000001 bytes, which is INT_MAX + 2),
>
> Is that a bloomfilter map?

It is! Did you know that from the 0x1e in the repro C code?

  *(uint32_t*)0x20000640 =3D 0x1e;
  *(uint32_t*)0x20000644 =3D 0;
  *(uint32_t*)0x20000648 =3D 0x80000001;
   ...
  res =3D syscall(__NR_bpf, /*cmd=3D*/0ul, /*arg=3D*/0x20000640ul, /*size=
=3D*/0x48ul);


> Looks like it doesn't have a check for max value_size.
> Pls send a patch to limit it to KMALLOC_MAX_SIZE like
> we do for other maps.
> Hashing over bigger values are pretty hard to do from the bpf side.
>
> > and somehow calls a
> > helper (bpf_map_peek_elem), and manages to pass to it a pointer to the
> > stack while, at the same time, the size of values in this map is being
> > used as the "access size".
> >
> > Fixes: a833a17a ("bpf: Fix verification of indirect var-off stack acces=
s")
>
> The sha is too short. Pls use 12 chars.
> See Documentation/process/submitting-patches.rst.
>
> > Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBY=
yvBSgjN1T31K+gOw@mail.gmail.com/
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0bfc0050db28..2019d6177969 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6701,6 +6701,8 @@ static int check_stack_access_within_bounds(
> >         err =3D check_stack_slot_within_bounds(env, min_off, state, typ=
e);
> >         if (!err && max_off > 0)
> >                 err =3D -EINVAL; /* out of stack access into non-negati=
ve offsets */
> > +       if (!err && access_size < 0)
> > +               err =3D -EINVAL; /* invalid negative access size; integ=
er overflow? */
>
> This feels like a good place for such a check.
> But it's not an overflow.

What do you mean by "it's not an overflow"? If this condition is ever hit a=
gain
after we fix the bloom filter map, it will be likely because of an overflow=
,
won't it?


> In few other places we have the check against
> #define BPF_MAX_VAR_OFF (1 << 29)
> but this path into check_stack_access_within_bounds()
> didn't hit it.
>
> Since map value_size is negative it is causing all sorts of issues
> and probably not only here.
> Once bloomfilter is fixed this check will not be hit anytime soon,
> but let's add it anyway.
> I would return -EFAULT here and add a comment that this is a bug.
> No need for WARN though.

Ack.
Do you think this will require a regression test?  If so, could you please
point me to an example for how a (test_progs ?) test would define a map wit=
h a
large value?


>
> pw-bot: cr

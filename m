Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636E38E111
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268677; cv=pass; b=n3kgO1yB4Pl+hkvueFO1V3582seOTTZnAbVGM28zRM+ND3RrvcC1PM7OD+28tVyY1ztWX55Wx3Uc9FkE8/Ayvdq+rkwNTdbqL7YR37CviuuwlxeDdIYD7nEQyjno8Z4LZM9ghd4zV+UYUDVHYLdlfrioOXo+5tcBMbaxkmxCsxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268677; c=relaxed/simple;
	bh=No+SZ0mPm+dszFojpRK4g9esvb91FrLdwCZRd/DB9q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq1cn3W4J0t/7qwKTMGJ5bWrzyqDa597pj6zkjXK0Y5sjEnXG1rIz5JbPeEV4SkN1Sg6K6E0nMKO/HtdggDVAT8mUC5EktOBGVahia55KumAFucMtJJgahV9YzQjLXn5/mzLnBK1ROoweGccKtgNeFil7HCvpDFZfxwJZxw76aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqlmsg3c; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqlmsg3c"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3599019ae92so235680a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268676; cv=none;
        d=google.com; s=arc-20240605;
        b=FHqtyPUm0oI4V3gwBhNy6ijLLdS/R885tpMtQCzQulb1wEZ1uG1/q8IGdK7RCbRFoQ
         SJonKmMDBN/OeCk3yrcEbOybQzpzQBtN3cfHI5h7EVpnapdzddV3ZKw3wifwhyp499SR
         eomgBvTtJAJghluGZPFctwGiHSPoWl62DNaxMj1a+LwObhrb7OPyrA55bwmGEdXhgfNj
         4ZRHbvWHDAFmnOPSr4D9dC1Gg9QHK79C4F1iQWDSCqnszCj8FW9fgGGqVZpHAowfEOWo
         cGNkA65r4MMzvZOVH/ktRSh2c5TseQqZc+OS+u6z44HOS7TmIKcSynQn+O2Y187ih6bq
         Fg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=S/8EdwKkv6XYHcEBz8MhJ7KmllMildjTJM/EkEorI9dlmAbWXJDsrzx92Y2Qr+A1DI
         jLA5m7AP1/g+fo+9TzCOLeVUPyzx17c2Y1oIH9nW1AbrDKMfl2tHyIqVFGa1TBLKqWdW
         KMZZW1kRTHoOFQhuTjC9syjDcsN1aXsWkDLNh4fZQFG3ya2gNOYCrGMGA/7R8Vtz0wLN
         vecm+/uKLv2DFCaxAsOotbDPpJPFGQ2qQ7QxTtU4lgWKnHGIJpZp1cio2JZERbg6SvFx
         oj4PCq4tRe43/KFJPLa9RQDuHoDRrnA65way2XFwPFfzuEvLAy1fR0vChBBzD4Y+fr+u
         Lt6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268676; x=1773873476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        b=Xqlmsg3c7fxSHhazMEJAH2kBAYO+NowDhVf5CoxKFmeyKTXxy8Rii4HOZOZzFo9Hfs
         fxxchYR983NFMapMk299fFdgfKZW/L57zfYrzVuQXTte1V1310232NlEwbGW44yur64J
         76ILZkVbLUi6pJVFfK2RlMyCoz/tjTwdSETgXjOZekWYBn+2ShrKixJv3rB4R1P657O/
         w2NtmT/abExNnY3WuazkNgkf1fe1L7GzMytKHM8NdcD+zFWg67f78Ot5+kJJQRneF7zz
         q1tT4in4ED8uzGbbMtUqkijDswHDsRdTDl6bH7io2TPpzdgX9J8tMyXxwLVvAxTM5EYj
         L11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268676; x=1773873476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        b=AGC3tz9cvZr0W3Lsvv1ZRj+efB6XmVtr1nSN1UIIu69fwYukdChFQ0ZgvlepxA1AhP
         vJoanuSU4HKcw9cPltGveDPXeGW6o3EmYdN2GgVc7XR7VXTQx5Hik6e3VY03z1FxLVsL
         T5DsOFCIE0l/P9CI4ofC4kQ1NYNyRmTZGMEeLxwsSoy6wwNISn8BKi2aiyayhC8PhYSZ
         qem0vaLJSpm7K+mf2Uezy0M8GksDd4wjC7g1zIRnFcchhVfXpPHDJGerKRcXwapj/Ltt
         WrYCxlXLu0vFrMSM8VuvTmsK+fTxg2Zo+G+A/PhANeWOz3fswjGa/SPteV0UcnXF3bZo
         TH3A==
X-Gm-Message-State: AOJu0YzBn8Yoqf81r9uvftiGjkUsG0kl5GGTLpJ1BzqibSGnAkaCcNru
	Idw+0sXdA+HMnpj90NS+2v04g0APyNlDiVlfHK+Du6rWiSH8kguZNk1db8hJG4mrcT7Oy2fZKgr
	uJ9jk3qcSCrp0S0N98V898IBEBqZsoUPwCiBJ
X-Gm-Gg: ATEYQzz4PPJp7112/qRIh7rle2AN2MSXbcXhdar6TWC/BuVAwfTFA0NuTIVXRcKS/HP
	9Kl5TfALqqx6gffTUjwY4/6ITN7wNKvhsSm/MfNtvKRBM0R32Yt4jF/nuR6HOZ+Nq6pHfhorNpP
	m6NORqrQdew8hqCF/JEOJ4uMH9CRLki3ZtOasHBSqbH6PxnfZFXcdhkL+hadGUI1n2uuvhJOePJ
	rPu/1mT9rHrffwIzWUbK7MjZLpEbCjGxiJVUeKSpHEkrQywn8rcB/D7mebgY4ElIWnfvEixqE4D
	CgfMy2c=
X-Received: by 2002:a17:90b:1a8f:b0:359:7fe6:7e5 with SMTP id
 98e67ed59e1d1-35a0199ca96mr3799571a91.24.1773268675774; Wed, 11 Mar 2026
 15:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com> <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
In-Reply-To: <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 15:37:43 -0700
X-Gm-Features: AaiRm50vJaxcN-kF0b9evke2EZ18SvYUGjpaiaWXV923kNaZt8YtqIpRkaBWFlg
Message-ID: <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > The verifier should decide whether a dynptr argument is read-only
> > > based on if the type is "const struct bpf_dynptr *", not the type of
> > > the register passed to the kfunc. This currently does not cause issue=
s
> > > because existing kfuncs that mutate struct bpf_dynptr are constructor=
s
> > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > > additional check in process_dynptr_func() to make sure the stack slot
> > > does not contain initialized dynptr. Nonetheless, this should still b=
e
> > > fixed to avoid future issues when there is a non-constructor dynptr
> > > kfunc that can mutate dynptr. This is also a small step toward unifyi=
ng
> > > kfunc and helper handling in the verifier, where the first step is to
> > > generate kfunc prototype similar to bpf_func_proto before the main
> > > verification loop.
> > >
> > > We also need to correctly mark some kfunc arguments as "const struct
> > > bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> > > argument and to not break their usage. Adding const qualifier does
> > > not break backward compatibility.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  fs/verity/measure.c                            |  2 +-
> > >  include/linux/bpf.h                            |  8 ++++----
> > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > >  kernel/bpf/verifier.c                          | 18 ++++++++++++++++=
+-
> > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-------=
--
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > index 6a35623ebdf0..3840436e4510 100644
> > > --- a/fs/verity/measure.c
> > > +++ b/fs/verity/measure.c
> > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > >   *
> > >   * Return: 0 on success, a negative value on error.
> > >   */
> > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bp=
f_dynptr *digest_p)
> > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const str=
uct bpf_dynptr *digest_p)
> >
> > but kfunc is writing into digest_p, so that const is wrong?...
> >
> > >  {
> > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_ker=
n *)digest_p;
> > >         const struct inode *inode =3D file_inode(file);
> >
> > [...]
> >
> > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct b=
pf_dynptr *p,
> > >   * Copies data from source dynptr to destination dynptr.
> > >   * Returns 0 on success; negative error, otherwise.
> > >   */
> > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_=
off,
> > > -                               struct bpf_dynptr *src_ptr, u64 src_o=
ff, u64 size)
> > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u6=
4 dst_off,
> >
> > again, dst_ptr clearly is modifiable because we are copying data into i=
t.
> >
> > What am I missing, why is this logically correct?
> >
> > (I understand that from purely C type system POV this is fine, because
> > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> > is a representation of some memory, and if we are modifying this
> > memory, then I think it should be not marked as const)
>
> The patch is just to first make the arg type determination independent
> from bpf_reg_state and make kfunc signature consistent based on what
> commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
>
> Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> flag means the dynptr struct on the stack is immutable. Currently,
> there is no way (and maybe no need?) to specify read-only dynptr.
>

are you basically trying to determine if CONST_DYNPTR_PTR is allowed or not=
?

> > > The verifier should decide whether a dynptr argument is read-only

can you please remind us what "read-only dynptr argument" means for verifie=
r?

> >
> > > +                               const struct bpf_dynptr *src_ptr, u64=
 src_off, u64 size)
> > >  {
> > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst=
_ptr;
> > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src=
_ptr;
> >
> > [...]

Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF658405AA2
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540610; cv=pass; b=ZCzxrJUxMp7b50Zw+YmGSlkYlF9apGH18vFi4v3tnYZuYjzrDOoMfBU9QKrEcr/ocvSvGa3no67z/T4drBrsWnZoK/1aVBLDw3EyrnrpJ+3NWcmmCf0+xCNLgv+VKdtj4FcLbf2ypjKbD84sOOJwv7rMo5BpKDITzR8RYnRKPkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540610; c=relaxed/simple;
	bh=P+1TFgcm8u6LvnWwQZL0iG9ymsVorf/E55NWzFlf/Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN+FLNZ8FW88vBocibJANJpCf+dUYNh//P3kBUFcH7LFlC3HZYFNQB+ZnGfKFiWJj8Ax/n8Jitve0aAXCQBc+0WHBZCILvdrmOOcoF0dePw8+fVy7ZOsrnxOK5We5/DUl4UvBu8jUIF5Pee4uLML2O15cyr5z+k3XczyFBJyIMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuQUb4h3; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuQUb4h3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a535e7c00so12099357b3.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774540605; cv=none;
        d=google.com; s=arc-20240605;
        b=EJPp1Cf8WsDNz1+Rd5vw8+NNiF0Nu8ACaeK4F1kbig+6N//GxQN0jsGb9dOrwgxE4G
         gxlpfll+7aNzer5nad+tn4dSLGrPDrIjPnhDBgtt2pw279k9MTX2wvvQzIZ22IwmacRf
         VqYtQFakFnmpC5foTsVr6ndWpZaVtVYMEhKpb5jLgjF4VjWlAfWuxRezlGrr5rSSMaZh
         swR566FnhmBh7vLjzEn1jdTW9dN4slFQRG2CixM5aopE/vpZE9VOFfpKMlQiEAUDBaX4
         MGxfIFO5fRD9oRMq7lz04pfGzbc5VSJbJ1tpu/AjdPI15wTHVvAG68cYHBWgMjRk4vQ/
         IMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iDBJ7sCgWzMhFqtmYLgGxuVtDEt5mT2n6dUSB1UNQyg=;
        fh=IhjkrtoTOZvYY1xPm9z5IEwH00wCCn41nAjOgwWQPHo=;
        b=EMcdU4zdDDIER6FoekOL/dw/7g8cQzNKbJC6VD9VEuWnwc6K+bLI7PoeGItVe0iSD0
         y8G/JXlkGcDA1RNqa/dZwevhnzp0OmvOaxlwqqDcoPIlICCg7dmdSNR5wO43gFzY6zvR
         utShYkx3q5TP215PyIc4Vgg4j/a+bux9wWgYdkLrBUilck69xHKlxip2xlOk6vR5aAag
         F/WT3qR10XCmlwKSsgdK8RiypQcGDsTdJL/0QgIL/RvyLtDlGr3nZJ0LoLfeJ1WlOlhF
         Nl9bX1d+OiI62zZFrGhzhqM2eAiibSq1hvot49KPVhp3WoHyEWPUtTRhNNe/EUzLwx4T
         Xg/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774540605; x=1775145405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDBJ7sCgWzMhFqtmYLgGxuVtDEt5mT2n6dUSB1UNQyg=;
        b=HuQUb4h31HPiw5iN+j9gfj1YTjEkiCuBLQbzmzAE/Nw0eQnuLb6fcdwRd+g7M3z/XW
         93h2alwAWxLvwBxN/Jkig+GSeDmMbwmbL7UflLyV99l+ksFMnXRxKPwY08Nm+ft/Jowd
         4rudsCFo7woOAKfNW8UMocJLlBwxwy4xC4SFMP/fSeI7InAVptnzrptyPRJJaIVuVgrY
         0CERYjZunKjF3aKxPAHrBs9U8p+BrgmgQXG65/gYU3zOrfw2sAuZ8mVjKf+JFFQKhKIU
         4rjDreQgEYmafAIWlA53mpKmsJAbbtXobhzHcz69ohbJQysS4YrmiFGOkcO3U4ueP8KX
         CC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540605; x=1775145405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDBJ7sCgWzMhFqtmYLgGxuVtDEt5mT2n6dUSB1UNQyg=;
        b=frQVFp5ekh5PI6rqDkAD8T64kpnn/tmkdkEUxm2w2UdnM3PpNChTeYGSCkpV7YAabr
         VTiY/gj2kuR1G4bzj33xwPwfruWF25JHIyLpioiEXBVrAeZokr51bFepEDuQ4XU7IqOA
         Sn4EIo3dYO2BfnxudneWFQ9ckSnjOU0yotvdgacHfNlBUaPZc+3TzF3syFVjOokFPKDC
         +bKhqVco8DGs76YHePsCNi5LD6Y7o2WfvFuAweToPnoEqIs9+N8Sym/B45mbZvK0sTgi
         JmUz716FX4K6LU8CV32/h6m4qh+jBM47QsYgBv7fTbqrPN9YuXAems8E/5YJbjPgfXu6
         RX+Q==
X-Gm-Message-State: AOJu0YzHVozQEc5melZmoLnKc0+wYlo4yRny9hmzVk/voraFMM8ylVuh
	k9Wy5ixuPYYczBL8d7+PYgzNJ36jhhpyqmMxP6K8zq/3dAWzVEU5AgCv1Chk0KHrMQWTCqD3WD8
	PZ2GxgzBl8vQQpWawj+OmTsMWKxez+cY=
X-Gm-Gg: ATEYQzz1Kxv/NdENOWRT6nk5FWikGo6xPrsYGk+hLRDdr2HeSN5+BD1/L8sxjiHQ9uR
	RcTnNaPXYxiFwczhReVo+FbNsf8Wk1EVpz12kOeZMfc3pPmmOl8D67FVkWf7t5VEtBPw+Dlb6dZ
	mhBk24pjgDicNjzg/8jdBWH+uh3EJfqC0vlwCcVh8t4EYEMZLd9d4d9clC+CWfrsQRQZWJBFz0N
	/gz6mz+ShMJ9n/m+3zTNKrbN11LJsmMGL2+FssMFzbMhQWysIM1hO/dgwMW+r7sYTM8kCq8uuSC
	bgASa4s=
X-Received: by 2002:a05:690c:39b:b0:79a:702b:4ecc with SMTP id
 00721157ae682-79acf6f60f2mr80089467b3.55.1774540605288; Thu, 26 Mar 2026
 08:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326052437.590158-1-ameryhung@gmail.com> <20260326052437.590158-2-ameryhung@gmail.com>
 <CABFUUZGnj6jOifYknYahrEJjzx9inbT7nz=OGmdr_MfUEW-HHQ@mail.gmail.com>
In-Reply-To: <CABFUUZGnj6jOifYknYahrEJjzx9inbT7nz=OGmdr_MfUEW-HHQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 26 Mar 2026 08:56:34 -0700
X-Gm-Features: AQROBzDtIYmp0rrHK8XB2SHXulgauxtbxiWVPjTI5o7pFpikeoruH-foLbeKnxE
Message-ID: <CAMB2axOZniWCCXjjCDGNXJK7k9=evFkCsxQdmH5vCLRu5oYTkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Fix task_local_data data
 allocation size
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:27=E2=80=AFAM sun jian <sun.jian.kdev@gmail.com> =
wrote:
>
> On Thu, Mar 26, 2026 at 1:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Currently, when allocating memory for data, size of tld_data_u->start
> > is not taken into account. This may cause OOB access. Fixed it by addin=
g
> > the non-flexible array part of tld_datg_u.
> nit: seems to be a typo of tld_data_u?

Ah yes

> >
> > Besides, explicitly align tld_data_u->data to 8 bytes in case some
> > fields are added before data in the future. It could break the
> > assumption that every data field is 8 byte aligned and
> > sizeof(tld_data_u) will no longer be equal to
> > offsetof(struct tld_data_u, data), which we use interchangeably.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b=
/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > index 7819f318b2fb..a52d8b549425 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > @@ -90,7 +90,7 @@ typedef struct {
> >
> >  struct tld_metadata {
> >         char name[TLD_NAME_LEN];
> > -       _Atomic __u16 size;
> > +       _Atomic __u16 size; /* size of tld_data_u->data */
> >  };
> >
> >  struct tld_meta_u {
> > @@ -101,7 +101,7 @@ struct tld_meta_u {
> >
> >  struct tld_data_u {
> >         __u64 start; /* offset of tld_data_u->data in a page */
> > -       char data[];
> > +       char data[] __attribute__((aligned(8)));
> >  };
> >
> >  struct tld_map_value {
> > @@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
> >         struct tld_data_u *data;
> >         void *data_alloc =3D NULL;
> >         int err, tid_fd =3D -1;
> > +       size_t size;
> >
> >         tid_fd =3D syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
> >         if (tid_fd < 0) {
> > @@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
> >          * tld_meta_p->size =3D TLD_DYN_DATA_SIZE +
> >          *          total size of TLDs defined via TLD_DEFINE_KEY()
> >          */
> > -       data_alloc =3D (use_aligned_alloc || tld_meta_p->size * 2 >=3D =
TLD_PAGE_SIZE) ?
> > -               aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
> > -               malloc(tld_meta_p->size * 2);
> > +       size =3D tld_meta_p->size + sizeof(struct tld_data_u);
> > +       data_alloc =3D (use_aligned_alloc || size * 2 >=3D TLD_PAGE_SIZ=
E) ?
> > +               aligned_alloc(TLD_PAGE_SIZE, size) :
> with `start` now included, `size` seems even less likely to be a multiple=
 of
> TLD_PAGE_SIZE. Could aligned_alloc() fail here?

Hi, Thanks for taking a look.

This indeed could be a problem. Passing size not being an integral
multiple of alignment can be undefined behavior for some memory
allocators. This is okay for TLD_DATA_USE_ALIGNED_ALLOC as it should
only be enabled when users know the memory allocator supports it.
However, aligned_alloc() is always used when size * 2 > TLD_PAGE_SIZE,
which may lead to UB.

This issue is addressed in patch 2 when the allocation path is cleaned up.

> > +               malloc(size * 2);
> >         if (!data_alloc) {
> >                 err =3D -ENOMEM;
> >                 goto out;
> > --
> > 2.52.0
> >
> >

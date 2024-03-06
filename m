Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1DD518
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691863; cv=none; b=pGxc8XSQzU/Ys8I3RTPE52F2B1BTN8XlgrdtxDIsKIQYEVEjtQlM3UTuQOLN8l9KFJAFIcKo2uofrfy48SwbVEd0RL6Pnatow6jWL+Gz2k0MNAiJf9O9nmAs+GN+H2qYYkKC/waL7iwAYIS2HOShhhiQS/miy0CXOw3Ho37XUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691863; c=relaxed/simple;
	bh=hPSS03sUgc3ZDkbvvRyvLflFaFOPzI0ApfG8dNPsRtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxBRWJM0cllOXsFrU9gR5owUHzpLl4UKeq1oG8L90NUdO5t/+fgrdSIgXT2jVB9jD6Yc0IHhCd2KNkc666g1CXUD9mCkvOEx7aNWRdV7oSSDU54KFj2Q376sezZG4CbDgolZXHJQ95k1pV9JHtPIU5ePYsewCwQJpmTVMHWt0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuH1zU6i; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuH1zU6i"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69096fe743dso70006d6.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709691861; x=1710296661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX3ov+3vWHsjJgdlTx/huzIYZr+Q9BQemmQ2NzRN67A=;
        b=LuH1zU6iSzpIUuNinBCpkMdehUXrP43iz8SwE9Fq7BUApqF/oCYhYYgR9i/RlaxQHu
         7US/k1ojaRmvD0jZSuEqZ2Wtw0OoTqGSBcOUpv2ZmB4ox9oRNmZNf+gKAeAJpWr8gPyH
         +xEIwel0CJ1BAQLwiQ/whc0CmMqx2ue6H+Y+NtT5W7zAZBKa5ALdVU0R6T7pSvAIPY8g
         PhRysTNXCvAY6kLAJllSBPsrPD7Ah9V39gUJrRplWYLCNbqZWJHHatss/4yLVPvFGlC7
         rmjADxCYVJKMJqCHeTiheg5HsnQbdzpXk0N3wlBO72+eXVD7zBVKvxC5T+nQqnBw5MrB
         9c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709691861; x=1710296661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uX3ov+3vWHsjJgdlTx/huzIYZr+Q9BQemmQ2NzRN67A=;
        b=xL73pfXARyWItg+nGt/sp4+b+d32KxwDY3S9ssuqgdNLgedXK88weQH9rMiqB8oB6t
         lCNPXLctZm2/JtlMoBZ5os8eWT9AufkfV/P14ajoM003KXd0YDwP13h6oDyRkrvyOdM5
         N4tTzBi6EwEh1bFNelHCSklhfAe3FhGQCS7UJC6jsKnYp6WnXPG1C10l4xkD6tose1EF
         8CySSbzFy+aiD8keHQOymFIy1nHY2FFR8csHWi9VDz9GRnWMYKkDv5Lb62GYApY+Ojh2
         tTmv/AJcvWap7od4xlibjIq9EI0sXfXAJfcWH1T/Nh6C9p3pJLdJC0Vp+997WQkDtx9L
         i2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWode+mrW22JnN8H3S03Qz+Glb6DWmQdfTQA98xVRjnuXhtJneGocJoGK7ESiSugLpd0EHM52wDfXKckLxpExblRl4S
X-Gm-Message-State: AOJu0Ywg+4BODKZ4S1dViJ+I63Mnpepg3ckHktJDZOHOThmbpxK6+Jwg
	3LAs/bnh9t+C0vHmnPRL8h8dxgF06H7kARqdRwZaelbrMVsawBGcBqmAzgkcoGnUeKIv72DlcSt
	03JSq4drmk66qA05Larw2iL3fnW4=
X-Google-Smtp-Source: AGHT+IEElixLgD17+Dm6GWK/7mXveOsowgJPbgxynCWRSIC4yyUde0aE4hWuOTOunD/GLRg/dY85k29j7la4GJNueLs=
X-Received: by 2002:a0c:f2ce:0:b0:690:4724:777c with SMTP id
 c14-20020a0cf2ce000000b006904724777cmr4024960qvm.35.1709691860823; Tue, 05
 Mar 2024 18:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305064353.69734-1-laoar.shao@gmail.com> <CAEf4BzZ93VRvb9Js8gMDaGOe_vZcFmQBChEd42S=9T0D++FBeA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ93VRvb9Js8gMDaGOe_vZcFmQBChEd42S=9T0D++FBeA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Mar 2024 10:23:44 +0800
Message-ID: <CALOAHbDgXJXAHttJ6rrWqTTpuCzeVdbM_u_m-QOVk151CCzfLw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Add bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add three new kfuncs for the bits iterator:
> > - bpf_iter_bits_new
> >   Initialize a new bits iterator for a given memory area. Due to the
> >   limitation of bpf memalloc, the max number of bits that can be iterat=
ed
> >   over is limited to (4096 * 8).
> > - bpf_iter_bits_next
> >   Get the next bit in a bpf_iter_bits
> > - bpf_iter_bits_destroy
> >   Destroy a bpf_iter_bits
> >
> > The bits iterator facilitates the iteration of the bits of a memory are=
a,
> > such as cpumask. It can be used in any context and on any address.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 117 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index a89587859571..a769561b65ae 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2545,6 +2545,120 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >         WARN(1, "A call to BPF exception callback should never return\n=
");
> >  }
> >
> > +struct bpf_iter_bits {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_bits_kern {
> > +       union {
> > +               unsigned long *bits;
> > +               unsigned long bits_copy;
> > +       };
> > +       u32 nr_bits;
> > +       int bit;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_bits_new() - Initialize a new bits iterator for a given me=
mory area
> > + * @it: The new bpf_iter_bits to be created
> > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated=
 over
> > + * @nr_bits: The number of bits to be iterated over. Due to the limita=
tion of
> > + * memalloc, it can't greater than (4096 * 8).
> > + *
> > + * This function initializes a new bpf_iter_bits structure for iterati=
ng over
> > + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bi=
ts. It
> > + * copy the data of the memory area to the newly created bpf_iter_bits=
 @it for
> > + * subsequent iteration operations.
> > + *
> > + * On success, 0 is returned. On failure, ERR is returned.
> > + */
> > +__bpf_kfunc int
> > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ig=
n, u32 nr_bits)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > +       int err;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(stru=
ct bpf_iter_bits));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > +                    __alignof__(struct bpf_iter_bits));
> > +
> > +       if (!unsafe_ptr__ign || !nr_bits) {
> > +               kit->bits =3D NULL;
> > +               return -EINVAL;
> > +       }
> > +
> > +       kit->nr_bits =3D 0;
> > +       /* Optimization for u64/u32 mask */
> > +       if (nr_bits <=3D 64) {
> > +               err =3D bpf_probe_read_kernel_common(&kit->bits_copy, s=
ize, unsafe_ptr__ign);
>
> it probably would be better to zero-initialize kit->bits_copy?

will do it.

> but also, please check that this works on big-endian right

will check.

>
> > +               if (unlikely(err))
> > +                       return -EFAULT;
> > +
> > +               kit->nr_bits =3D nr_bits;
> > +               kit->bit =3D -1;
> > +               return 0;
> > +       }
> > +
> > +       /* Fallback to memalloc */
> > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > +       if (!kit->bits)
> > +               return -ENOMEM;
> > +
> > +       err =3D bpf_probe_read_kernel_common(kit->bits, size, unsafe_pt=
r__ign);
> > +       if (err) {
> > +               bpf_mem_free(&bpf_global_ma, kit->bits);
> > +               return err;
> > +       }
> > +
> > +       kit->nr_bits =3D nr_bits;
> > +       kit->bit =3D -1;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> > + * @it: The bpf_iter_bits to be checked
> > + *
> > + * This function returns a pointer to a number representing the value =
of the
> > + * next bit in the bits.
> > + *
> > + * If there are no further bit available, it returns NULL.
> > + */
> > +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +       u32 nr_bits =3D kit->nr_bits;
> > +       const unsigned long *bits;
> > +       int bit;
> > +
> > +       if (nr_bits =3D=3D 0)
> > +               return NULL;
> > +
> > +       bits =3D nr_bits <=3D 64 ? &kit->bits_copy : kit->bits;
> > +       bit =3D find_next_bit(bits, kit->nr_bits, kit->bit + 1);
> > +       if (bit >=3D kit->nr_bits)
>
> zero out nr_bits so subsequent next() calls keep returning NULL
> (sticky iterator behavior)

Good suggestion.  will change it.

--=20
Regards
Yafang

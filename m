Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5739B483
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506349; cv=pass; b=VYcZ1FuLQyc/DgDl0bL+qtHuIY7hj5lYcwAnhUKuxMXzcnSad1vNUVJLByME6DJ8NHuvlhBo2Ow+XgdliTTwwCAbxDeO+ml2ZZBmVFXJGUFo7hb5p1YGZhrxLhLxH6XUYTTvaQIxjro5VzLLH+0rAx4LjpGfUWFG2FRnAlaQRyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506349; c=relaxed/simple;
	bh=s6aJdA58IGADa1+v1zsb7cJg0N/wgNuxNFFyBe9eVf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfLXSpGaE2Tr3o0aQ+KNRTK3U+nKxUM8x2Z+jYskoJ0sj0yl5VnPNDz3DS20vuG0P41bEmKMx6k3evHl/FLDo6tor38ZS9dVROhm22aV5gEBBwLoy66V3Vr3wUCBS3/QPnZuMy7A06SCssNgKqg1DseFxE6nZUIL7xsi3WsIaEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3Er1+Fo; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3Er1+Fo"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488a29e6110so22701155e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 13:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775506345; cv=none;
        d=google.com; s=arc-20240605;
        b=WsWoz/zAKNAkbUmne6So+pDLAFzzhyba08zmRHxPdCckQT0aQwzyD2l8tMaacVTQEX
         5BUkYNRQpjRU7k5t+GAEOyz+TPjF6boYYJKYoh2/km/wKf/4tFNbvf8yTZT+ReRZVOUQ
         0z3xxa0mgjrKICBGxHsxEOL2WF1tXPw+Q7c18hCwrsNmE/FWr+l9oDwCaaeURAsAnpDD
         FFe//2Rw9HRnSrtUNf8nN+hGhXBTRofBE0cqcLj6kWnEuXQY4kq5e6iE13SRXLYqSsvV
         Ho7ffPie0neHDH0fxr5NvxkdvsBDkWtXIh6zHFRY4r2dDhmd8lhHLgNnmEu6w1pQrLVS
         4iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        fh=AZCIP8LJhMJDbdcchN0KUQDG2Z3tiZxaNIxutZo11x8=;
        b=jMz7vghRKGQfuITH4UeIni55oV+OHl4iwI3v5K8PtseTrvLBjY1sYzVNK1olDqHyon
         OLMhEPgT6Vmr7PLLtCGq0Gw5tIc3icrRwoLdnfVs32XwDFip9j2dQMMYZ5r09C4x3t+V
         Oc5hpL+fNzEc3LBtZ77dzqYjsIc5UDZjRSjj0wqp3jEX7CMOSIFyNaYKUI8eNuHuBiE4
         Nxu0EpDAjXIFMPbLDrE/fy9CXem0uy+qZP3JjaGEk6UxElx3DnrxddMZz16M0+epT3PD
         eFOBqluGDN3fls4hoDzMpxZ/hLsRsgz3WPnA+QUIZyb53y95ghLLb50/Tf7L3TZQMI2N
         8NXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506345; x=1776111145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        b=Q3Er1+Foj2JI++IytQF+1vu2hw0uEAYNR6gyM1YtgJ+qMUcsBRPCtUDmEc9HCS9Bnw
         lzIzjVUxyyIKn2Zv4bpXyXCJ55gCE2mFg00JvxisKQ1H3JJNS57YKA9L3HVgrK7SvioU
         tjVaS8jX73mVBQu64uFhWaatYGVRXXFfNs+famwofGp3ZVq4CnjZdl9o7LHwIRM7U97N
         d6axOoFkiwe+77RaL424r4vv7m3xadw5EBSiHPq9q1A9aMh5yRgTnGPs9rDlwY3v+qTu
         1pjqHdQ7eOVSYp27GTV7Ei47m+Jc6oVe4Tru6VW6LhUJcrk7FMtdonevgEscoJRi36J5
         5ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506345; x=1776111145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        b=rW1V6QZN9PMAJV/wMuMioC6krWvqYUkap5fXygbs07iRti7JZ+BGHnVEAMn8rBDENS
         LHhJNq6DJS8da0To4eXbWrz/cvLKOJA+A0a1v4O6BN9CWPYoRYLeLc0P0grFwsRFc+8f
         pEklZV4Pm+HnSlLVgtXyM1XCwhK5XSjDI7vm45r5CKKkL4C5+6Dq17cg1uyDVq7Vdf26
         ZPH39Hw2n5O7V52Koroa34r/y0MJs0qFFLjPGTdc7XfIZKgnsi2/9DD61nU15yRr4/Yd
         PoqHB0YaL9B7FBBKH1yKkK6qYejs9MNPWTUuMDCGTrZ00mkPhyZPfj3QEbAaPv8HPVsi
         KTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkAZr0xyj+Npe6UJJb4TKrxoLQHKx9jRebmtZsGZenlz+J59r1a8ZePz0r4Iud7ldtz3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwlr5cwF24SDBk7OmYOutzojmMCnJ0Ldl5RTwgR+D7vvsrSkVW
	vZMyC0C0n5nH/gP8iSvIOGGvsGlMD/8+aS0rC7aESw8qIvmpu37h9/wdYGw8xWrzqCASmarTjW4
	Gxu8SibvTPO9ynxajZIL+FDPEkY4+glM=
X-Gm-Gg: AeBDieuW0g9QReGz6Phn+CUnqWaPnEqHn0VkkSE0imwtl+vR7g9NBM/Rh8lZgGhWzgT
	7zi7VyKn1Dj6uZ2MhvoulvD9192cpGfFUhwZ/NwnIL0/KGGY1fhBtRVbGSE+ZqDaH0WtBC98Ckv
	fWuDHP9dHDHY2yvUQY8O8Pig+4i8uq0LnXQVvYvYgG9TwV93Giu8M6FMOJFYxsJbmmPi1dIB9go
	I+g/4bYnrESQI7+Eo2e5WwSY+Hqw0noelt8gRoBDUwuAAsfrrTJHzBbI8g0csolcED5tEnLlkHW
	Aqm3A3nY7FgZ+IxkkJwXSIJlSI0ogS9VLPwKGP0+DVi5Kqkb4r/iFanykXCEGdrr4vcz8S7V
X-Received: by 2002:a5d:5d0f:0:b0:43c:fd92:f432 with SMTP id
 ffacd0b85a97d-43d2926a133mr20381542f8f.2.1775506344767; Mon, 06 Apr 2026
 13:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com>
 <20260401191126.440683-2-varunrmallya@gmail.com> <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
 <ac47BIEUBBkTch31@krava>
In-Reply-To: <ac47BIEUBBkTch31@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 6 Apr 2026 22:11:48 +0200
X-Gm-Features: AQROBzAzS2x1pnm8GQsphNrgAlMcDdJKIJ2GsYVUVKDUIlO7GIewSXGeCtDX7ec
Message-ID: <CAP01T75W-idA_7y6HYaaUW17oQ=o08+2gM5dnLBdH+2D0aRdBw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi
 is not sleepable
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 11:46, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 12:50:10AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
> > >
> > > Add a selftest to ensure that kprobe_multi programs cannot be attached
> > > using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> > > rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
> > >
> > > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > > ---
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > >  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
> > >  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
> > >  2 files changed, 54 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > index 78c974d4ea33..f02fec2b6fda 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > @@ -10,6 +10,7 @@
> > >  #include "kprobe_multi_session_cookie.skel.h"
> > >  #include "kprobe_multi_verifier.skel.h"
> > >  #include "kprobe_write_ctx.skel.h"
> > > +#include "kprobe_multi_sleepable.skel.h"
> > >  #include "bpf/libbpf_internal.h"
> > >  #include "bpf/hashmap.h"
> > >
> > > @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
> > >  }
> > >  #endif
> > >
> > > +static void test_attach_multi_sleepable(void)
> > > +{
> > > +       struct kprobe_multi_sleepable *skel;
> > > +       int err;
> > > +
> > > +       skel = kprobe_multi_sleepable__open();
> > > +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> > > +               return;
> > > +
> > > +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> > > +                                    BPF_F_SLEEPABLE);
> > > +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> > > +               goto cleanup;
> > > +
> > > +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> > > +       err = kprobe_multi_sleepable__load(skel);
> > > +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> > > +               goto cleanup;
> > > +
> > > +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> > > +        * Also chosen a stable symbol to send into opts
> > > +        */
> > > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > > +       const char *sym = "vfs_read";
> > > +
> > > +       opts.syms = &sym;
> > > +       opts.cnt = 1;
> > > +
> > > +       skel->links.handle_kprobe_multi_sleepable =
> > > +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> > > +                                                     NULL, &opts);
> > > +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> > > +                      "bpf_program__attach_kprobe_multi_opts");
> >
> > Nit: While vfs_read will likely remain stable, the check could
> > probably be stronger to distinguish an attach error from -EINVAL?
> > I added a typo to vfs_read and it still passed, because it failed to
> > attach instead of getting rejected on unfixed kernel.
> > May not be a big deal since vfs_read is unlikely to break.
> > I verified it works by adding bpf_copy_from_user to the program and
> > attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
> > LGTM otherwise.
>
> why not use bpf_fentry_test2 ? you could also put it in pattern argument
> and bypass opts completely (up to you)
>
> also there's test_attach_api_fails test, please move it over there
>

Varun, the selftest is still not applied, only the fix. Please follow
up and target bpf-next tree this time.
Thanks.

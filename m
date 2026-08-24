Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4538D3F0
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601881; cv=pass; b=jpExz7caCmG8ulXcSazbLo6Ur/j47IDVp7OXBfEZxzjlzDrhpAGn83TDP+YaRqYzZCnI7Kshaumj5iIO1rxddz1ZlmF2aMOPrOlibdIv7aAKo7ow//kfrjIiv8TXhA70SXSNHcB/+KJr6S0RbJUuLENJmr0tzBBJgRyUcpsJ9s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601881; c=relaxed/simple;
	bh=ztc7AZVbqLvil6lnkmXQ02g+FumferD9nAfzbJDieJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCbUchFHH4puGTVyJyQA/1HklXEBUKGsylPqtBpvi4n5vT5Pf2n9CwNwNv4Cu2duK4EAIZ1D0BXIB+5FV8az/tUHYbR7+BKEFwrHSqxJer1MeRfxcBBY02zXnUL2WLUV6n+huX6813u9GeqaoHtfb+BMT+SJWth35myFlC8T6wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5wAx0J6; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5wAx0J6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e04df8c46so5237091b3a.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601879; cv=none;
        d=google.com; s=arc-20260327;
        b=dzjZJVQEmp12xXq8FB37hC6H+DaotCxNx64Hol2SBMI8zBK61UlIEebSWyucwJjyzH
         f/eOjld843wi8YU6cW0MgoatlcKSXWAU0HvNAqfNGEsepy/ZzEe+JtF0XXNWReG2Km7Q
         7Dn9V2b1AGx/4i4ByvRWSAw6x0yJlV9A7aPn54n5zFKO5QFWhLZ1W2TjBML8iAscsF2+
         gyLVzYEnqnljagd3MziXiAdhfPHtsew8KkLTvhe8jhMiidtE80yds175LTXqvK2vlBQA
         7S+64E77pPE5zPoNVH4aroAee2XvrY600GtRZlGglTtDReascnCEHb21/D2sHSjbzRn9
         0/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGyM7k/N8T57GToXJh7KwKOn+OZJUTS8V18VDRU/6iw=;
        fh=bFvLb6mLmiYzXav+3vY9Z7M98KJvQHG9XbtXqyK4KAA=;
        b=nVXEwpsc0XZ4z/En49PT9BdV9zSwVQmjFI4MZF1kW7wZQxrPzWn/NKpxB90R7mYe3K
         mk0aVITlMeC2pV24igiPFMflG8SHyVQNPkzcBuCvNBGSFtERAKnopeJHEua5Vhz9yMhk
         vF3s2yyXdTgkmpKjTDwOvgDFXFP+KmuziZiUZVj9ppQXAP/2jQTXyVg3vcVq/fQ+Y/Da
         x5hdA/wi9U6wIuMuttXtSJ8D3MHMz0KwLfia/hONt0BFW/Vkx2ZqEgt5C6N5jb5teJEJ
         sKOMYj5FxpuwZby7cBgfrUbcuYALqAfbMzEyxCdGGNcSFAPzq+4fkZozDJXTLCm+Csl4
         cJHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601879; x=1788206679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGyM7k/N8T57GToXJh7KwKOn+OZJUTS8V18VDRU/6iw=;
        b=K5wAx0J6UuK2PzaQ45AB8OghiCjAA48kc20vILrEyxz7AQ7zXpJdajQ140kxh4r9W7
         vWBSR+jYsgV39MxZVEGAJ6gf+70/5eNjhPGW++ZrIebSCyA5ljYdT8cNH4uk45pZh1a6
         lUhe+TstSMXImzqtgnfmuGf60t3oWBCqoi7yNMgFjb6feHfkjJGR7a5g/GZsTGE565We
         rtaiDo9BTl7fqymwDurS7OZDAY7V1Dwu49eFkGgqsLk8jjcP7GD20uoWLyr9ljdDoL3H
         ZK8YlO0MXScJkb+MB5cGipFEt9XM4cjFc73Mo19j/WDBkrj1MyGHXpCzIKz+eRVQppq9
         sGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601879; x=1788206679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGyM7k/N8T57GToXJh7KwKOn+OZJUTS8V18VDRU/6iw=;
        b=CIvgeERL/61B/Qq/ntJ4t2URsrf1Hzcgy7n7j+LDHlCeHbG8Iy7rAluIyd5/eBD/Vh
         U/phj98jnzMCUPj0Ddn39Was6Eu80+eVTuUtntyBG5xFMh7D69r8GIXfR+u9RCUsMBLc
         WQ+bHrwJ7mysfDUuVHImf/bMfPZArH1Z/XeYAy74j4SDCjPVAdRRa+DIqSZhgP0spwmn
         KhA4fYh74mTT436cflqL+CGavc+mLMvMv+iW/8kl5On8Xik4ZptpRSXFgIBM3W7My4Z2
         AYMJaHkhQyl+QqFrZC8wLx9YsazLEQ5XCaQMqObk9TkJ83mwUT92uhYfsGtYp25GYsHF
         hSQA==
X-Forwarded-Encrypted: i=1; AHgh+RqIxnJB5kc8s/9GPqg3T+jeKzFOR5VlpQ6cpwamWWdMGSXgDJeuwXrXRV97bMYhAQREqmE=@vger.kernel.org
X-Gm-Message-State: AFuF++nb3wejq3l28Vvq89TcWbS1AT2Up8u6Vzpj/lAKPbMvS2gtoyUm
	Jg1rTtvBNOSqvbOdPesbErMFMpB+nX5xf52Q8OJTP1QRpBZhXmA+eJh4cQ3lrclyLKVleGuzIiu
	4mLvoRSUdkgOF1vk9wPUAgTD1ziNSq8E=
X-Gm-Gg: AR+sD12i3jOMomC8yHdDgIrzMGaRmgsWhT5xQ9GAkJewo/vNGcod7Q9QCHM4dwBvUNk
	9R9FfpOJYGRkf/BQGngBVEDXLOsNKMuvUagO8Ps2zriRqyKUOA+llcNcHzewldPSFUPtut9BV3E
	VwtAJUWCmTG6R2iDal4WCVX4Bq5XbQfDPwJAKfqUOCWCymmLEomCLV0EK5iI7tH63khe8HXDrxJ
	vGV3EbsSVda+n+CwPdAVlxp9xgxXGCPJvAWDhqUwr06SmAtbdHeEZbQRPEwOabHazzpluN86gEM
	GcR272AGX5QTh0PtUvbGYFZbk4YXiCaGIQ9PQfWGjeR5vtsUUqZ7pdM/L+XeEfy0XLtp8mka4y2
	E4bUAQO+oVcqLlX7Cw0ZVZB9iPLivyuMRwK0rXwiDVA==
X-Received: by 2002:a05:6a20:be8f:b0:3b3:216b:2743 with SMTP id
 adf61e73a8af0-3cd9103c931mr2714237637.4.1787601878895; Mon, 24 Aug 2026
 13:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818153202.90714-1-leon.hwang@linux.dev> <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
 <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev> <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
 <90bbc900-21cd-4dfb-a058-13930378052f@linux.dev>
In-Reply-To: <90bbc900-21cd-4dfb-a058-13930378052f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 13:04:23 -0700
X-Gm-Features: AcwNN1W8by1xeiM2nS0uP-BSqlnh6x8cTG7aWUTePlGmeIOdHofEa_QByHGxHoA
Message-ID: <CAEf4BzZY-C3WtoRkdi+U7XFAMv59JeJ2R0yMi8+FGM4sLTsnQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:02=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 22/8/26 01:58, Andrii Nakryiko wrote:
> > On Tue, Aug 18, 2026 at 6:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> On 19/8/26 00:15, bot+bpf-ci@kernel.org wrote:
> >>>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init=
.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >>>> index 5671c31085cd..2b69290bcc3e 100644
> >>>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >>>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >>>
> >>> [ ... ]
> >>>
> >>>> @@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
> >>>>      test_global_percpu_data_lskel__destroy(lskel);
> >>>>  }
> >>>>
> >>>> +#define PAGE_SIZE 4096
> >>>> +
> >>>> +static void test_global_percpu_data_map_resize(void)
> >>>> +{
> >>>> +    const __u32 desired_sz =3D sysconf(_SC_PAGE_SIZE) * 2;
> >>>> +    struct test_global_percpu_data *skel;
> >>>> +    const int arr_value =3D -1;
> >>>> +    struct bpf_map *map;
> >>>> +    int err, prog_fd;
> >>>> +    size_t data_sz;
> >>>> +
> >>>> +    if (sysconf(_SC_PAGE_SIZE) !=3D PAGE_SIZE) {
> >>>> +            test__skip();
> >>>> +            return;
> >>>> +    }
> >>>> +
> >>>> +    skel =3D test_global_percpu_data__open();
> >>>> +    if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> >>>> +            return;
> >>>> +
> >>>> +    map =3D skel->maps.percpu_arr;
> >>>> +    skel->percpu_arr->arr[0] =3D arr_value;
> >>>> +    err =3D bpf_map__set_value_size(map, desired_sz);
> >>>
> >>> This isn't a bug, but since the guard above already pins the page siz=
e to
> >>> 4096, would `const __u32 desired_sz =3D PAGE_SIZE * 2;` read more dir=
ectly
> >>
> >> Will change to 'PAGE_SIZE * 2' if the next revision is needed.
> >>
> >>> here - and is the unguarded `#define PAGE_SIZE 4096` preferable to th=
e
> >>> `#ifndef PAGE_SIZE` form used in sockopt.c?
> >>
> >> No. PAGE_SIZE must be 4096 here.
> >>
> >
> > can you please elaborate why do we care about specific PAGE_SIZE
> > value? it's a bit weird to guard test based on page size...
> >
> It is to verify the mmap change in libbpf's bpf_map_mmap_resize() for
> percpu data map, like those subtests in global_map_resize.c.
>

this didn't explain much, but I think what you are trying to say is
that this won't work for PERCPU arrays with PAGE_SIZE=3D64KB, because
PERCPU value is limited to 32KB today, is that right?


so maybe actually model that in the test itself, expect -E2BIG if
PAGE_SIZE > 32KB or something, and otherwise check the resize?

> Thanks,
> Leon
>

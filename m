Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52A3AD528
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682560; cv=pass; b=Py+zVoGVIN5mefjwME9j/+3GJkie6WH/Z0edaxse9tK9/xEmER65uBmw6iXGDqTeooZf5UnZlr/HHcZYLEfvICJL5Qx2BB+DsCxZVBNPplZCgG7c2Dsf8jE9G2026Yeko8VZdgdN4k8/gDhfOwmseW/JyNdKJmFIzy45XYNqiS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682560; c=relaxed/simple;
	bh=KM/lcUx7z1exuS4n8yi/+58q3UUBVKsLFZjGmNnRgok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRmNvw+I1cFQADMLFb7liSOIZJ5Ac4ZPWBl2fMoW085/Eay2lTjaN3sqmrCfIGwai+BscLZ1hlJM/y6ZpzS0vrc+mhUHFUC/tZShemcj0KXDq+gf3tLylUYMKB04KDaWj17lDk9Pr4T835stSwXOxX3NECCFfRuIc5DP+ny7iIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZk6FCrg; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZk6FCrg"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso186787b3a.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682558; cv=none;
        d=google.com; s=arc-20260327;
        b=Jo76MXkUTjhrP/IYkTPqAyRQzPQmZWTeHsAt5CtaKuK7JWEhkLABrTjaQa7461gUiD
         g8M/YODRNI7zxhf982blzREPKfRGL3l4GwPqf+Qf1gHA7ZB/t0jp3hgrhvFSF5zXYbc8
         s3JRmiwjiMpbgm8aBa7+CxqttsQ22HgCjFEYuhe6QlFXaGjPq8j/YQoxsqNH9kzuKY6m
         yqRY7eW+mOXOJmvG+S6hPGDLUnXnVlKKjCAuAXVZ+e3kz8EhFVi3dANVl4EWSeqttGmj
         ng10e1BRhuefuwhI5zs6oXedMDr6WtiKfpkf2IlOM4hjl85nFJ0ZPNkcvu3iG5fiOHbg
         m1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KM/lcUx7z1exuS4n8yi/+58q3UUBVKsLFZjGmNnRgok=;
        fh=lvCelA8Lucg0Wg38rH+hC4thNrYPnSHqw/W4mGSLupI=;
        b=El8dMMBpXPV3I82gVDNR8g5wLJcmDxN3/9IoSmYgl1LwzPjG6oxTjLhinfrwpgJLHx
         nmRIfxge6ztJfdug7VhWC+vfDrBsVesT0bHvyXGMEGvMBPY78IUJjSeKiWn5htbYonED
         on+co3QxX5FpnmXBil8ElqIN8wz3bSFVmzTbDoxREHsoaXdCx7ShzH/EpP+tRzixxPEJ
         V4QTt5KUMcP2uPWSbwl4w7pPsrfsL2PzWoM63FhyM+/UTsDM4+dgeJ4D2TJoeYA6Weze
         tbyi2xN7eCNEsvbAgEDDc5sersezNLHRFexDZvpXiMpDgpR+AcwpuaPaj+L/5wkckK7E
         4NJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682558; x=1788287358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KM/lcUx7z1exuS4n8yi/+58q3UUBVKsLFZjGmNnRgok=;
        b=hZk6FCrgUr78TVbmhz86dvdyqVsyHrc56YApspCjFbks/9vPXyypDrt8lwZ1A8oKKI
         NT8vQBhVk8Po5cO+FzgexxHfSWs+klPmZ8+iJzp9i8RfX6+u0Px0KLF+WvB6RpMrmKVq
         uJwlZiGykogdotTvA71NH/VWClxixr1c8U1kUreH+qt9yMv024O1+/5VnRdciyxWDprV
         YsacYbAznIBU/hG8nvRaUsuq9V6wZ+bqSlwGAlTyYPotBwg2Nkvq/kDsh5HA/g+rP9ad
         MQkLVgZ25/+z0WYZ/Zji38U+jyQM2hXGr686qeUCFXK1YwkiMpjVSM0B3SKYroHy8nl2
         mpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682558; x=1788287358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KM/lcUx7z1exuS4n8yi/+58q3UUBVKsLFZjGmNnRgok=;
        b=desV6AjB0hvQyV/9jIHMoIB7m+1Uy4zCL/e87JgdlM8EsS71veIvx+jRfn/L19Yr53
         08i5LrNXfUSZJssJLss/puEhqITuSwBI2gm/U5/LPv5KIY8ihwwLfYmBKMUNjp6Jd4QA
         /ucCo7AB1jhiUq3og6zxUYHHS/sjVtrWaQnKIl88PQaZNUZE2cnX2A78MGElsY224bMc
         0ay4ksx3GcYAFrbaNatqw7EAE7bZ2TAixHdhgEkKbuu0AXiKkelD1yuRaD42c4+64wzr
         RpdENJI8n/s32OOTttIUlbrrXNNjDJy7K4wXMwpmFUDzmwsm0bpD0pLvWItEimzDdcPr
         KBKw==
X-Forwarded-Encrypted: i=1; AHgh+RqeJCEOND9DV3mHnNcBQ9J/+dGGyFX5I/QPPojHwitjxwcPHdnO9EAzkz/kVoaMN+jO0nc=@vger.kernel.org
X-Gm-Message-State: AFuF++ma+DE9OC2zN5WWFX6782wxYaKdvlJH1Lyjjs3/T9GMlDFWhEmr
	jqhbdadQMSd4/hgorU9j3eCzL5/2YQw9KGJkgRIduKQYv5Zax14jAXOHz6T7WgVQWpsz1a/awPt
	rE8Tpe+0/s1K287voV8oyX7g8yRHAgPY=
X-Gm-Gg: AR+sD13Awby8sltsRNpy2VMwMjSbaM56aXLiqb9a+1mOZRJOVEaYgbiHsXtBYpX2W63
	O6QttWCStCHa7ZOImPUBqQ16bi5dpTcfwQ0uaj9XjU2lnMQvqQU/tG1WacFfh/MQokeItHRf8Re
	vIDpBv85+tVIhc+asH8G77qRwVapuvnXv/opZ4z4FkAWkLyrFsHLJC1hMHP2yI8IL1qXzrctOsD
	Z6p2ckewuysRkTE/zv7ThniH5p2jMNpNPx42ECC2lnO7fm4jDGcIberRZRUNMvPBLJR0EjpmCCk
	V6aYgui5HoblGpy88SASNXTnUuqFDvF4wly/V8acG0MtBk6zY1Yk0IvOhh33ab4Ru0WlmR+rFvP
	INNiw62+21UxplyciAxfTzvA1SvNtQLs+J7NQ+djmMQ==
X-Received: by 2002:a05:6a00:3c8d:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-85374ed1b07mr1103841b3a.15.1787682558435; Tue, 25 Aug 2026
 11:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818153202.90714-1-leon.hwang@linux.dev> <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
 <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev> <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
 <90bbc900-21cd-4dfb-a058-13930378052f@linux.dev> <CAEf4BzZY-C3WtoRkdi+U7XFAMv59JeJ2R0yMi8+FGM4sLTsnQQ@mail.gmail.com>
 <b8f1e71d-0fe6-47b5-bf59-0e077e5806ad@linux.dev>
In-Reply-To: <b8f1e71d-0fe6-47b5-bf59-0e077e5806ad@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:29:02 -0700
X-Gm-Features: AcwNN1XyrrP9zNTFIOW0jz_xCJcy9v-63nFUhyb-nd_k_Kn4wLwg02AyJIgkoCc
Message-ID: <CAEf4BzZ__H1Qy5gk_aQcKdMNKFBnx9UbHTg8HTfF4T0edwz88Q@mail.gmail.com>
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

On Mon, Aug 24, 2026 at 10:17=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 25/8/26 04:04, Andrii Nakryiko wrote:
> > On Sun, Aug 23, 2026 at 10:02=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> [...]
> >>>
> >> It is to verify the mmap change in libbpf's bpf_map_mmap_resize() for
> >> percpu data map, like those subtests in global_map_resize.c.
> >>
> >
> > this didn't explain much, but I think what you are trying to say is
> > that this won't work for PERCPU arrays with PAGE_SIZE=3D64KB, because
> > PERCPU value is limited to 32KB today, is that right?
> >
>
> Right. Limiting PAGE_SIZE=3D4KB is to avoid the
> test_global_percpu_data__load() failure due to PERCPU value 32KB limit
> when PAGE_SIZE is 64KB.
>
> >
> > so maybe actually model that in the test itself, expect -E2BIG if
> > PAGE_SIZE > 32KB or something, and otherwise check the resize?
> >
> How about skipping test_percpu_data_on_cpus() when
> test_global_percpu_data__load() returns -E2BIG? Because
> bpf_map__set_value_size() has already been verified before calling
> test_global_percpu_data__load(). Afterward, it's unnecessary to check
> PAGE_SIZE value.
>

let's just add a comment about per-cpu limit of 32KB and why PAGE_SIZE
of 64KB or more is not going to work, and skip the test

ignoring load failures seems worse

> Thanks,
> Leon
>

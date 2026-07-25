Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902533F367
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943829; cv=none; b=Ppj4YQ2XakoZGp/sBc6XcA85uqcIaCwVylleRpiN0Mqm2UyR0Wb70Aih1o5dzZbsKrSokyLvy+lSc0aTaVLijd2/UdRXmcxy8QAzgFnLKULsUHaE1jLYmkoo3hDVTtFusCoTlKXxhpWiuGvjPwnuJU1BqhCLvgXWCjSAGIuFiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943829; c=relaxed/simple;
	bh=QOvHQqeAyMjdvOGozHerL8Ivquu3x9fFj5/LtlMaU40=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mZyvQ+8coHTsxziG2v207ycM/bCqDWeiNn6RyRl8vMIFQfna8IOBxs+hewmO3CjDZEO/7CIYNy4ZciH/aw2i1ktsuoAfh0UTINphso6UsImGyoyob6lZFTg2PB0Wv2+FGg+3RUc22DMiTafv3SyqZq1Uh3nDofnKwXx2YXtnqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsykyD9M; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsykyD9M"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so286890f8f.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784943825; x=1785548625; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GKruidiCeI9Lokg0FcrKCVEZjDbBI/xjMEkScsCvP6I=;
        b=UsykyD9MkgZFgYfiAXQiKCwc1E/I0Mz1AeY9S06ITp/I+0o7UjFgR1EYa3ykK1Woxr
         NRXlSLbVC5NCMjPjS6LWvZ1lRODAowTFel8c/o4JFFkQqzs1ZfdOEKGIlp+o9M7ZZfBq
         St7JgLmMNxnEbWPmiRL3Jh/Mee6ppaZqQ0BczeaXrwyXoU+JQCvbj7ifbqZmMndqTcV2
         3maWD3oBoNBUMnz/P7XPXOFPEgH5sPCEQCn7NIwT3INw+YluFSszbYaowaAwswK/eim2
         NOcpn+9rar0nQHuRGW55OytWGV3tcvhCoG4GkVKAV7dlE95pQm0Eu2PG20yw1rG5KSqG
         Lp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943825; x=1785548625;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKruidiCeI9Lokg0FcrKCVEZjDbBI/xjMEkScsCvP6I=;
        b=V1h9v9w2EhULwsmXPHOi+/Q86dTXVzfT6yWj6E8BzNtz08xEtXeX8Lfk/cdRw3P7yA
         rIaZXJSjK2OKxfOaqyfoJTBafss7snr2ma7KpjcnKuB72+v/uJoBiEBMfXTs7LE7YpXd
         JQKlfalLKWwbibRC5DPXMUB/JvUdJKrrZdlIJQ2K9sV19T3JLikzr5AJv9q9Kz9w9BCF
         BenlZDgYSMV5WflCP7EOsfUqsdVU8ZyUAEa4HzcPVy43i6W2+EaIzqYbzNV+6p779ZW4
         89OwnOR8b+YfDazpIB3IMNDVY00NPMKreV8fBiAPvtxBTVgZqstTroSaCvJ98t0g8tvZ
         Wh7Q==
X-Gm-Message-State: AOJu0YxF4KZ/kZHsTbQ2fQQIoGUQSR809KqX58ws09luxYN+OyACyxDl
	mOpMVjPTLjBMAo/PCjEuBndzofWAn5y2GPHzlMP+CueajXPNoVBGDhVH
X-Gm-Gg: AR+sD13K5fe/i4CokWZSFTr1qenoF3mEYnLWxjo/XY3Uk5io7PDslXglBR0PObkDZFC
	+0PjIWRMdGur9FfzL/2LEGcTVrFk8puOyGVVf30Qj4A6H5OHsCSmYpF3iO3TuP9WLigSzgcdjb6
	pPiZ59oNtwqT1SSnKencoBADSPCoWXEve6tNXbsdek6pBH3EpTJSoZ6WXuslKTsSBq+0/C55UyL
	3zCYlTTl4jU2bfyvl0wQzUs95C3ndjrjdF+hYUVW7+UHPxx+TOeRzqA67e2yL8ke8K51+kRpAat
	3k/8rwZdnNAPx/qZLJ69UWWLXU0wLehvATnZPtHZqe6DRNoCwW+s4tRK61hVuBEuLP/5R9sQ9xH
	pPHpS2/CpdB3aWpQkxSLTUkpfYqEaDurlOtV0vvb+4dTNf8b6+h1dMTd50EL2r/8Ll6XV4kBHoU
	IF6XHZdtMJ0rAJ2roEahMaTjoUaYzTIHOkdxEC6XSAa6b9ETYWkVRe8BaYqbYLnLWFmJ7e3El4l
	9OSghgkB1FDMBRmWg09Xt51345eOe1iEH475sHyVb7kGjuce0oZRqA=
X-Received: by 2002:a05:600c:8715:b0:495:4cb6:71c3 with SMTP id 5b1f17b1804b1-496b5736d24mr7163345e9.39.1784943825271;
        Fri, 24 Jul 2026 18:43:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm28847825f8f.3.2026.07.24.18.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jul 2026 03:43:44 +0200
Message-Id: <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Song Liu" <song@kernel.org>, "Jiri Olsa" <olsajiri@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
X-Mailer: aerc 0.21.0
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org> <amJhnbom_expRgN2@krava>
 <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava>
 <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
In-Reply-To: <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>

On Sat Jul 25, 2026 at 2:13 AM CEST, Song Liu wrote:
> On Fri, Jul 24, 2026 at 1:54=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> [...]
>> > If we add a read per page, which is the worst case:
>> >
>> > before:
>> >         nr_threads: 1, map_size: 1048576
>> > arraymap-mmap:       throughput: 0.032 =C2=B1 0.000 M ops/s, latency: =
31248.846 ns/op
>> >
>> >         nr_threads: 1, map_size: 8388608
>> > arraymap-mmap:       throughput: 0.003 =C2=B1 0.000 M ops/s, latency:
>> > 372565.622 ns/op
>> >
>> >         nr_threads: 1, map_size: 67108864
>> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
>> > 2061083.005 ns/op
>> >
>> > after:
>> >         nr_threads: 1, map_size: 1048576
>> > arraymap-mmap:       throughput: 0.006 =C2=B1 0.000 M ops/s, latency:
>> > 170794.193 ns/op
>> >
>> >         nr_threads: 1, map_size: 8388608
>> > arraymap-mmap:       throughput: 0.001 =C2=B1 0.000 M ops/s, latency:
>> > 1346389.229 ns/op
>> >
>> >         nr_threads: 1, map_size: 67108864
>> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
>> > 10700389.105 ns/op
>> >
>> > So filling all the pages in the mmap is faster than faulting one page =
at a time
>> > in many page faults. IOW, there is a performance regression in this ca=
se.
>>
>> would it make sense to add new map flag for that?
>
> If possible, I would avoid adding a new flag for this. I think the
> regression is on a very special corner case. BPF arena has
> similar behavior (fill in page table on fault). So it should be OK
> to have array map do the same. WDYT?
>

I think it would make sense to compare cumulative cost of mmap+read-every-p=
age.
I am sure it would also be lower before this change, due to the added conte=
xt
switches for fault on every page access that would be amortized before this=
, but
may give a better picture about the difference.

I do feel like it's a corner case realistically, and after the first fault =
the
page remains mapped (and users who care about pages being present can go th=
e
route of passing MAP_POPULATE). I am assuming passing that before was a noo=
p, so
it can be added to code in a backwards compatible fashion if someone really
depends on this?

> Thanks,
> Song


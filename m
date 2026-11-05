Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793918024;
	b=qyc2FewLd+/YW5VS+CyX3CBMT4zDF6dIP2IRUtww+wfznEnbt4GulUmpP4OGtAGo220C
	 E+xQP+VGwjTQPpukEnHCeLEDQPCBPCI/iJg19/bK9JQPx8Ba6eVXy1jm0tijFf+wnn60E
	 1DI6XCsBxaoWwlwNXq+bj5CCl9dTUapjxT9xqxOToEOqmjGF1b0ssXKoei70fRn4P07Bm
	 h1nehKHLWVT/r9BxA3Oi2BzvqmS0EDTF7WSEwehyIfMF5gcYatcOwjrFQUAJD8r81YvfL
	 Bf/Zlmn8ABdWEQEB+pC2YLOKu3ZRpuB5uwawdS3Xk34A1e6fuxn72h27CDu+5HySvOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=31ZSEIgnSRblqiUyaAfYn9e+uXgsnPwJ063UmUgD6Oc=;
	b=lJ+ftPl1ReM0dhg2zqEAtNT/B6Nh+w2+URtftT5GejlwbbvZL5H2Cdzt7YRJoVEGPwq2
	 g5cpJU4BUi5mjqlyasuYAH4y5r4kTGKXr91fYl8arhN6Y8BDOACIkWoEypvxp95IdM9uM
	 WYSPucrzXFVnzDiA83zgwBuFmXnwQ5YEwlCfgNLY88X0iRqNFbngsHUEP0DOsn8lHg2JT
	 LKYDVVKNWF0tn8b+irH1N4GtqPZKTQraK+xiAYcZ9aaldT6ZE1lhJH7imIG64ylJhTuuZ
	 wUcmccWf9M4wzuFMY8JyvNEt+TaIet97oO/GDXYWB1DrXfHkohusEsP8/ty48fGgYzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkL1uUsJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58444606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58444606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkL1uUsJ
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso50145ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:33:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793918024; cv=none;
        d=google.com; s=arc-20260327;
        b=ln5vkpZXM048JSVMCndmfVBKc0aDqiNCjTA4Sd9o41ztqIeS+w7oaGzC1u2uDBtDG5
         yuo7Ru6VvvERYs6QdNUdoAGHb9eNfSxhrUcOoTtnTCehaUysiNj4zrnmbPz4AR+wZtjl
         mYFg6xznpmML6UREYkB4HZsTBPwWpf2pau5QuVvMMklm9bfIVIPHCanGLo01XrRAbGVl
         OX0K7MJ8G6MiBaQ7A0uBin5F/j2krOgNkgJVlakwdGogYb4PM+WbxrUSySjahJn69rP5
         XZzt571sfTKnSX/6rf2sCYl2uBPjP8y/a8bt4iUXpxiTjXqfJeMkn/Qn08KAOxpoYyON
         tscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31ZSEIgnSRblqiUyaAfYn9e+uXgsnPwJ063UmUgD6Oc=;
        fh=I4+Bp15YmpQ14/HHVTeuJHhWdUo6XYRy0lYhRsrOuig=;
        b=PLQE6s3JDNEL41cZONlYoMKvD7zUvRMSXD5LOTMEX5PZ95g0eEb15eg8Y6P/V09Mcv
         wQN+p7mTfQ19UG1nIPye3FxhKoorAJH9ckFQC0EbyGtQ9Cr4WCgxYF7m9OaLgNYh/tPq
         K2tpmR3+YhGiaF0eMxJ9uP8+DAE/ihx0m9fVHIoFGr1rCx5ohwsogwUNu6FIdmp1FI1S
         vRA+lpWy9+5SXD6Pf9yQQy4AORLgoOMEKH63PvJtTcWBfbsNwkmWqU8+Jx4dAabySCQK
         /2VBIiDasN5+Izcudw6BaPocNImWfcoLk7ZXWLFS/drhNYFM/c79c9V61Wda2/h1r7So
         ve0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918024; x=1794522824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31ZSEIgnSRblqiUyaAfYn9e+uXgsnPwJ063UmUgD6Oc=;
        b=AkL1uUsJOeHObshdo9+U1TMRekYzm+FQSnIEBxFADET1q6LI//3991kEMggxnQ8JG+
         LzcVyzwf3kZOT5/ixczpwa0zj/jgFZvVz9653Dj58inJGySH+H1PAQWEA2KS6YB1OMma
         t1VMmK/a7AF4TK6UVPL6/w6YeNPA7jO396F7053+B6Si5Kp5WKvA6ks3QmxfMto/NgQE
         rBKr1kKhybKvjP8qEM8o9qsfB2nXJq3XFMuuBGVIgg4BLeU+ABIAyprv5agZaGgPV+NT
         r5q86Kul7HexJbCh3tQSV7k9BaYerSqC4/MIPGpYc4pqF4KeHcIS2uNHq2qnkBehRKuA
         rIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918024; x=1794522824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31ZSEIgnSRblqiUyaAfYn9e+uXgsnPwJ063UmUgD6Oc=;
        b=2C0S4+AOhWYBXcO4tVDX0EyOui7lNZTCFPxZO6SgPHtbERpYnDFOGsrAD3nWc98D4T
         01Qjz5jxO9wk+7FiksmPcQVUXPys7K0YW5Z7EXZ0HFJ81pOJdzvWCKKEkNzJeIJqgTgC
         KaMedf58BiW0UlJ3iZbnnBq3fV7DUghGBeQ9T9kWj+cpIzbU8xZWlk/avDwIXhThctkM
         7qEXEqKXZk3R6tEGka/NO77bM+9QmS/yaGPshu2XpIWPeiE3U+YD5XDtvghvniOGsbSZ
         2qr6UVshWunJV3VY36LPY9pNk5ESNpJBdS02ukZxPhxeYCJAq36D0zxe1qN1+i5AuUDR
         2C3g==
X-Forwarded-Encrypted: i=1; AKwUvBwFZnGVkX0+k15rV04GEPJ3PHG4JAxVr9tAr12ck6WTZ5rEITW+SuHNtmlyPKy9KhjS4yY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Yg/VCK5R4GcS0zj0EwnisS2BL9h97oURjoPJxFDpyBlQGD8o
	GNRFxb276T9O0g4yt3yk1GFVGwEjoseFe6zHzOlzFqvp4FpIQ5Fseu5zfknO58vos6pvxGQ/v2V
	nU1D2+iO+E0NcvTvTZh7mokf8XBFf9L1EiErQw6M=
X-Gm-Gg: AYBFou2yo89Fz1xIxBV5KskaESCY99hDe3+1X7ZEop7R6m1eQVOa5SPReTCFXOT2/js
	FbLAN2rEaZ1MWB9Zl+dN15mCNwwHiJo9Atjr1Vip7vi5Se4mXiRQ/vG+QiqgWH45YM6k82rdzV+
	juZlyyFCvGwOjDQoMy2oKxgjrOm4ilWu4s80w5qMBUyeRoKx5MaUOU+fDHgAA1v+b5mpc4IpJZo
	qOU09cuQDBamrfeumPvFOckurjihUNWS3DtEP/qi3v0DhfSPApXiCg8vHVlhC/Nd1G8RnAkrTti
	ZRLfOY8D0yBHtG9LXcVktDS6JbnAZol52tzXOx+bPAeBSe5dxhZ5NoycIjQEVwbuREzeUJ+ebXt
	rrIoPV/Ow4L5LMsOiTw7BIflYbvfc5KHABFp4bnkkqv2yUHaLThHNrUiXnDzeD0x3Fc5cLM/7Sm
	RfW+177GOVXHWGRiTRix1uniwkLpa7X4/v0Q==
X-Received: by 2002:a17:902:d2cd:b0:2ed:205e:eac3 with SMTP id
 d9443c01a7336-2ed40ad43d6mr11276705ad.12.1793918023548; Thu, 05 Nov 2026
 14:33:43 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-d-path-memfd-v1-1-692a5664b36d@gmail.com> <sashiko-outbox-192887@kernel.org>
In-Reply-To: <sashiko-outbox-192887@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:33:31 -0800
X-Gm-Features: AclHuK_44Icv5iKrVAgcoF-RzALW9SohVIN3sRDCgSubWdDt28UmDb25q-uzOXw
Message-ID: <CAEf4BzaJcmCbTA75Fh6OUkduAui0VCwuWjvykCpe00ivmKWXzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use memfd_create instead of
 mkstemp in d_path
To: sashiko-reviews@lists.linux.dev
Cc: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 8:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] selftests/bpf: deprecated CHECK() used in test_d_path_mem_access(=
)
> --
>
> commit 70ec4540d31dab1fed0411808b9f6ef87d380925
> Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
>
> selftests/bpf: Use memfd_create instead of mkstemp in d_path
>
> This commit replaces mkstemp() in /dev/shm with memfd_create() in
> test_d_path_mem_access() so the check_mem_access subtest can run under
> vmtest.sh when /dev/shm is not mounted.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/te=
sting/selftests/bpf/prog_tests/d_path.c
> > index 1a2a2f1abf033..0f0150d73262b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
>
> [ ... ]
>
> > @@ -230,13 +230,12 @@ static void test_d_path_mem_access(void)
> >
> >       bss =3D skel->bss;
> >
> > -     localfd =3D mkstemp(path_template);
> > -     if (CHECK(localfd < 0, "trigger", "mkstemp failed\n"))
> > +     localfd =3D memfd_create("d_path_loadgen", 0);
> > +     if (CHECK(localfd < 0, "trigger", "memfd_create failed\n"))
> >               goto cleanup;
>
> [Severity: Low]
> This isn't a bug, but since CHECK() is deprecated in BPF selftests, shoul=
d
> this updated check in test_d_path_mem_access() use ASSERT_OK_FD() from
> tools/testing/selftests/bpf/test_progs.h instead (similar to commit
> 47687a29b2c3 ("selftests/bpf: Use memfd_create instead of shm_open in
> cgroup_iter_memcg"))?
>
>         if (!ASSERT_OK_FD(localfd, "memfd_create"))

yes, let's please switch away from CHECK please

pw-bot: cr

>                 goto cleanup;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-d-path-m=
emfd-v1-1-692a5664b36d@gmail.com?part=3D1
>

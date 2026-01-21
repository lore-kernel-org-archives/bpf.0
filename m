Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DA3D34A6
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028897; cv=pass; b=t5YA/paSdopO6/P9ONcwujnzIvczZHAYHZTK1kETOINN5zRNmdK72DTjkYpmWHrqGH1WGhePi6Fu/das52qAPYkJyS05gEy/f33h33tQ9MmHmfhHlYk85dUfg+EP5gK4YmRqCHkxdpN0jIgXGSJJfsqliN2zJtSGHCd51owQqhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028897; c=relaxed/simple;
	bh=by9E3Dywr6SO/xHqGCjYZuhEk6x9oxt3CbCIYYxJ9DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nytgbVJ5QfAZ/3YoeG3T17C7Jm9p6jZTP+wZ6+0/bxB2fNjFz6j1tWSKoC3AYUX6vX2aiFB6pEfQVeqavBrORIK5ykoQT2FIVgSUtBfu55DEADmH7H3FrpWmQxR4z4IWHiJYsQRF9v+rtlqispshK2vG0Iw7Ih6c4wOIDYz6LUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akszvgfZ; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akszvgfZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432755545fcso184890f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 12:54:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769028893; cv=none;
        d=google.com; s=arc-20240605;
        b=BeJhOVUZbQxqWSc3KVbO93eCn3YKAapWya8mQM6FR+2OzjCNpvIBDhauGJDbw4Te1S
         f6tkHlVh/Aw8n/P3PdPSkwRu7aL/TmNqfxKqUNvya13WSJaFfWWgJfo2Cy/3LL3l02t7
         //c3oKVkAU+Lg1N9CuvGQ90+SYZnTUvheJQdyVkv/M3lzrGk0PdTnCZqnCX+4Gg9TmOh
         2P9s2paUwWJCOv1V0/A9Hh4eowBtq1CpaCx5AQd+EuXzQo6o52Mh66mgweNIBUyY8Asu
         nepsXpdgdDeLgGch/OngMH2K3Iv6dz0DJy20wgSnz1Hnmzggds6mcMrEmnOhFtWsv0Tu
         cn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=by9E3Dywr6SO/xHqGCjYZuhEk6x9oxt3CbCIYYxJ9DQ=;
        fh=XiQznVffgT/aRbZileG+ik+1d8I4JzHDcLZ2CYZQZFE=;
        b=fOtXYuqs1QlNfO4Ea7PqeNxUEdoYM6DR8/eDQtOj91CM24rqafKdNc0bDDoVYsHvKr
         q1qWSR50UnfDY/rZA93ckXGJ+pTjMdMMtsMu2cqe3rf15Xzaand27F18AGad/5udsKRl
         yxiavs+XrOsFR0n6EyNeOn8SsuXgYjqQPrZ2h1XftWMN3vhdSfXp/UJxQpo/uCu+bGJ6
         DNicBLrii1jrAWxm9C1D1xJt7po27JC/O46xCp7GF67DS7U3IZC1/jQWezt6mkZgVAg/
         siTcu/dreirtyYu+RNLVNeNrU89SY9YxNuly3Mjyj3JkTH5T0W0n2n0RttjC8Bj3ngnf
         bHZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769028893; x=1769633693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by9E3Dywr6SO/xHqGCjYZuhEk6x9oxt3CbCIYYxJ9DQ=;
        b=akszvgfZNOoXuqOIDK4+l/hY9/7+I6CCsIawFHT0ZcuZxsG33P2hZ6O+1y7LHix9l1
         hqQ3wM6qtN99d6SDcfZnp3VZqbyzdgXTp3mYn5EH/Rj5XegCXCXNzWgdeXj8wKOogbyU
         kx1ieRSme9G/udpOwD16pDpOQZoBoN1NXi2ur1QeEdI/iW/3L8ne3PnZIyID8A5gnckm
         Uw5I8OeXiQBEpQFX7uRSqy3wiQVqJ4vQp39rczQ2GUJ4SPcgGTd4bsWXP2mCao183J1s
         wSwIqhnMHdU1w8rLW9xG6n1l+yoiULlkbQ8em1ROfFPJ4Q7pPabNx5IIQcXLm88VunGI
         CDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769028893; x=1769633693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=by9E3Dywr6SO/xHqGCjYZuhEk6x9oxt3CbCIYYxJ9DQ=;
        b=pnC2NwEitOA3H3Laq0onC4WAonc8esfhy14Tz7C1bLnno7xDHDCEMOy8cslpfw5ZAE
         bBRyBOTjRnk9Eyd0vGngeNpFQMJgiCkUD6jIuzTGm8NVZAMhYOc8lSEbH71xN5wedhYt
         TGoizEHqEoP8hE9/ELqeuHh6BYWjStaPHf89TYcqjJBjM5jnZXWr79tAzJHtRr+jvPo4
         eoE1Y2PrSeesDqbPAiz+9fVB3Eg3xKDqh//l22ZILFudtHY++uNnr7u1IyRgnQA2XLXZ
         IQSlt8SAzW/BBKiu3ERhw/60X3mUayT7WyBH+2kJLs+UrMpZTNmb7rDJHEKRYlU+bRyH
         Fnag==
X-Gm-Message-State: AOJu0YxkYtyGUuUfPZTgSt7wddUWLkLyghOyGD/ImMpNL4+O/R6ZetDS
	UQW4LqmAdr/26x/LwGFTJ1rWtnzblrabZeu3J/YoHbxbT71cYRBhmyRQNVSU02jRo/J7DEAJPhy
	hDqDFqOYlMbN4Op931G2sxvmr75Vimow=
X-Gm-Gg: AZuq6aLUTk22l4/YNAapmP3Ip+knamdAg+zRG0zJtQwEQ0eIq2S6izPVOsv5y248F98
	7Hpnw8DmogQvpN13ZEdkHByQHr8pdARquNpbcjLgQ8U/U4/arCFwVR80M7KlxRUvOTt9rU6voVi
	0L5A1+QHfMh1adsOy6ZDFVToWsRL4XT7TOFK+nretswfMB0apK6IODOULoPwTHG4BRrV4SoOB+M
	hpJXSo0ECltYzCOieYVRHbZ3ABF1cx5kxpYZF2gWU4n5jOAUCXLGTVIuoZJ2KMbkzFJQGmbu60+
	+Xhdc1EKSQJPDJusZO7F8YCd/iNiHVTer/6Ju31B5ck0VpK7LRsLbdEB41tGvDBUVKza5Q==
X-Received: by 2002:a5d:5f84:0:b0:435:91b8:e01b with SMTP id
 ffacd0b85a97d-43591b8e16amr11019407f8f.45.1769028892879; Wed, 21 Jan 2026
 12:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
In-Reply-To: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 12:54:41 -0800
X-Gm-Features: AZwV_QjqFjkv1O6mQy22-NiFYjt5LTUWPVo5pN2y0yrtFS6kl3XOHutI9qwRwYw
Message-ID: <CAADnVQ+hTZ_ynDJk+pccBwHGLs3hyvjDUGyiaKR2osmi0VAQ9g@mail.gmail.com>
Subject: Re: [RFC] selftests/bpf: Running test_progs with distro configs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 7:02=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Hi,
>
> I know this has been discussed multiple times already but I'd still like
> to open the topic again.
>
> We struggle to run BPF selftests, especially test_progs, on distros
> whose configuration is different from what is in
> tools/testings/selftests/bpf/config. While the tests usually compile
> fine, many test cases fail because some required config option is not
> set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepable
> tracing programs, which is often not enabled on enterprise systems).
> This makes processing the tests output much harder.
>
> One possible solution would be to maintain our own DENYLIST but I can
> imagine that the same problem affects other distro folks. So, I'm
> wondering if the community would be interested in some solution which
> could live inside the upstream repo. Obviously, I don't want any
> complicated solution which would require a lot of maintenance and would
> bit-rot over time. So, I'm thinking something like introducing
> CONFIG_DENYLIST which would contain "config:testcase" pairs and a couple
> of lines of code to test_progs runner which would parse the file and
> automatically skip the given test cases if the required config is not
> enabled.

test_progs already has -a and -b and BPF CI is using it to
silence the flaky tests on some archs beyond what's in selftests/bpf/DENYLI=
ST*
already.
For your use case I think you can introduce DENYLIST.redhat file.

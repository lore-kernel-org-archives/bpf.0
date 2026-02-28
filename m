Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E3326927
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247528; cv=pass; b=exg4TfbYpejbwlqAD2XWJdYyZQZyP4GLAvvJ/5S9uQ97/H4LyzIU1ti7mXzM/3jcHvQAKKBcN7+ILdflkRY1pilTpSw1oXU/KYINphsAQkSfnU/HOt+KjBufAcuu4fUSorkSfdg25ujA61oOsciPOW1o9sf01caUyxS1Sy7jXJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247528; c=relaxed/simple;
	bh=ysdqeISiySuqEph7vi8qMMTL7nfGjmC5pfX7MTnaBb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft3+T0TlDR8L6V7UXC6jON2MmX1c/U3iicVyyA2x4bxvOCKOVd4IykJmXeYnhwcBrmIfWwYZwmAlZZRdsQ4vuC1GA0oJtnPULCyCr/W9F5OsLEFafwTqhBL5yGovIZ8uw1AJ1UveqwnVrdgq5ZpObMcSJ5LisrvMRFe3DEin92o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMBKa6au; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMBKa6au"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986e0553b0so24999417b3.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 18:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772247526; cv=none;
        d=google.com; s=arc-20240605;
        b=LT8CFXalmtfkO+YeeM3k7mHL2qh37X7nA1x+tg8c+Ra3d6Pu4P/V/zMCYJGStiHjPL
         WwvndA1BlczL38tC55IxF7WONEj0esgApC5oGqs+bZhp1ZR7g4gUEiM6vqyPKBkH7wi8
         Mc3unan3Tq8WegXToZUvL00BaNgvkMfENnRSGtR77I/qQCCYONCzB83jhKvxMi5qkwsJ
         cHHVKP6e+Zj11qJyIU37Lbbbg2rDp/iJtXTIDbCgkTyyBjsH8EQdNsJZ83oaogZShshr
         ERoxwBnW6EDTUvj/AiGloUak2r9zM2Fsv9N7ScJy/y2r2GVkAjxUPa98aTEHWFX9Qbss
         xZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8J8++aM/qOXvTI7XL2hzcCosb8kXGfqH4Z9aH7ivo4Y=;
        fh=m3X//x5/mNQaY2gYeoorhFYThPUSo3UkZPe2M/nolF8=;
        b=BaJHCpIuifnFA8j5yNT+aEMSpAmuNgz0fp7tomYoPhF8FEZhRNuiIL3xtaS7Ru3Lnm
         2as7v/KVGch1ehOOkWEuOwvHh5cUBRXynndFG4PIKVJ8DLnF8m8AeIPt4bvLxUCMtiF9
         r0tXH04bkoeZR7r03xkTa1axCkfscd8lBpURqC8f5p8XaK84S8XulAfFBr72WsLuyCmT
         mA+STsR3CaAw3qK4MRvVsj3XlIqgZ0UVCjL/k8tjqPcTnjl4LfIOfiHoqBG39WLoKKpU
         7tHoKzEuoijnRKFpNi2MVQPANuJ08dYXtzkF7YuSPBWzqOXol7DJYxYEN8oWeI9E4jfH
         EwpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772247526; x=1772852326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J8++aM/qOXvTI7XL2hzcCosb8kXGfqH4Z9aH7ivo4Y=;
        b=nMBKa6auNF7Zph6qHOOkCCKsBybYd6pIpvyXMfTuaG2NRZJvqLO+k4lwj9rjDItsDy
         0f3bmiTVXrLsxYFEXfqSMEcY5+HB+X7YcswQT/C0AbO/MXm3kIFJRvfji5lDXf9NLSmt
         l7MCnxueKSKTw3xa6ZKp9tiWywUvTRssm/95mcw3E40M+Rcm/wS+M22XIgql9W6Uy4UE
         vIRPNqAagIDzLetVKAUDreXM5cNoCiw+FgCny9R+7G0vGUsAvPtGOyHecHFc9U2j8LPX
         GGcoHxaf5agwJS4oC13ytE89Ubw8W+UwrRgWBm0ug1AZkgl4DRB345zGo/jWQpl6jL5S
         I7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772247526; x=1772852326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8J8++aM/qOXvTI7XL2hzcCosb8kXGfqH4Z9aH7ivo4Y=;
        b=vVnf430bbbQpNDrGuuzoireLoCXm+uJrruwxsR/+iiLT5NQHxYBNx4YDwnaY7FLCM7
         6U2ewTRr0AUISz6j29VfV1kpEpT4FhnVdsL0VgIGz6V+kV1Pbi2hJ2h3vnEOuIjwbHMv
         JczbYQuPKGBWV6NzCaxZaS8Ljm0GIUNmyDFrGxbsB6Zax/CZhWB7hcpWdt0y4MMlhQF3
         mC/sPI99JkxQXD/6J92HK9hkC5Wwwe5Hc0NHEHe+48pPb+oMqfS7soUTDuvx5PAXXttF
         RJKEuy5Aq14wYQ+FvLozMZkxep8Rv9uAkWW6kL826toiuUoxJaaA1LYgXHiCmbpXdzQU
         eBUA==
X-Forwarded-Encrypted: i=1; AJvYcCXauiioMsiujwj3Tp9rE5jdN2fSOvRkpvBLMdBJnN3qcSdoireNk+nZdsHIxPUA5dDZ8CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpN8yS+mCO11f1jkZEqmobviDJuIx/htQqHGQhOfLh0Qy4YJn
	TWj+QQIyAQ8W/7LxpGlwHaxgdvJ42pxh1fCvTblQDhFPqh0Pr6Rlq3nF3fHaQIiiqNfgKTZ2HMi
	W5YSboxmnU7OdBIwEHc7n6O0JWJv9/2E=
X-Gm-Gg: ATEYQzx6OF9Yx6OVscVHp4esrBKK2mP4Mt5mernohQc4NehTJBAvzgNpZMmaTLM+Uh2
	DketGcjBH42z1w+XMGkfRPrZp+/XlOBJwB0F8jz6hMrmrHmaVEZbL0ftvBaE7i5EDv50s1/AUdr
	vUavnGVLZapK1UoEBWSB2OI35vaDqWmbI7WX9HpGTH/U8zN3O3oqATUZ6GMfL3ljNLRy6SNLC23
	kBtBo2fSthXfrYPGdF6idsUrhI4f0Qf5b+eLc2sJt3Kts17yS1UNgkDrKGydmw0mfP2jSRj8WvI
	RLjA5B1Ada0NUT/M+Aw=
X-Received: by 2002:a05:690c:6c0f:b0:798:599d:fded with SMTP id
 00721157ae682-79885591fb6mr47126697b3.35.1772247526508; Fri, 27 Feb 2026
 18:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
 <20260227164037.84110-2-sun.jian.kdev@gmail.com> <CAADnVQLT8nEetXYDB1rFOqwgyBvowbafUzuz=7EBWUyVQw5G6Q@mail.gmail.com>
In-Reply-To: <CAADnVQLT8nEetXYDB1rFOqwgyBvowbafUzuz=7EBWUyVQw5G6Q@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sat, 28 Feb 2026 10:58:37 +0800
X-Gm-Features: AaiRm51O9D60ynZRnlY1MPt6xcWTGaymJOzyTANVoFyjkqM8sWnaSB0KF_lBfl8
Message-ID: <CABFUUZHfkxJrCzZk10cqdVJj0iz_cyg8Woh=1Y_bj-7x2+VBaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: bpf_cookie: skip kprobe_multi tests
 without bpf_testmod
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 2:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 27, 2026 at 8:40=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com=
> wrote:
> >
> > The kprobe_multi subtests rely on bpf_testmod fentry ksyms.
> >         attr.type =3D PERF_TYPE_SOFTWARE;
> >         attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
> >         attr.sample_period =3D 100000;
> > -       pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FL=
AG_FD_CLOEXEC);
> > +       pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FL=
AG_FD_CLOEXEC);
>
> This part is not explained in the commit log.
>
> pw-bot: cr
You are right: the perf_event_open() argument change is unrelated to
the testmod skip patch
and shouldn't have been in this patch. I'll respin as v2 and move it
to the appropriate patch.

Thanks,
Sun Jian

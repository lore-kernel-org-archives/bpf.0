Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5F1D555
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569280; cv=pass; b=f9yS/zgDdgRbXZ7OnTO6vrWtjGzSX81geNAcbhdvdYXt+7Le0EXBjGxbtYtNb7rsPMAzhFl6ugIUOiE/SmlfoNG9JO84Qw+uuRhx4Y6aQgA2gdVsauXgUQ++MEJetr+5xgXLMLuLLeO8Z+zWtV+M0k5FXz/bD64SV5boJcmXWPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569280; c=relaxed/simple;
	bh=NKgnPurdkip5P21bX0VgS2dSmB1YYbUttO2mE0YX/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saGH9S968aAKeS4to3nFdq9xY4lGUCylM27Zdp8U4XsrxEvetgvJG0kOvYzmIiMupe6u5BPEb+NAFqKscE8HbQseP9wNVUVkwmBmQD56tGjivlPBLuGc0SgvaiVvKYCb9JWXjsjK+POE+ihGcwwLomIY6QSFp2gnKzGoAoRwxNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StXNn935; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StXNn935"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94a231b285dso911828241.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 22:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771569278; cv=none;
        d=google.com; s=arc-20240605;
        b=GJV79PsAElpJayKSJnJkKOQJWFOaLl1jzi3qFyGgChWnItbaZ752ObEyF/PUzODLXQ
         /+TlBicRLxUeh+lYuD6NfnJsqrUJPbFFbPtGTKdieL62chLKXtwhEqsLdhGkkSUwyuWs
         NtHQQ5inTXz2Q8epcd3BIyZiF0QpUxCO/L0eBggrP9GTdWnwivnU30uOxCLjVGd7BNmG
         0dFH91Gn50d2o8CZp5DOGxgGUVPvQd86l62ZJiJISPZabNgvwTLizIYgVeeeztVTvj2d
         /Zf7kB8LCt3KIfNoZRxjtT93nzD00czJbbIwKNjQDq96pMyPNCmijG1+0ThebbF2r4Xr
         hfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDYpme8tSO4KdIort3ZYVWM2MiJetiXNYajIJmviPTw=;
        fh=rXGzJJakM+nDAyjL3So/L4zu3cCKu4AZes1G31hugkM=;
        b=C+mLlihr2m8toYkusKQJX5ckwgJxjJBVbzFM7rXf+u+GTtN9fnmeOtIE5dmOp3Ynnm
         qrbedq8ucX08P3slfe/R/mXXw9lOhdJVq5d8KCQgbSLhiZZw2PJQ1Q7+UYsYbOtFTloA
         G0jJ3/elXm63r8zGoud1gnNQJqGcW+qMhfaHWPo1bq/+hkb/lDUyucm/dd2ob5smUEkl
         353ec46QxUPl73ohThqrckAqs6GflouACn3T0xcBM7UdX/ZsBlzWaIc/vh8tm2INNtDr
         CspqC4FOwcmxMnZRETUePtQWzqHw1JnP2dWwE0paRO2S7V/W8Pl6KqQg4jzHpvDJuQuX
         5yhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771569278; x=1772174078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDYpme8tSO4KdIort3ZYVWM2MiJetiXNYajIJmviPTw=;
        b=StXNn935kBM3SjT0XdVeDg0pJBm5Nfs5D28Oi9FZkWTQsTbFt15VKNP+wVjC6f9nMy
         o0sNaA39fKhPz3w8qLVJVKiU5zsThHEvbOIrL0WpzG8tmk0m6V8gnEXAx7oTVmfMzg6E
         y6U1GuJPfwLqliwH2MyHyHME8eoTrvvP2pPvZsoF4+G1E4J0rAPCzCG6rrK1Rsb2DsFb
         MHCDQjuzigkDr5swZmSjdqkMJ1WAifIzt/LErAErpRS4PkQnxb/ZstGGgqKmv+QyuxJA
         p4MxoWV9f0sQ/EjjeqCZDJBa86SU3q6RxK1lSHbZWLSQ2VQIAVTEpTE1slMLbpvmLuea
         +nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771569278; x=1772174078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDYpme8tSO4KdIort3ZYVWM2MiJetiXNYajIJmviPTw=;
        b=OcS9FzKzm1akd73HOsT4ds8UMqZl1flxiwgBN46XHABfhLA2us0AbqSIpLgPNQKwIT
         wp7NRbW/SGGawz7EYEOlGHvfBaEq2D10ymN5gOpTYgqTQHRtgflQeYqgk9K09dvJStGD
         Gw9AMyn3FYUfVIlHQiU0ouzLoYJ8CpSsGldvfU0CJZ4YhGHXY8HedWqYgEaGYV0EaSQV
         5lslhVh4Q3224kVb+s+l9fMdDQlgjlGzylnDbF+3tvCS8Wlk2doVUPwmEkZMicFYtfNV
         X6lW/cOT3W4ahysOGnxt4ZEw1VcWWYoyRvJ3LamcnzvO+9mToqZRy0byaXlNwK+ePVKB
         PhWA==
X-Forwarded-Encrypted: i=1; AJvYcCXpJchWMMgHVvlr21ROCTORS8EwOoGwR9XXrVZHMaByJT9CAVF0XiH8ezj710kiI+OBxLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtRzyUmi3FEJKoWYROokuosLMSXE9z+8WPQ+UOdioKB5bAKRQ
	hk51fXrEAb7GaQ2qVUseTZ+mVUk+EiQIMW5hXKrPO6Mlb/lxnad6NnV3ib7/+fXzdoBcXwhmxhA
	qAI4strYxFO8ckI+cVpAKpuyLhEk334DIimaA
X-Gm-Gg: AZuq6aL35wzahZujBQOOD6XOgNw14U/gvJGFvcg+oTLrX5yEAY2uMuINOfohJv/CWVv
	2bx81NI4KVb+F7Ksq3M36cplgsI9u+K42/GAJl2fQ6+hsuGw5uOLPKSqFL4ivA9aD8B97zIO3aY
	a0S8YQ3uhosAwtot8nu/DLaVzObZ643mkkv7aT05/KLNvSF9AOtD2/j9WR7mEhq9F6AeTJp9Cql
	T2EVgEa/u8grqNM/AukSU/wR3KZ0kAJ4LdbHK+D/3yfqrvJKgoGRIHmGCVV3XFF0ae7/b16lKJK
	kyy+reZo9SaclWTO1WYW5vKnU3gbSBQqMxojfF4MQA==
X-Received: by 2002:a05:6102:3f42:b0:5fc:2b29:b00f with SMTP id
 ada2fe7eead31-5fe7fc6591dmr4591578137.19.1771569277681; Thu, 19 Feb 2026
 22:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771316309.git.paul.chaignon@gmail.com> <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
 <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
 <aZdcoaH9ERUNpln1@mail.gmail.com> <aZenQb3H5g73Bhz9@mail.gmail.com> <7b696c92e56dc560154818484cb35def2639cbf2.camel@gmail.com>
In-Reply-To: <7b696c92e56dc560154818484cb35def2639cbf2.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 20 Feb 2026 01:34:26 -0500
X-Gm-Features: AaiRm52txNGnggIOoddNlQ9kLMIH-xSK3JTS3RTpbbqoG0i2oIaxGq5uFenp0-Y
Message-ID: <CAM=Ch04aEBi0eCtemGRBO0xFcPs5Av5T=AqQwQxGcNSJ2nAQ9Q@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 8:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
[...]
> >     tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
> >     umin_in_tnum =3D (reg->umin_value & ~reg->var_off.mask) =3D=3D reg-=
>var_off.value;
> >     tmax =3D reg->var_off.value | reg->var_off.mask;
> >     if (tnum_next > reg->umax_value) {
> >         /* The u64 range and the tnum only overlap in umin.
> >          * u64:  ---[xxxxxx]-----
> >          * tnum: --xx----------x-
> >          */        ^
> >         ___mark_reg_known(reg, reg->umin_value);
> >     } else if (!umin_in_tnum && tnum_next =3D=3D tmax) {
> >         /* The u64 range and the tnum only overlap in the maximum value
> >          * represented by the tnum, called tmax.
> >          * u64:  ---[xxxxxx]-----
> >          * tnum: xx-----x--------
> >          */
> >         ___mark_reg_known(reg, tmax);
> >     } else if (!umin_in_tnum && tnum_next <=3D reg->umax_value &&
> >        tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> >         /* The u64 range and the tnum only overlap once in between umin
> >          * (excluded) and umax.
> >          * u64:  ---[xxxxxx]-----
> >          * tnum: xx----x-------x-
> >          */
> >         ___mark_reg_known(reg, tnum_next);
> >     }
> >
> > Wdyt?
>
> This makes sense, I missed this nuance in the original patch.
> Maybe keep the first check as 'umin_in_tnum && tnum_next > reg->umax_valu=
e',
> then?

I too think Eduard's suggestion makes sense. We will be explicit in
the code that
we want umin to be part of the tnum.

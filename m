Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8522EE4
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267118; cv=none; b=SF5bsmiJF+Biiz5CWhGFxvCj87UFmQZsLdSc8ysQpLFTEyyBd5Tp3jYMjdi7l+pifJ4sJCez+7XCgEFrpxv5bBHQtOJuQFPe7SPgsm8rGMRLS+ZdsVq4NJIQ3fBGAkxs4xGVPihn+2++H4/aQPhawvpa10xgiPMmOy3gO1J2SKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267118; c=relaxed/simple;
	bh=L9F7FZ8fK3qj8QeFev1VlIkcVKLo5m4xEcZ/kF/ZjaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFlv6iNkocaMrbe3KFS8F6eb87/7vUl8RBdT31Meq1igKHlSyhIIJuR5P4Ey886vgfR12WyYw5lqzQWvfz0BlIWJKQzlbQDRwQ5CSES+EH4qF0v56xg9rrScqhMlFuXIMkzVkefPQTd94AupUbTXykNGtyCwlvIz+84fKP1JRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAAK7VO/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAAK7VO/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1163356a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712267116; x=1712871916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9F7FZ8fK3qj8QeFev1VlIkcVKLo5m4xEcZ/kF/ZjaE=;
        b=UAAK7VO/dPbWGpLnlfUh9yiwn+PonP4V7iQ/ynnf8vWwgE/+QMkEWrrGFhOe7mSF9L
         tztAqTNaWr9Nx2rVMnJ+pwPFj0NQQmV3INu4rAaHW0D3LmoeJ5vFh5sbsL+Y5/+E7aBr
         3g2SlCuL4cLDOl6RBZeT8ERrEmJHKT2FAY6/a4oYyo2INLTqB4lKrbb6zh4xq5kVTsoC
         SLb7yetzcCsu8e4TIEueVqIYeSzpMbgHqon0v+enQmuMEnLcbe3UcvaeVdegDJvW9UjR
         RrV+XUe/nXYbRZZlgyYfj4LuekpzqcbW+GkiD/UIXXIv+bZ5YFOyw2hUGh3E0fpFq/Wy
         xsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267116; x=1712871916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9F7FZ8fK3qj8QeFev1VlIkcVKLo5m4xEcZ/kF/ZjaE=;
        b=FrMYXvi1xpoY4zQlbeY8+exdBhU8sOMGik/og2VqjMCAT9u0Xe53O4G4lE7+eRhnl7
         W7VD07VH5hoAc3L63vdczFs0pUq11fLiMJPf1Q9HapdnF5jv8oJqmA9ZnJPqdBNWS9gW
         t8SEacAUIV2nX37tx9o0fv6yjIspqa6+KKnvrLzMOkP7m+331rv7jZXMn4n0+yWL1wMM
         /lZLNspFJddpuLEkP+/okg3ShO6iirTrDjNVWBrQwzXM96KddCFpOXT0NEqN9rZdR3pg
         XVVmKi3K1ytn/U+kUoZTxkT5MLjr+OVZWu3z0N0Nj2gNv1aM7RTHAIfSncWnDr6zVWsu
         fKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/s3DaG4MreyywPRxharj4+v9fp/azjhkZLxgxFzdiGvNqBr9UehH5wT0KWXhK+nyos/N8o6mzn54XU0QgfnoomzlQ
X-Gm-Message-State: AOJu0YzaaORcAhNmOzhKeaRUAUwLxzC+QsfaKPZwccNs/vhWe1mxRTnS
	QfHK/EXQrRcuebp369DPyNPKyEu8hNJtXYicK1ye8pHbvOP+0Elm3TZVZ3hzcZksl5kzihbddNz
	vjfu4OxzCtgKuYLO99mnyfOnQNrg=
X-Google-Smtp-Source: AGHT+IGWNXOxmhi0CQX1niyC7C2WEidfUYIkUcLYKIFb6qKGvJSOojFYsavin6v2wuzMawfHUNxJMLmhEjM1rbzPCDY=
X-Received: by 2002:a17:90a:17a4:b0:2a2:9452:5e45 with SMTP id
 q33-20020a17090a17a400b002a294525e45mr930422pja.2.1712267116355; Thu, 04 Apr
 2024 14:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404100901.7d6bc10f@hermes.local> <3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
 <20240404112710.25d4e99d@hermes.local>
In-Reply-To: <20240404112710.25d4e99d@hermes.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 14:45:04 -0700
Message-ID: <CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, 
	ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:27=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 4 Apr 2024 11:16:32 -0700
> Yonghong Song <yonghong.song@linux.dev> wrote:
>
> > On 4/4/24 10:09 AM, Stephen Hemminger wrote:
> > > I am fixing the use of TC BPF in DPDK to use libbpf and bpftool.
> > > Luca recommended using vmlinux.h to address possible build and
> > > CO:RE issues. But it won't work.
> > >
> > > There are missing pieces such as definitions of IPV6 next header
> > > fields (in linux/ipv6.h) and TC actions.
> > >
> > > Without major hack surgery, not possible to use vmlinux.h instead.
> > > Since vmlinux.h defines may things that overlap with other headers.
> > >
> > > Using:

[...]

> > This is a known issue as currently vmlinux.h does not support macros.
> > There are some efforts by Edward Zingerman to support this but this has
> > not done yet. At the same time, you could have a trivial header file
> > like
> > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/b=
pf/progs/bpf_tracing_net.h
> > to be used for bpf program and then your bpf program with vmlinux.h can
> > have much easier CORE support.
>
>
> That is an example of header surgery which I would rather avoid having to=
 carry
> as long term technical debt baggage.
>

What's your ultimate goal? As Yonghong said, vmlinux.h is not
compatible with other headers. So you have to pick either using
vmlinux.h as a base + adding missing #define's (because those are not
recorded in types, so can't be put into vmlinux.h), or not use
vmlinux.h, use linux UAPI/internal headers and then use explicit CO-RE
helpers/attributes to make your application CO-RE-relocatable.

It's not clear from your original email why exactly you wanted to
switch to vmlinux.h in the first place.

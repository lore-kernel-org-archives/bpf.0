Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0F279334
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287024; cv=pass; b=FHTwkB2a1isQcPtuYwIS8dnFytppd4KXogw7rRtN52Deu9HvEUUGGbFGgMk2XcQqqwmJ7Iv5TSoT9/eZZnXbbToKCf4eU/eJ5Qb5/9BahBqa8R4Yp3U/xX7tznHj2LAsdzzShar8fP9gx9KszW5g+I18UELibXnRNtTseQGh/ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287024; c=relaxed/simple;
	bh=GaaNZcjpodnsAzv4m2iPX05Zq7otswTnvY9FgzS0EHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdgBZNUJ3E628rqEb8wBc5X9oRG+0/6NaGFxHNvu+QvPGnrB7LHSBiV0QcmChshnqe5oVvYPdNT9IVqy3eQQIEwJKuKxJ1n8ocwewUiKBBGBBwKlcYySNXa1y9MAVjCMnNbNDpzSHCsSqyLZwXnxM6ePp3t0yyorKj4ggU9Evno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XsRY/SFM; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XsRY/SFM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1165a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776287023; cv=none;
        d=google.com; s=arc-20240605;
        b=FmnVNMga2kceTv21tOXrUxJlxs3NILC0ab/KhC9szhKee+Xje+Y889L0oRMPktkW8k
         wJlMKtIlUhf6bhu/9utCjL8m/cyMb7EB3dpoPgrRCVkejBHXqQHY9bot0jgkLp5kknNS
         id++qr6lpUi3AUK8/fBtWEc3B8F4UrsbQNgAAExyyDpzI8nzJz8dWkcjqWzWFbCGOZwR
         BzAft2IE960LU5lnTxMw/p7yYY/I3t4bpk/1YVk6DKsaFK/G6SEV2ZoD8f5ivw/D91d9
         N+L+7EEd3p6Vsicl2JcebZkOHf87ud9Kovsd9lcaFB4JH2C3J4Nu6LpFoIeA9w5HteYv
         O+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        fh=iIwsyDgdgwTzvoTyE8SLXqSaPQTT39NcXbanmJ5Q78c=;
        b=DIdSzxeU88/DZAiAewzkRu/CjGJeO6RCu3fWplo4Yp3figFJTWjgXyOWgL9hS58/QA
         VBmWVabuZk/ji9Yj0ND41OeY4khRKAGb3vGhE2Q2IBN86PnhNmTD1SJnT2q4X1RaPVDd
         ka1D4BwxDv5U7h2Hcwrndo+ej5EUrHzzgxeEKncXkZuF0VQvN6/bcdFGEEK8bGIvRjdT
         YeOVvNEi+UYnAxcHqQN4XzVNH8xYV1Xm+6ipMS5txMzw+DRwO/SYVbjKqRe+tHqi0okm
         45NfOJQyUovo/1R5J7vzQv8E/TCOHb4CFJUrzDtjAPNao/BSSAXeWDbq1yQjBMGNQ8+D
         087g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776287023; x=1776891823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=XsRY/SFMGYJCRXoivRO3oa5bLJ71GiHRIJmHzS5CrF5VUjJdd+hV8k6h8Hc8acy5UA
         yzCv2maRQmr3UoQgWe2BwKVdIFSSWgXAb058iwgFF5JGOAuxjg1etk+/4PjX0jNPtUfU
         F196m2hDsOIS+hHWcXKTv65cuesfDho6jb7u0fZwDdvNVDz96meOZVK0rjbpVwrZzRTv
         T/LRK7lfQK/1zur7SEA8te1lqaqQp1WcYuRZzZQSO6vMSPwTZTOQtXueZqAS1KEiib8l
         St6JQ9G58yL/vXw8hfuKPmmqe3FCUg92QZH0BSvagOrhGJLUUSTgse7gFR8UZkuZe3mB
         snIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287023; x=1776891823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=gvO2Ca11tUH7HS5Zr+vc0jIgNememb/fx3reVHoMAe+FyaX1149qEjmZn9IDXDSQ5o
         fA0Rku3mN0sY5BP7qYSDaUlBKI5/WGPRNW9TOa3nSIZsmdGGXFjJswNgEbBqFFT1kboM
         KfJD6NzhLwd3lVIaJiD7h3vJD7dX/2lSN6f3CKXn/jTFMg67yoonIakIk8FXoHWKkJOz
         4LQ3sry/BOlcwCHf/fejnuvVQY21FUYVpgCqjaM1AWuMtALZm8o/4H0eFvfH0oPdg4Vl
         wQMDa6y5U8AeFryGNWqVgwLSZ/SYG3Fqe1On3y2FfYf6aeAVzrj7XGtlNoTvFYSpiHma
         efDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RdgoYBYx2cBsIjL0PdreSfsbnkmlkdUNhM04JWnaPg25TCfCEWlI6P7MEDajsWKvtyns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92qi5reCSseI28hI7Lenj02/YEQO8968rzVxYzA/dK7JKbKeU
	yKRI4BPoAGOAQYhQPgRCuHbOvH4xOUm7G+t6ENm9kjgFj0N+QzxvJRlGZ2WAohzj/yWBsuv5LOP
	9HABxkfyEJSghigVYa8As+DQ0gy1DHfStiQhsaw7L
X-Gm-Gg: AeBDieu2x8P8qY4JOWgKghpiLTW2EqfEWE/TKlWcLMhBWVsla4VecCYKJHBrisTUuU2
	p3Up7c1djiYZ9RjO9JNQx9GOPz3DOw7mgGzsAyKzrfKkP2S9wT1lZMkJ4OhrU1N2mFXIraMW3KF
	d7oqhZfO4oES2M1wqpKleqA3+c2c2cX432DT/Yjd4XdKHzw1HCTr+GnliX3QqbfPAnTwD6xBtEZ
	hnoNSygYRY9IeUQyARIBKKvICKfyx7tv7FO2LVKfNpEGakHcSQEKZQbl0jouIWFiuNegYPHa6wT
	ePPh0Mw=
X-Received: by 2002:a17:903:2484:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5eaa22380mr5127465ad.3.1776287022908; Wed, 15 Apr 2026
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
 <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com> <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
 <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
In-Reply-To: <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 17:03:30 -0400
X-Gm-Features: AQROBzBz2q68BZW8dTm1i7JCyf7T-jJ8N457zfM2449jgU9ei1obevOWDfD4MWI
Message-ID: <CAHC9VhS1sVMGHpO-5Zn0K0w6suTB-i_SwvouDpEmT8sXffsRfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 6:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/14/2026 1:44 PM, Paul Moore wrote:
> > On Tue, Apr 14, 2026 at 4:10=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 4/14/2026 12:09 PM, Paul Moore wrote:
> >>> On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:

...

> CMW MLS and SELinux MLS can be mapped. They have the same components.

Yes, one of the fields in a full SELinux label can be an MLS field,
but that doesn't mean there isn't translation needed.  The important
point is that security label translation, mapping, etc. is necessary,
possible, and has been proven to work across a variety of systems.

> >> SELinux transmits the MLS component of the security context. Smack pas=
ses
> >> the text of its context.
> > Arguably the NetLabel/CIPSO interoperability challenge between SELinux
> > and Smack is due more to differences in how Smack encodes its security
> > labels into MLS attributes than from any inherent interop limitation.
>
> Yes. That is correct. The big issue I see is that SELinux does not repres=
ent
> the entire context in the CIPSO header. Thus, you're up against many SELi=
nux
> contexts having the same wire representation, where Smack will have a uni=
que
> on wire for each context ...

That isn't always true is it?  From my understanding of the "cipso2"
interface an admin could easily map multiple Smack labels to a single
CIPSO label.

It's important to remember that if you wanted to utilize CIPSO to
communicate between SELinux and Smack, the label translation is not
between SELinux and Smack but rather between SELinux and CIPSO as well
as between Smack and CIPSO.

> >>> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> >>> require some additional work to convert over to a lsm_prop instead of
> >>> a u32/secid, but if you look at the caching code that should be
> >>> trivial.  It might be as simple as adding a lsm_prop to the
> >>> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> >>> and not just a u32/secid.
> >> Indeed. But with no viable users it seems like a lower priority task.
> > You need to be very careful about those "viable users" claims ...
>
> Today there are no users.

That you are aware of at the moment.  You are also well aware of my
feelings on this issue and ultimately I'm the one who has to sign off
on that stuff.

> There are other problems (e.g. mount options) that have yet to be address=
ed.

The existence of one problem does not mean another does not exist.

--=20
paul-moore.com

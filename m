Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05E3ACF10
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024930; cv=pass; b=lVJZ2ZJRDVfyfE1vU0B0XLCd/R61K4D+ICS76WDH1h5NkyXM5tEMlASI+b51wAHmah0LWAxUn8USAmGu3zwgxqXDQi0DJbHA+bf21cGr86nG6W9fF7ga0II6LIugLLHknGO/ohxtyHm/McKmzDthZG40zeUpzr9O8F4JIlgyP/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024930; c=relaxed/simple;
	bh=kvxn37ehJt2t49EA7gAZMkRqtpC6ltaOhhejd2s2lqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDRnwtc6jXZeiDyE0rVs3uSkgtthR3JTYRzm1BrtoKuMQcf2I4J5el1px9QOAD/oFCU+U6wdr9pvgLjMgmKoD5fm0D/KWc409Nk6JN2awTF/+di98NwqtqM2nLdm5kMyuT9tAcL00+67EBQIFbUdOmRyWJkjuq//h0wZWe6EYQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNuP1rFl; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNuP1rFl"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65f9a875eabso705081a12.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 05:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772024928; cv=none;
        d=google.com; s=arc-20240605;
        b=M/NyZS+uQbfKOgOEKTu9OaEQ8DdPXRot8FQ/OZWYNLdRP/u9t0Q2A1ot64jooQ92P1
         U2/88vgUf05JwxNoTulBMi+kcCi1VNSyLTAwV2XHwljiuqJPJLC4MSbqteqU2H7Xexhz
         AZz2DM/FNfKi69MUzTGuuW4ED1eYkA2qe12swTrWSWpDcYcieG83AwTYHDG4F49vMfVU
         7oxOcZOBeV9gUj3f0fImL5AD2YRPJsc3HB9rcvOEF3gdmIPZSxKhER0Kq/mNOjbFZ21R
         NY2RxFZu0IgsGw6yeBKdT6PMZwh7Xo46kb74jbh29KspxYil9tN7rhk0HYi+dXzJR6jy
         +nWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+XbltfYDccqGspnnVDVacg3d+WFlsN4Jo2zXU+iHeA=;
        fh=0jq6H05DlkOy9w5kuzms0TDRL5YJlK3Kd8vULpo6tKc=;
        b=biuUyKSmjE2EiHqm2JFj+vPt52opRkTJ2bydJwceqV22wJPJeqalOAm/kY0AXGNCXO
         8Uj46GzFVgQR/Cb8hoDZVOMNZWK+8/78eJy11yHvN1crceGaV/2ypl/6gKkwz+G3uJvj
         nTotTYZ4VRXYA60h6OxY6plqp1MTir4Kxv2+8/jydT907xegTAGOdyqcJsd+MetV2aPO
         kmkGM1K7BMDb+JOfo7G4uEV0FqwwssxPncMKrMu6zQgt00fQxegzQ7zfKyjvOOWOrUud
         XXF1160kWI+VUxFvRuHHkS2kV2Z3SwNgdAWRgQewDUtw+7oHgs6ORJYYPTlKXrDhLlRC
         y6tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772024928; x=1772629728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+XbltfYDccqGspnnVDVacg3d+WFlsN4Jo2zXU+iHeA=;
        b=HNuP1rFlX9ieABCLqjw7uX79cQdpqhHUI5xXxcx0HXX2SO7t+8cLvqTQFYsLK2O2nT
         XsL8ZB4VZ3NrM2/ckk88/126Wfuq9omIl6SsTMZ5QZ48ElSQbtOVM8/ZK+RzR1XphEQ3
         +/m8ThcidGIhxim88fm+BHvVh7Ty/o2Ph0ap53z0SrNfEsUbAEW+wcUnJo6IuJ3a6rkm
         8yJVQD1pOn4pjxIeUkWuN15pL3HdWXUvcpT2b+vcgEIQv35YGCwxc++g+TY6NCe0ewbD
         Ah4NZAJk90gFQABVipkWx20bPfedE/vX4qhogdFQGBhKvt9K2TfeB6UzTJx5cBqyA3xy
         7sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024928; x=1772629728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+XbltfYDccqGspnnVDVacg3d+WFlsN4Jo2zXU+iHeA=;
        b=Cj3RJX2qH6xVAgX6+fDrKjzaoJ56LVgrwKD8ZbYamzYzCkJFLxSwhvgGO4VqVcEr1x
         wvEj+wkax+BZsCKSEkrTFgXWsG+FWHl5B/OsUvNPkDtDbpLyp0RmH0F4UmQK/hgOdTFD
         jM+dHrSrTDeoBx7/WrAL0DvvgJaEEQsHSwJ84506laJ7jAHRfm9eIpWMyH49EJRVlC92
         iCH4wx/+jD0RrDReJFPIQaJKzSIYexQ3m0mGIuAR+FVje9FKmktLq2mEcX+V5UwcWTO8
         OAltgxwEXpFbu0uNaKEsY8Hpc4iVeL+ZLRstzMPcnTH9pIWOsA+TEsWx4EWfE0cc8fOo
         d/zA==
X-Forwarded-Encrypted: i=1; AJvYcCUXhgGxltU6xnR4qXCpnffbXvDtrw1oXiz+vP11l7ycZ83p3YjOvilu1eSFT6XdwOtW8Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTVlErYh0Ck/20OMXrKAcgI1SdJY9AYVeMEWEKRd11NS85yvL
	mY0cQPattXx1Q7gbAQnrPTbbHh4BzVDUPnpUaeNA6Zssqc3HpDigREHhVXy5nuVrZAqxfql7WwQ
	yLiW6cSZ5sUl4zpDR9FKwjf1I/EQX01Q=
X-Gm-Gg: ATEYQzyib7hOXAMXLXNJ9e/D6v2czGnmgu9Dk9P3vI5gqkKac0xh02f0lfaKQQceQI9
	44AASpOZTR6XIDvPlLuYFgpf2Xxtk4/e0FXq4OKFEkGnLxnUBYqQIEHvtTAiI4VdoXQdYc073Rz
	R2/DhfE5ASK01KOkkd8XnrPsv5KMpsMQCZRkrQ9ciRo18JQ3P9pVVDp49h0y6HuMqjVnbIABtj0
	2U1tisw00rFcyNVa9TGuP5gYlcKTg+SIm0CVnG/gCEINuvrdOMqmos1L0E0/tPCMSTdKm3p3g4p
	ftM/TebT8ww5LtKSlRvdApg=
X-Received: by 2002:a17:906:fd88:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b90819557a7mr899153266b.3.1772024927378; Wed, 25 Feb 2026
 05:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224212535.1165151-1-puranjay@kernel.org> <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
 <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
 <CAADnVQ+vjJf9xy6Oy5dCy_F2hvKt6TwZ1jA3Xv2PxMDpkPksXQ@mail.gmail.com>
 <cc08ccc2398d3110fa85b76ef0452c46132fcc98.camel@gmail.com> <CAADnVQK+otFugLAS_6BSFgXVw9CfzcrDpJWZpnsDQXyAV37R3w@mail.gmail.com>
In-Reply-To: <CAADnVQK+otFugLAS_6BSFgXVw9CfzcrDpJWZpnsDQXyAV37R3w@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 25 Feb 2026 13:08:34 +0000
X-Gm-Features: AaiRm53Z-4QPhdDXEJNMoS4_Q2NU6SBTbJdPwgEf0Ae7tDX4-WuWFfeQFqUGx34
Message-ID: <CANk7y0jJMdhSt+pk5uwJVP0cpPGgpTsBZTrS=OhuWC-Zm1iKhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 2:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 24, 2026 at 2:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2026-02-24 at 14:50 -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 24, 2026 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Tue, 2026-02-24 at 13:46 -0800, Alexei Starovoitov wrote:
> > > > > On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@=
kernel.org> wrote:
> > > > > >
> > > > > >
> > > > > > This series adds KF_FORBID_SLEEP, a new kfunc flag that can be =
combined
> > > > > > with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FO=
RBID_SLEEP
> > > > >
> > > > > I don't want to introduce this new flag now only to be
> > > > > replaced with KF_ACQUIRE_LOCK.
> > > > >
> > > > > the follow up we discussed in the other email is different.
> > > > >
> > > > > pw-bot: cr
> > > >
> > > > Then the refactoring should be bundled together with this series,
> > > > otherwise it is very confusing to have a flag named KF_ACQUIRE_LOCK
> > > > and bpf_verifier_state->forbid_sleep_count, bpf_reference_state->fo=
rbid_sleep.
> > >
> > > The name shouldn't be forbid_sleep_count, obviously.
> > > I argue that the counter is also incorrect.
> > > As soon as we have two iterators that take locks in acquire.
> > >
> > > if (..)
> > >   iter_next(it1);
> > > else
> > >   iter_next(it2);
> > >
> > > will pass the counter compare in refsafe().
> > > Both states will have forbid_sleep_count =3D=3D 1, but they took
> > > different locks.
> > > So we need to compare refs in for (i =3D 0; i < old->acquired_refs)
> >
> > Current series does that.
>
> Current set does:
>
>   case REF_TYPE_PTR:
> + if (old->refs[i].forbid_sleep !=3D cur->refs[i].forbid_sleep)
> + return false;
> + break;
>
> Is it enough? or unnecessary?
> For REF_TYPE_LOCK* variants refsafe() checks ptr.
> btf_id will be checked by regsafe(),
> but two different vma_iter-s will pass regsafe() and will
> pass refsafe() too without 'ptr' check,
> but they locked different vma-s.
> If we only care about forbid_sleep then yes they're equivalent,

Yes, in my mind two states are equivalent if sleeping is forbidden in
both of them even if through locking different vmas.

> but...
>
> this forbid_sleep check for REF_TYPE_PTR is needed only
> if the same iter type can be used with two kinds of iters.
> Those that forbid and allow sleep.
> That's not the case in this patch, so it can be dropped?
>
> So both hunks to refsafe() in patch 4 can be removed?

I added this with the thought that inside the iterator body, one point
could be reached from a path with a release (sleeping allowed) and
from another path where sleeping is forbidden and they should not be
considered same.

> and then with a bit of refactor forbid_sleep can be removed too,
> since it's there only for:
>
> + if (state->refs[idx].forbid_sleep)
> + state->forbid_sleep_count--;
>
> if we do it similar to release_lock_state() that decrement
> of forbid_sleep_count doesn't need to rely on a flag.
> Potentially...
>
> > > anyway, but then why have a counter?
> >
> > To avoid re-scanning refs array. Counter is an implementation detail he=
re,
> > but bpf_reference_state->forbid_sleep is not.
>
> avoid rescanning for the purpose of in_sleepable_context() ?
> sure it's a useful optimization, but
>
> if (old->forbid_sleep_count !=3D cur->forbid_sleep_count)
> in refsafe() is also an optimization. It's not necessary for safety.

Would it be safe if old is 0 and cur is non-zero? If both are non-zero
and not equal then yes, we can just consider them safe.

>
> While if (old->active_rcu_locks !=3D cur->active_rcu_locks)
> and
> if (old->active_preempt_locks !=3D cur->active_preempt_locks)
> *are* necessary for safety.
>
> Yet
> if (old->active_locks !=3D cur->active_locks)
> is an optimization too.

Here also as you say, we only care if one is zero and the other is non-zero

>
> The whole thing is becoming messier and harder to reason about.
> I think we have to clean it up now instead of adding more debt.

I will think about this more from a fresh angle and try to clean it
up. Till then, I will send the two refactoring patches in this set
separately as they are useful and not related to this set.

Thanks,
Puranjay

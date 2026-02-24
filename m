Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB1330328
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962731; cv=pass; b=AllfPGtYFeFd4aPqOeg+7UpBeLi9IauZgbVilqBCTW/a92z0mdrCYucLYbRn7tQ5SZYDchIHMRWUOlQNo3OkVhkltp1wtYOJ6EQ43rrzX3J4dgZ4EKdJlzKgKmJvfdNtP7/PVL4w01A3gkTJ289MyRPRd3z6Z9mgiwLc02XjYvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962731; c=relaxed/simple;
	bh=SoixlidDiibOOpy1bBAn3Bjb0iw9WOkz1GIcGBKF5s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHliCYBrEXmCAWLAWmtQBZNFnr5LEEtTuFtZoyrdaHCyosFSGNFM2L82PKqAb54v/NOawYmrHebz6vmoOBtfqKpws2OKScr0RHnBrCPEOIy3d6zo+jKlMwQAEQIimCtdmrKn9rMw83jjK0+sCLEmrpRCaHGnwHdxGmZ2dhSNuek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if17CGpK; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if17CGpK"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8fd976e90cso802754066b.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771962728; cv=none;
        d=google.com; s=arc-20240605;
        b=XvYSJKBeCZh//rtS7HpmGX9K0USmiB+T8FeZ78ePjVVoePc2a8mQtTxpDW+9kRNL4T
         gV0FHll4gfvC9ig5f2lHVdt50+NkMRwutzrO35/IR/RgROCNbwqxA6O88Rt/9iCfJ7Oi
         K+GO4DJmAGVKFz0tj+gxcwMrRLdem9Z88cTknOYDxWnVOGHVe9aml5wKOzKRlBVs2tUv
         AT0wu1lYbn4vPL/zdzzh7zV/uHh5mFyFadOVJ4lrZtFR0SuB0Gfpggc1iWIgaHH+vKgL
         9/OTixB7WHZUZH/RaeGv2zPWu4RyA7wnf4j7Fyi/ZVIED3EF9KZDgHU4P1CSx+UkCdGA
         ZeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CW77RPxHP9c5AiefiMyl8UTV+Eib5tdUtzprV6NOeOo=;
        fh=ssiRGpjMl+b9sAWw2mtuNTXZnnnjl1IklYqlt7iCziA=;
        b=Ooa0i1FBpEt4kJgRibCspjddU3EWirr72Nuqs7Pq+OhHzRblkbZ6Nf1xZ6aUjdMevb
         p4wQ4J8TLvsOZJZYSWewW6TnTqY9om0pSa5YRTUymlw3f3cp1MLYn7l59TF/OUOiy1aA
         /Gj+hyQJMmzBRDDfdSOc1BjgC7xjR0DIcSl7UHGMhM2hWb0UXvjiGlsanYpxTy7MxHI5
         3vI5fvjS1cNh7NF98ZlynNCSTZ13I0W9wCqDIOc9wjfFUz/ECmsw1dyO5IiNZRW2BzZg
         ukZHS3V0zLPUrZ+3mFAgnCzE067UZEefAA3bV1QbsCj+5IbtbdvqbvjNJBvy5akOgYHf
         J55Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771962728; x=1772567528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW77RPxHP9c5AiefiMyl8UTV+Eib5tdUtzprV6NOeOo=;
        b=if17CGpKUNNf75v6igeiTDH2KSzVR62nZjaYbxfzyiIb1FDH7e68c5WTO+ICAAzoLj
         PTEuGQYAYrh+QPCzMQa6hueYB8Fm8gLNnqrVpeyzq5u8LFnNnVxhkijjAZLhuIpl6jg7
         +5c1Z2aBL1xENBa9lZIMY9Tg+MzpnFsPRcc88p7WObe2FzcoSIiK6bf6ehNv+l4guyr9
         a1XR+J2blwz9K6VsXEhNPr/UxsjhneT7EgMTFmhPBpDbMhabhdByOr67G8fd93D4MlYU
         1sxXETZQQ0hsetRp1y8a3otMKZlnfKjlId3EcQOy6nGiS0/5ISG/6bPdzIdignp6O6ku
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962728; x=1772567528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CW77RPxHP9c5AiefiMyl8UTV+Eib5tdUtzprV6NOeOo=;
        b=BzweQlRg3wbp1A4rFVFSt/49B9a1xj7MWEhZ2rB+SEZBD/e3bFCAjO+7rZ687RhYkN
         SXC5nYSRdWmmtSduuoCl3/eYChicXg3Lhi37Pqdm3T+5Sb8IwqmC8BUzk4nzk8w4Z3QV
         f3y3xzXX9uuim5Mgbsz9ZWQl5dN58P6tYVYxh5sjb8Ecue8fueuS3SdalpQS9V6f0r+/
         Rq8k0xf08wblt9c46OEkqq3LhVwkKFdCXUGIZ+N5oICfZeYkDhPZEs22StLugVXHz0JI
         UhkzdM66yaHRU5QQakvNv7suZ4hPZtk5T5A8f31D8Xt9Xu+Ew35c2gSbDT6UPiaUqG6z
         l/qg==
X-Forwarded-Encrypted: i=1; AJvYcCWV/Lcp2rIK6HJIU2/bVgOPngOs6cKPYL6EMGDfadmI2gFW6AKbtvvMvFLl4XHJvsl5rGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhnKJH5WWKB1aWo4PRA3LSgQTo9qskpUC30omz3BznJm0YbDp
	5KH4O57638zkTN/g8upAbEEumM/EBqCCvRr3sj7IHG52jLGBp3xZZfNsuoIw8UcSWOwItKz6Ccl
	7ujxOzTSC9rXIYNiQ2V/q78ts5wsh7vU=
X-Gm-Gg: ATEYQzxBl34DSt+JTuvlRnEa7MDl9qc436jP7/loHbpMAPnkrs6Y1F8Js0WRXrQZwJo
	dL8X7SsBPBqW6DXDXTLHcW7Qx1bcHEuQahsAYtm5mvF0B351JZFiBvJW09CWrGFldV7+kd4//Ik
	uesB1q39OQYStrFK232nHCZY2sUCLRQWudQdEF6kv8HB0celZnnLdJ8D0dXC5VwAeQmEouHGAT4
	IlC4DlFQuyZ3xv97JDQK4Ye1z6gZztD7ehVsoL0EDCaSnfyNdXd6X3cAAowPEvu+gGfV4+bkVDi
	HwQIf8vq
X-Received: by 2002:a17:907:fdcb:b0:b8f:a03c:ac22 with SMTP id
 a640c23a62f3a-b9081b77ae4mr907145966b.42.1771962727752; Tue, 24 Feb 2026
 11:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com> <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
In-Reply-To: <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Feb 2026 19:51:56 +0000
X-Gm-Features: AaiRm50nqWHH-30qUmv_6zCffcGuXUgLj-EWc-RF4A2gnUDmjipv0GZNgw0DU8c
Message-ID: <CANk7y0hv7TsJD5Ne_LaHpLiHNfMDJV+SUyXqnNftmC03fMTUBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 6:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> > > > >
> > > > >
> > > > > Iterator KF_ACQUIRE support is not useful on its own right now, b=
ut it
> > > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _ne=
xt is
> > > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "hold=
ing this
> > > > > pointer forbids sleeping; calling _release invalidates the pointe=
r and
> > > > > re-enables sleeping."
> > > > >
> > > >
> > > > The name of the flag and semantics bothers me a bit.
> > > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_AC=
QUIRE.
> > > > And document it like:
> > > > KF_ACQUIRE -> acquires a resource via reference counting
> > > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > > >
> > > > and to match it I would do:
> > > > KF_RELEASE -> releases a resource by decrementing refcount
> > > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > > >
> > > > When lock is taken it's typically prohibited to sleep and do
> > > > other things. So I feel such flags would describe what's
> > > > going on underneath more accurately.
> > > >
> > > > Thoughts?
> > >
> > > I am fine with this except, I think we should still keep the
> > > KF_RELEASE a single release mechanism that releases according to how
> > > the reference was taken (refcount/lock). There is nothing wrong with
> > > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > > KF_ACQUIRE_LOCK -> KF_RELEASE.
> >
> > yes. Is this too complex or what's the concern?
> >
> > > I am fine with both but prefer the
> > > common KF_RELEASE. Let me know which one you like and I will go ahead
> > > with it.
> >
> > Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> > but would like to hear a 3rd opinion.
>
> At the moment verifier tracks the following locking/non-sleepable
> resources:
> - active_irq_id        - nesting allowed, forbids sleep, special stack sl=
ot acquire/release logic.
> - active_rcu_locks     - nesting allowed, forbids sleep, used by in in_rc=
u_cs(),
>                          no special acquire/release logic.
> - active_preempt_locks - nesting allowed, forbids sleep, no special acqui=
re/release logic.
> - active_locks         - nesting disallowed, forbids sleep, no special ac=
quire/release logic.
>
> Currently verifier checks what kfunc/helper is called and changes
> internal state accordingly. It might be possible to slice the above
> into a set of "generic" flags / feats, but it requires some thought.
>
> Maybe explore this as a separate series?

Eduard,

Are you fine with making KF_ACQUIRE | KF_FORBIDS_SLEEP as a new flag
called KF_ACQUIRE_LOCK
and then keeping the common KF_RELEASE that will release according to
how it was acquired?

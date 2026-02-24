Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5C3396E9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964426; cv=pass; b=CBUgyA1FDH6CEflUhdmxiOizJ95dD7h4Xi1Op4iyoJxMZz9vCSKC+D1ClYKWWIh7Iq2XsxAuDryivtHU49C3QC4OKK8gZZxW8Ixj6MdyYqkYEDMrikMG8yZIyz1NY8lxbKFtvV8jkzWITySgoMXPqVAhBE7B3dTy2Keg6KdlrKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964426; c=relaxed/simple;
	bh=E6Izt/wASSMtz0Sp+VtYIvY4MqQmpRIkQuHSAZOgTBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq65CXfOLxmdQ+SXPeJehAAAdTQw+ehGijQYJ09mMc0Az2EHWfhyRvyWpCD7F/PC9hmFF90fXr1/8/O4lT6oy3v1KopvvkW26PKwnzcow2D3aC4u4IZ/UFmgBwzK0jUcIygvS78Er/nmFXrB37pFluBoKIDv2FIwajgEgmsMQ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLjCqjMc; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLjCqjMc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so6772611a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771964423; cv=none;
        d=google.com; s=arc-20240605;
        b=Az6R15+M+RyrEK5XMYAtqsdX7dkJd8xZRcoW+CL+sxtDRQpQ6ql7LvFRYPhKeYe6ry
         86t3Ir7Xt9MytYm+jN2ioS+bhsq3apIUDcNGYZAbtwRCBpultcnmoybtC5Ttg32nBFNm
         I9GXMa7+p8ej2ALI7Zh8rrO6j3YBJbDu9wYkl3YWJ1IyyV0Nzk+z413nHq1C6HRTKjwl
         gj/lNTclS+W59kEa3t8SgiS4zfrx+lz0Ql9fw014hetZdmNkVB6PggLe9SfMXwtTexCv
         IWQayHbpD+WPrxP/8+eOHaE3GMKAHgA/taLjY92bsKKBfBgtPJAz7VhE9ZCfP5jpPxIq
         hZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i58N5tBw33uwbFIeC1U3oiGYnkQzxwAsL0+QHlFuPoA=;
        fh=5TagfFmbEyJbPD7viepQ5yGjqWGCzQmMtAe0sUsFONM=;
        b=Jqc3N8AGKRlfnGIAvYQNYkXXJhZowevYIHmoVPueZSVk5pLub7mOgrCTR5pPx0lyDb
         iWcrjwXAcblFGXj/I8B/oaqmN5mJNxev7uBt4FiDNwkWsApadPrFjSql0IqjScgisOKp
         EO9MOQGX82v1w6IMV4dr/aLlSXn7vAmOt4Me3p498+cENkP1uw76ERlsrHrOpd7ysGg5
         amJtZ7tbQqqbUs9ZR+LVnj8PKn6l9PnodoiI15kN3JqUs2Q+mZ5vVLHvnbhSOO78cCRO
         P5j1H3vqP4YBIqFvhQOMRGZfkjxJ6C6PyCzvmEwiOY+qr3poq5IN+VeiEXmxOPJtj7zF
         xKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771964423; x=1772569223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i58N5tBw33uwbFIeC1U3oiGYnkQzxwAsL0+QHlFuPoA=;
        b=lLjCqjMcSHJvcDOH2C5E3FBPm4xqFtmhpuaMCx/ytfLxrvFXSmIkmKYH3hi61sg5Zb
         c9bVasz8VeOuS+8pduWKjcqmdigPJzt39KBUSxrEyOncRsjV7y6v6K82VVkf4tckm6qF
         EYqzumIX1XMTDyZliaIvTcKdmvxOxrtLnvwlPuUdBk7RBZccLwF2xJZ64xyGhx3GNSqZ
         1GUeR9mSLFYInFJAUiow5fqLelEl25Ya38nGEOQZvfZfs7/B2rOOuoyB3xDDpA5RvcOX
         GKUpXF06sxNgqa9hOnZd6BYJN0APfUsuItxQjpG2FP3cBGi2hO+qPDAhDKbwCK2fdgsn
         YW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771964423; x=1772569223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i58N5tBw33uwbFIeC1U3oiGYnkQzxwAsL0+QHlFuPoA=;
        b=Ffp0kU6msBa3XocxGTQ+HNybCEktpxL6A3c5+MLuS0y22niZ9I/r7pSeG1Zd0Sfi//
         rGhRICep5WTFdoZAwExz9CyCCVFz47O8S+2VwLGmJeW7kIdKKKwlW/qtBazXO5S1O4pG
         ZEaQDZkw7XgpmhJ+zqOjsYDwK3oictOdFUYHzPNF8souaIBROohTW86aXUywOLjW6tXR
         /wxFkp61DhseekGzUguYW4PK6cmUPVZmpadPZd4U3yba7V4IFwwcUNvCK7yVF1JiV7mf
         OLsV/uywsPkZR/dIOQ9Lc8tj7YcL8bPypYs8aRRCnfl3I915tB+Xw3IbopjU9E3QbXOb
         ZG7g==
X-Forwarded-Encrypted: i=1; AJvYcCXdYopWN/ODL8m712tZx6U9xHM/OUHB/+cEqM8E73TCMGSRZm98buZ2K5xH/jSqle/F0as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjZa0FrzzQysEuyfpV6nDfPVk/hyELKJbZhNNlLxyGr3ATzRK
	6PGO5nXJfxU2Z6AsZA/Vt3i7oXX7bGlCGlQLfNtE16l/l/FdwbzVAvw3fP6gk9D73JriwuA00zn
	Ct45/Tihn0TJ8ITGYSct0qk8e4hqWXMI=
X-Gm-Gg: ATEYQzwzzSQeu0UBrcB98ncSRFxODk2dnAiANjv3NiUhoeb+OV5sq825VQo/UTUOAvB
	pXgwABl5ygv5I6DIb8VDB+4CBJmShur5CDPZusPerwqndcJa+Vgi5cXDBpDtoGMsUW9njLcapo3
	GN8J9Tb/zhpuFFJI6VUqr/EVCggcQdTy6rNbWCKDPZu2g7/qtckJ9MZfmGbQQ/7e4xVrRp9Gvw6
	1AY98cUAxAn7SymBp0CaDbtiaubdttKoBWmtqfomzbHJqiS06Yqy31TvSnUom+ChqfqnYc6ezcw
	ozYvz0/ldHK9vAmeaxQ=
X-Received: by 2002:a17:907:7fa0:b0:b8e:fad0:6c97 with SMTP id
 a640c23a62f3a-b9081920c9fmr703201766b.8.1771964423127; Tue, 24 Feb 2026
 12:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
 <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
 <CANk7y0hv7TsJD5Ne_LaHpLiHNfMDJV+SUyXqnNftmC03fMTUBg@mail.gmail.com> <f3dec7da331d618df266383fd3f67832397464ac.camel@gmail.com>
In-Reply-To: <f3dec7da331d618df266383fd3f67832397464ac.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Feb 2026 20:20:11 +0000
X-Gm-Features: AaiRm50QPir1IQ4hwmYCUERebim5ZTk_kxxpy0opBmpqFafOu3nut1pAFhQS6pA
Message-ID: <CANk7y0jNL2x0w7TbTNbjoq1STg_BF5C7EasDMFpSfjHHgbOA4w@mail.gmail.com>
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

On Tue, Feb 24, 2026 at 8:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-02-24 at 19:51 +0000, Puranjay Mohan wrote:
> > On Tue, Feb 24, 2026 at 6:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranja=
y@kernel.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Iterator KF_ACQUIRE support is not useful on its own right no=
w, but it
> > > > > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose=
 _next is
> > > > > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "=
holding this
> > > > > > > pointer forbids sleeping; calling _release invalidates the po=
inter and
> > > > > > > re-enables sleeping."
> > > > > > >
> > > > > >
> > > > > > The name of the flag and semantics bothers me a bit.
> > > > > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs K=
F_ACQUIRE.
> > > > > > And document it like:
> > > > > > KF_ACQUIRE -> acquires a resource via reference counting
> > > > > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > > > > >
> > > > > > and to match it I would do:
> > > > > > KF_RELEASE -> releases a resource by decrementing refcount
> > > > > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > > > > >
> > > > > > When lock is taken it's typically prohibited to sleep and do
> > > > > > other things. So I feel such flags would describe what's
> > > > > > going on underneath more accurately.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > I am fine with this except, I think we should still keep the
> > > > > KF_RELEASE a single release mechanism that releases according to =
how
> > > > > the reference was taken (refcount/lock). There is nothing wrong w=
ith
> > > > > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > > > > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > > > > KF_ACQUIRE_LOCK -> KF_RELEASE.
> > > >
> > > > yes. Is this too complex or what's the concern?
> > > >
> > > > > I am fine with both but prefer the
> > > > > common KF_RELEASE. Let me know which one you like and I will go a=
head
> > > > > with it.
> > > >
> > > > Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> > > > but would like to hear a 3rd opinion.
> > >
> > > At the moment verifier tracks the following locking/non-sleepable
> > > resources:
> > > - active_irq_id        - nesting allowed, forbids sleep, special stac=
k slot acquire/release logic.
> > > - active_rcu_locks     - nesting allowed, forbids sleep, used by in i=
n_rcu_cs(),
> > >                          no special acquire/release logic.
> > > - active_preempt_locks - nesting allowed, forbids sleep, no special a=
cquire/release logic.
> > > - active_locks         - nesting disallowed, forbids sleep, no specia=
l acquire/release logic.
> > >
> > > Currently verifier checks what kfunc/helper is called and changes
> > > internal state accordingly. It might be possible to slice the above
> > > into a set of "generic" flags / feats, but it requires some thought.
> > >
> > > Maybe explore this as a separate series?
> >
> > Eduard,
> >
> > Are you fine with making KF_ACQUIRE | KF_FORBIDS_SLEEP as a new flag
> > called KF_ACQUIRE_LOCK
> > and then keeping the common KF_RELEASE that will release according to
> > how it was acquired?
>
> Idk, I'd keep it KF_FORBIDS_SLEEP for now and rename later.
> W/o the discussed refactoring ACQUIRE_LOCK is a bit confusing, imo.

Okay, I will keep it as is then and send v4 with the requested changes.
Will rename this in the next set which refactors these active*

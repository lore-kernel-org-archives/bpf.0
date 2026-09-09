Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399A446BEA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995308; cv=pass; b=BlP/Z2HZL33Lip20MgUnVn8jfpbnPm63XPfPZXusZO4+6Mdk4KjYzQ37OliXUatqIwHrqpgOglQVg/cIp9D3/NKbU0g2m1YiumFy1hmiBuMQHdKVo+bkMyhiyotSQaiHZuW8t2EPkM0BXyaKXHUIAQ1vI3PDU3nXjPn+ztkFxtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995308; c=relaxed/simple;
	bh=PXCiYUIUDFbcVYjS13LmGtnLqgKi8EElaJmcYhZhgTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+dIvdnGanlkR5TVZOd5eoBMhptE6I3Fh4qvS9sgBeRynXKkwOxw9jSO9Qe0ZGHIMPx2WhCdfWvW0VxEYrDMlv1EnfHnMe/wV3X7piOPpNV6Lt18FV+hBOuO6xZRDiRWam1D2+CgpS/A+ZjBnPWxi9IcDoLZYCXD45CvIK7MfK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V9+arPla; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V9+arPla"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2940d16190so138835966b.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 16:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788995304; cv=none;
        d=google.com; s=arc-20260327;
        b=rJ/39CG9SBZ/fG/crq+hlm+PjHR+8fBLIzlwTcKtm1/ECHZ4KVWE031BhMwsKntbDR
         u0x/pwM1lG8WWOMREFnKGBiVxBf2t1lv3yY++UFZ5v+W6JdbnAex7oqzH1D3A0rjoI2f
         xq7XrEXNltt3NKYtLrNkN7TSKPckkAsgD/VcSlcNeG9anejEU3D+KlxyES/sF8HnKPVZ
         YyvMa9EcrVFGyQmmpG0hbGSSISblyUqUhLotFa0JWRuM4xRwLHrc4E1gWMA8NFHqX0cd
         odXwhCUFY4JHd+wSar/KwvjMY3IB3LOhG8LYt8ib9svYPgYcZzm8jSHXwifnTmnGTpJg
         lgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        fh=KDvTxKFrDUKYEDJFYKxxUBOkTqiJ/VtFqwnjtm1Myds=;
        b=enKYQVf74Z6DvjxUdIK0kvYYNvVsML6JMmM3aHVP000moeu8l8BjjP/cLHXXF+TgF8
         QHZH8pyfIv4pnuvrZX6NebqdYh8sud1xuP2Y6blkod2jQxJHVTMRYbJLvmFL0d88uvbT
         kQmk2SW2uJHA1K5Jq42sOdWHeZtECaSuQ53KZy1ZjsgI73pYhrWZmlS4VnYaPduKE8aI
         J0zhScIW2jbSefxhiuDzlCcwCSy6XklyrsjJXmYEbHb1BCdB8o10PYl+ZNFLoqdfVy16
         1M5opnVNWsEsU8Ww+oQD1II2Au7vTzP4ZphI6nid1R7ZNRAOPpilXqjBSMNSU7e5NZqy
         W69A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788995304; x=1789600104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        b=V9+arPla0SL8qTc6bDoEa0KlmBKTUybqYAio8v07RTbEGg4p7JUSbkOyCeQlbQiKdm
         aNUIVrOuFwEvRQHmNAaaPyZQ5ZDpvbVVdAReB7FFGb5oSZGkSuB5h4N8cEhDxeX7Mve6
         MicGEG/4nRHuFOn9V9UOO1dsrAV6lrA38D0HmFtlV/GGyZh56NYoY7uHUogErRIExnvB
         rc/6q/KcbCwefGlgkrn2KoD/b12fmj9w+ia7aeqjRwthBCxmkIJYm5R4dgfpAIis38MK
         7g+8ILGrl9gyjr0XhnF+vN7pjldKPWRTMoh/BxpNZEqe8fs0vmbDxTBowkmMZUt1nmjO
         Av1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995304; x=1789600104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        b=a/9fZLwe2eVkLoGIkesSVW5UQPluwBqBrRDPGo8DlbVTo5OzcgVujZufo64VqgFpMc
         pIFAfh9iuut9SElJnJKi1hBQWN+c+NSSq3hUFzPnPPDGqXf46NsGRUEGKdkq7pCX8J/1
         lEmB6vwegE+whNsZmR9YLaI2cUJihPpLXQY0YjbRPLqfZUCP11dBQZFTgwycoSLDnJIP
         EtnHZeAY22tUIPhLawVR7oncO/nuuvT56viJb6APu5v7r4IqykKsSLb7ioIC59zhtxu0
         0YEI7QSjD7ZxFZ4TOD0UchvTP/oUmhtndbmKOzBXNH37Gq2LgwS7iC+GYFz9Um47eyZ4
         RcIA==
X-Forwarded-Encrypted: i=1; AKwUvBzUuJj6DQisbfJHSNAG13H8dxqaO4ujG4Yv7wBgS/0ykxMulxuobUZ7SMSnmL7sxYDOC20=@vger.kernel.org
X-Gm-Message-State: AFuF++lWBzmx+q3pmpQ7Y8EcSBiH6OIDCboRsR7HwN5iiZagj5I+EYGI
	ZYUUGOQKlxHnvQGWO5oukcMAlncFG0lgbEAa1kGk9iSMX6eH3FuFQq3L7446V1FA/TZKbT4ZVus
	NhF7QvMLQgy9TDELLbT4QGvU751d1u0wxkPyILBfN
X-Gm-Gg: AYBFou1Qdox3kTc+DciKZgWZyUbHdknuMYNslKHYhlISc8JAdoGYqaWaRVqONB7y1FD
	972AVE4ko8xHcDGdGxYgsMEQZdwUyCVcEKiEJ9W0rJ4LxBGhHCwyYgNyIxdirqxnDn0Og0fFHMO
	omgIE6zrI6FJ7Euez+gV3okMgDpPuO/S0D2xg11RvGZ2qgskC19EUq7IabEuTQpwkoBxkDc9Z13
	IpKog7ok3eY3EjIPkWkh6KmwAaTRMwWiVYq4nr8WZsgVQKiyTtDFF4VWwos1Lb2q4UtvLobefET
	FnL5HyiV0dqAs9xT7cIcCSBKpdsrRvlYmgtwZl1ExlJUiXPUqM0AEsqX7zIVRWHWZk1wbaoCN5Q
	ZWCAp2qPeo9A=
X-Received: by 2002:a05:6402:51d3:b0:6a7:f25e:31c7 with SMTP id
 4fb4d7f45d1cf-6a7f25e3481mr12004386a12.19.1788995303609; Wed, 09 Sep 2026
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
In-Reply-To: <aqHUw6k0Mf83CGFT@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 19:08:05 -0400
X-Gm-Features: AcwNN1VWtmI7TVPKE3LPkQppsWuLJXnoUTUb0EBC2ejua9Hn27X6xeBhQULdxgQ
Message-ID: <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
> > On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > >
> > > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> > > policy objects to BPF programs, with the first of them:
> > >
> > >   bpf_lsm_policy_release(object)                KF_RELEASE
> > >
> > > The kfuncs are the LSM framework's own BPF interface: there is no
> > > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> > > walks the matching hook's implementation list and calls the one
> > > registered by the LSM whose lsmid the policy object carries.  Calling
> > > a kfunc for an LSM that is not active or has no policy object support
> > > fails at runtime rather than hiding the kfunc at verification time,
> > > so BPF program loading is independent of the boot-time LSM
> > > configuration.
> > >
> > > A policy object reference is meant to be handed over through a map
> > > kptr field, so also register a destructor for struct
> > > lsm_policy_object: map-held references are dropped on map teardown,
> > > possibly from a context that cannot sleep, which the
> > > policy_object_put() hook contract accounts for.  For the same reason
> > > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> > > releasing a reference must be allowed wherever one can be held.  The
> > > filter itself is needed because BPF_PROG_TYPE_LSM and
> > > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> > > kfunc lookup buckets with other program types.
> > >
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >
> > > Notes:
> > >     v2->v3:
> > >         - No change.
> > >
> > >  MAINTAINERS               |  1 +
> > >  security/Makefile         |  2 +-
> > >  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 100 insertions(+), 1 deletion(-)
> > >  create mode 100644 security/bpf_lsm_kfuncs.c
> >
> > While not a new concern, it has been a few months so I want to mention
> > it again to see where things stand with the BPF crowd: are the BPF
> > folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
> > similar to fs/bpf_fs_kfuncs.c?
> >
> > If the answer remains yes, the BPF devs are not able to tolerate
> > kfuncs under security/, then I'm afraid this patchset is stuck.
> > However, if the BPF devs are willing to ACK kfuncs in
> > security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
> > for the LSM tree.
> >
> To avocate for the current placement:
>
> Placing these kfuncs outside where it is in security/ would
> be very awkward, the kfuncs use lsm internal APIs
> (lsm_for_each_hook, active static keys, lsm dispatch table) that
> have no buisness outside the LSM framework.
>
> And logically, the kfuncs operate entirely on in-tree lsm objects.
>
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6215fcb07770..ba816d7ee127 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
> > >  F:     kernel/bpf/bpf_lsm_proto.c
> > >  F:     kernel/trace/bpf_trace.c
> > >  F:     security/bpf/
> > > +F:     security/bpf_lsm_kfuncs.c
> >
> > We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> > the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
> > the VFS.
>
> Agreed.
>
> I intend that any security/ kfuncs go through both LSM and BPF
> review at a minimum. As a bug in any of these kfuncs or their permitted
> calling context / signatures could cause regressions in either subsystem.

While some other subsystems are lax on this, it's general practice in
the LSM space to *really* try to get ACK's from other affected
subsystems before merging.  Sometimes we move forward anyway, e.g.
patches being ignored for almost a year, but those are exceptions
rather than the rule.

I only bring this up because the MAINTAINERS entry was pointed at the
BPF devs, not the LSM devs.  I would expect that patches going into
security/bpf_lsm_kfuncs.c would need to be ACK'd both the LSM
framework and BPF LSM maintainers.

--=20
paul-moore.com

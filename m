Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9D348C5A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935788; cv=pass; b=k1o6DUPI1am1zBgf1M4UCbQUWvQIoDdMlr5+CVMJU6cLTgvFMps+gMN3j+fNtbJclaVBY8SMFbg/pm830lQ18hwVehwczJ6efiLNdok0/EJkpsIYIZ8A420VxQn+l5pf6tgklJMPRi1oK8QD4iAM1Cui7y6V66J96P0gndv7Kr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935788; c=relaxed/simple;
	bh=n6YHQIP0YEZBjX3N4RIfYi4Tv10PSi2zYyplxcrhn8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glGvoEYRXBwaLbuwaThspnre+RApIVXILG2tRu5alU9WoAER3ZnYbSYyu2s2MXzIfRFy4K5OHZu+mCZNDKMIwQx0GSAiONvQEGZfnv6rhOA04XhDUFS83YaCskto2EW8Qdw09R96XghuOUyQayFWug89efDoIGtdDkK06Rq8nPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cpAdbRH7; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cpAdbRH7"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso768855a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935787; cv=none;
        d=google.com; s=arc-20260327;
        b=jlhNcvmqbwOwk5LPMO5Zow60okdxUpITbNT/IedJ6YS5mcyus1soV9vso3+FfS0ltb
         Khq0GFxYVbsenKmRfaV2I4yk3KbwBq4KwZGOBqDTjrycP6RHU9G2O96Rxs42E6aH5Kde
         WZzipeHAEQKHeohFCP6am+8MEL0chMgK5sa+4wDBDF9UfH0+JL9ya/rUjx9Z5aIcKwOe
         lSxHn30qQITGIHaCf1kY2Dy1ObciEL2Ig1HJOHyo0YyCnssOveWyXRTlqropLCaqDt8S
         FQHRBp2paLkXUBM2Jci3codWzP34r7fBo65itPJ7ts9BABMJZbCPqE/sG/fsVkkiiEwF
         yczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        fh=9eE7jAgy3dMZ3FZ8eM0Uwwoc2j5cXiveyEEWXJgyjCc=;
        b=Clmj1qhmPOPIph9HQNm/A49qNsBuVeLwW2H3gYGrS4g+gj30E48AezYO+wYdlY0GgW
         XERUNkHTdlKHiK2xc5e6GriLQmGrcGDmC2mlN1lXJB4YrcfxBmy4lO7jV8kEsOw/pXHq
         /MV1fWHuyc07+yppom0fWlohs1joYYAXD8GahGjHl6VvZ66XfyiPi5UKQ0Ij/mBob9MO
         d0+CT02WD72OPnPFu4SDGY/qkXac4rnwUTZ2s/ZhKlrPfO8jZXhk9pX71bToBW44L7b1
         bW7067LRYSOy8UAwZxChgtb7TdBsh4hMNSASGX53rinGPIzxzvDoKKYwKfbms7VdoGMq
         3QGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782935787; x=1783540587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        b=cpAdbRH7t5xAMwguDDuZK37rPcEOaYzQ4ETTYy9WXq6WKUjUW3ouLoSVzV5uKd2dSx
         zxaBFrPb00r7pIIwa/qVQBvngoMQKUser31oKRm87CahPJCy6wh8+T83fwnF/Z4xaZyf
         W2GceJ+KPjmm4wyycgPGexEym9ouWL07tnCzExbNVCUvfk/0Cuv4b2mnd6nH0EguB5Pl
         dQRuTgMwZwE9mDrHL6IeNvWsFSHh0guy+I6UdTwWdZ3AuAgIpfOlj122dBrzrmJLjHSN
         qtlIywFntFuCBmxSXwI25QEXl5GMN7o/GSOlTuZKvQ4/dKRhvA5dHZnO+sWjfIMvQfuM
         biwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935787; x=1783540587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        b=sv3D7G/mXy0UikbrFafzIVfXw9H1QiB5eIXY2L1Ao8kttsc7u+zFFsMJsgTLxxB+3w
         l+0WMMfeFbPyHpf4kueN6LVovFJrh3u5nMUy1R6mbWSSupYOKJS9HG4GHPAvSn/v7JKI
         k5qc/s9AGc1FuAy+ptjOE5TmkidbyPEeDAAHgbNlAstWA5vUKr2kqM3QokMKQbICqEyx
         iWtc0RXLJLETMdOEChpe4ggrwWIa/c/uKH6jZYzZSD4lSfIYXQogw4htjj46A7hRWe1C
         dKCV5Yz8ErxRmUhTgqvCkWFUdE9stQ0POPJszdGthDZcTnk3r15b4/iX5OoB2nWMu+lE
         Ub3g==
X-Forwarded-Encrypted: i=1; AHgh+Rp1NkgL+DSwXGwI4ZWQRGFcJFEeXMZZfLOWgTiN2yHJ4QwD/9Tz681xWBU/+Qar2a0jvMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Q0tQE9Ys+8vjB8HoIGRB5wgHj4yVjK92tAMS4Hs/TBR1HP5Z
	Q4J5PhsyALo1K35518Hequmd0sF8eyAMmPhbec1sTxtawcy3BXywCX73jARtCcTF2mPNgJtp/xL
	RglkfRuYVB8uBfixh23VLk8tazo78QB0TPhYW84M+
X-Gm-Gg: AfdE7cks+q5+Kz8lC/forQcHHnQArzS5bQIy1GJ/LbEnQ6DI3u+R8MVdZaIoExV0nAe
	/WU0INYeAlSePgxvlnC/WJEdrZk7xp+3Y4pd0xVqxsIsF03r9ySpyMnkIZN2w8Revl7YxSNiowi
	PNTTUQBZkvWhqXQSZqUHjlxlRO33efpyhZNRwb2Xh7dTgbkwatWa0Gnix0BV7jbekGyjpK11E0h
	4elKGvtoIloMcPRrhOxxCEUJj1OQFWUx92nYZl90aGjgvCSeogMrLAjr4QGnGqZIHd/0NrD
X-Received: by 2002:a17:90b:3dce:b0:37f:ec5e:12d9 with SMTP id
 98e67ed59e1d1-380ba8d5433mr2217986a91.16.1782935786771; Wed, 01 Jul 2026
 12:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net>
In-Reply-To: <20260701.oTeikequi3ee@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 15:56:15 -0400
X-Gm-Features: AVVi8CchkWBXMOb3h-xrc92CuqNk9C2bKMYW9zj_XiDt_Bb5zyUcKbp9tgMfNuk
Message-ID: <CAHC9VhQKda2hBaNkb2OcqmEg3S_2n7HwQGkFFNDNaxMkTCn1TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:49=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn=
 <mic@digikod.net> wrote:
> > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > > > Create 2 kfuncs exposing control over Landlock functionalit=
y to BPF
> > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset preve=
nting callers
> > > > > > > > from accessing unstable internal Landlock fields.
> > > > > >
> > > > > > Generally speaking we don't want to provide APIs, either in-ker=
nel or
> > > > > > at the userspace/kernel boundary, that are specific to a single=
 LSM,
> > > > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > > > function as examples.
> > >
> > > This patch series is not about the LSM framework, only about Landlock
> > > and its specific model and use case.  Landlock using some of the LSM =
API
> > > is not relevant here.
> >
> > Based on a quick look the patchset enables BPF programs to call
> > directly into Landlock.  For the same reason we discourage other parts
> > of the kernel to call directly into individual LSMs, we want to
> > discourage BPF programs from calling directly into individual LSMs.
>
> We're OK for a dedicated kfunc to call directly into Landlock (with a
> tailored interface).  Landlock is designed around its syscall interfaces
> (well documented, tailored, tested), and this would be a new user of
> almost the same UAPI.

Larger issues exist beyond the suitability of Landlock's API; in fact
Landlock's API isn't really the issue as far as I'm concerned.  The
issue is that we don't want the kernel, whether via C code or BPF
code, calling directly into individual LSMs.  We don't even support
LSM A calling directly into LSM B.  Any caller making a call into an
LSM really needs to do so through an LSM hook.

I'm not opposed to allowing BPF code to call into Landlock, it just
needs to do so through an LSM hook like everything else to date.

--=20
paul-moore.com

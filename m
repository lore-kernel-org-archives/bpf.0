Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA71358393
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791253; cv=none; b=i+Wb3VpaQQSzwvIbU5tTtw9iiDWLHNogSMF208ilybp73cz97WkZbkG2qyZDBmAXMc+VdaaVhxEWozAxZw4xGHlPzcot9PqU+mTejb+IzjN+Od89Bcaj2fHU/nLRFYgC2OrBkM0V9Y00Oo/jAv68/ziq9plr0f5/v852zjCvjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791253; c=relaxed/simple;
	bh=Otf5TtKLt3P6lmlkJiFtklNIKvRQIvt73Bnw8pB5Lrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szko8n0ajwZ/DUjmM4I8Wr2O0hm+shnf7d9SHH5sce0Y3dYK250yjuvGNqS+8Gk1QXPvJUDt4/+kyv98dZ9bcMq/MDTgUE0vui7gqRKzPoh4lORXiN93aPGBcYUy8spv7iEKc6QQXE35Nx2bJ5TalLyRG6aIn0Kh0VxRe60s1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+LLFH4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+LLFH4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5209224f8f.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772791250; x=1773396050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si6gJZflbpg2/p8TcnKsUQK0gcIs9I1IuQBcaW/7KB4=;
        b=O0+LLFH4CjESCtwLlLJeh9nqEj/q3N7wgtxn8/OZ0tEsbL8PkRD0V+ScJcLtea6TR7
         fPYcwKKjK8he93seRQ+9b46fKlGGZnxe8DW075+l9AjWrSEmvMsk0Eddq81yvfk83CJ8
         TcbGSDZP0Yf2FWlMtFHEYwb7GtKIIj2omC/gUR3rxF0m9VO/ruTgHy/o/obN9Z/vfDSc
         Wv5ZSZgl60vQGChKb8CLNlVQ7zpG7HoYR8YpiKWqOlx8WnZCrNinL/S06S+J5LlCDgM0
         c5Al6B2QoKPhXuwpsJqAP+9KtHejyVw641k7dd3zixpSENUCNJ+wNshac1k7FOqnAsHV
         qBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772791250; x=1773396050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Si6gJZflbpg2/p8TcnKsUQK0gcIs9I1IuQBcaW/7KB4=;
        b=pr9KZfIsbpozArDtEYib1rr9A0udx2eUnbao9sKjRipj3kVmvpI7tQ9jJwy6s08a9K
         R1byLFrt3P9ek8JjHC2cCzl68zeBaaYF3ZJv4ChG/BJLxD4Fwr5Lz3IERNwjoFtz8mkE
         bI7GRa4ufsceHvPHfRFdEb2OHnHqI7h3DHa1xTtVfKWnHXaLibLHgZMc2k47/UfSyx+c
         5ddhlSf1KgDpDdkff3pBmzUxJfJsmVhkSgN7TGCLyS9PhZVGpQi46RC4t45pPohAaWa1
         qDB8iv0+SYX45/vg7zCS9eTVRZdfMbEXlyqCoqB1z5NqRGw049ixTROzy3Yp1Vr3Ry2X
         ti9w==
X-Forwarded-Encrypted: i=1; AJvYcCWltw9nC49Y1ILxw6jpWKQwh1/qcedHa9vr3Bnd74UBIKvWydunAM8KhC+Aj8HP5IlD0Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3rzbu97Ea8YLBt/H+jVVgRZ8VRlEEyErvu4sDLbWEKSnr3ZC
	ZgrHk+qkErGf8dtrJ223ojzV4NSJeYg8E9AxylQwd/AeoOSJGH4qwkSs
X-Gm-Gg: ATEYQzzuKjfGDT3v7lkETYJsDaxl67LGmOfSJl+oPYOkdQtRfqhZIJtmonESQ2waxAU
	5wgw2V5ROqas0TtIWMY+IhPZYNpWrvbqcrmXEmrB6pRlIhlkO+olS6OtuzJLfYfyK4GTvXCuXIS
	kcA7bthFYEvC6IkjI2atbKIMuevDJfD5wfra1vIKCKviT3S2y/FckP7YJXZClZ3Qakb+i9rODH1
	cDO8mvnSiXZJWJrpPEC0Ch8nxcvorXNNhhL7VU1kvMtHWj0fBLReKBpoLczuNKFR4sL6T1lYUPz
	uXWx3ymIDU7OqiRepMZhNLbCR3xXHp7SQD1/9OP4/lEMRWTOaFKNH+3aWd/UlqaWJje5gMYx3r/
	doO8h2DA+KLk04LZ7eSW0wczG5AQfWMwoFtw6FShvWBZ/aofLBuGZF9O+3QFqQFU14iV/hJU2JD
	wnlqHB6Res1WKhq34APnTayYr7pp8OdExuJ5wYyUD5D6q0Ucz+p00g5qRdbQuj6JY6
X-Received: by 2002:a05:600c:3b0c:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-48526918944mr23274095e9.6.1772791249789;
        Fri, 06 Mar 2026 02:00:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485245e0f53sm13970035e9.13.2026.03.06.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:00:49 -0800 (PST)
Date: Fri, 6 Mar 2026 10:00:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260306100047.7c4725de@pumpkin>
In-Reply-To: <CALOAHbA9u2sHSYRF_kDKpf2d_UADQFu-1BMWFhBTo3mvgf6kFQ@mail.gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
	<20260304214447.3e5817ea@pumpkin>
	<CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
	<20260304212802.458b878e@fedora>
	<CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
	<20260304220019.3efa12ab@robin>
	<CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
	<748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
	<CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
	<20260305082125.35d8539c@gandalf.local.home>
	<CALOAHbA9u2sHSYRF_kDKpf2d_UADQFu-1BMWFhBTo3mvgf6kFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2026 10:22:11 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> On Thu, Mar 5, 2026 at 9:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Thu, 5 Mar 2026 13:40:27 +0800
> > Yafang Shao <laoar.shao@gmail.com> wrote:
> > =20
> > > Exactly. ftrace is intended for debugging and should not significantly
> > > impact real workloads. Therefore, it's reasonable to make it sleep if
> > > it cannot acquire the lock immediately, rather than spinning and
> > > consuming CPU cycles. =20
> >
> > Actually, ftrace is more than just debugging. It is the infrastructure =
for
> > live kernel patching as well. =20
>=20
> good to know.
>=20
> > =20
> > > =20
> > > >
> > > > BTW, you should expand the commit log of patch 1 to include the
> > > > rationale of why we should add this feature to mutex as the informa=
tion
> > > > in the cover letter won't get included in the git log if this patch
> > > > series is merged. You should also elaborate in comment on under what
> > > > conditions should this this new mutex API be used. =20
> > >
> > > Sure.  I will update it.
> > >
> > > BTW, these issues are notably hard to find. I suspect there are other
> > > locks out there with the same problem. =20
> >
> > As I mentioned, I'm not against the change. I just want to make sure the
> > rationale is strong enough to make the change.
> >
> > One thing that should be modified with your patch is the name. "nospin"
> > references the implementation of the mutex. Instead it should be called
> > something like: "noncritical" or "slowpath" stating that the grabbing of
> > this mutex is not of a critical section.
> >
> > Maybe an entirely new interface should be defined:
> >
> >
> > struct slow_mutex; =20
>=20
> Is it necessary to define a new structure for this slow mutex? We
> could simply reuse the existing struct mutex instead. Alternatively,
> should we add some new flags to this slow_mutex for debugging
> purposes?
>=20
> >
> > slow_mutex_lock()
> > slow_mutex_unlock() =20
>=20
> These two APIs appear sufficient to handle this use case.

Don't semaphores still exist?
IIRC they always sleep.

Although I wonder if the mutex need to be held for as long at it is.
ISTR one of the tracebacks was one the 'address to name' lookup,
that code will be slow.
Since the mutex can't be held across the multiple reads that are done
to read the full list of tracepoints it must surely be possible to
release it across the name lookup?

	David

>=20
> >
> > etc,
> >
> > that makes it obvious that this mutex may be held for long periods of t=
ime.
> > In fact, this would be useful for RT workloads, as these mutexes could =
be
> > flagged to warn RT critical tasks if those tasks were to take one of th=
em.
> >
> > There has been some talk to mark paths in the kernel that RT tasks would
> > get a SIGKILL if they were to hit a path that is known to be non
> > deterministic. =20
>=20
> Thanks for your information.
>=20


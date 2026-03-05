Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F1379999
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703179; cv=none; b=ocvhb0iZ1PfLYaoxNlTxM+5dyt8Q5c/TCnlS9/qExA7z3XNuVnthVKXInjZxPxPcJbyPSo4cMFm+BgpmbyxkFV8/rHnSybHiScub0ZRloHGTdOhBcfGDyJ9wsQLUi7PpoNkLGF9+qkgN+WkQxA2qT/u1uK4iB0q4yycs/NuvGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703179; c=relaxed/simple;
	bh=9PYOb+VpS5iduMsjRQAstf3pfoEPKqF4vCLzhZxYmzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4vzJM/Pyg7YInVX9AaO/LLi3n5USbNWnIk/68ilySzvfltllLi/xyk9tHAu+8bDqBI02gjuaAcGdikLXsNn8bzvggTcUw6ySLMQQLRz3jPo+Dy+m/QE00FeBk6kE6xTGMMN5CIEWT1iB4t5oopgjHYSdIS/SBrWH6uMuthq6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcjOgqKa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcjOgqKa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483770e0b25so66224815e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703177; x=1773307977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Wh14Cu8HPwYp2aF4AzVWASloPNWhH5O37QCidUK+E=;
        b=mcjOgqKak919W21aNiOfDWp3RExh27bIzdoIxIC4k58wQM4+b6YOrFljmyeqK/3Snd
         UyoDhIFVRObN6Fp1wc8I05j/16qrFKwbiU7oK33CfvMkOVYlLBP6vRSb7yybQLun09rz
         Nw6J8yJosxvThsVFKfxDV7uWnObxA+CKDCC0iU70qjfRFs7M7U0rhbSsn6+6Swxohih1
         8bKSxJI++wSK73E++jRfvZ63EH/8TyVexW3a5qqyhbO2oMlPcZ7+odbc/0E2pDbFHhlF
         fxdz+abfRQ548SA2fp4i4i6VkDAt2etu7DMYwVozDBZRJLsj79/5R0WQDEdplHcT8Hfo
         zZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703177; x=1773307977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9Wh14Cu8HPwYp2aF4AzVWASloPNWhH5O37QCidUK+E=;
        b=XnALSqitvPN/ZE0CYHRV6+p0Cef/A+mf1tLW9sOI6jo7zAW83ezwifXMgjO1CvzM40
         Qe12/nt0kjQTJI8Gd7YOFS5nu1+8I9irdp4AzITaH2laScP7G99ZRd5joZWnByecXvJZ
         61GwttJgofzP9hdqjyBH/VhN4GbWpOqqiEfXceCuNF2MQSeA2qTgJk/3AT7xpR8WGmyr
         ZSDtoXNuMtQSRuyCyIYKGd1fv+/l7FK1wWnO1eEYOOjg73p0u6Gk2Wu8J/u2U9cRUzmv
         hxxuzyCKXUd2abOv+N01/ug0HetMAv1hp4FzeXGOcKNIHvp+5eJgDwwTwCLX0/t9SuQX
         zJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXc0hkZp3NXLRywxl48UEHI3mQSqyFKa87zpBO9QXhkKX2EGGJG7nAtdpEh7+fIBZFEdJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLbDGCDCqYU5PqzTDauoYKjAccUkdUG0676hwr6TQLoyXADHo
	JObCGG/R0HnearITMVPvGuCp5yIlx5tjDIsfjtu04e7E77y8gDbyyGTs
X-Gm-Gg: ATEYQzzS/ib8qsGxNQZqIC7eZMOD5R8W2ScQZc5s+iRr2N+bXmXVi+sKy+Fmb/BMq9L
	llw7fAvr8CeX7sBm3posGAzedW/DhYNsIjY1ig045BrGV7v0VYOV4Odb6hTmH+Wy/cq0rkz/c8y
	M1i6MFrY8mjYnjFAdg9XAS+S/HB5+LWmBEOMMbcZe6zu/EhBYYR9ujstMFIXKJjihXc0WR0CXvY
	ehsYU0o8h/wAfARxyGHy0zrkSwOcvxUgAAe+p0IsXjQ8su82of5oamnqgi2+IAoIxeZCGWXes3M
	bVHyUsVPRO3PKvxwl0ueHxkyBk8jSXEcRbCJZbEz6xh99KnxsAIUcqLR2ya/013p8WiA1+4/zSH
	4KybkWzYuk7cUBwUNwHSubg07H6yeLLoJQIxl4OlJ6vx0J7YHMierw5MMqE3IqnB0lZtLvv5zrl
	Uf2e+fyFhQ5LMwlMIxsSNPPdXIqWQHfCth3wY2eFXnowtshfpDUu/XtJaeFIMfhyYrJEbneL6nI
	iw=
X-Received: by 2002:a05:600c:64ce:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-4851985aa88mr86271115e9.14.1772703176565;
        Thu, 05 Mar 2026 01:32:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm63043525e9.9.2026.03.05.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:32:56 -0800 (PST)
Date: Thu, 5 Mar 2026 09:32:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, will@kernel.org, boqun@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260305093254.61facfb6@pumpkin>
In-Reply-To: <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
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
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2026 23:30:40 -0500
Waiman Long <longman@redhat.com> wrote:

> On 3/4/26 10:08 PM, Yafang Shao wrote:
> > On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote: =20
> >> On Thu, 5 Mar 2026 10:33:00 +0800
> >> Yafang Shao <laoar.shao@gmail.com> wrote:
> >> =20
> >>> Other tools may also read available_filter_functions, requiring each
> >>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>> impractical solution. =20
> >> What exactly is the issue? =20
> > It makes no sense to spin unnecessarily when it can be avoided. We
> > continuously improve the kernel to do the right thing=E2=80=94and unnec=
essary
> > spinning is certainly not the right thing.
> > =20
> >> If a task does a while 1 in user space, it
> >> wouldn't be much different. =20
> > The while loop in user space performs actual work, whereas useless
> > spinning does nothing but burn CPU cycles. My point is simple: if this
> > unnecessary spinning isn't already considered an issue, it should
> > be=E2=80=94it's something that clearly needs improvement. =20
>=20
> The whole point of optimistic spinning is to reduce the lock acquisition=
=20
> latency. If the waiter sleeps, the unlock operation will have to wake up=
=20
> the waiter which can have a variable latency depending on how busy the=20
> system is at the time. Yes, it is burning CPU cycles while spinning,=20
> Most workloads will gain performance with this optimistic spinning=20
> feature. You do have a point that for system monitoring tools that=20
> observe the system behavior, they shouldn't burn that much CPU times=20
> that affect performance of real workload that the tools are monitoring.
>=20
> BTW, you should expand the commit log of patch 1 to include the=20
> rationale of why we should add this feature to mutex as the information=20
> in the cover letter won't get included in the git log if this patch=20
> series is merged. You should also elaborate in comment on under what=20
> conditions should this this new mutex API be used.

Isn't changing mutex_lock() the wrong place anyway?
What you need is for the code holding the lock to indicate that
it isn't worth waiters spinning because the lock will be held
for a long time.

	David

>=20
> Cheers,
> Longman
>=20


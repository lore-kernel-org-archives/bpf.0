Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B003ACA52
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956051; cv=pass; b=h3opjFXm6mYSuDbmCf9QHRCBFMD431Ha+ttyRY5dGjj/Zn3bUwj+ipnnBGJUsEQW/CrcygjTH1w+LQBa78NmsCPp8nUbLrzySveW8lbkNGwnw090UaZzaOE7poc5XKrJuwBZSUKcw2Pp4RybWvX42NhmrtISjPZFmzDuki1U2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956051; c=relaxed/simple;
	bh=op2WAl+A8WCV2+n13UwckpDZcDhru/asS1xBQHlPgsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxhwwo52SmdEfD8USRypwkFTh5VRZcP+N9dY0e3ASRnedGzHdAmgFgkeE8ZoaJgK+nDn/FM5FWC28WBcis8RygOGbN26XGs41gaDVutlEs9o9DESYUyJWEM+3boYWMV0ua9r4qAL44/qPSYdfYSwGSFFNieqqOL6qodNreRdOBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhnUFbqN; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhnUFbqN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4362507f0bcso52008f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771956049; cv=none;
        d=google.com; s=arc-20240605;
        b=QoRgd5n58PE7wH/Q5t4cT3a/l3N6/dbARlvn7cbHDFaSuTPVfoGYFffsZnsN1NCins
         Uzvjq3GKKpnH3hBjOZR86qmxSjFjWc1Rt/JAAf2reUCF6rvXYXls8+iT0Bxv4MlEJO1S
         XGxa4lcUChvMI9Mw1uV6pqB+zTSuwfHK0AHVbI7NWcYp6nN4fgo5v/HZxLAyM4kiE7+r
         WunxzaQckpCzey6zeVzLkv6qP3HPV6cfCBBmpTTa3Wpbl31sjpLXpbs3TxUZtIwWDSCD
         WEEHKJzygHDwDVSo2fUQrYOeOEkKkEqDCuexqKXq3AbXFHZPm4c5GXq1YBTEawc5/ds4
         PDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=op2WAl+A8WCV2+n13UwckpDZcDhru/asS1xBQHlPgsQ=;
        fh=V+pBgdWCGc3eEx30o3EZqXHeWkGtRTtxD2uIo15vuaQ=;
        b=iupZAIR0rACQice010lp2sjDQ0evV+YJ2slmDfTBozUh8CkST9mlHDr+piRE7hn30B
         /QbMTQNAClYAZAwJuAKVP6KIjqYUwJSgaxbgCa3lXOEIovQUSu5y2rLN0BxxNSiuxjcC
         5jh7x/dl6Jrgvnb+qkCmnBNczJ5YWLq0MznDf6zLthc5WWmQOTEoXHeMIPr10iRpvPUL
         1SB9kvoxYTWn60Z8i2LIQ6xa14Bp7FkMx4mz3W3LAbBcgLxAbb+h8JOC2QHNek/rC/rA
         sVKl7XQE5s6KLAoXQnLjTqrDeyAnLTMCNNodIFYirDOiCkXtvkaIolmpR8pfdptzhkK6
         SDkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956049; x=1772560849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op2WAl+A8WCV2+n13UwckpDZcDhru/asS1xBQHlPgsQ=;
        b=fhnUFbqNydaeQ5KtemMPevvfOp+4/fr3cZXVFbR0Prqb5ipV7mCDv03Zjbhz1LvOtB
         yOd2NLohjRP/nm+EMYdwyq5Hl0tqJrMoLXN31fii2YdmwwP2U9HudgOb1bWxVgLI6V36
         AEKCq8QuP6TkyAutkqW0rrvSXECDe9uzY169rhtPOlghsRT/FCENO76e8tMOCkezrDbp
         HKO+o40bc4/cJmYPw5UQstSXWbyx95/jBpTZj/EPTfe9gCsIILiBlo2OlfuLIHk7Enys
         rb/HCOPCXLh3N80YMhod98YdddiFaO5DCSurj+34nga8T/889j2FUxuk6pRzkqnfn3fI
         kpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956049; x=1772560849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=op2WAl+A8WCV2+n13UwckpDZcDhru/asS1xBQHlPgsQ=;
        b=PjZlo2WirpC7ONkK1FNElG1NpJypAWxTz9+lRmkPMdCKpnP3pNP6mziIqp4hKKn8eV
         gKZ/lWmI2F8PLO30RoIT/paM/EEN4YYmRizjyPiYq53vXYz+hyhT6QEyMEBpkWRM3zC4
         sLlMz4cqiN3qbzRx41UUI02qZ+CeFSeTfbfLY0YPqk66Hwy28GNYViLbCTS5a03sHT02
         X2TBdoqI6Z4U6xL21CDq4r3wau3/iJvQHIyR0O/b3EjIeqG4f0qWXrDUlPXNCJh9HZod
         hPWtMhhZTK7nVyQ/OdACjTwSKwlPI3fjdkIYDchTAvJJxX5YDVzcW10n/YkTB124Twxy
         j3pQ==
X-Gm-Message-State: AOJu0YxEpWfgyD0IEs8rNycBo45rEam/kF8Q66PGrthPbBQnCszxi/i+
	b6lIw4iJP8mNprIqVSphEq4GgWRcQ21+M7omgWbLcM9HAxQYVfdcIgRSUGLDloic7sZslh9cVCi
	0kr+OSalHHwXY6cyt11mhNn3ygCjcdK1QkSwq
X-Gm-Gg: ATEYQzyaZI8PQ/LKCsw4JJ779r3rOMZJGWYI+BVkNN+BqroMsBnceu+cqr9JDP3P0Jt
	SMHaOJ9hXE/ymiDD4ilQkUNrXI+Ordn4/iMuZpFeB7YHOfXoOgLTzeVxd+z9fMy/ZjZPPg2UGHI
	+7WL0KSn6wd8G4hc1HPwqp6snlDV/Fuxq4q10OGVaqU4hvsnleODo+JEXoGYK90y5gAXgeLk9nC
	NMWrc9GumbnpyIMW94E4gbYC9SreEMO5IA8rh8zn6fIfbQI0Ov8/+VQiOJuAcJht728Y8BcQn+l
	X8BJ1Jj2KfUOvEOr79PSltP4ko2OawK+qjtI8AR2ZdVJwfw1559oBPNkO0OmCZi2yBkLJaYiUr1
	dHmt5Py+y
X-Received: by 2002:a05:6000:607:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-4398d95aa4amr1351186f8f.22.1771956048684; Tue, 24 Feb 2026
 10:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
In-Reply-To: <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 10:00:37 -0800
X-Gm-Features: AaiRm50fMpIAmc5j4p_2ehJMOiNLcepI8Sr74Yrw0hHoaaQeYVvJ8kTx7V3gyDo
Message-ID: <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > >
> > > Iterator KF_ACQUIRE support is not useful on its own right now, but i=
t
> > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next i=
s
> > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holding =
this
> > > pointer forbids sleeping; calling _release invalidates the pointer an=
d
> > > re-enables sleeping."
> > >
> >
> > The name of the flag and semantics bothers me a bit.
> > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_ACQUIR=
E.
> > And document it like:
> > KF_ACQUIRE -> acquires a resource via reference counting
> > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> >
> > and to match it I would do:
> > KF_RELEASE -> releases a resource by decrementing refcount
> > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> >
> > When lock is taken it's typically prohibited to sleep and do
> > other things. So I feel such flags would describe what's
> > going on underneath more accurately.
> >
> > Thoughts?
>
> I am fine with this except, I think we should still keep the
> KF_RELEASE a single release mechanism that releases according to how
> the reference was taken (refcount/lock). There is nothing wrong with
> separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> KF_ACQUIRE_LOCK -> KF_RELEASE.

yes. Is this too complex or what's the concern?

> I am fine with both but prefer the
> common KF_RELEASE. Let me know which one you like and I will go ahead
> with it.

Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
but would like to hear a 3rd opinion.

> > btw do we need a selftest that 2nd task_iter cannot call iter_next()?
> > Like:
> > iter_new(it1);
> > iter_new(it2);
> > iter_next(it1);
> > iter_next(it2); // this one has nothing to do with sleeping
> > but once we think of iter_next as KF_ACQUIRE_LOCK
> > it becomes obvious that it's not ok to re-acquire the same lock.
>
> But we still need to allow this if the locks are different, because
> that will support the nested iterator use case. For example, nested
> task_vma iterators that iterate vmas for different task structs
> (different mm->mmap_lock).

Well, different tasks can have the same mm->mmap_lock.
For example: two threads of the same process.

> And I think the check for re-acquiring the
> lock for the same iterator should be done at runtime as it is done
> currently in task vma iterator. I think what you are saying is that we
> could have a certain class of iterators that take a global lock ->
> only one iterator of that type can be used at a time (nesting not
> supported by design), even that should be taken care at runtime rather
> than the verifier tracking it.

I mean that as long as iter_new() before and iter_next() after
implementation is using mmap_read_trylock() then it will be fine.
Runtime detection of deadlock works, but we need a selftest.

When iter_new() did trylock() it was borderline acceptable,
but doing it in iter_next() feels suboptimal.
Especially if bpf progs are going to adopt the pattern of
bpf_iter_task_vma_release() that does mmap_unlock
in the loop body, so next iter_next() will rely on luck.
Many vma-s to iterate -> high chance that one of trylocks will fail.

Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AD37BE8F
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932294; cv=pass; b=dJUUK6RKZYAaqTBKV4XewZfJWFD4cMyng6rIzvK7w8SUO6esTChvSsTZ4K6quQKXEryp3oaaWtCcLd6w37bC03oJsrtiZ+atRAqYxVgT/pQLSMpQVm9u1iYaUBOJEiPw+nAZAdjKicj+0WtQ5aQwNOQ9V5ft0Pn5MGTUYlEyiSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932294; c=relaxed/simple;
	bh=0h8wHrtI/qyGbw1ifbnANE2Bi6Zp/mvWLzKpHtQm/Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuHGOyo+1CZmnVKrfDH3BR6sfewaUBJ+iF91z9x2abKvWRO1yDl7TkuDoQBakdC12Pf+8F1Dy+4lYnKv44PzHW+OrNNbXs1KDbucMqpZdZQOQg6nVVD9wZcaek3vGY6ht/3Mjk1hr7cE3ucfKde7KEBJTXzTua8J2lO774n9bLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co3SKq0D; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co3SKq0D"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8fa449e618so869956266b.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 03:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932292; cv=none;
        d=google.com; s=arc-20240605;
        b=cPpTSTVHQU3+8fq752eQuupwp6qh4RNyzD+JdIvsJkNJhf+3Vduw7VBlfV06PdaDQM
         lxVwmX1iIvQ7BNq8GFu7m8kuldqqEoJ+PEcUPYF0V9bGorgL2uzmMV9K2BvJj4j9WlmI
         /x1MTUv9V/i1mKrj4pkjmPKq6eKEigDtLUgFTyCXhNAXoUPv2T2nhw4TCfKc6CMUKT/P
         x7lBLIpKPz03c/Sbkap/yDEKqXg0PwOnEbQa7nciYQwPi6Y5z/UGAyjkuar4P61j1QHz
         fwUJDRMhiK0179zLt13g3rvqac2IadJUhrSQf9v2pF292uHQKlxaMpO6JQZm1n9abpAb
         4Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0h8wHrtI/qyGbw1ifbnANE2Bi6Zp/mvWLzKpHtQm/Uo=;
        fh=8DoVh3Iyt0R+s2t7XOny+wXcz6YPk7eroGHcz2JdAg4=;
        b=PCwurljvbUicPJFLquPi+HTcJz/qB3t0ez6N7BzD9DzDvwnj2rXcpmroLAtxGECjBP
         d1HADiI9koMyl5Gh8FOQDlNNxzqE9cVHjdTpZgWN/hEZ9JICvvos/9A2aJGMZY4AgRKt
         +YwIuN5DaoPbMinBWudOYtXa+vI4EPANLiaJl3OzH3Xpf5n4fuQMwmMRcpb6SfihAEmZ
         kF4qWhODCaFF4nVrGJsZy01PdWqKcGobMRTBLba3zEEa/p5JtFotOAiTJAwM+92ZqwPH
         MQyp906gz0tZyvEQsGmIfKM9GIun8F7UqqUIqELB7GECtV6V9MnkkIphcfEMvx/jkHrj
         Zx+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771932292; x=1772537092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h8wHrtI/qyGbw1ifbnANE2Bi6Zp/mvWLzKpHtQm/Uo=;
        b=Co3SKq0DcmZ92vYvkq57tAuPD1PWICMWg72Y/vvYk3r852wYv8SfJImBvUpWBnwH0D
         Azz/lRwoPi1T1tScit0/EVWL++tIxFYe1B0dOYeDGBCaiD5XpXJaHc73JM7whrB00aXc
         KMjLnpP7NuzQ3hho/B+0e5PHwus8zgr8Ow+xE1U3jhOJ3uQBb+DVaXHG6CHl+DddxR6o
         5kg18YPXWBOzxXNgsWg5QPdIcBJHaUvtPoSFU2LvQYOz8GrDZh/nYQk7MjUbCUdSUNf4
         72Ye2lDO6niZQaW1Z8vROEOEmJ0RdfB6kpdFiIojdsMlS9hT9eaY0KiOWQ3kbDi+Ur5x
         n9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932292; x=1772537092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0h8wHrtI/qyGbw1ifbnANE2Bi6Zp/mvWLzKpHtQm/Uo=;
        b=Djdsfa7rSZpBWsA0rMaXn/8E9s3D+KVAlgtkao2XQuRvxo0GWjik1v9IXrGMDSeYBV
         2zEczCiUgUKiwsXhCMmXyeY9PxJAW1h5G4B5yexVwQxNAW4sciIIjAt85vhCngL53qeD
         ub5gWUEh5NTz1DMOPHes3zTnRM+12DcBfiWi1J8hs8In42ucbegfPf0S5IYiJS86NcMG
         bds8k5/pGK0cfMsKzWNwPYa7hsNuTJuDJP08SohyoocvLECLbrzSrBGMecG7TFMFVl/F
         SyTaIJdW441r6qPBr9pl9CSLetwJk0yChBUHzMWnsNiERgLLlTPGlxfsMhuPhJwJnTJy
         lZSQ==
X-Gm-Message-State: AOJu0Yy0gP3f9j0e7rnfmhmqfwqUP7jSEa7hd8U+jove+rDdA0xtofsN
	zSOfWhNyS1VrF8HFOgbOe/o9g954W2KOgzUldoJEGemM7UtGCYR/y8ai2xTnasb8Ly5cDrsMUlG
	2crnFh/qbw4usIPvNKr3GkzqtMwa6xRM=
X-Gm-Gg: ATEYQzy+/Il1sGRQmiAiaFFlYGIO+D4UBXOTBMrMEhjft0cqYJouqm1VHs7MtqBiZ9M
	HWYK967B5IHGDon51G8iEFKdW0Jx6ENZlRdhyeBPQIXsmtpThLGF0pYR9nrGPc1QRWETiLu9AUK
	rS9MeiwJTnTosqyaczseoZ0qYjl7qOMu222uZ7wohxjajjoptThJLL4oUkIPNzyiJxs9R3N75U4
	pwm8qGJT6VTFI9wVuyZ2y65KQ2HCJmewHr2LYqvaBkatpMso/nU1pyEVVEnTAhfL+o2VseUiaCS
	+aWtXPqDRcSAMjAgJr148Q==
X-Received: by 2002:a17:906:ee8e:b0:b90:3593:654c with SMTP id
 a640c23a62f3a-b9081a2aa1fmr713013466b.21.1771932291638; Tue, 24 Feb 2026
 03:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
In-Reply-To: <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Feb 2026 11:24:40 +0000
X-Gm-Features: AaiRm51cBgLfGqcQo86Xqh9SXFMHeFSIcvF2I5QqDnwj28uSlCV6i3eed26S64s
Message-ID: <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> >
> > Iterator KF_ACQUIRE support is not useful on its own right now, but it
> > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next is
> > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holding th=
is
> > pointer forbids sleeping; calling _release invalidates the pointer and
> > re-enables sleeping."
> >
>
> The name of the flag and semantics bothers me a bit.
> How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_ACQUIRE.
> And document it like:
> KF_ACQUIRE -> acquires a resource via reference counting
> KF_ACQUIRE_LOCK -> acquires a resource by locking it
>
> and to match it I would do:
> KF_RELEASE -> releases a resource by decrementing refcount
> KF_RELEASE_LOCK -> releases a resource by unlocking it.
>
> When lock is taken it's typically prohibited to sleep and do
> other things. So I feel such flags would describe what's
> going on underneath more accurately.
>
> Thoughts?

I am fine with this except, I think we should still keep the
KF_RELEASE a single release mechanism that releases according to how
the reference was taken (refcount/lock). There is nothing wrong with
separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
KF_ACQUIRE_LOCK -> KF_RELEASE. I am fine with both but prefer the
common KF_RELEASE. Let me know which one you like and I will go ahead
with it.

> btw do we need a selftest that 2nd task_iter cannot call iter_next()?
> Like:
> iter_new(it1);
> iter_new(it2);
> iter_next(it1);
> iter_next(it2); // this one has nothing to do with sleeping
> but once we think of iter_next as KF_ACQUIRE_LOCK
> it becomes obvious that it's not ok to re-acquire the same lock.

But we still need to allow this if the locks are different, because
that will support the nested iterator use case. For example, nested
task_vma iterators that iterate vmas for different task structs
(different mm->mmap_lock). And I think the check for re-acquiring the
lock for the same iterator should be done at runtime as it is done
currently in task vma iterator. I think what you are saying is that we
could have a certain class of iterators that take a global lock ->
only one iterator of that type can be used at a time (nesting not
supported by design), even that should be taken care at runtime rather
than the verifier tracking it.

Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C42609EE
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385286; cv=pass; b=d9lR+Yz8cXWPe52MVxFKndJRSgx2NHB1NUi9G1QFDWn2YElgWRHNacUwuPQij5lIh2gFYFPaxLsrR0heYbfqTFWFhDLJwCHvzpKcDRh0QwJRSQvAe+MVwfQIBJPY3aoSa7zfREpQ1UexWAyu5yzZKo1bVPL5gQPqX/A2i5wgIV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385286; c=relaxed/simple;
	bh=0zhSW5wmUaD0jpTyQrm539UhtLesNqrMcD3VFkopJAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrIwhPSNf5fszOn3LYyPX96A5BsBk9JT2FApJUHW6rq2HDab8giQa0VIVPrDXCOV6bb3gnmrQkZpphUna4zlPjuC+KmBbz+DebL2EjmVhgz7241QUeFj13jR4qG1lS384H5L1FSI5sE1AtZ0hYHnwkCXVYd2L/sAVJLEBsqREQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+8eqPcC; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+8eqPcC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-667acaeae82so9128264a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774385284; cv=none;
        d=google.com; s=arc-20240605;
        b=dmE/GLMKMVITImphaX+5Bjc7Sl5tOwF5hW1q9rtN2ELBUslz8XrVqB7fEDcsjT8mYU
         GX5aeTsfHPc2cbq4oQID5ZzLHBp1YnvK5diVbKzEZLMXzbJ+tT95zVuZQwf8O1NQUG2d
         MRR6lYzDFUZuk3uKajuP5VuMNmfr6KrjDK9AFdO4AFIVCqMuXijWRCOgLELM95LTgKK1
         J2WqKO6URvQ1ky5uJAIYScwpiOcA4TptX21XUjuqlQoBOYD0IoshsacTZgNC/+rGPXsJ
         EjNW7d5uWD+p6q69aWmi+oJk3p+ElPQRuQWfCw3kNGXKr4IHKc1KNa6Uopz/vFjFasu9
         CZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FF4Ndpq79z6jWmUhP6/Er9eaHCQIzrN3mb5NiwJreu4=;
        fh=8DoVh3Iyt0R+s2t7XOny+wXcz6YPk7eroGHcz2JdAg4=;
        b=aYmO8ELr5w6RJTJRviPZ+1UERg/eqBoNqQZJopJyRj1GQhNvUhf0XtOblN+6SwvuKA
         vMtqCEmkClR8HEtrw1xmWanZJ0CN3NL5caofSGtDvO7XRElDomv0MEzPBvy6MW5Ayny/
         mMifK2cvuwxO+gJO/81p5DtYsgA9u8Jl/wcIMN9ZUV1tGtezzyQDWRLUGN8h8Dp2gK/w
         u1C2rZ5YNSX4+sjrP5MMntAxYdLJ6MXqxpZvQYJFyfzrq7Pe6Swb8X2OI7GBsoRxsIXb
         GkMJI7pLrwnP+GoVvXiGZRNVzbn8+ccQT9G1rKnZvUvQGBaqI6kmI95oiaWpjUdrdoR/
         XlDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385284; x=1774990084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF4Ndpq79z6jWmUhP6/Er9eaHCQIzrN3mb5NiwJreu4=;
        b=O+8eqPcCkgz3cM5JLzf7JKgJm7crb7nvZuB9oDH0vK9rwtZW/MXU3YECz1Y6F2ZxSd
         WNS5IzXiH67tQ1Zgd6WfSguJrghmW36x+iZW0EiaBgZYFYxWuDsps7mgAXmGh3HW1vbf
         eUsdvInSllfQ/+66TfTaw4zJ/qBitWYGXM0sLqJFMpYNpYQRBb+GBve3WY6DIDEYn12o
         Ft6Ibujix7ahL3qwzwN7MmO8uNDnMzIX20kI00KoLFcZgeXopHkZPNtD7hoOt8Cvk9Yk
         Ndf5z4YwPVV6Ha0Qitp3wsoqUCPVqFC4aUgcAvTZUzO/sFpfJ1ZBEI+cACSGV+4+cNtc
         ibdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385284; x=1774990084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FF4Ndpq79z6jWmUhP6/Er9eaHCQIzrN3mb5NiwJreu4=;
        b=FA80yrQ0eUNieaMwAjYbWVSxzhmz8llC7a8hwtAYX7peqY7usb1vqCA7Zt8shdRBKA
         1U9iR4P5QDlGXxYIL4ea2+YXbACDBuBG9yWAfxkJ5L7gEHSnxXlqFEj6kf2Xv3FBSczt
         I5FkJHMJK9WIy4W8RKbWGC6jMQbmuK690SrOqADAND7Z4rxSo+2bIx9tJ+XTzhXYcgov
         AoedXt4hZ6S1aNOay8cVg6XOY13IjHU2oyLE/aELp3h+uBXM40G19uBly4n5lO6KQpp2
         GtrJ/Ug3jWEooTOnO64QS6Vz7ZwQ4JMO9X4G43RiG7gfR/7K1XlutZd12AoOPnrxTIfo
         dPwA==
X-Gm-Message-State: AOJu0Yw4hTRhlMAk+Xzp4se8waXNlRpInQzCaCv/D+H9jfWxR5O7zKaw
	UNh6EIVGP14K7czpaYzneqPmYYFjm9GrBa6CYC7mA66Iok3jVmkTp4Oz6OpsnoMfXFbKAmmoiqD
	to/uz9lmV2YsmrUoOgDreBTH44y8Xs60=
X-Gm-Gg: ATEYQzzWUsE1EYlfXOcp9U2/z8vtloll1Vc7+5zDkhzfEJLivCkCRO9Zr39ac5apecj
	hiuQ7Bh+txEm+YM+1ze8Ny4AwmmAeOPtT5DujWLFqGZrR0y/l4zkQwBy8Uyop5fkzzHRhShF6BS
	65crDJhEFR8jIkxgh9c3GpsTLyRd1UwCf2sfxcIUGh2DqHVd0gIdipZK4nR1jXr4Gy2/SjHQT17
	JlConIGFTBFZQqpKoNJAfGFlYszJID2Axv3K0+3VxJVKJf7zRV8b/RYSbSrfrq6dbZWAIuzk8vg
	/1+p1pQn+zOpTE6X1OeQu4Y=
X-Received: by 2002:a05:6402:40c5:b0:669:77d0:cd30 with SMTP id
 4fb4d7f45d1cf-66a826b6566mr487483a12.24.1774385283614; Tue, 24 Mar 2026
 13:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316185736.649940-1-puranjay@kernel.org> <20260316185736.649940-2-puranjay@kernel.org>
 <CAADnVQKbxiBsXOsyau+rh86aK2VFHanNhBWRF49H0J+Tn+h0bg@mail.gmail.com>
In-Reply-To: <CAADnVQKbxiBsXOsyau+rh86aK2VFHanNhBWRF49H0J+Tn+h0bg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Mar 2026 20:47:52 +0000
X-Gm-Features: AQROBzCsyIcTGIkwThSb2VJwtprAVUKjsqYksBiISNp1xblTB5U-4-MFeJvIK0Q
Message-ID: <CANk7y0gzQybP29P=sj-QssrLO8CKRFXHBg1FVX4z29XxdH0hfA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 16, 2026 at 11:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >
> > The open-coded task_vma iterator reads task->mm and acquires
> > mmap_read_trylock() but never calls mmget(). The mm can reach
> > mm_users =3D=3D 0 if the task exits while the iterator holds the lock.
> >
> > Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
> > via mmput_async() in _destroy() and the error path.
> >
> > Reject irqs-disabled contexts (including NMI) up front. Operations used
> > by _next() and _destroy() (mmap_read_unlock, mmput_async) take
> > spinlocks with IRQs disabled (pool->lock, pi_lock). Running from NMI
> > or from a tracepoint that fires with those locks held could deadlock.
> >
> > Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
> > following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.
>
> ...
>
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 95d0040df584..5908de0c2f82 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct =
*mm)
> >
> >  /* mmput gets rid of the mappings and all user-space */
> >  extern void mmput(struct mm_struct *);
> > -#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
> > +#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH) || defin=
ed(CONFIG_BPF_SYSCALL)
>
> why? Is this some kind of odd config with bpf and without mmu?
> Is it even possible?
>
> These hunks make it impossible to land without broader review.

It was found by the kernel test robot in:
https://lore.kernel.org/all/202603051628.H3HNsDUG-lkp@intel.com/

CONFIG_BPF_SYSCALL can exist without CONFIG_MMU, bpf_iter.o is
compiled only based on CONFIG_BPF_SYSCALL

When mmput_async() was originally introduced it was only used by
oom_reaper so they guarded it with CONFIG_MMU in
https://github.com/torvalds/linux/commit/7ef949d77f95f0d129f0d404b336459a34=
a00101
but now we need it in task_vma iterator that can exist without
CONFIG_MMU so I followed the same approach used for
CONFIG_FUTEX_PRIVATE_HASH as in
https://github.com/torvalds/linux/commit/56180dd20c19e5b0fa34822997a9ac66b5=
17e7b3

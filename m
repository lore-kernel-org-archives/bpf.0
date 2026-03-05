Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6C3BED48
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729330; cv=pass; b=e9t9hSmZzwnvIEJ9nr0PKymLGjjwOK64LM8gZ7AgX1NxAMPMyd0kGIKproW3qT/KXfT2EQs0qk/59aRzd2adovAPsKhyW06GEFI9XnxVbLdQC+bQf4kZkR6SkKXAhfihJTt0hL6SaQe8dgCb0DJigo6A7q0f4TogXwcXql2cGRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729330; c=relaxed/simple;
	bh=3wlARo1twcyJhELzqUZpxMMDlMGAxmvm2m3QQ3NEKBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u12iS6023Gy3MD15w1dZnPDc+Zdn1JVJsFOkCg3kbg+cmy9njMo/uOq5ijzdo0Ku9/o0PuwtVWXlvGMnOuhV2lkohIM8KvjX6O6a5H0rBAEuExGNY204UVfFOQN7O7wlskN6A7ZJ0be9xyzMiOEx3WS7QPouppo1ZiDrv2MUD7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHlz3zf5; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHlz3zf5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936b85cc71so1031796666b.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 08:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729327; cv=none;
        d=google.com; s=arc-20240605;
        b=MmflQ00wUMeG6whyYaMBGa2Jb3b1nTL4YUhYla7Hj2J9/NTSPIE8VATROdXifwCNKZ
         8KIhxjwMi8Liyz56ySLr+/RrYQp1rboxza8tpuIHEUvlfoHX8maQ+1+LCT7Myib2awDW
         GVZVrFfbDUinVW7+vFZCMz2H2k+uasut6SU2YOitjZaPOzyXhjIX+ClRT07G6yT5WNBv
         4GKDQnYQjIIAX6dEB+Ui3acjUdVjN+LPxlPbhD/YEcb778WgOzXA971claeWw0u5/Cyp
         IxSQ4u4pwvr16W4N6L8nXH6P0dlnlOnzWZrcnxG4MF77NKRxYc6OFB8T64q1yGlSCuYR
         Br+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EbRXctj3cL160VBZCxwhSm0SrOXj1MIRXKqKkFudGVo=;
        fh=V2bTsbv6M94YX3O1oBaAkMJN+DpnN04JPyyf0fZ9tro=;
        b=lPbjVVR1xhDnnG4Km49HK1cIXCiLYOYiYdRqAff38ZHyalJCuwMTWdqkGgdTwpe17W
         +XgO8MSHpJ9CchmZnGpWldVYIgwzt68BqvlLxEvL9RBigzZlMapRK0DXOO2QcL1XOgTg
         JLxeh1sHYCIhS6bJOBhvxDL/iaUhIx0R+gmtWXN5cG6RYB0Cs+nG/HePvc/I11hJkwlm
         BFoi4PK/IDWSV98Lq0COWqWIFqsnNCPjv5Y8RAYsH8QzjImEWsNMFAKr+7oqy9KxFpzC
         0LiFILxU4n7N0NOfsV2switev7XREKqi6x82avssu732xzPYMTgSy8pRajJ01eLOjaKl
         HjoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729327; x=1773334127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbRXctj3cL160VBZCxwhSm0SrOXj1MIRXKqKkFudGVo=;
        b=KHlz3zf5u8c7NihqHsC4+5VuGJdIPjW8G2ASJj57cMlROJRp50fvSW2P/eVmJoabg8
         h7f+vcqbVpz41L+H2TEh8aRHKEsiXddeWkaSt9DfuzT/tnj/dTuhtD+o6iVVpSv/q8D/
         VT/ypgSNcKOylGX6hLmKQHtgjZKSqYUmuc4kvB8aeL6AcLSwudayLeZ7Y/08N0hOgNkE
         PkTqWL1q0+0CsHxPT0E6h62evP6rwu65NnQDZ/f/F//CcTfqdiRmyQEyQrpDdgfHIfNI
         bUaOhhHil3Tc1/CmgEv1hIbTqC/a+Hm7OXSE4RkLmJzrLVPnliMoK+wBcTM8QLnd3I/Q
         4L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729327; x=1773334127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbRXctj3cL160VBZCxwhSm0SrOXj1MIRXKqKkFudGVo=;
        b=NxjB/Pc3Cr545XrMbwmcBGek5K+Vg8goqsRil4GOruZkvbrhEYJ5c0p2eQrhR7nAuD
         uzk6zk8BFNhxXGV2xl8bDgcyPJalBM/KhefezY1NIaOzyZLVCjM1IO3BNfFx3AoNBZjE
         O5cfbgJKhsrn+G6PtlZFkYa7OxbsFoJQb4vfk3BL1wXIyCBsCTfHw37tAVC0a4A2aKvt
         sfVnyW6ybh89fmhzHBy4DSQAp53QTDfycsUWtASpCHcA7FkpfhMq9LAPZXBrUxCD+DTP
         DltE0+likGXfc2/cUoL1nFeGOSEYY8PjtgkOZTrB2ptj0oomaXRVXR8REWbtOMbAbLBu
         o9Mw==
X-Gm-Message-State: AOJu0YzGDzu8CGepaPTQfqK0Evvzh5GLZpR9GrtNwGl4HAz3PqTeTSWM
	roR5ToxaDX4DkwrMuw+9PjUJMtsvlVFlgyzJPuzynhiVk56C7wpq4PGigoaHoKTgk2biT7lgM1V
	DxcgGtKoAVZMFz5fbipB71tU+B78K1oo=
X-Gm-Gg: ATEYQzwGDwwCQ0P0/ff3boJYyK2PtgAY3HJmC1uLWSV92BLFULju1UiGuQv6wugevd2
	HPToGFHsSI/oYElK9FD1/JmPjEysqJnSR3WEJzW/8jx7TEiNMPLJZsW3C9OhKRJYeHxYFkwYgeP
	4gMFh7GioluS3oc1eL7SkC2NarEpE4S4v6dtN/2mmCdP7zBbPKv2g7VeaCkvqv4kgPiOLs0YTjM
	7B0EEOy/UPBXbrWpFjhFDJqSywOS6YSEhbENpfiAGLnHkeHuW/5jQscwiuT9/cpubOkRCutEZ86
	a9ztfKcQa8iOYYN2dnJ/As0=
X-Received: by 2002:a17:907:94c6:b0:b93:717a:6a08 with SMTP id
 a640c23a62f3a-b93f1468035mr405175466b.46.1772729326773; Thu, 05 Mar 2026
 08:48:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304142026.1443666-1-puranjay@kernel.org> <20260304142026.1443666-2-puranjay@kernel.org>
 <87pl5ixmjt.fsf@gmail.com>
In-Reply-To: <87pl5ixmjt.fsf@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 5 Mar 2026 16:48:35 +0000
X-Gm-Features: AaiRm53fqxhfHD4Mu4JjljBOH6E-DohuRvqfuhchAAw0fELBKDj7roRNAlxWfzw
Message-ID: <CANk7y0hybd2RyQi-rUROo6a=Tu36b0L-+ntYrDObaQyK2iHPCQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 4:34=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Puranjay Mohan <puranjay@kernel.org> writes:
>
> > The open-coded task_vma BPF iterator reads task->mm and acquires
> > mmap_read_trylock() but never calls mmget(). This violates refcount
> > discipline: the mm can reach mm_users =3D=3D 0 if the task exits while =
the
> > iterator holds the lock.
> >
> > Add mmget_not_zero() before mmap_read_trylock(). On the error path
> > after mmget succeeds, the mm reference must be dropped. mmput() can
> > sleep (exit_mmap, etc.) so it is unsuitable from BPF context.
> > mmput_async() is safe from hardirq but not from NMI, because
> > schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
> > which can deadlock if the NMI interrupted code holding that lock.
> >
> > Add a dedicated per-CPU irq_work (bpf_iter_mmput_work) and a helper
> > bpf_iter_mmput() that calls mmput_async() directly when not in NMI,
> > or defers to the irq_work callback when in NMI context. Use it in
> > both the _new() error path and _destroy(). Add bpf_iter_mmput_busy()
> > to check irq_work slot availability, and use it alongside
> > bpf_mmap_unlock_get_irq_work() in _new() to verify both slots are
> > free before acquiring references.
> >
> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfunc=
s")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 77 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 73 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 98d9b4c0daff..d3fa8ba0a896 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -813,6 +813,55 @@ struct bpf_iter_task_vma_kern {
> >       struct bpf_iter_task_vma_kern_data *data;
> >  } __attribute__((aligned(8)));
> >
> > +/*
> > + * Per-CPU irq_work for NMI-safe mmput.
> > + *
> > + * mmput_async() is safe from hardirq context but not from NMI, becaus=
e
> > + * schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
> > + * which can deadlock if the NMI interrupted code holding that lock.
> > + *
> > + * This dedicated irq_work defers mmput to hardirq context where
> > + * mmput_async() is safe. BPF programs are non-preemptible, so one
> > + * slot per CPU is sufficient.
> > + */
> > +struct bpf_iter_mmput_irq_work {
> > +     struct irq_work irq_work;
> > +     struct mm_struct *mm;
> > +};
> struct mmap_unlock_irq_work is exactly the same struct, perhaps an
> additional patch renaming it to something like struct bpf_iter_mm_irq_wor=
k
> is needed. Then we can reuse it for mmput.

They are similar but do different things, mmap_unlock_irq_work is used
to defer from NMI and hard-irq, but mmput_async is safe to run from
hard-irq and only needs to be deferred from NMI. I had thought of
combining these but later felt that keeping them seperate would be a
better approach.

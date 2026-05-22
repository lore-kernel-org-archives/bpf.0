Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456D2F28E3
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473691; cv=pass; b=mVJYaV8yxYz/QZouppMgf8rdmxI29EmCNWy4tcBi5zlKt6Ngg9ghRkkEhSty8+KvW/96FG5a4aN+dDT3SCTJh83Aktvo2pv8H3aJ5k7M36PH2Its8i7okxY4A1szBwsM6TnQuw4yhOUQWqb4H2xBPtg0EFepYT+BmyC9T3Snm20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473691; c=relaxed/simple;
	bh=1XRJ4C9TaMI2A7XaLWToHalc9UHeWu4Ds+cj260YAsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE3+OUMAuSIckABnZMT3+rYqE/HuKRWg/AoGY4fAE+oCZrWrw2yo+NizXQ+LafLqUBKYBsGCaAOR1A4nMXQctKpxIjlZYyWX7AWgqFBwAdxmerieTE5yy+rxSYQqKKu9tSJJTkJCmfh9qmkx2GZrdYt55zvFiA27xag09fPlWT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT2F6qgW; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT2F6qgW"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so10935921a12.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779473688; cv=none;
        d=google.com; s=arc-20240605;
        b=U9d9uRCU/zU4QUL76jRXTFNoWWEIy697lFxHyluak5oemYfu6LTDOcP8rpl7pGAeID
         iKRf5grruUfJJdNwOcbbPYwblLb2Ad4hguf1Ai3lLpZRj7Acxt1eQUANmbt1xvYE4J94
         vcaTvHyPfKTTZQwJ30rSdJztwRBbHGp/1IhRN19zx5zRmyc57gL+wl0nEcZC+CrQDMK6
         ZS+NZpEs4fySD9gzXBTvEafiPsGcXXfkxsaFuVxTiGo51V3qWKdgP7G8Vv0L6nLBX0RR
         umUb4U5KyIpXDBWYXYyZNrMfnbDAvUqwK16lRXfPtq4LTGx+rZZK7F2j3BFTCkdcudD+
         ipoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H7MKQiGtc6xFnrPKcB00KXOCn9KHA0scZYmqs9X549k=;
        fh=Oc3aavqSS8KGYUYnw1xnR1T0oexLfMbz1aj8hBorgS4=;
        b=ivHturaIqMEcbHRUo5d4UQucl8PdyRNSSXToPw5viXcMMwhndOz4IuP9XS22tUqLIU
         xLl31NTJDNzI4dxDe8grD26l6vPmKRLGkkEdTuVhs0Ax0Azei3tBDRjPcp8+yUlsLwM8
         EqvEEtdyF6PmaxQNe7uO8obxkNAvTv/NCwaUi0NRpOO8IA23Lg+dyIbb3zix3YYjwwxd
         XO3PyHaBy79w7EBkmcXUBt2dHdYCAhPHeVJfnb25Ud85XKVC5nZd7C6SyGibqTf3uoc1
         yAjyIKSolEGvUTpckEwJJlJ7qfVJIVsiz8vW3phjZfJtZLZdhIZXqvWgUIVbKpoT7nHN
         Z/qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779473688; x=1780078488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7MKQiGtc6xFnrPKcB00KXOCn9KHA0scZYmqs9X549k=;
        b=lT2F6qgW1CmBTXdbQ8UvulPOT+aR13CWIEy0JoQZkNCPpnv786KtPVarPdhUiLC1ZE
         CNsIxiFkehXmUniFAJL252DDAFOzzBolcvJVDsPh1ZBg/Sj4qYrXuKxp8/AJKTtIHDru
         A6P7XAWmAuQ1ave8/ltyKerWYoWAgTG51dWsWf89Won4otHIXuwgoqWUFdFpCfjvZATI
         isYfCp8HTfEMkc4zufg8aVbsLUQYpEpg6zB/WttwDbpHzOx3SYpXgRuSm0A0bWbLWb+k
         X0Zb1GKPcxKYBDzRkLsjy82NVHsfHXztpZifWCJ6PIPG4bMDbgJVVfXsLUVvaeP+AxfA
         Chng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779473688; x=1780078488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7MKQiGtc6xFnrPKcB00KXOCn9KHA0scZYmqs9X549k=;
        b=NtLa5pu3EI0LXB75X0ZQ4YhfLOPF3ymF12kzivmvPmPMKr6121aA5uk0TKBvKpYgFT
         w2b5nabJcJegq2wxoci2jP2gpTkp14yTxB08H93WwaSLwk/8QVafXyilTsHmfC4TULuT
         xU9EYPaOPV2tGPt6zbL+GPAjw95P2fJq2s8Bq4KS+YTYMCloVzXVwc75z84KnntAWGQl
         HnOnqv4kka5X5JrM6BdbMfODlO3/Ub7rd65xW8lRJQeq1YvWvgL2585yRcmlrGjcF7rk
         CTUPKSA+rJRtUG2yoqpu5Y+EeX7sU3B7FPRZE+rVi6J2ZFmXiUe9GtcwqtSdOoleU5WQ
         9apA==
X-Forwarded-Encrypted: i=1; AFNElJ89QFXUPzEOez8GC3BnB0cECmcefHQK3TWBPv1UgPvrTpdzXLWeS5StU8PmiY/8/64TWzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIBsxYdku3eMqsJyVxDVteYiwc+2gBDcNWXd9LMAyURgWVyj1
	h5f8r7U02eFo9/NEoiMoDtQqRmiMLvVNhXAPwlL8iH6XE+IbTaKmsv44/ce50NA8T8OG+6wyC+O
	7Suwi00np1a9LlG57eafqwgtHc1Di4Q4=
X-Gm-Gg: Acq92OHJ2YhARBM6Tw6lfiYnDjE5NpvENGMtElij1oaqb1jIXeruHb3v17ha0cp8dbJ
	4sj3gj+Egx5OOl8QSHnLUm88HZVwBYfSPGJrrv35tjwldx48Y9zvkA/MPh8Wo56H6S7iNd0Z4QB
	YGLOreInXb9JAjASWX1jknklkr8YWdIQ+atAUPn5/xuT68vbsOyneYfZZVzYF55I6/pf3fUkgwk
	Ft8HtEPoKYMv21kRpy1SjJFbPRxXGuik+RWBKEbZqCby3pHDCP4izOq8rD8Amh+RghPPmW/S5Ku
	4ZQ1Xh2luWPFWwW6ibgpQjI=
X-Received: by 2002:a17:907:c283:b0:bdb:2f5e:227 with SMTP id
 a640c23a62f3a-bdd22a3d41emr352465366b.2.1779473687983; Fri, 22 May 2026
 11:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
 <20260521225022.2695755-3-ihor.solodrai@linux.dev> <CAEf4BzZ2i95MaoEt+twNKmw-9FGYbNJ-mLwwHRJ8yAJN7njvwQ@mail.gmail.com>
 <7b1a89e6-d473-4ef6-b8de-09c87bda7337@linux.dev>
In-Reply-To: <7b1a89e6-d473-4ef6-b8de-09c87bda7337@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:14:29 -0700
X-Gm-Features: AVHnY4KkCS5NnWzyPGxsV67JiGzHhBZmC_y93W54sJ7gmg7rQy73rex8BHEuzT0
Message-ID: <CAEf4Bzb4-oJ3WFgEkqKZ5VwY=3gyKWA2QgJMQE8XMf6Mtu+qBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] bpf: Avoid faultable build ID reads under
 mm locks
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:05=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 5/22/26 10:42 AM, Andrii Nakryiko wrote:
> > On Thu, May 21, 2026 at 3:51=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Sleepable build ID parsing can block in __kernel_read() [1], so the
> >> stackmap sleepable path must not call it while holding mmap_lock or a
> >> per-VMA read lock.
> >>
> >> The issue and the fix are conceptually similar to a recent procfs
> >> patch [2].
> >>
> >> Resolve each covered VMA with a stable read-side reference, preferring
> >> lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
> >> enough to acquire the VMA read lock. Take a reference to the backing
> >> file, drop the VMA lock, and then parse the build ID through
> >> (sleepable) build_id_parse_file().
> >>
> >> We have to use mmap_read_trylock() (and give up on failure) in this
> >> context because taking mmap_read_lock() is generally unsafe on code
> >> paths reachable from BPF programs [3], and may lead to deadlocks.
> >>
> >> [1] https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@l=
inux.dev/
> >> [2] https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel=
.org/
> >> [3] https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@l=
inux.dev/
> >>
> >> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_g=
et_task_stack() helpers")
> >> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  kernel/bpf/stackmap.c | 107 +++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 107 insertions(+)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index 4c753e02c415..95336c0e8b56 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -9,6 +9,7 @@
> >>  #include <linux/perf_event.h>
> >>  #include <linux/btf_ids.h>
> >>  #include <linux/buildid.h>
> >> +#include <linux/mmap_lock.h>
> >>  #include "percpu_freelist.h"
> >>  #include "mmap_unlock_work.h"
> >>
> >> @@ -174,6 +175,107 @@ static inline void stack_map_build_id_set_valid(=
struct bpf_stack_build_id *id,
> >>                 memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
> >>  }
> >>
> >> +struct stack_map_vma_lock {
> >> +       bool vma_locked;
> >> +       struct vm_area_struct *vma;
> >> +       struct mm_struct *mm;
> >> +};
> >> +
> >> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma=
_lock *lock, unsigned long ip)
> >> +{
> >> +       struct mm_struct *mm =3D lock->mm;
> >> +       struct vm_area_struct *vma;
> >> +
> >> +       if (WARN_ON_ONCE(!mm))
> >> +               return NULL;
> >> +
> >> +       vma =3D lock_vma_under_rcu(mm, ip);
> >> +       if (vma)
> >> +               goto vma_locked;
> >> +
> >> +       /*
> >> +        * Taking mmap_read_lock() is unsafe here, because the caller
> >> +        * BPF program might already hold it, causing a deadlock.
> >> +        */
> >> +       if (!mmap_read_trylock(mm))
> >> +               return NULL;
> >> +
> >> +       vma =3D vma_lookup(mm, ip);
> >> +       if (!vma) {
> >> +               mmap_read_unlock(mm);
> >> +               return NULL;
> >> +       }
> >
> > As the code is written right now, this vma_lookup is futile if we
> > don't have CONFIG_PER_VMA_LOCK, no? We'll just unlock mmap and return
> > NULL regardless of this operation succeeding. So if that's the intent,
> > then starting from mmap_read_trylock() all the way to mmap_read_unlock
> > + return NULL should be under #ifdef CONFIG_PER_VMA_LOCK.
> >
> > But could it be that the intent was to set lock->vma_lock =3D false,
> > lock->vma=3Dvma + return vma here if vma_lookup under mmap_lock
> > succeeded?...
> >
> > (oh, now scrolling further down the thread, seems like AIs picked up
> > on this as well, oh well)
> >
> >> +
> >> +#ifdef CONFIG_PER_VMA_LOCK
> >> +       if (!vma_start_read_locked(vma)) {
> >> +               mmap_read_unlock(mm);
> >> +               return NULL;
> >> +       }
> >> +       mmap_read_unlock(mm);
> >> +#else
> >> +       mmap_read_unlock(mm);
> >> +       return NULL;
> >
> > see above, was this meant to be a "return vma"?
> >
> > This whole function is quite confusing, please help me understand how
> > it's supposed to work both with and without CONFIG_PER_VMA_LOCK.
>
> In v2 the stack_map_vma_lock could be holding either vma lock or mmap
> lock, in order to support CONFIG_PER_VMA_LOCK=3Dn
>
> Then I tried testing it, and it turned out to set CONFIG_PER_VMA_LOCK=3Dn
> you need to disable SMP, which seems like an unlikely kconfig:
> https://lore.kernel.org/bpf/bf91eb90-1b6a-4bad-a0e5-072f9dce7daa@linux.de=
v/
>
> So since v3 I dropped attempt to support CONFIG_PER_VMA_LOCK=3Dn by
> treating it the same way as failed mmap_read_trylock(), which is
> expressed by returning NULL from stack_map_lock_vma().
>
> I guess you have a point in that the stackmap lock/unlock helpers can
> be refactored further. But with respect to CONFIG_PER_VMA_LOCK=3Dn I
> don't see why we'd want to maintain additional complexity of mmap lock
> bookkeeping.
>

Some architectures do not (yet? ever?) support PER_VMA_LOCK at all.
But even for the common arches it should be possible to turn off
PER_VMA_LOCK:

config PER_VMA_LOCK
        def_bool y
        depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
        help
          Allow per-vma locking during page fault handling.

          This feature allows locking each virtual memory area separately w=
hen
          handling page faults instead of taking mmap_lock.


We used to not require PER_VMA_LOCK for this functionality, so if it's
not undue complexity and maintenance overhead, I'd try to make it
work.

>
> >
> >> +#endif
> >
> >> +vma_locked:
> >> +       lock->vma_locked =3D true;
> >> +       lock->vma =3D vma;
> >> +       return vma;
> >> +}
> >> +
> >> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> >> +{
> >> +       struct vm_area_struct *vma =3D lock->vma;
> >> +
> >> +       if (lock->vma_locked) {
> >> +               if (WARN_ON_ONCE(!vma))
> >> +                       goto out;
> >
> > this should never ever happen, it's a bug, we shouldn't warn on it, we
> > should make sure we never ever have vma_locked set to true if there is
> > no vma
> >
> > the whole pattern of returning NULL from stack_map_lock_vma() and
> > still holding lock (i.e., allowing and expecting to call
> > stack_map_unlock_vma) seems confusing and error-prone, tbh
>
> The idea of stack_map_lock_vma() was that it may fail like trylock,
> and it is safe to call corresponding unlock(), even if lock isn't
> held.  This allows to have an unlock() on all paths after a lock() in
> the code, instead of "if locked" or "if null" checks.
>

I got this, but it's a bit of unusual pattern, so easy to get wrong.
Normally, if some lookup function fails to find whatever needs to be
found, it should release resources (i.e., not keep lock). Sure, it
might require slightly more nuanced error handling in the caller, but
that's nothing new.

> >
> > why not simplify it to "if we got vma and locked it -> we return
> > non-NULL vma and lock is held, otherwise no lock is held (because
> > why?)"
>
> I'll try that.
>
> >
> > pw-bot: cr
> >
> >
> >> +               vma_end_read(vma);
> >> +       }
> >> +out:
> >> +       lock->vma_locked =3D false;
> >> +       lock->vma =3D NULL;
> >> +}
> >> +
> >> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_=
build_id *id_offs,
> >> +                                                   u32 trace_nr)
> >> +{
> >> +       struct mm_struct *mm =3D current->mm;
> >> +       struct stack_map_vma_lock lock =3D {
> >> +               .vma_locked =3D false,
> >> +               .vma =3D NULL,
> >> +               .mm =3D mm,
> >> +       };
> >> +       struct vm_area_struct *vma;
> >> +       struct file *file;
> >> +       u64 offset;
> >> +       u64 ip;
> >> +
> >> +       for (u32 i =3D 0; i < trace_nr; i++) {
> >> +               ip =3D READ_ONCE(id_offs[i].ip);
> >> +
> >> +               vma =3D stack_map_lock_vma(&lock, ip);
> >> +               if (!vma || !vma->vm_file) {
> >> +                       stack_map_build_id_set_ip(&id_offs[i]);
> >> +                       stack_map_unlock_vma(&lock);
> >
> > see above, I find this confusing to need to call unlock_vma if there
> > is no vma in the first place...
> >
> >> +                       continue;
> >> +               }
> >> +
> >> +               file =3D get_file(vma->vm_file);
> >> +               offset =3D stack_map_build_id_offset(vma->vm_pgoff, vm=
a->vm_start, ip);
> >> +               stack_map_unlock_vma(&lock);
> >> +
> >> +               /* build_id_parse_file() may block on filesystem reads=
 */
> >> +               if (build_id_parse_file(file, id_offs[i].build_id, NUL=
L)) {
> >> +                       stack_map_build_id_set_ip(&id_offs[i]);
> >> +                       fput(file);
> >> +                       continue;
> >> +               }
> >> +               fput(file);
> >> +
> >> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_o=
ffs[i].build_id);
> >
> > what about
> >
> > if (build_id_parse_file(...))
> >     stack_map_build_id_set_ip(...); /* no build id, parsing failed */
> > else
> >     stack_map_build_id_set_valid(...);
> >
> > fput(file);
> >
> > ?
> >
> >> +       }
> >> +}
> >> +
> >>  /*
> >>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
> >>   * They will be subsequently:
> >> @@ -194,6 +296,11 @@ static void stack_map_get_build_id_offset(struct =
bpf_stack_build_id *id_offs,
> >>         const unsigned char *prev_build_id;
> >>         int i;
> >>
> >> +       if (may_fault && has_user_ctx) {
> >> +               stack_map_get_build_id_offset_sleepable(id_offs, trace=
_nr);
> >> +               return;
> >> +       }
> >> +
> >>         /* If the irq_work is in use, fall back to report ips. Same
> >>          * fallback is used for kernel stack (!user) on a stackmap wit=
h
> >>          * build_id.
> >> --
> >> 2.54.0
> >>
>

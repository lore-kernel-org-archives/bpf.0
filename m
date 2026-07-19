Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABD39769A
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470871; cv=pass; b=FpZ4Gn/3QmQ+oDZZAxez0KKu825O5497Uvfp6rxs2B3n+xfNER6lWew0OXIo6EFytorC9u/sDfLzyEqUoKxa0pLS8/AxI+5/+MrG1UnPyCwW2SDee8qeH/spENb4iXwFt+VaZaWITB1d+8A2fA7AVMWzV6iVK6IwnMFYXajzgbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470871; c=relaxed/simple;
	bh=IZcd2Ffdam9JzzuwtapqaD5SVcJ1l1VklN7O/RZrQ+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwM4wYbxxn9GW4ylqKKjAB8hS/BBrde5Y6XKlSDTJ5OKiUevyLGBQe9V3/SvPfyiQnVY8UCRjRtUgN7N8PEurg/yEf2cWXznioRgwCuNstlN+TREHzUURsz7smG0nJo9K4OSiDcCX9t6+efAY2ni5gt6uuyek/TKKF06q3q/4RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKBnOukn; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKBnOukn"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e9f7491ffso115833387b3.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 07:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784470869; cv=none;
        d=google.com; s=arc-20260327;
        b=B1r47Xta2elLZ0QFxiSsbjrw5fzGG2M+FqKm8QRHtFmBAhuMpuALQACdLnh4WRjgNx
         j0I5YgqimTlz4D1BixYFt+eHBbpjRcndpABkTCfuh+O/A0bcYQYAKwUPx3hSKd7qGoS/
         tNLjH1TmNREN+3DecySGL/Q0DScNJn53FwJ4Jn9az9bg43NIBAYDCTV0E2y14NRRKsQ4
         ageTCozg/UWd33GZYBuU/rplT4rjB0eLq9yGY9keuEG7wNwl7a2sWWp1lu+ngKPXmsHg
         2MsTHhuHWwvF9g3sdUQsyRD2aq7ehGlaKlQUA/unBgOMf66pFiWjAQPTQ4BSua3M9Per
         RSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQXuF41EKnnf5p6H5bvVf4+oU50ppls9wh6xOrrEECo=;
        fh=PH2gP1zAMyonzTiEW5h6MKAsT/ldLMN4A9XUGiwF7+I=;
        b=SZwMm5ZUXYHr1BsbGnMMaK7eZbf3tXZ0WiLlTDqNrTEQs7GFWulWdll9rJcd4S7aeM
         WkNNvFGLhp9ZBknsmmaYlEabtGeaExLU+QqJItLRodlgeKlQHht9wo5piYYzFVlMtchF
         3N4158dRm2DgfsqCd0cM0mN4x+94H8TLHeS2MfUCt6bRLXwUw334Pc1OZbHVNowZfdlK
         6iX/m6gUKl9z/WWFqrT5X/JUxYXVKh9VOX7PpLqEBOVmAmzxcJ+TsR8RMX328Rw+A0NI
         H356mZa6mCR0cIQ+TdG6HJeodwQMt7UNg62BgAUtxJbnzkhEWCfLgfdlHLswCAeV8nZT
         EU+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470869; x=1785075669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQXuF41EKnnf5p6H5bvVf4+oU50ppls9wh6xOrrEECo=;
        b=QKBnOuknc1Lk5m0drnzwqHEs5A3njarI/XISM2obiaoVe87bhK141F6y4TkKvPCs3+
         j9ZPMfGPCPaB3Cyf6PaYM0KWs+C8rPGbzSFoEMS2PvRrCLc5n6D1x/0wnoVM//Dvx83K
         Rm223swXEx2pA40Fd457pDBDfQeEctGM7GdLfRYIW5NBJJVgLF/TsvbO5B8+G9YHM+Iw
         0pLcW6WIg9X4KU2QMGSeo1/ymeJ4d6W+epC29+ezOJSuVIi2vUQMJwW9nHeN0ZiZgYDU
         4TocCKbZ4Rx5GdjjQD+TZUoQD3+CuIM8gTrR8z28+kfPomQ1vB9z3IERMN8Brgq9GDVG
         Ks0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470869; x=1785075669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQXuF41EKnnf5p6H5bvVf4+oU50ppls9wh6xOrrEECo=;
        b=cG3BXUxclUjK6hSEWCuJlvrGmLgzSlcoxdN/+O53tU8HI/938nocGJUQMvuAPFO0JL
         oZjx90UibVswmTpcB2g9YKQ61BHuwLI71BCO2FTinzWladEa0HUb7l6PcEZPWjo8Y+3A
         jce7REihSkBg5Ea//XlvQSp/kAYWfQIKwzypSmNgBeJTuIpZbTt3KoyKamRvuEcPituV
         1W5UYaq1402u0BVmhYFRZLuPD8K1JhV9fnNf14OprfoNt1aOJDMbHOQ+42A/6q8tDHj4
         1bbtpnwBZ4eL9Q/NJNJLhm+IDTtACqJhgFbYnWlPe0hKh3EQNofisM2hrN4MrfMjYvIP
         KjLg==
X-Forwarded-Encrypted: i=1; AHgh+RpbjCI46HO3ZeEFvIKKijdDuO/oCNAvlIeQHXUV9m8wi5BM1bgWjeFuVZYNdmlPULyhYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AzpVkzyas8PkpMFuqHs2GYSg0IL0TyDVUAz4bFHC36isLO08
	tcFWYzDJg87v+nvYWli7uVRgL8Hp4yaqL9SE3obTsbHTKA/izmSyQ5JkMotadR0DCXyyQ22vKEy
	AQh4vuSQ1om//u13/tod4g0thSNcIQWo=
X-Gm-Gg: AfdE7cllkEadZ8EgIF77Jn6dJEYPzQRiayfNsXTdgbtORR/tFRNntYKEUj8x9+yvJT4
	qbOdvM652gNdRt97mvqCjzjPsfCJzrcJsPE2Fbn3iJcMj29gXuTHqhuYKxZxj40841E01VyLJ3u
	OpFNdFj4cgVd84rAxOUxDXP3HXoSQAP0BedMl3ok3Md4oZwWJ0MVnF8E63x3acBaSubYS559vUD
	JXIXGKAmUFvHp3l/V7KzY3ut8QKD44Nj2j1KcYfWq87ORYUHkDRWDjBo0N3OaBDfKu1hh7mDlcZ
	vTO61UEbp3fy+QQ4iLGKZmpErL3Axg==
X-Received: by 2002:a05:690e:1597:20b0:668:83e:b1a0 with SMTP id
 956f58d0204a3-6683be04443mr2497289d50.109.1784470868729; Sun, 19 Jul 2026
 07:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
 <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
 <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com>
 <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net> <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com>
In-Reply-To: <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 19 Jul 2026 22:20:56 +0800
X-Gm-Features: AUfX_mxwesFmNu1dNjr-BogPo22zQ0R2S7fjnZyb65ZIG2_ABoXnoo55cGSsEGk
Message-ID: <CABFUUZFsippcjQ7JYqtAJnMa73J9cGaa_tAbr0iqvv_pp-y6Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay12@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:30=E2=80=AFPM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> Sure,
>
> I=E2=80=99ll take a look at that issue once the current patch is sorted o=
ut.

Hi Sanghyun, Puranjay, and Daniel,

While studying the bpf_find_vma() mm lifetime fix, I investigated
the pre-existing sashiko-reported mmap unlock irq_work race mentioned in
this thread.

I have an instrumented PoC and a small temporary debug diff, which I can
share if useful. The PoC runs bpf_find_vma() from a hard-IRQ raw
tracepoint and invokes a nested lookup from an NMI raw tracepoint on the
same CPU.

To make the narrow IRQ/NMI window observable, the outer callback uses a
bounded bpf_ktime_get_ns()-based busy-wait, configured for up to 0.5 ms
and capped at 4096 iterations. With that instrumentation, I observed the
inner lookup acquire mmap_lock, followed by the outer context colliding
when it queues the shared per-CPU irq_work. After stopping the
reproducer, its process remained in D state in __vm_munmap().

I do not currently have a natural-workload reproducer without the
intentional window widening, so I do not want to overstate the result or
send a patch based on it without your input.

Sanghyun, I saw that you planned to look into this after the current
patch is sorted out. If you are already working on it, I would be happy
to share the PoC and my observations.

If you have not started looking into it, would it be useful for me to
continue investigating the issue? I can share the PoC and debug diff
first, and look into possible fixes if you think the evidence justifies
it.

Thanks,
Sun Jian

>
> 2026=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:44, =
Daniel Borkmann <daniel@iogearbox.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> >
> > On 7/6/26 1:28 PM, Puranjay Mohan wrote:
> > > On Wed, Jul 1, 2026 at 8:48=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > >>
> > >> On Mon, Jun 29, 2026 at 8:25=E2=80=AFPM Sanghyun Park
> > >> <sanghyun.park.cnu@gmail.com> wrote:
> > >>>
> > >>> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) witho=
ut
> > >>> holding a reference on the mm. On a foreign task, a concurrent exit=
_mm()
> > >>> can free the mm_struct between the lockless read and the trylock,
> > >>> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RC=
U.
> > >>>
> > >>> For the current task, task->mm is stable. For a foreign task, pin t=
he mm
> > >>> under task->alloc_lock and release it with mmput_async(), mirroring=
 commit
> > >>> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterato=
r").
> > >>> Use spin_trylock() instead of get_task_mm() so BPF context does not=
 block
> > >>> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> > >>> foreign-task path because dropping the mm reference is not safe the=
re.
> > >>>
> > >>> Race:
> > >>>
> > >>>    CPU0 (BPF program)                  CPU1 (exiting task)
> > >>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>>    bpf_find_vma(foreign_task):
> > >>>      mm =3D task->mm
> > >>>                                        exit_mm():
> > >>>                                          task->mm =3D NULL
> > >>>                                          mmput(mm) -> frees mm_stru=
ct
> > >>>      mmap_read_trylock(mm)
> > >>>          // UAF on mm
> > >>>
> > >>> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> > >>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > >>> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> > >>> ---
> > >>
> > >> Puranjay, PTAL, I think you've been fixing similar issue in
> > >> bpf_iter_task_vma_new(), would be nice for you to check this fix as
> > >> well. Thanks!
> > >>
> > >>> v6:
> > >>>   - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destro=
y()
> > >>>     still uses it.
> > >>>   - Keep the direct mmput_async() call in bpf_find_vma(), but guard=
 it with
> > >>>     CONFIG_MMU because mmput_async() is declared only for CONFIG_MM=
U builds.
> > >>> v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.p=
ark.cnu@gmail.com/
> > >>>   - Replace bpf_iter_mmput_async() with mmput_async() directly as s=
uggested
> > >>>     by Yonghong.
> > >>>   - Add Yonghong's Acked-by.
> > >>> v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.pa=
rk.cnu@gmail.com/
> > >>>   - Use [PATCH bpf-next] subject as requested by Alexei.
> > >>>   - Add the missing BPF maintainers/reviewers to Cc.
> > >>> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.p=
ark.cnu@gmail.com/
> > >>>   - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
> > >>>     trylock + mmput_async(). (Yonghong Song)
> > >>>   - Reject irqs-disabled contexts on the foreign-task path.
> > >>>   - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async=
()
> > >>>     falls back to mmput() which may sleep, and bpf_find_vma() can r=
un
> > >>>     in non-sleepable context.
> > >>>   - Shorten the foreign-task rationale comment and trim the changel=
og body.
> > >>>   - Fix the v2's whitespace damage.
> > >>> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88f=
GVKOAa3_ZenPOFkA@mail.gmail.com/
> > >>>
> > >>>   kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
> > >>>   1 file changed, 33 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > >>> index fc5f463ca529a..1d56193caf5e4 100644
> > >>> --- a/kernel/bpf/task_iter.c
> > >>> +++ b/kernel/bpf/task_iter.c
> > >>> @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, =
task, u64, start,
> > >>>          struct mmap_unlock_irq_work *work =3D NULL;
> > >>>          struct vm_area_struct *vma;
> > >>>          bool irq_work_busy =3D false;
> > >>> +       bool mmput_needed =3D false;
> > >>>          struct mm_struct *mm;
> > >>>          int ret =3D -ENOENT;
> > >>>
> > >>> @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *=
, task, u64, start,
> > >>>          if (!task)
> > >>>                  return -ENOENT;
> > >>>
> > >>> -       mm =3D task->mm;
> > >>> +       if (task =3D=3D current) {
> > >>> +               mm =3D task->mm;
> > >>> +       } else {
> > >>> +               /*
> > >>> +                * Foreign task: pin task->mm against a concurrent =
exit_mm().
> > >>> +                * Use trylock on alloc_lock instead of get_task_mm=
()'s
> > >>> +                * blocking task_lock() to avoid deadlocking the ta=
rget task.
> > >>> +                */
> > >>> +               if (!IS_ENABLED(CONFIG_MMU))
> > >>> +                       return -EOPNOTSUPP;
> > >>> +               if (irqs_disabled())
> > >>> +                       return -EBUSY;
> > >>> +               if (!spin_trylock(&task->alloc_lock))
> > >>> +                       return -EBUSY;
> > >>> +               mm =3D task->mm;
> > >>> +               if (mm && !(task->flags & PF_KTHREAD)) {
> > >>> +                       mmget(mm);
> > >>> +                       mmput_needed =3D true;
> > >>> +               } else {
> > >>> +                       mm =3D NULL;
> > >>> +               }
> > >>> +               spin_unlock(&task->alloc_lock);
> > >>> +       }
> > >>>          if (!mm)
> > >>>                  return -ENOENT;
> > >>>
> > >>>          irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> > >>>
> > >>> -       if (irq_work_busy || !mmap_read_trylock(mm))
> > >>> -               return -EBUSY;
> > >>> +       if (irq_work_busy || !mmap_read_trylock(mm)) {
> > >>> +               ret =3D -EBUSY;
> > >>> +               goto out;
> > >>> +       }
> > >>>
> > >>>          vma =3D find_vma(mm, start);
> > >>>
> > >>> @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,=
 task, u64, start,
> > >>>                  ret =3D 0;
> > >>>          }
> > >>>          bpf_mmap_unlock_mm(work, mm);
> > >>> +out:
> > >>> +#ifdef CONFIG_MMU
> > >>> +       if (mmput_needed)
> > >>> +               mmput_async(mm);
> > >>> +#endif
> > >>>          return ret;
> > >>>   }
> > >>>
> > >>> --
> > >>> 2.48.1
> > >
> > > Thanks for this, it looks good to me.
> > >
> > > Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> >
> > Applied, thanks! Could either you or Sanghyun look into the pre-existin=
g
> > sashiko-reported issue as well?
>

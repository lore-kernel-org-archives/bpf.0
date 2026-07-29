Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24532469849
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344327; cv=pass; b=j+myfoR8D/Co7PpXlZjPBpBFwPEbH47BGp2KFw13MTbcqzB/uoZeejzllsSsVLs8jQAikE7N4Cp8ieKGj5Na2w/wyB2zW5M2OrMG9YlvVJSW1ldToeV0mz7lNe9FuVEBVbohxL1QSPKgw+zGGzuoHwEByksPyzOqd7CIAloE1is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344327; c=relaxed/simple;
	bh=Ak/U6hwwxMcUe9I9fETxH6dCF6CGhoLRTTeI/ZY+LVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAJEua7wEJTxScbGk3K3uKSMteD6XODrtV3+AIhUPnfY17GivmTSdEblbIz0/M0ZMUZkbrEuPzoZEqcSJBdggj09obU3gj4Vc4+XGBt9ARLmLgr1lVy9tbrCpQdxZ7NsZtsochTyMKmtmMRjJzAAv8NO5/36Ai5EvqguFYZKzwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIYlg2wz; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIYlg2wz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso108950a12.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344324; cv=none;
        d=google.com; s=arc-20260327;
        b=Q/BSoPU66jc4KZeAY5ksPtapLd5oJsRAVHo0nQyAXcN22kaKsDImdIz5B5tmMAk+3g
         x0VSfX8NXYuZkVFOxtvZgBJoQeGf2oCehHqVQKcw6U5Evf/USdQKZydqM+Q20fFyH1wf
         O/l08EHSHhsyCCfBtTGy781r1b/D9HUSfGArVc3g/aTrSnmVd6pWy1tcY9ZPQwXH0tF4
         MfsLPIHymCKaKaCfu/LYIBgjZkysd0YnJUchfDPzS1S7v9gPElgAG1Ms5L0E35+jeCYI
         VcHvmyvb0Ef3XFGezTwUeqI5Xyhwf2Sc84iz7U2DXwWKSfFgd5kZV5AO9py6ckYA+hWF
         ywTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FWzDG+ffAQlStkRpHvHJS6/rK/dWRxR6zPkTRl8EPvk=;
        fh=LKGfUj0v36GWZKXUvA4BuuQNer3CiaxXUtYelmTZ2N8=;
        b=WogA5IbwvsAlUjjrn0aX7hZO2iw03HboxHl1eskHnJpSE3SpvwvI9l2PleXN1stFgD
         Dt0xFGwn0EDGDgUrgkJ32WAtltng8RUlMjUjmy37uzSnbdnfERXJu0+Ax48Qa6glTyjr
         D5nTVoz/hS+BEhl2+2oSkOa5vOtYE0qwxyLzqhP+Ucb/JqAoPTA5XjPW7pfCkHkRqMFY
         ioSIgeZjY7xtH7b4k9TWMbiCmbrGQD5LzzEBJWP0SFMmALGp/qfFXPRyIOd0tA4oYYcX
         F+q2nncBZDo+eum5gy/dH09FUL3tUFpcA4/QVy5p5bV8k+FsD/39tzbK/As9Tlems7XU
         Rphw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344324; x=1785949124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FWzDG+ffAQlStkRpHvHJS6/rK/dWRxR6zPkTRl8EPvk=;
        b=IIYlg2wzcQLc9MMiRJ/yMogiMUomrVzBAFrOd6vJfMRSED+BUpSWCHG5Fk9NWQR0Qc
         IEgmREIAB2J8PFLqbMyXvr+baEJjI50pptLZTcrlylAvn+1UZyLSa6Je9YOyFY8Q2JQU
         kvjxlrWqr0YnziLmtMx9RH25cJeDdxSAkJeL/9ZanopkTqR7bGaB1n2inv8MpEFmkacj
         KYpPC7Ilv2bsHU0j4Ni2sW3mxe3hUYCYTkExp1Y4WColSS8ujzRebbQiSzoovOoB/+sm
         WMoXbOOioRQftCz8j2isNkcPJWZ1VGzI8eZ1EYDM6F6gUSzFIKS2g1UsEuG1xNXS4Hn+
         ayBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344324; x=1785949124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWzDG+ffAQlStkRpHvHJS6/rK/dWRxR6zPkTRl8EPvk=;
        b=Vr3glwzQVUEmCKvVoZVzEI0lxANQBGJe2w0OPXg/FBQKf67qUrkBp6+Eq1lFMrt8+W
         c/fNtaFCncAPh3DxSUH+emuHpn1JiyQ0sYsD65hvhOTDfvsM6mXC064ng8ZhsMw4gZzF
         9tnmOPI3lI497Zd7m5MeuTFaq87lg4lAl7n1vMCujGlTDul9q8TceMLu5RdJ264BxgRz
         3AxC4W1UhpvH4sxonakiThXRO+AArLLnr8CZ3bi5nZ70TfFKxg7WVqmjRs+xLmkY4zdz
         NWcNSUZzbCtd0bubKTzxTPf86ZsMANJ8sPlfcmlB/J5yDuOJDPAUyC0w50ViLtFGpahg
         HR1A==
X-Forwarded-Encrypted: i=1; AHgh+Rqnu9IaN6Hk13RNO8vjeMVX3f6LTSvoZXRuf2HndJmPsOAcR35m99WoIBzn+ttbHFvlzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MGq7n5Z+T9W7FvjHR12p7t4hwWSq7WwAupzUZSmZThV8qoO1
	bUo4EyVyItAr81hps4R1wKyxyR0cP8BL+cpqualbqqHgSiWlVHIaoadSpcW9RrTwe6+W8bRg3Ms
	qGOrM6RY8dJ2ogPd9bvtcVFFfxXwLlC0=
X-Gm-Gg: AR+sD13tvXVC5Y0JERrE/6f31PWyC2ptomCHutiIDqtlhE4ZYXe10FRblKzzlIMg7Ap
	+Z+jOQKKjV0obkvMZIITjPFWEG/aJp24CxGtxumAPsJyWjjBli3AyAc5b9KQgho0O6i5RRnOgvt
	I+rkqMC66AWuI29nJ3TchMTDHJC6nTX1XzH4+TUfKiabQFUmAz6TRcFlyX2b5iBZZxPn0d7GDRt
	Mk3tsU9vL/ziN+6OJ4SZhC6YyUEDp/1AsJ7Yw+EEnWkgdKungAtb2HDj+3meZSCyG0NXdgh7pab
	lz6y55HlhRev7YphUPvaV9HyZ4PTIEVcmNmk3+QhW+j1AifMVs1f+BcpfKzh
X-Received: by 2002:a17:907:3d02:b0:c12:7f75:7900 with SMTP id
 a640c23a62f3a-c1f8cd08f80mr195416466b.27.1785344324039; Wed, 29 Jul 2026
 09:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 29 Jul 2026 17:58:30 +0100
X-Gm-Features: AUfX_mzDf5F25JYt9yoajr0h05-J_vf1T6_c6FUoxZftM_aMhuMw32pTVAD0Y3Y
Message-ID: <CANk7y0hwPBrMi4hMaBvDP41x0oyEFERsf9=TeSZga5Q0SxwimQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix mmap_lock leak in irq_work path
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:31=E2=80=AFAM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> stack_map_get_build_id_offset() introduced a per-CPU irq_work to defer
> mmap_read_unlock() from NMI context, and bpf_find_vma() later reused the
> same mmap_unlock_work. Both callers only check whether the work is busy
> before taking mmap_lock, so a nested caller can reuse the slot before the
> first caller queues it. Two read locks may then be acquired while only on=
e
> deferred unlock runs, leaking a read lock and blocking exit_mmap().
>
> Reserve the per-CPU slot before mmap_read_trylock(). Use the same wrapper
> in stackmap and bpf_find_vma() so both callers release the reservation on
> trylock failure. Release it after the irq_work callback unlocks the mm.
>
> Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
> Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dcdd6c0925e12b0af60cc
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/r/20260630033745.B80201F000E9@smtp.kernel=
.org
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
>  kernel/bpf/mmap_unlock_work.h | 37 +++++++++++++++++++++++++++++++----
>  kernel/bpf/stackmap.c         |  3 +--
>  kernel/bpf/task_iter.c        |  7 +++----
>  3 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.=
h
> index 5d18d7d85bef9..d416e4337635f 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h
> @@ -4,12 +4,14 @@
>
>  #ifndef __MMAP_UNLOCK_WORK_H__
>  #define __MMAP_UNLOCK_WORK_H__
> +#include <linux/atomic.h>
>  #include <linux/irq_work.h>
>
>  /* irq_work to run mmap_read_unlock() in irq_work */
>  struct mmap_unlock_irq_work {
>         struct irq_work irq_work;
>         struct mm_struct *mm;
> +       atomic_t active;
>  };
>
>  DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> @@ -18,8 +20,8 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unloc=
k_work);
>   * We cannot do mmap_read_unlock() when the irq is disabled, because of
>   * risk to deadlock with rq_lock. To look up vma when the irqs are
>   * disabled, we need to run mmap_read_unlock() in irq_work. We use a
> - * percpu variable to do the irq_work. If the irq_work is already used
> - * by another lookup, we fall over.
> + * percpu variable to do the irq_work. The active flag reserves the slot
> + * before mmap_read_trylock() and until the irq_work callback consumes m=
m.
>   */
>  static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_w=
ork **work_ptr)
>  {
> @@ -29,9 +31,10 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct=
 mmap_unlock_irq_work **wo
>         if (irqs_disabled()) {
>                 if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         work =3D this_cpu_ptr(&mmap_unlock_work);
> -                       if (irq_work_is_busy(&work->irq_work)) {
> -                               /* cannot queue more up_read, fallback */
> +                       if (irq_work_is_busy(&work->irq_work) ||
> +                           atomic_cmpxchg_acquire(&work->active, 0, 1)) =
{
>                                 irq_work_busy =3D true;
> +                               work =3D NULL;
>                         }
>                 } else {
>                         /*
> @@ -46,6 +49,32 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct=
 mmap_unlock_irq_work **wo
>         return irq_work_busy;
>  }
>
> +static inline void bpf_mmap_unlock_put_irq_work(struct mmap_unlock_irq_w=
ork *work)
> +{
> +       if (work)
> +               atomic_set_release(&work->active, 0);
> +}
> +
> +/*
> + * Try to take mm->mmap_lock for reading on behalf of a BPF helper that =
may
> + * run with IRQs disabled. On success, *work is the slot to hand to
> + * bpf_mmap_unlock_mm() (NULL when the unlock can be done inline); on fa=
ilure
> + * no slot stays reserved and the caller must fall back.
> + */
> +static inline bool bpf_mmap_read_trylock(struct mm_struct *mm,
> +                                        struct mmap_unlock_irq_work **wo=
rk)
> +{
> +       if (bpf_mmap_unlock_get_irq_work(work))
> +               return false;
> +
> +       if (!mmap_read_trylock(mm)) {
> +               bpf_mmap_unlock_put_irq_work(*work);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work,=
 struct mm_struct *mm)
>  {
>         if (!work) {
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 41fe87d7302f2..166fc8efab8b2 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -415,7 +415,6 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>                                           u32 trace_nr, bool user, bool m=
ay_fault)
>  {
>         struct mmap_unlock_irq_work *work =3D NULL;
> -       bool irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
>         bool has_user_ctx =3D user && current && current->mm;
>         struct stack_map_build_id_cache cache =3D {};
>         struct vm_area_struct *vma;
> @@ -430,7 +429,7 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>          * fallback is used for kernel stack (!user) on a stackmap with
>          * build_id.
>          */
> -       if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current-=
>mm)) {
> +       if (!has_user_ctx || !bpf_mmap_read_trylock(current->mm, &work)) =
{
>                 /* cannot access current->mm, fall back to ips */
>                 for (i =3D 0; i < trace_nr; i++)
>                         stack_map_build_id_set_ip(&id_offs[i]);
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index b256fb9c1214e..e66e3484f923d 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -755,7 +755,6 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, =
u64, start,
>  {
>         struct mmap_unlock_irq_work *work =3D NULL;
>         struct vm_area_struct *vma;
> -       bool irq_work_busy =3D false;
>         bool __maybe_unused mmput_needed =3D false;
>         struct mm_struct *mm;
>         int ret =3D -ENOENT;
> @@ -792,9 +791,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, =
u64, start,
>         if (!mm)
>                 return -ENOENT;
>
> -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> -
> -       if (irq_work_busy || !mmap_read_trylock(mm)) {
> +       if (!bpf_mmap_read_trylock(mm, &work)) {
>                 ret =3D -EBUSY;
>                 goto out;
>         }
> @@ -1191,6 +1188,8 @@ static void do_mmap_read_unlock(struct irq_work *en=
try)
>
>         work =3D container_of(entry, struct mmap_unlock_irq_work, irq_wor=
k);
>         mmap_read_unlock_non_owner(work->mm);
> +       work->mm =3D NULL;
> +       bpf_mmap_unlock_put_irq_work(work);
>  }
>
>  static int __init task_iter_init(void)
> --
> 2.48.1



Thanks for this, it looks good to me.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

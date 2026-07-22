Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54F33B6F9
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701456; cv=pass; b=ugldnsViqX6CEHrJ1KSJpbefAHy5XK8N9fpPhI7hIKMlMnptZ23S5tnl9wepuqTg7gqIN6u6GiGRs3ej24JTu32CbdL/YGtuizNW2oBTxFIH4pvAtp+9YoQ286E8KXyEeAENO8WKIcvQgwIyPlv5Ukt/WNDUrqS6wXOIXRUPLCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701456; c=relaxed/simple;
	bh=JPeRvgpEvIBeYXa9RYJjzJv8zZ8DuclhDrCOS+sRYIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0oIzzeNBws7ksWNZrbjYOboQHT8fMpE/1ytqRD05cKWOVeCF3TnP+Q/C4FVsLX6bTDsGPK5ECTGQp11spJAyxMJfFHPEIPmWCkWh2H3Da+dg834wTc91k0nz3CWNPKPNXTN7Tl+bl2StLz/KXSlzFPVBFiazTHZPMg5ymxyY10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GczUwY4R; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GczUwY4R"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664c6304683so7143546d50.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 23:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784701453; cv=none;
        d=google.com; s=arc-20260327;
        b=LvUCn+LxAVuIac2vwAwV6V1mxrYlz3YQ/Pma9HkWac5ZQ/r0udllm3159FR3D1HCcX
         03Od4kENqrwIrmGR2hPwDWBufpv5401jd/jCU4Jx6pYyDyOGoF2dX3x3vaW9reKmEt8a
         hicpFSJLOgR6NYLTZyTh4modV/PCvD2KpWhDgz6hZdR20aHTl87jOZGPv1Uyya9V4V5J
         jlSpBi+0EvwRCM3UPCx/QlVXbzb113nZBYaBBOhJHIj5XcBpvRmGGjpPbCP/OOj3MyRv
         kTYHvzVFQOwN2c9XSqqFdFxxVGMkrOMRXRcyYfY8dZdZ+Lw6qfwAzKeXeFv3GDbmoqXV
         41iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19lXecs/75Y4Fu3RBqBNVxPsnCrq7MTAUPM8gkGBm7Q=;
        fh=alvCsyp/1b32dpoa4D69YCOvL9T9eV1YoI2l73RiDLQ=;
        b=JRMjfn4JKGAudv8xFoQuTPNvpkcTeQMvforT3SS4vqna5EeqhmSKjEkdVrRvzpDTQ8
         lCGRSpSlrfEEtkS9Tv/px40ZyWRha+dgjcLQXDikMb3m8LMwd0UJRguKGsftB3AIrwOc
         P8rqwRcJ6pPoSE+RoJ/0xD6vu9v4ITmj0PwWNSUaNIzqo80WCeCUQ3Q71wAYyMxI5KAO
         eUQeZEmd6AQ2dgN9W/M7+t7KR0wCOQydtzUxpUX0UiB5t5Ec3PxVBW4wiRhIh6EWQEVH
         AfIhx7LtUxCHfceMAbTufO1nfmnAxoYEiw1UDAznc9UcjfzO5QshIUg76u+R4ycvuTwq
         A09w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784701453; x=1785306253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=19lXecs/75Y4Fu3RBqBNVxPsnCrq7MTAUPM8gkGBm7Q=;
        b=GczUwY4RmeoeVAFA6uGArFQMrGMcyE/C2UfNbyvEjujHHp3W616MsAn0m9f2tmSn/C
         BGQNvU+cxSQHnIugwLRcQnlP7XaOADRrlE0gMqWGK/TGIcFSmlU2WPUHlbstHCXg0Iym
         /uHasxzYNh1N/c2F3DqDlH3SXk2ZXK/vJ0R+aw4u7DVGNO9nnJYKXBqDjuHPd3t7sve1
         ewp/gxhAXc2ZVrZnaRYv76uYRHa3BUclR2bJlEvEo08zWgkqTZaFjqkeLrWHHxTPCyB+
         itUJWqO40gBy2FP0XfRODPbFDpIOmHq722qsU+Ww7MiESHFzJGncexYxJkZ4f43HUgTc
         X3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701453; x=1785306253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19lXecs/75Y4Fu3RBqBNVxPsnCrq7MTAUPM8gkGBm7Q=;
        b=KAm1A2JnyCQTFZqxYU3U8ePtDsHhSCEGUyH4u2Mhl4jBaNfOLlBmAxwDSbg39SjbsX
         NjsAaKerIw/IZ9IIUgR+isQj8tYT1ByF8BbFnikRkr1EwW+oeX9CJKRnECmJNfqn3yS7
         jkPM+csq/DdiRlELc8BAxoViA35CBvECr5a2VLToraVxx06rEpqI9gaD7DejXqJuOFkZ
         89SrGircKaQRkYILbBDBbOtg0qOPvF8G0CwO+/UMs5OcZCx/j0W4YhQe/F6kO7eIUDXC
         G48f71/fNG19dPXomHUceL5EW7DGq464FqvMKy6QuoE8tXBoi/IV+lhoIVd72yC22f/h
         eMeg==
X-Forwarded-Encrypted: i=1; AHgh+RrbSRG6R1viauptd3QbAuv3wI9pHsP1QV7KJgFQjToyTADGvRBHEdKlSiURBdLv/KkLdw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xCZjInlPfHPMV3JLQHRsuG5T1lg3xw5DS7C2wtOoQpMu8IpV
	NQZCBOo3hGfTg69VKCx9HJc0zbOaemKQJyXcEfmrCL0wbFWJrB/MU7KiN8exjHdrhrqn6rznKqU
	mKeEikO3T0Ok1cDCiZ6cMBPpZJzmze/U=
X-Gm-Gg: AR+sD10Mi+ufWVVMpgaN0ycITkJVVBV7C7gqDIme8MlSE7MsSaiFsI1Gyhx0AENyqG1
	Rj8Ax55rQuIxQjf7IxyyKxU7/N6nNF7xsEeZsE/W9j1FR5apPtnXYch7qImJKhHeK68iM5GtBTW
	f5+I7IIgGJaajTonSh9cO+9UWGEo13ISCZNE0mVqPq4YeVt6pMASBUragg62KKv/I/cbOlUw5o7
	FXET9iq7ex4Gvu/TltNVl2CSgCWag0N1IgkUVr1qgKmpC2iwtDWzcx4KcSX2H+/QXzUYZRfafaC
	dqP7AduWBWf5hSfWkPK77X8kTZcT0Q==
X-Received: by 2002:a05:690e:4553:10b0:668:97de:2a95 with SMTP id
 956f58d0204a3-66897de3527mr84066d50.93.1784701452236; Tue, 21 Jul 2026
 23:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 22 Jul 2026 14:24:00 +0800
X-Gm-Features: AUfX_mxsj2zlJCkqZolHNZICUSB-1PJ3zkEfzs1Lmbm4aZUeZowbpgkTucPHer4
Message-ID: <CABFUUZHiBwM8ekbTqGYqEi5PHu-Ge7AyzMhG1VyPget4okguLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix mmap_lock leak in irq_work path
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:31=E2=80=AFAM Sanghyun Park
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

Hi Sanghyun,

I tested this patch (HEAD 384544c1660b) with a local IRQ-to-NMI
interleaving harness. In two runs, the nested bpf_find_vma() invocation
was reached after the outer path had reserved the per-CPU work slot, and
it returned -EBUSY as expected. The outer path then completed and the
loader exited normally.

  run 1: outer=3D103475 callback=3D103475 nmi_seen=3D1200
         inner=3D1 inner_find_vma=3D1 inner_ret=3D-16
  run 2: outer=3D177463 callback=3D177463 nmi_seen=3D1198
         inner=3D1 inner_find_vma=3D1 inner_ret=3D-16

I also ran:

  ./test_progs -t find_vma -v

  #132     find_vma:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Sun Jian <sun.jian.kdev@gmail.com>

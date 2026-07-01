Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CC431E74
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935327; cv=pass; b=oqE1FpIRiuFu7AEJ0CXdISI5nTUVzsnmGnYWs3OKTIJZ3Mx0W/B6sFximvNnrDZ7dJhpwSlVh50l9BIu5Lreus/MlP6uBZocwi6BTgZLUkFAFc13I+WsEOm1UsPLxFeA5YU5gXtywo0mqgeNwklSfb2ZiMXouUsQYiAe32i/0M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935327; c=relaxed/simple;
	bh=VRV5KgkU07YRp+V1cPOYMBiaD24MXTcbDBcsQ0F3bYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgAdjAcOksT7K9X2/bxnVuIreBXHHRNdqFscFb3Frqdjs1kbWlyQW3tuba4UXBIs04ST68/uvTDtzGgpqyvf/HoI81c3az+GeCV1Zom8MOr1XaUKYFn559AQLxZNqGtpuFCxMUqKleHUyz6O8HKhuhPsMdGBbRd/2Pq0v5R+ysI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWOtjpAd; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWOtjpAd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c8017e981fso9843705ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935324; cv=none;
        d=google.com; s=arc-20260327;
        b=F0JaS2uqIUWJ1Et4xNlk5E1HdF6mtzjky7TKQCrhaYf5jl1hKQjnJM/yNjMvl/F+6K
         BInpXtPmTPuSQOjZzfsPy6mzXrJOew7SMIt9YCOxyBZvvD+MaaL9NEO/d3DFwdtM/2vy
         d5ZyMuZCcMeWTx3gXn/kphSxGXUVnYMkgggFdGCLm/HCrmgTseX9SuGBKFJh+36lbnTG
         Mw/9qpmGxq8WLNCQePIpiqAyGfffKyV0wq4dJELpd3sJC2iRmXU0fppykZubHAm0d86e
         sDxCqHKuqmJXmktENxIa1xcGbyl5vsoN9ZjZW/MtcFMvCxJmm/lk04Vg9B+h6aYStscR
         EuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mEYTvJzhL/V6TzuY+V2xTyCWfMI86Ce8S1qOhL0LveI=;
        fh=ZZ/6d592NF4PAdXHZ4sOydrM9uE0eYB/1zwMxBxzMpk=;
        b=nCcPQ8JkiWGMLwUfc5pC4NaSMDGiHamhUvM5x+BMy70cmcBrp7ZjmsX1byyMcQwGjC
         /ssBpZXwL+kddn9hpgapZQXyJudat57P2Nl775kFVlJQPXrvC8sAVPuPvE2CYaIOc5nA
         qit6shrCLfMGn6fm4G/Gg691jMxhJxLpKlZFkKI9w8QX5wnLoV/CzIgSKhQ/vVt3ABmA
         ZCNW36ZxmAkhju/byvD+60L7nHkI9dmPP4KTjXn+3vTSaeWb2j27egsLDRJ7XKwlHMKu
         dXliLLAECZLER9FlrUyiyuzMxpRku0q3r4zkTWcZRtChX99mztLCfg6VqrkmUgQSnCyP
         U+7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935324; x=1783540124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mEYTvJzhL/V6TzuY+V2xTyCWfMI86Ce8S1qOhL0LveI=;
        b=KWOtjpAd3EZ4T5akihLqvwMh4xzj4VeJ2duFgtt2IyMY+bomQBjoiB/XNFLwbDbpmN
         /kJOb2qXoTGdgGvqSahz/0TvmD/YoGeexFXN1edS02kP0qdQemQytBzDBKZk9pGbFG+P
         M0R2VDNXDPY5H4wD+QFD7wGghj/U4lANgRf/Wz+n7r4HVc3fi6YW/2cOFSzAThuaCqol
         sVyU9o2g7lIHg3c2mmXsRXEP57AFCDCMnufP4XPHK8owfW264fGetGrcgHmUmdnr3Ak2
         GchGI71x7Wo4HZjdQK6PZ1KWzDS0XhcCLkUzKVXDMvSBQFchqvvpndqMXJD2BmQqMQDB
         gCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935324; x=1783540124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEYTvJzhL/V6TzuY+V2xTyCWfMI86Ce8S1qOhL0LveI=;
        b=oRLjXHsNVO4u8b5q9KSPslAKYRJFjbrIjvDhINXX/GAu0U98gqhopvKneV1u4xHvOb
         13jeh9QnrsNWX3xnqmNvHukMguauUWCGkN0JYeG6DKvWrTSuo+/BQZeAL2HemMrXo1xf
         5u964QR87XT3QChKViPKWzsExqK7shYPb1+6qeQ0eCcw5KXUziyHAIs5xwYDEHkR4Cpp
         ZHbsbJYK7X6kwHQu+tQhx0fk0CKsCb9HDY2t85ybukidl1nVZocOo3ly1eZ/LBpa2ihX
         pVHHV5cCC14l/l4lZote+Cj0AvHHhbvaTRqRoGAA4+z22Ki1BFJHJ1F/jNLpAWGpZejt
         sIBg==
X-Forwarded-Encrypted: i=1; AHgh+Rqo6TXEyTAHYB+SShm1U6Af1Z7W33HuNjAcRWxIxbf31ubYui8BaiNB4rSidmcsvFzbG+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeF8u8iElXacdySy6ciOcvW7tlBDR/ogMuAScJMDJi71pu8r8Q
	Tk+9mwrDBPw4xR4c/qq51nuVA5+KlbO2GYRkM76RM7834vH42a7qtLbFUejKIFLQobKLIAtvOKv
	zkhX+JD6D1OMm7GBygStpnRuAOGuYE9s=
X-Gm-Gg: AfdE7cn57OxIJdDeGNA9eFxJT4zVTzp6JcQZExon201D2rMzBbu3IyYLl4+5ROIhU/p
	gfgm9x/TvxJbBmMRKJ9bTSDyfgxZBvxgS7dpIg1BFi+R4P3LjIobk3N9nTareDt6WhlvR6fpEnX
	75ryYfN9wkpuyuFPlstU4jeJtMEhQnZnGdL9w5BqmB+1JRcVM/reh3t1uPbR3N38VkkMCVkrQrb
	alR+BWzQxAZcxP2z9Y11vJVRsGFZSS+UgtHA1mWbhuqevYK5C/5iOuXmH2x0CY08lPsbVE8yitT
	svA28d84/AwLAlZVukwrik0n7z5moOXP7yH0RdCwDjPhBDDs2t0XgA==
X-Received: by 2002:a17:902:ea01:b0:2ca:26bf:1e4e with SMTP id
 d9443c01a7336-2ca911f4ef1mr19301685ad.33.1782935324450; Wed, 01 Jul 2026
 12:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:48:32 -0700
X-Gm-Features: AVVi8CeqSOU1jRVL8sOTHxDANrTZxaAXpNSR-QiYf_--pIO-WKYYHaPy-b0zdYE
Message-ID: <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:25=E2=80=AFPM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
> can free the mm_struct between the lockless read and the trylock,
> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
>
> For the current task, task->mm is stable. For a foreign task, pin the mm
> under task->alloc_lock and release it with mmput_async(), mirroring commi=
t
> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> Use spin_trylock() instead of get_task_mm() so BPF context does not block
> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> foreign-task path because dropping the mm reference is not safe there.
>
> Race:
>
>   CPU0 (BPF program)                  CPU1 (exiting task)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   bpf_find_vma(foreign_task):
>     mm =3D task->mm
>                                       exit_mm():
>                                         task->mm =3D NULL
>                                         mmput(mm) -> frees mm_struct
>     mmap_read_trylock(mm)
>         // UAF on mm
>
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---

Puranjay, PTAL, I think you've been fixing similar issue in
bpf_iter_task_vma_new(), would be nice for you to check this fix as
well. Thanks!

> v6:
>  - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy()
>    still uses it.
>  - Keep the direct mmput_async() call in bpf_find_vma(), but guard it wit=
h
>    CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU build=
s.
> v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.park.cn=
u@gmail.com/
>  - Replace bpf_iter_mmput_async() with mmput_async() directly as suggeste=
d
>    by Yonghong.
>  - Add Yonghong's Acked-by.
> v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.park.cnu=
@gmail.com/
>  - Use [PATCH bpf-next] subject as requested by Alexei.
>  - Add the missing BPF maintainers/reviewers to Cc.
> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.park.cn=
u@gmail.com/
>  - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
>    trylock + mmput_async(). (Yonghong Song)
>  - Reject irqs-disabled contexts on the foreign-task path.
>  - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
>    falls back to mmput() which may sleep, and bpf_find_vma() can run
>    in non-sleepable context.
>  - Shorten the foreign-task rationale comment and trim the changelog body=
.
>  - Fix the v2's whitespace damage.
> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa=
3_ZenPOFkA@mail.gmail.com/
>
>  kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index fc5f463ca529a..1d56193caf5e4 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, =
u64, start,
>         struct mmap_unlock_irq_work *work =3D NULL;
>         struct vm_area_struct *vma;
>         bool irq_work_busy =3D false;
> +       bool mmput_needed =3D false;
>         struct mm_struct *mm;
>         int ret =3D -ENOENT;
>
> @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task=
, u64, start,
>         if (!task)
>                 return -ENOENT;
>
> -       mm =3D task->mm;
> +       if (task =3D=3D current) {
> +               mm =3D task->mm;
> +       } else {
> +               /*
> +                * Foreign task: pin task->mm against a concurrent exit_m=
m().
> +                * Use trylock on alloc_lock instead of get_task_mm()'s
> +                * blocking task_lock() to avoid deadlocking the target t=
ask.
> +                */
> +               if (!IS_ENABLED(CONFIG_MMU))
> +                       return -EOPNOTSUPP;
> +               if (irqs_disabled())
> +                       return -EBUSY;
> +               if (!spin_trylock(&task->alloc_lock))
> +                       return -EBUSY;
> +               mm =3D task->mm;
> +               if (mm && !(task->flags & PF_KTHREAD)) {
> +                       mmget(mm);
> +                       mmput_needed =3D true;
> +               } else {
> +                       mm =3D NULL;
> +               }
> +               spin_unlock(&task->alloc_lock);
> +       }
>         if (!mm)
>                 return -ENOENT;
>
>         irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
>
> -       if (irq_work_busy || !mmap_read_trylock(mm))
> -               return -EBUSY;
> +       if (irq_work_busy || !mmap_read_trylock(mm)) {
> +               ret =3D -EBUSY;
> +               goto out;
> +       }
>
>         vma =3D find_vma(mm, start);
>
> @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,=
 u64, start,
>                 ret =3D 0;
>         }
>         bpf_mmap_unlock_mm(work, mm);
> +out:
> +#ifdef CONFIG_MMU
> +       if (mmput_needed)
> +               mmput_async(mm);
> +#endif
>         return ret;
>  }
>
> --
> 2.48.1

Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C63ED5B3
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690820; cv=pass; b=LGqcl5ucZcVoXFO3xLcHxvrdpmMRX5ybuS6cjQdPkP6tTMXS3cV8KnH7saVurjQRwPmdzUTCAO3iUXh/X/7Gu+R19KlwfPZVMjBmeMDrkxHO0Gb5WeA6XnLOhT9+9EbBT0II/znSWPAAg7SJBaYegtDqhLEcHN6zQuS99OtHWRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690820; c=relaxed/simple;
	bh=VY7/ARQ274h4uKfie1OktnCkIxcE/wgH7GGSyqdtydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7zQKzZkXczCDoA2ktcR09RsCXLgKztEDS5h7dOsA4an1r2fkEI5FQOOVmMeXRm5GyRKZqxPDHff/DN3edtP5TJULDL+ytX4xcnz5Juz51CgZbYCvptShUfhHoZ0iMFh7S0o724dqKwS2pfcWOu0FkMZPnrL0dedqJDcMAEU95U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/kjkEYN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/kjkEYN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a1e732e5eso20396027b3.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773690818; cv=none;
        d=google.com; s=arc-20240605;
        b=N6W5pRyBn6zsbTlCk8W0cdxqbuVSGZxO2qd9d0dR5TfpHCxWPG0KTK2ktEVroLa1LP
         l8l+I0ilseKXu+wqfAMnM8CXOFEOLPfWtcBOQSqQj6L/6GwmXjWb2w0IVqEiVAYI6QAY
         ErnWJCD41wsqrXBwlbp+wMNpZqcDfG55qjXvPaJyw76gGBn87ThEGLbwZaJTyfLLSrZh
         pLFPdn4JsE6lnygQ0qyL39KI3MkYQ8okvjSfohbrkcIhLAqhZxHciEdSwWpUFgy/Sy+C
         W4FZOzRYLGvCWL5BNjQkdAwkREPw4Kl9xVt6OOYCpf/A0MivJ+UwpOZgDVObfD+xaljI
         XCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        fh=VHJWUKlk9QSj6V5TfcZaJkODFXxQkKpIImsatCW5Hgk=;
        b=HwxQe45KvXEFKNQgzij/d7JTIWgv3F6vv08e9++N0d+fS7QjS4lJIUKQNMt1D4rlHU
         Kpb/Fq72PuKatw38GcUmXa0lFamHc2bXYp72HQN47MGOU+8LLoai8oFOD+7ZlXLSrH3X
         +Dz0ND/slX3KQWLp2cYVUwafTis4uTqQHdp54SxHmITmEqcUScnw2KdjArjPbQV+8s5g
         rJLU3ATYh9nwqHMeBxA76sjnt68ynR+sJxb7XooMESYZXO/68iFQhIvapK/0GLE8+ZOt
         fOyPNI7t1dkfSxstmWeEOin2LzJj6c6gym76yaElwXK89kUqldo00ELExpMDbtO0I1vw
         +p1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690818; x=1774295618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=c/kjkEYN3oBorrXhP4wUvrrlFlAEgUgv6mZICv0wTLd3Dg6GwDE1PStnQQ70b8nlmX
         +lRI7ZL7OyGshmCQ3mNL4Bjypn6+2hV2m0tJVMgIG7EJAyoxI0sM4zSuKRLaItSg0RPp
         34OVwOFOPl45i6ASkzCqC3I1C/g6oIwfiIIOJqMDuxdZt8g1OqADU/DOTrHV5vniTg8j
         NV/T/sfOWT9wapsnCCquzHghKsuNARxerYCY7FExT3F2FUTYjVCCkxSdQcd8oMpED5pL
         GInqJGmcQrELNrFEJQshbpbxERVxHcRDq8mZjMvrxu7ZeqH+JYSSmW2g8yi6rrr0zLYi
         ccAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690818; x=1774295618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=Is1RCpbajUadu8+xcKUMm4z/3OJOEWnisoVp/4iRbKoaYfd2B6+UQpOIOOSd9409by
         61ucQAstMN2pm0Wb/wzKdnLPnnm2NUOc+fw5OJFlwGVe3JGmybVUv11+KR3sUWa/pIoC
         dUqVeC/T522MGK0xemc2t7dvpGLK5//EaH9y6f4UZoBBrQEbGWiHmeK4xyd0Q1foXAgr
         6hrAkdR852bsNrFqvnuf4X+lZcfZ/1SWu34NLUXrKrbaY6GpDrpft96lGXfwo17rpLFC
         39b+By6DRG0GXOzHUcgV5DnJZ08FiRHM766/zl3nK/NG+UeH8CPwvUaYKYPl4VAfctli
         5iuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovMMy3/rBfwyGNaM432pAY2vHJgHGKIdY2D0stUfSugyyrWzJUWsNVfg4mROFF2yi9E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSI+IF09nmiMWIrfjzxtawN585V2YeGRRJ2FdkEDoXCib3UaO
	OQ9f3HruuD/7+O7j40ndk6HJCikRYv3kTCGXXQwQW5R2LY9JCUDt+ERyCfoOtT6B7YGJTKmYHlf
	lC5f37AJa58btJMzAGNG9H5PLYxHISKo=
X-Gm-Gg: ATEYQzw4XL3cb+/zMlBoo3pTgp2MrsdveRp2KkWfAW7J2Rh/cF9qyuo9g8/NDTgyjnf
	msKN/EJK17Z9q8w4FVfhHvUqEk0+gPT/8dlyD7cBKaUJwYNAsDicuIBVptKdm0nC9816Zqqv5jJ
	BR88vz3qTDD/8xENDIKqfrEW0BOfwY7Mo6185PwozKGkESKpfHh+3beLinLviJrSJlnt9fVn9t/
	iSWggGkSGt25zeU6vTnaX5tDhkWv4ksUUlbteN6aRoFiIsdC5Z1EZcZ2R10Skie3bUSol0CkK8q
	T5rG7r70x0BAXucXAwUVCjw=
X-Received: by 2002:a05:690c:6c0b:b0:79a:4317:395a with SMTP id
 00721157ae682-79a43175384mr64466277b3.2.1773690817924; Mon, 16 Mar 2026
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 16 Mar 2026 12:53:27 -0700
X-Gm-Features: AaiRm51TRiU_TdEe_xqQj-pB0MImfrzcDdg1WNNiYNlT_5xOuouk70K7fxXMtb4
Message-ID: <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
<devnull+rsworktech.outlook.com@kernel.org> wrote:
>
> From: Levi Zim <rsworktech@outlook.com>
>
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.

Let's not do this.

This re-introduces deadlock to local storage. In addition, local
storage will switch to using kmalloc_nolock() entirely.

For riscv hardware without zacas extension, I think a workaround with
some performance overhead is to enable CONFIG_SLUB_DEBUG and
slub_debug options.

>
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolo=
ck() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CREATE
> always fails for me on 6.19 kernel on riscv64 and bisected it.
>
> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
> in local storage"), bpf memory allocator is replaced with kmalloc_nolock.
> This approach is problematic for architectures that lack CMPXCHG_DOUBLE
> because kmalloc_nolock always fails in this case:
>
> In function kmalloc_nolock (kmalloc_nolock_noprof):
>
>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>                 /*
>                  * kmalloc_nolock() is not supported on architectures tha=
t
>                  * don't implement cmpxchg16b, but debug caches don't use
>                  * per-cpu slab and per-cpu partial slabs. They rely on
>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
>                  * attempt to allocate from debug caches by
>                  * spin_trylock_irqsave(&n->list_lock, ...)
>                  */
>                 return NULL;
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> (But not for a PREEMPT_RT case as explained in the comment and commitmsg)
>
> Note for stable: this only needs to be picked into v6.19 if the patch
> makes it into 7.0.
> ---
> Changes in v3:
> - Use macro instead of const static variable to avoid triggering
>   warnings.
> - Wrap lines at 80 columns
> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2-1-=
576e33e4fa67@outlook.com
>
> Changes in v2:
> - Drop the modification to the PREEMPT_RT case as it requires
>   kmalloc_nolock for correctness.
> - Add a comment to the PREEMPT_RT case about the limitation when
>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-=
24abf3f75a9f@outlook.com
> ---
>  include/linux/bpf_local_storage.h | 1 +
>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
>  kernel/bpf/bpf_local_storage.c    | 4 ++++
>  kernel/bpf/bpf_task_storage.c     | 3 ++-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>
>  struct bpf_local_storage_map_bucket {
>         struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.=
c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>          * preemptible context. Thus, enforce all storages to use
>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +        *
> +        * However, kmalloc_nolock would fail on architectures that do no=
t
> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +        * bpf_local_storage_alloc would always fail.
>          */
>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? true=
 : use_kmalloc_nolock;
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void task_storage_map_free(struct bpf_map *map)
>
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
>
> Best regards,
> --
> Levi Zim <rsworktech@outlook.com>
>
>

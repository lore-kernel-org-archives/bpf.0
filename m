Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618251DED5C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884869; cv=pass; b=NaGXt/DczFl6uUR+Kn5Z9QKvcqr3B19KAWAqqQ8xMuMTPkQehvtswkG++wFJIDC/KNYmxJjuCoqICAgdz3Q/sg96a4//EQJ0Rw1tR/RvlI9W7Uq/V7hm1Z7LqVW52cao3bPf5YaYOv0o0ZPArjc9laX06KsWVy86sjWzXmtfupY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884869; c=relaxed/simple;
	bh=XX5iiUAmS9hMQZZFWlVN3P+KFJubPiD/ksB94ASRexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnjjKYUR2dNNPT1Blp9z061kn2crgEU1FQOjMRCsgaNRQyzPOmE4GBElPYF+20lKcqBiLGJpUPw07vxMKX4SZWSh+ec89SA0pS+6AHc0e5e951pe0vf9B6Ra109t9vzteqHAIB7h7kPvW4FUNtsOFNEJw6QdvTnQMFyMzWl9tBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI+DsHW8; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI+DsHW8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36974217d4eso18841a91.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778884868; cv=none;
        d=google.com; s=arc-20240605;
        b=Fgo6z3P09WMlcOPqvFOYzM4Gp9TGMNt9tejSfXMSCq3271iqlJaYnSFUOqIXzwi832
         Gs8n3JbUepR1J4f5m51Q8EBKLBfgH8uA4o/s5h7kS8lqK18nCmJTcOCccKy45mLTWLfc
         F79bxjOwNEl+9zwCOpi4l1MMmBlrJkogv6jPDqOkmF35vGu0l928yV4f2OZuBlCsBuvF
         pXusUwP3ilbstogKz8dwYhEOjQ6XC94ukH5KBNgrM0dyDBWkKsGNG2ZbLOs+Qk+u1JmM
         u82109HSE7xcW9M6KtBMVhyxPmOLEaqrAnvxhh2SHRssUSZy+QZMw245chIamAabtjiI
         gW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4sZonZi+63Oj3knXne0RiydkPQCwPaqJreFlqX4Du8=;
        fh=xCzrO6Bu7yUrvPUsurjnkuau4fbqBFZafoO6yfAWrss=;
        b=f7+hAdZ+xhRp6ULCg4y40H0oao8/GTap7GJrV8HCYp70iGEy9YJjnx8DMf+7LGwvIi
         MQERSO8PwmkNHGKk9+eVDVnEL0N1h2fG8R1c+4P5ABf8Z5BxB9OWVI6o4TpF++gO/LG5
         z7u68iIUUFsnEHJZGucyzfWhZ2znhs2scnhxuFSPXDbUDSLjvb0wFGgP1e9YDh75B8sU
         CycQ9QiEI29rxCmkBFzkNtxbOqB7a5EYIWIYmqCqvqwi5d37HavTwJEn7xiHUKriwa2Y
         tyQiB2Yt895cgZaRQVwODI8NhEaU1sAt3asjCybviObWt1tPWNZt/W0ctAQy6hDDWci4
         gPpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778884868; x=1779489668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4sZonZi+63Oj3knXne0RiydkPQCwPaqJreFlqX4Du8=;
        b=nI+DsHW868ZXjtV4bubp7sU4pYa/gOgmeuTcK3Vwv2N6RmuPCJqIa7/JpPceD16sbB
         ahX8UzE0DN51ioo0/g6hTLegr605K0AxHb5ZmTB69iPiNo4d7UkiuHbgXnW4SSGNx1BW
         JTBOAMhIJKJFG736e/AY1S1q85cW52PiRTHlZggGh9rfV2CxNPk12sn7cI7K050Ehh8e
         kE2BpZ2e2V9ILs99AkOYHzLAD8wTk7IADIzQVlud+ZDcpe/h5VSdQrYjUI+M/0lKfhhL
         0F3X2qegp44X3JihjxL8XWiecGSuES/xxBGdEQPo2cfB8sSxi25RfP2r4nkUMAq+KfRH
         ATig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884868; x=1779489668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4sZonZi+63Oj3knXne0RiydkPQCwPaqJreFlqX4Du8=;
        b=UTu7FHOYMotaOVQmJZrTGSbtBa/0rkukl8u6ldmkx9S1C/5BPV+2VBdUOtQsZH/gRn
         QGdYsmWSwhskIj1SYZw6A4g0vyiKATQk/TpsttLD8EpVW04nVflzm0BtcogB/BbS1X1N
         iS1UiTHdRQ9jJSRDtGbpvENVj4rvdxw9W4RPU0m7ZMU6C77ZoQVRUxCXl2EMEFGPablg
         KUGWzjpgc8ng8xXugwaSL7nBkw93al2O79UQipKok+ZEnu5x93oL9qqSYQhC/aImk14L
         uQWt+jGPjb1M5Uv3oMf1sWXy2Cro6KllB9RFvCgfnU6ILuJqWtQRP9yKUEqanOk15WIC
         nlog==
X-Forwarded-Encrypted: i=1; AFNElJ+rHsoF9rSa3cOaw7izEBV/JCLPyb8J791MtUvDZ8jOc2fBcAsmbsS3sra/Pi7snn11ajQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFeMQTs+nvyzkE1ZrHzl4Kmd9JYed/St7qipDXicKC76mcMWk
	VDnNMq4I4GHkk7pmGIfsUHo7zV2x8eB719lzirnTn9CgleEn4CLBF9auL7Ei/MOclyXL3NzDlPH
	CRdMYMZhdElh6kknkDWLnYKQTC8tWy60=
X-Gm-Gg: Acq92OE7yf7TU+FDLa+ZwT7EXoXyMAnNPVaqrvVk4B5TmB3cja3MHf6/IAu1PCfGqB1
	HXNjaU7X7aJHcAUNRsRFlTldTNdzeLAriTFWmBe4aOXuqcd8e+6O/BHy9kLCA92V/yQ1boyuBSI
	K0d/dixZpq8+dQCmlcwt1shFIstUhaMcx0tdPXn8ZxSOMc/VmBZfA39T9DoYOpz6P2VcREaT0Q+
	bw0/+ZgQjjmvO+4yZPd6auzlepOLKyeBMR794R2Ivz27otWq/lItrzW5sTCHhkcWbw/C7+vLYUS
	UHYovNkLe686zqjeHM6WvAc88klM6fYRJg==
X-Received: by 2002:a17:90b:2d0c:b0:369:7433:2fe with SMTP id
 98e67ed59e1d1-369743303a4mr139876a91.6.1778884867542; Fri, 15 May 2026
 15:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev> <20260515005244.1333013-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260515005244.1333013-3-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 15:40:51 -0700
X-Gm-Features: AVHnY4IywDBOivrWUJKzykLbbZy5EXNUqxJN7RGWH43jqd9oS7xoTpcz1XNZyfc
Message-ID: <CAEf4BzZ1u6N2+cSkkSn65F_D_jEZK+4Gy_M1GNOVXkD36h0Now@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Avoid faultable build ID reads under
 mm locks
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Suren Baghdasaryan <surenb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:53=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Sleepable build ID parsing can block in __kernel_read() [1], so the
> stackmap sleepable path must not call it while holding mmap_lock or a
> per-VMA read lock.
>
> The issue and the fix are conceptually similar to a recent procfs
> patch [2].
>
> Resolve each covered VMA with a stable read-side reference, preferring
> lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
> enough to acquire the VMA read lock. Take a reference to the backing
> file, drop the VMA lock, and then parse the build ID through
> (sleepable) build_id_parse_file().
>
> We have to use mmap_read_trylock() (and give up on failure) in this
> context because taking mmap_read_lock() is generally unsafe on code
> paths reachable from BPF programs [3], and may lead to deadlocks.
>
> [1] https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linu=
x.dev/
> [2] https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.or=
g/
> [3] https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linu=
x.dev/
>
> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_=
task_stack() helpers")
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea5..08f7659505d1 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/btf_ids.h>
>  #include <linux/buildid.h>
> +#include <linux/mmap_lock.h>
>  #include "percpu_freelist.h"
>  #include "mmap_unlock_work.h"
>
> @@ -158,6 +159,109 @@ static inline void stack_map_build_id_set_ip(struct=
 bpf_stack_build_id *id)
>         memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>  }
>
> +struct stack_map_vma_lock {
> +       bool vma_locked;
> +       struct vm_area_struct *vma;
> +       struct mm_struct *mm;
> +};
> +

tbh, it feels like this should be provided as some sort of primitive
by vma/mm API given how common it becomes when one tries to work with
VMAs efficiently (in terms of avoiding unnecessary mmap lock)... but
that would be a question to Suren maybe

> +static struct vm_area_struct *
> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{
> +       struct mm_struct *mm =3D lock->mm;
> +       struct vm_area_struct *vma;
> +
> +       if (WARN_ON_ONCE(!mm))
> +               return NULL;
> +
> +       vma =3D lock_vma_under_rcu(mm, ip);
> +       if (vma)
> +               goto vma_locked;
> +
> +       /*
> +        * Taking mmap_read_lock() is unsafe here, because the caller
> +        * BPF program might already hold it, causing a deadlock.
> +        */
> +       if (!mmap_read_trylock(mm))
> +               return NULL;
> +
> +       vma =3D vma_lookup(mm, ip);
> +       if (!vma) {
> +               mmap_read_unlock(mm);
> +               return NULL;
> +       }
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +       if (!vma_start_read_locked(vma)) {
> +               mmap_read_unlock(mm);
> +               return NULL;
> +       }
> +       mmap_read_unlock(mm);
> +#else
> +       mmap_read_unlock(mm);
> +       return NULL;
> +#endif
> +vma_locked:
> +       lock->vma_locked =3D true;
> +       lock->vma =3D vma;
> +       return vma;
> +}
> +

cc'ing Suren to help check we didn't miss any of the per-VMA/mmap
locking gotchas

> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +       struct vm_area_struct *vma =3D lock->vma;
> +
> +       if (lock->vma_locked) {
> +               if (WARN_ON_ONCE(!vma))
> +                       goto out;
> +               vma_end_read(vma);
> +       }
> +out:
> +       lock->vma_locked =3D false;
> +       lock->vma =3D NULL;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_bui=
ld_id *id_offs,
> +                                                   u32 trace_nr)

why is this only sleepable case? the only difference between sleepable
and non-sleepable is the use of build_id_parse[_file] vs
build_id_parse_nofault to fetch build ID, no? Other than that the
algorithm of locking VMAs is the same, no?

> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct stack_map_vma_lock lock =3D {
> +               .vma_locked =3D false,
> +               .vma =3D NULL,
> +               .mm =3D mm,
> +       };
> +       unsigned long vm_pgoff, vm_start;
> +       struct vm_area_struct *vma;
> +       struct file *file;
> +       u64 ip;
> +
> +       for (u32 i =3D 0; i < trace_nr; i++) {
> +               ip =3D READ_ONCE(id_offs[i].ip);
> +               vma =3D stack_map_lock_vma(&lock, ip);
> +               if (!vma || !vma->vm_file) {
> +                       stack_map_build_id_set_ip(&id_offs[i]);
> +                       stack_map_unlock_vma(&lock);
> +                       continue;
> +               }
> +
> +               file =3D get_file(vma->vm_file);
> +               vm_pgoff =3D vma->vm_pgoff;
> +               vm_start =3D vma->vm_start;

nit: we can calculate offset here instead of carrying over pgoff and
start, offset formula is cheap, no big deal


> +               stack_map_unlock_vma(&lock);
> +
> +               /* build_id_parse_file() may block on filesystem reads */
> +               if (build_id_parse_file(file, id_offs[i].build_id, NULL))=
 {
> +                       stack_map_build_id_set_ip(&id_offs[i]);
> +                       fput(file);
> +                       continue;
> +               }
> +               fput(file);
> +
> +               id_offs[i].offset =3D (vm_pgoff << PAGE_SHIFT) + ip - vm_=
start;
> +               id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> +       }
> +}
> +
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -178,6 +282,11 @@ static void stack_map_get_build_id_offset(struct bpf=
_stack_build_id *id_offs,
>         const char *prev_build_id;
>         int i;
>
> +       if (may_fault && has_user_ctx) {
> +               stack_map_get_build_id_offset_sleepable(id_offs, trace_nr=
);
> +               return;
> +       }
> +
>         /* If the irq_work is in use, fall back to report ips. Same
>          * fallback is used for kernel stack (!user) on a stackmap with
>          * build_id.
> --
> 2.54.0
>

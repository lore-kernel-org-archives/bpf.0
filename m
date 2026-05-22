Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9E361DC0
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471750; cv=pass; b=rBDbhDQ5ielefPpLw5CtiEGXLcQQmp6b4UWVW0FM8CiA7QmIBDVpWOmjpdXO3d3nXQ0TsxjA4V+9bDPuue+1VtS1/4uW0Yfy1wZFAPBQvxEsRFb15jwEnt29zl6vj3Ur/GC4P3AH7Dzs++hACFmyoQGkiZuf0P8D1ULlYVEB/wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471750; c=relaxed/simple;
	bh=8AIIYCwd6OCW78bzJd2pVf+c6hfesnefwsRiLA6mlZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHQMDJsAPJ4RGj1TxPaewnietWTvlj64DcGSE3hAbU1dEQ6oDxWRt8GZ82nICnAPLm678Kgn23lCcV03EcfYXl+36lwkardfuw6vrRAM+r7Psi+Q065jrJ8iNDO1wYXQ0bH6+JPs2zxmITtskW8tz3rKO8PCx2Sw3Ho3HalHwsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeFqJj//; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeFqJj//"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365eecc5885so7062574a91.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779471748; cv=none;
        d=google.com; s=arc-20240605;
        b=DBsR//n+o1K8eV5jDK3bIGIlgDKYHkUQ3K0Ow4dJc+pCNul2jldWTyd2vhnWYppijJ
         n+KTFVSR+QgGDuMTPC4BJj4MZW0Bd/awK+p9w5rI2DgNg7H+xUqXm0tjFvZhJYuEdORu
         9SG98iiNH+TbIRXckT7xouk7raNQVFH74su0oehP8aemWOh3zwm9biTIPmjeU48GEQqk
         DozaDgFpUaDlpBhWUfOgexsP2P6pLYsWZCkv6E+IcJ7FHtjYkIdy9jx/zt80kxn1gJkH
         pqLLAqjeBOLg6X/UuHGIwP8jEIoDVJv3QbvDegQoEFpJU20+mvNWaNOkXTBkRnxE1cxM
         rkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j45vMjFgAV9ZNWynQ2PmLzDUaIqScsZmsxwYBfVpMJc=;
        fh=yOSTQulpzP5v4pqrY1GjIxjmqs/Erv9Rrf+rEv+a9nI=;
        b=Mtc1G++hV6+VGjvWXjFeC6ZQR7peReSuXJ6rPpBuuSMyWTC+aELwgS/8n2RUzdlHOm
         GPfCRfEvhKmaOcn/UvmuJG5l/FzCJm3kttp3MqnE2BJ1VEoeXJ5hzUR7Ei0mB7YgkPlC
         PFUddwSWU0Y64tZPfwMtQ70oPSy6OYSF6z9eUhyeTM4KlxgeVSW/GjoI6/sErjQ9ZCg4
         cIewWSdUeZfdRLKrzOt6VAswBQD5/ksYm7z0VFgGvSaMLxsO2CtXH9BwYF7d5c0MqSV4
         fBBITY1m2o4QoTHWMfBrnIzaBWhKZbsdk7E+6r59Xz1wXGcwxlwAv4jNBwIPgp3SlTpD
         15jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471748; x=1780076548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j45vMjFgAV9ZNWynQ2PmLzDUaIqScsZmsxwYBfVpMJc=;
        b=SeFqJj//y0S2IISGrqi5gJWaXmxkW2fI1GQkwmq8WVziLic+Cq/iW52kMq2QEWbZUK
         oFTwbPfzNxFJmKWXtoT37L15wD4mjsPb+dhl54gux/fCeMhGaACFsPvWlKTcDxYXwgU4
         aS0SVkxbExkXHSDJ1CTdf8WR/nEtYzDSqKgWWVtwUguqEj2MzuQMOTblNquNdgftjXX4
         s7Z+M6YxjITTZmytlX4avytCCJNOgp4Kdng5unvLbMDEm6ksOJh9gov1+cNpNVGT1G2K
         820lVcNbBCTZQaGI5Da9wtXXyxcA2zuqKmlL5kEYi91rKVHfLjbphM2aijHA4xDGwSvC
         va3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471748; x=1780076548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j45vMjFgAV9ZNWynQ2PmLzDUaIqScsZmsxwYBfVpMJc=;
        b=KHsrr54PcMPcADPz4EDGney1TgKrtO2ScGrP0wb+yJJbZLSyYRRGN23r6WRWLB0ruG
         ByNJIo2LbzT9FuItR71urzhaZNf7AFLw3ZFFgVr24tZn+nfTY0rizXX75qUs6f9MbrHB
         mSHUFPU6FhPL7z/qjgcB+CfYxbUw4AvUEpRsj6ztBAgQk9lSHUN1UZqznCI0N7UO+oTR
         DOqUR7uoFDc1mEz/40P+uM6SYwE+lwr6VoHAL3aglgmyRsMcs0mQ+tIkzrJ/ScqwXe8b
         Awu51e4ZL4T+NulEGjMrOv9UdlCPAkXKvrnuuy7KySdeynygSK0lR5b8yI6DKaSPRItc
         aE1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/wRxmDT8LUNoATT5EscWxMAaICUDGLE2WtTHEOX7fxqF36aRvIhp8usi9htHzNQGh8h4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0147mwIX1h0etxCK2swnbuCZfLv7X+XbEqoZKzaAeFbGufDHY
	QbBR8L3x9tkDxBZmnQYFF7R2lUdnYn3chsyO+/eBbHI0H8to5kguZmNJ+0GD2E3Rp3xqoAD5l9/
	iSQQscqf+khXHAWyOp7mfQQWpaQm7bmM=
X-Gm-Gg: Acq92OHjK8rR7ivTabFG661+R6YaMkdHGa4xyT9ZEcNjSSSFPmtug5s0wb5D19jVIYv
	X5kj/cnMzv8dLz7Pkx56XW0w/9ByzSTkmvrWfV7KoVnGX42u4QXB6N3pRhGvBjAeogLdqovQt0E
	VuA2ixdyYYk3eh+RVC0sImQvs49m1IQyZpix73mjNnKPC4ic8G4ZgnzonhBQ49qUYa+EEcLEC4l
	h/MeoaJwfhMVXxfz4pkas+Dd6D+nAGe6VCuTPFwKs940b0aqL5sMFHlLC/z2iY2Is28Ho43IZtF
	Do4FuTyxT3RO7pWt0ONm+aQisO9rd4pOXA==
X-Received: by 2002:a17:90b:5203:b0:35e:3e86:e2d1 with SMTP id
 98e67ed59e1d1-36a67472320mr4658642a91.7.1779471748135; Fri, 22 May 2026
 10:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev> <20260521225022.2695755-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260521225022.2695755-3-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 10:42:13 -0700
X-Gm-Features: AVHnY4IsLHJFzUvIc_sFbVDDrEJHQjgpV3jV3BnpO7L5YCcwegihOT-7vgFs3Z4
Message-ID: <CAEf4BzZ2i95MaoEt+twNKmw-9FGYbNJ-mLwwHRJ8yAJN7njvwQ@mail.gmail.com>
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

On Thu, May 21, 2026 at 3:51=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
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
>  kernel/bpf/stackmap.c | 107 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4c753e02c415..95336c0e8b56 100644
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
> @@ -174,6 +175,107 @@ static inline void stack_map_build_id_set_valid(str=
uct bpf_stack_build_id *id,
>                 memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
>  }
>
> +struct stack_map_vma_lock {
> +       bool vma_locked;
> +       struct vm_area_struct *vma;
> +       struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lo=
ck *lock, unsigned long ip)
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

As the code is written right now, this vma_lookup is futile if we
don't have CONFIG_PER_VMA_LOCK, no? We'll just unlock mmap and return
NULL regardless of this operation succeeding. So if that's the intent,
then starting from mmap_read_trylock() all the way to mmap_read_unlock
+ return NULL should be under #ifdef CONFIG_PER_VMA_LOCK.

But could it be that the intent was to set lock->vma_lock =3D false,
lock->vma=3Dvma + return vma here if vma_lookup under mmap_lock
succeeded?...

(oh, now scrolling further down the thread, seems like AIs picked up
on this as well, oh well)

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

see above, was this meant to be a "return vma"?

This whole function is quite confusing, please help me understand how
it's supposed to work both with and without CONFIG_PER_VMA_LOCK.

> +#endif

> +vma_locked:
> +       lock->vma_locked =3D true;
> +       lock->vma =3D vma;
> +       return vma;
> +}
> +
> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +       struct vm_area_struct *vma =3D lock->vma;
> +
> +       if (lock->vma_locked) {
> +               if (WARN_ON_ONCE(!vma))
> +                       goto out;

this should never ever happen, it's a bug, we shouldn't warn on it, we
should make sure we never ever have vma_locked set to true if there is
no vma

the whole pattern of returning NULL from stack_map_lock_vma() and
still holding lock (i.e., allowing and expecting to call
stack_map_unlock_vma) seems confusing and error-prone, tbh

why not simplify it to "if we got vma and locked it -> we return
non-NULL vma and lock is held, otherwise no lock is held (because
why?)"

pw-bot: cr


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
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct stack_map_vma_lock lock =3D {
> +               .vma_locked =3D false,
> +               .vma =3D NULL,
> +               .mm =3D mm,
> +       };
> +       struct vm_area_struct *vma;
> +       struct file *file;
> +       u64 offset;
> +       u64 ip;
> +
> +       for (u32 i =3D 0; i < trace_nr; i++) {
> +               ip =3D READ_ONCE(id_offs[i].ip);
> +
> +               vma =3D stack_map_lock_vma(&lock, ip);
> +               if (!vma || !vma->vm_file) {
> +                       stack_map_build_id_set_ip(&id_offs[i]);
> +                       stack_map_unlock_vma(&lock);

see above, I find this confusing to need to call unlock_vma if there
is no vma in the first place...

> +                       continue;
> +               }
> +
> +               file =3D get_file(vma->vm_file);
> +               offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->=
vm_start, ip);
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
> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_offs=
[i].build_id);

what about

if (build_id_parse_file(...))
    stack_map_build_id_set_ip(...); /* no build id, parsing failed */
else
    stack_map_build_id_set_valid(...);

fput(file);

?

> +       }
> +}
> +
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -194,6 +296,11 @@ static void stack_map_get_build_id_offset(struct bpf=
_stack_build_id *id_offs,
>         const unsigned char *prev_build_id;
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

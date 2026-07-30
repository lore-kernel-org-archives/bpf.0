Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A537E5CD
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455464; cv=pass; b=g6DWTkQJ2gQOpQ8qT9UM8xkT//Gv/M8bCLRtgNQydr0ugEi5pBobjKT5mCJqZpcmKkE5YqhoFZjysKpI9glNSVJUeiasZ3WJj1yi5fbcOks6JgI0+Zlsg/8ix9Dx62PwtzJAev5LDpXGRfM/R3euaHVtdGo43Z6//mj1gjj0szg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455464; c=relaxed/simple;
	bh=+VVPbvL7mocDGLXS3fELGNff80eo/dL7gEUIGSxImYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POcP86lwDYhg2g8vGbYu41ivUPvrxkWVib8zVjBPVdgbP2BtJrPIK60R03Z1HHI5HpHjMGKs4NmSMRqRSganQGzTK35bTD8K2L5WABYzSg1hvRKrXiWwj5MP4TlQHHkSwiVJTXOCdNKN/Ju4l9+ajVWkP7HUrsoBLGmRgnNiJ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOjAHZev; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOjAHZev"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb7926836eso212244a12.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785455462; cv=none;
        d=google.com; s=arc-20260327;
        b=lkX2zuLzsVDMmUpqvn37bFgX+ZOTPgugKyaGnIph97BtI6SFg70DfpkqBLqFxLCJcr
         c733jU9OHH+/Rf2Njz86FFigIDNZ4U30n+xoxGoSCgTsokYZSTRWXrZRwQ+ntm3ODV6e
         tW9mbKxicPFfZvVQuvaeUkCNnXbGMLsSk6OPAolceLVkrLJ4Y35mvGSz89LiCDzL9F5f
         CBAh+JqoJPlYc+5vVCrcuJrERTsmheF2gDQYpr4zvBRpHqZroIqlbNkgsdJ4hMFPi25o
         AvY9JG1eaNpSMSWlVWkC4YWdfAcavlfcIhrGkpWCCdYXKUDE8Bd3k8dBF9gNoeX226hB
         VnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=32A37f+/HsGvkPn+Cjf/D2l/wFEJaksecpc2OGTw5Zo=;
        fh=u9dmlfgbc+8+xuBzHWtcG0bAwEpSMU8ekH3uq/NdKxw=;
        b=IAxA0dqWz/oZxQhwnfZmcxdBwWpzPp1zEDdiHqlZM5FEuB60Or+Y2AJ2oCmQ/uaS3R
         vyvEmqaMAGw9G1ePW4LIO7RpAyYkZ3Qf3urGyrgtIT7mT98Z82XpIe4kg+wxlXbGOpzt
         khX7ZwE+HSQ5jlyi582AZjIoOLj5W/tSr/fuX52DQNKT/mb6IZBQfYhgbmFjLzLExE1/
         NL6Kx/IyvaouKWVRZMOVJj/yffImnhjA+kPq0gebnjVnrr4nvIHAqrvKXJ8VBd3bNUrz
         RVfIcM6kd6fMbmlXfE19YOSXjeBFYbpl3/phbnoUtCbUSYddN4zB+raPSAkoXiALA+hQ
         uJNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455462; x=1786060262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=32A37f+/HsGvkPn+Cjf/D2l/wFEJaksecpc2OGTw5Zo=;
        b=gOjAHZevSh/09DV2jdWRZXd9quj2Weicn2ybO7ZKgTVDx6HtMMDQLS7XJMMnuJhOq7
         E8czvTI7VveJU6NI7W43nZDg+XMrWSwNl6zT3cUqXeXOLbf6J4r7TU+U/3++K8+LthUN
         ezfIXW/nudhp4znLRxKEMZL6yP4nAtTS9mtD9Onoezcli7vYr3R4q9CYP4QbRRR6n5he
         5HXMvl9esF8klTe9h6tj3xoErprhTI8VyXKd0QrAb5EjPalmFUog44se3KhWG4P6e39N
         XIXCQxXq67cMJrfTyWeTc/tRfIiuVhTbhy0YxMX3zLj9kHvotpaEY5EXDksOrwOo3gjQ
         oDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455462; x=1786060262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32A37f+/HsGvkPn+Cjf/D2l/wFEJaksecpc2OGTw5Zo=;
        b=mgCt9Y/YQPAFOwJiY8b1dtmJMKBZ8IrLDPVMagbbiAvNKGKiQTJhQcZDXxwiIfdhhP
         HNxqeo8OSfMCpThj8TTBsSUW+iHLVY1nYnSjCponMLohPVZP6CM47mSrlr4ebxUlzV7d
         7+w5jyCwG0I6bcDtAMawfaL9ab6TZLLVRxrLZ3O+284Dmag09+jjZocUbv/mbAtGZsVA
         ZzYiax0s82pW7k13ObixEcRahsJ6B0xdkRC/iJPmF4f3542CwLwSQZ7fg0Dv1C9xc4wa
         UAAO3ASpX6vRqFK1mt5tOWHXJcLqlbwb5DbIwhn9+PGFs5Qa/vDeoRqHO4GXjN6XQ3bn
         BaAA==
X-Forwarded-Encrypted: i=1; AHgh+RrHzmfcahDd1RZgAjMPg0ydNuT3Wd3RZwbcZrj+s822ZwJw4q+ow3l/GUBbBHm7rMU1gWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CgmxfxiLwsA+i9cz/h4rIkxOHmfk4kyaTnXLyIofbN3OCq9p
	nsWh/BKy2jBg30lmbnqLK5Et+OlRy1+LGy2JKFJyj17rcq1ZwLD4ic6hCv4u+mAOBmGM5BDmXuU
	f/HAVNCgm5btnEH36pZUJKYSYIMBNGp8=
X-Gm-Gg: AR+sD12tG71dgz7VCxQwxUAiuEx9FBNQlBko3CZTRGZmLg09cgD2uWry1/XXWStXqW8
	Iy9//ELIaFZm5JP3sQKQlgdjdk5lLv8QIN2M7KYiF24bke1tBoTW9euUkD3+dV0Xv95nN9oJ+hb
	5CGC4VP7ZCyEGdQjBGvUCCtD9eG6/MN6uUS1uHJTeLJ2Qy1PVW8PeCc8m1ZL4nv19z6A1NP+4wP
	oxJTAq9HzjxwZ8Z2Mjh3FQHOEH7hLt6F+udHosjEPB1NRU3U0JMrLJ/2OwYcH4PQBoNcWs4zEDj
	YTzZoCvpyKGy3ktFww1PgW+zGrnGHHxnfYGFnnnt4pGNN6kMT7JUt1FccJ4e+KStyGKsALuuaK0
	VyikfTU8xo1Jr8eX/h7fdalczSO9FE7U7MWHNkj5JqQ==
X-Received: by 2002:a05:6a00:6c85:b0:847:770f:da4c with SMTP id
 d2e1a72fcca58-84ebc1eb91cmr4044866b3a.16.1785455462359; Thu, 30 Jul 2026
 16:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730054858.209807-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260730054858.209807-2-sanghyun.park.cnu@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:50:47 -0700
X-Gm-Features: AUfX_mygzkksPurFul-eYC80NIRNZASyC3fJd894Jn4A1w9AVGfxFPWXqt9Z-IM
Message-ID: <CAEf4BzZ3TN4b0OFOV62YG=W3pAKD4x2eK=_mrmBCci7=fNQE0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:49=E2=80=AFPM Sanghyun Park
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
> Tested-by: Sun Jian <sun.jian.kdev@gmail.com>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v2:
>  - Drop irq_work_is_busy() and rely exclusively on active, as suggested b=
y Ihor.
>
> v1: https://lore.kernel.org/bpf/20260722023004.1497923-2-sanghyun.park.cn=
u@gmail.com/
>
>  kernel/bpf/mmap_unlock_work.h | 37 +++++++++++++++++++++++++++++++----
>  kernel/bpf/stackmap.c         |  3 +--
>  kernel/bpf/task_iter.c        |  7 +++----
>  3 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.=
h
> index 5d18d7d85bef9..d6e2b65f6d052 100644
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
> @@ -29,9 +31,9 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct =
mmap_unlock_irq_work **wo

tbh, bpf_mmap_unlock_get_irq_work() name and its semantics of
returning true if we can't really do anything seems convoluted and
backwards.

maybe we should make bpf_mmap_unlock_get_irq_work() return `struct
mmap_unlock_irq_work *` which would be ERR_PTR(), and return
ERR_PTR(-EBUSY) if (active || irq_work_is_busy) (see below)? I'd
probably call it bpf_mmap_unlock_guard_get(), though. And then we will
have bpf_mmap_unlock_guard_put() (instead of
bpf_mmap_unlock_put_irq_work) with the same logic.

and so in code, we'll check

work =3D bpf_mmap_unlock_guard_get();
if (IS_ERR(work)) return /* womp womp */

....

bpf_mmap_unlock_guard_put();


thoughts?

>         if (irqs_disabled()) {
>                 if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         work =3D this_cpu_ptr(&mmap_unlock_work);
> -                       if (irq_work_is_busy(&work->irq_work)) {
> -                               /* cannot queue more up_read, fallback */
> +                       if (atomic_cmpxchg_acquire(&work->active, 0, 1)) =
{
>                                 irq_work_busy =3D true;
> +                               work =3D NULL;
>                         }
>                 } else {
>                         /*

[...]

> @@ -1191,6 +1188,8 @@ static void do_mmap_read_unlock(struct irq_work *en=
try)
>
>         work =3D container_of(entry, struct mmap_unlock_irq_work, irq_wor=
k);
>         mmap_read_unlock_non_owner(work->mm);
> +       work->mm =3D NULL;
> +       bpf_mmap_unlock_put_irq_work(work);

we drop active to zero here, but irq_work_is_busy() can still return
true, I think we do need to check both

>  }
>
>  static int __init task_iter_init(void)
> --
> 2.48.1

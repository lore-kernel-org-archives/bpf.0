Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A714334C18
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868288; cv=pass; b=ZnuqKa0boJ9TgmCrORHfUT0gbhiR2QzoQANuQpW7/AD3jHRlxqpcvIlObF5Q3VfEVQKuzm+l1YuJ15uxJImhC3wiAqMP8eeSSfuwdwi+dGAyfuPQWL4AD2tw6fKdxNsB9HBjyLKhuXd0zaNV9Y7mA5AeNX4U8t1+q0ie7fK+T8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868288; c=relaxed/simple;
	bh=gv8aqJA6Q7Mo0cobCm6Y9D23OX+wxYoejibnyePYaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Fo9Nz9L1ff8ZgsiYxxhpUwp2VGcoJSvxDCNMQLfdUuzFn34drPIrlgpdr4xcyTMVKG5l/9hu9+intUeHqgmi4nWxLdFjZxbJ5on49BMAjB5ywuSYVXybpJpS6oXxgjnmUhocZnHej25GglKn71fzZRU7ebXnh6leySJQEqMP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmmY6CRa; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmmY6CRa"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65a3527c5easo8038364a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868281; cv=none;
        d=google.com; s=arc-20240605;
        b=WtjGJAdgDJC2oubbf6FAPGRGCyYmviJC79OkufIDwaDW7jd7ZL6yi9aY3M019V348i
         4GyBZr6xsIP7a2kRELB6dyQrrkO8xvIVutp5KUwlD4J4sgJzrnJfQD6+yZxIxJLR5a5m
         qlnsN+e1dBgWQX+gDJlsQ4IT6Ric16dw3wUfYeehehHcl4lTb8tipzP9xGfq8vKlgixw
         wloeQ/XS/+NJR2Jyku5/pq6RGGKRfxZc7bWaeTC8TV5suRVJG2NVELHu41rX1bUUF2o7
         0JYxYzWVw7JUo6ad4QuU6x9GxXSX/66ZiKw0VPs5EYuU15wbTR+Ctm94gLeLu18Q50t0
         cBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPBO11nqdyY574SP/8l5CcTATLQqYcbi1G0kqpaPBbI=;
        fh=2qDl97vg3z2ktsd1B1tRc16I9T0HpjpvgJC4sc0hJtU=;
        b=JEbnu5kWxbASEfxF5Jy2lFk5209c+hC1WYs8r4tMGf3bPsRw2URAr/bJY5jdbbJ+5H
         yIeOf7Oc6/Fll3lz0F7eySMQVpF3hUyR0nPWVMMmKNeD30auNUGorOQS1vfr12efDExY
         HCr+wtty6p1ds7EoZlzww2gDSmEYMR12qETIb+uJaOAGC4GwODXbxKWbElvEyQEJvdQl
         BuhKPrrUYrSR3/4LOTS0J+BtsP3mzzeZCJGHdT0hJa3DjtWuzZ5QPsoTZ4Ausl0goLkZ
         zV4Ikc8nB+8174++B4HTZa8sj7mppR+5zsMMQLHYhADvujso9kAJ57w2feI9nIEJxl4h
         8a2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868281; x=1772473081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPBO11nqdyY574SP/8l5CcTATLQqYcbi1G0kqpaPBbI=;
        b=gmmY6CRaGo4x3CtQMf+zLr199q31le1+XCO4k/ra6OfuxDxuwm88IJJeAB4H+nnRoW
         qLlXbfBTMXCJ2zQTF4qhprfxW4QvxW4ac87RE+1Mj/jvLxbt2WlaXZnLOrimcQaFEWa/
         1XI10GOdt9i2UO5HlDO9QbHoq1GsAi1aApO710sYZtM1/4D9WE6/9gEmRKdEyF/HoJtf
         B/xLjBNJ4H1RrJ19cdBxqOt8Cmp5DLgFRDSDWSMI+sSbFqW13o8XF9+evJrHehIsidBw
         dtAu6jdqRupBjgEVXj/OYByFItv9soDxrxsYdSWIKaH0/neA8O7N8OuTnzK6FWm5biwD
         cKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868281; x=1772473081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPBO11nqdyY574SP/8l5CcTATLQqYcbi1G0kqpaPBbI=;
        b=rd1rmlms/mSfRgPXo2Wg3Au0guSMvb57yeltj12ILa0Ez+OyKhN0A7+Ge6T9Eg89U1
         ccx7eeAeRFJzIxCxiUCZI5gfMRSfkfAA/hXESQfe6+l5nFNO2CD+YMWwGPc+/tzvJbhM
         n80HVDufadFj7adduU4eUhlW5jYKuoZfrQg0swf+Pl6Gf1Ft/YLEUSapvGaY8+cpQOOT
         l+181ctlfl4e/QaXuWto7C48ekF5dRWQ85z9soYzdDW6A77bxSeZ6mM8Q/oFzwbGHrBd
         NFxZt5XBcEzNiTTbzLvyGKgiz72BkuKqXpj8C5kEKrwNEMou4GEcpsEPv45jVH9ckZul
         D2gw==
X-Gm-Message-State: AOJu0Yw6h9phDVvXemigIbZ9bmiJhAQRPWWw6n4jEu+QhSXB/f8XTcEf
	Mr1CsSd2aMX5QII3AqIRECBKX0YAuSoALimMusCW3NyXZl94G/X+4QZ4DY2ssbFuE5ZfNtDZ8vT
	I37vhXHgNUAyZ7xj2guuZgsy9mXeWRIl0aeqk7Y4=
X-Gm-Gg: AZuq6aKo1kfBRvS/LF9lQYdz1zA0E+Ido5W9PL9q7CZaqjwYXjCWTu3jPosJQBmo/wu
	5XAz1hz+IGZ/ckkXZoYzq11s/To6l5mUeptvib1c0HS//3qV1RjyjK4nOMYssJx6q4G/Y0H6fWy
	baKNHqJ/Wfv14uZ/tpNQseOXhgFE9ZF47Zf9jmbItLfi9m+4MesWFrLWPAyVQ96bCzc30OPBBZF
	xrws8/LQpWncx6s1dsiGrfyoOLVSsTDqjsyrEvtAzVllPpzFXsaoZrnQOAx+VW/TJ36qHZP3Fsi
	LbU0zZzQ
X-Received: by 2002:a17:907:d06:b0:b8f:a26e:dec4 with SMTP id
 a640c23a62f3a-b90819557c5mr595449566b.7.1771868280591; Mon, 23 Feb 2026
 09:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223160300.2109907-1-puranjay@kernel.org>
In-Reply-To: <20260223160300.2109907-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 23 Feb 2026 17:37:47 +0000
X-Gm-Features: AaiRm50hbykrgwD7fp8kiuHrvG1CHQiYykQ8LLYBq-yvW2ZwHljNsNgp00Icm3E
Message-ID: <CANk7y0gKw95DuWN50ccxTQuGwakbt==xbS5vjFEg7-nEWm9QLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:03=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Changelog:
> v1: https://lore.kernel.org/all/20260218182555.1501495-1-puranjay@kernel.=
org/
> Changes in v1 -> v2:
> - Add a patch to consolidate sleepable context error message printing in
>   check_helper_call(), has no functional changes (Eduard)
> - In check_kfunc_call() for KF_RELEASE and __iter arg, use release_regno
>   like dynptr rather than custom handling (Mykyta)
> - Fix some comments to follow correct style (Mykyta)
> - Move state->forbid_sleep_count-- to release_reference_state() (Eduard)
> - Remove error message in check_resource_leak() for forbid_sleep_count
>   because it is redundant and will never trigger (Eduard)
> - Consolidated some checks and prints (Eduard)
>
> Some BPF kfuncs acquire resources that prevent sleeping - a lock, a
> reference to an object under a lock, a preempt-disable section. Today the=
re
> is no way for the verifier to know that holding a particular acquired
> reference means sleeping is forbidden. Programs either run entirely in
> sleepable or non-sleepable context, with no way to express "sleeping is
> forbidden right now, but will be allowed once I release this reference."
>
> This series adds KF_FORBID_SLEEP, a new kfunc flag that can be combined
> with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_SLEEP
> is called, the verifier tags the acquired reference with forbid_sleep and
> increments a per-state forbid_sleep_count counter. When the reference is
> released (through corresponding KF_RELEASE kfunc), the counter is
> decremented.  The verifier checks this counter everywhere it decides
> whether sleeping is allowed =E2=80=94 sleepable helpers, sleepable kfuncs=
, global
> function calls, and resource leak checks.
>
> This is fully generic. Any pair of KF_ACQUIRE/KF_RELEASE kfuncs can opt
> into sleep prohibition by adding KF_FORBID_SLEEP to the acquire side.
>
> To make this useful for iterators specifically, the series first extends
> the verifier's iterator support to allow KF_ACQUIRE on _next and KF_RELEA=
SE
> on a separate kfunc taking an __iter argument. The verifier tracks the
> acquired reference on the iterator's stack slot (st->id) and auto-release=
s
> it on the next _next call and on the DRAINED (NULL) path, so the
> acquire/release is transparent to programs that don't need mid-loop
> release.
>
> Iterator KF_ACQUIRE support is not useful on its own right now, but it
> becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next is
> annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holding this
> pointer forbids sleeping; calling _release invalidates the pointer and
> re-enables sleeping."
>
> The task_vma iterator is the first user. It holds mmap_lock during
> iteration, preventing sleepable helpers like bpf_copy_from_user().
> Currently, this can lead to a deadlock as the fault path also takes
> mmap_lock.
>
> With this series, a BPF program can release the lock mid-iteration:
>
>     bpf_for_each(task_vma, vma, task, 0) {
>         u64 start =3D vma->vm_start;
>
>         /* sleeping forbidden, but vma pointer access allowed */
>         bpf_iter_task_vma_release(&___it);
>         /* mmap_lock released, vma pointer invalidated */
>         /* sleeping is fine here */
>
>         bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
>     }
>
> The series is organized as:
>
>   Patch 1: KF_ACQUIRE/KF_RELEASE plumbing for iterators in the
>            verifier. Pure infrastructure, no behavioral change to
>            existing iterators.
>
>   Patch 2: Consolidate sleepable context error message printing
>            in check_helper_call(), no functional changes
>
>   Patch 3: KF_FORBID_SLEEP flag and forbid_sleep_count machinery.
>            Generic, works for any KF_ACQUIRE kfunc - iterator or not.
>
>   Patch 4: Move mmap_lock acquisition from _new to _next in the
>            task_vma iterator, preparing for re-acquisition after
>            release.
>
>   Patch 5: Wire up task_vma as the first user: annotate _next with
>            KF_ACQUIRE | KF_FORBID_SLEEP, add bpf_iter_task_vma_release().
>
>   Patch 6: Selftests covering the runtime path (release + copy_from_user)
>            and verifier rejection of invalid patterns (sleeping without
>            release, VMA access after release, double release, release
>            without acquire, nested iterator interaction).
>
> Puranjay Mohan (6):
>   bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
>   bpf: consolidate sleepable context error message printing
>   bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
>   bpf: Move locking to bpf_iter_task_vma_next()
>   bpf: Add split iteration support to task_vma iterator
>   selftests/bpf: Add tests for split task_vma iterator
>
>  include/linux/bpf_verifier.h                  |   2 +
>  include/linux/btf.h                           |   1 +
>  kernel/bpf/btf.c                              |   3 +
>  kernel/bpf/helpers.c                          |   3 +-
>  kernel/bpf/task_iter.c                        |  44 ++++--
>  kernel/bpf/verifier.c                         | 147 +++++++++++++-----
>  .../testing/selftests/bpf/bpf_experimental.h  |   1 +
>  .../testing/selftests/bpf/prog_tests/iters.c  |  13 ++
>  .../selftests/bpf/progs/iters_task_vma.c      |  39 +++++
>  .../bpf/progs/iters_task_vma_nosleep.c        | 125 +++++++++++++++
>  10 files changed, 331 insertions(+), 47 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosl=
eep.c
>
>
> base-commit: 9cd168a2720bc614647dd20bc5d1c308c56a44ec
> --
> 2.47.3
>

Some patches were dropped from this, will resend again.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32940D58C
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787624; cv=none; b=ZA0e0DbDT3fVCBvmIjAKDGHDJM2PAiPYwfXun+r//mUphvmDbiQhZjprdm3kMGq7Epw0Cd4Tq+dOjRO/ff1XkIDrGXILpQ23OFVv7H5lcJHYb+kZYFYXGvJMB/uFZxpmisbXVYD2uyXqglo+ZFD+Dn6Pfg/oBrpyor8QWo6ag+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787624; c=relaxed/simple;
	bh=CEyjj6VGfJR5agfxFhVGmgZFcVEelJh9bcoIBx3trPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0pllFwur0ZjCQZ+gngrmSCIL3MgVAHc+BOXBh4oVUUFw0jN8GHHsMxjkcEy7lxQoZK6J3ven4W+NIuwx3q5cD3+ZxrbLDOdt8X7yBbEwH2IOB/yCR03Kvy9R/D7ouVfYMVEN7JsTg/ZsUju+Tf9ANVwnfS3xUP08cqSNruweQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwN2CTcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwN2CTcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C111F1F000E9;
	Tue, 30 Jun 2026 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782787623;
	bh=bg11iEPGV4asJlLP/B5kCdeNjV/daDqBGeR4oqYoQZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwN2CTcPV3wD8LBruNYAvwbobmBV8lanQ9X6bttGxsMWWabEqD7cTeAeZnC9VPJzv
	 IhPkiU3vfKVNqXpIaNH0b/JUwuyNSpi8GrZUVctObymXtCpRSB3JbtjY1rw/fXIPG6
	 6M3x4YC5EUcGwXFfwsmDii77kwDqLFHCcI43AkFRwyT3ZHJQD9xIjYPLmPtqTTfUYJ
	 iN/vugcVxI5nXXCtBET5iQ3+w/fGh+qjQO9QKX69RZwhaleZOz+rOSFFOdMz13HQbw
	 o+PvgOFkFEnUnMcHpBVESHDsVL5ZzJcXPj1+BoYR7IFkklfOCvLrhAhezje7V0u4PL
	 8oFH9DepI5xTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>
References: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 02:47:02 +0000
Message-Id: <20260630024702.C111F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch removes the `bpf_iter_mmput_async()` helper function but =
leaves an active call to it in `bpf_iter_task_vma_destroy()`, causing an un=
conditional compilation failure.
- [Low] Calling `mmput_async()` directly causes a build failure on configur=
ations without `CONFIG_MMU` and `CONFIG_FUTEX_PRIVATE_HASH`.
--

commit 2e44c7b3855fc202fcf8df33fd8efe7bae06e921
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Subject: bpf: Fix use-after-free on mm_struct in bpf_find_vma()

This commit addresses a use-after-free in bpf_find_vma() by safely
pinning task->mm for foreign tasks under alloc_lock. It adds a required
mmput_async() call on the exit path and removes the static inline wrapper
bpf_iter_mmput_async().

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e791ae065c39b..27ceead874651 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -782,6 +807,9 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, =
u64, start,
>  		ret =3D 0;
>  	}
>  	bpf_mmap_unlock_mm(work, mm);
> +out:
> +	if (mmput_needed)
> +		mmput_async(mm);

[Severity: Low]
Does directly invoking mmput_async() break the build on configurations
without CONFIG_MMU?

The removed bpf_iter_mmput_async() wrapper previously fell back to mmput()
when CONFIG_MMU was disabled. Even though this new path is guarded by a
runtime IS_ENABLED(CONFIG_MMU) check earlier in the function, the C compiler
still evaluates the function call, which might be undeclared in the headers
on !CONFIG_MMU builds.

>  	return ret;
>  }
> =20
> @@ -796,15 +824,6 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>  	.arg5_type	=3D ARG_ANYTHING,
>  };
> =20
> -static inline void bpf_iter_mmput_async(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_MMU
> -	mmput_async(mm);
> -#else
> -	mmput(mm);
> -#endif
> -}
> -

[Severity: Low]
Does the removal of bpf_iter_mmput_async() cause a build failure?

While the wrapper was removed here, it looks like it is still being called
further down in the file:

kernel/bpf/task_iter.c:bpf_iter_task_vma_destroy() {
        ...
        if (kit->data) {
                bpf_iter_task_vma_snapshot_reset(&kit->data->snapshot);
                put_task_struct(kit->data->task);
                bpf_iter_mmput_async(kit->data->mm);
                ...
        }
}

Will this cause an undeclared identifier error when compiling
bpf_iter_task_vma_destroy()?

>  struct bpf_iter_task_vma_kern_data {
>  	struct task_struct *task;
>  	struct mm_struct *mm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630023443.3026=
627-2-sanghyun.park.cnu@gmail.com?part=3D1

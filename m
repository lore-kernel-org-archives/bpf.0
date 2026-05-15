Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58B15A864;
	Fri, 15 May 2026 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808824; cv=none; b=meisW3nTGhueQvO+w+rdwNhhUXAGIZqNSL3Mq7f/qBG50jv/PXUm6Yv+QyDqrSjHTVmyXeiEAlreevnDJO3dFwjJElZU8yQghydutySkyVT+wyj7K18/1lj3jUZhIKNq+L6f4jdjalTPqGLa1KIIi6ik9cn5d2bFJ+rCvJs4Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808824; c=relaxed/simple;
	bh=6H+yyLRHg1fVn3Jefm/Iqdi3Ofe4alMH6ik/FYWeq0k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jeHjRFFIGik9IqVo7g6e7/U4ZBxDR0UWgQgHr5NH1BwpMLgOgOuhCJ49sIP/5Q2mwPismxNVfugdGfn7AbUO6L53cYfcq6/W2eYGes1GtXLUjRVqZ9ZHdHllsibmCK1dYbNrU79Iy0vnWhDt0Vk3DfbohHU4CC5oTJQ+DVQw2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6KzWx+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6KzWx+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B85C2BCB3;
	Fri, 15 May 2026 01:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808823;
	bh=6H+yyLRHg1fVn3Jefm/Iqdi3Ofe4alMH6ik/FYWeq0k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=X6KzWx+RON+xw6QIRQymnVNan3r+gajm4u+3SYiS9X+K5ryQmx2eZNKQazfU8Rqa5
	 PJaw/O3aJzN9AEpodOwxtrxIzEFVszJccZ5q40SJzxyPb/HkpTiEChnPVgKOW6+Qpi
	 nJwgfFsob1kZMrdhhDtckGuszk+N1xxLTR7mggTWNesME/FpHhXKMMdbKmW9KSpjNT
	 6Q6Qpa12tMSC810oBugFjJpRjQ2r5/hCDpZI++CoqqK7jYJHRClmMDXHPiUpPnwxEl
	 KrDi9X2Ls8o8MM6pJI4WF5cEQYLUx6GdUZ5xDsTmZC4vsSWOrSqifzNQSYzEG4vmGi
	 4IaUJHD7rwwWA==
Content-Type: multipart/mixed; boundary="===============6191291153885309066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e2084173f17252ff227aba064e534682b52a7a451280c0df4041825ebae30b6@mail.kernel.org>
In-Reply-To: <20260515005244.1333013-3-ihor.solodrai@linux.dev>
References: <20260515005244.1333013-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Avoid faultable build ID reads under mm locks
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 01:33:43 +0000 (UTC)

--===============6191291153885309066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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
> @@ -158,6 +159,109 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>  	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>  }
>
> +struct stack_map_vma_lock {
> +	bool vma_locked;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *
> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{
> +	struct mm_struct *mm = lock->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (WARN_ON_ONCE(!mm))
> +		return NULL;
> +
> +	vma = lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		goto vma_locked;
> +
> +	/*
> +	 * Taking mmap_read_lock() is unsafe here, because the caller
> +	 * BPF program might already hold it, causing a deadlock.
> +	 */
> +	if (!mmap_read_trylock(mm))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	mmap_read_unlock(mm);
> +	return NULL;
> +#endif
> +vma_locked:
> +	lock->vma_locked = true;
> +	lock->vma = vma;
> +	return vma;
> +}
> +
> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +	struct vm_area_struct *vma = lock->vma;
> +
> +	if (lock->vma_locked) {
> +		if (WARN_ON_ONCE(!vma))
> +			goto out;
> +		vma_end_read(vma);
> +	}
> +out:
> +	lock->vma_locked = false;
> +	lock->vma = NULL;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct stack_map_vma_lock lock = {
> +		.vma_locked = false,
> +		.vma = NULL,
> +		.mm = mm,
> +	};
> +	unsigned long vm_pgoff, vm_start;
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);
> +		vma = stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {
                        ^^^^^^^^^^^^^^^^
This isn't a bug, but a subsystem pattern flags this as potentially
concerning: the code uses !vma->vm_file to classify the VMA as anonymous.
Per mm-vma.md's VMA classification rules, the correct test for anonymous
VMAs is vma_is_anonymous() (i.e. !vma->vm_ops).

Some anonymous VMAs carry a vm_file reference. For example, private mappings
of /dev/zero set via vma_set_anonymous() leave vm_file populated while
clearing vm_ops. On such VMAs, this code would proceed down the file-backed
path and hand /dev/zero (or any other vma_set_anonymous()-style driver file)
to build_id_parse_file():

stack_map_get_build_id_offset_sleepable() {
    if (!vma || !vma->vm_file) {
        stack_map_build_id_set_ip(&id_offs[i]);
        ...
        continue;
    }
    file = get_file(vma->vm_file);   /* gets /dev/zero */
    ...
    build_id_parse_file(file, ...)   /* tries to parse /dev/zero as ELF */
}

instead of immediately falling back to reporting the raw IP.

In practice, build_id_parse_file() would fail the ELF magic check with
-EINVAL and fall through to stack_map_build_id_set_ip(), so no crash
occurs. The code matches the pattern in the existing build_id_parse() and
build_id_parse_nofault() API in lib/buildid.c, so the patch is consistent
with established kernel build-ID handling. However, is it worth switching
to vma_is_anonymous(vma) to avoid the unnecessary sleepable read attempt on
driver files?

AI reviewers bot+bpf-ci@kernel.org and sashiko-bot@kernel.org raised this
across v3 and v4, and it remains unaddressed in the current version:
https://lore.kernel.org/bpf/1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org/

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}
> +
> +		file = get_file(vma->vm_file);
> +		vm_pgoff = vma->vm_pgoff;
> +		vm_start = vma->vm_start;
> +		stack_map_unlock_vma(&lock);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			fput(file);
> +			continue;
> +		}
> +		fput(file);
> +
> +		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
> +		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +	}
> +}
> +
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -178,6 +282,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	const char *prev_build_id;
>  	int i;
>
> +	if (may_fault && has_user_ctx) {
> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
> +		return;
> +	}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25894427199
--===============6191291153885309066==--

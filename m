Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA23F4119;
	Thu, 14 May 2026 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787451; cv=none; b=rUBAGwlpoAuEyXIfdt6VifrqpUFpKHKy5fUGpojvaGyF7E69//R/7d+Ve1UeELyOg2S0VDgNwVMEhBBGy05TqgY1XqF2nEvJwv/rL4sK4QXFz2etIOv00T97psO71z4hcsXTlghGC9a4CAnM/1sXvdyIpkj0CPHRbUl4OzknlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787451; c=relaxed/simple;
	bh=VrpO0YibduF8ENb+FcSMwUwCfQhTfqBkVEqmnibSz68=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t2GrwFhS7AWbQEcq0gUM7ww/yq3Z+dt8SJrBMYpEOcRCicbsmdAaKl8bpyqiBsLvtu4vj2J17ytjCOU5mNY1LF9IZTzKH/pEOf6nNWQsl9T4GyORrOfDUmiwClrmjqBRaxMZd8yfa+iKzWDbbMekG9bD+tpl3K++GgSTQm3YpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE9SwUBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE9SwUBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E21C2BCB3;
	Thu, 14 May 2026 19:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778787451;
	bh=VrpO0YibduF8ENb+FcSMwUwCfQhTfqBkVEqmnibSz68=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WE9SwUBxQtCIY2glW+rVj8enadtXerk+KwZl/CHN+AsBZYpV/PG+w1PI0UkWZQszC
	 8Hj8l7Jr21eyRTuqoNJi0YJLV5WoY0mGhcARfj9+Uqgj9LKJDbAjFCXcRDZ/RpeBaX
	 W0PrLVbXSDCuDX4LUTt4t7elRwsiEMUBOA+D2/kzSaitMLlNHCdTCaNPARG/3VM3A8
	 N+Gi+8Wrs+q9hJL9+9+WnV7/HjAnGuz75Uyg//kh5nRkChEErzp1WJxm1x/dYcrALp
	 b3dq+AViSiWB0//Hb396HRyZfebQW/V5gYqLDk9bZDIAqLm7liXEScKVNN6Z+841eY
	 KY9j5rkj2Z0xg==
Content-Type: multipart/mixed; boundary="===============5129401964523210386=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <baab29c5bbb2d4b6885da72ef98a1b7da439c4479166c587de704f3587f51ae8@mail.kernel.org>
In-Reply-To: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
References: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm locks
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 19:37:30 +0000 (UTC)

--===============5129401964523210386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea5..c1e96df360c3 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/btf_ids.h>
>  #include <linux/buildid.h>
> +#include <linux/mmap_lock.h>
>  #include "percpu_freelist.h"
>  #include "mmap_unlock_work.h"

[ ... ]

> @@ -158,6 +159,105 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
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
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}

Is the vm_file check here correct for classifying anonymous VMAs?
Per mm-vma.md, vma->vm_file is not a reliable indicator of file-backed
status. Some anonymous VMAs carry a vm_file reference, such as private
mappings of /dev/zero set via vma_set_anonymous() which sets vm_ops
= NULL but leaves vm_file populated.

The canonical test is vma_is_anonymous(vma) (checking !vma->vm_ops).
For a private /dev/zero mapping, this code would pass /dev/zero to
build_id_parse_file() instead of immediately falling back to the raw IP.

This was flagged in v3 review by bot+bpf-ci@kernel.org and acknowledged
by the author as a minor edge case but left unchanged for consistency
with existing code elsewhere in stackmap.c:

https://lore.kernel.org/bpf/1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org/

Should this be switched to vma_is_anonymous(), or is it preferable to
keep the current pattern and address it later across all of stackmap.c?

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

[ ... ]

> @@ -178,6 +278,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	const char *prev_build_id;
>  	int i;
>
> +	if (may_fault && has_user_ctx) {
> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
> +		return;
> +	}
> +
>  	/* If the irq_work is in use, fall back to report ips. Same
>  	 * fallback is used for kernel stack (!user) on a stackmap with
>  	 * build_id.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25879521172
--===============5129401964523210386==--

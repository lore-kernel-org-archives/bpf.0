Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C4383330;
	Tue, 12 May 2026 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559414; cv=none; b=Jof3YbS5mZEFhTVFyhX181xmgRLU6ySZQ89dH1Pli/beuqicUXuke2MwjPkNQKvNmGtEtHkmH3f6wKw3O0vmppsfl1d3BYQhHHcr2T1nz5fNdaZlkOdLqVO5KmgYQgYiFU9wtV9IWN+KUaqKjE/YDgIxr0xqbd8sA8MJ2c1pHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559414; c=relaxed/simple;
	bh=bEOvsuJFt5/85X/NJhPStcXht0zcQhdJSVlXJ8NSj/M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DX7z0jF6G3NaJHoGGgVKfECnYHR7kFrwENSLhzuA0tqyyJSiySUWnyVY6/4ta1W/vJUyjI7CU45OsGYo7pFMWRxQQOdiLdexEyiPhdIpronsc+b6AYxa5+BREV903KwehMo35rNKrUM0mR1VryZ/ibjn3H1y1adcnGdk2LMeoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6cyW3df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6cyW3df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBBBC2BCB0;
	Tue, 12 May 2026 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778559414;
	bh=bEOvsuJFt5/85X/NJhPStcXht0zcQhdJSVlXJ8NSj/M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=B6cyW3dfJpLqakSsKFhjLU2VYaMNfTA8UQJm+HO9URM5hg9nUAk8DjQjhyKSoYlym
	 aAAdP8A71VkyT1SfNysQ8XaCvjpKU9yqUbSKCCe+rnDNKoKEdmUIl702RT60FqftxT
	 aGMU52ALpOneYLethUqlR7FEvGWsc6RsfTQkD5RuiIFdQ9C4LirwG5ud/a6PDNxPcB
	 eQTOGUszvOG9OnKA0h0EjLE8S9PMyNGzJBx4PlQOoad9mXOvLoQAuqm7yaGnhnlZfp
	 2BMlQ2mPvSSjUADaTF3YZp5vVyX9PJ2l2OexnWWGt9OvYVAWkULwH0qXkQGxY49g5w
	 OwbDAWWreH1nQ==
Content-Type: multipart/mixed; boundary="===============1946919969375932260=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org>
In-Reply-To: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
References: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v3 2/3] bpf: Avoid faultable build ID reads under mm locks
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 12 May 2026 04:16:52 +0000 (UTC)

--===============1946919969375932260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea5..c1e96df360c3 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

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
                            ^^^^^^^^

A subsystem pattern flags this as potentially concerning: the code uses
!vma->vm_file to classify the VMA as anonymous. Per mm-vma.md's VMA
classification rules, the correct test for anonymous VMAs is
vma_is_anonymous() (i.e. !vma->vm_ops). Some anonymous VMAs carry a
vm_file reference (e.g. private mappings of /dev/zero set via
vma_set_anonymous() while leaving vm_file populated).

On such VMAs, this code would proceed down the file-backed path and hand
/dev/zero (or any other vma_set_anonymous()-style driver file) to
build_id_parse_file() instead of immediately falling back to reporting
the raw IP. build_id_parse_file() would fail the ELF-magic check and
return an error, so the practical effect is a wasted pinned-file
reference and a pointless sleepable read attempt. However, the mm
subsystem guide directs that this pattern be reported.

The existing non-sleepable stack_map_get_build_id_offset()/build_id_parse()
in this same subsystem also uses !vma->vm_file, so the new code is
consistent with pre-existing style.

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}

Mykyta Yatsenko suggested an optimization in v2 that has not been
implemented: cache vm_start and vm_end, and if the next IP is in range,
reuse the previous build ID without locking the VMA. This would avoid
repeated lock/unlock cycles for consecutive IPs in the same VMA.

The current v3 code only caches the file reference for same-file
optimization, not the VMA range. See the original discussion at
https://lore.kernel.org/bpf/8b2cf5ca-182e-4eb2-ab90-8fab9d81f6e1@gmail.com/

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

Commit message:

>     bpf: Avoid faultable build ID reads under mm locks
>
>     Sleepable build ID parsing can block in __kernel_read() [1], so the
>     stackmap sleepable path must not call it while holding mmap_lock or a
>     per-VMA read lock.
>     The issue and the fix are conceptually similar to a recent procfs
>     patch [2].
>     Resolve each covered VMA with a stable read-side reference, preferring
>     lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
>     enough to acquire the VMA read lock. Take a reference to the backing
>     file, drop the VMA lock, and then parse the build ID through
>     (sleepable) build_id_parse_file().
>     [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>     [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>     Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")

The existing Fixes tag points to commit 777a8560fd29 ("lib/buildid: use
__kernel_read() for sleepable context"), but the bug was actually
introduced by commit d4dd9775ec24 ("bpf: wire up sleepable
bpf_get_stack() and bpf_get_task_stack() helpers").

The d4dd9775ec24 commit introduced the pattern of calling potentially
sleepable build_id_parse() while holding mm locks via find_vma(). Commit
777a8560fd29 only made the latent blocking behavior more severe by using
__kernel_read(), but the architectural issue of calling sleepable
functions under locks was introduced earlier.

Should this be:

  Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25711733137
--===============1946919969375932260==--

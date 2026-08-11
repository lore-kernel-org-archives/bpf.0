Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179D417BFE;
	Tue, 11 Aug 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452015; cv=none; b=LYPcE0U6XZy44k0vhNhfx5zKiT6ni/pxX9Sbk7Xy380jvCVHYvEYznGY388B3x+3D6UKoL9SQJK5fhqOEZ97aNYVQWXyryQjHMGquthf+2RgAa+jVV/ucT7Lx+OiJvrobj5mHyxI/FbvuwWsHZV9oh54jnyIp4munpFF/kGzNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452015; c=relaxed/simple;
	bh=vlDB+IT6HAFzvJ9h8+I4k38CjPjJSAOOjk9KMjP6z7o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=trvDiUwdRK96TIU9ng76SsZr1EV4kWOd1WgnY4/A50P+uu+CPMMfE5rpLa90Txx7saoNeEu64oS8noKCsgrNJ3wYvdn/mNARNUZNWx8DW1TsiLAGqwrJln3v5zdspwf2ldFFf+J0AQFnZRQT+eQR3dv0l5hgTyQfODCPxOoa5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGt+2tWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGt+2tWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F374B1F000E9;
	Tue, 11 Aug 2026 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452013;
	bh=d5KyEGK2gDTZnR9ONWdkjRYGPSDM1pP3aSec7OaL0No=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KGt+2tWOShDWT53xguh5grN6IERZuI/BcSokJh/qo9xHrDHp71T2lTEV8vQI3kKH8
	 sOujFReeKMeaVoSrS8UVExf60Ru+jd3nZucEoHFqgKlr3oD/x2eFor3QT9EDx/pSSG
	 b7Gp+UNTJ9jd9tURmxMw6E92iQrsfM6GTEOr5vI6JAgRDOz3vUAmAF5UgRQOUY3DQv
	 Eq7LdS74jTomov+Lqtp3eqg9I4dlCIxLq7zHhX+wOvYT7jkRzrvezC23saJp85LF4h
	 il/alnH9MhPAE+csaCRah1/5UqNT05pglcNV7hD/nL/WJz1sSUlW4Z56sJTnG/R0ex
	 UWmi9hh6E70KQ==
Content-Type: multipart/mixed; boundary="===============4081865467468875899=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c189189e30671eaac05435772319bfeec1c1bf5d8a21a4f7e4aa95f0e88910a@mail.kernel.org>
In-Reply-To: <20260811112154.94053-3-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-3-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add user memory access kfuncs for mm_struct
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 12:40:12 +0000 (UTC)

--===============4081865467468875899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Register both kfuncs with the common BPF_EVENTS kfunc set and mark them

This isn't a bug, but could the changelog be more precise here? The
kfuncs go into common_btf_ids, which is registered for
BPF_PROG_TYPE_UNSPEC, so they are reachable from any sleepable program
rather than from a tracing-specific set.

Relatedly, was gating them on CONFIG_BPF_EVENTS intentional? Nothing in
either function depends on tracing, and the analogous
bpf_copy_from_user_task*() kfuncs in kernel/bpf/helpers.c are available
unconditionally.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6388b6b23e490..9ba3362832cd0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4931,6 +4931,8 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
>  #ifdef CONFIG_BPF_EVENTS
> +BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
>  BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
>  BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 891897f8a1b35..8931b3b2fc9d7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/namei.h>
>  #include <linux/file.h>
> +#include <linux/mm.h>
>
>  #include <net/bpf_sk_storage.h>
>

[ ... ]

> +__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +				      const void __user *unsafe_ptr__ign,
> +				      struct mm_struct *mm, u64 flags)
> +{
> +	int ret;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
> +			       dst, dst__sz, 0);
> +	if (ret == dst__sz)
> +		return 0;
> +
> +	memset(dst, 0, dst__sz);
> +	return ret < 0 ? ret : -EFAULT;
> +}

[ ... ]

> +__bpf_kfunc int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +					  const void __user *unsafe_ptr__ign,
> +					  struct mm_struct *mm, u64 flags)
> +{
> +	int ret;
> +
> +	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
> +				 dst, dst__sz, 0);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (flags & BPF_F_PAD_ZEROS)
> +		memset(dst + ret, 0, dst__sz - ret);
> +
> +	return ret + 1;
> +
> +err:
> +	if (flags & BPF_F_PAD_ZEROS)
> +		memset(dst, 0, dst__sz);
> +	return ret;
> +}

This isn't a bug, but since copy_remote_vm_str() in mm/memory.c is
already just a get_task_mm()/mmput() wrapper around copy_remote_mm_str(),
would it be cleaner to have bpf_copy_from_user_task_str() delegate to the
new mm-based kfunc (or share a static helper) rather than keeping two
near-identical copies of the flag/PAD_ZEROS/return-value logic in
different files?

The new copy also uses a 'goto err' where the existing one inlines the
error path, so the two now diverge in style too.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31488001112
--===============4081865467468875899==--

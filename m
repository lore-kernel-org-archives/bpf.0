Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F4440A35;
	Wed, 12 Aug 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537136; cv=none; b=h9ICu94KGe3vbVsd26X2wfJbScGsOu/3qRnlm4rnVrBiNvJSFU4svT4uZmZbdZFb/Bi/lH6SEJn/OUZQnnTBEyghAXZv32XMNCdsfTjlHf7gTZEP9GbxgnDoBCcedaql+C5gV0PTVrcOtM+EHH1vGIPiclqpvfGak3K0E9nY5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537136; c=relaxed/simple;
	bh=hWIi33t2KwRJlr6LGT6D0u95DfVfz2wo7/55X8BLW+o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VS6OzG7je+Rb5AGVXB486ElWbuS6r/qMZD1RJQV+ya3wrcWgc1V1mkrOGQPzXmRJ30wA2CymI6n21UTyMkNxfI3q31laDWYpnB9ODkx/pFHq808xOaok0jY3E5ancRXdh78SkkaH4S5MaqSQbkMLyoWKCdvjhYLhEbl3KpC33DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR1ELGkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR1ELGkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD871F00A3D;
	Wed, 12 Aug 2026 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786537133;
	bh=AMpFTc+g6IgE1WuvBF2vZgzKnR0zlmMW9uPYcbdXHdc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XR1ELGkYJUV0I3g+KHTQYwCBvRLMrofKznvS8I2nDwtcAyO0VcBpHl04RQkcUVAGd
	 PA/06i9bIQZ0fUD2+LzJXHKLuGZr5I9B4/mB2dslmOh0rgPdMIXsJUt9zq4UyQHOHt
	 4Evh2ualwdkzQ3p/qB/M/StBLdKPE2iArtvP33SDgYsES544piVbjcoYRLikb7IPzO
	 08dwiQhROIEA7O87PDxzOvAPfdyEO31fQkFlzOaOTJIigT6stfi9A9uOP+3dOCDc8d
	 DsGbQTy5Uy9AoSMI64EBBLauPv8n6dbYhhr1lSoBCwm8aVN1AXNgwhO2DuM9zeQlsO
	 IrlkxLoizi2iQ==
Content-Type: multipart/mixed; boundary="===============4269150414782578171=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c6c4c0dc10821a217412145a7ecce31849d0f2375ab6fb51b69db49acad7e22@mail.kernel.org>
In-Reply-To: <20260812111140.7762-3-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-3-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 12:18:52 +0000 (UTC)

--===============4269150414782578171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891db6..74befdadad68 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2024 Google LLC. */
>
> +#include <linux/binfmts.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf.h>

[ ... ]

> @@ -379,6 +380,112 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  	return d_real_inode(file_dentry(file));
>  }
>
> +/**
> + * bpf_copy_from_user_bprm - Copy data from a binary parameter address space
> + * @dst:             Destination address, in kernel space
> + * @dst__sz:         Number of bytes to copy
> + * @unsafe_ptr__ign: Source address in the binary parameter address space
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           Reserved for future use; must be zero
> + *
> + * Copies data from the nascent address space associated with @bprm. This is
> + * useful for reading the argument and environment strings before the new
> + * address space is installed by exec_mmap(). For example, at the
> + * bprm_check_security LSM hook, @bprm->p points at the first argument string.
> + *
> + * The destination is zeroed if the requested number of bytes cannot be copied
> + * in full.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
> + * fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
> +					const void __user *unsafe_ptr__ign,
> +					const struct linux_binprm *bprm, u64 flags)
> +{

[ ... ]

> +}
> +
> +/**
> + * bpf_copy_from_user_bprm_str - Copy a string from binary parameter memory
> + * @dst:             Destination address, in kernel space. This buffer must be
> + *                   at least @dst__sz bytes long
> + * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
> + * @unsafe_ptr__ign: Source address in the binary parameter address space
> + * @bprm:            Binary parameters whose address space will be used
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from the nascent address space associated
> + * with @bprm. If the string is too long, @dst is still NUL-terminated unless
> + * @dst__sz is zero.
> + *
> + * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on success
> + * and all of @dst is cleared on failure.
> + *
> + * Return: The number of copied bytes including the NUL terminator on success,
> + * or a negative error code on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
> +					    const void __user *unsafe_ptr__ign,
> +					    const struct linux_binprm *bprm,
> +					    u64 flags)
> +{

[ ... ]

> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -390,6 +497,11 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
> +#ifdef CONFIG_MMU
> +/* NOMMU keeps the staged arguments in bprm->page[], not bprm->mm. */
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_bprm_str, KF_SLEEPABLE)
> +#endif
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)

This isn't a bug, but since the bodies are still built on NOMMU with no
possible caller, would it be tidier to put the CONFIG_MMU guard around
the two function definitions as well as the BTF_ID_FLAGS entries?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31592551940
--===============4269150414782578171==--

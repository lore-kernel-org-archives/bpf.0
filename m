Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FD367F45
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808348; cv=none; b=ql3SbudsC0rF8LD5RpfFdoTBf1Ll9gUorv8bj6AOhKT8mNGhSh4BLG2p9iYla18QyCLyX3OLFdGBRQo6dzvG/CEss1/70TpkgDeyBTz50oWtmi5kL6ytnIidjimCaRNj3Lady/ydNBnMENh7m5C0V6yHhRv4iKGPZjiSdgv2gFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808348; c=relaxed/simple;
	bh=HiuJ/Lt9pMwL6jOtJXOt5HXXbHN/iNveKFTh+3BBkR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GYtkUwqGI0wXWGlNbcbjgH20lhaaKXu9BWXKg+v4CUAXtybksS3PEZUc8zvcQUrvDImLmodzyLGi9hEZUdUqJFTVJQ3DGpZCPyMbPxkRvcJbNkryL95eSjJyd72oeMIkEFG1iPir7pzIcaWRnpv4vr4EaoYa669yKwVQXcWCWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnSxBjH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnSxBjH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF40C2BCB3;
	Fri, 15 May 2026 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808348;
	bh=HiuJ/Lt9pMwL6jOtJXOt5HXXbHN/iNveKFTh+3BBkR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WnSxBjH+XqxzikA0I4o4VkWOwZCpjny8ZYWtHntMJfMgsfaFxIRbVmpJ3n23KZWN+
	 LUOjnB1SVsuBGLuK7DFOXoCoB4P8nuqiIwEuatpVZhGO5SKGZIkb6tGvmGX4AEDZER
	 2X/kiTpPo8rY1uAA/6mY1JmFPx27ZpzHWMgo3mZtca/RXa14/fFAkGnoXz8ZyRyrEO
	 jXwNXYTkasgH+9oAFbDU3wcILt7aWowMis3RhQFqr9lfTnYrfPRT46Va4AFuasUO7c
	 dKTzUxUmnLYAvbt/OuFrj9t3Fw4ykS+4Kc4UN+GdMRixRPL2oeSLmW0D4hend52th7
	 n1FTtxcuG8n2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Avoid faultable build ID reads
 under mm locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515005244.1333013-3-ihor.solodrai@linux.dev>
References: <20260515005244.1333013-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:25:47 +0000
Message-Id: <20260515012547.EFF40C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Sleepable build ID parsing silently fails on kernels built without=
 CONFIG_PER_VMA_LOCK.
- [Medium] Incorrect VMA classification using `!vma->vm_file` instead of `v=
ma_is_anonymous()`.
--

commit 6ca3c963b80bfbdca796bfbc82d5d51cf0333054
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Avoid faultable build ID reads under mm locks

This commit modifies the sleepable stackmap path to parse build IDs without
holding the mmap_lock or per-VMA read locks. It locks the VMA via RCU or
mmap_read_trylock, captures the file reference, releases the lock, and then
performs the sleepable file read.

Link: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linu=
x.dev/
Link: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.or=
g/
Link: https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linu=
x.dev/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> +static struct vm_area_struct *
> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{

[ ... ]

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

Does the fallback for kernels built without CONFIG_PER_VMA_LOCK completely
disable the build ID parsing feature?

Looking at the #else branch, it unconditionally drops the mmap_read_lock and
returns NULL. This causes the caller to receive a NULL VMA for every IP,
which skips parsing and falls back to returning IP-only traces.

Could this instead keep the mmap_read_lock held, return the VMA, and allow
the caller to extract the file reference, vm_pgoff, and vm_start before
safely dropping the lock?

> +vma_locked:
> +	lock->vma_locked =3D true;
> +	lock->vma =3D vma;
> +	return vma;
> +}

[ ... ]

> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_bui=
ld_id *id_offs,
> +						    u32 trace_nr)
> +{

[ ... ]

> +	for (u32 i =3D 0; i < trace_nr; i++) {
> +		ip =3D READ_ONCE(id_offs[i].ip);
> +		vma =3D stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {

Does checking !vma->vm_file properly identify file-backed VMAs?

Some anonymous VMAs, such as private mappings of /dev/zero, can have a
non-NULL vm_file but are conceptually anonymous since their vm_ops are NULL.
Allowing these through would result in taking a reference to the device file
and unnecessarily attempting to parse an ELF build ID from it.

Would it be safer to use vma_is_anonymous(vma) to accurately verify if the
VMA is genuinely file-backed?

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515005244.1333=
013-1-ihor.solodrai@linux.dev?part=3D2

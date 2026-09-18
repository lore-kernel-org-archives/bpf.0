Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A495351C17
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723819; cv=none; b=J7TmrI1HNc86tsohPbQrsvL3piv52jN+y8KV+ozm/0Ss1yrDdUwwzCry9FBjyjRn9DNmhnvXBs5UmbXW8EmIRx3gP8umXPZGizItKTBSe7FKKi4qpAPEhbuEm67c/n7ACg4EBVAetqFr/KICN57aMMNvZEdaCFmWZYIgDaA13Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723819; c=relaxed/simple;
	bh=7U0k1RMm/xHDbf7wC0qHRHTt3kPQyAUaAqXWjg1Z38Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TFQJBUW6PEoKh9/5jA5Or527CPBl/C1XBK5elS1I2t56CJamfuB7BHBdoBibBS0S4qvDNRa6owSnVY2zhpaXvvvOTHDg4TwwGd3H8KuqTMICTL6HymA66cQ53WzicECPxVRcpZatVLql+LnvrBkXQEGtZBZExc2OqQ3pOsojQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+LctNFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+LctNFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF821F00893;
	Fri, 18 Sep 2026 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723817;
	bh=eDpOCznABDD5IHodk+irrAU2DTvWziaom606cNC5qgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+LctNFTu3FfHICdIEXKp/rmfK08OWvXXq/uxDkpLDbSGMHvpyATY2jCtCtXY6s7X
	 sUaMOBkyOvm/sNsa4Dq7SDGT3DR5Wpg/vBooRVFWzc4Lgaui7Q+MDLyF3FIi9SEOz8
	 34FvPvDHUyIk91koLb0AEnNLyTK8Zem2JgJOtiAZc6bjYigURH3ayxL9xuvQsTH1O8
	 S0H1tYqU/ak65LPkD5CWAr3P9XrUNU3rjkqxfJJldDbkgdVMqn5wtXOLKBcMeC/B+w
	 cjb0RHZBX6DVrV1XhRCaHHnErd4pmcnFGi8v8cEm995cOV0TSmAmKX5pDJEOX7Bk+U
	 9QUFso5R93Ekw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/5] bpf: Add user memory access kfuncs for
 mm_struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918091058.297740-4-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
 <20260918091058.297740-4-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:30:17 +0000
Message-Id: <20260918093017.AFF821F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: UAF in bpf_copy_from_user_mm due to unreferenced mm_struct
--

commit cbb90d2c797aaefaca575d8d6f41d087c38c6414
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

bpf: Add user memory access kfuncs for mm_struct

This commit adds new bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str()
kfuncs that allow BPF programs to access an address space directly using an
mm_struct pointer. It refactors task-based helpers to share their internal
implementations with the new mm-based kfuncs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 051b6654e57c6..f6b3eee6098a0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -3659,6 +3697,68 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
[ ... ]
> +__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +				      const void __user *unsafe_ptr__ign,
> +				      struct mm_struct *mm, u64 flags)
> +{
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(!dst__sz))
> +		return 0;
> +
> +	return __bpf_copy_from_user_mm(dst, dst__sz, unsafe_ptr__ign, mm);

[Severity: High]
Can this result in a Use-After-Free during concurrent task exit?

When a task exits, mmput() drops mm_users to 0 and calls __mmput(), which
invokes exit_mmap(). exit_mmap() releases the mmap_write_lock and then calls
free_pgtables() without holding any locks.

If a BPF program passes a trusted mm_struct like task->mm to this kfunc, it
eventually calls access_remote_vm(mm) without validating or incrementing
mm_users (for example, by using mmget_not_zero()).

Since access_remote_vm() acquires mmap_read_lock(), if this occurs after
exit_mmap() has dropped the write lock but before it destroys the VMA tree,
vma_lookup() will succeed. This means __get_user_pages() will walk page
tables that are being concurrently freed locklessly by free_pgtables(),
resulting in a Use-After-Free.

Does this need to acquire a reference to mm_users before proceeding?

> +}
[ ... ]
> +__bpf_kfunc int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +					  const void __user *unsafe_ptr__ign,
> +					  struct mm_struct *mm, u64 flags)
> +{
> +	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +		return -EINVAL;
> +
> +	if (unlikely(dst__sz =3D=3D 0))
> +		return 0;
> +
> +	return __bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
> +					   mm, flags);

[Severity: High]
Similarly, does this also suffer from the same unreferenced mm_struct
lifetime issue described above?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918091058.2977=
40-1-tasos.papagiannnis@gmail.com?part=3D3

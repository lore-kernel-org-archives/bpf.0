Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005933E1D1A
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170515; cv=none; b=f10g0ZzrAomaIJwmLMsNL3iOfmD5qTHZLQ99+7lDPaKX3yfRJXC5v/jDkLvEmIendcBWucrfodb1DJy882+8+/OxAcBqKNQNYqZidV3bhUX7ZLiqoUANxcDEOvLsQFTGPlaXbDFaldcSq3U3GAfVtb+Uy0f79QaBbnjfr/7hlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170515; c=relaxed/simple;
	bh=Uz30qR7eDU/YylRTBNhnOZS7YPd8NhUHTff5cwlLYCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNJteE6nXuKh4O38E13BdgkWO60px8AVcGCMhAmoGB0P2pgh0f1Iozfv0HiPEuA+PR3YeUtkhBt/cATqUscvq/88R2UaVB489VPmsVp/LQIM8M9lGedkvO4pWjLsJ1uwhi+jiQO7bmq623n7NA4xe2KTo+u43hD9pd6orypQ7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXxWAmR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXxWAmR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF21F000E9;
	Mon, 31 Aug 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170513;
	bh=dP+W8az+GAGNJ5KuW59jjizCDEwnzYCovZUzzWVSjd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXxWAmR2IluIDjeDXJ6hOEK4ywB7llmd83gV5s57S0pt2BN4w2AcfFdF+HPClnhCa
	 W+QLu+0wHQnmk6qSGob7lRuB35CvRnltNGw0GHIUph172pPINBiDYcKhxIRe2VNtSF
	 cQkuw77ypsr64YToQIHld/ni+siPuyfw76ukCIar1duwURLbjHmCvGKKTuuErpVzZ5
	 2btumM1aTPl8dFVuffm9Q2SAz83HXr7VmAUtoL+paOw+Jl24zBsHgIKCMo8HUwqMH5
	 uVScSJlqAE6s4URs7c5Ecfzzbag1okUN4YtuHTWx4rAEkpQZd2szwme/tL8FrLX1LD
	 w7k/o7b+3lzwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Add user memory access kfuncs for
 mm_struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831092305.42062-3-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
 <20260831092305.42062-3-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:01:52 +0000
Message-Id: <20260831100153.60EF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `dst` arguments in `bpf_copy_from_user_mm` and `bpf_copy_from_u=
ser_mm_str` lack the `__uninit` suffix, causing the verifier to reject unin=
itialized stack memory and forcing unnecessary zero-initialization.
--

commit 064bec09b54d9a7638a0865baa943bd0e6467f30
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

bpf: Add user memory access kfuncs for mm_struct

This commit adds bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str()
kfuncs to allow BPF programs to access trusted address spaces not associated
with a task_struct. It also updates existing task-based user memory access
helpers to use these new functions.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc8756..19c01aa734ae1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +				      const void __user *unsafe_ptr__ign,
> +				      struct mm_struct *mm, u64 flags)
> +{

[Severity: Low]
Should the dst parameter be named dst__uninit here?

Without the __uninit suffix, the BPF verifier natively treats void pointer
kfunc parameters as ARG_PTR_TO_MEM. This forces BPF programs to redundantly
zero-initialize their buffers before calling these sleepable kfuncs, degrad=
ing
usability and performance compared to the older bpf_copy_from_user_task hel=
per.

> +	int ret;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;

[Severity: Low]
If the __uninit suffix is added, the verifier will assume the buffer is
initialized upon return. Without clearing the buffer on this early path,
could this allow a BPF program to read uninitialized kernel stack memory?

[ ... ]

> +__bpf_kfunc int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +					  const void __user *unsafe_ptr__ign,
> +					  struct mm_struct *mm, u64 flags)
>  {
>  	int ret;

[Severity: Low]
Similar to bpf_copy_from_user_mm above, does this dst parameter also need t=
he
__uninit suffix to avoid forcing BPF programs to pre-initialize the memory?

If it does, the early flags check in this function would also need to zero
the buffer before returning -EINVAL to avoid leaking uninitialized memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831092305.4206=
2-1-tasos.papagiannnis@gmail.com?part=3D2

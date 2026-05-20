Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9E373BEB
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294829; cv=none; b=tsxRG3TqyFHnJoFs/K22R2u5LGjYiOdKwtltO4ohZIcrvdUnvP7grNwmImGiDlHyGlKiGcdlR4S91mdJL6D6X+kfJpDrkT+ufg/JIlIcYxgyPZTculY03eu8FR1WAAQpgRJAu+iSVMwuZTz9AOVg5OtdwdYxx38FTiIUy4pod00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294829; c=relaxed/simple;
	bh=AM0Jkebl3l/bngAKgDE71o1Xs5im6dOmp/biiw0+2w4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhFzoFkhGUDqcXdHZ0OGWB3INkGaggapIUo2aqV8gzNWrmsVENYczm8jFI2QMVmSKXLdIVN/F3tzNfSv6WmDek8Ha1Jsvq7f13lTwtHeMy5DZQAV6q9lxDC3V+qnp8fEYPVbpd1hiNPifGfHaSitgHE6x7rrZBb1ahD5Myu/nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTmwfjRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTmwfjRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FD21F00893;
	Wed, 20 May 2026 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294828;
	bh=Wn6GpSr4qd5xuikL137DzQ9WRnGBxi4rZ41cpL9jEBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTmwfjRl5Hi+6z7qZiRoCaLhODwsEIBNEdPyPcfy8m2koObm70CroZdzs7uimm8At
	 OpICbz8Nr9PD6agc8MaiSBiDXC1UuETlNzIVspVZ8fok3qkO0K/Z/0HSH0rLAp1KVz
	 IhRam5lPXXstU331fYMZQ5oJRH7WXzHrTm1RLgT5aoV6SODpZEuyTSd/KdwVJSWuXa
	 vB4C/RR8yF7gDUzQar4ecRLHNQYpaON3Ub9jP/tCp/v2FNiL3R+VuhCX7em8++yI3Z
	 EZD4LRBDU8vOTQ8SHloWOY9ZzsrJGJOb6hbsUTMMXq45GfF0s+MPJbRGqoe7v0Hn1U
	 g3IIgqIFWsb6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/20] unwind_user/sframe: Add support for reading
 .sframe contents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-6-jremus@linux.ibm.com>
References: <20260520154004.3845823-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:33:47 +0000
Message-Id: <20260520163348.11FD21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Incorrect FRE size calculation due to using a mutated `dataword_co=
unt`.
- [High] Binary search incorrectly reads 64 bits for a 32-bit PC-relative o=
ffset, corrupting the function address calculation.
- [High] Unbounded linear scan of user-controlled SFrame FREs can cause a k=
ernel hard lockup.
- [High] Usage of `guard(srcu)` invokes `srcu_read_lock()`, which is not NM=
I-safe and can corrupt the SRCU lock counter.
- [Medium] Mixing goto-based error handling with scope-based `guard()` clea=
nup.
--

commit 12c453957aeaea0a5733d7ed09d97cf7dfd380a5
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add support for reading .sframe contents

In preparation for using sframe to unwind user space stacks, add an
sframe_find() interface for finding the sframe information associated
with a given text address.

Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.=
1737511963.git.jpoimboe@kernel.org/
Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linu=
x.ibm.com/

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 6b3ce3f8966d0..a38f50a363633 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -15,9 +15,350 @@
[ ... ]
> +static __always_inline int __find_fde(struct sframe_section *sec,
> +				      unsigned long ip,
> +				      struct sframe_fde_internal *fde)
> +{
[ ... ]
> +	while (low <=3D high) {
> +		struct sframe_fde_v3 __user *mid;
> +		s64 func_off;
> +		unsigned long func_addr;
> +
> +		mid =3D low + ((high - low) / 2);
> +
> +		unsafe_get_user(func_off, (s64 __user *)mid, Efault);

[Severity: High]
Does this read 64 bits for a 32-bit PC-relative offset? Since SFrame V3
specifies a 32-bit signed integer for the PC-relative offset followed by
a 32-bit function size, won't reading 8 bytes merge both fields into
func_off and corrupt the function address calculation?

> +		func_addr =3D (unsigned long)mid + func_off;

[ ... ]

> +static __always_inline int __read_fre(struct sframe_section *sec,
> +				      struct sframe_fde_internal *fde,
> +				      unsigned long fre_addr,
> +				      struct sframe_fre_internal *fre)
> +{
[ ... ]
> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
> +	dataword_count--;
> +
> +	ra_off =3D sec->ra_off;
> +	if (!ra_off) {
> +		if (!dataword_count--)
> +			return -EINVAL;
> +
> +		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
> +	}
> +
> +	fp_off =3D sec->fp_off;
> +	if (!fp_off && dataword_count) {
> +		dataword_count--;
> +		UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
> +	}
> +
> +	if (dataword_count)
> +		return -EINVAL;
> +
> +	fre->size	=3D addr_size + 1 + (dataword_count * dataword_size);

[Severity: High]
Is the FRE size calculation correct here? Since dataword_count is decrement=
ed
as datawords are read, and the previous line ensures it is exactly 0, doesn=
't
this entirely omit the size of the read datawords from the total FRE size?
When __find_fre() advances to the next FRE, this might cause it to point to
the middle of the current FRE's datawords and read garbage.

> +	fre->ip_off	=3D ip_off;

[ ... ]

> +static __always_inline int __find_fre(struct sframe_section *sec,
> +				      struct sframe_fde_internal *fde,
> +				      unsigned long ip,
> +				      struct unwind_user_frame *frame)
> +{
[ ... ]
> +	fre_addr =3D sec->fres_start + fde->fres_off;
> +
> +	for (i =3D 0; i < fde->fres_num; i++) {
> +		int ret;

[Severity: High]
Could this loop cause a kernel hard lockup? fde->fres_num is read from user
space and can be large. Since this performs a linear scan reading each FRE
sequentially from user memory, and unwinding often runs in NMI context (like
perf PMU interrupts), could a maliciously large SFrame section force the
kernel to loop without yielding and trigger the NMI watchdog?

> +
> +		/*
> +		 * Alternate between the two fre_addr[] entries for 'fre' and
> +		 * 'prev_fre'.
> +		 */

[ ... ]

> +int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct sframe_section *sec;
> +	struct sframe_fde_internal fde;
> +	int ret;
> +
> +	if (!mm)
> +		return -EINVAL;
> +
> +	guard(srcu)(&sframe_srcu);

[Severity: High]
Is this safe to use from NMI context? Stack unwinding is frequently invoked
from NMIs (like perf PMU interrupts), but srcu_read_lock() is not NMI-safe
on all architectures (like arm64, where the non-atomic read-modify-write
could corrupt the SRCU lock counter). Should this use srcu_read_lock_nmisaf=
e()
or standard RCU instead?

[Severity: Medium]
Does this mix goto-based error handling with scope-based cleanup? The
function declares a scope-based guard here, but uses a goto-based cleanup
label (end:) below. This goes against the cleanup subsystem guidelines
which recommend either converting all resources to scope-based cleanup or
none at all, to avoid confusing ownership semantics.

> +
> +	sec =3D mtree_load(&mm->sframe_mt, ip);
> +	if (!sec)
> +		return -ENOENT;
> +
> +	if (!user_read_access_begin((void __user *)sec->sframe_start,
> +				    sec->sframe_end - sec->sframe_start))
> +		return -EFAULT;
> +
> +	ret =3D __find_fde(sec, ip, &fde);
> +	if (ret)
> +		goto end;
> +
> +	ret =3D __find_fre(sec, &fde, ip, frame);
> +end:
> +	user_read_access_end();
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D5

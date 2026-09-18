Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131D39B4A5
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723474; cv=none; b=srVJTr+gTzx3rKDfPo4D8x7+I3QYAOhv+A/irlgYuwvILVs/QGdX8AXZSGHIbZulBAMXBCNvN0PFLen3HJIv7qixhnZ5tguadd8EM9ZJOB+TvH8GrGnWkViaBkBy9/scjpqU48ElBVxXxx4h5m5PmJqx4Qn94IpoE5cn5/fkAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723474; c=relaxed/simple;
	bh=zW18JH5PVGmnlflhrk4B9/yiEUSuC9qPpp6P840c6Po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxLwTB6wORDykAWA00gbvu3Ms/1Ma9IursO71Ux0k7a1LiHQN1R1dXydbGQZ3jkKRB2JwNgqTiVpdpjmeA8E9+9gK6V4rcbtWjxr/2BV3TDDgLQOKozUEHlkEXaJNEI+Ex+2Nonemif+jg6Wkb2Kxn9Ctpk8zHcRbzET3nh6XwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/E+D/LU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/E+D/LU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5872C1F000FF;
	Fri, 18 Sep 2026 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723472;
	bh=J8YihC9B+5OocyJWgpt747622dR9P9kzf6Lq4ZBru5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/E+D/LUYHtwewNA6eznqjBKA4xX9QKOvsF4HFHVP+Q4DZ5uL2REwJ802XWTtE+IB
	 Jp2dYT9jGR8JBCS2fnkHI2c/XDaEt8m4JJUcaFiSEAihG2e3lrhJt/VvZjSJQJ2fHx
	 FutcnsRzD2U1adTkYdC9l7K4gatOEthuNI5UDhgE+JqwebqZJNljV7U+zVnNOjKAdc
	 DYUbsVs4RnwHr0tlzQHixZOtUaW7Al/7pY3vCj4x4zBxrcNln//tK6MN0JS8XctI6g
	 VRk/eAI62YngWijF3gGOM+3NZHH3Zeq/vZtx9IqFcpqaByJYNj1T9JKoh8VkZaRDs/
	 JZt7OU8SsO6sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 4/5] bpf: Mark linux_binprm->mm as
 trusted-or-null
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918091058.297740-5-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
 <20260918091058.297740-5-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:24:31 +0000
Message-Id: <20260918092432.5872C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: ABI breakage by marking linux_binprm->mm as PTR_MAYBE_NULL
--

commit df643731c6bb225a7d4269f98487ad63ccaf91fc
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

bpf: Mark linux_binprm->mm as trusted-or-null

This commit marks the linux_binprm->mm field as a trusted-or-null nested
pointer so it can be passed to kfuncs after a NULL check. It updates the
existing LSM selftest to reflect this new verifier requirement.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..3539a768b9211 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5997,6 +5997,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>  	struct inode *d_inode;
>  };
> =20
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
> +	struct mm_struct *mm;
> +};
> +

[Severity: Critical]
Will this cause an ABI regression for existing BPF programs?=20

Before this patch, the bprm->mm field was treated as an untrusted pointer
(PTR_TO_BTF_ID | PTR_UNTRUSTED). The verifier permits dereferencing untrust=
ed
pointers without a NULL check by safely rewriting these accesses to use
BPF_PROBE_MEM exception tables.

By explicitly adding it to the BTF_TYPE_SAFE_TRUSTED_OR_NULL list, the
verifier now tags it with PTR_MAYBE_NULL. The verifier strictly forbids any
direct dereference on a PTR_MAYBE_NULL pointer before an explicit NULL chec=
k.

Does this change mean that previously valid, safe BPF programs will now be
rejected at load time, violating the kernel's UAPI backward compatibility
guarantee?

To avoid this breakage while still allowing kfunc usage, could a kfunc
accessor be exposed (such as bpf_bprm_get_mm()) instead of modifying the BTF
property of the struct field?

> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/self=
tests/bpf/progs/lsm.c
> index 7de173daf27b6..7441d66c080c9 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
[ ... ]
> @@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bpr=
m)
>  		bprm_count++;
> =20
>  	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_st=
art);
> -	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
> +	mm =3D bprm->mm;
> +	if (mm)
> +		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);

[Severity: Critical]
This selftest modification appears to demonstrate the regression in=20
test_void_hook. Doesn't this prove that existing BPF programs in the wild
that access bprm->mm without a NULL check are no longer accepted by the
verifier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918091058.2977=
40-1-tasos.papagiannnis@gmail.com?part=3D4

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE64F797F
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740187; cv=none; b=aEx0fDme/oP9eYb5r+7RkJbjr/exFuUqmloWM8vXM+4Ij/HV/umICYLf2uT795GxlAerq6lfGR55iZZVd5q+oAuLLoGhZWhSASnC1jIvNJkgyF8cHKOPBK5GnzBx5xSy9u93yQMAG/UOoqMozjNOvmj70CO494UZDa9r5l8rE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740187; c=relaxed/simple;
	bh=IOObpe2OSU3tGru0j+4FUCrorkv2Lgm99SdambyIJc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dO8J4hoSG0q6/E3o2ot8ZMnsKFz0NvHw5t9SSCOS10LWtfQY9/ieqXSXKxTv7+E6hILPwmrXXS/gTEO0eh3xd31sUDMae1Gfw8Qu2fqCeb27e3eyNSYOZb9adM/Uz8ao64yOVkH3s0yKQtPuAoBmWMM9e6Cg0oXqRc9fahpjopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS6k4wp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS6k4wp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88251F000FF;
	Fri, 18 Sep 2026 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740186;
	bh=AQj4VD/WXy4m3KR9kalUmlXRQxwYTO/V1/tTqp/nm40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nS6k4wp18KyWmj27+kIbxe1Uv/QzfJvgX1ASWQXnaYgffy+iomb24FLRrIMPXt0SJ
	 jf/vSexNR+RI7+2P3WHH+5KsSt9Z88JBH6InUVCeNcEgLfBkXMvDaYAWLFrBhRed7H
	 Hu3F7+WIxDDMi2sI1l511sKhANVEc1Y+1it2CcHjWGWvBwF0mpb2Tww2XWajipm/CS
	 ok4l4NYcdwCZpvMzoEhlVmHgpbKKQE0h1X8Tg1lYOzKHzupCbI4emLrEM9UfHNSoYE
	 Q2I+wWI1P7cuQl8gSAz2mX0ckE8r7T4KFM/uGOk5kTOkVdTTyCNsuV0iitvgrj+yAB
	 if90WszzbmYIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 4/5] bpf: Mark linux_binprm->mm as
 trusted-or-null
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918131757.42802-5-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
 <20260918131757.42802-5-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:03:05 +0000
Message-Id: <20260918140305.C88251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: kernel panic via missing PROBE_MEM on fexit of free_bprm
- [High] bpf: ABI breakage on bprm->mm dereference due to TRUSTED_OR_NULL u=
pgrade
--

commit 128aa90c601cd807f8be00c84b4237b6611809e3
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

bpf: Mark linux_binprm->mm as trusted-or-null

This commit marks linux_binprm->mm as a trusted-or-null nested pointer in t=
he
BPF verifier, allowing BPF programs to pass it to kfuncs after a NULL check.
It also updates an LSM selftest to perform this NULL check before usage.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..3539a768b9211 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6051,6 +6055,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));

[Severity: Critical]
Can this upgrade to a trusted pointer cause a kernel panic if a user loads
an fexit program attached to free_bprm()?

Because free_bprm() frees the bprm object before the fexit hook executes,
reading bprm->mm yields a garbage pointer. Before this patch, the verifier
automatically inserted a BPF_PROBE_MEM exception table entry to protect the
dereference of the untrusted pointer.

By upgrading bprm->mm to a PTR_TRUSTED nested pointer, the verifier bypasses
this BPF_PROBE_MEM safety net. If the fexit program checks for NULL and then
dereferences it, could it trigger an unhandled page fault and crash the
system?

>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
> =20
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/self=
tests/bpf/progs/lsm.c
> index 7de173daf27b6..7441d66c080c9 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
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

[Severity: High]
Will this change break ABI compatibility for existing BPF programs?

As this selftest modification demonstrates, existing BPF tracing or LSM
programs that access bprm->mm without a NULL check will now be strictly
rejected at load time by the verifier.

Previously, the pointer was treated as untrusted and the verifier
automatically shielded the dereference with a BPF_PROBE_MEM load, gracefully
handling NULLs at runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918131757.4280=
2-1-tasos.papagiannnis@gmail.com?part=3D4

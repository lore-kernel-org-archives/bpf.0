Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93D15539A
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778202579; cv=none; b=N5QxzOJ3IZFo/ynjDH6xLWI3O6MTY33pvVDEuPnnjkG5qrC61P/bGgxLPq8sA5DplvendQk0FQXdV6GCOHhaQXnavvTidnFJVLFiWRMANeZoha//dQjdkFhDaLzXbqhGGPQWGhTfKbamK5sQv5Z0NbyLMkcbHygVAat5SdzQsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778202579; c=relaxed/simple;
	bh=++9jsHNVNq3l8llvKQi9yCF/dfpiRD39ivM/cFka7qE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TdxixOytNc3GuTuz5uis2rlLSW0IRTRAk1YjYFkjp9UYrqBAALs8768ojKyRF/8EpG1hzKz9ROdEy9zWTyjZYaxyEeHmL+FPZHGRwr4f2NUDHOq7tFbJKma83IIoQ1bCoUhrhjFOFUKDQjBYowOsdz19++ilgLnWJ1LbCOr1Fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM8i5JQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM8i5JQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4AC2BCB2;
	Fri,  8 May 2026 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778202578;
	bh=++9jsHNVNq3l8llvKQi9yCF/dfpiRD39ivM/cFka7qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TM8i5JQwLVPRtIu9UELlWv9YBzG/IWl9uhCFLlgjVb9vYbQ97ZxamZCGoE50YylF3
	 ByvuyppGlaGGGS6gtJOd9PkLhcbj2jzVTU8tm+jlgW6Ocx4IU1zWd7GofSy3vhDMJa
	 thD/GdgFPc3/c1z5WhRrkK9PqfaT9irs/VxkQPAIr7Bz1HMzQasg5Hd0vYF2OybTzH
	 tagcBRhV7SfggrwHGJnnzzYPK1dg2DyN3f3rvlubmHhl6AW1NXAAEGnrmJvp2u9izy
	 3lIenjibk0gdlyEVR20wtdMdq/pMDZJexU4Dn/Es8wPuwlII8NKQ/8od/g9iWffDaw
	 8Ik+i+V8tLZmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] lsm: framework for BPF integrity verification
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-5-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-5-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 01:09:38 +0000
Message-Id: <20260508010938.A9B4AC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double execution of `security_bpf_prog_free()` on error paths, lea=
ding to duplicate invocation of LSM cleanup hooks.
--

commit da3e568b0e83968c7e672f02d2dc4e5b4cb4a3e9
Author: Paul Moore <paul@paul-moore.com>

lsm: framework for BPF integrity verification

Add a new LSM hook and two new LSM hook callbacks to support LSMs that
perform integrity verification, e.g. digital signature verification,
of BPF programs.

> diff --git a/security/security.c b/security/security.c
> index a26c1474e2e49..bb78f7e45a98f 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -5255,9 +5315,18 @@ int security_bpf_prog_load(struct bpf_prog *prog, =
union bpf_attr *attr,
>  	if (unlikely(rc))
>  		return rc;
> =20
> +	rc =3D call_int_hook(bpf_prog_load_integrity, prog, attr, token, kernel=
);
> +	if (unlikely(rc))
> +		goto err;
> +
>  	rc =3D call_int_hook(bpf_prog_load, prog, attr, token, kernel);
>  	if (unlikely(rc))
> -		security_bpf_prog_free(prog);
> +		goto err;
> +
> +	return rc;
> +
> +err:
> +	security_bpf_prog_free(prog);
>  	return rc;
>  }

Does this introduce a regression by causing a double execution of
security_bpf_prog_free() on error paths?

If either the new bpf_prog_load_integrity hook or the existing
bpf_prog_load hook fails, the code jumps to the err label, calls
security_bpf_prog_free(), and returns the error code.

However, the caller bpf_prog_load() in kernel/bpf/syscall.c receives the
error code and jumps to the free_prog_sec label, which unconditionally calls
security_bpf_prog_free() again:

kernel/bpf/syscall.c:bpf_prog_load() {
    ...
    err =3D security_bpf_prog_load(prog, attr, token, bpf_prog_is_kernel(pr=
og));
    if (err)
        goto free_prog_sec;
    ...
free_prog_sec:
    ...
    security_bpf_prog_free(prog);
    ...
}

This causes the bpf_prog_free LSM hook to execute twice for the same BPF
program. During the first call, prog->aux->security is freed and set to
NULL. The second call invokes the hook again with the NULL security blob.

Could this duplicate invocation violate lifecycle symmetry and potentially
cause reference count underflows, state corruption, or NULL pointer
dereferences in attached BPF LSM programs?

While this double-free behavior already existed for the bpf_prog_load hook,
this patch expands the flawed error handling to the newly introduced
bpf_prog_load_integrity hook. Should the internal cleanup in
security_bpf_prog_load() be removed to let the caller handle it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D4

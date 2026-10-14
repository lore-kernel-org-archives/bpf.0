Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D952940B
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999817; cv=none; b=cg/zWKPXbWQVS45uunArkq0oGqTKfqzJVdAtSZAxXiFRcga+pC23eGxjV3gGw168/zxm+nJdco0/exwKy2sYqBbd0lFy8+Xm+8IguyuWWd4gk3umLre49MOQJhx3VCktKCyXoGO1J0czSVQ19K5m8yYDdXYIk61RPVryRYTeJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999817; c=relaxed/simple;
	bh=Ve3ncIJfsqYjab+Wfioxyq9D7g5PGbboMcwsDLTpIeA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ebWwmvTBYGEc3JlO4cjwO2UAl3mVsJp0wS5jaOqI/8dGIvLuEZpc1XOKhvDq+py8dOogzNA3rWXOol5gWVJhkcYZTBaHsmfOqrog+c4GfwvzWXQypXbYQar0O5EZ58J4h+whqg2UsovTi6DXNUmjV8zPm0VBad8rrHgjikInhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2yi/X1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2yi/X1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D021F000C4;
	Wed, 14 Oct 2026 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999815;
	bh=E0Dd6dI929XYeJBjbIDPyRXusUwQ6UKp7v7aZe6QWX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o2yi/X1KGZWnM3tWWtM5VlixosLRHUgYidK9FDk0QlfbRAdyrJk3NpF6qBp6bVIQ0
	 iXvU2gIuxSEr0vvpvTuwZlbbotrwjYjNwYjnHk52HjTs/CC/VPRaGPNRYxT9QcN8Cv
	 Io/iSde+sAX4pOezOlO9e79uvP+N1aVk8lrXxTCUyLGX/r3oWwvlXN74NQdY6r/9VD
	 Q3LH2N4XlnElwKpd5CJOotw0N6yUDEsEbEo4ZxD3KN7FUqQis292heQ6O4FVyIYYFT
	 XV4L22TVhrcWiTe2cVyNOIHAUsn3bh5Bxu5aHluCc/FHolVWqzzTySiF5qIxRj+Lcg
	 lxM3n+0eDjOjA==
Message-ID: <sashiko-outbox-171590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Test MEM_RCU carry-over
 for trusted fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261014173039.3666415-3-utilityemal77@gmail.com>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
 <20261014173039.3666415-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:43:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: unhandled NULL deref of f_inode due to SLAB_TYPESAFE_BY_RCU
--

commit 3b6fbe50569bfdf0fb6b88ab1c38f2e6056c0f68
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Test MEM_RCU carry-over for trusted fields

This commit adds selftests to verify the behavior of the BPF verifier when
accessing fields from RCU-protected pointers. It includes an accept test
for dereferencing an inode within an RCU critical section, and a reject test
for using it after the critical section ends.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/to=
ols/testing/selftests/bpf/progs/verifier_vfs_accept.c
> index 55398c04290a8..f519ba5f4ea20 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
[ ... ]
> +SEC("lsm.s/bprm_committed_creds")
> +__success
> +int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
> +{
> +	struct mm_struct *mm =3D bprm->mm;
> +	struct inode *inode;
> +	struct file *file;
> +	ino_t ino =3D 0;
> +
> +	if (!mm)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	file =3D mm->exe_file;
> +	if (file) {
> +		inode =3D file->f_inode;
> +		ino =3D inode->i_ino;

[Severity: High]
Can this result in an unhandled NULL pointer dereference leading to a
kernel Oops?

Because struct file is allocated with SLAB_TYPESAFE_BY_RCU in files_init()=
=20
in fs/file_table.c, the file object can be concurrently freed and reallocat=
ed
while an RCU reader holds a pointer to it. During this reallocation process,
alloc_empty_file() calls init_file(), which zeroes out f_inode.

In check_ptr_to_btf_access() in the verifier, the PTR_MAYBE_NULL flag is om=
itted
for trusted fields read from MEM_RCU pointers. This prevents the verifier f=
rom
enforcing a NULL check on the resulting inode pointer. Additionally, the
dereference bypasses the exception table rewrite that would normally handle
memory faults for untrusted pointers.

If a file is closed and reallocated concurrently while the BPF program runs,
could inode be NULL when inode->i_ino is accessed? Is it safe to codify this
pattern as an accept test without requiring a NULL check for f_inode?

> +	}
> +	bpf_rcu_read_unlock();
> +	__sink(ino);
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014173039.3666=
415-1-utilityemal77@gmail.com?part=3D2

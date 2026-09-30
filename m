Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36B4D5963
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775800; cv=none; b=NIfJeNx0ZMK6g+exg7KPRPXRoLzkqzCJyQONCQVaXRWXiptwx3svCUP/HDh0axq44fVRIz9pEw2odG7MNxF4M9o7EsxxVPuDncikUoEAT2lBBHrroTZrisQTLRULF7vGC078GG2JlH7fAJtly4aaAmlsOtNFExocJ143bYCWLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775800; c=relaxed/simple;
	bh=zPHMEvQ3R86ofA+ImCdYZfDXzMyTWt1GZ+fR9Zp+fDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dxou7fgHUlXSvrzAtNUdtIZR6DUF9XP+DdHnlIpN0FnDLsJG/1324nmlRuNuW/mlotc96IdtejjiFnr+3WTWtVbb2syS9Cn7S7S5nxkjJX3qmAwWH73iRzL1X9AU3C2NG2FyjVzo5xoWcaRAcGhntTHAcsEKdn5aaEQxlVgLCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnXcc9/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnXcc9/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F851F000FF;
	Wed, 30 Sep 2026 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775788;
	bh=LPDnYb6fvWl7hd3He+yD0TykIULeFFRP69i2vPA1Y0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnXcc9/cdu5Kz34HUTk/c90O3sOHuLHVQVqzHbYkAP0zxWtifuZcESSOT6QRQ4RvD
	 6kYv9Gant0FyRN5bTb8JohPSKGC7fM2U0f6FJXuBifSWQJxI02XMLB+fUsiHRwa3PR
	 VI5x6HkBGXKhFsbhJsNfLSWPdF5m771C5J41gZuEqGvN5XqCi8OkCA4CKWnE8KF+pV
	 v3ciX6FVSQ9E3Zv/4OrKU4JSjBBeVo3znjNmTITpvUew2KZdAkvzIx28lUHZprGKlJ
	 sBjc38S6i5C9Bt+nCixRqhtMrRnix1XZTCyIUjbB6u/kWMdSsZAf0bwVh7v+24Mier
	 yrabEIQZvCoMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] selftests/filesystems: check that
 OPEN_TREE_NAMESPACE keeps mounts covered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-work-mount-fixes-3-v1-7-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-7-be34c83956ae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:43:08 +0000
Message-Id: <20260930134308.85F851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: open_tree_ns_covered_test fails instead of skipping o=
n unsupported kernels
--

commit a67cc0a2598a800459db0d5c4bf95ad3d7f9463e
Author: Christian Brauner <brauner@kernel.org>

selftests/filesystems: check that OPEN_TREE_NAMESPACE keeps mounts covered

This commit adds a test for open_tree(OPEN_TREE_NAMESPACE) from a user
namespace that does not own the mount namespace it copies from, ensuring
proper behavior of recursive and non-recursive copies.

> diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_n=
s_covered_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tr=
ee_ns_covered_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_cover=
ed_test.c
[ ... ]
> +FIXTURE_SETUP(open_tree_ns_covered)
> +{
> +	char p[PATH_LEN];
> +
> +	snprintf(self->dir, sizeof(self->dir), "/tmp/open_tree_ns_covered.XXXXX=
X");
> +	ASSERT_NE(mkdtemp(self->dir), NULL);
> +	if (enter_userns(getuid(), getgid()) || unshare(CLONE_NEWNS)) {
> +		rmdir(self->dir);
> +		SKIP(return, "test requires user namespaces");
> +	}

[Severity: Medium]
Would it be appropriate to add a capability check here in the
open_tree_ns_covered fixture setup for the open_tree() syscall and the
OPEN_TREE_NAMESPACE flag before continuing?

This would be analogous to the checks performed in open_tree_ns_test.c and
might help avoid false positive failures when automated CI tests run against
older or LTS kernels that lack support.

[ ... ]
> +/* A caller in a new user namespace that doesn't own the mount namespace=
. */
> +static int foreign_child(const char *dir)
> +{
> +	struct stat st;
> +	int fd;
> +
> +	if (enter_userns(0, 0))
> +		return CHILD_USERNS;
> +
> +	fd =3D sys_open_tree(AT_FDCWD, dir, OPEN_TREE_NAMESPACE | OPEN_TREE_CLO=
EXEC);
> +	if (fd >=3D 0)
> +		return CHILD_NONREC_ALLOWED;
> +	if (errno !=3D EINVAL)
> +		return CHILD_NONREC_ERRNO;
> +
> +	fd =3D sys_open_tree(AT_FDCWD, dir,
> +			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC | AT_RECURSIVE);
> +	if (fd < 0)
> +		return CHILD_REC_REFUSED;

[Severity: Medium]
On older kernels lacking OPEN_TREE_NAMESPACE support (or the open_tree
syscall entirely), will this fail the test instead of gracefully skipping i=
t?

When the flag is unsupported, sys_open_tree() returns -1 with errno set to
EINVAL. The first non-recursive call in this function expects EINVAL, so it
silently passes the check. However, this subsequent recursive call also fai=
ls
with EINVAL, which returns CHILD_REC_REFUSED and triggers an assertion fail=
ure.

If the open_tree syscall is missing entirely and returns ENOSYS, it appears
it would fail earlier at the non-recursive call, returning CHILD_NONREC_ERR=
NO.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-work-mount=
-fixes-3-v1-0-be34c83956ae@kernel.org?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408A3ED3B4
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775863; cv=none; b=A7UEyKiiQgJ/Dst0aWbfPQ42eAiSYJkfEsAlgL/pn2MHGbguz5FZd/nHM+MpGT+H4gaCDykui6FkhXNNd3Rz+j6F94NuLg0FNRkZk4qyzcFYN/9jVQNGH20bIDfH6gfNF/KRhxrzgB8EZz1M5eI8TP+4jT9JnpyYXDiQnYWR1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775863; c=relaxed/simple;
	bh=oqDMhLM/C2yIdS4KB2PG64gyN8ObXVY654b6epnwwVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVHE38Omb8uqrEmGoSP2rzs6kIRj1oS85QCtrV+OUP15xvi0SGJH71ntZXR50HCIOArC28K0CE2kUAGAQeYuKFSrG/shPS2Nd14iks/hcggZQzR37myjcYtjdWlW+qx5oPn6Ns1WRd7ltOhRa34R6wLUtPFapT1igC5EL368u+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdNNskWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdNNskWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364141F000FF;
	Wed, 30 Sep 2026 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775849;
	bh=X1OeMG7UpyACBXd416Lt9bj2CnJ5nJJI7vkxMaIUsiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdNNskWF+fHV8fdMVijkAt55NOtWFy5f4B5SIVcSycs58Z4e7/KmyoAiKzX8IUYe1
	 iKikQCtGXevtPN6j2xVNWZQXEXsLHQiGgQaJFuDZk8VcHTeNTCwTn5ROXrYlJDQDep
	 A0E3PmEXgIOg4MhJrDAzgvGOUWsZWYX6bUcSfmcJoVPy++GMnejH35OMZPf4jZ22mp
	 g31m+ULZT0Lm11/PzjiWFl3b2jzz8BScw2bOak62SLUcd6QE8qaxPaFOEd5wf9r2ZB
	 WGqu1zzbly+n80m5jAHBjMtrj0COJTkAu799e7OvOaqUEfpgfQQX0rPwgabaeKlgTD
	 eGl/gpktv0xcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/17] selftests/filesystems: check that a busy submount
 survives a synchronous umount
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-work-mount-fixes-3-v1-3-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-3-be34c83956ae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:44:08 +0000
Message-Id: <20260930134409.364141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: temporary directory leak on early SKIP in test setup
--

commit 02ea3b012fe359abd8677445122fce027a20c695
Author: Christian Brauner <brauner@kernel.org>

selftests/filesystems: check that a busy submount survives a synchronous um=
ount

This commit adds a test for the shrinkable submounts of a synchronous
umount. It verifies that a busy submount will survive a synchronous umount
operation and result in an EBUSY error.

> diff --git a/tools/testing/selftests/filesystems/umount_propagation/shrin=
k_submounts_test.c b/tools/testing/selftests/filesystems/umount_propagation=
/shrink_submounts_test.c
> new file mode 100644
> index 0000000000000..43efb7faf95ce
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/umount_propagation/shrink_submo=
unts_test.c
> @@ -0,0 +1,205 @@
[ ... ]
> +FIXTURE_SETUP(shrink_submounts)
> +{
> +	struct stat st;
> +	char p[PATH_LEN];
> +
> +	self->mounted =3D false;
> +	self->fan =3D -1;
> +
> +	if (geteuid() !=3D 0)
> +		SKIP(return, "test requires CAP_SYS_ADMIN");
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
> +
> +	snprintf(self->base, sizeof(self->base), "/tmp/shrink_submounts.XXXXXX"=
);
> +	ASSERT_NE(mkdtemp(self->base), NULL);
> +	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0);
> +	self->mounted =3D true;
> +	ASSERT_EQ(mount(NULL, self->base, NULL, MS_PRIVATE, NULL), 0);
> +
> +	snprintf(p, sizeof(p), "%s/dbg", self->base);
> +	ASSERT_EQ(mkdir(p, 0755), 0);
> +	if (mount("debugfs", p, "debugfs", 0, NULL))
> +		SKIP(return, "test requires debugfs");

[Severity: Low]
Does this code leak the newly created temporary directory on the host?

If the test skips here due to missing debugfs, the kselftest harness
terminates the setup early and skips FIXTURE_TEARDOWN(). While memory and
file descriptor leaks in tests are typically cleaned up by the OS on exit,
this mkdtemp directory in /tmp persists on the host filesystem across
test runs.

> +	snprintf(self->automount, sizeof(self->automount), "%s/dbg/tracing",
> +		 self->base);
> +	snprintf(p, sizeof(p), "%s/dbg/tracing/.", self->base);
> +	if (stat(p, &st))
> +		SKIP(return, "test requires the tracefs automount");

[Severity: Low]
Similarly, does exiting here via SKIP() leave the mkdtemp directory
abandoned without cleanup on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-work-mount=
-fixes-3-v1-0-be34c83956ae@kernel.org?part=3D3

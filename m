Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78393DB326
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775617; cv=none; b=S3r72mPkIafWdA2Wta2quaXu3IKYjRpdr5Ni8HAuU2+7Homm/HLlASpaeh0acBiEwidqpbOtMRBCzx9XVWpQnYSKUa3c8bfBt8kaYuNFCU/oRb0Z8xwDezZdB9kvDns1ajsXTuZzIxQ9gXHdaduan/nsKIZAeGRs99EzK9h9QnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775617; c=relaxed/simple;
	bh=QrSft6bYjtKgHraRQh5TeRUJkU37SquOsZRTUk9D938=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=buA9ixBjsy5moX6SSE7Q+Lot/4QHG7x4GFPsTUia+PzECYO9AexA+7SCu0wrNFGYbZ/jr8i/UaF636DEqW6oOoz0FBc5lS66On7lR4sTS5TUhx8E0Hb9sHGpxOQO7AJpjYLTs9FjCrvbtCWJGi3jtrQYwJVEan3p7Endpfwqrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU/mNjco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU/mNjco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9030C1F00893;
	Wed, 30 Sep 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775600;
	bh=hU2JH+hsPdja0mAg711IF6/545Wy7AotIaP3B3Q+lvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JU/mNjcoheqjp5XB/JKFQU2l9TNGn5V4pwPzAArjQCukSFrWOlLnTXfhG3rgR2qHo
	 yw87tmLXDsS2qZjEplfQxp1FZSBXvfWsCwt2gPowui+xGAKBwlWkTfbtoAyKaPJbp5
	 IivX+mXETgWiyWYjGUEQswcFeMACrFyEUBySXyJjL6aQ8YmiCQrdLeu2z6sb9iJ0hI
	 FOrmLuYKm4d1jBNO4Fz/u/lTiBt2o1eBrvNRuv60S/J3dRW/uIHxiBTE1Yes1TQ/oq
	 qxnsIRBWRTVRe1uQDKXLkwqJtSgPTS4h7oDj2EidpuJhq87WjYoN8koEjuSm5ETQ39
	 ls28wHUioiacQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] selftests/filesystems: check that a mount
 namespace file on top doesn't bury a mount
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-work-mount-fixes-3-v1-9-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-9-be34c83956ae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:40:00 +0000
Message-Id: <20260930134000.9030C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: test hangs if child unshare() fails due to unclosed p=
ipe
--

commit b1881c835955f20f1fe11ad422bd61758e3f6d5b
Author: Christian Brauner <brauner@kernel.org>

selftests/filesystems: check that a mount namespace file on top doesn't bur=
y a mount

This commit adds a test for moving a mount with a mount namespace file on
top of it. It ensures that when a mount is moved onto a shared mount, its
copy propagates correctly to slaves without being buried.

> diff --git a/tools/testing/selftests/filesystems/mount_cycle/overmount_ns=
_file_test.c b/tools/testing/selftests/filesystems/mount_cycle/overmount_ns=
_file_test.c
> new file mode 100644
> index 0000000000000..c24436a17c0fd
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/mount_cycle/overmount_ns_file_t=
est.c
> @@ -0,0 +1,187 @@

[ ... ]

> +TEST_F(overmount_ns_file, existing_mount_stays_on_top)
> +{

[ ... ]

> +	/* a newer mount namespace whose file can be bound */
> +	ASSERT_EQ(pipe(pfd), 0);
> +	self->child =3D fork();
> +	ASSERT_GE(self->child, 0);
> +	if (self->child =3D=3D 0) {
> +		if (unshare(CLONE_NEWNS) || write(pfd[1], "r", 1) !=3D 1)
> +			_exit(1);
> +		pause();
> +		_exit(0);
> +	}
> +	ASSERT_EQ(read(pfd[0], &c, 1), 1);

[Severity: Medium]
Will this test hang if unshare(CLONE_NEWNS) fails in the child process?

If the child process exits via _exit(1) due to unshare() failing, it closes
its file descriptors. But since the parent process never closed its own copy
of the pipe's write end (pfd[1]), the pipe is not considered closed.

The read() call here will block forever waiting for data instead of returni=
ng
an EOF, causing the test program to hang indefinitely.

Should the parent close(pfd[1]) before attempting to read from pfd[0]?

> +	snprintf(s, sizeof(s), "/proc/%d/ns/mnt", self->child);
> +	ASSERT_EQ(mount(s, p, NULL, MS_BIND, NULL), 0);
> +
> +	ASSERT_STREQ(read_file(b, buf, sizeof(buf)), "Q");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-work-mount=
-fixes-3-v1-0-be34c83956ae@kernel.org?part=3D9

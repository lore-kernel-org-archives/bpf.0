Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF87255F28
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283140; cv=none; b=e0Z+cKV5bzuhbAUtHtuIaIyTYamj9sFqFZm+EuQBoLYOZ15gTCmxrgQCAK8Pdye+n4BDIVMf+tjbexneWovfF+7xJAn9Z26e0QFJT9yYteHdn+2Q9QjN7J22r1n975rgtvv+mPCT63xX4fwIrQHui4zvaeSplb5bRN7r5Ty3oaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283140; c=relaxed/simple;
	bh=OQ9vd3o49sfB5Xb0otvGBh6NSQP6vycxWO1OFRiD9j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AWDbU3yEY7/I88FmrNz3X4Uwl7WR9/cLjuaiC7WW7qXATL8YjJwHTk3OmSpkgNULK0HkREYK9N/o31Oh1MWjd381PLf5G5v/plxntC/cWcbMaU6k0Rq4yzmDjehS8U9TdXpI2+FuZzKXnsqCSfqdC5Z94P/+By1BC4nTk6w611c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hILzrrha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hILzrrha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C4B1F000FF;
	Thu, 24 Sep 2026 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790283138;
	bh=SdHV3Iu+uxUOqNz4Ts2pZMkR38ajwzaoDBpGfB0KJDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hILzrrhaOZHF8EjXx5BuJwxT9rtg6MIVLVXIKPjQBUz34okqOE+NcA7+pKMYfzmzi
	 sVJAx3bwsfkmbnZv9/CBiC2z3/T3a1cCGC4gMaHgn57aSzVeh9+PF/QiwsMSbeCq9w
	 49xic603wS/hzmClig++0Cu5vyfVoexwn6HUj2LvTycIszVZhJmVQLpf3A92s2g16/
	 sp/cCRrNC3LaTeNq3kVo1Fy8FvVQiimA9rCVgSSXnEEHMHCnk8oqJ235U6AUny2BWg
	 3uzDfW91VF5ame8NNScslBtkPMJnNLpa/ESEoow0PlGk114COdGlwuypTUsDT+borc
	 TvjCmoPrl5GVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH vfs v1] bpf: Allow bpf_d_path() from filp_close_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924204226.190315-1-ihor.solodrai@linux.dev>
References: <20260924204226.190315-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 20:52:17 +0000
Message-Id: <20260924205218.04C4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: missing filp_close_sync dependency breaks resolve_btfids and =
selftest
- [Low] bpf: failure to migrate CHECK() to ASSERT_*() when updating selftest
--

commit f620a29b55750df4341321e76f9065c834f91fa3
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Allow bpf_d_path() from filp_close_sync()

The d_path selftest closes its descriptors with close_range() so that
its fentry program on filp_close() runs. The vfs commit
46ace7e4dc4b ("fs: make close_range() synchronous") switched
close_range() to filp_close_sync(), so the program still attaches but
is never called. This commit allows bpf_d_path() from filp_close_sync()
and updates the selftest.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..09a27810ca27f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -972,6 +972,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, filp_close_sync)

[Severity: High]
Does filp_close_sync exist in the current tree? Since the referenced VFS co=
mmit
(46ace7e4dc4b) might not be present yet, adding its BTF ID here will break =
the
kernel build during resolve_btfids due to a missing dependency.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index 1a2a2f1abf033..7665e1d28a641 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
[ ... ]
> @@ -165,7 +166,7 @@ static void test_d_path_basic(void)
> =20
>  	if (CHECK(!bss->called_close,
>  		  "close",
> -		  "trampoline for filp_close was not called\n"))
> +		  "trampoline for filp_close_sync was not called\n"))

[Severity: Low]
Since this CHECK() macro in test_d_path_basic() is being modified, shouldn't
it be migrated to the modern ASSERT_*() macros? BPF subsystem guidelines re=
quire
replacing deprecated CHECK() macros when updating existing tests.

>  		goto cleanup;
> =20
>  	for (int i =3D 0; i < MAX_FILES; i++) {

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/test=
ing/selftests/bpf/progs/test_d_path.c
> index 561b2f861808e..edb5494a47f74 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat=
 *stat,
>  	return 0;
>  }
> =20
> -SEC("fentry/filp_close")
> +SEC("fentry/filp_close_sync")

[Severity: High]
Will the test load fail unconditionally here? Attaching a BPF program to
fentry/filp_close_sync when the function doesn't yet exist in the tree will
cause an error. Applying this patch without its VFS dependency introduces a
cross-tree dependency failure regression.

>  int BPF_PROG(prog_close, struct file *file, void *id)
>  {
>  	pid_t pid =3D bpf_get_current_pid_tgid() >> 32;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924204226.1903=
15-1-ihor.solodrai@linux.dev?part=3D1

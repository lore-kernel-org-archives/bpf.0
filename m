Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B12F6586
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711497; cv=none; b=AmFKi36qa63NavaZBSlYqfkH9Gwb1ZWF3Nb7q9H91lkFTATXoTg93hLY6Oj2hVlKiCfAiZdtcod5fCSNCa74L3DZgqO54tC2ElhAduao4lAwP4XlD5qdh0H9dkvbCSKt/osC5KD7q17PzmAsNRxYF/GFb92XLJpAMRWN3Lp3U08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711497; c=relaxed/simple;
	bh=6As943DaH6GWJIsfJooLi3Gr/B9sktdFOk9vN/aRvcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dO6JwqZLR0/yI36nIvBJoEHjY3LKBmMG7gCdpf+dnJtqGwBIwt3LQlTICdUX48hYXEpu4fO9RyZpMEM+oz75KPK4bZUkTLitYLbSlSZC4goeVykgn7vmU3TFV3877LLDypEVGwTEsLSAQMDCfpP1OEz9+FdW5nOaP2lDm9r36VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9soT7wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9soT7wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FE71F00A3A;
	Sun,  6 Sep 2026 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711496;
	bh=059Xf1CaIVfnMTole34Pv5xKtm1Z/wiB1WRJqBA1czI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9soT7wJrt5sQAkC74EsuEQyu7fp37CCB8f0O7WsmeCqR02yLg7Dz298sH/UA4YYZ
	 rVzBxuZgmVJXR6WTTC4PqtN29NH6tKIs1zS6iais3INbUE7NJN4912QhIKL97syChU
	 qU4EjwWQfczk9u8UmNTo60b0+hTY9yeuTZhM3FzQe6uNg1kUbp6xhRgCgqPhK6J2cD
	 BQY2K6prWH2hp1It0lENgvAAFcX6GNI8Tbri9eumkTB+z8Mbq4YC2IyZwK7jkxVsRs
	 Y3SMdKn4y3+rPNGakZm2KmUpUiQc3EoOnOpYaxKAdSvggZBhiHpWeBB6Pp+0RU9QUG
	 i71bk792SVo1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover recursive bpftool
 map dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <178870998583.979169.18178382250623407398@tychen.cc>
References: <178870998583.979169.16526173782819097354@tychen.cc>
 <178870998583.979169.18178382250623407398@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:18:15 +0000
Message-Id: <20260906161816.53FE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Lowering RLIMIT_NOFILE without closing inherited FDs from the te=
st runner creates brittle test execution.
- [Low] Multi-line comments do not follow the BPF subsystem standard (openi=
ng `/*` on its own line).
--

commit bfea95162d84a988e16f2cd61621377edfd83849
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Cover recursive bpftool map dumps

Exercise recursive map dumping for array-of-maps and hash-of-maps,
including shared inner maps, empty outer and inner maps, BTF-formatted
values and multiple selected roots.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> index 0000000000000..330a3344770d1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> @@ -0,0 +1,419 @@

[ ... ]

> +	/* Compare the complete JSON document: a flat array with the root first,
> +	 * one copy of the shared inner map, and unchanged entry representation=
s.
> +	 */

[Severity: Low]
Does this follow the BPF subsystem multi-line comment style? The opening
/* should be on its own line:

/*
 * Compare the complete JSON document...

[ ... ]

> +	/* Select the first inner map and both outers as roots. The other inner
> +	 * map must be appended after all three roots, even though it is found
> +	 * while dumping the first outer. A process-specific name avoids other
> +	 * tests' maps joining the selection.
> +	 */

[Severity: Low]
Does this follow the BPF subsystem multi-line comment style? The opening
/* should be on its own line.

[ ... ]

> +	/* Every key is enumerable, but PERF_EVENT_ARRAY lookup returns
> +	 * ENOTSUPP (the kernel-internal errno). Check both entries so an
> +	 * early exit on the first lookup failure cannot pass.
> +	 */

[Severity: Low]
Does this follow the BPF subsystem multi-line comment style? The opening
/* should be on its own line.

[ ... ]

> +	/* Create all fixtures before lowering the limit, and keep the test
> +	 * runner's limit unchanged. Retaining every discovered FD would exceed
> +	 * this limit before the recursive dump could visit all inner maps.
> +	 */

[Severity: Low]
Does this follow the BPF subsystem multi-line comment style? The opening
/* should be on its own line.

> +	pid =3D fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out;
> +	if (!pid) {
> +		close(outer_fd);
> +		if (setrlimit(RLIMIT_NOFILE, &limit))
> +			_exit(1);
> +		snprintf(command, sizeof(command), "%s -r map dump id %u",
> +			 json ? "-j" : "", root_id);
> +		if (get_bpftool_command_output(command, output, 65535))
> +			_exit(2);

[Severity: Medium]
Will this sequence cause sporadic test failures if the parent test runner
already has 32 or more file descriptors open?

Since the child process inherits all file descriptors from the parent,
lowering RLIMIT_NOFILE to 32 here leaves no available file descriptor
numbers if the parent already holds >=3D 32 descriptors (which is common
when running the full test suite).

Later in the block, get_bpftool_command_output() relies on popen(), which
needs to allocate new descriptors for a pipe. If no descriptors are
available, opening the pipe will fail with EMFILE, aborting the test
prematurely.

Should the child process explicitly close all inherited file descriptors
(e.g., using close_range(3, ~0U, 0)) before calling setrlimit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178870998583.979169=
.16526173782819097354@tychen.cc?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D16318146
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665278; cv=none; b=fifPAZ6t1Uzchd8OicpX9x3Yc4j7/QHEdLPK4bmgCO5E6t+q+myiHjFydi6N5005rVNDlSuDdSSs+a3MmORHWYD7yM1HjxtJpwIY4wwuWb9SxFooZ+sjvOwo88go46x0uYeAtZvm8VdIJmopwPEeG4HDFPY9wP4bqPNswX1yJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665278; c=relaxed/simple;
	bh=YFPZ3ZBsncP8SjqMWsOzxjGbN+ujof/zBkMfqW3EhJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ektaYklvhQTaR7FCEmd3cY7Oq7awtq6z/D1bryD0xMwvBTT/j00h57Sn9mTWWXYd4O06KNmOEJHBSrQ6Xs5fjetK1Y69ZZrIynB9UKnIN4qa8VNYx1dtN85Db8k7VG+HlrAvSzDRWAy/lDhlwGhflBH1I2zzBqrSD535A1ykZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzUYymcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzUYymcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6065E1F00893;
	Fri,  5 Jun 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665277;
	bh=5qVeNwuv1X9NADSD1LO58Adv6MheHEXHZNbHOUq/01s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzUYymcLiWrh3XHheP1cFfGFMd4KkjxROPjSyBjo3sjDSQ3HRqVwE+K2xCDCEYSGh
	 TPR3iTaSlnhaack1cuuBRh7dmB7+4ePI9oSKI8O7+ijg5BlwfDxiLayQZp/rSp1aCL
	 oYmuPw9268tN0AWT4Q2vq+9P5NKZ1XTK1/sjN+Jx0lPLbTRHqSPANih7WSh3IpmCEG
	 VR30Px32yHG+bXxtAfvYscaN0mXQVhD0R+HtVuBsC8l1R2rNiDWP/jxcsVz1XtXDHi
	 lK3QWPurl0NPBKVoUQ2NWECGk7PTSPx7ccCqJLnYjKfI1erZKbUIphVOVOXrDMckcr
	 SzeyelmqFzEXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Run test_perf_branches more
 than 1 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maya Matuszczyk" <mayamatuszczyk@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605130601.2699172-1-mayamatuszczyk@google.com>
References: <20260605130601.2699172-1-mayamatuszczyk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:14:36 +0000
Message-Id: <20260605131437.6065E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing memory barrier due to discarded atomic result in BPF pro=
gram.
- [Low] The newly added multi-line comments violate the BPF subsystem comme=
nt style guidelines.
--

commit 0f17d761030fbe911f483b7b808f059931d7d390
Author: Maya Matuszczyk <mayamatuszczyk@google.com>

selftests/bpf: Run test_perf_branches more than 1 time

This patch modifies test_perf_branches to retry until a valid sample is
obtained, rather than failing if the first sample lacks branch data. It
introduces an atomic coordination mechanism between the BPF program and
userspace to wait for the event.

> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c

[ ... ]

> @@ -85,19 +76,35 @@ static void test_perf_branches_common(int perf_fd,
> +	/* Make up a bunch of branch events until we time out or bpf prog sets =
a flag
> +	 * that it caught a valid event. To be completely sure that required_si=
ze_out,
> +	 * written_stack_out or written_global_out writes and reads won't get
> +	 * reordered by anyone in a way that would fail this test, use atomic
> +	 * operations
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF
subsystem style guidelines? The BPF guidelines typically require the
opening /* to be on its own line for multi-line comments.

> -	for (i =3D 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; +=
+i)
> +	for (i =3D 0; i < 100000000; ++i) {
> +		/* This technically should be an atomic load with acquire
> +		 * ordering, but we don't want to clog up memory bus while
> +		 * spinning
> +		 */

[Severity: Low]
This isn't a bug, but this comment also places text on the same line as
the opening /*.

> +		if (READ_ONCE(skel->bss->valid) > 0)
> +			break;
>  		++j;
> +	}

[ ... ]

> @@ -175,6 +184,18 @@ static void test_perf_branches_no_hw(void)
>  void test_perf_branches(void)
>  {
> +	int err, duration =3D 0;
> +	cpu_set_t cpu_set;
> +
> +	/* Pin ourselves to cpu0 so that all branches we generate would be
> +	 * also on cpu0
> +	 */

[Severity: Low]
This isn't a bug, but the opening /* should be on its own line here as
well.

> +	CPU_ZERO(&cpu_set);
> +	CPU_SET(0, &cpu_set);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/too=
ls/testing/selftests/bpf/progs/test_perf_branches.c
> --- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c

[ ... ]

> @@ -40,14 +37,14 @@ int perf_branches(void *ctx)
>  	written_global =3D bpf_read_branch_records(ctx, fpbe, sizeof(fpbe), 0);
>  	/* ignore spurious events */
>  	if (!written_global)
> -		return 1;
> +		return 0;
> =20
>  	required_size_out =3D required_size;
>  	written_stack_out =3D written_stack;
>  	written_global_out =3D written_global;
> -	valid =3D 1;
> +	__atomic_add_fetch(&valid, 1, __ATOMIC_RELEASE);

[Severity: Medium]
Will this actually provide the intended release barrier? Since the return
value of __atomic_add_fetch() is discarded, the Clang BPF backend optimizes
this to a relaxed BPF atomic add instruction (without BPF_FETCH).

On weakly-ordered architectures like ARM64, this generates an instruction
that lacks release semantics. Could the CPU reorder the stores to the output
variables to occur after the store to valid, allowing userspace to
observe valid > 0 but read stale data?

> -	return 0;
> +	return 1;
>  }
> =20
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605130601.2699=
172-1-mayamatuszczyk@google.com?part=3D1

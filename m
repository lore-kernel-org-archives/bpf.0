Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FD41B35D
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655472; cv=none; b=iwmxky7Y2u1lnJQhn0hi3K6CJpDqNbiuqRH+BsAr4Vv67avePxQ+OzKNbTSJ2iQs6uQGRgTWKc0S89LQ52K0n5QReNXAh+7kjMuUmJy0XjMEQgcDEhy8eaac/985Ti8XOHC/qoGXfYFD+FvHUNOmfyPPRNszHf9FvStB8bhgnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655472; c=relaxed/simple;
	bh=nKP86u6QALSKLKK1kCP/ux1DnrpOGG1lDJi0J2BspHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZ+X4mR8FyNc4q/i0HUdwpc8vZMep0/36pdoBckqb2HMgt6DeeVi/JXXE6qNbLI4XzuB8gnuKTGILFfK4CGyrQEBQ8AbWT7xjGNXWK0olRFWmExNRCLsB1QHXgDIrMMaspAA7gDhEz0BIEw82Ge5gNsloO9t65Sm9SSv6Yvhey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUJhgf5U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUJhgf5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EE3C2BCC4;
	Fri,  1 May 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777655471;
	bh=nKP86u6QALSKLKK1kCP/ux1DnrpOGG1lDJi0J2BspHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CUJhgf5UWhB14/gf1VfDPUyLdQTDUN2mMopQo2Vb+MBxJgwfBS0QobNMz4jvzyZD+
	 nrlJ9JB+KzDMpksh5cHZA+PRpOwn90lbN3A2thfu1ssKjooG3Mgdo/4uuw/wxrbVZk
	 zORot3SoOq5mYFrn+IYmEFSMsURjvSwTXlVXkzAThWKLXiwQzsXLh4ttrTDsugkPz1
	 bEHbpRUmbUJbz4cP53NSp5D8u7TQPqmY8qu5RK76e9M7pA8XbxqGX59fjQu1gJtD8v
	 qhNx5whLYzA6koSKUt/gxC09k0quqJoryDQ99Q3zRbIT/JOzkOARfFukEm57jjmCMT
	 jg0Xrj66N78YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2 v3] selftests/bpf: Test LINK_DETACH for
 perf link
Reply-To: sashiko@lists.linux.dev
To: "Florian Lehner" <dev@der-flo.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501160901.224134-3-dev@der-flo.net>
References: <20260501160901.224134-3-dev@der-flo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 17:11:11 +0000
Message-Id: <20260501171111.B2EE3C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_perf_link_detach` test verification is brittle and lik=
ely to falsely pass, as a single call to `burn_cpu()` is too short to guara=
ntee a perf event tick.
--

commit 80a1776d4374467cf1d037c1e22a1252e27c885c
Author: Florian Lehner <dev@der-flo.net>

selftests/bpf: Test LINK_DETACH for perf link

This commit adds a new test, test_perf_link_detach(), to verify the
BPF_LINK_DETACH syscall path for software perf events. It creates a link,
verifies execution, detaches it, and checks that the program is no longer
invoked.

> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
> index 9e3a0d217af8..b75112c1b67d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c

[ ... ]

> +void test_perf_link_detach(void)
> +{
> +	struct test_perf_link *skel =3D NULL;
> +	int pfd =3D -1, link_fd =3D -1, err;
> +	int run_cnt_before, run_cnt_after;
> +	__u64 timeout_time_ns;

[ ... ]

> +	/* detach via BPF_LINK_DETACH - BPF program should no longer be execute=
d */
> +	err =3D bpf_link_detach(link_fd);
> +	if (!ASSERT_OK(err, "link_detach"))
> +		goto cleanup;
> +
> +	/* make sure there are no stragglers */
> +	kern_sync_rcu();
> +
> +	run_cnt_before =3D skel->bss->run_cnt;
> +	burn_cpu();
> +	run_cnt_after =3D skel->bss->run_cnt;
> +
> +	ASSERT_EQ(run_cnt_before, run_cnt_after, "run_cnt_detached");

Is a single call to burn_cpu() sufficient to guarantee a perf event tick he=
re?

The software CPU clock perf event is configured in perf_link_setup() to sam=
ple
at 1000 Hz, meaning it triggers approximately once every 1 millisecond of C=
PU
time.

The burn_cpu() function executes a fixed loop of 1,000,000 iterations. On
modern CPUs, this loop often takes significantly less than 1 millisecond to
complete.

Because a single burn_cpu() invocation takes less than the 1ms interval, is
it possible that no timer interrupt occurs during this window?

If so, run_cnt_after would equal run_cnt_before even if the detach operation
failed and the program was still attached, causing the test to falsely pass.
Could this be changed to use a time-based loop (similar to the initial
execution check) for several milliseconds to ensure correctness?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501160901.2241=
34-1-dev@der-flo.net?part=3D2

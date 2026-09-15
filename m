Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C973B14BA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474365; cv=none; b=fB4bqX3aGsRvaNERcbA/SP9xvprzzspCe3BlAq6R1Y8sn8qYCLsKnhAT1rnbP0kKLDniCtlDDLJ7NuM2sqNzmIRb0MwI+Z0psattk3uaYaS8r8mxzcyEgo4bSwK5VCQ8fbkVTc0d6Qz5xy75hh5OVJgGMjlYUmquZqUvB/71lcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474365; c=relaxed/simple;
	bh=2OpOgRhr1ccoySSxN8EYjy4zj9zCijvFJQ0v1Tm3GSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGaz19mBgFFyCoCxT+2j0EKI4DTwl8NYkoBYkcRvlg4DmrPM739UGHAVOouETThtVDzSUAgniPUge/ROXvPu+XIeH5fbfEIHB2s0Lqy9112c60ZspF6ZZ6PUgq7q5EZJW74YbXVgd3TDq/YMRTxqvWdY0ul7Ou0WGFlt3bX6LY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuBnekeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuBnekeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE73D1F000FF;
	Tue, 15 Sep 2026 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474364;
	bh=DRozbcZWAixvnlzYRQDIHErvr56og/8DYTUxS8EuEig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuBnekeh3KO1jKIsm1eYsISXuJxEarMjsUpsDoti2Yr9qwHbd9gjrl3RBkIGE2JSl
	 1jhzvLnucGKxUEhBMqrYKni3i/FTtAq/Nde03fBAleKvY9RXOsAS4DnatKBPHeez1P
	 6FjY78KwLKO4njQhcZTSw35f48Tjuv4RhMhv/k9CqoDDp5U6g4k6xZKCe0zTqScJmJ
	 tZ8VD7v03j1q9e0xyPlLiihJifCn5Zw+cSUVp2hw9jwIbAGAC5x4m+zkRBUBcIMFg+
	 c+Ipolj1a3YE76mG+05flR0NReKHL5gOVgztW0gTi6sELihzXlaSe7a/uIs10q99Fu
	 E6iWEvol9IQ4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Add tests for
 bpf_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915114240.3269184-3-puranjay@kernel.org>
References: <20260915114240.3269184-1-puranjay@kernel.org>
 <20260915114240.3269184-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:12:43 +0000
Message-Id: <20260915121243.CE73D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing acquire memory barrier in wait_for_callbacks() caus=
es test flakes
--

commit 94884d64c04d541a6330ac72dab6a74a056c422a
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add tests for bpf_call_rcu()

This commit adds test coverage for bpf_call_rcu(), verifying the callback
behavior after a grace period, including proper map, key, and value
recovery. It also includes negative tests for invalid usages.

> diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/te=
sting/selftests/bpf/prog_tests/call_rcu.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
> @@ -0,0 +1,212 @@
[ ... ]
> +/* call_rcu() is lazy on a CONFIG_RCU_LAZY kernel, so allow well over on=
e grace period. */
> +static bool wait_for_callbacks(struct call_rcu *skel, int expected)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 3000; i++) {
> +		if (READ_ONCE(skel->bss->callbacks) >=3D expected)
> +			return true;

[Severity: Medium]
Does the poll condition here need an acquire barrier to prevent test flakes
on weakly ordered architectures like ARM64?

The BPF program reclaim() uses __sync_fetch_and_add() (which acts as a
release barrier) to update the callbacks counter after writing to cb_key,
cb_val, and cb_max_entries.

Since READ_ONCE() only provides a volatile read and control dependencies do
not prevent speculative loads from being reordered on ARM64, the CPU might
fetch the shared variables before seeing the updated callbacks flag.

Could this cause the subsequent ASSERT_EQ checks in test_call_rcu_run() to
fail by reading stale values, and would using smp_load_acquire() (or an
explicit barrier) be more appropriate here?

> +		usleep(10000);
> +	}
> +	fprintf(stderr, "callbacks: got %d want %d\n", READ_ONCE(skel->bss->cal=
lbacks), expected);
> +	return false;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915114240.3269=
184-1-puranjay@kernel.org?part=3D2

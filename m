Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2C2DAFCC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341819; cv=none; b=GUyVehHsywWHqD5sP3jBeQdQdnBC6A5TS005SU+THB18vwKZUifkmOH8p+ZElxxEbAPcps9jmgWKAgkQTGBUBsR7lafB+M7kdYrrSYxp8FKo73m1uhPG5PycbSdT7nxFDgdQc08/RLQAkp91giZia9EaWh/LvLMGByUuHLphZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341819; c=relaxed/simple;
	bh=68hfuyCxi7qxZzfJ1OS66wyBIWZXAy1dYK1tQGa1ME8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ox3xtdbqXxB/Bd2m3K0WSwj1pTBXfIDApKULfSzoJpaaj3uNGs/RrNPc1N5W1C/DT7UPfydAi4Rc633OulhSkXMEL8UDIuTi+ZHWks06Iz26cz8nzCiYdhfzN/S1E/o0Dn5oP0vDQthJyv/A5iAfzLNWyjQuzmxEeaDg4i/MOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH9dzjsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH9dzjsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D1EC19425;
	Tue, 28 Apr 2026 02:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341819;
	bh=68hfuyCxi7qxZzfJ1OS66wyBIWZXAy1dYK1tQGa1ME8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aH9dzjsPYtkzt37OhWpak9P2A9bvcZq7608racs+Tyow55r/ei8ArmoWedNqr9LgD
	 V2wwjFrbNeKZiTGtZRuYB3nJ7JTVri/kf7hSNrNwuX7OKAVm1mCDGdygLUxEOqye1e
	 14Er+RWI+YRxCLxAJv+tKYieVk5ivltOj2kXPoAaAYZwmde+6mWbuTMrYDLJuvAr5S
	 9HqciD5ghvqcjHcPF4IFYvOZTZ+RdiKvXZq2AP9QT1IGp6TSFSctFnHQIek2bjkKvE
	 WADgdketbb5RIorGD+PSLzbJnDCDGRA3klWZTSjjqVz/RWmU/e83ap6TWgO9fbZPXH
	 /OCcv/Ao4xJ6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add XDP load-balancer
 benchmark run script
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-8-puranjay@kernel.org>
References: <20260427232313.1582588-8-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 02:03:38 +0000
Message-Id: <20260428020339.45D1EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Any extra arguments passed to the script are silently ignored be=
cause `"$@"` is used incorrectly inside the `run_scenario` bash function.
--

commit eb02fb82c543ffe6f8607af5eadc8ba489f2fb53
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer benchmark run script

This commit adds a convenience script to run 24 XDP load-balancer scenarios.
It formats the benchmark results as a table displaying the median, standard
deviation, and 99th percentile.

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh b/too=
ls/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
> new file mode 100755
> index 000000000000..f65cf46214a3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh

[ ... ]

> +function run_scenario()
> +{
> +	local sc=3D"$1"
> +	shift
> +	local output rline
> +
> +	output=3D$($RUN --scenario "$sc" "$@" 2>&1) || true

Does this silently ignore extra arguments passed to the script?

In bash, "$@" inside a function evaluates to the arguments passed to that
specific function, not the global script arguments. Since run_scenario is
called with exactly one argument ($sc) throughout the script, shift will
consume it and leave "$@" empty.

Should the script's global arguments be passed explicitly to run_scenario
when it is called, or should the script store its arguments in a global arr=
ay?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D7

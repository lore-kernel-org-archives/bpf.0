Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB611925BC
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706583; cv=none; b=apfuvUPhN1hzpEBjRWcfpzLPoKtoUBgg6cJdUSutkA0M5jAphEUqmjht+OQQWc4hVLVJEXOMq7p4fY0ro3IiNWk6pv5xKMJjxuDkzegxi/HyEOMSVH6CP3l8tIY9998U2R+dp7fzAh6XeiRpk1MBEBM+YM85l2lnx6TdFynTf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706583; c=relaxed/simple;
	bh=G9iy6+rds6i3vDF5cHFjUKEqnJhNg687DO3t/F7RUjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXn7JiAWDjZ7M/p2b70JrJQh8MuHJRSc6p3SGUC/tm+5n5V52Ms8l9RpguQAS6gzKfv9kZJ7rlp64ABtRG3D/3KJ5WL5VX3NGHRVlVnm0EwoBcoJNQ4Y05pfyuTiBmtVG6194Ygt/iZN6QX3fLAkqxHNcOuj9uOsG9uj47HWNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZrylUoc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZrylUoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B2C19425;
	Mon, 20 Apr 2026 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706582;
	bh=G9iy6+rds6i3vDF5cHFjUKEqnJhNg687DO3t/F7RUjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EZrylUoc45Y60Q3kfel4lolbzxbu99chRPur/4qrHaazeiWCVDRcXarfegisR997m
	 nrDegZREpm/Fj/7fhjcBY/S+ND4y7wA95Wupfh83uH8u6Aahc9MNlj9uEl62GqZ0N5
	 qy4COsRDynmNhaKvc7a2ST0DKKa+85pJk4+WVdPMuWKpzaQm+pbh6AdpLAaaVFzPdv
	 xX0c6gsS+YEhdR9mWZzDAn/KHOYTHm0dxyUoVF18fzs6USsFlkR6p7MCAUwxA0ZHJH
	 zZhomlCX41aygkHCsQOdM9hRAhE8UJKp7/SalQwjXm5TnFRW3KIos6J0y2J99dfEQl
	 LixJI1FGj43SA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 6/6] selftests/bpf: Add XDP load-balancer
 benchmark run script
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-7-puranjay@kernel.org>
References: <20260420111726.2118636-7-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 17:36:22 +0000
Message-Id: <20260420173622.B99B2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script's error handling is bypassed by `set -e` if the bench=
mark tool fails.
--

commit 676755d117c703df4634ef7adbb680cae370c16a
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer benchmark run script

This commit adds a convenience script to run all 24 XDP load-balancer
benchmark scenarios. It executes the benchmarks and formats the results
into a table displaying median, standard deviation, and percentiles.

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh b/too=
ls/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
> new file mode 100755
> index 0000000000000..1bde3898dfb63
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
> @@ -0,0 +1,84 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail

[ ... ]

> +function run_scenario()
> +{
> +	local sc=3D"$1"
> +	shift
> +	local output rline
> +
> +	output=3D$($RUN --scenario "$sc" "$@" 2>&1)

Will this assignment cause the entire script to abort immediately if the
benchmark tool fails?

Because set -e is enabled at the top of the script and output was declared
separately as a local variable on the previous line, this assignment
evaluates to the exact exit status of the command substitution. If the
benchmark tool returns a non-zero exit code (for example, due to an
unsupported XDP feature), the script will terminate right here.

This appears to bypass the intended error handling fallback below that prin=
ts
"ERR". Would appending || true to the assignment ensure the error handling
block can execute as intended?

> +	rline=3D$(echo "$output" | grep '^RESULT ' || true)
> +
> +	if [ -z "$rline" ]; then
> +		printf "$ROW" "$sc" "ERR" "-" "-" "-" "-" "-" "-" "-"
> +		return
> +	fi

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D6

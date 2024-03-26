Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A013C9A2
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470117; cv=none; b=ZYVz4mm+MGGccXD1JT10JTwQ8GjrQrpQJbfV/sfv2E/hLS82lcyRYghbgK80VJuzJL9VpbO+FoJg81tnVP25dp2nAnptdT8QqEum8OHqwk3Sa2UqTsCuEKdIYxoo12IJcNAs0Huc4CHGCcN66VX4/YTuLN4yctpwBrsuZbc/XJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470117; c=relaxed/simple;
	bh=yu/XkQfjJCrvCRiekVibtKPC5Joq22HsUXZCzsfhUwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nw3EhMUzfZGIsF6bi+mwMokImf05W7rwePxZgc5frOV06KAOpIl5Re/WCy80HkC/OMk9TOqErURBZqcm4NDEEXJt67BVM0+MZ+ZRST0k1BoeVO0MeCvO8OWMr3tDPWsQZJIQuPsmAbbZceY76JBX57W+w8+YQ5BnkfCbfnWEoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4SYO2Bl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4SYO2Bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7BCC433C7;
	Tue, 26 Mar 2024 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470116;
	bh=yu/XkQfjJCrvCRiekVibtKPC5Joq22HsUXZCzsfhUwo=;
	h=From:To:Cc:Subject:Date:From;
	b=e4SYO2BlAW5IddD+Ldd9nmP5aRoOc7EnYyBuJbsQLhzRokQ9ft6d6Ek82DsLhUgo+
	 RCLeANI+qLBFj/mdStyNa1PG6MLk269aJ3ugrQ/3TfIXrZ6vyoPgnk5QjCihAh85qc
	 v/HX5Fj6LTl0CmG9WgB7JlcezCy4qWn0zYk+bsvpc/3RRZxZHK+uP+yvrs8shM8++X
	 I9pMIvH7LjuNV5JvVUJsRrLAFrBrZfDW5KOJA0iDMoEEn53QZLIMCa8KdbbmohqiTi
	 0fxYiZ1ichwQUDuBpFAjscyHaSYb6zJdclfp+XVQS1+t6IuV6AW8u9Lh0iQyVlJlQ7
	 Naea9OrACeaqg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/6] bench: fast in-kernel triggering benchmarks
Date: Tue, 26 Mar 2024 09:21:45 -0700
Message-ID: <20240326162151.3981687-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove "legacy" triggering benchmarks which rely on syscalls (and thus syscall
overhead is a noticeable part of benchmark, unfortunately). Replace them with
faster versions that rely on triggering BPF programs in-kernel through another
simple "driver" BPF program. See patch #2 with comparison results.

raw_tp/tp/fmodret benchmarks required adding a simple kfunc in kernel to be
able to trigger a simple tracepoint from BPF program (plus it is also allowed
to be replaced by fmod_ret programs). This limits raw_tp/tp/fmodret benchmarks
to new kernels only, but it keeps bench tool itself very portable and most of
other benchmarks will still work on wide variety of kernels without the need
to worry about building and deploying custom kernel module. See patches #5
and #6 for details.

v1->v2:
  - move new TP closer to BPF test run code;
  - rename/move kfunc and register it for fmod_rets (Alexei);
  - limit --trig-batch-iters param to [1, 1000] (Alexei).

Andrii Nakryiko (6):
  selftests/bpf: rename and clean up userspace-triggered benchmarks
  selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
  selftests/bpf: remove syscall-driven benchs, keep syscall-count only
  selftests/bpf: lazy-load trigger bench BPF programs
  bpf: add bpf_modify_return_test_tp() kfunc triggering tracepoint
  selftests/bpf: add batched tp/raw_tp/fmodret tests

 include/trace/events/bpf_test_run.h           |  17 +
 kernel/bpf/helpers.c                          |   1 +
 net/bpf/test_run.c                            |   8 +
 tools/testing/selftests/bpf/bench.c           |  33 +-
 .../selftests/bpf/benchs/bench_trigger.c      | 391 +++++++++---------
 .../selftests/bpf/benchs/run_bench_trigger.sh |  22 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 .../selftests/bpf/progs/trigger_bench.c       |  68 ++-
 8 files changed, 314 insertions(+), 228 deletions(-)

-- 
2.43.0


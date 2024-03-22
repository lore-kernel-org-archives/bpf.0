Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE753C38
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065650; cv=none; b=lX+v3ozG68cEFIZ7wKOuX+oFipRoNSt4txcDMd9YQyEr1RWMR0+KcdWFlzB4UxEwhzKlG6a6h1d//DZ1zZ2mZ8Y1up+BVmzvUJ/DYUgIxeAPg2f8lX6/Q4rl6VRj/WRVjHoUnb8jQiOo4AYB8z+l1s1l9cPhO1fJ21/dpCTxsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065650; c=relaxed/simple;
	bh=yakbgmYpgyYqiWclKwI6Xh8fBThso/tZTFeQei4tdTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLE6wjIeItAE6+60e285Uf05ZV64wAwrGuU/GWQmJqc6AKI0Nsj57igHO0QtS61VrLz3hXLeJ55i/Nlfytcqa3/YhPKMLL7d0aTlyowTMizVl+1hjDNtJRRnSTCaDkFJ17CKxxUGD3yPIiy60OEODpVB+yQJU29EloqyUMnvRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFGCxRdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFGCxRdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D179C433C7;
	Fri, 22 Mar 2024 00:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065650;
	bh=yakbgmYpgyYqiWclKwI6Xh8fBThso/tZTFeQei4tdTk=;
	h=From:To:Cc:Subject:Date:From;
	b=uFGCxRdTc5P586dth1MyLPw2VZ3EDy5bvNAjlnVenQc2RSSab68Kas6iMz1afGlKw
	 oGG+1KYmpKMh4woveqa5QcYwgc2zGblaAacQ6EI6woIFB8aM/t4d0CKKkeFP3SOlJ1
	 Gz4Lh0YzTdUNiNeXb9ybeUkI6jOfbmdrZRhIzKJTAnEYU7njHrr/YxmGBXxzu9bmrX
	 NbFjWylLHxezNl3IXDX89x7UEJfp1tXIdQ/UmX5Inb/JFtpozlPP3zLJeQHgN146fU
	 YhVyjJjV4TxKtUTaiwVYk0igHkOKljvIdaFxJVCTTbgaa9aiXir0DV8ycXvp8Ir7VN
	 nvJMapJxnt1YA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/6] bench: fast in-kernel triggering benchmarks
Date: Thu, 21 Mar 2024 17:00:35 -0700
Message-ID: <20240322000041.2919948-1-andrii@kernel.org>
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
able to trigger a simple tracepoint from BPF program (plus we also mark that
function as allowable for fmod_ret programs). This limits raw_tp/tp/fmodret
benchmarks to new kernels only, but it keeps bench tool itself very portable
and most of other benchmarks will still work on wide variety of kernels
without the need to worry about building and deploying custom kernel module.
See patches #5 and #6 for details.

Andrii Nakryiko (6):
  selftests/bpf: rename and clean up userspace-triggered benchmarks
  selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
  selftests/bpf: remove syscall-driven benchs, keep syscall-count only
  selftests/bpf: lazy-load trigger bench BPF programs
  bpf: add bpf_test_tp() kfunc triggering tp and allowing error
    injection
  selftests/bpf: add batched tp/raw_tp/fmodret tests

 kernel/bpf/bpf_test.h                         |  34 ++
 kernel/bpf/helpers.c                          |  13 +
 tools/testing/selftests/bpf/bench.c           |  33 +-
 .../selftests/bpf/benchs/bench_trigger.c      | 388 +++++++++---------
 .../selftests/bpf/benchs/run_bench_trigger.sh |  22 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 .../selftests/bpf/progs/trigger_bench.c       |  68 ++-
 7 files changed, 332 insertions(+), 228 deletions(-)
 create mode 100644 kernel/bpf/bpf_test.h

-- 
2.43.0


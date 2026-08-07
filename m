Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015F3C3C07
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135517; cv=none; b=L6IkydyqczBwzn7tfD65zVlZOgUi5sPTBhBvwCel426HKYmxlz2UhiBDlWs+EWlJ+AtnuiX7yZqh4JD53AoyzTimo/bSfixIMGwG5U/4QyDLBEzew1dKf5J3f6ijXLm7FJju3yzThx1eAdbsT+8zrKbOLCwfhbXCTA0aMV66JIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135517; c=relaxed/simple;
	bh=WazOmSMLsp94BokIaqiLxKuVNaoqgCFklh4zbgOagj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eq1ymVZfhpg8xHd/sxtRwCuJixlwBD2udKuscemQFqh0FvdFUrgnFmcSBc9/kb2zHqwbEMEVHrdH3IlaXouQyHck2wZvCJb54DjgMN6KiT4YoFj0zg1al6Mr/xH45lQGGKqdW/tft9WLKprqYUcsMkHpm8t6JuHsppOieYo3HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wvNl2x95; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvNl2x95"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786135512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGsj4KmGNuxwEIxXYPSu6XwqhL8VtYFUmVWXQfKk1mk=;
	b=wvNl2x95ku7XNM/Dq3mTAfZLMc2RpcfRhcLKfByTNOrCegMg9dYk62/AVZ78E6fh1HvE9l
	mqBwLFh9UnHLCJLq/AyiCU2y5TPTMAupWR08NpLPg8YVcNk1XpgWxVMfxxMTbDQ9g5wvEh
	lH3xLkOlh/PFHHzpskIjpgKaBU//Dh8=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 0/4] selftest related fixes
Date: Fri,  7 Aug 2026 13:44:30 -0700
Message-ID: <20260807204434.1036279-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

This is a set of fixes accumulated during BPF_GCC testing and an in-works
verifier enhancement series for 32-bit tracking.

Changes since v1:

 - 1/4: reworked. Instead of forcing BPF_STX with barrier_var(), select
   the expected message with #ifdef __BPF_FEATURE_ST, per Yonghong. The
   changelog now spells out the two tradeoffs: on a BPF_ST toolchain the
   test no longer reaches map_kptr_match_type(), and __BPF_FEATURE_ST
   means "can emit BPF_ST", not "will" - clang -mcpu=v4 -O0 still emits
   BPF_STX, so the #ifdef is only correct because selftests build at -O2.

 - 2/4: reword the comment above the error-summary walk. With
   --no-error-summary and no --json-summary the loop is skipped
   entirely, not just the printing, which the old wording obscured.
   [bpf-ci]

 - 4/4: the RV64 recipe in README.rst wraps the denylist in \" and
   relies on the guest's second parse of the init script to remove
   them, so %q broke it - the quotes reached test_progs and
   parse_test_list() split them into junk filters. Drop the
   backslashes so the host consumes the quotes, and correct the
   changelog, which wrongly claimed README.rst shows the command
   unquoted. [bpf-ci]

 - 3/4: unchanged.

v1: https://lore.kernel.org/bpf/20260803170251.1898102-1-vineet.gupta@linux.dev

Thx,
-Vineet

Vineet Gupta (4):
  selftests/bpf: map_kptr: expect BPF_ST reject msg on cpuv4 toolchains
  selftests/bpf: add --no-error-summary to skip end-of-run error log
    dump
  selftests/bpf: report failed subtest count in test_progs summary
  selftests/bpf: vmtest.sh: preserve command quoting when running in the
    VM

 tools/testing/selftests/bpf/README.rst        |  4 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |  9 +++
 tools/testing/selftests/bpf/test_progs.c      | 64 +++++++++++++------
 tools/testing/selftests/bpf/test_progs.h      |  3 +-
 tools/testing/selftests/bpf/vmtest.sh         | 13 +++-
 5 files changed, 67 insertions(+), 26 deletions(-)

-- 
2.53.0-Meta


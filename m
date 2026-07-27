Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921D37AA9A
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162587; cv=none; b=Pg8kfdGJuXOESfoPVbTlO+gnONLp04M4uXjDrVYmj8E18PF1guEaRlyMpYIzi5S7sdvk1tSPqg8TpPBi1kiDuHq2PwBBNED5UxkStQyG+KfiDZ+jENmwEvBAiWZmLj2o4+px6/Sn6BeWR0yiOLk/9jR4wcHsFKYvafi+QOtP5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162587; c=relaxed/simple;
	bh=rnLaruOSRQ5uDK5ZU7HDhI+DpzKpD8VvDeOSpc/EcEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPD/iW0MD4scsEEU5xmxqD0bkpkTMHJwxGDipWKu+3ygFpje/alfy+ONFcETyrI1sCqc6TxEJYJzeVZW5l/V5wxWd0Jb6hfzr7HEwILh2qXXaxUJ+OD0dL5JfpASmTriPkyHMX7mrfhK7864D4e/xk2n36fqucebZvZ3uRf1WMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g3M+DqJk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g3M+DqJk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785162579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7tHghUuh4abL0fwwnOGlOayUFDXuWG+n5PvNG2j5QBw=;
	b=g3M+DqJkQz7oVE7zYcnCb3KUfo0PuPSR/Dp6zubbXXsm8bnX9toxZx/W8oEBBSpY8cvZdP
	Zkf0hJ/aJ/hY+gSQS39O/06Y3kgBfy3kLsFuLTSuVMyoRmnweLX7hJfdqk0ScnsFARuor1
	croZ7gE4Yzs+dCd/ZRysqs8/yibw01o=
From: Leon Hwang <leon.hwang@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] arm64: ftrace: enable single ftrace_ops for direct calls
Date: Mon, 27 Jul 2026 22:28:42 +0800
Message-ID: <20260727142844.21212-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Beyond the DIRECT_CALLS support on arm64 [1], select
HAVE_SINGLE_FTRACE_DIRECT_OPS for arm64, which enables the BPF
tracing_multi link on arm64 [2].

All tracing_multi link selftests are passed on arm64.

 cd tools/testing/selftests/bpf
 ./test_progs -a 'tracing_multi_*'
 #545/1   tracing_multi_attach_rollback/put:OK
 #545/2   tracing_multi_attach_rollback/unlink:OK
 #545     tracing_multi_attach_rollback:OK
 #546     tracing_multi_bench_attach:OK
 #547/1   tracing_multi_test/skel_api:OK
 #547/2   tracing_multi_test/link_api_pattern:OK
 #547/3   tracing_multi_test/link_api_ids:OK
 #547/4   tracing_multi_test/module_skel_api:OK
 #547/5   tracing_multi_test/module_link_api_pattern:OK
 #547/6   tracing_multi_test/module_link_api_ids:OK
 #547/7   tracing_multi_test/intersect:OK
 #547/8   tracing_multi_test/cookies:OK
 #547/9   tracing_multi_test/session:OK
 #547/10  tracing_multi_test/attach_api_fails:OK
 #547/11  tracing_multi_test/fentry_direct_access:OK
 #547/12  tracing_multi_test/fexit_direct_access:OK
 #547/13  tracing_multi_test/fsession_direct_access:OK
 #547/14  tracing_multi_test/fentry_after_multi:OK
 #547     tracing_multi_test:OK
 Summary: 3/16 PASSED, 0 SKIPPED, 0 FAILED

 ./test_progs -a 'fill_link_info/tracing_multi_*'
 #132/11  fill_link_info/tracing_multi_link_info:OK
 #132/12  fill_link_info/tracing_multi_invalid_ubuff:OK
 #132     fill_link_info:OK
 Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Links:
[1] https://lore.kernel.org/all/20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev/
[2] https://github.com/kernel-patches/bpf/pull/12986

Leon Hwang (2):
  arm64: ftrace: enable single ftrace_ops for direct calls
  selftests/bpf: Enable tracing_multi tests on arm64

 arch/arm64/Kconfig                                     | 2 ++
 arch/arm64/kernel/ftrace.c                             | 3 +--
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c | 9 +++++++--
 tools/testing/selftests/bpf/test_progs.h               | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.55.0


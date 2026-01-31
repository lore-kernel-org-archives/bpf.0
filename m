Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A81BC46
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871027; cv=none; b=iBBgQYqnT6qmq77sE5iNoByzF34/kHdjwBehVP0m/Rif9fEC83IX3nnohQBQe+GlTdKHGmyB/FPjW+AzByqUOKW2yXwZ1wwe+rNKggIuElX9DgwrZU972jwUlmfINHO0IIL0bQUmXA51oUgkbg56OXZPFnGFovLMMotDULWZNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871027; c=relaxed/simple;
	bh=bNAlVMmmliEy37W9eTudFNDwYDkxzgo7/yJtKgYpEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYUKEq46f0AeNAkK/MzDzDo+BHZ9xdYdar3t3d/wY6UlYtDCMZoYn6v5YBo7DoYiCbItoAuXDfPzze2D2f/c0z7hYWU2q6dvSudA3vvnl35yn13v4sPEWRPUljH563g4TAgzY0hcR2mg51uX/b7meF+5Cm/pLykYnq3JLGqtXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xR7mX1DD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xR7mX1DD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769871022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MODxuvbGY1RgoOQzCJgngFFaiYFV9sU4L7e3PPw4RGc=;
	b=xR7mX1DDmL4XqCfb4ytMxX95j+vkzpYZ/dZE+3+GWC2lXx9FLK1iqdzRUXN6LhORyavaIj
	bKk+wZpfKvNOUPyvrb3qObQ6MkXDDmWVVR9Pxrq/lZXaKiwPjXe49iuu9abYEBaugZZDIM
	KgZsB/77G8xAJ5Zbyhgjqklngek/miw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 0/3] bpf, arm64: Add fsession support
Date: Sat, 31 Jan 2026 22:49:47 +0800
Message-ID: <20260131144950.16294-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to commit 98770bd4e6df ("bpf,x86: add fsession support for x86_64"),
add fsession support on arm64.

Patch #1 adds bpf_jit_supports_fsession() to prevent fsession loading
on architectures that do not implement fsession support.

Patch #2 implements fsession support in the arm64 BPF JIT trampoline.

Patch #3 enables the relevant selftests on arm64, including get_func_ip,
and get_func_args.

All enabled tests pass on arm64:

 cd tools/testing/selftests/bpf
 ./test_progs -t fsession
 #136/1   fsession_test/fsession_test:OK
 #136/2   fsession_test/fsession_reattach:OK
 #136/3   fsession_test/fsession_cookie:OK
 #136     fsession_test:OK
 Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

 ./test_progs -t get_func
 #138     get_func_args_test:OK
 #139     get_func_ip_test:OK
 Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Changes:
v4 -> v5:
* Address comment from Alexei:
  * Rename helper bpf_link_prog_session_cookie() to
    bpf_prog_calls_session_cookie().
* v4: https://lore.kernel.org/bpf/20260129154953.66915-1-leon.hwang@linux.dev/

v3 -> v4:
* Add a log when !bpf_jit_supports_fsession() in patch #1 (per AI).
* v3: https://lore.kernel.org/bpf/20260129142536.48637-1-leon.hwang@linux.dev/

v2 -> v3:
* Fix typo in subject and patch message of patch #1 (per AI and Chris).
* Collect Acked-by, and Tested-by from Puranjay, thanks.
* v2: https://lore.kernel.org/bpf/20260128150112.8873-1-leon.hwang@linux.dev/

v1 -> v2:
* Add bpf_jit_supports_fsession().
* v1: https://lore.kernel.org/bpf/20260127163344.92819-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Add bpf_jit_supports_fsession()
  bpf, arm64: Add fsession support
  selftests/bpf: Enable get_func_args and get_func_ip tests on arm64

 arch/arm64/net/bpf_jit_comp.c                 | 71 ++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 include/linux/bpf.h                           |  7 +-
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  5 ++
 kernel/bpf/verifier.c                         |  5 ++
 .../selftests/bpf/prog_tests/fsession_test.c  | 32 ++++++---
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 9 files changed, 110 insertions(+), 20 deletions(-)

--
2.52.0


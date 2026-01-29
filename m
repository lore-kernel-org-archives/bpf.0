Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322A3191C0
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701894; cv=none; b=p/5fJXGOeHc/kf9CjGnRaGzzWzXC+Ch/FgbOVpkpcjO/PNwWgOTPZls7aDBI0V69LYGbEcZssQjqi7AdpIV5UnR2SAdA9wEDe+rBjDzmPwdMF40+4s4wjBuV/ZZTVfd1hQtkRuypFIilLBwo6ZbuQEEY2/hk95/WAopQGpTXGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701894; c=relaxed/simple;
	bh=jc86nxPbqmTKqXlbhlpra9MGSXv1JuBgM7NgrFBhGyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2mi6lPasEYlBeLbl3JYtFEy+mOScaL4/gdYLgH1pVUchoHGb/etJL4hWS9rjuF4Cm+N3H4+kmHKZJIRtdf4HXGMhV36pD5Fm0soB5E4nIYYXEzJIy4TbRCfjHyDwwN8MXksXhoydH/mRYeC0qY1dZTNDYuhjjptiBs2uBko92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KzP36po8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KzP36po8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769701879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ctcQwPUhn/CREyCgaiX/XAgOXE8OMZeTnRPpvn+cap4=;
	b=KzP36po8UqEg9VMmawwQF6A37EPdHBRGn3LJLrA/7uop7MwuIh3oPAbeSkS7/g3a9z9a3E
	292g6Bj9vKAGW0s2XVwOgiR6IEOHtjDYF5jyB+DL7TrldX32oIB9PR79lLhXFn0rB1KdAO
	dc7L/9fOu4AKUbMXkIqGfh4+V9w/Qog=
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
Subject: [PATCH bpf-next v4 0/3] bpf, arm64: Add fsession support
Date: Thu, 29 Jan 2026 23:49:50 +0800
Message-ID: <20260129154953.66915-1-leon.hwang@linux.dev>
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
 #135/1   fsession_test/fsession_test:OK
 #135/2   fsession_test/fsession_reattach:OK
 #135/3   fsession_test/fsession_cookie:OK
 #135     fsession_test:OK
 Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

 ./test_progs -t get_func
 #138     get_func_args_test:OK
 #139     get_func_ip_test:OK
 Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Changes:
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


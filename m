Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9A369210
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612514; cv=none; b=rrelkg0WVl7H5wju90IqV1bvsXx7k3Ed+VgP0XjJ0RhYTXqRFlXbGg+wv3woQ3c9ZyWwozfroOk4A/djxG97ofZMjyu6Tpqo6zm76tcFg4ndekXZ8u69rZiaZS0I3U9AZCCB9ZHs8p2qnnymUDzQVDmmY5CbmLOjT8RWxJW+VZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612514; c=relaxed/simple;
	bh=pztt026up2P4xqtjxc1Kc5KO09stPQ8UGQxMeSCjTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxAnRXbldg7mzgCMHsjg0S6ow1FkoBorXDbHzkvTj60+NrwQ7Pp9xZv9vt2yT02dPRaIrvpPD5OpvdBfXcV5t1+xrGyiMaCGW7iJtqIdRrKfwlDUeATSza/weoUrXXcU6C4rNS2fI4i3KxP4vfs2ZoWN7FBHT+b/HQVefaG/8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZiwyxMFD; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiwyxMFD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769612495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k4l9+/zjVdAeQ0ROWCJXkoihmFOfDxlfbczHQ1tq6Xc=;
	b=ZiwyxMFDDtqkv5yoZMLezAk7OywXx0Ln7OXs3BjuRsOkLUQ2xuKxLh9NimUaUb+KIKfwdY
	Pw5ly/3E/LN8ITSNn2U796762D7cLlRzNgZdhLcfDLCidGhR9QBV1sD8lyA9I6YBmByGEM
	Wtnr8gp/9Z9ipABzFpVyz7TS9Ns0nh0=
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
Subject: [PATCH bpf-next v2 0/3] bpf, arm64: Add fsession support
Date: Wed, 28 Jan 2026 23:01:09 +0800
Message-ID: <20260128150112.8873-1-leon.hwang@linux.dev>
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

Patch #1 adds bpf_arch_supports_fsession() to prevent fsession loading
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
v1 -> v2:
* Add bpf_arch_supports_fsession().

Leon Hwang (3):
  bpf: Add bpf_arch_supports_fsession()
  bpf, arm64: Add fsession support
  bpf/selftests: Enable get_func_args and get_func_ip tests on arm64

 arch/arm64/net/bpf_jit_comp.c                 | 71 ++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 include/linux/bpf.h                           |  7 +-
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  5 ++
 kernel/bpf/verifier.c                         |  3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 32 ++++++---
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 9 files changed, 108 insertions(+), 20 deletions(-)

--
2.52.0


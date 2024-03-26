Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED73129E7C
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426502; cv=none; b=Tj27ctETDpgDWFMOODLc6fqZT7pri3Uqzv2rUWGqeTz+fDEXghcjhh6VsYIZQnnxYQbP90cMH3oT2SErc8RWa3Q+HqYFYtPYwCrT4fgOygC1CUBCqeGSnWvfFcxMYzINmQzlCQWnVrKlg8UU+/Qyy/V4WFvHRDryxxechciFhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426502; c=relaxed/simple;
	bh=VJ4ERxRyAQme67dvpDKgsSqF1beY8Nnobj/HldzlLt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBOxjreISdEtHimxbjzdg4R9/cAwMsS8z7CWF6si9oK1TGvpaYmkS09R/VxnITRDASod/hVJnSDrEgFeCkGRT6ysgkrR4c8VZ6JmlHfwq8er/x/sGv1yvddqoxA/A179UD28HQIYUhksegT4nIOZBn1go2hdgg6lHzZnAodnhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1346024E7068; Mon, 25 Mar 2024 21:14:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/8] bpf: Fix a couple of test failures with LTO kernel
Date: Mon, 25 Mar 2024 21:14:43 -0700
Message-ID: <20240326041443.1197498-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With a LTO kernel built with clang, with one of earlier version of kernel=
,
I encountered two test failures, ksyms and kprobe_multi_bench_attach/kern=
el.
Now with latest bpf-next, only kprobe_multi_bench_attach/kernel failed.
But it is possible in the future ksyms selftest may fail again.

Both test failures are due to static variable/function renaming
due to cross-file inlining. For Ksyms failure, the solution is
to strip .llvm.<hash> suffixes for symbols in /proc/kallsyms before
comparing against the ksym in bpf program.
For kprobe_multi_bench_attach/kernel failure, the solution is
to either provide names in /proc/kallsyms to the kernel or
ignore those names who have .llvm.<hash> suffix since the kernel
sym name comparison is against /proc/kallsyms.

Please see each individual patches for details.

Changelogs:
  v2 -> v3:
    - no need to check config file, directly so strstr with '.llvm.'.
    - for kprobe_multi_bench with syms, instead of skipping the syms,
      consult /proc/kallyms to find corresponding names.
    - add a test with populating addrs to the kernel for kprobe
      multi attach.
  v1 -> v2:
    - Let libbpf handle .llvm.<hash suffixes since it may impact
      bpf program ksym.

Yonghong Song (8):
  selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
  libbpf: Mark libbpf_kallsyms_parse static function
  libbpf: Handle <orig_name>.llvm.<hash> symbol properly
  selftests/bpf: Refactor some functions for kprobe_multi_test
  selftests/bpf: Refactor trace helper func load_kallsyms_local()
  selftests/bpf: Add {load,search}_kallsyms_custom_local()
  selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO
    kernel
  selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms

 tools/lib/bpf/libbpf.c                        |  26 +-
 tools/lib/bpf/libbpf_internal.h               |   5 -
 .../bpf/prog_tests/kprobe_multi_test.c        | 248 ++++++++++++++----
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  30 +--
 tools/testing/selftests/bpf/trace_helpers.c   |  46 +++-
 tools/testing/selftests/bpf/trace_helpers.h   |   7 +
 6 files changed, 281 insertions(+), 81 deletions(-)

--=20
2.43.0


Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341FE13441F
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051275; cv=none; b=ib4arOq5Y+aiYaRzhYrn4sc3tCMRPxHMwz2ozABya94nqLMP7rwEmv6GIM6AEvOMglsxMBkScYiv/VGQ6KHZcxzF85Zo4MBhHAvJ0OnV3SSSLfZZ0Jpl1O6oxtixUob5zt2bJKdyNpaGhkGElWn0WUC+kCivN8dRcwKm77V//jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051275; c=relaxed/simple;
	bh=rH6WTJamFufej1SdOc0wv0kcmx+3esaryHMV5wA9fVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHcBQKocKo6Vp/6GjOwyg9ohcJ6Upwng55V8ze4ynm8dFVYzLif/6+DIYbXF1Eu15xifdmS2z0Jc2GdUYFKiZhIH3IT6Eb+TEOtWCt3we6Q7biqCRMyClXdPjyUeJ4fcpkXX9CIg/fxxi0LGCYDo9LhgcLiME8N8kFy35e5i0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id BD09D2218FE6; Thu, 21 Mar 2024 13:00:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/5] bpf: Fix a couple of test failures with LTO kernel
Date: Thu, 21 Mar 2024 13:00:58 -0700
Message-ID: <20240321200058.2218328-1-yonghong.song@linux.dev>
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

Yonghong Song (5):
  selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
  libbpf: Mark libbpf_kallsyms_parse static function
  libbpf: Handle <orig_name>.llvm.<hash> symbol properly
  selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO
    kernel
  selftests/bpf: Add a selftest with available_filter_functions_addrs

 tools/lib/bpf/libbpf.c                        |  66 +++++++-
 tools/lib/bpf/libbpf_internal.h               |   2 -
 .../bpf/prog_tests/kprobe_multi_test.c        | 151 ++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  30 ++--
 4 files changed, 224 insertions(+), 25 deletions(-)

--=20
2.43.0


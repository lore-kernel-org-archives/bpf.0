Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83C20DE0
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396461; cv=none; b=YdBolbJYGN7ozeDTj9xY47OLmaDZ9bfiCLKrYd5uJX53bRRoHig/PoXhmx/uq21Q92zuTil3SqESjVT+M3BHjgf+XiVpUrSrQ/CQI57mnYX9XqQTJN9t1KoxAZ4ZEhrUhXMfyh2zYSzbhpqf24w+Zg+CTaD6yte5891NGtd1WJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396461; c=relaxed/simple;
	bh=lLfKQ6H1wKEjRcp/ZrfNvLY9l03rW2BWj73IqetVHcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPufz/YZESMbvmyLUfUF6DL7JEr3Ul1BKNM9f2XcfxlU9hcy86tfMvItwJxWedjeSh+ikFngEisFIlTxR+qgdaIdBwic5qIB78EaX1Tid50vtZZsGbIQgOdRtiCU2yTk2HTIjIO1kWurwguGdt/TJo6uGjzSfaROto+yrB92AcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3A18711EDE1B; Sat,  2 Mar 2024 08:20:44 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/4] selftests/bpf: Fix a couple of test failures with LTO kernel
Date: Sat,  2 Mar 2024 08:20:44 -0800
Message-ID: <20240302162044.1498741-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With a LTO kernel built with clang, I encountered two test failures,
ksyms and kprobe_multi_bench_attach/kernel. Both test failures are
due to static variable/function renaming due to cross-file inlining.
The solution is to either skip the test or filter out those renamed
functions. A helper function check_lto_kernel() is introduced to
identify whether the underlying kernel is built with LTO or not.
Please see each individual patches for details.

Yonghong Song (4):
  selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
  selftests/bpf: Add check_lto_kernel() helper
  selftests/bpf: Fix possible ksyms test failure with LTO kernel
  selftests/bpf: Fix possible kprobe_multi_bench_attach test failure
    with LTO kernel

 .../bpf/prog_tests/kprobe_multi_test.c        |  7 +++
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 42 +++++++++--------
 tools/testing/selftests/bpf/testing_helpers.c | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 4 files changed, 78 insertions(+), 19 deletions(-)

--=20
2.43.0


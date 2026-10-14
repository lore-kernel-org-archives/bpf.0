Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D139D6E7
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977507; cv=none; b=UB1QuSkrYT+cT71Tby2+gvTq9wysteswBzPl2XXJSC5jpcrIL1ZPVjMKSR2CKCQKSEv8zSySJvA64CsZrbQY7+ReTIVKiyYSuHVfevHSCVaSoSXga5x7fD9e6bhFzTMTIyhW+rVFXZjcBgPK/wHVikCBnkBrpvyfxgIxUzLikSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977507; c=relaxed/simple;
	bh=00nVKVTPaYWz3INyxq/SritoKgZREtUBG4wGIzclx6A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a+4rt24RLVY2Lh0ADan4jGNeTA1HqKX/uSbmpLa3KI9kOMW/Z5KVpOO8UWg+vicn8QDXzD4Pf9USnnluepnGruB4mUqGT4ej4aY7PA/ngKSpp4MTlizIRk4fSrzRZRh6SjRrCCoYUp9hJVTu9cJWsQIrBwENmO4WxaT8H63PN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kzRsHqrX; arc=none smtp.client-ip=91.218.175.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kzRsHqrX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=00nVKVTPaYWz3INyxq/SritoKgZREtUBG4wGIzclx6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977502; v=1; x=1792582302;
 b=kzRsHqrX8QEttM0rLMzyUYtQSSeaSBr2n6XCpsIpJgxFeBNkzSTOX4VfB8kvR11Hlg/UnZFz
 gVnprbxjq4zY7AzqkO5xl4CNL3Eygo/VcmWhOPGV0uuxS/Q+l5Jgi1TkY4n/lhOoZDOGsN0CVo3
 3+zlsp2Au1kavDc3bbGce7os=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e5216cf033832cf1;
	Wed, 14 Oct 2026 11:31:42 +0000
X-Mizu-Trace-ID: e5216cf033832cf1
X-Migadu-Flow: FLOW_OUT
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KaFai Wan <kafai.wan@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Feng Jiang <jiangfeng@kylinos.cn>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v2 0/7] selftests/bpf: Fix selftests failures with LLVM 23
Date: Wed, 14 Oct 2026 19:30:36 +0800
Message-ID: <20261014113043.640435-1-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with clang/LLVM 23 breaks several selftests. Patches #1 to #4 fix
those failures.

The following self-tests also fail under specific invocations of
test_progs:

- ./test_progs -t prog_tests_framework/test_fail -v
 test_prog_tests_framework:FAIL:skip_cnt_check
 unexpected skip_cnt_check: actual 0 != expected 2

- ./test_progs -t prog_tests_framework_expected_msgs -v
 Caught signal #11!

- ./test_progs -t prog_tests_framework_compare_text -v
 Caught signal #11!

Patches #5 to #7 fix these.

Changes in v2:
 - Collect the selftest fixes from the two patches in v1
   patches: #1, #5, #6 and #7.
 - Add three new patches: #2, #3 and #4.

Changes in v1:
 - https://lore.kernel.org/bpf/20261012135624.2749743-1-kafai.wan@linux.dev/T/
 - https://lore.kernel.org/bpf/20261012140202.2754552-1-kafai.wan@linux.dev/T/

---
KaFai Wan (7):
  bpf: Determine freplace staticness from BTF linkage
  selftests/bpf: Fix stack_arg precision backtracking log expectation
  selftests/bpf: Fix stack arg pruning test JOIN log expectation
  selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child
  selftests/bpf: Fix prog_tests framework subtest count checks
  selftests/bpf: Skip expected_msgs subtests when stdout is not saved
  selftests/bpf: Skip compare_text subtest when stdout is not saved

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/prog_tests/exceptions.c     |  2 +-
 .../bpf/prog_tests/prog_tests_framework.c     | 34 ++++++++++++++-----
 .../bpf/prog_tests/uprobe_multi_test.c        |  4 +--
 .../selftests/bpf/progs/stack_arg_precision.c |  4 +--
 .../selftests/bpf/progs/verifier_stack_arg.c  |  4 +--
 6 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.43.0

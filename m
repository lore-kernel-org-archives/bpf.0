Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B133FE04
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511550; cv=none; b=I0BcE1YSduLw7JwZWeu+4ZXrqhoTPfE1Nd44sMJ97AMUnc2iabRyn1KbQ2Jug4urSe6/w8OnC7tCljqs6Lc6KH1lxammBMBWia2snDmkawNyHYUhTfgfrRRR6zjDgyQGF5MX35g8L0E/hyv5NC8+SWwpCG8O3jNe+dr90pLESfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511550; c=relaxed/simple;
	bh=Rwu0/Q5O6sDify4vtHE7EgDx/HdSGFfyoKuhTksF7Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EREeY+vaNTlRbjQg6y+ByIVZuoqlO8H+F1CqVP0fYQJnpzMOwLI+3AYioNu74dOzIGqCEk4+h8y9aGV5QMGY19CIC0FwNf7EbgkFWniu48KYeSIcH8tdaIumXIt1DJAq/BgV7hYxCco6iFNlghvgKAWsQdJE2ukqtNIHcAiONnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sr5M0+63; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sr5M0+63"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2bRCV7yDeBf8GuOUBEvMnX2Y0xlNieUH03bOqMBKOs=;
	b=sr5M0+63Wsz/ZZW1ycof/LgoMgshho1gsH8aRzB8qzGyjBs7rbmGy5s3WQDYQs8NGiSTHH
	mq0TRXvTdlSZkV6BWgnSjsF3wTVpux4bX3ZZf61jgHFh7IQrelrkdZ8gq8t86l0TpmxOZm
	hR78dUiXmERnYMyYvwn87pHpaqddEYo=
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add JIT disassembly tests for 64-bit bitops kfuncs
Date: Thu, 19 Feb 2026 22:29:28 +0800
Message-ID: <20260219142933.13904-7-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-1-leon.hwang@linux.dev>
References: <20260219142933.13904-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add bitops_jit selftests that verify JITed instruction sequences for
supported 64-bit bitops kfuncs on x86_64 and arm64, including
CPU-feature-gated coverage on x86 where required.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/bitops.c |   6 +
 .../testing/selftests/bpf/progs/bitops_jit.c  | 153 ++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bitops_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bitops.c b/tools/testing/selftests/bpf/prog_tests/bitops.c
index 9acc3cb1908c..2c203904880d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bitops.c
+++ b/tools/testing/selftests/bpf/prog_tests/bitops.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "bitops.skel.h"
+#include "bitops_jit.skel.h"
 
 struct bitops_case {
 	__u64 x;
@@ -180,3 +181,8 @@ void test_bitops(void)
 	if (test__start_subtest("ror64"))
 		test_ror64();
 }
+
+void test_bitops_jit(void)
+{
+	RUN_TESTS(bitops_jit);
+}
diff --git a/tools/testing/selftests/bpf/progs/bitops_jit.c b/tools/testing/selftests/bpf/progs/bitops_jit.c
new file mode 100644
index 000000000000..9f414e56b1e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bitops_jit.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+SEC("syscall")
+__description("bitops jit: clz64 uses lzcnt on x86 with abm")
+__success __retval(63)
+__arch_x86_64
+__cpu_feature("abm")
+__jited("	lzcnt{{.*}}")
+int bitops_jit_clz64_x86(void *ctx)
+{
+	return bpf_clz64(1);
+}
+
+SEC("syscall")
+__description("bitops jit: ctz64 uses tzcnt on x86 with bmi1")
+__success __retval(4)
+__arch_x86_64
+__cpu_feature("bmi1")
+__jited("	tzcnt{{.*}}")
+int bitops_jit_ctz64_x86(void *ctx)
+{
+	return bpf_ctz64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: ffs64 uses tzcnt on x86 with bmi1")
+__success __retval(5)
+__arch_x86_64
+__cpu_feature("bmi1")
+__jited("	tzcnt{{.*}}")
+int bitops_jit_ffs64_x86(void *ctx)
+{
+	return bpf_ffs64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: fls64 uses lzcnt on x86 with abm")
+__success __retval(5)
+__arch_x86_64
+__cpu_feature("abm")
+__jited("	lzcnt{{.*}}")
+int bitops_jit_fls64_x86(void *ctx)
+{
+	return bpf_fls64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: popcnt64 uses popcnt on x86")
+__success __retval(3)
+__arch_x86_64
+__cpu_feature("popcnt")
+__jited("	popcnt{{.*}}")
+int bitops_jit_popcnt64_x86(void *ctx)
+{
+	return bpf_popcnt64(0x1011);
+}
+
+SEC("syscall")
+__description("bitops jit: rol64 uses rol on x86")
+__success __retval(6)
+__arch_x86_64
+__jited("	rol{{.*}}")
+int bitops_jit_rol64_x86(void *ctx)
+{
+	return bpf_rol64(3, 1);
+}
+
+SEC("syscall")
+__description("bitops jit: ror64 uses ror on x86")
+__success __retval(3)
+__arch_x86_64
+__jited("	ror{{.*}}")
+int bitops_jit_ror64_x86(void *ctx)
+{
+	return bpf_ror64(6, 1);
+}
+
+SEC("syscall")
+__description("bitops jit: clz64 uses clz on arm64")
+__success __retval(63)
+__arch_arm64
+__jited("	clz	{{.*}}")
+int bitops_jit_clz64_arm64(void *ctx)
+{
+	return bpf_clz64(1);
+}
+
+SEC("syscall")
+__description("bitops jit: ctz64 uses ctz or rbit+clz on arm64")
+__success __retval(4)
+__arch_arm64
+__jited("	{{(ctz|rbit)}}	{{.*}}")
+int bitops_jit_ctz64_arm64(void *ctx)
+{
+	return bpf_ctz64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: ffs64 uses ctz or rbit+clz on arm64")
+__success __retval(5)
+__arch_arm64
+__jited("	{{(ctz|rbit)}}	{{.*}}")
+int bitops_jit_ffs64_arm64(void *ctx)
+{
+	return bpf_ffs64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: fls64 uses clz on arm64")
+__success __retval(5)
+__arch_arm64
+__jited("	clz	{{.*}}")
+int bitops_jit_fls64_arm64(void *ctx)
+{
+	return bpf_fls64(0x10);
+}
+
+SEC("syscall")
+__description("bitops jit: bitrev64 uses rbit on arm64")
+__success __retval(1)
+__arch_arm64
+__jited("	rbit	{{.*}}")
+int bitops_jit_bitrev64_arm64(void *ctx)
+{
+	return bpf_bitrev64(0x8000000000000000ULL);
+}
+
+SEC("syscall")
+__description("bitops jit: rol64 uses rorv on arm64")
+__success __retval(6)
+__arch_arm64
+__jited("	ror	{{.*}}")
+int bitops_jit_rol64_arm64(void *ctx)
+{
+	return bpf_rol64(3, 1);
+}
+
+SEC("syscall")
+__description("bitops jit: ror64 uses rorv on arm64")
+__success __retval(3)
+__arch_arm64
+__jited("	ror	{{.*}}")
+int bitops_jit_ror64_arm64(void *ctx)
+{
+	return bpf_ror64(6, 1);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


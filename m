Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657260;
	b=EB7mRapY2rbKPIsbphpVxAd/Cs1M7v3aOSlvfe8x6Y17azPszfuGx14BhTMIQmcDqhBi
	 Wu0xRyzJqqbumU/lGuhmsbLgXUIZJjZeVFZUIt395abTxDhA3n+IC3YeMszTqZzYoQ19z
	 +lv6W4Du+lguKJL6ts0Tnntd1FqaTvYv80t1zK15dHvFb4nd8bDAzk8onvYSaaGq9582l
	 XVdHLCH7BAUtfGkRFAFMMwxT+frTPIIYXtTmZ7YS/pBs3dA9KRbEyvRPZ8coWQmUerSwS
	 L3vSJdMPOHYE8uysGCxmFjrBpQ6XQ2NcsbaaQIY4+7dKe+hJcP2qHhjD4VkHNfQFw3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657260;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=alDcra3w3Tj4hHB+IMSFMePf6yuAIBKMhq01J4FcsdQ=;
	b=CbuTpoL03IFgecO5atE6BX4hjH6oiLmMHtF6GOoPYJGXFvENu5PfVGVNUEC4uDTL2Xfu
	 IRLGT0JJtZ8rlZNm/iKmIsX02cngiNwWyKXjDh98HHAz3DKBwvK79az/rn1Qji8ETA9o0
	 JPPm3Eai/goDP3k0MXCAW8ejUEMripz90/qm2jgiTBKatm35pyXSOYt0FfaDyuEIBueC4
	 6FS4cHoCCBO1LQTb9Naz8Y0jm7I0c5/mR+HMUHvoVSeBFTtGXu3zVvC/pjs3/0VHVrGtL
	 xaxvPd4xNDNt9deJYSJSg8ca9HGNMpdDHmVog2sgWogE9PnZOgXAttn9FyaFs7pr/jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Z2j9c/MF";
	arc=none smtp.remote-ip=95.215.58.177
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F6606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z2j9c/MF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r1vvkItYp0dYXtEa2bRLbOBZn/jhwa9VVsin4lnXi3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793657257; v=1; x=1794262057;
 b=Z2j9c/MFdYjdjLxwn+dAxFRy+U7OhFnvEf/PH55yWrwSYFoBc5MB5zLl8CggwR54S7PeRsqm
 imWqhZw7UlpTUPlCu3P7z0wpR4GTnByDElHDI9tjWGVBAio2z9vTt4jKSfhpg4VB3qgzPg+HXMc
 rcMnlDFY12cur/WQmLnnK2jk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92917c669be6866a;
	Mon, 02 Nov 2026 22:07:37 +0000
X-Mizu-Trace-ID: 92917c669be6866a
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
Date: Mon,  2 Nov 2026 14:07:10 -0800
Message-ID: <20261102220717.4079739-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220717.4079739-1-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7cd1f73b37ea ("selftests/bpf: Fix build of callx tests with GCC")
gated the callx progs on __clang__. GCC had indirect call support which was
recently refurbished along with a __BPF_FEATURE_CALLX macro [1], so gate
on that as well so once this GCC is released, the tests start passing.

Put the arch and compiler conditions in a CAN_USE_CALLX macro in
bpf_misc.h, and use it in all the test programs.

While at it, mark the placeholder programs left for unsupported
toolchains and arches with __skip(), so they report SKIP rather than OK.

[1] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ffe3ead4a8ad704b557b0cfa4f823df647c65a0d

Measured on bpf-next with a stock bpf-gcc that defines
__BPF_FEATURE_CALLX, test_progs before and after: 79 subtests run that
previously did not exist in the report, 78 OK and one @unpriv SKIP,
with no failures.  The two dummy placeholders retire and
callx_rodata_lskel goes SKIP -> OK.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/callx_rodata_lskel.c  | 2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h               | 7 +++++++
 tools/testing/selftests/bpf/progs/callx_rodata.c           | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_callx.c         | 5 ++---
 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c  | 5 ++---
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index f6ef67c3141e..acd821fb568f 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -36,7 +36,7 @@ static void __test_callx_rodata_lskel(void)
 	if (!ASSERT_OK_PTR(skel, "open"))
 		return;
 
-	/* gcc doesn't support indirect calls */
+	/* toolchain or JIT can't do callx */
 	if (skel->rodata->skip) {
 		test__skip();
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index d7f706c3bc4a..1b264480e128 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -295,6 +295,13 @@
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
+/* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALLX */
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) &&		\
+	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
+#define CAN_USE_CALLX
+#endif
+
 #if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)
 #define SPEC_V1
 #endif
diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
index e3f8335f80f8..8c28f01b7113 100644
--- a/tools/testing/selftests/bpf/progs/callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
@@ -4,13 +4,14 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 /* set by user space before the programs are loaded, it's in .rodata too */
 const volatile int bias = 1;
 
 int op_idx;
 
-#ifdef __clang__
+#ifdef CAN_USE_CALLX
 
 const volatile bool skip = false;
 
@@ -48,7 +49,6 @@ int both_ops(void *ctx)
 
 #else
 
-/* gcc doesn't support indirect calls */
 const volatile bool skip = true;
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 7e59188d9fca..ca1aef34ab72 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -6,9 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-/* gcc doesn't support indirect calls */
-#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
-    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+#ifdef CAN_USE_CALLX
 
 #define CALLX_INSN(DST, SRC, OFF, IMM) \
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
@@ -1075,6 +1073,7 @@ int callx_c_ops_on_stack(void *ctx)
 #else
 
 SEC("socket")
+__skip("callx needs arch JIT and compiler support")
 __success
 int dummy(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index b2ee0c8e042b..642071fa7498 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -6,9 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-/* gcc doesn't support indirect calls */
-#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
-    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+#ifdef CAN_USE_CALLX
 
 /*
  * Read-only data with pointers to functions, where the compiler puts tables
@@ -992,6 +990,7 @@ int callx_c_packed_struct(void *ctx)
 #else
 
 SEC("socket")
+__skip("callx needs arch JIT and compiler support")
 __success
 int dummy(void *ctx)
 {
-- 
2.53.0-Meta


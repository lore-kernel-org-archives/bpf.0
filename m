Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1B35C1BD;
	Thu,  4 Jun 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596487; cv=none; b=mX5kt8396denJTzKp77KwjKuod2sZdNfWBOf1HDZs8LTQlU1nq+mNIJevgqtz0kuuVo33vRUmHGeIU5qX/nsNJOPqtKlQ0kp5ZOmbAu0C5c9BYtzyESXkQJ3Tj5KTiXnAcyth/zWbE1tT41UWB7MrbrnZ0ZyyLyejb7JoU1GdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596487; c=relaxed/simple;
	bh=XA8feS2UBYei8jYsRryc4FYs7usXFeZul/MKk45r5bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvEiHnLdrkw62wOfS1C0W50AmJ0mr+wojXKwgbpXaafU/mdbxCGbzdtMicypsvY/VVyr8WIlP145jLigdQzJAG+vV60TvUIAtDrMGFYel4RZ9W7DP1QY03VLIkzWSTK77Sti2bkrBsON89RNbD9AtAjITmUarYRTqxiwNX0UTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=iujUg7H/; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="iujUg7H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=K/tziB3s+yk5mcLF6UYDNVmgkyFZKd73fm
	iVlxLqXc4=; b=iujUg7H/dfok3nhNqBZFAcivsgggXNJLDeZ1QlXdh4itjevbvH
	yD4cptreVzuI5SeKDlsIHMG8eouDivhNISOU5Im6Bo32LURSuBywDR++dr0Xvhj2
	er0a8QdOOLV3IlFk4byzzbVn/Co+DEycvR4vuHZNTo6vNmMbmbjxlKC/g=
Received: from dumpling.. (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQDHn5fnviFqazoNAg--.16320S4;
	Fri, 05 Jun 2026 02:07:49 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shenghao Yuan <shenghaoyuan0928@163.com>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds
Date: Fri,  5 Jun 2026 02:07:30 +0800
Message-Id: <20260604180730.2518088-3-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDHn5fnviFqazoNAg--.16320S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDWryxXF48AryDGFWfKrg_yoWrtFW8pF
	n5u3ZIgFWkZr13Wa17AF4UZFyFqa1kX3W5AFyrA345ZF1DJwn7Wr4kKrW8GryfCrn8X3yY
	vr4Sqr13AF4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl
	c2xSY4AK67AK6ryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiZ2DUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgQIA2ohcoGL3AAAsi

Add verifier tests covering constant pointer arithmetic on a
PTR_TO_FLOW_KEYS register, which regressed with commit 022ac0750883
("bpf: use reg->var_off instead of reg->off for pointers"): an
out-of-bounds offset introduced as flow_keys += K and then dereferenced
at insn->off 0 was accepted, while the equivalent flow_keys + K direct
offset was rejected.

The tests check that:
 - in-bounds constant arithmetic on the keys pointer is still accepted,
 - an out-of-bounds offset introduced via constant arithmetic is rejected
   for both read and write, with the same diagnostic as the direct
   insn->off form.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c  | 77 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_flow_keys.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 219ff2969868..dae26dda3782 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -38,6 +38,7 @@
 #include "verifier_div0.skel.h"
 #include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_flow_keys.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
 #include "verifier_gotol.skel.h"
@@ -189,6 +190,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_flow_keys(void)            { RUN(verifier_flow_keys); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
new file mode 100644
index 000000000000..512e5d1d2665
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Constant-offset bounds checks for PTR_TO_FLOW_KEYS pointer arithmetic. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* sizeof(struct bpf_flow_keys) is well under 4096, so +0x1000 is OOB. */
+
+SEC("flow_dissector")
+__description("flow_keys: in-bounds constant pointer arithmetic accepted")
+__success
+__naked void flow_keys_const_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 8;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("flow_keys: OOB via constant pointer arithmetic rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_const_oob_read(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 4096;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("flow_keys: OOB write via constant pointer arithmetic rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_const_oob_write(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 4096;					\
+	r2 = 0;						\
+	*(u64 *)(r1 + 0) = r2;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+/* Equivalent OOB expressed directly in insn->off; this form was always
+ * rejected and is kept to show both forms now share one diagnostic.
+ */
+SEC("flow_dissector")
+__description("flow_keys: OOB via insn->off rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_insn_off_oob(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r0 = *(u64 *)(r1 + 4096);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


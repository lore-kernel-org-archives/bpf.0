Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B743E071;
	Mon, 20 Jul 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565792; cv=none; b=aWO8aW3oN3PDRjAe9FYzeaVPJd2h9AuJkur2QxTzrFKAPUHwwTbuz1BTNvSwkZUfJ98A/4cXn/I7yjgzy8k90LI9gz4TTdk5q44f/2ZmmHypdI5raNj+INpkckKSr42SHCRG6olzAs38CiCuBcSIdpD7AFnfMPM4x4ozZDB9Lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565792; c=relaxed/simple;
	bh=UWnniLm65KaS5SRJI4XMphEP4Hx1T+PlqV6EOZTR7FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVasQoKU/gST3XOE9HVX67PAAbzrAXwgVsVcvzcFHWo3p5fhiKetR3oAHJLhJpnCFx7io3lODD1Qr0Pvl83s1dRzq+5N7SNkIGsRVxVj1M/b53FnkAT0awfVCi3QLFdh6u1+MMTXapVwPxt0U0wR9wZB/CwSKbQyOUPXOwPwMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=c5aPwSVe; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="c5aPwSVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=vDCpJ1bWGK3VjI9ZcwfOWFxt+A0+AHkkyD
	r3H/6ccsk=; b=c5aPwSVez563QkIK3MZdEfB/Z6GnV754HOxOnibZ09CBKzHRDe
	ZMBnawIob3CtK977tWkBsBeHW9sxTG157rlRoWthqmFpM2OCphs8qAbaDBT5l1y7
	lcvKIFOj1DpIOJ7fwrxGAZwNZEKPP/yFfN4iHLR5xdltQLwk4pSxMdIpg=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQDX1bcGUF5q2kYhAA--.51004S4;
	Tue, 21 Jul 2026 00:42:54 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover stack frame number after scalar plus fp
Date: Mon, 20 Jul 2026 16:37:45 +0000
Message-Id: <f081c0dc908da30006f5c72f0654a723c171d0ca.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDX1bcGUF5q2kYhAA--.51004S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17Xw18tw18WFW3Jr4fKrg_yoWruryxpa
	4kuF9IqFn7Arn2gF17CF129FyrCF4qv345Xr40vr13ZF18Jr1DXrZ2gFy5Jrn3GaykZw1Y
	v342qasxAa1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU88nrUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier test where a callee spills a map value pointer. It then
derives its frame pointer through scalar += fp. It overwrites the same
stack slot through the derived pointer.

The final reload must be treated as a scalar after the overwrite. The
verifier should reject the program when the reloaded value is dereferenced.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 -
 .../bpf/prog_tests/verifier_basic_stack.c     | 28 +++++++++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e7..0483ae340726c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -11,7 +11,6 @@
 #include "verifier_arena_globals2.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_async_cb_context.skel.h"
-#include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
 #include "verifier_bounds_deduction.skel.h"
@@ -165,7 +164,6 @@ void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
-void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
new file mode 100644
index 0000000000000..279f389729b8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "cap_helpers.h"
+#include "verifier_basic_stack.skel.h"
+
+void test_verifier_basic_stack(void)
+{
+	struct test_loader tester = {};
+	__u64 old_caps;
+	int err;
+
+	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
+	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
+	if (err) {
+		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
+		return;
+	}
+
+	test_loader__run_subtests(&tester, "verifier_basic_stack",
+				  verifier_basic_stack__elf_bytes);
+	test_loader_fini(&tester);
+
+	err = cap_enable_effective(old_caps, NULL);
+	if (err)
+		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f21146..634183fc86883 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -97,4 +97,45 @@ __naked void misaligned_read_from_stack(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack pointer arithmetic preserves frame number")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void stack_ptr_arith_preserves_frameno(void)
+{
+	asm volatile ("					\
+	r3 = 0;						\
+	*(u64 *)(r10 - 8) = r3;			\
+	r1 = %[map_hash_8b] ll;			\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto +2;				\
+	r0 = 0;						\
+	exit;						\
+	r1 = r0;					\
+	r2 = 0;						\
+	r3 = 0;						\
+	call stack_ptr_arith_preserves_frameno_subprog;	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __used __naked void stack_ptr_arith_preserves_frameno_subprog(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = r1;			\
+	r6 = -8;					\
+	r6 += r10;					\
+	*(u64 *)(r6 + 0) = r2;			\
+	r7 = *(u64 *)(r10 - 8);			\
+	*(u64 *)(r7 + 0) = r3;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


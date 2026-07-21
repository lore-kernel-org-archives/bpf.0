Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291AB446067;
	Tue, 21 Jul 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626817; cv=none; b=D4QqPVL6Ip/wSYv5+cz85pEy4rymCQPUsfp+MaDllrMg5mdN/gHDXjbyfPmYKMlnXKIr094InEaOWVWmUlrvacjzxsnkTfqkfVxkU8pcsaQECK3PTf1L5liwaMY5gO+7MsctHK5iW5Yxb40NGKYYLs/EucLJgNZhZIF3L97iBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626817; c=relaxed/simple;
	bh=pd29ih5NGPL+LRYgn3SYx4O+j5YSjz6BJLeg9SAmU3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Txvbpf4zD83PCK9WQHC1V+qXC2eWm+PNCawupdGvYhqE3iOLIvVvbelrN9E7EiX7UyVOyXACBMhwiYlJGI2x6PM62pAUYkK0dLEHhxNGnj/YOL529lkd3K81Qx9A9vfamPsSp/h18lvSIptH53T7soz2EB4zSID4z/1nwMKh3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=F8ferGGo; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="F8ferGGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Gs2jgJj4mVdNSKOvvv9HEk5Nxya5qv/1JF
	1lJb5WTTg=; b=F8ferGGo/p/HsFkU5WihqlbBWbhIAOBvAPuJLX7dKUbZWxA8fC
	cwo4ebbWX9NC4oii1ObooyOjsklrCIuarB46EGKN9G89aMGfsgR2y+xjWm0KIbJM
	w68hSudCO6f9kVxYiSK5YJbP4GcXyr/ce0W7zMf3rXC2zs47lkhhEFV3g=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQB3dbdfPl9q4NAnAA--.61424S4;
	Tue, 21 Jul 2026 17:40:03 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH 2/2] selftests/bpf: Cover stack frame number after scalar plus fp
Date: Tue, 21 Jul 2026 09:39:43 +0000
Message-Id: <81c5f138e510622fcf908b99bfc7000b872e0966.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQB3dbdfPl9q4NAnAA--.61424S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17Xw18tw18Ar1fKFW8tFb_yoWrWF18pa
	4kuF9FgFn7Arn2gF47CF12vFy5CF4qv345Xr40yr17ZF1UXr1DXrWIgFy5Jr1fCaykZw1F
	v342qasxAa1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4f
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTrWwUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier test where a callee spills a map value pointer. It then
derives its frame pointer through scalar += fp. It overwrites the same
stack slot through the derived pointer.

The final reload must be treated as a scalar after the overwrite. The
verifier should reject the program when the reloaded value is dereferenced.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 -
 .../bpf/prog_tests/verifier_basic_stack.c     | 14 +++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)
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
index 0000000000000..ff9382b47920c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "verifier_basic_stack.skel.h"
+
+void test_verifier_basic_stack(void)
+{
+	struct test_loader tester = {};
+
+	test_loader__run_subtests(&tester, "verifier_basic_stack",
+				  verifier_basic_stack__elf_bytes);
+	test_loader_fini(&tester);
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


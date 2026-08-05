Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E93CB55B
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955491; cv=none; b=L/W0/eO1WIi4hLHRGcBwORQFNaIhHlTR7pY7bjkLKn7UODMpb/0FSBHawrcSxRAB48YRfe0s2NgKTwLWOd2I+w4K66+hEPF0VfJtcNgsx+foNOy3ToSJBpaFjT1QLQe1i6cnjGdTL/y4WwSl6JUR2PQU6higwcnyERzZlVyYLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955491; c=relaxed/simple;
	bh=Bh2ss0wJYCRgVqshn7Zok8s+aHvOR1tdCkEpWxl98m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpQQJXq34MXf1x89vkOLw38Ek7wile5hUOfK7rON40l8KyHHnzCETpzGhVBinZewOKyJ+/sJlnVAN8bl3RXEe27UiUsnUaidsGjqUOeKvgr9YGLTqFGY3JEJHhTz9qJU27ztUbZx95UNb8iawpQWckrJ05P/D93droXQo8Dlxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ESH8ANoN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ESH8ANoN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fHtolZwDJv7mB4hj9WDnQ1/6ASejavatcfNnBGp1kmI=; b=ESH8ANoNxSv4fAnKAmmC6210/z
	2bVR/6K91vhdvFiiOCtyyQL1JA8uUBYM7hahyT+BWaBhV2GCwxOUfqN4IixwuRn0DONf3njxEp5bj
	7AzK1HG52tw0c8Ic3wYi8J7YbnqbSXtP8voqnqhxbHE//KVguJTkTonVaJSYNa+8upcx025QoCJ9X
	4Qz6YoA00c7nJLhdICQTujrzo0p/wZ7j/xthjI0/hyy72G0rn2Zw6dx91PKNoKLqq69CSy+VdhD/r
	ImzZPSjnoorD9e/fX1Z/rGFeVIYH6NDQnHEbamtYWKA4Z/090wiPWPHXOLqetFDVBZy2+k4mSV0M2
	kW0J1rJQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrgbe-000JYg-3B;
	Wed, 05 Aug 2026 20:44:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add tests for sub-register zext across state pruning
Date: Wed,  5 Aug 2026 20:44:43 +0200
Message-ID: <20260805184444.292828-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805184444.292828-1-daniel@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28083/Wed Aug  5 08:24:50 2026)

Add the example walked through in the previous patch as a test case: define
r6 twice, by a 64-bit write on the path the verifier explores first and by
a 32-bit write on the path explored second, and read it 64-bit after the
two paths meet. The second path is pruned at the merge, so the w6 definition
never reaches the 64-bit read, and its zero extension must be marked at the
pruning point instead.

The second test moves the pruning point into a callee, so that the marking
walks the caller frames as well. Their caller saved registers are NOT_INIT
while the callee runs, and marking those would set zext_dst on the call
insn, which has no destination register to zero extend.

The third test uses a BPF_CMPXCHG fetching into r0 as the 32-bit define.
Unlike the other definitions this one is patched by the fixup pass even
where the JIT does not ask for zero extension, so it also pins down that
the marks added at a pruning point reach x86-64.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t subreg
  [...]
  #668/1   verifier_subreg/add32 reg zero extend check:OK
  #668/2   verifier_subreg/add32 reg zero extend check @unpriv:OK
  [...]
  #668/80  verifier_subreg/lsh32_imm31_value:OK
  #668/81  verifier_subreg/rsh32_imm31_value:OK
  #668/82  verifier_subreg/arsh32_imm31_value:OK
  #668/83  verifier_subreg/lsh32_unknown_precise_bounds:OK
  #668/84  verifier_subreg/rsh32_unknown_bounds:OK
  #668/85  verifier_subreg/subreg zero extend check across state pruning:OK
  #668/86  verifier_subreg/subreg zero extend check across state pruning in a callee:OK
  #668/87  verifier_subreg/subreg zero extend check across state pruning with cmpxchg:OK
  #668     verifier_subreg:OK
  Summary: 1/87 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 73b5b0cf6706..101f2a8bff7f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
 /* This file contains sub-register zero extension checks for insns defining
@@ -990,4 +991,91 @@ l0_%=:	r0 = r6;					\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("subreg zero extend check across state pruning")
+__flag(BPF_F_TEST_RND_HI32)
+__flag(BPF_F_TEST_STATE_FREQ)
+__success __retval(0)
+__naked void subreg_zero_extend_check_pruning(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_len]);		\
+	r6 = 0;			/* 64-bit define */	\
+	if r7 != 0 goto l1_%=;				\
+	goto l0_%=;					\
+l1_%=:	w6 = 0;			/* 32-bit define */	\
+l0_%=:	r0 = r6;		/* 64-bit read */	\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+/*
+ * Same as the previous test, but with the pruning point inside a callee. The
+ * marking then also walks the caller frames, whose caller saved registers are
+ * NOT_INIT while the callee runs, and must not mark the call insn.
+ */
+SEC("socket")
+__description("subreg zero extend check across state pruning in a callee")
+__flag(BPF_F_TEST_RND_HI32)
+__flag(BPF_F_TEST_STATE_FREQ)
+__success __retval(0)
+__naked void subreg_zero_extend_check_pruning_callee(void)
+{
+	asm volatile ("					\
+	r1 = *(u32 *)(r1 + %[__sk_buff_len]);		\
+	call subreg_zero_extend_check_pruning_subprog;	\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+static __used __naked void subreg_zero_extend_check_pruning_subprog(void)
+{
+	asm volatile ("					\
+	r0 = 0;			/* 64-bit define */	\
+	if r1 != 0 goto l1_%=;				\
+	goto l0_%=;					\
+l1_%=:	w0 = 0;			/* 32-bit define */	\
+l0_%=:	exit;			/* 64-bit read */	\
+"	::: __clobber_all);
+}
+
+/*
+ * Same as the first test, but with the 32-bit define coming from a BPF_CMPXCHG
+ * fetching into r0. Unlike the other definitions this one is patched even where
+ * the JIT does not ask for zero extension, see bpf_opt_subreg_zext_lo32_rnd_hi32().
+ * The stack slot is left as STACK_MISC by the initial 32-bit store so that the
+ * cmpxchg does not alter it, otherwise the two paths would not converge.
+ */
+SEC("socket")
+__description("subreg zero extend check across state pruning with cmpxchg")
+__flag(BPF_F_TEST_RND_HI32)
+__flag(BPF_F_TEST_STATE_FREQ)
+__success __retval(0)
+__naked void subreg_zero_extend_check_pruning_cmpxchg(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_len]);		\
+	r1 = 1;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	call %[bpf_get_prandom_u32];	/* 64-bit define */\
+	if r7 != 0 goto l1_%=;				\
+	goto l0_%=;					\
+l1_%=:	r2 = 2;						\
+	.8byte %[cmpxchg32];		/* 32-bit define */\
+l0_%=:	r0 >>= 32;			/* 64-bit read */\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len)),
+	  __imm_insn(cmpxchg32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -4))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


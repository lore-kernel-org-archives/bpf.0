Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C503D348C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955491; cv=none; b=BojJA5SegFJ1fdbpNOlkKDUHRYFpY+DyJdTQ/lpsp+j0J8TwUIQhuzMb4lUQW5f3MYJyXsJuSmnqpiSeED4F62e8g0C+4UQ4PxbE2k2LSEIIoD2H7WQ9tL/yzkVDwuv9MJYTfHq/dEmYG57Cd6RWDLIiItLIYkKApkbhVCYEmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955491; c=relaxed/simple;
	bh=Y7gVX7FfOYg7mnMLfBdC+TAMb2utl1k4omy84nPegFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSJx10mdy7KxMybFHIFxX2t2hGd7Z1t9cig+JLBe6lEM6hslZf7Kttl5xHnJpdHXLPy127PIDcREEy8Kjp7RUFweaQWS6AUvHx92/493T/Rp/DzUdM3vLje2QCqjcvVYm8p+Umes7pNw+yojjn7V9oV0q0emCfs74Kryezupf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Dp1VKFSU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Dp1VKFSU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5BS9JwJSbIyoX31BgHq4yIgdST7f41NAw9RizqO7ncw=; b=Dp1VKFSUzf8yRLHiaCRwwBA+2E
	Y93aRyTNELqdw7TsPc1ED/j3w3hc73RSBKFTQdQmu/fD6ibV2FugnI+lKgREf1ukuvS04KK/5ii3v
	5eBNkGGglphuyKPa+j2PQkNZxzHc/yyaWF2YI7bM1/nz7rEeAxHHghHoD37e6OUBJhXQVyWsXpT61
	1TLphPwtqteu1ViGWRiEdYfgDIPxO9ddJ5WWUbriIVgqWaou7jGrtppbrhpGhw0rUDo4unKvt+xRr
	SZ5G/dkiNbHWLB3fDInvv02SJoSIIGoiIVkLDkhGdq6RghRm/AK1/y3jCPBxV1faT6xrPuXETsvAT
	izFWjvhg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrgbf-000JZ6-1u;
	Wed, 05 Aug 2026 20:44:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add test for arena pointer zext across state pruning
Date: Wed,  5 Aug 2026 20:44:44 +0200
Message-ID: <20260805184444.292828-4-daniel@iogearbox.net>
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

Add the arena counterpart to the sub-register zero extension pruning tests:
r6 is defined as an arena pointer twice, by a 64-bit copy on the path the
verifier explores first and by a 32-bit addr_space_cast on the path explored
second, and it is dereferenced only after the two paths meet. The second
path is pruned at the merge, so the cast never reaches the 64-bit read and
its zero extension has to be marked at the pruning point. The test is only
relevant for bpf_jit_needs_zext() architecture such as s390x.

  # ./vmtest.sh -- ./test_progs -t verifier_arena
  [...]
  #564/1   verifier_arena/basic_alloc1_nosleep:OK
  #564/2   verifier_arena/basic_alloc2_nosleep:OK
  #564/3   verifier_arena/basic_alloc3_nosleep:OK
  #564/4   verifier_arena/basic_reserve1_nosleep:OK
  #564/5   verifier_arena/basic_reserve2_nosleep:OK
  #564/6   verifier_arena/reserve_twice_nosleep:OK
  #564/7   verifier_arena/reserve_invalid_region_nosleep:OK
  #564/8   verifier_arena/subreg zero extend check across state pruning with arena pointer:OK
  #564/9   verifier_arena/basic_alloc1:OK
  [...]
  #564/26  verifier_arena/iter_maps3:OK
  #564     verifier_arena:OK
  Summary: 4/35 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_arena.c      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index b241bbcf54a8..b5f5b81a27e7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -635,6 +635,41 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
 	return 0;
 }
 
+/*
+ * The verifier walks from a sub-register definition to its 64-bit read to mark
+ * the definition for zero extension. When the walk stops at a pruned state, the
+ * definitions live at that point must be marked there instead, and that set
+ * includes PTR_TO_ARENA: on a pure bpf_jit_needs_zext() architecture such as
+ * s390 the addr_space_cast defining an arena pointer emits no zero extension
+ * of its own and relies solely on the mark driven zero extension, so a missing
+ * mark otherwise leaves the pointer's upper half undefined.
+ */
+SEC("socket")
+__description("subreg zero extend check across state pruning with arena pointer")
+__flag(BPF_F_TEST_RND_HI32)
+__flag(BPF_F_TEST_STATE_FREQ)
+__success __retval(0)
+__naked void subreg_zero_extend_check_pruning_arena(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_len]);		\
+	r9 = %[arena] ll;				\
+	r2 = 0;						\
+	r2 = addr_space_cast(r2, 0x0, 0x1);		\
+	r6 = r2;		/* 64-bit define */	\
+	if r7 != 0 goto l1_%=;				\
+	goto l0_%=;					\
+l1_%=:	r6 = 0;			/* 32-bit define */	\
+	r6 = addr_space_cast(r6, 0x0, 0x1);		\
+l0_%=:	r0 = *(u32 *)(r6 + 0);	/* 64-bit read */	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
 #endif
 
 static __noinline
-- 
2.43.0


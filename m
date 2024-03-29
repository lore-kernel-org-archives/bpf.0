Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBE3D0AD
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739055; cv=none; b=bMtGwBBW60gL8HsC+6IWlQvKalTLpnx/ImukIQAjE+llwlpmpz7fUAGHO+Cb5AWuI2pRxQ62xTNLC1jj/7zgtshk+kxcc2yT+F4fyncW5OEadLE/BwRxyIhqrMncG0DUrASwy1ImUkUdD0LHdUGu1T+xojCWb5XinfugjaVkCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739055; c=relaxed/simple;
	bh=34A23ZPAbo8EL2MuE7Mox2mBxKyW5YvaEfgJjY9mPLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eN4avEq6sCEpGG1XMDfROdWlqWmPr0MK3CQNObcsxJ3sbadCjNkU2zpuzF2948vb5cSs+Nr7PXQCaxXKs/JRm8jJ/iVnKnM1X9w6FYFk1NBNPr71blTLTpxn/1j/qNK0ivXALkZp+MYIszq/hu4hmOBr6yfp3oS6vbaeOCwQ4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha3Juce8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha3Juce8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74284C43390;
	Fri, 29 Mar 2024 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711739054;
	bh=34A23ZPAbo8EL2MuE7Mox2mBxKyW5YvaEfgJjY9mPLo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ha3Juce8B7/G6hOtUwVBxxOtNmbtSFpgMqnHhHrlFtgTb4ljex3eSr21O8Digbzff
	 Z6q2ZLn778ug9oWvOTHKW5789gc727ZFwGwpbAi3QBgIz1imUfgrd0LFdUUepCJPzY
	 jvEMzlvlijqB9PG25C9nzXunyF5f7ddh+1itaLUqPGNYJNZeMglp5UJAlOiR1lK0QF
	 gdQs087C6jFly6+RIJf79YYHNd8zMk/7rrOEr5HR7DngPf0BLDSLobbAFbG0mUeMAU
	 o65avJdyeeVk6ofsn4cLLPPDBRStA643PQlUiGAOr16v5Z2IdJfBM5VwZPAGXMWk4F
	 44hoyEq/BU/lg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next] selftests/bpf: make multi-uprobe tests work in RELEASE=1 mode
Date: Fri, 29 Mar 2024 12:04:10 -0700
Message-ID: <20240329190410.4191353-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF selftests are built in RELEASE=1 mode with -O2 optimization
level, uprobe_multi binary, called from multi-uprobe tests is optimized
to the point that all the thousands of target uprobe_multi_func_XXX
functions are eliminated, breaking tests.

So ensure they are preserved by using weak attribute.

But, actually, compiling uprobe_multi binary with -O2 takes a really
long time, and is quite useless (it's not a benchmark). So in addition
to ensuring that uprobe_multi_func_XXX functions are preserved, opt-out
of -O2 explicitly in Makefile and stick to -O0. This saves a lot of
compilation time.

With -O2, just recompiling uprobe_multi:

  $ touch uprobe_multi.c
  $ time make RELEASE=1 -j90
  make RELEASE=1 -j90  291.66s user 2.54s system 99% cpu 4:55.52 total

With -O0:
  $ touch uprobe_multi.c
  $ time make RELEASE=1 -j90
  make RELEASE=1 -j90  22.40s user 1.91s system 99% cpu 24.355 total

5 minutes vs (still slow, but...) 24 seconds.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile       | 2 +-
 tools/testing/selftests/bpf/uprobe_multi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9eb40d6343..b0ac3dd80acf 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -759,7 +759,7 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 
 $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index a61ceab60b68..7ffa563ffeba 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -9,7 +9,7 @@
 
 #define NAME(name, idx) PASTE(name, idx)
 
-#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
+#define DEF(name, idx) int __attribute__((weak)) NAME(name, idx)(void) { return 0; }
 #define CALL(name, idx) NAME(name, idx)();
 
 #define F(body, name, idx) body(name, idx)
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252A482E9
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733820; cv=none; b=Cf2WLgWxAWI9Qkwtnj/xYKyqnhX6kDxWtCxukkS3A/BU785EHotjORNCglVilVIe/Pqg9GZWUGQD1UyYQqdvb45ITIEErcHjSaqVdxCRk3mxQ9YQbZ5ZS9G/rMEKFESZChv7HWXNS1cSvbSc3+A4y37Sit3b25/eAOukZ89JtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733820; c=relaxed/simple;
	bh=xEpw/8qXhntk1WFLGcX9yhZXFyRArn3rO/N7YoSWSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XosXq1l86sdZAl7I+4VG13PHbOIIHTMz4buglmqlA2J9jD1JIx3601qWPycnH8FUMYRsmCMS/R7tK75Ve2gqEIjpE8E6bhDhwVqimGYAJW7Aiztck7ITbLzt1HdzbGFYfRV1xn3UGJeTs9+b5kBJgvezr7Q6LoYRhioc1zZS/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCh5CxrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCh5CxrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2269DC433C7;
	Fri, 29 Mar 2024 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711733820;
	bh=xEpw/8qXhntk1WFLGcX9yhZXFyRArn3rO/N7YoSWSRA=;
	h=From:To:Cc:Subject:Date:From;
	b=iCh5CxrYDAdANiI1Q7+YivMWFAijBlh/q64Oy8h4/HV9xfT5KNxYK58w84d9Xon8A
	 7SusA1Q2lhMXlIQoGNp9b5E2vOCQyqbZwD/usJvr9tMnemqJV7jqwtvCc9i/tisuJ9
	 qepKbTOW8BT2XNrVa5tJI5zRFSAVc6QIC66ZMEym6xlbYM+mUOyN5GBOjVH1o27eb4
	 OJQakn5dbEy0fc/ElQFVVoo3EeGSIWy/JQoU1oG/2neMiyk+WcRQvYMiuTwQ5eT/cj
	 iPhLcd2dkU5gs0KgycqO2uiklxwXtBB044bw5D7sP/4AB05SlHfQqN7RuL8e4QULL5
	 zagrsvd/PyLqg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: make multi-uprobe tests work in RELEASE=1 mode
Date: Fri, 29 Mar 2024 10:36:54 -0700
Message-ID: <20240329173654.3174156-1-andrii@kernel.org>
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

So ensure they are preserved through noinline + asm volatile trick.

But, actually, compiling uprobe_multi binary with -O2 takes a really
long time, and is quite useless (it's not a benchmark). So in addition
to ensuring that uprobe_multi_func_XXX functions are preserved, opt-out
of -O2 explicitly in Makefile and stick to -O0. This saves a lot of
compilation time.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile       | 2 +-
 tools/testing/selftests/bpf/uprobe_multi.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index a61ceab60b68..e38228563766 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -9,7 +9,9 @@
 
 #define NAME(name, idx) PASTE(name, idx)
 
-#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
+#define DEF(name, idx) \
+	int __attribute__((noinline)) \
+	NAME(name, idx)(void) { asm volatile (""); return 0; }
 #define CALL(name, idx) NAME(name, idx)();
 
 #define F(body, name, idx) body(name, idx)
-- 
2.43.0


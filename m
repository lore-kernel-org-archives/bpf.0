Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A72C68D
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754333; cv=none; b=kKyxJQEyZIwSoFUMKUYW3ZSKwK1VIEktT32vYEzUWleOfH+WWT7MN/BWbjohe+o0g1EWkl8xNe8Ag8KMOuia2ZNZk2o/pouiLcR3L///J0mJ3O1euIrQLbV2Uqdr+/EwtIA3/IjmTWiQ+spzTvcW8DPW1r7rgpvZzjVOZj/LGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754333; c=relaxed/simple;
	bh=Znc57W0nRD+Iz1lbrmnDfpTHcuBN9RCnZRrXZq53IYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pD9W2oW6obW2WJjKgvEqkMRZsRGRYTIj9Ib3kRRNsk/3vUIf24yXEWWbrbiJzp7v/v/Hw9gysvEuIMGMvlW6nbS17NNOPUg9jV5uRjb/KsUyB0sZ9+oPdjH/2rf/+tzYiJYYH4kT0+UNnfkqH6jnZ6mUI9poDIS87I9UY2E3dGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyzQG6x0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyzQG6x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F28CC433F1;
	Mon, 18 Mar 2024 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754332;
	bh=Znc57W0nRD+Iz1lbrmnDfpTHcuBN9RCnZRrXZq53IYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyzQG6x0l5xo9y3sg4jkPckYRAGWYEtQzfWZxcKqOho3DK157BwFatamA1fo4W6HF
	 B9sTSqcPXFWJEwcLczyU9k54TpATWNvjU6scX0Vui+v7VXg+hhd4Psumsg7MO1al0o
	 SjMZ/2dHUmkG+XR5mfNZ7PbJlX6SFslNRb9urFbMR9zv9UVb0ND7UlJtJ019yWJBhz
	 cBrbkwgu76Hv7sz6PJWSHYt0B5F2BDexwQkwWFWQGJudOUmNxMZO2z0kjWt5tH5Q5Z
	 dL2ASOhQNCOeQwONQ3FkJl+US1E7Ra7G02ykaGfhwswNl3uhJVwk+IA6Qf1IU4xmPX
	 JLugryTAZu/GA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: Mark uprobe trigger functions with nocf_check attribute
Date: Mon, 18 Mar 2024 10:31:38 +0100
Message-ID: <20240318093139.293497-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093139.293497-1-jolsa@kernel.org>
References: <20240318093139.293497-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distros seem to enable the -fcf-protection=branch by default,
which breaks our setup on first instruction of uprobe trigger
functions and place there endbr64 instruction.

Marking them with nocf_check attribute to skip that.

Adding -Wno-attributes for bench objects, becase nocf_check can
be used only when -fcf-protection=branch is enabled, otherwise
we get a warning and break compilation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/compiler.h                     | 4 ++++
 tools/testing/selftests/bpf/Makefile               | 2 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 7b65566f3e42..14038ce04ca4 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -58,6 +58,10 @@
 #define noinline
 #endif
 
+#ifndef __nocfcheck
+#define __nocfcheck __attribute__((nocf_check))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e425a946276b..506d3d592093 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -726,7 +726,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -Wno-attributes -c $(filter %.c,$^) $(LDLIBS) -o $@
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index ace0d1011a8e..3aecc3ef74e9 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -137,7 +137,7 @@ static void trigger_fmodret_setup(void)
  * GCC doesn't generate stack setup preample for these functions due to them
  * having no input arguments and doing nothing in the body.
  */
-__weak void uprobe_target_nop(void)
+__nocfcheck __weak void uprobe_target_nop(void)
 {
 	asm volatile ("nop");
 }
@@ -146,7 +146,7 @@ __weak void opaque_noop_func(void)
 {
 }
 
-__weak int uprobe_target_push(void)
+__nocfcheck __weak int uprobe_target_push(void)
 {
 	/* overhead of function call is negligible compared to uprobe
 	 * triggering, so this shouldn't affect benchmark results much
@@ -155,7 +155,7 @@ __weak int uprobe_target_push(void)
 	return 1;
 }
 
-__weak void uprobe_target_ret(void)
+__nocfcheck __weak void uprobe_target_ret(void)
 {
 	asm volatile ("");
 }
-- 
2.44.0


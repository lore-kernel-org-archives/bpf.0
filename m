Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E34A4839
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358777; cv=none; b=qhVAtY5wvFV14qKT4/n71mLSDZlakouBuSpn5d8EgFBgNYIcw/U8JgDGg5MLM4yxHyiqXbGqgdg36YkI2ZEu+3qHxCkeh2apXZ3sLi8rAGJSqNj2q0TCwfeSoUskofDNyF6IN9mwmGzFWfcfPG4ixmT+kllCfLuswKQUS13N1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358777; c=relaxed/simple;
	bh=fQqkJ+FRxFpfRvJ09eS+soQ+a3xAiEToaWPlJT7o9+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoRoU0kLQx8CtDjQWRvCH6teAz4s+BXsydQ/BfONrVs8ca+pMa+tyqdaWmFye97efu5FF+KiIxOGz5LIhhNd6TAuGjmr04TJ5HeoVGch+tWOLHQMYl3v4rNu84qTgZ+ocfQY8xv17E4xpg4hFOut1Ps2SKfjCEISm3irvS0nQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Bu9/QwJ9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Bu9/QwJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dwnGeNSwJSc1p8Amp+mGpOQXvnEDmW1YabCYIOGjBuA=; b=Bu9/QwJ9GaauaW5gIxUlKBvp0c
	jXD0CxXfmRBjaYo47ZthtgTotWeOFsLYa+dJy6Ls2VGlJf3uC3HstXCR02ZjgAhLiG6+QGQEL+V1F
	CwdJG1qMs32JI3dhE9y7f3akzF8gByjhNJ8QHOjB9/SAGKkFlZqEP1VPYlz5uj3T8vcgww9ZsFWac
	X5um1M7+g9o5KVDujwCQq/UP5YiAUoZtvGHfWWPvbeHz2OJHeZwfpu1PI1erlBfw04+DWUBnZgeLv
	yYOa5Zo8cLcNoiWBRtjt9QbB7uZxvpve3i1VU44uHj6F+4lCC3D/FMyubnoU/bsj3fXqF/sfrH/ZG
	I4KVB6lQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6O-000Jkt-1Y;
	Fri, 25 Sep 2026 19:52:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 11/16] selftests/bpf: Add tests for the indirect jump edge limit
Date: Fri, 25 Sep 2026 19:52:38 +0200
Message-ID: <20260925175244.1136329-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Add tests for the indirect jump edge limit to the verifier_gotox suite: two
programs whose gotox instructions are their own jump table targets, one in
a single subprogram and one split across two, exceed the limit and are
rejected, and a chain of gotox which sits exactly at the limit still loads
and runs.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_gotox
  [...]
  #644/30  verifier_gotox/too-many-gotox-edges:OK
  #644/31  verifier_gotox/gotox-edges-at-limit:OK
  #644/32  verifier_gotox/gotox-edges-across-subprogs:OK
  #644     verifier_gotox:OK
  Summary: 1/32 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 4931a77ba0b2..b917c2e14283 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -457,6 +457,100 @@ __naked void spill_fill_ptr_to_insn(void)
 	: __clobber_all);
 }
 
+/*
+ * Emit each table entry next to the instruction it targets. Numeric labels
+ * can be reused by .rept, while %= keeps table symbols unique per asm block.
+ * BASE is the code section: libbpf relocates section-relative byte offsets
+ * to instruction offsets in the loaded program.
+ */
+#define GOTOX_TABLE_BEGIN(COUNT) \
+	".pushsection .jumptables,\"\",@progbits;" \
+	"jt_%=:;" \
+	".global jt_%=;" \
+	".size jt_%=, 8 * (" #COUNT ");" \
+	".popsection;" \
+	"r1 = jt_%= ll;"
+
+#define GOTOX_TABLE_ENTRY(LABEL, BASE) \
+	".pushsection .jumptables,\"\",@progbits;" \
+	".quad " LABEL " - " BASE ";" \
+	".popsection;"
+
+/* N gotox instructions, each targeting all N gotox plus the final block. */
+#define GOTOX_SELF_TARGETS(N, BASE) \
+	GOTOX_TABLE_BEGIN(N + 1) \
+	"r0 = 0;" \
+	".rept " #N ";" \
+		GOTOX_TABLE_ENTRY("1f", BASE) \
+		"1:; .8byte %[gotox];" \
+	".endr;" \
+	GOTOX_TABLE_ENTRY("2f", BASE) \
+	"2:;"
+
+#define GOTOX_OPERAND \
+	__imm_insn(gotox, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0, 0))
+
+/*
+ * Count edges even when their targets are already discovered. These
+ * programs deliberately use a scalar: the CFG edge limit must reject them
+ * before symbolic verification reaches the invalid gotox operand.
+ */
+SEC("socket")
+__description("too-many-gotox-edges")
+__failure __msg("number of indirect jump edges in the program exceeds")
+__naked void too_many_gotox_edges(void)
+{
+	asm volatile (
+		/* 1000 * 1001 = 1,001,000 edges. */
+		GOTOX_SELF_TARGETS(1000, "socket")
+		"r0 = 0; exit;"
+		: : GOTOX_OPERAND : __clobber_all);
+}
+
+SEC("socket")
+__description("gotox-edges-at-limit")
+__success __retval(0)
+__naked void gotox_edges_at_limit(void)
+{
+	asm volatile (
+		/*
+		 * 1000 gotox * 1000 targets = 1,000,000 CFG edges. At run
+		 * time, each block loads the next table entry and jumps to
+		 * the following block, so the program terminates.
+		 */
+		GOTOX_TABLE_BEGIN(1000)
+		".rept 1000;"
+			GOTOX_TABLE_ENTRY("1f", "socket")
+			"r0 = *(u64 *)(r1 + 0);"
+			"r1 += 8;"
+			".8byte %[gotox];"
+			"1:;"
+		".endr;"
+		"r0 = 0; exit;"
+		: : GOTOX_OPERAND : __clobber_all);
+}
+
+static __noinline __used __naked void gotox_edges_subprog(void)
+{
+	asm volatile (
+		GOTOX_SELF_TARGETS(750, ".text")
+		"r0 = 0; exit;"
+		: : GOTOX_OPERAND : __clobber_all);
+}
+
+SEC("socket")
+__description("gotox-edges-across-subprogs")
+__failure __msg("number of indirect jump edges in the program exceeds")
+__naked void gotox_edges_across_subprogs(void)
+{
+	asm volatile (
+		/* Each subprog has 563,250 edges; together, 1,126,500. */
+		GOTOX_SELF_TARGETS(750, "socket")
+		"call gotox_edges_subprog;"
+		"exit;"
+		: : GOTOX_OPERAND : __clobber_all);
+}
+
 #endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
 
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


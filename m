Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F068407CFF
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641259; cv=none; b=lq+yANnPnd6HqOFznfmbCj3xgradvABc6MdO6WUNvfO5TeKifeuEPWkc+Re/I3Fkvm6TC1MsyrcU71KcsRR+yMZAdxotIcRQc6UvpBQeL4Gxj/1K4vDX+24uZfh5D+FKNjJUp1MJRwgDsbe31naUpUc4iP0zd+jUUkMByf2L5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641259; c=relaxed/simple;
	bh=TQ4Rgf5qd8xRNpGDkUWTndLmaxWA46Ns60JTPwI4W5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7xKsyGuOz4112U/kJbeJLOesSsPZ8YVytn2FeFyfXu1LLdh8RExTJfv/8ZcV3ucmBaDf0OvCu3Gi/bCh66r9wcYxw/ct+zXVhpCe16GBPcwNjbQIqvnCepTYXA0IJczQ8Lt5m/nWx6ZygUAbwtrD9nPUwtpmGCqRkEcpbGFSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE/UTU6J; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE/UTU6J"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eedc94d37so765094f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641255; x=1781246055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nl2PQhH5a+7Pfo1XR+dLZkIvECajZ41TVuJEhJdnTI=;
        b=QE/UTU6JTujJQTXreRFpedDORLgR/4vOujrizcNJazktwluvHLU7Gm6AdGfSCcTdPN
         DPT0+ZivsIrET7MYwOLNx65Tm+aNmSnw2iTnNXkSgeDrjtQt18c9fgScYrIdngu35cvz
         tDHVclVsIMhf44yWZ0VIj/EP65MODXVDpf7oynIUsQyHrVkVqNH7A76N0sPEksBMHsa7
         hImdXM9EetiCYSZeVa3zS9ggZCQp9SoruTLZyX992SKXC3qRoIwjr56hA3sRnzyNF/SK
         hPLIerzLkH0tFY21lvICmt9MJrhrTndBZQYz2h95i/onZ360lYNJ2Bx3NgciIeEpOcb/
         xt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641255; x=1781246055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Nl2PQhH5a+7Pfo1XR+dLZkIvECajZ41TVuJEhJdnTI=;
        b=ft9JObo6IvbbGX82GBp3AGJizG/7z2qkD2nVdesFdOKgYm5EtL4aHM/Z3S0lH92g0l
         SbUyoMSUD2MtBuLfYw3+Q/O0wFriItfzc+TkpsFbFYV2rddqSuSK6bzNKnX5aZAve3lr
         TrEnL3QMiw0rqddmdsFJjE6zZV4cg8+bmhrNTSQdm5Di4fc9rcgf24p+slLRvcu9ADIA
         QHWIr9jDns2yOb/Y6iD3Fk25jXxW4FxfNQsvk0/xiQl3TYwEm4Qi0MsBq3CN62SE9Ov7
         YuaHB4db27QT9WYeAntoGUJ9Q4zCojgD+nzNysByd/fcipqkYq3rFr30e3JaUv1GjzTY
         ecPA==
X-Gm-Message-State: AOJu0YyfcRCH2XEGxs8Z+NvQpM1SxoDYvUqQZQ1hd6ARRs2zQGdeFQ8P
	hNBdSmAx1LR55lebGkHrcAao62x+v21o8SDIWlp5yq4vv6IqQDMxtuN8ryIAyBil
X-Gm-Gg: Acq92OGCg5NETofc2VANH1epUgXQLIl7elDzxRqDGgvAOdp4GIIW9hEdFePqCXBtPS8
	l8do8yrfLagwzCxJRnCFQG+0ZKHIiPriWdF7/Z71OgNMsR1BaKYZKe6RUgUMVoAiNQTDKNRLwD+
	unapPbstCD+mIZyXX+Xl6qCbTtadj7mcVPkriYM2bSG2fSqQNG4Zs4cvPFcu0YECkDjnw1cPgqP
	WtEMcLGTGpLGYiE2zM/n6Hp9FKRVePm8BIR2VIkXGljP0lBLc4iS2/Jp+wjSpU6RXZwTchGtCGF
	3iFhroUkwyxcUT1yCbjh++URz+jU/VJuRcxH4JKrsZXF9xzu1SMBXaM1CB30iykpZmO7ljkqDHh
	TrK8Cqm9qgdrgJeFgGkQUWkS4TDKShsAzUgBqiXNytuzeaiXTbgCN/yXQuPpus1STThoO2PaIIg
	PCOwyD/Fxwics+tnoKdhIoh3kIMEVxP8NkQXpUYGWdR2TcXHs07l6j4JCW6z3JTqteRvBd9J3zE
	lpjanzbXw4IIFbUo0H0mHst+3d/lcptLlPyp9Iu1Xz9uWZF0x+3QR67XwSx+t2uGuyJE6k6drcr
X-Received: by 2002:a5d:5049:0:b0:45e:f765:ff9 with SMTP id ffacd0b85a97d-4603063d61bmr2609088f8f.24.1780641254367;
        Thu, 04 Jun 2026 23:34:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm23942804f8f.6.2026.06.04.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/17] bpf: Add verifier diagnostics report helpers
Date: Fri,  5 Jun 2026 08:33:51 +0200
Message-ID: <20260605063412.974640-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5508; i=memxor@gmail.com; h=from:subject; bh=TQ4Rgf5qd8xRNpGDkUWTndLmaxWA46Ns60JTPwI4W5Y=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt/DuUuH5J2MmT774da2Y+KOP/4/9M9i5MLNYXO70I 6lXmcHVHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhISCjDP+UVh7m5wsTXdVU/ mrhe+lz8Hb3H70K2599gNvgj5K754Twjw8Rj1h4fvy6MSavaJlDGFnXnS++TSzvW/Xm/N/TXCvP sNCYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a small diagnostics renderer for verifier reports and wire it into the
BPF build. The initial helpers emit the common text structure: a failure
header plus reusable report sections.

Wrap report prose at 120 columns so Reason and Suggestion text stays readable
without changing source or instruction gutters.

No verifier call sites use the helpers yet, so existing verifier output
is unchanged.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/Makefile      |   2 +-
 kernel/bpf/diagnostics.c | 110 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  19 +++++++
 3 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/diagnostics.c
 create mode 100644 kernel/bpf/diagnostics.h

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4dc41bf5780c..90255d80e5be 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
new file mode 100644
index 000000000000..a6684adc0c31
--- /dev/null
+++ b/kernel/bpf/diagnostics.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+#include <linux/bpf_verifier.h>
+#include <linux/stdarg.h>
+#include <linux/string.h>
+
+#include "diagnostics.h"
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+#define BPF_DIAG_TEXT_WIDTH 120
+#define BPF_DIAG_TEXT_INDENT "  "
+#define BPF_DIAG_MSG_LEN 512
+
+static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
+					    const char *first_prefix,
+					    const char *next_prefix,
+					    const char *text)
+{
+	const char *prefix = first_prefix;
+
+	while (*text) {
+		const char *line = text;
+		int prefix_len = strlen(prefix);
+		int text_width = BPF_DIAG_TEXT_WIDTH - prefix_len;
+		int len = 0, last_space = -1;
+
+		if (text_width < 1)
+			text_width = 1;
+
+		while (line[len] && line[len] != '\n' && len < text_width) {
+			if (line[len] == ' ')
+				last_space = len;
+			len++;
+		}
+
+		if (line[len] && line[len] != '\n' && last_space > 0)
+			len = last_space;
+
+		verbose(env, "%s%.*s\n", prefix, len, line);
+
+		text = line + len;
+		while (*text == ' ')
+			text++;
+		if (*text == '\n')
+			text++;
+
+		prefix = next_prefix;
+	}
+}
+
+static void bpf_diag_print_wrapped_text(struct bpf_verifier_env *env,
+					const char *text)
+{
+	bpf_diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT,
+					BPF_DIAG_TEXT_INDENT, text);
+}
+
+static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
+				     const char *fmt, va_list args)
+{
+	char buf[1024];
+
+	if (!bpf_verifier_log_needed(&env->log))
+		return;
+
+	vscnprintf(buf, sizeof(buf), fmt, args);
+	bpf_diag_print_wrapped_text(env, buf);
+}
+
+void bpf_diag_report_header(struct bpf_verifier_env *env,
+			    const char *category, const char *problem)
+{
+	char problem_buf[BPF_DIAG_MSG_LEN];
+
+	strscpy(problem_buf, problem ?: "", sizeof(problem_buf));
+	if (problem_buf[0] >= 'a' && problem_buf[0] <= 'z')
+		problem_buf[0] += 'A' - 'a';
+
+	verbose(env, "\nVerification failed: %s: %s\n", category,
+		problem_buf);
+}
+
+void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	bpf_diag_report_section(env, "Reason");
+
+	va_start(args, fmt);
+	bpf_diag_vprint_indented(env, fmt, args);
+	va_end(args);
+}
+
+void bpf_diag_report_section(struct bpf_verifier_env *env, const char *title)
+{
+	verbose(env, "\n%s:\n", title);
+}
+
+void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	bpf_diag_report_section(env, "Suggestion");
+
+	va_start(args, fmt);
+	bpf_diag_vprint_indented(env, fmt, args);
+	va_end(args);
+	verbose(env, "\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
new file mode 100644
index 000000000000..f13a939722bf
--- /dev/null
+++ b/kernel/bpf/diagnostics.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+#ifndef __BPF_DIAGNOSTICS_H
+#define __BPF_DIAGNOSTICS_H
+
+#include <linux/compiler_attributes.h>
+
+struct bpf_verifier_env;
+
+void bpf_diag_report_header(struct bpf_verifier_env *env,
+			    const char *category, const char *problem);
+void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
+	__printf(2, 3);
+void bpf_diag_report_section(struct bpf_verifier_env *env, const char *title);
+void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+	__printf(2, 3);
+
+#endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0


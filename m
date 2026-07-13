Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D637756A
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957156; cv=none; b=bRfN2wehL5ynpAlt27KAZPaLF65H3EY2htTPW8yVpwyuYusLrdQWKPjmy7itY0bwZqGxy+gUtDU6YJXkE6DypT3PvpPoivE1nCh7PMamm7XRqT2gxdC/7HtJUllla/6wZEfnXtyQS2StG4u8oQFIcEjFjvTmgWSMWNRgMCjWPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957156; c=relaxed/simple;
	bh=qlM0m8Eb7qzd+V4BSPvzXh+Am5pfDSg9vIlmHLw5VO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdoN3IbgOiaYgInuPsWxgJWAlMv9M5MFnetoX+P+Eh3AjuwjDg2VLZIQEmsZ+4PaRXAi3mUCNpK3oJcSTOUrk4IgnqIeJEXBQ42BT8S6HQkbgQobB9BNipz///Z02VOQGzDl+YzYxX8sEwO/jxW9STvTD435WBmXhwNqKVaAvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFCFWzCz; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFCFWzCz"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4619e6c826bso1101972f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957154; x=1784561954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2Njoy9tx0njOy/DeQT8rT3WxQhsMn2Vhr27H29+egQ=;
        b=eFCFWzCzDLDXNsII36VhNz0L3UOfoTbPglQ1x55xGU8MMK4id4xbx9WFuMqpnpDMPg
         F/wn0QEgyJY50jLOwvFQCdnjwVXonU7beX0Tm5BHF1+6t7w33OG+Ky1TTenxljHRmSOI
         SfqTY+cCUaKZ4McW3onut7fy1BpZQI5k3clDLJFxDsN4XbZHcJF82AJwHrSV2jqt/RNP
         1wjoGY/89sG172EEBn+suVHzhbdP1SWXGgKjKS2Spre3Ncb/120pKFirq/2bUfIWwPEA
         w6UUKTbKAUZPnrYj/YHyfmi/GSeen5oAlZaZdznZCQBc2aUTCBqH/vgoX3CFLX8oWB26
         b9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957154; x=1784561954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2Njoy9tx0njOy/DeQT8rT3WxQhsMn2Vhr27H29+egQ=;
        b=Mf3JzkL42nWQFGn8ZHMTrfaUPcij4WLrfyUXcqh8nAou2dw7fLF76cC9W+IaRMzxUE
         iB2idwFbIW/HVYKqBxULYEJVX+TU913Sdh2F2xSF/8CKWkB94/P4TtzEH9xl6OLhRMxP
         KG+MA0FeOuL7M1VZpLHkdAJ8ORaTzc0tCCAZ7n1OdhU+eJ3FIlw6MrDydn83j2hhB3fo
         jFsscUCWM+jN+JI4L5rJtIs8s8omaSQ3FTPUP3sWrscz9ZoV2/HmDaZ5TCHUZcZ7NDQV
         N2g3fTFYv5VyNuSxc2AHwwDcMFXKf4I3Z+hioISdqtsTqOAYNvS1tgIvzAqs5aVB3JoB
         vT0g==
X-Gm-Message-State: AOJu0Yyn6faOkgVO6AqyA/6zH2RtGGm4Gk6qhoL3LHnv9/EJ0yhnbSsE
	mV5rap2GWB41upRZmkciKajtk5QPo5f42pZCX4leMsVNHSNwQXc7eX0RIW3Ta/fQ
X-Gm-Gg: AfdE7clCPpDjEKHaINpjZPPB+D3CKQtalSD66x/DvTETE4Hy7oh5eoRgRNuXcWAQX2+
	JsTh3MVErm5GzwT8cmjgs+2lacSjbCWRXlJAWoVLxArjNBIlPKDd2MMI9XWurcbRHCjVz6+z+tY
	Ys4YhvPI00N9xDwTdxJcBVmWlVejI+KMYsATeOMgluKzHBObLm54LrZGBxwjp7PoHJNYfsBE8WF
	lhAb7+GdoJ5GoiQZ3GIuQ12lWkXpdjQhpVf3qyFXNPuRYXMRRdcpAZXlKJvz10kuvTPQeeJVshu
	1aBaDieRKC7lDuVy/PZ1Q+0cXx3I12Jw8hw3nlDgMP/cIdnr6xVQFfarZ1yJDzHyTpHFPY2ktU+
	n3TiZyVYl/PrFu4ld0ee5xcxeWUXKBP20w8Dxeh/84z6sM0ZV7bFildZDFEk/IGNe4DLS/lrT5J
	HZJzkqRdLGTLoQit+dDMOtZp16VXhAzRZzj2bdDUKwxnwY6MAnGmnG5gXqW0Sfa57n4Fr8PydGg
	m0WwpoAcS139saA9Cwyj/eeLArqwh9yXp0PA6JtrR0ydvm96Otdc9U=
X-Received: by 2002:a05:6000:24c6:b0:471:9fd4:73e with SMTP id ffacd0b85a97d-47f2dcf579bmr10886711f8f.44.1783957153528;
        Mon, 13 Jul 2026 08:39:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm166035f8f.27.2026.07.13.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/17] bpf: Add verifier diagnostics report helpers
Date: Mon, 13 Jul 2026 17:38:50 +0200
Message-ID: <20260713153910.2556007-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6733; i=memxor@gmail.com; h=from:subject; bh=qlM0m8Eb7qzd+V4BSPvzXh+Am5pfDSg9vIlmHLw5VO4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURVY5/2d5/h5zqzm27/etn7zLo/TWlfrYT1lhktZFQ ZpsM392lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIsEowMkw9ktlbUrLw/76RD W835a1PlV1vuzrua/t7k8f2bQRfL3BgZOqYLT2tdIzjzt1zJ09lBGZ/+ln1PtGDddUj2puXj0qO azAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a small diagnostics renderer for verifier reports and wire it into
the BPF build. The initial helpers emit the common text structure: a
failure header plus reusable report sections.

Wrap report prose at 100 columns so Reason and Suggestion text stays
readable without changing source or instruction gutters.

Gate the helpers on normal verifier log output from the start, so
BPF_LOG_STATS-only loads do not collect or render diagnostics.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/Makefile      |   2 +-
 kernel/bpf/diagnostics.c | 157 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  16 ++++
 3 files changed, 174 insertions(+), 1 deletion(-)
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
index 000000000000..6d28a3481cfa
--- /dev/null
+++ b/kernel/bpf/diagnostics.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+#include <linux/bpf_verifier.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/stdarg.h>
+#include <linux/string.h>
+
+#include "diagnostics.h"
+
+#define CATEGORY_MEMORY_SAFETY "Memory Safety"
+#define CATEGORY_REGISTER_TYPE_SAFETY "Register Type Safety"
+#define CATEGORY_CALL_TYPE_SAFETY "Call Type Safety"
+#define CATEGORY_RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
+#define CATEGORY_EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
+#define CATEGORY_PROGRAM_STRUCTURE "Program Structure"
+#define CATEGORY_POLICY "Policy"
+#define CATEGORY_VERIFIER_LIMIT "Verifier Limit"
+#define CATEGORY_VERIFIER_INTERNAL_ERROR "Verifier Internal Error"
+
+#define BPF_DIAG_TEXT_WIDTH 100
+#define BPF_DIAG_TEXT_INDENT "  "
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env)
+{
+	return env->log.level & BPF_LOG_LEVEL;
+}
+
+static void diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+}
+
+static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
+					const char *next_prefix, const char *text)
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
+		if (line[len] && line[len] != '\n' && line[len] != ' ' && last_space > 0)
+			len = last_space;
+
+		diag_log(env, "%s%.*s\n", prefix, len, line);
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
+static void diag_print_wrapped_text(struct bpf_verifier_env *env, const char *text)
+{
+	diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT, BPF_DIAG_TEXT_INDENT, text);
+}
+
+static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
+{
+	char *buf;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
+	if (!buf) {
+		diag_log(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
+		return;
+	}
+
+	diag_print_wrapped_text(env, buf);
+	kfree(buf);
+}
+
+void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category, const char *problem)
+{
+	char first;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	category = category ?: CATEGORY_VERIFIER_INTERNAL_ERROR;
+	problem = problem ?: "";
+
+	if (!problem[0]) {
+		diag_log(env, "\nVerification failed: %s\n", category);
+		return;
+	}
+
+	first = toupper(problem[0]);
+	diag_log(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
+}
+
+static void diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+static void diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+	__printf(2, 3);
+
+static void diag_report_section(struct bpf_verifier_env *env, const char *title)
+{
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_log(env, "\n%s:\n", title);
+}
+
+static void diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_report_section(env, "Reason");
+
+	va_start(args, fmt);
+	diag_vprint_indented(env, fmt, args);
+	va_end(args);
+}
+
+static void diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_report_section(env, "Suggestion");
+
+	va_start(args, fmt);
+	diag_vprint_indented(env, fmt, args);
+	va_end(args);
+	diag_log(env, "\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
new file mode 100644
index 000000000000..be7ad5142726
--- /dev/null
+++ b/kernel/bpf/diagnostics.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef __BPF_DIAGNOSTICS_H
+#define __BPF_DIAGNOSTICS_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+struct bpf_verifier_env;
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env);
+void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
+			    const char *problem);
+
+#endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0


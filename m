Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE23C7689
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902788; cv=none; b=nL7b8YME8Sr++Vk6m4wZKrNlYFBRAxcRvHYhM4UbtKFISbJc06lFl5oQwKlB0mSM3DSniVUL22ekesu9+ntm/ue6VQXpMvs9EEnkTtby1daCFM57spsgThBmFfoaFQaKNts7dP5EjhQN4ILmk/2hnntCuSiIzUNv6fStgZb4WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902788; c=relaxed/simple;
	bh=9HMRf7BuLUhswMWYacAfom9ITdxVYgMsy6QCxH5yqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bov6VRYeXcYjeL8L3QKy2h9TISqeShwbdVCZg/Qw+5Wgw5Jni0u9GXjoGmBtH1VDR3bc0HNg16Gb3LlBhfRbQWa04T4ZWreQ9tfUvI9hWOkI8DAz9fJsEwUxthwShC7vLEhkoo3HnDkXzF/NZ/N5DdLJL7mVFVkgU1JjN4DcT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXUXEmCo; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXUXEmCo"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-461edb387ddso2414083f8f.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902777; x=1782507577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpmvjl+rV3Q0j8QVx800qGudToL26W/wXkVJKPx79G0=;
        b=oXUXEmCoE1vmqMr0/2G007gd87jphuzPeKt8PFLMjiO2qSha3zY7SeOG+Y+E0W/KJy
         kZgkryd56ewjMV9Om/1tBxYOPx+ZbDrFq9Pwfd6BNa3PHwcJWTgXjDDKiQ0lFUsAkkfG
         Bc5kX0AjnQ65iNnJ017yODXSET8A2jKWPrKiM9HYEigewjat4abPmcXaysHd3H4pBtPf
         FPCEeKMJjF6v3eKHINWuevdHO6FD8Q7I6JmIjjbbGc2Et3JFQ+PyUe2sOzprOA/N/SU/
         iDbxRD7qAfJyDmEuUFr4TegPicWdrdAQ8iGZDozg+K4brqWPk3wM2sZa7fKwKO/RzL9D
         OKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902777; x=1782507577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hpmvjl+rV3Q0j8QVx800qGudToL26W/wXkVJKPx79G0=;
        b=VtSM29ifCka/yKWR68ukV4hBnDoeEraAk+Sg7I5n2Dv/mIowMbCBV/Ag5wrmH9dyMQ
         oZe5Y3+dnxSuFzi/zAXRQ1BgXV+ww2jijOyN1vR3sRYZOAy48H3Wf6vam9sBDIxS/qQM
         BY2sFSmcVBROHAyz6Bg5yXQ6KUXiULW3d9o26U4LAJsuA+RxhT1huTD0zxZj69i+3zd5
         slpME+mYmwXliQTiU+dxKa94R3oumjCRY0Lf3IJVDzq8wND+4aq+x3KrZaTwXOIPQMM9
         3ivfu95yDujyt/1XoJ39S3UKYyJAg/zdcaiolRXqrv1Ge/Lo0nTqebeXXCHpbJFovKUV
         9toQ==
X-Gm-Message-State: AOJu0YzwF2fNoc9cQSv8D3M0WdBfH8Fp2VpNv1eaEB0XQHQVv7H//3Vz
	bJca8mdusXhK9ZnSLe2kTcfiKB+UMoGjp3iI1rlxdvLwZ6hcRrgK14tVyUn3p77a
X-Gm-Gg: AfdE7cnkkYVS9NEElRezU5RMhPWT53vu6/5LyclGmXg4jzv3unpluyVE0KFcC/2IeQz
	H3WKIywArhmZlTtaKEQovFo7rYvEB5iPDxold45fb/+oXdNtzXCwe9bNzt/ybYmzer0IWpompCW
	hobnhNV81F3bIFg25acC1Zc87vUIyxzGX9BNrGu7E/rU3Wp0XcmbxUFbq0xAR+foImqismfqT3P
	IqY3MGicgRNWycE5ukFwgaC6eOw/ze18kZY6lDMPvyX5OyOLsj1sOyM26OAu9M8mGHcpBhihmS0
	gaxlvT+AgRWf2wu5989r30MYDYKE3esYIhxW9Mw5Gjl+qQetOHRFBiywgt/ZREqk3LYNau3jL1w
	ceIozcIaJUAWI0dJR1bDesLxltWBh01o8JOsMFnL+W/bCFHiIOmSIEYXZn9WEjgVDsvTqFn2bfF
	FvwJo0mMU6RmZW0oFfQWoXk2HZ2/I9f4KumKPU8LGRfYYcyequ7cZIu/FT5IJQS315B2706RpGX
	Z4k6XpH4wMMSyXhjedveJ0H4iDNwZQem07DG5SB/Qf6eoGwFmB/wR0=
X-Received: by 2002:a05:6000:4691:b0:45e:891c:648e with SMTP id ffacd0b85a97d-4650694fddcmr7043438f8f.8.1781902777131;
        Fri, 19 Jun 2026 13:59:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5413sm2050104f8f.11.2026.06.19.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/17] bpf: Add verifier diagnostics report helpers
Date: Fri, 19 Jun 2026 22:59:14 +0200
Message-ID: <20260619205934.1312876-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7084; i=memxor@gmail.com; h=from:subject; bh=9HMRf7BuLUhswMWYacAfom9ITdxVYgMsy6QCxH5yqmk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05Z9zZ/xWH+FU4j/ydJId2/UaC21XI8PSYyuuRu7sm 1bCw+vbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkkv2Bk2CD43vaVwYKvjN/f Vb25waDbUaucGfug+SbLVnETw87ma4wMS1oOr4ypUm2fqyli8//Dz4mc97YeXLqxIHuyrk3yn5B bTAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a small diagnostics renderer for verifier reports and wire it into the
BPF build. The initial helpers emit the common text structure: a failure
header plus reusable report sections.

Wrap report prose at 100 columns so Reason and Suggestion text stays readable
without changing source or instruction gutters. Keep reusable formatting
scratch storage in the environment-owned diagnostics object.

Gate the helpers on normal verifier log output from the start, so
BPF_LOG_STATS-only loads do not collect or render diagnostics.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/Makefile      |   2 +-
 kernel/bpf/diagnostics.c | 170 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  16 ++++
 3 files changed, 187 insertions(+), 1 deletion(-)
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
index 000000000000..a18fd5aa395d
--- /dev/null
+++ b/kernel/bpf/diagnostics.c
@@ -0,0 +1,170 @@
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
+#define BPF_DIAG_CATEGORY_MEMORY_SAFETY "Memory Safety"
+#define BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY "Register Type Safety"
+#define BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY "Call Type Safety"
+#define BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
+#define BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
+#define BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE "Program Structure"
+#define BPF_DIAG_CATEGORY_POLICY "Policy"
+#define BPF_DIAG_CATEGORY_VERIFIER_LIMIT "Verifier Limit"
+#define BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR "Verifier Internal Error"
+
+#define BPF_DIAG_TEXT_WIDTH 100
+#define BPF_DIAG_TEXT_INDENT "  "
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env)
+{
+	return env->log.level & BPF_LOG_LEVEL;
+}
+
+static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
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
+		if (line[len] && line[len] != '\n' && line[len] != ' ' &&
+		    last_space > 0)
+			len = last_space;
+
+		bpf_diag_log(env, "%s%.*s\n", prefix, len, line);
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
+	char *buf;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
+	if (!buf) {
+		bpf_diag_log(env, "%s<failed to allocate diagnostic text>\n",
+			     BPF_DIAG_TEXT_INDENT);
+		return;
+	}
+
+	bpf_diag_print_wrapped_text(env, buf);
+	kfree(buf);
+}
+
+void bpf_diag_report_header(struct bpf_verifier_env *env,
+			    const char *category, const char *problem)
+{
+	char first;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	category = category ?: BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR;
+	problem = problem ?: "";
+
+	if (!problem[0]) {
+		bpf_diag_log(env, "\nVerification failed: %s\n", category);
+		return;
+	}
+
+	first = toupper(problem[0]);
+	bpf_diag_log(env, "\nVerification failed: %s: %c%s\n", category,
+		     first, problem + 1);
+}
+
+static void bpf_diag_report_reason(struct bpf_verifier_env *env,
+				   const char *fmt, ...) __printf(2, 3);
+static void bpf_diag_report_suggestion(struct bpf_verifier_env *env,
+				       const char *fmt, ...) __printf(2, 3);
+
+static void bpf_diag_report_section(struct bpf_verifier_env *env,
+				    const char *title)
+{
+	if (!bpf_diag_enabled(env))
+		return;
+
+	bpf_diag_log(env, "\n%s:\n", title);
+}
+
+static void bpf_diag_report_reason(struct bpf_verifier_env *env,
+				   const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	bpf_diag_report_section(env, "Reason");
+
+	va_start(args, fmt);
+	bpf_diag_vprint_indented(env, fmt, args);
+	va_end(args);
+}
+
+static void bpf_diag_report_suggestion(struct bpf_verifier_env *env,
+				       const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	bpf_diag_report_section(env, "Suggestion");
+
+	va_start(args, fmt);
+	bpf_diag_vprint_indented(env, fmt, args);
+	va_end(args);
+	bpf_diag_log(env, "\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
new file mode 100644
index 000000000000..5fb3271530a1
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
+void bpf_diag_report_header(struct bpf_verifier_env *env,
+			    const char *category, const char *problem);
+
+#endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0


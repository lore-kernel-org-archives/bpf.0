Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8A383C93
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577613; cv=none; b=Y2fI2nGh5yDuMcpIE0j1dc0k/G4LawsSbqCbgI4uE0pfrW8chBA3Qy/2WfjNS2VTWfaHC2RpGWMJ9IH/iulUloEIoMcE3MpjeFuZ5FpMYvX1KnEeEvZAuspheKKhaOGHHtalK4TOWYAxIDYIMOrxTf8j5zNj6RpzS683wYEcBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577613; c=relaxed/simple;
	bh=7dlSlk6ymyYB2kDkekspdr3qud1endRBgYTTMkVLe4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAZrt9tBibJkJb9a927oZ64IOemSew6Cw/d+nRKx1fINLoD5ofhvna+WwoW0utdc9tq1xYd5azWjyhdy4EhFRzgFK8vURXqNpnECXl3MoM8zjfRrJzsAj6FexsL3b9zT993VBKCmSyR/myP5ATUboKRxCqveIF4Dl9AKZHlR0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSuyIuzq; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSuyIuzq"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so216665e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577610; x=1787182410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi54zPyWPb0YNgT9IWMS3DNg+cW9Qhjgv0AxXMGOifQ=;
        b=VSuyIuzqDeTElvBzJ2sB+5gKXwk+oM9WNwWQ7l1znZsHj0dUSj2ZPZejSzCz5+f8Hw
         ku7zuSTy9jQZtVhQ0ANUcaaOzJVUjYYichekqrP3fIpRQIPV49NPGLeJg4XUpWwQaoR3
         SK75hWgiIX4SjlsSn6eZsamqI6NjVC8a241xQVC2g9lYo8ME1GaXL0DKVf09nlz9rjHL
         qDk0NLMQXC7PbX1RHKeoOgcHgW4ixZSYLKsAo3lAFORodjXXfyHPsNzfyuXUSWKZHoGZ
         3ndeFDuEPT6Vr/DNjXxMkJbvQ2eR965MdI7qEkL6QeXpwUcngv8CiOXAnB/XpDa4y3Fw
         DBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577610; x=1787182410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vi54zPyWPb0YNgT9IWMS3DNg+cW9Qhjgv0AxXMGOifQ=;
        b=Gpfm2Cht3Gr5VTXWCpbhzkkZwL0wsAK6EzJyJx/ASORr457FWPpp/95v3B5ccPHSIx
         w6bMn9tDy2TuTy/24NdLygEDpqZNuACm2FKQongmhwPLKJJCNUKFKIfMoGYLzCW/Fww0
         XJNwd3AQVpP9ZhWUn+o+KLVxSv6PM2J4sXrJVHDYzTe/0ko4PNHS8Wk8qxE9tevPPFtc
         VNJmNqHHxHlNvOKBC9eb6qwn7ydjAaaf1q6IBdxHxU2MzDKs6yzsDQUk78I9Ux0GblGq
         zQ++UidSH+v9lg5je37uAtXZdgtbYbhyNKK9jytTYRQu3zR8aERLNJjgI1MQ9u+hTbCr
         LjjA==
X-Gm-Message-State: AOJu0YyhYL8/gtq2MBbOwu10QtzQW79nOTIDOS5mIMsfJR5FFWQlN1FZ
	Zn8jp0WIvkVczXuWyvI9o/259H2o0b3g9FAMBQ5QU8X59lyK1Ag73xSPdHTMQeka
X-Gm-Gg: AR+sD10iyvFTTrNjqOgkmDrroR519mVEseHq0u6HVboxi1NrZbRuKj6HNTkexbMu3ab
	97XJMGJGyziVyMCxRW2b6yEPPvsGhleeW4evbW0MnqH0BhcQamxmXPXypQi2HNO0nIAbzUWPOjS
	6uTwAXGzBJAS094dqNepJFmss8Vn23QO8/RNgszborc1Hd8s+j4LU8HVtch2LVE2j0nteZyZPPj
	o9R3UoufYAmDWuOM6cMWNKvONg92fxmIJN+5KfQ2M7S+aO715aav3HLb1ALdVmlVTC9iVWg6v/n
	nFNP/IENq4NGrb15cvxVpF6DwygNQd4TD3BrXwO/lixeRlTWEhIPq9oAAJCg2cmiWPBm+vm98z6
	PUhXp/ZV2gxnpkXEePvnPlMJ2xI7tY7FOmTSoQD9rj2AVQY7pQxKgYkh5KvOxZmka3dTYGFVlWr
	+QTCDDZzUfAuwgFnkxF+isf4ViHvWGXbZrSh8Pts61ioywy7IPwDZZ9Rq/SPcLpU7m3mDjR03jC
	sPewgMbn+6/9S6fmdRpNvAiw6eg5C/lc4b11yyELVN+FD3xS5AtPNucTRoI+iR+OUGwCe/nU2fU
	K7lEaeNI0A0wmHPw2Kv0LnG9Qqg=
X-Received: by 2002:a05:600c:4585:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-499821bcfecmr12668525e9.1.1786577610073;
        Wed, 12 Aug 2026 16:33:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998216cf97sm12861875e9.14.2026.08.12.16.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 01/16] bpf: Add verifier diagnostics report helpers
Date: Thu, 13 Aug 2026 01:33:04 +0200
Message-ID: <20260812233326.3575958-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4120; i=memxor@gmail.com; h=from:subject; bh=7dlSlk6ymyYB2kDkekspdr3qud1endRBgYTTMkVLe4E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQfPQT99Za92ZFrl9k14bJsd8be+i6rqMjbFNnhYab Xalfuc6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCcJOzGBlmvWm/ufl69LIEvZ3S WyoYQid+Yi+59j3tlFJ53Y2PZ5qPM/wPkrWrVeB+Pi9tdUjofZXlWSpJ8+WOCCyIrL10K26rWDs zAA==
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
 kernel/bpf/Makefile      |  2 +-
 kernel/bpf/diagnostics.c | 55 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 16 ++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)
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
index 000000000000..ba57aabd399f
--- /dev/null
+++ b/kernel/bpf/diagnostics.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+#include <linux/bpf_verifier.h>
+#include <linux/ctype.h>
+#include <linux/stdarg.h>
+
+#include "diagnostics.h"
+
+#define MEMORY_SAFETY "Memory Safety"
+#define REGISTER_TYPE_SAFETY "Register Type Safety"
+#define CALL_TYPE_SAFETY "Call Type Safety"
+#define RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
+#define EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
+#define PROGRAM_STRUCTURE "Program Structure"
+#define POLICY "Policy"
+#define VERIFIER_LIMIT "Verifier Limit"
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env)
+{
+	return env->log.level & BPF_LOG_LEVEL;
+}
+
+static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+
+static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
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
+void bpf_diag_header(struct bpf_verifier_env *env, const char *category, const char *problem)
+{
+	char first;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	category = category ?: "Verifier Error";
+	problem = problem ?: "";
+
+	if (!problem[0]) {
+		diag_write(env, "\nVerification failed: %s\n", category);
+		return;
+	}
+
+	first = toupper(problem[0]);
+	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
new file mode 100644
index 000000000000..e8e4c06233e2
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
+void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
+			    const char *problem);
+
+#endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0


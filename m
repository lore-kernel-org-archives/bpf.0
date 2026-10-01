Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D152ED3B
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868127; cv=none; b=aH9nQBWoxNc3M+wClK8FxArYKmhcitl9RHAZ+TEBsdKt2YXxrOWJoR6AJL9pj3Rl2w45j8/NWG5uvH/JZR7+iUU8b8gZLhLJC5tl77HfQf9Bw4BW5LesKI4W6TwR5jTnp2hRjirh/SCHrWZ1nqHM2b1xT+gVNyqmoGeeujVjJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868127; c=relaxed/simple;
	bh=FTrTAjgbEPiB3dcqQvf9b9uX941Z63zFqOYQnxzO63w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj8ZZTyxgtPO2oZwZi+PyggW1ue+DBBFAePcvxwOTense5MWqNbFr9t/DAMpkCNTlrdayVvZtyg7l0Unk1taq+8cW8VbVv2nKMIkqcgKPb9qwgNmiOZ4ZqgxpVW527+JG983DxbE7B+i0Op2DZLnVLaRTVhygNetKo4wUppWiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4R9lBE2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4R9lBE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW/lx6DUV16jrQ8XfWDIKuBRm3R/7XC0QoFfh8n8doM=;
	b=L4R9lBE26prgUmdZRnXCqdYxUWT7MesoLIv0SsQ2kU6HEGLiSOUMJkI3svI2garHJ2kQCk
	BbIQ85N5lMqqALc9g319uP/H+wJ+qDzLqkNIrSKOPlfRDBoGkMXyv7gcaL0zr/WFAY0IC9
	sKqgumwm38o1FFiYvi3rC961EZGb3d0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-mUEapQYXO_6j_E6qZrCDbw-1; Thu,
 01 Oct 2026 11:22:01 -0400
X-MC-Unique: mUEapQYXO_6j_E6qZrCDbw-1
X-Mimecast-MFC-AGG-ID: mUEapQYXO_6j_E6qZrCDbw_1790868119
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDA2C195E90B;
	Thu,  1 Oct 2026 15:21:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 338BC1800361;
	Thu,  1 Oct 2026 15:21:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from libarena
Date: Thu,  1 Oct 2026 17:20:36 +0200
Message-ID: <20261001152042.124445-10-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add bpf_atomic.h including atomic read/write macros like READ_ONCE() and
try_cmpxchg(). This version is a stripped down copy of the one currently
present in selftests/bpf/libarena.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../verification/rv/bpf_monitors/bpf_atomic.h | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 tools/verification/rv/bpf_monitors/bpf_atomic.h

diff --git a/tools/verification/rv/bpf_monitors/bpf_atomic.h b/tools/verification/rv/bpf_monitors/bpf_atomic.h
new file mode 100644
index 000000000000..f834ea91c9d3
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/bpf_atomic.h
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef BPF_ATOMIC_H
+#define BPF_ATOMIC_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+extern bool CONFIG_X86_64 __kconfig __weak;
+
+/*
+ * __unqual_typeof(x) - Declare an unqualified scalar type, leaving
+ *			non-scalar types unchanged,
+ *
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ *
+ * This is copied verbatim from kernel's include/linux/compiler_types.h, but
+ * with default expression (for pointers) changed from (x) to (typeof(x)0).
+ *
+ * This is because LLVM has a bug where for lvalue (x), it does not get rid of
+ * an extra address_space qualifier, but does in case of rvalue (typeof(x)0).
+ * Hence, for pointers, we need to create an rvalue expression to get the
+ * desired type. See https://github.com/llvm/llvm-project/issues/53400.
+ */
+#define __scalar_type_to_expr_cases(type) \
+	unsigned type : (unsigned type)0, signed type : (signed type)0
+
+#define __unqual_typeof(x)                              \
+	typeof(_Generic((x),                            \
+		char: (char)0,                          \
+		__scalar_type_to_expr_cases(char),      \
+		__scalar_type_to_expr_cases(short),     \
+		__scalar_type_to_expr_cases(int),       \
+		__scalar_type_to_expr_cases(long),      \
+		__scalar_type_to_expr_cases(long long), \
+		default: (typeof(x))0))
+
+/* No-op for BPF */
+#define cpu_relax() ({})
+
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
+
+#define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
+
+#define try_cmpxchg(p, pold, new)                                 \
+	({                                                        \
+		__unqual_typeof(*(pold)) __o = *(pold);           \
+		__unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
+		if (__r != __o)                                   \
+			*(pold) = __r;                            \
+		__r == __o;                                       \
+	})
+
+#define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
+
+#define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
+
+#define smp_mb()                                 \
+	({                                       \
+		volatile unsigned long __val;    \
+		__sync_fetch_and_add(&__val, 0); \
+	})
+
+#define smp_rmb()                   \
+	({                          \
+		if (!CONFIG_X86_64) \
+			smp_mb();   \
+		else                \
+			barrier();  \
+	})
+
+#define smp_wmb()                   \
+	({                          \
+		if (!CONFIG_X86_64) \
+			smp_mb();   \
+		else                \
+			barrier();  \
+	})
+
+/* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
+#define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
+
+#define smp_load_acquire(p)                                  \
+	({                                                   \
+		__unqual_typeof(*(p)) __v = READ_ONCE(*(p)); \
+		if (!CONFIG_X86_64)                          \
+			smp_mb();                            \
+		barrier();                                   \
+		__v;                                         \
+	})
+
+#define smp_store_release(p, val)      \
+	({                             \
+		if (!CONFIG_X86_64)    \
+			smp_mb();      \
+		barrier();             \
+		WRITE_ONCE(*(p), val); \
+	})
+
+#endif /* BPF_ATOMIC_H */
-- 
2.55.0


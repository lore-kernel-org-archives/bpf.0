Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698090;
	b=M49x5VKWVq9cz0c+n2jd9aRKRV+Hrd7moQ5u8YUwcbhr0cJt5i68r91n3fC4RHag3jbL
	 IJKtl6YhpkFlvqdUax4uoY1xuQQQ6/jM3e/dmCEuWWWG5zIQ+hMiV7sC32dmpuTtORkBj
	 emOgDCrZTJ++Npfb1Q67yGqfz8GifsQBtMgA4gM6oe6Tw5WGhYhAIZhMqDtFv1h+RvMQy
	 AyBESFS9b6oThpRon2+VAgfldolr8tyep4mCaXw081Hb98IMWJ9+LyrSESOsiNIYwbd1r
	 Q4f839br8tx80Dfgi+64wMeUDU7brM9nn1Mg14YRKhR5vdRepKkwQW9YkYtmRhu3R+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698090;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=5LbbQ/OanmcwSV0W0viv1h4cDoZwm0Qe55LoCFE56iQ=;
	b=BIEFesPdEPZ/kNPMNe07RJsO7X566INgigs+iqBuIFHC2TQafFLMK6mHZmwrhrym4G7s
	 CJmWn8MyuRtrs/cXU/2z6iBvEMzUebKPHRNdVn9+3yh8JrLlaDVBChlFpgdUjK/Bcuqkl
	 OIxljhR3cxKr8IlLFlgObEXbiJS+H8wenKJoldtTZ90HJ7cLFFdsOqzzP8rC1xk7r22/4
	 aQog+2nGW7pkfi9DL7FOAkZOVNObMpCIxgBU51j2JmCOLwmS6ByqRQJnijpEgJy7aWRlA
	 NYRdkMfi8rs4FtEVO8hPmwEySrVCEAg+yZzXt/gHaRl6F9GWRITkRgxRUhZt9jaQC8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eg+DE+JC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE5606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eg+DE+JC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LbbQ/OanmcwSV0W0viv1h4cDoZwm0Qe55LoCFE56iQ=;
	b=Eg+DE+JC9qCnU3TpyhXWgiGToOi9FT2Aq/56tD/eLei1aw8dfOAlzMFf+9PCiR3wG5Q9oO
	CC9pZP8bUooOWBsb+2+nW59xHsYDCkuXRoqtNP8jKlozTrPMK3ueUqSd/c+csmYawyyC/I
	Yt7ardaCJBc0WoCGZm7Qve7IsQUxEcc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-gaRqeYGcMJqVAVWIsyA1bg-1; Thu,
 26 Nov 2026 13:01:24 +0000
X-MC-Unique: gaRqeYGcMJqVAVWIsyA1bg-1
X-Mimecast-MFC-AGG-ID: gaRqeYGcMJqVAVWIsyA1bg_1795698082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8E0A1955F2F;
	Thu, 26 Nov 2026 13:01:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A469D1801A67;
	Thu, 26 Nov 2026 13:01:19 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 12/18] tools/rv: Copy stripped bpf_atomic.h from libarena
Date: Thu, 26 Nov 2026 13:59:58 +0100
Message-ID: <20261126130004.127155-13-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add bpf_atomic.h including atomic read/write macros like READ_ONCE() and
try_cmpxchg(). This version is a stripped down copy of the one currently
present in selftests/bpf/libarena.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../verification/rv/bpf_monitors/bpf_atomic.h | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 tools/verification/rv/bpf_monitors/bpf_atomic.h

diff --git a/tools/verification/rv/bpf_monitors/bpf_atomic.h b/tools/verification/rv/bpf_monitors/bpf_atomic.h
new file mode 100644
index 000000000000..3cf9a78a15c7
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/bpf_atomic.h
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
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
+#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
+/*
+ * Clang advertises this feature when it can lower acquire/release atomic
+ * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using the
+ * barrier-based fallback below. The generated instructions require kernel
+ * verifier/JIT support added in Linux 6.15; compile for an older BPF CPU to
+ * keep using the fallback when targeting older kernels.
+ */
+#define smp_load_acquire(p)								\
+	({										\
+		__unqual_typeof(*(p)) ___p1 = __atomic_load_n((p), __ATOMIC_ACQUIRE);	\
+		(typeof(*(p)))___p1;							\
+	})
+
+#define smp_store_release(p, val)							\
+	({										\
+		__atomic_store_n((p), (val), __ATOMIC_RELEASE);				\
+	})
+#else
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
+#endif
+
+#endif /* BPF_ATOMIC_H */
-- 
2.56.1


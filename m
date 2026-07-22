Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8F282F16
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725790; cv=none; b=ofZO979STCRyAG81djYbNzZPMYcE9KP5r+jW2uOcTJzrIyd4caJKnxyZDt0H4EBw502SRbB6KMhV3HKvR6wnU8H+JXtmNNl7Sp0CBgtlCH4KzQXYFUHM5+h/CXGp8aKZpI3sydX5p7nFtZlbB31l/nKf/sp28Q7LBdIR71cMkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725790; c=relaxed/simple;
	bh=XmSnFexd7TuxLFJeeLa9qzz3bZRbei/pYQynIR7d/C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frkVc0A6QMmoJuyXNlkEfWDMMd7h1hpG9ZzuSqLZbqaOAgXNKAYmBB8HHgNm8kWHbibOC/S6QN3oo817Zp45AjBzehcIu/Xf6tNMwkZNJFxTdA5n249VrOw0FL4bhMYoI3+rfwVtD0JWcFHsqwjRXxo2J/U/W8dezR2AEkpFXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhYbHccf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhYbHccf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EAA1F000E9;
	Wed, 22 Jul 2026 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784725785;
	bh=I+vTX/d5yvm9nmi6cVLrp22DpQg6PSgkZg+2pIbxsHQ=;
	h=From:To:Cc:Subject:Date;
	b=MhYbHccfKMm9zivp5QWVR/SDKQPxl3rgvvabpy+Hkvq4h/YyphsjK2LjvgFBEIAI5
	 A+GRV36+uzfvqTemriREbzdvzQp0K3lcOFb8e1lfYDp21s6VCKEP8Bh3RLXQb1TaIY
	 SaFfQlo+YZ9ORWJtGNpyqgJStAqIV9R+vmDKvaQ3zQBcS46JTGvP3HYq3qKd2bsCUA
	 CjieZjxU6eXneyYap3cJT9otX0KtTYSEZIWJjNYadXw+3ndd/51PDKDmTRsqMlJda9
	 ExF2oFPWQitD3mrzXnujcNbdj1tZJKBD/jLL0QFbO9FZJfQrKjvy9pCuyOmwy/6fiS
	 G1mm0LrQYLrIw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] libarena: Use compiler load-acquire/store-release in bpf_atomic.h
Date: Wed, 22 Jul 2026 06:09:33 -0700
Message-ID: <20260722130939.3991397-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach libarena's BPF atomic primitives to use compiler builtins for
load-acquire and store-release when Clang advertises
__BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
existing barrier-based fallback.

Notably, as BPF programs begin running on arm64, it is better to use the
more appropriate variants since we can no longer rely on x86 TSO ordering.

Commit 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
introduced support, hence kernels from 6.15 onwards are needed when
compiling with compilers supporting these instructions. We have
relatively recent kernel version requirements in libarena anyway, and
have not cut first release, hence declare such a dependency.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

Changelog:
v1: https://lore.kernel.org/bpf/20260721185705.1365329-1-memxor@gmail.com/
Changes in v2:
- Use __BPF_FEATURE_LOAD_ACQ_STORE_REL directly for guard.
- Use __unqual_typeof

---
 .../bpf/libarena/include/bpf_atomic.h         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
index b7b2304319295..4558fa26911f6 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
@@ -86,6 +86,25 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
 #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
 
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
+	do {										\
+		__atomic_store_n((p), (val), __ATOMIC_RELEASE);				\
+	} while (0)
+#else
 #define smp_load_acquire(p)                                  \
 	({                                                   \
 		__unqual_typeof(*(p)) __v = READ_ONCE(*(p)); \
@@ -102,6 +121,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 		barrier();             \
 		WRITE_ONCE(*(p), val); \
 	})
+#endif
 
 #define smp_cond_load_relaxed_label(p, cond_expr, label)                \
 	({                                                              \

base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
-- 
2.53.0-Meta


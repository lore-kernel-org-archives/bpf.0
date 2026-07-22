Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDB357CF3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729409; cv=none; b=M0Ny4fGhL/J5X42VdTcFCAOx7W1yrSVZ94vyJRY1KNwMdppyNx/TLaxfK4wtOVgy2/kXFhVa51bKgEeHsfxW4D9kXUSiH+dma2HLOII8hHHsQ4TKln+9wOzCjGjnz9PmE5EudP5uEP5q6ku23xIfXlwm1VXrWjqrxI99Dz2B+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729409; c=relaxed/simple;
	bh=W5VY5orGZHHGhk6PjUsl9ECL1Y0peb5ASSaEh2WfbDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjZlAiQ1lMurSqWHbtWxFlhAjS8O9TO9rKR4fF9A9iqS3c7CQDW4tXhbzajwTBLoc0eUWKUDc44z2HnGXKgbjgBc1XkVBzXuP4pULzyMOPTKDt277HA9v4GaqmWsgPAi6Rh5RP740iy/Kj8ysZfDnxc7HNbClBZubQb5nTYj8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3JC21Ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3JC21Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70CD1F000E9;
	Wed, 22 Jul 2026 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729407;
	bh=dx4sVV9V0RocNLu4jcGAbCzzchw3AjZebnFNfaxRYrk=;
	h=From:To:Cc:Subject:Date;
	b=j3JC21LsjoP7SBULB8qS50WEW2uiW5W5KT/t7HIJ3VQNXFYJOzWnwv9TeubNiQmFc
	 /EULy+SjzPmRrWx1kKGeQ4v9MjGjZJEi5Mh5sIxtKNadDKOVY6to0sTEvMXNJRFe7U
	 XnVGVHp4ZrblnQhN6OS/0WTbZioAlRa+fqxoVyA5hZf7Efudrfrs9mzSTk9Ix3vH7D
	 AYe/wfMkDVaFiA508sWi+26yWp3DFQJ0LRoWK8P47Dt6nvSjty/Lh2aI8S7iHpJ7Vm
	 SH0ku3XiwaoNOKc9cTYRddhsXftoG5o8erxM3oZNN47BQ1r2YQp0L+vGhjgbBbgdYp
	 MZoPGcUcDFs8Q==
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
Subject: [PATCH bpf-next v3] libarena: Use compiler load-acquire/store-release in bpf_atomic.h
Date: Wed, 22 Jul 2026 07:10:01 -0700
Message-ID: <20260722141003.2841007-1-puranjay@kernel.org>
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
v2: https://lore.kernel.org/bpf/20260722130939.3991397-1-puranjay@kernel.org/
Changes in v3:
- Use consistent ({  }) for multi-line macros

v1: https://lore.kernel.org/bpf/20260721185705.1365329-1-memxor@gmail.com/
Changes in v2:
- Use __BPF_FEATURE_LOAD_ACQ_STORE_REL directly for guard.
- Use __unqual_typeof

---
 .../bpf/libarena/include/bpf_atomic.h         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
index b7b2304319295..43c306e17f198 100644
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
+	({										\
+		__atomic_store_n((p), (val), __ATOMIC_RELEASE);				\
+	})
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


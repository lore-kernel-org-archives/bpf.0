Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016A30ACF1
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726694; cv=none; b=uppnDj7iKddcAi7rW+Lr0lAXbxyGa81nSIabp45t1D5H+C7g18hlqAZyS/9kcsjDVShMTW06aaid0CXRmyuKov7HUe6hVf1tOnvPn1jaII7T406Ya7s3n9tz1ncQga4VXlQ4oIzqXrRiL+Zt/7MXcEPAgYYnaXINnns9d9aO620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726694; c=relaxed/simple;
	bh=cQ0Iq6k9yhriCscjZsF3+fNS2ntXWspYAUYu9pnqDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLONB+GrCrra9L5nYS0xqnGtVX7QFW+uYXrNBOxu0yhgMQDFFsU3yz+Oa3GBoL5GF2jh0Sd/c0sVIvk7h93lb8xe4Rdzm67BVFXEJbPn8rnQTGqBI8kKizxSrQIRX5WkJz2/8rXEiWDlXhzHcoRdVtWMQDd07iRu652n39kO1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geiSR11u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geiSR11u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2581F1F00A3A;
	Wed, 22 Jul 2026 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726693;
	bh=BfGRNi7Oqi+7XBYt6F9CtoZ59nz7KhumD5mHQy4Fcmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=geiSR11uD6rv5dddNV6oZ4Mzx0yVDd8C5561pTEKZ5jE5LGvv37zTbtxlsWlfuqsc
	 oIEda1rEyymdixQlLemQmIDtYRcOhjEWHl8OAABxjmVFGATrcBo+wOUa9eAPf6Vn2L
	 yHFnLUW5R/WN8rTsAcnwB6BKkXQbFtoury9YL/+qnyA7/Tynk9O+1d8fZeJEmtEHtS
	 5eQqWfez4c01evg3NOeXR2UX9h+OSY1LaiAsN6gNk89V62vxxiyRNwJd46TDo6QhbB
	 UFkWbejzOJJq40pJGbZ8Sr3WhacKVJGbagN7kgVKbF9CI6NOjEbAFXGp4VS37VLIQE
	 lxQHH09yi3rbA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Verify inlined numeric iterator shape with __xlated
Date: Wed, 22 Jul 2026 06:24:20 -0700
Message-ID: <20260722132424.450230-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
References: <20260722132424.450230-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __xlated tests to the open-coded iterator suite that pin the shape of
the inlined bpf_iter_num_{new,next,destroy}() rewrites. The programs are
naked functions, so there is no compiler-generated glue and the whole
inlined program is matched instruction for instruction:

 - constant bounds: bpf_iter_num_new() folds to the state init, storing
   start - 1 and end directly;
 - non-constant bound: bpf_iter_num_new() keeps the range check, with the
   distance computation and both the -EINVAL and -E2BIG paths.

bpf_iter_num_next() and bpf_iter_num_destroy() are inlined in both.

The tests are pinned to x86_64 and arm64 (bpf_jit_needs_zext() == false):
on arches that need explicit zero-extension the verifier interleaves
"wN = wN" insns into the inlined body, which would not match the fixed
instruction sequence. The inlining itself is arch independent, so checking
it on these arches is sufficient.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 145 ++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 0fa70b133d932..c4df589ecd7ae 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -88,6 +88,151 @@ int iter_err_unsafe_asm_loop(const void *ctx)
 	return 0;
 }
 
+/*
+ * Naked functions, so there is no compiler-generated glue and the whole inlined program can be
+ * matched. Pinned to arches whose JITs zero-extend 32-bit writes implicitly
+ * (bpf_jit_needs_zext() == false); on arches that need explicit zero-extension the verifier
+ * interleaves "wN = wN" insns and the fixed shape below would not match. The inlining itself is
+ * arch independent, so checking it on these arches is sufficient.
+ *
+ * With constant bounds bpf_iter_num_new() is inlined with the range checks folded away, just
+ * storing the initial state (s->cur = start - 1, s->end = end); bpf_iter_num_next() and
+ * bpf_iter_num_destroy() are inlined too, leaving a call-free loop.
+ */
+SEC("raw_tp")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("r6 = r10")
+__xlated("r6 += -8")
+__xlated("r1 = r6")
+__xlated("r2 = 0")
+__xlated("r3 = 10")
+/* bpf_iter_num_new(&it, 0, 10) folded to the state init */
+__xlated("*(u32 *)(r1 +0) = -1")
+__xlated("*(u32 *)(r1 +4) = 10")
+__xlated("r0 = 0")
+__xlated("r1 = r6")
+/* bpf_iter_num_next(&it) */
+__xlated("r0 = *(u32 *)(r1 +0)")
+__xlated("w0 += 1")
+__xlated("r2 = *(u32 *)(r1 +4)")
+__xlated("if w0 s>= w2 goto pc+3")
+__xlated("*(u32 *)(r1 +0) = r0")
+__xlated("r0 = r1")
+__xlated("goto pc+2")
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = 0")
+__xlated("if r0 != 0x0 goto pc-11")
+__xlated("r1 = r6")
+/* bpf_iter_num_destroy(&it) */
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = 0")
+__xlated("exit")
+int __naked iter_num_new_const_folded(void)
+{
+	asm volatile (
+		/* r6 points to struct bpf_iter_num on the stack */
+		"r6 = r10;"
+		"r6 += -8;"
+		"r1 = r6;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = r6;"
+		"call %[bpf_iter_num_next];"
+		"if r0 != 0 goto 1b;"
+		"r1 = r6;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_common, "r6"
+	);
+}
+
+/*
+ * Same arch pinning and naked-function rationale as above. With a non-constant bound
+ * bpf_iter_num_new() keeps the full range check: the distance is computed and both the -EINVAL
+ * and -E2BIG error paths remain. bpf_iter_num_next() and bpf_iter_num_destroy() are inlined too.
+ */
+SEC("raw_tp")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("r6 = r10")
+__xlated("r6 += -8")
+__xlated("call unknown")
+__xlated("r3 = r0")
+__xlated("r3 &= 65535")
+__xlated("r1 = r6")
+__xlated("r2 = 0")
+/* bpf_iter_num_new(&it, 0, <non-const>) with the range check kept */
+__xlated("if w2 s> w3 goto pc+8")
+__xlated("w0 = w3")
+__xlated("w0 -= w2")
+__xlated("if r0 s> 0x800000 goto pc+8")
+__xlated("w2 += -1")
+__xlated("*(u32 *)(r1 +0) = r2")
+__xlated("*(u32 *)(r1 +4) = r3")
+__xlated("r0 = 0")
+__xlated("goto pc+5")
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = -22")
+__xlated("goto pc+2")
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = -7")
+__xlated("r1 = r6")
+/* bpf_iter_num_next(&it) */
+__xlated("r0 = *(u32 *)(r1 +0)")
+__xlated("w0 += 1")
+__xlated("r2 = *(u32 *)(r1 +4)")
+__xlated("if w0 s>= w2 goto pc+3")
+__xlated("*(u32 *)(r1 +0) = r0")
+__xlated("r0 = r1")
+__xlated("goto pc+2")
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = 0")
+__xlated("if r0 != 0x0 goto pc-11")
+__xlated("r1 = r6")
+/* bpf_iter_num_destroy(&it) */
+__xlated("*(u64 *)(r1 +0) = 0")
+__xlated("r0 = 0")
+__xlated("exit")
+int __naked iter_num_new_inlined(void)
+{
+	asm volatile (
+		/* r6 points to struct bpf_iter_num on the stack */
+		"r6 = r10;"
+		"r6 += -8;"
+		/* non-constant end so the range checks are kept */
+		"call %[bpf_get_prandom_u32];"
+		"r3 = r0;"
+		"r3 &= 0xffff;"
+		"r1 = r6;"
+		"r2 = 0;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = r6;"
+		"call %[bpf_iter_num_next];"
+		"if r0 != 0 goto 1b;"
+		"r1 = r6;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_common, "r6"
+	);
+}
+
 SEC("raw_tp")
 __success
 int iter_while_loop(const void *ctx)
-- 
2.53.0-Meta


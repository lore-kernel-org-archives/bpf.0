Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E73FBEC2
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357445; cv=none; b=tZdWs2/4RVIXujB7Bg22hPKG5/g9shPV9vqKZHboJ/A/FHsOEziD6amYwNJVFSOxI8JDnhwIm5peM/XTBlvmV5EOEK1EDVf2ZG3toYC+KMsr6DMq7VvU5oic15Zn/nfBx1Iq1O60/7rdiC0G/q2X+tJK58omCabRO1YrSFCLQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357445; c=relaxed/simple;
	bh=hBEF+kk0CUTCv9EVKQqF3fY2umSOGj238FwnEsVpV1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELR2LJX9SjMU2lnL7noR1nodvFZZtPSpFB3FMUFOiA3H730GaMYEomUcXCur2MHvNG3i1DuUh0PwxeMkbDqEoYYSyRXhAGB7tbdU3nZPUG5NPhwr6MBMQexrd2aj6PMNTs3sIx5A13ek0xAD/TkpyxU2RnOXQx2mMG0R0Xw0WPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0YSrEts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0YSrEts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA971F00A3F;
	Wed, 29 Jul 2026 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357427;
	bh=WcvuoBKsVAdSG6bbGQqQwtBbPvwUOLvjGk58eVLViLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0YSrEtsrY3I6wgHPfgWCdIE8GK+vCbpdsWV/pAdaOT8H3BXfiYi1zP9mhsbespLn
	 GOlCx5rECi6vGqq9PcljpngaCZen00lpRjrJv5US1wBIt3KJcVrrsLKjCRQrjMB9Zj
	 O8W96HL/AEnu1kUV5jYqfnlgRw0extqNELa92kW/URFUcO3KwxftNaf3Gm1h60IjtO
	 vgMle13Bz+RMrHKzRnOowBCnXBy1dYKhxuyVN9T6GY1L4yHlsJDiAYFzk/VJ0QcBaO
	 RkCOKkObI5uwMGk4HpRxPhHdxJEe9T3os4kAXYLuD3ILa/0DpYqGHkeX6gN6Ae9fSH
	 Zp4qpymgHva4Q==
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
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Verify inlined numeric iterator shape with __xlated
Date: Wed, 29 Jul 2026 13:36:25 -0700
Message-ID: <20260729203633.213973-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729203633.213973-1-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an __xlated test to the open-coded iterator suite that pins the shape
of the inlined bpf_iter_num_{new,next,destroy}() rewrites. The program is a
naked function, so there is no compiler-generated glue and the whole
inlined program is matched instruction for instruction: bpf_iter_num_new()
emits the range check (distance computation and both the -EINVAL and -E2BIG
paths), and bpf_iter_num_next()/destroy() are inlined too.

The tests are pinned to x86_64 and arm64 (bpf_jit_needs_zext() == false):
on arches that need explicit zero-extension the verifier interleaves
"wN = wN" insns into the inlined body, which would not match the fixed
instruction sequence. The inlining itself is arch independent, so checking
it on these arches is sufficient.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 0fa70b133d932..62d7df9e80beb 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -88,6 +88,89 @@ int iter_err_unsafe_asm_loop(const void *ctx)
 	return 0;
 }
 
+/*
+ * Naked function, so there is no compiler-generated glue and the whole inlined program can be
+ * matched. Pinned to arches whose JITs zero-extend 32-bit writes implicitly
+ * (bpf_jit_needs_zext() == false); on arches that need explicit zero-extension the verifier
+ * interleaves "wN = wN" insns and the fixed shape below would not match. The inlining itself is
+ * arch independent, so checking it on these arches is sufficient.
+ *
+ * bpf_iter_num_new() emits the full range check (distance computation and both the -EINVAL and
+ * -E2BIG error paths); bpf_iter_num_next() and bpf_iter_num_destroy() are inlined too.
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
+__xlated("if r0 > 0x800000 goto pc+8")
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
+/* bpf_iter_num_destroy(&it) is inlined to a nop */
+__xlated("goto pc+0")
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


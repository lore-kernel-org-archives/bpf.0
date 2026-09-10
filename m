Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957533C3BEF
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033440; cv=none; b=CbwE+jyHmCo58Et9sqIFcP6l44p87YxcduF/JFLLNLNSox+gBFdEwI3QL3kcXREu/0Fz8wAaTJ7qaTVKGS3BhZ5Vj0aj7g12MUob1aHeZj7Em1lzQHxqxswFE/lManMkfytY3qVMtAMRFwvdfYvnsLEEvWLW2zsHXYE7pkBkfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033440; c=relaxed/simple;
	bh=IRHLHOdHI4dU+xUOQR0VCUvJyo29oB9HqLuQLp5v2hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctDG8KAYC4tYTXrTTDV5XQxUA7RcxI0hRLMQVt/xKzowLfwIg4+vTjqZGV0vCDcbnBZKtfTDS73Egs3OSj3oOccPNI5yrCtwGvyKL7a3GLAP0NuR3tlbjNHxZw6EV8q7ens+QXHiAdQ/CyIMIk2EVtBq3gXgYRnmi629wwfYNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu+SZWxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu+SZWxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B67C1F000FF;
	Thu, 10 Sep 2026 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033437;
	bh=qTmw7ypY641nBuz3lL97qsg/I3NAMz8UdN8Kms//Yc4=;
	h=From:To:Cc:Subject:Date;
	b=Tu+SZWxsBhFXXnS/cNV+wgFx5E/KZW+vT+HDKcnTQMC3gonEfopK71xWbblVe7iyv
	 rWHzlWja9NWWwYBygG2TU0mcd9pi4dwq4fciOArVsFWv2FbpW2PrgdLCB4NMCUAFiv
	 9qDXlJN3Jqg+jM3hV+wAGlsbDFvSOxDc8b2n6r5kENxBHscLioK99CHKdXm7r4A45s
	 HtKHG2LMveSimBep16XWkM+IvgDKObe5fez3ljD6IeCaG/W3TApwpq7gJ153PqFq4H
	 /RiUaYtLOSRdQ+PMJmD976O0WEdLViaYOSmjhWMTpxM3ClivxI5EK/rV+pgeEtpe3y
	 vdosU5BPFdWCQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCHv2 bpf-next] bpf, x86: Use global buffer for trampoline size generation
Date: Thu, 10 Sep 2026 11:43:53 +0200
Message-ID: <20260910094353.1256316-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently arch_bpf_trampoline_size allocates and frees a temporary
trampoline buffer on every invocation. The buffer is only used as a
scratch space while __arch_prepare_bpf_trampoline() calculates the
required size, and the generated trampoline is discarded.

Allocating a writable scratch page during kernel initialization and
reusing it for all size calculations. This improves tracing_multi
attachment time.

With current code:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55227 functions
  serial_test_tracing_multi_bench_attach: attached in   1.563s
  serial_test_tracing_multi_bench_attach: detached in   0.256s

With the fix:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55235 functions
  serial_test_tracing_multi_bench_attach: attached in   0.798s
  serial_test_tracing_multi_bench_attach: detached in   0.258s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v1: https://lore.kernel.org/bpf/20260907160538.922450-1-jolsa@kernel.org/

v2 changes:
- added comment to init_trampoline_size_image why we use execmem
  allocation from EXECMEM_MODULE_DATA [Alexei,Mike]

 arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bba351944202..9f9b1456dab0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -9,6 +9,7 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <linux/bitfield.h>
+#include <linux/init.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/memory.h>
@@ -35,6 +36,21 @@ void __asan_store8(void *p);
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
+static void *trampoline_size_image;
+
+static int __init init_trampoline_size_image(void)
+{
+	/*
+	 * The generated trampoline contains calls and jumps with 32bit relative
+	 * offsets, so the scratch image must be in the execmem range.
+	 * On x86, module data and executable memory share the same address range,
+	 * so using EXECMEM_MODULE_DATA to get writable memory.
+	 */
+	trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
+	return trampoline_size_image ? 0 : -ENOMEM;
+}
+late_initcall(init_trampoline_size_image);
+
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	if (len == 1)
@@ -4000,24 +4016,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct bpf_tramp_image im;
-	void *image;
-	int ret;
 
-	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 *
-	 * We cannot use kvmalloc here, because we need image to be in
-	 * module memory range.
-	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
-	 * that returns writable memory in the module address space.
-	 */
-	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
-	if (!image)
+	if (!trampoline_size_image)
 		return -ENOMEM;
 
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
-					    m, flags, tnodes, func_addr);
-	execmem_free(image);
-	return ret;
+	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
+					     trampoline_size_image + PAGE_SIZE,
+					     trampoline_size_image, m, flags,
+					     tnodes, func_addr);
 }
 
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
-- 
2.54.0


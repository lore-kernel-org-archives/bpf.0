Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6E513568
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797151; cv=none; b=eAWQQUgvHhrcSJU3zZqdHMcHJ6hRVXY6rw2wWZJLRF4+LUpSR/iwYXCc2fCx7ZzJG+P4TnDiOuOh/CGgMl18jrG2v60IVrU3Epz6cZMiknrPaqeoWl2FpxUwVLrv2gGjNLrwEHRtP7Ss10Qg71phjndV1lxsEcIGX2Vz7+5Hit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797151; c=relaxed/simple;
	bh=0U/c8zD+uMW1qlo5TNoOcuvL3UH6qE8ewzT8qYPxruE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qz9A/Oq1PWo1HMsL+35JC2NcbpfcYKVJSSfDokV/Kzmf1I0+O9ML/ShOL3jLIp7tUbAJzue66D/uOStOd9W9zn7lYKbby474khiBzkOYJi+xzr1yPhYV9WiP60Gc1b1XRVV1jiexSuRUcalVZLArRhc2wKejKFoJBHkmwDDaBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3djP7Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3djP7Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB7C1F00A3A;
	Mon,  7 Sep 2026 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797148;
	bh=So+6FFbvNbgmGlrjPCGO63p63w1Sqa2HAsC59wZ/wAs=;
	h=From:To:Cc:Subject:Date;
	b=d3djP7EtAguos7iklIkGBbj0wzRxewgE71NxOpJPKd4GhDUEnpDzxTHNdSTiXaU/G
	 ZN0KsxxGWDecQxjHdaqXRRkDMJ8ct+PkAeo8b0HkDcTsjV50h6rlL3l08ETnYkCk7X
	 /2U7bQjvdhVGkma0SWuw+B+1RVrTu3fxQms32oobaAAqVE8wWahW1pobB9YtFxJblM
	 gSLfoNDpzYCOpz3oM9xxJJEnl80B0mIVXVpWUTe9XPh3cHn6d47hajhWjVessSS2f3
	 ansOgpMXerwrXdlSoYoqca9Z6+WkiB0XMt2IRZJ7Tvq8EAT964HM8wbAPMR9uy/wul
	 sI6Ei4AQhNvGw==
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
Subject: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size generation
Date: Mon,  7 Sep 2026 18:05:38 +0200
Message-ID: <20260907160538.922450-1-jolsa@kernel.org>
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
was "bpf, x86: Add support for jit dry run",
- doing this by having single scratch page instead as suggested by Alexei

 arch/x86/net/bpf_jit_comp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bba351944202..13ef0d53ca29 100644
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
@@ -35,6 +36,15 @@ void __asan_store8(void *p);
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
+static void *trampoline_size_image;
+
+static int __init init_trampoline_size_image(void)
+{
+	trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
+	return trampoline_size_image ? 0 : -ENOMEM;
+}
+late_initcall(init_trampoline_size_image);
+
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	if (len == 1)
@@ -4000,24 +4010,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C28850E;
	Tue, 18 Aug 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058320; cv=none; b=ojdVKv1g8vOgKnfr6Hc9aVDmt4vRd3V+WMKjHy5CDF3uOfljTIEl0QcL8Dz2/aI6blM1atnUADDmahD2aB4X/teIrqi21VYmboj+gxoelfyzmldmNny1LU7B0oKu42JuuUGD96tOZWz1kQEF3eauQ9lr3+R+mYPbRPigoVNoOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058320; c=relaxed/simple;
	bh=ScXZvl3cQyEFnKJfszQGQuW0uh4lNvxyfS14QVXKFH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PY6pH7ohPZmc4Oe/JF6DA6hPfkhyr0MP98FBFHWw5YzHvvw4G5Sp6F0XasUF8aXy74HJ4+YOLTEOcJtmXSLxx0+9A8BsDSAvvMPX0kCUqJlEWZDjqy+823M7bfUHsr6eDIqiC0oU3HzVaBL+uimdVOpI3NiUd024AEjaNWODqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYVRMJ1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYVRMJ1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEFF1F000E9;
	Tue, 18 Aug 2026 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058318;
	bh=Whvd+d836LjKs68wlsX7Q18v4nLq9Ty71dCxZ0RAccw=;
	h=From:To:Cc:Subject:Date;
	b=LYVRMJ1c7KaYMrjK0DixovyzwY1Rx5Ps6TbO8FwBtNUMmk+X2uM+q/ZsQOpyhJfgT
	 3h1DRW28NQv6bHyDrYX0FyJuFsweIriw9CBRvr48L/XIchSlCqbFgr1QrPKDNpRrfG
	 LuyqoIpPUcYY78YI6MHKxl+taaxT6jvnakR8dhtV28xC586xPGBgaHSLzjWEmEnGsw
	 Os/8G/3RvzkSPUryxUwWDPsz/871ayHibF2myyl/kajxHoIQw/BmGQ3OmM50LvCzOp
	 hrWJE2M1iHt9ehJrskHMGxHjV7aDHREN32Az3o789hxWhn25/M3r7Id8HeM09bxRfy
	 Lipe3RXm4PD0A==
From: Mike Rapoport <rppt@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
Date: Tue, 18 Aug 2026 16:05:10 +0300
Message-ID: <20260818130510.3110054-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
number of trampolines [1].

The slowdown caused by extra protection changes in execmem_alloc_rw() and
execmem_free().

With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
W+NX and execmem_free() resets them back to ROX.

The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
that only needs a temporary writable buffer in the modules address space.

On x86 executable memory and module data are constrained to the same
address range, so x86::arch_bpf_trampoline_size() can directly use
execmem_alloc(EXECMEM_MODULE_DATA)

Replace the call to bpf_jit_alloc_exec_rw() with a call to
execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
drop bpf_jit_alloc_exec_rw() helper.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 8 +++++---
 include/linux/filter.h      | 1 -
 kernel/bpf/core.c           | 5 -----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b2feec81e231..7d064d3e2788 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/execmem.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -3706,15 +3707,16 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	 *
 	 * We cannot use kvmalloc here, because we need image to be in
 	 * module memory range.
-	 * Since it must be writable use bpf_jit_alloc_exec_rw().
+	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
+	 * that returns writable memory in the module address space.
 	 */
-	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
+	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
 	if (!image)
 		return -ENOMEM;
 
 	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
 					    m, flags, tnodes, func_addr);
-	bpf_jit_free_exec(image);
+	execmem_free(image);
 	return ret;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 32d5297c557e..14acb2455746 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1333,7 +1333,6 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
 u64 bpf_jit_alloc_exec_limit(void);
 void *bpf_jit_alloc_exec(unsigned long size);
-void *bpf_jit_alloc_exec_rw(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e2076667b245..1b89c18cf246 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1128,11 +1128,6 @@ void *bpf_jit_alloc_exec(unsigned long size)
 	return execmem_alloc(EXECMEM_BPF, size);
 }
 
-void *bpf_jit_alloc_exec_rw(unsigned long size)
-{
-	return execmem_alloc_rw(EXECMEM_BPF, size);
-}
-
 void bpf_jit_free_exec(void *addr)
 {
 	execmem_free(addr);

base-commit: 07edbd8fe6416f45e9ba6b0edcd3e40770601ebc
-- 
2.53.0


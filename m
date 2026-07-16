Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AA353A6B;
	Thu, 16 Jul 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188341; cv=none; b=PQAjB2ssdpmzUqBhSDYhhZwcD20nrRxo+UV/0QUIywlntlW4qeAR9ksQ3eqRa2dcuqpF3N6qARZ1XukLl5ezJwRF1Mz6OcIlV2543vTsMdL7TasgVrs4t2EXJiAj5wxXswnuUl96wYci8kgJp0NirG6CNJLwloe0osecQY9kyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188341; c=relaxed/simple;
	bh=duHjMvPTKNUsHVFBmk2zASNmPWRBWn/MrKC3CEPM7Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCkJ7B8GsODqqNSEzU44C9LKQCKRYmzO2UJ5xR4ijM8NczWdJLF7q5Rw4tFZSNIdsLQ+hFNM77axH3o13hoBjNJmNWNiuZl9GzF+fEo/JvP4V2JwtoSHPtfFZYIWNGtz7NVUcV5nhiXBmamWo4HW+tFo/B5j9BB5+48kDrVi0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebIEpnRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebIEpnRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640691F00A3D;
	Thu, 16 Jul 2026 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188326;
	bh=E06Ic3v1YIX7E/Iklh6+E5eIa7VNqBAM63t+V+fmcL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ebIEpnRxXLsx5NWS+3LMX4Z9ujdvhXpyQfiuzDV5s4EMBV6DtiOpKP8hwiA2Jj8Qy
	 W99R3X5sPLfVFrkGo5B27A3fAH2GxnyMEW5S/qZV0xXpW1v5K2Vno7BI3X9DmJ2r+E
	 2pOgBpekERSV+7GOol8ttGCth/3SB6G+fvQHL7pqnDB6GXGlFYo1wkv4bzBtaT6W2R
	 iL+y1TYW894SNUDhvBmW65z88DTvYhOItKr4sniQ7GcOb6u5lCouYTZGch+6hh6GSa
	 O4N+9XL/sUULaWnipsLUDuZJNeq04NWOJ/rhajN3twBTMV6D2Fha2OOLZePsrrSZff
	 OhHxqROLnmspA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 16 Jul 2026 10:51:38 +0300
Subject: [PATCH bpf-next v3 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 "H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
X-Mailer: b4 0.16-dev

arch_bpf_trampoline_size() allocates a buffer to get actual size required
for a trampoline.

This buffer must be in the module address space because
__arch_prepare_bpf_trampoline() calculates  rel32 offsets relatively to
that buffer.

In preparation for enabling ROX mode for EXECMEM_BPF make sure that the
allocated memory is writable.

Add bpf_jit_alloc_exec_rw() wrapper for execmem_alloc_rw() and use it for
buffer allocation in arch_bpf_trampoline_size().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 5 ++---
 include/linux/filter.h      | 1 +
 kernel/bpf/core.c           | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de7515ea1bea..b2feec81e231 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	int ret;
 
 	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 * This will NOT cause fragmentation in direct map, as we do not
-	 * call set_memory_*() on this buffer.
 	 *
 	 * We cannot use kvmalloc here, because we need image to be in
 	 * module memory range.
+	 * Since it must be writable use bpf_jit_alloc_exec_rw().
 	 */
-	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
 	if (!image)
 		return -ENOMEM;
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14acb2455746..32d5297c557e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1333,6 +1333,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
 u64 bpf_jit_alloc_exec_limit(void);
 void *bpf_jit_alloc_exec(unsigned long size);
+void *bpf_jit_alloc_exec_rw(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1b89c18cf246..e2076667b245 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1128,6 +1128,11 @@ void *bpf_jit_alloc_exec(unsigned long size)
 	return execmem_alloc(EXECMEM_BPF, size);
 }
 
+void *bpf_jit_alloc_exec_rw(unsigned long size)
+{
+	return execmem_alloc_rw(EXECMEM_BPF, size);
+}
+
 void bpf_jit_free_exec(void *addr)
 {
 	execmem_free(addr);

-- 
2.53.0


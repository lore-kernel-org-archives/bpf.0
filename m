Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D03B8D4A;
	Fri, 26 Jun 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499392; cv=none; b=FQIvF/pEl7RZQGaEvm7TZqMbK6YL343vJwUXfOBq/Q+LKCkLblmBRjq/uLUlzZmm220/I3BOUTrE7l5qaNJdmkNvCjtzyw3AW1ZdW/XEaC6lYojYqmFLC9Q6PmH1q2V8Y2ogvcFF5d2KuwOuU0PXXQhrc8XOk6BoRA0MeCSsFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499392; c=relaxed/simple;
	bh=bI/KHTolIdtv3FTL7InJ0hhNUfnZEdK5r+sQZIY2CLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKKXqJ4ZyY8Q2Gui3YzoCQ104tFbbcKjnRQ31MOo07xQB3D37gsjU20c9Fyikr/SKiHhNJhwdwEcNWL7NK1GJk+O5GiyPaXPpcpJS6Fe31UZYrnrly3Hvp4MK5x1f9jx0Ld6OzNjnPD+16Oo9LdfU1G2JMIn4zyJe+RTqUhmjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFfFAi98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFfFAi98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A91F000E9;
	Fri, 26 Jun 2026 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499391;
	bh=TdrRiIsdo13lPOUfMh91dChbQ2OeqjtHy5SaLFlDk0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JFfFAi98RyZxqVduQMmsHxMB25bLkHww4LgIocBQXNAz6kbFe7++bA2T8MBuAyrhs
	 cidqwJzRWK/IE0ZeHVCNFEpWa0KqKLeDn6BhhfSKSfJLtyWSbSIDHCymKVzC5JqPRz
	 POl6gCJJnWOjDoLF2+RQYcmoliTmFd8jr7SiAVoajdKKFpr66YesPjx9zgLHfQW+oL
	 E59NhIUeQTbcABTNyGtu3EzaWbcVrTtgk344cjdEZwO59FUnyHv2RZbBGWEzRzL8Va
	 DRDeBzCnCNeiOjfuR8dWWmC0fGYmYWClTixJ35VTAO6YF9h3P0CGqtOGmBFqNkROvz
	 amiRa89izefEQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 26 Jun 2026 21:42:31 +0300
Subject: [PATCH bpf-next 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-4-45a0b0ed4fe9@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
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
X-Mailer: b4 0.15.2

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
index 054e043ffcd2..ba562d3bf031 100644
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
index 67d337ede91b..773b16f06572 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1323,6 +1323,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
 u64 bpf_jit_alloc_exec_limit(void);
 void *bpf_jit_alloc_exec(unsigned long size);
+void *bpf_jit_alloc_exec_rw(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9666b6cca797..55284b5d0292 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1072,6 +1072,11 @@ void *bpf_jit_alloc_exec(unsigned long size)
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


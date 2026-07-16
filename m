Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D023AFAEB;
	Thu, 16 Jul 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188329; cv=none; b=u/OXsAO32BuIoMZMGDdnHgZEesLdwPmWy3qRY4clhKZkdaj4kk//Fn8OhEZioHFioWqOjP3r9VNS+sIaxTb82cpT/c+CZXkhuk3s5UviJhcf+vkmU0ze9YlByTjZbQvVh3mvLUdnO/1Ek/iMmpRFKwrz3kI1QrALJdYVKiqE5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188329; c=relaxed/simple;
	bh=5P0sua/71rPK3l5T6jCA12GMKa2j6NT1JAfTkULYULA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aphTn2r4DPUnTUNPGoFvIrb9jTONBuoaWipPkRJwp6wMiPJyiii5NFvGZDEMidCrO9v/fygIwPGRhGP2HTeJTloJm+bQ6lAEeCNCkFYMYPrFzUIJGtWWnORslmqTN+VpqQikO4Z5K1Kk+oMWQdzaHSuFC76YUL4Vp6ZODpaKbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9HKxYuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9HKxYuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B61F00A3F;
	Thu, 16 Jul 2026 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188320;
	bh=IatqBvV/RTdCVpUja1LQkhqHsNuZ9wpcED5UwFKZr5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F9HKxYuZjI7mg9CHs1gu6tIuTYVX5BE8bGwTbX/qHgaMj9Z5tKGh4H8gIvEpKgtpJ
	 dBsO1HjtPc3Y7Mbb2+jgbet2IDb2aE+xHeFhb6W6UrUMAVLUOLAoozPTskPSjFAigK
	 zqpZ4EViHeA0YjqG8VOnxC9ojJBpiflZZrPCnXdc/eeXCJt26whX7YKpCT0NIrvoOI
	 nmwxitp71PGGYMEKeZ0srND6WMr/wy3awrOnvfJ8LYykGuIojU+2K2ekK1xKnTKUUK
	 5TDfqjs9HVtCtqQj6dgYoc4aTJLiErifk5b0xVWDKw3P8Qk0XCeEplLugmUldrfbhL
	 qvXBdy6ohTucg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 16 Jul 2026 10:51:37 +0300
Subject: [PATCH bpf-next v3 3/5] bpf: alloc_prog_pack(): skip ROX
 management for already ROX memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-3-4e76158c01c5@kernel.org>
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

execmem_alloc() can return ROX memory that is already filled with
architecture defined trapping instructions.

In preparation for enabling this mode for BPF on x86, make sure that there
is no redundant management of the ROX memory.

There is no need to fill allocated memory with trapping instructions, to
request permissions reset on free and to set ROX permissions as this all
is handled by execmem_alloc().

Add bpf_jit_mem_is_rox() wrapper for execmem_is_rox(), use it to check if
execmem_alloc() returns ROX memory and skip the redundant steps in that
case.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/bpf/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fc75625dc951..1b89c18cf246 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -916,6 +916,11 @@ static LIST_HEAD(pack_list);
 
 #define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
 
+static bool bpf_jit_mem_is_rox(void)
+{
+	return execmem_is_rox(EXECMEM_BPF);
+}
+
 static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
@@ -927,16 +932,18 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr)
 		goto out;
-	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
 	if (static_branch_unlikely(&bpf_pred_flush_enabled))
 		pack->arch_flush_needed = true;
-	set_vm_flush_reset_perms(pack->ptr);
-	err = set_memory_rox((unsigned long)pack->ptr,
-			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	if (err)
-		goto out;
+	if (!bpf_jit_mem_is_rox()) {
+		bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
+		set_vm_flush_reset_perms(pack->ptr);
+		err = set_memory_rox((unsigned long)pack->ptr,
+				     BPF_PROG_PACK_SIZE / PAGE_SIZE);
+		if (err)
+			goto out;
+	}
 	list_add_tail(&pack->list, &pack_list);
 	return pack;
 
@@ -965,7 +972,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
-		if (ptr) {
+		if (ptr && !bpf_jit_mem_is_rox()) {
 			int err;
 
 			bpf_fill_ill_insns(ptr, size);

-- 
2.53.0


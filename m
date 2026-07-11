Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79502381E80;
	Sat, 11 Jul 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763068; cv=none; b=DY1A2IHBBJtQf6xL/RKDpNIF9cBTlCxh1cNG1qVdqlBW/s8DqO7bvzAPkV0kP9O9/JEkUQ5GjxK8sK/1pPQ6pEuphuCXoYzf7jteXCmZNUs5dAq7iRl4NlmP71JdoLTzOLb/sHPEpEgek2z2umig69uBbuUG+GnawCuZdFrjsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763068; c=relaxed/simple;
	bh=5P0sua/71rPK3l5T6jCA12GMKa2j6NT1JAfTkULYULA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrKgsCLhCt253N1xOlpFwDtXCBVs5Gi6vlob+4QFAQAN9USCVX8dOHn0FCpHPNwHHPzGHLuTrijzupk9Xf/wiEtIoqPxRu799tT+HKwldKBengWc8o+4r5WK0ajtx10AIOumNSL2tqpz5C+aqb0Ys5VnrfBgiYlCGqgfS3WhXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAoz4on9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAoz4on9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F7B1F00A3A;
	Sat, 11 Jul 2026 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763067;
	bh=IatqBvV/RTdCVpUja1LQkhqHsNuZ9wpcED5UwFKZr5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XAoz4on9c26Snv08lb63ljkDeQeteH+ON+KmJTJxrBQ7QAYD6kkAES3VWZjbpz4DA
	 Iz36RjarEwDxD7QzK2V7BqyH6afYxr4gzw70RphGtMILmdeQczCsvmXqXyRdPA3CpU
	 UImGzFsbsxb1jR73T9eWMnRjRbQR3amgFwNl7ARcoYXlfwzvCdPH3QvvyvQWcvGTED
	 qR3JYKk9l0HhUHGT/o0yVihTyl3ygM7i/nTQdvFs/oSyGmGd/XVaKkBntEwCXTPJ9L
	 bX3DSbcmP4Ztu2JpI3LhYEOv/xZpsXQRxh7Nnt3x+Y69wFwgwg1+hkyn1ovndIclL0
	 tZL0rTHdKfsOw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 11 Jul 2026 12:43:47 +0300
Subject: [PATCH bpf-next v2 3/5] bpf: alloc_prog_pack(): skip ROX
 management for already ROX memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-execmem-x86-rox-bpf-v0-v2-3-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
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


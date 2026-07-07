Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A742379C;
	Tue,  7 Jul 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433891; cv=none; b=KvzozPv9SzKDg6GMn9ycmIja0O9lMEFeZlvk2N651SV1uALW+yIqgtXwnNZ2Lc8b+EKfMEMLSnQwofst+fZcPNKT9VY07L1Js0L9f2vr73CQsMNcaGWV5MI+IL4ob4S5Q7DH/78Vo8hIB+so2xl0O3jRu5tJ1oE+O8+EX/dMJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433891; c=relaxed/simple;
	bh=ZvePkxuYnomSGIXLnTkR8K7/eEhekkuBobhAT1TdTH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9QJYoTgI5CTf/T/bDUSjCD19pBLTCDQG6TzHheR8rZYFm+euYaMgBXQaXHkKRTS2eDDRDRAc4aVZMVO74EMMr4VWAFWkkpUgd1mmrjV0Gr6/VjAr9DLpKGDZl2pQv5bVe7HsIcNBFni7y+3TvhbjXbDXIkiX4qNHPqLKWN3SXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gvjx15f3DzKHMLg;
	Tue,  7 Jul 2026 22:17:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 405E94056F;
	Tue,  7 Jul 2026 22:18:01 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBnd3OXCk1qwUWNAQ--.43005S3;
	Tue, 07 Jul 2026 22:18:00 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v5 1/6] bpf: Extract the is_struct_ops_tramp helper
Date: Tue,  7 Jul 2026 14:22:14 +0000
Message-Id: <20260707142219.2871758-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707142219.2871758-1-pulehui@huaweicloud.com>
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnd3OXCk1qwUWNAQ--.43005S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfGr1kGF4UXF1kGr4rZrb_yoW5tr4UpF
	1fur13Cr4kWr1xWFyktay8ZFya9F1vqrW2gFWUGaySka1aqryUXF1rGw4UCFZ8GrWYk3Wf
	ZrWj9rWDCrykZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIw0e
	DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Extract the is_struct_ops_tramp helper, and use it in riscv and loongarch
as the current checks are somewhat hacky.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c   | 6 ------
 arch/loongarch/net/bpf_jit.c    | 2 +-
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 include/linux/bpf.h             | 6 ++++++
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b0075ece4a6e..36337c3dad85 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2544,12 +2544,6 @@ static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
 	}
 }
 
-static bool is_struct_ops_tramp(const struct bpf_tramp_nodes *fentry_nodes)
-{
-	return fentry_nodes->nr_nodes == 1 &&
-		fentry_nodes->nodes[0]->link->type == BPF_LINK_TYPE_STRUCT_OPS;
-}
-
 static void store_func_meta(struct jit_ctx *ctx, u64 func_meta, int func_meta_off)
 {
 	emit_a64_mov_i64(A64_R(10), func_meta, ctx);
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2738b4db1165..686e2991ff6d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1843,11 +1843,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	int stack_size, args_off, stk_args_off, nr_arg_slots = 0;
 	int retval_off, func_meta_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	unsigned long long func_meta;
-	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
+	bool is_struct_ops = is_struct_ops_tramp(fentry);
 	u32 **branches = NULL;
 
 	/*
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f9d5347ba966..406e774b4ac3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1033,7 +1033,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
-	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
+	bool is_struct_ops = is_struct_ops_tramp(fentry);
 	void *orig_call = func_addr;
 	bool save_ret;
 	u64 func_meta;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index adf53f7edf28..70aad8d7d84f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2196,6 +2196,12 @@ static inline bool is_tracing_multi(enum bpf_attach_type type)
 	       type == BPF_TRACE_FSESSION_MULTI;
 }
 
+static inline bool is_struct_ops_tramp(const struct bpf_tramp_nodes *fentry_nodes)
+{
+	return fentry_nodes->nr_nodes == 1 &&
+	       fentry_nodes->nodes[0]->link->type == BPF_LINK_TYPE_STRUCT_OPS;
+}
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 /* This macro helps developer to register a struct_ops type and generate
  * type information correctly. Developers should use this macro to register
-- 
2.34.1


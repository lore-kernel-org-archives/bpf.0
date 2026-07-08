Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC143D6CAA;
	Wed,  8 Jul 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492824; cv=none; b=SJU1HwQVUqBRVlPBnGnODpZwvGiH7SlQT8oTriPCy0T7YCiSnuggbr9ye9ZVK/8Af+IcY9cqQC1AUs95FrgY8pNsA7gyFuJWp3zHBu1iwIeWkATVe0IwrgLI//q+5qUn9q0VXTaf/+haK7L+NqIpVEpvTTyCp2uiJPlADOPc6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492824; c=relaxed/simple;
	bh=E72cQ5gEaYsGF4kiTdWq5j1R0JKAZa2mQQjs8zbfQtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuqZS+otXgzrk2MVmWFnsGNxXmPF0ilX7wv4vplPj6jlneFh8hSt2tQjChZzTp2lDytrY2SwBfizHNSlovVnTcmQwBjGtN7PkARwM9uHsU+jAEq1ltoGVbuHutLgb2KIO3xAgYpgCU1VrOnrKzKfFsmeJdxKO5oUKS+5T54DFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw7kN1xvrzKHMMs;
	Wed,  8 Jul 2026 14:39:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D0E9740AEB;
	Wed,  8 Jul 2026 14:40:16 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgD32yfQ8E1qblLgAQ--.30661S3;
	Wed, 08 Jul 2026 14:40:16 +0800 (CST)
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
Subject: [PATCH bpf-next v6 1/7] bpf: Extract the is_struct_ops_tramp helper
Date: Wed,  8 Jul 2026 06:44:30 +0000
Message-Id: <20260708064436.2971933-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708064436.2971933-1-pulehui@huaweicloud.com>
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD32yfQ8E1qblLgAQ--.30661S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3WFy8Kr4fKF4DWFykXwb_yoW5JF17pF
	4xur13Cr4kWr1xWFyktay8ZFya9an2q3y2krWUG3ySka1aqry7JF1rGw45CrZ8GrWYk3Wf
	AFWj9rs8urykZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0U8
	n5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Extract the is_struct_ops_tramp helper, and use it in riscv
as the current checks are somewhat hacky.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c   | 6 ------
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 include/linux/bpf.h             | 6 ++++++
 3 files changed, 7 insertions(+), 7 deletions(-)

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


Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4533122D;
	Mon, 29 Jun 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741405; cv=none; b=lTAoTByGzjgPTvKJJjQcrZ2tnVHbsRbV1UJ6zOntivL6yGdVf1BNhLBoDxkPpoWCyVcHmQ7Add3QI9Y5r7CwJA3U+4juOcUMcXcC9SeFl9qQU1SKvKuH7aEfjIpGW1YyuDQNzhusRJnzyxB9ox8sPJHsBlZVtXNeQzSxo/GOsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741405; c=relaxed/simple;
	bh=plIULUfEnzrzN6J/ZtMiDTWHk8KrLIQA0Vw39n3JwJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlPW+Y5Yj1H2hRhs23pV8rweIROqR6P6mmMgPSH28tedQS1E2FD4WeTtk87XD62dPyeA+mvG0UXM5Yfy+BhQ50lMtQgg51sCdD5BoYrU+SBoNZpMAiRjGhLmSdqVGewTalCHIgO2BNwqmigQs8c2g5PB+gL3v+7MUOeJ2wzyaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gpnqQ5LHzzYQv0t;
	Mon, 29 Jun 2026 21:55:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DD69D4080A;
	Mon, 29 Jun 2026 21:56:37 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCXBfOUeUJqDlQCAQ--.44260S5;
	Mon, 29 Jun 2026 21:56:37 +0800 (CST)
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
Subject: [PATCH bpf-next v4 3/6] riscv, bpf: Using kvzalloc_objs to allocate cache buffer
Date: Mon, 29 Jun 2026 14:00:45 +0000
Message-Id: <20260629140048.733346-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629140048.733346-1-pulehui@huaweicloud.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXBfOUeUJqDlQCAQ--.44260S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3Cw13GrWfGw4Utr4fXwb_yoW8uF1UpF
	4DGrnxCrZYvw4kWF1ktF48WFy3ta1DW3W7GFWjk34fXFyqqrWUX3Z5Cw1Y9Fy5CFW0yw1r
	u3yY9rnI934kJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

It is unnecessary to allocate continuous physical memory for cache
buffer, and when ebpf program is too large, it may cause memory
allocation failure.

Acked-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 4 ++--
 arch/riscv/net/bpf_jit_core.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ebff0388c3a3..69512d93ca4a 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1195,7 +1195,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (fmod_ret->nr_nodes) {
-		branches_off = kzalloc_objs(int, fmod_ret->nr_nodes);
+		branches_off = kvzalloc_objs(int, fmod_ret->nr_nodes);
 		if (!branches_off)
 			return -ENOMEM;
 
@@ -1300,7 +1300,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	ret = ctx->ninsns;
 out:
-	kfree(branches_off);
+	kvfree(branches_off);
 	return ret;
 }
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 452ca08e35a7..c1d6cc7a9135 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -72,7 +72,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx->prog = prog;
-	ctx->offset = kzalloc_objs(int, prog->len);
+	ctx->offset = kvzalloc_objs(int, prog->len);
 	if (!ctx->offset)
 		goto out_offset;
 
@@ -164,7 +164,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
-		kfree(ctx->offset);
+		kvfree(ctx->offset);
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-- 
2.34.1


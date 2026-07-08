Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B253CAE83;
	Wed,  8 Jul 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492823; cv=none; b=kzdrYGM5riL/q6avflhrRIPiP6BhIVXgXsCjtCwEDWXzsY01KaA8y8qQt4WJLh90RlYdevPDPPJMYgdo6Szz+6yefTmfNdx+db1lgdDEqr+J4UhkaK1z1jjh1eEqHXvNcedPqEsDdUBleUmlvPRV2neUR8egRTMYM8DHihi4tPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492823; c=relaxed/simple;
	bh=qPt9I6+9XToEtbUdM01fhPiq431pMpOxWncjbkoEv6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlJUwj87rDh9NRtB1wfCmnqqRYmktqmWdnSUkJxiVWCiXJ6WHXHFT6YMsVT29R5g4BqU4LssdRrMMM5tHdcY1yNw00/L1YGmNUidbYD+wEKGx9Rt9V4QMGbEcGRpOdvVimSuWxQdEj4FtNgjFIbCVTpb8NuZPXQlZHj8Oml4mDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw7kN2cVwzKHMND;
	Wed,  8 Jul 2026 14:39:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E5E534056D;
	Wed,  8 Jul 2026 14:40:16 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgD32yfQ8E1qblLgAQ--.30661S5;
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
Subject: [PATCH bpf-next v6 3/7] riscv, bpf: Using kvzalloc_objs to allocate cache buffer
Date: Wed,  8 Jul 2026 06:44:32 +0000
Message-Id: <20260708064436.2971933-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708064436.2971933-1-pulehui@huaweicloud.com>
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD32yfQ8E1qblLgAQ--.30661S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3Cw13GrWfGw4Utr4fXwb_yoW8Kw1fpF
	4DWwnxCrZY9w48WF4kta18ZFy3Ja1DW3W7GFWUu34fur90gryrX3ZY934Yga98CFW8Aw1f
	urWY9rnxu34kJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz
	E__UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

It is unnecessary to allocate continuous physical memory for cache
buffer, and when ebpf program is too large, it may cause memory
allocation failure.

Acked-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 4 ++--
 arch/riscv/net/bpf_jit_core.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 406e774b4ac3..2f06752fb036 100644
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
index 7cce19118619..cbfcd287ea16 100644
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
 
@@ -170,7 +170,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
-		kfree(ctx->offset);
+		kvfree(ctx->offset);
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
@@ -234,7 +234,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
-			kfree(jit_data->ctx.offset);
+			kvfree(jit_data->ctx.offset);
 			kfree(jit_data);
 		}
 		hdr = bpf_jit_binary_pack_hdr(prog);
-- 
2.34.1


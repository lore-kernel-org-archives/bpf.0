Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355C52BE58;
	Wed, 23 Sep 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168977; cv=none; b=SbNDMxafFoUqmHTkauE7hjhEXl1nUgQLL6TTx9xobgnNsSlvNlQCpV7wO5iAhJTXMoA9xng87CQ3VP5wqo9Qat0nJdVG1WVPmENP8jFWXrJk6sJauNFPEf/t19RQm3rJ7Ix48ZiHCM0tRgH7EYfY+NbLac8eVDKsvLQnx75Xz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168977; c=relaxed/simple;
	bh=bg9bhbGrO8szyUuIieyhFOaqXkMVTj0HA51QVzs36Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm5mUTHivQkiNstg6gqSOZ+JgZtppk2o26PVZu1L6zl/sS9/zOL8iDR69PxLOZfZe146mhDc2ATRuzkzTes6Ma7d8x8B5FHByY8NaYOt/scAUmvnNdQ0z8td4abNQXkXqwA8c7b0FOL1xBJ+mC65qmDannDQVvZ9vREm2YlrHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sKhOeygB; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sKhOeygB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790168968; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o6SVUnKde/TR5k8kPB3Bgbc2uo8e/oZYlAsOUPZzYhI=;
	b=sKhOeygBsXf+Zln0mzQe72MUeS4kW5KijfS93dKnGdTxxJIh4cNUuIeezsvLqnmE0aaaOzmBJDdTFP12eBJQewvJKu8q/2HiR5Yuq3wxA2X3Ad0n1QEVR4Q1HTp9QdGUIJzU5IwACvrpgFH5L6t63ouUtV6NQvOr2AQMpU8CBQU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBX4ZPB_1790168967;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBX4ZPB_1790168967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 21:09:27 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf, riscv: Add support for indirect jumps
Date: Wed, 23 Sep 2026 21:08:55 +0800
Message-ID: <20260923130856.1157-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923130856.1157-1-cp0613@linux.alibaba.com>
References: <20260923130856.1157-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement JIT support for the indirect jump instruction (BPF_JMP |
BPF_JA | BPF_X), a.k.a. gotox, which lets a BPF program jump through a
BPF_MAP_TYPE_INSN_ARRAY jump table.

Emit "jalr zero, rd, 0" and hand the xlated to jitted offsets to
bpf_prog_update_insn_ptrs(), which is what fills in the jump table
entries; without that call the load fails with -EFAULT in
bpf_insn_array_ready(). ctx->offset[] holds the offset of the insn
*following* insn i, as bpf_prog_fill_jited_linfo() expects, so it is
shifted by one and offset[0] comes from the prologue length. build_body()
now records both halves of a multi-insn record, so no slot keeps a
fabricated offset.

Only the RV64 JIT is covered; RV32 keeps failing to load as before.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/net/bpf_jit_comp64.c |  5 +++++
 arch/riscv/net/bpf_jit_core.c   | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ed0a6f871dea..9de3749fb268 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1691,6 +1691,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_zextw(rd, rd, ctx);
 		break;
 
+	/* JUMP reg */
+	case BPF_JMP | BPF_JA | BPF_X:
+		emit_jalr(RV_REG_ZERO, rd, 0, ctx);
+		break;
+
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 	case BPF_JMP32 | BPF_JA:
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 2fb0b4e198b9..15acf249fed4 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -26,10 +26,13 @@ static int build_body(struct rv_jit_context *ctx, bool extra_pass, int *offset)
 		int ret;
 
 		ret = bpf_jit_emit_insn(insn, ctx, extra_pass);
-		if (ret > 0)
-			i++; /* skip the next instruction */
 		if (offset)
 			offset[i] = ctx->ninsns;
+		if (ret > 0) {
+			i++; /* skip the next instruction */
+			if (offset)
+				offset[i] = ctx->ninsns;
+		}
 		if (ret < 0)
 			return ret;
 	}
@@ -176,6 +179,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
+
+		/*
+		 * bpf_prog_update_insn_ptrs() wants the start of each insn, so
+		 * shift the linfo array by one and get insn 0 from the prologue.
+		 */
+		for (i = prog->len - 1; i > 0; i--)
+			ctx->offset[i] = ctx->offset[i - 1];
+		ctx->offset[0] = ninsns_rvoff(ctx->prologue_len);
+		bpf_prog_update_insn_ptrs(prog, ctx->offset, jit_data->ro_image);
 out_offset:
 		kvfree(ctx->offset);
 		kfree(jit_data);
-- 
2.50.1


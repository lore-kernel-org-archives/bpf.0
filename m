Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E13659EB;
	Mon, 28 Sep 2026 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562426; cv=none; b=bEnvZGtWXFgmf4dWlXiBWtMWkZHXEDvdTcFkL+sFf8nOWmvFY2rpnS+m3THR5icsU4mrDIEB+LiAklEUmXJox7i+AFHJDg0h4xfiX5Z84V9bY4Bv6LYCPHYKgqTGQP621yghf5gGNGMJAL8qjyUcGkhjgUpyq3d2Bboi4r2/3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562426; c=relaxed/simple;
	bh=+IHq2LajwxLmLBH4+t94ISfOlEZHbtgmyo+rg9UBkok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abtas3TF3RImVovlc1vmo1Ac2eHrRg9a+l0bXz2NbIVL1zL7emgA5whPITOGy++vbDFIrCzUhkpdVnxpSM/GhIpXpSp74r6B/Zj1s0mm6kLUUeHWaSPO+8a1/8oQUyFkXoji2cN2XSEVLiGSDsW3PCBUhWuRfwo6j33DGK98O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lw3n/7PB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lw3n/7PB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790562411; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=065VVLUzE02OfjnOXMUOzcbAkEzc2W26yXRo/QM7FkE=;
	b=lw3n/7PBhyjKtJxTar4YlIV2Vof4HdDv9uQIRHRxQ+5prymNgvcSZ9JPO3VQoTpMVHxgEyD5tFxZFe+CXp5zd1S5d2jk/gD1ll2H2c0OabMjBT11H+J54jCYQcAPAlDHnKcVd6Z2reVKGkifHdlaMfWWBjOdfClVSq8TUT3P9L0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBgzgOW_1790562091;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBgzgOW_1790562091 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 10:21:31 +0800
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
Subject: [PATCH bpf-next v2 1/2] bpf, riscv: Add support for indirect jumps
Date: Mon, 28 Sep 2026 10:21:08 +0800
Message-ID: <20260928022109.1093-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928022109.1093-1-cp0613@linux.alibaba.com>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---

Changes since v1:
- Reword the code comment to say "shift ctx->offset[] by one".

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
index 470a6ace5662..5265dd5bd39e 100644
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
+		 * shift ctx->offset[] by one and get insn 0 from the prologue.
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


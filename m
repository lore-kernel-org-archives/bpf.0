Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6E3112A5
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985092; cv=none; b=fBFdmhq5f4s0aTC7cYtL+SMyueEM/IKMKxEiB1+0mFmQAkf/qC8ORZL0vI+EK9yMrzvSxh2JhY7U0uXF6sQgo/Dk1SRz9QnGiSLrlD5mWKrvTAh5ehA14rjxYD3gckHJHtahiP++flCLt0XNTutNJwPDhoh55utaPeLvYJXs29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985092; c=relaxed/simple;
	bh=aa3qWvUPCmRh4pCzXnBNcE4eCfPH8a6fYvAoJhTFWHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9vvYnbxiLrV7+7G5TsQ+GhFyXJECZ+d1T3NB2BQfsFxmTmgRrFDH/aJftYpX1hJvsHupOcfQmS2iU0bEkX884K27QLDDM0CRiiqVUrtOt5H0xF8ISfVDAW3qgL2IicLGbP4oKYkjFv5jhT8kTbbCdr+9lNaS+zEdB2YBrHYUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpmASJun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpmASJun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4501F00A3C;
	Thu, 28 May 2026 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779985091;
	bh=5tQgGnkdHxEM/wLQx5ec96DsLADSPZSksdytZbAN40g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpmASJunHqJOI6D0vRI3GOgtWzcW0Jzqx/Vogt5tE6kqRR8zPTOlr9s8+3yNaFZ+S
	 zMLtDvS1ckG/ZoF6OvY8p6Dqmk3hfIX10poUQW5bEusEbqnOpBjbJvXJKXd9OAnCB/
	 PsTqpa0VjkUQQm5x84AWXYJvs6oSO77xiDEDgKxxDZe/yV6ezDj/sl37YoDtUFTh3T
	 ZHeTVnlDBNy7EH3q9ra9l8Lb+B97/2ISsgvHGSofdjdBLGXLU5EmxU+UP0CPRaYvWs
	 golw9K1W3TZGT+MNmKGEYJQe7GhPRe1i12f8nGs8/6xWP62s+9AI0FkaIg+dtODGdj
	 h7o3jwgLJHpTg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	"Yonghong Song" <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 1/2] bpf, arm64: Fix redundant MOV and clarify stack arg comments
Date: Thu, 28 May 2026 09:17:47 -0700
Message-ID: <20260528161750.1900674-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528161750.1900674-1-puranjay@kernel.org>
References: <20260528161750.1900674-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_stack_arg_store_imm() materializes the immediate into tmp and
then moves tmp to the target register (x5-x7).  Emit the immediate
directly into the target register to avoid the redundant MOV.

While here, qualify the bare "FP" in the stack-layout ASCII art as
"A64_FP" so it is not confused with BPF_FP, and note that incoming
stack arguments sit above the FP/LR pair pushed by the callee
prologue.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e3bbeaa94590..b4abc3138f37 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -546,7 +546,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *                          low
 	 *
 	 * Stack args 6-8 are passed in x5-x7, args 9+ at [SP].
-	 * Incoming args 9+ are at [FP + 16], [FP + 24], ...
+	 * Incoming args 9+ are at [A64_FP + 16], [A64_FP + 24], ...
+	 * (above the saved FP/LR pair pushed in the callee prologue).
 	 */
 
 	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
@@ -1235,11 +1236,12 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
 {
 	int idx = -bpf_off / sizeof(u64) - 1;
 
-	emit_a64_mov_i(1, tmp, imm, ctx);
-	if (idx < NR_STACK_ARG_REGS)
-		emit(A64_MOV(1, stack_arg_reg[idx], tmp), ctx);
-	else
+	if (idx < NR_STACK_ARG_REGS) {
+		emit_a64_mov_i(1, stack_arg_reg[idx], imm, ctx);
+	} else {
+		emit_a64_mov_i(1, tmp, imm, ctx);
 		emit(A64_STR64I(tmp, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u64)), ctx);
+	}
 }
 
 /* JITs an eBPF instruction.
-- 
2.53.0-Meta


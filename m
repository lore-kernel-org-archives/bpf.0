Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD812D3A69;
	Mon, 13 Apr 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083614; cv=none; b=ONszNG9TnDsGnpFH8kLxPX8x27D+mophqJPiJNGyRTvq+8mAQMJpWlXfBXb9SFPXmtGLZm8uvEwQ6qbyv6G7/TzLdCFpWlRpJ+Dx9gtWqVfjDTpQFnPShBVWKIW9uf3wgYn7+MIv49HftrT8VpGEfQgyvao2fN5tlCwQiv4KMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083614; c=relaxed/simple;
	bh=s2vi1gMOe/zR29r19y5FbZV0U3O5/J47TujbBaojO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwLYwhHn2neM+x6/9/r/IhlxiECnxxkqGzu+RctMmgWyaekKSEVJtolHz+ec5W7NvQBv/+K4uxWFWI5qTjqRvKVuWTZSEq6sLYdX3yZt4gbIvFX4Iq3uEc5H+bHDm7TFR+ox2hjrPqWZ0y/KwzysnFkyUwNng2NK8pfutU3+CpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyVdMkfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyVdMkfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C778C2BCAF;
	Mon, 13 Apr 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776083614;
	bh=s2vi1gMOe/zR29r19y5FbZV0U3O5/J47TujbBaojO2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyVdMkfK4Oedgp2gw/N++DpkgaKb8l8tqh6RNQQu+m78z4PZX76lWAkk7uCa7uTzw
	 WjO4QNoNAx8PaoFPUDio7r7lHUblHPTnjKE+CSKp2IFpaRCr2O7H7qA+Ov33NVq9/7
	 6oqMi2QvgGZ6rInIBaUEcu4wIsjD+tRbVYAmw6sIJvml1IF7ow6rvdRSr3DOLeIk1J
	 Gx72Cfs3ZAm26IK48vwf1zqZr1sSng05KRjk1fpTRty7IiznAstw4qSYj016I6PnKz
	 iggPuonwpdFCEul7W4eCW05XVHjsdAQq5jw6sisOiWjot2aosVsu/Oa7PqOLokO80m
	 TiydTUzKdzQkw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
Date: Mon, 13 Apr 2026 05:32:55 -0700
Message-ID: <20260413123256.3296452-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413123256.3296452-1-puranjay@kernel.org>
References: <20260413123256.3296452-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_flush_icache() calls flush_icache_range() to clean the data cache
and invalidate the instruction cache for the JITed code region. However,
since commit 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the
BPF JIT"), this flush is redundant.

bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
region via bpf_arch_text_copy() -> patch_text_nosync(), and
patch_text_nosync() already calls flush_icache_range() on the written
range. The subsequent bpf_flush_icache() repeats the same cache
maintenance on an overlapping range.

Remove the redundant bpf_flush_icache() call and its now-unused
definition.

Fixes: 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the BPF JIT")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/net/bpf_jit.h      | 5 -----
 arch/riscv/net/bpf_jit_core.c | 7 -------
 2 files changed, 12 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 632ced07bca4..549537cad86b 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -105,11 +105,6 @@ static inline void bpf_fill_ill_insns(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
-static inline void bpf_flush_icache(void *start, void *end)
-{
-	flush_icache_range((unsigned long)start, (unsigned long)end);
-}
-
 /* Emit a 4-byte riscv instruction. */
 static inline void emit(const u32 insn, struct rv_jit_context *ctx)
 {
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index b3581e926436..f7fd4afc3ca3 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -183,13 +183,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog = orig_prog;
 			goto out_offset;
 		}
-		/*
-		 * The instructions have now been copied to the ROX region from
-		 * where they will execute.
-		 * Write any modified data cache blocks out to memory and
-		 * invalidate the corresponding blocks in the instruction cache.
-		 */
-		bpf_flush_icache(jit_data->ro_header, ctx->ro_insns + ctx->ninsns);
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
-- 
2.52.0


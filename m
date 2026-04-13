Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11B3B9D96;
	Mon, 13 Apr 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107483; cv=none; b=Cqh9C90zTRTQPGm8Nin2h77CJFyRf150O9xxIlBCDRgwv6SA8OlkLaOfF/THNW53mjaAEBPJJycgmVZzSZAp1mju6MTBfXg+NXd0rqsV4qyXXQPqWKaapGmv5VeEvUyJ/WecPDi1YVhtNLZGBZW4W+hCH1kdKV0F//QpzbL0JkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107483; c=relaxed/simple;
	bh=RaXnAWNff4duq1RNyPN0ZReQj1L/HbYwn3Mst5z7mDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3Ic8o3+eaIsDQDD3oiEkCnekHXlKL4+2eUFq+vxGQ+WvySJE100d2jfmRNTR++HDENegeDBkfdKv63IS1mU6Vra2LwkBs9+nVBeQVetLwvHKpQWrMuL/3pMROuhUASIfKs/jud4mG0lI6MMwBp+Vn32mkaPxXfNZaf6tbJvt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlCnP6Rm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlCnP6Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B8C2BCAF;
	Mon, 13 Apr 2026 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107483;
	bh=RaXnAWNff4duq1RNyPN0ZReQj1L/HbYwn3Mst5z7mDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlCnP6RmxuAKB0gAI1nC7kPGEqeRRo2NXdlC9bNO65KDApEEdDpNeU4z90SabRxIB
	 EoHZGegIveSk6125qX30acurctIP7EWFM79fmbCGfHNpIDYKUUpCm/tqhIB2zsdRoV
	 wxBd9ehytg5O5ohrJvj3npz3Ld5au/mK1GznFKr1Gl97266oouDFBUbeWexk5VaZgn
	 y8k7DF2cJI4Pev+eCA3uKLdAlfeWA+Fz9KfLJeIm3Yijmo9pa+lbRtOkY2VX2YhMwp
	 e7+xMgK560SlBDGM9nmdlrK4Gbil0+C9vFPww1PnHuuvcWzvfqH6V0Ijw/3720apij
	 zkwL7tSaBL+cg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	"Luke Nelson" <luke.r.nels@gmail.com>,
	"Xi Wang" <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Pu Lehui" <pulehui@huawei.com>,
	"Paul Walmsley" <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>,
	"Albert Ou" <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf, arm64: Remove redundant bpf_flush_icache() after pack allocator finalize
Date: Mon, 13 Apr 2026 12:11:08 -0700
Message-ID: <20260413191111.3426023-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413191111.3426023-1-puranjay@kernel.org>
References: <20260413191111.3426023-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_flush_icache() calls flush_icache_range() to clean the data cache
and invalidate the instruction cache for the JITed code region. However,
since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
management"), this flush is redundant.

bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke(),
and __text_poke() already calls flush_icache_range() on the written
range. The subsequent bpf_flush_icache() repeats the same cache
maintenance on an overlapping range, including an unnecessary second
synchronous IPI to all CPUs via kick_all_cpus_sync().

Remove the redundant bpf_flush_icache() call and its now-unused
definition.

Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index adf84962d579..7417d24a5b6f 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -18,7 +18,6 @@
 
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
-#include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -1961,11 +1960,6 @@ static int validate_ctx(struct jit_ctx *ctx)
 	return 0;
 }
 
-static inline void bpf_flush_icache(void *start, void *end)
-{
-	flush_icache_range((unsigned long)start, (unsigned long)end);
-}
-
 static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
 {
 	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
@@ -2204,12 +2198,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog = orig_prog;
 			goto out_off;
 		}
-		/*
-		 * The instructions have now been copied to the ROX region from
-		 * where they will execute. Now the data cache has to be cleaned to
-		 * the PoU and the I-cache has to be invalidated for the VAs.
-		 */
-		bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->ro_image = ro_image_ptr;
-- 
2.52.0


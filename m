Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46746EF9B
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858416; cv=none; b=mOhZO3EWKBvdh4eBaJoh8NkUT2CreWEhw5L4lJwHr2aTo2txh6ZOIkbzxVEONmWtFcldUSHy2DbbAIM/Zklfxm2p87UNOOMLta9dHzbO8GQXAevSmhzWu8ukTp+sN7Xo2PcIbwg0UxAe3eBrn3doO5FZ2bFlxJKnc+hAtaWcNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858416; c=relaxed/simple;
	bh=IqS6oyBgIDjHtaQHvzSbG4MM9UaB29p+F+ApFnitYfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvZazIuYT1uXQAFFGjtNrPGco/mJ0nN7jC/2SWkWC+WBQrU0zcdV6j3ycmWO5hYxh2loBzxbCD8PLafwSWhuX0ShoPOoNEwGCN+P/+pXtAVRpmi1wMnTE8O19jr8/Lvy8nPnWg4Y4ihM1OU1f0Fuzm1/3R5HOamXpfF0BTgrtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+Ap7AAb; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+Ap7AAb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785858402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZajl5Xdn8pCbprwTdxblPIPdG7FZfeAhKaqi9LI+wg=;
	b=i+Ap7AAb+2UL+WGGv3vKg5oW4oFGgvO/ojWdNxgpOnwkcMV6S0FdYpUjkKDVHpwcxGsRAR
	4qN9P8PkcKjYkShHhEAEuAIXVlTDMzXmeyTBY3GA+fytqo1KmAYvwIZEqPj4ybZsVY+Njc
	1AsKMlEBwuvomFbGJGrrP8QWpIU9EAI=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
Date: Tue,  4 Aug 2026 23:39:37 +0800
Message-ID: <20260804153938.16129-2-dongtai.guo@linux.dev>
In-Reply-To: <20260804153938.16129-1-dongtai.guo@linux.dev>
References: <20260804153938.16129-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Support the internal-only BPF_MOV instruction that resolves the absolute
address of per-CPU data from its per-CPU offset. This instruction is used
only for internal inlining optimizations between the BPF verifier and the
JITs (e.g. inlining bpf_get_smp_processor_id() and per-CPU map lookups).

LoongArch keeps the per-CPU offset of the current CPU in $r21
(__my_cpu_offset), so resolving a per-CPU address only requires adding
$r21 to the source register holding the per-CPU offset. Advertise the
capability via bpf_jit_supports_percpu_insn().

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h |  1 +
 arch/loongarch/net/bpf_jit.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 54f35bcd0f66..585667e361c2 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -411,6 +411,7 @@ enum loongarch_gpr {
 	LOONGARCH_GPR_T6,
 	LOONGARCH_GPR_T7,
 	LOONGARCH_GPR_T8,
+	LOONGARCH_GPR_U0 = 21,	/* Kernel per-CPU base register ($r21) */
 	LOONGARCH_GPR_FP = 22,
 	LOONGARCH_GPR_S0 = 23,
 	LOONGARCH_GPR_S1,
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index aa88f904a5ca..b8dd956d46bd 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -722,6 +722,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_reg(ctx, dst, t1);
 			break;
 		}
+		if (insn_is_mov_percpu_addr(insn)) {
+			if (dst != src)
+				move_reg(ctx, dst, src);
+#ifdef CONFIG_SMP
+			/* dst += __my_cpu_offset, held in $r21 */
+			emit_insn(ctx, addd, dst, dst, LOONGARCH_GPR_U0);
+#endif
+			break;
+		}
 		switch (off) {
 		case 0:
 			move_reg(ctx, dst, src);
@@ -2376,6 +2385,11 @@ bool bpf_jit_supports_ptr_xchg(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.53.0


Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220152F745C
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959041; cv=none; b=If1JB4c427VqJY75ivseXWauKhSM0IO1aTNtO7FnIUMpgjZFMXJCLe1+PEf49PzrkDJPhbhnmUJg+HcHyVmxqlXDWtXdwgAIDMKkGaXpLSTw4j58seNizD+ejm48X5DoAmBhNoCmffpmqYT1q29QUJaOayksdB0siLyodBMdGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959041; c=relaxed/simple;
	bh=2YumHmT4R4gKfwEUrU+wl2y3oDnZcbSwBUhQbNWpBFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JY/CRzAD8r83Nh5HDKMuWiFuCX8r/R0H1bQ+Guib7QfwvFDeUt3WHO5AoVFEr+JxA/v9XDmB4FZKdJHJ1Y5TeFx/DPRE/N1dfXkItTay3kFoxUIarx0cr22BZ+65gJc0T+GibHJbS/uaG+fZ/n1GqA1gylJ4bxqlC+Jnp3iIwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfaR7vDl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfaR7vDl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eg2XUtsWbE8d0hRsNi6uEMkuMS8sIDRfMXn4zdVKrcA=;
	b=vfaR7vDlEzr7H511Y1gM++5ovrA2aW+i+R8Ajuq0pU+xoE1rT9C4vVAxO/1Fm/SqWeCY3k
	rU+VFE7jK+x3xdRIfd5bJDosqli5Mk4hTiVKYBiIssCjJW/LQo1LBvQv2iKpUD1pPDovTT
	lXXbEW8NxLsQkK8dcNTOYVrTWGusjU8=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 02/11] LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
Date: Thu,  2 Jul 2026 10:23:13 +0800
Message-Id: <20260702022322.51033-3-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
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
index 76b723590023..44fb5ad26d1a 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -404,6 +404,7 @@ enum loongarch_gpr {
 	LOONGARCH_GPR_T6,
 	LOONGARCH_GPR_T7,
 	LOONGARCH_GPR_T8,
+	LOONGARCH_GPR_U0 = 21,	/* Kernel per-CPU base register ($r21) */
 	LOONGARCH_GPR_FP = 22,
 	LOONGARCH_GPR_S0 = 23,
 	LOONGARCH_GPR_S1,
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 5e34e9e3f508..b4208fa3a242 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -759,6 +759,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -2406,6 +2415,11 @@ bool bpf_jit_supports_fsession(void)
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
2.25.1


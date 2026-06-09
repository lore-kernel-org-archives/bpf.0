Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828B271471
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978536; cv=none; b=XADSWOxEenZX7hJZLxIIirpl/zCeHy/PIhVExDnhMOR9TbnC4zVLtHzGYhbt5V+3M/12AGmY9KaJ/dzcx0jZxKrwxQxxCirKNwB4g+3JY0ClgyLOuZM3VQEZoVRVOKL4Y1AMA/Iun6EBHEEFqreinT+JygBI5Vvo/2aTxXnVmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978536; c=relaxed/simple;
	bh=wpbJHpxad+7JGWSjJRRls0fRZwwrcJLgft4B7iXSC0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klaUahqHeEwjza/VjyA4L+g7dyH5x4Z+zvXeLAcpeykpl2FEE5GuHgaUMxMBuXKtZTwIvqAWoezTmUwz9avosXyMPaxJ9Ft2apPdZkMZZGgA+4yYoCBOWgpCEirsQgg4EO2NDgZgfsWomnsT4t7XGXDtUymjU5VZ1xBytPrQgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TOiHzgak; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TOiHzgak"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780978533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWpTHfWWZUVThXrKoJmnC/j3bJH8+PPCY8BiE0/Gy6Q=;
	b=TOiHzgakf1wOTnqrq+QC64QowG3xa3xpYnlFIwMXgfzIB6sQTyjNgooLBEpQjR+dvHcpKD
	RwRU28FwCD6ux6c4XLyQEBkjeFsIsEadW8c8Hu7JTFhbv7nueawqx68KpyduZ89sMfwpwc
	gnntFOxndwhsg3y1XOtlHfRld8ssIQQ=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v1 1/2] LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
Date: Tue,  9 Jun 2026 12:14:06 +0800
Message-Id: <20260609041407.122384-2-dongtai.guo@linux.dev>
In-Reply-To: <20260609041407.122384-1-dongtai.guo@linux.dev>
References: <20260609041407.122384-1-dongtai.guo@linux.dev>
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
JITs (e.g. inlining bpf_get_smp_processor_id() and per-CPU map lookups),
and is not exposed to BPF users.

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
index 24913dc7f4e8..20d5bf792108 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -728,6 +728,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -2362,6 +2371,11 @@ bool bpf_jit_supports_fsession(void)
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


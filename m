Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DA2F8EBF
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959092; cv=none; b=LECvrQD6se9RkUoLD9mODrG2njrBAfM/E1HqtjFUD6B6kkfoi7iS7C2pnrcX9tt7zaGkKP9enxBw9bqQO2UPlmL4fDXlVXgMF9k0jTEdullrMVXaNthMBdLS2bld3RU6g+bol1hvkeJlLaBFgf8ZqgZi1eb6Y7CTNss6ASujv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959092; c=relaxed/simple;
	bh=WaV2N2RfmOEbjDJsy48Tb419zhchiiRgQ9o5wSSN5eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hnn9AbVYW6uD/UTC1rU82UOxFV7fs25X9wpAJGoqZNQtA4kLeL0EIlWCPJEWtLULgwUrKaIIy8mpQmjS1tYIXdTp9cbhKDWRVdvtyItlbKF9pfNEuFNw2WfryARCalEUyWC3T2y2/vUWTieVtwiiQNcXe4RkmPjRtF+jXT/vZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QZZodb+q; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QZZodb+q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ukdJkLQM1320Bw3py+/iIV6UhvYlsRtvZicAN+vI9E=;
	b=QZZodb+qUlARdDhHeGXYFfd2ZAQX/NlQ6nZ5goNmAslu9qfORlEbpSi5gSAxeTY4tdYulx
	u6dOZr06neAQ3ujaNu9jKN35XurBH4v88XJHhIDIuJh0tHv2QtnQUpjaaX/Zo3eR1dXb4Z
	3Pe5utFUFU/qfZarVvQ77SFrQ+s7jlE=
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
Subject: [PATCH bpf-next v2 06/11] LoongArch: BPF: Support sign-extending loads from arena
Date: Thu,  2 Jul 2026 10:23:17 +0800
Message-Id: <20260702022322.51033-7-dongtai.guo@linux.dev>
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

A sign-extending load from an arena pointer is rewritten by the verifier
to BPF_PROBE_MEM32SX once the JIT advertises support for it through
bpf_jit_supports_insn(); the generic helper otherwise defaults to
rejecting arena instructions.  Add the callback and implement the load:
route BPF_PROBE_MEM32SX through the existing BPF_PROBE_MEM32 path, which
adds the arena base held in REG_ARENA, while selecting the
sign-extending load variants (ld.b/ld.h/ld.w), and register an exception
table entry so a fault on the access is handled like the other arena
probes.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index f172ffc2c011..4a3b632c1fde 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -739,7 +739,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
@@ -1349,10 +1350,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+	/* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + REG_ARENA + off) */
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 		sign_extend = BPF_MODE(code) == BPF_MEMSX ||
-			      BPF_MODE(code) == BPF_PROBE_MEMSX;
+			      BPF_MODE(code) == BPF_PROBE_MEMSX ||
+			      BPF_MODE(code) == BPF_PROBE_MEM32SX;
 
-		if (BPF_MODE(code) == BPF_PROBE_MEM32) {
+		if (BPF_MODE(code) == BPF_PROBE_MEM32 ||
+		    BPF_MODE(code) == BPF_PROBE_MEM32SX) {
 			emit_insn(ctx, addd, t2, src, REG_ARENA);
 			src = t2;
 		}
@@ -2548,6 +2555,21 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (!in_arena)
+		return true;
+
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		/* Atomics on arena pointers are not implemented yet. */
+		return false;
+	}
+
+	return true;
+}
+
 bool bpf_jit_supports_fsession(void)
 {
 	return true;
-- 
2.25.1


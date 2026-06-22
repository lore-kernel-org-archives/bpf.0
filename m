Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D53ACEF1
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139035; cv=none; b=txAD3RaZQYNBStYGN3mlJQbVp6EfN8+p5VKDDH1YQVEdlcSkeq+yYDam+WtgBkcdc2+wpFWafKtwHR3+IrHqdSZhjrFY8mrVgz8db8evM/5/rTW2P9D7hca0fZt9f0ikJguQvC1t98+ejCBhLxSnNSB56jDKuCchL+S5NttldVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139035; c=relaxed/simple;
	bh=XRdaxU9N7j1KAXQfNqe1kJXr5PDGUqIVm+gHVv7994k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws4+zLlSGVyRBFjfQwi9AKuHzIq09+CTbTDQ5Y8TMDPBnn1EaXnCO6BrjeyoEhTXAILaoDg+tjZ34dQp6W1g2Bt3ZfJr7xuUhgRLLfrEDKspQM2xsAtUn5ynpZF6SWLIn5ycKnKNLbFXIPb9gdzGd2hgbvkOpMAq1kOGnTNclN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MohMmFeF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MohMmFeF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782139029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xKLc/VpD5w8rcK4oOI5MMeOf2bCaOl8dM0h4XZdcLc=;
	b=MohMmFeFFLZo2g0INVPqHNPOj6Y64mEhVY6skwfYLnFAFehmme1SlZvktnLQ0RZJRrjNnc
	qrK5K8DSdtPLRCUHFDFJ29AWbCgc8j/VQa4PtfbRoBm1Fjg8laiG2AF1KJVLGQAyE0O8h4
	kgN7NrAKnJY92DUPxbdDvacJYX4Winw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v7 03/11] bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
Date: Mon, 22 Jun 2026 22:35:49 +0800
Message-ID: <20260622143557.22955-4-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-1-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since interpreter is unable to handle the 'insn_is_mov_percpu_addr()' insn,
require JIT in __bpf_prog_select_runtime() when the prog has the insn.

BTW, rename the helper bpf_map_supports_cpu_flags() to
bpf_map_is_percpu_map().

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 5 +++--
 kernel/bpf/core.c   | 1 +
 kernel/bpf/fixups.c | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e1843d2859e..87b8d1928a06 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1782,6 +1782,7 @@ struct bpf_prog_aux {
 	bool might_sleep;
 	bool kprobe_write_ctx;
 	bool has_addr_space_cast_insn;
+	bool has_addr_percpu_insn;
 	struct {
 		s32 keyring_serial;
 		u8 keyring_type;
@@ -4170,7 +4171,7 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 }
 #endif
 
-static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
+static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
@@ -4197,7 +4198,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 		return -EINVAL;
 
 	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
-		if (!bpf_map_supports_cpu_flags(map->map_type))
+		if (!bpf_map_is_percpu_map(map->map_type))
 			return -EINVAL;
 		if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
 			return -EINVAL;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49398b5bd172..69203d58e0ad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2621,6 +2621,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
 	    fp->aux->has_addr_space_cast_insn ||
+	    fp->aux->has_addr_percpu_insn ||
 	    bpf_prog_has_kfunc_call(fp))
 		jit_needed = true;
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2d5958774b61..9552ddcf6936 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2009,6 +2009,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 					return -EFAULT;
 				}
 
+				if (bpf_map_is_percpu_map(map_ptr->map_type))
+					prog->aux->has_addr_percpu_insn = true;
+
 				new_prog = bpf_patch_insn_data(env, i + delta,
 							       insn_buf, cnt);
 				if (!new_prog)
@@ -2113,6 +2116,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
+			prog->aux->has_addr_percpu_insn = true;
 			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
@@ -2134,6 +2138,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
 		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
 		    bpf_verifier_inlines_helper_call(env, insn->imm)) {
+			prog->aux->has_addr_percpu_insn = true;
 			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
-- 
2.54.0


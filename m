Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57F47B40D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124734; cv=none; b=KEBiMRPuOXP86/zZZJIQ2cTe8QUB9odyu9hXWbh9hvuEnCTnRXE+gYguXhR6ncdM6ax2c6ivH7eOEUyLtBN6A9CUyRS5FhWGGdKTOb5gTgd3RJtUmhFiSxsmLj3P1OdgeqgIK5EDPt81LzrGe0i4TqrBs9RjBGH0Uy1rSTvN4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124734; c=relaxed/simple;
	bh=afs5fLgT8Qx3Rxr22x1O8wwdXCqlwGq87d0SiIZw1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYUU3Xf7Ua3o9+E8hSXY9w0IOj1qYOp91KlDI79oacSLb+vmHII/bPgawJg98NGT31Xq/nISv/2eZWm9INlcNwAkIj3+sVtYzxlBpLHobXaRbalbjhexCpLhQrSWR/7qETtQC1S7ZvTIJ+fPtexg7Sc79m/0xaV1XVt5iFafb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vee2idHR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vee2idHR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784124730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iva0H+8uYUGc12Hzh0ksizDRG/UQtCa60DRk1jyvB3c=;
	b=Vee2idHR5IyO4YqpuEuKl/3i0VeAy0U36lbJqVzMaHkjSHjN7lLAxZOCzYNi/RLq65V+3u
	weIAgZvj74PZsJqvoGU6l4XhifcR/q8UrYR+HzzWzisXVm2LQnT6m6H8J/d3myOGHA9/vX
	fQF7OUPbu6aKAAjw/Z6cPuyE//mwo3g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v2 3/3] bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
Date: Wed, 15 Jul 2026 22:11:22 +0800
Message-ID: <20260715141122.15783-4-leon.hwang@linux.dev>
In-Reply-To: <20260715141122.15783-1-leon.hwang@linux.dev>
References: <20260715141122.15783-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The BPF_MOV64_PERCPU_REG insn requires JIT to emit native code to for
'dst_reg = src_reg + <percpu_base_off>'.

However, the interpreter ignores the 'off' at its ALU64_MOV_X label.
The 'off' indicates the insn is BPF_MOV64_PERCPU_REG insn. Then, when
the interpreter loads memory from the register, it will hit a page
fault.

[    2.545572] BUG: unable to handle page fault for address: ffffffffacaaf034
[    2.546485] #PF: supervisor read access in kernel mode
[    2.547167] #PF: error_code(0x0000) - not-present page
[    2.547850] PGD 134e63067 P4D 134e63067 PUD 134e64063 PMD 10021c063 PTE 800ffffeca550062
[    2.548912] Oops: Oops: 0000 [#1] SMP PTI

Set jit_required as true in order to disallow interpreter fallback in
core.c::__bpf_prog_select_runtime(), if any BPF_ADDR_PERCPU insn is
patched to the prog.

BTW, rename the helper bpf_map_supports_cpu_flags() to
bpf_map_is_percpu_map().

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 4 ++--
 kernel/bpf/fixups.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31181e0c2b80..d9542127dfdf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4163,7 +4163,7 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 }
 #endif
 
-static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
+static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
@@ -4190,7 +4190,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 		return -EINVAL;
 
 	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
-		if (!bpf_map_supports_cpu_flags(map->map_type))
+		if (!bpf_map_is_percpu_map(map->map_type))
 			return -EINVAL;
 		if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
 			return -EINVAL;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d3be972714b2..a0bddada7964 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2008,6 +2008,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 					return -EFAULT;
 				}
 
+				if (bpf_map_is_percpu_map(map_ptr->map_type))
+					prog->jit_required = true;
+
 				new_prog = bpf_patch_insn_data(env, i + delta,
 							       insn_buf, cnt);
 				if (!new_prog)
@@ -2112,6 +2115,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
+			prog->jit_required = true;
 			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
@@ -2133,6 +2137,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
 		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
 		    bpf_verifier_inlines_helper_call(env, insn->imm)) {
+			prog->jit_required = true;
 			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
-- 
2.55.0


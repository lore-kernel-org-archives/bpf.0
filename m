Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E915B57E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084751; cv=none; b=rujllyudrhhUs7WIC+sjmcXPch9FN0zqPrIOExerSOgAM9Hrtfehx/TVMJwOJPBSALBQ+gkh4obYNftZbV3OMal3XutxJKYQen3lJXqDdebyAfwqko0HDHtejtPJ2nh9kfrOCSci7ATdRcAfTwNNBkmtGMw/Ka4HANEg1DM5OSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084751; c=relaxed/simple;
	bh=DacCd/vpGLhS+f2GpHcsajrVJRcugjxOZts82xRcQ2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6RWkmcJ3cV7hgmgDB7DpS63E1f8f63vSwlPILky6IWZGMVHVkzxC8/8JsvYTP8bw1rDz5xcmW3UemJgdgaH1KS2XsuHUP/4+FXrXR/MYPFm33m4dsi0zoY4uoBEVMdBkcTtbbQ4PKp1pzGAWQco+qd5xjQTHuTmo/6HexEYnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiTpXeBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiTpXeBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3771BC433F1;
	Tue,  2 Apr 2024 19:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084751;
	bh=DacCd/vpGLhS+f2GpHcsajrVJRcugjxOZts82xRcQ2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiTpXeBUsrOMnKwMjmNEZi4HXc55c4jvnD9M288ohbeabY5NIo7dMk2MRKrrTbhlq
	 VmZRv5/tVBLg0C4weuMGB4PmyeLLIsiSd5KgXjT7ztgxQnniguiTD4UzIfFTuTL0En
	 bLGWN1R3Zdq5bgSRduCjGZYkf6zzhog0LyNW4kPmXgLOmlzO8LmtqlfjFB3Hvp8Y6L
	 iofHNj4boyLRPW3n/vKeTvUwmCjDdLVH7aY+2mfH0luclwRAkw7KGGwzwOrAxP+Mqf
	 U7NNOgXYoXG63WFqm1D2x0KWjxKVNfwFlWWDq0XkRPQhth4pGiTzxLMfMOd9FYukqS
	 GzZjD5q0RCPZA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
Date: Tue,  2 Apr 2024 12:05:42 -0700
Message-ID: <20240402190542.757858-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402190542.757858-1-andrii@kernel.org>
References: <20240402190542.757858-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_branch_snapshot() helper using architecture-agnostic
inline BPF code which calls directly into underlying callback of
perf_snapshot_branch_stack static call. This callback is set early
during kernel initialization and is never updated or reset, so it's ok
to fetch actual implementation using static_call_query() and call
directly into it.

This change eliminates a full function call and saves one LBR entry
in PERF_SAMPLE_BRANCH_ANY LBR mode.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcb62300f407..49789da56f4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20157,6 +20157,61 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Implement bpf_get_branch_snapshot inline. */
+		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		    insn->imm == BPF_FUNC_get_branch_snapshot) {
+			/* We are dealing with the following func protos:
+			 * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
+			 * int perf_snapshot_branch_stack(struct perf_branch_entry *entries, u32 cnt);
+			 */
+			const u32 br_entry_size = sizeof(struct perf_branch_entry);
+
+			/* struct perf_branch_entry is part of UAPI and is
+			 * used as an array element, so extremely unlikely to
+			 * ever grow or shrink
+			 */
+			BUILD_BUG_ON(br_entry_size != 24);
+
+			/* if (unlikely(flags)) return -EINVAL */
+			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 7);
+
+			/* Transform size (bytes) into number of entries (cnt = size / 24).
+			 * But to avoid expensive division instruction, we implement
+			 * divide-by-3 through multiplication, followed by further
+			 * division by 8 through 3-bit right shift.
+			 * Refer to book "Hacker's Delight, 2nd ed." by Henry S. Warren, Jr.,
+			 * p. 227, chapter "Unsigned Divison by 3" for details and proofs.
+			 *
+			 * N / 3 <=> M * N / 2^33, where M = (2^33 + 1) / 3 = 0xaaaaaaab.
+			 */
+			insn_buf[1] = BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaaab);
+			insn_buf[2] = BPF_ALU64_REG(BPF_REG_2, BPF_REG_0, 0);
+			insn_buf[3] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 36);
+
+			/* call perf_snapshot_branch_stack implementation */
+			insn_buf[4] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
+			/* if (entry_cnt == 0) return -ENOENT */
+			insn_buf[5] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4);
+			/* return entry_cnt * sizeof(struct perf_branch_entry) */
+			insn_buf[6] = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, br_entry_size);
+			insn_buf[7] = BPF_JMP_A(3);
+			/* return -EINVAL; */
+			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			insn_buf[9] = BPF_JMP_A(1);
+			/* return -ENOENT; */
+			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
+			cnt = 11;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 		/* Implement bpf_kptr_xchg inline */
 		if (prog->jit_requested && BITS_PER_LONG == 64 &&
 		    insn->imm == BPF_FUNC_kptr_xchg &&
-- 
2.43.0


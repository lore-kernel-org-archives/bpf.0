Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD41139E
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190423; cv=none; b=kXDO+0zVyDU6Ydo4HKru3hJ9uKdN2CjwgUzjqONQHWEH+7g8tzUUR2aWe0QB4xtCx5opPgp5Fp+FdrnSkDlcGmLamhMEQokxmWgjbz94VX/KRJdBRCnBqBHl+aLfvLFW7QXpi/Wq2N6CI56UY7p8uN34URzuSR41NmqsmAB4FJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190423; c=relaxed/simple;
	bh=GouJUfQiVXFwLl8zWZh6Ah9pxPeN9Nt9znZaT5FuTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTOeXx6ZqfQQavKeTQhG5x/anVlwDhPe2pPcG9R3aWCj1PJCK7N4Yz5PyGZAbwZ9+eJhxiZQE1wsAZzqeDT3BIb+ZOnF901kJibhyhSghBdV/E6t3v+mjgf1SCLfH/WfCcM3CV1IfSyVNhRc4+piU3Ux4y52JWxXTZyrB5vNDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZwB9mlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZwB9mlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F22C433C7;
	Thu,  4 Apr 2024 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712190423;
	bh=GouJUfQiVXFwLl8zWZh6Ah9pxPeN9Nt9znZaT5FuTTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZwB9mlp35d/duOfi5UD+vCqxyJ9Yb+1AGvvYPJDIqWAlYOrfr21a0WzeNotOqctV
	 Ix+gxV4ZFRMiiucDCARqzilyRlz3iCRyRxrF+AYSwL7agXxaOpGtQKTEtRbu2OKhOj
	 P9IKFrLqM2ytKUH/VaIWnPciEFfUaJeFXOXwPomEikVl7rXCmkhE8c/fR14GEiM0IL
	 Asvli+9SOJuISPKhg8uBBeHl3br0sqvTPnIhNigNpW14yqyGsyZ8ZlHp4mX4z2p8y0
	 N7lNPsr2XLOYlEebRai2LAb/gXTvppKB1pVGDDdUqK6PI/HXTROL6gobHMd2DX+5gf
	 KoCPIPxFvS6JQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
Date: Wed,  3 Apr 2024 17:26:40 -0700
Message-ID: <20240404002640.1774210-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404002640.1774210-1-andrii@kernel.org>
References: <20240404002640.1774210-1-andrii@kernel.org>
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

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17c06f1505e4..2cb5db317a5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20181,6 +20181,61 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+			insn_buf[2] = BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);
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


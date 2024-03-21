Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B31332A1
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044313; cv=none; b=t6ba9Tu+LJM+2OfvYwMa4ZRQNfI2lb8srWP5apkZwyAFrDnNclSvVLQNlMXNAuGFwxX6/K7OGy5C195wVqBU/ceMEUAF1H7RMLfj8jhDCwsGnzt5p17hJ3MACW+Bk8ApRHY3nRrBG4C0lDOFparfJV06FM6X6hoyQG7D6eOPODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044313; c=relaxed/simple;
	bh=zs1ViZjfg4YKZFDNnAPthsFgDutL0KGI2N4kW5c7yuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oldcK3Pt9jPfhhhVlLTXqgt3lbnk+TfKNuUloogZEP9DQ51PJRAgfQSFXOLKhQYkj+S5GYtzt1ORL/xne/2Zlm+aOzrjLhuoXZQ9GyORc/QQ7D6eg1bsnR9Stg1KeZGuqtHsxbHhsPqbDHPyN0dhJFE3ex0RTOC/gzD7XFas7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLCc3qVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLCc3qVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F740C433C7;
	Thu, 21 Mar 2024 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044313;
	bh=zs1ViZjfg4YKZFDNnAPthsFgDutL0KGI2N4kW5c7yuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLCc3qVuS806YjmBQUQSRwXCGG/FNI8t1e3dM14hzmkMIF0iIIfvokmOcoUXzsFLS
	 oVlhpwla3BvPJ3iznTO/GlB+M1kAhTqTq9qnUwT50G7G5gaj1SBIQdHyhIY3lB/Fhc
	 cgbQNsTTRN9ltpaY4fS9cvSaeNcSUbuHc+L56M+k4Zz/+oHuTHnafFohwJpxli/OFM
	 0ZRKPhq3b4fOqfVtKuNF+OHdb61dRVSRpIKAXxzGbOafqC4xeouhwpgfjMBlhT3Srx
	 sa+fWw0Bcs3ZGh54KkCLxPdGg1LxeOJzjMKthoj8G9GSJTGUKPAn+RrP07d8ArCcKj
	 J9OWuthQKHQDA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: peterz@infradead.org,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: inline bpf_get_branch_snapshot() helper
Date: Thu, 21 Mar 2024 11:05:00 -0700
Message-ID: <20240321180501.734779-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321180501.734779-1-andrii@kernel.org>
References: <20240321180501.734779-1-andrii@kernel.org>
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
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..4fb6c468e199 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20130,6 +20130,43 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+			/* if (unlikely(flags)) return -EINVAL */
+			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 5);
+			/* transform size (bytes) into entry_cnt */
+			insn_buf[1] = BPF_ALU32_IMM(BPF_DIV, BPF_REG_2, br_entry_size);
+			/* call perf_snapshot_branch_stack implementation */
+			insn_buf[2] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
+			/* if (entry_cnt == 0) return -ENOENT */
+			insn_buf[3] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4);
+			/* return entry_cnt * sizeof(struct perf_branch_entry) */
+			insn_buf[4] = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, br_entry_size);
+			insn_buf[5] = BPF_JMP_A(3);
+			/* return -EINVAL; */
+			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			insn_buf[7] = BPF_JMP_A(1);
+			/* return -ENOENT; */
+			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
+			cnt = 9;
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


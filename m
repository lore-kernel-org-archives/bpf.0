Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844DDDA9
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023996; cv=none; b=t4HE0aG64fo6/Fwk94w4LTbGpMSXfAJE5CBBzGye3YdJ+AcmXy4LJEqZTsjbMQosYWij4H1GEMvivNk5AW29LhebS6AjpK7t8HmKRrDsL3O7L51bp8h7Uuj6YDQbO1o5G6+umRIvR58jXSiAP0imnLWR5RLoyTpW9OXK1KehJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023996; c=relaxed/simple;
	bh=UfUAWN0tHoYmneaTCTttUq3rZ6LCuxovlKO3xzU/DVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWz1ajRnp986MpcnL33FbxN5w3hds1kgdkIaWKlI5u1GhSyOw+7EoaVOGvEJvbraVyUwBXFM/WzXjolFEqLXWMRlttT9tyskba67ErGyWTooNXnhkp2Ua5xWPC2oKMF2ZYZi+AG2D+58bGuE/gqfw1ZTA0dx8vVFB0XJ++kEFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLdW+7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLdW+7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA00C433F1;
	Tue,  2 Apr 2024 02:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712023995;
	bh=UfUAWN0tHoYmneaTCTttUq3rZ6LCuxovlKO3xzU/DVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHLdW+7xUzUm0bubL39N4ECYQWS7td7QZDKbNPZdfAZsgnN/2nrTEkFgHUTGyGD2T
	 OB3swk9tgskUR01603T+v5Qf4T0XI6OmhmSe3WTz8VKzTxmsckwM0CMR4En+DKdUHG
	 7s3kqsYjTLn93x0TowCboaJ4tcChoJ8VE3lL0VA23uZMPC3TYg1Q+mYpR0kMhtNWkQ
	 r8qF32+eFr6Fmg8IJZHrEvswDbz9M7U9UJ71qDwpiTeK2QT3nNkEKIGRNScmTE/CE+
	 JYjctBCdptqGsPscsWA+2crF/m7IIjYybqcFOIa5sWMu3K8o5blk+WaO3la2rD+zxH
	 F74drCspaIijg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
Date: Mon,  1 Apr 2024 19:13:03 -0700
Message-ID: <20240402021307.1012571-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If BPF JIT supports per-CPU MOV instruction, inline bpf_get_smp_processor_id()
to eliminate unnecessary function calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..af0274b090bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20072,6 +20072,30 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+#ifdef CONFIG_X86_64
+		/* Implement bpf_get_smp_processor_id() inline. */
+		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
+		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
+			/* BPF_FUNC_get_smp_processor_id inlining is an
+			 * optimization, so if pcpu_hot.cpu_number is ever
+			 * changed in some incompatible and hard to support
+			 * way, it's fine to back out this inlining logic
+			 */
+			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+#endif
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-- 
2.43.0


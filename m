Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904B225A8
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738069; cv=none; b=tlMaWmagQsbGvhtOYcvtUNKJ4rygQuAjeJubPJjdEkeEkQTbNz4oYpNDlLG6lt0T2Gj6SODsk66N5TjEiEh5EcXsxCoC7akYcc2UsQAF3qlzdYOVDxmAoJOyIh3FWiB32fLS6l/O8CDcpfVOLOY+YnM2HujMCGe8r/9/k1Z5z+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738069; c=relaxed/simple;
	bh=bKWtYC2Zn55ptgsWc3tn3d/Y9QuPa0RDYZ/pP2P65kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEoGJG1j5CZgnXZFK0Ev3xsDg04EIOdYf294kKkcOR33P1Wy/5wn6caaf7lwlIL/rvsy6RdNvzNqCFdEd7BNeSd16B0csdoONik3Rlx16hA+k9iLidNS6eg2K9HylkXa+oYU+3c2bNT0rIFeJsQak6T+afp39O8ml2vsH5KrfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBROYdZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBROYdZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FE5C433C7;
	Fri, 29 Mar 2024 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711738069;
	bh=bKWtYC2Zn55ptgsWc3tn3d/Y9QuPa0RDYZ/pP2P65kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBROYdZuyZ5vJgkKX6foaJ6DlkpXwwmBGyNfm/NnShTJu3WHVqj9uVbWz3f2MsAgJ
	 pLpTzcobK/DtTEV1eVIo5haaplNDl7J1MBrHEhutb9Zx84SzoTjCadGrF/EeWOz5dn
	 jxaKJZfCSs7Xb6VOPk5pIlfQ76Bajtb9IoWAelLr8LWN+DCd47OFRPb9j8MzR6VEyW
	 bTJ+iilJgTTBoUvAT67qEtePEzX5B18LQZpI8HIcjiAw8Vak+jTc0hiU3t+qApw6a2
	 Abq8k9TYeQWKsEPZi0fdWhGEu3RyNlDCaF502FaCDwF1fG0Y9uOeANu2yj5QCLIgr9
	 wt10+LuyF0IQw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
Date: Fri, 29 Mar 2024 11:47:38 -0700
Message-ID: <20240329184740.4084786-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If BPF JIT supports per-CPU LDX instructions, inline
bpf_get_smp_processor_id() to eliminate unnecessary function calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..24caec8b200d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20072,6 +20072,23 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Implement bpf_get_smp_processor_id() inline. */
+		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
+		    prog->jit_requested && bpf_jit_supports_percpu_insns()) {
+			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(long)&pcpu_hot.cpu_number);
+			insn_buf[1] = BPF_LDX_MEM_PERCPU(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 2;
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
+
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-- 
2.43.0


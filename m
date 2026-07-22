Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03323E008A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720502; cv=none; b=X81fKARaiM2O32sZ63hKpDPCH0JGtLNOoKnkbMkh2AXXUpaPgWR2Xpvaw4w/EjYg62EDZI3ozfLzMEmQZ3t8LlA1JRdPVQyBrakrfmg+ExOc8Meonu4aHAUa2rcBHPjaTyJNn2mYsNxLCqhIMHp4EWj39upiaiFXg57VeG+LR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720502; c=relaxed/simple;
	bh=oiqsiXH2auvvTcy+XpKqq3f+Cggs5IcjKSAEqS0H5jI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mSrT7wlFig5Aa2Vfe5JZTKoiNQP2EYs3F6VIBshNYZ2DwIgDeD3UGp5i/OiL42ynVAVL7Gm18ZkamuLNiygx6vriXdUHc2VcW0PjBBnbmaqGcxFZrALdOAq9mHRVCEEk31UPv+8ipUJuOotjd/DuQwlDI+IiNRY9/+yb6+tWVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pru3Trle; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pru3Trle"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so2223709f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784720499; x=1785325299; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EEdu2NtDKvJ6m5L7yD3u1hILhc3acdgjyOagawBBaU=;
        b=Pru3Trle65O6AmM9lDZgylvzE04eqtnMGLnAWwot+Zx5jMMHmWj9XT7gCLBJksQYpr
         21kgRKzLu29m45NWXs2uYjOlCQvw61b983HZGilgjpiRmfbuxy7LXVx4tSepcWVHbyN4
         Iobqf5a8vDQrFo1XJFHjGr3I+qieBM0McZw8pPNMfNFsmBaJRUK+O0XWXVeFg6APEAkl
         dbsVfNVfJjhI2u1pfMASnwsq1n9UOvRxsAC9QEIxomT8ZB9cd5GvrFjBTgOceCq5a6dp
         F+tvGVbHJJ7EKpDXuVkNX3rVt+w2qXUZGOPnq8b8WHUag7MqZHSPcsnKSsQkE/EI1Yvh
         ZtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720499; x=1785325299;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EEdu2NtDKvJ6m5L7yD3u1hILhc3acdgjyOagawBBaU=;
        b=cPSDxFi2S7Mx1POAUO/0qdyvZqY+ssf3PhBkmtEqMyGRzHTbkI9w9Owu0E6DLfOX6G
         yKm0yVBa5CizrJL/Hk9e4zAzChoNmOMeb3BEdjXbpBSSz2pocRDy5OXSUnoPWsY/3Rsi
         Rtu992TeCA0WJDA8vbb3SSvEQs4yfy+4XOaSftuQWFErtvO+L1Xqr9zsIzsi26PT2FQ+
         mhvl67Gxd0hYC2eZx+IDv75l68HIjDNNK2UG37hbgujTm3T2tR2Vmd3dmehnA0vqEsnC
         OkbZnjfR6C5hTHe4jpMfc0z0NjCPcXqR2DWx9PvK5mOCSCieKtn0RvXf09S7he2IbSkF
         7bUw==
X-Gm-Message-State: AOJu0YyoLAHnYDDJHc/bQq2X1bKhHzJnLvpZFQdFbo3wPMKHIntI0njm
	fuPwxlinIkJ0+fFwf3e61xzczk2GhBErS/QKplKOK+aQOPIj/xyO+O28JruuAa/UBi29SoBBwEy
	UmOcrCkP2XVKhD8llFg==
X-Received: from wrzf10.prod.google.com ([2002:a05:6000:1b0a:b0:46e:4b8:3001])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c84:b0:493:dcad:84da with SMTP id 5b1f17b1804b1-4954a3eec74mr269227495e9.1.1784720498761;
 Wed, 22 Jul 2026 04:41:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:41:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGqsYGoC/32NQQ6CMBBFr0Jm7Zh2lCKuvIdhUcpQGpGS1jQa0
 rtbOYDL93/e/xtEDo4jXKsNAicXnV8K0KECM+nFMrqhMJAgJRQR9uuIc3zwjKN7c0TCpr6Ik9L ctlJC8dbAe1W0e1d4cvHlw2e/SPKX/ltLEiUKcR4aMr2uDd2s93bmo/FP6HLOX1YCZqqzAAAA
X-Change-Id: 20260622-bpf-lskel-fixes-2-758036ae9911
X-Mailer: b4 0.14.3
Message-ID: <20260722-bpf-lskel-fixes-2-v2-1-1ec545c6861c@google.com>
Subject: [PATCH v2] libbpf: poison unresolved weak kfuncs in light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

When the light skeleton generator (gen_loader) fails to find a BTF ID
for a weak kfunc, it correctly clears the immediate value (imm = 0) to
convert the pseudo kfunc call into an invalid instruction.

However, the generator fails to clear src_reg (which is set to
BPF_PSEUDO_KFUNC_CALL). This leaves the instruction looking like a valid
pseudo kfunc call with a zero BTF ID. When the target verifier's
add_subprog_and_kfunc encounters this, it unconditionally scans all
BPF_PSEUDO_KFUNC_CALL instructions, sees imm == 0, and panics or
fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks
the verifier's dead-code elimination logic which expects to cleanly prune
branches protected by bpf_ksym_exists().

Furthermore, when the generator processes subsequent references to the
same unresolved weak kfunc, it copies the imm and off fields from
the first occurrence but skips the src_reg field, meaning subsequent
calls also retain the poisonous BPF_PSEUDO_KFUNC_CALL flag.

This patch fixes the issue by explicitly clearing src_reg for both the
initial occurrence and all subsequent occurrences of unresolved weak
kfuncs, converting them into standard invalid helper calls that the
verifier's dead-code eliminator can safely recognize and discard.

Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
Changes in v2:
- Rebased and added Fixes and Acked-by tags
- Link to v1: https://lore.kernel.org/r/20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com
---
 tools/lib/bpf/gen_loader.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index d79695f01c87..a08071114347 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -783,10 +783,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 		return;
 	/* try to copy from existing bpf_insn */
 	if (kdesc->ref > 1) {
-		move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm), 4,
-			       kdesc->insn + offsetof(struct bpf_insn, imm));
 		move_blob2blob(gen, insn + offsetof(struct bpf_insn, off), 2,
 			       kdesc->insn + offsetof(struct bpf_insn, off));
+		move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm), 4,
+			       kdesc->insn + offsetof(struct bpf_insn, imm));
+		/*
+		 * jump over src_reg adjustment if imm (btf_id) is not 0, reuse BPF_REG_0 from
+		 * move_blob2blob. If btf_id is zero, clear BPF_PSEUDO_KFUNC_CALL flag in src_reg
+		 * of call insn.
+		 */
+		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1));
+		emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
 		goto log;
 	}
 	/* remember insn offset, so we can copy BTF ID and FD later */
@@ -804,10 +811,12 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 	}
 	kdesc->off = btf_fd_idx;
 	/* jump to success case */
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 4));
 	/* set value for imm, off as 0 */
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, imm), 0));
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
+	/* clear src_reg (and dst_reg) to convert pseudo kfunc call into invalid helper call */
+	emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
 	/* skip success case for ret < 0 */
 	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 10));
 	/* store btf_id into insn[insn_idx].imm */

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260622-bpf-lskel-fixes-2-758036ae9911

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>


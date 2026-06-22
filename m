Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959529DB86
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169474; cv=none; b=jDLJ1647vluCU7OYXuVwMLJTx+l/1R5sQEW6tEm9pmYUnKgeBqrdrwtjEzQxNpCK2a11Abz5Om5StM4vhw+Amgtb78lZFvWjfNP8AhMasqxH7BKwoY97DPXrFv60vqlGOcxPFenPLAnZGwSBuTYEfA8/cFTwwe5ZwXJptWCyPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169474; c=relaxed/simple;
	bh=ftQG/1RMgrIeRs6dP3PxPeGzz5fOmUvEfdk5pZF/azM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PRQw2BK+vw7BFLOYN8ZmH7Nsd8LbuKQ5ALOLXlhPaBSj3tD3dE1tAoYNJgWFQOQKh1lg6Bx0/RJR3rFwpQqU57gB/gbzgF1VyE7znwVEW2Ov3xFQy+4Km3gn713iLVhpZfsmH2J1MBpqxuDD8ZwgcOiB6fD88U1cdUqN6zEBUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIbVCABf; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIbVCABf"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69576b83dc2so4420125a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169470; x=1782774270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6tdVkbifnmy4OpS0s5hYsfsTMfjK8C0RXIohZaEO8A=;
        b=HIbVCABfFsksOb1OCX9IQEAFPKLA9OtNlEzdu6hdjPQH/spRwzkPbkfibfdwnV/JfG
         oe7CE3NmbQq+kCHPFxurBFh8L15G7q5976IBB7SUHTz+S4S7PUEMJLtGKRU8M0P3uehl
         iuv9DaOs7tpGd5Yxeqv8itdwLOQr0ShC1epczlvl0yCqKe+FrkXbFBXWs2OZdMMukyLt
         BIORr04kQb8/nDmrDPa44esC4US/5m1v9+987qsTxxZfkfC6qcN4uQj7x/Tkx0G0J6oO
         dq/ZAeclKkzJ2fK3+dbJVx1aus6cbqwuhJaIRqm1P1LSkoDnaFeBdq4OsYvtKrM61bvY
         ByzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169470; x=1782774270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6tdVkbifnmy4OpS0s5hYsfsTMfjK8C0RXIohZaEO8A=;
        b=FqcGvTWmVas6AL6Am4LpKr4S/KTLxcAMN8WY1c1d8teEueX8Q6bcfKwqTD3L3Rwhkr
         FYqHzz9XVMntqgxYRFCJDlgtbKg6nGXhoQGruO+7qetJPEybVXiMaqFxjsPuYO70VUDI
         /wG/FxpO2E7VEarqdN60mB5gKGTo0ZrFC53QrHNFy/gimSm9Buo3DwwDv20pJMj/y7Ew
         1XyUfAtEP/klrQcWKVIVfMwOIAgKD1ztmTJxZZ+vVTg9spbCdplDaI6eJvryKLO5Zg05
         KexkwJBQ0C6KtMCBHSh+zCYVICNGDl847YiH9KBzn40o6rk5COFpy16PMmMqmaDOy7bv
         t/dg==
X-Gm-Message-State: AOJu0YwLvN3AH+fg/M6TYbu/Rh4w/aoEtkWI+ZYF3xV9DJos8ib7u4TL
	N3qoUIA8Tch7+tS1/tA2A0UMx6lLJSiZy/fLUOKxeR6QjzX333+bJ7+iffNUS5ELTv2R+7WNWWM
	eUgPoQRDtJ1yzkCQ8eA==
X-Received: from edr1.prod.google.com ([2002:a05:6402:44c1:b0:697:bd42:cb2a])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42c4:b0:687:7fc4:1ea5 with SMTP id 4fb4d7f45d1cf-697dbb654bfmr67219a12.23.1782169469462;
 Mon, 22 Jun 2026 16:04:29 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:04:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHi/OWoC/x3LSwqAMAwA0atI1gbaiNV6FXHhJ2pQVBoQoXh3i
 8vHMBGUg7BCk0UIfIvKeSTYPINx7Y+FUaZkIEPOOCIcrhl33XjHWR5WJKzK2hSuZ++thfRdgf+ UtrZ73w9JWegbYwAAAA==
X-Change-Id: 20260622-bpf-lskel-fixes-2-758036ae9911
X-Mailer: b4 0.14.3
Message-ID: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
Subject: [PATCH] libbpf: poison unresolved weak kfuncs in light skeletons
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

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
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
base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
change-id: 20260622-bpf-lskel-fixes-2-758036ae9911

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>


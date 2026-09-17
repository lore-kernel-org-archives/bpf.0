Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D625175A64
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643516; cv=none; b=Xlwj+ZA/vn4aFjy67wpniguupwaE5Og9nhVTQdWU0sHgTtEw1CuWtDLBphQtSws63TDQ2uDG+uFclHhhP/fAK4cA9LGEBdvxeCuAcHx9RyerADIOZGZutKHeNHA3Iod2vqQc9tzSXKxXTjdzW+nirv6eykdOJT0acnb2yIBBvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643516; c=relaxed/simple;
	bh=2dYc4G2hLeBzJuyKFgPPXaLjHLg/ViMJmgypQVUNZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEWOUphp7PgEvrrNnCYqPArgrrusMbF+sIl1aPSqaue4P07ybg9IifWteE2Y7GBmftvHL9X/9Wq8PBVFnsQttZVH+Md+TlONuFF1xwSkDPs2NqpmvmSa3c5v4E+F+TzfBKB+2OHCmJ3W7VRBSCR9zbN/Gr4zbmEJkpfowWyXEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC1w7ecf; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC1w7ecf"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so2789065e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643499; x=1790248299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtO8FclDiABWId9+FsrsL0wPH5FRoKRhVJi3ogGlc40=;
        b=jC1w7ecfLrYzMTu66sH9dR9m5ZToE7Ww8/hSCl0MLd6e6Lw+YZpbIdyTpXt3Ar66OP
         /Z5ky3fvabCQGOT/zQYkm2ymYLiQnrDJU4G3ZkW0AsWyNtIiNNAPHjaTHZRelgJtlc1B
         Ta2vWSv6e84ViY2Tvc95dNpvU91aQjFpGX16mE3urlXCwRTA5ndG46il3RcUWn61msnD
         saxaMkDHKsNT1Knwk8EMFrmOw6aBucNM+5IUNjnrQGheDeR+NkQZKCJakLiOov7hN9mO
         M3tfEU/gre6eVUSZl+2M+MhtOETUG3G1OPss1Z+gbyIgogDk36lC2rHy55JZpbKgD7Jz
         aKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643499; x=1790248299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtO8FclDiABWId9+FsrsL0wPH5FRoKRhVJi3ogGlc40=;
        b=NibeoAKw80bjVtzYn6J6Yoqk4wHmLjfLYgRGBwQ3/2u/3uuoVhmjqADmYPdw1xJe00
         dUAg/kOsoGC29FG4t080iQkb+nLXCZNCfY7zStCmZBUMb6UsdR+S86o0vwy0e/XOt4e0
         Q520p+K89w422CMQTjFVk1cNHwRGwSm81AjENABzzk19Snh75MnpNZGEyXFOEvsOXEQx
         ifJXjpQHK8kxgmIUvyFaCS0xf7XP4y+lrxN0dZcwOpnn39c4n9K5kOpQ3BcmyFoyNReG
         FjSLUBmPsGEWBcP2zvHo4acTfqtdWJSh3s83TuhkBK+AFwNZRziT+gWMtBiy6Lr6Qj+G
         KHMQ==
X-Gm-Message-State: AFuF++kMkjAk0foJwRqCaTKW9xRFoMkNRbGSANoz+EQFJ4Oow2N1VwcQ
	nlV9htRG31Oq0ankDC5yc9RXi9mHHOrOqjRrjPoI8LgV/GGj5AB672QoUDGdJ/PO
X-Gm-Gg: AYBFou2IdgVMymlsdxJ63QXC1g4jOQrNJv/nUOQYI7+ilTxM9qVYRbpf5Kn80QAoww5
	4Yuxe0RgpSfs4fCL7EvlYedpQEfb5TT+rQca1uyMLmYrbSgu78kqx5hvbQyNLApvtXvYTv2Jo6E
	cYmw6Cln0+dyefNG4lt75O1yLLvib52rvYc8n3U/bLjjsyBErfzFDVsyjRyjUwj9A6Xo04R/j1n
	ae/xgiCY/cvIVyfCV91pSYXMXSN5NyhVzCu/Mh3q1VUl6zmkYNFqJACc3IYHTkLt9oaJFX2bPNp
	gDfiStLXJvX2CLEhXFa+Afu40ALxrQs2rorAgbqr/ypwOAZQ5jEXqDgPrsygoVEJ+7Bqev0h4+w
	QQwK41ifqH4dLrsYfIEjbxcY7EBplw/I6QneMlLAN1Do4bHe1s0ymK3UVVENW+BXO8Zjjf9TWOg
	QCMI6DZ2Yz/f6igkoYY4i8iwA1CfbSHMlgKoqr6iqkL5ty+4NYhtiPXhsal19+VawQ1jlNBiFYx
	OOHOo9gE5OI6Dda8fP8mAPCSDZsMRXl9nwYT+g3bWIBEJTUXBHr8acs7mz5CmkPrPEh/pdKa13R
	bBk0m89urEegv+e07jPVTF8zxk2qozKrIHyFnw==
X-Received: by 2002:a05:600c:c4a6:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49eb7345a16mr73569895e9.30.1789643498601;
        Thu, 17 Sep 2026 04:11:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd967f1csm25465995e9.3.2026.09.17.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 06/10] bpf: Restrict CO-RE poisoning to relocatable instructions
Date: Thu, 17 Sep 2026 13:11:18 +0200
Message-ID: <20260917111127.3780880-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6825; i=memxor@gmail.com; h=from:subject; bh=2dYc4G2hLeBzJuyKFgPPXaLjHLg/ViMJmgypQVUNZvk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qeSpTjz5HJV801kijGNUJmlve6rEvWzOe1nP/2mCi hV5K307SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJF3fgx/eGT/+e00LVKT3ux+ x3NKwsvvt9euXs0XHyvzz337m0+zTzMy/NC+FmF6U3v+TV9uGQPNzxa7PhXwRJwPPrBzvcLHoN8 uXAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

CO-RE relocation records can name any instruction offset. When a
relocation cannot be resolved, bpf_core_patch_insn() currently poisons its
target before checking whether that instruction is a valid relocation
target. Malformed metadata can therefore replace jumps, calls, exits,
register-source arithmetic, or non-immediate loads instead of failing at
the relocation step.

Handle poisoning only after the instruction has passed the same class and
operand-form checks used for a resolved relocation. Route invalid forms
through the existing diagnostic and return a hard error. Keep poisoning
supported instructions, including both halves of a plain ldimm64, so an
unresolved relocation in dead code remains valid.

Extend bpf_core_poison_insn() to poison both halves of ldimm64, and return
its status directly from each validated instruction case. This avoids
routing the success path through a common label and leaves the helper free
to report errors.

The shared relocation code applies this restriction to both libbpf and
in-kernel CO-RE. Update the early in-kernel regression to expect the
relocation step to reject its invalid exit target.

Fixes: d7a252708dbc ("libbpf: Improve handling of failed CO-RE relocations")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/relo_core.c                     | 58 ++++++++++---------
 .../selftests/bpf/prog_tests/core_reloc_raw.c |  3 +-
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 8ad2715721cf..2672623a4198 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -980,23 +980,30 @@ static int bpf_core_calc_relo(const char *prog_name,
 }
 
 /*
- * Turn instruction for which CO_RE relocation failed into invalid one with
+ * Turn instruction for which CO-RE relocation failed into invalid one with
  * distinct signature.
  */
-static void bpf_core_poison_insn(const char *prog_name, int relo_idx,
-				 int insn_idx, struct bpf_insn *insn)
+static int bpf_core_poison_insn(const char *prog_name, int relo_idx,
+				struct bpf_insn *insn, int insn_idx)
 {
-	pr_debug("prog '%s': relo #%d: substituting insn #%d w/ invalid insn\n",
-		 prog_name, relo_idx, insn_idx);
-	insn->code = BPF_JMP | BPF_CALL;
-	insn->dst_reg = 0;
-	insn->src_reg = 0;
-	insn->off = 0;
-	/* if this instruction is reachable (not a dead code),
-	 * verifier will complain with the following message:
-	 * invalid func unknown#195896080
-	 */
-	insn->imm = 195896080; /* => 0xbad2310 => "bad relo" */
+	int insn_cnt = is_ldimm64_insn(insn) ? 2 : 1;
+	int i;
+
+	for (i = 0; i < insn_cnt; i++) {
+		pr_debug("prog '%s': relo #%d: substituting insn #%d w/ invalid insn\n",
+			 prog_name, relo_idx, insn_idx + i);
+		insn[i].code = BPF_JMP | BPF_CALL;
+		insn[i].dst_reg = 0;
+		insn[i].src_reg = 0;
+		insn[i].off = 0;
+		/*
+		 * If this instruction is reachable (not dead code), the verifier
+		 * will complain with "invalid func unknown#195896080".
+		 */
+		insn[i].imm = 195896080; /* => 0xbad2310 => "bad relo" */
+	}
+
+	return 0;
 }
 
 static int insn_bpf_size_to_bytes(struct bpf_insn *insn)
@@ -1047,17 +1054,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 
 	class = BPF_CLASS(insn->code);
 
-	if (res->poison) {
-poison:
-		/* poison second part of ldimm64 to avoid confusing error from
-		 * verifier about "unknown opcode 00"
-		 */
-		if (is_ldimm64_insn(insn))
-			bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
-		bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
-		return 0;
-	}
-
 	orig_val = res->orig_val;
 	new_val = res->new_val;
 
@@ -1065,7 +1061,9 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	case BPF_ALU:
 	case BPF_ALU64:
 		if (BPF_SRC(insn->code) != BPF_K)
-			return -EINVAL;
+			goto bad_insn;
+		if (res->poison)
+			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
 		if (res->validate && insn->imm != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx,
@@ -1082,6 +1080,8 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	case BPF_LDX:
 	case BPF_ST:
 	case BPF_STX:
+		if (res->poison)
+			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
 		if (res->validate && insn->off != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDX/ST/STX) value: got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx, insn_idx, insn->off, (unsigned long long)orig_val,
@@ -1097,7 +1097,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) accesses field incorrectly. "
 				"Make sure you are accessing pointers, unsigned integers, or fields of matching type and size.\n",
 				prog_name, relo_idx, insn_idx);
-			goto poison;
+			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
 		}
 
 		orig_val = insn->off;
@@ -1140,6 +1140,9 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
+		if (res->poison)
+			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
+
 		imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
 		if (res->validate && imm != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
@@ -1157,6 +1160,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 		break;
 	}
 	default:
+bad_insn:
 		pr_warn("prog '%s': relo #%d: trying to relocate unrecognized insn #%d, code:0x%x, src:0x%x, dst:0x%x, off:0x%x, imm:0x%x\n",
 			prog_name, relo_idx, insn_idx, insn->code,
 			(unsigned)insn->src_reg, (unsigned)insn->dst_reg, (unsigned)insn->off, (unsigned)insn->imm);
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index ee267289fd88..10bda3ff80eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -124,7 +124,8 @@ static void test_early_core_relo(void)
 					       enum_id, access_str_off, 2, true);
 		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
 			goto cleanup;
-		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");
+		ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2",
+				  "poisoned_load_log");
 	}
 
 cleanup:
-- 
2.53.0


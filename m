Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E74B1280
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687958; cv=none; b=Sa+XGpnCcSghBIS2fr06WPNIMr9zcFT2sf+dfM8PbXr2eaXfxEA7vkdeRwb0zY7XvJxfNlV2Eez5YJpv8n4TO0wuSD5+8ZVqY6r/WCwhDDECywY5np1n7TNYU9z+CEAA9d9RDW6CjIeY3ftCfih+XbmVj1apg0DTKv88RBSTbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687958; c=relaxed/simple;
	bh=Gj32JiyqDGcx9RhTd3ZU7Ej5EAAT1FguvvGgvR5C3iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsWf9ESrLvvv0aboKKn3WZUdvdwAgZfkZi0JY6enDDwDBWtKAmFemHWDaUanhTF2EbNxZYF2iDNhkCfRwRhScf3+IaUN+B/L7rW4t55Vj4CI7s5W1Y18pxFwfYIEZ9nq+tQqNy+cNIT0T+K9/D1nAoV561915JsUeOjShw2434I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcnHsjeH; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcnHsjeH"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-49e73611928so6501995e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687954; x=1790292754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ocwqm7U2VY8eGd78EbduJlyP4eO2aM6wQPl5l3Xhjc=;
        b=NcnHsjeHXR5NHm3P74nKUj3E/eKTehCaqhk9jDcYo+7auVNh49/qBx4SrYzVJJ6zC9
         zTtit/V/YheDgFlWWaEL3o3lkiny99zr4IGzCcaD45N+tCdMc+rz24mOCDn56DlUKedY
         9NOjLfDuC4nL8bCabBav1tp470HvrWpwBT4QZi35Y1/VilpSbo84XzFPWpS3Rb+fX1Dn
         9LkaYZieoOCEdO7+2crso4dItyD/KT88uthr4LBTuM7H1rAqBj3fAhcsEJuwAGMjz5+G
         J61vXuyANueMR/R0y+uikAgjOaW8IBYFkmi1paXAL54W9Z+SZp9iap4k6iULPUrluuFy
         6EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687954; x=1790292754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ocwqm7U2VY8eGd78EbduJlyP4eO2aM6wQPl5l3Xhjc=;
        b=UsGvXJkTkuj8PapOsJBbgl2+dXKxjcz82SsKnd2CWT9K6onlfpovOznYJnMQVcRV9J
         ziI6Vh0e1mPIlAWRAvrpvCTmmIa4pzcLaAexu76wIXlgquC5xaaBwPCKIVikbuaPItPW
         rlrVFkXXPMpCBAgfr4P602noCebHuXntgAdqrvJw17uz+AW1n6oatctsfkoTBjTb4AKo
         e8i24vcxlhEOm+ndKHzYl1ZTEMT1VF+fF8CTvmxX48NuZMwhpdyFN8QHPI/+VcOJIrRG
         sfWFjG1GTJktSOn8uEDuCEzgE363ZsW7sMgeshwElGjZXwD35AOIIo3v5S2vrRPbF4Wj
         Lmvg==
X-Gm-Message-State: AFuF++mD0DmfYI7GFQ1kfiqTHLqgaNKHeyvabw1UO85pLq29f9Uac9FW
	l8TqnDJk07u0GpccXwSv+nISSUXWm5zTvS9DpLx4pTwA64Rm8P7rOTHNcZmbt8vw
X-Gm-Gg: AYBFou2ebAJ86ybtx9VxWMtWGS/t3tVThnAqbqhKSv6Q7021+Vpm5LZyaV7g8HuFwJw
	lmNy2oj7+Uvj6r+JGA0m2gMG+938pNbMihDRRSbXyPTeTpld2a9mQstmFtOrleq+r0f4Mvbdus/
	OMJS2NJ0hmtSQCH6mvO7/0kFbLypVIL6O90sK8XuBIDdznq2S2Mxxewgu4PuJETFARaHRfPoWk1
	WHHpMWT0Y23eShi82B1/ntzKlRJD47Cfojhmz5uXgCQOHRBDR1LLQyaqDZzZFWbPznJuPXKbk59
	fZ+2GxlcIOVgF6FriIOkjvA7S66N1E+DKZ5X3g81a66U//4Bt9kW9FM9P/iKr2qCNriXzUOt+uX
	5sZ7hxu5clF1i9seuGWqVt/MbUlSkI9S8hwp5fJHNxSeZCca9hS3inuxYEKS7d7VDw4ZIr9ssjF
	WzWsJy+JG09Lfs/v/AUa0u90wssWjyYUXSQOD8ThSVzkhV7GELKKYx8xeLP4+irmsH2cNp90zUI
	f2fq4KYZkvV37A9YML9MqnFteJ8bNIOFy74zzfl5moGQ6EcRNaNj7dMEL0cHE/JYg8JdCoNMylK
	t/sueDY29XNFfMjPVBrSA5+vhng431JcbmlRaGLkljA7bfub
X-Received: by 2002:a05:600c:c0d5:b0:49f:bd43:5a1c with SMTP id 5b1f17b1804b1-49fbd435a63mr67812825e9.15.1789687953608;
        Thu, 17 Sep 2026 16:32:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf37e69sm18703180f8f.29.2026.09.17.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:33 -0700 (PDT)
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
Subject: [PATCH bpf v7 06/10] bpf: Restrict CO-RE poisoning to relocatable instructions
Date: Fri, 18 Sep 2026 01:32:14 +0200
Message-ID: <20260917233222.2542500-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5989; i=memxor@gmail.com; h=from:subject; bh=Gj32JiyqDGcx9RhTd3ZU7Ej5EAAT1FguvvGgvR5C3iQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRWZHR13ethAfRvtIKc4f7x9vc34y3+T49aDExU36M +0Cpt7vKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESm9TEyXBQtKTl8mumFGUtH 1rTrGuFsLfMW/Vo/OSYq6EBChvaLl4wMt4zW1j8SLp40P27C44CaZrHQrtPXIqITNKZpRu5fsLO NGwA=
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
in-kernel CO-RE.

Fixes: d7a252708dbc ("libbpf: Improve handling of failed CO-RE relocations")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/relo_core.c | 58 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

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
-- 
2.53.0


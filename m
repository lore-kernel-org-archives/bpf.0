Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F744418347
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593697; cv=none; b=QHUhkTqLbKl/WnWXmYLLf0OBBGaNdT0XvXsDLaoyWv1Dr5/E+UNbJaQtVw0ULiP6MaW9pdrunC3oyxJISGERNdy8Jq4239XoWQjf6m5dBx6ja97VTnCq8ouN1dgkFTLjfgcPEF9T/1nfZalrWgpMnr74wSmrYB3cEosXEr5ZYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593697; c=relaxed/simple;
	bh=2dYc4G2hLeBzJuyKFgPPXaLjHLg/ViMJmgypQVUNZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKfvkvN2vttSUufuYF69F/XG7d7OOUpOy9/FOE2XYlZtEp4cIl8c8AMTAgIiF0ZwLt1X4fKWaptPW4wefU65HjAfns4QFP6n4X3qF/Cogrk8oI69GaedKIXGd7EOEZ0I+cXm7+Li9AmpodwodDYLnyGsTMK7xdjp0rWQ4MW/Eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5QPa+7H; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5QPa+7H"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so433085e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593674; x=1790198474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtO8FclDiABWId9+FsrsL0wPH5FRoKRhVJi3ogGlc40=;
        b=F5QPa+7HFhjIP+99ArdU3OcGcw+VSQGXnqKDjSvw8yY/OjSILIxqTgRCsTL7WcHUHg
         /hkBVUzyy3bRy5Y63k+WeCzbf1uQapAWaykMRbBj3iGn/jH4MaRi8x7wEbPJI4z5M3qM
         6OX895Bj8c0pvMD/FXNRiwMt2/UfktqtqPbvQzYgSVUwFnNMQlu+j86sYPxH9o11LI2O
         du29x6e/EfEK5HkmqyRLglJ1fM7h0t3xkQajdRD2Vc+M0Oh2+ZRJaaTuvpYMJ0Sphoyp
         PfPDL/RriBGBCFty9qx5dwba8941nNTGXGqdXkjbf0N7HHHUipFtJtlt50Jo85RCwTZb
         bvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593674; x=1790198474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtO8FclDiABWId9+FsrsL0wPH5FRoKRhVJi3ogGlc40=;
        b=lGVIZR8qDDSbCxtI/Nqy8l2wDcyPLVxze+2tQIW4OnuZU0kE2UGMAg0+Vo+uWd0baC
         pQE6yaKj92S3yViIpV/AQnue+/dIPzi6CzU7+3NnKLD0moyeuiRnbAo3n1FCsnGrqCPy
         y/80yAXvILwu0f0uodP2L6iPvFri21RmItN3Wg7KuceGWxhZCWbrCRzwKvB/EF+2EpfE
         xCRr/hTrILw9iW4cQf/lQ7at4jiqgKgcCTe4cUDIqA/I5v39gdwmEeq9DC/QgCvMj0tS
         1rCOlU7sh2A5dirz0n3emWqUVXeX0RBIRyUpXbDjSwkkGtJs3zROkkLDwaAhWY5K8RkL
         Hn8Q==
X-Gm-Message-State: AFuF++k0MXGZgRH6unDUHezfuCEr/BSAgL7XqNDzH95KWpI1/0NAsRsc
	7r2kMIrlwGDSUFMRPxPwORCNj77EygGw9Q/H+1foRIQV7PepD69fI7FSWKoKqu/r
X-Gm-Gg: AYBFou16f+x3iTsRMR8muVxz5Wp4PkOrAtt4GRxpaxXkoIDGumDeuA12DRquRJbbbgG
	jFIhDOCzuJRc++7AwHvuQYBMf8gOXpkZN1lvFI0TOR6hJrW/orcNDmY/djhpSKFLpYx0mQ0cPGu
	+4casLFFrMNqYpGQwvhgJoHFOb9z7lNY2DaZXTjW8dOdVa53Ox0MoCGWMKV9PRMyDPyO3qr6ocW
	D+/+FL8Hc9fPZQMLGdc23Ja9NHmR8iyrDX1X89/5Z1EHfe8makAFf+ShRxpQopFagk1KYTt2DJA
	cxG75AE4EjUNq708pncOOloGI4vvDT5lUTGJtzvnCtD0G3ywAa6B3D1UvInq+BMSIn7zJdBZhP3
	VV3F0cN+kFgr7Z724dcnvqitZyY2WYD7t4T7EY71h78xiE7YlOHTbHEE1qqScaQxSbbTFWvySJQ
	GMZnZVcpWChxNUi+w3I7pPUYUOj9AU57cbOyrFzlE6TRcfjgMBdwebWxBb4bHcCaBkgDhB0eLyo
	AcGDnIKfXJZOU18spLFuR8oZv431JCAgkN7vhZk0xpywrM58sgXHbb1e7dW6+r1mcJVdZLVJS1G
	jOh+SEMAOa3FA+8gKtFL2pYrGXSQ6HAoNzmWqi4=
X-Received: by 2002:a05:600c:1909:b0:49e:8418:389d with SMTP id 5b1f17b1804b1-49eb72f35bfmr47572055e9.9.1789593674111;
        Wed, 16 Sep 2026 14:21:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24774esm32936615e9.10.2026.09.16.14.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 06/10] bpf: Restrict CO-RE poisoning to relocatable instructions
Date: Wed, 16 Sep 2026 23:20:53 +0200
Message-ID: <20260916212102.597335-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6825; i=memxor@gmail.com; h=from:subject; bh=2dYc4G2hLeBzJuyKFgPPXaLjHLg/ViMJmgypQVUNZvk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h9xUJ558jkq+6SwRxjEqk7S3PVXiXjbnvazn/zRBx Yq8lb4dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMiJfEaGM9NU39e9VXt4TuZK XSn/mcK3Ph5s9gJPF4paMy/e4H21kOG/H+PnD0IJywo5Zi56ufav6onuicLFLAHuJoxfFwvuDuH gAgA=
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


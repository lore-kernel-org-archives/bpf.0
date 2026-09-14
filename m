Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229A2DF134
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424728; cv=none; b=rOVUTt8OVtYWQxOy2QtmT/w/PZEKnnit6635BMMKrGeczTHSXNzV159QKIrwGXwJ4OX4j/xQ9shRcpG6jdoRrCBfiNCrAX01aYwd9IzqxqWbtkWNMrC8rnWFQJVHfm7qdqxfpTFSKkzQuBdNwBSOdQUfW34s4tmtumfpybJRK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424728; c=relaxed/simple;
	bh=9FV/F7RgjZWwSFQuFUT5NQhdoVa5SaG9U6/HexKmnJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKT9MBbsdyzgt32YwjibnQZYidadTPmN+BgySWQ9l6fBL9TQoeNrjbPJls3jpfss3LlXurVadfjselVRYZugxrO+bZ19dWw8TOATQ4PZMIIN6jg2LoPzeD9bMESAPpNRr52W8xP4vQ3lWqg87WK9gtYOOwvow04o9H6JyxPceXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppeQyGnO; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppeQyGnO"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4858866f7ffso953114f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424725; x=1790029525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jizcm7L94cKWDO9DdJMmDI+wopmsq1WqmVxgzuPyEfU=;
        b=ppeQyGnONowGgC0USHMeAOz5CzYZeClkEosqaPuS4rpmLSvysELL/Co6pltVd4zdPx
         aCuZpQdIvNfQ2Fsi56GwxJO3XX01paTOEPSrs63iC0hKANf4uyzeQ8TN9vMEIWCnx7u4
         if+UWtJUOhf2W8vcFgU5lTJcyzBs98xwGT1glHZN3nKP6ZjD2enpmKhl7XhdlcDTBmxb
         kQBNNqX28W/xxixm7Ndvc+VKxl6vbuLawqBEOWIewtPSD+VSrsoogDlni0xRFNULywn9
         rqCROtYZXhCbRMjOWDHsgw1DFkIvAY+4BEuKWNmtrVUFETUV8tHix1sRyuGVRjZozZUQ
         8rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424725; x=1790029525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jizcm7L94cKWDO9DdJMmDI+wopmsq1WqmVxgzuPyEfU=;
        b=qc0ir+dvn+TO44trTpM7NbuhKta/5xsO0BGsdh0N1j+ckjEwpIZ7N8fMtCrD1r5UlZ
         KIZTFG+OqxveHyjbbV1hajL9QQY3LUyyUEjXoIMOdTKEo5vT/MEXv2Un7VttDRZR8iSK
         hAjLtPw/hIeWnDSNS1pk7ZKxcm5T0GTw0z+bjamwVLECJU5BaZmMWSuzCWSHl0nmfia7
         p5MgOATOEPBY3vB5HZO/aMT6Ljk187HArF3bHTDCp3/BbGA2zZeYoRtBmFPhaMNK0zyi
         kIvJtEfWaXJIzK35/TNuKv0t5DA1OyfQ1ToMYky7quCNie4RHwNRtcBuI8j+r67M+6bp
         JABw==
X-Gm-Message-State: AFuF++ks+7s68uWtf1aHNg1yxab+c9veE5umG7E8APZiuUqb42pDL3jX
	3wTI/DN+GaUjQe/03eX7hwxrLl+Z/HOif9eYfQeOllPeJoAqqorh9LUeyh5Jni2fTJA=
X-Gm-Gg: AYBFou3esCiMsZbaLHZhdH06zO05pKG8FUBgQpYe5unUxPpaubgtNDo6gv5+uwHyH//
	9Wbo/4J17eN4gKncVzedqFIIAFopdNigkmfSYYL+gZ2qqXBYv6LBkIwM3+olix6KsU6Fb9/aRpj
	4YqcPtOpFf3SysT0RbeiPrta62MyERaQs0xIL75xcoPyJYlB1bOLkUBtlKFAplRvnfVIS9c3rAg
	9TkR3swOGKeGl9vdaLW1LjJEdOFT//1YMGle1Hu2siXM2OkcRel6O7XE2IbIp8Uy/pXH+uHihcw
	jdMrd2xfcR16bWeZuOK9v9btrPEdywSArN5SLoakih90XBWxBGbzEHxMAdkpYZTE4uWz//uMefz
	jtmpk9ueb7QFQqrm4Obva3AxnrcKxGycJ3JCdkaM7a4o4OjOis1BxjEhOUlts8LfEpB4ivyVNT8
	c8JbO0Uzb4PcVECqq1ii31W+VBSI/b9m7mPiRLvT7nXae8JzGJewGN442LkCmiScqT8ITC1+Egt
	lixmaB2oXQh0BOYa6Xzl6xH9rWRdQfX17+6xOszmhAmBDkbGkXj+m/B3yDehz46BPwJLNXMHR/v
	2V4Ytfq5YmxXZJGo0E3nVRQPxPDgDsA7sYoA/Q==
X-Received: by 2002:a5d:6f09:0:b0:486:fcfd:45d4 with SMTP id ffacd0b85a97d-48702aae143mr5930613f8f.17.1789424725267;
        Mon, 14 Sep 2026 15:25:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm30391049f8f.33.2026.09.14.15.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:24 -0700 (PDT)
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
Subject: [PATCH bpf v4 06/11] bpf: Restrict CO-RE poisoning to relocatable instructions
Date: Tue, 15 Sep 2026 00:25:03 +0200
Message-ID: <20260914222514.1635018-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5991; i=memxor@gmail.com; h=from:subject; bh=9FV/F7RgjZWwSFQuFUT5NQhdoVa5SaG9U6/HexKmnJA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFid7N2iqBcO5qpl7jHVc/LyjOkFo1L29Gfqh8jmTBk nwPJ+OOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATOTWH4b/CdbVqzT4vplNDDgw OePlQUGNL9s/7dup+GUnQ6/asXMcHYwM69+XKHzcY5JyoaCiee06i6B4D51fFx9F3i8SeHsgOeE 4MwA=
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

Move poisoning into a helper that handles both halves of ldimm64, and
return its status directly from each validated instruction case. This
avoids routing the success path through a common label and leaves the
helper free to report errors.

The shared relocation code applies this restriction to both libbpf and
in-kernel CO-RE.

Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
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


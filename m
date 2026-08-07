Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E13C3459
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136400; cv=none; b=ZjVpa4s95npkLGHQcF9hkNaPDnyUZReQkWdGs5pzL4HfB7msocSRqs7SG/7JXrQdGS1t8L2avrXoxRO8tDvTYhCymSVYkSpBl7LejlsX2JAZzvoAl4/R2jeGndCmvbAJ9cdH48PxrZYl2lgpGhbvYwBmY81+KKiCDfHfwl67c7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136400; c=relaxed/simple;
	bh=egsmF6/ztroJ7mqQgBeSoBNzD/OmrkZ5JFYXvscQ3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqSEmUfEBUELgIPZcLv4EFwAUAno0RVpby68pGdYjUwkyIIrR6lEhG4NcZ4Tp8bRX5LaeVdQJ6JBJROrhvTQa3tKmNj/9XeTerBFFkb7aqaFNhY9B01YgZHCs0xTJh2nJwrW/PJjGPt7fp+iZ+cVWuWVwI0AFVrw4wbtIJmCyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+d0MqO4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+d0MqO4"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2746567b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136398; x=1786741198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqJqUzIZprh6xw0sxvkSCwLL/6/F3L/5Loon5rmkYvY=;
        b=G+d0MqO4ghKCZcPAKshYiao7P7cyUSWdF4P1MH1r9envm9EmlTVPgw2HSgNVQmpoVD
         DmZxqPdXxSOAA62FdSQl5wC4aToUR+ctlDhQ/uPnaGWrM1gByvFu/3ZvILD0mNq0jbhp
         eK80nanFxWsJ/BfkXQadX1hr7dvdWqj39W2PGG1oOSxQ50K5Gz3DgIOqLcnazIcMNllt
         OivdLFTxF8XPMpABCu3EcdpGQEz6Hi+i4Eh3JQSgTmvXW59mKhVM7bNIUOv7dn75vJSk
         iDoWzjphUGnV8mO8rVbwtCnHBJ2JnJXUygGrg3zJqnT4b4KMga+eHRUKsoc1BmSiPkA/
         qdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136398; x=1786741198;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqJqUzIZprh6xw0sxvkSCwLL/6/F3L/5Loon5rmkYvY=;
        b=OUi1XPtg2Tp4FnCpyvu1Gt0Eobex8O7uzgFH9jBCL8rV5VEBUKA5ev0G3ACQ7Fzw4x
         rnybX65suiEZ2dTgAaPUI6MBjbXhWmfDfdP0/sPEDtPTzI25vzHe97Duy77BUPH9VXPB
         uOw3LnXuaN3vQKwHimDkJl7Uwd79RJOh0r+MCiCrR7FHz6XIcv8rXLPOqAqxuGI9SnzO
         CWvf0o8NvJiujaoXm6c66TvPIg3MkQiOT/RUM/l98eZlaTqqkncOM64WTi9gUCpizEUV
         ag9mybjqf5g8bzdt7jaMMfwtsW5EAlnVcprZ0IzeRGXhrDyVByWd2nP5uXVmHpTE6Y5f
         mFww==
X-Gm-Message-State: AOJu0YwQAKHExH6UCwAahYjofO7qkcq4gLNkK76hHYXjL2/igPVwMyGc
	bNd2uj/CFmy2oMqjhJPFlEVmhk3+NAy1/fBdtZeoyZpWnqj5tNeD9E6XGcjwwPEr
X-Gm-Gg: AR+sD11UADjpyq6Dfjf7F2Ltgj/pS2zMoIb3bZAq6lsbbTxCHNQKhDmFTLnVLhArBJp
	LpYxu2iNs0Sdcmo5B34aHtEI4jS7dtX2rSNibc6I697/Z444o5hqeq3AZ05wzX53aSGVUrJmjjh
	NvSg15ROfgUZNiBTu4XXb3oAgyRggVlc0xI+OSyz3yWZeqzPp39hTX4IfGuY73OQ9zgSeBASKSX
	JynVEuSU7+Admkz6QJ8dt+f2Gi+ROh9wozKJV9gIV2oEPhQkpq8mfkPQp29SKiyQPgBSEoVmimU
	kTU4JHcl1bgiKJ356CDBnfjaHSyhL9KVFDu8+653vpKWZHiGYkljbb1ie+YLoPnnTcgudWjtpT6
	LPoVLSsFrv/6jh+nSjtWp+XlPqNvUpEOnq7KGECez6OpmCDaqgDsZZqerJMioGBKXJUUa/Qmyj0
	bIy8+SMS45kNq7GSVYdzUIUJLy942Au5z+UvwGZPmklXf1IkJPBHPTrny7Bfb8e5p5riSf7YWf0
	N0eQnZ2EyEssye5Uf6aAuipHMAvswRT7UYeDpQ9xewNbHJkU2E7P5E=
X-Received: by 2002:a05:6a21:62c4:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3cbd3bc0036mr1523038637.14.1786136397934;
        Fri, 07 Aug 2026 13:59:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:59:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	info@starlabs.sg,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v4 1/7] bpf: do not print a newline after disassembly in bpf_verbose_insn()
Date: Fri,  7 Aug 2026 13:59:30 -0700
Message-ID: <20260807-static-zext-v4-1-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

At the moment there are more callsites that want bpf_verbose_insn() to
not print a newline after the instruction, than callsites that want a
newline. Drop '\n' from disasm.c. Non-functional change.

The changes in bpftool are verified by writing a bpf program using a
variety of instructions and comparing `prog dump xlated` output in the
following modes: plain, opcodes, visual, visual opcodes.
The output before and after the changes is identical.

Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/backtrack.c                       |  1 +
 kernel/bpf/disasm.c                          | 68 ++++++++++++++--------------
 kernel/bpf/liveness.c                        |  6 +--
 kernel/bpf/verifier.c                        |  1 +
 tools/bpf/bpftool/xlated_dumper.c            | 19 ++------
 tools/testing/selftests/bpf/disasm_helpers.c |  3 +-
 6 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2f473ad4fd7c..40bd04421a99 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -285,6 +285,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		bpf_verbose_insn(env, insn);
+		verbose(env, "\n");
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 0391b3bc0073..50b3ca5149a0 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -139,7 +139,7 @@ static void print_bpf_end_insn(bpf_insn_print_t verbose,
 			       void *private_data,
 			       const struct bpf_insn *insn)
 {
-	verbose(private_data, "(%02x) r%d = %s%d r%d\n",
+	verbose(private_data, "(%02x) r%d = %s%d r%d",
 		insn->code, insn->dst_reg,
 		BPF_SRC(insn->code) == BPF_TO_BE ? "be" : "le",
 		insn->imm, insn->dst_reg);
@@ -149,7 +149,7 @@ static void print_bpf_bswap_insn(bpf_insn_print_t verbose,
 			       void *private_data,
 			       const struct bpf_insn *insn)
 {
-	verbose(private_data, "(%02x) r%d = bswap%d r%d\n",
+	verbose(private_data, "(%02x) r%d = bswap%d r%d",
 		insn->code, insn->dst_reg,
 		insn->imm, insn->dst_reg);
 }
@@ -197,19 +197,19 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			else
 				print_bpf_end_insn(verbose, cbs->private_data, insn);
 		} else if (BPF_OP(insn->code) == BPF_NEG) {
-			verbose(cbs->private_data, "(%02x) %c%d = -%c%d\n",
+			verbose(cbs->private_data, "(%02x) %c%d = -%c%d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
 		} else if (is_addr_space_cast(insn)) {
-			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)\n",
+			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)",
 				insn->code, insn->dst_reg,
 				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
 		} else if (is_mov_percpu_addr(insn)) {
-			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)",
 				insn->code, insn->dst_reg, insn->src_reg);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
+			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
@@ -218,7 +218,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				class == BPF_ALU ? 'w' : 'r',
 				insn->src_reg);
 		} else {
-			verbose(cbs->private_data, "(%02x) %c%d %s %d\n",
+			verbose(cbs->private_data, "(%02x) %c%d %s %d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
@@ -227,7 +227,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		}
 	} else if (class == BPF_STX) {
 		if (BPF_MODE(insn->code) == BPF_MEM)
-			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d\n",
+			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
@@ -235,7 +235,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			 (insn->imm == BPF_ADD || insn->imm == BPF_AND ||
 			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
@@ -246,7 +246,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			    insn->imm == (BPF_AND | BPF_FETCH) ||
 			    insn->imm == (BPF_OR | BPF_FETCH) ||
 			    insn->imm == (BPF_XOR | BPF_FETCH))) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
@@ -254,7 +254,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_CMPXCHG) {
-			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)\n",
+			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
 				insn->code,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
@@ -262,44 +262,44 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_XCHG) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_LOAD_ACQ) {
-			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))\n",
+			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))",
 				insn->code, insn->dst_reg,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->off);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_STORE_REL) {
-			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
-			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_%02x", insn->code);
 		}
 	} else if (class == BPF_ST) {
 		if (BPF_MODE(insn->code) == BPF_MEM) {
-			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = %d\n",
+			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = %d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->imm);
 		} else if (BPF_MODE(insn->code) == 0xc0 /* BPF_NOSPEC, no UAPI */) {
-			verbose(cbs->private_data, "(%02x) nospec\n", insn->code);
+			verbose(cbs->private_data, "(%02x) nospec", insn->code);
 		} else {
-			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
 		}
 	} else if (class == BPF_LDX) {
 		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
-			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
 			return;
 		}
-		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)\n",
+		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)",
 			insn->code, insn->dst_reg,
 			BPF_MODE(insn->code) == BPF_MEM ?
 				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
@@ -307,12 +307,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			insn->src_reg, insn->off);
 	} else if (class == BPF_LD) {
 		if (BPF_MODE(insn->code) == BPF_ABS) {
-			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->imm);
 		} else if (BPF_MODE(insn->code) == BPF_IND) {
-			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[r%d + %d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[r%d + %d]",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->imm);
@@ -332,12 +332,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			if (is_ptr && !allow_ptr_leaks)
 				imm = 0;
 
-			verbose(cbs->private_data, "(%02x) r%d = %s\n",
+			verbose(cbs->private_data, "(%02x) r%d = %s",
 				insn->code, insn->dst_reg,
 				__func_imm_name(cbs, insn, imm,
 						tmp, sizeof(tmp)));
 		} else {
-			verbose(cbs->private_data, "BUG_ld_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ld_%02x", insn->code);
 			return;
 		}
 	} else if (class == BPF_JMP32 || class == BPF_JMP) {
@@ -347,35 +347,35 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			char tmp[64];
 
 			if (insn->src_reg == BPF_PSEUDO_CALL) {
-				verbose(cbs->private_data, "(%02x) call pc%s\n",
+				verbose(cbs->private_data, "(%02x) call pc%s",
 					insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)));
 			} else {
 				strcpy(tmp, "unknown");
-				verbose(cbs->private_data, "(%02x) call %s#%d\n", insn->code,
+				verbose(cbs->private_data, "(%02x) call %s#%d", insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) goto pc%+d",
 				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
-			verbose(cbs->private_data, "(%02x) gotox r%d\n",
+			verbose(cbs->private_data, "(%02x) gotox r%d",
 				insn->code, insn->dst_reg);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
-			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) may_goto pc%+d",
 				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
+			verbose(cbs->private_data, "(%02x) gotol pc%+d",
 				insn->code, insn->imm);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
-			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
+			verbose(cbs->private_data, "(%02x) exit", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data,
-				"(%02x) if %c%d %s %c%d goto pc%+d\n",
+				"(%02x) if %c%d %s %c%d goto pc%+d",
 				insn->code, class == BPF_JMP32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
@@ -383,14 +383,14 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->src_reg, insn->off);
 		} else {
 			verbose(cbs->private_data,
-				"(%02x) if %c%d %s 0x%x goto pc%+d\n",
+				"(%02x) if %c%d %s 0x%x goto pc%+d",
 				insn->code, class == BPF_JMP32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
 				(u32)insn->imm, insn->off);
 		}
 	} else {
-		verbose(cbs->private_data, "(%02x) %s\n",
+		verbose(cbs->private_data, "(%02x) %s",
 			insn->code, bpf_class_string[class]);
 	}
 }
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..ff1e68cc4bd1 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -497,7 +497,6 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 		pos = env->log.end_pos;
 		verbose(env, "%3d: ", insn_idx);
 		bpf_verbose_insn(env, &insns[insn_idx]);
-		bpf_vlog_reset(&env->log, env->log.end_pos - 1); /* remove \n */
 		insn_pos = env->log.end_pos;
 		verbose(env, "%*c;", bpf_vlog_alignment(insn_pos - pos), ' ');
 		pos = env->log.end_pos;
@@ -1043,7 +1042,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tr%d: ", i); verbose_arg_track(env, &at_in[i]);
@@ -1058,7 +1056,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tsa%d: ", i); verbose_arg_track(env, &at_in[ai]);
@@ -1070,7 +1067,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tfp%+d: ", -(i + 1) * 8); verbose_arg_track(env, &at_stack_in[i]);
@@ -1545,6 +1541,7 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 
 		verbose(env, "%3d: ", idx);
 		bpf_verbose_insn(env, &insns[idx]);
+		verbose(env, "\n");
 
 		/* Collect what needs printing */
 		if (is_ldx_stx_call &&
@@ -2285,6 +2282,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 					verbose(env, ".");
 			verbose(env, " ");
 			bpf_verbose_insn(env, &insns[i]);
+			verbose(env, "\n");
 			if (bpf_is_ldimm64(&insns[i]))
 				i++;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6233c0081d1..a9358e04bbe2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17538,6 +17538,7 @@ static int do_check(struct bpf_verifier_env *env)
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
 			bpf_verbose_insn(env, insn);
+			verbose(env, "\n");
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5e7cb8b36fef..5579173a61e3 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -107,14 +107,7 @@ print_insn_for_graph(void *private_data, const char *fmt, ...)
 
 	p = buf;
 	while (*p != '\0') {
-		if (*p == '\n') {
-			memmove(p + 3, p, strlen(buf) + 1 - (p - buf));
-			/* Align each instruction dump row left. */
-			*p++ = '\\';
-			*p++ = 'l';
-			/* Output multiline concatenation. */
-			*p++ = '\\';
-		} else if (*p == '<' || *p == '>' || *p == '|' || *p == '&') {
+		if (*p == '<' || *p == '>' || *p == '|' || *p == '&') {
 			memmove(p + 1, p, strlen(buf) + 1 - (p - buf));
 			/* Escape special character. */
 			*p++ = '\\';
@@ -129,16 +122,10 @@ print_insn_for_graph(void *private_data, const char *fmt, ...)
 static void __printf(2, 3)
 print_insn_json(void *private_data, const char *fmt, ...)
 {
-	unsigned int l = strlen(fmt);
-	char chomped_fmt[l];
 	va_list args;
 
 	va_start(args, fmt);
-	if (l > 0) {
-		strncpy(chomped_fmt, fmt, l - 1);
-		chomped_fmt[l - 1] = '\0';
-	}
-	jsonw_vprintf_enquote(json_wtr, chomped_fmt, args);
+	jsonw_vprintf_enquote(json_wtr, fmt, args);
 	va_end(args);
 }
 
@@ -351,6 +338,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 
 		printf("%4u: ", i);
 		print_bpf_insn(&cbs, insn + i, true);
+		printf("\n");
 
 		if (opcodes) {
 			printf("       ");
@@ -417,6 +405,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 
 		printf("%u: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
+		printf("\\l\\\n");
 
 		if (opcodes) {
 			printf("\\ \\ \\ \\ ");
diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
index f529f1c8c171..30221352568d 100644
--- a/tools/testing/selftests/bpf/disasm_helpers.c
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -55,10 +55,9 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 	 * for each instruction (FF stands for instruction `code` byte).
 	 * Remove the prefix inplace, and also simplify call instructions.
 	 * E.g.: "(85) call foo#10" -> "call foo".
-	 * Also remove newline in the end (the 'max(strlen(buf) - 1, 0)' thing).
 	 */
 	pfx_end = buf + 5;
-	sfx_start = buf + max((int)strlen(buf) - 1, 0);
+	sfx_start = buf + (int)strlen(buf);
 	if (strncmp(pfx_end, "call ", 5) == 0 && (tmp = strrchr(buf, '#')))
 		sfx_start = tmp;
 	len = sfx_start - pfx_end;

-- 
2.55.0

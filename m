Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585B3C4547
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845486; cv=none; b=Oxsz87c4l43OV8sgW+ALfpT+9VEs8QD18fggIVkIAy3iUDitviNQx38bixpe946E2ZnyyGTaQryXdoJb2HgIwQ3l9LCczwxhidJ/ds260Jb3gIsuNyy9/UPnp5k9rK0W+nbKl6A0cv7OVVPbVWejU7BWpB+RkEFQY3M7Zz1/k30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845486; c=relaxed/simple;
	bh=OzlmmEfOzGYiS5091eIgiNo66Ms6Ah0nCbaBreaPT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa9qlryHTf2ItTgyNHAwsy9UpFMatP/jf14Q9UlPIW+Fk7KtvlwHINx+TUTPvcMnoV1LeDgTHYBKjDy8xYgoCDn++e6AKChiSBFsTqsFSRS6pGGpIZg34Mc+86+FA03Td+M4vpRnq71K6Mdjj2tRzqudhoR814DfFe/6sixgjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHCRDeuX; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHCRDeuX"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so5361085e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845481; x=1787450281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmTDB9xlQbnS9+FJ4DKK6oLmys7ngu62WzLZIOvBrjI=;
        b=hHCRDeuXiqj/oqmqMvEhfKBvxn9dlArR69I+NFddHMalDp9j9efNItcxzC2z4fxnab
         UJk4dtpjtCbeMBlrhBLSZghOj+RjTS3wNr0n/rE6F1ksfH/8NtSPGsZz2pvV4m7E2Pt7
         a6qL4iIHtTftHrCuTpGXMO3jIFGcfuEFRRn41MMmTN1lqadLLVdzpVRP3ba6u2WuNnUJ
         k3F25Kk4Oelwy9aDLDbsnrn8iXr7E8Uv3CaGeeaf4D5aDx7X+VeaEBVGXe/wFn+7KYHG
         +/unRr6hiyg/3t4yFYQ7Kr/Xx1w8dgBBhHMnLAKTExnYR+68Ngnm+QjpBFclH1mOUdWZ
         YwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845481; x=1787450281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmTDB9xlQbnS9+FJ4DKK6oLmys7ngu62WzLZIOvBrjI=;
        b=pLfrG27oCtWD4DXLF4mQV/H5ZD33ffHou5VfQSoxAhkdtGelB5H9TNVUVWmTbaGtM5
         HIvbFK9aMt21Q0T6ephz8e/6+VVGbw/StHD4RclB9pBmMHkYvJN68cdPeMfLvrL2Vjwo
         mPvqggO3oUgDMp9QMP5DB/sx0odXwH8I8Bh276VYM1NAHsv1lUfoQtok+b17RXbEV2Yf
         4nexhA+IfnEYmBYMMQmWH0Qwu8U2jsbz1Nq9wLfv8LEEVN4qNuSIGp8TAxsiqycV8nfb
         AiZed939kmy8288AwMEgpt97CvMJHpd9HrN1X/DVkVCiwRxvEh3F1rOlsjk0gOo3TBlB
         c7Iw==
X-Gm-Message-State: AOJu0YysTjUpKRZLXX0/FHYaExrhcAw20KQOEAFKDGyLFgWt+kIsZMPo
	bmmC6OdqPc1V3bbS2d3eG9VX2PW/9FYy7S/QAe7Ior8q4ndIEOJut0vyysxMmBFI
X-Gm-Gg: AR+sD117Yzs8XX55S6wA6gCF5k6RkReSwkuymEVrH3ym9qJXsfpr2SKfj0eB9qt8E9l
	AEsoMf22RPiOG0uECcO+TZ+oPwYmkNl+UXH/JIa3OWkxUFvvKYgiZSexrM8pOgyhxspoWVyhOWo
	c9dEoWkbud6CAUWChW9ixo8CBmnCd5gXD6niVw3TU0zGcQrQD2V8AkLCR2OZ4xRKhOStR6tnwY/
	pnGJJ/94c1M1NzBHtSQetH4qY3oDjj3WrTesc5/lntjGhOss6eQ+5+M7yGRBFBokRsah0SRK16p
	y3W9YyfALawbK187IcLgTGj8kbN6ipGUj/Q8K1ZJqYuypEgaFSv7XN928KEMB+WBVj8EI6R1vPU
	tlypm8BOd0bU2WoeEYEMBuEUGdductHoa1zFKjzlDlH9c4ar8M8cvDjSyh2CebvQA8E1Dxb9lIE
	hHJHuzL0mkHzDoEepDZYGTfK7g5ZVa2T9fjpVAptaoyOx6vOBK5V7biDVAsxgW8k8RYFSUkwZG8
	3qEenw59fXs0ZDdkfmaH5GuNxsEBPLhoulRVYCeH6vWNB701ILl2BB1D57K9hrD3JDMe7ITSsIK
	P6HR75GM0AvrCc4N8ctPfrhSwI0=
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-4998795bca6mr267107295e9.8.1786845481333;
        Sat, 15 Aug 2026 18:58:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996128cffsm2983375e9.15.2026.08.15.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:58:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/14] bpf: Correct Program Structure diagnostic context
Date: Sun, 16 Aug 2026 03:57:38 +0200
Message-ID: <20260816015746.2632990-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6562; i=memxor@gmail.com; h=from:subject; bh=OzlmmEfOzGYiS5091eIgiNo66Ms6Ah0nCbaBreaPT+U=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQlz5gV2c6eTVwvVmpybO3pgTrMIouTGQ8+O6iycy1 NryRfd1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCL63YwM122O54cH63XEhV3/ Ksag7zuvz/uPgfiKHm/rGqnrGp0HGRnm+xeriE52tJm6W6L0hHfhr8WhVhGX1N+dmSgbd0D12Xp WAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Program Structure reports have three attribution gaps. A missing jump table
is reported at the beginning of its subprogram rather than at the gotox that
needs the table, recursive-call details are present only in the legacy log,
and the early subprogram-layout checks run before BTF line information is
installed.

Pass the failing gotox instruction into the jump-table lookup and include both
ends of a recursive edge in the structured reason.

The BTF validator needs the discovered subprogram boundaries together with
the LD_ABS and tail-call properties collected during the layout scan. Split
that property collection from layout validation, then validate BTF before
reporting layout errors. This makes validated source information available to
the jump-boundary and fallthrough reports without changing either check.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c      |  6 +++---
 kernel/bpf/verifier.c | 47 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 0f13c13f4133..95c59f6cf70a 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -287,7 +287,7 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
  * combined jump table in jt->items (allocated with kvcalloc)
  */
 static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
-					  int subprog_start, int subprog_end)
+					  int insn_idx, int subprog_start, int subprog_end)
 {
 	struct bpf_iarray *jt = NULL;
 	struct bpf_map *map;
@@ -327,7 +327,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
 		bpf_diag_program_structure(
-			env, subprog_start, "missing jump table",
+			env, insn_idx, "missing jump table",
 			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
 			"No jump table was found for the subprogram that starts at instruction %u.",
 			subprog_start);
@@ -349,7 +349,7 @@ create_jt(int t, struct bpf_verifier_env *env)
 	subprog = bpf_find_containing_subprog(env, t);
 	subprog_start = subprog->start;
 	subprog_end = (subprog + 1)->start;
-	jt = jt_from_subprog(env, subprog_start, subprog_end);
+	jt = jt_from_subprog(env, t, subprog_start, subprog_end);
 	if (IS_ERR(jt))
 		return jt;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3de9e4f617b6..d2f08c6612c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2995,15 +2995,13 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int check_subprogs(struct bpf_verifier_env *env)
+static void find_subprog_properties(struct bpf_verifier_env *env)
 {
-	int i, subprog_start, subprog_end, off, cur_subprog = 0;
+	int i, subprog_end, cur_subprog = 0;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 
-	/* now check that all jumps are within the same subprog */
-	subprog_start = subprog[cur_subprog].start;
 	subprog_end = subprog[cur_subprog + 1].start;
 	for (i = 0; i < insn_cnt; i++) {
 		u8 code = insn[i].code;
@@ -3017,6 +3015,27 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
+		if (i == subprog_end - 1) {
+			cur_subprog++;
+			if (cur_subprog < env->subprog_cnt)
+				subprog_end = subprog[cur_subprog + 1].start;
+		}
+	}
+}
+
+static int check_subprogs(struct bpf_verifier_env *env)
+{
+	int i, subprog_start, subprog_end, off, cur_subprog = 0;
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+
+	/* now check that all jumps are within the same subprog */
+	subprog_start = subprog[cur_subprog].start;
+	subprog_end = subprog[cur_subprog + 1].start;
+	for (i = 0; i < insn_cnt; i++) {
+		u8 code = insn[i].code;
+
 		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
 		if (BPF_OP(code) == BPF_CALL)
@@ -3038,9 +3057,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		}
 next:
 		if (i == subprog_end - 1) {
-			/* to avoid fall-through from one subprog into another
+			/*
+			 * To avoid fall-through from one subprog into another,
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back or bpf_throw call
+			 * or unconditional jump back or bpf_throw call.
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
@@ -3126,8 +3146,9 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					bpf_diag_program_structure(
 						env, idx, "recursive subprogram call",
 						"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-						"This bpf2bpf call would make the subprogram call graph recursive. "
-						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+						"The call from %s() to %s() would make the subprogram call graph recursive. "
+						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.",
+						bpf_subprog_name(env, cur), bpf_subprog_name(env, callee));
 					ret = -EINVAL;
 					goto out;
 				}
@@ -21124,17 +21145,19 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Discover all subprograms before validating their layout and BTF. */
+	/* Discover all subprograms and collect the properties needed by BTF validation. */
 	ret = add_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_subprogs(env);
+	find_subprog_properties(env);
+
+	/* Validate BTF and apply CO-RE before reporting subprogram layout errors. */
+	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
-	ret = bpf_check_btf_info(env, attr, uattr);
+	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.53.0


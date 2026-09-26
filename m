Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E943C05F
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429456; cv=none; b=j/hlZIBAM9krdZdCy9mpH5x2iz+ukNu1jUYtsYqVvdY9h2t9Q9aQQd0vGMV78HqT47U/ceCKf52Fhd4aPHa/rFiXUhGqHetdpve2ARKZZz25DCw9WEw7FF4hswhCqvO1532KpF+edujeWwyQttPWB+vhfBNbVJkUU4wCjBtcO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429456; c=relaxed/simple;
	bh=Z/fAGKxM/kwN9NtIupqtxmxlToae+MQKZDpvODEamLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8964+FZL18B0RNe103ihmlGuBeTDUvQUFGrBTHS/aoA5EhtArFud4ZnZgHXLaBCtZ7Gc2jrS/nfhUu3wCjJpYNrIcYbsSS3HkD/h6qmqDFSKkWaQqaVJsUb5jyt7cMsrCXqpbppKjfRfUGIrKqPT2o6GGgS27MSh2SBenzkgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWgyCiKx; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWgyCiKx"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48880d1367fso557374f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429453; x=1791034253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qH3PaVT/QJtDkzjVNWGNimUbmF56crRwYyDvwUsVet4=;
        b=LWgyCiKxMe6mlo9aYohEwKYxJIiT7aQR98Kyz25f/cXVYIfy6JqCsvDn57ocM4nilV
         QvJQaSTXcQpOlqA4p3P9iWxizMAzFgnymg2L7V7fYMx1Tuq0P8W6I1o4gt6RWGV+bkIM
         WkQtHGN8WnVlJ1R1gDUV3cfA8XcnNtdMw1Qrt/MaDTY6UO28SZFQ30HxvISkqPFV1yzX
         E16/wqOHhsumlLZQ1I5AGPRzcsqu1tWNyulb+JcWl5mT9QFaUxva1iy3mQU8WOHevLH5
         ORGM2trRg9l9u0B8z7ICiM/30p8xcQ2NxbSeXw1QzE1zioFC7x4VM0EENzQhAccxBM1U
         kbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429453; x=1791034253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qH3PaVT/QJtDkzjVNWGNimUbmF56crRwYyDvwUsVet4=;
        b=tWcKHN2aNY7gdjDsN1ThIF/SY9GrbeSFShJyFI/wLKD3ifguZB/zInpyVxIFeJVyFW
         oMKb76ECD3a8J3EAZWKcsRuQWeY3t45te+td7RWhe0He8PZmbiR2sUQyF+v8KEnw3VPx
         wAEmd/NZhScdM1TbSnfh2ED0NGM7k4qdPupkedmDsRHQaEa/xctDXrcSlCRoi5BRsaxY
         FxwWVTWHRd30q2dJQo3ufTPW3RddV9q6ZSN1ZFN+Znouo3Yekq8h+7hWGIY4VpKNSENO
         YZwoXoY/ayq1yulxjEDa6ozXHPHxESRv3WlCllL5ptjQbJheDTf/y+WnI+PWWO8C3iNx
         3njw==
X-Gm-Message-State: AFuF++mIWgFIJqiSWqgYgVgieNAOkYEUzbGnxeE94516rWsa1qoGjOok
	Ez9Z3a8arog6RNeAJHWF8Fnc6H9/542cWmGcKCRceJ1paGyl5XKobU6WzDB24IRO
X-Gm-Gg: AYBFou1mC4OE3zX0yiI5IFSORJfpeVI0StxSQtOlYl1xBnrikCD3ePp+puKVPHP+Xqj
	JdPh6O+0RO5RnOKIGPAmfFbkuklQLYIZOee7zgByaDRaSY59kOrDNAlYYbuNoXl3ENql68LBBLL
	WLG4mP85XyYxMCLb280bbkeylM54ZzH5s2tKtFh/1Z0sIidW9rsGFvkUYFiDBj+SHS4uxf7CeH5
	pxJUTqa986p/EsaYzkGt4MHHay3pxsh+QnU98ytDlClmffvsltjRVb41irp1FV3l5RPAZi6www1
	a2RvplwU2R0Q2uRxoonNi/kPlYEENxhF1eAL0vRHRf7sDAzs2tTRWi7qfP9irfg5h8vJgwONfg1
	u7ArjstH9d5PnVzsgrrosplHV0DH7RJ6IsawpkqgkC384YamJ3AGdSmamuKKMDnp5s6qmh61PYv
	glk2DtW3in/HbMdCjtBBKmj1ivsBkJIMP8AQOL573Gir2lYy7MPeTS5GKbau8FHHBeRSk5HmEgG
	H9cJ8f/BHuuVuc4UrwzjyVUPblDAxMGrjURELHO429aZYreXul57Kl5puA2uqlVaSja45Tc/HTE
	F6D7Iv3A6il0htcYRvh6zJwsruCW+EKdYRr2SW8=
X-Received: by 2002:a05:600c:8b25:b0:49f:e58a:1dc7 with SMTP id 5b1f17b1804b1-49ff06e50a7mr93904105e9.19.1790429452813;
        Sat, 26 Sep 2026 06:30:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06bdd11sm135711925e9.9.2026.09.26.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:30:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/3] bpf: Correct Program Structure diagnostic context
Date: Sat, 26 Sep 2026 15:30:44 +0200
Message-ID: <20260926133048.2962553-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926133048.2962553-1-memxor@gmail.com>
References: <20260926133048.2962553-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5556; i=memxor@gmail.com; h=from:subject; bh=Z/fAGKxM/kwN9NtIupqtxmxlToae+MQKZDpvODEamLI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv7iSdlq3pmLTG0u9zRxH6zntmE7VXUjuOq7WuVd6qKa 5X8bkjuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESOvWFkmPDF56b876e7eBTl k78smTL3niODoOXGVYsUjE50PJqo9JyR4cqE4mcXX390vts0w2ND4iO+BY+7vVNaGmu6vadnnD1 0mQUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Program Structure reports have two attribution gaps. A missing jump
table is reported at the beginning of its subprogram rather than at
the gotox that needs the table, and the subprogram-layout checks run
before func_info and line_info are validated and installed, so their
reports cannot name the source function or line.

Report the missing jump table at the gotox instruction that looks it up,
rather than at the start of its subprogram.

func_info and line_info validation only needs the subprogram boundaries
found by add_subprogs() and the LD_ABS and tail-call properties that
check_subprogs() collects while scanning instructions; it does not
depend on the layout checks themselves. Split the property collection
into its own nested subprogram and instruction scan, together with the
program's callx marker, and run bpf_check_btf_info() before
check_subprogs(). The jump-boundary and fallthrough reports then carry
validated source information without changing either check.

CO-RE relocations are unaffected: commit c26e97721b17 ("bpf: Apply
CO-RE relocations before subprogram validation") applies them before
add_subprogs(), and they stay there. Only the func_info and line_info
validation moves.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c      |  2 +-
 kernel/bpf/verifier.c | 54 +++++++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index b0bd9ba951df..d8a579680e5b 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -393,7 +393,7 @@ subprog_jt(int t, struct bpf_verifier_env *env)
 	if (!subprog->jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
 		bpf_diag_program_structure(
-			env, subprog_start, "missing jump table",
+			env, t, "missing jump table",
 			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
 			"No jump table was found for the subprogram that starts at instruction %u.",
 			subprog_start);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e00398..b2cc607ac02d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3107,6 +3107,34 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static void find_subprog_properties(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cur_subprog;
+
+	for (cur_subprog = 0; cur_subprog < env->subprog_cnt; cur_subprog++) {
+		int i;
+
+		for (i = subprog[cur_subprog].start;
+		     i < subprog[cur_subprog + 1].start; i++) {
+			u8 code = insn[i].code;
+
+			if (code == (BPF_JMP | BPF_CALL) &&
+			    insn[i].src_reg == 0 &&
+			    insn[i].imm == BPF_FUNC_tail_call) {
+				subprog[cur_subprog].has_tail_call = true;
+				subprog[cur_subprog].tail_call_reachable = true;
+			}
+			if (BPF_CLASS(code) == BPF_LD &&
+			    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
+				subprog[cur_subprog].has_ld_abs = true;
+			if (bpf_is_callx(&insn[i]))
+				env->has_callx = true;
+		}
+	}
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3120,17 +3148,6 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; i++) {
 		u8 code = insn[i].code;
 
-		if (code == (BPF_JMP | BPF_CALL) &&
-		    insn[i].src_reg == 0 &&
-		    insn[i].imm == BPF_FUNC_tail_call) {
-			subprog[cur_subprog].has_tail_call = true;
-			subprog[cur_subprog].tail_call_reachable = true;
-		}
-		if (BPF_CLASS(code) == BPF_LD &&
-		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
-			subprog[cur_subprog].has_ld_abs = true;
-		if (bpf_is_callx(&insn[i]))
-			env->has_callx = true;
 		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
 		if (BPF_OP(code) == BPF_CALL)
@@ -3154,9 +3171,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -22570,17 +22588,19 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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
+	/* Validate BTF before reporting subprogram layout errors. */
+	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout. */
-	ret = bpf_check_btf_info(env, attr, uattr);
+	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.53.0


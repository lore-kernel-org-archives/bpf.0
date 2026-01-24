Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76720B7ED
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225512; cv=none; b=eVxWU5eSRmWdx2Trp8dO7JTU4fKeO85mJoEUtZTtgxicCvF3hAPoMDzkCzwdb6soxzT1Krw3Z4gAzatl4Vr4UvZu2S/HJOIc+VkwF1pKLFMR0KPXOXT947oG8/iWLKB8amu5e7uzXn2j1awQOALP48lgzY20l664G1f2b128FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225512; c=relaxed/simple;
	bh=ov0wUqV6kuTWTFBkzZscv2aYec7op/sl0bS8tbqxj1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcsiQFE7REYIrm+dva7Gau1nm80U9dCtkp9uzJ0tO778rEB1xhRKn2IgaWQln8Z2SSnjo0z7zz8y1kkgOgAaSuMxdY/IsewB+tzSbVkWe5af9oE7EK16DtA1dK8r917MnlbiNWQdvOQQZuGpaY/s/99IGPNDIVfkYLZh4roP5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBXG9QMG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBXG9QMG"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0c09bb78cso20139845ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225510; x=1769830310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MyGznuXGAu60e1tz5lHjO5zn/zhV1nMJNWbpCAy+Ik=;
        b=GBXG9QMGhVsF7DpzxaLxURSje+hnx5S+fHSqdDcm28PxROnbj6XzRnDMdXFXjdb+zZ
         KVa/4UsbbDbMpxnKtuz0s26YFDMTywEC2s+zYvkavE0GbxAWjjqfkUI6UmTXLcFj/XZA
         TQnUfhH8i7Es3f8yDF9nNlIDNJkdaMy+zGm+1ZcHvLuW7ND18qRipymeE61BBdCE408s
         ZAXF9P5OYtGr4x7vs5Fff/BQsRP5bot3hdUbXNASorQLIQD1BEVjbVlp9VDTM93inTb1
         i0GNo4GfEy+ZsfPSZHqEY8+z0Cvm9PcEQvnkNDWJZsoSJpH37nGxykQUH24huGs4dZg0
         pKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225510; x=1769830310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MyGznuXGAu60e1tz5lHjO5zn/zhV1nMJNWbpCAy+Ik=;
        b=aF8yhMbVOHJSMqAoRHY4DSazPSVOCS/JdXPWcU6rr7tUaK6g/7KZDdy9RsUL9yo+Az
         N3/PrQ1twOKqZ8gCGBmjJg8RroGko3xVh8pn0OPOGyHa4Yte4zr2+NwUUUb0xsqBZq0K
         1/G5HGKyO/SHBjsGj7LXtVVq9bj67ZJ6XEas+9NZRylAgWPrdHdMP4V6IOUX0qNxv6SS
         XiF20nlnR3aZQSa/c72258tR6HICgTCR4xQYpdukHf2lsoX87wZVhSG950Usl+ymo3xP
         IKf/oaRm2XJMk/b82ZHA1gCuT90Hfg8+r1J03L5LgvTg28R5cqa31QhetMtkBHaWZHKq
         vLaw==
X-Forwarded-Encrypted: i=1; AJvYcCX2wsdP5+vhrHjRYnfhvevPHK4Degq2NzNZREDA8a72nUn/mzzomES/4na73rhTDHPUBT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9sBISCXfyzS8x96GcP6h7kyyMj4ljTsRt2aAjVQoJJe8vukA
	XWeAJku3N3myyj13iWm7OfmkZOM+XS1bSEE7hru7PCXCEyD92qbX68sI
X-Gm-Gg: AZuq6aLQHEk9AEQ72WNpiqT+ZU0iiZVGTtYNK9Zd3qD4XuS/pfr9PCH6XVnn7BNspOb
	Z1S4obZpnybZTKmxDBMDmazKewHF+1ymwGtA42gn/zV15DazHSy+Lkdv1F8uaE/6/FxsUkvaDOQ
	01aE/F+R8ibjl7z6Aaims+U4ZFcMBAvkJYnaasO+1y7mhVBrY+bKQtpcy32PUe6iXbF+3V/WO/l
	O6zpggnP8Rso8PlKzozyfIL0rh8KF2YLRHYlCFpyiyepQKJzc5NKjNodw2WucTEGN71X2d30Enb
	t/b85QYMpvvJ1PqRB+G3MVl+TJ33nbDFIn1/tnfwhva9F9xX01FbgStQWOfGw6G2XoHBvGnGP2m
	jXwiY1FAVd7/wYJz5RzQt6pbBIat/qj55iq/l5CXD1dtXV60zGjA2zSTgH5tUqEu/o0e9O4OyA3
	ls2UPUY/wG
X-Received: by 2002:a17:903:2442:b0:2a0:f0e5:74eb with SMTP id d9443c01a7336-2a7fe835facmr43215035ad.28.1769225510260;
        Fri, 23 Jan 2026 19:31:50 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:31:49 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 02/13] bpf: use the least significant byte for the nr_args in trampoline
Date: Sat, 24 Jan 2026 11:31:08 +0800
Message-ID: <20260124033119.28682-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, ((u64 *)ctx)[-1] is used to store the nr_args in the trampoline.
However, 1 byte is enough to store such information. Therefore, we use
only the least significant byte of ((u64 *)ctx)[-1] to store the nr_args,
and reserve the rest for other usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v12:
- compute the "delta" for the BPF_FUNC_get_func_arg_cnt case

v11:
- fix the rebase conflict

v10:
- some adjustment to the subject and commit log to make the description
  more precise.

v8:
- fix the missed get_func_arg_cnt
---
 kernel/bpf/verifier.c    | 39 +++++++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  6 +++---
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41bbed6418b5..2081343a848d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23747,19 +23747,21 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
 			} else {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
 			}
-			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
-			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
-			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
-			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[7] = BPF_JMP_A(1);
-			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-			cnt = 9;
+			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_JMP_A(1);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-				insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
-				insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-				insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
-				insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
-				cnt = 6;
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 7;
 			} else {
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 				cnt = 1;
@@ -23808,15 +23811,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
 			} else {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
+			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0e9635bcd783..d466a1503da3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	if ((u64) n >= nr_args)
 		return -EINVAL;
@@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	*value = ((u64 *)ctx)[nr_args];
 	return 0;
@@ -1231,7 +1231,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-1];
+	return ((u64 *)ctx)[-1] & 0xFF;
 }
 
 static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
-- 
2.52.0


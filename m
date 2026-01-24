Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484242580DE
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235642; cv=none; b=NfFDvveMk03xaSfQEMKVVkTMIKV4hY6lSrJzPxATqH20dfZU38IuMkScvo89Jn0yjyMssnn5KIGK8Bn/qb4BsuWNIzE9FmS3I3cOXwaUoVfXVW365NSi3vdo7FE/pSgeTgHO8iCbzJU0lD4gjFgf7YFRr6fG1Jkds+QRQHJ069E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235642; c=relaxed/simple;
	bh=ov0wUqV6kuTWTFBkzZscv2aYec7op/sl0bS8tbqxj1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T95QfRuw+uXmW5KYc7mIGsZvdFyrxrhWQ3KpNEAP6JdER0LMz9TBRcC2gcs5EZR/IYJIQNBZczPUIcDMvUy+TdLZQt7MAdFnPAUU5r4lMa/RTJYWp+E+l6U+HPR4SR5lXlESfP0exBCGQPxFwZ/MGNFd0YewSULuuFacDzVWAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyzdCAzj; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyzdCAzj"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so2017588a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235640; x=1769840440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MyGznuXGAu60e1tz5lHjO5zn/zhV1nMJNWbpCAy+Ik=;
        b=UyzdCAzj0iKtR/p/hphPWxGCi4BL3lBeeYrrpM1Ix8yfVD50FvuuqEFgqJCCYLiwSY
         ENkfU0/Ksl8dup8QhW6Rkb0il1gsMKIymv3vyEk+1aAp1iRy5ENHO+7okLMVpEG2+/P7
         kUH0rFR4q/d/JGqfguqJvUb0nQHJwf0XNE/+wDScWfAHbzTOeWAKX4dBwVS6ECAx8sKj
         sw/VrtjjYXM9hWkOJOcldahOsH9mywf8vPCHwn/sAqCFlOVNChBa7bxCSpd8VOwDKLjc
         jduN3V7a76RDVxQXgFg+AXdhQFR/rD9BckmOHSTZmUQaqXc83oeCUUwAr8pusUYm2LB0
         hZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235640; x=1769840440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MyGznuXGAu60e1tz5lHjO5zn/zhV1nMJNWbpCAy+Ik=;
        b=IzwL3IYSw0Nb6eZo/PFX5Tlr70d+3IwJeKF8hC4Ff9wPy4Q7wGNmIdCHxmMKFYbKRH
         qjyaJhBiv9uAa0czeqAmS64YwskccbW/2lingwy6bzvUpsnrlQlCAbDMebYbKUZV3omE
         9KuXVKrWTHa6XpCJYJk7QLoS5fHPcDztxkh7wNq3mYPyZkCH2Z4BCJTDUy2VMP8Ua9zo
         pvv+Ivva87Nhek7WXEV5k5FCV7hZec0LBbIbTyOvBTZ7MTyxy4GdbF0BYEB/aYnyo/KA
         Rp4fFUFmnPO8iaCq3yutYNZEnKRAhxKXvjPYrunUxjuZwm91mZdsqsuywfrIBLe1b9M3
         2nxw==
X-Forwarded-Encrypted: i=1; AJvYcCWAQuOy5bOVXTkLFWm/glUL5oGpHz7J6gG37lDZBDGx00oiexQrzuN+Yh89AkZLOTEiuT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZzLas2VIiTNukTu6r57aNdtCEw2VhNf+j62ZLtVPbH2Ude4q
	un3HH0M27lP2TgJ2oWfJ/acuxjeuVR9AZG3mukBJ9k73ffQC/u9gPk++
X-Gm-Gg: AZuq6aKHXcX1Q2Gm4Mz9zBowpU+VEceaJrxqVpIiOdkcx6MNyQn1wedDlYl3oWc8AlP
	gJuDiID/aIojo4/6P34ltrVFyLx6KZ0sPZ0JBlG6AXQWQaNZ83ll9D1HUEdqD3Ht+GWnVjSTatJ
	auzPy144zFvW4+rZdaakRjxje0FIwe3BnqgIySXMVXqKR7vMUL+WgToYIVFmp1UXqBEjS3Lva4O
	91SIIytzPZdN6C+nOJvjY/lDZ6luvKUNLLwl8CaeWF2c3bWmIe6oFmOL16JOiUmuf3sI4b3/NBA
	Kq3oFVnEVA3n9wOrtTIDsAgJaIp6S/lpd6sq1sEm90cSvL28lg+l5fis/aEKXMAb4QRABaR9ct8
	ZAnT6AVjZw5VOEVxooJfnSbSyPek8xeVfiUg+a9FPpSwL3/nvvqbYohlTROcBilJXS1bNxnaryP
	wPcBHi/Nol
X-Received: by 2002:a17:90a:e7d2:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-3536700d6d2mr4331296a91.8.1769235639598;
        Fri, 23 Jan 2026 22:20:39 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:20:39 -0800 (PST)
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
Subject: [PATCH bpf-next v13 02/13] bpf: use the least significant byte for the nr_args in trampoline
Date: Sat, 24 Jan 2026 14:19:57 +0800
Message-ID: <20260124062008.8657-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
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


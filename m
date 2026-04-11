Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3F3BED1B
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775948406; cv=none; b=A1X6vWvRHQ+8fF6Cs4Jsf/fzikb7ERWLE9zVdFQ4HgMDaKwcZUWLwkB8Qgh5UqdKokPycUnr85QpfL2Kn1KzhUAQGpyFIcPNvCI4gkeDmt4eR6Y909Q0C9lcvNdDjdn46vt/QI47c4hG0rkOqNejazypqIV3Ck/yV9G7F5go8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775948406; c=relaxed/simple;
	bh=q0oHqCkrkd6HK37r8MEkpwzLWDCnanKL46TLrNr+Cr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkkzG6RQHqRik9UrWgXOfVeESyQCpac8MNV9ImkwolT2Dpka6ohoWQy1/biHAogqMLuP0ZoRix6Nt9Lv6oxNWkkHm2YE59YBYnoMU+vCThqf7LA6UKMAy4vAaN4tyCc/UxYGXkqisI6PIcjudBwMA+qJZ64+grkdPcZU4ILqwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYpOI4AD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYpOI4AD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3591cc98871so1593970a91.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775948404; x=1776553204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GlHA5UW1D9PZO+2mmGUIO4RMm2xI6wLvI86RVX2sKQ=;
        b=LYpOI4ADQU2ySmgTNrAMEwL9yguz4mEG2zTZDLywtXjkgEYECizMq2MHAZGUNTI7Kt
         nCg5ZeLyDqnizosjkS53wH8K9lJP7S88Pzbp0OkXYGOokW1hsJbkeVrr+eGYpWrYaViA
         cqB/Ndlt17BvUD4M4KmXN46Elu920NTD4DyUURqFsx6fUdIxzSBS8vDynjZ9N2TM+Ysv
         Soq+qZONUtRuvqyVtk1Am/9T+WdkszFStiW1z8MdiBKfPJa/ZaAbOryhnyyqTOMxU395
         yKhDEdS5x62vyTss64zqTTsie29ll1oLw44GbpCzgzWH1ARRLXsNuYU4XlMkZjKuDqaB
         kALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775948404; x=1776553204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GlHA5UW1D9PZO+2mmGUIO4RMm2xI6wLvI86RVX2sKQ=;
        b=XQVOTS2RUXE0Xf9yZTTA8AExnvNnoLx9KVSqiKwVX9vsvZIzLJLbxtfygm0sqAv5J3
         jw1Eb6C8iRN2JKuB/ArBThXzZWzgKp0FEA8qMUM4m9pD6K2hZyaCEUDJbXFQzmbJ3L7c
         vL3XGHkuHJd2uhji+Bu/FfqQzDKVx4hBfU3qT5NhqmUrH8AN6je2+aGM8itoR/K9D50S
         vp2EdA2y4NSpHt5rDXvbqNYfVcJwlerGsmYqmGebj/zSkukNw4UFK/kTL8pVqoxXfFYM
         aupGvfmhgvIY4FJT784Ldsk6jaCYEG0Vp07UD8IMmF2vEY93k9qxETdrtRtZB2i5mwId
         b84w==
X-Gm-Message-State: AOJu0YwqPNam1k2gqD02c1pL27IRR6+L4YxtE63iBH1wKFm0AMGKnhcc
	3qh8nL9TGjuaqp1s4lKfdLaX9hhKhXrREWIAS9KosOO6sYsRNm6FLr/b4pcNVQ==
X-Gm-Gg: AeBDiev6Tx0icnLJQHbBpZhe6PODYTyEfE+Gu6iUMNc1K4LRvWPEmTL3F5fFltr0Im9
	G2/nNgCWabl1ZPayyb7SYbLTrOxx/kJXHsbZwM2NMZpxNts+MVoTVqm5pZruDCK5C2uU6rzyuNU
	5UChJoSfxnA5zRXiw9vV6rtO1MIt1t3X485V1X4WmfZy0S2/ML5ToWoL50DHmkEyJwq4PObswDH
	w6WBSkl/LuGCwOjLLwE75dUEDKRAKBGQ7mzWwGpR1l8YA6FtsSW81U0UOIyLKdeEYCYT68hpL89
	xTBxQsowy2Tj/iunTtGB9kTlP/7+Ot7Jx/VezvOkPfXZ1Yr7G6DUqIKI7640q02BMYAWuw/Wluh
	thtlIjdy8HcGOCBzsb/snjZA2kJPhOa/7y74rOvAib12OpeD5iQItc+sUzRhcVtBxaQEivMI3L2
	Vl/PcxpCwh3WF5VzmS+iVY5ZfsJ21UkCb5f/W4slszfM5wTXqT5IUzlrMyjrJrZfUNjqkEGfNaO
	6g0XKomG25cUHtxbvh4PUg6DE/VPwMDreuEcPJV8KMQwhPhxRrRTA==
X-Received: by 2002:a17:90b:1d8a:b0:35e:30bc:96ed with SMTP id 98e67ed59e1d1-35e42781abdmr8497158a91.10.1775948404155;
        Sat, 11 Apr 2026 16:00:04 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db008esm65381635ad.16.2026.04.11.16.00.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 16:00:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next] bpf: Simplify do_check_insn()
Date: Sat, 11 Apr 2026 16:00:01 -0700
Message-ID: <20260411230001.71664-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move env->insn_idx++ to the caller, so that most of
check_*() calls in do_check_insn() tail call into the next helper.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 103 +++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 57 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 974e46f04f18..967e132f2662 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14541,6 +14541,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 }
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
+static int process_bpf_exit_full(struct bpf_verifier_env *env,
+				 bool *do_print_state, bool exception_exit);
 
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
@@ -14921,6 +14923,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
 
+	if (is_bpf_throw_kfunc(insn))
+		return process_bpf_exit_full(env, NULL, true);
+
 	return 0;
 }
 
@@ -21371,7 +21376,8 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 }
 
 enum {
-	PROCESS_BPF_EXIT = 1
+	PROCESS_BPF_EXIT = 1,
+	INSN_IDX_UPDATED = 2,
 };
 
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
@@ -21411,7 +21417,7 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 		*do_print_state = true;
-		return 0;
+		return INSN_IDX_UPDATED;
 	}
 
 	/*
@@ -21521,7 +21527,7 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 			return PTR_ERR(other_branch);
 	}
 	env->insn_idx = env->gotox_tmp_buf->items[n-1];
-	return 0;
+	return INSN_IDX_UPDATED;
 }
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
@@ -21530,49 +21536,40 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
-	if (class == BPF_ALU || class == BPF_ALU64) {
-		err = check_alu_op(env, insn);
-		if (err)
-			return err;
-	} else if (class == BPF_LDX) {
-		bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
+	switch (class) {
+	case BPF_ALU:
+	case BPF_ALU64:
+		return check_alu_op(env, insn);
 
-		err = check_load_mem(env, insn, false, is_ldsx, true, "ldx");
-		if (err)
-			return err;
-	} else if (class == BPF_STX) {
-		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-			err = check_atomic(env, insn);
-			if (err)
-				return err;
-			env->insn_idx++;
-			return 0;
-		}
+	case BPF_LDX:
+		return check_load_mem(env, insn, false,
+				      BPF_MODE(insn->code) == BPF_MEMSX,
+				      true, "ldx");
 
-		err = check_store_reg(env, insn, false);
-		if (err)
-			return err;
-	} else if (class == BPF_ST) {
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC)
+			return check_atomic(env, insn);
+		return check_store_reg(env, insn, false);
+
+	case BPF_ST: {
 		enum bpf_reg_type dst_reg_type;
 
-		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 		if (err)
 			return err;
 
 		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
 
-		/* check that memory (dst_reg + off) is writeable */
 		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
 				       insn->off, BPF_SIZE(insn->code),
 				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
 
-		err = save_aux_ptr_type(env, dst_reg_type, false);
-		if (err)
-			return err;
-	} else if (class == BPF_JMP || class == BPF_JMP32) {
+		return save_aux_ptr_type(env, dst_reg_type, false);
+	}
+	case BPF_JMP:
+	case BPF_JMP32: {
 		u8 opcode = BPF_OP(insn->code);
 
 		env->jmps_processed++;
@@ -21588,19 +21585,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 					return -EINVAL;
 				}
 			}
-			if (insn->src_reg == BPF_PSEUDO_CALL) {
-				err = check_func_call(env, insn, &env->insn_idx);
-			} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-				err = check_kfunc_call(env, insn, &env->insn_idx);
-				if (!err && is_bpf_throw_kfunc(insn))
-					return process_bpf_exit_full(env, do_print_state, true);
-			} else {
-				err = check_helper_call(env, insn, &env->insn_idx);
-			}
-			if (err)
-				return err;
-
 			mark_reg_scratched(env, BPF_REG_0);
+			if (insn->src_reg == BPF_PSEUDO_CALL)
+				return check_func_call(env, insn, &env->insn_idx);
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
+				return check_kfunc_call(env, insn, &env->insn_idx);
+			return check_helper_call(env, insn, &env->insn_idx);
 		} else if (opcode == BPF_JA) {
 			if (BPF_SRC(insn->code) == BPF_X)
 				return check_indirect_jump(env, insn);
@@ -21609,23 +21599,19 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				env->insn_idx += insn->off + 1;
 			else
 				env->insn_idx += insn->imm + 1;
-			return 0;
+			return INSN_IDX_UPDATED;
 		} else if (opcode == BPF_EXIT) {
 			return process_bpf_exit_full(env, do_print_state, false);
-		} else {
-			err = check_cond_jmp_op(env, insn, &env->insn_idx);
-			if (err)
-				return err;
 		}
-	} else if (class == BPF_LD) {
+		return check_cond_jmp_op(env, insn, &env->insn_idx);
+	}
+	case BPF_LD: {
 		u8 mode = BPF_MODE(insn->code);
 
-		if (mode == BPF_ABS || mode == BPF_IND) {
-			err = check_ld_abs(env, insn);
-			if (err)
-				return err;
+		if (mode == BPF_ABS || mode == BPF_IND)
+			return check_ld_abs(env, insn);
 
-		} else if (mode == BPF_IMM) {
+		if (mode == BPF_IMM) {
 			err = check_ld_imm(env, insn);
 			if (err)
 				return err;
@@ -21633,10 +21619,11 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			env->insn_idx++;
 			sanitize_mark_insn_seen(env);
 		}
+		return 0;
 	}
-
-	env->insn_idx++;
-	return 0;
+	}
+	/* all class values are handled above. silence compiler warning */
+	return -EFAULT;
 }
 
 static int do_check(struct bpf_verifier_env *env)
@@ -21780,8 +21767,10 @@ static int do_check(struct bpf_verifier_env *env)
 			return err;
 		} else if (err == PROCESS_BPF_EXIT) {
 			goto process_bpf_exit;
+		} else if (err == INSN_IDX_UPDATED) {
+		} else if (err == 0) {
+			env->insn_idx++;
 		}
-		WARN_ON_ONCE(err);
 
 		if (state->speculative && insn_aux->nospec_result) {
 			/* If we are on a path that performed a jump-op, this
-- 
2.52.0


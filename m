Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C4336896
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813372; cv=none; b=W/TmhppMyTVeKnohMVbuGgQEQ7vVk/WNwOnqdfxLj+RSY2zewk0g9OvToW7zf5wMF+VDtLQR4OLqMzb+7LnvAemf+vxCGwb7Kd0W5ua/lTW3m/b33/DpIA8b3VC4CnmNFP/iHwdNygdDVc3tIk73rq7FOrzQqIVgTAQ3xxXHgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813372; c=relaxed/simple;
	bh=qM33RQVTyYwlNEULxrQoOGm6aquoZBUWSoi7H+M785U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZTvIztoJ5oboe2KA/12w2itttprU0jv8eKYNB2j9vRFoxOHE12ZpO2CAGLAbAPW6UD30c0tjzmCi8kaw+x96kXlv9T6AcEVj0jT12szM6EwYmCmFU7JtvvuPZqBwcQ4qVHd2B9XIP8KxsMp65PVTrgHFBOe35sBMAVO1WG//Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGKqaxUj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGKqaxUj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76ffd06593so1293316a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813370; x=1776418170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=sGKqaxUjVsU6XNFP0PM7qayM24JDFQgXKy82FhgjsuyNDA+P8Oj8q292kh69F7yJcZ
         rwbsL0ndhda+j8KxTncKvclu+s14O02fPZ92UZCVd0jeynZK99kHF3nNE0TBjdkA0u/+
         15QydFbJwB+DjQ0arqu1femSOePnR/sI9eovIL6ifz4YLOY4fCJTopBlm9O0RsosJldU
         JipmLabJuNeY3S1OtdvHai2BRJ/eBpW+CTB9pvW287GxZ4ZPOXMeTtagvPnL9y22dNp0
         +pYPftcKgQTo6RP9kov/uNJ0IvON1Ro7JOd/t1hoZGxvb+9MMfTM++Rf9yGERk+qIwJc
         AtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813370; x=1776418170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=D4jL3n2op58X+Gh81/fZsNH8vlEV0e5CScaKTclj2YO1RCqF8JdESy7ovJ0AtcKEIG
         mwK2XRlCHtQvcPXOKBZRxNxlBwU0y/F7cRxbxeXu0NBm3zHxnrMVWuGuI/qTY12+K5wC
         iWCvZrMFvlp4mwYZawzZ4p14UTwZlBDptC4bL75iUxAbu6xzAqGZ+/Iaq+QXHWrpsSPU
         Z0aPuol+i2xpRC1yhUS1Bf4ywErtVn7B0uy0L1KfRxmZ81mz39Xe6y0Mm22L+xUZi2ND
         l8Ac9Hi2F1fMAJE6OO/sx/RYgGw1lzeNnoKvp/YPbBp9l4myvVmtUFOWrN0duA6HQ8OT
         MkfQ==
X-Gm-Message-State: AOJu0YzbbHUjUevkELoG9lVw8G3V8qZAly8Ygtvd3cKDjqphUCK1XB3F
	9iY/6EnC+4v732YXEPsn/Ki9ksYxxv9pJS6/TSb8yVGWBf/sXIPN7zTIpZYbzLD0
X-Gm-Gg: AeBDiev8RniDlbphJ7qxB433bzYahyu0KHdWD0GfacvOJx43eobGdMKCkfmhd2trlNJ
	FZBmGJDe/vBpiZS94hGTsYe2Dnq/IY9wgx/rCjF6JyGJxyZsWT2UZAXh3KUHUg4P/harYaI7Ixs
	WDtNi5P51XShdLPPPxu8k+7A6e++OMeOKkjuQIjujzy5KhZyUWAPGMAI7FoXADnikC99wzQme93
	dolTLUK9jd9yANgXrbQ5yk2XgbdSBFNk9RmGGfFZuAzM+TmaCQ8sPpqv7lelDjI3F8QWqtyAmNK
	OlOlGdJTzfe/TKhjj9xboNzqRm8XOVhe3T1An4pm+bP4OQmXmgnrWgGdV4Qzh0fCPmB5zQDNb6V
	JG72wWisE4QM+FwSPmHXTkK+7H/DXa5smSyCq1e+r2oyhwe8r9Aj6qfmQUYmtXMMLaNJ1pMSXDz
	Jtx16zoD00EnI2NSGAluHnSMLR+Z2FBCQrqy/3p/Y21hr7GBUn5dtFVNeXkTRfxSRj/5Q=
X-Received: by 2002:a17:903:1d1:b0:2b2:5c31:24bf with SMTP id d9443c01a7336-2b2d59b838cmr27213025ad.19.1775813370287;
        Fri, 10 Apr 2026 02:29:30 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 01/13] bpf: share several utility functions as internal API
Date: Fri, 10 Apr 2026 02:29:05 -0700
Message-ID: <20260410-patch-set-v3-1-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Namely:
- bpf_subprog_is_global
- bpf_vlog_alignment

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/log.c             |  4 ++--
 kernel/bpf/verifier.c        | 10 +++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36bfd96d4563..15f7f9f35be9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1121,12 +1121,14 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			  u32 frameno, bool print_all);
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
+u32 bpf_vlog_alignment(u32 pos);
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
+bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 37d72b052192..f0902ecb7df6 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -847,7 +847,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		mark_verifier_state_clean(env);
 }
 
-static inline u32 vlog_alignment(u32 pos)
+u32 bpf_vlog_alignment(u32 pos)
 {
 	return round_up(max(pos + BPF_LOG_MIN_ALIGNMENT / 2, BPF_LOG_ALIGNMENT),
 			BPF_LOG_MIN_ALIGNMENT) - pos - 1;
@@ -859,7 +859,7 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	if (env->prev_log_pos && env->prev_log_pos == env->log.end_pos) {
 		/* remove new line character */
 		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
-		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
+		verbose(env, "%*c;", bpf_vlog_alignment(env->prev_insn_print_pos), ' ');
 	} else {
 		verbose(env, "%d:", env->insn_idx);
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84699a428077..dd81cfbad680 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -421,7 +421,7 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 	return rec;
 }
 
-static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
+bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
 
@@ -4610,7 +4610,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			if (subprog < 0)
 				return -EFAULT;
 
-			if (subprog_is_global(env, subprog)) {
+			if (bpf_subprog_is_global(env, subprog)) {
 				/* check that jump history doesn't have any
 				 * extra instructions from subprog; the next
 				 * instruction after call to global subprog
@@ -6971,7 +6971,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
+		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -11040,7 +11040,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
-	if (subprog_is_global(env, subprog)) {
+	if (bpf_subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
 
 		if (env->cur_state->active_locks) {
@@ -25186,7 +25186,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 again:
 	new_cnt = 0;
 	for (i = 1; i < env->subprog_cnt; i++) {
-		if (!subprog_is_global(env, i))
+		if (!bpf_subprog_is_global(env, i))
 			continue;
 
 		sub_aux = subprog_aux(env, i);

-- 
2.53.0

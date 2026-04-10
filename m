Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4723A7F4F
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854579; cv=none; b=lT3o1QgOI97CcHtW9VLJbQ61f42OyquiLKxZk4kPfNVIMGGA4tHGF0dvZoEjbrp8EbgR5iJVGG5jzTB+3rwsuRsWfqXUJ08C2NqPkTXY2CkSJQb1cam2eaaZmZxKbhtzujV5gaFe3HbUtGp+ZHBwutIqDDQH67rKf+2fGj95UXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854579; c=relaxed/simple;
	bh=qM33RQVTyYwlNEULxrQoOGm6aquoZBUWSoi7H+M785U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpS66BGsfmwF1Sl5hIcg40j0U0PaYI4anDBNsoTTchUb10ZT9r9UAlNKofSnnTWkoQXuw9F7YvKCafMMCVCMwVD1sfYWe2xIIFPJwUZZQ1lvlbRjjqb8VDkIME+j+qGmshOLKuaFfEQpS47ioFwXDP7Eyti28ree/3+J18WYz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEhp0R4X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEhp0R4X"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so1247132b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854577; x=1776459377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=MEhp0R4X+CcQ72fN2BiJz+qGoMc4U3h8Hgs4G+uT2ORBES2c8gaQKG6yauaph85L8K
         ZELpiKPquwlCenmvrW/+1DIY9V9/5MkMzZSAMstoR8V7CqgkDpOOYyR0YjtEVomPRX/Y
         QzuGbmjSMsWOme9a+UU3JpZdILLJNNoKTsqY7sJw+9jcdubrAMhS1rtosVdB/k1ioYze
         8vGDlqujEnQ/NVTw6aIFprBl7sT5wpCLXrYo1ngWl6iChhO8om9BCYIUlijyrsbLaDL3
         NslaFJxTqm5Mbi2kbp7690WWMVIxTtKWDy6kaoEUV9PUW3jKnvZViQ4GWYWA89pjeDB5
         48zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854577; x=1776459377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=r879Z6DTfTGeYuLVOIYDec4tDf6H8qI/dZmcwfpHNFkzmVEZmT/0fvAF8tPsJQW/ks
         tKlxjnp66Yt5lOLQCFhONALnRkKGHX7ZnrgKiqqWA5MQwIOecudJ8MgYZ1bhpTapvBch
         WT0j4Sm9Pq3rGfGGPsFehy4I90ISJbP8Lbc29aKC4X24gdQ6XWbktWC2lv4z9IAYtNfR
         IoKs4+1s3+7kZA+3CjaIu9wGeCGoWoqU+C/uAAnGg7SV9MzKdkMwKJOMtgODJ00TX/0G
         tu1y+Du77mq17snZQN3+8xLu61IIyQBA+my6utd478L7nMqRz0yp5jnwHOqUw/mJEVUI
         QXlg==
X-Gm-Message-State: AOJu0YwUWw1SGI9yn7ebJFaDUl6Tw8R/3Gs9rYtw3oBn5FeC806WCf6U
	HEEvTXI/ImYjr1/4rVbF7l0KzWnP/jwA9wRpUAERWMRZYIZWmazkup285oSWo/6i
X-Gm-Gg: AeBDievVQHYsCg30An08zQWIaTgWZh0AS76FUfYQzZg9rur2K2oFB1VrIxzeEXv6e47
	RQ050nCXjgCQVvJ6rIm2bvTi8U60D65XzJAGbtOyHLEm/iaAcdcysNwP1d+ADOz2xgSLBui+tM8
	zMnVpNX3wgWV7kmnJUC2ql/z1gqVZbnY928zeXYbGQcQzHkjBEK9zXRdcKJU6X1uYPMYQHNT9q+
	WGEPLmhLsuAXGarchBXIY1h6l68rCw3kYyQUeIiyvcn42+s1CRqBw4N8c4jWZ3lPx3p2KVKA+Ct
	SDZ2VS2X7Vssj9bHG0jtSHzsNl7faXlYV24cuzRJnmr+0vOwFAeYJSrNOu/cT6SHShb1cSceYn/
	Uw0TCLwji7WzAR3CaOexIm00MbnyqFH2r3u9U9b/49WM1GsXdoRNsBJK9gdpcAxgfk6K7CvRy9q
	JJQdYNpNa6LWD8kIZ33eNlRfKGWtOysUNBCRphmhfQQiS1fYQ6VtvFXeB83wst8zER59I=
X-Received: by 2002:a05:6a00:4b0b:b0:82c:9c90:58c9 with SMTP id d2e1a72fcca58-82f0c12f435mr4829369b3a.4.1775854577252;
        Fri, 10 Apr 2026 13:56:17 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/14] bpf: share several utility functions as internal API
Date: Fri, 10 Apr 2026 13:55:52 -0700
Message-ID: <20260410-patch-set-v4-1-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
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

Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1531A046
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783508; cv=none; b=GHzR9HbVzINAug7aUDrEI+61wPUdd3IxTaUJUaI72HaDwLdgElbxqTSnPAg4ERhJZo0NSA7vTnaG9aSRa+nbb+a9aG3VFWKg7fvK1TOpoND3lq4VCSHtVtrmIvgz7fDIEOd/TOV/3Z1p47XQ49mlC/t99+jj9lChXBC59PNuNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783508; c=relaxed/simple;
	bh=qM33RQVTyYwlNEULxrQoOGm6aquoZBUWSoi7H+M785U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy43M9l7VfrT30FOhfMXTXFuSCsnNVGhsasi8/uJ3/658uJOUP01oUJGiBWyI4UM8z5PPOTUkuZhdXePcDsX6+1+8btIL5VykBd94R+BwO/inscRFvffPXyEoPSVfz4zGAG6doolPvkoDsc9ZQ6Bnnry8dfmWdn4ektVH7Htvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQJ1656J; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQJ1656J"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so8717810c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783506; x=1776388306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=WQJ1656JrpDDnOx0j3Il5bn0g3BYjnk65LvzsAOo9g2Y4HFI3Ygz9ARE8BJrICCkt9
         QXVMc7QPV6gQ9bk7sSLm1T8wmEGNprCSRGq5NAX9mVxnfsLxBqgWbESeF9ae7bbpp5Y/
         pdqKgrdpOb9OLsKYKUe3whu5nxORuNe/IOidnZNUf+440PHH/Ao/4hdBMzAkTzmpqxAH
         m2MImpiPFM5dJSVm3glk7FpFiqSYP9GOTHpBlUc0RMJsNFKaUr+BpWxdoZCAUjxEFc9L
         ntZ4dX6NFxGPlaxvKfN09gcLx2UGvijIg3MAb12LO6d6CEWgyIE+aNrgMG3AUTH8cZLV
         LgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783506; x=1776388306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bO+c7VpdFmmGrWPDqAkqP/1wWdV/e+x2p4WHFnQ55XM=;
        b=YccRM2sUlMy04/kacY/apzqe0Ap7pHhuvospjiTNncnwdWHQALUqOyt1RONZZKlt3e
         JpAXxFRMklKI+eoT3M2bsWylz8+jWgops8OP8MDwLrQxioFi8ueB5D1frlhssJAOMg2r
         IzvFieenzHov9Rt/1XA8WIg7Pg8OHCHzroBEhWUYGESa7pCXZxk26OGji8EJKAd4jw2H
         cloFszkZ9C3/gXBKtMO0Za4OQ7TwuhGQW5QJDd95DZ8vH+/scid4S+cX4r6I4kCIgKWe
         SU3pj8QbKFAuXLN4n5N+kWv2dR61riiIVpZ7MKibQfEgzzzDaboEQuKL4ysvaEyNK5ew
         aMnA==
X-Gm-Message-State: AOJu0YyyYlwbB4es/I356xVAVqhtEkSTHp862lf6rCzbjtfLtQNxH8DQ
	1T0mdOOoSkq5KcfO9tWf5cem7D6iyVuhePV/z1l/JLA9Pa46O+TsQsBLxN0DusdB
X-Gm-Gg: AeBDietoDn2ejBibu6AZX8kQ88yj0Acc/vb57ZyROf2wwLD5FSvpeYvpFfxjCIQPTtb
	Qe+3uDGmFRK4QdD+BM5EuxPur9x4rXg6t2p2KmvJSZHUtN2XgjnKScqD3/1yE34tOgTKc1AVXAJ
	G5udgnlNprJ4ueED3nXRGcsNLO+B2RJ9lwsSQk1zBgQCb0+t6sXYhQZZm/qVGD1ugXtSD0W78dI
	rE06wz7y6nmtx5tjU1/6wmCRkWCgXJpfOqmrQoEfSCS6Disv/ptvCzqvQmGaB0ruMzKZgFuhHeV
	vcyRDYac9c94pnEvg/Q/J7Cz1LSuC3iOmdUuY+3LaM4sJ+yDNgB0JXj9OIbJtcDeRaza14FQSe0
	v58cRieTafTbX8ZSQa7JC+qk0mJmeuDoGo7Be4Capm4Zob7l8qxiYbLPcmiedZnlfsu/1V8Gn4k
	yC8gaSAOpTHM14uVYtp2tzERAYwnYPDDDhr/wlwQmiAi5WdkSh9iQ6LXeMRFwsq9Xn3vCBs0uhr
	rQ/0VQ=
X-Received: by 2002:a05:7022:6725:b0:128:d23d:81a7 with SMTP id a92af1059eb24-12c34e68fe3mr734379c88.6.1775783506224;
        Thu, 09 Apr 2026 18:11:46 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 01/13] bpf: share several utility functions as internal API
Date: Thu,  9 Apr 2026 18:11:20 -0700
Message-ID: <20260409-patch-set-v2-1-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
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

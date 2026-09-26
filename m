Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708743CE7C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432453; cv=none; b=bywfLCb362J7+3y0Mbhs4YLhb5Exk19Ph9I4lEUKX7aDk68CVkN3RJskFvdvJwF3gAPWhDomTZTsubtyGaD7zPJ4MLOeXDM8j87t4LEwwRTUKqiko4WSLWmuftMfhjWGs3Fywfn0bJbjJ7Shilnhbdu1YgXlh6Ase47ix7HqmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432453; c=relaxed/simple;
	bh=zkj0WRiz+jaTX8mqR10LA4L5PN2LSsTeH2/4BLjeqso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQisFgByiCBuYg/fP5uAjIwyLLi1mzHDUiMTP9o+cOZGUfTgABNFyF3233mmKUqvngamuYKu9bkBjILE2gyfGe6FAvxMTXNhn+mRFovCfPZ+3gnJhjpugIdaGcLXJ8qfMbedYAYKbaefAsklvjPyXXbdif79fLOidkbqOP4zCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEPE2wFK; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEPE2wFK"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so867688a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432451; x=1791037251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lRsCS2CDA+0h3XQVzmXlEnJ33T2sgIQfoj7BvCF7OA=;
        b=mEPE2wFKVI8TdUKEaAdBq05Ifyrn6WCtCwsUgW1QA7v3pNXp7+she6U5TIDjfcqiTX
         F4W3l1ZxihsZ3n62jZARYb1Wt0Nedl0+5rK8WiDA3THZNZwvrxwI832suM96DLrS4rbc
         jZBk14Ayf7IJsgU25G0nYfk6n8ere/yQHEAYZv+In+gg6piQkjQpw94KH4j+PIzHbVRq
         ci9UW+fQLsh4GJIVTjgb8d18Ogf75zQd/SLXlhH5mUmd8gh51NWpEL5ekjqk63kMQDYT
         eGtZ8nEE4J+iMySVpsvNchykI1OUEQEth57KwyXjfKkJRsOiq5Kmh+qrUFbD0/6lQG2W
         ql5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432451; x=1791037251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lRsCS2CDA+0h3XQVzmXlEnJ33T2sgIQfoj7BvCF7OA=;
        b=XOognWgtOCphBaJmiI97HVnaMn6RI/7xt2UPMyEJd3orToUs7+SBBsuE5WlhNE88bC
         AKyxH7moO7wyajB2vFP5zNBtkAG7X0qIjhwFR/H6ITycC3hmwpg7oHDlqvX7wGWjmGQe
         G/v8bNM5nDOXLCUxEsJZGRSta/eSstXtOc/mJ31ZuzOL94YxxWGcByrEOmgIYFXpDxU0
         0iZFVdHzd71ftN73xKz2nbwOWR+h+hWBL/242afEm/qT+0rOJEAIjfT9vJ6RB7cXhEXR
         7J7rRajbjtDLo2VJ36ZNETyhxUsbt0JOxpWJ7206MmydH12NmIAoQCUQlNrDwpBa81Ly
         KZnA==
X-Gm-Message-State: AFq9FYIF/wlnHagLNWQehFfjyvxdPHGOBnFO0EKeXq/dHKXAKuPpNH0n
	chcqy52LGyHZcdDGv8vq1gZAH6HPdZuzKLdJnmXjB60+GsThVxNIApUKuj3ZNMd8mhQ=
X-Gm-Gg: AYBFou2VXYOskIwnwmECZ2fJ3jm2eFVeY1hIa5nJ7eWYU8dCsXUAT8BkzJaz9MRCJ4V
	y524A4l8fiPxNmF0WzmCdU3LC6MKQSAtm3lWScl6F/oU7VJfE+tdOux+z1bSKPkTuFgkYxTvSVp
	WHGahbtuQKnuDc1uxXe1K8cd+hgncnD9GcFLNyOuilcvsDXjfBeiq/vAodnbt8vxmJ0oNN9KjDb
	RZbK85nWclLkgW3vJxCt9pqjZ27DQFyUSO4poYM+a/AaKSRfUzRviiWB4o77GrcucYi9cqGzhRX
	PklOQgvBZfcCl1KLj8UDOEWseeqVRXj4h5k5hVcD9hTAvt+ejpuDi/th+A9Q2yQ+no4/oWNy/xe
	we+1PQk1++GCAwJMerxZGrYBuA2RZ0qp6yThK4QiUw8u/eYId/dZCkFMEPjCrg4SHg7kbNaczqp
	gsTKnTjn7+9aAnsiw3VdvzQodIe8AwWumNoUlOL+wAJXuo+qZ9yAwIofwGBp1t2gv4jUBxkCNIB
	1hY4q8k2vDKBbQ+ulpxQRelAg7kZ71rBOpL2HPC7g==
X-Received: by 2002:a17:90b:5410:b0:3a0:ac34:f7be with SMTP id 98e67ed59e1d1-3a0ac34fc4dmr5167514a91.4.1790432451386;
        Sat, 26 Sep 2026 07:20:51 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 05/36] bpf: record write effects for atomic operations in liveness.c
Date: Sat, 26 Sep 2026 07:20:03 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-5-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Atomic read-modify-write instructions are recorded as reads only,
omitting their stack write effects from the may_write masks needed
by SCEV.

Record both read and write accesses for atomic RMW operations. Keep
LOAD_ACQ read-only and STORE_REL write-only. Share the precise/imprecise
stack-access dispatch so both accesses use the same address handling.

Fixes: fed53dbcdb61 ("bpf: record arg tracking results in bpf_liveness masks")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 57 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1cce0c7406eb..6b2f1bdbef7f 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1555,9 +1555,10 @@ static int record_stack_access_off(struct func_instance *instance, const struct
  * 'arg' is FP-derived argument to helper/kfunc or load/store that
  * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
  */
-static int record_stack_access(struct bpf_verifier_env *env, struct func_instance *instance,
-			       const struct arg_track *arg,
-			       s64 access_bytes, u32 frame, u32 insn_idx)
+static int record_precise(struct bpf_verifier_env *env,
+			  struct func_instance *instance,
+			  const struct arg_track *arg,
+			  s64 access_bytes, u32 frame, u32 insn_idx)
 {
 	int i, err;
 
@@ -1615,17 +1616,30 @@ static int record_imprecise(struct bpf_verifier_env *env, struct func_instance *
 	return 0;
 }
 
+static int record_stack_access(struct bpf_verifier_env *env,
+			       struct func_instance *instance,
+			       const struct arg_track *ptr,
+			       s64 access_bytes, u32 insn_idx)
+{
+	if (ptr->frame >= 0 && ptr->frame <= instance->depth)
+		return record_precise(env, instance, ptr, access_bytes, ptr->frame, insn_idx);
+	if (ptr->frame == ARG_IMPRECISE)
+		return record_imprecise(env, instance, access_bytes, ptr->mask, insn_idx);
+	/* ARG_NONE: not derived from any frame pointer, skip */
+	return 0;
+}
+
 /* Record load/store access for a given 'at' state of 'insn'. */
 static int record_load_store_access(struct bpf_verifier_env *env,
 				    struct func_instance *instance,
 				    struct arg_track *at, int insn_idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
-	int depth = instance->depth;
 	s32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
 	u8 class = BPF_CLASS(insn->code);
 	struct arg_track resolved, *ptr;
-	int oi;
+	bool rmw = false; /* atomic read-modify-write: both read and write */
+	int oi, err;
 
 	/*
 	 * Stack arg insns use dst_reg/src_reg=BPF_REG_PARAMS(11). Since at[]
@@ -1643,12 +1657,20 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		break;
 	case BPF_STX:
 		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-			if (insn->imm == BPF_STORE_REL)
-				sz = -sz;
-			if (insn->imm == BPF_LOAD_ACQ)
+			switch (insn->imm) {
+			case BPF_LOAD_ACQ:
 				ptr = &at[insn->src_reg];
-			else
+				break;
+			case BPF_STORE_REL:
+				ptr = &at[insn->dst_reg];
+				sz = -sz;
+				break;
+			default:
+				/* ADD/AND/OR/XOR(+FETCH), XCHG, CMPXCHG */
 				ptr = &at[insn->dst_reg];
+				rmw = true;
+				break;
+			}
 		} else {
 			ptr = &at[insn->dst_reg];
 			sz = -sz;
@@ -1675,12 +1697,10 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		ptr = &resolved;
 	}
 
-	if (ptr->frame >= 0 && ptr->frame <= depth)
-		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
-	if (ptr->frame == ARG_IMPRECISE)
-		return record_imprecise(env, instance, sz, ptr->mask, insn_idx);
-	/* ARG_NONE: not derived from any frame pointer, skip */
-	return 0;
+	err = record_stack_access(env, instance, ptr, sz, insn_idx);
+	if (!err && rmw) /* also record the write half */
+		err = record_stack_access(env, instance, ptr, -sz, insn_idx);
+	return err;
 }
 
 static int record_arg_access(struct bpf_verifier_env *env,
@@ -1690,7 +1710,6 @@ static int record_arg_access(struct bpf_verifier_env *env,
 			     int insn_idx)
 {
 	int depth = instance->depth;
-	int frame = at->frame;
 	int err = 0;
 	s64 bytes;
 
@@ -1715,11 +1734,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 	if (bytes == 0)
 		return 0;
 
-	if (frame >= 0 && frame <= depth)
-		err = record_stack_access(env, instance, at, bytes, frame, insn_idx);
-	else if (frame == ARG_IMPRECISE)
-		err = record_imprecise(env, instance, bytes, at->mask, insn_idx);
-	return err;
+	return record_stack_access(env, instance, at, bytes, insn_idx);
 }
 
 /* Record stack access for a given 'at' state of helper/kfunc 'insn' */

-- 
2.55.0

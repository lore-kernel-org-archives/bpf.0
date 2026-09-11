Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08C353A6B
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164268; cv=none; b=kAt9iomYEzpQRxHx4ScrVKnwXFdX8bde17t3Vur6wBdXcYJtI+to86DSK9do8r+VbkRCi6wr2lX32dYFaLF2A7n++XFKAvYJnds+r3on9E5BbGlVlH5jn5q/ePI2DZRxr7kE81DlHwbfGRDpuB+a1Bu+XxdsAmOkiCJjdLpYdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164268; c=relaxed/simple;
	bh=1gJZpqv6luJOn121HNYHW4P66bLKWO/+Q1/G0vsf3jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoAFKvX85h/DXf2VISQXYQIDKcIpejC/NCBSz53GyqGnxBj6QvoFqSapjbKbvA13rRBPw1bpyDCHfVUqESWlIcrlhkmxQTlDW1C38cjPj9yR9QDKIDtPn8yzuAtoCFT2y+38HekI7wp2e+86Wqj9IL+mdLimvoyAs6HdIhtbdXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl4B1Iww; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl4B1Iww"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b1ba286f6bso1521615b6e.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164265; x=1789769065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xso8KbIqUqs6gkkehfAoyJbZk6zCc7hVvliQO2Do/YM=;
        b=Nl4B1IwwngJhJJhVhnVPksH9jFQX4cTS3ByzSIHu20jIuz/5+k0TH762bho7gkUyw5
         OZeexnWiTn5naJJwdCsGutGmnnyXnEPJnMcBLRHGpySBuL4AH7wzMlTUU+PXAUtpEzd/
         WpOn6yfuHySyMZnvRCSaR62JssgQcnicruAvoKWrNWdV3xPfYnxQ1vrNxdtBtYn529IW
         FeZA1qsyVjo4+cX4PzxaBYpLry6/EZXTec1JHfIhsWjF2uyOycDl9Ag6euR3bgcp6Lmq
         +6N1f1OHBedL3udsAKxOJYtEqkaSsS3nyt7F2ATlXbjjGE5jaDcI1F+5+aDMviEkuB/E
         FNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164265; x=1789769065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xso8KbIqUqs6gkkehfAoyJbZk6zCc7hVvliQO2Do/YM=;
        b=fG7gtmB/mWZpHyzxKPfykUcAu53L60oaKwsHQyWnsowyQcIT9UlnmNKz8uo8r2afTf
         gG2QxC7Rgq6BLfu2W45TftMCh8KhXNOD38fpT7pLp8x4lJHM8C5Qt5Yc6rOIfp3zjTbf
         39Lvi7uAB6htJ33liS3wA/wz8na7Lmzmx7Z0E7EqNwTcA+G4O90p7pgYLi4Ac5iW18nj
         CDsakPlOfB5/SPAzjKYXnA/1ygrnRCcqLqGa6W/FIRhGtWvHc0dZctcPSicQVBiWOvRp
         hlAl5YuXOzL0kp6kLZg3KcidmV1IIBPzcn5/lJy+YpHcnwiGdgPfqhrRKXS6gK5j2lNj
         F9Ow==
X-Gm-Message-State: AFuF++mpFBdzkHxAV5WxMCH9izpLJqn3U9VpTpqjEnWA8cPhrzga8Cyt
	gmnrol0KStGlzNrJ9jPYwQZJMCS0QTpsG0nbonxC7NqHHiLvgHGEtufX5jPXuA==
X-Gm-Gg: AYBFou0M6SPeW6JFg/Ar6l/e1IXhF6Ti94dcNPaP8MO7lhPc5WWABPW/nnxmqAYfS0A
	qO3L071LFh/Km1sdnZwIfk89a6uXKLkXOFQLCjt31ELQRUphNankV17XyNhzMHIruIW+n216+aF
	pMAgurZT+oU2Y+eZFPHftXdIwLKXRap/j/maSlFkJ/Yx6AI5mAAtRnRxF9U1yelZADOQQZ3a0KP
	EkbgZyOyJ09CDH5new4Y+fl0RzqTGUws17QYE9KcHW5tZZIsfHiCWj0R4k4IRS6RBlxWcUMLlPP
	qGDvVHM5P1eu6whGFShuCzqc2jRe7cscv6Q5rmGIhlF0Y79NqxFmSnPEY9f62HVwWZAhCl9su2L
	EUOL3Q6gtATlg2Ep//n8fD3JAbfCf0p16StkorNglxQsczuGi0a+9TEjoXsbkdQNK7gVjPIpVXL
	A4JB7ZputB9B90dRBi04s4gHhKfy9YTfrLmMj8e+QDJA6Tvboi6+w0cEhyWSP+xQ==
X-Received: by 2002:a05:6808:5384:b0:496:9ee:e538 with SMTP id 5614622812f47-4c1a57b60bbmr6759587b6e.5.1789164265140;
        Fri, 11 Sep 2026 15:04:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c331bc937bsm3437884b6e.11.2026.09.11.15.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:24 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/23] bpf: Clarify unused and scalar function argument types
Date: Fri, 11 Sep 2026 15:03:57 -0700
Message-ID: <20260911220415.1396439-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_DONTCARE is the zero-valued terminator for the fixed-size
helper argument array rather than an argument whose value is ignored.
Rename it to ARG_UNUSED and stop helper argument iteration explicitly
when it is encountered.

Commit c3fd8e5fd100 ("bpf: Reject non-scalar bpf_loop iteration
counts") introduced ARG_SCALAR for arguments that must be scalars.
Reuse it for integer and enum global subprogram arguments, which already
require SCALAR_VALUE despite being classified as ARG_ANYTHING, and for
exception callback arguments. This leaves ARG_ANYTHING with its legacy
helper behavior of accepting pointers when pointer leaks are allowed.

Also pass ARG_PTR_TO_MEM when checking a global subprogram memory
argument instead of using the prototype terminator as a placeholder.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/btf.c      |  2 +-
 kernel/bpf/verifier.c | 25 ++++++++++++-------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e80963971f68..dcbf8cea45d6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -874,7 +874,7 @@ enum bpf_type_flag {
 
 /* function argument constraints */
 enum bpf_arg_type {
-	ARG_DONTCARE = 0,	/* unused argument in helper function */
+	ARG_UNUSED = 0,		/* unused argument; terminates argument iteration */
 
 	/* the following constraints used to prototype
 	 * bpf_map_lookup/update/delete_elem() functions
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 31057c8f3a7c..122a4101ce94 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8244,7 +8244,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			return -EINVAL;
 		}
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type = ARG_ANYTHING;
+			sub->args[i].arg_type = ARG_SCALAR;
 			continue;
 		}
 		if (!is_global)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 42d89db5df07..5d21bee45805 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8843,9 +8843,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 key_size;
 	int err = 0;
 
-	if (arg_type == ARG_DONTCARE)
-		return 0;
-
 	if (regno >= 0) {
 		err = check_reg_arg(env, regno, SRC_OP);
 		if (err)
@@ -9356,7 +9353,7 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_DONTCARE)
+		if (fn->arg_type[i] == ARG_UNUSED)
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
@@ -9406,7 +9403,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_DONTCARE)
+		if (fn->arg_type[i] == ARG_UNUSED)
 			break;
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
@@ -9429,7 +9426,7 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
-		if (arg_type == ARG_DONTCARE)
+		if (arg_type == ARG_UNUSED)
 			break;
 		if (base_type(arg_type) != ARG_PTR_TO_MEM)
 			continue;
@@ -9447,7 +9444,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
-		if (arg_type == ARG_DONTCARE)
+		if (arg_type == ARG_UNUSED)
 			break;
 		if (arg_type_is_release(arg_type)) {
 			if (meta->release_regno)
@@ -9818,7 +9815,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		struct bpf_subprog_arg_info *arg = &sub->args[i];
 
-		if (arg->arg_type == ARG_ANYTHING) {
+		if (arg->arg_type == ARG_SCALAR) {
 			if (reg->type != SCALAR_VALUE) {
 				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
 				return -EINVAL;
@@ -9842,7 +9839,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
 				return ret;
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
@@ -11029,6 +11026,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	meta.fn = fn;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		if (fn->arg_type[i] == ARG_UNUSED)
+			break;
 		err = check_func_arg(env, i, &meta, insn_idx);
 		if (err)
 			return err;
@@ -12924,7 +12923,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	for (i = 0; i < nargs; i++) {
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		const struct btf_type *t, *ref_t, *resolve_ret;
-		enum bpf_arg_type arg_type = ARG_DONTCARE;
+		enum bpf_arg_type arg_type = ARG_UNUSED;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
@@ -17991,7 +17990,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 		cs->is_void = fn->ret_type == RET_VOID;
 		cs->num_params = 0;
 		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
-			if (fn->arg_type[i] == ARG_DONTCARE)
+			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
 			cs->num_params++;
 		}
@@ -19795,7 +19794,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			}
 
 			/* Also ensure the callback only has a single scalar argument. */
-			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_ANYTHING) {
+			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_SCALAR) {
 				verbose(env, "exception cb only supports single integer argument\n");
 				ret = -EINVAL;
 				goto out;
@@ -19808,7 +19807,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			if (arg->arg_type == ARG_PTR_TO_CTX) {
 				reg->type = PTR_TO_CTX;
 				mark_reg_known_zero(env, regs, i);
-			} else if (arg->arg_type == ARG_ANYTHING) {
+			} else if (arg->arg_type == ARG_SCALAR) {
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
-- 
2.52.0


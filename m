Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933640A945
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164274; cv=none; b=eKZoRc37POnb4AxEjD07qlqf3Px6/sq1BjdDN+s0slLj4wguH9vUiSz6LxIiskTCvHjIX8QDMIOVmB8MheA9dY9QUPazGSMX9mmtBX+SWZHFzisjlh+gTDcwShBK1AZUAYeblpJNCtz6dV6/Nhrfkb46zDL/zGK4qDMugHepoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164274; c=relaxed/simple;
	bh=jweahzAKGEaFeG29engIhXbAWZF0zeQyq00RPCArTvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg89LCOOQBsQuDXS1sxM3m2bKX5/HG8j1EAkSh3ELRretK1cD65G/xjy3nRaZgu5bqYSOFrU8YDsp6FgEPvCWGqMW11Hl5lWXx+V4398zMltx4qYEg5slo7rsXgUSZJWN33Ex7IUdGjB6qzgIzX8iKSzlUsnu+DN8DqbReJsZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWaFZUCc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWaFZUCc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6c1983dfaffso702400eaf.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164269; x=1789769069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoPdn8RRiwrm79WgyoJhgNTlDTnl6whg9DYNWk83jMU=;
        b=LWaFZUCc6ZvS4DmXZ8CiSwaqXwSMivE3B9OVssC78+RfbkAsO2k4bSsbXnYIuHRXTR
         /MYNjxK+k1Ighk0azGUHW3G5m9rZIGg/uHjmGFVSHL9qOwptBtpGyKRx9CqRuX8k/Xj0
         EXgvEZSqJcMyn9hafNXdZJHgRLulkiHOAgyJROfJEywsw/u/ibW9IMrdBi/3O6p4RUsJ
         PtrBruUwQLMCIyHpjGJpP8HY8FguXjlUG/LMznkYsIn2bygKsYOimLIry9lmmA8Ksz8Q
         U/tNgbCNtCJ4cIfaLvYjdKpa+YGN5T5saKbV9Nad6oF4E7SVXkrCBcoibm3lb5AGW9Dp
         JZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164269; x=1789769069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hoPdn8RRiwrm79WgyoJhgNTlDTnl6whg9DYNWk83jMU=;
        b=OozxVjPCVBvsJ7EIWL2VT4LcP/5iiN0bggzzQxynqa+fFSvaLFdu80bdy3P+77eAbk
         YzEcEwall+EkIFfeIN9H46741P7M4zJ+wRGocJ+Kj9wMcRh1c1EcJnWsaNVAc6hCG8AF
         ywebT25xQqQe/gSbmKECGw6pR0VvPf1n9QcuWUVVNas8VCNOLMO7TB3uDogS4OWXN8hO
         sL8ImAiP8PNyr0w0qepzKCfHbj2Q+KDpVKAh6vGcW7esdoCgzSDIDb9OaR5zNpBEtUkm
         o3+2y2a7aujWKuTIsXTz8CvTIo4IMdT3zu7Fu6L9K/f5Ua745Ce7YOYndzzouzQ141ZE
         ZhEw==
X-Gm-Message-State: AFuF++nbTbsGBUiQ3aBMrZKbT+hB6+Jqx7jd0m7jYmFabeyDF33G7If8
	GCI26BG5iEedQKLtvil380Dae/dXU6QTC7ZpjLz1X9B9wmaK7t3NDNdcjgMXPg==
X-Gm-Gg: AYBFou0CBOuQfd03IHpjn+dsP6RLzG2plTBfAD9RjVILoZtFu2q952bCK7x7SOxI+Tc
	+O1H969Ee7++MOT6NknsHGYisPT2JgN5LI5Ot/3Ao+X/+3pODOR/BLfscZlU5h5lnPLpb6ierJa
	SjDSJQf6p3GnIIZnMhA2iDEerN3kNvhpOVlkvxKJxYrOvJqBUbf1SUJTrSA+599PijIaBfQYLH3
	sc95w1QcL1iPU/qHdBYqS351VlK/gn4VZ2qHdPu+K7UcVYn6YGcPd8tGj8O1mkJlQI+BSVf0Xud
	pVCxnAxQFgOA2I/r7QKtzykYw+JPr3WMj8rY82KXUfNT2wHZCLNqoHSCFCKnayMxFiJ4StvN2um
	3UXO6OxX0W6BbCgkVeHnRNrcLsCix+L5EQEasxqc0mzsgoyyLVXZTc/ucAoUNxsZF2gEODuLWZq
	m5OOzPfACFG8kg1p74F01dAjLa+AT4DO9hATl54N9RXB6CIZdhX66/T98bbcBM3w==
X-Received: by 2002:a05:6820:2013:b0:6b1:445d:aaef with SMTP id 006d021491bc7-6c0b9959576mr4620254eaf.2.1789164269247;
        Fri, 11 Sep 2026 15:04:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df96217e3sm2902806fac.15.2026.09.11.15.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/23] bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
Date: Fri, 11 Sep 2026 15:04:00 -0700
Message-ID: <20260911220415.1396439-9-ameryhung@gmail.com>
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

The verifier supplies a bpf_prog_aux argument to both
bpf_timer_set_callback() and kfuncs rather than reading it from the BPF
program. The helper prototype leaves its third argument unused, while
the kfunc path identifies the argument from BTF at every call.

Add ARG_PTR_TO_PROG_AUX, record it in the helper prototype, and classify
the kfunc argument when its prototype is generated. Because other
ignored and implicit arguments are already represented by ARG_IGNORE,
the generated prototype has no internal ARG_UNUSED gaps. Validate in
one place that it contains at most one prog-aux argument and that the
argument is register-passed, as required by the BPF_LD_IMM64 fixup.

Record the argument register in the per-instruction metadata for both
call kinds. Drive the helper fixup from that metadata instead of the
helper ID and its hard-coded R3, matching the existing kfunc fixup.
bpf_call_arg_meta::arg_prog is then no longer needed.

No functional change beyond reporting invalid kfunc signatures when
the call is added rather than when it is verified.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 -
 kernel/bpf/fixups.c          |  5 +--
 kernel/bpf/helpers.c         |  1 +
 kernel/bpf/verifier.c        | 66 +++++++++++++++++++++++++-----------
 5 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54af5562ec95..aa4d3bb5e8cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -923,6 +923,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
 	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
 	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
+	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
 	ARG_IGNORE,		/* argument the verifier does not check at all */
 	__BPF_ARG_TYPE_MAX,
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6b973b94ee75..1e7593e8d5c5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1599,7 +1599,6 @@ struct bpf_call_arg_meta {
 	struct btf *arg_btf;
 	u32 arg_btf_id;
 	bool arg_owning_ref;
-	bool arg_prog;
 
 	struct {
 		struct btf_field *field;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fcf68cfb91e9..2add8001c3ec 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2020,7 +2020,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (insn->imm == BPF_FUNC_timer_set_callback) {
+		aux = &env->insn_aux_data[i + delta];
+		if (aux->arg_prog) {
 			/* The verifier will process callback_fn as many times as necessary
 			 * with different maps and the register states prepared by
 			 * set_timer_callback_state will be accurate.
@@ -2035,7 +2036,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 *     bpf_timer_set_callback-ed will return -EINVAL.
 			 */
 			struct bpf_insn ld_addrs[2] = {
-				BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
+				BPF_LD_IMM64(aux->arg_prog, (long)prog->aux),
 			};
 
 			insn_buf[0] = ld_addrs[0];
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..051b6654e57c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1510,6 +1510,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_TIMER,
 	.arg2_type	= ARG_PTR_TO_FUNC,
+	.arg3_type	= ARG_PTR_TO_PROG_AUX,
 };
 
 static bool defer_timer_wq_op(void)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09e96d04801d..c7822addfc64 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8783,6 +8783,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 }
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
 
 static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, struct bpf_call_arg_meta *meta)
@@ -8838,6 +8839,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 key_size;
 	int err = 0;
 
+	if (arg_type == ARG_PTR_TO_PROG_AUX) {
+		cur_aux(env)->arg_prog = regno;
+		return 0;
+	}
+
 	if (arg_type == ARG_IGNORE)
 		return 0;
 
@@ -9454,9 +9460,42 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
+static bool check_arg_prog_aux(struct bpf_verifier_env *env,
+			       const struct bpf_func_proto *proto)
+{
+	bool seen = false;
+	argno_t argno;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(proto->arg_type); i++) {
+		if (proto->arg_type[i] == ARG_UNUSED)
+			break;
+		if (proto->arg_type[i] != ARG_PTR_TO_PROG_AUX)
+			continue;
+
+		if (seen) {
+			verifier_bug(env, "Only 1 prog->aux argument supported");
+			return false;
+		}
+
+		argno = argno_from_arg(i + 1);
+		if (reg_from_argno(argno) < 0) {
+			verbose(env, "%s prog->aux cannot be a stack argument\n",
+				reg_arg_name(env, argno));
+			return false;
+		}
+
+		seen = true;
+	}
+
+	return true;
+}
+
+static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_proto *fn,
+			    struct bpf_call_arg_meta *meta)
 {
-	return check_raw_mode_ok(fn, meta) &&
+	return check_arg_prog_aux(env, fn) &&
+	       check_raw_mode_ok(fn, meta) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -10999,7 +11038,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	memset(&meta, 0, sizeof(meta));
 
-	err = check_func_proto(fn, &meta);
+	err = check_func_proto(env, fn, &meta);
 	if (err) {
 		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
 		return err;
@@ -12143,6 +12182,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	const char *ref_tname = NULL;
 	int arg_type;
 
+	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
+		return ARG_PTR_TO_PROG_AUX;
+
 	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
 		return ARG_IGNORE;
 
@@ -12293,9 +12335,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		if (is_kfunc_arg_prog_aux(meta->btf, &args[i]))
-			continue;
-
 		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
 		if (arg_type < 0)
 			return arg_type;
@@ -12303,7 +12342,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		proto->arg_type[i] = arg_type;
 	}
 
-	return 0;
+	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12898,18 +12937,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		u32 ref_id = args[i].type, type_size;
 
-		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
-			/* Reject repeated use bpf_prog_aux */
-			if (meta->arg_prog) {
-				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
-				return -EFAULT;
-			}
-			if (regno < 0) {
-				verbose(env, "%s prog->aux cannot be a stack argument\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-			meta->arg_prog = true;
+		if (arg_type == ARG_PTR_TO_PROG_AUX) {
 			cur_aux(env)->arg_prog = regno;
 			continue;
 		}
-- 
2.52.0


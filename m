Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06D2D2487
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645693; cv=none; b=R+Scb+5kvykUCDyesvA+VtsODU0W+VaSBIbe6LweM3jsEyQngT2tTugsVK3ui8X8UZAhEadLfFZdM2lHBNZfmuFxRx07Ko3N1aK/YH3NXy0fMygnxl0LS8+I20ZHWvCZgi/R4x8Y5J0+QUOZxE2Wxgs+sWzqPVaXLWDBMnr305g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645693; c=relaxed/simple;
	bh=ko+ALhQsD5CWtPMhMjH9sfEkhpYU2vSHT8c9lrS1g0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqFYn3+e71g3k8uoEDQPl+rRgCcNsLhcqZxX/6QOHOJYSIjr5AGXo6KwhEiq3XrM5ztWzOOQaVeMjzjd1+wScy+FlJNxMDS5nxIu8kp1qo1Vh+IVaR68pk7U9MrspRHgvaE0GBQ/EVp3FfqVduGOPaK3CTrM08RS+xF76Htp7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQuAHlFB; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQuAHlFB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so1476079a34.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645690; x=1789250490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgTtdG5CF0F1DCxJR6KLEMkzq8ohBxrkv6FnUaYnQZk=;
        b=lQuAHlFB5OhlAs7DmQs5vMeO6l4cHzuPN0n3xSGs71unOhIc94T8AXe/4V8PLYzhSZ
         uoiM0DLfaBb/gCQ7BNWawgvxKcAMMkKraxSoLxA4yfFGaAwckt3aWOOva6J4V6wNTzzc
         WjOBuOvP4yLgADfB87YbRceHlJTk51tAxTGc7sgufVT8MiWMwLapyh+UZV8RmNz94YK/
         HAr+lLkrRc3QbqKS9GJmZ27jlSLk1Eu54EZ8XnOYG9blHSRtrdpY2mSvrPm9YBbaRnWB
         ClttVEHy7xAitA7xpSbVMZb4/qmRpwig8IINJ0psqUG+ssftqUSbFTsfbHji0/acCrdO
         ppkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645690; x=1789250490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgTtdG5CF0F1DCxJR6KLEMkzq8ohBxrkv6FnUaYnQZk=;
        b=hJhrc1o+X0bAwwfbeRQmDs21z8wLP7IBlK/6AQLdekSe8yF0W5mJCItdT5yvmJgAMx
         Dpzxu9PWtEvgO+kAM+xOx4ypJEVDtWmZHMzluwkCM2eLr2RmG1T68ep/XSiudIsXwLpa
         SUaFMbWazf6weBL1Vd/TlopKaJ6oVDzjtb4BCWTSMqWVAukFfDBG2zJ1aGCDksGBgMcJ
         zeo5F7/s3N5CASN6YRtDpBIrRP7UM1Ldlc1A9cweY3QFQSv6nKyDlmB4BCprXKAbBJQz
         ShqqpsbiiH+vMEf32eQ0QrHfyr+HOXPELcDXSu/RRF1+5a9+N29BXAq/gecuRkdJY7mw
         daMg==
X-Gm-Message-State: AFuF++kmZOfaTLZ8EWGmS85OL8MgcVQYD05GZ2GAWjEjzrEGMr7comci
	h9KH+XlHDBLK9EpVlCHLy/1xcKEnoRfMTVN9hEI6Mjm2sxOeLFzW9l8bnKAdZg==
X-Gm-Gg: AYBFou1udiaa2sguujQoQI/foJ4gYTTwfsYcXZrf3PuwtEPwXbj/0Veu33snUHCN+OZ
	mguW+8m96l7w5+AKGD7UNAQDJmjAcYh7XqS6sAK0WqW9fMAHHb4bPIKBBwi6jf5NJ+BujuY0MpA
	XfYuFoosC1X6BzjwSnc4j7SLaHP0Q8cdgQcqulfxmvXqBZ/E9v1Tc1vM1aksKgJeNCSpI49NLTb
	Tcw6cHh6H1LL8Xy1ouP5Q1rsUY5687KRiSYvcbwC63h6samuCOnDA384An58QoLqQSPG6adRFTW
	o7+rZRnR2kydLZ7bcb6BjmpYDZGSttAAD6r3KzzA92T9tqjXtyGvolw88bQaIcMpvEBIgnH0jaS
	wA9utCDbI5hgZUY6WDfZ7LFwBd0KXFyuAtpIu+NmJDbHFyCMHHBCcilm8Y0hT4b0VSv8d4BGr6b
	j5Zu2VMDL9fPHX2i9k9BhtQqzpFKsr+hZoKU6g4Xe98cGsEjJue9k=
X-Received: by 2002:a05:6820:4b94:b0:6b1:a5c7:58ff with SMTP id 006d021491bc7-6b6fcdcfd63mr9216155eaf.26.1788645690261;
        Sat, 05 Sep 2026 15:01:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc6f6996acsm1597497a34.4.2026.09.05.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/22] bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
Date: Sat,  5 Sep 2026 15:01:02 -0700
Message-ID: <20260905220117.922028-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
the kfunc argument when its prototype is generated. Validate in one
place that a prototype contains at most one such argument and that it
is register-passed, as required by the BPF_LD_IMM64 fixup.

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
 kernel/bpf/verifier.c        | 67 ++++++++++++++++++++++++++----------
 5 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f620920ea575..547703f54a89 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -922,6 +922,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
 	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
 	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
+	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a3c44ab06a1..e919e308f272 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1585,7 +1585,6 @@ struct bpf_call_arg_meta {
 	struct btf *arg_btf;
 	u32 arg_btf_id;
 	bool arg_owning_ref;
-	bool arg_prog;
 
 	struct {
 		struct btf_field *field;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 73fb3ffc18e3..9512f6497d32 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2015,7 +2015,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (insn->imm == BPF_FUNC_timer_set_callback) {
+		aux = &env->insn_aux_data[i + delta];
+		if (aux->arg_prog) {
 			/* The verifier will process callback_fn as many times as necessary
 			 * with different maps and the register states prepared by
 			 * set_timer_callback_state will be accurate.
@@ -2030,7 +2031,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 *     bpf_timer_set_callback-ed will return -EINVAL.
 			 */
 			struct bpf_insn ld_addrs[2] = {
-				BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
+				BPF_LD_IMM64(aux->arg_prog, (long)prog->aux),
 			};
 
 			insn_buf[0] = ld_addrs[0];
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 72bfd8f93ae4..1b731aad54da 100644
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
index a0a74a5e23be..22f5aff76b40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8737,6 +8737,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 }
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
 
 static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, struct bpf_call_arg_meta *meta)
@@ -8792,6 +8793,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 key_size;
 	int err = 0;
 
+	if (arg_type == ARG_PTR_TO_PROG_AUX) {
+		cur_aux(env)->arg_prog = regno;
+		return 0;
+	}
+
 	err = check_reg_arg(env, regno, SRC_OP);
 	if (err)
 		return err;
@@ -9400,9 +9406,42 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
+static bool check_arg_prog_aux(struct bpf_verifier_env *env,
+			       const struct bpf_func_proto *proto)
 {
-	return check_raw_mode_ok(fn, meta) &&
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
+{
+	return check_arg_prog_aux(env, fn) &&
+	       check_raw_mode_ok(fn, meta) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -10916,7 +10955,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	memset(&meta, 0, sizeof(meta));
 
-	err = check_func_proto(fn, &meta);
+	err = check_func_proto(env, fn, &meta);
 	if (err) {
 		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
 		return err;
@@ -12044,6 +12083,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	const char *ref_tname = NULL;
 	int arg_type;
 
+	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
+		return ARG_PTR_TO_PROG_AUX;
+
 	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
 
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
@@ -12192,9 +12234,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
-		    is_kfunc_arg_ignore(btf, &args[i]) ||
-		    is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
 			continue;
 
 		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
@@ -12204,7 +12244,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		proto->arg_type[i] = arg_type;
 	}
 
-	return 0;
+	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12799,18 +12839,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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


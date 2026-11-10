Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328183;
	b=ROd9y0XgqGOc+OLzVtfjWkAtYEn02aKt4EHkBv17ji/oq5xURi6sa5QwulTaRKn5fB8C
	 HYB5WpVz7aVzwbFtgpuT5V2KbF5iTICBI0FfGwkGThnwy3+0SgkUqmgku2dPQVv9LuZ7X
	 hYuddM/cgkxUGC9gp7G7/ce0LFihMxoTCdKQlnTt2YO9CYGLa+rOyDlqyeXZV5BQsVIzJ
	 XUiYtmorr25G9DrIcYH+nB4s/QkonbHAwjTvyZw0FzJcE0RF7j5V45FoAHTYCR1iZVvb5
	 H37H1+ieKVRj0mz3Ts6ssNQoKlqXsJUHkwk5qKAZEMB6hcU+L0h+5lw4shva/hZr08A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E2htPxxd8pYq/nTTU1mdsyHbWPS+910mvX1mi64lIOY=;
	b=nCOVJTxTZm6XiTAr15jXFcKFtjpr6JzZtJ4sSVR2LAO4G9T29ybFWZNpCd3RebrBTSak
	 jooSNM+2eICZSgKZvh5E8odUjF920CL5cJSVI4UhUuR9eni/MznZ0kk78DnbwqbcsSmhC
	 jQVteeQuhVDqkn0FtpkycIZR9Wi/p+4WqXzHX2wtY8/jt7VGbAdr8aUsd7VjLTdFPOqV/
	 /gB5GRTuQvCXUT8mlmOvIBiwmq37bdmCA21uP0nnShdYeV9E6FLsGvi7hyzaIA/upqF3L
	 HZhyq0dOFUIAtxv5Kbxe/ToFwLjbxAl9zD9s5tO+7bhlHOiOMn2bHiSQsh6J/aCI4DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpmHXDSN;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9E60A6F5B
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC9E60A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpmHXDSN
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso24127695e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328182; x=1794932982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2htPxxd8pYq/nTTU1mdsyHbWPS+910mvX1mi64lIOY=;
        b=dpmHXDSNure72iJRjjsHIf3Y4OAT5yRr1U+uTno5o6rymxxvaW9NKVO1LnLknTtqTN
         Z9bYKwACqzhDR0RwohdsUvO0TN3FuQt4iyVlmNyEP8+Zw4K1n6cS3TAhYrUT9AHYpx6a
         /VD4QPx92Mh3mGVcO4fJI1p8jKzePHC0MC8BIBYrw6lVEkiR9Lh7liLuOetD81C85ePF
         xcKLcTJgBEvqhieAiaStxaJi8NLwBaPR21uo1aGvbO6AFuFRchp4DzCi7uhsO4xm2ZnU
         BfkmVPRy/3Y2EjRo7EeeDroTW2fh2DM86jsm9IY0w9u2TYelLhQLstj5ocukb9zgepQE
         x4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328182; x=1794932982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2htPxxd8pYq/nTTU1mdsyHbWPS+910mvX1mi64lIOY=;
        b=B76e9dpUo9PxyEGDjVJJjYpHoCpPRHUQ0//zA8d0DPrF+2aSkauymW3mA/l8wcemvZ
         8yxKU8TjK0T6MBQiC3zYhZMx3gz2HvoBPoacv3OHx37WYr9/lnLGksRrkiA8SKT2A4Cn
         bkEOskMiqCFs8Qtujj+ukBfu8/61B3DOrEG8yfpfLyLYC3vmX6LfX/Xec0SA0hFx9us7
         zkjr7wanS9mKabFmCcS1QcT0UYiA9ptviIxKEktfCl6O8T4VQKm66DIdgg+LLQQDTiVO
         +flrrEXlTY9r+KGiXz/33v0WEODUDuQww3Hz6+sCWsLh0Pz67JgbZujV1l2H8eqOcYFu
         lsxw==
X-Forwarded-Encrypted: i=1; AL+hErFsZ2o42j0XgUMDPLLuiOerya8WMME4ZzQ2UVAOsQLzoFHwjA20GhKDGylOCPZnY4Ineqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mmb6JIP8oIM4MhqCArSvTOnhSsF82ew/9gvvuvdhTxX3t3NAc
	q3oxlbBu5RsBZdfDnLdP8ZMnqn3jZy7MsO5x26whmxR1IOGHymYJOBKs
X-Gm-Gg: AYBFou2gTuP+u6mGeFqZWqRtvsrIiL/QqGuihcLy3468VCrxm2uOdlxOoWUd/SShAxU
	zkbSWStQcV++Dgcg3JnuKt/k5+ynqPwM6wCULpduzSuL4KVyLHYbcTCZ1jMv2E7f7w7CPLtKe4v
	ZeEbnCxAsDoJ1JkZDIM+6HnPxgaUuZLz9i2zjufc9XJPX4g+Am1Hkp5U4VzbbbAr7WRBtSMoFQ7
	MPwh/dYVYr6Xvzmuhre2/ktYeTYr1L8pG6WDsBM01NYHLMZQwCaJ1/g8Yz1Ohl0u1pNx/x4RrKz
	8Ntrv2woEWRKCXBEf0OjM6zeHSSjfprebXRbz8iussy5/M1S83Za+vUMLLIEMmwJCwXhBCLefxs
	VNtMaFILQnh0EkzBQvfa4wmTjC80LS6J7x+2ECr5XL4bpRtt9+uchVK4hzY/pn2ZNEcjtpC399v
	bEamlxUp4aLd2rLKDU5rzHNjFE2DJBbcWzrYp8fQJY8AVH4Ygrl5RxRZKCdonjrd9ZrHXQc5YVe
	mElzp4n8q6qDF1vMsrtrrEaNLEF7e6GROqNW1DNX2X74huy83hbafpa5rf+U/WkYgC0y+UIugET
	uxkdWmdKYuSgpHf/8P8BnUyQ8bkPka5O+cq4IRbiBOkJFjk=
X-Received: by 2002:a05:600c:4e41:b0:4a3:7344:13b5 with SMTP id 5b1f17b1804b1-4ba023477admr52973575e9.16.1794328181747;
        Tue, 10 Nov 2026 08:29:41 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:41 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 13/18] bpf: Check the return values of fmod_ret programs on found targets
Date: Tue, 10 Nov 2026 16:40:33 +0000
Message-ID: <20261110164046.454431-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later patch lets resolve_btfids make the functions found by bpf_scan_ir
fmod_ret targets. Each of them gets a "bpf_fmodret_retval:" decl tag with
the values it returns on paths without side effects, for example
"bpf_fmodret_retval:-22,-12". Returning such a value instead of calling
the function looks to the callers like a real failure.

Read the tag when an fmod_ret program is loaded and check at every exit
that the program returns 0 or one of these values.

A function which the static rules allow keeps today's behaviour. So do
the functions declared in BTF_FMODRET sets, which have no such tag.

Only a kernel function has such a tag, so do not look for it when the
target is a BPF program. Remember the values in the program, and do not
let an extension replace an fmod_ret program with restricted return
values: it could return any value. Check this at load and when an
extension is attached to another program later. Do not allow tail calls
in such a program either: the program it jumps to returns for it, and a
program array does not check the values it may return.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   |   6 ++
 kernel/bpf/syscall.c  |   1 +
 kernel/bpf/verifier.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..56a5e4b9f138 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1969,6 +1969,12 @@ struct bpf_prog_aux {
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
+	/*
+	 * The values which an fmod_ret program may return besides 0, from the
+	 * "bpf_fmodret_retval:" tag of its target, or NULL
+	 */
+	s64 *fmodret_retvals;
+	u32 fmodret_retval_cnt;
 	struct bpf_prog **func;
 	struct bpf_prog_aux *main_prog_aux;
 	/* main prog: there when the prog has timed may_goto */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..0a78f66a1622 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2490,6 +2490,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	module_put(prog->aux->mod);
 	kfree(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
+	kfree(prog->aux->fmodret_retvals);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff574c..b12b57c7403e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13561,6 +13561,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (func_id == BPF_FUNC_tail_call) {
+		/*
+		 * The program which a tail call jumps to returns for this one,
+		 * and a program array does not check the values it may return.
+		 */
+		if (env->prog->aux->fmodret_retvals) {
+			verbose(env, "tail calls are not allowed in fmod_ret programs with restricted return values\n");
+			return -EINVAL;
+		}
 		if (env->cur_state->curframe) {
 			struct bpf_verifier_state *branch;
 
@@ -20260,6 +20268,75 @@ static bool program_returns_void(struct bpf_verifier_env *env)
 	return false;
 }
 
+/*
+ * A function which the build found by analysing its code has a
+ * "bpf_fmodret_retval:" decl tag with the values it returns on paths without
+ * side effects, for example "bpf_fmodret_retval:-22,-12". See the comment at
+ * the top of tools/bpf/resolve_btfids/main.c. An fmod_ret program attached to
+ * it may return only these values, or 0 to call the function.
+ */
+#define BTF_FMODRET_RETVAL_TAG "bpf_fmodret_retval:"
+
+/* Parse the next value of the list at *LIST and move *LIST past it */
+static int fmodret_retval_next(const char **list, s64 *value)
+{
+	const char *end = strchrnul(*list, ',');
+	size_t len = end - *list;
+	char buf[24];
+
+	if (!len || len >= sizeof(buf) || (*end && !end[1]))
+		return -EINVAL;
+	memcpy(buf, *list, len);
+	buf[len] = 0;
+	*list = *end ? end + 1 : end;
+	return kstrtos64(buf, 10, value);
+}
+
+static bool fmodret_retval_allowed(const struct bpf_prog_aux *aux, u64 value)
+{
+	const struct btf_type *t;
+	u32 i;
+
+	/* "w0 = -22" zero-extends, the caller of an int function sees -22 */
+	t = btf_type_skip_modifiers(aux->attach_btf, aux->attach_func_proto->type, NULL);
+	if (t->size == 4 && !upper_32_bits(value))
+		value = (s32)value;
+	if (!value)
+		return true;
+	for (i = 0; i < aux->fmodret_retval_cnt; i++) {
+		if (aux->fmodret_retvals[i] == (s64)value)
+			return true;
+	}
+	return false;
+}
+
+/* The program must return 0 or one of the values of the tag */
+static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
+				const char *exit_ctx, const char *reg_name)
+{
+	const struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	s64 v;
+	u32 i;
+
+	if (reg->type != SCALAR_VALUE) {
+		verbose(env, "%s the register %s is not a known value (%s)\n",
+			exit_ctx, reg_name, reg_type_str(env, reg->type));
+		return -EINVAL;
+	}
+
+	for (v = reg_smin(reg); v <= reg_smax(reg); v++) {
+		if (!fmodret_retval_allowed(aux, v)) {
+			verbose(env, "%s the register %s should be 0 or one of", exit_ctx, reg_name);
+			for (i = 0; i < aux->fmodret_retval_cnt; i++)
+				verbose(env, "%s%lld", i ? "," : " ", aux->fmodret_retvals[i]);
+			verbose(env, "\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -20316,6 +20393,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
 		enforce_attach_type_range = tnum_range(2, 3);
 
+	if (env->prog->aux->fmodret_retvals)
+		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+
 	if (!return_retval_range(env, &range))
 		return 0;
 
@@ -23759,6 +23839,58 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 
 #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
 
+/*
+ * Programs attached to a function found by the analysis may return only the
+ * values of its "bpf_fmodret_retval:" tag. A function which the static rules
+ * allow stays unrestricted.
+ */
+static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_id,
+			       unsigned long addr, const char *tname)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	const struct btf *btf = aux->attach_btf;
+	const struct btf_type *t = btf_type_by_id(btf, btf_id);
+	s64 *retvals = NULL;
+	const char *values, *list;
+	u32 cnt, size = 0;
+	s64 v;
+
+	if (!check_attach_modify_return(addr, tname))
+		return 0;
+	values = btf_find_decl_tag_value(btf, t, -1, BTF_FMODRET_RETVAL_TAG);
+	if (IS_ERR(values))
+		return PTR_ERR(values) == -ENOENT ? 0 : PTR_ERR(values);
+
+	t = btf_type_by_id(btf, t->type);
+	t = t ? btf_type_skip_modifiers(btf, t->type, NULL) : NULL;
+	if (t && (btf_type_is_int(t) || btf_is_any_enum(t)))
+		size = t->size;
+	if (size != 4 && size != 8)
+		goto invalid;
+
+	for (list = values, cnt = 1; *list; list++)
+		cnt += *list == ',';
+	retvals = kmalloc_array(cnt, sizeof(*retvals), GFP_KERNEL_ACCOUNT);
+	if (!retvals)
+		return -ENOMEM;
+	for (list = values, cnt = 0; *list;) {
+		if (fmodret_retval_next(&list, &v) || v >= 0 || (size == 4 && v < S32_MIN))
+			goto invalid;
+		retvals[cnt++] = v;
+	}
+	if (!cnt)
+		goto invalid;
+
+	aux->fmodret_retvals = retvals;
+	aux->fmodret_retval_cnt = cnt;
+	return 0;
+
+invalid:
+	kfree(retvals);
+	verbose(env, "invalid %s%s tag of %s()\n", BTF_FMODRET_RETVAL_TAG, values, tname);
+	return -EINVAL;
+}
+
 static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
 {
 	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
@@ -24173,6 +24305,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
+		/*
+		 * An extension could return any value for an fmod_ret program
+		 * whose return values are restricted. This is also checked when
+		 * an extension is attached to another program than at load.
+		 */
+		if (prog_extension && tgt_prog->aux->fmodret_retvals) {
+			bpf_log(log, "Cannot extend an fmod_ret program with restricted return values\n");
+			return -EINVAL;
+		}
 	} else {
 		if (prog_extension) {
 			bpf_log(log, "Cannot replace kernel functions\n");
@@ -24552,6 +24693,13 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	/* Only a kernel function has a "bpf_fmodret_retval:" tag */
+	if (prog->expected_attach_type == BPF_MODIFY_RETURN && !tgt_prog) {
+		ret = fmodret_retval_init(env, btf_id, tgt_info.tgt_addr, tgt_info.tgt_name);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * We don't get trampoline for tracing_multi programs at this point,
 	 * it's done when tracing_multi link is created.
-- 
2.43.0


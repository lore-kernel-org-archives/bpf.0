Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998337;
	b=xL2saF87+Zr0gZtqEnm6xFboz3uEEMVVgwflOdkWmdE462JxX+uO71PTY7tcMwiJ9w3T
	 iiqTrpdO1hKWfCTRbF3m+1PFpZDd0cr10ZW8PjGHST2Eoq8TI9jez+xilcxK9HMLhBhfr
	 iA/ajyMjQm7feAW+Sr2yPkF+P1g3s3n4ymUvudZirabflFJsGxmfQLfQpO6NeRK+4vePI
	 Z+AzJBNOFgF/Rdn44SS/rleOLvqNL4Vex1h9h+p8X6KGK1S3Sa9EtNRsuvA9G3/bFj1w7
	 hn5kwYmX7D0pfL/pIR+VXohuK4lbIwmjnuaXSCq14OwdAyf+t+5OR0j+lKPPotymtKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BSQmYSj7ASxOoDycCnlWcf5b/d2VgwavVPobGw9DT/I=;
	b=EhXhRFsKMpAVDjrN7/cGPFeTatCkQFPDJwKMmhWGvqJjbKdPSAaKLvN6gbNs03Gg0X1i
	 kohjFU9WSskox48YeRMlHh3lVLa+ohjb+QgcglwHEu6cA2HE5P9WJJ0S7VwSmmies0C5h
	 QhUV2Dh/vBUpNy/Jjl7zgMHzxmEEgyt3vFS7XaaiBDEeUgarSYIbXaVG5qWrtK+3I4IXD
	 vf+4AjZOkHYm3GYIxRkSyL6SJ8NwW9pM7h0jk7NtA31mNBdpOIG0GjOpUEVCXB/O2doab
	 XorRyKauT7te6hU/hJbN35zMeeQtR/fQUicyVlg2fGAP+4jGoO6WcI7AbtVLOHFN9CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r0o5Fivu;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CE606EEB4
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C7CE606EEB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r0o5Fivu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a215e64962so12453565e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998335; x=1794603135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BSQmYSj7ASxOoDycCnlWcf5b/d2VgwavVPobGw9DT/I=;
        b=r0o5FivuOBbRNSBaLuN+M5IlG8cmSnTkuKxppCmc5tyXsxaRalK2kJmwnDSAVr0NRp
         KKRTPcJZ30LMsbkFyKq9Q5vuYCyalMIoSUI02XsbZpSPYbjlSWxCvdJuCfQSsnARYKP1
         j5+h3XmgT5OU9IthA+qWsy3JfXm0SUdFcEvASUsb2wwgsSW170MVRlisA0X8qyEfIR4J
         DkdWK7kjptQi3cSySnyl437h8M2JrhC6W9bVJzD+HbwxmHPaUANpFlLxnRqrLGL7rwVF
         XFqxaa0/l3p1CXYllaMBYIwl5N6ARDkcSH/4Oxs0wuAskM3f4b+kaZRnNYgpruLO+fOz
         iugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998335; x=1794603135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BSQmYSj7ASxOoDycCnlWcf5b/d2VgwavVPobGw9DT/I=;
        b=aIXBlAjAjazeFb/sIgyEOC5y8LgiK662Kz36EetSbD+4jzYsHSdPq9Ly9ouy00yykB
         gFLA0CbZUAYFbHcDkJmrAPe248TA/X1ly+Rg69xgP6qpBKDSHsiCts8qpuSaA32DkqKr
         Ji8o9+NEEBko/pP68OimmYSA0mxwNAWr8Qb3dbqZqDIlCvMbFGLkfZTaGZXI88JxfWBO
         D4THIzL0YwWEGSCg02uVbAUol685yY+IFAhAAOkbmBqiYCbnZMOM15HQMOQCjjwE3QfT
         BW+cjyD42UbVHv48dYqAxrgCnSHXbrSk4ll9XdFY4JslwvMJ/Yc5qrwv8nXG/QKSmlnA
         g9yQ==
X-Forwarded-Encrypted: i=1; AKwUvByPWe209ToJ7zezhjScqXe8rmYzs1wxV2GpX0o/QpYAz4nSH8AMMeAtyzYyqp6HJcwr5kM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+alvSB4jyVtGGN68KPnLeK/Dp+7bMvamN/KfS5st8X2h7/UTQt
	gCiZZ4Fv07xDDayqBmMNwdGcfdigB+Sf+18qkKLP/bl/eq1e+nCuG84A
X-Gm-Gg: AYBFou3nryN1lipqdhS+vBmiCSYIiT/BS8NO2PnUj1qFoTRXl23K41LAUtph17L5D+H
	8gDfWkh9hRqy+icA86SBJRmUIL5YOQNAhz4NucwUdqF0R5B35/szoDw5jgCEStBQz22F+pHoT6D
	V8TG7wNHaZU8HLuo29YNwDmG7faP2LR132Y0AO9uM93L7vj/9YMpQxKXa0WBHlHceLUFIlS0WVH
	s+mc9PZc6ce9l8Vo1SnXNPTqrqCyfYJk1bjB+NBk3Ju8/SErJev4H2qGsJyqkE61xtra3Q2Uj9l
	NnXifW/zCTyclsgn9xqNWI3uLtO4NcljADRsA/cFEr3m1ZpSVJ8zUk3HP7JJvCGkRwDwOC+8Nlm
	lQ1NAe0ZcpfJek5Ei0v8ZPw+rWJGwLfxyRb0ntCj9dPXYUNxhdGAAton7W6wo5zzSte9vVURBna
	hHCFlIObePszy2qYIp3V6VYTHsvSzHfk0zUwnlW29LokFyArgmfAYm+g3qV4mwy9doUdOWBB6Pn
	oai2V6lPPZsTcIZPp445vRMWovsLpyh/NmmOFP9uYZKSvwWUmB78ja9pri7Srh5cjX6+S8yRENk
	MXS+78TnI/TiaovxxHpOYcrYVQSCBHCgR6Z30/LoSdVsb7g=
X-Received: by 2002:a05:600c:3e8d:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4b6df5eaac6mr63442635e9.18.1793998335216;
        Fri, 06 Nov 2026 12:52:15 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:14 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 13/18] bpf: Check the return values of fmod_ret programs on found targets
Date: Fri,  6 Nov 2026 21:03:02 +0000
Message-ID: <20261106210314.1767267-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/verifier.c | 146 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b011acc22c50..69387de119a6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1967,6 +1967,12 @@ struct bpf_prog_aux {
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
index b7329d164771..a9da29a11963 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13329,6 +13329,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -19887,6 +19895,73 @@ static bool program_returns_void(struct bpf_verifier_env *env)
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
+/* The program must return a constant: 0 or one of the values of the tag */
+static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
+				const char *exit_ctx, const char *reg_name)
+{
+	const struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	int err;
+	u32 i;
+
+	if (reg->type == SCALAR_VALUE) {
+		err = mark_chain_precision(env, regno);
+		if (err)
+			return err;
+		if (tnum_is_const(reg->var_off) &&
+		    fmodret_retval_allowed(aux, reg->var_off.value))
+			return 0;
+	}
+
+	verbose(env, "%s the register %s must be a constant, it should be 0 or one of", exit_ctx, reg_name);
+	for (i = 0; i < aux->fmodret_retval_cnt; i++)
+		verbose(env, "%s%lld", i ? "," : " ", aux->fmodret_retvals[i]);
+	verbose(env, "\n");
+	return -EINVAL;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -19943,6 +20018,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
 		enforce_attach_type_range = tnum_range(2, 3);
 
+	if (env->prog->aux->fmodret_retvals)
+		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+
 	if (!return_retval_range(env, &range))
 		return 0;
 
@@ -22874,6 +22952,58 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 
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
@@ -23283,6 +23413,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -23662,6 +23801,13 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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


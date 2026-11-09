Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243307;
	b=uLactfnsD1jS7X+pfmkWcvvgmAeYP99n0ntqbLo1thUMAyAVPstID5INl3SIo5sNkAcA
	 hXo7b8LjWRBpschu9K+lEV4fRF/j6xxm/ontqcPRxUrADhD2uOBrxKzqRkJ8NHVqBM15O
	 9Tc8A8iduq0Xz6PTWMzfSqsyuN4nNAJDNKufTaQhY6wknq7C2qDtESHH6LCspuI0mFlDo
	 V1wI34rHrT6NLMs/FIaaYzFneEVOAiGJ7oj/5bsV//aKGJMow3mHIh5g3iJURCP1cMsvP
	 UgYOfecbQIg3E7+QSDgBRjzRgzZoRwqcTkSpEIARFBvl3MU7agWZkTdB/OYNcitEmfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9+WHAqdkVksZXFFsADq8RSBSp8brp2TfZyHaHhZGqc0=;
	b=cD3LLsyNasQ+l+gHIPmtAkFpnWBxj9Sh/ZQDm2FvkY4f8u3nJinqUGHFNoqPgDVlpTqI
	 QC1Fe01yI/AYyzCMu6ObLzqPhiWyup/whXYqgrIjmvkN1EV/b0MzDXvXhSb0L7MUBMgJJ
	 S9NaE3Ijv+5/d+vgUsvSSUFlB+Ek0OfPZlgrfOfSvFfBvJr0lpT7rDwdP9xyUW65Hzsbj
	 JRMMdcO4w/N+xJKQROiCiYGnJYoxSfdWJqtC5dAV3vEDGFJPVwUcy35AXD7Qoxmw+enp7
	 CxDiU9bajw/cjfk0j6N/hhm5B0JLJwuxf+C7idcDoN5cx9ureKWFeTLVfcBueSnz+DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQYEwFXC;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D6606B696
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563D6606B696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQYEwFXC
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490a0e72588so610339f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243306; x=1794848106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+WHAqdkVksZXFFsADq8RSBSp8brp2TfZyHaHhZGqc0=;
        b=zQYEwFXC5IQDm3ZzChzBjjGdeXfehiQn9TLVI1BKhNP2Je/vyCwreX0fi4DFAj0sIs
         rboCFzv2joQD4+zPzxzK2pbaiW1Cswyg3bbMRVd8rbb66fAHuPup9vhkKpxu9lDPZKL7
         ftM3bfZMD3hwhm7wcjH8Jh8y8oW/gfhdoj5dJZ0t8J/OE8u8pM7vZ2K6iXKm/I80nOay
         bj5PBZDLJMrfI1twq7dfSDHWK+7zGtYGMxsLvQM0Si8tBiQGZzSTbTWyWPAq5qcBYaVT
         U2w7D/zRm7EFxLR7IMgUlYOCq73ZUOqgUimCKILwcV10X9Buhj3PyTYn43pa4gE3wumC
         408A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243306; x=1794848106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+WHAqdkVksZXFFsADq8RSBSp8brp2TfZyHaHhZGqc0=;
        b=DB65pp0FcLapTQHJpuEljMombyUkkefRB9/ATvwFW33Uug4EwMEaBScXqgBL7Xh1UH
         6KMz9cCNmnQTJzbmSV8ymAXGiSM1f/5O6gOC1tlNTT24srUAaJqvlWklcWM94CsV8kAr
         pK9PqFyVgC9gAFkyP0u60Dq59AKCUqSlq1MmTloWkrgV3amsh6m2RRrjqlkaV/67M5YP
         +svBdIXgvmoffvN7+gy1cgdmIjiSfpqFJutUAtB63YWNZhsujiRJ9UEi6tAX+y65VhwF
         QL46uooDeqIKOPNd+86hq+6vovas8wjDf/yRkCtXqi79IIywX4md1bJ/GrFRhf4y/BE/
         vGaA==
X-Forwarded-Encrypted: i=1; AL+hErEE1zJxDqZC20HVVuqO0nYysr4wEIJydkIhII/NnEXRvf63Z4GbsfxAzwavsjwRIn0Zl68=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0+YlnX9gyse79/Zkd0pmTZSyWJScaaNYVgLHbttO7jyYuGjrD
	JWxTqvamZCB0RflEteC5O4rSasSD6L25jJhX+yFDAVteCxPR5zejxnYR
X-Gm-Gg: AYBFou1W/lgGVAQVohDETg4UVdhTbTLycLU/00yjFhby1dS4USVwFnuRmo9r1xh1RvU
	xIL1c+6AjhfVgmkF6FEed4544rZDQa+dC4PImryM/AHtJdYnV3czDU6nBd1JL/M8jBf5nnzd2wG
	d8Do7FUbl9Fkja4i06MvGoRVAaZ7TcPQpwOq8Q3OUVp5cM8VfflYg+ytAaANuraamRGbbWj4Hn5
	3ca64+zo99qsUXmZ2FpCune5JmIyUj96eV6wyTrWBvAMHJ6eRbH/9RCWV9nmx/EtEpsUfjFKiie
	K+vsz1v4jVnkn1dsDmbUPUzIyZMFhn2I0XZ5GoVnDPh8fM6cbmIzKbwQTKzDzZv445+I4vb+LiK
	iVw9buPOiNuyf7F1pQM0emvvVJ2KIjknPAaYBalG8pLFlgjpUOVVvK90hj3+Fnvgr03ASVPXwUo
	+kJAI4rW6ttzJ0kas6I46Uuv/r9YvmdJwjcO75w2Xyto3vXlYPt3hQpKvF3aCwN2jcM08VVDz+O
	16HdV8qwm4YqlSxf0pIm+Z1UFGUv6u4AryqegGHU+gciF/K6eiKazxigh3OKBND/fAv5F/Y2pv6
	Z/fwE3re47g26+SNtaAx3JV+S0UChR7zR9prDkDQSNTim7k=
X-Received: by 2002:a05:6000:3c5:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-4982e737930mr104921f8f.18.1794243305527;
        Mon, 09 Nov 2026 08:55:05 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:03 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 13/18] bpf: Check the return values of fmod_ret programs on found targets
Date: Mon,  9 Nov 2026 17:05:33 +0000
Message-ID: <20261109170550.141443-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/verifier.c | 140 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

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
index 20b1b9ff574c..f3476b12c58a 100644
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
 
@@ -20260,6 +20268,67 @@ static bool program_returns_void(struct bpf_verifier_env *env)
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
+	u32 i;
+
+	if (reg->type == SCALAR_VALUE && tnum_is_const(reg->var_off) &&
+	    fmodret_retval_allowed(aux, reg->var_off.value))
+		return 0;
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
@@ -20316,6 +20385,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
 		enforce_attach_type_range = tnum_range(2, 3);
 
+	if (env->prog->aux->fmodret_retvals)
+		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+
 	if (!return_retval_range(env, &range))
 		return 0;
 
@@ -23759,6 +23831,58 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 
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
@@ -24173,6 +24297,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -24552,6 +24685,13 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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


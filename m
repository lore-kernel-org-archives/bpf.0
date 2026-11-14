Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633546;
	b=C8G3uailS1X5LsnhdpFD6dEI47RN45lbnyHaWgYc9F/l3OZUFxsyc9QSf1kZTqWUDCnm
	 KwVfWL9ERGz+pNs/iJZ+jBjCzjswWYrqTg5lGHUeb4HHIszbx8xWdRFscejXSALJpcOpN
	 W9LBERsQTHkDlxch4kUN+O9kYFTymJkMZDhJxmEf3Jpt6yBOGj+kGw8IIkuo2urPh501D
	 t3KJf0AO5VLTgSQFr7uEUIeGMbxup9nS0/Oa9F4MJXgVKoel0e5xgVX69Nfzie814u3nA
	 syV6TFg+EhJk+ckxucad9mnpRRvj8GtTTu4Ko5ORqOe9ezxLmtyXQtTmWNT6ucmI5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ceM9MCvR1VKuRMSxmfAhWkiIIsOwUIN7u7H0c2sH75Q=;
	b=Zjd7Uv5vsmxuB3pqw6xMflYaryHnyiT5zfwjx0bG/AOs+FRWhUJC4Dmtip7kSvemLULe
	 g9aHiC3ny4xAV/9hg+bgrhlM1Z7Hvn6C92+aojBtsKZtyBtJX08V/0wNc58wCTjgczwlZ
	 wjMWyBksCPCoD7MGobFQXYiXYXninFKvL6IK6IA0F1TSPR1W4aAPKfngjk3EhIsA2OCDc
	 ic5vp+bmljWXy1NEOtovKvB5WnutsyDwNrVohJ3DbSsBpWP53C+ttJe0X+R96mBQMgTJu
	 qLWBImt3ccw1+6VmcYMU65pqy3vlar1wbkcYwDIjgdNGFSf7rNQybjJWqyKfoejP0xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=orKsz5LJ;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE9606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EE9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=orKsz5LJ
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so649616a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633544; x=1795238344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceM9MCvR1VKuRMSxmfAhWkiIIsOwUIN7u7H0c2sH75Q=;
        b=orKsz5LJXsvCnJUVqDIva2oyaddwet6xgKEESo4bY2tJmKUxS7m0gdKqMsJ1HACTWl
         zl31MLwjw8F6iod1cZDTtlyvek/E8rxkHzUAwSWwd0CregrPf8rzylAn7TMFl61wkuVA
         ilYGD5gPVXcjKAZeT4IJkJbFZ+ArV98wvU1WuyuDcPBQujojkdkSsmWoMjDfgVzYfZl7
         qRSEYL9aDXVFqKIXvW8SrbHjd00xvY/J9tc01KfaKFObbVEYb2VrXiHyXIHR7/K/5vxT
         ILK2GTSoGoi3nNZqf6eGjAKMiTr76f9rRyO8NDjMe8RpQvsPxde9hRbnYPQU2ns1Ma4A
         wJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633544; x=1795238344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceM9MCvR1VKuRMSxmfAhWkiIIsOwUIN7u7H0c2sH75Q=;
        b=OsCj49pinbWe0w9tyb2QEiC5Hc1bfMALLPWVBMpMgpYO7UxzyxKVLwF6xUrDbp9f66
         xpeatwV8tf0PfrlePBtEPAcBAHYvY+dEXepzpMPZ/t9/Vv5xv2Fawnu76YWOzOqV3lt4
         2cIC9zJ4w8COQ5y4vqgyZM+yAwZjl9vQmGvbvjgjJaLg4xuTGkvre4H8NjJmlqYsyCLq
         fY96KfpiwmXdLLWYndlIGecTDSiqAPRZMaLOUSyGCIKWEIgLaQnQgmGWIMmjSmLGW5uv
         9IjyLyuBrO1oiTM/y7z+qPg5CMW3SbdGp0a6xYHJlsVhgsxMn5YsBMnsNYsOrGc6zJ4X
         il/A==
X-Gm-Message-State: APuU4Z/GZOpVEXFpfRP3gYJe0xiuffLPQGyQNFOS1o9GpvgLEtHp8Lc+
	D2U7MGrnr7D/uMci4xkZcwVaRVbPE7BXPe9kjcgYHss4p9hWqisk9FsrrajnIg==
X-Gm-Gg: AYBFou3RlwFj8U97xUa9K0MkvnJ+ePSPuN4otftwn/qC82OqfBmxLY0IXbf1ZhWu1PA
	vYJqYMOSm7RZrSr6vK00A0E5l0N+qh3cypv6kjfZegzwgiYOB7Ol4v+gu7fd4MVM7JxsHcIUPgO
	jAVWJ5t5VnXIQd4d1Qzb4AfTK/fkzlcGTpOk8tnQRAnKUX8vHNt05+VofNKglxC+sIP2J/1APWv
	1gBNneKmgheaAobXdYOb9f7cZsdXqvtlUs6qrn7AHgLi5OAcqxf3bmN78qKIdXROfHcfFphuq6k
	Awumd5g8S7B1mF+oQRQWbklrv3c0WjaCf9KgKlEx2NjcHOd25WatONxXdpoup0hr65I+XBusa1J
	9Zz64NpXiGUWvuIG95ka7lkb2LgONHNBYVvgzHC0G6Z6C1jmjsAqtUBRmct1+B9AObLH0pZZBJM
	3d18hz8BY9e+SrqiYsZkP0zQXDQ8ySelwvkyedY4le3AGci2/tWaC5MjNg2j4PF0pzFxCdtHBEd
	Zirk1hsbCAV8vDVMMTrUT76jbSMsdeXHhvQAa0/lvmKoQZXizW4yl1beOHvvjyhLb+i73ewHLZg
	DJjtYOvG7cyJTMc6osMzPeadf6alLEPF3Nt2jUSfP1kY1t9tj8uvBDmgBB/yDBj013jJcB1R+Pq
	9bZmESqPC+NAbIjq2OVhwBgg4IUhvVJCAa3DU3+6dCTQ2dlc5iVGn65zndqGObRjPYVF2SR9esw
	==
X-Received: by 2002:a17:90b:1650:b0:3ab:1b19:78f0 with SMTP id 98e67ed59e1d1-3b1b0a50380mr4713802a91.41.1794633544376;
        Fri, 13 Nov 2026 21:19:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce49d6sm12936658a91.4.2026.11.13.21.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:19:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 09/11] bpf: Allow fmod_ret on tagged functions and check the return value
Date: Sat, 14 Nov 2026 05:18:03 +0000
Message-ID: <20261114051805.683966-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
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

From: Anton Protopopov <a.s.protopopov@gmail.com>

	SEC("fmod_ret/vfs_fallocate")
	int BPF_PROG(no_big_files, struct file *file, int mode,
		     loff_t offset, loff_t len, int ret)
	{
		return len > MAX_LEN ? -EFBIG : 0;
	}

This program keeps user space away from a bug below vfs_fallocate() until
the fixed kernel runs. It does not load: "vfs_fallocate() is not
modifiable". The build has tagged the function with the errors that it
returns, the list: "bpf_fmodret_retval:-95,-29,-27,-26,-22,-21,-19,-9,-1".

Let an fmod_ret program that is not sleepable attach to a tagged function.
The declared targets stay as they are: what a program returns there is not
checked. A caller of a tagged function can get each error of the list from
the function itself. The build knows nothing about other values:

	R0 at an exit           the trampoline
	0                       calls the function
	an error of the list    skips it, the caller gets the error
	another value           -, the program does not load:

  At program exit the register R0 should be 0 or one of -95,-29,-27,..

With the BTF of a module a program can name a FUNC of vmlinux. It attaches
to the function of that name in the module, and the tag of vmlinux says
nothing about that one. So only the own types of the BTF object are
searched. They are sorted by name: a binary search finds the first tag.

The check is static: each value in the range of R0 is 0 or in the list.
[-27, 0] has -25. The program above gets to the exit in two states, -27
and 0. The verifier tests R0 at the exit of the program and of an exception
callback, so flow_join_makes_up() does not join ranges that leave a gap.

R0 has a 64-bit and a 32-bit range. clang ends "return a && b ? -EPERM : 0"
with "w0 &= 1; w0 = -w0; exit". That is [0, U32_MAX] and [-1, 0].

	target returns   range     R0 at the exit
	int              32-bit    w0 = -22        -22, allowed
	                           r0 = 1 << 32    rejected
	long             64-bit    w0 = -22        4294967274, rejected

The caller of an int function reads the low 32 bits. The trampoline tests
all 64: 1 << 32 skips the function and the caller sees 0. So the 32-bit
range decides only if the high 32 bits are 0. For the ABI see the comment.

	What returns to the trampoline
	main program, exception callback, cookie of bpf_throw()   checked
	tail call                                                 refused
	extension of the main program          refused by existing checks

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  3 ++
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/btf.c             | 30 ++++++++++++++
 kernel/bpf/flow.c            |  2 +
 kernel/bpf/verifier.c        | 80 ++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..ac26bc517482 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1542,6 +1542,8 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	/* The errors in the "bpf_fmodret_retval:" tag, if that is what allows fmod_ret */
+	const char *fmodret_retvals;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
@@ -3430,6 +3432,7 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 			 struct btf *btf, const struct btf_type *t);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
+const char *btf_find_func_tag_value(const struct btf *btf, u32 func_id, const char *tag_key);
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
 			   int comp_idx, const char *tag_key, int last_id);
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0d039742c97a..b8567190cd0c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1359,6 +1359,8 @@ struct bpf_verifier_env {
 	char tmp_arg_name[32];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
+	/* See check_fmodret_retval() */
+	const char *fmodret_retvals;
 	struct bpf_liveness *liveness;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3b30517f56a3..242b011ba93a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3682,6 +3682,36 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 	return value;
 }
 
+/*
+ * The value of the decl tag "<tag_key><value>" on a function of the kernel or of
+ * a module. The build sorts their BTF by name: the tags with one key are
+ * neighbours, and so are those with one value.
+ *
+ * Only the own types of btf are searched, not its base. With the BTF of a module
+ * func_id can be a FUNC of vmlinux: it stands for the function of that name in the
+ * module. What the build found in the code of vmlinux is not true for it.
+ */
+const char *btf_find_func_tag_value(const struct btf *btf, u32 func_id, const char *tag_key)
+{
+	int id, n = btf_nr_types(btf), len = strlen(tag_key);
+	const char *name = NULL;
+	u32 name_off = 0;
+
+	for (id = btf_find_by_name_kind_bsearch(btf, tag_key); id < n; id++) {
+		const struct btf_type *t = btf_type_by_id(btf, id);
+
+		if (t->name_off != name_off) {
+			name_off = t->name_off;
+			name = btf_name_by_offset(btf, name_off);
+			if (strncmp(name, tag_key, len))
+				break;
+		}
+		if (t->type == func_id && btf_type_is_decl_tag(t))
+			return name + len;
+	}
+	return NULL;
+}
+
 static int
 btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 		    const struct btf_type *t, int comp_idx, u32 off,
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 640a7c500f7c..99abcef86920 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1054,6 +1054,8 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 	if (jump) {
 		/* the verifier compares what the prog and its callbacks return with a range */
 		ret[0] = BIT(BPF_REG_0);
+		/* no insn takes the address of this one. It's 0 if there is none */
+		ret[env->exception_callback_subprog] = BIT(BPF_REG_0);
 		for (i = 0; i < env->prog->len; i++) {
 			if (!bpf_pseudo_func(&insns[i]))
 				continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb1659ce7a5c..7fb41713641a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13550,6 +13550,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (func_id == BPF_FUNC_tail_call) {
+		/*
+		 * The program which a tail call jumps to returns for this one,
+		 * and a program array does not check the values it may return.
+		 */
+		if (env->fmodret_retvals) {
+			verbose(env, "tail calls are not allowed in fmod_ret programs with restricted return values\n");
+			return -EINVAL;
+		}
 		if (env->cur_state->curframe) {
 			struct bpf_verifier_state *branch;
 
@@ -20225,6 +20233,66 @@ static bool program_returns_void(struct bpf_verifier_env *env)
 	return false;
 }
 
+static bool fmodret_retval_allowed(const char *list, s64 value)
+{
+	char *end;
+
+	if (!value)
+		return true;
+	for (; *list; list = *end ? end + 1 : end) {
+		if (simple_strtoll(list, &end, 10) == value)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * The build tags the functions which return errors: "bpf_fmodret_retval:-22,-12",
+ * see tools/bpf/resolve_btfids/fmodret.c. An fmod_ret program can attach to such
+ * a function. A caller can get each of these errors today: the function returns
+ * them itself. So the program must return one of them, or 0 to call the function.
+ */
+static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
+				const char *exit_ctx, const char *reg_name)
+{
+	const struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	s64 smin = reg_smin(reg), smax = reg_smax(reg), v;
+	const struct btf_type *t;
+
+	if (reg->type != SCALAR_VALUE) {
+		verbose(env, "%s the register %s is not a known value (%s)\n",
+			exit_ctx, reg_name, reg_type_str(env, reg->type));
+		return -EINVAL;
+	}
+
+	/*
+	 * "w0 = -22" zero-extends, the caller of an int function sees -22. The
+	 * trampoline tests all 64 bits: 1 << 32 would skip the function, and the
+	 * caller would see 0. So the low 32 bits decide only if the high ones are 0.
+	 *
+	 * That is right where the ABI leaves the high 32 bits of an int in the
+	 * return value register open: x86-64, arm64. s390x, riscv64, ppc64 and
+	 * loongarch want it sign-extended: look here before one of them is added
+	 * to CONFIG_BPF_FMODRET_SCAN.
+	 */
+	t = btf_type_skip_modifiers(aux->attach_btf, aux->attach_func_proto->type, NULL);
+	if (t->size == 4 && reg_umax(reg) <= U32_MAX) {
+		smin = reg_s32_min(reg);
+		smax = reg_s32_max(reg);
+	}
+
+	/* Stops at the first value which is not in the list, however wide the range is */
+	for (v = smin; v <= smax; v++) {
+		if (!fmodret_retval_allowed(env->fmodret_retvals, v)) {
+			verbose(env, "%s the register %s should be 0 or one of %s\n",
+				exit_ctx, reg_name, env->fmodret_retvals);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -20281,6 +20349,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
 		enforce_attach_type_range = tnum_range(2, 3);
 
+	if (env->fmodret_retvals)
+		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+
 	if (!return_retval_range(env, &range))
 		return 0;
 
@@ -24276,6 +24347,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
 			    !check_attach_modify_return(addr, tname))
 				ret = 0;
+			if (ret) {
+				/* Nobody declared it as a target. Has the build tagged it? */
+				tgt_info->fmodret_retvals =
+					btf_find_func_tag_value(btf, btf_id, "bpf_fmodret_retval:");
+				if (tgt_info->fmodret_retvals)
+					ret = 0;
+			}
 			if (ret) {
 				module_put(mod);
 				bpf_log(log, "%s() is not modifiable\n", tname);
@@ -24454,6 +24532,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	env->fmodret_retvals = tgt_info.fmodret_retvals;
+
 	/*
 	 * We don't get trampoline for tracing_multi programs at this point,
 	 * it's done when tracing_multi link is created.
-- 
2.55.0


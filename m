Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546599;
	b=RH9BtvMLDpdwR9CsI52rtCCAfUsTUPKbWB+A5mugh7cwZ7ReQhFwGdnJnPeUGt/qPLjY
	 gFRa85etbsjWpNAota1puz3URJUV5dPm4NLlX0Bew5BnO3RLnUbX/rhqkJwB/DhwTxkep
	 GsKY85SdX4iucA2lNNlEJTE47Th2yDX4yaIfTFnfbr81I/6+6gF93q2Q2fXFB8sMU6Ohs
	 1o0/oScLYXU2THE9eJzK69WAFbPmdDNSt97GTMK0YkQz9mJO9GkV4GrosWndn7QtWR9Tr
	 zthXdsxT2fmI+QbtG9jMz7VH1PXX6MNmZnvRtxUR3ijcVpYnZLRHxIsrylIDD4O2q9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EGRrqMaUNmVflr6veBZiXzMTRJg8bVeXspGW6DNXkmk=;
	b=x7IKuyFCf1cOXDZB++gKedlPyo+K5sofWU2yyFLY3aEovN78rJEa9lT8L3fVx8YTF+0M
	 /1zEYN6qDEV2yBfHQouNJRqZhGyG+wYa040g/RC2TCUQUmxBWmKkru8m7CKCsTGEtVQDF
	 Kv5ak7LaHHJfGiVzoPCY1Foixr5Pp6B3UBZT8FKnsoTmRpSMWgv3JQqG160o2x713O/NM
	 BKvbqbQL+rEUNFel8LoR4epR/zxx0X0CJPLkK3abRqZ2rxzs/2evyERDV4GcK3GMmYTni
	 Seb+g//fABCcYtFgTl4cCkLZcTfTVMDB+XbgymiGk8n1eKF37soBdmdjnrvJS2VEIFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPLukMJi;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B7606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81B7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPLukMJi
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso267679a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546598; x=1795151398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGRrqMaUNmVflr6veBZiXzMTRJg8bVeXspGW6DNXkmk=;
        b=qPLukMJi46l7RAtN7lZjgHchh0oKTA6j6wqiPiZyCZq37Hddka+7oCFFzMjVg4ii30
         Y9hTEjUQ7c+Mu6xzYUswd7oMbnAddFJJd3P0coDpwRl/uwdtmQwVw9l/ntHY+pWq0RU+
         FTMIRKGRXJehEAy9b+0xMOKVgQKh1ukGQa3nT61vBDlAjRHX7j/EMKlWRzlfncfyYmAS
         5dmIjCLhb6XD2ysklfbxLz7qIAWL6//A7WYVkysQUaeIdhCER6rYFJoEtSkN1TD2mJZj
         ZYhZschSIecYtAEp5AW/2UwPKhN/ii2XFuNaUCtiEZsfclSJA1WanRQYCqi6QpbD+Psw
         khXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546598; x=1795151398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGRrqMaUNmVflr6veBZiXzMTRJg8bVeXspGW6DNXkmk=;
        b=lezF24YATWMmffWbmUT/JIhw1rjX3p8xSuN4DR7J/17lJnCbjLVpLSl9E0m5Gp7687
         7uBjceFjd8wmh7lxtMJ0xc/HOTTg/UrZhXZdgOkxsdmb5QvjC0FW4+EkSCI+ZKeD+gPj
         b4fEuBVdQht8S3io7vVZxQC078pgBo4548llHzCLG+YpDrHrqOm6wojvm+Tcnk1I2Pwi
         7FTlOd5C/OQ8/hsoO2n6eL8934iEDKz320XdZ5T46K402cFFzdKrbQhHUsD8paStalEB
         5jR8VIQ1P5dkZisbMkK6pB9gK9YI3PYjjMr1dYkyPEWu+UwIy7WRJ7W2lGCBy4EKRTSm
         +j4g==
X-Gm-Message-State: APuU4Z9AhQvQvOaIZ1z+W88sb+tqS3Tsf3NuG6jv+Q0T7r7x4MZefg5e
	QOCM3YyVBYSrbi0kT+ikZmmeCc/039pZ3QPT0xo6KZ+HTDU9MQFM5JB06+x3zw==
X-Gm-Gg: AYBFou09Lik1m5YKi9b9dVv8CQA3g2kkAVq+qiaw5M70AxONNUnC8KRCCYZxPbWIXG5
	MVVpskPaCDng3g4s0zi63WWju3qxp8x18eftxdjITwAtAtpvDjlW4qGyFrKNT366dc14p7qQ4IF
	I80WerQS6zie1D6RkdrYlwujNIdnEUu44lo6NpBFWHuW138NRSgXuijcbUc63x0p18DoFMAUYY/
	o81495DIE/fgkvKw4L9LFXLz1AQv2L2gwufh/+FicUXMVjj3q5qTJfiXFHjGBkWCaDKtruiulia
	V+yTnCL5bcqJ0J+DEbXx970G8JXijWed5NYqy7zYYhGkx8mViAkoVzdtdvZ4AylRwRuMARSZd26
	afXJnMptmQnjUumw5Sny438Ixk/7CnljzMDMnrK8ALDSOw6i5OJBt0tsUvw1gbKtHtXXpc3x9fS
	Bs73Iz9OlOzTHtuNutqrK7vOmTxwFcSfjEQhkpFwgst3kMsER9af4lBbdD16OeguGX9ZAQT1My+
	zq9scXRxbOGsKcAjbO6KfOFDWDcGWNzMwBe5lVzuGFgfF52teKn9hYnuMtpAqI0rz7zJO4x8AB6
	pxYC+rcZ0dop3/f1MEVaPB5bzPOIzairSGfuZUC5ZytpJxhWm94QfNVr9LH94fbrwcVJ6MHKCi5
	Y7+6TCL4qZiXYSXjiX+dyqjvRmy25vqHfFdsdfMissb65PZk9iq9drhVe/C1TADIcd5fqsfUciI
	o=
X-Received: by 2002:a17:90b:35c6:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b1b0b9b78dmr871315a91.22.1794546597800;
        Thu, 12 Nov 2026 21:09:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm7483335a91.5.2026.11.12.21.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 09/13] bpf: Allow fmod_ret on tagged functions and check the return value
Date: Fri, 13 Nov 2026 05:08:57 +0000
Message-ID: <20261113050901.1399091-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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
the function itself.
The build knows nothing about other values:

	R0 at an exit           the trampoline
	0                       calls the function
	an error of the list    skips it, the caller gets the error
	another value           -, the program does not load

With -EDQUOT in place of -EFBIG:

  At program exit the register R0 should be 0 or one of -95,-29,-27,..

The check is static: every value in the range of R0 is 0 or in the list.
[-27, 0] has -25, which is not in the list. The program above gets to the
exit in two states, R0 = -27 and R0 = 0. The verifier tests R0 at the
exit, so flow_join_makes_up() does not join ranges that leave a gap.

R0 has a 64-bit and a 32-bit range. clang ends "return a && b ? -EPERM : 0"
with "w0 &= 1; w0 = -w0; exit". That is [0, U32_MAX] and [-1, 0].

	target returns   range     R0 at the exit
	int              32-bit    w0 = -22        -22, allowed
	                           r0 = 1 << 32    rejected
	long             64-bit    w0 = -22        4294967274, rejected

The caller of an int function reads the low 32 bits. The trampoline tests
all 64 bits: 1 << 32 skips the function and the caller sees 0. So the
32-bit range decides only if the high 32 bits are known to be 0. That
fits the ABI of x86-64 and arm64, see the comment.

	What returns to the trampoline
	exit of the main program, of an exception callback    checked
	cookie of bpf_throw(), default callback               checked
	tail call                                             refused
	extension of the main program      refused by existing checks

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  2 +
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 83 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..ee26185557ef 100644
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb1659ce7a5c..960231ec591e 100644
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
 
@@ -24276,6 +24347,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
 			    !check_attach_modify_return(addr, tname))
 				ret = 0;
+			if (ret) {
+				/* Nobody declared it as a target. Has the build tagged it? */
+				tgt_info->fmodret_retvals =
+					btf_find_decl_tag_value(btf, btf_type_by_id(btf, btf_id), -1,
+								"bpf_fmodret_retval:");
+				if (IS_ERR(tgt_info->fmodret_retvals))
+					tgt_info->fmodret_retvals = NULL;
+				else
+					ret = 0;
+			}
 			if (ret) {
 				module_put(mod);
 				bpf_log(log, "%s() is not modifiable\n", tname);
@@ -24454,6 +24535,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	env->fmodret_retvals = tgt_info.fmodret_retvals;
+
 	/*
 	 * We don't get trampoline for tracing_multi programs at this point,
 	 * it's done when tracing_multi link is created.
-- 
2.55.0


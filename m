Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502028;
	b=sBIkFAzCL7AshN9Ao5palKwPHdWXhQEDatyIIApUrNmm2+HOZI42sCepGAta6bX5RIJ6
	 cMSlrxyobuDUB/9WQbKXWw2F+IJPEnbQhLkoWvrA7sr52aJk/mjT/kfMo2ShDAc0pp1fj
	 0vlOdlAyhANLmOU3BUPl2cZrr/gC5NtPAB/28DyyyLnfWXPLx8+UfD2icMxXzDDwtOxVz
	 hKfMabdqweVfPcGVe6euCqkFOaQ32oBLmP8a5t36qgCPoQmAP91F92rAyFtLAF6zCeQxM
	 t3X1P/yeRxKtWpLmA2d2h8UCRf+6ljSRuIFmugHo1hk5/zl7TTxgycWv5k5JFdNe6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=opQ/GNakZXCGVFGGrK9thJYl93ChEkWHL4+yOrmtK3I=;
	b=AIJc4zzrGUdhpYtzcAxmYKbts55WALMva7Q3TQHuzudawOdA7+qTBN+ZrTzzJlp5N65v
	 8BOWLJ7UTJ43lYcQadH3ioD+RylZAJFAlMkg5YNvt+og7XACvekRVs6d8y/+tEd+msEvi
	 IRdOh5yrtYZT7u5rl7e3VJYKrLnO3kCiyfRXOkTRtDbyXsztToE94PhVISp5i8L4Gijyf
	 mjxZqsAB1z5jIGpmB0RCGopidj4RUUHoklg/0KnLBfyxg20g5MNjVLKIWCw7/12j5lCEg
	 vIc0khbTNXj9lyRU3D0ZCxt483OqKmZMk9Vdl6ON9ZIArWCPBMTLva78N45KStfN+8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/FMurJp";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A3606A89E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2A3606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/FMurJp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea138a3497so301845ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794502027; x=1795106827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opQ/GNakZXCGVFGGrK9thJYl93ChEkWHL4+yOrmtK3I=;
        b=n/FMurJpFup0sOkWcVVMez0V1Nv09TZipIIDeTVVY1lMtr6vzUtvyZJCaVUEaK1mEs
         Ds133RV08ZvBo1LzqUVjwfyCyLx1EoiWWODuqIFydszwYgV8VZwT8tFR22T6OioStNyq
         AmTE9Ccwzdqy91KIHyfNjUSA200B6Dee1oRO/OxoUGbIpvNq18R7gobcNSi9gyr5LpZl
         geDWXvBuyxRHgeAyuJDjidtqNFkFaPHH+Qs5YdOrpRuRGu3WwVDgRV2PdxS2qqBkE5Tw
         7UTnZkoWVrT6aZKxuzruOLhbf5DPYVC8FGekB/dcePYBpGEa2LHtkLTwc6SReDtt9gDt
         +ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502028; x=1795106828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=opQ/GNakZXCGVFGGrK9thJYl93ChEkWHL4+yOrmtK3I=;
        b=owCAGynGz2ip3snOQLeHIX5VhQR5De9lZsQZqiK+f5aH81nwPlrPLIHc9Fa4GmWmpc
         tQqQ8V2BssDdnvsdbpUU/XGjYXoGNbxQkZPkoZhZSIEnpp91IDcxGqTPPegLHPrOiX3f
         22PbhtY0GtKXMDtuLA3D9tlkTQC4EbiX1SJuCWMIuTt1dD3XZo0l5YU5uPVIkadP+EB4
         ShL2URujyFUDMPCljCGVwTNwC6P3eV7uX/Pg0Or6jJHPjvKXIEOWBWgQJ2p/zQgb/QJO
         Vx4iq9NV+yLVITixDddKQ0KSvQVCgOUCUtRsX406W67+V2tArw6OaY4xHj8AfN9i+urF
         PoJQ==
X-Gm-Message-State: APuU4Z/fy/oVfXx+UmVSDBTtSO+SpkWDIwZzKWNY+t2CLjIhjg9wBZnk
	kaMS4708jziyQTNM//dNOu6V/ypk/5W5m+ryvVZ9I4E1/wxILA22x9Ercl3sLQ==
X-Gm-Gg: AYBFou13UqoV8VeTklZchg8jANOZ7LFWLGz4cDT9qi9uYUgX8XWiC10ctaUuFZA04ZA
	U3KLI3wkKGZw84EowaeufUQe3lSuM3roGzoia73Bk+5mHeO1XS1LC20dFx1EXWh7z4ZIPJhNS+y
	Pb8SIGYHrFJIjtEOSRl4af2c5z9Rks8CDBH/PRQBLf0Mfm1U5tjRO95B6C+V/F8RZRr3/xU/n7O
	8tuTDJ2rGenJcWHlfekDuPdVE80p7dWXiyO5Umaxp8Op0xTtcONqyEPqoATdAKUtB5g7hWW9x+g
	cXVkc/NLw8hdfkuIFQ1DQw9aopT3bUt7FIhT1UIIAh44qW6ijDQaC/wx3LjF5jbjhHdyjoJhhPq
	94OPLJU6tvDkDgr30r7sCakS4CYSxW79KwwqykWf47pui5juGOYDzfc4t46HEENIvYZYirt88yD
	yc8JKpR0xt1Yr6ijGBJfGJF5gez1gtG0NVacb3o6VQUcVH6cCxMPUsns4ZyJS/ApGhC6v30c+1Z
	oLvVBEeE7TtzBdR9Ra4x4hepmSG6+j6VNtKhipbyIvptWOa4c5IXdPY7ryJyUJNCbjxZmE6OXxw
	PbugAqraou2euQMnTk7tULvU8cdxCSkAnTOlWY1k3XfN4D6sv6NdKvQdf6bkV314U4GV3+LUtJK
	PqxxITwwX6QrGdAfXu5wqjBD6W2U9QRmXGI0oZDItiHq0pJVSn9rmM5+wQkBXIXWr4+9q1Yg8Tj
	yH8rJuaqWYGK7YZN5l1Vzp
X-Received: by 2002:a17:902:f683:b0:2e8:93b5:c555 with SMTP id d9443c01a7336-2edd7aeae6dmr64055645ad.61.1794502027323;
        Thu, 12 Nov 2026 08:47:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0f9ffsm37396285ad.75.2026.11.12.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:47:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 09/10] bpf: Allow fmod_ret on tagged functions and check the return value
Date: Thu, 12 Nov 2026 16:46:09 +0000
Message-ID: <20261112164610.1917256-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
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
The declared targets stay as they are, without a restriction. A caller of
a tagged function can get each error of the list from the function itself.
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
index d4fdb724cc1b..8a3cded313f4 100644
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
index 56924ce392e0..3ee90c2bb1ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13531,6 +13531,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -20209,6 +20217,66 @@ static bool program_returns_void(struct bpf_verifier_env *env)
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
@@ -20265,6 +20333,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
 		enforce_attach_type_range = tnum_range(2, 3);
 
+	if (env->fmodret_retvals)
+		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+
 	if (!return_retval_range(env, &range))
 		return 0;
 
@@ -24260,6 +24331,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -24438,6 +24519,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	env->fmodret_retvals = tgt_info.fmodret_retvals;
+
 	/*
 	 * We don't get trampoline for tracing_multi programs at this point,
 	 * it's done when tracing_multi link is created.
-- 
2.55.0


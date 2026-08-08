Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50627E07E
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149591; cv=none; b=EsCxT4fZJOlhwGRQVsobRF7P+mi0DqvhAHeRTQN4Tz5czeLxnKIb447orr1d+DJPxmcqBZMcUgbW3TTn5PZcIxpiJszTqGkdXjX9j5KDoePwM6Q8CuDDT0R7W1EMEyIfCZRbyOVAlfGahxp47uKIx6CZ4bwKzzoQGIdo+3TWBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149591; c=relaxed/simple;
	bh=LzrWIIJyrsGm5O6yniWtzHFmeSDHtMHOirrodKLGbgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMgo9MDA9G9W1lm2TR7qmcDcrIka7Cy2q0baWKDpZLJHD+FAtS+4H6o+1J/9Ozph8luo7XecFZm8b/iSEa3tqHZM78cSb/zO/JB0cmKRvdIaB6Jd8xZtegZdDO6Gb7WVnx7a0wMPV5jGUmIOUkTJj0Wq+8TubXgzrSfPy+rQbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3CJniMl; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3CJniMl"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-7e9f9a3167aso58164a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149587; x=1786754387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEiNMhi+cKBij0ApLObpRBr5B/Y69XYrodxj3+pBvp8=;
        b=E3CJniMlLGdZITpSaiHzSPqvcC+d2/W+VfHgtxcoPwCa8cBwd0TipME3GRqyNK1L5l
         CehOwks98TBqwfC2Ju7QiBbIc+zVPRncchNJ/VoVqz+mUdRUOuN13Jk5U25pFKNh8kQS
         mWtYdrAE4KGz+QBQKzhCMfGiqwtghlr0R1Qek/EtHJotPMSOW5SBLUKuLO6mzRQwl0Bo
         NXKBfYvzOSEfZja9+pjVlKfN0gVnraJIsmXz6PQCL3JJ78LA4JWmVvuDcXpGBmCYImqW
         jj6OPz6x2J92DGGiQFUNamAwP7GdBJ21Fpx1j5MPq4UdM1jfcBWpAU89+t08MLXpD0cl
         FVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149587; x=1786754387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEiNMhi+cKBij0ApLObpRBr5B/Y69XYrodxj3+pBvp8=;
        b=RLHXl9ndmMYLC+7lDvUmwPsILaV4b/YEvObEN4c89YmGNhsoQjQmz9OvXYaztuXo8U
         sVrFLfzcGCmpZE2lVl+7ta0zKn4GOfjcA11hGptuAMKxHSCaxPt2k1B1vsePAAC1DTMj
         kXpJaiyFv4Eih5RpGor7a/UvtltRkh7eHDoUKAidjAmAHxqPZ7FJosViw090CYF/rOpI
         sI+DW2miCQS7dbDp2y8b7jK3Bahb/sWVcoDcQ8/rK+/kMop9UWFrFUPNCC+8GFHfqUsu
         0IPbiQbk/8pSD5TMAzEPpslr/JrMv+zdUJ43+VMJDLBh6Tj+wjd76L8MovTaIJUzR1mz
         21fA==
X-Gm-Message-State: AOJu0Yy8Dst1bCFpDgQYGkcBkTx2MFjadBA8hPdolhIO2+KcKOQ0i+hn
	dx/bYnu5EnT/p3SCeHCoh7UtoxRslnVhe9G8ZRPc9Qwez27HpJQXkdbLc6NkzFuSgUg=
X-Gm-Gg: AR+sD133fUy+F7KYxt6VMw9lZXvjlkEQhg43/dknqcNQwPNkZt4NP1jogrSI28l23al
	VvpOTpqmBMLj1QQfKNtpYUMBcT7dmxxbwVcKIlMHrGnWqJOBQte0XVsJTzHnR5eZRkv/oqvSDC3
	dZDk5pQi0uSXUxNJWT/UhCAGwSoF1O/FYwwzlPB9jBr9h69wiWBkddjzSLVkVM5XAGgrN1mytuY
	OBHkvEvL3YO6RaConLmF3LlG2iwZjEixA8fS9+4v1u3XQmKO7pXW1uEDNbwGQmEmwY2cO0+JXyF
	bR+PAgY/4elwxuqYHx/Fj3s82mZVWLHoNygK3O7uaHalIRWiUq2qDCEOruWi5f33gLngPIAA2oc
	NMM0S6l3gwCs0BKzB+eSnjUgi2sGBGyZbLuTDPdBsB7f2V5RmghmMMt8pfDA2P6x4SjqIrBMGf4
	qlGRxbAB25dgdsJqfJGuw580wl1Sv4fox0sv6vCQVJkfe0YCnGwcREWCZ7zpWK0MBM5slaUxicM
	jjkyiVmfEgOcFZg9YlM2DSdTeY44qm4O4DdB9ihAmWBKKYxVb/rmb3L28i+AIw3rIdihwk=
X-Received: by 2002:a05:6830:2a8b:b0:7dc:c749:ade3 with SMTP id 46e09a7af769-7f34dcf1707mr8664169a34.3.1786149587117;
        Fri, 07 Aug 2026 17:39:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5633f7sm2403016a34.5.2026.08.07.17.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 02/14] bpf: Split subprogram and kfunc collection
Date: Sat,  8 Aug 2026 02:39:22 +0200
Message-ID: <20260808003938.3486067-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3291; h=from:subject; bh=LzrWIIJyrsGm5O6yniWtzHFmeSDHtMHOirrodKLGbgw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqoKV+UXXyfs/pQ+d565u4P4ktuNCJK/Hhjfs+6KbFdmD WfM6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBG3akaGyY8rHvsdVWO//MeLe32H+c L7PFF+Ocfr956e8FmrJjTmDMP/itX+s/QyVWUesE1Q9DgoGjpxc1ptclTHqxMiG/WD9YTYAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

add_subprog_and_kfunc() combines two operations with different ordering
requirements. Subprogram discovery must precede validation of func_info and
line_info, while kfunc descriptors are only needed by the verifier after its
initial program setup is complete.

Split the helper into add_subprogs() and add_kfuncs() so each operation can be
placed according to its actual dependencies. Keep both calls adjacent and in
their existing phase for now, and add short comments describing their roles.

No functional change is intended for valid programs.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 92d0cdd95c0f..4573df98b1ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2842,7 +2842,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	return 0;
 }
 
-static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
+static int add_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
@@ -2854,8 +2854,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 		return ret;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn) &&
-		    !bpf_pseudo_kfunc_call(insn))
+		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
 			continue;
 
 		if (!env->bpf_capable) {
@@ -2863,11 +2862,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
-			ret = add_subprog(env, i + insn->imm + 1);
-		else
-			ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
-
+		ret = add_subprog(env, i + insn->imm + 1);
 		if (ret < 0)
 			return ret;
 	}
@@ -2905,6 +2900,28 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int add_kfuncs(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i, ret, insn_cnt = env->prog->len;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (!bpf_pseudo_kfunc_call(insn))
+			continue;
+
+		if (!env->bpf_capable) {
+			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			return -EPERM;
+		}
+
+		ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -20330,7 +20347,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = add_subprog_and_kfunc(env);
+	/* Discover all subprograms before validating their layout and BTF. */
+	ret = add_subprogs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	/* Collect the kfunc descriptors used during verification. */
+	ret = add_kfuncs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.53.0-Meta


Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BD3E0080
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963874; cv=none; b=aPW2vW/6L1EyFI24KqiYU12lECY8zMm2u0bAjuvX1B8licBLu9Q4ts5H2IcTGu+9GjxoOwSUpUSNvvH++lcFwm8qZZ0cfh5jQ8lNAGSc9vrZkXsJVW6YzX2ZfQYd6VpLDol7OL0THyakqojhF0dDRwAT8R659ZkY0bqPhcR2aOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963874; c=relaxed/simple;
	bh=6hA27fVfv6akH/LXwY5AGdDdX015mL+uZdfjZ1NX3Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaP42U64FhlsX2+y25CC79bTzRkf1EtwdE2YBjNSkp1Iu5WrtLOHPL3tTlYqXjYqKaf2YWceP/KLaIpVkjEYMF4YnXAfyeJT+Q5a0QVXe0Nv2S4+IOm9ty7GeOnIstUqkNO2ikX+xW7rpW2NmDAmzw8lcmg7Yu1lIRM8H/iunEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNx3t/r0; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNx3t/r0"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso4281675e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963871; x=1786568671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WICcn2gCRNuFbqmtyS6PfQW5rGdM4Y+9zx3MQOlKv7o=;
        b=bNx3t/r0P1i0xX8IWvc0vjniep3+uHDjTfm7E0F8LKIQOU9lumzrBuXHlJycqtP3e4
         3iamcacjrBS7OsZvuXpKK6PpJShzgqUW/jZoKjm/6Cwd7x9kaXFMe0TCf7/4Qm0UIE10
         pTbi7INNVtHT9hF3RYFDd68EQ0yLWfXhaDbh6UjjsxL6lkbX9g+pUnUCl5yK8T8VZDl8
         mFXJuSvJ0KwQ9M0csfMkJQwf8/Uc4YbTs67SRkbtzRJve3+y+Tes44xhqbCmxgoqo63n
         eCa6JbywKN20gPZ8+1/5NhEIfhhImrDT5dL8ZlxHfjQ7fNN539QwhBZUZlN1q1wEMa06
         Reqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963871; x=1786568671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WICcn2gCRNuFbqmtyS6PfQW5rGdM4Y+9zx3MQOlKv7o=;
        b=APD8Or6mXUjgJb4JYZw3qxATlgUqVJxdfTV2FicXfeYlIZaVbhSoIefqK/jsG3lcX4
         i7BB1A91BMGDmFZ5yvOovKkENUz9OlbBI7bhuqpJMpkf8dRU/MKVk29iD1gEz2Wo/1U1
         GBvt6J2LGzU+OTq4H8JaYGGQZS2g7vZSqumENFQvNEUnkUJ/kK1VqpzkDxVfSr2TQOp1
         48i+kddrJUtesmMhO8dpAj5QH3f3PjjNd2EDHDVR2X8YSCkvXpcsJtNF+dfYY+NtlkQP
         NEMPsJq3xDqxOut1bus//v4y+TNrjz2QM02EfXnlugdtH1+b6kGrdMrluCDQayawM7aU
         +tFQ==
X-Gm-Message-State: AOJu0Ywfv7G9z7Phs0QfAsBS1OSGJHQOLyGYOqE5u27g820UOiofFaQt
	K/CYhAkyQO+pe6wZihRxHGiJL3w58ArZ129a7iSj8LZIpFDqkJoN2aNmfyN3aHmO
X-Gm-Gg: AR+sD10EANKrRQDKxj9eNd+dWdmbCgPXQK5ll/+ABNnEdh2BJsTXQG9rMS7Hac5Hi/u
	WAc2Ie0dz4TlckBW622OZgSDAk2qYrcucVf+PnCnnxrfw+nCxOCYAjw+6rKLuDcMG71LiOWlZr2
	9QdwsZsmpdYaWpE5WRTs0aviNKuC0kyH15dVc445OhtGapyXLeRC47rlvLNyVrJkgoKQBDu8Ipq
	iisGNZGN0pZiY8HtlPcc2QHeReB3KUkoFhEbpeOzLdwIWFz3tFByG3oyNiuzgDmH3ARh0kFDtYY
	HSZWynfw/16cUedVnsE+BSwTV0asu+a/WaaKZi10BZRFmOfObnLs+csBBdw0hxHwxABSr23Tl88
	TVRYs4iqzaBEzma89EdMj4nPGvRM9ZzaUulWn0shdhfebefwNpxABhC7e/+BifqW23yf4zbxkGN
	2leZVBIn3oMpKZqgevEFgRalc+AOOJnbsDv5htlNoeG3nIbD+73whgx5HAjZ9r/8lSqilgmvBrL
	En0Kz3c3Qk9Yba2HiBLR+0lDOAIxjXpsH0vi5NbBUnG/YjB26cGJrTIs6prVsWynznrvuHWo4h9
	pLCks1EhG4MewJjBqBM+xdPyezk=
X-Received: by 2002:a05:600c:e557:10b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-4994e7cbbd0mr108818335e9.14.1785963870921;
        Wed, 05 Aug 2026 14:04:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e536a14sm67802585e9.1.2026.08.05.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 02/13] bpf: Split subprogram and kfunc collection
Date: Wed,  5 Aug 2026 23:04:13 +0200
Message-ID: <20260805210427.3218326-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=memxor@gmail.com; h=from:subject; bh=6hA27fVfv6akH/LXwY5AGdDdX015mL+uZdfjZ1NX3Vk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40eR4jRea878urNcwOBBpp5c0LTz2tsCG1KNBHDm5I fdj1t3sKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETiNRkZVgasf3aZQ+eFXEJH vKlvrkz90/T/D3rq+HLEay/8WtWdy8jwVdFQN/vn88U71JS3nLBaaTW769BpjX8hXeorjA9abDn DAgA=
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 129e50888b90..24b163c2bd63 100644
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
@@ -20322,7 +20339,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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
2.53.0


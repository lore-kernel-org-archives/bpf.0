Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF26AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645700; cv=none; b=Tx6EdUySPchdd3ygvKVDiROq8XD1WQCqi5YW30903wkNJYEDwOjRrp/4B+nEDpV2Do8SlV/k+qcVXlGO084UIpnVCbobwKRogY4DCnlHn9n7oId7D3yW99v039jKA+M2j/ohedi2UXIgPcSJbP8WXaFwYwOFu1CRJq9nMn6Z1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645700; c=relaxed/simple;
	bh=lc0N/OwRFe/m0D5cnmdIc24XKciQ50nbJi4jALD+joE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIOTLTSn5P1MnT/r1UjBu7QmsgnQPg9weCjt0W8dsT8efbMMm0DW4r7CXnnHc2rRkmgYe7WLKkstlpoE8/Y6yxiLLRyTtIu6QcwV23fKufU9eH8GGAXYGyS4qlNWre/xP60vnRKX8J+OAfu00fS4uxFghqqb8hD1dlred+RSlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Kuybnu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Kuybnu"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1b233ca98so1778542eaf.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645698; x=1789250498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjD9kvVEyoQCQmBUQSUK9k8pRvAkdPFjYHn2sGQvvJE=;
        b=P+KuybnuMh1spq3s3nRyS01IWqciBBm6DDXhAAEDpNmID83G7vUWgWQUjt9umVyHqx
         Ks8K82QvV2fA3Zup92ASc4lob4vQoba4ZwoLHkgwZuXXf7vlVwjG5A0D/HKuW6QRCpxn
         WYJzJLV+gHR7kvl3UQoIF9DJtq7p8mbfkblQj0gW4g+ZjsmpJJZfyi6RtQfhInpUREk8
         KR1QiptuL17BUPoN6yDYCSbxBm/EWVHEOPvXihSK2U51Qrk1yw0QnnmJaCyXUNyTrw1i
         2+Gd6kaJozxlw5pbzrUMGDs2j904eivjGp+M9e8BJ9qUetgqrxHI0J93Q5OLQd16dSMe
         xIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645698; x=1789250498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjD9kvVEyoQCQmBUQSUK9k8pRvAkdPFjYHn2sGQvvJE=;
        b=fbdpMUEAn4P9sZelfXdA6Wp+lnEsNqOvsDFbXa5hFc0bdJour8KivPCl2oYwj/lCSV
         R8pbHDY6TJXcrSz2LTXl7kcXeaf9TdCD5vOBFpTgWiBTfHraGgwVrsM1O2fc6UBzcUw4
         kQ02I6uAB6ivWk955B2JgeTGcK/l4cz6RYYiDE9oHtydciTCpFnUN65btczG5qogLJqu
         PkyzRVBCBSMugu0UZDb+vOQ0f2oXAR/2uyBFKF4MBPJT3y2TsI9GkDRpE/Ljtu8Wnz6o
         r63174fV23vVT/keD7xsZnPHxMj9v0grunwHMBaS0PgiO21N85U9GP8opGNX5LYB6W2k
         SppQ==
X-Gm-Message-State: AFuF++mmajaAB4cUHyiiaHCY3xjsfmpIhzkJFbGe4RLmKo3GSGUoTEeM
	W7yiY8oo45IZPGdmzZgaIBypVb3Fmjmh7bnBYmKMItroer8+7Q8gHfZ549oJow==
X-Gm-Gg: AYBFou0p1woQZweg/d4LH7iiHKg0E412pfAU8vGds3k/rJd8r3xxuYvmXuodAHVysL+
	AGNJ1Z6ZyzmEVY149LFyo7xFzEcof8OgztFUzlZlAt6Wt/hTujRG4a3GWkOGHxW7akYnuxWwQja
	vqXP4S5eZbjUIwU/OhMN2cp9+ZihzQB+WCfUkhp+xkKlhp6R1u5RUxQSJQezLPg1DzezQPE2KdM
	ajMsJf/jfdiqDYPmW1fBTXc8dGL0+A9HHCVl2A+QKf+OdeJUzonfHtW3+clmTGsb3Lzck3zw8w4
	pitLT4tTlUabjMnByo0HL9XkCHY0klTQpzvy7ePyR02xV1ohf4y2a3uS5vv9Jx50Tb2lzqDvE/s
	+gUr/VdBjr8r9nb8EGzdUUIeSZrdVswqu/Hfp7kOI4DfDbdaFzyv3huisueiu/+LHRjVcjxMxxm
	zky78H6LozSX5AAHrGwFs/tRl6ML17OQqR76hyH4qDy6pGrsB09sw=
X-Received: by 2002:a05:6820:4dcb:b0:6ac:b6c0:2c09 with SMTP id 006d021491bc7-6b6fa4d572fmr9676466eaf.1.1788645697763;
        Sat, 05 Sep 2026 15:01:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6de03fa6asm8949843eaf.12.2026.09.05.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/22] bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
Date: Sat,  5 Sep 2026 15:01:07 -0700
Message-ID: <20260905220117.922028-13-ameryhung@gmail.com>
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

check_kfunc_args() walks the kfunc's BTF on every verification of a call
to work out which BTF ID an ARG_PTR_TO_BTF_ID argument expects. Helpers
name theirs in bpf_func_proto::arg_btf_id[], as a pointer to a BTF ID
that resolve_btfids fills in at build time.

The ID of a kfunc argument's referent is already stored in the
immutable BTF records that describe its pointer and modifier chain. Make
arg_btf_id[] point to the BTF field containing the resolved ID. A __map
argument instead uses the existing vmlinux BTF ID pointer. Produce this
metadata alongside the argument classification in get_kfunc_arg_type().

Declare the argument BTF ID pointers const, since the verifier only
reads through them. The BTF object owns their storage and remains
alive while the generated prototype is used, so the pointers remain
valid when the kfunc descriptor array is reallocated or sorted.

Both helper and kfunc callers can now read the expected BTF ID through
the same bpf_func_proto field, which lets check_func_arg() take over
the ARG_PTR_TO_BTF_ID case.

arg_btf_id[] shares a union with arg_size[], so an argument cannot
store both. The scalar-struct memory fallback keeps resolving its byte
size at verification time, as it does today.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   | 12 +++++-----
 kernel/bpf/verifier.c | 54 +++++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1f78746e0601..fe6ab92ceeff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1020,13 +1020,13 @@ struct bpf_func_proto {
 	};
 	union {
 		struct {
-			u32 *arg1_btf_id;
-			u32 *arg2_btf_id;
-			u32 *arg3_btf_id;
-			u32 *arg4_btf_id;
-			u32 *arg5_btf_id;
+			const u32 *arg1_btf_id;
+			const u32 *arg2_btf_id;
+			const u32 *arg3_btf_id;
+			const u32 *arg4_btf_id;
+			const u32 *arg5_btf_id;
 		};
-		u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
+		const u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
 		struct {
 			size_t arg1_size;
 			size_t arg2_size;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5b394e847e6..b6e36df72d13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8793,7 +8793,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	int regno = reg_from_argno(argno);
 	enum bpf_reg_type type = reg->type;
-	u32 *arg_btf_id = NULL;
+	const u32 *arg_btf_id = NULL;
 	u32 key_size;
 	int err = 0;
 
@@ -12082,13 +12082,18 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		   const struct btf_param *args, int arg, int nargs)
+		   const struct btf_param *args, int arg, int nargs,
+		   struct bpf_func_proto *proto)
 {
 	const struct btf_type *t, *ref_t = NULL;
+	const u32 *ref_id_ptr = NULL;
 	argno_t argno = argno_from_arg(arg + 1);
 	const char *ref_tname = NULL;
+	u32 ref_id;
 	int arg_type;
 
+	proto->arg_btf_id[arg] = NULL;
+
 	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
 		return ARG_PTR_TO_PROG_AUX;
 
@@ -12116,7 +12121,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			reg_arg_name(env, argno), btf_type_str(t));
 		return -EINVAL;
 	}
-	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	/* Keep a pointer to the BTF field containing the resolved referent ID. */
+	ref_id_ptr = &t->type;
+	ref_t = btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id);
+	while (*ref_id_ptr != ref_id)
+		ref_id_ptr = &btf_type_by_id(meta->btf, *ref_id_ptr)->type;
 	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -12239,13 +12248,21 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_release(meta) && arg == 0)
 		arg_type |= OBJ_RELEASE;
 
-	/*
-	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
-	 * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_BTF_ID
-	 * looks at where its register came from, so leave the other kinds alone.
-	 */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
-		arg_type |= MEM_RCU;
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+		/* A __map argument names a vmlinux type rather than one from
+		 * the kfunc's own BTF.
+		 */
+		if (is_kfunc_arg_map(meta->btf, &args[arg]))
+			proto->arg_btf_id[arg] = reg2btf_ids[CONST_PTR_TO_MAP];
+		else
+			proto->arg_btf_id[arg] = ref_id_ptr;
+
+		/* A KF_RCU kfunc accepts an RCU-protected pointer where it would
+		 * otherwise demand a referenced or trusted one.
+		 */
+		if (is_kfunc_rcu(meta))
+			arg_type |= MEM_RCU;
+	}
 
 	return arg_type;
 }
@@ -12271,7 +12288,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
+		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs, proto);
 		if (arg_type < 0)
 			return arg_type;
 
@@ -12923,10 +12940,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
 			continue;
 
-		if (is_kfunc_arg_map(btf, &args[i])) {
-			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
-			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+			/*
+			 * gen_kfunc_arg_proto() resolved the expected BTF ID
+			 * once. A __map argument names a vmlinux type rather
+			 * than one from the kfunc's own BTF.
+			 */
+			ref_id = *meta->fn->arg_btf_id[i];
+			if (is_kfunc_arg_map(btf, &args[i])) {
+				ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+				ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+			}
 		}
 
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
-- 
2.52.0


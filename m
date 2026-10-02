Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EC48382C
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945265; cv=none; b=PjNEcRL5ECdNUMGHGUJQXdt1kLmijVj2EiNEp9kzYmwILM+SmUxv2cPZq3UyepE8dDh41PBSMGCNOs3lJZMnYYDSt4LGEfCvgY4RCHPlWEm/BqqOLpVLAKHLRlCZmmJl1WbLg4tYidqlrMbOwU0pRjGNpBqo3l5cfGi5VgguVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945265; c=relaxed/simple;
	bh=fVoa5FFdEpTsPAaYdOL3sUow0aaticEn1RxLrRHgPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLnnr1CF8q4EY9PAnRX9ku8mtMymCUIt6CT4un75nXKJ4dIBpwfcV0I8RVkn3uqJkE+oedDyS/xiXWS1axXECacTIcRDMEaZ2Ow/odBNSKCdvhgEKCW6xsBz/c7ZYuUr2oqTdZQKiBoa8D6KM5EE2La96pi1iWVJEKi5/0YTSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkk75w55; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkk75w55"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so2305531a91.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945263; x=1791550063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JORCgLRdBAWYfnPFtHUXchWkMBuOAZ30jdO8B2N6V+k=;
        b=Hkk75w55xFgdYBNi7LqnqVEFekveqVvcJV4hT8XAOpjnx9OiV2fFRI2Md4dYjXdxoE
         Uv1heO0AwIbI6oBSHz8iWYXg8bbpyQgte9lhXEoABBGTOE9eSHgbrLiJd+iaZ6dl07Za
         u7HNrsNPlsP3y3BLcYo4XsHZ7r/nHlcTPTEI3rDDOjiHYeMF7cs9qmwr5XUl7L8uSqWM
         bYtbu9FszsTHnP4K7fhBudxo5hk1NYWyiNnKOtwW0MNXWUgKWmNcfPpbN0rT9LXyxbtv
         gRtOfKy8s8jRJTG/RLoOlgWdV/ZnXrm55y1t8Av6Q2Xpc8TG9uIL/A84b+b2hQSg5cbg
         jrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945263; x=1791550063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JORCgLRdBAWYfnPFtHUXchWkMBuOAZ30jdO8B2N6V+k=;
        b=M1SMwBbwiTnwovWGoEpeqmcP3GwMzfCeax9ypwno11fSTsW2e9X8AJEchV41xMQ4py
         J/BGiWRpbdUS0S861jHilLfpTaxZg+bB2tLLNHwbysLbLzXy9jtI9Jc0PsnarqM5Nd0e
         tOvO4Nbj4/J1MwadvjqU2UHmCotk9ufcxF7WkusOipfBNqg3NtjvXRVs0D+xq00z8PqW
         xK7wJJY89k7HEuhfq9emB9aFsudlyDzOLbuXnH6ZI/yMJcJZQQ7yEV7sd4qbZ2dhQgON
         A34ex/Lzds0ehcmDKIdgxp2uOXWynI3N2kJ9JmQZE79CnfqqwqBwV/lKmJcCLZp6iGtB
         LmzA==
X-Gm-Message-State: AFq9FYIGgzYDSmtwrV0staTahuHwnZqKnqQyRJLfJbZxUMValUp+XTTL
	Bl7dU5RIjcppLuNlldTt75aAiXF2R8GPKwF9XjXXXbKv1I8swzwij9dQ7LqT5AZacd0=
X-Gm-Gg: AYBFou2g8/igmH123/8ObyVnElrIQSLMowY3Rvay6tau7SbhReDTtUAstTm2rDW6Vzy
	SWN/yOwmSPtQmkVgZwc0SCt4l+tMoPFvhBTsOeJ7NYLSO4jnlCWbtEgCyosyLZy5rtFhgvi7p+m
	e1G3dMCaNMzgoMz/JZh+ODru5Cdii9wVJBFPHmQ/6aSx6q0DU6AIxpQ+LmE2WevmURR/ZWlsPBa
	dMVStwja10yUxuZjKtPUN0LX8KBJWgVeMnJicJdJ1M3JuTmaItlrGBrw3pOzpPYQX21MTCqutsa
	A6rlVC9pLhmIzsCEpiifmfd+DZ1lZzqX8f69AsFLUwRvEVdXVc93uDWrIVVTE0uLMX5ApUFZWxj
	BHUlnr3559Fu+JYs3oryih+z+Upyj8VooLqiDH5XZj5FLbd+qvx/yCxYnJZ+AcMYTA1EtJf4sgs
	osVipZSf365B6WCqpfHo8pe6nIEZ+WN3TLhro+jG3uwtTPFjo+5Oy3Eeh/9d1qZxY7yJDkkDsvO
	7HkEuOBG8l+O9ZiM35VQJ8vioLmv1+kcLjD2JZDDkNdXzymNXEg8cTqynZvcZ7LT2nIzDmeyeFb
	Snt4OUQ4GWkTQDzuIDeAQpA+4IQ99MepqAr1XLJeDTQ=
X-Received: by 2002:a17:90b:5483:b0:3a4:b509:88be with SMTP id 98e67ed59e1d1-3a6ce981729mr1455782a91.15.1790945262975;
        Fri, 02 Oct 2026 05:47:42 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6f734ae3dsm795135a91.2.2026.10.02.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 09/15] bpf: Allow a variable in DATASEC that is smaller than its type
Date: Fri,  2 Oct 2026 12:47:08 +0000
Message-ID: <20261002124714.180012-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM splits a static of a Rust program into pieces. Every piece is a VAR
with the type of the whole static:

  [223] STRUCT 'BpfCell<core::option::Option<...>>' size=32 vlen=1
  [236] VAR '..scx_cosmos9TASK_CTXS.0' type_id=223, linkage=static
  [248] DATASEC '.bss' size=0 vlen=9
          type_id=236 offset=24648 size=1 (VAR '..TASK_CTXS.0')

and the kernel rejects such BTF with "Invalid size".

Allow it. The size of a variable in DATASEC is used in two places:

- btf_find_datasec_var() looks for timers, spin locks, kptrs and other
  special fields. btf_find_field_one() skips a variable when its size is
  not the size of its type, so there are no special fields in a piece.

- btf_datasec_show() prints variables by their types. It would read
  past the piece and past the end of the map value when the piece is the
  last one. Don't print the pieces.

"global data test #8" and "#10" in prog_tests/btf.c expect "Invalid
size". BTF of both is loaded now. The map of #10 is not created, since
its value is larger than the section.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c                             | 31 +++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf.c |  9 ++----
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c9d4b709380c..0630675377aa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5397,7 +5397,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 
 	env->resolve_mode = RESOLVE_TBD;
 	for_each_vsi_from(i, v->next_member, v->t, vsi) {
-		u32 var_type_id = vsi->type, type_id, type_size = 0;
+		u32 var_type_id = vsi->type, type_id;
 		const struct btf_type *var_type = btf_type_by_id(env->btf,
 								 var_type_id);
 		if (!var_type || !btf_type_is_var(var_type)) {
@@ -5412,16 +5412,16 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 			return env_stack_push(env, var_type, var_type_id);
 		}
 
+		/*
+		 * The variable can be smaller than its type. It's a piece of
+		 * a variable that the compiler split then, with the type of
+		 * the whole variable.
+		 */
 		type_id = var_type->type;
-		if (!btf_type_id_size(btf, &type_id, &type_size)) {
+		if (!btf_type_id_size(btf, &type_id, NULL)) {
 			btf_verifier_log_vsi(env, v->t, vsi, "Invalid type");
 			return -EINVAL;
 		}
-
-		if (vsi->size < type_size) {
-			btf_verifier_log_vsi(env, v->t, vsi, "Invalid size");
-			return -EINVAL;
-		}
 	}
 
 	env_stack_pop_resolved(env, 0, 0);
@@ -5434,6 +5434,16 @@ static void btf_datasec_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
+/* A piece of a variable is smaller than its type, which is the one of the whole variable */
+static bool btf_var_is_piece(const struct btf *btf, const struct btf_type *var,
+			     const struct btf_var_secinfo *vsi)
+{
+	u32 size;
+
+	return IS_ERR(btf_resolve_size(btf, btf_type_by_id(btf, var->type), &size)) ||
+	       vsi->size < size;
+}
+
 static void btf_datasec_show(const struct btf *btf,
 			     const struct btf_type *t, u32 type_id,
 			     void *data, u8 bits_offset,
@@ -5441,6 +5451,7 @@ static void btf_datasec_show(const struct btf *btf,
 {
 	const struct btf_var_secinfo *vsi;
 	const struct btf_type *var;
+	bool comma = false;
 	u32 i;
 
 	if (!btf_show_start_type(show, t, type_id, data))
@@ -5450,8 +5461,12 @@ static void btf_datasec_show(const struct btf *btf,
 			    __btf_name_by_offset(btf, t->name_off));
 	for_each_vsi(i, t, vsi) {
 		var = btf_type_by_id(btf, vsi->type);
-		if (i)
+		/* there is less data than the type takes */
+		if (btf_var_is_piece(btf, var, vsi))
+			continue;
+		if (comma)
 			btf_show(show, ",");
+		comma = true;
 		btf_type_ops(var)->show(btf, var, vsi->type,
 					data + vsi->offset, bits_offset, show);
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 642800b80c74..24ab62b2834a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -424,7 +424,7 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "Invalid type",
 },
 {
-	.descr = "global data test #8, invalid var size",
+	.descr = "global data test #8, var is smaller than its type",
 	.raw_types = {
 		/* int */
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
@@ -457,8 +457,6 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 0,
 	.value_type_id = 7,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Invalid size",
 },
 {
 	.descr = "global data test #9, invalid var size",
@@ -498,7 +496,7 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "Invalid size",
 },
 {
-	.descr = "global data test #10, invalid var size",
+	.descr = "global data test #10, section is smaller than map value",
 	.raw_types = {
 		/* int */
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
@@ -531,8 +529,7 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 0,
 	.value_type_id = 7,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Invalid size",
+	.map_create_err = true,
 },
 {
 	.descr = "global data test #11, multiple section members",
-- 
2.55.0


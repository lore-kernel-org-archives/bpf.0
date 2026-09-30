Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D74052B7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796720; cv=none; b=u0sa2JsV/GPLdmO4HfXhp9lV+P1awyKcynW94xts5J40VHfKzm4WgaJ7TwMCYXAAAkuV/FWcQdqgStHZ4G0rhoiCmfyF7uvq6ydXumNt7AhGL+mvqHDwQRFwihZpBJIQDoNPe2iALMEqJYfOIt8+95X7gR5SCFXHvcPvqzpurnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796720; c=relaxed/simple;
	bh=GdAWnQ4NLEm8NC+KJXOxVxUR++yV1p9nUxnFr74CiIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYImFcW7L4DCDuvZHa6kokb+lJ9jaZ2MAafTbFmJ2x6wqMtvsvkJEeRdcReKZAqX2Mze5m6H0wHNUkF6WoGJO4ejGGQZycYIHxexO10DhsKXlGezi2ANLxJ6SVFSh0xbdbBZk2AKeMbx4SVJLtbghq+vOFsbokgFUE9aFZW/SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee18+kpP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee18+kpP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so37279175ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796718; x=1791401518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+s+0RuFdjApUe3ACCU5wUCo/iYGpPvyntto9ZnlujVI=;
        b=Ee18+kpPwTbnmuHRCERSDJWA+3ps7ltEIP/kraMszzuH5tWmAppPIh5qhfa6vZFe/s
         Ejn/5OhUx5XReHb527V+qSfWqzB7aNQPrY2y4X7irQKa0iOlN4j+05bNElMyze8fRnTg
         7kXwBSHFViEfvXexF6o94eJQ5gHM/fuH85BxXqawOkuUnhXOPyPw3Go+/IW09+xdMUE7
         +cPpruq1dP4GgDyhZOr7Ls7w87gpHbBc8NrWnsOBRyI0X/7dU1VzknUHLFRr8uv65Sc/
         EHkF3TTXMe9PrA+L/4zt5H2q35UFk0C520QfWrzTBUfUnBSm2wZRzgBx79XnZhO9UbDj
         eCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796718; x=1791401518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+s+0RuFdjApUe3ACCU5wUCo/iYGpPvyntto9ZnlujVI=;
        b=SU2kHZp8i8RFp4ymO3zI0MfdlWTs4iYupl5t7I8vbzWUs4Qgqvpm0odHZiuAQUHsJW
         zYqY1CbcXQuXObN0lNeRqeWJ1LTM4ZFS/2pqrfG3fuDLqjuR6LXVx7sLZVyqGsdTex+W
         zWsRIJb/stDqeofsO2zE/JMjqv12t6Z2kpa3zXh4RsFswOJSlnjXkKijwmvsx1clveAZ
         GOFUhths+2/ib/WCR3IbXDXvxtRmBUb3220Py7r3FTSbeFfjAl4fgeYA7JY+g0ZyoVI7
         FHqCpRV56XHceYYZxC7qbXksZYZxJEFo7MuQEzde1BKm1LbbzV3bgx0vc1wiiIjoe1Qs
         Y03g==
X-Gm-Message-State: AFq9FYLhEo1NKnU03bzCY1dDEgNLEdCiJEDofxcSXf9wS3cuNcTd8j6u
	sgxIAT57N5ab3KxcXqLqaRoqkOk/MZnrcI8WbvIxk0Ty1unXxXRc02V0wWkmvMPH
X-Gm-Gg: AYBFou2xG0GfH8fYw2QQWQ4Muiwag6O7zAUjHbmRqaKFaWZ1fxwyaWxW6ubd5EYHukB
	iiXNrqT7IMf3hRb+zncv637rp11ge6qOVHpya4wLech/g1eMo9N11yB0Z6aBtQ5yCZvBS8ZsfCD
	JhF0/3djmLzhrm1+VzrVm9Bq/JKrdoAjiw85gAKLktCDNPSdtRwM3bTZA0e4fjP+Hf9tNvmsK6k
	vztNekC9gwAPmUibxpx1UmmHsYnx+qhEY2l8nWbfLPDuDpGuwywVlRP7U5FoAtROxgundfeIp8j
	/ObxolCPHtP1VdIwnY2bcT0FjuFtFMR1Xh7ZNhEq5HwU2M9XtYvZJHBEeTBEd/XiNAQH95XMxxp
	mwxgfgQjx4+H3XdtYDnFIQubxvlCR3gFYdOWK/MHvmQhBL8t3p9NtQTKRQyu1+L45t6zk8WWIb4
	olhSfbdQaI2FQ61aaT50pIljW9AryZCrs91eMK+pY0kQR2x8Asxl6NJUEhanYJO4Xa2cKQ9E+Ni
	0l3bbPO35NK2LhcxCGqx+dJPe3jQa8AdUpDIKjlTD6/BxrmFzh5oXakT55pAoUrELpXvQxGO/ie
	0nBELQrpPgtjKtHyiFhqeONF8omf1PIyndYRtCoZ3Io=
X-Received: by 2002:a17:902:f68e:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2e2f3ca8b4fmr9750005ad.3.1790796718275;
        Wed, 30 Sep 2026 12:31:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b851b9sm1600755ad.78.2026.09.30.12.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/14] bpf: Allow a variable in DATASEC that is smaller than its type
Date: Wed, 30 Sep 2026 19:31:22 +0000
Message-ID: <20260930193127.2181684-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
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
index 751cb14c1949..2c27224a0bfc 100644
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


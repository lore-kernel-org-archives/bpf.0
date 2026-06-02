Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78273090DE
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360894; cv=none; b=jDSNH4t28dp4aASLnsId4+Fs9MiyiumzkN3enmcWVIoW7ToE56TZRBXp/zQZWDCJhapGqKA9U98Go5jGmGR6TrMp0g4HAK/N0hy2P80eoddta5g7j4RzKYGwHTLg7uxWSrLh7Zlo2Nfn7GfUnEQYB/80FHwHTIO87/HqwD55NdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360894; c=relaxed/simple;
	bh=JveFWAub4r3x6WDAj354Lar7xh+eomF00yWXx0/QNtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seEoLaa4a+utavtuYenm9kkE1YC/WCZWpdoHMrhRAK9jHq3jFj7PxbJsqpBNV1M4iY3B6iiNVbUuZgy3bobiPC11ViiLCYaR19om0rcnD24lR11f+PDVlm92FdLIidcC1c8zROsq/qRg5ziyC33j6S/mS9j4Ij19P3k41Azi+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kAy9Jmew; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kAy9Jmew"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304d555293aso6937165eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360892; x=1780965692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt53YMxTh9CHtOv8p9oDekJQoD1NWgCxt93hk4crzcs=;
        b=kAy9Jmewc8HxDuL4v8q1RBStjrRhL+kBe0ABoal2p0+WLqSLprlGxpAgca7UnMjL9I
         QVDSA3X/gBmcio2H2IY6xLBLDKECqYOxoEIH/J2nAMcWecJMHwCndkbjtI6aWW1/eDa1
         KrCTb3G+dag3meoUIisqmjj/Xlp4HPsrPxdeoRrw0UkDFBk/4M7EbtbhcC0OicCN806r
         d6xepNug0jQ/oqxPGcHXfpICwbUwvQnVBQcoRg9BxgGMV76MPfEtyMXl8w3yJgKaKz13
         OrkNiBxWg3qZ6CRoA5rhTi4gYKPWk83/AUV/CK2T8YNVvqsMSvK5harmwajLqAL4d9P2
         DR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360892; x=1780965692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mt53YMxTh9CHtOv8p9oDekJQoD1NWgCxt93hk4crzcs=;
        b=RsP+iQXHunlk/Re8dFStyKL8Vk8wqHid0+GNzkANDDi0c4tCfXvsnwUdWXxa9eHPYa
         khc4lyJzOr2lHVDqBvE44zkJq9NcMJrBUISdHoi64km+nvbvNJ+9sd5PWrkg5hTMW+jB
         IiQzxW/ivAGcK6dvOH2ou/3Yo72ecw2jjQlmBmOyPadaZODlVgGOe1TbXwKhBp88PyFD
         h9wG7eVrOdyfTkpVVEQuUCWwExho1SmTCzQ+2mBcFHO/o680hSbaf+pjRLkOu3VIdtPf
         KUe7Gur02QAYMnHQTNNVk0fR6FBPCUPQsKEZlm642ffd5YsC7g6fWfTJEff2ipImtuSA
         58Wg==
X-Gm-Message-State: AOJu0YwrivyrJx02jk0ZG75ZXX2Ta9wTgg1fTlo5BndLXzFW/AdfmTY7
	0DxWbRwpXm9MJuNvQK3M+liYla67XAjcOmIeHVSCj4jzNxlaNdJjiJnhT/FLnqi0/Ac2N0Emh5w
	+T2Dc0X8JW7tc
X-Gm-Gg: Acq92OFUNO2TMJQaPfyUx5+Kd1nfSBR9XftFnFKfUDopM4TUPlxA2ukHgkZo/cQFtMe
	HS9Gr5L2bdwXN6p9ep91Kj461JvHx1/A44HHwi/OSGRmEljGt21Imm/yDEk5XJn3YExhFzKu+Y5
	Cfi++F3glkvGRlLEAXK3T6XLMe684Q+MQiIygyW8vipvFk4XcgohRYeSeo5XGT2IKc8G3xqaUDB
	bPFIMr+exYPrOwWxQb3+RRET5BRUoh8Q1xr5Ir3zeUtzvqXE2xGXesSQ0y25VOQ1I+ztzjFl8WL
	f6vdI1z953TNUY9ntGx1XIMzSGJGFP4CEpwPiaas8BSh7wrAJzBy7LagGV0kK6SD2zzbFx6Z7K5
	ZgvR+e+BggxWswWpGUcI9/4A8MeP2exAwR4nP+JB560ROs0LLzVRKLQVnYM5t2xaqSHObSTJqe0
	TlkoHHcqNEMYfV6MiWt/0UthlxdLF+TR0yt3SG9h0+
X-Received: by 2002:a05:7300:3708:b0:2ed:27a3:eae2 with SMTP id 5a478bee46e88-304fa527021mr6900400eec.15.1780360891819;
        Mon, 01 Jun 2026 17:41:31 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 3/6] bpf: Allow subprogs to return arena pointers
Date: Mon,  1 Jun 2026 20:41:17 -0400
Message-ID: <20260602004120.17087-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
References: <20260602004120.17087-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogs currently only return void or scalar values. However,
it is also safe to return arena pointers between subprogs in the same
BPF program: Arena pointers are guaranteed to be safe for both programs
at any point. Expand the verifier to permit returning an arena pointer
to the caller.

The main subprog is still not allowed to return an arena pointer because
arena pointers are internal to the BPF program, and the return values
permitted for each main subprog depend on the program type anyway.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c      | 66 ++++++++++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c |  4 +++
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c6a930aca67e..3bd44a22dd06 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7858,12 +7858,22 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 
 	/* Find the first pointer type in the chain. */
 	t = btf_type_skip_modifiers(btf, type_id, NULL);
+
+	/*
+	 * We currently reject type tags on non-pointer types,
+	 * which neither LLVM nor GCC support anyway.
+	 */
 	if (!t || !btf_type_is_ptr(t))
 		return 0;
 
 	/* We got a pointer, get all associated type tags. */
-	t = btf_type_by_id(btf, t->type);
-	while (t && btf_type_is_type_tag(t)) {
+	for (t = btf_type_by_id(btf, t->type); t && btf_type_is_modifier(t);
+		t = btf_type_by_id(btf, t->type)) {
+
+		/* Skip non-type tag modifiers. */
+		if (!btf_type_is_type_tag(t))
+			continue;
+
 		const char *tag = __btf_name_by_offset(btf, t->name_off);
 
 		if (strcmp(tag, "arena") == 0) {
@@ -7873,13 +7883,39 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 				tag);
 			return -EOPNOTSUPP;
 		}
-
-		t = btf_type_by_id(btf, t->type);
 	}
 
 	return 0;
 }
 
+/* Check whether the type is a valid return type. */
+static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
+		const struct btf_type *t, int subprog)
+{
+	u32 tags = 0;
+	int err;
+
+	err = btf_scan_type_tags(env, btf, t->type, &tags);
+	if (err)
+		return err;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+
+	/*
+	 * We allow all subprogs except for the main one to return any kind of arena pointer.
+	 * General arena variables are not allowed, since it makes no sense to return by value
+	 * a variable that's on the heap in the first place.
+	 */
+	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
+		return 0;
+
+	/* We always accept void or scalars. */
+	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -7963,18 +7999,16 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function is void or returns int, exception cb also requires this */
-	t = btf_type_by_id(btf, t->type);
-	while (btf_type_is_modifier(t))
-		t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)) {
-		if (!is_global)
-			return -EINVAL;
-		bpf_log(log,
-			"Global function %s() return value not void or scalar. "
-			"Only those are supported.\n",
-			tname);
-		return -EINVAL;
+
+	err = btf_validate_return_type(env, btf, t, subprog);
+	if (err) {
+		if (is_global) {
+			bpf_log(log,
+				"Global function %s() return value not void or scalar. "
+				"Only those are supported.\n",
+				tname);
+		}
+		return err;
 	}
 
 	/* Convert BTF function arguments into verifier types.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..1ded44652c83 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16645,6 +16645,10 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	if (err)
 		return err;
 
+	/* Pointers to arena are safe to pass between subprograms. */
+	if (is_arena_reg(env, BPF_REG_0))
+		return 0;
+
 	if (is_pointer_value(env, BPF_REG_0)) {
 		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
 		return -EACCES;
-- 
2.54.0


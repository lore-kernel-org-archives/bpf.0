Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A603750D5
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812245; cv=none; b=DQ6X44sWwAlroXUuRs81H4MzstPm9Ad1KzfPaZ0R7l8f3x6ZxmhMr+P25pj1nuWGZAjGwuYppy/a2d4mmccrAepBZhviQsh96hdQBm2ivHxH15xHtElz2C6ri+jeBiBKxKc9nmh3aYAEPkWiNTji/45Rcp8TVCU3CygoByb+FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812245; c=relaxed/simple;
	bh=eAyAH4EzLiX4/J/hrELdv5ktgvGkoWa3GwoXBLJmvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFpA1mgPAN1duUOTC1EQGeH5LW/bZqaxUgqILmFSrfxyO/7V/3ROULRUwiUn1IeRjDD5pVOstjKGS45h+DshENyJO5Zn50u+yPDvZlO3Gr032Er7hBN/g55nYorpJGysitUxqITmnzXyq7iV5X79sbWWT7VGQqd/1x4I6XktbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKnlhF/k; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKnlhF/k"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8216bf5eb5eso1094501a34.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812243; x=1792417043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mvcoad9nzU6IXoC8dz4R0nkhuXSbXc0wlp9oQqAjttc=;
        b=HKnlhF/kB87aLtskLR6jdFzdOpabZ2cXOqtFhAZEQWdygKl6Hf88iaTGNUDqrAPS2W
         4eNXkpM4Gm9YJXS1VtLyt2dBnm+NsL/nxZ29EFjOAUTQK1hdmpVDlmJtYIuR7TqtFIGp
         ZMqXt2i9mR33qqxZPYrIn04CoBsbl8deC/vZDG0zSjg3nDJehpVvAwgsW1I7lvtZEyut
         utirnkUgcWL6PdKYp0M1GDr46w8TzCD2xjhJZZTdE7jr6GVmSNExcfvCXAUiBHWQJeAL
         bgov/iOiwcQ45/1TSVejTRGulVIyNsUOuviu5DYeryqHi3WP5II6HHIouJXUWtem4UGc
         x+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812243; x=1792417043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mvcoad9nzU6IXoC8dz4R0nkhuXSbXc0wlp9oQqAjttc=;
        b=jKCEYrwj5CO6YORPuKCTFgiXR0jlzfuqnatKcjS3Vdu10UeuPLp/+rumS0SOhuvrl8
         2LIEU6s2ygIvE0y6a9+AN2/1cHBzrnteLa3uefsuX258ULNVQHc1apleGDvqdjJjHfIc
         YOTjG1rzv/+oqvNAfHZu/4GTnGsGO31Kk6Xb9Gw4ZT9ePUK7FwGkzK1Fvzpim5BNS5wU
         w+ebN0h/CtBIVPP3JWawg5dS6pNxep4TrpxnDeBL07KGgNjY6tvXv2jl9SjzxN/cyO0I
         e/mqhTLAX8Vghu88KKWWBclFCtBxA1hIWe9qyF3vJ0CF9FdDukr69s2IXJ/M89LNQ5tV
         uLeA==
X-Gm-Message-State: AFq9FYJTzCp0lK1EAH/jhfUhT8RwOx2rzhgm7ij5f9bQWVevA1D0mxuk
	y1YqK+HRmYk6CfZWlr8rn9d7wkToE2IM/LwFm956hKreHdf/FeVvaDNemK6qocMsN1c=
X-Gm-Gg: AYBFou06OPfIKgeed0Ry0/PB+1oOYwKOM/UV0/Mh89MmbFFKStm1c3od2fewtF8JYyw
	1P9Iz0IN8z8r57ERc1Bbg0utNjbh3Rf8Q+yAmoXg32Mefi9YYwaO/hzYatFa+fZHStAcx3PGtC7
	rVOyplSUA8aXY6XoMZVRtzXGBSrjO1e6db2bnjfFPDFeTjcjvXprmgI/R6UduRZc4yP8+kmE7Fs
	ee+2KN/HIhTQwWujG6BqPas3gTrvfGc2TfEhjgx1AviY9P9s95vWEhmBCXsBIO8En/JjLvY+lTr
	lTEz5OPGj08AbPmG5VfQCk945OsKwbXW3X0XjbGmmWGeBbuCToAEG/EHu3jK7Mm41vOeduFsaMu
	nDjZvfSpNxrccz2fmy1TrV4t+xTP8MLmon6iS5quBBaIpx4R1FI4xNm6Viw6KoHLMFRpbzKJrDe
	KDbqiyhS9D+A8zBSbmvyKpu/dyh92+i7cjCZIC3tPy5pL5cJWWnddd8DMt10MeU9u56gtocvDlI
	VXsOo+ftXB2GAkieY2nRa+SkGXcxon9aJmcw18bs8/f46coyAWJvUfDu7lnbupyrX6Od+PCdPaX
	Etssgw==
X-Received: by 2002:a05:6830:258a:b0:813:baf6:c644 with SMTP id 46e09a7af769-8309797b5fdmr9281374a34.26.1791812243062;
        Mon, 12 Oct 2026 06:37:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303916e485sm10916636a34.15.2026.10.12.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/10] bpf: Recognize __nullable on pointer members of kernel structs
Date: Mon, 12 Oct 2026 15:36:59 +0200
Message-ID: <20261012133711.4030594-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4020; h=from:subject; bh=eAyAH4EzLiX4/J/hrELdv5ktgvGkoWa3GwoXBLJmvVA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMwzUz7rQLGE45UbFj9bIYh+c3dvsGS700l3hc521sLq3g qrKoo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZ84CR4dYy8e1TnO88sl+qXd9cqH hczNvT2CyEp1haZX3y+W2J4gx/JW6az5s5y6nNJqD6U/uUSeeZAl19ldlNL5j1FsyyWSnJDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A pointer member of a kernel struct that the verifier derives as trusted
or RCU-protected is assumed to be non-NULL, so a load through it is a
plain dereference. The BTF_TYPE_SAFE_*_OR_NULL lists exist for members
known to be NULL at times, but they live in the verifier and have to be
extended by hand.

Teach btf_struct_walk() to report the "nullable" BTF type tag on a
pointer member as PTR_MAYBE_NULL. The tag combines with any other tag
on the member; it only says that the pointer may be NULL. The verifier
keeps the flag where NULL would otherwise be assumed away, on trusted
and RCU results, so a program has to check such a pointer before
dereferencing it or passing it to a kfunc that needs a trusted
argument. Untrusted results are probed anyway and lose the flag, as
does anything walked from a map pointer.

The next patch uses the tag on __arena members to decide whether the
injected address translation has to preserve NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      | 18 ++++++++++++++++--
 kernel/bpf/verifier.c |  9 +++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b09c04ccdc6d..bcbd49c7ca0b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3557,7 +3557,8 @@ static int btf_type_tag_walk(const struct btf *btf,
 	return 0;
 }
 
-bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
+/* Whether the pointee of pointer type @t carries the type tag @name */
+static bool btf_ptr_has_type_tag(const struct btf *btf, const struct btf_type *t, const char *name)
 {
 	if (!btf_type_is_ptr(t))
 		return false;
@@ -3566,13 +3567,18 @@ bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
 	     t = btf_type_by_id(btf, t->type)) {
 		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
 			continue;
-		if (!strcmp(__btf_name_by_offset(btf, t->name_off), "arena"))
+		if (!strcmp(__btf_name_by_offset(btf, t->name_off), name))
 			return true;
 	}
 
 	return false;
 }
 
+bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	return btf_ptr_has_type_tag(btf, t, "arena");
+}
+
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
@@ -7961,6 +7967,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			id = ctx.id;
 			stype = ctx.t;
 
+			/*
+			 * __nullable combines with any of the above: it only says
+			 * that the pointer may be NULL. The caller decides whether
+			 * that matters for the register type it derives.
+			 */
+			if (btf_ptr_has_type_tag(btf, mtype, "nullable"))
+				tmp_flag |= PTR_MAYBE_NULL;
+
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..70fd44a6e1c5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6721,6 +6721,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
+	/*
+	 * A __nullable member only matters where NULL would otherwise be
+	 * assumed away, on trusted and RCU pointers; the rest are probed.
+	 */
+	if (!(flag & (PTR_TRUSTED | MEM_RCU)))
+		flag &= ~PTR_MAYBE_NULL;
+
 	if (atype == BPF_READ && value_regno >= 0) {
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
@@ -6785,6 +6792,8 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag, NULL);
 	if (ret < 0)
 		return ret;
+	/* Nothing walked from a map is trusted, a __nullable member changes nothing. */
+	flag &= ~PTR_MAYBE_NULL;
 
 	if (value_regno >= 0) {
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag);
-- 
2.53.0-Meta


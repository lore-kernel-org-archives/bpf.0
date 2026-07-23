Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5830FC21
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783296; cv=none; b=XAZ85OgmGKoOu7ZdrjocRLzTd29niEwkVdI8ZwtGwwHC1V1q76N72VNtdtX7CrZ2l5tVLkeB8Az7DOQTONOv5MkIMzZ50UAyZKebjqKmMweDdL3enYHRmVpvew2ipH+ppLhyFE7cAv3qzdJ9GzCwfaER0It4NppoeU/2tfvsR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783296; c=relaxed/simple;
	bh=uTnvSPvuedKQUMcA1gvLr6jpWpVQbjio/RJB7eAC8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2hVXuLf/KBh7DuaIFx8QHApRqtd2Ry/Df9DvBArQ+/U+1tVm/hEIEwRuYAiJRZmhbSVCVWeu7b8D5h+mJ8rNxaqI7xxXTjokYUKVuu/dZYZa+jZ2w7Mt5q7Dt5pBpC9wSwffW6gVC0GLimUAh5Zvo+hWpbJTboPoqWnNkO1OGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j16gy1nU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j16gy1nU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso164060a91.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783295; x=1785388095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxoSo8DpyeO9Qz7dYrgtA4qAkmnMt0Wk5cRjRQGx+Rk=;
        b=j16gy1nUncZ7+g+hPuHvK7sUgMawkNd7wYd5/8ICSVf4UkyUewQ/OdwWKu8SSKKj4l
         GqT0Ki98DYwXzFa708mU/GFJYIEKQjr0RjgslJEudUEfdwTlP+buMq3syUMNYNJQibr5
         DOfU8pBoY/NHzdNJ6FaYPKx379+1QxJLTUhO15QdfixZRwLOGhwcFGz/H0MY0rVghrn2
         GGu5efObFH7hA3rpmY52bejqj0RnKTbGTswNr33FT4r6Qe++aYTmCfykIWmOCGtROdzT
         PZittM0Y0mZstqtlhOT8Frxv0aNMkrYPy1WpTEJnFj5yKRE0+ib5eremOWwXYnzDFqaT
         miSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783295; x=1785388095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxoSo8DpyeO9Qz7dYrgtA4qAkmnMt0Wk5cRjRQGx+Rk=;
        b=eTxVtoQa0XbBKrtIkErOid0VdiIHR1kjYESxSsy/SPUmzpLfFpVp6EmpG2XCjUvdOZ
         BOL5ZS28a7IUgSV1hWRignxsQB2BGaJABJrxhUcVC0bryAVLQRK0hy6bLpQyY07u38cS
         T3Dp6aXlV+XgzV0qva/URIp1pFN5oby+XKg/FW5zQmkvXEK5dgKKS2OlOzG838AA9f5i
         VsSMjlWkFbDop/ltFJ3UObzxtbKvkWW/06S2JJYoFcN1FZLbySWZCqM2uJYko38zaBm0
         U8sCoyeTQ1WhGssH7hU40VnUYqdQt0qDz8YnMFeOTIxATSBYjxFml/rHlyIAmi3AQZW/
         iw+Q==
X-Gm-Message-State: AOJu0YxBWdu4LFPO4fGp0lDDVpipwp2ILWQ+xTrsYM4gEVUPbD2mcSPl
	vIZJ56JhN2vYOGoLpyZ5Gn7ffqz6wpUfz4LHWT2Tzgvosf++3n02EpdbmvwRlA==
X-Gm-Gg: AR+sD127nn9H8pEETfdzFA0Jhcn2LQUk/iPTwsjMwOcBpmsRIULh+KXK8gXOFp/LUPI
	C9qpcsvXEQ21NpkLePvRxHnaWaLjy3hrHTjlrH9fRNzocQEz19r3pr9+iB/fIwVg1o6276RGK5g
	Vi62/VRqjtAKeNCEzqjAGbFUraW2EUGqwKBBGgDW/fSEL38YJwcodHRjwaduVorC1lG1iH3J8PU
	j5VJOcr8SXVEd+N5JK2HBVjkV5YO3XtlP0LDQ0BY56bEI0X6mNKVvzypF9tGX6xOnAVPU1d+N5r
	TfIPCL8oV6fjDZSgEMXcE36M59mX8QrFpHbKrVIasoBL3/bizmYKrazduoViS7yYDHtMcgcmscE
	K6wzA3A96XRMppxtWUmwufdK3MYvWPfbDqNTVt7llGWEgyJuY9aUgdJR/gge2pNPAdE7v
X-Received: by 2002:a17:90b:2d10:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38ec6632b70mr1509478a91.33.1784783294669;
        Wed, 22 Jul 2026 22:08:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaac56a7sm294074a91.11.2026.07.22.22.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/18] bpf: Check helper and kfunc mem+size arguments identically
Date: Wed, 22 Jul 2026 22:07:53 -0700
Message-ID: <20260723050806.1158442-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper ARG_CONST_SIZE and kfunc KF_ARG_PTR_TO_MEM_SIZE memory
arguments already share check_mem_size_reg(), but only the kfunc wrapper
check_kfunc_mem_size_reg() ran mark_ptr_not_null_reg() on a possibly-NULL
pointer before the access check. That call does more than clearing
PTR_MAYBE_NULL: it converts special map-value-or-null registers to their
real non-NULL type, e.g. a map-in-map value to CONST_PTR_TO_MAP. Without
it the register keeps base type PTR_TO_MAP_VALUE and check_map_access()
treats it as raw data.

Because the helper path skipped that step, an un-narrowed map-of-maps
value could be passed to a nullable helper mem argument (e.g.
bpf_csum_diff()) and read as bytes, leaking the inner map descriptor (a
kernel pointer). The kfunc path already rejected the same program.

Handle the possibly-NULL pointer in the shared mem-argument checking so
helper and kfunc arguments are verified the same way, and drop the now
redundant check_kfunc_mem_size_reg() wrapper. Both paths now reject an
un-narrowed map-in-map value used as memory.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 49 +++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29d45636c28b..6520742d51b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
-	int err;
+	bool may_be_null = type_may_be_null(mem_reg->type);
+	struct bpf_reg_state saved_reg;
+	int err = 0;
+
+	if (may_be_null) {
+		saved_reg = *mem_reg;
+		mark_ptr_not_null_reg(mem_reg);
+	}
 
 	/* This is used to refine r0 return value bounds for helpers
 	 * that enforce this value as an upper bound on return values.
@@ -6910,8 +6917,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			reg_arg_name(env, size_argno));
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
-				      access_type, zero_size_allowed, meta);
+
+	if (access_type & BPF_READ)
+		err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
+					      BPF_READ, zero_size_allowed, meta);
+	if (!err && access_type & BPF_WRITE)
+		err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
+					      BPF_WRITE, zero_size_allowed, meta);
+
 	if (!err) {
 		int regno = reg_from_argno(size_argno);
 
@@ -6920,6 +6933,10 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		else
 			err = mark_stack_arg_precision(env, arg_idx_from_argno(size_argno));
 	}
+
+	if (may_be_null)
+		*mem_reg = saved_reg;
+
 	return err;
 }
 
@@ -6993,28 +7010,6 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 	return 0;
 }
 
-static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, argno_t mem_argno,
-				    argno_t size_argno, struct bpf_call_arg_meta *meta)
-{
-	bool may_be_null = type_may_be_null(mem_reg->type);
-	struct bpf_reg_state saved_reg;
-	int err;
-
-	if (may_be_null) {
-		saved_reg = *mem_reg;
-		mark_ptr_not_null_reg(mem_reg);
-	}
-
-	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
-	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
-
-	if (may_be_null)
-		*mem_reg = saved_reg;
-
-	return err;
-}
-
 enum {
 	PROCESS_SPIN_LOCK = (1 << 0),
 	PROCESS_RES_LOCK  = (1 << 1),
@@ -12421,8 +12416,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			argno_t next_argno = argno_from_arg(i + 2);
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
-				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
-							       argno, next_argno, meta);
+				ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
+							 BPF_READ | BPF_WRITE, true, meta);
 				if (ret < 0) {
 					verbose(env, "%s and ", reg_arg_name(env, argno));
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-- 
2.52.0


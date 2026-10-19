Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B34EB86F
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416145; cv=none; b=FOgiCOgxguRSQGrEgyLhDdCPYt1OpCaaA88hJKqh4rqyKUMHMvUIGMBWa+cuWEDkX0vI/lJutLHHRZ7t4MzCHJtbVK85cJfDVtCQZOdWVk8OdTPsg1HtFOHaGd9DU4XwZUqc20uCe5NJrkk0Vj0w2xLtzbGKel5Qvwz4OSov2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416145; c=relaxed/simple;
	bh=j+HmBS16zscDKk0jsaubZ/DDpJGXsyZdlTXshrUYdt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvENfPVMq0gUn/zVCDHpcx7ZKDNmDCM2Y3SVV8stNIXBbp07aqSH3QXODimLxeLDtrGGeXSRRj64jqclq4VxdhnMXx6tap8gQM5TAkTfmyW6eiKWI0nGmbsU8zE0S8HPWGvRXRI99K8mzraAeMQ4etVYfwLPsgjVhgNep1NRJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wife03id; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wife03id"
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-70399d7f076so998954eaf.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416143; x=1793020943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ84R09gBhcICPFhnTuvEVmiuow2Q8Z9aVX4a/jCuQU=;
        b=Wife03id07h1K6nQl80FF6voBjMKoLoEez2vlK9nQrs28fgRfYlOZO76+583XZBnal
         /hCjtvGwcRUg/LrD4ajnheQH0WEZosmwKxUEaAJJWVgXTkRSa/oV0RndGA8OlPvf0aV/
         ytioupL46gxQa1ADU3BxYDimbPs8B579sHOEpWyPI4LjmepbY3LAnHtk+Sw94hOby97u
         eN0e2iqZozgmOhqxJLnGTPXZ075nUhw9rJaddHPS7sxr+f7311YqltVAKcEBHAtKElzw
         P1OXCElZMj/YfYy51+g19PmIcucVfWKGIEwEGonjyVyK22lHvEOvmtmPQdP7gpvzXBeK
         cK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416143; x=1793020943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZ84R09gBhcICPFhnTuvEVmiuow2Q8Z9aVX4a/jCuQU=;
        b=q8j0LDKOa9Y4V4Fknfi0CFvjAYvcB0OYCC1k6G2k3NA4gGE116Tcb2ip3vTiKI+6Xd
         KawxN1LlcqdPrCkeaD6M3MrK6qmTJniMHSKcRb3rIeNHXaAjp7g0eZbkNCRZfKq9dSCc
         l9Jsowqi88/eLJ8xJ16MIWBqls2GS52aCDRWodJN9HMFm5XmOUovBrzXVDmWQCHU3AIK
         u5DNNpIp4N32EUyu1MDPKxD3msLHieKc4MAkCTwDO1D6C9ijy/gfPx1Z6KkDL46rahMB
         1xVHVDDfPv00lIPtPkhBbHuFR++447I49UoIdVLyeu81qO7lodXmgGUtfqe0hzEwQiSK
         mt9Q==
X-Gm-Message-State: AFq9FYJVwKY5s4oFhEp2A/0ILMkY8l668JHYd3V8p9O2Gs3JhbWWS5ML
	uXKksDI3dbRKtJr+Nq/atRUvy2LOLx7NG3Pbd1Q/QWla1lAwsQnN4bUs+vEOMCIv37I=
X-Gm-Gg: AYBFou1VoRkpU09WCVuJIAP1RR7y+u3OTE5bLiL5+TWExNjj9dJu4DP3e2o1CfdT5GW
	3TizKmpn7nZ7clGAMoUui+IXGL8axSbJQzcNcrfn8YnWG74RNuYHPneWcdpkCPjQFpgqsWfVSUv
	rB8eXEXlRhjCUqXolcFbiq/CzZzsVy8uS754lAzXYbhDUtQAi9P6iBBQDbQaiMosHkRlU1RuaIw
	5xOox4lD6KDgCAmSiMtOzpSHedRZ3IOqTRs1Kw6I+Rny1bSQ9LzLhXMqJ4TQpjiadmoOujgSNqq
	blePE1ZFuE6U6Afbfi8uy8fHr1cLGK6qIj++nxJB7dNfNWACNA+thvOyF+INKHcYzAba+eAfpQa
	P1NJlz/X/j3ZXFn7DaLtavzCD8KE12pbj+jjiL9qbj3QONjvPlpLfwOI93KQW4ipgMTheK0aZkd
	ilHNOPznke5/N7z3waTs+H9YKGVA13hVco3n0H2a7e6R++23r79Pj8Wa0Vq0AZLRr4cjgkfp1GG
	dpEW8bXIPoB8/9QOCmdbKkU/uX2Y8mGC3sh6eIwb+duo9aqkZJvB2SkPo1ZqVFrZOJ+aOAO3B0y
	0cNI
X-Received: by 2002:a05:6820:1389:b0:6e0:1599:a4b with SMTP id 006d021491bc7-7035599145cmr5251289eaf.18.1792416142706;
        Mon, 19 Oct 2026 06:22:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm6800906a34.4.2026.10.19.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 06/16] bpf: Recognize __nullable on pointer members of kernel structs
Date: Mon, 19 Oct 2026 15:21:48 +0200
Message-ID: <20261019132203.3034698-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088; h=from:subject; bh=j+HmBS16zscDKk0jsaubZ/DDpJGXsyZdlTXshrUYdt8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxJGcxP35EquL72tI9B2dtmk6h3YA/84ZEh4mnWkOO2UP 3XnbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImsSGf4zdL3/7vNHOnzk88f8AiWfT n7Q2iiuPGaRLv1Or68d/dMi2JkOLVe4b+90v6niv5h9rzLlyx+JvlyKUv35KtbZG4t4th2khcA
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
keeps the flag where NULL would otherwise be assumed away: on trusted
and RCU results, which a program dereferences as they are, and on
per-CPU results, which the per-CPU helpers shift without a check. Such
a pointer has to be tested before it is dereferenced or passed on.
Plain and untrusted results are probed anyway and lose the flag, as the
BTF_TYPE_SAFE_*_OR_NULL lists never applied to them either, so a tagged
member of an existing struct asks no more of the programs that read it
than a list entry does, and the tag can take the place of the lists.

The next patch uses the tag on __arena members to decide whether the
injected address translation has to preserve NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      | 18 ++++++++++++++++--
 kernel/bpf/verifier.c | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a9bf4c3c0a27..012b6c5c3eff 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3569,7 +3569,8 @@ static int btf_type_tag_walk(const struct btf *btf,
 	return 0;
 }
 
-bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
+/* Whether the pointee of pointer type @t carries the type tag @name */
+static bool btf_ptr_has_type_tag(const struct btf *btf, const struct btf_type *t, const char *name)
 {
 	if (!btf_type_is_ptr(t))
 		return false;
@@ -3578,13 +3579,18 @@ bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
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
@@ -7973,6 +7979,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
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
index ca5301fe3f66..1679ffec431b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6754,6 +6754,16 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
+	/*
+	 * A __nullable member only matters where NULL would otherwise be
+	 * assumed away, which is anywhere but on a plain or an untrusted
+	 * pointer: those are probed on a dereference, which tolerates NULL, and
+	 * the BTF_TYPE_SAFE_*_OR_NULL lists never applied to them either. A
+	 * per-CPU pointer counts, per_cpu_ptr() does not check for NULL.
+	 */
+	if (bpf_may_fault_on_deref(PTR_TO_BTF_ID | (flag & ~PTR_MAYBE_NULL)))
+		flag &= ~PTR_MAYBE_NULL;
+
 	if (atype == BPF_READ && value_regno >= 0) {
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
-- 
2.53.0-Meta


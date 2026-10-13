Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164373A451B
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879632; cv=none; b=MOWcuFpieSMkZh/5zFx5G2NZs29ztNiFI3b/WtjqtIRCXqZYz711mRNoNjIApIsP2AynfsWiX72xYYupWRN/0RKdLnuCG+QewH/OXaho/lDRpJZ0krBsMOV5PU4RZL6Tx+N0Y6TjsoZnqe8TIRLai5p2Em004H/WFrXv/AgEGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879632; c=relaxed/simple;
	bh=GpqJNujkJAJmo/5JzH+cmTzwe8KiXmp2kxjNNMjZJtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giKKK0Lf9jO+CHpmY3uqNoVhEgU7SGCfJ+0hS8q2Hhn9DbVjcYsTUNxSxdDRJKuLINKGsTjP9QfYuN8pyw+O8laXpbXWmZEt1hTeVvVtDkEhHT8OkKIgJYuUDElM7ajwrjbT7XwyIl+FTIdnbJFCUInbj/cr7kE7ZLkprXjARI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJvK8eyh; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJvK8eyh"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-828c0b569f6so1042741a34.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879630; x=1792484430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOF1sErnrPdnBpA+Slq+phAthz9YDwdKX3AdLSvqA6g=;
        b=kJvK8eyhkZYTP5sW/jYPg+ir612naIGu5vQGILscGSHRmI175xcCqurm6oYUVN/hVF
         rfgXqSiu++98U1fFSfbyi7njB8TkVKLa1ZSsQ/InZzdvqcDjgpm+K8Hz+Jmsn22z4JEI
         umM9hSD0mP4hypuQPpM/olIGAK17lS6XlgS+J3a6SUrriaa87SJmk6C9XJi0Iv4bsZoM
         86CUc79dxUR/LrcrK5hgQLTC9/hoiK+bxmUO0EFvNlw2vB8t3ylEpN19kblIobs6lcrN
         EpiteMHjNajOMDi9NA7M80v0Xjv0FjLMo1IhxLjrtIGWFvNFn1OABDK+yNzwfMdKqtFO
         pVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879630; x=1792484430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOF1sErnrPdnBpA+Slq+phAthz9YDwdKX3AdLSvqA6g=;
        b=qE4NxkoKY5h9LSqnfhfsadm14S5PDJUcBsnF2NzsSlVHTSrkD8x3e2QQ/RduFGeJxi
         qcH0AEGonfJGRuNl+tGuJHxxqQ9/w2fXWPS3mQl2frr2YuzhF3eCDQdrEn4PdE/vrQO6
         e4g2nZbCmG9k8CzlIYsbMFg7RtNXcL8S+bHkVh19cbIMGxEmY4sHPBSGW630mXV3nCTG
         5Vq4AEEzMcscit3E5ShtX9JGGnPK4KU4wMr+tasv9cvpDgjFTX3gC5u7pe82IikYFa2G
         KXAyPZo4ddWsLPC2aurMERDc+u85hximEk7ifwW0Y5FgCke86dpAZxowQ46js8MwoV1+
         Y68Q==
X-Gm-Message-State: AFq9FYJDBDdEIzvVu0bXSlIqLgWNm3bWrT31IhX7dXpjScPPzmxL6TlK
	4+N3hmLSs0z09WteoUEenBsJp1Ybg4lUvxvBADZGYHdLvL55w5a7woge+lOjOznh5Hw=
X-Gm-Gg: AYBFou2s3JxoPc9pqTbmb4MOdnpVq1lJiRzEFSg8omtWVSNaYNcRGRwlNmF4bI1smC4
	sKhxy5aLa8ipIQhUelsjlGRn0BeqKk4SmPu9JHlDk/rO+L35wdBDxmDGolUiXk/8vYhj7tMjGyB
	VsbSDCqxQNaeSfwOsu68YAtfckyMHf2wWFlaGfzgE37i55qV+a6zraCio3wfG+Nus8WmFR6WgYV
	B9L86t8DRUQBYFTgRHMPuKZ9FLfAjzEk+Ouhyd+fcbL1wdpyo1sZk9BWhIDK+qOw3q4sSXpnnxc
	t5EEPkWWjNs7PFZpGKjg3toVwbMIezSW0ErtiuRA7axk+5sPpZDxbRpSTD25YvTetPACyUCVWP7
	hgQoErBgVy0SRvylytY7rliD8dZLBxIFul0ToNC3JKZWyaF/fyW0/NHsEfrb04rQa/PXmGVoxy+
	ODAoJAW8N+oTheMdXMA3Pm4Lfgy5VvJCBBrg+hV81pCQKtXurSK5H9so2ji7HFC9AV9KOuv8SP4
	Fq10KbmHGPIQdBsKt3KbMyp8iFhK77mv5CQX6XVtz/r+xGIPeaHxWy/0LY5KQMITJNj38Mo8+8v
	7YO/jg==
X-Received: by 2002:a05:6830:4acc:b0:82f:5471:4dd7 with SMTP id 46e09a7af769-8309844074dmr16349309a34.30.1791879629886;
        Tue, 13 Oct 2026 01:20:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e024sm11490583a34.16.2026.10.13.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/13] bpf: Recognize __nullable on pointer members of kernel structs
Date: Tue, 13 Oct 2026 10:19:59 +0200
Message-ID: <20261013082012.1107446-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3539; h=from:subject; bh=GpqJNujkJAJmo/5JzH+cmTzwe8KiXmp2kxjNNMjZJtM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3m61/yWuv981zNxyZv5/2PydB9vDU1be+lHkdjjd4tn NlZf6ShlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEao8zMsy++Gvl8+ffjaOevK1dJr SCTe71Vbvae9P7Vhn+Ome/hpGP4b+vq868d1UhererkpSUSkWC1/y81LZjgbHv++iLnVumfuUDAA==
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
argument. Untrusted results are probed anyway and lose the flag.

The next patch uses the tag on __arena members to decide whether the
injected address translation has to preserve NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      | 18 ++++++++++++++++--
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

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
index 2f190abe3448..a9c47441fba9 100644
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
-- 
2.53.0-Meta


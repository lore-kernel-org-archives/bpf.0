Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26314F798D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107714; cv=none; b=GXjMmZoJtyhC+PkY5AWMhZmLya16EbqdKzYGq+VVxwpShIUV+Z5CiCZpCc87bHb9884PgLA2Fb2UeGuV72lp/SzPrU5rDug7IuYTkExxOWO56Q2o+TbpRbDGKuYFJM26mgpQRp7gCXLJ8rIW1c9p8eoUV7X7p9l63T65ORSRBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107714; c=relaxed/simple;
	bh=ZVI5vbG0AdzPFy3fTZmw9XjfwjRRLmZhJC4PgubwiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+b5qJ7USFe8+wlzcB2MQdUPQ04+BBMFeV1lNtkKTz0kQnmam0Kx5ZV7qMMcG8PH3AVIVB04Isaz7um69k4ySlTe7VLv3aFRwPyaYuI30e6M56cv5nDZWYJ3e9wOzy3yQvJjsd2kpVfsTGivGUO4C1OjaL6R+BM28ThWohmvjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ1fgeXx; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ1fgeXx"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-515166dfd77so2539008b6e.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107711; x=1792712511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3ki+DporVcLjTMz8gD0IU9BqW7MtInlmHHXIcWJElA=;
        b=YJ1fgeXxRbaPXmLyivxPQNbHwERcGfPcrNRcuIk3MY6v4vqoTpTuOXq4V9hOCAJyDv
         oTLkbfhUMwbH2wAzLbkhnVt8O2jHkJpzVExW0gVAUjXG+rjEyk/hOfGnBGh+TTgVJdV5
         ST4nEMUZOrwuDsR5CHNystu1WZBP5zJ0U7GTQ2lrmFbiRcXsiABLLLUXxrON1Bg2ppcv
         D+OpmuIha0j0RqYPn4eWlpXre/4C836YdWV1mlr1XlTcnyxR/kp//u+4smJK5oL6CsSf
         z1n55VW76D8AkyrK9YueqQSvFLQioK7C8oUUMwlammTOQojCg+QrT4e9IZHudCFh8i0t
         gW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107711; x=1792712511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3ki+DporVcLjTMz8gD0IU9BqW7MtInlmHHXIcWJElA=;
        b=ASGpHDk73rcra8dPoSGHTDeLOUQ1eFEO/9gZ3aLpoqVVawAMQC8UFlN/vsNDuP718l
         Otm4Pgd8rMwM8A1lkJoziEjwTQNslrLQDfIdKL4K3CiYmp0m0MUrS6gtCEq+uBNf2EhV
         7UjRTBN6CNZ6pMqEiPQN4eeKBivEsZkeU+ludbSTzwf2OKl4aEHTDn5UkbbitVo9z2Ot
         JsqiOTrSxyZrx+0voSc7mU4iNJ1atBR43SLalqTM6WQcZlNdF7F+k6MLeHLkz1Bwihui
         R28//9JjL4J6TXEc6haw2qNuZXFu6YgeOH11IRGOFp/5Ai3llTkgmBRbOkHPZ+3sra5+
         CYxg==
X-Gm-Message-State: AFq9FYLKPEoprkQAjrjsox3o8ZBKZ/ef3O2Lk03hKPh5Y3TV6l3N+OQt
	8R7sL7Duz+hXT1Cky6mKPtO1KFQF4xdsPCTtQ4SMTEZHREpnSDk3ixsYu2c21/uIbYE=
X-Gm-Gg: AYBFou0i9+1K8/80saHYomTr7EVZxV7lUaCml4vDvIdPIISJqxV+SlkvtdIof2ppsF2
	3ksIceiZfHqzf4S07wcKh9FwMDE5AXqRqjVp3dbnIF8rPFlo4wjAKX6Dr1MbvrQT7nEfI/fhoQT
	rbl3qd4h5EbKdK9Pkl8H5Iu6qAQosTtCrvEpJoYs/VMI0cPMdpz/g459a43luxHKA/+kGXyfIlc
	c1tgwgZ5a81yfZuY/08MI8af2S5tnFKfveKofVZfmBv61PgWgW3epr4SRu529MFlFTUgbGJzJsa
	6kLDhKJ/NUyBFKXFoEuxNXC9iDHKLqVoGhwrjHrqrGxsGg3MDKlKGv/94J8aRKnlLYGCH+9wITL
	yyvkvcarSaw4h1wdom/197bIoJN4J6ud15DzoS7bQiUi/DB9HCERFPXYyIN2vZyCQORiWOGPw4a
	LUH4u1EB1R5S/BUL0jVlLwbexCttB+idauygyEYyz3i9Z5b4np+KdxhN4mpTxaulOStSYLxft4c
	R2mthSMumfObFxpIFmVOGLfXuV49nsaNckhRoee/DDZ2oG+DixiFMzjeliGVQFBYhssGutnJdzD
	nwg5
X-Received: by 2002:a05:6808:23ca:b0:4d6:92b3:5c88 with SMTP id 5614622812f47-50c5b27c212mr22306610b6e.64.1792107711464;
        Thu, 15 Oct 2026 16:41:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c16d862sm269240b6e.9.2026.10.15.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer members of kernel structs
Date: Fri, 16 Oct 2026 01:41:12 +0200
Message-ID: <20261015234125.3152346-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4524; h=from:subject; bh=ZVI5vbG0AdzPFy3fTZmw9XjfwjRRLmZhJC4PgubwiL4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3OuY+1M9z6xRtlKsSD7ZeG/7cqfLWyX6c7+yPpv5Jqgg /+erjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk2XOG/47S7H+3/Dn2M3G3sbiWgX uZ9jXz3XETd8mxzDpYMm96jSUjw42lm/fHuOmyz/vq+ayPxfdP5xotTlmD7HkiZ0o1ed5P4QEA
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
keeps the flag whatever the pointer the member is read through, so a
program has to check such a pointer before dereferencing it or passing
it on, as the tag says. A tagged member of an existing struct thus asks
every program that reads it for a check, including one that reads it
through a probed pointer and relied on a NULL dereference reading as
zero.

The next patch uses the tag on __arena members to decide whether the
injected address translation has to preserve NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c      | 21 ++++++++++++++++++---
 kernel/bpf/verifier.c |  6 ++++--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64c78434fa05..3c01618694a4 100644
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
+			 * that the pointer may be NULL, and every result of the
+			 * walk keeps that.
+			 */
+			if (btf_ptr_has_type_tag(btf, mtype, "nullable"))
+				tmp_flag |= PTR_MAYBE_NULL;
+
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
@@ -7969,6 +7983,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 				return WALK_PTR;
 			}
 
+			*flag |= tmp_flag & PTR_MAYBE_NULL;
 			return WALK_PTR_UNTRUSTED;
 		}
 
@@ -8060,7 +8075,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			ret = PTR_TO_BTF_ID;
 			goto check_variable_offset;
 		case WALK_PTR_UNTRUSTED:
-			*flag = MEM_RDONLY | PTR_UNTRUSTED;
+			*flag = MEM_RDONLY | PTR_UNTRUSTED | (tmp_flag & PTR_MAYBE_NULL);
 			ret = PTR_TO_MEM;
 			goto check_variable_offset;
 		case WALK_SCALAR:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f143b1b18b5c..b4d9ad3ca966 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2497,6 +2497,8 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 		mark_reg_known_zero(env, regs, regno);
 		regs[regno].type = PTR_TO_MEM | flag;
 		regs[regno].mem_size = 0;
+		if (type_may_be_null(flag))
+			regs[regno].id = ++env->id_gen;
 		return 0;
 	default:
 		verifier_bug(env, "unexpected reg_type %d in %s\n", reg_type, __func__);
@@ -6712,9 +6714,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			 * aggressively mark as untrusted otherwise such
 			 * pointers will be plain PTR_TO_BTF_ID without flags
 			 * and will be allowed to be passed into helpers for
-			 * compat reasons.
+			 * compat reasons. A __nullable member stays nullable.
 			 */
-			flag = PTR_UNTRUSTED;
+			flag = PTR_UNTRUSTED | (flag & PTR_MAYBE_NULL);
 		}
 	} else {
 		/* Old compat. Deprecated */
-- 
2.53.0-Meta


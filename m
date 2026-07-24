Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD3449EA4
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920101; cv=none; b=V/15J6vpJ+rEaqb+wofLq8G+d/gBU+wbhn5d1lUkCSsLameJv0IvF4P2kcCwaULsaVtxzP4wDRtjkTWR2f7Kr0yfnO2jURFqls9yczriKVMSa9wJ/uqu2SxpzEi/UqdR2kwNiOywfgQCkJ3T0wUcmbZ3odQVPw96PrXloQcQaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920101; c=relaxed/simple;
	bh=J8g7oCz2z4n2dKJlmRvEUDxipLlB54B/BWD+p2EJfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF5fXpboLinu0cmUuGyJT24d/EytfOlZzj0NGJeSjkKYEDhBK8Vu8Etjx/Et2OjxI1g3nOjo0u7Ye+IHPDN21cD+ZsXV0GcXmhnaFpTNlSTpH8xFZ4bRuFz/gu771VEyCbGRsrqUfLwcPVJUmr1nz1pROtINnN5/Zpatbgr77o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSfXmcjq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSfXmcjq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so790894a91.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920099; x=1785524899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg6jZFw+vLmNX6HcvnU37y8klI+41nJo+gT2K5K5li0=;
        b=XSfXmcjqe02b2tmPbJQZN1iJ2+OyZJHlqZ1ng6Lds6Z1UNtcgM5roqawB8NNYNO34a
         JrsPTAkSsUmsN0PSnBogqh456AoifU+eAbWx8Z5VNTtYLy4f7/ao6V0Ebqw8HSRO8mU2
         BzjcWXujhpzu2LxV6T2MjpxfITb0Mr+hkmvYNourNypIAuKs+DVeQVJ3Olm/Y5F66/0q
         MSJUPH8a70uoZZPd+Uoj+SZ6nscRMqbyGN6jN9kSnLGozYjxyRDgAHeIHsihtqWIVpHu
         0ak2luNTD5LikJb/KhPnfG1/n9ADs3SGFPuJzNDbSvpwt6b0A/lSdw701rTvvMUFaaKH
         HKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920099; x=1785524899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mg6jZFw+vLmNX6HcvnU37y8klI+41nJo+gT2K5K5li0=;
        b=BzOcxLhaiu0IOcCBvYm6QLIiKijtN1UXhF7oIK//lUxoDR+uHqMdTFqC1E72eJm5LX
         d+0IVo2LDZchn6wy5r+7wZIsw0N7dERYBVy9TcjADmH8WrYRr1XPHlrydGcxLr91sGbF
         WBkNX0UdqnTO/rH7vKuRvTQaneTRAlKQUrogkMgPJMoSaE1kc57Ap5i1hY5YsQBVte0K
         N/dr2fh2qLka/0RHTvnLk7F+wvf5B6NiIX0AdmE/DX2KTNmF5nS+iua8GhyXIrdGnDfq
         MBpKqFpBLxP2H02xreUFBJ1CLGPPAeBLrho5mJ6XOEfjswLBcij2qoT3tJJCjKYXU5v5
         7mlA==
X-Gm-Message-State: AOJu0Yx35u4LAfYkc5rLBy6U5uAHfTGkM3JBnfTLzZq6P0aer6LqbzZ1
	g2cJoCev76xcIc7dud4KBS7JixtXGmnuNp8H6UAbHw7y6y8wim7bwhXhA/Loqg==
X-Gm-Gg: AR+sD10VZLhB415SaU7M+wYL1LdYVXkR6924xR/eOAn6hVTjd5xZ0fkjWV9Npv3gije
	N4mCIkLp07fs5nGlyg12ZjnMNsNjWljDLofE3f9g3SQ6SsnkwAxwiYZZzbcPuVeFBiXnqpuGfMs
	z3Qy80/yewdAsspYLnG19n4s2sGopVKv0uZsz2vZ3ykNYb1NuhYmXaWrxtwIxccjqUKkdJ82FG5
	5Wfr86ZHkdTkuCXKBKUNdYofvLIC94yiaJ5XKEqO6K/zRJtkL9jFZjNF+dBF6WmHaWDKeSQwGJs
	5kMBEqLrIxtW/ElJdKwaH2wtODfQrGMoBADBjDVx5lAUiwWHrX3X5bhF0gfsBPQLKI2QHphPzYG
	Ie4c6P/7aoPgfFzl1p4tm2lciLwAsLiG1idh6ZhJj6EfOHWmOjVPydmP4x90YYosECT65
X-Received: by 2002:a17:90b:1a8a:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-38ec697957fmr7910345a91.12.1784920099488;
        Fri, 24 Jul 2026 12:08:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f04175831sm1955652a91.11.2026.07.24.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size arguments identically
Date: Fri, 24 Jul 2026 12:07:59 -0700
Message-ID: <20260724190813.1458271-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
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
index 468702b09c50..2e56f726c12a 100644
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
@@ -12415,8 +12410,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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


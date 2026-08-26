Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F793909A2
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768346; cv=none; b=Y4J3Z4ZjbKNVbwo3fbhrMocb9X17KDLNifhGSavO3ForcOntREk0e+EvKjmWR5WHS7QVs8CrKtIIJgX5BD1ZTw2tOmGXH/WciMjAOahkBXwi27MXFxffPgggyvSWhvKniEGw3b4x8Wz9++mbDNvfx5QfX7aODop13tFdQBxnReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768346; c=relaxed/simple;
	bh=J6UklPYiUWaTxbBCd22Z3eZdchUvKmjGiYo9f5xDHQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyXh2gDV/qxfLXcd3M1Bf0q0qmHgmaOQKQk1DpBifM7aA7l0PEn5TDwT2u4BfSQo8B5Ztgse7rx2tJlssKNAx76MMow7VXEkQJ+xNpGzkYSom/zRQfcfCCDARtJDZKKyT7knj7+d/RUYurZgQ6xUYNNtuggx/4UDTZCXc9GTei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhoI8RAV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhoI8RAV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-395cf2535acso232087a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787768335; x=1788373135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie0UM2c2V/bOQ7/kdNLj+Tj8N/dzdmLwE50Wxf5eKeU=;
        b=fhoI8RAV0TBIomYU9wRuLdz81afLcqlGpMaUeTM9ZypP45P6hCG9w90taUq8MjO0s3
         OzEKmYDkDZ+3NLSZNxBeNYTQXCSn0JdprpzD81o4uQtXiW1xyzE2rLK3Mfyn8DFD0NC8
         vWbPsQlbacM6SXz4osc3BgsV7FGQ9apTRf+1SVKQzO3rT/9B56GIB/u5VCHcY0miKNam
         vWZKqVX0THFVyFLjLDmJRlCLKHCWKYwmZFAPmhhU1T8RUhfP4P1COF3U4ruTM4Aq3sRg
         /lewDVf3Y3Lal8DWyWAMHMTWlTb6h8LZtVMp7E0OoPQXkgFeaFJv9+fHgU2q/TFc9X9t
         3Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787768335; x=1788373135;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ie0UM2c2V/bOQ7/kdNLj+Tj8N/dzdmLwE50Wxf5eKeU=;
        b=eA6CKrDHpRnENYZ4VPQ1O5hgER0OEgUpTU8zaTCygFK/ln8ze+p2haumETcoDSjZD2
         8bsvb/u4Z1VYtY/k4Ipyk0rCQVaRnkALSt6SaetlTSE2kjqr/8LGOGFoUv0QROeX9Kc/
         440ZtHCKlthe+xybgR2vrr5CNHq2Kkn5s0UMVoSRnA95Ed0veHfsREOsbuyYB6CQdb/W
         Yn75Zh1c9bU5wj/xY/HaDBNgWEQlxjinQaBSBb2MyjviLWmR34RbZhbb5EefCK17AhBU
         jGj6QnIjSvh6fIAfLK0QjurAxwWB0NJKVSTUO87swPxM6p9sbFeyQ7oCrtRiIS0VultY
         Z7WA==
X-Gm-Message-State: AFuF++kTq9pE02Cjes/WLGU7IOm51g6cvcxbNBp519P4cUH/BnsDyyEt
	SbDhw4Sn3oPHvK9GvlKkH0eI6+xe1MEbls5vVMDGJGjY3vsyUynjKXQk6W9Qe/cJ
X-Gm-Gg: AR+sD13vy0OkZCKQPm/fTXv9H1gHX+kuoSqN8etOLv2r9bhnewPCQCxgJj9aJCPfqOF
	KWiHhf67RLRlHINy0iqTIyUH+iBVuD3q7UQI1D46NEUoq+fqORidel2LoYtct770FquwjuVOCqA
	Sqfonn3TrBhq08LWbXo7O+8BykxiKpKyzXK5jJb/cdG07zeFYP14RlRBlY5NnOgY2Gr2tCH6KJk
	TYclnbwvtNh1fpxnNfmG6DsizfEYeTBM7OHM8rDZpKTF870fH9aVj1H9LZHa62bFVp892C7Nf8i
	FONvbJCepVEXHU6varJENw5/lfJF4VGf0vLLS68xCPKScj8CHc7J6L6+NuzhT/3ithXX3PxcusW
	hgVwVyWUN5+TC2Tgk5ImGZjOfHM4FXwYX0CjOq7BJGEfmRKiAPuv/YiXf2GkvuXDoK1SMhLrOke
	/uoBReC9r/tzdLKxtcwEpRG2uLcNXTFy2+7RHdc1Khvp/A+YTRxKXRnY7U2jjOp6S1BIUMP1Son
	dXbFw==
X-Received: by 2002:a17:90b:57ec:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-3969bc27a13mr1039070a91.9.1787768334529;
        Wed, 26 Aug 2026 11:18:54 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3966875e5c3sm5182901a91.7.2026.08.26.11.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:18:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: check_cond_jmp_op(): properly infer if register is null
Date: Wed, 26 Aug 2026 11:18:44 -0700
Message-ID: <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Nicholas Carlini reported a bug when verifier can incorrectly infer
that a pointer is non-null. The bug occurs when two pointers are
compared and one of them has a type w/o PTR_MAYBE_NULL flag,
but which allows a value to be NULL at runtime.
Here is an example:

  // `a` is PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED
  // `a` is 0 at runtime.
  // `b` is PTR_TO_MAP_VALUE | PTR_MAYBE_NULL
  void *a = bpf_rdonly_cast(0, 0);
  int  *b = bpf_map_lookup_elem(...);

  if (a == b)
    *b = 42;  // verifier does not catch null pointer dereference

This happens because of a special case in check_cond_jmp_op(),
which attempts to strip PTR_MAYBE_NULL flags from pointer types,
when processing comparisons like `rA == rB`, if either rA or rB can't
be null.

The non-null property is derived based on the absence of
PTR_MAYBE_NULL flag on rA's or rB's type. But that is not sufficient
for types like PTR_TO_MEM, as in the example.

This patch replaces type_may_be_null() call with reg_not_null(),
which contains an allowlist of types for which absence of
PTR_MAYBE_NULL actually means that the value can't be NULL at runtime.

At the moment, the list in the reg_not_null() omits two types for
which PTR_MAYBE_NULL is applicable: PTR_TO_XDP_SOCK and PTR_TO_BUF.
In order to remain backward compatible, and assuming that only
comparison between pointers of the same type makes sense,
this commit extends reg_not_null(). W/o such an extension e.g.
verifier_jeq_infer_not_null/null_ptr_to_map_value fails.

reg_not_null() can be extended further, but I deem that out of scope
for the fix at hand. Explicit base_type(...) != PTR_TO_BTF_ID
checks in the check_cond_jmp_op() can be removed with migration to
reg_not_null(), but that is a behavioural change, as the special case
would start matching for PTR_TO_BTF_ID that is also is_trusted_reg().
I omit the behavioural change from this commit.

Fixes: befae75856ab ("bpf: propagate nullness information for reg to reg comparisons")
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

---
  v1->v2:
  - no changes
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..897ec4b38dea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -355,6 +355,8 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 	type = base_type(type);
 	return type == PTR_TO_SOCKET ||
 		type == PTR_TO_TCP_SOCK ||
+		type == PTR_TO_XDP_SOCK ||
+		type == PTR_TO_BUF ||
 		type == PTR_TO_MAP_VALUE ||
 		type == PTR_TO_MAP_KEY ||
 		type == PTR_TO_SOCK_COMMON ||
@@ -17085,7 +17087,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 */
 	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
 	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
-	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
 	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
 	    base_type(dst_reg->type) != PTR_TO_BTF_ID) {
 		eq_branch_regs = NULL;
@@ -17101,9 +17102,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			break;
 		}
 		if (eq_branch_regs) {
-			if (type_may_be_null(src_reg->type))
+			/* src == dst && dst != NULL => src != NULL */
+			if (reg_not_null(env, dst_reg) && type_may_be_null(src_reg->type))
 				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
-			else
+			/* src == dst && src != NULL => dst != NULL */
+			if (reg_not_null(env, src_reg) && type_may_be_null(dst_reg->type))
 				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
 		}
 	}

-- 
2.53.0

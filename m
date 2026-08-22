Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9717C203
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358780; cv=none; b=eTzoX2klQMdlxDKU/+FEZWe0923AkxyKg4dULSaclEPjFFSHV5WkO2Ahh8s3qQmeFgx9uW5qzrZGxLbEB8Oc+K1i0ZIEV9BvyZmKgS3l2zHG9uP90rU4o4ZBl43KC74034k9wcLoub6rn6C5Xs3S60OUyVv4aq163Lk48RF23TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358780; c=relaxed/simple;
	bh=QfEbQyFqvW8CpPspGrQ1blzamqXZ1u1iEVrvsc4p1i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NOD8GMpl6npTHfQXzTNvubs+pEZl7Dvx9PVgWaoxOUjcprho7LYqw+3e7BBgx5WO/RL9Ku1Y7FpjaqzzChF1gUQt4vemluyBEqnHncuiY47q4GBqcy7/ls3xG+Pg1QEtKMmsrKK6ryQp2CAR/pQzE4wwaUPwZ3VqzwJ1IBZGtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGhp6sG+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGhp6sG+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so2180284a91.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787358778; x=1787963578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTAv9LK91MR9tUtG3jyEiGCf1TbsMNt6lZu15Q7HKv8=;
        b=FGhp6sG+00EwGJtko5AORVO81dlhM5VPxCxsegespADggTBj38pqAJ5j3vDgDQduO1
         MfI9JbcrTz5mls2orzN+cy8OEHY5ZoSHgaJZL58x6+hbgjzlYIZya2qZJTQlAG3RGO8m
         rVSliJLCaWxifVJmoerc4YqZUP4qsrCNeeBEGEZQ0F36oETkWr5Fla+7Nz6uetZq8+kq
         sMAn2835A+chqp+4aILJAZjxM3MNhVvf3LuNcvRQWvEBGc0hDfkT749/VK6DwuSazH21
         qNmRNW53OnjEwLwYcjxFGoOI49MMyU5BvuGo/kPdHRqWCYskYerjg+c4eWZpehDW4oEH
         ZPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787358778; x=1787963578;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kTAv9LK91MR9tUtG3jyEiGCf1TbsMNt6lZu15Q7HKv8=;
        b=fck4IHk7a9hehXw4fxlVfRM+d8m0/MPfFCbaVYAc6Nep2JSl1wRpvAxcw2O9jaAVJM
         /U3HUb6CDal9iyxIuqqihEbVGsggKs2Mhk0/rU+wXnw98uDLX1nmzTxjbhOEBwNNb7Su
         T+J5YAXgtH7XEWZ4kLxVf+CBAtcZk6MK3SFsILZbM2VMHaZ7R+FT6sNreGFxQ9wWhmp3
         mQqW33D1lSCaJsM/5HgDcgaNZ4az77NG6l87+ZCZy8m3/rMmsiH/XxtBtPN1l2pj4x7d
         9HIdTyeEq6+FGWChUtAEItPrWG0T03Ee+5hiKtVmidgl08/aSQ+pg8gxyz1AlkUqZUyx
         6OaA==
X-Gm-Message-State: AFuF++mODj4lzJcq230sIKmqPFRePz8n3ntc6wmu6bC3oujq3QfAjLOJ
	AFqjQ9+j0NiJbYZaTVNbA7QU2Zsm1Po63KmR2rTPcmq5ipJKSThao4ZZ1vhI/g==
X-Gm-Gg: AR+sD11mWnY3BNzdi4GVpizYbyupNmXVDFmQe6nPqT48RuIELzCw7IiXAw7Ia7h3s+Z
	KN09Dw4q9vgC97aUP0fY9YLFJj+FrJGFq5t7EwAUJTFp0xPiIJ+xcfobJa+yHSWNZ0hpkL2szJf
	3GS+mJxB+7qF1d3soMYAgZaPbuijqlK4ROXsvTatc+Ox3+7mtgu7XQW9MCXH5Il3iQKkvY0SAj4
	w5zQM9mEjJ7CKAb8Wj9f2e/j3HmGaseGwrTMh0DPHiluI9//ul1PbKvlgmq+WooJnx1JeMVGEcR
	OzrMoBRAp/+TnFP/dAgc86l4qjyWB1z7Gsp8vZctXQoVKAreAzo1Z1hZVNTxU7zBZTwWW9fWLer
	Q4mLIsDvSOvCx6a6aSlrfoD/Qbfp2RHRMg7m47YDT7WIeVi61w3jm9lACLPn5C4FHJpodFG5p7Q
	kAvJGiwuT1JU/8m9hk9pqIP06IRj4HP9ACRDNU8ItO+fGy64MTn7dURmeQrmcQ/QRlWzX2Xj7oF
	0d/1FwMgK6GaNJ6jyhvYQ==
X-Received: by 2002:a17:90b:5347:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-395c3a4bd22mr19471823a91.14.1787358778374;
        Fri, 21 Aug 2026 17:32:58 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4968618sm880297a91.3.2026.08.21.17.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:32:57 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: check_cond_jmp_op(): properly infer if register is null
Date: Fri, 21 Aug 2026 17:32:36 -0700
Message-ID: <20260821-bug-029-bad-non-null-inference-v1-1-45ddc0f7c308@gmail.com>
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

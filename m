Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938B126C02
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566778; cv=none; b=mlrhVsYfETZqg16vBoXguzPLi7rEH54o4sjjXg0kUiF8dUxeTr4TDi+p5NVpPT9EgOWAhNbrgqNMYCPNqLmHZfrDrVu3hgDQkqelCswC9/bYkcawPFvrZzH8wRxsW9XqfPeURMnaqR+BDLuUBc4hvLgNpog9fYP/Mb3+I0NX/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566778; c=relaxed/simple;
	bh=7mDchWi3SLG715zWe3B64fd2fq9tpEq5faVGUbt+XpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHoC2uLkalpcctmvkLdQojX7lqLcReVm0+LooslTsL1EjnqLYAJkKPQNapwtdNZn4erGKRAD5JtrjsW9af4fysIViN9yV2HPw3wGzWbReRvp6EP06bpYMrW6ZJE/TNwsK/rnZgg3KPHJrb0TX556AQVps0FJ2d5w0QXjv0Ej+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQPyXd/5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQPyXd/5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso1704664a91.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566775; x=1789171575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iaOgD+CmNkylJGpCzYi4x/eklCrg17cZ2WgqT8gtpRY=;
        b=EQPyXd/5QqtPejFHqjsRuvShsYe8lTQmLgpR3iiNDaOxOlva+m3NI94BGl8GcropG0
         FAkQ+eAXKAMaNQlnOJVky7H802IQPSlvC/5Yb5A0VBUziMXoQ/RgeSh813Qa2kdolvkk
         RH7a6m5GOEnFdYX1GO2X8XN8ilaI7r04Sqbl4DeDSXq7s6r5HIIf8JhFtD4sXkhhPRBH
         TKywKU/ip+m7uTHRwsgngQQkAeEVHLGSj/r7YJJrWCi9qivSzRtW6F1CpC5+Knz2bfRM
         e9abUQXfuBRsJtLzrIkdfrbrj48u1UqbODuc22Ok1pJY3AHo1piNFRTvdeK04vsMhQUW
         yREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566775; x=1789171575;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaOgD+CmNkylJGpCzYi4x/eklCrg17cZ2WgqT8gtpRY=;
        b=ledH/vq9t8YxGJAnPIgm6Y4yEmTg/C2KrrpGNgxJDBLovKPsxwXVbC6NjHrU4x2gcX
         OQhfTg5NMrMxS8IjfBL/+XUQlYaxtdA7iTnrhDstgXKZDQQDjWoAu0dsj3NZuQN/aG5w
         3QYIlnqVWFF/RtRA4rBnKTWaWiQWWy2zEAXfMCCFzj2vs1ZO/Pg8DnBQ8Z8YB4+8PkZ/
         G1Z0oDO5MA7wWK9nu097gdFsYXSyF6c3iX6HjTCbrMCptjSzg55RgEZ/atPnS5j6ciEc
         yiTH0e7AeaGsrl6bRhqyN2pLeDvOfuNnG7dnjOkOk+CDQOqOJ8YTNPNw107i9LtFZP4N
         h64g==
X-Gm-Message-State: AFuF++nl32+FFpRNiylzQC+7sTpRGq+4kA+ebf2JH1t04krEgJU1zsO2
	KK7DR89DH0SL/GQLFQHWmoUNghRrpCCXwBEhMQpiOnW1KlCrBz84z5zN1pbutxMJw8o=
X-Gm-Gg: AYBFou2lD95zx20zsMPmSm/kzr2C0j75HNi46h8TOBUOuWalFcNw0DvWGrArK5Ip6F/
	/qTZcbbJs6KoxWdNLo6L0w1bVF6U5nzrsdo0WTdr0PqhTRacPyLp0KZxwzeF7XJv6K8PQ3N+uh9
	/MpMDXPsAfIvC/NIGi9i/EuQMVo+u8xquxoLNK6g4tfrQprM4tfrRKztpVeyl9yedDU080v0rpl
	GEwzElFowH77Js1/9oUQar9DYHJarB4XfjVVs5JU0EM1f7DG6Omqsk37FxHev6kORMOrRyUInow
	7JRyWCeNpsHbLGMXl1LOZ+p6xJTkwjrXOkOez1si8qDj2U9zje3zLBurYF0KTJ1hv5bgdKjllB/
	SrTgsrUWXB7u0j6l3g5+YMbNECWRzH8O+KpXg0ZsP5pDCnpEECNEsTW3yhaufsUqi6o6c0rjGyD
	RFJC6KDQz9pADY1YZiG5m7YFC4E9zKj77m94g+PZDfjQIR0u5EmvdBd/GhQofJIifPD8Dww5zZe
	BfGtyDoXMaWfmLVXskhNf8QENk39bQN4uMfXR8zNo9Krw==
X-Received: by 2002:a17:90b:3c05:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39b26106c44mr13814872a91.10.1788566774999;
        Fri, 04 Sep 2026 17:06:14 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 01/10] bpf: mark a NULL call argument precise
Date: Fri,  4 Sep 2026 17:05:52 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-1-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_func_arg() allows bpf_register_is_null() for nullable arguments
w/o marking the underlying scalar register precise. Hence a checkpoint
created on such a path would prune against arbitrary scalar value.

check_helper_call() enforces second parameter of the
bpf_get_local_storage() to be zero, w/o marking the underlying scalar
register precise. Hence a checkpoint created on such a path would
prune against arbitrary scalar value.

Grouping these two into one patch, as they share the same fixes tag.

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                                        |  9 ++++++++-
 .../testing/selftests/bpf/progs/verifier_subprog_precision.c | 12 ++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c6ad157a61e..ca362a7ea58c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8752,11 +8752,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 	}
 
-	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
+	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		/* A NULL register has a SCALAR_VALUE type, so skip
 		 * type checking.
 		 */
+		err = mark_chain_precision(env, regno);
+		if (err)
+			return err;
 		goto skip_type_check;
+	}
 
 	/* arg_btf_id and arg_size are in a union. */
 	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
@@ -10906,6 +10910,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
 			return -EINVAL;
 		}
+		err = mark_chain_precision(env, BPF_REG_2);
+		if (err)
+			return err;
 		break;
 	case BPF_FUNC_for_each_map_elem:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index e174a905c562..dc0c7034c04f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -287,9 +287,9 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-__msg("frame 0: propagating r1,r4")
+__msg("frame 0: propagating r1,r3,r4")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r4 stack= before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r3,r4 stack= before 18: (95) exit")
 __msg("from 18 to 9: safe")
 __naked int callback_result_precise(void)
 {
@@ -419,9 +419,9 @@ __msg("to caller at 9:")
 /* r1, r4 are always precise for bpf_loop(),
  * r6 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r1,r4,r6")
+__msg("frame 0: propagating r1,r3,r4,r6")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r4,r6 stack= before 16: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r3,r4,r6 stack= before 16: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs= stack=:")
@@ -575,9 +575,9 @@ __msg("to caller at 10:")
 /* r1, r4 are always precise for bpf_loop(),
  * fp-8 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r1,r4,fp-8")
+__msg("frame 0: propagating r1,r3,r4,fp-8")
 __msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r4 stack=-8 before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r3,r4 stack=-8 before 18: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
 __msg("mark_precise: frame0: parent state regs= stack=:")

-- 
2.55.0

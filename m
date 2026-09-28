Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0234037E5DC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619268; cv=none; b=etAkJtcqy4Wn/KOwpAras0dXR/mPNEFzcxe7NBTKpUlmb6gdy6ASPIkbZbxLbOPOw/I4c7s368aDqjlULSuhfeqZxPMF9xruzkUWMksSkIgAexXX0qcI3TYCcmfJQA7zxWnwP8hIYy5Wqf2zvv4F+VxYNvu895a8MbHoFjWIG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619268; c=relaxed/simple;
	bh=HLG0MvOmo3JoVvZoS/I+0+nS+1m04bJ5Bx6M2uekpQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICsWE1w/mX2X+Mpcu6R1rOaRdvanKNottyFkIcinU0+gOUFcabaWtvdEhD3FFqDSB/r8AaYctxmd+CYCyPdYQiCtd3w/IFJgT3EFW00Pk7yHDENr9p9an4XhsKKjaodXN+K9jf9qWm6AKWljOIK/p2n/neF40NmYnUf0yhI3WB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMPqvBIm; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMPqvBIm"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8144632e066so1825189a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619266; x=1791224066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kw0T0GSXZMLU83IYSIO2HtVAr5aOLCJW0y42AorMYxg=;
        b=bMPqvBImwrE+PkukljGxzCF/YKEu5p/3rUBb44TIph9R0wAt2ZRlOs3AlJA2FshC59
         sJUeAAQxxBDHrnnbzggNr+/IVFuXnyenuaL/FXWtK1+lMB4ssnADapmZvGZ3ToDUDrvz
         QmxRsL68L+hoV3zZgL8Sz9f6f8GabuYrmQqPJUbWoqsOCxA6plz4MDTMLJuOhmfU3tB8
         ld9OWZe7pK51k/xEKEXEmE776iY2jApo1OQ7fZyKyf/Gt0CjuJkMdMyWkZf1IJG8k1aA
         WHV1b1nMBXe/pWIjP+3s1BYqqyzYWEvW8SD6HQLxw+yHmAycR6dt4D2m/sLLOzmCP5q8
         icgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619266; x=1791224066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kw0T0GSXZMLU83IYSIO2HtVAr5aOLCJW0y42AorMYxg=;
        b=V0rl7AXvENM9hIHazg+GlIaoEy7M76msWJzkcItG4sXyS+dFSMS1QLnIMkMfW84fJt
         tLCBCRhYpilKfmtULZ1XCB9j9LNBlyNxVbiDT6SxLtV2SMPImV3Bt1fqjF7FSKBK5Gk0
         XD4kzfDWPw1vnWc6CVd9vm//z+fur54UjHx2ZzZyR6n9qUQ8eCLl9v3oc9eKFRWfdCvk
         0JIae5s2/0gjbPbDg4QuuldrK67Bff9PGKWkmuIPRONnJrKdkIhI8xaw2bSgctCmVUqp
         nCwwL6yjwRGHK6eJ1HpikiusNliUA8Dfv/hXNKvpnksfAIU2aMLGkj64+8X2lIkzlvAB
         7OPA==
X-Gm-Message-State: AFuF++nzLUjFl+QIrVJNFdIMW2powYr9wEMQtfkEKlkTDObQdjK1jEKg
	DndbSiokRezFanrR074VdkV02bf60mxXgAy8gpxqDVfuXgpw1gw7SWc96nADyw==
X-Gm-Gg: AYBFou0n1zUxj30PNLxyFWDrOTTYki0It099YG7Lu0boduGM4NL948cJda6nqOCLD46
	HlYNrPSycMDJoaUnfo8Sil9LUUSxuQi+VQxjQgBfx8mS/fqjy9YPdYukaIii81Gzm3/jzqvqt+8
	MN2/1cLh2Erm69ydfNr1cavhINLmWnIKizx0rWAqA1Z9mQ7wx/r1XsAYbUUqiIUz/sROSFSD8Mm
	B3bONHzq/RvrUJeEvOVqGHOLL+fjhwtPwUoaTsEGAB1w/kE5uUJWuBBBSrAy9emqWGTcAQ7Pj26
	XixJBdZM5j2ABATAs5+J0i7N4GAGORfAsP3i+I+rBlnAu/QE29BuC5MdBazCg/B112MeB6Z5OCj
	NWGqL+znUV3AhqIvNOrYEcVILQomwohoFEYzobN4IrSHQ2uGj6/gG8Y/GmzpBHxuvO89u47WR5P
	nIBBMCtOujNdeErYGdhh1l3xUrUJyZfnOz2r2Nx+0Ux+smmpD4LIFy74VGquy3
X-Received: by 2002:a05:6830:61c7:b0:806:23ea:25b6 with SMTP id 46e09a7af769-8177fba95aamr15601274a34.2.1790619265860;
        Mon, 28 Sep 2026 11:14:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58a00277sm2067656a34.16.2026.09.28.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:24 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/11] bpf: Check subprog arena arguments in the common path
Date: Mon, 28 Sep 2026 11:14:09 -0700
Message-ID: <20260928181414.644158-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_PTR_TO_ARENA accepts both arena pointers and scalars. The existing
BPF-subprogram contract includes a constant-zero scalar; it is an arena
address value rather than a conventional pointer rejected by
nullability checking.

Kfunc prototype generation already records this zero acceptance with
PTR_MAYBE_NULL for both arena suffixes; separate JIT metadata determines
whether the kernel callee receives the arena base or NULL. Apply the same
call-site representation to the temporary BPF-subprogram prototype, then
extend the guarded check_func_arg() path to cover arena arguments.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47ad4f92ef67..237b81ee3159 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10815,6 +10815,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			 * to protect against invalid memory access.
 			 */
 			arg_type = ARG_IGNORE;
+		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
+			arg_type |= PTR_MAYBE_NULL;
 		}
 		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
@@ -10880,7 +10882,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX) {
+		    arg_type == ARG_PTR_TO_CTX ||
+		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
@@ -10908,19 +10911,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
-			/*
-			 * Can pass any value and the kernel won't crash, but
-			 * only PTR_TO_ARENA or SCALAR make sense. Everything
-			 * else is a bug in the bpf program. Point it out to
-			 * the user at the verification time instead of
-			 * run-time debug nightmare.
-			 */
-			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a pointer to arena or scalar.\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (arg_type == ARG_PTR_TO_DYNPTR) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
 			if (ret)
-- 
2.52.0


Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98773E3142
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442488; cv=none; b=FokOSQvNvJNLYWkU/+5TEdzoJtzbBxS5MGKiUmGOGrcg2QM3i3FLJtk/nWWJcuwUoCTNaJh3HCOgAWYIv9AMlS2v2Saopzi8JX1qECtbD/JoMIKDIXUiYr3FmkP0Q3j8neT4s8gcUcm2kchXri6oath1ybmMMv1gtVEGcYd44yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442488; c=relaxed/simple;
	bh=Rz3HICdJBTk3HqDJt2a/p1ky9eNo/C/ofzxiXhlwzuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCGm/90C8m2sy7w3zHI374RpyMrQ6qgBZm8uWt8gfqXmU6Uoq9M/8E7aX5kH3Pg7T5ivJyt0vVm0eG6/Gi/DwsPpHqh7hMMT74T7qYzrBQFkQjJaecF+Kqcyyt4LQEoYe0hUg4el7W1bzh70LhdD8u16EgvNh8XB3LMcrCpWsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTg0yiO8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTg0yiO8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2238974f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442485; x=1774047285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uUGJ306uP9TftNpj8Jwm1zzquPGbhoGFWt1J2Cyxns=;
        b=CTg0yiO8PYmmEPN/Ykl1ih2TTEmVnPQedCHDirF8CKwgkXECXD+FzfI472i32w2R8y
         ttQZzNgu3RmjF7EV/m9F0RO0SLSSuUxuK/exuU6l8i1hedTfUXLM3keHRDSlsu6KuayT
         udTFuPD1gxxG+9bsSTyX2f4DwJKsFiN8RhEbzrxw6/7uOWK/juokI+JCL2iOcaQ8W5TR
         7hXJAabfYaYpmiOXSe0+3A1nxtgiJheTMwiPDebuBoq1VAZZWpwWsW9uVDwzDAKLrnjt
         /wxiXGkH41I208ZPRU7MKwiW7Xf749he1m4mAMTDZtBRky6JwTOBkHvHhawVGpT5s+x+
         SqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442485; x=1774047285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUGJ306uP9TftNpj8Jwm1zzquPGbhoGFWt1J2Cyxns=;
        b=Haf+H3U71NGY7QFAZO2rMkEwP+0whtDcA7i1UZzsJtd6Y/xSQ3x9TP/cJZOKwAW4rd
         npR4Mtv9PZSxxA5pOUvg1/PuZxybXzg7mAbs8EJxKEBVAuEWyq2inBT/HCGY6oDCFo67
         4slK6ViKUGGIEJQQuGeCaFbgrXhZJ/vQyYyffcdw6ROut5kK9n4Cm1xTblCOwdLGb0ct
         52dpMo6cBzBcKFOF+H/6PFwL2iBPvmDbm3CSYR2AqiXnG08qBntYpLSjpCb1kH9ytg5v
         ihTCKW6zA/yTdRKJClLfDwU+jqs/tW/XWRkeAvPGIpdoh9HVvz8ZSKzcBT2PP2ltaR0d
         OH4A==
X-Gm-Message-State: AOJu0YwYn0JGJMcDrQ1/7dWH+8jOJ3O6at8FcyXkKZBCXLludGJH0Oo4
	LeXlmtIEMweGVZ3ykSNrebSP7x1K+RAPa7mzbs5z7AEcxaEOLM/XBjmRFpLL4g==
X-Gm-Gg: ATEYQzyOK79M0ntwz/p41UvrS1hRwZsFZf41Mr1XW/ynnIk4u/kbYrbre4aZgpMre6E
	osVpKhoh0wKIs4i6rVL15a2LkRWNjQDYtlJku+j3PhAvXlxUn7scTiXPsnuOA56S2UEqyayAX0E
	dKvmxJH/WmYNFtMvwWbXSZSP+vErfRxR1gj+ZZVHWVgYPd+VWO4iMAdpKmszeMC2CF04mErQ1+9
	iS5DvWmp+yafhilx5Y3wJ+nmECzUTophF4BIoVO6a5UDEHcVI7UTbuaPXWSWHt0NjtyfcCAsCbT
	bchdFlHbyMIkOZ3K6txmZf76WAaNNAqaxaQJcj45S7+9lg3c66MMJgvo1/9aEeKTIwsDhc3xAdh
	zJf+dDM3exid4luUxQUzPmNMm/B6T6srOs04wUj8ZIUpxvkCp+YmhuOAkZB5D5kQwgJp6ow4gRi
	RQGxjuk3zOEVFuUn36iQ3nrN2X/+xQZT90HY+A6EMGehpJGS/AyFeLQ9iK0kkVQr5J2/J6MVRSE
	z47DWjrFP1q/Fj30LRyj/wrOFRkTXw4hgZiv+Q9LyZIg5ioQGWZ60UHz3dHi5OI+fR7BsLMB7Uc
	3ooPVQnY9k0=
X-Received: by 2002:a05:6000:310f:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-43a04d7c54fmr10393805f8f.12.1773442484976;
        Fri, 13 Mar 2026 15:54:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186e3sm24298454f8f.26.2026.03.13.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:54:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:54:43 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on range
 violations
Message-ID: <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773441432.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This patch fixes the invariant violation warnings. These warnings
happen after we refine ranges & tnum based on an incorrectly-detected
branch condition. For example, the branch is always true, but we miss
it in is_branch_taken; we then refine based on the branch being false
and end up with incoherent ranges (e.g. umax < umin).

To avoid this, we can simulate the refinement on both branches. More
specifically, this patch simulates both branches taken using
regs_refine_cond_op and reg_bounds_sync. If the resulting register
states are ill-formed on one of the branches, is_branch_taken can mark
that branch as "never taken".

On a more formal note, we can deduce a branch is not taken when
regs_refine_cond_op or reg_bounds_syncreturns an ill-formed state
because the branch operators are sound (formally verified). Soundness
means that the verifier is guaranteed to produce sound outputs on the
taken branches. On the non-taken branch (explored because of
imprecision in the bounds), the verifier is free to produce any output.
We use ill-formedness as a signal that the branch is dead and prune
that branch.

We have had five patches fixing specific cases of invariant violations
in the past, all added with selftests:
- commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
  min/max boundary")
- commit efc11a667878 ("bpf: Improve bounds when tnum has a single
  possible value")
- commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
  logic")
- commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
  boundary")
- commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
  JSET")

To confirm that this patch addresses all invariant violations, we have
also reverted those five commits and verified that their related
selftests don't cause any invariant violation warnings anymore. Those
selftests still fail but only because of mis-detected branches or
less-precise bounds than expected. This demonstrates that the current
patch is enough to avoid the invariant violation warning AND that the
previous five patches are still useful to improve branch detection.

In addition to the selftests, this change was also tested with the
Cilium complexity test suite: all programs were successfully loaded and
it didn't change the number of processed instructions.

Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitization")
Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 974305ef3210..bd3bdfb6b0c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16676,6 +16676,57 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}));
 }
 
+static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
+				u8 opcode, bool is_jmp32);
+static u8 rev_opcode(u8 opcode);
+
+/* Learn more information about live branches by simulating both branches being taken using
+ * regs_refine_cond_op. Because regs_refine_cond_op is sound when the branch is taken, if it
+ * produces ill-formed register bounds, it must mean that the branch is dead.
+ */
+static int simulate_both_branches_taken(struct bpf_reg_state *false_reg1,
+					struct bpf_reg_state *false_reg2, u8 opcode, bool is_jmp32)
+{
+	struct bpf_reg_state false_reg1_c, false_reg2_c, true_reg1_c, true_reg2_c;
+
+	/* Create copies of reg states to simulate both branches because regs_refine_cond_op
+	 * will modify the reg states passed in.
+	 */
+	memcpy(&false_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
+	memcpy(&false_reg2_c, false_reg2, sizeof(struct bpf_reg_state));
+	memcpy(&true_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
+	memcpy(&true_reg2_c, false_reg2, sizeof(struct bpf_reg_state));
+
+	/* Fallthrough (FALSE) branch */
+	regs_refine_cond_op(&false_reg1_c, &false_reg2_c, rev_opcode(opcode), is_jmp32);
+	/* If there is a range bounds violation in *any* of the abstract values in either
+	 * reg_states in the FALSE branch (i.e. false_reg1, false_reg2), the FALSE branch must be
+	 * dead. Only TRUE branch will be taken.
+	 */
+	if (range_bounds_violation(&false_reg1_c) || range_bounds_violation(&false_reg2_c))
+		return 1;
+	reg_bounds_sync(&false_reg1_c);
+	reg_bounds_sync(&false_reg2_c);
+	if (range_bounds_violation(&false_reg1_c) || range_bounds_violation(&false_reg2_c))
+		return 1;
+
+	/* Jump (TRUE) branch */
+	regs_refine_cond_op(&true_reg1_c, &true_reg2_c, opcode, is_jmp32);
+	/* If there is a range bounds violation in *any* of the abstract values in either
+	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
+	 * Only TRUE branch will be taken.
+	 */
+	if (range_bounds_violation(&true_reg1_c) || range_bounds_violation(&true_reg2_c))
+		return 0;
+	reg_bounds_sync(&true_reg1_c);
+	reg_bounds_sync(&true_reg2_c);
+	if (range_bounds_violation(&true_reg1_c) || range_bounds_violation(&true_reg2_c))
+		return 0;
+
+	/* Both branches are possible, we can't determine which one will be taken. */
+	return -1;
+}
+
 /*
  * <reg1> <op> <reg2>, currently assuming reg2 is a constant
  */
@@ -16832,7 +16883,7 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		break;
 	}
 
-	return -1;
+	return simulate_both_branches_taken(reg1, reg2, opcode, is_jmp32);
 }
 
 static int flip_opcode(u32 opcode)
-- 
2.43.0


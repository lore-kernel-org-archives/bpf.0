Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB954B0E26
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687954; cv=none; b=Hoz6OJdyMOprgsv8eSCahM5s1cWYUQO7Dg8TF+fsXWhYCUEidSof+r/EORseMPItZjmPAji7nPrcTlfa+eE1jPZIysRDA5LWretfSnUI3Biq0Mhi4R3YCKepkyTDguhNpHNc54G4mr7tHo6gEIAz92ioqAWidcB+sySZT+vXd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687954; c=relaxed/simple;
	bh=bRYlCnr1arR+ACx2/DjlcrPKZzHIgwCnLZdS+GCDpz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny4aqiDA+4LkJbp6+hotXTo9zd+AHj88s/x1KmVknYZ74SO4OFrhQJ623mEKzd6z88cCnruy0y6zjsOK4bxu9xTWJh+3lwqAgUqkj90rqjPJDUlCfvXATmcYDRjx9CYbyAqUVAMu8gnxuuivLiDEK0M2taf6Veb0LjDo6PJ6dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFBq3oV9; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFBq3oV9"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so450795e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687951; x=1790292751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLK2QRpWqeMoPFpVdI3uPI0cYs+CHfQkd+4FX5xCgSw=;
        b=EFBq3oV96sPKQQawn/SiBmTlplpo0zNo325EF8VzoQdygrmehNsKI3iAFijOqk9N1K
         +2REaMvBsQkCKLGv9Gq4cdiAVbxBECCFmv6ZwkbwlYy/lWIXWicv4ZuwipbkYUZF0YJc
         s90SxJUDDXJneYSOqbE2FRrv97vjvWfUp4Q372OOp12ZHPCUJkvrJKSvMmKOPzA562gj
         IuITTqVc691FvSzRpWOk6Oc83HBiqUhiqDpvo9hZS1TYq/Rrb1JF4r7b8hIYiNEMSS5h
         ViJy3pZfzrxQ6c+c9cs8PRlXJNQekg/+oYe51gvgSQpqnrszR1OXAUDdtgnf0RMW5Ixg
         8m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687951; x=1790292751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLK2QRpWqeMoPFpVdI3uPI0cYs+CHfQkd+4FX5xCgSw=;
        b=h0Yszyp4TxvJF18zxx1Cd1lTo7Dvp4fX+2KD5gEZHR5aB5Nt5M/7fzmJ0Zr+np4/2p
         xCeHayJenxO3074jfs92hu1UOmPZ66uP8Z2v0RK22pT/aFrsG9FunrCsSSQoLvYjMTnV
         LyU9FzdSpYI7lwRGJXWFeSYWfVHZJX4igKmgjdCzpAd5IGEyg220QO4BcpaMhtacZHye
         8BH3313VrHyx7DlVLot42XyP397B6MzsHZXnmj3iJVhzXwHmVL2j6QZ/3fGfPLyXCWmt
         V1Ehdru0Scy2ZKqm1ELv19qnO8rWKg4wT5aA5+7/9sLrpn0cpyQo9HfVnInUoDfOWgZi
         RqHg==
X-Gm-Message-State: AFuF++kt1XdMr7JYa29CLfpE39QnAu4Y7DHVB9I19tnLzw0NOVbCLO6T
	PxLY9YfU9sYwFibYWB0JzjR25n2dDaTiI90DWUFQa45Ma2YI4Xzuoc6AOVgWTe4S
X-Gm-Gg: AYBFou1CYyYT6iEkk95vGwD189TOp0loXlbepsOjy7Oqol3UDgLTASmJhOH+KPTNpX2
	ebQYY/qXe3jGMU98NJpeeLT2p7VhVtUG5PlU9pTZZDIKAzmDc2vgjma7KllZ6bmjDolldMNcCSE
	z/xclLzg60DQzl7qAlA7zdTmuUfXmPSjOVbHARMJDl+/4/qsRru638HrghfRPxxjlppaSByCpfK
	WydqS4gd/NjFvGPJKhdorOPysqeqUQD9MUNaM8Zw4roDFZ8C5EYhoHljZW7SKu9IIPF8HdUj3Pe
	HNHl2ZFDRMCvIfJxJI8GwOsZZRqqB5F8GKVH9YdqJOof7G3c6vPV2XM6s0+cMqwBJB4ea+S2+bF
	wkBWm6HRLQRqrugkhZ/BE9XiMbRi2kFDzTV/YPbjVGySoUydQFoF19QZZdldTD3P7pEVBip7vry
	K6Fu2B8yAm/p2apwWICSYfWhWGIKn8qwSsdfaabY/ZEIwItwxNNntt57nGN510Q+T7jyP8Ao1tf
	ESlutR6WIFyhMzRTJVmg+bPqie+Lf/Sy+Ghbu1J5lqMZ7+rfIvNJhhp01j+a7qW4BaXfFWDM3NF
	o6ctXUNi18ffp99iEdKi4SezR37QNUHmLLKWqz4=
X-Received: by 2002:a05:600c:3550:b0:49c:fc89:59cb with SMTP id 5b1f17b1804b1-49fc56db95cmr5203415e9.5.1789687950657;
        Thu, 17 Sep 2026 16:32:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ceb92asm1274305e9.6.2026.09.17.16.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v7 04/10] bpf: Apply CO-RE relocations before subprogram validation
Date: Fri, 18 Sep 2026 01:32:12 +0200
Message-ID: <20260917233222.2542500-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4982; i=memxor@gmail.com; h=from:subject; bh=bRYlCnr1arR+ACx2/DjlcrPKZzHIgwCnLZdS+GCDpz8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRUZ3+OnlEs2zujbpztny4+Y9P5Hsh9v2fbt2QSTGb N7F4B3/O0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjARlYmMDBOEk9UnuNyMWya9 Tktlv/NcviTPpff3mnfnbJrNk2kq94SR4WH5rl1xM6Mc6rctT+nxuzEzxdw+5/qbtTIla1bYL+F /zQcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump before in-kernel CO-RE relocations are applied. An
unresolved relocation can then replace that terminal instruction with an
invalid helper call. The resulting fall-through into another subprogram
breaks the CFG invariant used by postorder and stack liveness analysis,
which can write past their per-subprogram arrays.

Apply CO-RE relocations immediately after preparing the program BTF, before
subprogram discovery and validation. Keep func_info and line_info validation
after subprogram discovery because those records depend on the complete
subprogram layout.

Reject an ldimm64 first slot at the end of the instruction stream before
CO-RE can inspect its missing second slot. check_subprogs() previously
rejected this form before relocation processing because it is not a valid
subprogram terminator. Moving CO-RE ahead of check_subprogs() removes that
implicit protection, so perform an explicit check before applying
relocations.

Include core_relo_cnt when deciding whether to prepare program BTF. A load
that supplied only CO-RE relocation metadata previously skipped both BTF
setup and relocation processing.

Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/check_btf.c       | 12 ++++--------
 kernel/bpf/verifier.c        | 12 +++++++++++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..bba5a727c651 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1197,6 +1197,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 
 int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 			 const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..4c1ed842f661 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -338,9 +338,9 @@ static int check_btf_line(struct bpf_verifier_env *env,
 #define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
 #define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
 
-static int check_core_relo(struct bpf_verifier_env *env,
-			   const union bpf_attr *attr,
-			   bpfptr_t uattr)
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr,
+			bpfptr_t uattr)
 {
 	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
 	struct bpf_core_relo core_relo = {};
@@ -414,7 +414,7 @@ int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 	struct btf *btf;
 	int err;
 
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+	if (!attr->func_info_cnt && !attr->line_info_cnt && !attr->core_relo_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
 		return 0;
@@ -455,9 +455,5 @@ int bpf_check_btf_info(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	err = check_core_relo(env, attr, uattr);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d7080c260d8..33161dc64568 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21199,6 +21199,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_diag_init(env);
 	if (ret)
 		goto err_prep;
+	if (env->prog->insnsi[env->prog->len - 1].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+		verbose(env, "invalid bpf_ld_imm64 insn\n");
+		ret = -EINVAL;
+		goto err_prep;
+	}
 	if (env->signature) {
 		ret = bpf_prog_calc_tag(env->prog);
 		if (ret < 0)
@@ -21274,6 +21279,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Apply CO-RE before validating the program's instruction layout. */
+	ret = bpf_check_core_relo(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Discover all subprograms before validating their layout and BTF. */
 	ret = add_subprogs(env);
 	if (ret < 0)
@@ -21283,7 +21293,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
+	/* Validate BTF against the complete subprogram layout. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0


Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB008313547
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009802; cv=none; b=Vk5s+pIVOioTdRh7HHf10zdxKNbe+YTy/dDTPbm6+3s5OnkRfFK8N03EiP/VBHZmvamQTDs9dj/W9MwrRfYTmYbtjSjzyM+pulM/zYuuB92f2VVWjmvqf5Ny34rvouSqgUR07lwkSuv5CdC+nnXQPlIADLVNoI7vh0z2CJNgy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009802; c=relaxed/simple;
	bh=WfNQwDn5aGW1w+xUYvNaj/B/o47fYjbjsFlRiRNR55k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/zcITbhSDAB9Dy2PPo/UDQKPVQIMqzo5pfYoQBMR6tptCPbswNGIDmcmPpcHzd1Jx9/q8VKLrAI0Xb418zcVxUM7txOKgITmT5mOOgjOY+DHKG9Mj9DsdJUxDfx1LnugMhLQkQ+OVwUw07Bx8w3Wkbj1nivKKRMy27mIJqQyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMuquKrv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMuquKrv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b23f90f53aso39627375ad.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009801; x=1775614601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8beuDnAQzJUSwqYVqMdp9LC0rJ7ORjD2xLlT0OWuus=;
        b=KMuquKrv6X5qkMyomFwx54Oy4qUfM3BvLbmUuihXLwpMDd4d8rv1QJa/QIAQ/qtO/1
         Atj5aMTRH6HW62KfRwO2X25nwr8OpxqJckGngDqbb3HoGze02u4pXJU+j3MfWuZ+CXi0
         yA1saFk1lj+75U8TKbBjPt098Hz6hovPe7JyLtCsvZmboMT5p33a3AM2PhTuXTaRGQ/v
         8Z3xQlgJD4NtqbKjpMtf2SZZuy0Kl5KKrp/nVxR6EOkYt5RlKmi8pavWMTr/5k42ZjOL
         1Xv0O8Eck96HBietEdcs2n0NuYB6/4xQ90ZCXMT/u3IDvPfca7UcK+tmBqi0PwtmBIVA
         g/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009801; x=1775614601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8beuDnAQzJUSwqYVqMdp9LC0rJ7ORjD2xLlT0OWuus=;
        b=k8lJPxZtgd2Oyxz/b1v8w+ciq7khsbJEW76CNx1Ym4/jrIYtkn3eiRjTZOjSgLNKUd
         To53oGbUI2CeoC6n8/WUUYrtc5JXgMp0P7a4n26MqhYVzlDPFRaE0354BAX0PbsbfIuo
         5mAdhCWWZAfFXrAVY66kPlSTDuSDxek9e/PQbXG/MFjNM8rDwlrkOUffwJDiXF6p/PcU
         thXnXv0WcGVSw9kMDBDh8pyLaETGVDA41LPahtzcX7w4ra8sXoZpnwdSRCxu7+Oo5Ne/
         VV5jWwasdKf/tiS07vYOalRI2HsFDH0bG6x841J1iMdJldDWDcTQNmv78gGyGr/QQ5qh
         zVzw==
X-Gm-Message-State: AOJu0YwcfHJ4FTFYG3bfMd+KZjTfhMTfNKGCk9M0YM/CpPKfQV+eAa8q
	pTOmHSYrikhEsTCDKoq1LK87LJy6UHAfohTnhEYdgoxpbw/d4p5eW2NX7vbKOA==
X-Gm-Gg: ATEYQzxHBwCHP3r5+PINS7+nCnnXCmX+38mU/MUSA69gGJp7NPvwjXO9IKX0dKJ+QIK
	Vs5dJAehKNP11H9DZsH3OX6G537n/z4cBsJgxR3J3GjRflmrxk8xa1vqP2hFhY81ImzsR+IIsf0
	Rmm4nOYYqrJ5K0D+i5SL6k+eCfXVbmTotRNs9UddbqPjjQEitbGytqTbVkCIeQkaT6cUpcCKkWE
	r9qc5CLnjX1JkfMZnP3xQZNaZUuKzRGESuA+oXvgJ6XzPMo1kR8KiCexk/leYacPgUYQDDhM/p3
	eS6/GIvcL7wuM+u9YAc0ihbQn3EBJpxnmXvXWIfeDecr4FMZ5EzjPcJC8+d99uinAeJ6hN3OCvn
	NMXjRaYsekiJk0VyVpcq9rEZq7E515dh076BGXiEvaSef2tB6M88f7K1MiHR9ZgfcJHWy7fm80b
	4RxHxHjJWdfSDxULNdBS//Jx2nfcwXQscIRCd8vLt6E3K4qYS5tb6KMb5mzIL8ULudW7CBcvHTR
	EZjl//powxciq0Qars0L7zj4/XBXlY2TJ4L640aZObDIxPfHpZsh98ujhvyjQ==
X-Received: by 2002:a17:903:a8f:b0:2b2:4c92:c389 with SMTP id d9443c01a7336-2b269d26896mr15683275ad.34.1775009800614;
        Tue, 31 Mar 2026 19:16:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24278501esm132699995ad.58.2026.03.31.19.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/6] bpf: Do register range validation early
Date: Tue, 31 Mar 2026 19:16:30 -0700
Message-ID: <20260401021635.34636-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Instead of checking src/dst range multiple times during
the main verifier pass do them once.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..3ec786361698 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2249,13 +2249,6 @@ static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
 				struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs */
-		for (regno = 0; regno < MAX_BPF_REG; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_known_zero(regs + regno);
 }
 
@@ -2908,13 +2901,6 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_unknown(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_unknown(env, regs + regno);
 }
 
@@ -2947,13 +2933,6 @@ static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 static void mark_reg_not_init(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_not_init(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_not_init(env, regs + regno);
 }
 
@@ -3958,11 +3937,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	struct bpf_reg_state *reg;
 	bool rw64;
 
-	if (regno >= MAX_BPF_REG) {
-		verbose(env, "R%d is invalid\n", regno);
-		return -EINVAL;
-	}
-
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
@@ -22070,6 +22044,14 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			verbose(env, "unknown opcode %02x\n", insn->code);
 			return -EINVAL;
 		}
+		if (insn->dst_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->dst_reg);
+			return -EINVAL;
+		}
+		if (insn->src_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->src_reg);
+			return -EINVAL;
+		}
 	}
 
 	/* now all pseudo BPF_LD_IMM64 instructions load valid
-- 
2.52.0


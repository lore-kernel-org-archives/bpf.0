Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EE3905EF
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570408; cv=none; b=iKWcxTGL6ZHCUN3ESz0Af4Pv4SKemCacz05d2G1ohbzRUnIl4gpFjxOy4Mi6/9csh5XpE33cCWWV96w5Lhb4hqnqBMbQ5eDoeW76s/kxmg8REoTKS/+CvkMxhNRPJZ3vcULqcB/WY2WnKe5D+QEYOs1SOJ1B+ZonzJkKmjWDytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570408; c=relaxed/simple;
	bh=NoFQkmoHWn4hr3bekhYUsRXLsQ8FlB7OwsAmKkktFKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4uZxSao4hO5yZQ4nMDyvo3ACV0bKZwrRndeTos/m4e94iWEI//MYodTNEsuCyTYEfVcHgaO6KPc0egTHyUe5D6E0U5Fiu/idR4ombP6J5hQHMt54VSLcrGjyDf0CWyiyoFxpr4mlq42CIdY9cdoOR1At2jnhMIWyJ59/o69COk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdgvLSQ/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdgvLSQ/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso29838925ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570406; x=1786175206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YlhbUEwlCrrkAHrfDnrBY6Tauy/7Aok8t0AmG8wYubw=;
        b=pdgvLSQ/LDpoiAl+T6keXg8qHq2+Xyu7+jafdLNZVwv/PAFN830+3xcpVetZjj/RWL
         rpo9U+F4y++wcfD33UfZGICyFqJQPEZjCtzfNBMPxujFM+jo1vjQvyq9NKqYTZvUoOxv
         B+574uBgVVPWRjNe9EN08xrb8kUVOPG9ecZN12BqWY0L5xionV/QH230AsI0w8+3hlzw
         c8s3uXrNwER3BcMGHY+yb0GBJL4gvfNCXtGGFUbuuUpXMwZT+xx181iLDGkGF4fBGC1Q
         cfpKiuYD+jKdogCQi6oLKnwkvkQcGHoAsev5wBxvDB7b7g+gKnnNxClWYX/X2+dCeXGr
         MUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570406; x=1786175206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YlhbUEwlCrrkAHrfDnrBY6Tauy/7Aok8t0AmG8wYubw=;
        b=M7iPvdGrUtzA5DX0LpQamHMAFhESWz/j73m4TAEmwciZgNFNUWj/OTj4NLMhCf0QPL
         gLdMbJnANSZxP+Jm6ojV3y50rtRtaD7C5viIo6YCBKcCb75uhfh0TXWC2JNQaYcO7u5W
         oX5zqf/nGhnBLj/9TGSG77oMXPedrklRBWOF1y9K5+MuXybP8D3L54JnrxYcVxbb20gU
         IylQ47IeVeouLvUE4CvLGw8WHZQJi3rJTANtL4O0zQyu6W5YeiIZDF/PyHRme5hMWm6X
         7ydx6Bu/jKo7X8x0P4qB4+hqxGtG0vIj9hvWTM0Q2n3v6lKhqi1W7jLbOua86C3jrWUW
         m1pQ==
X-Gm-Message-State: AOJu0Yzaf3aSI/u46aUeEKvawJzfOOeDnzsBrehgjK/MJbJkfRmxgt21
	3okhKM4HkTwLJdtVzCxRl59xTcfJB/Ea3FczJ6Xe2myhd5/3Gn1Z0bw0N1//Yg==
X-Gm-Gg: AR+sD11rXDBCzIofOSbEaSOVLtbn+tFEDKLhpujJcjB2RxhUaPQ0eXBN9rn6dmTkabz
	fgubPe6wwC2LQZoAk61On7CwcvBUG8vu758l+lTd+CA3MUTuuMSOVq8+etznBNtCeQabbi7r8Ew
	Cxxv00jCdqJN2Y8ScJye458LguJcNCg9jgy51Ui1/ddW2ooetRpu/3iQyqhIg1D/mLhT232VFvi
	4OkRMKneO7/rZ0p211GfQUrqrIMM+1NQRfchzGLZPLr3MATUQkKNOKzPZ6FPje8HOfnYjoJ0FFb
	eIB4+CBGRD48SwSe++pxxff9TfgxXeGSKpBojGmQGkQtr5AJ0FKUMvQ2zLCYgtTBXvKOD2qkEXc
	fj8A714dOqncWSk14dZHol7uYfU2+BuNqcijKzQpp3wui2jkaiDuKrtMDstrPMQZD/8dj3I7nqo
	qdy0fV0PKly1CE52V/P0l2cG8NmX2+biFuMO18smXRTSMXZw34zXg=
X-Received: by 2002:a17:902:ccc7:b0:2cf:b9f9:18bb with SMTP id d9443c01a7336-2d053552de6mr22695485ad.4.1785570406251;
        Sat, 01 Aug 2026 00:46:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ecfsm14974895ad.10.2026.08.01.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/18] bpf: Check helper and kfunc mem+size arguments identically
Date: Sat,  1 Aug 2026 00:46:21 -0700
Message-ID: <20260801074633.1595644-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper ARG_CONST_SIZE and kfunc KF_ARG_PTR_TO_MEM_SIZE memory arguments
already share check_mem_size_reg(), but the kfunc path reached it
through a thin wrapper, check_kfunc_mem_size_reg(). The wrapper existed
only to invoke check_mem_size_reg() twice. Once for BPF_READ and once for
BPF_WRITE because a kfunc mem argument may be both read and written,
whereas a helper argument carries a single access direction.

Let check_mem_size_reg() take a bitmask of access directions (widening
access_type to u32) and perform each requested access, then pass
BPF_READ | BPF_WRITE from the kfunc call site. This removes the
check_kfunc_mem_size_reg() wrapper so helper and kfunc mem+size arguments
run through exactly the same code.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d9e48cbf517..cb805bc97604 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6871,11 +6871,11 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *mem_reg,
 			      struct bpf_reg_state *size_reg, argno_t mem_argno,
-			      argno_t size_argno, enum bpf_access_type access_type,
+			      argno_t size_argno, u32 access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
-	int err;
+	int err = 0;
 
 	/* This is used to refine r0 return value bounds for helpers
 	 * that enforce this value as an upper bound on return values.
@@ -6912,8 +6912,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
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
 
@@ -6922,6 +6928,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		else
 			err = mark_stack_arg_precision(env, arg_idx_from_argno(size_argno));
 	}
+
 	return err;
 }
 
@@ -6981,18 +6988,6 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 	return 0;
 }
 
-static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, argno_t mem_argno,
-				    argno_t size_argno, struct bpf_call_arg_meta *meta)
-{
-	int err;
-
-	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
-	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
-
-	return err;
-}
-
 enum {
 	PROCESS_SPIN_LOCK = (1 << 0),
 	PROCESS_RES_LOCK  = (1 << 1),
@@ -12397,8 +12392,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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


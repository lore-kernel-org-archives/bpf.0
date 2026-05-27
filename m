Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3C30AAA6
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866112; cv=none; b=Q5psNMuiQKv4b1M3UkfD3mO2n6oN73+lpVTAG9Wc85PEpQmvaNZkAYfEBoXlukjYz0rT16Em2JYHDqiwHLOtpTIQOLmiKb/05GQz49oav9HR/JwcGT1t0q8LQwen0pkSln419mIKtY9JzzlDKt5WgApO4x2PJnVgowx+tDnqlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866112; c=relaxed/simple;
	bh=1EOqZs/9ny1tlXy1bUn1d7cFJcxuMfiujP4jHefX7w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do2KySMM1kLtkK4ykJph0CdLAVKC8KWgL4pu1VuT1wKSt6llTI5xdgrAEuVUq5XHjgDaV43bUTYUKjqrzpPEJnmkPrIqFhRl+U1VXExivrp66MPVLq2c7Migu56qo4KpzdB3LX5PNMq+b6hXFK5BNPsRSskIlbSjdNHc2BdQG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sxavbSBF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sxavbSBF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bd266f6fc0so56631625ad.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866110; x=1780470910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npCv+8h6WNzvx9zlPhTr6B17RdDF02qk2QZTo7RdZyY=;
        b=sxavbSBFS2Otb0Qv4PDDPNZp6RF3xrUY3te0RRgAXktE6dw3DntuLy37PhtPtzyQN2
         hbKEJhacq+m99ljqeNT5Mt+UuMSVlOBcgWW4LbeHk26eYejhonvEzbJI+bcM6y9NGNjd
         6BZGM4pWuqYySYP8GTs/Bs1KJDAMODmQhs1WhlOSpEL7/ekqZ1yip4Mko6MANuXiHuob
         w/r+MyvnvCweczXDxlMpAinNdZZs8u+gCuJaPoRRnU1P9oq8kiwhFJes/bZYXvD01oMi
         Gs5HdGJDkm55ldJBF4Q24pMwSg9dLiC2x8mcFQUfBVrro3YRxOSZDVjU9iTg28VmTx1r
         YU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866110; x=1780470910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npCv+8h6WNzvx9zlPhTr6B17RdDF02qk2QZTo7RdZyY=;
        b=Gq3hmN16g/LvvEzJ5zpge2mOdsOegfSDu+IXgiE3wDRP60nQsen4lFNKGcZzlOBKtG
         nbKo4MbwwCPFTn2YtpfQKtS9Qgw4lUXFOP9D1YP7oLHxtkga8uIsKuT4/2VZW/38T64j
         KhHpvq6WrKhjgHPaqY11/wrOg8VPLnNg/uVl9eF/pE0eHR9oHBaKzwfJvxLXDxermAQq
         WBKRyomUbdUiyoxHcicaVVGMQe499y0lFHbJw5NVw66PS28b0h+M84vLKOfG//qXaCEQ
         cyb1rkuIvk+3ArFYI1hxjizO14UyZeNVDx+jOYWZ9Ndrvf7DC7NUD5cDjnuqy9LlGfFL
         7dvw==
X-Gm-Message-State: AOJu0Yysdtl7qkRtQUVx7BEKGoJYE+5cU8JvcRJSJaO9N4GT/Xnj2EYc
	SsRRChKc7dop7JCkxuYLteEUl6uk8VtezND9A22b/BrGfLFPtDLUaO6rCjvgcP4x6JVt4Chp4TX
	oW3Fh7QsWxA==
X-Gm-Gg: Acq92OEbX6kZ9IxM0hk6YcDQT84wXHlExaf80QnVLRQxMPOi6gCOzz+fT5fOHMnTgcq
	qdrmEq9oxazvdcitWa0tWI/ueH77096PotewUCzjIrrCbAatbRO7yjR9ShUfiyeF1sAfl7QDdR3
	0k/WA+7RiP+0eSlu5QP/KyY8xeqV59PCeFZ+UA3mkdcMnITavbyZTECJ+cP4IThizgSLi3tLaSY
	fc/yecCo0L6VwIKqbeIhtDdkUwQMUb04z2ag9ZLqR8p4yu9/8C3YeExEmzGmwTEsqzlkpaBzJIQ
	QobC9jOt9CxggmtkJVMB5iAB4tfAO9JoSk+EG4qk9/8v1jX76mfNhcrAm9QMcrq4EG8YzPGnx7C
	5u0ThBlJVokc6/thrNuU5A6gDnBAgcQdsuz3Rays4sPz0LuL9Bv4WfYnjquj/6FxM4cH4+ddHMG
	oSBlLttkC4ZsSFUe9DjkeHIAp9FdmHurv67VQ=
X-Received: by 2002:a17:903:3508:b0:2bd:9a28:7189 with SMTP id d9443c01a7336-2beb05a2183mr241560355ad.7.1779866109920;
        Wed, 27 May 2026 00:15:09 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:09 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 4/5] bpf: Allow subprogs to return arena pointers
Date: Wed, 27 May 2026 03:14:56 -0400
Message-ID: <20260527071457.4598-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071457.4598-1-emil@etsalapatis.com>
References: <20260527071457.4598-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogs currently only return void or scalar values. However,
it is also safe to return arena pointers between subprogs in the same
BPF program: Arena pointers are guaranteed to be safe for both programs
at any point. Expand the verifier to permit returning an arena pointer
to the caller.

The main subprog is still not allowed to return an arena pointer because
arena pointers are internal to the BPF program, and the return values
permitted for each main subprog depend on the program type anyway.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c      | 50 +++++++++++++++++++++++++++++++++----------
 kernel/bpf/verifier.c |  6 +++++-
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c6a930aca67e..7a8101879f84 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7880,6 +7880,36 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Check whether the type is a valid return type. */
+static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
+		const struct btf_type *t, int subprog)
+{
+	u32 tags = 0;
+	int err;
+
+	err = btf_scan_type_tags(env, btf, t->type, &tags);
+	if (err)
+		return err;
+	t = btf_type_by_id(btf, t->type);
+
+	while (btf_type_is_modifier(t))
+		t = btf_type_by_id(btf, t->type);
+
+	/*
+	 * We allow all subprogs except for the main one to return any kind of arena pointer.
+	 * General arena variables are not allowed, since it makes no sense to return by value
+	 * a variable that's on the heap in the first place.
+	 */
+	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
+		return 0;
+
+	/* We always accept void or scalars. */
+	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function is void or returns int, exception cb also requires this */
-	t = btf_type_by_id(btf, t->type);
-	while (btf_type_is_modifier(t))
-		t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)) {
-		if (!is_global)
-			return -EINVAL;
-		bpf_log(log,
-			"Global function %s() return value not void or scalar. "
-			"Only those are supported.\n",
-			tname);
+
+	err = btf_validate_return_type(env, btf, t, subprog);
+	if (err) {
+		if (is_global) {
+			bpf_log(log,
+				"Global function %s() return value not void or scalar. "
+				"Only those are supported.\n",
+				tname);
+		}
 		return -EINVAL;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9bdc3b32c05..087ddc5119e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9373,7 +9373,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		clear_caller_saved_regs(env, caller->regs);
 		invalidate_outgoing_stack_args(env, cur_func(env));
 
-		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
+		/* All non-void global functions return a 64-bit SCALAR_VALUE or PTR_TO_ARENA. */
 		if (!subprog_returns_void(env, subprog)) {
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
 			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
@@ -16630,6 +16630,10 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	if (err)
 		return err;
 
+	/* Pointers to arena are safe to pass between subprograms. */
+	if (is_arena_reg(env, BPF_REG_0))
+		return 0;
+
 	if (is_pointer_value(env, BPF_REG_0)) {
 		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
 		return -EACCES;
-- 
2.54.0


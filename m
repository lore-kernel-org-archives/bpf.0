Received: from mail-pz2-f21.google.com (mail-pz2-f21.google.com [74.125.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEF357CE9
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535326; cv=none; b=NwgKGfVaEM3VcpZJG8uqfc9+FcWhrOu9BTuKgbvb/i9im5+yk0ymYx8IMlMtNTzn8duLP6HDEE04xNuI4p/U2V3SxAZflT0/hhVJ8cXfHa2JPcLoKQQ3fVrGrK7T5SEnV4t3X1oRTrdGcRDIbk95mL2SfZuMEJ+geT97qGIsF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535326; c=relaxed/simple;
	bh=/EBmqpedMyXNs4le2UtjM/VEZab4NrlOKqHobY6nb5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs133YkWRj9mgqwLrdkNzKMxcPQl896hXPNmtvEIhOJ/c0qBOLuDm/zNOEpUmlooE/e6Mt8r5MMGbOXBBwQkjntcZZVXMANWMIZaNUqrYK7gLs9YdjePEq/mwZHf4VDxdTj76m/l6pwY30hAvxXKmrLEHSGYLNnIwG06h2CAhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cRo90lHt; arc=none smtp.client-ip=74.125.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cRo90lHt"
Received: by mail-pz2-f21.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so536828a12.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535325; x=1790140125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbuudFOahnKw+BAgWb7UD/RD+Mep0oLIS45rulzTPn0=;
        b=cRo90lHt/O8sZp0SUkoFt+OOA29mH/BroxBlP9HQ5sH8S9S7eyD96VfsQCaz+ySXVl
         bUS0fon8ijIWx/IIOIr4EPp0Z+FOg0AfKfZd5oipdtgieZn1C/JrizH3w+YPjKk9kaYS
         S3gn6Be+V3iwq5Q3gG+328psemmNigJLGno16iB1c87yqVBOoponMw4cXnuAIrJD1va1
         REfnypde9sg+k9exfnRFZt57orqhoJyyvuAfVkAeJISakhBc8etVNLtazOU6dLOvOVHJ
         h7ci5WYfDhxMf8MALyh6AAVj2tr9JZL+G9HLdP++BhWmhLLvr+iRKLvNRtHht8LnQ5MX
         SXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535325; x=1790140125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbuudFOahnKw+BAgWb7UD/RD+Mep0oLIS45rulzTPn0=;
        b=21MCYjkuYx+XgOaBvx6qomQ20I/t1OSJXeiuXDi6s3IJEWb+6CMUzQcwoMkzbkZTrQ
         SaGeVCi9eVrHQDcMYQuImy2enUADk5vl7FLGXD89973qtXyseWidQCQsQ1Fc26Ilaxi1
         Qreg6yrC1awGs+6fNR9cgnF33VtMYtjka0Vf61GJIamkL/Nbm18Gh0vBaWry/8s5zc9M
         XDjSZzqumVc3ZAyKvQ1bWoQgUnWza0gqPezDeB4NJy+aidNYr5P0ueRz5SW4Z7yLJvBH
         4XxC3tAynAE43rK/8zeCCjSW9Xmne9JS1mxbZpROM35AWTX0K7hjPRSyVi+T/ij5jqp+
         p6Ww==
X-Gm-Message-State: AFuF++msuvMJ5q+ovIrUW4opEYCjfNxxfxeM30TjNCP7bgx/vzXV8mcb
	8F6MDDtxVEtLD7/5UhtD3B34UtUw22ADk7e/ZrqcuP1CNMGkekZZumGB7HnWYmDZ82azlKWWDSI
	K9HD6KVc=
X-Gm-Gg: AYBFou2soKIV7ADUan45BhXMRW/yXDrhEVqXiKXAmlN6zZJ1LaJCVPEeAn3nCGuDqNv
	S8QhIGfaSIhjKGgj+B/vGj/0PQ0uX+BzdqUVi9UI4/3vUUZWHyzGVYI3HNLxmm+k12fVde1G5A0
	3z5cjyC6FqjxdEXMUfRygMuaRInQp3+ZcEEDA6s98fN5rj5aClctjT33kfOfPAXA4HR8bhUmYT7
	FZ7YEzpj/JsPUPctJ65t2q1VRCczyVgfkKc0oGu8uoyz19hXdzRt//jHnwQIvr6jgm51Fp5qApC
	c4dym8jAEdyniRq9MzZ4O5XjsSg0B/dEUqXe9KjJPC6c7cjZtfkaiGFKIgnlTVaZ3kRpkX9KEdI
	8a//EHnmo7yFoSeQu2YTQ/OD7DSwxjqs/xaSeSkVWYnkhVNeqGHQsFfDlWfxUKobH2J8U4MxDfn
	FJ/ErBIOoPYKxfSCnwxmGJ8fBB04wvJT/v3tYCGFZmX0pdM5sG72VGkg64v3ZMdmx0iW0x3DxMQ
	/pamMC8EjUikLau1irvuNDxlyci/bt3QHn/SA==
X-Received: by 2002:a17:90b:3c51:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-39e1e5047b1mr3271726a91.21.1789535324587;
        Tue, 15 Sep 2026 22:08:44 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 09/11] bpf: Track whether dynptr type is known
Date: Wed, 16 Sep 2026 05:08:27 +0000
Message-ID: <20260916050830.8774-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TYPE_LOCAL dynptr type is used for two different
kinds of dynptrs in the codebase: Those that are created
locally and backed with a memory region, and those that
are passed as arguments to a global subprog, whose type
is not known at verification time. The two kinds require
different handling in certain scenarios, e.g., packet
pointer invalidation. However, there is no current way
to distinguish them.

Add a new field, type_unknown, to bpf_reg_state's  dynptr-
specific state. The field designates whether the dynptr
type reported is accurate, or a placeholder for "type
unknown". Adding an extra field to bpf_reg_state avoids
unnecessarily splitting TYPE_LOCAL into two types, since
they would behave identically in most cases.

The change is currently non-functional. The new field is
first used in the next commit.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d5b4ab0ba..76aa724de 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -71,6 +71,7 @@ struct bpf_reg_state {
 		/* For dynptr stack slots */
 		struct {
 			enum bpf_dynptr_type type;
+			bool type_unknown;
 			/* A dynptr is 16 bytes so it takes up 2 stack slots.
 			 * We need to track which slot is the first slot
 			 * to protect against cases where the user may try to
@@ -1531,6 +1532,7 @@ struct bpf_map_desc {
 /* The last initialized dynptr; Populated by process_dynptr_func() */
 struct bpf_dynptr_desc {
 	enum bpf_dynptr_type type;
+	bool type_unknown;
 	u32 id;
 	u32 parent_id;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c08ea94d..357ed7c30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -688,24 +688,26 @@ static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id);
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id);
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type, int parent_id)
+				   enum bpf_dynptr_type type,
+				   bool type_unknown, int parent_id)
 {
 	int id = ++env->id_gen;
 
-	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
-	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
+	__mark_dynptr_reg(sreg1, type, true, type_unknown, id, parent_id);
+	__mark_dynptr_reg(sreg2, type, false, type_unknown, id, parent_id);
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+	__mark_dynptr_reg(reg, type, true, false, ++env->id_gen, 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -717,6 +719,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, err, parent_id = 0;
+	bool type_unknown = false;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -772,10 +775,12 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		}
 	} else { /* bpf_dynptr_clone() */
 		parent_id = dynptr->parent_id;
+		type_unknown = dynptr->type_unknown;
 	}
 
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type, parent_id);
+			       &state->stack[spi - 1].spilled_ptr, type,
+			       type_unknown, parent_id);
 
 	return 0;
 }
@@ -1945,7 +1950,8 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id)
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1957,6 +1963,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->id = id;
 	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
+	reg->dynptr.type_unknown = type_unknown;
 	reg->dynptr.first_slot = first_slot;
 }
 
@@ -7783,6 +7790,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		meta->dynptr.type = reg->dynptr.type;
+		meta->dynptr.type_unknown = reg->dynptr.type_unknown;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
@@ -19889,8 +19897,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
-				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0);
+				/* Global subprog args may be backed by any dynptr type. */
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, true,
+						  ++env->id_gen, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
-- 
2.54.0


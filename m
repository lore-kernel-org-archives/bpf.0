Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06878577E3B
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097654; cv=none; b=dWQDSyQN1ArrZZME08DYjpcdDqnH8Xgw/2jPl3Jg1G6g/p8kCg8VNOJCBsewjBES4a2MRhIEqFVhOowgknl65mzHf3znM1yiQtTJOazWK4GB2ykhgXBFBHe4CKjKVwvVR+wKcsJbr0lL8vcQY9Tki305zMVTg2GuQDuFBlDUdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097654; c=relaxed/simple;
	bh=+wqleCA+p9rbs7ppEm2zoLuG3IWPujpJnMYbg025GIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYINjxzmzImkSVHDDJN9R3LiAWpD7H5lJOTaCGJab6ABV2N/FZlRZP+JO84Pr/nKMJ/E6qJawgvrw2kxS/MvEXSbpY8JOXfMsMWLem3F2P4DJMJJWkvgXQbuPkRnexVJ7QDZ86FD/h/zN8y4w0tIb6gvHOARqfxXB4i+kiNlgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UL6E3tYd; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UL6E3tYd"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so132366a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097648; x=1790702448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZs2haudTC1Ifx9sckuF8aKv3VP4ro6sJqrcY12YPF0=;
        b=UL6E3tYdHPIlGHvq+EPDfk0W5rGjuI+xSSvWR3Axywuo6/IZAdhCewlDqa5BClJeyi
         yyq2JiacpB6sCmj/28pYvVWGA2ogMdnmJ3YqP+JOFhAzU6wbiEvmu6zVZcEBwd7Ciw8j
         s5ed2nkLilAQ/kaaB/kmRNmuo3rMgfHyKboYTyGUphK9GO42g98mzc4G9isiJFvgiHpI
         EUsbZy92rS0xdytlnH/bnqigpYTNBETl1vNE2DeFx7L6JVHABSac6SJR+fpf9SKRo53G
         cd0ZNjmzBGo59F5y5ce0mJC4zmed9c1ibBcPpVrPGn1fSINwwezH9XqXGYNqBWElv0E3
         hPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097648; x=1790702448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DZs2haudTC1Ifx9sckuF8aKv3VP4ro6sJqrcY12YPF0=;
        b=kyzGD2KASiH2NCJtO6ZxJkc1CKUd94OJvdMIk3rEVNocLkJTzd8F9G9MKhVE8/xEwL
         Mhn4jNPJfuoJuxxnLRLTOrivun8FnraiSj0B9zX/sIpgXbXj/TY/i4/fdvv7CqFAcT30
         UkFr+YcdNI0TbDJQMQnorxzs0PLE6aq8p06QRVrAR18RoDbhS4gV9+rfrjxK1kyELlbL
         FmnYm8L/hqaY8QXPmtDzvSelofBgtk8QWwHnaeZyMHsSxu+gfFWVpBn0f+JBM+TR79hM
         yEgbZZmo1btISFwdeDK0cFm8/3CIRiGy8U6Dk6/8m55bf8F2NZNmvT/nc0Bq7KziSLBV
         y2yA==
X-Gm-Message-State: AFuF++m2YSbkeA5O2KNwYAGuxlFBkqO4jKFOWDDuRVQPodx9kbS+aIIs
	3KVx1u84SBmXN+8vOjVUPV36qcgx9jDngptN8ZqNRISTzOuSPpXRlN4MVaAaLlDNgZzahUtI3Zt
	lGE8XxW8=
X-Gm-Gg: AYBFou1GpENJLV8YsJfw17NctgbwzmVI+c4xZ1xURAPnGVLWCf7tXfjAvEB2WA5AoTc
	ByH7Lvy9g5/1ft2ZdOAVREV0Z7+Nhf5ERxtkoGgPkaiPXTKzDYV21BNnxh+puIQO7yd79hTe9G2
	fFvspLuVn5+4QBYoGzppmEt3SuDrzrBBrb4XBviTl0vz5X40bJizjHkqMTI4IdhHwiJewq23RPC
	lpdaxNZa4cr9k4+h5fAbcDwELCg/MkF1qgik3KR6FxS8+QwOa11Yl4NirhKC90lWGPcX7L+WsMD
	oMwYU6RcgbhTrF8nW5sdb4lBR/VKjm857XPxOb/m5J7JqnzJEStT215Rs5fPbZcY6u+RKFZ82Y6
	RqoyS1tUDH8i3wBf+lqmneR8wEKCChU4sqJsFKovnQz996BNpJx81isnelwvJhQJkqnCSsYZqYq
	fDkCxjbac7sk0ID0i+1GWvbzjbnyCTvF6yw+98snbw0iJunFmjAfucOnDIs/sTnlJDE0bmbb6Nd
	4yOKvL4I/lJmwviGyiHqLdg69B+hgCdebF/cWf8Cw==
X-Received: by 2002:a17:90b:52d0:b0:39e:1693:c3c1 with SMTP id 98e67ed59e1d1-3a07e5973c4mr163619a91.17.1790097648106;
        Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
Date: Tue, 22 Sep 2026 17:20:26 +0000
Message-ID: <20260922172028.6269-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
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
 kernel/bpf/states.c          |  1 +
 kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index be0ccad15..f57730d1d 100644
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
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c..360aeb5da 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -795,6 +795,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
+			    old_reg->dynptr.type_unknown != cur_reg->dynptr.type_unknown ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
 			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
 			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cebed6c9d..da110cdbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -694,24 +694,26 @@ static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 
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
@@ -723,6 +725,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, err, parent_id = 0;
+	bool type_unknown = false;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -778,10 +781,12 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
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
@@ -1951,7 +1956,8 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id)
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1963,6 +1969,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->id = id;
 	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
+	reg->dynptr.type_unknown = type_unknown;
 	reg->dynptr.first_slot = first_slot;
 }
 
@@ -7801,6 +7808,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		meta->dynptr.type = reg->dynptr.type;
+		meta->dynptr.type_unknown = reg->dynptr.type_unknown;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
@@ -19963,8 +19971,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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


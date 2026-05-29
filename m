Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5935F603
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019394; cv=none; b=uezZlMp0pvLm9HiXOC21948m1Kte80t3fQsJCmZzRkx7QDpo2+22AKXzdzjB9MpLv76H4Mo44XbNMoENQBP/8kbqLo2xEavgGS3VJ03ZEPu4jwS3IhoZDeIBq1NusMn4rH2k6bbV74ICtTTE2cFFLqL5DnDjrUvrZe4PIwiKOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019394; c=relaxed/simple;
	bh=O1PihKKyybnh0OrGueQapQSt0HIjf9J3uBUeibbhu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGwLXjjsaBSJARTXXkkS8JxGB//sr9BDAmCwLBc3QiwsF0+j5ktjRYg0A0u4P/NinSKBEXZlBp30rsyVkSclMGk2WepigM4Qov4/reQUhfjQEF+w3Uau1OoGFMagC7XqvXi3o9+MrASgTYxUDMu4RPIhDBC0tz9FUJLHWBbdyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ny9rpJu8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny9rpJu8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4583f0a1aso98261355ad.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019389; x=1780624189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfGQBj3Jm2Q/AGII8DfWgnJibd71heaT0bL8CgHQHYA=;
        b=ny9rpJu8DXR+cUKXF9ZMmLh2jEhl6BhSK1wf5/3mJnnjwhJAHbYZ7aWHsKLRVCcNrD
         gsYkuPrx1MzdXD81ts68haZGAVCRfBnIpEhWFss9/UTQ5jFf7tWRvPkwRGlth77WdMAV
         8MsESl4zKj9M5Us0lhhpik3gE7TUqs6rJUIc9A/ey8fOUhnWc/xmloz8eRQcEW7Nn0mF
         xaqc2zroaMYTh08gR485WIT3FgCgm6Nx99hZHfdVOU8od5NkvDLSctek0+I4RViy0O4U
         f2L+ND/TRo/undJInbTkjGVcwQZ17NTscQLvTLNiYjf4ZkdVeKzZCyDRGL6ZbadxOQUM
         3Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019389; x=1780624189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfGQBj3Jm2Q/AGII8DfWgnJibd71heaT0bL8CgHQHYA=;
        b=dJYVr8T0w3nbLjz5gr8Thvilh/NU02hlXi4F8lA5W6niAQY6b8qJM9Yhxel+eXHu17
         hHrzFGI+pB1Ntv0bdK36i4HvF5oGOjQMZiUFqKjf/zotWbPqqPx79CoFYqxCR4jJumRu
         DfncEFOG1X77jr0k+1Kj4praZ5BNxGRZPTeZ+yQSyew1AfHBVykivM6e36+c3RFlJ+0i
         pU/CkXNKKS1qwXa1iBqFewxcu7uKP3sBMc2PXwjFgx4/zssylp490XHiG7Jy+1XOJCVa
         O0cIpntXSJBF99vuIjqFFsgFShitFBIaO1A5gss9YdhB5EtWqaUp4PyMz6iTVlPbXhi9
         CTPg==
X-Gm-Message-State: AOJu0Yzd7t8MfoPjPr+O1ZKb65qJmrLeDMouSjUOIiY2olHi5R+jv4KX
	jVIF549WQqfs2zjcqdqPhGCuOoNIb8N8Lm+Vxce+obAvfu3LMomzBxspSG4yQw==
X-Gm-Gg: Acq92OFEn5dLL2gAj10kTUQhD2jDiNE8efk8KpZiOykyVj6qnrgL4BR5JaIX2bUHCYS
	k78q8X48Vl8qNX86MOswEzxjAUoMUcL6CMeF8JjyYk+xa/TgTGskBO97lYocly2JfcaVqYLdiMM
	TL1P+hu0KbHq28KL5h6rL9ipStgs9n0Y014OXz1IpJZzI7FWY4Yc1xBg7eCO6A/gLovgIBXtBjJ
	2uZHD5Y/h6UnaQRMenu6sqCcgZOdl8L2aA2fBAoOOtq2CX8WV7bwty7ESoBOzD6RAa58tNK0j7N
	t62ZGNn96HgLrePr8NhavbclLYrL3/UuiVVB2/Kjww0nxwa1VM/pJA0zKnYDQTYHqK0TsTQKEfl
	/TtCPpAvLD+cPxw7bdQWEFi3eyhsAcxgNK5fPSAsdSAdkwWrqRWlPJT0sMYegdNSF97sEfHFi3y
	DGoEP7145RMod1NBWZ/WICUsPl
X-Received: by 2002:a17:902:c412:b0:2be:260b:fa58 with SMTP id d9443c01a7336-2bf204f3f1amr10101415ad.1.1780019389405;
        Thu, 28 May 2026 18:49:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b00ebcsm664285ad.51.2026.05.28.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 09/13] bpf: Fix dynptr ref counting to scan all call frames
Date: Thu, 28 May 2026 18:49:32 -0700
Message-ID: <20260529014936.2811085-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking whether a referenced dynptr can be overwritten,
destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
current call frame. If a clone sharing the same virtual ref parent
existed in a different frame (e.g., passed to a subprog), it would
not be counted, causing the verifier to incorrectly reject the
overwrite with "cannot overwrite referenced dynptr".

Fix by extracting the counting into dynptr_ref_cnt() which uses
bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
all call frames.

Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when refcnt > 1")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 52 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 375e5e5f9131..3a4233396aae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -786,10 +786,29 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 		__mark_reg_unknown(env, reg);
 }
 
+static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
+{
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int ref_cnt = 0;
+
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 << STACK_DYNPTR, ({
+		if (!stack || stack->slot_type[0] != STACK_DYNPTR)
+			continue;
+		if (!stack->spilled_ptr.dynptr.first_slot)
+			continue;
+		if (stack->spilled_ptr.parent_id == v_parent_id)
+			ref_cnt++;
+	}));
+
+	return ref_cnt;
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
-	int i, err = 0;
+	int err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -803,28 +822,15 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		spi = spi + 1;
 
-	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
-		int v_parent_id = state->stack[spi].spilled_ptr.parent_id;
-		int ref_cnt = 0;
-
-		/*
-		 * A referenced dynptr can be overwritten only if there is at
-		 * least one other dynptr sharing the same virtual ref parent,
-		 * ensuring the reference can still be properly released.
-		 */
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (state->stack[i].slot_type[0] != STACK_DYNPTR)
-				continue;
-			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
-				continue;
-			if (state->stack[i].spilled_ptr.parent_id == v_parent_id)
-				ref_cnt++;
-		}
-
-		if (ref_cnt <= 1) {
-			verbose(env, "cannot overwrite referenced dynptr\n");
-			return -EINVAL;
-		}
+	/*
+	 * A referenced dynptr can be overwritten only if there is at
+	 * least one other dynptr sharing the same virtual ref parent,
+	 * ensuring the reference can still be properly released.
+	 */
+	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
+	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
+		verbose(env, "cannot overwrite referenced dynptr\n");
+		return -EINVAL;
 	}
 
 	/* Invalidate the dynptr and any derived slices */
-- 
2.53.0-Meta


Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4520396572
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503823; cv=none; b=fKw2ihppauNaKQq+lWDx5E6AVmtar4T0rUBXMk4uk2IRMDECLX3Yeo/ayjjBlc1d/7khR7GHH0dfJYQSO8Tw2j714ZVaKjEsMzeYGy4HV5j6kF3v3VGuCRa8MYxx8xcOqMA7IPz7LDrWOrTNP4wMQHE4aHZKveJq4hAIKtxjKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503823; c=relaxed/simple;
	bh=Zsdy3wPwotHvzHFWuQhJDmmJXIU6zHLGNKRZtoojSp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6R8NalxLcY5dvk+1IMCruW7bVcIMp7U6fJOoJ+kZ8BoPRRbRJkvoX0AokmbnpbPmzkjiPUhzLsWs6XQUFxMSTOroXKJFiWskXj/n9g7SIlqDHPfpthyxYrmx3XzwSUyfBCY/5WES0ejB65DSBv/UQokZN5+gpQhhNICcjjIJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyg2EYxo; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyg2EYxo"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccf0fbf41so3016985e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503820; x=1789108620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSqBe4XSeOtbU+8gCzXyc6p8mDs4jwvyRJsJVF7a8DM=;
        b=Eyg2EYxob5GTYv1nwxhxxQ40jlfbyF+281bqM/59v+eO/fSGRx30c3yyBcSk5LKr4Z
         7sYcrl+UFImyKEc5za0kc3j0IW7tXps9XqFYJ8GR8z7NFtB3FNlURzGsdDUWqzuenoYF
         C34NibStVQ/VXxIqkKRdMQEpobym8CatJV4NT9SLbuWfZKBwo5KkcXMNNyKDfsLMA4a2
         eS39kEWJfkMnjNHQxfas33Ku03wCHmxW1ryzPzP/yDRRGCoGRlpuezQNpnZe+VexnjSc
         CsMAcXO5+IiSVtGSgw1ln7493SLHbAlaUcSBihnI8/EeFJS7tr3TA6NwCWE7tOMbnoh/
         UvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503820; x=1789108620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSqBe4XSeOtbU+8gCzXyc6p8mDs4jwvyRJsJVF7a8DM=;
        b=nRgGTaA32Q+OWdb0Ul9XB4I6J5Vm3m4MCAGMjCOCUkX2ze/wjTwEEih86q15XBZ+AC
         k5Hr2scHaxXaB8dlStQPdh3tzXuocwu4DkNqa05BvDOsK3oZaYsHGiycD8MoRcKZP9Uk
         irExuxqa/Kdiq61sw35AemNs/tCQ9DvRhLWKGhYDQK07qrSPz3s6Vtxueq6qeh9NHhHL
         4ajO5YGmJgqAD+oZp4ZUZAIUsNWlhdmpWcYK3KD2SrpJaDwkffTtEDkJW9JeB30fnjal
         s6+vDr7MjRp/wCHawYFCnNaMO/gYFQAawcz1rnRrv8eC1tLtv6vaSj2A1PDltkc+veCx
         hy8A==
X-Gm-Message-State: AFuF++katJWNIpdGJWo+N+3Iry67loPXR1TkermABJU+BfJGVGVm2ybX
	XB1WQLcsSCHYb86qQVTloe4JR561iqTiy9v8Hd+SoLUUtKYLNvGy4qGemU/DxlHv
X-Gm-Gg: AYBFou0215O4us/zavoHPrXibYldeED9Pl/wGPjm1BfN5KebR7DUD9vZwvgn+bNtR79
	O8VYaEnJKyQd6n7S882MUWSuAAbo2Pq2oy2mwQvTPDlFaLtqUhk0lEIG3SJbbzTrXPc9xNuANMz
	pY7NiyTUk/ZIK07kGGoUuco7NJ5OeqaWSGeDGsr6v70PsHWtfafI7lKQobT2xJkUBdE3791AV4c
	6gj4O8SWzWp8GFsqyS8luW+tux1nFFvd459MUu6DovA7/kRm+d1672XjYjkN0Kx5bgZf4QIeR0Z
	63PTrDMeFPGCVxYWHjzOmpn0YVZmqbG4XnGf91B2iBp90kfzzIVEO1l/xfSmI2icEcAniJRviX/
	z5rjC4tnfYnpkVGqlEGEK1/Wa6p3xeTRjkbCFECWwVgl6xGw3ezRisS511as6sM50ZvV4p2b7ZP
	qh2H0kmgI+ShgxPj6DuU/OLvLST/pKKY1BWFTwsspUuircIOWbMh1ZwtzXF0PTxC0J1Kkv7Y52x
	8EoJjeqQCfcRDpukCYW1YxqdXHKMkkSFfkcSGXD8EB5QP3oI3syKJvoVDQiSoRZtPnyJcWl/e83
	DMqxz3rHd125XnGKtBGkLnRbFo7SBEanzzi3LQ==
X-Received: by 2002:a05:600d:4447:20b0:49c:fc6e:8cbc with SMTP id 5b1f17b1804b1-49cfc6e8e40mr6751775e9.32.1788503820033;
        Thu, 03 Sep 2026 23:37:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm138793105e9.14.2026.09.03.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 5/8] bpf: Clear NON_OWN_REF after RCU protection ends
Date: Fri,  4 Sep 2026 08:36:43 +0200
Message-ID: <20260904063650.3877826-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=memxor@gmail.com; h=from:subject; bh=Zsdy3wPwotHvzHFWuQhJDmmJXIU6zHLGNKRZtoojSp0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2uUdDN8XlNWfnvG70MxfPdRcb8YFPfZqnxWihn1vm t4eUEnvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQeaTL8M7Bhs7ydNiNdnPvG 84mXWJZGuUWYKNyZusVhw+1szwRPPYZ/yr9rEw/vevP+GUelU8MBR8+SS394NNtnMgSZRN/bVe3 JBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A local kptr load of an object containing a graph node is marked MEM_RCU
and NON_OWN_REF while protected by RCU. When the last RCU read-side critical
section ends, invalidate_rcu_protected_refs() removes MEM_RCU and marks the
pointer PTR_UNTRUSTED, but leaves NON_OWN_REF set.

The stale flag lets graph kfunc argument checks continue treating the
pointer as a live borrowed reference. In particular, bpf_rbtree_remove()
can accept a pointer after its protection ended and return it as a new
owning reference, even though the object may already have been freed.

Clear NON_OWN_REF when an RCU-protected pointer is demoted. A spin lock also
provides implicit RCU protection, so invalidate non-owning references before
demoting RCU-protected pointers when releasing the lock. Otherwise the
demotion would clear the flag before invalidate_non_owning_refs() can find
and invalidate those aliases.

The demoted pointer remains available for fault-protected reads. Exempt such
reads from the allocated-object reference-state assertion; writes through a
fault-prone pointer are already rejected, and bpf_may_fault_on_deref() makes
the surviving loads use BPF_PROBE_MEM.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc0abf96cc89..56a10f79f9a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6038,7 +6038,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 
-		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
+		/*
+		 * A fault-prone allocated object may still be read through a
+		 * BPF_PROBE_MEM load after its lifetime protection ends. Writes
+		 * through such pointers were rejected above.
+		 */
+		if (type_is_alloc(reg->type) && !bpf_may_fault_on_deref(reg->type) &&
+		    !type_is_non_owning_ref(reg->type) &&
 		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
 			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
@@ -7416,10 +7422,14 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 				lock);
 			return -EINVAL;
 		}
+		/*
+		 * Invalidate non-owning refs before RCU demotion clears their
+		 * NON_OWN_REF flag.
+		 */
+		invalidate_non_owning_refs(env);
+
 		if (!in_rcu_cs(env))
 			invalidate_rcu_protected_refs(env);
-
-		invalidate_non_owning_refs(env);
 	}
 	return 0;
 }
@@ -9519,7 +9529,7 @@ static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
 		if (reg->type & MEM_RCU) {
 			bpf_diag_mod_begin(env, reg, NULL, BPF_DIAG_MOD_WRITE);
-			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
+			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL | NON_OWN_REF);
 			reg->type |= PTR_UNTRUSTED;
 			bpf_diag_mod_end(env);
 		}
-- 
2.53.0


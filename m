Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C453F1AD5
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511422; cv=none; b=ONQPXQmYboQKpObXW0z2qqoBe/y70kHKYDSy2ii9ooQL5sGDt7uZcKTpWCz4p2id5I3uBZM7hEYZ0AK/9w6vqbV2ABFCa8dL+8jN3+cEjVWS8VzdpHgOWe4nQ4giVpYOfKahNK/b5LcNaQ17CoLS77PBVFuAQXCflsrUfIJqyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511422; c=relaxed/simple;
	bh=Zsdy3wPwotHvzHFWuQhJDmmJXIU6zHLGNKRZtoojSp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYmkHLScpH5e2dVAJTyLXNdjZFsqAUlgl9OHUbJBhCsb32M2fSZDZbSXAHO2pj4XQhU2qD4+QqpiKEn/uUkLtbEMpdYZIYJeZGo64LM70DeEPNMDXPG/uphWvIB3R4FGBb0xDAswz6SpJCrpFS5pYZG2N1d46T0bEncCFrC4s6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNEZt0jw; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNEZt0jw"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccf0fbf41so3457485e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511414; x=1789116214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSqBe4XSeOtbU+8gCzXyc6p8mDs4jwvyRJsJVF7a8DM=;
        b=gNEZt0jwf7HIuLDrdiD8s1vOfTAw6DT6L/CoWIQuFbO6kewfB42jIlfa2SDLqOvOmD
         tMH/g/0RjT09LSMj9pLJoHRzes4q6k8yBIEuB47egqRqGxh0zg6E7N+nBc1uxZe2G0By
         HroRFKnnI+bvOy776670tjI4fizBhZicqJIZg5TfNzOFeV/kHX9s1lOSzVTNy0tJORst
         ES0N4IpoNf+1QNgDfnHM1RZo1wAL3Jo+0FJKxXWUzGDyb+kzoLvxpV7ytXGcVIhgXAuc
         6Q11MkE34TZcY1ne6Q/Fi4+2KPYhO2CgQ1uy1VVwuR6LfMM+KzIxA0e+sR1JKL7JveX0
         qaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511414; x=1789116214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSqBe4XSeOtbU+8gCzXyc6p8mDs4jwvyRJsJVF7a8DM=;
        b=RYHP8KHVGuwSAZ36RiMZLSdfNVGwILGXKYaXca50+ajCEK4iVGciVkG3X6QPi5QP2n
         CzD0fvEGpneJcMymWQd1LcnFjbMbOdjtDYXlAPHXO9fF5uTNkbF0MdXQGEG1/HI9/JOA
         TjzIWf82e92BXumrzVwxpJmqGHhZWqp2KafhqJPHMo5lv4PRdFHRjHmWAQERd07SDEus
         3ZvLd7Dt0I5UNmj4xQjmW2FPbqA42idMGIGwZKNIenFjX52gb5R4NpXqiBM0sIQTX3RG
         E/KcvOqPcfnPa6mtm5yOrafewyrfm8OpwSjPHTRGODERG1jmTpazatL45QTuz094ty8c
         Y7Sg==
X-Gm-Message-State: AFuF++n20/Yhtq+fkGpP8+UL0GYmsAJUSRo2efkrRUOd+pedVptSEWjJ
	Smqk0XdGlGaNadfsx4crK2H243PZ+QSOMT3GabPcCL4U8BRbxYXB6OIzaCLRvPFc
X-Gm-Gg: AYBFou3Rfhl8DFrShnRJBfZ9+Jaq2afV6GgPY2g5ajZxe0uiqq4Kai+OWRkARVA9F1K
	2qugCZun3MQUtF0vL0+/HGG5kz/+2/kLfClIeX/aG0EIV30DpiK8XDdr4GTS3REy1akIAHnaEkR
	3BWlxflkmpVLEYR9Ckzgy5zspL1L9vnxw4sVRm56OiveCJ9CCECX0hsCODn5yHm28L0KhjUwmKJ
	s4yS/bvnd6tShB7tscpjq/5hW+zQE2lMAj7nXO20r7nocnjsSJxZRhhcR64/s77wqYI9QPH+W8i
	hH9FrCi+AZzl/XSa4XItIm/xvFNnsHtqreLR7/XLNN2v9fpBw0S0zesc8XVLFcIY92dz4v94Zw3
	0rpnDj1sdYF78Uci/R+t7nwpWDO3HBPmG4tdul1QI6mddopghw9d+yDoi9wn/hRLuWWwkmGbhDJ
	l36nk3KCg4MHk6QckNSjjyUTWGrGUcU2FFH1W5L3qGITdyzTB6x5SibYmyRkAeJqD9iXTU6jXg6
	hQDkYPncv1OSB3cK6MgzkUD8TgGBedWIdsgolHrI1aPWHITjmXNxA3WeYNZEDIO20CzTtZJZ/fK
	PJQkRCWe8Yu/A1y14jGpnnBeDJo=
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49cfc6e8e51mr16935745e9.24.1788511414375;
        Fri, 04 Sep 2026 01:43:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740af2sm53090585e9.14.2026.09.04.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:33 -0700 (PDT)
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
Subject: [PATCH bpf v2 5/8] bpf: Clear NON_OWN_REF after RCU protection ends
Date: Fri,  4 Sep 2026 10:43:18 +0200
Message-ID: <20260904084325.52250-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=memxor@gmail.com; h=from:subject; bh=Zsdy3wPwotHvzHFWuQhJDmmJXIU6zHLGNKRZtoojSp0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy6QdDN8XlNWfnvG70MxfPdRcb8YFPfZqnxWihn1vm t4eUEnvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESe8jEyTEpQCkpd/e5c6/TC pKD/BVn2HMu215bFTnJeWWOQ5ieUwsiwxC/7+YNTyv9ea79l9Ty5pXeb8NqV+67Mk90+MeuGhfc iXgA=
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


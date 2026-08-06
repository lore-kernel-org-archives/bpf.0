Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF49367B99
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034455; cv=none; b=X7FxL7qyUqSYkr/iamaZABDXZ5gIaiN1cpie5G63IVtTtwNTCUC+oirQi7gBEvKk2B1gEfdjN5BVUzrccHW0Ki2W3BQ7uAJBtvWrNWGakl18xU4VJjNbpuYby6rHvIE0COyDVmWKtGsMUI3x+bwvB8Q7cSp5Sr9Iq+2RSzaWYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034455; c=relaxed/simple;
	bh=LqeS1xBE37yWphY9vBD2ryCMCWOcfOYwwWpwUYDrZGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrNLlr7hH+UoaPTvv3N3ii+VFqHZHAlJtRcTw2qKknZQ07nYil/jotxQTB23z2YnfeeY9hdJIspYVW2V5cn2FIbmNpbrItTk9kmkk5/cld8FTFpCTTSEMAbHIvNSDBUsPDE5EgscoMU5CdQpxHR5rkdXJRXsXFJ2RYuXKDZzcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANvSmpSH; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANvSmpSH"
Received: by mail-oi2-f11.google.com with SMTP id 46e09a7af769-7edcd5f9e55so753500a34.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786034453; x=1786639253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgTYmkOJ98ExBd4yxHkoJFVvUYjK4U5+IK60jcUxR/Q=;
        b=ANvSmpSHc42WCrS7GCHfKV/YJWt2+ktnH3VAbdkYbHnW0j05Pevm5uKGfxOKwQ1hl2
         G/xubyFixRDqjBZz03lGXpNSV0SH6pXIeyV5iSLQncJRGD6CFgZQv9Zq9mKdrrImm89i
         VB9iHtD2hBNfTFeOlkQhfaZ8jdLFEsqsC3lIYsMzz37F39zra71ke4yAMo0N1z+QY57r
         lZWUzyfjCBggkswHdW9IvcBkkGqJeyXyLKrpPfReF1rv12Strp4mMZvzhDVUbeVPetWl
         0VtvFkiJ9oFkFy32+kc9Qj5jsyzr9T5RqeBsmcSFainTSvJ1EQrhMAwNutZyfpApQ9zw
         6c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034453; x=1786639253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgTYmkOJ98ExBd4yxHkoJFVvUYjK4U5+IK60jcUxR/Q=;
        b=K6SCjpZpGNHSiTkBwIHfvpvSvqjBoVsYJruK3JESJETgbhMvAXu2iYhHpClPXIk8Oh
         9OOdxe8HuPY0j9ipMuwUirLwkqUywImqtcPQLIwXbIYJAWwKeWPJ5dqlnZfIemWSSDpG
         2QIEPBnZinNH3BscUyIxn0sdYph2ZkdQD4iQRhIsYZZpkwVhWqESY48wamDxiWqffc96
         dXt64a60nUdt+UNY6TccX8DfUG+bPa+uSDzDcyEWrStFXqAhzexRhybE6Fap9g1egZl8
         21gCuPC6PVJTzP6AXF4bquX2t3YMn/0HKLzTJLc8iBFLbg2FmJrWzvyIKlwUVG8y8xXP
         9USw==
X-Gm-Message-State: AOJu0YxJr8+N0+N/XJB2otoyYBogvAvJgESI/cT1ZEhigiKS0zB11wlh
	auA4nc6miOsgebMFEoZod0bBRWyiOlTe+mWbaFXwxa6w5Qhf3k/kAETMGvGz/ZMY
X-Gm-Gg: AR+sD12sruZwIs6xrnsGed3pQ5uu2a01FX5XyahjFXzXZuxkeFdEq/Bea/wcqIDF5Tj
	wnAX6DhbJoKptrf/9aKz6ot61JtbOfs1bWQGdlhSHOiT7YBsczWv5lB/CTkolct9SDI24y0+g2b
	EOcOoq3Y3cm29sYnS69rJHXixgaMEwJToYPYKXzrO131OpKCOpFDC+1hq8dIZ1EXvpAeQJoXOgL
	9NLyEW7jpwYucJmAStLvX4BcNh3qr0Spfuo27Yz0D37NnA3UPY8MxZPPPwa9AM2br1a7J7EWU66
	BxyWaH5J7KufD9SuSxEVkuiV63WJZBRsIPE5XWpvgPvpSykHzFJzSFVJk1Q2kqZK6XOV8kvdf8S
	/aPBPo3/vyMFBhYOGjyb0C+gFpSqVCazjO3Ax77E5AtpyYgCh5KmVKQjYSxzjrJDVPLYxkS7xLb
	WPJQ9AU9Dr3xRHS9cFqz5IO585EfSrRtKd0yaOdy6K7kBQRXeJO7mdLLzv7H4Vphs++GlEsGZLI
	xzge56GKYYmUVZgoPewdeHYKMVrC/4BBFfnJjkhJlb69ccxBa5xnXzg80wT0V7UMoQum5s=
X-Received: by 2002:a05:6830:3142:b0:7e6:f4a3:1df5 with SMTP id 46e09a7af769-7f1e5c98217mr9769393a34.1.1786034452567;
        Thu, 06 Aug 2026 09:40:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df30117dsm4726917a34.1.2026.08.06.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:40:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and remove in_sleepable helper
Date: Thu,  6 Aug 2026 18:40:48 +0200
Message-ID: <20260806164049.3158887-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806164049.3158887-1-memxor@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622; h=from:subject; bh=LqeS1xBE37yWphY9vBD2ryCMCWOcfOYwwWpwUYDrZGg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatkx88aO8ddbVf4/rHk1nVc5+kvOXnfdP3F5n9y+qw9eXkh zvodpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEjrI4Y/HAbXalL2spnvuiJkpvf54m sTsTMaB07Ur3v398oXu8O3VBgZ1quYneMIFxcIDjRZx3ZTqHmeHcdCvucL2g6xp85ZeLuYHQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier has two helpers to determine if the current program can
sleep:

  - in_sleepable() checks only env->cur_state->in_sleepable
  - in_sleepable_context() checks active RCU, preempt, lock and IRQ
    state in addition to in_sleepable

Several call sites incorrectly used in_sleepable() where
in_sleepable_context() is required. This allowed sleepable programs
in non-sleepable contexts (e.g., inside bpf_rcu_read_lock()) to
incorrectly use sleepable iterators and kfuncs:

  - check_css_task_iter_allowlist() returned in_sleepable() and
    therefore allowed css_task iterator in any sleepable program,
    even inside RCU/preempt/lock/IRQ-disabled regions. Fix it to
    use in_sleepable_context().

  - The first sleepable check in check_kfunc_call() used
    in_sleepable() and only verified the program flag, not the
    current context. Replace it with in_sleepable_context() so
    sleepable kfuncs are rejected when called from any
    non-sleepable context, consistent with the second check in the
    same function.

To prevent future misuse, remove the in_sleepable() helper
completely and replace its legitimate uses with a direct check of
env->cur_state->in_sleepable. We do not want anyone to test this
bit directly and in isolation; all sleepable-context decisions must
go through in_sleepable_context(), which accounts for locks and
preemption. The remaining direct checks are in in_rcu_cs() and
in_sleepable_context() itself, where testing the bit in isolation
is intentional.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6233c0081d1..3dadf2b33a36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4441,11 +4441,6 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool in_sleepable(struct bpf_verifier_env *env)
-{
-	return env->cur_state->in_sleepable;
-}
-
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
  * can dereference RCU protected pointers and result is PTR_TRUSTED.
  */
@@ -4455,7 +4450,7 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 	       env->cur_state->active_preempt_locks ||
 	       env->cur_state->active_locks ||
 	       env->cur_state->active_irq_id ||
-	       !in_sleepable(env);
+	       !env->cur_state->in_sleepable;
 }
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
@@ -10258,7 +10253,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
-	       in_sleepable(env);
+	       env->cur_state->in_sleepable;
 }
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
@@ -12083,7 +12078,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 			return true;
 		fallthrough;
 	default:
-		return in_sleepable(env);
+		return in_sleepable_context(env);
 	}
 }
 
@@ -13090,7 +13085,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = bpf_is_kfunc_sleepable(&meta);
-	if (sleepable && !in_sleepable(env)) {
+	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 		return -EACCES;
 	}
-- 
2.53.0-Meta


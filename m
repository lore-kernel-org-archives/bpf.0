Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118518;
	b=r/wj7TVjkC6tpFgxxpgXKmfHyL4fuDWcAPZ3t4QVDDyjTNiEiVQFiZHvxY6qtNDaG4fk
	 gsUo43IseRxqbjojlWyh1Ze+/aoAwKZ0+waHpO2yYpA1oTJqujF21/oJ44jrWDVb6qhJy
	 mwoNwLMzv15U5lu+t1Z377y50mZiQRzRtU4ELdvkl7xsprQOowADGYz93DTtWE2TtYTR7
	 wOJIvpLdM3x1JvFY0wqHzVqcBKpTj2eYJBUBS2cBztn9vdwyuh7V0Uw5FeUa+XeTEGeIC
	 hBPOhq1lUsbiEHmUX9TePQyvYNsD91z6raEi8cU7edZOe9dOecrrj1hgjZzf+GCspGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPtn5ODw56mt6EieWHO/AaHO5wP1S331VtWH/+mwXwA=;
	b=Jg6NsVvCaeopmy15NgxH6Pce5Dt4AksNbm3LBO6OkdRnnZdPW+KIIhWUimEV4zIGoUNp
	 G62PxTukLgke/Ix/Ocsci1wHp/Mj0ANvIVv7Gc3QL2N17BVZamTG7fw99QHfOrbRoUJiU
	 GOkqOSD5R08DCCFN8GQAdJJcowdaetPKAvKWXyFaXV7QXqjJ/yzjzJEFAi6fc/HXuWoFS
	 j0qphRH/omMcfWt2FsNRRt1EM1mh4DRI9Fun72cQ1jCsCqacSctOg/T1HK4ddM2sbqE09
	 YoGEBFRYO+mAOJI28wd36JNWEEnH7QdPXuNbx6oXlkleZiwNB3an7wTods/URV4ucNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YIw5e+VN;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C639606A327
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C639606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YIw5e+VN
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso39009b3a.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118518; x=1793723318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPtn5ODw56mt6EieWHO/AaHO5wP1S331VtWH/+mwXwA=;
        b=YIw5e+VNS1u6o2J371Ufnju+qXryTFJahT0y+TQUUoFHMricOykj9gsrvNOwatn7HV
         gpq8Rt04rUIkaBW30TQy0yysrJctd2ObkRrz0i7aWTV1WRdpMIxNsNMxRksS2xfpp8me
         puxr1C7SPN74N6aTbw5wruC00odEoKBz/KK4vPy+GLxWVStp8BTAad4pKsM3eJ3Djgxb
         CEQ/tHSmiFJDh9QqSzmOqOyLl0/MuMHHeOINNCcyeypOMcdtCKGEGo7rAc6ViPYhlZr9
         OUiL77yuwChHPRD/9TJPAF0BFeJkYs8Rc5V+GEGK6NZhJtKkJTiHIiT2aAzVMZ88LvRl
         5AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118518; x=1793723318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPtn5ODw56mt6EieWHO/AaHO5wP1S331VtWH/+mwXwA=;
        b=CQkRbAIIjllho4E4+8PdeI8mUqPEJNt5WX+y9eU2PD9M4MvJWHTpssxMsXTewY+48w
         rh9VQ6G2JFvG14+vT/hmYa3xioelIh9wL22AMuzmbh1uJo8hgBudOefI/Gfw4cXim8e0
         JJ95W7gy/4PtSRSQ41hAh5gjitYU7pqDR2JNTkryYjZjzomyZx1TnEidFCePod6W+q5m
         3z7t4REHKr2bRe2MksXWssB2NvAPwJboKKUw528Bto+RuHJk0k6AX/ednieMZIhrkR6Z
         lNRSigZbpR9mKKrf9iqH/PbC8Q9WZIJDtqHJAKudAxic457KC28qw6we4UkMortbMu/H
         PTQw==
X-Gm-Message-State: AFq9FYJiiSz20ae667lcRtM3CZlXnCYgiLqKZJKIv35fQ3eTOsewVW6q
	xSlVLXGJVY2KmseSj5T2jMwFAvgc/Ki+RovlueI1jbnIVxg23th3KIm8KVbpwoC/gEeiOakuACB
	p0N5JNpU=
X-Gm-Gg: AYBFou1K+ajBIC8OOjm7YYm89IvZEHsteBN1hm3m4IjTgsiyXUFk+xcn1jVsaA18ki0
	BD+1l45ekRXjXWlfN60s1VPgcu5EG/QVNpkGzMDQL3GzEO8jDfhxMVYwi1nzheeiGBMBMm+UTyA
	C8vapcjV3nLt95fUDqLUt1GHN2tmLNGdpVeU8mZQGdKFGVNnNfRKSfBVz4YBlYIy7WO1dK02wOm
	C8O+fY7CDb3aSqJmR0xMM39PGyTBTTIjz/Kj79+WaPVGGimd/z/KOCLORIq/63LDycmXnO659OM
	NzdxkTIpKvD86qG+nHJX7MNs1QLahkgXIhYy9C6bSeBxR7DO0w/FXJIC4+iiUAgmVMEereFLEi/
	aDXrdsDgEnJv+Gk2NFy9Nc7z3rwMxQncBVX/cHS6aTEyHiJJEJP8tYcWvGfEuSJUGbhO9YFSCZ8
	lNacA7WMFCXNlTissQWeLgcgqwfC0Ga7abtA0DSWz4q34SvOry4ruiBJiKdAUa60nKqTNMBEKzT
	DTeA9H7Ipikv9NehpOkpI8XaTb5YL/7uPOVXxjJagh4FfHxJRe3Po3WuGO4p+iQZ+h3/7mGDIKE
	1sPoshdKgIibTQjuhQ==
X-Received: by 2002:a05:6a00:3e12:b0:886:46c:8a1f with SMTP id d2e1a72fcca58-8a367255053mr8292448b3a.35.1793118517671;
        Tue, 27 Oct 2026 09:28:37 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:37 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 6/7] bpf: Enable fastcall for inlined local IRQ kfuncs
Date: Tue, 27 Oct 2026 16:28:19 +0000
Message-ID: <20261027162820.10887-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark bpf_local_irq_save() and bpf_local_irq_restore() with KF_FASTCALL
so the verifier can remove BPF caller compatibility spills and reloads
around calls that are replaced with internal IRQ instructions.

Only enable this optimization when bpf_jit_supports_irq_save_restore()
reports support. Backends and configurations that keep the native kfunc
calls must retain the compatibility spills, since those functions use
the ordinary native calling convention.

Share the IRQ kfunc identification helper between the call summary and
the late fixup so the fastcall decision follows the same backend gate
as inlining. Leave the native function implementations unchanged.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..26b6a9df0d45 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5197,8 +5197,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_local_irq_save)
-BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_local_irq_save, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_local_irq_restore, KF_FASTCALL)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr, KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr, KF_PERFMON)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aff7080b5c85..b1ea1564e959 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19605,6 +19605,12 @@ bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+static bool is_bpf_local_irq_kfunc(u32 func_id)
+{
+	return func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
+	       func_id == special_kfunc_list[KF_bpf_local_irq_restore];
+}
+
 /* If @call is a kfunc or helper call, fills @cs and returns true,
  * otherwise returns false.
  */
@@ -19641,6 +19647,8 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			return false;
 		cs->arg_slot_cnt = btf_proto_slots(meta.btf, meta.func_proto);
 		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		if (!call->off && is_bpf_local_irq_kfunc(meta.func_id))
+			cs->fastcall &= bpf_jit_supports_irq_save_restore();
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
 	}
@@ -23373,8 +23381,7 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 	if (!desc->offset && bpf_jit_supports_irq_save_restore() &&
-	    (desc->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
-	     desc->func_id == special_kfunc_list[KF_bpf_local_irq_restore])) {
+	    is_bpf_local_irq_kfunc(desc->func_id)) {
 		int irq_op = desc->func_id == special_kfunc_list[KF_bpf_local_irq_save] ?
 			     BPF_IRQ_SAVE : BPF_IRQ_RESTORE;
 
-- 
2.52.0


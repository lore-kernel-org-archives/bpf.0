Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501B563FA4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190715; cv=none; b=ft5jwULoojhEOhOgsT5+bNIGyRI6iX948pGWHPVw5URYDA0Byet09rg4zVtPj9jw7xY0xCZg8ezGfI8PKMCRKb7Uyzg+Cw01/uTt6YkvkzwNPZLFfC7eowC1GhIUmJ4xu4Az8sAAvWwzMJnWAbxJTZqj6dUU5kX4hoiK+jT5aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190715; c=relaxed/simple;
	bh=CafoO0AOBLdKBfRt/whGtiYwRsYXGe3Vr0OYubl9wvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFB/OhAmhunbIEO4a4p1WMg9JCJKX3VtP83yCnnEaMu58MKZoIj10M/J6b6VOA6DSnVXugCNE/jaPVQ1t0fBNl9DyF0IDHSann+RNiNwQTGH5lmiRqYwRQJNqHnBeGNM/fvsAqkltHAOlFxM8WCg2ZZOA6XwZXG/YejegR46bQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6p34OiW; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6p34OiW"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso4640505e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190712; x=1790795512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDZVFWSGaj0HhMfxa6S/hrcGQ1o73/MZ00MPvdPg4vQ=;
        b=G6p34OiWOgcZ2p1GmmrjdMGE92w57f1Vq/wl7XsqECrzHLdMXfNlFiPZOS1dbazsVv
         tI0EfaWu2ojdipxN+aUNMC/avuY0ow/Bn5oBVZqv1clalqtM5HnugdxLsQ+LBMmtC/VL
         6Km2fapHaOHnW5DB4VoqC9X0UNqg5+EHzJ2O8z8YCVVhVb/Ec6PTtqZcsJKjbzL7mQve
         XBpW6eV5ZLd9PwiioOtcsC3FgrXc4CegnHFCJpIzdik52wVhckCSKnRjj5joYJXyiRp7
         dhb0kx+bmNM1tV4VZU9lksi0eVfthrnqmPHJ+mjVnq1nODi8lSD05DOFb+bCKmM6JOdj
         ygVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190712; x=1790795512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDZVFWSGaj0HhMfxa6S/hrcGQ1o73/MZ00MPvdPg4vQ=;
        b=DI28Qyb5/+K84mcXBGWcnn4BlCIvMnM0CgUnFloO1CeFlcJhFeSt9p6oup4f6wrjqz
         3X2lcaySqBdsVMeS2aFr8GrsSpivKbj0nscstPu956ZBHFIubzVGnUegn1i1bPNAnuiX
         dxrrWYuYyA4c+35YJYhK5H7suDS+xIomchTe6KOwKpvzGCXUtLyoROuEmRSHCjO79Y1d
         p3b7Vn6YoErn/DUeDSetmESxO5hOx6+gm1At+hDt3at1/AS8NE7YuNsKVbNnDAiV2ySA
         ptWcNzbWAHE5vzYB9mkSfH9RcY+FmP/SM1pPYrKG4ogUqoFNhJMJ9+G68SUOZcE/exu8
         BBNQ==
X-Gm-Message-State: AFuF++mEnyIxJlh7SS4MMTxL/pbcjeF5aPPK7iBK72/iqfeP088LDnYx
	k9DpErH1fAwUw0ExEV1yN1I7IuTJZqYAzMxfGyqKXIlDhIiEZQwwIFpfdFhWeIFT
X-Gm-Gg: AYBFou2ZSA4V4vS6UBpCJSNo5OEa8H55NZQYQNk5P/OkJatB5LW2cr+MvtwA8T0Kl7b
	t8sFZijurOpxHoxnEt2GbQ8/MBZtWzGB6V7cXqfssj/kZ+fcNV4FRgoxeIbmCIa+jKN2lswPiF+
	o9i9HHS4+l643wCcPYx7klUfXryxWVXkOci52vIHlaKwsON2M+2X/dAkKyO5C6PiJ/QBkiHq6q3
	LL4jOemaEjzWxrm2P6RJ9C5unxkTq+4GptCl0sNRvWKdUUjvgyZLBuPsqMDICcuqqIecOCUvZgI
	oUB7liMJPHI4SV0KfJu4+w+lC2fXhZdAOxBok6ZewTv+SMIdXUujbnB37WKRQajejVA3GyPTw0E
	SWyyoqvpi2dQZdk0SEfMkyajEZtoQhUklecBO2Z8dgrwze8aoBuUj/U8ZI5QpcHOYrqHmnahgKA
	gp5H1LSoHKn0yT9tb8/lLFRYsTjySoAFKRk3MxCzcVHvMUHIMnOEmbH9BFSaDy9+Z1Q27uloLp4
	bPdsHSjuG2AT+1xkZmBKKcR7R9pAMe0q4uan0JBSNPhiCKkl7sMA9MUfcf3KZeI5FaJwGSXB7al
	XEhhfXrJYUPEfJMupoEMQwdQiR4w7OXK/V1sFw==
X-Received: by 2002:a05:600c:468c:b0:49f:bd3c:bc19 with SMTP id 5b1f17b1804b1-49fe66f4cabmr2621645e9.20.1790190711578;
        Wed, 23 Sep 2026 12:11:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488687791cdsm8137892f8f.22.2026.09.23.12.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/18] bpf: Track scratched stack slots with a bitmap
Date: Wed, 23 Sep 2026 21:11:12 +0200
Message-ID: <20260923191139.2816206-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=memxor@gmail.com; h=from:subject; bh=CafoO0AOBLdKBfRt/whGtiYwRsYXGe3Vr0OYubl9wvs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4lfj2F/TH/vyFvzk57m8zfjkxXzv6PwH57zu6SaXb 9t90qSwo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNROcvwP6M30l2k7W9n8rNd Recd+P7NYJ+xaufRrVc3569+FP1VTJWR4cHeoklbF8yV1OJ8rnR16/4PzZvevtdp2+Ccu8m8RKf lJCsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The set of stack slots touched since the verifier state was last
printed lives in a u64, so the log could only ever mark the first 64
slots of a frame as scratched. Make it a bitmap sized by
MAX_BPF_STACK_SLOTS and go through the bitmap helpers for setting,
testing, clearing and filling it.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 905a081d4b62..354463a74292 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1057,7 +1057,7 @@ struct bpf_verifier_env {
 	 */
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
-	u64 scratched_stack_slots;
+	DECLARE_BITMAP(scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[1];
@@ -1463,7 +1463,7 @@ static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 
 static inline void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
 {
-	env->scratched_stack_slots |= 1ULL << spi;
+	__set_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -1471,27 +1471,28 @@ static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
 	return (env->scratched_regs >> regno) & 1;
 }
 
-static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u64 regno)
+static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u32 spi)
 {
-	return (env->scratched_stack_slots >> regno) & 1;
+	return test_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool verifier_state_scratched(const struct bpf_verifier_env *env)
 {
-	return env->scratched_regs || env->scratched_stack_slots;
+	return env->scratched_regs ||
+	       !bitmap_empty(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = 0U;
-	env->scratched_stack_slots = 0ULL;
+	bitmap_zero(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 /* Used for printing the entire verifier state. */
 static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = ~0U;
-	env->scratched_stack_slots = ~0ULL;
+	bitmap_fill(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
-- 
2.53.0


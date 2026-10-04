Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0C439322
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121139; cv=none; b=EnPekIgJZDshahZUE1oBd87+e7jMLSSM/qa7QlwRrz+QOg8b71gr8nVc9zGh+6HzJfRAfsm2fKyvJgp7vlXHeFecgNe7gGDb2sBa5xnLoy6VheI42f3fvuRglIgPi5gAM0hC83OSWtz1Vclull9uqbaDJ07/ZJ/7gw14Qc9LOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121139; c=relaxed/simple;
	bh=naAF7/nrhuJcbBovpveuM3U6TdzA91x0cdQf4O/5dwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSDZJUKC5SFPx6cQ1DRVJ0UAFoEdcREBkN+U3PJmPNfMtU4wE76vJZLDLAiti6usMHgoY3pb79h0dLvg65le24//0U1lY+xJAbcDsBPaKRQMoN3ABZQ44rOXdWZNtGwalB+hGBhvMTAUyVPq3O6AL1/OdslXPBsLRkq4oueprbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0S4u9Zd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0S4u9Zd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381b831d535so764715a91.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121137; x=1791725937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NdwazKpbHN6PcgLxQdYN3qabUPYYVZutN8bq6tFIwKY=;
        b=C0S4u9ZdhYs54cwBVFF4K0+Q0tZIiXKLUvuaiwAU09ThEw1mqr+M5RGmHbF8nkOGod
         U4DDmRvWM410j6NFGOSyA6YrRDI4hNpYgso86mt2LV+GMBNz3XY2bmGym2UDLBgr2F8+
         8CVgutPpKuF0hoAddzhjYiL8m1nGeocfO16bTXui+yYWl4ubv/93ku3VJRsP+uMVM01S
         grpaACYDsw1tgJXYa+uhJrlgw1JsJjdgAh/vGDnN0kWD0vJ2Q4utATla4A4jk+OUEDl7
         wl+8gtfZKg1BH2vKjXk2OEQyAdLMQFb+8WTWJY9eSRbPr0H5Qtvn3LdBRNE/EbcMhdKB
         +1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121137; x=1791725937;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdwazKpbHN6PcgLxQdYN3qabUPYYVZutN8bq6tFIwKY=;
        b=OXFqf1A8ZsCN+eGVaiije12N7LcwwjjfG6PtBLll1t4I6KQa6EmRA6FJ/wN0UX21jZ
         TT/enHP38vs9aQl1aHe8HBVcCN0nGspbvfC1nX2mjC1EzYoPMQkYQK5/JKjUftd4iahE
         dDpiZ0Sl5hWNIMFZGD4cZfbBlJDQE7FRlu7n3K6sh8YsfPRC/gpGfEiiHkfEnG9kHsBM
         mXMNXhI2A2vY7vUpZn1mlazLG3tk5AKjIpr94yKWjjh5oCN/BNA/niv/Nrgct9R6bXGP
         2xRfKPdfWXoczpqsg3nkrRhKaFl0pcES5hGZKKCc7qshgIx4GOYf10WGpzBIe2Ibo0jP
         z5Lg==
X-Gm-Message-State: AFq9FYI1erjHp+imfKYwlUvArlhOLdHn4IDvwfKjc3ia8zNrfLvojqUs
	EEeee492/S2w+y9wCuAtErmYLj9WuT3k3tbBtMbNJMmlmPkgR2oreTGb9Ep3Cg==
X-Gm-Gg: AYBFou03h/3M5K6sJqjae7ysaD2aerCcKDyeZzOw9/c8sTAABKSjCX9d0Ap0Ew3mNni
	TGmvCB/Gh7Blcvp4lk48BwuBwMGMWuYLV+f0fqguA+umXGRZV6c09kQr35QOxi354YUv7+uqEQi
	P3P4UBuhSyhQCm2Bw7vjWssS6wdvB6dQw7v5inNaKosBU6dXYPrNH8Wteep2dfc+Sg2pXsZR33g
	A52xhBXCeADPGFFeQAwrOKLqWywSOH+bLEtBEUDZnj6+DSbrnO/L17924RERrFLficpuLENUNYF
	ZBINtpg9GzTWNRlj2XS02Ty6LcZgH+Tp9HEnNpn7JQxeexKXJRi7sD7wE/W8Q8Ssezb4FfN3zjV
	4fUlSYHsYd4y8layb8sPFHwLuxxGiVEN1kL+XzdjHUs2WN0/Iv7K/5Nxvx0N+lob37sgWp7VKDM
	loQWGrTllXSYTzA+QP/fbs4E5a8Rz0aKuQhblMbkDUH+R81/yYAHkPY+UdLYjdMnBRTp5ITr3kd
	b/Riw4nkuCTi2U=
X-Received: by 2002:a17:90b:2e49:b0:39e:14db:437c with SMTP id 98e67ed59e1d1-3a786736693mr3974266a91.4.1791121136909;
        Sun, 04 Oct 2026 06:38:56 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 22/43] bpf: add bpf_reg_union()
Date: Sun,  4 Oct 2026 06:38:04 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-22-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A utility function to take the union of two registers' scalar values:
merge the circular 32-bit and 64-bit bounds, tnums and base/step
of two registers, then synchronize and validate the result.
Leave id invalidation and type validation to the caller.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 73bbd7f8f1cc..555a41c5660e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1814,6 +1814,8 @@ bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step);
+int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
+		  const struct bpf_reg_state *src);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5fd6376da171..28c16e35b1f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/cnum.h>
+#include <linux/gcd.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -17164,6 +17165,33 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
+/* acc := acc U src, matching types only. Caller must clear acc's scalar ID. */
+int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
+		  const struct bpf_reg_state *src)
+{
+	u16 base, step;
+
+	if (acc->type != src->type) {
+		verifier_bug(env, "union of registers with different types");
+		return -EFAULT;
+	}
+	acc->r64 = cnum64_union(acc->r64, src->r64);
+	acc->r32 = cnum32_union(acc->r32, src->r32);
+	acc->var_off = tnum_union(acc->var_off, src->var_off);
+
+	/* Retain a common congruence if the bases agree modulo the gcd. */
+	step = gcd(acc->step, src->step);
+	base = acc->base % step;
+	if (base != src->base % step) {
+		reg_step_reset(acc);
+	} else {
+		acc->base = base;
+		acc->step = step;
+	}
+	reg_bounds_sync(acc);
+	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {

-- 
2.53.0

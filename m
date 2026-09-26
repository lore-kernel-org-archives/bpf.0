Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A746AA96
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432459; cv=none; b=ZyGE1iH5LRaGmHIHVnjNrvAlUF0EC0YlyQKOiXK/hwhOGhMnh79Af7+cnQ288GIgPgvZHMEkgNR2rQDU0N+HSiqYQvghGb30RtPFAty01VHiNbpq+yPFzOHPsZFTyyvC8jy/+0RXNvZ0d4aZkav7U7BwOsHGU7qtt1u0LecPZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432459; c=relaxed/simple;
	bh=Kx8PczaMnrVtCeSORCYNmmp3+2ILYgWO3oNsDrD6YHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q16hM6tMfyKIstLwGX2loyTUi6hYbnWwQBHjMpTncsmJ+54jC8WC41sehpwpDVYqFA2xXAg3kwfXgIqrqF5K42pnh1e1G35A+BX8iukPhtQ4KRa3UElIcEJw7fEVSKOMmQBfuIBM5fXojInY8GIwc/5bxh7XuzqYGxGGyPySoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTC7Rd1I; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTC7Rd1I"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so900465a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432457; x=1791037257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPKbx3ItVOpjH9sY90r8wbZdXfWgHP2IcmoJJfmh1Kg=;
        b=jTC7Rd1I0lpmSLhXYDD/TNwQRwatAjf0fGmQ4GjpLSbDGSTWhQPeET8AdL6K7yamvN
         ZWZCM3VMVZ1sCnp0AbPy510jclfRggWBaahKNvLlIuHMXKTJ4iTBqZT4juaey+CKgYEf
         2iGz0RFqh/LwERcbEz9Ia8Btm6QGMfHfdoqtjtVVZhoe6byMi0c0uDiJCl/6Ez+KYx9q
         xUtlu/YLDIES3dCF64ATw8gIsn6r1Akvnj8szAKtPSbaxVOe+4Z15hagGdBWR8hfZPy+
         IUsP11LcCBgKvI28uh1hUDY3XKycDRrduq01slB/GI8WTqnw0nsRtebKh1yi5YTAUXVC
         zw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432457; x=1791037257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPKbx3ItVOpjH9sY90r8wbZdXfWgHP2IcmoJJfmh1Kg=;
        b=cXaQAFduthreX+MEfvBPba7/7ndVWSh89mxnYaMEH5xwp37jnxXSTfSNb1/xwGGnCS
         piScLZrRQdC2d21NqHk3U0XqVMs7TOJORK+H78KWUpF0wtanqKTbZsNmFvYs9nyVmWkb
         6gvCuBoNWs7ILfs/AOokmIivXBoBTa4IpTg56DEBQ7GfVS+REZ4IE57StWw1vZLB21c3
         wxHxT64LoOZzLLfoycRCnrMfKa18RUPZyRbfxThlzr4TGtIs/pXnm9FBkNiz+9I3J6Na
         IEp8ArE8WkvV4D/+wOOSBVoVCBSXN3DWdi3W3nNy3GfKtAxxscMIq4ZQrNuid8eW/DaI
         bIcg==
X-Gm-Message-State: AFq9FYI7DAgmD7XQTun89oGQOrJJ5h+D637K2ytUfnBpTLmOLXt2pFTz
	A+y13BT/DHxbtGgdXPnPMSfi3rWYhnkvLzZ7oL128a8T9dNo9BcifOsEhMATlVskWvE=
X-Gm-Gg: AYBFou0TjSGVyvCmZjELhSN7vlE5yCDvCcLHt9PZMHurxOIJzPNgw3vb0N6SJ4scVCU
	MhJI3zJ1oTBZrtyv8WJgdxuSZvwEDe4oEa3S6j0EgdveRHcstXH6eozWwGVNoQWdb/EemmGjlK1
	UbY/GHjUIujT7/wIJi6UX/gLDG0oJ/zQ5iaXDM7lm9BTnGNuhnc+MZykIuDdTt+XvrxerAtGRgd
	+e56K6+Im1Z6dZwQyG4ya3+USOjlzZnY8ukiPC83XyDbREo1S7EPLbNoVfbqqXrInABS6NfcUay
	XARDLGIshvPytnbPtvbKq4gKKaeqTAzGdtcTxLs/DGwUyDAI/xRd02tn3QmYkFpdAvaZXFNpqfK
	9A5Dmm4hjdecMmXhgFA/rEbddsVoyDCb+5qhWYeG3eyMX4QZaUv4RNTQQPZrG9va7xlUgsHwLge
	OWCadAoTsHnU2zELD2oI54zbhBCoJa0JTxGHGaiEe3o+vekHHSEXnzTDPNvf4TjU2pxAd/5FNsS
	o/inazYac52sKaDx0u3dw81kP38m0Z0TpwuAthnExoPm5Iy66OB
X-Received: by 2002:a17:90b:4a0c:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3a0e568ef17mr932009a91.8.1790432457283;
        Sat, 26 Sep 2026 07:20:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 11/36] bpf: add bpf_reg_union()
Date: Sat, 26 Sep 2026 07:20:09 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-11-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A utility function to take the union of two registers' scalar values:
merge the circular 32-bit and 64-bit bounds and tnums of two registers,
then synchronize and validate the result. Leave scalar id invalidation
and type validation to the caller.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 719b7c7fd2f5..706fdefbc07a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1748,6 +1748,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 step);
+int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
+		  const struct bpf_reg_state *src);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b5f45cb46f14..1ec44d72a346 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/cnum.h>
+#include <linux/gcd.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -16952,6 +16953,33 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
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
2.55.0

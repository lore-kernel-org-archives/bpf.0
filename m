Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34706220F2A
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155091; cv=none; b=llz3e8poroxfLzagd4WPZa2BphIjDid2nqSDLjRRZP9NmkoJX0f6RcTEuykT/XuJu/KmY6QJtK9dQ3Axs5aP4hCMHooExzXi+Xqjz2CfCCJBPwj5AkSQA/iOjN3m1CUVKKbNusIJtwkqd03dt9lMLb6nA9iddEupEb3P5zTDZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155091; c=relaxed/simple;
	bh=N7WwlREECWnAUsef2ciaYJLCkxe7W9hgDaZeEtkXIjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvFyk7C7uMUJ6H2VSkTng6MJb8prU/2XKCJhquvewwKvD9bknymg2J1vQWfkB7mflVORR2FAdbcIyYh4kEWcCBXfsfx/y5+I2nhABSWA3/hGioQTuTVn04LQ3++wsJWBMmdwXFgR5hav+vYQTOGf8JZHDZaywGLce3+3eRQRGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSWSq/z+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSWSq/z+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so12270545e9.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775155088; x=1775759888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRoqcw9aXjjpxUirjrVDb8kCcheqPKRo1P52sN2oMSQ=;
        b=aSWSq/z+JEuoQ+J9abUzwoWYh7QZYSfmoPODkDBw0XziZX3KKU42GloHg/ihOfkJf5
         J3AKcOghCWnXjrcF4VMf4OK6eeCl39Z95JruW7uvheDfR4/K66Dt9MPfPo6GbOJyqYB9
         OaeLKHb4KjAUq0tVCfmZc0rJybPzb30CALg2uhJGx5hCdq9sABLe+ostGKW2oSlu5aY2
         ayaXdplNykIOkTRMdbtvaENk6ZxhojSJ4DBAZVGR2QODAG1blBPhbmuvh05241nrhizk
         zs+Y4r9ZMl4kRAXSJZ0tsVOprFZXyQtEUTZldTZE5m7RerH1T84omvG+IA+oXjMWuK+j
         8JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155088; x=1775759888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRoqcw9aXjjpxUirjrVDb8kCcheqPKRo1P52sN2oMSQ=;
        b=mwBDi/xEZ9MzEnJws9h7NrqJonUF/r4/YcdF9t2aJkhtxDNbJLQgIAC3WVns1Nv3P2
         9G/oU2K/I2SW6a4oM1/aDaGVPVIMSnDKReXnqkB75Pr8h3Z5MQalDCiDO8jig5QT6fOn
         A6BrK+t87qilGsBiS8gQLf44y0urTe+w2AsoAWZsWpCA8xK9rCGDzepEhUGoCKri6fCS
         mPIY4yH2WNDQzkOfKaiFqwh02zAg/07hHqR2UbkgaPtZOVC8kZmSCRZAnepdU2I0zZID
         QpOE3PfGPFxZVtzjM848F/3jhUxC1CXXFDBefQPwJbjxIUm69fi7e/fceueG00aagI8r
         vSWg==
X-Gm-Message-State: AOJu0YwRsmzl3/9htkJm5qn55p+6X9ztnHSpcFxmebEak2mL5kE8dmaW
	bJBsPs+wGS88hhft0J205TqKVsMHvnHoIcCzQ6de7Af5LsiUCZsXKwXKoSbqDQ==
X-Gm-Gg: ATEYQzz8RnxZcBYOBu+DzqpwdJTj/fxzPW1gIa0oLX/2xu04DDphWOVcXb5zvExHGqD
	PXkmTsvZ1mWLRT5/XYhlpXgc7Ayn5DVP+pBLKKkXpUH3G3pvR690PWfCNDyJDVx0KcoRR0247qY
	1V27KuF7gpSpSsd7DONqIpZgbKzDdacRcahhA2vQpMX0eN3LIG4ZJdx6GDEwOOUvrYdWkDA2aHC
	SKYJ0cF2u4KCN65Mn2heO1AZtSjsjgiyzUc8ANjbIA5maECTCRDFRCMoWcxR073teVPtpvmp0yC
	zPV9CIJaQybDLiPlTa3J823OHhl8Ehyb4yEkChIxeMt/7/GXEWISAW4xGLVjfbXVvSqfTIA8eg4
	UT7Bm0KP8WT5VO1SzOiXRRwm5zFPnbS1fOvn73FQW2eddsiRVcbnXgZgcXzBLieyCvH2g/yJeab
	6eEIEu+VeqakDm0salnADNJaWmp8SK6GWociTRWIJ/Fg==
X-Received: by 2002:a05:600c:638e:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-488997d4dbdmr1518915e9.30.1775155088102;
        Thu, 02 Apr 2026 11:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5594sm2215815e9.3.2026.04.02.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:38:07 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
Date: Thu,  2 Apr 2026 18:46:46 +0000
Message-Id: <20260402184647.988132-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402184647.988132-1-a.s.protopopov@gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a pointer to PTR_TO_INSN is dereferenced it is possible to
specify an offset inside the load instruction. This is a bug,
because while the verifier ignores the field, JITs are not.
So, patch the verifier to not ignore this field.

Reported-by: Jiyong Yang <ksur673@gmail.com>
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..ce29b3b7a4d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -212,6 +212,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
+static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
+static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -7735,6 +7737,23 @@ static bool get_func_retval_range(struct bpf_prog *prog,
 	return false;
 }
 
+static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
+{
+	struct bpf_reg_state fake_reg;
+
+	if (!val)
+		return;
+
+	fake_reg.type = SCALAR_VALUE;
+	__mark_reg_known(&fake_reg, val);
+
+	scalar32_min_max_add(dst_reg, &fake_reg);
+	scalar_min_max_add(dst_reg, &fake_reg);
+	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
+
+	reg_bounds_sync(dst_reg);
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -7816,6 +7835,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					return -EACCES;
 				}
 				copy_register_state(&regs[value_regno], reg);
+				add_scalar_to_reg(&regs[value_regno], off);
 				regs[value_regno].type = PTR_TO_INSN;
 			} else {
 				mark_reg_unknown(env, regs, value_regno);
-- 
2.34.1


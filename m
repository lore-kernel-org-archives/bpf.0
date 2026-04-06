Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732512DB791
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490772; cv=none; b=gQ9EFwdK/3LqaXRgerSBEUbkbeBzK6IhHKewOqZ+exmyLceDworrzZ8hFHOvL0InAQy+H5E84gKY6+uq2wdUjRmB+9ywUyupSRh6VWcZxHSKOQGeqfVdW5G5mRZu91zR4UQYda/arTcizZ81+apDKWcl9TAjH0WqGmpxho22/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490772; c=relaxed/simple;
	bh=tR7GSJXl+va0H/YbcU5ad5uJX5OqWVzLTCOmKVJ0X2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELzuW+EFmkfJyBFHcyAsqfpTQhTQD/cjzb1HrCRRCTMWwm6lBe8f1aYb9AKo+Fv9g/nR0kSDpp+Ozk9BJb4EEzJN/e5v6i5Ka0rrqUflE66lZujwmxvZO0qsqXmvcx2qgZ5d+iztl7Ul3jzzSKwYgvoLHvgM1XAMWIDBPKEANc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohOoqZ9/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohOoqZ9/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cf7683a28so2370244f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490770; x=1776095570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MTR2BeZdPRI3xp/SQmhxON71Ap+fv7NrQE+ofKTbsI=;
        b=ohOoqZ9/+giMIUsiFuBjtneNFwewkvE1GKRGhGgF9Nv4VExW7whxSYW7YoxPGFV30T
         a7faWdN6Y6i2ABzts0NVI4VaZ9ZBR4XKDuxohUEjOlUkoP+RBNsOd+c2z9436bbNWzdp
         z+/lVVpsGCYFUizQGA24gu5rUDRkdtJjmIvng2kp3GAiePmPesVCrvqQqRsCrCJwbqma
         g0lyKRlZYMZyLouhJoV9GbBb0WwQsW8hdYcywVG5HRvFUfSVqAe3nUO5GZIpvzAC7ReU
         Ls0UNykO0hiFizXp81wqX/OT7iu+zn/BVUZoklwWL/+E2HIbEE2flUw8mTxpss7PuPxa
         Uytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490770; x=1776095570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MTR2BeZdPRI3xp/SQmhxON71Ap+fv7NrQE+ofKTbsI=;
        b=IHK0cHkLK3vlaJVH8W+Jo5I5UEGgcBalp2yF63xhlLvmGxCNZoimqnqMR4L2U3ltdV
         aDvR/wEkZ6c5mNUMeyqY4078BGYlzcepAbgu6MlnQlxJhYBKwgq/z8PyOdCsPDc64Dy4
         wl/Wzj5i0BPlMuWEk4NhSmVj5I6fMK7TC9ONsMWi+ELvUm5kUbpC/H8nU0Tg7WrdPElG
         KgpueK5FS9dPusT/FY4yn/W4ofhwvcM0QXefaPzNLfccTD0L7WkW0aYCRzxLzzU0LfTg
         j+3HSNtJ87y1izoyBAN6JPhT8dt5+Cu6GEuup4P0zJbyhIHcSBE0oc7REeqPn2ZkKwO5
         QWQg==
X-Gm-Message-State: AOJu0Yxjip+cwUau9UeDO/fN/oMEAFt6wcQjSBD6OG8VPO9pNjq0q+dQ
	yPRHpSjhqFG55DaCY+zokpfv1M5rZUiuCd7wGhEYYwvDcuso8kkr58nQG4J8Pg==
X-Gm-Gg: AeBDievfG+JT4/N5zoKGJDMRMV6QTo8g2BtpXytjHKYJgBBv828pNLgGLiQ2n0pPPSN
	HEvscoXVW+MoFOG9XHGL9H5DdgWDtzgPqpskijNWrlwl5uZZJ/ZYBwJZ4mFXun3VcZnYdPWUscd
	uoZKIdkjxOv+58uB0Hs26cVs0KzTpM5i3zZCaLBBKw3I737Sq9Wxk/twN7mD7oDApv/5rBVqpuv
	DMhTkh958y7kv0KsuKg42wIs6ezo/ryo+gWO53eS/vrtQNYezGK49hU6dDgcSKAbgsMHBCx4A/e
	F9uB0/qYoriwfEOPpcxZKdw5m7AXK9IpcJrysk93oLqfyw/wcq+sTd7E8+7tL3AG5QveNteatHH
	k8ZyNMiWlOLBQJwa4zbnCyj22PZ4VgEtJjIm6GkjvwQmI5zGXL2BlHAJhRhdmpXLYnhPm1G5BMh
	thffQHnSasSRXFLbgk7hTCJu9KkTf47fBgb5Lsb9g4jw==
X-Received: by 2002:a05:6000:24c4:b0:43c:fe0e:5bc5 with SMTP id ffacd0b85a97d-43d2926a073mr18177351f8f.4.1775490769568;
        Mon, 06 Apr 2026 08:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm42114802f8f.4.2026.04.06.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:52:49 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
Date: Mon,  6 Apr 2026 16:01:40 +0000
Message-Id: <20260406160141.36943-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406160141.36943-1-a.s.protopopov@gmail.com>
References: <20260406160141.36943-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a pointer to PTR_TO_INSN is dereferenced, the offset field
of the BPF_LDX_MEM instruction can be nonzero. Patch the verifier
to not ignore this field.

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


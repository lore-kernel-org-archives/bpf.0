Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98444CAC1
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059623; cv=none; b=P/Vn//1fTTEzQ/5e/45IwC4nu45J5tluwlC9gWKkBtRu2gZKAo1Df2VMDolnB7LQF1ai8qri9IVu59QUowTkJyWzWYcY/W6D0J/6nKpkpyCtf0bvyqLp4SAP9rsvIwt+OYB8Bh4YGyK0BzaucHPrppatabo2bll/6ZbOLRYNeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059623; c=relaxed/simple;
	bh=OH8SK54pN73AivvlNQ+QqNQM/9mKX8Ky7D1pdv723zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3mJGkQ7ydrKyBzwIiyUz8pJhkLhbSO42NwxtapLmEIrtahmLwPbwxlXD6rOsier2ZGidbU+B0pU0MsXtMAsYqXaB0OyMIMX2mTLWifX4Bzg+BxeFOkH2/Bm9NoPqzXGdCB2/KpSWlk3rXG+V00gb+rhYyVjRql8SckvqpflEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdWGpdTc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdWGpdTc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486b96760easo78351955e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059616; x=1775664416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQqrahdq8Peap2QK2FkN4dn9Bzod8641VuWhND70X3Q=;
        b=JdWGpdTcFArovfHn25RqEv0uCFt6dlaR/JP2W85XlJaEFI9nrr+jaeIaefAqRFKlF2
         IaZ82GFiXIpyALiqeq9qazyBlSP0hz1Cvv6uJ2731SMpUDwoFaNKQaRujkR7OcD6EfH9
         vNtXVzp1HdOnXsBRfi8DJ0rsGVpOuFdLk3/8an0x+56rCKETWuwguB2uM8heUIWs/Wyu
         cq0EQw3vwntXuIRtBNdyNw81wBtBrGkm9/DRa9d1E3KChAFk6Tr5sndY4KDnPafMIcsA
         R4fuGRsn8AoorRm5rXnw/69y61c8N3jl93jaFdxaNFOyRegHio9od5GUslOi2atO9l6I
         QLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059616; x=1775664416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQqrahdq8Peap2QK2FkN4dn9Bzod8641VuWhND70X3Q=;
        b=U94M+DKkRGkqOFax0gT0aET2pkdYqmdkmO0PiwAESfZnWzxI8b7aX11O9+53TkaRaY
         DmzBzHc8mMU1Iyre64dScO4rDPIcOzEQaYsP5edcXRU1GOL84SfP+vivwBBmuTGb1yFy
         XlyCe5+zFR+NjZGjvPRoxeFjHAYAlZt/yA6M73lndOoHD/pZl46xyGNnn9Gwg4QYZ6uh
         Uef/nbNJ/acTt0Cb8D7RV6ThXUZk6mHfGkcsexBUyeH8bPtqHNQ7ELaX4Njutqo+ge7k
         fKEgk1t927VWIt7owK6kGmd6b21Pd8SyiwAvsxkdcOs6I0P7lYC3xOF+HbhY3RwH9fbI
         jCzw==
X-Gm-Message-State: AOJu0YzgxMtWEtZiW30mgXCYq9PxhJSYEX4UqbyWuN3XWVEXV3duvjcB
	DXuuhS06TNFomuu4bjV+ADl0Hzoy8NamWSyOEVcgGtky6MeGoxRkkHb166Q97w==
X-Gm-Gg: ATEYQzz8pw58of9BCKTyLApoqKeMaxOezYAf4Gygr/NzYvtibc1BCVgFUA1MVHiaO4X
	FpPgu34MmGCMQ2gf5RoBIpChShMe6Ib65F9B7pZjiB1SGisUpVqrmzNvr7vLGBcwbX8fGEKVPtT
	9+iPe6nzKuT1uUBWsLgsjk2v7CRKOjpVVZdpZKQoQxAo6WmCEi/yKtdcxt4wYXV3y2Cqi1BvsN6
	hLvaIIEfH9LK4FQD/CQgsx/2d0GDu9MJqLEgm79jjUGqht24KEbbYCQKW5ZqO80Usc4s/K3StbG
	J/55++eV1iUBfMqAd1gkngwNDlkkUEOOZQuYoKDgiocFgRtJGnufHbKJHDF2mpdAMGp3CjesFsG
	BM3WOPPQwAuZcekRXLaLEfCaBXwM/lfcMJtCe6R2g530tMu7xCuc+3+O+8YrHwmxg9YfJMHgbQn
	eOpEssAPm6DsLQp2ATyXUW0TYXQJz6CBAcWp9ybSrjpw==
X-Received: by 2002:a05:600c:828f:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48883562a22mr83116635e9.7.1775059616177;
        Wed, 01 Apr 2026 09:06:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm116893495e9.5.2026.04.01.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:06:55 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
Date: Wed,  1 Apr 2026 16:15:28 +0000
Message-Id: <20260401161529.681755-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401161529.681755-1-a.s.protopopov@gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..f1b1c8e9dc26 100644
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
@@ -7735,6 +7737,20 @@ static bool get_func_retval_range(struct bpf_prog *prog,
 	return false;
 }
 
+static inline void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
+{
+	struct bpf_reg_state fake_reg;
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
@@ -7816,6 +7832,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					return -EACCES;
 				}
 				copy_register_state(&regs[value_regno], reg);
+				add_scalar_to_reg(&regs[value_regno], off);
 				regs[value_regno].type = PTR_TO_INSN;
 			} else {
 				mark_reg_unknown(env, regs, value_regno);
-- 
2.34.1


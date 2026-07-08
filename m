Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4C36AB56
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471488; cv=none; b=Qp+XHBsCCzzX3Bd0I3ItptVa1kgx2umQH4eDswCO3C9hVz1J3gB8aPlGa3od5mNe+MA0D97gyZGTMiE+ozhdZ166EvEWMxIuKabyQX+lZWGKLhCJ/nG6UqwnppETzMy/UcLkI0HNEtQfv0Oqc5zKJFPpnxxv4r2UaikyyNAXPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471488; c=relaxed/simple;
	bh=3tFYRggyFN6ghRSZ466IMISqMD0F2R8pZTt/MPw9OPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKzwDIemS9uK/fU9Ft7FuHLrIge9xq8uNfsv0dRtoPc6bOFEFI+/erUiYydqMedxr1yEGtT3AVtY+lEABHRp+W3OXT8HhAkDAHFe9sxskVw0InlWo+0bn2kfGAQLQRZnJa1ibuAX94+mMD6NhhgVKuhm0Sql7r2/fFIO1jDSUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQwQPGBg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQwQPGBg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cad4170e8eso1857055ad.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783471486; x=1784076286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9NdTh0XLsS9X7riUGdVU7aOZNNf6S5my4vAfjDCpg58=;
        b=nQwQPGBgexApSWCLbrhWj6oKKLbcpZzEkXpxZhDbHTCDMAf4pRYa710v0wvUtH5D+0
         2G9aFYSr/5c/tZa7T/V5sfRMOkcnBxOhN1d9MWYJS3O8zlj+l1m/Z6Z9g8G1DG5Hl/1S
         oExgaFfpr7tNZXFkv/vRgvE+t60vShUY3P1h0zWENhQPt+Mjr7Z7+h0Vd/MvcQKhZWWn
         WcRLemFMGfAv+oJewr0ba/eSNca7UNVICjlDVNVvde/FHb1f+W46alklX5bYodpDdTPc
         dqZrZH0JYqgRfy6ZYm7nNM2Qoq0xUwiQQj4NOuOaHAKDDFrb96QtPOUCcoNaZU1xBBC7
         KD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783471486; x=1784076286;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NdTh0XLsS9X7riUGdVU7aOZNNf6S5my4vAfjDCpg58=;
        b=fPuNqCYkBASnzN+tbv09dRHDlx1Cotukl7aLoXQRafrd7K/zh+4ccCVEmlG8hA4PrJ
         zv+/3YHBmAZzrymZNQYTCtQiNxLmWAiLtTCt6z6kqXfxRfKIdPO3hHLmhBp3IMyF/vCK
         W/AJn6adKE0tSP9dWVaABcYGlQ/S2j5pvfdW9su9JKKnIAA47q6swATEu9FL7IfK6IYq
         nAnmQQaLRorNuNGut02sZRAxvly/ApaLrDEn1QiTywWRGGbouDnVksxJM/U8uSKD6f9g
         uG2nLsjulWbAq/gaa6sPsJJ3feRwhOqxoWKYDnOT7vHVGcGg0XwcIR1WSb8yuhknSJ/T
         XFrg==
X-Gm-Message-State: AOJu0YzIFcA8tJ9XaZh4MKdfh/Kf9YyDsoA7Z1/DTIpTsZLsMLpbwH9D
	jFblxDY5043+7fL06m0MCuWSlQ4wwUHiYf5OhG2N6HwjR0iNpckCQ/sm5SEs8GZU
X-Gm-Gg: AfdE7cmUKoiTEX8Ldsm9WpUJgG9Y4alMXpW0Io8UMGkrJyD0D3EoIKCCAUkqEoZCj2C
	1VrQhHKjmufHxElYx19uE9mHzaBUl+p/KACQY/sIj1wfkTz+vCuCNyvGMqmUZST9Bz7v8znY/JU
	tb/gdLSqVxbDNZwIhVHL84dJz+aq4umATi1z5JMOoyjY+DSh8/0KXzNYcTzjkb6mhdCfzxS2jKj
	QFMwHfwzqTJGYGZrn1rQWieYIfno8nM6QsjeVY2V/vRo1/YKLhlM/pt2iczKq0u/7xjA3e6w/wK
	T8dU2zznVnnUgQAdFJZUjXjm+g4Z2WKTL8KXW38BopxKmvbMAT611EuEIyP76EBFkk3bRqfJLck
	zkUZ7TBpXMVJh+c4E8chRIYh9ah29N5d4+JEXo4CXtlPRANh2+OkQNncpC3qxB4W7InCyPwT0VQ
	Uq1kX+KNLUsUrlPN2tt/57QvEnsJjsy26hDoaCH6dQZYXY0zX0V0n8k+TIVNuTbHQ8/LVxU7D5m
	h42rL4=
X-Received: by 2002:a17:90b:1c0f:b0:381:18c3:1b99 with SMTP id 98e67ed59e1d1-38941205917mr243889a91.23.1783471486225;
        Tue, 07 Jul 2026 17:44:46 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:84e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm12371054eec.12.2026.07.07.17.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:44:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: remove artificial limitations on pointer types eligable for spilling
Date: Tue,  7 Jul 2026 17:44:28 -0700
Message-ID: <20260707-missing-spillable-types-v1-1-44a92121dc41@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
References: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The verifier loses precision when simulating stack spills for the
following register types:
- PTR_TO_TP_BUFFER
- PTR_TO_INSN
- CONST_PTR_TO_DYNPTR

These types are not allow-listed in the is_spillable_regtype(),
because of that check_stack_write_fixed_off() takes the branch
that marks the slots STACK_MISC.

There are no technical reasons for this limititation.
This commit replaces an explicit list of pointer types in
is_spillable_regtype() with explicit list of non-pointer types.
The function is renamed to is_pointer_regtype() for clarity.

Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3193b473762b..51f7965d42e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3304,34 +3304,6 @@ static int mark_chain_precision_batch(struct bpf_verifier_env *env,
 	return bpf_mark_chain_precision(env, starting_state, -1, NULL);
 }
 
-static bool is_spillable_regtype(enum bpf_reg_type type)
-{
-	switch (base_type(type)) {
-	case PTR_TO_MAP_VALUE:
-	case PTR_TO_STACK:
-	case PTR_TO_CTX:
-	case PTR_TO_PACKET:
-	case PTR_TO_PACKET_META:
-	case PTR_TO_PACKET_END:
-	case PTR_TO_FLOW_KEYS:
-	case CONST_PTR_TO_MAP:
-	case PTR_TO_SOCKET:
-	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_TCP_SOCK:
-	case PTR_TO_XDP_SOCK:
-	case PTR_TO_BTF_ID:
-	case PTR_TO_BUF:
-	case PTR_TO_MEM:
-	case PTR_TO_FUNC:
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_ARENA:
-		return true;
-	default:
-		return false;
-	}
-}
-
-
 /* check if register is a constant scalar value */
 static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
 {
@@ -3345,13 +3317,18 @@ static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
 	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
 }
 
+static bool is_pointer_regtype(enum bpf_reg_type type)
+{
+	return type != SCALAR_VALUE && type != NOT_INIT;
+}
+
 static bool __is_pointer_value(bool allow_ptr_leaks,
 			       const struct bpf_reg_state *reg)
 {
 	if (allow_ptr_leaks)
 		return false;
 
-	return reg->type != SCALAR_VALUE;
+	return is_pointer_regtype(reg->type);
 }
 
 static void clear_scalar_id(struct bpf_reg_state *reg)
@@ -3476,7 +3453,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (value_regno >= 0)
 		reg = &cur->regs[value_regno];
 	if (!env->bypass_spec_v4) {
-		bool sanitize = reg && is_spillable_regtype(reg->type);
+		bool sanitize = reg && is_pointer_regtype(reg->type);
 
 		for (i = 0; i < size; i++) {
 			u8 type = state->stack[spi].slot_type[(slot - i) %
@@ -3517,7 +3494,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(tmp_reg, insn->imm);
 		tmp_reg->type = SCALAR_VALUE;
 		save_register_state(env, state, spi, tmp_reg, size);
-	} else if (reg && is_spillable_regtype(reg->type)) {
+	} else if (reg && is_pointer_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
 			verbose_linfo(env, insn_idx, "; ");

-- 
2.55.0

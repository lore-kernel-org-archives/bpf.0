Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB148641F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164277; cv=none; b=LUeJ5ZQ84Wt+PyzlGtRvjPthsJF77ORO57GAkQosh+En1k5aDew3JXfGmgIXtdmviISdj7S4lBZ8aR8HAZYc9HCnzlkFifx/EQCv4+gbtjTGxI22FItIhU6agFBrRhjk7tDm3wJFjvIcwKG1220gcaavTU87bI/DMiGCH/PU3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164277; c=relaxed/simple;
	bh=ASOybdbOeNUKoD1zwNBOSpfa4cyXKZ0NUNsWfxC+//o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUAmmuoGr/irfjwdV4jR9Kue2G8/cV9j8ufrtwVHeJE4XdTzlLT6dUxj2y5N0FU/Y5CVGymjICfBmE5Bt029uT4s/1Ily4lE23BZInLON/hbVcPlOXuyiiaMCY8i+6Z131WdkSLlHksmsox+jXdi+QEqXjENxpt0ZRqXj1/lxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAD0qkI/; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAD0qkI/"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fd8ecf2ef3so80939a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164271; x=1789769071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8un87Wv3i40EL3UPE1bv+cOEFhjdyAzd2SjNHYSHdoc=;
        b=FAD0qkI/Dbf3v3WALYp9U53Ba9Bf7gTCf/2KMQxwq+c5HB78pocIQHmfnV/LfDWuof
         3TP1M3ZAXG0+94rzW1bN8FecWs41B3rS2LwOhEpS5tSXEj3SfqszvFk53ht4o9fyvRVc
         D3NKHWBazKBEA/+m+IC1HhWSPXA9hoyx+mVlkCSziMgcvMiKsxH4+kHwA+JrrMQ3Wiu2
         lvNq5qreuMehYL2rk99AjbJIMJTm5eSeUOaaBqLuKrC1P1OUYTb+o2FebtK+sLKECmTl
         21gV7OW2BAkUzd5WO/2aJeHuJDJuw8SLbsTsHv9WrSIGn4rx0hpbkC9KHfwfjaX/PA5s
         d8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164271; x=1789769071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8un87Wv3i40EL3UPE1bv+cOEFhjdyAzd2SjNHYSHdoc=;
        b=Wgikmx8hCd+wpm9a8SJVy2rIUWiiKq8gEKRO3Te93oXX8p+6X46xrQK1nGm8JRo7mE
         0xiQPS9Yn9/lNR6g7N5o1LYBLUCkY4+mLXWWCEy6/zJyN61YuMicCLjQJgex+qHr2jwx
         +u4EjEvdBWxNI5D/83zOksaSEUefM1qTDiKtD/Y5tgGhq7DUVNcnwN8KRx8t7MQmUEh+
         PRZiO2unQcUQ0E8onu7GQzWOeJOj2GwpQEcpSpUTeN6n7SGJFFUuXuq5FDskdYtOcZQT
         85GaRwrGVk8EOemmZlDvxGNDHB1O75F4OuYQmEnNhuawS6yIm5Yomi1squq71+hvoa+s
         1D1Q==
X-Gm-Message-State: AFuF++k2yG5Fj4qiqcoNXBYukZoUG3SipN20IkrBrSnZZy6JBiL1T75c
	NozFirav+iaCDAsIfAwR8wbk+k8ruGlYRuA4OKoKCmIuRxle/RviZWlxjULwrw==
X-Gm-Gg: AYBFou263NmnNMfu5d/kBlnDHBCfNQ+759BRV+1aXedTyDYd9S0yhGH895WzyrCWZoW
	XLao0Jff9hxUkqsneF0+7fsIoC5SnP257V8zB5g1qiPqyV8dLTkz28LhcnvQ7LLKq1/950houD6
	a6UapKdgFWB6N7NLA2iLrZVg0m/SQRe/0wR4UgFuXemF9fyEwPvQwTunU+QqwfGkbflLeYXhViZ
	KOhZcCpmeNbB/nD3rNXuvaAn658cmG337nbXQ0O03OnueYdUnhtPvqq5TwcdgwEDG4HhRXV9Tvo
	5pjNfzlC/4pF9KSye14+NMiGqnAJnSU7cNfTlZfstROyVAXKW9R/yniv3PUUx07PrBy2X+CcKJw
	eEEJzn1GtMa3zAgBKISbU5i30awCm2xhrxkk4LaTB8XwnGuvdcZXOEObmNXSQ8lVcRnwGEHwwIB
	NGWxF/AskQ7vULrxi866c9PC+lwtckZdXR5wfEjf+ORh6BmmiAaRZWxRlRN2z8Pg==
X-Received: by 2002:a05:6830:3c0e:b0:7f9:555:1df0 with SMTP id 46e09a7af769-803def20ba6mr4377878a34.12.1789164271088;
        Fri, 11 Sep 2026 15:04:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80477ea9138sm2668692a34.1.2026.09.11.15.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 09/23] bpf: Set OBJ_RELEASE when generating kfunc argument types
Date: Fri, 11 Sep 2026 15:04:01 -0700
Message-ID: <20260911220415.1396439-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() ORs OBJ_RELEASE into arg_type on every verification
of every argument of every call, from a comparison against
meta->release_regno. Neither side of that comparison depends on the
call site. bpf_fetch_kfunc_arg_meta() sets release_regno to BPF_REG_1
when the kfunc is KF_RELEASE and leaves it zero otherwise, and regno
is derived from the argument index, so the test is true exactly for
argument 0 of a KF_RELEASE kfunc.

Set the flag in get_kfunc_arg_type() instead, where the rest
of the classification is built, and drop the comparison. The release
handling in check_func_proto() is helper-only, so an OBJ_RELEASE in a
generated kfunc prototype does not feed back into meta->release_regno.

meta->release_regno itself stays: it is still what tells the referenced
PTR_TO_BTF_ID check and release_reg() which register to act on.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7822addfc64..20e7da6674a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12311,6 +12311,13 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
 		arg_type |= PTR_MAYBE_NULL;
 
+	/*
+	 * Only the first argument of a KF_RELEASE kfunc releases anything, and
+	 * bpf_fetch_kfunc_arg_meta() only ever records BPF_REG_1 for it.
+	 */
+	if (is_kfunc_release(meta) && arg == 0)
+		arg_type |= OBJ_RELEASE;
+
 	return arg_type;
 }
 
@@ -12997,8 +13004,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		if (regno == meta->release_regno)
-			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
-- 
2.52.0


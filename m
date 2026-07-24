Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07D175A87
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920100; cv=none; b=RywqloGy9mS20WKBClQZFjhT03c09AxGfXSWsWYcAO0Rs208ernlFW7+aWzW4H/K5UtPmFbbtOb4WTYWp9rT0410tc+P2QZVzIfYwXnY3MAHlGrtGeYiBxYd/nTyTR1UGK5WVCibqCvLQjlXBk8uu13VxYnuROEQSheRH6H6Q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920100; c=relaxed/simple;
	bh=7DvQFqMe5Ht8BrfdVZ37fo0ZmMIX8+gKqKzJ1AkyVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrHU1+8KRwEg6EM3HDCK1eyx+yBm7eV+LpFpkI+uqxQbvJb7Njm9V/7m0AUMHag324VeBrLbQzv+TS/R+UiwgjfAmIRYOkS0UDydBrtKHtG44scDixLhReW2ByZ6N3t9yUEoOjrPyjxfTb5k3ztP9WDs/Hjo4VOV5zPHwVnHZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyX3wVDh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyX3wVDh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848643382fcso909288b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920098; x=1785524898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwuoOt4nocRx+llDpLx4v5UqGUJ5ldTSzjQhVvx3bXQ=;
        b=SyX3wVDhw1LA3SvKFanLdK3eUeEVT4IATU5NIvgkz753gw5vD/9MOn38fU6WMRRpPp
         0K3lavQpypjH6rlDhTL7bixUobVfbZXBIdb8IujsiC5dgPfM2iajeZw/mn0EK57Pcs7y
         LBGATvRxNQhQpltls4zlbpTktiAV04iBuEMWBzHngngh8SmrnGM//ZT8RjYqvZV/WzRN
         /yXFu1/V5IEKV+jOvDO3zUFAkmzkTps03YM+zXBHWUwqifoDdtgg7XW8pneKVFMH/QrL
         KL0P/+vgrc/qBaQ9I8IX9XAjJC2tzgbscMfRs8UKwxFdE/X+xFHuJWXF94AIlB4gZZC5
         fvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920098; x=1785524898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwuoOt4nocRx+llDpLx4v5UqGUJ5ldTSzjQhVvx3bXQ=;
        b=I5x6SO7qBtfqkVgx0NWU0v/9soLE7swvJkXHZRxju97JseuOlRzvTRHcUUHi97wiHA
         8bkSaxwdIQ1GPq7VCbTnIBrHRIeWeR1MeAra3AvVJbPJ9o2YVxupc8vYWwmEYC/FLuQd
         1ykzN1ozJwjm+uPaPjtTrVO4g7h5+p/5+8uU/Eo46ckIN43oS9jSi4xPTH2uuPN8Qn7D
         C/Q6antdnJV8/KAtAHkCgn8m6pC6+OwsSCvt2Rodqq5i452LgpZm2o1T/ph+Cni5f6t1
         lYwjIJbo/yLu5VtMJ42uSN0lz04Q3X/JV0M4g988N7A1MrXqiYkhlBxR9Em4BjRtwuZN
         8ebQ==
X-Gm-Message-State: AOJu0YxFlrm4P5X9hcDvP1Uv6jmNF3gy0QztemmE2zbCyyeVNPTsbpJ7
	jZFL2u8/HeEjNmOH5DZ2pbNAuphIEZBgsxepubaFZriBocXwCfs+oPEPOHMGRQ==
X-Gm-Gg: AR+sD12jE2ibWNQBhwLgbjla1tBfZO4FDTKIszKCxX91i1DT59FuupEa0ma1LtjwkId
	a8En4z+N47ZwNQtFLd0I/FcVNnI+/hk+k8x4cxrGLUbU1rSYhq8527/DefJOiQaK1H1+QSmQf+C
	KCqCq4QfB73e3/u4D7j3kTNBTBMlSbzmdyBgybRnANUKcTI6sU9y3p9y2AJfsgMpVadVQZm9TUR
	brwmehyRJlg+f7nIWceEKWNuA97FHebmFukFHDYXxM9GEq69s+zWAgv7UxjmFHqvUQV354hMio4
	EbgX6ij1duRtKL1G6He8mzI4HMABL3utHOFd1AeS6/ZPqvNvmV8oVvFV8KH1DDWcf3RBUMOpEGO
	VtgWImqQjn9XeToa05oqpUQ9hrstcZ3bzhLNkmdKhUM8lbUO613L8GKoLELXSIlRo
X-Received: by 2002:a05:6a00:140e:b0:847:9565:7a58 with SMTP id d2e1a72fcca58-84e2c1a05a4mr9622870b3a.48.1784920098433;
        Fri, 24 Jul 2026 12:08:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b2843sm440540a12.16.2026.07.24.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 04/18] bpf: Pass kfunc meta to mem and mem_size check
Date: Fri, 24 Jul 2026 12:07:58 -0700
Message-ID: <20260724190813.1458271-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfunc now shares the same bpf_call_arg_meta with helpers. Pass kfunc's
own meta to check_mem_reg() and check_kfunc_mem_size() instead of NULL
or a temporary meta on the stack.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb0f3ea53c99..468702b09c50 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6924,7 +6924,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size)
+			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -6950,8 +6950,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 
 	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, NULL);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, NULL);
+	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -6994,22 +6994,20 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 }
 
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
+				    struct bpf_reg_state *size_reg, argno_t mem_argno,
+				    argno_t size_argno, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
-	memset(&meta, 0, sizeof(meta));
-
 	if (may_be_null) {
 		saved_reg = *mem_reg;
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, &meta);
-	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, &meta);
+	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
+	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
@@ -9258,7 +9256,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
@@ -12404,7 +12402,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size);
+			ret = check_mem_reg(env, reg, argno, type_size, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12418,7 +12416,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
-							       argno, next_argno);
+							       argno, next_argno, meta);
 				if (ret < 0) {
 					verbose(env, "%s and ", reg_arg_name(env, argno));
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-- 
2.52.0


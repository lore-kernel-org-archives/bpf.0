Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E74F6492
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370790; cv=none; b=UNqaloQievPR6e+1h9VokUf5rWAscX8EiRBsQa1T8k+0bFRmbHsevsE+7j84BVaHSsOiv7fqh28mKRr+swClR5MJP5SBfAHGJELCGoYH8Jr2tvB+fU5215SlZxBCU0X0998t0ZXJo4rnWeC28WF3yS/iyo4KuWX7ngwVipQXXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370790; c=relaxed/simple;
	bh=/741TR1nmp1+JQpm5oK4Otq2SJkcIH0fF+21lHBN5w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjoPc0l00GwalU+cySkYoJW5ChV+j90WLBgST+BhxIlGWHNRaDXOPc+cP7lx1R4M74QfIWzUaDnoPZOB5cnBHW/UufcdRSrcXZ0ThJ1oLFs70QR+ajJ6Jplocx2FPzQ54byZe6jrw3F4ThCz+S2z8picC49tWmSR+xUrFbjCb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUBNn32C; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUBNn32C"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7ff1e4ffb3aso680797a34.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370788; x=1790975588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uhv5/RUsGLtB3AnWvJ4sDT4M1Ucwmp3lZrIJWUTHra8=;
        b=sUBNn32CcLRk8vAJ+hs25TdCP8HfTlKmEhLcDdMPEaulXkKHhkm5R7pUzT/E6nPXIo
         QXHcL7LkCvRX6mG06BklN5dGnC0VXP5xUEsN6SlWJYmbraGjPpgsx4SJUFfPKx5fYf6M
         CQCuAgTzg2zLcd8166pziSMV3/aaeAuW6vDNA/JagscLqVtwnoDIveyWgZnqzz9YOlVA
         zcKrr5Sv/tATZERtTjjbChrSWb+yciV8eLXlo93kZvu07Du4ouJVK6HG/q+76MUGaTVb
         kH6ZFrAddMg0rtKxfOujaY1PQaZam2kQMDSWeNsz2sKYFB4IHzgwYCESw5A6Ea7a8vv7
         uI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370788; x=1790975588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uhv5/RUsGLtB3AnWvJ4sDT4M1Ucwmp3lZrIJWUTHra8=;
        b=WNn4Q/NBxiZu9fhERMf+2PPTkrt08hW9OLQp256VIF6JX+JUuY6yo3NtVbQh2pAyzE
         S1hZ8kOt5QNDbM78gIG3NdQxRa02Bum5a3InXdlRZ/qVR1WcPUSKznyfKFC/xni+2dgS
         3NixOC+wl3wwdcb7MvQDKBLkaHh3efOvbzH0yKsxCQkySQ096/CAIWfb8/LcZbKNiX/C
         79ce8Ly6NDe8Fy68xzg1Xa2w5DHdJ/WO1H6xxWdKq0KMfwK+6p9GnTFYaZ0Qkvh/iBAT
         e2hK7+MJ+yD3LMJ+dXEiJXQMxCJQPI4JQeUsiNJPxQyApD5seS4bm/pXf81H/EMlVteT
         z9vg==
X-Gm-Message-State: AFuF++kxYYO5DddBQ/lb5OfTMRpCocX7o05xjMSt2iqty7N2RQaNjjTy
	M+SP/rJiLawtoS5ZLtc/H1f+DzljdqceOMEL52vUQmBuvWoszOdUnfVF34TxUg==
X-Gm-Gg: AYBFou29FegJJ9EVfuMIndNkYcbE/sq6lY7xP50whBmofE3hSBdWlJjJf43mmXOT7LX
	YFS/brrzB9nxvdwj+dEobl5Jr9HsjYBNDwg4iX3YCRlmNZeN8Ke60ubksQtvZTZQkzK9O22pxzb
	anSCZbslvKdzMRcglLeRmQIGntVDOpmqHDCKDk+mVG7X2Hf+vQL0bTWzxQTJBQ+BmRNcwtFv1Lp
	8Z05mdj8Dnh8/wBoLjxFPppSF9Aymz2obWBSyj/7hvf/yX5gZd+dRCG49aWmMMO9YT56hGMwxRT
	DsiTKz0GF7hsq/lPnecVWxKdiHDTnZS4zJ6duYFNCGS6RdbfEKGrLMyrlPES64LsRjnRM90hguk
	TLdQIieCiKUZ5VbMLUkmJSVq51n6RaRGMOT35a82iCtWdNxuJLGIlt7jYK0MYVSwldrTw7TMp5P
	9XVaLitH2OObujikUmgvZ0v0Ofd8+dCjGacZSa05ASXHOobTtQIDXFzzazR3RbbQ==
X-Received: by 2002:a05:6830:610f:b0:805:9b38:6f7c with SMTP id 46e09a7af769-8178559762cmr7575404a34.29.1790370788162;
        Fri, 25 Sep 2026 14:13:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e8054f00sm3456679a34.9.2026.09.25.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/12] bpf: Check subprog arena arguments in the common path
Date: Fri, 25 Sep 2026 14:12:51 -0700
Message-ID: <20260925211256.1834061-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_PTR_TO_ARENA accepts both arena pointers and scalars. The existing
BPF-subprogram contract includes a constant-zero scalar; it is an arena
address value rather than a conventional pointer rejected by
nullability checking.

Kfunc prototype generation already records this zero acceptance with
PTR_MAYBE_NULL for both arena suffixes; separate JIT metadata determines
whether the kernel callee receives the arena base or NULL. Apply the same
call-site representation to the temporary BPF-subprogram prototype, then
extend the guarded check_func_arg() path to cover arena arguments.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7b245e90f33..96749d9b3e26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10815,6 +10815,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			 * to protect against invalid memory access.
 			 */
 			arg_type = ARG_IGNORE;
+		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
+			arg_type |= PTR_MAYBE_NULL;
 		}
 		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
@@ -10880,7 +10882,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX) {
+		    arg_type == ARG_PTR_TO_CTX ||
+		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
@@ -10908,19 +10911,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
-			/*
-			 * Can pass any value and the kernel won't crash, but
-			 * only PTR_TO_ARENA or SCALAR make sense. Everything
-			 * else is a bug in the bpf program. Point it out to
-			 * the user at the verification time instead of
-			 * run-time debug nightmare.
-			 */
-			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a pointer to arena or scalar.\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (arg_type == ARG_PTR_TO_DYNPTR) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
 			if (ret)
-- 
2.52.0


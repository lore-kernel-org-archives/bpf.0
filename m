Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608982;
	b=Jbr6CEDlqVpM8IV5DXyoT74UeS4UlOkTv4RJq7Gup3nR53pYg7ksZnNMHSXgrjJnECwq
	 Jki11GHfckc3jg9g6WkdXexIb4xG57FGHylPdF8GjBbMDAcARUoOx5RHUtTvqjLbWKy2t
	 1/QgDTjwJP1j+E5Yv72YG4+jRNmr5O0kf8o/Uxavkb93K1KEkKs88mBtBzy2xq+o2xZr+
	 z6ota5vm5WhZYDAUu4L2PRev0gSFTDLdK6Yo83Xs1pvXYS9kcErb4GE4DCNhGYTB1d4g9
	 YNaAGUPtnPqoWS49d9VL1XHVzdi3HUBN4vPhIkY++qm/qlPInDHMuItXbkvlvWvxkWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XQ8+5f46NabSzs2qVL1KtIneJO6CEizXtPDigG8/VeM=;
	b=kW9X7zXzsDlIaqKLareVmcpVJub1Ipj/iKShl/8Ph7LC6nrqcdbVonJGhImXSmzasDCv
	 j7GanzYp/DE2s2LIlCfYYFlCgxAcnlTFmfp1f/Gbra7RR/EWfSKIjuD9qJKXv74YpzlhG
	 ScRuI1EKi1uVzzWgTYvqLr/f0iaXHeoOf8cRLpe7tpsi8+M1dX3tC3YZB4a8hiqaoP9gP
	 zjSVje3dVN7tzPSek1hgn6G47efh5NyjJ/IB7631D4lhlDcAD8XC1hr9YzPgD3icWDCrP
	 /AK922fjBdHFWMwm5MtJB+CgoXHYWLAIIXjvgXzgvy64lgHwfSlgdi1YkikFgzPp6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JWMBben7;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE67606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DE67606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JWMBben7
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so2025303eec.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792608981; x=1793213781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XQ8+5f46NabSzs2qVL1KtIneJO6CEizXtPDigG8/VeM=;
        b=JWMBben7IZKHYY6pe1MGvXabuHpCCC7Uar6RzfXPjoeciSSEg3lqD8t35N6sLpT3MR
         WG+mK3eDfmmJqUJWtwnYh/9/iIGWlri+YUjnngtSNrxXcXrHiwUBcPItVpnbC/dlHfgX
         AgqbWolVPzKSkol2nIVMuZ/zURGhLUO/BWzrnTE0kYeTjVEnMuCU+9eFyUuitA7v5Csi
         YuNMdJ0WAz0XwqY0c4vkzqhv7Iz+UT/5IoJGXC0AvhGolRnzTouSvKcJ3nDj/kI6TRxd
         BkDgelXSZGxUeld5B9VgqV1hZcf/Qjjq/Q9eGca57kpynsUhMVw4vO1iOKMPnUku5SmL
         l2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608981; x=1793213781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQ8+5f46NabSzs2qVL1KtIneJO6CEizXtPDigG8/VeM=;
        b=mnE79Ik9RPwaPtJJKvZWD4vjcHONZRpsr3eX5tyNDsFDJrdNqnff7GeipWyY0pQMSI
         UaNlPk1dT2DOcacdcqGi0IHiSFFl48EmB2tR2+cvTj6IAueVaajoMkK+DaEtis2D72IP
         yiKirHtNtlh3ifNpdqNqVbMXwlrBQ+L1XFbqhxhZKt2YhhEh3YhOqrw4zdYrKXxqTnDa
         b6Zr28RqLq9yf9ElKaJFRSdJobaCn9xbHON/9GcSQRJH8l+7aUmINWTzwdRFnMfprzug
         cdGfyV7GMl99EQxTUL0s2fPWIscvSvBGLBS+uKOj938vR83StR77AUvPIHe7/6LfZMeZ
         BWUw==
X-Gm-Message-State: AFq9FYLoEQu8UX/f+8FcqcoI2wJ9x2/vW/l2wSXFUS5sVSv3gWkrtdFC
	bY6X7ZMItqb0p8Nn4+P6S6QqExjPmXPkrf0M5BEsuDW69kBnZ5Oqv3n6fjC7U0Xp
X-Gm-Gg: AYBFou3v4ZxUPHNkBBW3jXZsMxIm7mdjR3juig5BsZD0GIlD135GNqmmaxZ3FkwH41A
	vKlU8JNiQFCI5yhqc2JwthuUBdYBk/52EC5I57R2xFREemNIcL5qQOni+WzfLA2VdbW4EZwPx38
	BEQTEXGst7bLia3PpAyoWPjqxQ5Dv3Gc9bZu+/bTqljwZXdmRxmmy5xFgqu76lSq7fCVgRPvynG
	HUi0Qjtzcjzpi8t5KKhyzdveBY1vPbFa3XHN6qEy4d1PR74WfQJp97WcJqRVBVxk+HcMXwdk6aG
	bhY191yf9WPE9K832AgJXeeu0CIpfUNZ8Yan0vpmXfts2hr9ZkMh/AVTx7MYfoRf2pOfW43VNq1
	XMnGxfuo1PhCu6Au6YqOq08kQwwygmzrz3lRM4yj5Pd5t7LNYCmLCdKg0rbyK4TyfhJYsEUg9tQ
	bNfDAdJKz6jNrTNV9fhAHfqlQZ4TZ+eD6b/ZAvh/IJ2dTTPa0s2T4MrTkeXAeALRldGbWATWgTj
	TxzRtYAMsZOnH0g3iPPaMbCd82+NlyajXCjRH2JyQXpmSL6yCRLThDT5Wto4hqA49ZPneUlfPTt
	aPEybhKryJJm0Oa6gXa0TfdxF0+cfIr/FsLP
X-Received: by 2002:a05:693c:20c5:20b0:368:7c9d:1577 with SMTP id 5a478bee46e88-3687c9d18f4mr831509eec.20.1792608980580;
        Wed, 21 Oct 2026 11:56:20 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:90ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm9193056eec.27.2026.10.21.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:56:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: reject pointer operands for 32-bit recurrences/latches
Date: Wed, 21 Oct 2026 11:56:08 -0700
Message-ID: <20261021185609.607075-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid inferring loop bounds for the following program shapes:

     32-bit latch (A)      |    32-bit recurrence (B)
  -------------------------+--------------------------
     r1 = ... pointer ...  |    r1 = ... pointer ...
     r2 = ... pointer ...  |    r2 = ... pointer ...
  l: r1 += 8               | l: w1 += 8
     ...                   |    ...
     if w1 < w2 goto l     |    if r1 < r2 goto l

(A) Scalar bounds for pointers represent only offsets from their
    common origin values. The 32-bit operations also depend on the
    runtime base address: the addresses can wrap at 32 bits without
    the tracked offsets wrapping. Thus, offsets alone do not determine
    the iteration count.

(B) 32-bit operations on pointers either prohibited (wX += 1)
    or convert them to scalars (wX = wX). No need to deal with
    this at SCEV level.

Fixes: df4761bd441c ("bpf: Support 32-bit linear scalar evolution")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fea77772ca96..f9e2ca6a5a12 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2024,7 +2024,8 @@ static void log_incompatible_scev_values(struct bpf_verifier_env *env, const cha
 }
 
 static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_state *st,
-				  const struct scev_value *a, const struct scev_value *b)
+				  const struct scev_value *a, const struct scev_value *b,
+				  const struct linear_latch *latch)
 {
 	const struct bpf_reg_state *ra, *rb;
 
@@ -2035,7 +2036,7 @@ static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_
 	}
 	ra = scev_reg_for_read(env, st, a->ptr_reg);
 	rb = scev_reg_for_read(env, st, b->ptr_reg);
-	if (ra && rb && bpf_same_memory_origin(ra, rb))
+	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch->jmp32)
 		return true;
 
 incompatible:
@@ -2267,7 +2268,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 		return false;
 	}
-	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
+	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
 		return false;
 
 	initial = initial_val.value;
@@ -2700,6 +2701,9 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		reg = scev_reg_for_linear(cur_func, r);
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
+			/* 32-bit ALU operations on pointers convert them to scalars */
+			if (coefs.zext32 && reg->type != SCALAR_VALUE)
+				goto cant_widen;
 			/* Spills at varying offsets lose precision */
 			if (test_bit(r, loop->store_base_regs)) {
 				spill_base = true;
-- 
2.56.0


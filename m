Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208053;
	b=iRDMLBBZjqek25jJssNVG8tmgICPwILJqqtFjZCKdL+7VpblIdG33NlsrAKNQQVtqzB9
	 hKzBPnxMu+FLOT0t6eLi/0pxo05Llgs9VueNjStsU9yVr5up65LswalugHfLutPgnSzX5
	 wNCISW/C4PxaUtnNSYLEkFWEbA1NXHyeiPScWDJhwuhFkQKMhqvRoBjNKg8fTeb3hsimM
	 NPSWORVKvFrpg/9rmA39Hplzeu5xh73K/nwYti03d1YPsPaoU1GTGk164fzyyolGzq4bp
	 mSJLpi/ixdbY4We2JIzegXRa963sS4sLuD/TezCvhKPgmsIhmFJRPmNZomy5S1Zjx+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u52SOqFmcAgn/aiXyaGWdj6qpi9TAqBM8YwkC4CwqUw=;
	b=Elv/kDHZ3M7O/nH28lsdby8omHaZ6mN+FhXIyE4RpYkjfuWeO2Zb10Y31HVCb1MheFTo
	 JdXbzwZfNO4xQD/7feOXL3EPER3YuUf2xbHAckLivqwGuS2Btjqw8CiAlgFI+de1dn1Uc
	 LJ44JQdU2vlljb2P8Yh0uLN6E684aMKsJyPizQijLLGhFNw3goVuGT8sbXJBkGQY6I3Dh
	 IxrGkYtm+gV/R215o0XHYt1AQl7xqzUdD6spLJo839G19kfPfgOVWv2dDasFZ3SWnaz63
	 DX8VEY/kWCUgNeEtxjvqKbComqeCb2psmvkUZb/thv2nNPNuyIAQ0ZU9L5MZ3aDfHWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3Xcy6Re;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF58606A6B8
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF58606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3Xcy6Re
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso917145a91.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208051; x=1795812851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u52SOqFmcAgn/aiXyaGWdj6qpi9TAqBM8YwkC4CwqUw=;
        b=q3Xcy6RetEy3326B5ne1c6c6R4UlegViyZOGMtGjP3xMvgCJa2ruB26eD6qiylufdb
         Ny6YAZ69p7BauCu77959v8Dhx2tMDlw7A+bG90QNt4jpvd3D595RZEa0uMskCfdbloiJ
         17/Ppz0bcKFK3rjJdYsF0diniux0AnZUrg6gzeqMb62bcSUV0al9CWRGg1VtxMMgDp0u
         GDfB+G3oZlckwG4DlOW1oBG3uttD1Rmr+Mfd8aDrRf1euwiDBgIbvocisr6jE7tDTHyk
         nVn/L97rIs54oARjavX6+rQTJTm2CnAUQaFK6FnHe/CLdkdWk8omvNvEhmodUjcr1WVa
         P1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208051; x=1795812851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u52SOqFmcAgn/aiXyaGWdj6qpi9TAqBM8YwkC4CwqUw=;
        b=xuOCf/7loTiSBuzDZ9j4DasNb7sK2wpwHlw0/NJi0SWIA/ozkhGMmGV7YGHv1Yas+Q
         HxZK/Khm41WY/4jO6qcPmHv2AmoTr3WF5NNoos+HHYKK4hJt9fxWomkerCRsaMdv4erN
         wkQTIythAq6nAql+0jjXOdghscPud6Tbz8MVLfN8oJTZDSqy5KM89iRrK4YPiCbOLsGY
         /QHLv0Ti7qiDCp7hojexizh0H2cWi6Gu6BM7FH455WOy4KjppfeDRXZbdpbvJZ/MzwxQ
         SJZZdbyPtjCbljuF7O/DFfj/yqPk7s78AJSu2mBILqG5xSu+I5HRaWMsw2dFAGGX71MT
         4Tyg==
X-Gm-Message-State: APuU4Z/TlkEWLx7hSbRwnhwPfexdRBMIyW87tKUEbwqjlz5Bn8I7snXJ
	4RbVKZa5fx29tMxq56T8/0b9GimNNXQOW+OvnGeFSlPl52QTUQOrN4QKM/zcAA==
X-Gm-Gg: AZFdTZed//lcHaCe1J2lSjSBrxVEvOAAdd9AaeFKWiJgI9HY8jKfeYKx1oD9mdae5L5
	ToUki+kRgqYqyA4Qa6w4z71ybRrs0blto2azGeAhZ2kO09nvozSsw+r4YuD7bPSDilzEqnwp4Dm
	mKc6wwK3cLR1h0fnaQ0+NkTUKv6QatrkhtGxL2uYNOhe9ebRiT8+sSi5NP8v1z/wbF+ykMx4t01
	6BidLaUPcNVA6QiqkQyQbuIEyaMUsauXkRlGWqh1GHz69NxE6mmKscFdW8QIK4cMNe/I+K/2XB1
	8v9Mty8AZw+8lp9UBN2mH9kDC18VmKHGMLt2dFebfgfev7K+otko4FhnaUDtNFyI86dgE3s7Uy/
	4O74XzH9KquvFuBgDfDIC8QLmQcayEKNiJxIsl/kbNpVUBOq8aFy4pDMk1AI7gbbruC1ShN0GvN
	QXmUhBloXpTt3LLoJeIfi5gwNC+XHV0WffWVGzoZU8qiCmstmoM8hDrB2YS2fH8K9o4Ku8+Vt3w
	k1w7R6AtrNc83TH1m0at6NT9/J+GVJ3JpulWKRR9KpgmKFIhypFVRl9Na7TuObwC7qDPUMJ2ALh
	kyviz/y4u2rHYsrf1VlohyW1UDiudpaZ6MRxRTJa6TPuyAepsKtB+Hii7r/t5weVw40716HvKF5
	njVuv+VX+Np3yrsikatEioe8BuKyrRrKgC91jgN5drk0SbKS1utWk1Gwq4VCQQrUmx50XU24Lwg
	==
X-Received: by 2002:a17:90b:3cc7:b0:3b1:8300:f48e with SMTP id 98e67ed59e1d1-3b41c9715a7mr4216412a91.49.1795208050635;
        Fri, 20 Nov 2026 12:54:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b75f2a4sm324149a91.2.2026.11.20.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:54:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 42/49] bpf: Allow a range of offsets for a constant string
Date: Fri, 20 Nov 2026 20:49:50 +0000
Message-ID: <20261120204959.614908-43-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

clang merges two calls that differ only in a string. The join of the
two pointers has a range. "is not a constant address" costs one more
pass.

The map is read-only. If a zero is at the largest offset or after it,
it ends all strings that start before it:

  .rodata   a % d 0 b c d 0
            ^       ^     ^
            umin    umax  ends both

Allow the range. There are two exceptions:
- bpf_snprintf(): the verifier checks the format,
- no bypass_spec_v1: the cpu can speculate past the test of the offset.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 146718823e3..8d0767b3bd4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9585,7 +9585,8 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (!tnum_is_const(reg->var_off)) {
+	/* the cpu can speculate past the test of a variable offset */
+	if (!tnum_is_const(reg->var_off) && !env->bypass_spec_v1) {
 		verbose(env, "%s is not a constant address'\n", reg_arg_name(env, argno));
 		return -EACCES;
 	}
@@ -9595,13 +9596,12 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	err = check_map_access(env, reg, argno, 0,
-			       map->value_size - reg->var_off.value, false,
-			       ACCESS_HELPER);
+	err = check_map_access(env, reg, argno, 0, 1, false, ACCESS_HELPER);
 	if (err)
 		return err;
 
-	map_off = reg->var_off.value;
+	/* the zero of the last string ends all strings that start before it */
+	map_off = reg_umax(reg);
 	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
 	if (err) {
 		verbose(env, "direct value access on string failed\n");
@@ -9614,7 +9614,8 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 	/* the bytes of a pointer to a function are not known until the program is jitted */
-	if (bpf_map_range_func_ptrs(env, map, map_off, strlen(str_ptr + map_off) + 1, &cnt)) {
+	map_off += strlen(str_ptr + map_off) + 1;
+	if (bpf_map_range_func_ptrs(env, map, reg_umin(reg), map_off - reg_umin(reg), &cnt)) {
 		verbose(env, "string overlaps with a pointer to a function\n");
 		return -EACCES;
 	}
@@ -12776,9 +12777,12 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 		return -EINVAL;
 	num_args = data_len_reg->var_off.value / 8;
 
-	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
-	 * and map_direct_value_addr is set.
-	 */
+	if (!tnum_is_const(fmt_reg->var_off)) {
+		verbose(env, "R3 is not a constant address\n");
+		return -EACCES;
+	}
+
+	/* fmt being ARG_PTR_TO_CONST_STR guarantees that map_direct_value_addr is set */
 	fmt_map_off = fmt_reg->var_off.value;
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
-- 
2.55.0


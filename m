Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809137C90E
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404510; cv=none; b=gsvVUHZ79Wb1CaZHKvrTvQouS+Nfxs6R7wKAfbG+Mwo33Ch1RyDZ7DH813r7QXOwNA/Q36aU+YgoaeEqZwiCuc5vkR7Npb5RTprZM+F/k7yUxNGgIRzRHaO3PCMo3iOHYZKpzxgyYdBg9qKtR9YJiOnhM37vHhwJYboU5RCX06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404510; c=relaxed/simple;
	bh=zMs7nSz36jZxUeTahMo0usqAkAszaWwPA1Hx749fPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJT9brdyoR5MkkX5/KSkYVIdNjXXwTiFQ+bXikUfUyDsssMQDbYgWov1naYNxeKij9J6I5G8ySTmBUxveriBJkSzOD+ybl/Lt2uHMIxiYTwA6ZpYof8VOZVM8T2msqDb5Abq53zA1+iP/jAHjs1Dy5D/Qe/Cgl6pJppx+kOWS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRsg5RsU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRsg5RsU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad4170e8eso45299985ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783404508; x=1784009308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpg9LG+O76eplxZLK8lJGM9FCJbB7J7EQAwbljKS/SQ=;
        b=MRsg5RsUjzCkDOHjgzJS6q+dooiX9Rn1pbwRAkk4AQV94Lk5PoMpR3nXGGsFoHnZR+
         BJw0BwlnE5b5wzeGQuzJYuza/V16UXlhY5OPL+JEKYP6JwNfQkuNL+a9Uw5+GMJ60az0
         d6zzpzfgxDpKqXX8nnQxSwnbDfCnzkevrkWdheQ54OuMN1ptAuqg+0i3mFz3wEfK7VEv
         oeP1YqNd1B1vDIDJYcrax20y1IA9qniDpJw+Smt3wJhw+qQpIHUM39L9UMTtzOOu4dvK
         hjT/hihrVujrgQsz9YtQ37L7lefPBGhOfmM1vlPeBi/0YjpM3o1Kk2lN9BCOUHLk36xE
         xNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404508; x=1784009308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpg9LG+O76eplxZLK8lJGM9FCJbB7J7EQAwbljKS/SQ=;
        b=UNRz1cg6nfZWnY0RAgjcV1XhvpSfNk3rZCPCXzplU5pJUHSvf2wm1lyB+BUVtd6g8Z
         ZJxNdTrjjBmTeJcYdXgphpmGXzjGLTBkDQl8Nr3m3fzDdQr7t82zk5vYtXmyBBOCVBbL
         qT2Gw5wuI8mTu/8SyAsoJorDF0Ha19aUbPLQf4DIS+otJfMVMvyiDmOvUQRYCe6bZiJo
         qb0ZtJ1MqeNHapODMM3qm6zjh8lrxPND+jeQLx1YyYXUGb5tvFKApjKONQ9cnXOko1go
         9mYAzCjct0awj1K5S9IXJCa7Ek5Vt+Fq7KtVtoyc/8Cu5DxzSPduS8CvgDrjQTdJORqT
         8U8Q==
X-Gm-Message-State: AOJu0YzCwo5pg1M45i109MBe74SLzjbIIysUIbmfaD2VNXNhN4Y3MHWD
	RQfK5AQVVja8Pk05aWxsRpxL71Q7tx8SK8F/e/Ar37wJGyBbnjTyRD0uWh3wJKNi5Y5GOg==
X-Gm-Gg: AfdE7cnQEiuFhXgOwu2Gzj28uDFXsCMymgj87WLrZBJD6NMvNbIzlikl4+iIzWKblIN
	mTRy2yY4UqL9WUedpiUftHw9Smc8XolH1Mxdk1OdFfITfSFNsHahLaSf+yJzz1wagJ+Qg+87+sQ
	9smflWV/7B/jnpfpBUR1/jP50MmMiUyf20iBFp4cEp11SPvBLZ2cklhFxMmyXQu0RVZ6fRf5xNa
	WDJYrGdpCQIvBMkK09VHizmDJwtgkVjV3SAsMWbUCmnAF9L6jSC9Bl/ZsW4bGXXji2ubviUUm6+
	ctoTmjme2BWyAG7AAyuksK6jLaE5+nN/OHojFgsiYeZr3j9yEQ10KrraopribNmhlbYa92I+2Fq
	ICgck9ITRatVKZ5tsgRsv8dT/Kcmw5QZaNv2FqY+g5N+hchYFurGIhcZWHpCL2QFRJCclzcftLr
	fX27yXTyowsdkdRIStwb2LPZiUQh3NAjbjdxs5EFXogY6NkIel/ffsyVn3Wh9L6o0kgqiPl8J9G
	KiwD0zXwr7wAu+xmVWqxpOPbeNBvCjdrQ==
X-Received: by 2002:a05:6300:618d:b0:3bf:a698:ce4c with SMTP id adf61e73a8af0-3c08f001b9fmr4812556637.58.1783404508412;
        Mon, 06 Jul 2026 23:08:28 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm4101507eec.4.2026.07.06.23.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:08:27 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Reject negative const offsets for buffer pointers
Date: Mon,  6 Jul 2026 23:08:03 -0700
Message-ID: <20260707060804.93561-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
References: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

For example, a raw tracepoint writable program can load ctx[0] as a
PTR_TO_TP_BUFFER, move it by -8, and then access the adjusted pointer.
The access is before the tracepoint writable buffer base and should be
rejected.

Compute the signed effective buffer offset before updating max access
accounting. Reject negative effective offsets and use the checked access
end for max_tp_access and other buffer max access accounting.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21a365d436a5..b4ed6d519630 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
+	s64 start, var_off;
+
 	if (off < 0) {
 		verbose(env,
 			"%s invalid %s buffer access: off=%d, size=%d\n",
 			reg_arg_name(env, argno), buf_info, off, size);
 		return -EACCES;
 	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	var_off = (s64)reg->var_off.value;
+	if (check_add_overflow(var_off, (s64)off, &start)) {
+		verbose(env,
+			"%s invalid %s buffer access: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (start > U32_MAX || size < 0 ||
+	    check_add_overflow((u32)start, (u32)size, access_end)) {
+		verbose(env,
+			"%s invalid %s buffer access: off=%lld, size=%d\n",
+			reg_arg_name(env, argno), buf_info, start, size);
+		return -EACCES;
+	}
+
 	return 0;
 }
 
@@ -5351,14 +5378,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5397,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0


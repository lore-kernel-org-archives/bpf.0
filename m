Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071056;
	b=qA4lbfsVBSWv30a2WlETJzNstFIW4lPGU9bUPllFrO9fZ9Ob14HsKcL2kwkWZw/k5f3H
	 fhDs3AwOT/Woynmn+i/o8p3ErKiXgVtu5G1d1B9J+lmt7yYpkaGsqVWuwt9PBF6qz8m4X
	 dB2Ursayg+ey4cpdyfNTEwciWtpQ+zByUtPAQ7jPHolset3pBI5XzPmyvbqFFlyO4pFXE
	 Ya83K7cgriT9vllN2tE7Lqas/XMq8JyIAzTQKfX7O4FcvESGLWhe5kdP7Vn/6AV0Vc0bU
	 p04yIGYYeLf4YeX9luIy7YW1GRewigVDsjehLhfwWaVrOfGAGt5X6cQppKLOb5J2ckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vwIyfqPnulvMVf4jDzYiwgaTswaxhVcjhYAlGURzjIA=;
	b=m1W5dEQrcboDFSjKE6b0DvoyztN+q1RxryCuTH9IKP7Vo1DYJu4ATQNbM2NIiOzwID9J
	 BXg67Ak0KKLJ0glbcGU/zcHkHApgYUDDxz+wM4KaO02CuSd81MesMju4Gt2IGWzwxRjU4
	 Ee112aSFRjLsw/WbcC30/RX6r+9J8+oDmGtvSX5iCyMcipFHlh07Bs4+SWoOlBkjf79Ik
	 zhkVGVE+BVB47ThXO9Py58/xcZO1fs15/bIS6GztbkW5UXuRAMLMA4tESpdlj3G5f1gLW
	 LKwBcSsjdpYH8Y3/pu1QelCkKBlrwUZz7HbC7FbLorsWKgVhU7FjusmGB7gQ5x4RD/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3NlqlqR;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177E606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A177E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3NlqlqR
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so340125a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071055; x=1794675855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwIyfqPnulvMVf4jDzYiwgaTswaxhVcjhYAlGURzjIA=;
        b=h3NlqlqR9inlgm+LClbMzE8mSdM/pp/pxflzkv0rHMv6oqeqjhh3J0eFdOpmU9O+qZ
         yVPnAcqGOoDmlEORF9uqkVw1f+Lo/eEYJOxaDD7YsYVMgZRv9epAeyGVg3zo4Fx7Ph1a
         y9dUGG+fWW/EyVrkX07yFccRFtzDQeMiBfcBZNZJGYgv9DlCsqvJd9ranDClv1dg969I
         9LQW+6R6uXIfFWzGt3YqOCUc0jyFoE2bd5lRbdUI3oaqAgQwcGhjB/XRDzBVxB06oXXE
         +nH4w227CqQqwIEeL6JeiBG/uz/OMRzXEaEnDRPZ8g23ejULrCw5W4DkEyQcvpA3ZutU
         8IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071055; x=1794675855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwIyfqPnulvMVf4jDzYiwgaTswaxhVcjhYAlGURzjIA=;
        b=xEZ3LCWgB6FTyXMMTJLwVRu24GPbL3VrlwRgfiHJYYBYFWSNH9nYEDD3OjTreAmOov
         CslAjGBP330apnCj1e6qfyYqzfaA5tuNUL7Ns+ht3sZMTTj94Wm60jT/sBhcUu3cXzq3
         hwz4fUm/3G41F+rmiv+Nn9J/j3zkaSGDI91VbRSpM8tfgu3E24t7b/8QMjsV1DsSIBQT
         btvaAliqUA15LWkzmxnLCJ6wACqlYxThKuWvxILy2YKG5XjVWdRya4IRZypZ6fcoUmRy
         LvJfV22kgNEHcGSsSmUtA1ZYxbBvEcbpGv73SrDlkn7tvN/+UTr6y46ahQNgdssq/zgR
         o5CA==
X-Gm-Message-State: APuU4Z/9PBXKmmwGT2rE5pNoqW4WBC76kFADOnQ3JZhbT1lb2BfP3bwO
	8AzJvMtydIeDsAsiJhioOsAxdNAghzpeP9KhVLBJz0z2sytUf0t7uxp5qT7vIw==
X-Gm-Gg: AYBFou0+deecNDdx5roJuPE1X5Xk4WO8D0qY/g1tqvsiiTDCx5fMup3Zn3qlrTYjpUE
	qEOVXTp7M9FMdpXJvyQi1stKAbRckSX3AqXJx3D1ZVQnlBYxyRG6g6oae4MVLUP6/dLpnKW/D+Q
	4nGOlUJfE+EAWToSBnyrTMi9Hb1PJu8rOrBQITmP+D5k91aC9EDF6jBOmoDZrCLcGphFNghXltD
	e+IWUtA9cJGJxmeI86FYAKxrQ4rQsfPiKT2S8l/ZWgs1hA1vQA4FF1nQUylGVTvismMKoh9hmhd
	bboG8LyosdrnsjuitZT7AQ4sbXH21a3S1gwv+88uzn/DNu9D6mr2pueSuu7j5fXqWAzUNZfdxWB
	XHUHul1a67o7TijqkzaZoRSWFErkRp4YrNrn+l5vAe3qiP0Yk6jMOp6+wIUi3TvpfZbovqpSEdx
	W5ngjIco+24p29BbXiGLFCjfSsmtEAQtqEGsWsZYdlIHo6yig+5ydPbv/IdCEI4ENak6F0YXumE
	Oai068GDYfVCRfurFDRWmHk7g9skKgFqQOtA7XORIjpKGXoSB/QyhDh6yzDJVOwN2sA+EP2NOMl
	AWBJqnV/GXDq7FVQ6jIAj1rj4Z6sh1f2ZvdVmlzT0g14hsrF23TVDUC6TP5IVBRJ9JrvPynPZpq
	i45qEFJ+RiwkYRqJ5D5PtO5pAaGhGekun6B9dxN2keLOBm+7/wHJGX1BhiFdMNUlcls91PSIFMr
	vLScLahJZ8D4VCq22R2lc=
X-Received: by 2002:a17:90b:3e48:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3b106314940mr1742187a91.23.1794071054716;
        Sat, 07 Nov 2026 09:04:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm4315104a91.15.2026.11.07.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:04:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 9/9] selftests/bpf: Test a flag that goes with the cookie of bpf_throw()
Date: Sat,  7 Nov 2026 17:03:06 +0000
Message-ID: <20261107170306.2831028-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

  if (err == -EPERM || err == -EACCES)
          bpf_throw(err);

An LSM prog, no exception callback. The compiler keeps the condition in a
flag. Two jumps are between the place where the paths meet and the test of
the flag. That is too far for the rule that keeps 0 and 1 of a flag apart.
In the second prog the flag goes with the number that the prog must not
return.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_jumps_ahead.c          | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
index 66d8a7c4a6a0..de3252b59970 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
@@ -523,6 +523,63 @@ __naked void flag_and_retval(void)
 	);
 }
 
+extern void bpf_throw(__u64 cookie) __ksym;
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_throw(0);
+}
+
+/*
+ *	err = policy();
+ *	count(a); count(b);
+ *	if (err == -EPERM || err == -EACCES)
+ *		bpf_throw(err);
+ *	return 0;
+ * There is no exception callback: the prog returns err. The jump that looks at the flag is too
+ * far ahead to keep 0 and 1 of the flag apart.
+ */
+#define FLAG_AND_COOKIE(name, no, yes)			\
+__arch_x86_64 __arch_arm64 __arch_s390x			\
+__naked void name(void)					\
+{							\
+	asm volatile (					\
+		"call %[bpf_get_prandom_u32];"		\
+		"w8 = " #no ";"				\
+		"r9 = 1;"				\
+		"if r0 == 0 goto 1f;"			\
+		"w8 = " #yes ";"			\
+		"r9 = -13;"				\
+	"1:"						\
+		"call %[bpf_get_prandom_u32];"		\
+		"if r0 == 0 goto +1;"			\
+		"r7 = r0;"				\
+		"call %[bpf_get_prandom_u32];"		\
+		"if r0 == 0 goto +1;"			\
+		"r7 = r0;"				\
+		"if w8 == 0 goto 2f;"			\
+		"r1 = r9;"				\
+		"call %[bpf_throw];"			\
+	"2:"						\
+		"r0 = 0;"				\
+		"exit;"					\
+		:					\
+		: __imm(bpf_get_prandom_u32), __imm(bpf_throw)	\
+		: __clobber_all				\
+	);						\
+}
+
+SEC("lsm/file_permission")
+__description("jumps ahead: a flag goes together with what bpf_throw() takes")
+__success
+FLAG_AND_COOKIE(flag_and_cookie, 0, 1)
+
+SEC("lsm/file_permission")
+__description("jumps ahead: a flag goes together with what bpf_throw() does not take")
+__failure __msg("At program exit the register R1 has smin=1 smax=1 should have been in [-4095, 0]")
+FLAG_AND_COOKIE(flag_and_bad_cookie, 1, 0)
+
 char buf[8];
 
 /* As in test_seg6_loop.c without 32-bit insns: the copy is tested, the original is used */

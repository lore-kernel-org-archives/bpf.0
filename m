Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22C3976BD
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504660; cv=none; b=HSvSqmrEo2POfZfXAWrIPQGrBi6qnkmniJ456C7J/968aQq9VSMxAUs120Hque3rBynnEMvW4mEXlPNDvDd64WxY0zsG8udNzgdVlE1BK7cIxqGbn8X+bCOYf196o0B5aYH05RlJu2qngV5oDUz156xqFUl3Erz/6ojtEccesCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504660; c=relaxed/simple;
	bh=wQrjZrw9/mrdayJSQsNWrwuSWWYAntM/yonGUlu09ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaU9pPTg+vhkHrbTrNLJeNANbzlcd2M/vYtEecdj6emiRYxOXsLWrBIzXvYIl/I0jbfhc5y+abN8prpNStDXzNx8bGvei6E1acJPoOmxOwN2ImB5ydkhfro3ajg3n4TF8A4R9untppJWWo4lvQbmfTdHIt7QcB4sQPtuUli13Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcmgWJ0g; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcmgWJ0g"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-470145d7df5so1774967b6e.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504657; x=1776109457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G83gLFXj42ER0+OaQumxri0H+MvWxYOxkcS97a/FdA=;
        b=KcmgWJ0ggOPmBLCxMGiUdzP0OBrRzStzvY4rV/eMYvx3DVTmjpGkaYigvww69nb3f8
         uE04ddqtzuJb4jRUHBu62C3bCuDAobOOV7dmhPfAUm5QEv7EJrGsRMQLN2UEiG97HQFw
         8EqLhPmMTy1htBLBFwVFdizJ1Cw76GpEzdrzsYJe+hbANkkdsJ+kgmgOFndTL66oMMI0
         gSZKfl6uz5o1PJCciJsQxW1sUZuMGgvbtPesKeCMAGNCYZDwC846kTKSgCAhykaNzKDd
         mtdUW87wP9UOKV8FXRMTQ+JpJX/w4QQTYxhAxlboB0Do46+KPHqOP4Za0c7YS37u7pGF
         fryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504657; x=1776109457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G83gLFXj42ER0+OaQumxri0H+MvWxYOxkcS97a/FdA=;
        b=Xrehp7ZukEl00oxSAKR075TAjJEfkynmbnKtxSlly8cnquYqZPkFDGT1odmjjNcTiN
         8tAt4IoHhsAsHXjVjedVWIOdB2xXL2bkXEjry4uTepOas3ec+2kzWJw2weHbkv7an8a2
         Sg9wlXQ5n/hRpF0cc64DnuUqsdZ+B2wisR+opbLvi60XYO89ASi4S9DRFW4JvfUln6Lj
         g4kPbj9+6FuW+D1UT3YNozywa9pyseYJr4FJk6i3KMTApe1bcmPAL5HYECGyhcs/2DdN
         D7YHfrdyHfzgYsVw36ZGsJhxSRrzStVn8XencaTWfhCdsqewlgTfbhyKYQWeGXeu7OCb
         kj7A==
X-Gm-Message-State: AOJu0YwyxjkVB8+25ZyC4DoAfyEQoFdBZSz0i7L7ORtoAHJri9Kluzg9
	wbTjahnpSrooFzeq0yptoDRdz8OFSBq1roQTG3ROT2gHBhiaURoV4mDQpj/oZCo00mI=
X-Gm-Gg: AeBDieve/Asf+jZabjs/KBVWf3D/CyYx25OiZfznRuuHGOM0i/5S+ffU6X5LwPEs6oU
	mIEUZHvOlxmD3b0pqzhm+nD9AL9cCOrW9GGgfWRWVGt9540EgpSDviS8kFbsN7atVxAAm75/Bo2
	6Ql97/bU5Iz87oqChibc+I+1lhXXjUAgzamHa/rL31nF1A2kj59QYIB90G8M4xdaN3AuYGMDIo1
	NIDXwxqAawjuSdjikCZQukaHU3PL2OTMNuCxoJFOKkZMmnFBiIcZiSEfIqIcOHJGcjHbC2rLkzF
	Dskd2tebSFV/Nd2M7s7/YEO7K+8GitAr1jbCHguueLdnSSI2ExNYi1vmxVExNsALKYXp2MAuKUW
	6fRx3CH7w4Yl7q1EiOWt/NSj0s9pJ7eFpiNdR2iuocCV95b31oarz/YHmonAbrGk40jhdtz2xT1
	SheN3i7ByQJ+pNAl7wKUj1CmwTgTgTtHziIUAcvIZDg8zbzDr1m2Y7IA==
X-Received: by 2002:a05:6808:c1e9:b0:467:27d2:96a7 with SMTP id 5614622812f47-46ef904d90cmr7160976b6e.15.1775504657504;
        Mon, 06 Apr 2026 12:44:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d8d109b69sm8523209b6e.0.2026.04.06.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Add tests for unaligned syscall ctx accesses
Date: Mon,  6 Apr 2026 21:44:00 +0200
Message-ID: <20260406194403.1649608-7-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4449; h=from:subject; bh=wQrjZrw9/mrdayJSQsNWrwuSWWYAntM/yonGUlu09ko=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD9u0R+uDhVYdf5/lyV/jE5K6jPmFsorBq0d8fott1Hl+ SB/uKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESEyhn+pzc7vdy3aNV/vaPn721lqq 44Znz1bEq7Q1P+z4j+nMfb6xn+cOZf/q9l/+zas+CWIu67Og83yly2Fj0ozHbwxNbMteuWMwAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add coverage for unaligned access with fixed offsets and variable
offsets, and through helpers or kfuncs.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 6e683dd8002a..887cd07ed885 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -320,6 +320,30 @@ int syscall_ctx_fixed_off_read(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: unaligned read ctx with fixed offset")
+__success
+int syscall_ctx_unaligned_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+	volatile __u32 val;
+
+	val = *(__u32 *)(p + 2);
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: unaligned write ctx with fixed offset")
+__success
+int syscall_ctx_unaligned_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	*(__u32 *)(p + 2) = 0;
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: read ctx with variable offset")
 __success
@@ -350,6 +374,38 @@ int syscall_ctx_var_off_write(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: unaligned read ctx with variable offset")
+__success
+int syscall_ctx_unaligned_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+	volatile __u32 val;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: unaligned write ctx with variable offset")
+__success
+int syscall_ctx_unaligned_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	*(__u32 *)p = 0;
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: reject negative variable offset ctx access")
 __failure __msg("min value is negative")
@@ -398,6 +454,28 @@ int syscall_ctx_helper_fixed_off_write(void *ctx)
 	return bpf_probe_read_kernel(p, 4, 0);
 }
 
+SEC("?syscall")
+__description("syscall: helper unaligned read ctx with fixed offset")
+__success
+int syscall_ctx_helper_unaligned_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper unaligned write ctx with fixed offset")
+__success
+int syscall_ctx_helper_unaligned_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
 SEC("?syscall")
 __description("syscall: helper read ctx with variable offset")
 __success
@@ -424,6 +502,34 @@ int syscall_ctx_helper_var_off_write(void *ctx)
 	return bpf_probe_read_kernel(p, 4, 0);
 }
 
+SEC("?syscall")
+__description("syscall: helper unaligned read ctx with variable offset")
+__success
+int syscall_ctx_helper_unaligned_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper unaligned write ctx with variable offset")
+__success
+int syscall_ctx_helper_unaligned_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
 SEC("?syscall")
 __description("syscall: helper read zero-sized ctx access")
 __success
@@ -466,6 +572,33 @@ int syscall_ctx_kfunc_var_off(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: kfunc unaligned access ctx with fixed offset")
+__success
+int syscall_ctx_kfunc_unaligned_fixed_off(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: kfunc unaligned access ctx with variable offset")
+__success
+int syscall_ctx_kfunc_unaligned_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: kfunc access zero-sized ctx")
 __success
-- 
2.52.0


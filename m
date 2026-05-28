Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4C31AF24
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946024; cv=none; b=o+NR5dtZQ0UKB77YYzMk7mNvSVVdY6nf2AVw/AfMokA0uJNxH8Y5mJWM4xZXeNqazdtQ4d+G//OYhPF5eeS0vgGcjYaBqUCY2OkYFfAJ7NuwKUeolue1hka0pa1bTJ9viUzJdkj1loWCYXEoR0D9tid1RwIKHjnyCjj63i+8l24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946024; c=relaxed/simple;
	bh=BME0mcse/2cL4aD8NNnE58IwHey6vdaf0KgJLaRCaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCH1IphhnsD5fygkaluovs/Mi7/B064ngVIWbvN4D60hUJS0QP1irIcj6+mYa9fYDxyApL8TnHf7u/gjM462jmVqKCwHW3BkCVwKIPWsDEM+CzVKo8lrmj3D1+/8K7V+odedPONC1qGJGzjI5az0N0hVDQpfq4lUiYxYi+OiTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDZe9qnK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDZe9qnK"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso5122893a12.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946020; x=1780550820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCcNiDXdQEqR3ER2Fj1mnGxx4mfjr4kOZtzyjsTx4OA=;
        b=DDZe9qnK0GECMHdXkYoqi6a3ROOX0tSFkZjkUKNZGWE4qPqGsJ4unSJrXdubeb2o63
         Us/AIm4SBea0XQFfEso3Jh8oBTnhKduIIKJlDvNcPK+oJonPh5PEWzaQezkes2k5u7MV
         9cRkCXMCUgpcXAExSS5KK3G7ZruhwLi7N9lzZwToTLKswh/HG/CC3+MlPBo/AsItsJeI
         kfHiT69G8BTEneoQCFfWTcjZ5+YImlVMYIjh0qWmyiWm4ZPjOxw41so3djP9jCbnjfjh
         wmQqqAgNEhso91zC1YlDkoHc6cpj2C9wuhv0ftMA+lJPDOtnHbjvnQz1+cH6nh8rh/3u
         TS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946020; x=1780550820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCcNiDXdQEqR3ER2Fj1mnGxx4mfjr4kOZtzyjsTx4OA=;
        b=Fzu/AtrdjXm0IUmAr7W66mOorwq8UBwZzGdjgGRELOd7e8HMvZ6OnIo5/rigmKisYk
         4WqZriQ5OiOBs8C3cL5O3fviIIikBSZk7Q+lwWlCHTdEswK908zE0bzkXdCqIjydaS5x
         RtcUHoDe40tFOCf89gOTY3+yHENDENjxy8M+v9KZwxUGie6zaoX7HN/oXxdRhaw7UJmD
         AP2RmIhbnaMxPT7X6GLFYAFjiAc2PDqSQ3nOwsRfSdQOBSkLlDIlL6l+ZiHHxdeaRKoQ
         RvBywKKbXBYaDemM8OnalwamFn6uqU5qj/1/e6Is8lPV0O7RM8aDQWDN6HvMamq4NZfy
         rMmg==
X-Forwarded-Encrypted: i=1; AFNElJ/MX5n2xuXJ+rlpvzxRVpjtmdMAq1ZG5PN9Ril6r/EUj+p9VZhin2lCtPzIq/9LqqTcdes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIy9ulLYTVy0s49bJmWl1QtaInz+3ctEeIPwReGkTBr5C4YD3h
	pe4PP52mpKj1UbDNTLH4bnxNaN20AQLApoRAFv4gwCBNLRk2ldfSlD7A
X-Gm-Gg: Acq92OHuKjssox9Qigl9XC+QO4HHT2/didiHtp91p2EzBeva+6CYUaPXHF6lKk5ZIt5
	P24S/zf08MY6ybdTN5IJkQIKTkY679yMjVJIJefvb+BK8KiHua/VZD+wnJBaAwQYn04x41XSFlI
	gQxMuBVp57xhlcmYHOWg2pj0XKw8bEJQ6ardpIm85Gv3c+PZ8IDjNGPqKBQmyE2JXywiJZHFof+
	ao3AySNM/sDcQiUU9W7UlgQjt8vBhdanCtrBfvwQDOJThEw+8xIAK5EleP08mqRycueHQKX2JiC
	3Ed29eD2HyPZ1lXFVKeSOKb3+SaaxbVruMOPPMT2HhPxZXkhfmK4CNUzxBBugi135iCLXoak/16
	YCaUJ+FT6nIBO6Lg0v55CLds94xjj6JN7QLpH/aYoJAcyMEPbnD336wka/scCKR8eFFEyPE5mKa
	2UzeZRC1u8JzE85Lt3ho1LASniHRrTYE19oZi/ouLEjP/8Ut1r4pR8Ig==
X-Received: by 2002:a17:903:1b28:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2beb05d366amr303009205ad.26.1779946020423;
        Wed, 27 May 2026 22:27:00 -0700 (PDT)
Received: from foxirain.tailf10b76.ts.net ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c7046sm172642695ad.57.2026.05.27.22.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:26:59 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH v2 1/1] bpf: reject overlarge global subprog argument sizes
Date: Thu, 28 May 2026 14:25:33 +0900
Message-ID: <20260528052533.3940181-2-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528052533.3940181-1-hataegu0826@gmail.com>
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
 <20260528052533.3940181-1-hataegu0826@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram argument checking derives generic pointer sizes from BTF
and passes the resolved size to check_mem_reg() as a u32. The access-size
validation path then uses a signed int, and stack pointers negate the value
before calling check_helper_mem_access().

This creates a wrap when BTF describes a pointee size larger than S32_MAX.
For example, a global subprogram argument of type:

  int (*p)[0x3fffffff]

has a BTF-resolved pointee size of 0xfffffffc bytes. At a call site the
caller can pass a pointer to a 4-byte stack slot at fp-4. The current
PTR_TO_STACK path computes:

  size = -(int)mem_size

so 0xfffffffc becomes -4 as a signed int and the negation validates only
a 4-byte stack range. That range is covered by the caller's stack slot,
so the call is accepted.

The callee is then verified independently with R1 as PTR_TO_MEM and
mem_size 0xfffffffc. A small instruction such as:

  r0 = *(u32 *)(r1 + 4)

is accepted as being inside that BTF-described memory region. At run time,
however, the actual argument value is still fp-4, so r1 + 4 addresses fp+0,
outside the 4-byte object that the caller provided.

Reject sizes that cannot be represented by the verifier's signed
access-size API before the stack-specific negation. Add a verifier
regression test for the oversized BTF argument.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
---
 kernel/bpf/verifier.c                           |  5 +++++
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..caa5a6323810 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7107,6 +7107,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	struct bpf_reg_state saved_reg;
 	int err;
 
+	if (mem_size > S32_MAX) {
+		verbose(env, "R%d memory size %u is too large\n", regno, mem_size);
+		return -EACCES;
+	}
+
 	if (bpf_register_is_null(reg))
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff7532e..0ff8f85b4d46 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
 	return subprog_user_anon_mem(&t);
 }
 
+__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
+{
+	return p ? (*p)[1] : 0;
+}
+
+SEC("?tracepoint")
+__failure __log_level(2)
+__msg("R1 memory size 4294967292 is too large")
+int anon_user_mem_huge_size_invalid(void *ctx)
+{
+	int (*p)[0x3fffffff];
+	int tiny = 42;
+
+	p = (void *)&tiny;
+	return subprog_user_anon_mem_huge(p) + tiny;
+}
+
 __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
 {
 	return (*p1) * (*p2); /* good, no need for NULL checks */
-- 
2.43.0


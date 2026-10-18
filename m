Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F33BFE3E
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 04:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297328; cv=none; b=HR3US8FBE7c7QVu+a0PklbdixwsJ4+p0/3iYCWnfwcJesfosIvkf2ApsAMBFbK5XY0R5OU8AWMnYdlGBwOXfMKDRiQKVOrj3D1/E+rh/rMcG4Yxk0h4KXxuoP1nf3CnwPeuPKZGrxAp7bEgbl6NFvPJaFgPBwu9YK142SE2RXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297328; c=relaxed/simple;
	bh=1WTEq8XDn5lZJt8MvaFJTmJDSDYONR3DmalFi1vhOFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoJIl5/GEDn8NNhWFzfD3t2dPq3r3leW2zXcTIw6UQIr5WzfE9Pv6EkxFkUdg8UGV7xSg9M8WcXbNLKJE0iuaR3Bo1i/WkQRD8uhfHhOxEjWZEgbDiLseuzaQrAN1PveZnOM+KND7oakhNz7vR0edaJZTOXFmh9OHV9bwyyEpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuKihxCf; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuKihxCf"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso341044a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297326; x=1792902126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/LDrqDBR4YF4jx3Glhm4GDi471ougI+ZECXiqokwPJY=;
        b=SuKihxCfIQywq/PsnV6gU89D3HYuor5UMMAtaA+jInzLuzx6/ybmlt/dMhVYJRN51i
         kzbDmFFEbepi9+eNRZrOdXoPeA3djbWgVGJPwtTHE5k9jgPNLKOtfcqFIGiSVwg1SFFq
         EKzSn/ZO4J9oAtHugTd2yJFt2FT7dznZSb9DoPOEsh8UsWOEbdQcldSv1o2ZR31Oo/em
         jIMoO8s8RCEIOEayCEnFYqNpIxSGWMrGtQqLlx+Y1d57VFX8oGBHvbxGPuDeIwe/iEaf
         0P3E6ieLIFHQq8PKAQR1Bjj0KEnFSTLBnqapyCcK25DYrcigvTi3OwMZypXaO+h6NfXc
         FMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297326; x=1792902126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LDrqDBR4YF4jx3Glhm4GDi471ougI+ZECXiqokwPJY=;
        b=cnrsQBWmMQtcDTvOzkL4cd9p5fIAWQWCqekz3GZRyJvfYdGBdeoqEfEvBUKwRgVQBy
         o85e1+rvZw3Iy1VKuDtZKjLej4NxcHNfpKXMAOy/eLhaTlK+xzjiYWpRp9QTo9eKMhhI
         5Kh/+RlDJmCmJK6JT0rU/YSm5Ndk3RdDZoNuhnZiDAx7VylPguwWAAa9l4Wxj598ys80
         c0PbA5wvGqy0kofwvLtbUsWbjTQlK0/1lt20vmDkxOGBmtH+Q/5PxX25R/0ZKFgOpY2F
         bd6U3kI6wLK+MZt0fiaAkkuYeYbJrwXDBCUyPN73EoGUJ1c1Zdynzx3UUvOJEHE1znp+
         d/7Q==
X-Gm-Message-State: AFq9FYLTlIKGEfaKc2OyAvQWMq2Yt74kze4VVZHV2mzthc2Bf5DzTs2H
	fTjYxX0h71kDDZLyOhi5gwcmm0iB0qnLCeayO73izyipYPTzh4mCIwCS
X-Gm-Gg: AYBFou2XcOoivNDoka4WVkkaIYTV9lsIDpZKdRIiUJzlsY92TS0MnBkcY7sl06N0E1O
	WnXVp7hScLSup1i5nue801qbRX9RPk7mSUP3rUsdVTgi7QA0xQ9qDJso1nPmdHuiJ88i3oj+TfX
	C6hSsGn0W6emFXKsJqaexZH/NqfXXXQSj0cuJSjuJnTqTGQwQGdhJaSjECPCTh+MZWO1A0GFXh/
	hEFX0Uwl9L30Ydt7u0VoLH6+P2xYBNuFroVy3ra8s8767gKLbVUFtLEru+RGl0T9flpPMg01CX1
	RnrpkOUaAyRgRnzukoGcJkDPXjyBeN2L4RWWFJ0QOEEd/d4kIwkjyS1hqDmVK8+p1jZRYoe64oR
	Hbo8+z2eugBRx/0ekM8fDMEIgB8oLsBEkCsH1V0Saf6BRC/Cundl8KK5Mu5BY9vs4bcPu4O2cKj
	imT2eHDIvyGv0Kj3yDDgbIrzk+Krc9ricVaMpI4ARh8VT65AWXAtIIUQWHgSgHUy7zFLl3J22h
X-Received: by 2002:a17:90b:2d86:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3aceefbf369mr3429642a91.23.1792297326333;
        Sat, 17 Oct 2026 21:22:06 -0700 (PDT)
Received: from [127.0.1.1] ([123.109.188.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8758efsm24799195ad.55.2026.10.17.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:22:05 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Sun, 18 Oct 2026 13:21:42 +0900
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test out-of-range index bits in
 bpf_get_func_arg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-get-func-arg-v2-2-048848b3eddf@gmail.com>
References: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
In-Reply-To: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.14.2

The inlined expansion of bpf_get_func_arg() bounds-checks only the low 32
bits of the index, so a helper prototype that keeps the upper bits of the
index is needed to reach it.

Add check_wide_index() and call it from the fexit and tp_btf tests. It
drives the helper with indices that have upper bits set and with indices
whose low 32 bits are out of range, and it checks that the destination is
left untouched when the helper reports -EINVAL. Without the previous patch
the wide index is shifted as 64-bit and the load uses an address far
outside the context.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Assisted-by: LLM
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 .../selftests/bpf/progs/get_func_args_test.c       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 1bf47f64d0967a3543739841201b58b14b4036a7..9b0beb58d88d5bcf1a36a0598695fd02a2cebbcf 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -6,6 +6,40 @@
 
 char _license[] SEC("license") = "GPL";
 
+/* Keep the upper index bits: the inlined expansion must truncate them. */
+static long (*bpf_get_func_arg_wide)(void *ctx, __u64 n, __u64 *value) =
+	(void *)BPF_FUNC_get_func_arg;
+
+/* Both traced functions are called with arguments 2 and 3. */
+static __always_inline int check_wide_index(void *ctx)
+{
+	__u64 a = 0, z = 0xdeadbeefdeadbeefULL;
+	__s64 err;
+	int ok = 1;
+
+	/* The index is truncated to u32, so these select arguments 0 and 1. */
+	err = bpf_get_func_arg_wide(ctx, 1ULL << 32, &a);
+	ok &= err == 0 && ((int)a == 2);
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 1, &a);
+	ok &= err == 0 && a == 3;
+	err = bpf_get_func_arg_wide(ctx, 1ULL << 59, &a);
+	ok &= err == 0 && ((int)a == 2);
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 1, &a);
+	ok &= err == 0 && a == 3;
+
+	/* Out of range: -EINVAL and no store into the destination. */
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 2, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 0xffffffffULL, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 2, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 0xffffffffULL, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+
+	return ok;
+}
+
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(test1)
@@ -63,6 +97,7 @@ int BPF_PROG(test2)
 	/* return value */
 	err = bpf_get_func_ret(ctx, &ret);
 	test2_result &= err == 0 && ret == 5;
+	test2_result &= check_wide_index(ctx);
 	return 0;
 }
 
@@ -162,6 +197,7 @@ int BPF_PROG(tp_test2)
 	/* not valid argument */
 	err = bpf_get_func_arg(ctx, 2, &z);
 	test6_result &= err == -EINVAL;
+	test6_result &= check_wide_index(ctx);
 
 	return 0;
 }

-- 
2.47.3


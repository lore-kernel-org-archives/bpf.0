Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A83330B0E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505364; cv=none; b=tmdI7P68N0z862lo1kltVTMxBJJLS7ZgJ/U/Z2Z0GPJLaUnEEwvhXVbT7Ah0v3wW73y80agILxeNTvP9sAxg6udH2hrzDLySolEekBFFBr4Mz8KbLcYb3iTiilHV1xT94+3i8JgwlUeDLbiDI+ZYatPzHpb8oMkZ9LrDLMb/nMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505364; c=relaxed/simple;
	bh=wlEB4C0G8iL1zL5QqV1RDLM5AXvGH7Ul86u3lxq4Gwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQCWvuKg+gpvEujr/VUxbmVF+u3oaYR9Y0bTAIY9g2BU67FfRj0QHVr4jebctN4S45DQO182LdQbI3vBNwrBsMuQYcFhlUVm03zjebz6FZvgheG6Yh7AXsUnfExnVSSHVx63tViw38Mt1JA+6T+cwLDn1HjQxmglzUeq1vK+w5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz4/bgCO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz4/bgCO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-853c947bfefso566670b3a.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788505362; x=1789110162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6cTYhMb2zRw6Y8e+XQksOjoym37tvoa/7IkI38NMAM=;
        b=hz4/bgCO3dpaJ5Fa4zGb0WoHQQ/S4WkM9SYHT6FSYZ5UciqQJcGpPa/99JD6mw5JHb
         /FqV+fY1dhoYZ1u4+hPw1jeqlCUCftxSW8oHrrSsoiF89Qh8l7pZP8g0YdoG6ofYckTm
         KKZvtFHvuIJlfwgss6xXdIqsfV6FMb0u8CGeRjMdG8IgLyfqcy/q1NnImT0z8sRqcqcS
         Nd6uBAc1UUJFLQGMPL8tQ6Cy0qamnnl6d6pkW0l6vvWmoSBko5OfnTtT0hcnF88hcNJn
         PKDkB0sF0VTLJ2KgPN4Wbbc0DyxLznh0h0JQM1C5nybSgpcsA6rfu9y3LBkgKonuLJ2a
         yXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505362; x=1789110162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6cTYhMb2zRw6Y8e+XQksOjoym37tvoa/7IkI38NMAM=;
        b=Q2n6yopQU0UBFiCaMlynPXFkII2Q4LGAecUuG4K2ngr5vlc4VUcKePEdPBt1mAVdJ4
         esUUEORBYRi3QtNTzIimi7HVu7cPxwMMvHPB0AqPsZexO3580I3xtJaykIRxiYNdO1H5
         ZwElsSSkpd4Zm0fDUH4uakcvkxziUXzylmF80312IxEFHoh0BcF2Eewf4Ufiu7xQ0r8N
         u7ScRLCZ9K/KNFbThfFRUrw7WJgOovVEK00xgPdYZmI+i9XGuJwRJGcnyg69y96dWolo
         1uFppA2/+GcdZG+IG8q/UONLsgj5bEA+uLBwSJdcqt+fmcn6tEhzNpfwHwG61v8YPECS
         MwhA==
X-Gm-Message-State: AFuF++mrsZCRLsihuNtA9m9WkPmWoiLz4pU/mDscRcBCFU45CMU8zBQv
	4KJwRjGCoZxF4YEamiAXcU6wQXVcU9PbENR7FwQ5/8LOisrry7WfI8c=
X-Gm-Gg: AYBFou2lyJ6H63gcfPpG0NkBTB4I16Dlibw0LmlH4kvhRQ1ncXsENyZ7p9V8+lxSfNk
	htIiOu2Gop38lrhxReCAnxEfuwgEtHgR1nMAklrabKTgYPIoZb44N3AVYPQiEWAJP4pmOqO9P/i
	1jzYsGSGKybtn2wfT/OURM2gEAQ2+ZqSHwFcVrB+hwVI7kUNGtepYZOQUKpiNMYmc4RjNXKuy1+
	M1UZDNDPDd7n4l5aP+DfV6H+qPR7lNoBclAejR/Bxne9VKCE/Hl1p6ej/AY/gjI0BXlKjqaFVUY
	nR5fy4YIKZ5N0pxTTUYzxGtEAQAoaIu/JZI1EnYw+wMBUv2XsriuUtfBQizXtCnMtw1eWoz27Ur
	bDcZZoV8DUyNldMLfFCZqPAcrfwWjufVjHg9LulbM0sNo7h9GjRhZ6861K/a/PYmHU2jRq21po1
	kmz22GQHCIGSlAXQO7VgTXfCdSwUgtLVjbtWrgTVenRN63lTS9aWLqKdfFFr7GNoRqq2KctTH59
	yDrLAr/fxk7vA==
X-Received: by 2002:a05:6a00:3d51:b0:857:72f8:dca7 with SMTP id d2e1a72fcca58-8619c8845f8mr2621172b3a.13.1788505362292;
        Fri, 04 Sep 2026 00:02:42 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615273e3a0sm755511b3a.23.2026.09.04.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:02:41 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xu Kuohai <xukuohai@huawei.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: cover the exception callback using its own BPF stack
Date: Fri,  4 Sep 2026 16:02:10 +0900
Message-ID: <20260904070210.4163193-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070210.4163193-1-donggeunyoo.kernel@gmail.com>
References: <20260904070210.4163193-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing exception tests do not reach a callback that materializes
BPF_REG_FP into a register. They either throw from the main program,
where BPF_REG_FP already holds the value the callback needs, or use a
callback whose only stack accesses are frame pointer relative, which the
arm64 JIT rewrites to be stack pointer relative.

Add a test that throws from a subprogram using its own BPF stack, with a
callback that hands the address of a local variable to
bpf_probe_read_kernel(). The helper and the callback have to name the
same slot for the value read back to be the one the helper stored.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  1 +
 .../testing/selftests/bpf/progs/exceptions.c  | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 3588d6f97fd4..639866ce09a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -55,6 +55,7 @@ static void test_exceptions_success(void)
 	RUN_SUCCESS(exception_ext, 0);
 	RUN_SUCCESS(exception_ext_mod_cb_runtime, 35);
 	RUN_SUCCESS(exception_throw_subprog, 1);
+	RUN_SUCCESS(exception_throw_subprog_stack_cb, 0x1234);
 	RUN_SUCCESS(exception_assert_nz_gfunc, 1);
 	RUN_SUCCESS(exception_assert_zero_gfunc, 1);
 	RUN_SUCCESS(exception_assert_neg_gfunc, 1);
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index c8d716fbd419..cac4e082139a 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -212,6 +212,35 @@ int exception_throw_subprog(struct __sk_buff *ctx)
 	return 0;
 }
 
+__u64 exception_cb_stack_src = 0x1234;
+
+/* The address handed to the helper has to be this callback's own stack
+ * slot, not one from a frame that is already gone.
+ */
+__noinline int exception_cb_stack(u64 cookie)
+{
+	volatile __u64 val = 0xdead;
+
+	bpf_probe_read_kernel((void *)&val, sizeof(val), &exception_cb_stack_src);
+	return val;
+}
+
+/* Throws from a subprogram that has a stack of its own. */
+__noinline static int throwing_subprog_stack(struct __sk_buff *ctx)
+{
+	volatile __u64 pad[4] = {};
+
+	bpf_throw(pad[0]);
+	return 0;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_stack)
+int exception_throw_subprog_stack_cb(struct __sk_buff *ctx)
+{
+	return throwing_subprog_stack(ctx);
+}
+
 __noinline int assert_nz_gfunc(u64 c)
 {
 	volatile u64 cookie = c;
-- 
2.53.0


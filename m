Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523227FD5D
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089232; cv=none; b=i1wnJf+qzKnhKiZDVfZHeRirKvFw3/sSfVayC7SsqJmJWO+H8zWk5iBFDt5tJOW3MDrf4r2KTkvUOpNdjxaRcDdI/H/mUa2bRxx/gZ5LcYmTQQrZeNZvI/UCBsm++eNBglDlMtPl+XJpVHQruW4vtBdT1Mpnb1u+iMqiRmSzGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089232; c=relaxed/simple;
	bh=triRoJFAO9QGmTQRAWS+cLWW1nI1iOFeYJbdtBXZxJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVtiBP9igQbpLOocpm91j4sTQlnAPCIP8XI489ohAGo+G/Oe3EZo9weDa7D4uzjoPHAL506Fdf3hcIHHz+ZPFdMJSToJciFGduf3yD7PeClB0R1H0lDWL44pZQpULiIH+hEEpUDNqDYyFQgiWnG72m4oMUFr7CwQY+LRfqe3e/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0YG1Bys; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0YG1Bys"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9f316d68so2249345ad.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772089230; x=1772694030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkyUhk8dgF38d8q1EBE3loZO3CJfZ89yev/FRmDZYJk=;
        b=k0YG1Bys50Ldcb13zYGEpaCUNlY0yfTFwKqjVaHlqLtTV0UsQm0KjbPVJJeJJU3/Z4
         9DUbdtSBbtTOKqUz2okiaM7QIXN28OW66gSuYoQxSUIvUUSa53KpyaKC6PKYW8Z9zqlJ
         B4oogMg+gHtQmBWfvSgZ62JApqXwVvLfOIHC7mwb/uUhFCWzgBQnFLME63iD39FdJuWu
         JvvquZsaeVdPxbAwGZaMQJ/TokISwu1StihQaIDA7WqmtoeMCVs4uRUIZlGRL1CHnaMM
         nAWtNn9M1APieFyrkEeTAD/KMqE0vOD2byb0CsdNaiJVuulDcpzLvgQSdYdWJriZ1BIc
         oIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089230; x=1772694030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkyUhk8dgF38d8q1EBE3loZO3CJfZ89yev/FRmDZYJk=;
        b=Fzu56ZCTCiiHc811Gdkerfge8nP7EW+Ck7RKkypxiZDjItec7jpxzXkE731XckQ7le
         HCwrm4tn8CbGYw+uhvoomQxyPyFwR2iqmcErdJH5t1o85NGT2svLLEkomXfJimX1WDm8
         D2hJ+WMqMBTK+1YiH5WVcHRyC1as/iNqdkcHtjg3KRVUF2V9elkTm3UhvRTR4IpAy3RJ
         vh8/0ChiZ223AdZdkbzJ7wx/cWWgYipBRqF6p+rMka11HfVvarDSH8+BjUkrMfpGMwzl
         c6b6lewsVpCXWOoOSvzFEgcrnFh1BSwgHzledI800BO6QHJTKh/Rg2dR3g6lzCy1qGRj
         nGLA==
X-Forwarded-Encrypted: i=1; AJvYcCVgBF4e4cBNO9gZUqQGwANTz8weuNYclygBJzRfpspHrrDJjnK5ZcA7qoRo29CsdkFh5dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMcdjJk2lXPJ1TlC3ZQuxW6LeK0YyQfyWRQa6/bXxNM697hyS
	TnNGhhV+FE0+OnkTfCb2WodyYtq4iThIynY1+0yoW9t0UbehebFcm+/w
X-Gm-Gg: ATEYQzxoyYNg9x0/HycKTlwbQVmFgG2tU2cUUaNANrJ8kfgqrDRfH+SjYd+s8KRik3Z
	rhxaWclWxXC+a8dvFXnjD5dOtjpERZgL6TH1kMlunM+lt5Ke1co3Z/TFcORtWt24B1i/NJ1d1ys
	LT6hyDaXpMooMm06BYZHv8ZjSHDeDlb6YI0kfQNqwO+7+GwugSg44viNeAwgulNwXEyUJ9GWeIv
	JbrTvsLct5/P0FbA8H79vU+gajSmF3aUWuo+ZQdfEjs+K7EE/Ir9ndENEwUAB1M67+5wiXyYN80
	mrlKfKyVVQgVwYHAhpGBTpQERtcbUvZTNj1FZ8AtrtrQkv3OXRX6dX9J9s7BUIJqRBX0A9YLINL
	omnKJn89dTiYbDHV6M15kLksjkRtcuxKkFcAEzK5uwQbZiTX+639aA2thS22HZNgTY/ETXL+tmQ
	GqzCktnDasTHL/aN/PI08gz0kPpU95fcpoI8LIFtbKrqPXMZ1zBFWSjEKu3Akwb1SglYlbJw==
X-Received: by 2002:a17:903:3848:b0:2ad:cede:3a1a with SMTP id d9443c01a7336-2ae03495f6fmr14300495ad.39.1772089230036;
        Wed, 25 Feb 2026 23:00:30 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2adfb5b2296sm14803135ad.5.2026.02.25.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:00:29 -0800 (PST)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 3/3] bpf/selftests: Enable fsession tests for LoongArch
Date: Thu, 26 Feb 2026 06:59:51 +0000
Message-ID: <20260226065952.4082859-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226065952.4082859-1-hengqi.chen@gmail.com>
References: <20260226065952.4082859-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the LoongArch JIT supports BPF_TRACE_FSESSION, allow
the fsession-related tests to run on LoongArch.

    $ ./test_progs -a fsession_test,get_func_args_test,get_func_ip_test
    #136/1   fsession_test/fsession_test:OK
    #136/2   fsession_test/fsession_reattach:OK
    #136/3   fsession_test/fsession_cookie:OK
    #136     fsession_test:OK
    #138     get_func_args_test:OK
    #139     get_func_ip_test:OK
    Summary: 3/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 3 ++-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 075a1180ec26..afb185fdf60c 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,8 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
+    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 45eaa54d1ac7..3816a3616fbe 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,8 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
+    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.43.5


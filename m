Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7213C10B6
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845480; cv=none; b=d8/oYZDFTPgEDCaU1t9YO9ALQLK50Bqg7pvenUilXzU5uVT93TmByuz3KwXmDFJZP6jfbaKZt/IZA696AJASzK2g+gO5dEuCwQnxJ423uuzPAdvNdnW7D6NFjvSjmbySFnx/I3OAv3pgcWPvWmp4IsIDehgXsSlM5WAgh0bzg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845480; c=relaxed/simple;
	bh=GpNY+HnQop03ypd8qo1PhtX13zfevtIKkOCtmq+7pc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM9tDGfU471Tu4f8et6Y6NfRQ68nj1svMcoFQFfJd6cAaQMfYMSIigAHUioJFI3WaJ7ShdgLCEMaUuTdx/xfJGyYv7V/t91UEDhqq69rbEP8U2FJta1S254SEw5XiprrzUJsxHSLKuFhP0ojmNv4SkX9gh4NH7Mn0Y5YYfuQdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbTdqWIp; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbTdqWIp"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so6013375e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845477; x=1787450277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJpj4+Q2ePT6NOpFdiEYCDUaqywZgn2iJS+Zp3Hrk/g=;
        b=LbTdqWIpZTlJffP74gLnBYBiF5dlyWvouDa62l2VyZYI41YwM1jhoDE4kEVp/pypm8
         7Bfvdp/n2CEpRABAVXh+/vn8LpO4qcIS/yjx7CJ9R84n5Ct/JNmWpcIKjVZq4TzoHpGx
         KZUEe8mgcUawF2IzN35oFTSXed4bdyWVCYjuk1efZ/TLL/3/6dt4uWpbA8nI7p6Ln5g5
         beLtT498pgaD3iqASVARcfRdD01Taedxg+snOt7PhBB8Srn31Uxn4WIbiZghGf0ULS09
         JcZwRjvU2GJVWBuokmgnt4nzPIiTRcbLDolNhvgpymYny3vCayNLRPi71AgHY5vafQ4p
         Td6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845477; x=1787450277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJpj4+Q2ePT6NOpFdiEYCDUaqywZgn2iJS+Zp3Hrk/g=;
        b=YdbCDfEAO+csxi4FHox0XxH/NLEHZrQd4jJP6jW0YQNtuVwoSglIfxpDQEjZJf4Mxr
         lVcAm73+NY24FX2cZAjLe5lyrg80DTUdVKrAtyYpJUSAAUNa/7xPWMzwifZRj47mAR0I
         Plxv9AaBYL8qUG38dMC8DWsGASWFhtBpNIR8aRe65/vPFNSsT0z2VLUZZ7i4aqO4vC/a
         PziaK6L7EOWCgSGPHToYQpw0HF84vQEpSdhzaT2CLiUFmYd5vNv+TfTRf8epbBFyybz8
         o5GbCE/EHWY0v5pFrllg6f+WnMlVC3jt92tMCBGzdPE/Y7fm6nPv+TOAuqsBNNHHirrf
         f4kA==
X-Gm-Message-State: AOJu0YwjcyL1Xr77+KQ/LAIFX8hAiIjKcoHl8nielPFJS9eJvP5JHuw6
	6ToJ/1ePW1IBQVjfMR1GHPuTlYMsqLoWTtzfepEdQYa/e/l/HwPpUGJYz8DBX8mz
X-Gm-Gg: AR+sD13SokFOr0sOneHBlh/G8obYIM0z2Gf4HFiTmsM6/8CF0jJ0H/5Fjh3Xx6JQZ3K
	+I0YTFowiwlpC9e66aOOC7jymJmFEQfv3i/ehpMfWFNTVMx+mtI06y6AnvcfBAGrKtZA/zYR3bV
	qlyByyn3SnjLqkmdNwr50aGM8DJYfMcZToOBQqSpuuoCSztf3UI7hv+efR2Frz/kKct7F+EhhQV
	55GwVZ/rKQEW2uGYrNCK+cpKZm/zEbsIgmjVFrrfrv1ltG8WraXzr9RQVj3ybBrvah5cKr5ajYm
	2cXOz8MXpklum5q3uhNEmjJ6lNeIq2YPXZ1tcR7CfbkeHcAfXymodN9Wb6EC89OJsrtpOXW8qxL
	TeLF4WQlQ1rbVA7fM8GN6XJKkCUnxTtGm9lT5YO7voTitZTmG0a7MXxxZD9Sm3av7GykQEcSEOU
	2qYKAdBbwjmSqRdNqXTioGE9C82C/T5iDgeRqLWmg+GOC0uQPjmmcMHJHv9RNDdGiXviI3uqsU+
	/7Y+wl9Ggz/nr9ISdJNZQ3lMHiDMOtFLM4WkOytWSVjQ+P+lHFfG7im9XlR0Plly/SCLgiVhVDC
	nlvCA7cFu3CMrAVA+gjtoNRFYL0=
X-Received: by 2002:a05:600c:1d0e:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-49987941a4amr186099445e9.1.1786845477210;
        Sat, 15 Aug 2026 18:57:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996108141sm3422375e9.6.2026.08.15.18.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/14] selftests/bpf: Test kfunc argument diagnostics
Date: Sun, 16 Aug 2026 03:57:35 +0200
Message-ID: <20260816015746.2632990-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2792; i=memxor@gmail.com; h=from:subject; bh=GpNY+HnQop03ypd8qo1PhtX13zfevtIKkOCtmq+7pc4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQkzh3c6fXElvf1YGu3xJl9jnWrreZLpnpwfPjrVnp GOnTFPsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETWqTP8L7fIMdRKiGvNq2vI nMqlXaIYdH2f/ROeD47GE4v7me7vZvifsrvt7dIW2+meXHtPLzp0yW122e1JPtx/k/p6RHdJhe5 kAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Extend existing negative kfunc programs to assert that BTF void is rendered
as void and that variable __szk arguments receive a structured constant-size
diagnostic.

Also pass a context pointer to bpf_refcount_acquire() and verify that the
report describes the generic refcounted-object contract and the actual
argument type. Retain the legacy verbose-message assertions.

Link: https://lore.kernel.org/bpf/3eda33675965763aa9b2e6a5784f32b34a6a83988a55fbea98b0dbd0cf3b088d@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 2 ++
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 72aa6b5a877b..9418dfe4d7b7 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1593,6 +1593,7 @@ __u32 hdr_size = sizeof(struct ethhdr);
 /* Can't pass in variable-sized len to bpf_dynptr_slice */
 SEC("?tc")
 __failure __msg("must be a known constant")
+__msg("requires this memory size to be a verifier-known constant")
 int dynptr_slice_var_len1(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
@@ -1612,6 +1613,7 @@ int dynptr_slice_var_len1(struct __sk_buff *skb)
 /* Can't pass in variable-sized len to bpf_dynptr_slice */
 SEC("?tc")
 __failure __msg("must be a known constant")
+__msg("requires this memory size to be a verifier-known constant")
 int dynptr_slice_var_len2(struct __sk_buff *skb)
 {
 	char buffer[sizeof(struct ethhdr)] = {};
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 024ef2aae200..eaaed0859f94 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -63,6 +63,7 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 
 SEC("?tc")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
+__msg("requires a non-NULL value of type (void *)")
 long refcount_acquire_maybe_null(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -80,6 +81,14 @@ long refcount_acquire_maybe_null(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("R1 is neither owning or non-owning ref")
+__msg("expects a pointer to a BPF-managed refcounted object, but R1 is a context pointer")
+long refcount_acquire_non_object(void *ctx)
+{
+	return bpf_refcount_acquire(ctx) != NULL;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.53.0


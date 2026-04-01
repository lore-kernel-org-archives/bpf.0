Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9813F8DE5
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046519; cv=none; b=rvZh8d7NFww1a2LDjk8VDQ7ICj59fX6I+OCX4lN765CMg21VeVa9ajvG4Chy5s3bhgq7fgMQoJ+677sbpgCfhR2CHLo2LNCUtBAZWt6EJePUcwt87JNK6z4qDKcr7jmnPoLb2h7b1L4+jcH0Qoq8QoBSk2pEm/Wr1+BHs4WURbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046519; c=relaxed/simple;
	bh=G6Ux+kZ5wt9RB0R4H8XR6ugaYA2f0xFIJeh9qr12lrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTxMxveX5SWespqY8bGNI3Swrt/c1UeR8R6ISZZpjbhqNGskAlbfcFlDqMxmJwNYLCpeZioZQW633doBjNEMYPJRCp5Rq81gfo0XhGHIIglN4dmqAiaooTExZvGVGuxpuX6Y5CK8LnrmVKUzqhmRfuXto48+cJ8T5Xm19leiiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKsuxn3v; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKsuxn3v"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d91f82d819so6795005a34.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046517; x=1775651317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ+TIdvDOATxi3fjOeTspzqyh6/mAfXgF4jV6F4HyZY=;
        b=AKsuxn3vC6WGiTp8sjnhA44enejdXe9wQ0JWJl3AZF87e95jEtlEXLh3gqi6SGAJtd
         fUs6NxiO+lWpdtKZf/lrD3P39UGY52L35UQaGTnITdcVseVDkonUrsFfNvEhbYSygDig
         iI+p6uDXnzbXZVdEvlX7gbJhzxFqSG+BXLU9jcxSLEgy0IbaQA2D3GgfhwmFsRSfgsQs
         bsAZ15dEmYlXdEdzCpNL8eTh1xuGhLPMbbtIJhDhV8VUXHk7ECX5Phic8FCIpFK3WBut
         DReiymTrnIDPeEuGhFTKAWroPqyy13hKQaDV6PMRY4Y6XqrldHePjGK/wi8nbZlRVvDP
         tulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046517; x=1775651317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZ+TIdvDOATxi3fjOeTspzqyh6/mAfXgF4jV6F4HyZY=;
        b=qzDI0NTfiZeA6H3AOhSKL6kjJkYQ7DUBg4x6m2o7vvxR81FSYfetEKn3BaQQKPGf4c
         D7HW251TC/KQ64jDptSl3jZ8YvicIRJBSpvqGe/XVwVfK0k+O9wqWqx1H1+z6hv1NbTs
         ZKkbnAvXEe085XPw+rZHuRWcr4j/h/lXkaAuuITvb69v+Jt+MH5y4qzvY/KbI9btJaeN
         NkMbo6wth8VXDWEdasR7TG+cBDe/dNR5ZWGiSf3IQb1nHD3yIJWQraGp614Ab/Zw6V0+
         nm2vJFEfR0P+6yQwZADrPLF4eTcb6HY8aJ4si3nVAXtAEPFJxfN7oMWYV1CNNuYzFxFk
         I6mA==
X-Gm-Message-State: AOJu0YzRX+HN3Dz83YGt1ZwIMnpuupVp7bXhe+zQZAbzfK7sElW9tAG9
	FZdtjoRUJWOZSTbpSqYZxRpTY7KlkfrgnDB+XkaTGMAX67gmKh5cetMYn3ix2CL/DF8=
X-Gm-Gg: ATEYQzznIzZtPf104ZsGvbFWnA9TCW6EwtqcVBP6yy2Hxmc9mU+1obZm04TqxOw4eRj
	JhfKWxwb259IyhB+dser/7uNsutULVUA9jsTLodOk2dUn5wG/pSzBY/aAg/5+jwpECbN7j196ZG
	gWXrg+jLtnbcWFLkNvjsqUYrPmUzVuRos2balTTJjpKj/b02ccOBMpBSujDFIegrLAaI/6gF+hp
	EWj4AM/BDcMDNgnzI5MZXqsFfC/i7j/2wliNTnmhw0Eq5CljKEHU8wI6/pY2rdJ0+17p1q9kL8K
	j3z+JCK9a0TAHGZYc2L/T65CYw5xWcaiYLXVLpCYYJiCTaZA0d/TS68sD/W1hh1Ih/xWbKWiIof
	SjL/uIr8sVDmE7o5frsoWDDgRiui6HInvdowOCCUKry4HMI9DeegkMJl1cCyN5Cle9nx/eo6y0Z
	pGZ1OLpp+JjScvLEkYspTJg1MhTjAJqsj3Nwo7q2ZFPvQH
X-Received: by 2002:a05:6830:3116:b0:7d7:cd5a:cf9b with SMTP id 46e09a7af769-7db992294e0mr2284815a34.8.1775046516706;
        Wed, 01 Apr 2026 05:28:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a819880sm10395976a34.22.2026.04.01.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: Add tests for syscall ctx accesses beyond U16_MAX
Date: Wed,  1 Apr 2026 14:28:16 +0200
Message-ID: <20260401122818.2240807-8-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3998; h=from:subject; bh=G6Ux+kZ5wt9RB0R4H8XR6ugaYA2f0xFIJeh9qr12lrA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs372dtq93/tZ//+H9kZ9FOr/qJRZuMePc2p1dmzFxj+jb ac25HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIiQOMDM9+PFC0ajjFFWI/5UK4B9 /6Tu/CZf8eZsqLru+S8n8+8xrDP2MbjR//v/2dvXd59Irvn5dq+j2YKHdT9dvjPbz63dN253AAAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Ensure we reject programs that access beyond the maximum syscall ctx
size, i.e. U16_MAX either through direct accesses or helpers/kfuncs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 887cd07ed885..7856dad3d1f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -406,6 +406,37 @@ int syscall_ctx_unaligned_var_off_write(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: reject ctx access past U16_MAX with fixed offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_u16_max_fixed_off(void *ctx)
+{
+	char *p = ctx;
+	volatile __u32 val;
+
+	p += 65535;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: reject ctx access past U16_MAX with variable offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_u16_max_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+	volatile __u32 val;
+
+	off &= 0xffff;
+	off += 1;
+	p += off;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: reject negative variable offset ctx access")
 __failure __msg("min value is negative")
@@ -530,6 +561,56 @@ int syscall_ctx_helper_unaligned_var_off_write(void *ctx)
 	return bpf_probe_read_kernel(p, 4, 0);
 }
 
+SEC("?syscall")
+__description("syscall: reject helper read ctx past U16_MAX with fixed offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_helper_u16_max_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+
+	p += 65535;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: reject helper write ctx past U16_MAX with fixed offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_helper_u16_max_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	p += 65535;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
+SEC("?syscall")
+__description("syscall: reject helper read ctx past U16_MAX with variable offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_helper_u16_max_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xffff;
+	off += 1;
+	p += off;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: reject helper write ctx past U16_MAX with variable offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_helper_u16_max_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xffff;
+	off += 1;
+	p += off;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
 SEC("?syscall")
 __description("syscall: helper read zero-sized ctx access")
 __success
@@ -599,6 +680,33 @@ int syscall_ctx_kfunc_unaligned_var_off(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: reject kfunc ctx access past U16_MAX with fixed offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_kfunc_u16_max_fixed_off(void *ctx)
+{
+	char *p = ctx;
+
+	p += 65535;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: reject kfunc ctx access past U16_MAX with variable offset")
+__failure __msg("outside of the allowed memory range")
+int syscall_ctx_kfunc_u16_max_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xffff;
+	off += 1;
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


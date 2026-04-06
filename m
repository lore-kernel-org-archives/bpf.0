Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AD3988E3
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504662; cv=none; b=RXKHt+sGEnonusYMTDp25EZ6n3K+48sPmqrtTuo4rarVnzMkXzyEMYP9lhdD8zBnvX+waDI9JYQLp2pCkr9657BS2w5toFTeu6IrKVsIQi3jmqxn9orUbvvY2b6jiCf5hkMFGbwBO93jETILAV1VoBI9kslvGeBWkjH/GcoWRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504662; c=relaxed/simple;
	bh=9ref4488zVLjeG3jxxibpul/B+MbporI4s3J3S4nEaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk8D/KfB8iSBWnSEUbloMyH2+wgOuZ81t24WNZz+S6ItPTQPSotY+rG0XMtf2JoZKvMEGffN6sfLiwi/tzQm/ctij2Vl9g8GG0fp+q1RmWuCMg4HGTEqO3lfPVTFfu60inTPOkwVW4IPFcJVSGIuuFsYHdANO7xZ4CGu5zw3PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TufeqFee; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TufeqFee"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-679f6ee3fb0so1532638eaf.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504660; x=1776109460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVcVT8VLdaRSklEF0taT4D/ZKOPtfVG7jkLbCZMG0ms=;
        b=TufeqFee9kJRuOhN7BXo/ZFrYtT7/n5Za30rDqp2OU89AW/eSIhMMN+IHJXIQhjED7
         KPS/I/1XLhKpZ/QMktH6btJY6rG4JQeDjDyZ/HZt5ZnFDJxIoUIhKxbBOCMY+YNCilAm
         dsyYIrlg7wAHS4mjuwZ+revl3tlatl6sp0+mofx96yUYlPtDZ+dhtxbfJ1qNGN9+h/n5
         wJTXZQEYVw4TysVbAG/W2VclU3vY1UIRhsWKIlnOEvX1bvaMSfJhDBMxI61JRAvSFYQS
         wNl/lONqK6/4b+OxdvqvHGOZ4j0GWLmxUS484cudYxh0ccQd1Lzop2virsFWUDlOmdGm
         dK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504660; x=1776109460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVcVT8VLdaRSklEF0taT4D/ZKOPtfVG7jkLbCZMG0ms=;
        b=M7bzvSnQCTkXIOVcKJf1+riVdN+LtdsH6ley/Kqka68PEPKzq2E8HdeG7WnpDDLJQ8
         W3xkEwHGabjVjko8JveckhiNVjnsGfXWp/XD4Cec+qj9mD6Q5K/ZM3SDsiJEpL7i5Dld
         uBE3oj1BRRZi0iITS8qpK5Fhsun98bBAP3gaeVlg06ySd7QhJqa41gI+w4XbBjLdAlsh
         3P86pALee+smdjmFYqRiLiwuCGZGuD4g1PJxlyALZjzGQ7cOAoo9i7UE7dvKp9OFcvUb
         U3I65QYgKNsIsDXqjHh1AcjqyEDlFsV40Nh6ilxsoHMw4o/wWPD2OwgdcZVAGo3B42g6
         Du3A==
X-Gm-Message-State: AOJu0YzwzRzcqzh0CKPE6CMwbS1BSsdCc/Oh5WGgt6lWCXUoo5qDTanq
	OZz1BuQ2h8N1p/7YAbgiUEvx9TSz0pm4na0CaSbBwl2/PicQEmmwYC20DhKyNo0zdGs=
X-Gm-Gg: AeBDieskUmEt5mZ5z1lgvNcyjk18lx/GDT9kahsKpSTqPjCK2MUjSo5hjXFPc+P5Zkn
	+jjydnWab0gN4u9YWtvoMKXeFig+cB+MnMDKdLWc7OEkNVOfD1QrL4FVIlZA482lakqiIQ4c7vr
	GvZOlnDzRNFMnYDJmBkc6BF4cr4DWQpWoETAWy2bQ+XGZH7KhwFxJYMacHOHeua1aiZ/ysFBHfz
	yzPL/8R4t9i2fqNMUVOHUgU8N+JSLyBfBjTYXJl5bYtAoJQqJoqHbi4mZhwJPSxIY7lSpHw65tH
	Tuu33uGTG/5mlzgOp5iCJJ/Zaqu7vRcEXgk5EQrylR+DaajLJmlk8zrBtODy2KusxRw9mNmEQIa
	ysyQFp71T+U8HuKCtNqAQk/XWWkcq5KTBelairzYGXgmtv2TeXPmcUOZcrPJw3VDJKOKjlfpKjL
	cVBSykv5Wz+Hzpm88o0teB79VBOUalORQE7H1d1/o4lXs=
X-Received: by 2002:a05:6820:a0d:b0:685:9910:eb89 with SMTP id 006d021491bc7-6859910ed27mr3038108eaf.58.1775504659895;
        Mon, 06 Apr 2026 12:44:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42330d4a3c1sm6891440fac.1.2026.04.06.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add tests for syscall ctx accesses beyond U16_MAX
Date: Mon,  6 Apr 2026 21:44:01 +0200
Message-ID: <20260406194403.1649608-8-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; h=from:subject; bh=9ref4488zVLjeG3jxxibpul/B+MbporI4s3J3S4nEaM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD/suQ2n5urOmolnGnjW7ZgfKzT9b7rppoq3pxJJZq1hc V3V2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ9FxkZTmauKnT01P/4iWFL6SQZY9 mpf5VMyzeq7qt5/LDp1zbBpQz/U06UhmQF7paQX2zWlu4mtU9qi4RpxheZ/BzdMzMK/hxjBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Ensure we reject programs that access beyond the maximum syscall ctx
size, i.e. U16_MAX either through direct accesses or helpers/kfuncs.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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


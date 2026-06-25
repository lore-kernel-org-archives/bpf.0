Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770423D1707
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383150; cv=none; b=YCz15fxNzOkeggXbqfB9BYYoHbi0C3cRyp9w4JYPiZvhNbJvz7hzH+/g/SQ1CGnOqYxJojNn7fva9OHJeQjW+8zgIIOLCJ8pGsGhQWApnryfEFxvN3ikOIIiG3MKTHXSJUckZx7Dsc6FR9fjSf66gbiK5pvuvw3trvEDs90YDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383150; c=relaxed/simple;
	bh=3OkZgyiYKFwZQmxhI8N3WUicqCT3HgcTjiK5HYw3yVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDDzE4CsfTWGZPm1ILCPhElZ7PP0hV80Fcw5fDlQxjxSyw8Y0ZNJ3J0s3BZ0clqgl/uVnfsVJbjMNUEnslkypCqtTlURUlHaGaRiohaeNmNV/g6h3UvCzb0PUGcGstdDHZ3xALj5k0bsq44mZhHWeMFpFFZpz39hWHlbyNIqRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUMLaDSS; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUMLaDSS"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-845369f60faso1605803b3a.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383149; x=1782987949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsorTzz+tm9XYLISdfxE2Q0EUcGbGVAxd8Z+bCfU5XA=;
        b=bUMLaDSSyUie0J5dvC8Wvb7A+ATrxrE0ZPi/k3yWtMnfF74uhNjQKYChhqNEQH8zjQ
         9wrTWVmZb1Jdv7c/KL20UoTUJs+n4zt9yUy0h3UI+1EeAcuOshI7QHnBU8XBqMg39jzZ
         041EMkMeD3d760wbiLvjCIwOt1Mean69XRws5DxkbRPKFBYprh7BwBc7v1ETifvp9K83
         Ib44lTzH14qJTifanlhhBc2M4TZCPYznwmcL3Cvf2T50CCDJ1HuWqzKBsMJ51dUEfIui
         9s2RSj+zrkq4trKDfxX1h74B5yvoMmH4MXticSxSxztc1Zt5i6KMiJzANKxOAAziyoLW
         ttLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383149; x=1782987949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsorTzz+tm9XYLISdfxE2Q0EUcGbGVAxd8Z+bCfU5XA=;
        b=iCW55pO+Ic75YEzQ+dx7MORJx4rMvAWnf0pg/El0WsIdH0zPuAkW1IE1+HacOa1ymm
         ajJWKmaTg2OKzvqpw5JbhrjcTDYTWk8S0XgOYeYEKU13/CcKdXam/qP+kw5h0ycbauyT
         JGOQlbSovPCAaGroyepn7q9CroRZeDQyJvkdNF/RnClzdFXqEwwQcPh80QFHRCVL3w3z
         +uXPl1bpO3hhU8Zg/J7BE1K41iCkv9mKt1XoP+k984cVmOpBTeKjZ0a/sh9D+4o79Qe+
         oa/AAFzSb3lCJSa7zXP+nM34xuZX51HMjIVhHl9IlMzPgV5rWMEfMzsTW/9MvQnj2J73
         P8fw==
X-Gm-Message-State: AOJu0YxMEoM1k92yO+hQcTcG1yDgrlXXeZ4CJJb0ukuRvjNY7QHvlyFg
	wvcgSqwYf3OqalBM4QyqLNG6emKbnn6cj8G1V1bFTQs98lF8uvLPBHVe
X-Gm-Gg: AfdE7cmfIUN5Ijg443SCzLNjIRW8ulFFzunxJyPVrcBSJNyaGKY1b1FtxBbzseeQXp5
	dY1FL37yzT7rX6nLSiwk/TVEjMFOMxx/weU0MJaW9jGS4F+4ck/TVHkcqPNf23nZXjDA2lDmLwL
	imquweSrZB65YBLGwecQUPRMyQgDsg0vgxVgRtPIySvro4lgkc0AzO5NlH/cqJpeb8KRofYr2Wt
	coDdKvTvLg2in+00k4OxUpPfmQfYK8um9411+DrbF+mbe6D63XUQrhDsiXF7VONiEuARpJdZHBV
	d4D9hf2FtFxfJWzp/QbW061vz9KmX4HCkK41Mr65AjKNayuml/RNaIHlzTTsDAeOErQzi6e7kDy
	zWRSGvqC3VRgq50Uqql+3Gd6Ulg8QVUugrg1V+uZve4ioYRKxg4NozUcQQ4fOJ+zsh+yLI/JRV9
	YbEeI9JDZPqqo=
X-Received: by 2002:a05:6a00:1784:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-845b3af2035mr2529602b3a.17.1782383148652;
        Thu, 25 Jun 2026 03:25:48 -0700 (PDT)
Received: from [172.30.1.18] ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ba891314sm570708b3a.35.2026.06.25.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:25:48 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Thu, 25 Jun 2026 19:25:38 +0900
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Cover stack reads from zero
 spills
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
References: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5154; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=3OkZgyiYKFwZQmxhI8N3WUicqCT3HgcTjiK5HYw3yVg=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqPQIkb47z2OY27pReai0WVx3mv6SY/6Mdrpp0n
 dwcV5S8fhiJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaj0CJAAKCRBDl0TDFa34
 a15pEACI87iEvcFYQQtkQOLiySBNNRU+VPwTM14ZJRZBHl8dqrC17q7RDGgJ5GaZmHbYaxfFzUo
 AaN6+BcLuhNJjmm9xgviU00PjCu1sSo5v4EuS7hT4J7xSSUJYlPi5AZXsMN73SSMC4EBqGAm7UW
 BDpvi0ra+MisrOVrANmoeA9rQ4jwhEgsuWt6PUFqVZoqCLjaqoRxmKHzJPxzBvOrKEI0kKgZn8t
 14A25X9Sbi52PwZUFRYBcqC6f/Y5ZPsc/T0EJ9ARrJ0Hnf/ZVZO0G27tvz90If8srpsXHYZKGVH
 qgMXQ2JgPs4vIacDxiY/gluKr4qU81+xbqwPaiqG/VKcLob4MzLTnf3iWJZEar6BsRZxX6++aWm
 TbU0cb90gaEs0NOPxHL4oNb9WGYSfTgbIcXjzyoMSgxOngvIQ44ejzXmkk5l7VBI0ssIm7OyVP9
 KlHXsSEZmm0zzjRlsPfg9G8LoFB8tSdzh2UZ+QU9yhdZvh5pqt/X/bHQeAGg4Se8Vg56dWw2AJp
 RVodpPbYqGOo/wzEgRBQZilVtJJET0xj0vYQTH5hQrSWpdTQ+TBsDpBDHR6JROry86wG8qq5B6w
 9JEyPA40eH4OeRCsD8w+3iEXP7XowM0HojzM5BXRIUO94lbBpS/VLbSNZMcEUgUlqryhU02DcQH
 ZNwvhPQlRP4XhVA==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Add verifier_var_off coverage for variable-offset stack reads from spilled
scalar constant zero values.

Cover single-slot and cross-slot spilled zero reads, a sub-8-byte spill
with neighbouring STACK_ZERO bytes, and a sub-8-byte spill with
neighbouring STACK_MISC bytes that must not be treated as zero.

Add verifier_spill_fill coverage for a fixed-offset stack read spanning
both STACK_ZERO bytes and scalar const-zero STACK_SPILL bytes.

Use verifier log assertions to check both the zero result and the precision
backtracking trail.

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c      |  26 +++++
 .../testing/selftests/bpf/progs/verifier_var_off.c | 110 +++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 6bc721acc..34ea6c405 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -634,6 +634,32 @@ __naked void partial_stack_load_preserves_partial_zeros(void)
 	: __clobber_common);
 }
 
+SEC("raw_tp")
+__log_level(2)
+__success
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("R2=0")
+__naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
+{
+	asm volatile (
+		/* fp-8 has scalar const-zero spill bytes and STACK_ZERO bytes. */
+		".8byte %[fp4_st_zero];" /* LLVM-18+: *(u32 *)(r10 -4) = 0; */
+		"r0 = 0;"
+		"*(u32 *)(r10 -8) = r0;"
+
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u64 *)(r10 -8);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		"r0 = 0;"
+		"exit;"
+	:
+	: __imm_ptr(single_byte_buf),
+	  __imm_insn(fp4_st_zero, BPF_ST_MEM(BPF_W, BPF_REG_FP, -4, 0))
+	: __clobber_common);
+}
+
 char two_byte_buf[2] SEC(".data.two_byte_buf");
 
 SEC("raw_tp")
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index f345466bc..24cd0a763 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -59,6 +59,116 @@ __naked void stack_read_priv_vs_unpriv(void)
 "	::: __clobber_all);
 }
 
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("R3=0")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;			\
+	r2 = *(u32*)(r1 + 0);				\
+	r2 &= 7;					\
+	r2 -= 8;					\
+	r2 += r10;					\
+	r3 = *(u8*)(r2 + 0);				\
+	r1 = r10;					\
+	r1 += -1;					\
+	r1 += r3;					\
+	*(u8*)(r1 + 0) = r3;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero across slots")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8,-16")
+__msg("R3=0")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;			\
+	*(u64*)(r10 - 16) = r0;			\
+	r2 = *(u32*)(r1 + 0);				\
+	r2 &= 15;					\
+	r2 -= 16;					\
+	r2 += r10;					\
+	r3 = *(u8*)(r2 + 0);				\
+	r1 = r10;					\
+	r1 += -1;					\
+	r1 += r3;					\
+	*(u8*)(r1 + 0) = r3;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves partial spilled zero")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("R3=0")
+__retval(0)
+__naked void stack_read_var_off_preserves_partial_spilled_zero(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u8*)(r10 - 9) = r0;			\
+	*(u8*)(r10 - 10) = r0;			\
+	*(u8*)(r10 - 11) = r0;			\
+	*(u8*)(r10 - 12) = r0;			\
+	*(u8*)(r10 - 13) = r0;			\
+	*(u8*)(r10 - 14) = r0;			\
+	*(u8*)(r10 - 15) = r0;			\
+	*(u32*)(r10 - 8) = r0;			\
+	r2 = *(u32*)(r1 + 0);				\
+	r2 &= 15;					\
+	if r2 > 10 goto l0_%=;			\
+	r2 -= 15;					\
+	r2 += r10;					\
+	r3 = *(u8*)(r2 + 0);				\
+	r1 = r10;					\
+	r1 += -1;					\
+	r1 += r3;					\
+	*(u8*)(r1 + 0) = r3;			\
+l0_%=: r0 = 0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read partial spill with misc data")
+__failure
+__msg("invalid variable-offset write to stack R1")
+__naked void stack_read_var_off_partial_spill_with_misc_data(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u32*)(r10 - 8) = r0;			\
+	r2 = *(u32*)(r1 + 0);				\
+	r2 &= 7;					\
+	r2 -= 8;					\
+	r2 += r10;					\
+	r3 = *(u8*)(r2 + 0);				\
+	r1 = r10;					\
+	r1 += -1;					\
+	r1 += r3;					\
+	*(u8*)(r1 + 0) = 0;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("variable-offset stack read, uninitialized")
 __success

-- 
2.54.0


Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4204299AAB
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388413; cv=none; b=ll3TDxStef3wYJEmdYJ64cmlabqiCYnjQrM+geyOeB0RUZ+E1j0+0CkHdQAONPfIBNwtp8Hisp0DUG21lQz9kk32Dj1AQu/I01E9eK57zkpVvVDAIKhR60+WV4GPZcjgIP+xLdoBaYp9zwCjGA3oa4b87ZmJmoOZbIZE430DaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388413; c=relaxed/simple;
	bh=xptgCe9bCs8JvI5mrK84BHoKVlopNeH8hj9lsg8iaIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc5kRXEoEiRquUw62UyhQUf8KkmupnC2DSw4IyaPEasYquyl9aQsvj0K/Aee1I7JtTtSXsIqaIgW2RDXMOTqyRM8WrMHwK3QQ2k5LzhMjQ3tZh9LUEKLXq/zxZjz8FjpFB4topRX+mCyEKIIEUDk8BvnM68/i6DxExnLyaXfdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG1DBjWJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG1DBjWJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a07ed3ebdso900670a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773388412; x=1773993212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1B4+uHVYam2OzRSZapL3ZgAixz2jmp169k65ydcqpA=;
        b=aG1DBjWJf71KKd2laF5Oc8Efv4wfw2dVyXG0UoSH6a8e4i5zbrE0pDAxyCYZQh6q5O
         662KRvdSptqrpQ2neHv6yHeyu7q6uLpot8M30szfiomM8EA6dOqWyVnKEi43VdLf4S81
         udJxpk5ARIm3SK18JjAS3Y3o/RbNJSUeXXyPmjEm7Vfx/qPy7811VAjoOeI/K6w+kzy6
         SaLv3xoZ+VkkjCHNypxRgX4/RsprFKh5R60jEx55gQQdVQqhsejHvO+h/hYPbrFoz2vc
         mo17COKMLOMe3Hnm+Y2mERWE+V9K7XmcrnoQ74rYGB4w0P8UEgKNG0SeToRYGGCQn6LF
         hulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388412; x=1773993212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1B4+uHVYam2OzRSZapL3ZgAixz2jmp169k65ydcqpA=;
        b=Dv1dee8wvbHlC7xlAQN2DasB5GfrdFWAGLbE8T2QhKERrYJ7UpkcFC+kNSBe5qsunN
         RGhESpFV2cIed/1ki6uYO45mDMCfNWnW+pD3fhmb7DcSb9AtjBy+Yat59uf+4KrTrLF6
         Hf2lHdF9yMParzBlComvsgFvZWFGSvYtehQ0dc9QorKp0Rnngp4FpZElxWm3WaQmab2B
         0UunWGIXtmIpGqqwKp37PoiajB3OtcNI2Gzj945kJFECHJqJY/YOdH/xkRFMGNSdgVj3
         g/7566tgYbG9bfFjscKCdarQGUNHSUNQPmA0fRh1tUIKVo+kF6aqYWpESJOaagn8h6DJ
         KV0Q==
X-Gm-Message-State: AOJu0Yxgo4rgsvfPTAHa66sUmZYVPQnBEza+a2PVzjYrXWAa+M2ATP0I
	qqMZ/AGkFA4kZxb+ni2g1MAG3jXes7WsYwOfkO9ZrZlUXD90lkKq7pF9es+pm2+y1rI=
X-Gm-Gg: ATEYQzx6hb+Vys/FA527DPLaDp+vUzi2KmnKTqtqkQAnyYcwbWE9MHFf1qzJSPndzQv
	4fu+rA4Bg6O2KlFE7iKhwQQWk2CDDVgh2k0I5fe2TLtwtq7bmkVUW2m0uQAOjzfSJZJ9hw+urM+
	7XR3jj7SGbR7E/0ForXZ/msHSjQokKM6VAD+7WO7u9M5naOHHTJ0LvNcm6EzGp2HJJwE+emlaX5
	ZYy7CfdQyGkXLNrx2NENSDmaILTczb9E14v/S4l5vNNNRXR6zilX+2lcfLQg11xoYyr8NEeLM+m
	gCNP1cZ15oeQme5cOdnMcwGAIK/gvnKTynkuaBBd8dgF4t8YuiqsZdWoG9soUSrr0C8X83nDs+c
	8pvD52JNFLgHCoy4O7+sCJVJZGml19SLVGem3LIoLRdVIW3woB/EErji3Iz16ottGIuxl9Q8R5/
	kVeF35vWsCO6+7G3UxB0mCdwzpzhMAZ9dO5ZMvcgxXz6u9ooPuRoR0tysa0Lh+dFGtuGA51cR31
	S+IV/RfnUP5iYPc4v+g
X-Received: by 2002:a17:90b:1e45:b0:359:f0e1:f8c9 with SMTP id 98e67ed59e1d1-35a21efae49mr2189193a91.6.1773388411984;
        Fri, 13 Mar 2026 00:53:31 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm9774694a91.14.2026.03.13.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:53:31 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
Date: Fri, 13 Mar 2026 18:53:18 +1100
Message-ID: <20260313075318.11847-3-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313075318.11847-1-danjwade95@gmail.com>
References: <20260313075318.11847-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three test cases to verifier_bounds.c to verify that
maybe_fork_scalars() correctly tracks register values for BPF_OR
operations with constant source operands:

1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
   path should have dst = 8. With value_size = 8, accessing
   map_value + 8 is out of bounds and must be rejected.

2. and_scalar_fork_still_works: Regression test ensuring AND
   forking continues to work. ARSH 63 + AND 4 produces pushed
   dst = 0 and current dst = 4, both within value_size = 8.

3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
   pushed path has dst = 4, which is within value_size = 8
   and should be accepted.

These tests exercise the fix in the previous patch, which makes the
pushed path re-execute the ALU instruction so it computes the correct
result for BPF_OR.

Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
v3: Use single-line comment style (Alexei Starovoitov)
v2: Update tests for re-execute fix approach (Eduard Zingerman)
---
 .../selftests/bpf/progs/verifier_bounds.c     | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40e..bf834414ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,94 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or_scalar_fork_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 8;					\
+	/* r6 is -1 (current) or 8 (pushed) */		\
+	if r6 s< 0 goto l0_%=;				\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: AND with constant still works")
+__success __retval(0)
+__naked void and_scalar_fork_still_works(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 &= 4;					\
+	/* r6 is 0 (pushed, 0&4==0) or 4 (current) */	\
+	/* both within value_size=8 */			\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant allows in-bounds")
+__success __retval(0)
+__naked void or_scalar_fork_allows_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 4;					\
+	/* r6 is -1 (current) or 4 (pushed) */		\
+	/* pushed path: r6 = 4, within value_size=8 */	\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


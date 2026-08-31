Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BB3E1692
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168236; cv=none; b=ZXw6xsd2ZDEeSPwTyuJWy3Zzp3PauZJt9QVozp61dUK5N5GIJfIPiI5Y8oz1L+7hkZRod0BDnLF5zhneq5mLYoB09AaER552Wbhwl8Ov4h2yPxakkEOeXAgHkn8KIAXqBVpCJZNXNkw9zw8zNrOoXFVj2xzvPfnEqrfSqLzfiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168236; c=relaxed/simple;
	bh=bxCCFdUECttyJbXSGfdduUo/DEz+VpTX8wwbkV1YIHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNggFQxmZHX+4xBllLAkBvTqfCtILFBvqbxwBpF/izahklJRUsqvnqrMoxAVNI3Dh5yQ6Nb/wIYAS0ETNv1emvmsogGIPmBaT2VG4X9vy/YWr5Ck6lRhT0uwvsFFzF8C9NbwyvpmbcmAw2f/jZS0hDYYTNqMSdauJ34Dwys13MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHGJO3jA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHGJO3jA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso2013705e9.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168230; x=1788773030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agssTkVjz/VQ+HpJevjjY5hRGfaiF2JHVaDNy5Qphm8=;
        b=NHGJO3jAzqsuNX0fcpHWCZQRJSPj7bOoNNyTtqReDHDjbsrKBaH7A3WhZZYkmm/O75
         ozO3WmVaULMLM9ymdK1vDytunkpSUgmhKbNzvInMtGB0D9xXdspyVXG0bKSigZ3EQgwN
         PmDbeLsJI9u6QU2NUbrpLuQMMVWPUNSRBTMw9Dx5uU74HTMYDqQEBeBLbBT1QncWSpEC
         tLWlKa3kiyDJe3Ql/CAFPPMIp1Qii0LVvvjJDIlYart8XGjzziqdhoLq0DEGVyP7zdKr
         LmR4mWSrf67xctx2j3sxfkCIapkeLrbrU+1WwTDcDIbmMHPE1d2tUWjN6mKJS1AIyon7
         CAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168230; x=1788773030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=agssTkVjz/VQ+HpJevjjY5hRGfaiF2JHVaDNy5Qphm8=;
        b=c+3b+ZEEFc9Vc4KKT0WNPzRT7U8ztbeczi0d3jd3jiqZy4iBacVGs+Yt9Q0CmJk2Tm
         6PnmwuSw39tH/J5hHB1VRb0fabA9xfo3B8IhYiHV51OBy/hOv4n9guY4dUK6Y6I/jhTt
         DmgYFb4sdOwhd9aK9oLsBNia3fSm+dR48CCWLrWQWgT3UT+5idqyFt4L48nUg15WoaxN
         IiN+zNx3s1h71IZdBEH0ZtFlOsTrpQsyZNz/VaI8xiHUxlcS8dpEz+QD6Q4yk0tNCQlJ
         iV8jgEWVh7j9v/xBDkLctLf3ZeaFmnxphZBLLt9HudaIYAL4D/rU9js+6eN7pdSvZ484
         0ofw==
X-Gm-Message-State: AFuF++myu/hpG2y0ReIg3uFrn7r/3F9n1lBQBVpUwEF2YunYh1Hs0cB1
	PdN/WwBJARzKfDjEN61uj2jXAcasyo7GvP1YQPxAMGY20b9QO8Xl/BruE18WcIo0WJ8=
X-Gm-Gg: AR+sD12cQugRqRllnSfJWd9fFRti2D9+qZL2vBBd/Eqh6MUdeJK8DxCf0rPM6KAbwA6
	Vou0kmpCv6X++nhBppPEKozx6pGecv/yhp30PZYVUA6lcJ+T9QOPrqBoH/Uza/1f42Nofi1QA2Z
	9ANDUS67cy6i1w6CvFCBM1JOTtncZIocofp3CB1lb8ia3DtpjNaW90K7kjun14GZgQhFLuuRsF6
	ee6ebS+1EdatGbamgwepJmEanSZ4BdHfDJY1VpyL0FUyLiLyK06iCNuXV2vwgBuicLKl5xMX+va
	zZt49EtlRHZjVUsNi+O/epDbrRe6n7uA7lb1GiZituBrYdwxh049e0LfH6hEHeSgizefG3O4ImH
	KHtQMMBYjDX3RCS5pwKhnJEy8M6l6zIH+VSkh0dGLBGNHTUVg3AwN63NztmqskJL5aOqokKr0ct
	hAGcPXO+GNdA1vLePLS4nWdCVM3e62ekUHdg/c/iJfzO1NTLcDXJf75KDljVaXDNDKdTQyURPYv
	A==
X-Received: by 2002:a05:600c:4585:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-49b91c265d7mr347797155e9.3.1788168230352;
        Mon, 31 Aug 2026 02:23:50 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:49 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v3 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Mon, 31 Aug 2026 12:23:02 +0300
Message-ID: <20260831092305.42062-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a trusted-or-null pointer
(i.e. PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL) has to be checked
for NULL before it can be dereferenced. Marking a field from
PTR_TO_BTF_ID typing to trusted-or-null can reject programs that
previously dereferenced the pointer directly. This is useful as we
need to mark new fields as trusted in order to pass those as arguments
to kfuncs.

This patch adds support to dereference pointers marked as
PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without the need for a NULL
check. We define that those pointers can fault on dereference, so
reads need to happen through BPF_PROBE_MEM. If the dereferenced pointer
is another BTF pointer, we clear trusted flags and mark the result as
PTR_UNTRUSTED.

This applies only to reads. Other cases still require an explicit NULL
check. After such a check, the pointer retains PTR_TRUSTED and can be
used normally.

To summarise, before that patch, reads to PTR_TO_BTF_ID|PTR_UNTRUSTED
are allowed through BPF_PROBE_MEM and reads to
PTR_TO_BTF_ID|PTR_TRUSTED are normal loads. This patch allows
PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL to happen through
BPF_PROBE_MEM.

The unchecked read path has two consequences:

1. It uses BPF_PROBE_MEM, which is slower than a normal load. An
   explicit NULL check refines the pointer to PTR_TRUSTED and allows a
   normal load.

2. A faulting read returns zero, which is indistinguishable from a
   legitimately zero-valued field. Programs that need to distinguish
   those cases must check the pointer before reading the field.

The next patch updates current tests and also introduces more checks to
ensure this change does not break anything.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 12 +++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ae9f606539f4..d3d7254cc1f6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1326,6 +1326,11 @@ static inline bool bpf_is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
 	}
 }
 
+static inline bool bpf_is_trusted_or_null_btf_ptr(enum bpf_reg_type type)
+{
+	return type == (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL);
+}
+
 static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 {
 	/*
@@ -1333,7 +1338,9 @@ static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
 	 * turn a BPF_LDX into a BPF_PROBE_MEM one for.
 	 */
-	return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
+	return type == PTR_TO_BTF_ID ||
+	       (type_flag(type) & PTR_UNTRUSTED) ||
+	       bpf_is_trusted_or_null_btf_ptr(type);
 }
 
 static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..386401fe051d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6116,6 +6116,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
+	} else if (bpf_is_trusted_or_null_btf_ptr(reg->type)) {
+		/*
+		 * An unchecked load through a trusted-or-NULL pointer is
+		 * fault-protected. Any pointer derived from that load must be
+		 * untrusted, as a fault produces a NULL value.
+		 */
+		clear_trusted_flags(&flag);
+		flag |= PTR_UNTRUSTED;
+
 	} else if (type_flag(reg->type) & PTR_UNTRUSTED) {
 		/* If this is an untrusted pointer, all pointers formed by walking it
 		 * also inherit the untrusted flag.
@@ -6591,7 +6600,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
+		   (!type_may_be_null(reg->type) ||
+		    (t == BPF_READ && bpf_is_trusted_or_null_btf_ptr(reg->type)))) {
 		err = check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
-- 
2.55.0


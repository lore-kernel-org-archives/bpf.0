Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924703FFF94
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510826; cv=none; b=DGCyIxTcXrCFKXS/+ve/4QQeJuHK9STWRYZ7jSc7xqeFv1PW6UCNsiuCqWzwqAgnSItJNXQP/qqh5RvznituXLVcR2OdRnlVaP14JGy+xHZG0Xp+NSC5PLwJ1zJ6UZjKT6kgc8eKQ1HlJGImKemszqziEX/BMgcA9Q1BXUKx/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510826; c=relaxed/simple;
	bh=E7Ndr4b2lU7CRP6/8S6HmYL9ZoatBbkvm8aWnVNGBWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH+3jFjXDy7EIkvd3edMEqMHF1LXoTC+bnDlGD+1OoOQQVlO5zLIFGgYRvC52f4CQX94GxTPcfsjAsWIAqTbm/u0Bw6x1ob2TqsHnWe+R3Un1ZsnaN2dtlzR3+yqiLz0CVy+RuSW/ScTNUPUcd1jUiCRrBXyaE7PXeDPu3jbHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbj/yC/M; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbj/yC/M"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so530105a91.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510824; x=1789115624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xzlaic2JBHc9Cv+CnOeW5jYwCSJBEHKzd9VGwuDgds=;
        b=Vbj/yC/MsZ6E3AFzDB0/mRi70Eb+3xe0ZG6R4FMuMd1tkY8BKOcrR/MHdFYu2oAP4y
         Z/FGv5rzVDKaH4xuDKYTdADHS41DVvthoSDUKXazsNS2RFDbCXKeY3ScphQdGvFbcVX8
         qKYyWLqiERYe+y4puINReOnaKMTRqw19LdIaiNiGjLtbNvoNbvjyrnNLb3DP9mrBzW9f
         lx28Gzi5CTAq25WHIxe5GIbauXtrQgrb6lG6vx80T+bidraVKG0/sggoB1v39+CDVoFK
         61JJo1Im+c4r+ThlohySGETmmoVKkWKiFk9V8IhRB0+drK+YKSt/8SN0OSMOL4n816b7
         EafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510824; x=1789115624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3xzlaic2JBHc9Cv+CnOeW5jYwCSJBEHKzd9VGwuDgds=;
        b=CsUiDBj127cZvpoIrzLsj0RWb82TNnOnnx9HKYpXKkDoqiBwQjf0MQzfP3BoG9gXej
         ZRQlcY5c37Mb7hft3U4calZBqqB+6kkPqwGKmXA0ugqf6vqBw7vH/wcOATXtjdR0HXn+
         5cdMzbIMenZdx2VilwgeB4VribG6pQmw5d5H/hbInv1tcLwKPf23pXf5Q5S4xCJ/XGD8
         Q9R+y7BjmVFkLN0HM7mUQx4jD+uZyEM9y9dOPSnaVUHNW0Z4SM8h3mgBqIpCKAr3JQDt
         X7aQ/garl6L9Yki2vzmc78MCL50Glr5GAeWmf+BL90WxK6RtFZkrdxBKYjfKZfwGfhFg
         tziw==
X-Gm-Message-State: AFuF++mj8Dn/3WQrhkWXHXVYZrusRjwomKL0v2Kxz8GYszXwJddY6X2B
	k32DMNF6KNgJbiraBFAeIeqY6jiEMUQytymdlTM0SI0A58tZ28KIYPcGH5XwDQ==
X-Gm-Gg: AYBFou3+o4780mdIV7mLCk7Dph7a8s10kkh9iWUXf4PilTXoXzE75cxt4Nbj6YP+ARF
	2zeBqZaqL1bRPbfjcOVzILwehvV8yRjBRU5sWfpjvEK6QbUcctsUGRI3u9bjy8t1FqLi9dnQuJW
	jYEwvEidmlk0qBdHk4Vq9rJItc+yPvu1qvnfEjzTpCbGZhAn2XR1maHSyfo614OxEOrKxBLrUZA
	MZMUE1WKSplbl8O/Jofc6Yw1QEBbXxU6CmZgK2xVx5EoGAplK/Cxxu3YKM6eFO3KxOjajnbnC+p
	AZgOrl0JefDdgDRhJfO0f0KtfXom70b+HaJp+6GpW94AZNe1L6rMz46//WvNliWp2OBJKzXcTfg
	NfHLGtkA7zl1gQ+h7t8FNsmIm4yrVeF3jRuCK1WVNxbkrFn8o0xdzbowanMEZBPKjJCoL+n4ao8
	a7raWl8HftDpgt3Fw/w75PKZi39IlAMUAQneCspA81Y6nXPtiFP5TO8B3wdyt2kkhYlI3eByu4M
	EaApLRFnGnBTE3a1ITa0O9X4kw5CLsCGeFUANgsAdM=
X-Received: by 2002:a17:90b:3810:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-39b26213a86mr6890882a91.19.1788510823730;
        Fri, 04 Sep 2026 01:33:43 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 6/8] selftests/bpf: check that JMP32 pointer vs zero jumps are not predicted
Date: Fri,  4 Sep 2026 01:33:23 -0700
Message-ID: <20260904083325.2083493-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add jmp32_ptr_vs_zero_jne: the fall-through of the 32-bit compare, which
the verifier used to skip, contains an out of bounds map value access,
hence w/o the previous patch the program is accepted. See previous patch
for detailed description.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 8657e4a0d601..410acbf658c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -391,6 +391,33 @@ __naked void bounded_offset_infers_map_value_non_null(void)
 	: __clobber_all);
 }
 
+/*
+ * The low 32 bits of a map value pointer may be zero, hence a 32-bit
+ * compare with zero cannot be predicted from the pointer being non-NULL
+ * and both successors of such a jump have to be verified.
+ */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=4 off=32 size=4")
+__naked void jmp32_ptr_vs_zero_jne(void)
+{
+	asm volatile ("					\
+	/* r0 = bpf_map_lookup_elem(map_hash, &key); */	\
+	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 1f;				\
+	if w0 != 0 goto 1f;				\
+	r0 = *(u32 *)(r0 + 32);				\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
 void kfunc_root(void)
 {
 	bpf_rdonly_cast(0, 0);
-- 
2.55.0


Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6C3F7A9B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510822; cv=none; b=tCcS6w9mT1AH9e85r+QXoo9fJP423A+GNAn2KerL4rb8UOvnivSn+oyxoYrQuL8L3T8MWoIKHVN6saSULIjTZlr2J5jJcvVQUDRi/8EMU2TuDzudrJ1/L6DBQzNic0SISzHMYupE3PiAut7vJmxKQ55/UGkMhAoI8yTNtL/i+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510822; c=relaxed/simple;
	bh=cg3WJ8z7V1yWC4iyZ5x9R9+zXbGH03XeKIlUQgIAv1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNCYuuz3qxs5JYhGg1oEqv0MMXACl/bFnDoCtI43qqUm12+xBJJ3MpZ0uArTAtXMLHb6knRNRG/NtgRlXajmlPJpM8jld+8L4BRxcV1P1hXcs+TmH5T03Obm/40UxsypNjjv8oo5t1wnx6o/EkXZTLDOjgA0Oj5I30QBH539KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiZMQACs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiZMQACs"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so823309a12.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510820; x=1789115620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCicz6o+ujtCgcRneONqgxLEs/Xt8g6Uj/7VwMxEi3E=;
        b=FiZMQACsaCe/Wd3+W21Gl8DvinLFH4B9SUjk/kJKnQohUde3+LQgYtHyxFbZCrHzGr
         AopxVRiMmDYOu8AGdhXjCbZdif7pFla8c9y37EHmTqYfuGdgLOjDnvXVA48QxZEhHJOI
         chx3NNQWeVcKhNiv5JTetmYYc8XgoeUKO2cWe1w0eAnJdEDfLoXHW4GlbKHQOiGKND1b
         rLobmN59ulKytJ5fzC7uLqQX6NHucQkZV0E+UJU7PG5Mq6oYOzGv/vQL2EkWbOEfCyio
         sDeMt3hKBNW7Ai716dL9+4oCYg09R/gEgUHYZxhVSVCNWctdXvq82fw4sxHAqopoB568
         d+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510820; x=1789115620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCicz6o+ujtCgcRneONqgxLEs/Xt8g6Uj/7VwMxEi3E=;
        b=TwwhI0fYQsMq20cR9umGsKsSlwAxxOVIyt7MJ7VnjL+enC7iU9WQfCpeOlffwx5BjJ
         SNV3VCLmVIUoXd1/JrjYU8VLXBEdAfLE1WpvwYVEaepK2Y6hDA/Xyo+U0f1dt7410YeV
         fnPEFyIvh0UiYzacoJrKog2OxVNIqyUnwRtBzTlhCj7Iseyro+yKfNaPG8imbtg4IA0A
         xykLAdWkcBoIsv+Ms+1dodHD8FKNGAqwtKoqjn4xD3rkisap/iQ8zlyTqY94CvsFuIGQ
         p/E1KmTcz+tgc98EDxwoISaBoD3gDqZort2/cUyjNUwKqsvffxs04gvdQUfu84Ztlx60
         ukjg==
X-Gm-Message-State: AFuF++l+XmKdZR8ICxL/hYzM47LM8N/ZlUbnWd6HgruQdInO8Br4Xoig
	ehsCJg0EiH6i4cAEtl1gVtee4umDJRvUJY8QRy5txZ8zaJFhi4A0YonGf3b/7OSS8Ms=
X-Gm-Gg: AYBFou3uk2XSZu8j3VuSg3XmRgmFwuURUCWDcz6lzrzeM994F0GX425c3Gzdoh+Co23
	DIdBynS5QpRcwjM2Ga00kXqDa8ThQkiutPMKztgxjjbtwmMDxNdC8WNxlvGZdYeHtmaoId7rCy0
	7eZqERrkXnwAVKL5PzCIqhqBlH0k2myMlnRK6OnNo/AywtL5akFH4hM5ww/0tBUI2+CCa+XCDIK
	BQ/Jud7d7POD1/Z+1mNECFZMoAih61HomzK8o1OJhMavlUl/WoBpk/7nfUqQfOsZ90Rj5CihZA3
	okjp8vs+19sfAiScIdMrKCyvnHW1g2tkccTXhMSxMKl/wW0HegLpArVHxVjZIUi5IWVZMbjlROq
	wTOncHwE3dbcEiTX6WXeXLYRBdP1H+80OUlgvpidqfulHeE6ULYzTMnNh4mfRRqgRxY5j7ROmoI
	J+ObjVVEUKyV4CrLZB+rJYEtrHI5OX0cY78MYA+N5tKR3yWtpUK2Kt+rNlHwYAexif6ASVe+/WX
	f+7s76fVHdUcrcMYOp6PbVg6tAM8EAq
X-Received: by 2002:a17:90a:51c6:b0:39b:29ca:3d23 with SMTP id 98e67ed59e1d1-39b29ca41d5mr3422821a91.17.1788510820303;
        Fri, 04 Sep 2026 01:33:40 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:39 -0700 (PDT)
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
Subject: [PATCH bpf 2/8] selftests/bpf: no non-NULL inference from unbounded offset pointers
Date: Fri,  4 Sep 2026 01:33:19 -0700
Message-ID: <20260904083325.2083493-2-eddyz87@gmail.com>
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

Check that a comparison against a pointer whose offset is not bounded
from above does not make the verifier infer that a nullable pointer is
not NULL, and that a bounded offset still does. W/o the previous patch
the first test is accepted.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index b412a542ef76..8657e4a0d601 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -311,6 +311,86 @@ __naked void untrusted_mem_does_not_infer_map_value_non_null(void)
 	: __clobber_all);
 }
 
+/*
+ * A pointer with an offset that is not bounded from above may be null at
+ * runtime, hence it is not a witness for the pointer it is compared with.
+ */
+SEC("socket")
+__failure
+__msg("error: invalid dereference of R7 (a nullable map value pointer)")
+__naked void unbounded_offset_does_not_infer_map_value_non_null(void)
+{
+	asm volatile ("					\
+	/* r6 = bpf_map_lookup_elem(map_hash, &0); */	\
+	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 1f;				\
+	r6 = r0;					\
+	/* r7 = bpf_map_lookup_elem(map_hash, &1); */	\
+	*(u64 *)(r10 - 8) = 1;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	r7 = r0;					\
+	/* pointer - pointer is an unknown scalar */	\
+	r8 = r7;					\
+	r8 -= r6;					\
+	/* r8 is in [0, S64_MAX] */			\
+	r8 <<= 1;					\
+	r8 >>= 1;					\
+	/* r6 may wrap to zero at runtime */		\
+	r6 += r8;					\
+	if r7 != r6 goto 1f;				\
+	r0 = *(u8 *)(r7 + 0);				\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
+/* Same, but the offset is bounded, so the inference is still done. */
+SEC("socket")
+__success
+__naked void bounded_offset_infers_map_value_non_null(void)
+{
+	asm volatile ("					\
+	/* r6 = bpf_map_lookup_elem(map_hash, &0); */	\
+	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 1f;				\
+	r6 = r0;					\
+	/* r7 = bpf_map_lookup_elem(map_hash, &1); */	\
+	*(u64 *)(r10 - 8) = 1;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	r7 = r0;					\
+	/* pointer - pointer is an unknown scalar */	\
+	r8 = r7;					\
+	r8 -= r6;					\
+	/* r8 is in [0, 3] */				\
+	r8 &= 3;					\
+	r6 += r8;					\
+	if r7 != r6 goto 1f;				\
+	r0 = *(u8 *)(r7 + 0);				\
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


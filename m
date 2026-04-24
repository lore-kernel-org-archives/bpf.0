Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E2311957
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018686; cv=none; b=Dk7/pb5SdFWGJELdKl38FnCk1TiWw/DCx9pbloN3x9BENxh7IT/onh+xXAA7dHlCvWJDLQ5gVY99gy3OJDKDm/ll1GsEaP9fgoOMklTnncO7/vUZ4Wid89S0PFJDv/hntqdei58v2boS4JsIsX366FVHPfmYkur9UWMf73o7JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018686; c=relaxed/simple;
	bh=KcYc2IyJBNQXyrC3Ld5Gbt6tFFPtZHzHqRbGFhWeylQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+2rxy6ESKzCmETHhXaLYLzZrYFtyJoVTNIHWBNjki+EkETn/vpFPvDfrqoMav6xvqTNI2+yJLAA2BwMtql5vojo8lDqDDc1I672D57JDFQvUoGgmAgsKreZUHkga82Y+1j033wrI1+tUIohWtjHnYGQF0gxIw4vdvus7BuF3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz4aDZcs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz4aDZcs"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8318293f02bso354805b3a.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018685; x=1777623485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGj1yGIFUFe4k7lt3K0iUmH7miZOHlaHTJ0uzmb+e+w=;
        b=gz4aDZcsIz2jLO+SAd1oVi0SFuUICrcy4QKtOM2ZEmPY0q8Rgo2zVsiRenjfouNhsb
         Nu0Om9MwvURcspE725sgs1tb2jYUhchqpWq+NNib/S2MSyr3GEU7oVzGU0TYtIqABk/z
         QPiVdyhtNfVLio5acgovU7bCYEvNK/wr6n6jZXYN0ZND0FQ4dL4H3A+xAR7Ipofp6WK7
         8B8SLJzwQljwaTcxo0hXKDsTdbGEijfuCbD7P0cfhgt2TGXJpudfcQm3wrxoJy5JNAnC
         ugSuptqRUqn0id4H6lAcWhtxFpt7YKUCHxHJWf1PoEMg4Aay6liKyePc8U+s8fLOwr5/
         Ld/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018685; x=1777623485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGj1yGIFUFe4k7lt3K0iUmH7miZOHlaHTJ0uzmb+e+w=;
        b=WyH8LVh/nh4LeROzUhjnTdRzpnZ3ki/pQ9z54Tn9rOWK85BtawwsWW2+knojX+j5wX
         kYc9F//8B1pUf7XvptFub9dKwOCR1UUsdmdSHzuf1f58+2f+BsTXOJKJRYk70afp+eCw
         Crng7+lK3aMs6w3yuurWdNn3Qdagw4V8U/e3QWHGFOAyt1wdVCUhYoLaRtW9KGC+Birl
         6FwC7Rahth0htNIsnZv60UTQ4TJeztt6HHTp0rxSGddagXeAjUED5lY0zHwfijlpqt7P
         FgSOjTBmX0Wv3VV1FciTq1KBKnVe40g27zRSjn7kuyDv617/NhSqhOmBKmS7oFkf5QFc
         Ks0Q==
X-Gm-Message-State: AOJu0YyZCxObokah5S4LwE8r/CMy9QphfdSzYRPbuBRjYofvXnhbioI2
	sqYrcVEP44qiJXK5MfjQTS4/HuHp33Z/0AUAwTx/7K7X+xCwCJ0RP+JK1YnM1g==
X-Gm-Gg: AeBDietLzVQL7I78VFi2YQhTGgslHCQXWd72OqUNxsaXzHAFPsL+TiwCMIO5QlE02rx
	dRwR/NGzGuG8j7cnxLPxsUF0+ZZgCTCJCdop+OgPlzHsF3H7lmI69kX0wE9jGllpHou+UqPotiI
	47dp4w5M9bMsf9Nc1eJYZjwnkfnDWPvLFK7sBzyChIp1LranLTT0zCoAvOevCbIqB8nBYr20YcM
	hLO0S19rfD0pHTYZFuGrmv3S6pmSxXLVsvQOwtYeGQn49CEPFHW/fG5IYDKmoS3kzhyzPWsovdL
	okglLzRbErBjETN+wNiaJ4hHE5skLBVmdD8GrjM8JXhahZzVCpm+ZtZw+NcTlRvJ/LwY6l2Iaxh
	AsL8lrNfAmJTUAJfUJ6xxZEIT4mqp7+jPLcI80975TLFrgaPP34A7/+SSYGupcxwgu5FVs2BTqD
	lPBdsTFKwpCy79gvtRWadFQy7nvsyHgp7Nba99hcYzJNM5N4Rda1zUb7lfKqFo1ZQS7HKfgw==
X-Received: by 2002:a05:6a00:18a0:b0:82c:7420:82bf with SMTP id d2e1a72fcca58-82f8b553980mr28883503b3a.19.1777018684627;
        Fri, 24 Apr 2026 01:18:04 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm26604340b3a.58.2026.04.24.01.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:18:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: new cases handled by 32->64 range refinements
Date: Fri, 24 Apr 2026 01:17:43 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v2-4-57091924c9d7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

1. 32-bit range starts before 64-bit range's low bits in each block,
   causing intersection to skip entire blocks.
2. 32-bit range crosses the U32_MAX/0 boundary, represented as s32
   range crossing sign boundary.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f0b3fbbbb627..5dd243e653c9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2187,4 +2187,84 @@ __naked void tnums_equal_impossible_constant(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * 32-bit range starts before 64-bit range low bits in each 2^32 block.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
+ *       |< b >|  |                |< b >|                 | |< b >|
+ *                |                |     |                 |
+ *                |<---------------+- a -+---------------->|
+ *                                 |     |
+ *                                 |< t >| refined r0 range
+ *
+ * a = u64 [0x1'00000008, 0x3'00000001]
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_before_block_start(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000008 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x300000001 ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000008, 0x3'00000001] */	\
+	if w0 < 2 goto 2f;						\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */			\
+	r2 = 0x200000002 ll;						\
+	r3 = 0x200000005 ll;						\
+	if r0 >= r2 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r3 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 32-bit range crossing U32_MAX / 0 boundary.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||===|---------|------|===||===|----------------|===||===|---------|------|===||
+ *  |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
+ *                |      |                                  |         |
+ *                |<-----+----------------- a --------------+-------->|
+ *                       |                                  |
+ *                       |<---------------- t ------------->| refined r0 range
+ *
+ * a = u64 [0x1'00000006, 0x2'FFFFFFEF]
+ * b = s32 [-16, 5] (u32 wrapping [0xFFFFFFF0, 0x00000005])
+ * t = u64 [0x1'FFFFFFF0, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_wrapping_32bit(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000006 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x2ffffffef ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000006, 0x2'FFFFFFEF] */	\
+	if w0 s< -16 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-16, 5] */			\
+	r1 = 0x1fffffff0 ll;						\
+	r2 = 0x200000005 ll;						\
+	if r0 >= r1 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0

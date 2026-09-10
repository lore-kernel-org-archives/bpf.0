Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DB4AA030
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058882; cv=none; b=bhpFr5eS7t913MoHUb0m+iRXQqDZysTxWHZMk1N9+n36tpqUt9bgldLwHu8OvBCW2W9IWLbn3xQiutd7AOdnn7q9zHoZ07BDZsVP6GaKRslD04/spRKA+V6ulP9aEJgggLwkVxeRY9VLvobdcbBntWLzlSWhhVPYzYDSPkiHvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058882; c=relaxed/simple;
	bh=0ha2sGkGjon+eeZcJRjjPBS803qtaTj8dM/pQbd2s7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCoDU0cURUGVdIuiTENDXwFZ6DrwHwIBadUTZ5VzHhJfKj1TGaxWqfeP0yc11O4Hosd5Y+Y9Ws+suPXTXPorTMhXyuSklng3MAqiBNR8/uYbrsrkBc8hftls3jcy6cIBts9vjs7JKqg0WfkhLcgy1zWjoMT3SFnMqkBgUfZdFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nw7nC7sZ; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nw7nC7sZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0ha2sGkGjon+eeZcJRjjPBS803qtaTj8dM/pQbd2s7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058873; v=1; x=1789663673;
 b=Nw7nC7sZHlrBu1Mxta+EC44VdEdsyWl8pqsRoTjoZgl1d/85uUZ6L8DcVoHFVJS4Bo2k69FT
 r5fvZ1B9iZiBfRALjaYwDgZobKQHrg+07C7mPjMyc7hbqeqicGp6T199iTXaMHyYTnAuu2ILE2f
 ME+2kvdlju54kfBpVBxVCb34=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8644919bbe2bd5d;
	Thu, 10 Sep 2026 16:47:53 +0000
X-Mizu-Trace-ID: b8644919bbe2bd5d
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 13/13] selftests/bpf: cover the low-32 link for narrowing stack spills
Date: Thu, 10 Sep 2026 22:16:35 +0530
Message-ID: <20260910164635.459558-14-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two programs:

 - zext_narrowing_spill_keeps_link: a 32-bit spill of a wide register,
   filled back out, still follows a later narrowing of the source
 - zext_narrowing_spill_byte_no_link: a 1-byte spill forms no link, since
   the relation is not expressible

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new, with 12/13.
 .../bpf/progs/verifier_linked_scalars.c       | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index e8a44e7579c8..ca7471f0293d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -1048,6 +1048,60 @@ __naked void zext_fill_byte_forms_no_link(void)
 	: __clobber_all);
 }
 
+/*
+ * A narrowing spill stores only the source's low 32 bits, so the slot is their
+ * zero-extension. A later narrowing of the source must still reach anything
+ * filled back out of that slot.
+ */
+SEC("socket")
+__success
+__naked void zext_narrowing_spill_keeps_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	*(u32 *)(r10 - 8) = r6;	/* narrowing spill, forms the link */ \
+	r2 = *(u32 *)(r10 - 8);	/* fill it back */		\
+	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
+	if r2 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A sub-word spill is below the low-32 model, so no link is formed there.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_narrowing_spill_byte_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;						\
+	*(u8 *)(r10 - 8) = r6;	/* 1-byte spill: no link */	\
+	r2 = *(u8 *)(r10 - 8);					\
+	if w6 != 0 goto 1f;					\
+	if r2 == 0 goto 1f;	/* not deduced */		\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #ifdef CAN_USE_MOVSX
 
 /*
-- 
2.53.0-Meta


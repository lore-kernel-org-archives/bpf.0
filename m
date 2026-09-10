Received: from mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515852B1DB
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058852; cv=none; b=riwNIFgp7HmNFS8Pi395OvPDWOjFisCKpVX0pTB6w1FoaFPD2bIZcnpJPkYEGWEtGfVmGg2o0ZoM5YhqV66bfhQhcEdu/RkY2PDSCbrbL2z+uZMpDq1ds0Gbn54Y6zWqcRXfpJpmXrIRBsI+DJfOGORmmaRXxLF3kKJdWFP4Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058852; c=relaxed/simple;
	bh=S0BTMJ/3CMiKWvRdVO/UaaNhAWtf/hCTg91uhqdRYcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYTGWkBT2O0QD2r9E5id1T15/CCmZ0okS7Tt4Udn7KbstiTo9JG54s9O87YcqUBoNnFCO8rFil8ELeFzV/DYHkzLg/0u+7h4qW7DHRRlJkYstDbsl+dMbI7Aj8ovpyY0MlEp1wYuwj7e1sPwmPNAE3dy6jHaaZim/kTGaHMEYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uPPD0DM3; arc=none smtp.client-ip=91.218.175.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uPPD0DM3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S0BTMJ/3CMiKWvRdVO/UaaNhAWtf/hCTg91uhqdRYcM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058843; v=1; x=1789663643;
 b=uPPD0DM3ZhrLHjklNiME0axtTU8r9XXFVZlxu/BqytdbBhmMki7SwCAei4q+FdeGq0K1aM2p
 IIVMXTW0QUrwx36plYQssy+We9UMnHymG13Nj060msEDOuEnz+FRH0pWxleNwZiZyRb0cVwEKpd
 lnKoJrMcbOczi9kza973n8c0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88e6ca5c82b124ac;
	Thu, 10 Sep 2026 16:47:23 +0000
X-Mizu-Trace-ID: 88e6ca5c82b124ac
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
Subject: [PATCH bpf-next v2 06/13] selftests/bpf: cover sign extensions that cannot change the range
Date: Thu, 10 Sep 2026 22:16:28 +0530
Message-ID: <20260910164635.459558-7-vineet.gupta@linux.dev>
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

Both programs build a range that straddles zero but still fits the target
field, so the sign extension is a no-op: [-4095, 0] for (s32) and [-63, 0]
for (s8). The guard that follows can only be resolved statically if the
range survives, and it protects a div by zero, so a widened range is a
verification failure rather than a silently weaker test.

These sit in verifier_movsx.c rather than with the linked-scalar tests:
they exercise the range a sign-extending mov produces, which has nothing
to do with the ->id machinery, and the file already gates on the cpuv4
support they need.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new, with 5/13.
 .../selftests/bpf/progs/verifier_movsx.c      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 195b27a51224..3a0e67ebb963 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -202,6 +202,57 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * A range that already fits the field is unchanged by the sign extension.
+ * Both of these straddle zero, so the high bits of smin and smax differ and
+ * the top_s*_value test alone would fall back to the full field range.
+ */
+SEC("socket")
+__description("MOV64SX, S32, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov64sx_s32_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xfff;					\
+	r0 -= 0xfff;					\
+	/* r0 is [-4095, 0], already a valid s32 */	\
+	r0 = (s32)r0;					\
+	if r0 s< -0xfff goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* unreachable unless the range was widened */	\
+	r0 /= 0;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64SX, S8, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov64sx_s8_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0x3f;					\
+	r0 -= 0x3f;					\
+	/* r0 is [-63, 0], already a valid s8 */	\
+	r0 = (s8)r0;					\
+	if r0 s< -0x3f goto l0_%=;			\
+	r0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* unreachable unless the range was widened */	\
+	r0 /= 0;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("MOV64SX, S16, R10 Sign Extension")
 __failure __msg("R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem, ringbuf_mem, buf, trusted_ptr_")
-- 
2.53.0-Meta


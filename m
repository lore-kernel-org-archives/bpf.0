Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513176;
	b=3shob/Vb4JydAGuP7uAL6A0I7WNcHyAWuFB+pkCnxMRbrozvdAvU6ar+WqEsh0AXUPro
	 4ujpoF31/T93rdWNiBxg8Fc2oZNH1pSmm/WDLh4FtNP1HbbHuzR085Qmx9Wadj0SKURpY
	 iTivY7/PlD6OfD5/7Thc675qda/siKjEToq9s0N2f0eTgx3fP7DanIOjTC7yrj6PQ5lZa
	 7DvQHhm7MCTTiQwW7NupwqbKYcyCS0mWzvAGY3TjIDXTqnEFB5XUbM7qscdtQyLx2+YB6
	 30ivy+L2tiWXYWVXpJQemBYaZ0LxnnSTAYk8oKiMqwBWV1xEo2Mct5VZqGsfWgn+ALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513176;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bKUxGHRyo3+/Dr/aOP5Vkotdy4oFjZquORMcELQq3oE=;
	b=BguKlviG4YXHVRK3E9Fom3SpJUGNmm1Kns14kZTEUP9/F0ONcSXjd164tz2W/fNi8ybv
	 lLuoPCPn+AANdZXSncuOkMqFL7NXKGOiLPX36Pky4WbgzBA8T9m7SLB0O2oVh3h32N1r+
	 KgpIUnQi0mzbb9ngb7yJ7qFEJsw9esJ5kFRU2uNRoptuUwCECCVSfGeplqrNrLuAgZJXX
	 fH4jEBuKPe1V+6jT/j74wKl7MEZ3pr3VSPMpgoQgz09dPPOllX4LSxpwJGOhRJ+unuhSH
	 EfKMjAh491khUhK1brKdW00puUGAPniakP56o/lyGbvXvudQPpGRYk4sbTgHKczC9OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dh1cZjHC;
	arc=none smtp.remote-ip=91.218.175.165
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23D60A2607
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF23D60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dh1cZjHC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gE8TgRXK0GcKV0yfwGMME3U10Ye+CXjYA911KUj/qPQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513173; v=1; x=1793117973;
 b=dh1cZjHCEEe34GQWUX2jBy9/v4hOEK47NdKfX7JVjGe6toZoPPUyUhhV6fKrC91Om1zsigC4
 dTuG0kl3MxeYLIGjGFc++iGqBIqF44Mk7YFK+/sEHUuFACnf0ydRaiitupbSRqRX2vf9PlTnWex
 9VqMb2UA73K5BQF100b+E7Mo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 567127ed3dc100ce;
	Tue, 20 Oct 2026 16:19:33 +0000
X-Mizu-Trace-ID: 567127ed3dc100ce
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
Subject: [PATCH bpf-next v3 02/12] selftests/bpf: Cover sign extensions that cannot change the range
Date: Tue, 20 Oct 2026 09:18:57 -0700
Message-ID: <20261020161907.2115379-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020161907.2115379-1-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two programs, one per field width that coerce_subreg_to_size_sx() handles.
Each builds a 32-bit range that straddles zero but still fits the target
field, so the sign extension is a no-op: [-63, 0] for (s8) and [-4095, 0]
for (s16). The guard that follows can only be resolved statically if the
range survives, and it protects a div by zero, so a widened range is a
verification failure rather than a silently weaker test.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 6/13.
 - moved with patch 1, and narrowed to the 32-bit mov to match it. The
   ALU64 forms v2 tested now pass with or without the patch.

 .../selftests/bpf/progs/verifier_movsx.c      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 195b27a51224..3fcd03b7a547 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -202,6 +202,61 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * A 32-bit range that already fits the field is unchanged by the sign
+ * extension. Both of these straddle zero, so reg_umax() is huge and the high
+ * bits of s32_min and s32_max differ: neither of the gates that predate
+ * testing the range against the field can keep it. The guard that follows can
+ * only be resolved statically if the range survives, and it protects a div by
+ * zero, so a widened range is a verification failure rather than a silently
+ * weaker test.
+ */
+SEC("socket")
+__description("MOV32SX, S8, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov32sx_s8_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0x3f;					\
+	w0 -= 0x3f;					\
+	/* w0 is [-63, 0], already a valid s8 */	\
+	w0 = (s8)w0;					\
+	if w0 s< -0x3f goto l0_%=;			\
+	w0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* unreachable unless the range was widened */	\
+	w0 /= 0;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S16, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov32sx_s16_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xfff;					\
+	w0 -= 0xfff;					\
+	/* w0 is [-4095, 0], already a valid s16 */	\
+	w0 = (s16)w0;					\
+	if w0 s< -0xfff goto l0_%=;			\
+	w0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* unreachable unless the range was widened */	\
+	w0 /= 0;					\
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


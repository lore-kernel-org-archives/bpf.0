Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513172;
	b=pCcG39JXfDHsmQLwSy8WbiBxOMFVOrJ+rIvOrhrfaUzPhq9N+cU5o4Q+wyphyIT0JMtJ
	 PHqX3y3a8UMqu+/t7mpPzzG/RUx0VQgp+YOA3eg0eV4SoPQSTX+dja+/HJGSj+e378hWu
	 hwHpUuwmLUP7rhR50qfv+PxWcJPE2yt89h5dHePZKciQ7nzqdgh8kyG01QBGNkXC7YZwn
	 XWBjy1pt9JuP/e2/em0ePb50LNOKzJaWzCCVDh7AQT85YcZta/5hDs+50J4LjfZTJP9XA
	 e2kWpNN1FlcOb9cjKagrS49FCFGOa8UNIvqO4/40Ee2u0QIO91rgfZdZt1BPeokHrGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513172;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7g1O3+AMUjdU652869MtAy7jdfqLJuiqcLsd94SKaL8=;
	b=D+ml+oVXHzUw6azjpoDD+AdxCGfVmeAuhSSI6IjsiZDBT+JOGnsGEVQ60mQix+hBBlwS
	 aMBA8/qTc8FF6GvegoR5SpnCF5qDwZcshyeBlfTYyLvoZx/mQtx+/J8ZbNuZxhJ7k85++
	 HW11MIeGZDQFd3sgYlxwMU60puUy7bNiuT3pjujTZdth+LTn5J0LiMaLjRxzcu9A64xR5
	 vHv/BUSf2F5GVyGjjgw2QfBKGe4jtqLWSid19oGY60Nfc6VWOk2vxVHZIlXWRLL1bTbr0
	 0QYrwWZkbFbLNP3P2da+2Im97BAyC04/sPFEx+XLFHHK1iudBaTZG04moYNhxt1Q5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lJnrJ9q3;
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AA606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71AA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lJnrJ9q3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2t8VDdkxfN76z4f12I0ygVrVvOVbPTFc5XhNjpzAk+Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513169; v=1; x=1793117969;
 b=lJnrJ9q3HlCySm3fXdnACCgL6iXlSggZG56NZdVVRo7ED1ZoWbR59Id+W/Mh1+RYdmRtAEXu
 mV92PMBHR06S750jB1VAJJ4EQL1KW6KSQVfy8ejpOvpxIo3oHEjB7F17czfq/1G9j6GzgK+sUsf
 mRPta96f24vs1+4pyp2pPuN8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79913abc3e04dd01;
	Tue, 20 Oct 2026 16:19:29 +0000
X-Mizu-Trace-ID: 79913abc3e04dd01
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
Subject: [PATCH bpf-next v3 01/12] bpf: Keep the 32-bit range across a sign extension that cannot change it
Date: Tue, 20 Oct 2026 09:18:56 -0700
Message-ID: <20261020161907.2115379-2-vineet.gupta@linux.dev>
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

This patch addresses the verifier deficiency where it would throw away
a good range whenever that range crossed zero.

| 1: (54) w0 &= 63      ; R0=scalar(smin32=0,smax32=63,...)
| 2: (14) w0 -= 63      ; R0=scalar(smin32=-63,smax32=0,...)
| 3: (bc) w0 = (s8)w0   ; R0=scalar(smin32=-128,smax32=127,...)
| 4: (c6) if w0 s< 0xffffffc1 goto pc+2
| ...
| 7: (34) w0 /= 0
| div by zero

[-63, 0] already fits an s8, so insn 3 cannot change any value in it, yet
the range comes out widened to [-128, 127]. The guard at insn 4 then
cannot be resolved and the div becomes reachable.

The issue is the following check in coerce_subreg_to_size_sx()

	top_smax_value = ((u32)reg_s32_max(reg) >> num_bits) << num_bits;
	top_smin_value = ((u32)reg_s32_min(reg) >> num_bits) << num_bits;

	if (top_smax_value != top_smin_value)
		goto out;

which doesn't fire when the range includes zero, since the top bits
differ. e.g. for [-63, 0]:

    smin32 = -63: high bits all ones
    smax32 =   0: high bits all zero

The cheap noop test above it does not catch this either -- it only looks
at reg_umax(), which a negative smin makes huge.

The 64-bit twin, coerce_reg_to_size_sx(), had the same gap and was given
an equivalent early return by commit 0892ef2a7ef3 ("bpf: Representation
for intervals with steps"). This patch does the same for the 32-bit path,
for the s8 and s16 widths it handles. It doesn't improve anything in
selftests or corpora of external objects -- the shape above only shows up
in the test the next patch adds -- but seems like the right thing to do
anyways.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 5/13.
 - moved to the front: it is unrelated to the low-32 tracking (Alexei)
 - narrowed to the 32-bit path. Commit 0892ef2a7ef3 ("bpf:
   Representation for intervals with steps") has since given
   coerce_reg_to_size_sx() an equivalent early return, so Fixes:
   1f9a1ea821ff goes with that half.
 - measured inert: 0 instruction and 0 state changes on both selftest
   corpora and on 441 external objects.

 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 62f8951126ba..e1b41975a442 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6182,6 +6182,7 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
 	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+	s32 field_smin, field_smax;
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
@@ -6192,6 +6193,27 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
 		return;
 
+	if (size == 1) {
+		field_smin = S8_MIN;
+		field_smax = S8_MAX;
+	} else {
+		/* size == 2 */
+		field_smin = S16_MIN;
+		field_smax = S16_MAX;
+	}
+
+	/*
+	 * The range already fits the field, so (sN)v == v for every value the
+	 * register can hold and the sign extension changes nothing. The test
+	 * above misses this once the range straddles zero: it only looks at
+	 * reg_umax(), which a negative smin makes huge.
+	 *
+	 * This has to precede reg_step_reset() below: the extension is a noop,
+	 * so the base/step line still holds and there is nothing to discard.
+	 */
+	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
+		return;
+
 	/* See comment at reg_step_check_unsigned(). */
 	reg_step_reset(reg);
 
-- 
2.53.0-Meta


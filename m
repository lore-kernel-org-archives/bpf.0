Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132091;
	b=BrDGGf6e+RlUn7ZppZ7PEtDR2n+HGFssvO25QhSjTEzzEp9iEWWIJ0VSyeySNq0U2vPS
	 yAj8wKJKyb/n2uCbsxblrlUyya2wbMOBmq3x1cE9aPv0dgzHhHdFBxp3qfg7OrbTZ5faq
	 scZ7GAO0HtP8Faq+1qSI42yKvjF35vjL+w04pMSBuq6ou2QHoWUTbh1+X+178h8KHdVYd
	 ZsK/u4Vi2B7DM5yDp0ZqvNT1tmjEi0xPhxoHW4UnX34gvQ+t9UMGIhk47v4htbWEmwZPK
	 ONUONRMmCXrmHNngCOjP+akrxyipI4N9t0OQcFJr3QCNSUnb87Jt1ORpn76wCEZGnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Cst/7/2h1dvoCuAZvClJ9MauhVvXy0T/fu+4LQO2CM=;
	b=UxmFkHPn2vdzFM2D6dfrZHrbnOrpyH0soGaUUbW7mm/vHgtV1QVy3OfQqdCropVuzz/p
	 M8m2ClpKdP2S/N/rxtM8o3z1tkeVqkEpcrXJnN8nzN/1C9QpzfRRVWcpnKTdKqnpyC1O1
	 7xcGzQI8EjdJO4KPueVM1AxLKfkwibXII9b0R1S6ksDWfcBT1edGKVUMiQTq1VpYujyeq
	 drbJ3Yv/NFA5fpr2OQUw5VaK/aGdpsl6L2rbW1SXUMYscE7hrwuLw8Y4M/D2ITosxZAJJ
	 1QjcgO85eFw3ChgLp+w6ppRf4riIk0t/iU8Tk2NBFJQ3m6DSmpgIPpYlL5YlHT4pJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTga1cZM;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B73606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B73606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTga1cZM
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-886e61fa30fso138946b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793132090; x=1793736890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Cst/7/2h1dvoCuAZvClJ9MauhVvXy0T/fu+4LQO2CM=;
        b=nTga1cZM4dQzZbOZbpO1p487224aqBfnIQq4tuAckEsbNe/xWoim7iFwjczsdvUcIG
         DF3LNAplc52xDhnOna592lFF7bJArNmrvVRrCKFOWDGnZZHM6CHgKB0J4HxRP5yi8Rnm
         L4NCnc2ztbTR064vUSiSo9ym3cYeg9NHbqBUYTfNLi95n5IJ2r9pCRhtEabD++S+xz1a
         mp/ijAEIcVr0uHQu+EofuavNa8IbOzVoMbUjqCo76TBP4UYlhIJezHbkMo00W4yZFq5A
         CxFv3sKgc4DqtIn68spBDlBOB6tedAyraYsGPI5kcobVzkseIaC3utx4wrfrZedBl4FL
         qMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132090; x=1793736890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Cst/7/2h1dvoCuAZvClJ9MauhVvXy0T/fu+4LQO2CM=;
        b=IIAL5IyNNaXKkJ0dmV6xoNdmrh13Zt9oDftMYJjaF2qXCaeiwfP1KylP/zs3zFnlA/
         mSWNRTTa75YKKh/pveSfWEzC3CyMqv0H+mC3FKHbsbbsxLKS7/Y4R+4MyVXXFMFqQG93
         XoX9JW7bCtc9rp9NMhUKL8xrg9LzvlbpVVigZ+zNLI8oDzbevDZd+ygbUwOyNV2/0zl6
         jLnupAzXPxEvGeRRPFEzhMTi0/PEULduklXTM5n/ZL0VCVbpzP6gvJvdh+gvTCtouPJr
         s1kQRc7J5LvPoUwn7+u2s300R4YzNmiiPWg1e+27ZSwc2WtD0HDPvnWpDYMYjXA/2n0/
         p0Pw==
X-Gm-Message-State: AFq9FYJZH5ImHal4R6a5Z05l5hA+ipGtbISDd+ltu/F93eaLE1dH7Muv
	UyKH6x2LwbE+te+uAiFRPNChahnmL//O9YOmEXxti/8JflcBkLuVHK+9KUrQ1A==
X-Gm-Gg: AYBFou0/MgY92UFLVPruA/s+WQX0ga48Xzkgm7aBe6XxQkJlssGJv2wBV5tE+dYjhB8
	p5THcrXwM3S3Wvewx5k/1oT6d7XZyoLJ7O1PLItFIU8rPZcHA7umv53kaNI0uGWW4EcMKh+EVFz
	8ox+mICqPT8Uiw6/aU6UpD73iU1jwLIJUjqYPf6TEz/7qhXFdt1D3NubBAwJU08rFmpvw0AV6k1
	KL6szK84iF0sAWn7Qmnaq4AbQ5oU8NkyN/jImvq/RGei/Zgvqhr8mKgNa55WLEDwjkqZ9/n2ANS
	+CAKOkHvdfOvZcEQBfkNk6DpFEujaE0G3Phnh4HVpgr+7TJZtSaLBz8/wjpsrSsJjRe2NaV6Tmm
	wM3Qeanyudpa1/RwtT6uwdNW+QlrTd+vOPD0GpIwb4chplQ8W5I53aacuOFLXHJghEwcqYq5rGF
	8AAKqauONzZHHSc5n9GqlheqFEtt4C7WW3js8r6Irj5qNntxXLYQHzGqtTeKsZTI4JYO7tiQkgq
	dgaNoazJhNt4p7kVX53ibt7yyL22wkSS+BD1y+7jLQQD4n3SvYAEYuGkAaHMmjiLwcNTTx7YjZy
	YgVrgdK+GKkMgRLCtvrC6N9SAhLv3W2tMKohkE+siFlPKl4dPimpxrYHnm1kkC6F7GHi7gbpjWx
	CS1HptRZfja+8Iyk8RFo0CFAF
X-Received: by 2002:a05:6a00:4185:b0:86a:c062:8af2 with SMTP id d2e1a72fcca58-8a6e4052b89mr248056b3a.3.1793132089943;
        Tue, 27 Oct 2026 13:14:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5bd6asm460621b3a.4.2026.10.27.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:14:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test the valid bytes of a packet pointer in a counted loop
Date: Tue, 27 Oct 2026 20:14:36 +0000
Message-ID: <20261027201436.3192716-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

In each test r6 = pkt + r4. r4 is 0, 8 .. 48, but its umax is 50.

  test                                      umax gets smaller    result
  ----------------------------------------  -------------------  ------
  widen_pkt_pointer_step_lowers_umax        at the loop entry    reject
  widen_pkt_pointer_step_lowers_umax_down   the same, r6 -= 8    reject
  clamp_pkt_pointer_step_lowers_umax        at the back edge     reject
  union_pkt_pointer_var_off_lowers_umax     r6 is r6 or r6 + 8   reject
  widen_pkt_pointer_keeps_valid_bytes       at the loop entry    loads

The first three progs load without the fix. The verifier rejects the fourth
prog without the fix too, but only in the second pass. The test looks at
the range in the message. The last prog reads only bytes that the compare
with pkt_end covers.

widen_pkt_pointer_beyond_pkt_end makes sure that the mark "beyond pkt_end"
is not in the state at the head of the loop.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index fa01a616af9d..7b399bae0c60 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3936,4 +3936,162 @@ __naked void clamp_pkt_pointer_keeps_range_of_entry(void)
 	: __clobber_all);
 }
 
+/*
+ * r4 is 0, 8 .. 48, but its umax is 50. @bytes from r6 are in the packet: the range of r6 is
+ * 50 + @bytes.
+ */
+#define PKT_PLUS_R4(start, bytes)					\
+	"r7 = *(u32 *)(r1 + %[data_end]);"				\
+	"r6 = *(u32 *)(r1 + %[data]);"					\
+	"r4 = *(u32 *)(r1 + %[mark]);"					\
+	"r4 &= 0x38;"							\
+	"if r4 > 50 goto 9f;"						\
+	"r6 += " #start ";"						\
+	"r6 += r4;"							\
+	"r5 = r6;"							\
+	"r5 += " #bytes ";"						\
+	"if r5 > r7 goto 9f;"
+
+#define PKT_IMMS							\
+	__imm_const(data, offsetof(struct __sk_buff, data)),		\
+	__imm_const(data_end, offsetof(struct __sk_buff, data_end)),	\
+	__imm_const(mark, offsetof(struct __sk_buff, mark))
+
+/*
+ * r6 is 0..58 at the head, and 0..56 with the step of 8. The range must go from 58 to 56 too:
+ * in the second iteration no byte from r6 is in the packet.
+ */
+SEC("tc")
+__failure __msg("invalid access to packet, off=56 size=2, R6(id=2,off=56,r=56)")
+__naked void widen_pkt_pointer_step_lowers_umax(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 8)
+	"r9 = 0;"
+"1:"
+	"r0 = *(u16 *)(r6 + 0);"
+	"r6 += 8;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
+/* The pointer goes down. 8 bytes from the first r6 are in the packet, not 10. */
+SEC("tc")
+__failure __msg("invalid access to packet, off=120 size=2, R6(id=2,off=120,r=120)")
+__naked void widen_pkt_pointer_step_lowers_umax_down(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(64, 8)
+	"r9 = 0;"
+"1:"
+	"r0 = *(u16 *)(r6 + 8);"
+	"r6 += -8;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
+/* The access is in the second iteration only: the verifier gets to it after the clamp */
+SEC("tc")
+__failure __msg("invalid access to packet, off=56 size=2, R6(id=3,off=56,r=56)")
+__naked void clamp_pkt_pointer_step_lowers_umax(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 8)
+	"r9 = 0;"
+	"w1 = 0;"
+	"*(u32 *)(r10 - 8) = r1;"
+"1:"
+	"w1 = *(u32 *)(r10 - 8);"
+	"if w1 == 0 goto 2f;"
+	"r0 = *(u16 *)(r6 + 0);"
+"2:"
+	"w1 = 1;"
+	"*(u32 *)(r10 - 8) = r1;"
+	"r6 += 8;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
+/* r6 is r6 or r5 = r6 + 8 at the head. Here var_off lowers umax. */
+SEC("tc")
+__failure __msg("invalid access to packet, off=56 size=2, R6(id=2,off=56,r=56)")
+__naked void union_pkt_pointer_var_off_lowers_umax(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 8)
+	"r9 = 0;"
+"1:"
+	"r0 = *(u16 *)(r6 + 0);"
+	"r6 = r5;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
+/* 16 bytes from r6 are in the packet: two iterations read 8 bytes each */
+SEC("tc")
+__success __retval(0)
+__naked void widen_pkt_pointer_keeps_valid_bytes(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 16)
+	"r9 = 0;"
+"1:"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r6 += 8;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
+/*
+ * r6 is beyond pkt_end in front of the loop and comes back into the packet. The mark is not for
+ * all iterations: the verifier must look at the two branches of the compare in the first pass.
+ */
+SEC("tc")
+__success
+__log_level(2)
+__msg("widening r6 to 32..96 step 32")
+__msg("6: R6=pkt(id=1,r=0,smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=96")
+__naked void widen_pkt_pointer_beyond_pkt_end(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[data_end]);"
+	"r6 = *(u32 *)(r1 + %[data]);"
+	"r6 += 96;"
+	"if r6 > r7 goto 1f;"
+	"goto 9f;"
+"1:"
+	"r9 = 0;"
+"2:"
+	"if r6 > r7 goto 3f;"
+	"r0 = *(u8 *)(r6 - 1);"
+"3:"
+	"r6 += -32;"
+	"r9 += 1;"
+	"if r9 < 3 goto 2b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:: PKT_IMMS : __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394605;
	b=LiN2BXggKCyv3nUPqLaCF83mrTI1DcQtlZk+Y0kCbYUYnrqGM+nwmEOpXcAJ+t4O5WH/
	 uQYczlI3O7NANpn+KHyKGL8jGpraExyEsSdjCBAgDuRZ6iX7+1Ow0rbS2x3GkVsU3IbKn
	 hFXnv277IxOFa+wHB29vTn6OG4Q+e5PB6iNthaJL+9KcKrYXtb7Qd+kwBQAsz1owdEcki
	 YZ+I/VjCcO8UwUP1a9NGDZnlm2HixDUA99NRjuUtYB7cinfrfcMWx9CqPbFQfskgTka4C
	 ENelZl454KHOQnohMcboMnp648cWDUefHB6sDow5DqErXQJzgwU7qJxqKCAAcAg51LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2eWUMS2+ezGEv3VSKsBCsTcRq38lP78Aysa+2VWEh2k=;
	b=bVI2pl4B6pnlXbHfjRM2QXiVbfId+sn8l2jR8eN4LnCzU6NX7ne1fbg7A8boNCDiTVQ1
	 m1wNSeaJQtPepj+ce+MPvgYjPAgUHCIQMFtcjtXahc3yL1rbdzbeuZUv7KHxk1yMlvaI0
	 O+3PKQeczqWIVEJsHOoQwGVk/BsaI6LvcRdOjuokrDKofrFiXGfYysYFO42vzSQqp/NtN
	 Rlw7jlT/c9vK3ZNpIMifsawbCNIzurJ+oLeZsFzb31SCEpHH/PzOFkcCIz+02gbBjahu4
	 yKAS4Dkj4VjWZpJC5wvvM8cKeyYG8jVRZNV2QzzPsNIAeXn+DxITWBOQO6FEoybnU0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=thdwtGgG;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCB606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66FCB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=thdwtGgG
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso841950a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394605; x=1793999405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eWUMS2+ezGEv3VSKsBCsTcRq38lP78Aysa+2VWEh2k=;
        b=thdwtGgG2XBxvv09kLDxLO80vDEM58PgBBjk/qwQwh8jgwPG86apsBVwbxQmiQGtP6
         vXOuI7S/8/D0ZCwd9GTf1N0KXMHEaPmizBhea8jU8kcK8+JXHMYzdvEqOXb+j5DDe7b+
         rq07A77a8dBF+rL06YSYk0lreltNfzrMs9Q6qMVZI0G5jYvLyixNh/0Ri1jw28pRq8zY
         3rxgKQPEcWLzs3Gr6PDIfmEEZPnWKlgauhhsGcdXEHMqtYkbxP5mlr1fJN8zmKveIhmo
         SJi9WNEhxfokhwDgmpx4fJ4YLtjEkitGKBHm0Z+T44Cy0UpkS0qIIXEEeFzQQUxn9Y4Z
         XVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394605; x=1793999405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eWUMS2+ezGEv3VSKsBCsTcRq38lP78Aysa+2VWEh2k=;
        b=zyV+4ibNURU8CIzGf2ITc/z6gDwpPZWGLY3uEqY8dhoBxapRhs3w6TeMl3rjOSdfw3
         a8/WK/1QtVorSeGzCrW7mdjQdqokEQJRBCEHeTzcoCeY2MZYoIfsqQaGI4rLd86Gh/7G
         yw30KIxKoPq/IgXg3Ht0wUqlgCFpAmW2f/OmHVNvnfeR9ox5qxCK2xfg6TQrbKyc2q5S
         Dbwnqihm2/Hgcfl031CEchnVvIXEwjxrS1l+DlZYy14iAH0S+VA+ddpW7uZjS2i84tDd
         JIkRJSouhzya5RkBHELum6eMjd6f9bOUzquFHS223+a6rOhEeVuCbdTS036/2mfwzgE3
         s4vA==
X-Gm-Message-State: AFq9FYK3zfa8OHn85IqmmsC/h8BP1x36buLVT2uDjnTCrvTthaBugagd
	KLLWkvgy+hy7QBSgkBXaIcGIZ3PQC24V2KS0vHNtqK3AoiNLDWof3XcVCqve0w==
X-Gm-Gg: AYBFou0wedqxbH6BzvoLFMXdRGrUhN6i0od0HqFMdhCh9/Xs4mv8uD8LSmy8LCi8/fl
	GBmtAkgXaM8JYh5BDhzZl8INBMA86Zbk3/HmJ307z2PkvgyaID743PL0QZrn6Qn2pM7iOVXFQ81
	qi7TqWJEO9Gav+KaF1ViP42ZfQKxhsK7UfYJa5YDvjFbgzF1Rlvsrj35LRB17Fl4BJh4iTjGeR1
	N04XZoIM5NpztiHy9nAZU1RmZGxnos2yViDBWtA7nk5/opRQ7yf4ogpcPQDGuuyaSVpa1YRQj5W
	hPS7rODYHjXdzVungVXaB7J5v1Inwf00OMHFY4agj7Mo3hMGD4qEj4kuXqo+WQ2Jb7HEYWiACzO
	Jl/1BZRJfnTApmRaW4B7BNdTiHnftgwSUF2HOz+6gDWQ3oD5nd/eMXRcZ5Nmt9SGF05eEz3nkUJ
	BSIulj3rInFB7y5JvIkrzBygyoOdwHBQai9OJp6hNko5vHVTTeV5Jcver2IuLZuUATlcj8+aZ6e
	YUHMlauc0st/hsAbJg5HiK8SUXQqdKbfSAFu3yxPnldeUj+MTVnxhDIz7rcNOhxntORqvOAsn/e
	P8NFFNR/8ULD1/zS3YxXizWtW1iVJFCeuVWNpjcojuUCun3JjomcOExq97+FAepUswdnHM7kn3F
	dNMFVsmpjKaaBfGUWzZpjrFTUkH3ps/5IsNMaP3kLgz6ahQ1suYMq8PFQaj0K++23gQq3+xp3vA
	==
X-Received: by 2002:a05:6a21:151b:b0:3e2:95fb:8cff with SMTP id adf61e73a8af0-3e928a29f19mr2866757637.55.1793394604586;
        Fri, 30 Oct 2026 14:10:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada7b7d09sm401054b3a.44.2026.10.30.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 2/2] selftests/bpf: Test the valid bytes of a packet pointer in a counted loop
Date: Fri, 30 Oct 2026 21:09:50 +0000
Message-ID: <20261030210950.1904640-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
References: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
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

Each test adds r4 to a packet pointer. r4 is 0, 8 .. 48, but its umax is
50.

  test                                      umax gets smaller    result
  ----------------------------------------  -------------------  ------
  widen_pkt_pointer_step_lowers_umax        at the loop entry    reject
  widen_pkt_pointer_step_lowers_umax_down   the same, r6 += -8   reject
  widen_pkt_pointer_negative_offset         no, only smax        reject
  clamp_pkt_pointer_step_lowers_umax        at the back edge     reject
  union_pkt_pointer_var_off_lowers_umax     r5 is r6 + 8 or r6   reject
  widen_pkt_pointer_keeps_valid_bytes       at the loop entry    loads

The first five progs load without the fix. The last prog reads only bytes
that the compare with pkt_end covers.

widen_pkt_pointer_beyond_pkt_end makes sure that the mark "beyond pkt_end"
is not in the state at the head of the loop.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index fa01a616af9d..0be4fe8aadc7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3936,4 +3936,186 @@ __naked void clamp_pkt_pointer_keeps_range_of_entry(void)
 	: __clobber_all);
 }
 
+/*
+ * r4 is 0, 8 .. 48, but its umax is 50. @bytes from r6 are in the packet: the range of r6 is
+ * @start + 50 + @bytes.
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
+/*
+ * r6 is -8..50 at the head, and -8..48 with the step of 8. Its umax is U64_MAX in the two cases.
+ * r5 is 0..56 and has the range of r6. In the first iteration no byte from r5 is in the packet.
+ */
+SEC("tc")
+__failure __msg("invalid access to packet, off=56 size=2, R5(id=2,off=56,r=56)")
+__naked void widen_pkt_pointer_negative_offset(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 8)
+	"r9 = 0;"
+"1:"
+	"r5 = r6;"
+	"r5 += 8;"
+	"r0 = *(u16 *)(r5 + 0);"
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
+/* r5 is r5 = r6 + 8 or r6 at the head. Here var_off lowers umax. No byte from r6 + 8 is valid. */
+SEC("tc")
+__failure __msg("invalid access to packet, off=56 size=2, R5(id=2,off=56,r=56)")
+__naked void union_pkt_pointer_var_off_lowers_umax(void)
+{
+	asm volatile (
+	PKT_PLUS_R4(0, 8)
+	"r9 = 0;"
+"1:"
+	"r0 = *(u16 *)(r5 + 0);"
+	"r5 = r6;"
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


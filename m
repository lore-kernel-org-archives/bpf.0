Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983827;
	b=WH9wU8dVOZCLilwCHLDum/8X9oQL4kaXCFLDs6r5+f2kW9YQv1bUDo1L4jYUc8PBQcFp
	 iDgqawgX3doXW3tf1RWkPuYvHGcMfupA282meXbP14jx66bz1WVaMjkb9gAkbxu1FdyHr
	 Gn9FfAtoryloBgELlfEZMtru61Z7dNYhsbJf02RWEC9PKaLo5M87I2A2TuoTWDhS38YHs
	 VWLOgPBiwxxC2Mctg7qUl4quKuhHXgYZkj2VPCXMfuD4ME4ilpMPRc+xbdPNKz21Vaard
	 VDbJJpUgB/TcKaiT/uI5KawF9Xalg0SeT+CR+bqB8LgLpLOzwwNX/MrlflD7VFxazjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E1Ef4wYoigg93/xyq+zz/obozmm3aErQHKqZZIT1OQI=;
	b=BnfrYlgaToJUJ3sta/kkq2qwdsFGGB3yirQzvfaCWOYMgjQsONVh6Ui1Jt91/p5U8QqF
	 hnJKS32uudQ2cgWRBNnIW59WsfHdsYm2jJ9zdpJS85EpokCla6TJJfoVguIThUnqkeQfb
	 WZ09D30SBN78C6vzJl7QR7MXYOqW6wjMSt3dlUF51kIBRn+pJt23/VLZttVowTWdr/UHr
	 Hzxn2C0uXlbkbodzbCLi7BpdY0sCsHXWovv4HNHOxbdz5cgpCXr+O6P2n/QFQ7/AmAd/W
	 bM1lmNhsm3oKUp4CrT/ZU06XkNfChplg7UzqdPM19xepKhfaJJWuuto4kWdqnpnUT9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XIuVlYyl;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XIuVlYyl
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12914385ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983827; x=1793588627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1Ef4wYoigg93/xyq+zz/obozmm3aErQHKqZZIT1OQI=;
        b=XIuVlYylS7cDUysRMVFmHCsQW/x1R+x4jRV0mTT+I5OfQ6T+PBg+WtuQ0VYyLCwFql
         yfAO3hA850Tvy4A5qmmMqds7II0gb9FmTl8/miaxdtZjLwsbvuybSrHAltr5SbW4uKBI
         M2DV7H+7ljra3EMKy7AaPT9AUkd2cHyPxbLgIL0nIj7HvOGajjI8Hae8+JpiryR6At1P
         +gU2k4NI/Qb9hViipfppVg+Ouh/CY+XPFKixGyBzPwygFn3wFS+p4hfdMbNjYSQ5Zb70
         7R8Qi9nPG8pjOOBze4drBxC+elObn0LFTsRQLO9XCoccMvbZRMjSPnXKCsLZPNFKgudJ
         dVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983827; x=1793588627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1Ef4wYoigg93/xyq+zz/obozmm3aErQHKqZZIT1OQI=;
        b=N6P7ucRbTnQmos9IZPItwA+hwGaHWeOskEs7HvzMCG9Um8Z//0Iu0Lo3BZhpetQT7W
         UVtYVk0/9G8dJ5ZiOVxPMB8N/GLiGPGRfTdMpEePL3uccUgRmMt7KCt5fij+d9FCDVAh
         VeZkkP+Bkwin2wHdoBwbojgqBwkM9U1IexnTpAWyynzavcUgminmCKB2BpdeRp+dUvq+
         Q+kjT61nuUEYyeVoBmgmhaOF2P6kTZTMQFrAipbHL5y66rSg8DHfo2l5j7nBVg1zB+No
         ITFZ9oNfPAvF4qnE6yAebeg1mCY9zfptxcUtnw0EgAIB74GINVLqyKGNRc/YRm/FiQZy
         +pIQ==
X-Gm-Message-State: AFq9FYILFVz0cAmwm7IgAH/V+I2RmspnnTf/33WfviXqJgp6GL/Gn/Ya
	J6u53470l7jy2oqw84uOfxLC/r2XZjX3/zZmXsQ7Gi5Zd0heO0uJMJnqa5V9/Q==
X-Gm-Gg: AYBFou1LCBOT8jAiW+7qhxfeYfiPrHioagsvpuddxiP/H2Rj6qqFmxHRSPJuishZ+KF
	AJD9apaDsJLyw9ziL14hOMytpqqRtXIl90Esejgsov/iPWHQNwQCAZWlsQH0YNCzvFFCFuI0Jf/
	4OMmutl0x+NhAUrkpWLztSFWGpQXgk7h7N2sw2DSws1KbJJg6cdpudfzdr6WnFkUvjdSpZ+OBuI
	Se4QOX0bAPzCKqFodwrJY5sQLbehxaY1jhZijpx0v4GXOKv93ZCNiC4pUetyTJXZYYDXckfuKLp
	AGavObdWqntyRo2/9/gtm1/+8WOyiWlbVmHfKashfFujgbVu2F3zSGmpBV3HFxkUKD6KysZSk6t
	IVwi+AaEunUIqKJui9E2b+ZuD35ojxnCtnNq4mpTMOrcWdyQAseh74pLUGTsS1GOt32d7rrslzH
	b2fEXD1TXqNsLiaLbz19nJhPUTpu19EONyvoUilbVMD+X9WSX+oV0brwUp/mQLKj4PSG/UGpF2t
	gYMNZmSdkresu1I7ZtKHwxaaSmlu8gtFGogvF7dn9J2sACBvtJCSzOCKL3Scx8S/9j7msB4fglM
	TvullAZqkdYrVpALOY0FEyoOdc0gnbJAMOuFwZ85rYQk4GhQbWqzCj1ICuZ9MGTrc8a046+L9gP
	ZlY7fvrn9XdBFW+1xokKp6i04
X-Received: by 2002:a17:90a:e7c1:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adeabe0cc2mr4974182a91.30.1792983826489;
        Sun, 25 Oct 2026 20:03:46 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebfa4102sm6466062a91.12.2026.10.25.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 41/81] selftests/bpf: Test range of a packet pointer after a number is added
Date: Mon, 26 Oct 2026 02:59:02 +0000
Message-ID: <20261026025943.404450-42-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier keeps the range of a packet pointer when the prog adds a
scalar >= 0. The range must permit exactly the bytes that the prog checked.
In these tests the prog checks 54 bytes:

  test (pkt_add_...)      added                 8-byte load  result
  ----------------------  --------------------  -----------  ------------
  range_keeps_range       [0, 38]               +0, +8       loads
  range_load_past_range   [0, 38]               +9           reject, r=54
  range_twice             [0, 20], 1, [0, 20]   +5 fits, +6  reject, r=54
  negative_drops_range    20, [-4, 4]           +0           reject, r=0
  one_of_two_offsets      38 or 22              +0           loads

A comparison with pkt_end sets the range of all pointers that have the same
id. This is correct only if the distance between these pointers is a
constant. In these tests the prog has two equal pointers and moves one of
them by a value that is not a constant:

  test                    what moves the pointer     compared  used  result
  ----------------------  -------------------------  --------  ----  ------
  kept_range_old_pointer  r7 += [0, 7]               r7 + 100  r8    reject
  kept_range_new_check    r7 += [0, 7]               r7 + 100  r7    loads
  loop_other_pointer      r7 += 1 in a loop          r7        r8    reject
  loop_same_pointer       r7 += 1 in a loop          r7        r7    loads
  loop_one_of_two         r2 = pkt + 1000 in a loop  r2        r9    reject
  merge_const             r7 += 8 on one path        r7        r8    reject
  merge_displacement      the same, both have an id  r7        r8    reject
  merge_number            r7 += [0, 15] on one path  r7        r8    reject

Two more progs must be rejected:
 - kept_range_merge adds [0, 7] on one path and [0, 15] on the other path.
   The load fits only [0, 7].
 - kept_range_var_off is the prog from commit b88822d2584f
   ("bpf: Fix packet range of pointers sharing an id"), with a pointer that
   keeps its range.

loop_other_pointer is from
https://lore.kernel.org/bpf/21a8e3dfacb4269e348b10544c43cd05f785737b.camel@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_direct_packet_access.c | 375 ++++++++++++++++++
 1 file changed, 375 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 139ff019d87d..aa4abe22655f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -1098,4 +1098,379 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/* 54 bytes are checked. What is added is 38 at most, so there are 16 left. */
+SEC("tc")
+__description("direct packet access: a number in a range is added to a checked pointer")
+__success __retval(0)
+__naked void pkt_add_range_keeps_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r5 = r2;					\
+	r5 += 54;					\
+	if r5 > r3 goto l0_%=;				\
+	if r4 > 38 goto l0_%=;				\
+	r2 += r4;					\
+	r0 = *(u64*)(r2 + 0);				\
+	r0 = *(u64*)(r2 + 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a number in a range is added, load past range")
+__failure __msg("invalid access to packet, off=47 size=8, R2(id={{[0-9]+}},off=47,r=54)")
+__naked void pkt_add_range_load_past_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r5 = r2;					\
+	r5 += 54;					\
+	if r5 > r3 goto l0_%=;				\
+	if r4 > 38 goto l0_%=;				\
+	r2 += r4;					\
+	r0 = *(u64*)(r2 + 9);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+/* twice: 20 + 20, and a constant in between */
+SEC("tc")
+__description("direct packet access: two numbers in a range are added to a checked pointer")
+__failure __msg("invalid access to packet, off=47 size=8, R2(id={{[0-9]+}},off=47,r=54)")
+__naked void pkt_add_range_twice(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r5 = r2;					\
+	r5 += 54;					\
+	if r5 > r3 goto l0_%=;				\
+	if r4 > 20 goto l0_%=;				\
+	r2 += r4;					\
+	r2 += 1;					\
+	r2 += r4;					\
+	r0 = *(u64*)(r2 + 5);				\
+	r0 = *(u64*)(r2 + 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a number that may be negative is added to a checked pointer")
+__failure __msg("invalid access to packet, off=16 size=8, R2(id={{[0-9]+}},off=16,r=0)")
+__naked void pkt_add_negative_drops_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r5 = r2;					\
+	r5 += 54;					\
+	if r5 > r3 goto l0_%=;				\
+	r2 += 20;					\
+	if r4 > 8 goto l0_%=;				\
+	r4 += -4;					\
+	r2 += r4;					\
+	r0 = *(u64*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+/* off = x ? 38 : 22; the compiler makes one load of it */
+SEC("tc")
+__description("direct packet access: one of two offsets is added to a checked pointer")
+__success __retval(0)
+__naked void pkt_add_one_of_two_offsets(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r5 = r6;					\
+	r5 += 54;					\
+	if r5 > r3 goto l0_%=;				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 38;					\
+	if r0 != 0 goto l1_%=;				\
+	r1 = 22;					\
+l1_%=:	r6 += r1;					\
+	r0 = *(u64*)(r6 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+/*
+ * See commit b88822d2584f ("bpf: Fix packet range of pointers sharing an id").
+ * r5 keeps the range of r7, r6 is r5 + 8. umax of r6 has to be 58 and not 56.
+ */
+SEC("tc")
+__description("direct packet access: a range that is kept, var_off and umax of two pointers")
+__failure __msg("invalid access to packet")
+__naked void kept_range_var_off(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r7 = r2; r4 = r2; r4 += 51;"
+	"if r4 > r3 goto 1f;"		/* range 51 */
+	"call %[bpf_get_prandom_u32];"
+	"r4 = r0; r4 &= 0x38;"
+	"if r4 > 50 goto 1f;"		/* umax 50, var_off (0x0; 0x38) */
+	"r5 = r7; r5 += r4;"		/* umax 50 < 51: the range is kept */
+	"r6 = r5; r6 += 8;"		/* umax 58, or 56 */
+	"if r5 > r9 goto 1f;"		/* sets the range of the id from umax of r5 */
+	"r0 = *(u8 *)(r6 - 7);"		/* r5 + 1 */
+"1:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a range that is kept, 0..7 or 0..15 are added")
+__failure __msg("invalid access to packet")
+__naked void kept_range_merge(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r7 = r2; r4 = r2; r4 += 64;"
+	"if r4 > r3 goto 3f;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0; r6 &= 15;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r6 &= 7;"
+"1:	r7 += r6;"			/* [0,7] or [0,15], range 64 */
+	"r0 = *(u8 *)(r7 + 49);"
+"3:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a range that is kept, the sum is checked, the pointer is used")
+__failure __msg("invalid access to packet")
+__naked void kept_range_old_pointer(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r7 = r2; r8 = r2; r4 = r2; r4 += 16;"
+	"if r4 > r3 goto 1f;"		/* range 16 */
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 7;"
+	"r7 += r0;"			/* new id, range 16 */
+	"r4 = r7; r4 += 100;"
+	"if r4 > r9 goto 1f;"		/* r7 + 100 is there */
+	"r0 = *(u8 *)(r8 + 106);"	/* r8 + 100 is, r8 + 107 is not */
+"1:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a range that is kept, a check of the sum")
+__success
+__naked void kept_range_new_check(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r7 = r2; r8 = r2; r4 = r2; r4 += 16;"
+	"if r4 > r3 goto 1f;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 7;"
+	"r7 += r0;"
+	"r4 = r7; r4 += 100;"
+	"if r4 > r9 goto 1f;"
+	"r0 = *(u8 *)(r7 + 99);"
+"1:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+/* Nobody knows how many times the loop ran, so r7 < data_end is not about r8 */
+SEC("tc")
+__description("direct packet access: one pointer moves in a loop, the other one is used")
+__failure __msg("invalid access to packet")
+__naked void loop_other_pointer(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r7 = r2; r8 = r2; r9 = r3; r6 = 0;"
+"1:	if r6 >= 10 goto 2f;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 42 goto 2f;"
+	"r7 += 1; r6 += 1; goto 1b;"
+"2:	if r7 >= r9 goto 3f;"
+	"r0 = *(u8 *)(r8 + 4);"
+"3:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a pointer that moved in a loop is checked and used")
+__success
+__naked void loop_same_pointer(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r7 = r2; r8 = r2; r9 = r3; r6 = 0;"
+"1:	if r6 >= 10 goto 2f;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 42 goto 2f;"
+	"r7 += 1; r6 += 1; goto 1b;"
+"2:	if r7 >= r9 goto 3f;"
+	"r0 = *(u8 *)(r7 + 0);"
+"3:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a pointer that becomes another one in a loop")
+__failure __msg("invalid access to packet")
+__naked void loop_one_of_two(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r2; r7 = r2; r7 += 1000; r6 = 0;"
+"1:	if r6 >= 3 goto 3f;"
+	"if r2 > r3 goto 3f;"
+	"r0 = *(u8 *)(r9 + 999);"
+	"if r6 != 1 goto 2f;"
+	"r2 = r7;"
+"2:	r6 += 1; goto 1b;"
+"3:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: 8 are added on one path, the other pointer is used")
+__failure __msg("invalid access to packet")
+__naked void merge_const(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r7 = r2; r8 = r2; r9 = r3;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r7 += 8;"
+"1:	if r7 > r9 goto 2f;"
+	"r0 = *(u8 *)(r8 + 7);"
+"2:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: 8 are added on one path, pointers that share an id")
+__failure __msg("invalid access to packet")
+__naked void merge_displacement(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r6 = r2;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 15;"
+	"r6 += r0;"			/* id N */
+	"r7 = r6; r8 = r6;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r7 += 8;"
+"1:	if r7 > r9 goto 2f;"
+	"r0 = *(u8 *)(r8 + 7);"
+"2:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: a number is added on one path, the other pointer is used")
+__failure __msg("invalid access to packet")
+__naked void merge_number(void)
+{
+	asm volatile (
+	"r2 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r3 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r9 = r3; r7 = r2; r8 = r2;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0; r6 &= 15;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r7 += r6;"
+"1:	if r7 > r9 goto 2f;"
+	"r0 = *(u8 *)(r8 + 7);"
+"2:	r0 = 0; exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0


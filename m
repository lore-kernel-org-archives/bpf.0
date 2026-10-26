Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983676;
	b=xDAy0C7k2KD+Jgt63mgnvpPB3a66bK2UczCUTuyNdQ6tGR5dCP4YgZj5/jy1FFmW2o2i
	 hArsRTUmOe0R5m4mYW6/mNtrz89oEBTPX1JLI++p5+n6dBmNj4twifVcrI7Uk4iFZLGeW
	 0p12ndOmoYT3H+ilH40S1jP/qHFwLvcVRKdTZ1M1d6X16eAPvqFApVxZnXppfgGfuWUc5
	 cZA0gC49CpI7RJGgR0RdCL46aHDO1n0jFnhslqU0aavO+jBvHyU5xKYsLNZqp2/gUcunh
	 rH5hNeHPInGmzVkVqKZCKaELjckGXgpUpaGpjN5Yos0MyRMUY8UHpIn5k6KyH8r/QeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sds/TkNBuU5pQVTR8GJWGcyV0odwemTdv4iZhsgrumQ=;
	b=ehpvnajaUNqRGvy3xgojhLBKt9c12bS1jocXHE/KRHQnTFwc3K/AdtSwFcs22A2uZA+i
	 TsycUOKBt4fmyPui6R8cdGWyPbR1+mpVqsQhihjEopTc9VXQMvpdJ98Ww75m1yJ52VL3w
	 1I6z44RqT/nfwbNLI16TocFIJk6zU1SucaBOZHaZq2EfPIIifKTfI8Q7LhcHI5QIA4qLp
	 vGHDDKCCCQsoSDYF16vURndrsWuZV6YmRSJx/jU1AzTb06B6lvqalqmsvOXnhTMIkvoKw
	 qzP3MQhthLCpl45oqqz5mY+01GU2Ea9smGOJZkOwLUJcMO01YUFwjXvmpnaDn4wzaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ElBtLCuf;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4027606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4027606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ElBtLCuf
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea7190aea1so11032995ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983675; x=1793588475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sds/TkNBuU5pQVTR8GJWGcyV0odwemTdv4iZhsgrumQ=;
        b=ElBtLCufJar2kqbuvH0Ls1/bQdcEQEkdqAUtslWFmZor8NDQUqMvUjQH97gv6Y5TTu
         yQ4C0lCIbDNQleFb4srcKhe8tQi01V32lTgVvP3cCOtFyHyCOBc2/ZTYrCWQ8Ooi8EIJ
         jxyETg4uCB4d4+j6uLsAZIBuCI+wH1Fybjq6vM44XuIQkGTo+SNj0S6HVSm+Jwf+5tZz
         I/3t/HdZ8RECodOaLYc2OlwoVWxUTpQlu11pPR1dOsxVDRKyDoNUaMWzeACUPWPAkq8b
         Sv+fjZE3UfSfpYJ1xBIdbRJAWKl0J+PkIrSc3Xr0SyTzdbxdPjVpIVT7CeGm/okn5Z14
         EwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983675; x=1793588475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sds/TkNBuU5pQVTR8GJWGcyV0odwemTdv4iZhsgrumQ=;
        b=tpNQOM3zhngJ+2csXnzE2V2K4l4sDP2ngulTwLDoxKlY+rIwj7xva7n7eJ4pWy5MFi
         eVJu2G0EeCHteou6bOS7u4cCWfPYwdh6NBBbZ/HxRG/RLOTl8qeA0+lKUkaH329AaSat
         6znrp+QmDmWRYhnuCoRzcfkDfVardJkcsY4QS2manbokd6Tz403SJICw1Pwip7xPHM9t
         9U9H2EKcfMP/Bete+aHFO7dn/KVOrevZ8MSNuz6qYfUbvhyBB3DpWHzyKdp2PiXCOL2n
         fctTJLoR0O6v/JJrTmYAdoSlKuuqrxhI0QKQ4tPP5XAqiUM0U94JA8A4l+3DTVYB0Var
         hmiA==
X-Gm-Message-State: AFq9FYIWFitiC93QLF7sWJvYm8ul/DEoBhsartK9RPOC/7qByzIjjJSF
	wSE99ZMMWlQwo8lNdb4bYgO1kadKNthyNoBpOiiEq8RkPIizbU6rkhn1rFEMwQ==
X-Gm-Gg: AYBFou1u00aPIXib7HoW2HARwkbIE54zc2TXY8BOmb2dSwbkXgfR6to7IHM8OQqBbJ4
	sIbN4Ey0YTD3y9lTROChH44HU0Jjej5BzJwEgs+tLUQmUoNaTBvXTDQkMqycagzetXcmZRa2W0M
	eIjeF2Evvt6L9A9CJ74Rh5JsGReHkakHG1fJbShr70MBrKKRKrdqR5y+RuaczUdgz/vsU9T5TP+
	XZ0Oh0BpODoejKPiIl/P5tnpDr9+DzCcdF9m0sdLzkIG8fRQKu/77w34fz9I6np253LlX4fJLOe
	lJPFK5AxGhWwGmkPnbvAKqL5+SWYYlC7jsg3gs9OYg+R9zprI6nsO9iiUzV4aboDAx7DLu1JZI1
	iA/yi1hfpkEGTJgnrzKFN7w607yIuT0D14oL0mQAHWDwmUt3GGEbsSpnSn4+x3REU51K77IhALX
	Xk/Axv1F5sqphzJu4EJWASemn4HDmya5tYlUQ84zmD1IjyIdSxMSTJ/eIMW4BJ6sCMFhW16RyGX
	VUrYaCt20ULw3TfH7FiEHpvaJhcYXcOCNqb3Rzt++gcFzb3MPorPJFd6RqGa4yudR20Eu5PS1rU
	jbbZtEx2fwLBA/RTDenJ0JyZ9RUhan/TJw5g7D587k2PFhqyeSVqLoI4p6psGN6So4pRF/M8adP
	AQmFSxrz9KnR8Kq/dPHKR+/6G
X-Received: by 2002:a17:903:2284:b0:2e9:7ff5:544c with SMTP id d9443c01a7336-2ea9c6c75c7mr41452355ad.25.1792983674865;
        Sun, 25 Oct 2026 20:01:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14a670sm10174915ad.27.2026.10.25.20.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 15/81] selftests/bpf: Test induction variables that come back out of range
Date: Mon, 26 Oct 2026 02:58:36 +0000
Message-ID: <20261026025943.404450-16-alexei.starovoitov@gmail.com>
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

In each test two variables of a loop count together, and a jump in the loop
tests one of them. See
"bpf: Fix a false verifier bug in the clamp of scalar evolution".

  clamp_out_of_range...   the variable, or the problem             result
  ----------------------  ---------------------------------------  ------
  (no suffix)             a register                               loads
  _1m                     1M iterations                            loads
  _step                   has a step                               loads
  _stack                  a stack slot                             loads
  _index                  an index into a map value                loads
  _32                     out of range in 32 bits only             loads
  _off_step               in range, but does not fit the step      loads
  _const_off_step         the same, and it is a constant           loads
  _64_and_32              no number is in the two ranges           loads
  _64_32_and_step         only the three parts together are empty  loads
  _leak                   the prog leaks a reference               reject
  _two_entries            the prog writes to freed memory          reject

The last two progs have a problem in a part of the state that is not
clamped. The verifier must find it, although the path to the problem goes
through a state that never occurs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 331 ++++++++++++++++++
 1 file changed, 331 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 504cf8230625..61bb39a12de2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3484,4 +3484,335 @@ __naked void dominating_exit_bounds_count(void)
 "	::: __clobber_all);
 }
 
+/*
+ * r6 and r7 count together. At the head of the loop both are 0..9 and nothing says
+ * that they are equal: r7 = 9 gets through the first jump with r6 = 0..9 and
+ * r7 = 10 comes back with r6 = 1..9. There is no such iteration.
+ */
+SEC("socket")
+__success __retval(0)
+__log_level(2)
+__msg("loop header at 2, widening r7 to 0..9 step 1")
+__msg("loop header at 2, clamping r7 to 0..9 step 1")
+__naked void clamp_out_of_range(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r7 = 0;"
+"1:"
+	"if r7 != 9 goto 2f;"
+	"r7 += 1;"
+	"r6 += 1;"
+	"if r6 < 10 goto 1b;"
+"2:"
+	"r0 = r7;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* If r7 is left as it is it's out of range in every trip that follows. */
+SEC("socket")
+__success __retval(0)
+__naked void clamp_out_of_range_1m(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r7 = 0;"
+"1:"
+	"if r7 < 999999 goto 2f;"
+	"r7 += 1;"
+	"r6 += 1;"
+	"if r6 < 1000000 goto 1b;"
+"2:"
+	"r0 = r7;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* r7 is 0 or 256 at the head, 256 goes on, 512 comes back. */
+SEC("socket")
+__success __retval(0)
+__naked void clamp_out_of_range_step(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+"1:"
+	"if r7 s<= 18 goto 2f;"
+	"r7 += 256;"
+	"r1 += 1;"
+	"if r1 < 2 goto 1b;"
+"2:"
+	"r0 = r7;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The variable is in the stack. */
+SEC("socket")
+__success __retval(0)
+__naked void clamp_out_of_range_stack(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+"1:"
+	"r1 = *(u64 *)(r10 - 8);"
+	"if r1 != 9 goto 2f;"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r6 += 1;"
+	"if r6 < 10 goto 1b;"
+"2:"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The 64-bit ranges have 1..0x7ffffff9 in common, the 32-bit ranges nothing. */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void clamp_out_of_range_32(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"if r1 > 3 goto 2f;"
+	"r3 = 0xffffffff7ffffffc ll;"
+	"r1 += r3;"
+	"r6 = 0;"
+"1:"
+	"if r1 & 0x80000007 goto 2f;"
+	"w1 += 1;"
+	"r6 += 1;"
+	"if r6 < 4 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * r7 is 0, 3 .. 27 at the head. 'if r7 & 0x1a' forgets the step, 4 and 5 go on, 7 and 8 come
+ * back. They are in 0..27, but they are not a multiple of 3.
+ */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void clamp_out_of_range_off_step(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+"1:"
+	"if r7 & 0x1a goto 2f;"
+	"if r7 < 4 goto 2f;"
+	"r7 += 3;"
+	"r1 += 1;"
+	"if r1 < 10 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * r7 is 0xfffffffb .. 0x100000004 at the head. 101 and 2^32 + 101 come back. The 64-bit ranges
+ * have numbers in common, the 32-bit ranges too, but no number is in both.
+ */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void clamp_out_of_range_64_and_32(void)
+{
+	asm volatile (
+	"r7 = 0xfffffffb ll;"
+	"r1 = 0;"
+"1:"
+	"if r7 & 0x200 goto 2f;"
+	"if w7 != 100 goto 2f;"
+	"r7 += 1;"
+	"r1 += 1;"
+	"if r1 < 10 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * r7 is 2^33 - 5 + 3 * k at the head. 2^33 + 5 and 2^33 + 6 are in the 64-bit range and in the
+ * 32-bit range. 2^33 + 4 and 2^33 + 7 fit the step. Only all three together have no number.
+ */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void clamp_out_of_range_64_32_and_step(void)
+{
+	asm volatile (
+	"r7 = 0x1fffffffb ll;"
+	"r1 = 0;"
+"1:"
+	"if r7 & 0x200 goto 2f;"
+	"if w7 > 3 goto 2f;"
+	"if w7 < 2 goto 2f;"
+	"r7 += 3;"
+	"r1 += 1;"
+	"if r1 < 10 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* 8 comes back. It is in the range of the head and not a multiple of 3. It must not go on alone. */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void clamp_out_of_range_const_off_step(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+	"r6 = 0;"
+"1:"
+	"if r7 & 16 goto 3f;"
+	"if r7 != 5 goto 3f;"
+	"r6 = 1;"
+"3:"
+	"r7 += 3;"
+	"r1 += 1;"
+	"if r1 < 1000000 goto 1b;"
+	"r0 = r6;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ *	for (i = 0, j = 0; i < 8; i++, j++)
+ *		val[j] = j == 7;
+ * val[8] is out of bounds: j = 8 must not go through the loop again.
+ */
+SEC("socket")
+__success __retval(1)
+__naked void clamp_out_of_range_index(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[small_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 3f;"
+	"r8 = r0;"
+	"r6 = 0;"
+	"r7 = 0;"
+"1:"
+	"r2 = 0;"
+	"if r7 != 7 goto 2f;"
+	"r2 = 1;"
+"2:"
+	"r1 = r8;"
+	"r1 += r7;"
+	"*(u8 *)(r1 + 0) = r2;"
+	"r7 += 1;"
+	"r6 += 1;"
+	"if r6 < 8 goto 1b;"
+	"r0 = *(u8 *)(r8 + 7);"
+"3:"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(small_map)
+	: __clobber_all);
+}
+
+/*
+ * Every iteration takes a reference, only the last one is released. The path with
+ * r7 = 9 is looked at first. If it ended at the head of the loop the path with
+ * r7 != 9 would be pruned at 2: and nobody would see a reference come back to the head.
+ */
+SEC("socket")
+__failure __msg("Unreleased reference")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void clamp_out_of_range_leak(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r7 = 0;"
+"1:"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r8 = r0;"
+	"if r7 != 9 goto 2f;"
+	"r0 = 0;"
+"2:"
+	"r7 += 1;"
+	"r6 += 1;"
+	"if r6 < 10 goto 1b;"
+	"r1 = r8;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard), __imm_addr(ringbuf)
+	: __clobber_all);
+}
+
+/*
+ * r7 = 9 releases the memory. That is the last iteration when r7 starts from 0, which
+ * is looked at first, and the first one when it starts from 9: the other nine write to
+ * memory that is gone. If the first path ended at the head of the loop, because 10 is not
+ * in 0..9, the second one would be pruned at 2: with the same r7 = 9, although 10 is in 9..18.
+ */
+SEC("socket")
+__failure __msg("R8 invalid mem access 'scalar'")
+__naked void clamp_out_of_range_two_entries(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r8 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = 9;"
+	"if r0 == 0 goto 4f;"
+	"r7 = 0;"
+"4:"
+	"r6 = 0;"
+"1:"
+	"r1 = 0;"
+	"*(u8 *)(r8 + 0) = r1;"
+	"if r7 != 9 goto 2f;"
+	"r1 = r8;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"2:"
+	"r7 += 1;"
+	"r6 += 1;"
+	"if r6 < 10 goto 1b;"
+	"if r7 == 10 goto 3f;"
+	"r1 = r8;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard), __imm(bpf_get_prandom_u32),
+	  __imm_addr(ringbuf)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0


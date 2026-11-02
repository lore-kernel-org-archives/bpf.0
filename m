Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646246;
	b=fVP3vwKVx/1285H2gxod1JIDah5rDjVzY58ge6dmf54KnK/JXPhnxqJxPXcXEhaNhuLB
	 ZbYvzUyvKQfch5Se7XoYk3/c4TxKPQNsR6NNorQeD0Ix5RD17BODwoCaGy0MxyuRB+cj+
	 R/73XiL5Y1U4oJ6QKjpEdYBUpg0h49rZzeTQORz9Cj8KyuSv2Amo+KVIUw3RVldNO64yG
	 NEx5GroZc1kNV34XLxmjHSTzB3HXvAGAwxfE95JSmEM5wKBIZ8kk0g/xPKnJKfDzZhOID
	 yFJAQ1r6cLdqKeiUnjmNFyxYUwVyEOP7Z4TcftrAkV1TnGEaFVn6s/hqQFKEXRbbBnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646246;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Iaya+ea8Qjie8Rj4WRSUiis2uYCCVvbvbwG2XvI6duk=;
	b=TZcptImU62VDPHONjX3kp7lX/uA9XgdIZ8c3OFwADbTOhzF5CjfGHIL/xLfX42LxRgEd
	 AhlSBFO/4Etw0Q6qYufUndOyc77C1HQOjV632o3lUPGl2sXUXRC3vmETeaCv/7XQXHUrO
	 O4h1ZhuXzcHtMpwlP8DWgx2gInfWC1C257wPLh4kCbnj4WTfk+UYQDCNcge48D7KXO4pZ
	 5IOXJH709Ui+7gLVZhzWbwSCK0UCKli+eMBp5T8VGcGTl0SzDC737CDSIY3mCY2c53ftM
	 xXtNq3Xei5peUhanVVMk/4a/sn968By1xiBng5nWu57i3jONj32oqVhn53km5zihGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=s4UtKbka;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F63606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F63606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=s4UtKbka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Iaya+ea8Qjie8Rj4WRSUiis2uYCCVvbvbw
	G2XvI6duk=; b=s4UtKbkaeTMcucyRDM8cif1fWcFX6QeGAqOUxnWTg2UYmfdbc8
	/dnCZP+CHnPoiEuHVBLTlz6l3ijTea/j0jKmTobUTP84MTrFga4/UBooOzPPbtzI
	lDMfLOZ3YFQ2eHAWQjKPcRj8CRZwwuG+Q4/z+2PydBy4elcs8C9yZYc9M=
Received: from localhost (unknown [222.195.81.114])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgD3ej+g3uhqYcx4AA--.1473S2;
	Tue, 03 Nov 2026 03:04:00 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Exercise stack argument precision on state reuse
Date: Tue,  3 Nov 2026 03:03:50 +0800
Message-ID: <20261102190350.788433-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
References: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgD3ej+g3uhqYcx4AA--.1473S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyDGr15Zr1ktr4kXr4xWFg_yoWrCF1xpa
	97Ja4agFWkAFWqv3yxZ3yDCFWrGFn5ZrW5JrZ7tFy0yF4jgr47KF40kFsFqr1DJr17u3yY
	yFyjyasxGFyDZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6rWl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUyuHgUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add two asm regressions for the precision of the sixth argument, which
is passed in a stack argument slot and used as a map value offset.

The first test reuses a safe state after storing arg6 from a register.
Precision must propagate from that slot to the register at an earlier
checkpoint, so a later out-of-bounds path cannot reuse that checkpoint.

The second test triggers conservative precision fallback by backtracking
across a store through a register that later becomes a scalar through
pointer subtraction. The caller's argument slot must become precise so
an out-of-bounds argument cannot reuse the safe state.

Both programs are load-only rejection tests and use the existing stack
argument compiler and architecture guards.

The two test programs were supplied by Alexei Starovoitov during review
and are included unchanged.

AI assistance was used in preparing this patch.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Link: https://lore.kernel.org/bpf/DMJI3GWXQOC9.UA3K9X139AR@gmail.com/
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 15a12497e07434a587c43e04c4ee90541676e3b2..abf319cb8514102e75dc0d9b98c721e2eacea0b6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -552,6 +552,121 @@ __naked void stack_arg_may_goto_in_caller(void)
 	);
 }
 
+/* arg6 is an offset into the value of map_hash_8b. 0-7 are in bounds. */
+__naked __noinline __used
+static long arg6_is_map_value_off(long a, long b, long c, long d, long e, long off)
+{
+	asm volatile (
+		"r6 = *(u64 *)(r11 + 8);"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r1 = %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l0_%=;"
+		"r0 += r6;"
+		"r0 = *(u8 *)(r0 + 0);"
+	"l0_%=:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_hash_8b)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: a pruned state propagates precision of arg6")
+__failure __msg("invalid access to map value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void stack_arg_precision_pruned_state(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 0 goto l0_%=;"
+		/* Path 1: arg6 = 0. It makes arg6 precise at l3. */
+		"*(u64 *)(r11 - 8) = 0;"
+		"goto l3_%=;"
+	"l0_%=:"
+		"if r0 == 1 goto l1_%=;"
+		/* Path 2: arg6 = r6 = 0. Pruned at l3. It has to make r6 precise at l2. */
+		"r6 = 0;"
+		"goto l2_%=;"
+	"l1_%=:"
+		/* Path 3: arg6 = r6 = 8. Out of bounds. */
+		"r6 = 8;"
+	"l2_%=:"
+		"*(u64 *)(r11 - 8) = r6;"
+	"l3_%=:"
+		"r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call arg6_is_map_value_off;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* The same, but backtracking of r1 sees a store through r1 and marks all scalars precise. */
+__naked __noinline __used
+static long arg6_is_map_value_off_fallback(long a, long b, long c, long d, long e, long off)
+{
+	asm volatile (
+		"r6 = *(u64 *)(r11 + 8);"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r1 = %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l0_%=;"
+		"r1 = r0;"
+		"*(u8 *)(r1 + 0) = 0;"
+		"r1 -= r0;"
+		"r1 &= 0;"
+		"r1 += r6;"
+		"r0 += r1;"
+		"r0 = *(u8 *)(r0 + 0);"
+	"l0_%=:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_hash_8b)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: forcing all scalars precise covers arg6")
+__failure __msg("invalid access to map value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void stack_arg_precision_fallback(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 0 goto l0_%=;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"goto l1_%=;"
+	"l0_%=:"
+		/* Out of bounds. Must not be pruned at l1. */
+		"*(u64 *)(r11 - 8) = 8;"
+	"l1_%=:"
+		"r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call arg6_is_map_value_off_fallback;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 #else
 
 SEC("socket")


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415663;
	b=PNL2mGXzpI68V1CcUhpnpJsr0SaIkPQsJMYM+72Uo9QP5BhnXPnG95kbBOm7chF9/wDF
	 tWiE0AzXg5hoitD5CVcoxuFy6n9LIznvwPaUwAqH8bcm4+1om36XXGr/ELo5sv3qL87cM
	 Es0+1uuUPO95DBB8EOYLtTAcIVmGtES1/svgzzKFDXCm+RzNu1BsjuFuuMxpF6fL55r+l
	 0hysL8QZxUCYEzMCLw4XlvVYqLA5hUTikIjd4uJ5+TwXREs0xufiWqs1d48IoQ8rLAC3X
	 qkAhR1PIielAmfJHbcHxdkgZIQua9F84LMSDjttyrtBSK4eWfncycoRMmJM0W6M5FMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wWqVn44Q0dMNJctPmcxy/k0JvKY5BZy0qZhnwKb1B14=;
	b=A/W1TcJl36sazxn0RA4d0CrIQd/tN/Z1PkmhSD+8VtrDN0/1PQ33hCHhXZzpbMzMVAv/
	 SR7a8kzOboornQ6ljMjeiwrGCJfiPcO3Y+ffxBsTf5UPGR8TDUzj1Ur8y5+CXafSxLymw
	 NoljHiT0d5ZntnOlOoaHEF+5kdt9MP0UbnfGl5nfXl44/ji21GX4jvqPpkBOBUNZclEkZ
	 H84BucEzheparkKjcgCPrvgHQNAveJJ/x6ULuOisO3uSnezg+Yy5J80bq25msZ7vDyj77
	 6xcdAne7LdF7jDXuKKiToAQVReKDnyjKv8gxhkoDxJgDeu85KjLWOfmfwiHEwSLH26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RW5lk2UZ;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA5606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RW5lk2UZ
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so2938448b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415662; x=1795020462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWqVn44Q0dMNJctPmcxy/k0JvKY5BZy0qZhnwKb1B14=;
        b=RW5lk2UZtar+OJVnLa2XPqQ/yk5LR2su/pBYlEWYh9Az9m3JU2w8TZUsySA+ZaNOFD
         jC4l4/5I143qTRwPXtmixTfkMfrGVJJb0/O9wa/2gZHTPwKndSUPQAZk55ARL8z1c6yw
         Ojrxf7eptqoRtcNRhlSxI3F7CSQL7EYKaBC6Bgaf6CyHoOlg+8kFLEmqoWV07E6WKWon
         83rOxlRmit1gW94P8jOvrfXZdQruk07VIRLgPGd1N0goOpwBCFc7TYiymnsexiZXGef5
         yzxVDyX/k1NxBJ2HP/jK0GpwBBcqdbaPYecbFk0zSgt213m/wK1doofHeY9UYPbA8r4J
         DUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415662; x=1795020462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWqVn44Q0dMNJctPmcxy/k0JvKY5BZy0qZhnwKb1B14=;
        b=KTcxnj9bx2VR6c7aNwLu9n4e85d335KWBg8BAFOqCTkdrzr1+nGIcVWeydMzr3ppaq
         6aJ9YYaUr7Gt1GDW3pBQ4VRfiQxNY0eVnrtKRvGTujgA2dC0lYaS7IbcHg1bQeKYsDot
         Td96kOWIDFH4nTmy0yRfkfjpAZuHL86M/rMHNq3WK5ivbGKegPADgslOMe/YQ8oAJglt
         Nh+s3KueBDZhEWovfmJCIPRtsUWjP994uM6muBUep0YxzkeIZ8RgWwFrUKLi0AbnnVZ9
         rJK4DYtJAnUfxLYe5v0U8BDYUKa8KrPN8tntm6YybrhiMhWXhP0jEiGyjyBfmxw6h0Qc
         xwmQ==
X-Gm-Message-State: APuU4Z+gALC+k6QIXGcwM8xyrMpG9+K/+hkzlwRcyeyupgSAkUZjrSYV
	jwETQGvw2TvisXO/WuQispBu39Ip/hhgbhOL/8IpDFZXQ/iUoI0niFwbHtFIag==
X-Gm-Gg: AYBFou2yx9Qa4piRXdkuDuMbLP6V96tgOIJt0W4Q89NyOAlaW4HD+7uMgj+85w5yE4c
	UCyuecA773WQHTQ17m80hLpYQuhblkwj5emrIpd+RlOAn+8Hx9V+2TGPgUsmgXqOOqflQUaHqUY
	yn95AXJq0TJ30/423T0gNXKQpKlSbsso4c2fwT8QZjusbike4enTrPr+mqpYvZzKg5fCF/HhfQ7
	0E/jPhGOeavNj0nVze/VNWP0hxohVVNIFOzo6p6xJQdRnhsJqFjNXALSbu7A9bIS82YVeSNY+yl
	eKgGpyRrlbeM/okUUUGZlY9Lzu6LNxq1CiqabECbaIzhFFX+Xkk2qXwHSojJHkgbIXEcpvmkgEu
	+mv47x42CZ9QJW6tsYPIvU6SewtDxQoL/GdfoShvwTo7buI/VtTDMECIskavQ6hdo6Nq5kHQrr2
	i/PkQVAR52oQJ1Iub41P0aVfe4d4ylbhOvy6UEmrKTk2NEsQUQlqfkQxq7od23kVGIHTxmSWGTX
	am15XUZZbf/zmwxejC2xo+87oAgHB/uU883rAz9bT+Z/mcbW4Qq6jSdCwDfvaXsQpnyaLx5+9Yj
	AFgxNlveCQIfqUwdxp0Cmnh6ecMxJdDAZQPOvycNvSC8abP3/EEX3YnWVz8AQDvf9FnLVX2JO+8
	ZVTx0olsl/e50yG9NcIdqLyFyx9Q6Bu2FGoUAIhGJ62NsZhKerHGH1pdcRmZs39ZBpcfL+N0p/g
	==
X-Received: by 2002:a05:6a00:429b:b0:890:a995:1f61 with SMTP id d2e1a72fcca58-8bc1c78270cmr3136046b3a.15.1794415662002;
        Wed, 11 Nov 2026 08:47:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8ded4dsm2373279b3a.54.2026.11.11.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 17/29] selftests/bpf: Test a pointer computed before its index is bounded
Date: Wed, 11 Nov 2026 16:45:40 +0000
Message-ID: <20261111164557.2659679-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

Tests for the patch that recomputes a pointer after the jump that bounds
its index. Since that patch a linked register of a conditional jump can be
a pointer: an address base + the tested register + a constant on every path
to the jump.

Each prog adds an index to a pointer to 64 bytes, tests the index and reads
through the result. What loads is run.

 - The add comes before the jump: loads.
 - Only the low 32 bits of the index are tested. Rejected.
 - A pointer to the stack instead, and the jump makes the index a constant.
   The result points to a dynptr: loads. The add refuses the constant: the
   pointer is left as it is. Rejected.
 - The jumps leave no value for the index, base + index is empty: the
   pointer is left as it is. Loads with BPF_F_TEST_REG_INVARIANTS.
 - base + index at a loop header: the add is at the end of an iteration,
   the jump at the header. Negative tests: it holds at loop entry only, on
   the backedge only.
 - In a prog with an arena 'r1 += r2' is trusted once the main pass has
   verified it without an arena pointer (prevent_zext): loads.

The test with an arena is in verifier_arena.c, the others in
verifier_scev.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |  3 ++
 .../selftests/bpf/progs/verifier_scev.c       | 41 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index bf50413f6c08..3931a1d9b6da 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -663,6 +663,9 @@ ARENA_LINKED(arena_ptr_plus_constant, __failure,
 ARENA_LINKED(arena_ptr_plus_constant_on_two_paths, __failure,
 	"if r8 == 0 goto 1f; r3 += 1; goto 2f; 1: r3 += 1; 2: r8 += 1; r3 = le64 r3; r7 = le64 r7;"
 	"r2 = 0xffffffff ll; if r7 != r2 goto out_%=; r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
+/* 'r1 += r2' was verified without a pointer to arena: it stays ALU64 */
+ARENA_LINKED(index_tested_after_the_add, __success __retval(0),
+	"r2 = r8; r2 &= 255; r1 = r6; r1 += r2; if r2 > 63 goto out_%=; r0 = *(u8 *)(r6 + 0);")
 
 SEC("syscall")
 __description("arena: a number is not an address in arena")
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index bf526ff1b858..0659ed1bab41 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3372,12 +3372,53 @@ __naked void name(void)								\
 #define LINKED(name, expect, body)	LINKED_SEC("socket", name, expect, body)
 
 #define VALID	__success __retval(0)
+#define MAP_OOB	__failure __msg("invalid access to map value")
 #define UNBOUND	__failure __msg("unbounded min value")
 
 /* r3 is the address in r1 as a scalar. It does not bound the offset of r1. */
 LINKED(pointer_is_not_scalar, __failure,
 	"r7 &= 127; r1 = r6; r1 += r7; r3 = r1; r3 = le64 r3; if r3 < 64 goto out_%=; r1 += -64;")
 
+/*
+ *	p = buf + i; if (i > 63) return 0; c = *p;
+ * The jump bounds i. r1 is r6 + r7 and r6 is live: r1 is recomputed.
+ */
+#define USE_R6	"r0 = *(u8 *)(r6 + 0);"
+
+LINKED(index_tested_after_the_add, VALID, "r1 = r6; r1 += r7; if r7 > 63 goto out_%=;" USE_R6)
+LINKED(low_32_bits_of_the_index_tested, __failure __msg("R1 unbounded memory access"),
+	"r2 = 0x1000000ff ll; r2 &= r8; r1 = r6; r1 += r2; w3 = w2; if r3 > 63 goto out_%=;" USE_R6)
+/*
+ * A dynptr at r10 - 16. r7 is r10 - 32, r1 is r7 + r8, the jump makes r8 a constant.
+ * 'r1 += r8' refuses 0x100000010: r1 is left as it is. As an int r10 + 0xfffffff0 is r10 - 16.
+ */
+#define DYNPTR_AT(index)							\
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"	\
+	"r8 >>= 1; r7 = r10; r7 += -32; r1 = r7; r1 += r8; r2 = " index " ll;"	\
+	"if r8 != r2 goto out_%=; r2 = 0; r3 = r7; r4 = 0; call %[bpf_dynptr_slice_rdwr]; r1 = r6;"
+
+LINKED_SEC("tc", index_is_constant, VALID, DYNPTR_AT("16"))
+LINKED_SEC("tc", index_is_constant_that_the_add_refuses,
+	__failure __msg("dynptr has to be at a constant offset"), DYNPTR_AT("0x100000010"))
+/* r7 is -2 or 5. Its low 2 bits are not 3: the path is infeasible, and r6 + r7 + 2 is empty. */
+LINKED(index_is_empty, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
+	"r7 &= 1; r7 *= 7; r7 += -2; r1 = r6; r1 += r7; r1 += 2; if r7 & 1 goto l_%=; goto out_%=;"
+	"l_%=: if r7 & 2 goto m_%=; goto out_%=; m_%=: r1 += 1;" USE_R6)
+
+/*
+ *	p = buf; i = 0; do { if (i > 62) break; i = *(u16 *)p; p = buf + i; } while (i);
+ * r1 == r6 + r2 at the header in every iteration: it holds at loop entry, the backedge preserves it
+ */
+#define LOOP(add)								\
+	"l_%=: if r2 > 62 goto out_%=; r2 = *(u16 *)(r1 + 0);" add		\
+	"if r2 != 0 goto l_%=; r1 = r6;"
+
+LINKED(base_plus_index_at_loop_header, VALID, "r1 = r6; r2 = 0;" LOOP("r1 = r6; r1 += r2;"))
+LINKED(base_plus_index_at_loop_entry_only, MAP_OOB,
+	"r1 = r6; r2 = 0;" LOOP("r1 = r6; r1 += r2; r2 >>= 1;"))
+LINKED(base_plus_index_on_backedge_only, MAP_OOB,
+	"r1 = r6; r1 += r7; r2 = r8; r2 &= 255;" LOOP("r1 = r6; r1 += r2;"))
+
 LINKED(sign_extension_that_fits, VALID, "r2 = (s8)r8; if r8 > 63 goto out_%=; r1 = r6; r1 += r2;")
 
 /* 'int n' in three registers. 'if w3 s> 63' refines only 32-bit ranges: those of the copies too. */
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598958;
	b=hkQ91QtbNjM0tr1Sdx30D2W9PljbzlDxV5PgUECX11U806nBvNOEz0DDsxf1OGJ9Zl7g
	 ySdJ0xqGkWGbx/cpA+nuOGGDCOKRB+0SpEusLtBXUNpRGxVr2UTd5qcNyADu0qlGpYFuL
	 ELdqXPbdoyLI3qO3akVUf2RkRbUO0H0scCsq2E9WNmH+j42LfLTHMamwl1RZYdoG5sBxL
	 uQhS8cscvdBKQ78gpG6IC9+sqfog5y0AhRe0EWs77360HTW4MOcSn7/xpAUEqUGQlr1iR
	 V5mi8Fvq5SLQs0Sz/K8mJTwtHq7+NfUOUzdbCwSNxv5KUyZPIJxP+SkXjWCh/MNIO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ypxHukKMSoe73gQjgcMelJk6wgodCcSr83DF/XpC1lg=;
	b=ZfGM0SxCZeOp0CDJvB8VKmn0AkQcv8+zUpAbyGqlwctlYW28cRVgrVUVfU8Qe0u6x7ii
	 TOEga6ZfppMk5jfaTd1m8409WKRXIXWW+JTPOmS0F9WkufYZtqURBbU4qkik8q2lzGZzE
	 01YSuON78nVa1WP3NskJbBQ49oTxjPARVPYPnPY4llSGyJuhNy18CjUnEbgd+n9VedqlA
	 7eGEpupEREEG6034wEGLSXL0/cnOtkQhz77zroFHHila7y9ZawaI3RN8Of9jqGjEwuBPG
	 b5p+37nAXoBmMNpvjF2Xpzh9m4Y2GNybgfEF0pwuVocd+kErpYRrFg404U8gJkxgEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWj7SO75;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC87606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC87606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWj7SO75
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso15349445ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793598957; x=1794203757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypxHukKMSoe73gQjgcMelJk6wgodCcSr83DF/XpC1lg=;
        b=DWj7SO75+py7wvl/1cIxphT6QEjaATHTUglVILSnoK988buMP4Mils/d5VeT8IYcW8
         MjVB80i2dvR4D7sAaEpKHEOJHGXLshvsflqS43LnFC6z2PGxSIDWjTU938EuweeCojtz
         2khIwTLY03VZJoIscsQY4Uq10E0kJzgxslOLzqgvW18sMerE+SkftARbutyA6yR0J1d6
         1AigwNlnR2KjYKekYvWopg8zhzvJs8oo52p/tCvFts1/LWluR4mmc6t8z00pOgDJqCuX
         ZlBwxjKfh/TbWtmB33k3BgURIxEQlc66gF31IfclZgVz895JopTg7lNZAXMZy/sFj6yq
         apPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793598957; x=1794203757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypxHukKMSoe73gQjgcMelJk6wgodCcSr83DF/XpC1lg=;
        b=OoPBJ9OnSkQ65mwUFRcNiWzrNfOl9ajVraK4c/EhsqF0iKudcdjcL0tP4g9LWGE2oZ
         0YJYIpSJg5P0hE1OXh6t4ctRlioH6ZbGeZqlh5RQc3YVRHKdyafqQ3VZwTwTD499uf6l
         RjrgVfpoqkVgVbz/Xg6vkoO2Ny4id8psLSjyAJQGYFuMQnIpBO2Tq3+blUl/pBWZWQkO
         ynoFbkcyf7MR/7RO1qaQkq0POicb08qK4K9xqdaXmi9SGrCL2U3u2tJg0UYgtPHiRSy0
         ww6XQdvmtnoZ7jzvpoLL3baeQiFf3IfeMGu2LzOmd233REnJHFXupnenatt68hjr2Hc+
         tU5A==
X-Gm-Message-State: APuU4Z8svWGIjBcp/LQHRuoy8uIs5ytVBHF7TodlpG5Gsw/f/jpTZyvi
	spZgnDwT9YmJb/8gZ/ouq21LgZuf4BYsoRiNpeZDI0w5CGqSSJYCjf5LSaLqfQ==
X-Gm-Gg: AYBFou23Na+WEfjxv0V5K7O4pOXrYgQSfy65FjM7BzGkr+7KR6ytbjH7QN+DwGpBK1d
	PT6kfgkF3nskCBb9WFTN8AuhzTFlmhFT+uHyAMKDNcA1k0IHnJwYY7svYyW15BmSjXGwqHGwyH5
	io6rqFmF+ZCyK+DgojCYOeeJhWisWd62wF4StS+GBtQw9HXoqMyRF/vUTETj/hAv8BnpHKDLg8S
	ZYTwXKyXZMsYhE8BHJJ5N75bY6SS6n/RppZblCcqpvBxUyRvo1arkVlm5SGDfQ0Lxj29tllGP0Q
	tW1O+5ztRn6dVgbYHMHA0Y4scVuC0e1MTjnQ906yWcjnKaxVuES9+CtnzbmVOWxUdBht+VbQUOM
	hazgaxW0fFAR1a/hXWPxHG7v4Q+ka934FbJQJKDlHNetxNNicFumXmm5YY7wIUTI9/dtyDBXSK9
	/lsYtjzDYOU8vrDZUNWjpY3s3EOgUNzzeEsL3x6CPLmcvcPYjBGlYf2jId7fAppJ7Bzfxc96wa/
	ZFF7HW/JdVdMlIuKehGuARFpyeVZnyRb66vJCbVSW7NhAoO/tNUlyq2rNOKZZfwt1lK/FriLVtd
	jXpim6chTy5V2iSL+OLjEs7CBlNxtx7EI6znuEgbwfeP6ppuKKclHeiAiy1F/3zyIEpI2WZfs0L
	6hhAupWgxa6UyDl4a/Y101TG0i/tbAQTHWyTx0yJO9RXlSISAherD4wS2X5kkDA42n8ql7L5XNE
	I=
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3ae897ccbfdmr7953814a91.11.1793598956729;
        Sun, 01 Nov 2026 21:55:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm7491377a91.1.2026.11.01.21.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:55:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()
Date: Mon,  2 Nov 2026 05:55:43 +0000
Message-ID: <20261102055543.3584718-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
References: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
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

bpf_dynptr_slice_rdwr() can return its buffer. When the buffer is on the
stack, a store to the buffer invalidates the slice. See "bpf: Invalidate
a dynptr slice when its stack buffer is written".

dynptr_fail.c gets short progs with skb and xdp dynptrs. They cover the
events that invalidate a slice, the borders of the buffer, a copy of the
slice on the stack and in a caller, pruning, and events that leave the
slice valid. They end with a store through the slice and are only loaded.

test_dynptr_skb_slice_rdwr_buffer in dynptr_success.c runs on a non-linear
skb. It shows that the slice is the buffer, and that the pattern of the
documentation continues to work. It passes without the fix too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |   1 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 258 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  38 +++
 3 files changed, 297 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index cbb2cc9969be..19f38215d909 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -37,6 +37,7 @@ static struct {
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
+	{"test_dynptr_skb_slice_rdwr_buffer", SETUP_SKB_PROG_NONLINEAR},
 	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index c2247b38c849..ab25085dbb4c 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1277,6 +1277,264 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/*
+ * bpf_dynptr_slice_rdwr() returns its buffer when the data is not contiguous.
+ * The verifier does not see a store through the slice as a write to the stack.
+ * Thus the buffer must not hold data that the verifier tracks: a store to the
+ * buffer invalidates the slice. fp-32: the dynptr, r7: the slice.
+ */
+#define SLICE_BUF_DYNPTR(new)				\
+	"r2 = 0;"					\
+	"r3 = r10;"					\
+	"r3 += -32;"					\
+	"call %[" #new "];"
+
+/* r3 is the buffer */
+#define SLICE_BUF_CALL(size)				\
+	"r1 = r10;"					\
+	"r1 += -32;"					\
+	"r2 = 0;"					\
+	"r4 = " #size ";"				\
+	"call %[bpf_dynptr_slice_rdwr];"
+
+#define SLICE_BUF_CHECK					\
+	"if r0 == 0 goto 9f;"				\
+	"r7 = r0;"
+
+#define SLICE_BUF_AT(off, size)				\
+	"r3 = r10;"					\
+	"r3 += -" #off ";"				\
+	SLICE_BUF_CALL(size)				\
+	SLICE_BUF_CHECK
+
+#define SLICE_BUF(off, size) SLICE_BUF_DYNPTR(bpf_dynptr_from_skb) SLICE_BUF_AT(off, size)
+
+/* Each prog ends with a store through the slice */
+#define SLICE_BUF_PROG(sec, name, expect, ...)		\
+SEC(sec)						\
+expect							\
+__naked int name(void)					\
+{							\
+	asm volatile (__VA_ARGS__			\
+	"*(u8 *)(r7 + 0) = 0;"				\
+"9:"							\
+	"r0 = 0;"					\
+	"exit;"						\
+	:						\
+	: __imm(bpf_dynptr_from_skb),			\
+	  __imm(bpf_dynptr_from_skb_meta),		\
+	  __imm(bpf_dynptr_from_xdp),			\
+	  __imm(bpf_dynptr_slice_rdwr),			\
+	  __imm(bpf_get_prandom_u32),			\
+	  __imm(bpf_probe_read_kernel)			\
+	: __clobber_all);				\
+}
+#define SLICE_BUF_TEST(...) SLICE_BUF_PROG("?tc", __VA_ARGS__)
+
+/* Not in the line of SLICE_BUF_TEST(): the log of the verifier has a copy of that line */
+#define SLICE_BUF_INVALID __failure __msg("R7 invalid mem access 'scalar'")
+#define SLICE_BUF_POINTER __failure __msg("invalid size of register spill")
+
+SLICE_BUF_TEST(slice_buf_first_byte, SLICE_BUF_INVALID,
+	SLICE_BUF(12, 4)
+	"*(u8 *)(r10 - 12) = 0;")
+
+SLICE_BUF_TEST(slice_buf_last_byte, SLICE_BUF_INVALID,
+	SLICE_BUF(12, 4)
+	"*(u8 *)(r10 - 9) = 0;")
+
+/* the store is at fp-16 or at fp-8 */
+SLICE_BUF_TEST(slice_buf_store_var_off, SLICE_BUF_INVALID,
+	SLICE_BUF(8, 8)
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 8;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r1 += r0;"
+	"*(u64 *)(r1 + 0) = 0;")
+
+/* the buffer is at fp-16 or at fp-8 */
+SLICE_BUF_TEST(slice_buf_var_off, SLICE_BUF_INVALID,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb)
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 8;"
+	"r3 = r10;"
+	"r3 += -16;"
+	"r3 += r0;"
+	SLICE_BUF_CALL(8)
+	SLICE_BUF_CHECK
+	"*(u64 *)(r10 - 8) = 0;")
+
+/* the slice is a pointer when it is stored to its buffer, and invalid after that */
+SLICE_BUF_TEST(slice_buf_narrow_spill, SLICE_BUF_POINTER,
+	SLICE_BUF(8, 8)
+	"*(u32 *)(r10 - 8) = r7;")
+
+/* the write to the buffer is the spill of the slice, not yet checked for NULL */
+SLICE_BUF_TEST(slice_buf_spilled_or_null, SLICE_BUF_INVALID,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb)
+	"r3 = r10;"
+	"r3 += -8;"
+	SLICE_BUF_CALL(8)
+	"*(u64 *)(r10 - 8) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	SLICE_BUF_CHECK)
+
+/* a slice that may be the buffer is the buffer of the next slice */
+SLICE_BUF_TEST(slice_buf_is_a_slice, SLICE_BUF_INVALID,
+	SLICE_BUF(8, 8)
+	"r3 = r7;"
+	SLICE_BUF_CALL(8)
+	SLICE_BUF_CHECK
+	"*(u64 *)(r10 - 8) = 0;")
+
+/* The paths differ only in the buffer. The safe one is first, the other must not be pruned. */
+SLICE_BUF_TEST(slice_buf_pruning, SLICE_BUF_INVALID __flag(BPF_F_TEST_STATE_FREQ),
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb)
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	SLICE_BUF_AT(16, 8)
+	"goto 2f;"
+"1:"
+	SLICE_BUF_AT(8, 8)
+"2:"
+	"*(u64 *)(r10 - 8) = 0;")
+
+/* r1 is the dynptr of the caller. The buffer is gone when the function returns. */
+static __used __naked void slice_buf_in_callee(void)
+{
+	asm volatile (
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 8;"
+	"call %[bpf_dynptr_slice_rdwr];"
+	"exit;"
+	:
+	: __imm(bpf_dynptr_slice_rdwr)
+	: __clobber_all);
+}
+
+SLICE_BUF_TEST(slice_buf_frame_returned, SLICE_BUF_INVALID,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb)
+	"r1 = r10;"
+	"r1 += -32;"
+	"call slice_buf_in_callee;"
+	SLICE_BUF_CHECK)
+
+/* stores to fp-12 of this frame and to r1, a pointer to the stack of the caller */
+static __used __naked void slice_buf_stores(void)
+{
+	asm volatile (
+	"*(u32 *)(r10 - 12) = 0;"
+	"*(u32 *)(r1 + 0) = 0;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SLICE_BUF_TEST(slice_buf_written_by_callee, SLICE_BUF_INVALID,
+	SLICE_BUF(12, 4)
+	"r1 = r10;"
+	"r1 += -12;"
+	"call slice_buf_stores;")
+
+/* r1 is the dynptr and r2 the buffer, both in the frame of the caller */
+static __used __naked void slice_buf_of_caller(void)
+{
+	asm volatile (
+	"r3 = r2;"
+	"r2 = 0;"
+	"r4 = 4;"
+	"call %[bpf_dynptr_slice_rdwr];"
+	"exit;"
+	:
+	: __imm(bpf_dynptr_slice_rdwr)
+	: __clobber_all);
+}
+
+/* stores next to the buffer or to another frame, a return, calls that fill the buffer */
+SLICE_BUF_TEST(slice_buf_stays_valid, __success,
+	SLICE_BUF(12, 4)
+	"r8 = r7;"
+	"*(u8 *)(r10 - 13) = 0;"
+	"*(u8 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call slice_buf_stores;"
+	"r1 = r10;"
+	"r1 += -12;"
+	"r2 = 4;"
+	"r3 = 0;"
+	"call %[bpf_probe_read_kernel];"
+	"r1 = r10;"
+	"r1 += -32;"
+	"r2 = r10;"
+	"r2 += -12;"
+	"call slice_buf_of_caller;"
+	SLICE_BUF_CHECK
+	"*(u8 *)(r8 + 0) = 0;")
+
+SLICE_BUF_PROG("?xdp", slice_buf_xdp, SLICE_BUF_INVALID,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_xdp)
+	SLICE_BUF_AT(8, 8)
+	"*(u64 *)(r10 - 8) = 0;")
+
+/* the metadata is contiguous: the slice is never the buffer */
+SLICE_BUF_TEST(slice_buf_skb_meta, __success,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb_meta)
+	SLICE_BUF_AT(8, 8)
+	"*(u64 *)(r10 - 8) = 0;")
+
+extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
+
+/* a dynptr, an iterator or irq flags are made in the buffer */
+#define SLICE_BUF_SPECIAL(name, type, make)				\
+SEC("?tc")								\
+__failure __msg("invalid mem access 'scalar'")				\
+int name(struct __sk_buff *skb)						\
+{									\
+	struct bpf_dynptr ptr;						\
+	type buf;							\
+	__u8 *p;							\
+									\
+	bpf_dynptr_from_skb(skb, 0, &ptr);				\
+	p = bpf_dynptr_slice_rdwr(&ptr, 0, &buf, sizeof(buf));		\
+	if (!p)								\
+		return 0;						\
+	make;								\
+	*p = 0;								\
+	return 0;							\
+}
+
+SLICE_BUF_SPECIAL(slice_buf_dynptr, struct bpf_dynptr, bpf_dynptr_from_skb(skb, 0, &buf))
+SLICE_BUF_SPECIAL(slice_buf_iter, struct bpf_iter_num, bpf_iter_num_new(&buf, 0, 1))
+SLICE_BUF_SPECIAL(slice_buf_irq_flag, unsigned long, bpf_local_irq_save(&buf))
+
+/* The type of a dynptr argument of a global function is not known: the slice may be the buffer. */
+__noinline int slice_buf_global(struct bpf_dynptr *ptr)
+{
+	__u64 buf;
+	__u8 *p;
+
+	p = bpf_dynptr_slice_rdwr(ptr, 0, &buf, sizeof(buf));
+	if (!p)
+		return 0;
+	*(volatile __u64 *)&buf = 0;
+	*p = 0;
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int slice_buf_dynptr_arg(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	return slice_buf_global(&ptr);
+}
+
 /* Read-only skb data slice is invalidated on write to skb metadata */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 56be4eafc270..1b1a9e425ccc 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -231,6 +231,44 @@ int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
 	return 1;
 }
 
+/*
+ * The tcp header is not in the linear part: the slice is the buffer. A store
+ * through the slice is seen in the buffer, and bpf_dynptr_write() puts it into
+ * the packet. As in the documentation, the stores come before the compare with
+ * the buffer: after it a compiler may use one pointer in place of the other.
+ */
+SEC("?tc")
+int test_dynptr_skb_slice_rdwr_buffer(struct __sk_buff *skb)
+{
+	struct tcphdr buffer = {}, copy = {}, *tcp;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	tcp = bpf_dynptr_slice_rdwr(&ptr, TEST_SKB_LINEAR_SIZE, &buffer, sizeof(buffer));
+	if (!tcp) {
+		err = 1;
+		return 1;
+	}
+
+	tcp->source = 0x1234;
+	if (buffer.source != 0x1234) {
+		err = 2;
+		return 1;
+	}
+	/* a read of the buffer does not invalidate the slice */
+	tcp->dest = 0x5678;
+	if (tcp != &buffer)
+		err = 3;
+	else if (bpf_dynptr_write(&ptr, TEST_SKB_LINEAR_SIZE, &buffer, sizeof(buffer), 0))
+		err = 4;
+	else if (bpf_dynptr_read(&copy, sizeof(copy), &ptr, TEST_SKB_LINEAR_SIZE, 0))
+		err = 5;
+	else if (copy.source != 0x1234 || copy.dest != 0x5678)
+		err = 6;
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.55.0


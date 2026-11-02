Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639415;
	b=CuQaRoVGCZXR02Hh0Q55On4RVxThPQC3Q6Z7ALGa1uEUe1dOmk7jS7O90lWH9sn4VFS1
	 atMVKQLDo4P6XyZ2hPS8QZGF2YD+ehs1v95cxojaz15PsBL5UROVTkeUswhukFDs8c0ta
	 mXI2xwJfaPw2fKpnW/W2r/vjDQWG73P7/NFfrOBlh6E+X/JBF4m8ryZUcpSxeG2q70EMZ
	 qV3h7ENg8H+qcwZTxjYwJxdRyiWlhAvC/TItTo0mESIzIXyZvZnUHhVx+7w24n800T2FU
	 +y2nhYOKKPO91/yMeFE9RnPVFn043ZaD5ymBUr+J8YS6k0HO2MneEo1uve9VkoZueew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J8KNFHRI40yOqUhEHAE40dX3k8XUVZIDLri0g/MIgzQ=;
	b=c4dFS8GeG6rEH3NKQ/f+M4KpMzH0Dp0q+69ZT491X9/coGpNpEYPeUm09RESEObEAzE/
	 CcZ+TF4S+2z+CI04B6Ajhqc/kjNS7g9xUcYYgvWWhbJ0+sLFShftifliOyXFvJ0ddZEiy
	 r+4iIFP35B94tT7pMsW3UtAfr45YmNaZfmaHEWE4S2D3/7ltHb9wd0V5SDnvWf3vf+g7v
	 vk3qwflOKChMOxuZbB1ou4nNxWlh75epPqjGcDcjoBoBXrpRt1ItHo86nJ6DknvxUoKm/
	 EsnZS8stUnUIiyXdlwchc7v3pP23tUfZNdcdmFmMxBpMuiR49JKhh/cHgYvJ5sr2mMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bF1u9bww;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC119606AB80
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC119606AB80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bF1u9bww
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2413690a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639414; x=1794244214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8KNFHRI40yOqUhEHAE40dX3k8XUVZIDLri0g/MIgzQ=;
        b=bF1u9bwwZ3zYW9n53RCavAAfc+At4OfwsczYyUXDDUhlB5ZwhmSPtGNr1Oe1+ktNYN
         b3glZDteU2LrUJPQEmHIDkGW0YVL0t6BJYF7vOf+8fDEfflWztOdsMK55Hzab85zSNIJ
         mDhmVx3lAsTif+itaK/wBHQWVBouQAalfv46NpRTVTS7MSbcGeBc5VNb3XW+2dltiQeI
         KT8O4vb3KgXBcBA5cTmhmDJj1XtzAabCAtRODMhMdXGRwptXriV3ObGLcaLxe1cR2jlI
         r1DKZBQo2hKl218P5rL7DJIc2AwHHsEHBi5YFoiVKHFj53N5Fc++P8TNW9/IBs2b+j2d
         qWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639414; x=1794244214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8KNFHRI40yOqUhEHAE40dX3k8XUVZIDLri0g/MIgzQ=;
        b=k427IVev54B6TC0wL6zVCnqrXeBK3o8FjtRfOaZwEyKILO8eSwYfClM7tG1ByFlnxP
         spU03hxOXV0dVIfx9p7DEBa0/qVxLES9h/Fk8Em6sX7JAL7MPlc7JeueQHNDUXAXASC+
         WULTRH8FQd+KtXUeoP966rxuRPouAdFZEf0k2jBxZQhN5Wb/wro3vNuNx5Fey5EnDXCZ
         blNT7JsP1y/7VwhPKq0dxoYKh823n3izYCtqV+F0HXHWcpkD0naQRrz1CnL92hT/EPYV
         GxSl5XSc2nT1/uYcYe/nPmEWS+PV1W6Vx3aPuilI3xB4UqB0hrZJo6CPqtZ+UMNvc1RX
         35Bw==
X-Gm-Message-State: APuU4Z/J+tTVdZrtcJ6vX+xYAgjiJfsJOFSpLeSC04a70x8+hX2Nz9ig
	Ck15dp/IsAtGEiLf3kQXmlGAkSxnwg3WfPMMhxX1CSgSiZxPj7ToUqOujr1pkQ==
X-Gm-Gg: AYBFou0r/CQOChHXW/yEg0znZlY1O+8O6hrlc7iZRye24TjAlhRPLJjGNBAz8IH6D2P
	Par1aBkW0UKjDKXA29dSohSpiDx8M2zzDox8NJ/8sbSmKyVWnYb14vemO8Bwv0yGrau3zHKZHGA
	d9rytvh7TwfraChfPsJA8y1VT/km1nwY1oZ1SoeTcSog6mXzSjgyb+1CNft/yjKpJO11rSdCzpi
	LcNuRM0VCQbGirb2Klq5oKObC4HwRmHWXlOKx47aC/pMmnUzjzCfCtsBxA+jrri7xUiSlR5qlQq
	arnWkZR7f/JZ7c/y1Ep32HL0ovaOHnM6tSPgnHFEtPfKh1ecvUwbHaXfxfgoOof2HDAy85v6W5v
	vc1dGaqHHy8osejTc/dCgiKuwQJUF8xwlGNdWGgElzMsH5CNmbazyty4LsowQ8R/ydcwzuBJcAY
	oQRePC4nnlprJhqiJLAcZy3uByRkoLfV+Y7FSfb1tixPVz62E4XM7IG5leeoMj09RbI/fS0YLeH
	v+I5RiOc53cNq1Ihe8xOtWh1LIaKNy6LhOomaaoIv8jf8wCFttuk8wq3FS8TtdyWFILiGj3nXwF
	fgqqMCwcls6p5e0ukE7+lJXUvi4gbRGCbUczAArAbwFHQvUU4lDb3foWPwi4Zk08C5VStWEkbaZ
	Zlk20jywDpJqqjojA3sHBGBeP5FJydxWf3fwcqxx9EvQVQ7NJ848Q9f9ROlZVOiL6mngLXrA+dm
	g=
X-Received: by 2002:a17:90b:1845:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3ae8984de26mr7245938a91.50.1793639413800;
        Mon, 02 Nov 2026 09:10:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e087csm23809a91.4.2026.11.02.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:10:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()
Date: Mon,  2 Nov 2026 17:09:58 +0000
Message-ID: <20261102170958.3586893-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
References: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
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

bpf_dynptr_slice_rdwr() and bpf_dynptr_slice() can return the buffer. When
the buffer is on the stack, a store to the buffer invalidates the slice.
See "bpf: Invalidate a dynptr slice when its stack buffer is written".

dynptr_fail.c gets short progs with skb, xdp and file dynptrs. They cover
the events that invalidate a slice, the borders of the buffer, a copy of
the slice on the stack and in a caller, pruning, read-only slices, and
events that leave the slice valid. They end with a load through the slice
and are only loaded.

test_dynptr_skb_slice_rdwr_buffer in dynptr_success.c runs on a non-linear
skb. It shows that the slice is the buffer, and that the pattern of the
documentation continues to work. It passes without the fix too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |   1 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 264 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  34 +++
 3 files changed, 299 insertions(+)

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
index c2247b38c849..3770ffdeaaaa 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1277,6 +1277,270 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/*
+ * bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() return the buffer when the data
+ * is not contiguous. For the verifier an access through the slice is not an access
+ * to the stack. Thus the buffer must not hold data that the verifier tracks: a
+ * store to the buffer invalidates the slice. fp-32: the dynptr, r7: the slice.
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
+	"call %[slice];"
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
+struct file {};
+extern int bpf_dynptr_from_file(struct file *, __u32, struct bpf_dynptr *) __weak __ksym;
+
+/* clang makes no BTF for a kfunc that only asm calls */
+void __kfunc_btf_root(void)
+{
+	bpf_dynptr_from_file(0, 0, 0);
+}
+
+/* Each prog ends with a load through the slice */
+#define SLICE_BUF_PROG(sec, kfunc, name, expect, ...)	\
+SEC(sec)						\
+expect							\
+__naked int name(void)					\
+{							\
+	asm volatile (__VA_ARGS__			\
+	"r0 = *(u8 *)(r7 + 0);"				\
+"9:"							\
+	"r0 = 0;"					\
+	"exit;"						\
+	:						\
+	: __imm(bpf_dynptr_from_file),			\
+	  __imm(bpf_dynptr_from_skb),			\
+	  __imm(bpf_dynptr_from_skb_meta),		\
+	  __imm(bpf_dynptr_from_xdp),			\
+	  __imm(bpf_get_prandom_u32),			\
+	  __imm(bpf_probe_read_kernel),			\
+	  __imm_const(slice, kfunc)			\
+	: __clobber_all);				\
+}
+#define SLICE_BUF_TEST(...) SLICE_BUF_PROG("?tc", bpf_dynptr_slice_rdwr, __VA_ARGS__)
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
+#define SLICE_BUF_FUNC(name, ...)			\
+static __used __naked void name(void)			\
+{							\
+	asm volatile (__VA_ARGS__			\
+	"exit;"						\
+	:						\
+	: __imm(bpf_dynptr_slice)			\
+	: __clobber_all);				\
+}
+
+/* r1 is the dynptr of the caller. The buffer of the read-only slice is gone after the return. */
+SLICE_BUF_FUNC(slice_buf_in_callee,
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 8;"
+	"call %[bpf_dynptr_slice];")
+
+SLICE_BUF_TEST(slice_buf_frame_returned, SLICE_BUF_INVALID,
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_skb)
+	"r1 = r10;"
+	"r1 += -32;"
+	"call slice_buf_in_callee;"
+	SLICE_BUF_CHECK)
+
+/* stores to fp-12 of this frame and to r1, a pointer to the stack of the caller */
+SLICE_BUF_FUNC(slice_buf_stores,
+	"*(u32 *)(r10 - 12) = 0;"
+	"*(u32 *)(r1 + 0) = 0;"
+	"r0 = 0;")
+
+SLICE_BUF_TEST(slice_buf_written_by_callee, SLICE_BUF_INVALID,
+	SLICE_BUF(12, 4)
+	"r1 = r10;"
+	"r1 += -12;"
+	"call slice_buf_stores;")
+
+/* r1 is the dynptr and r2 the buffer, both in the frame of the caller */
+SLICE_BUF_FUNC(slice_buf_of_caller,
+	"r3 = r2;"
+	"r2 = 0;"
+	"r4 = 4;"
+	"call %[bpf_dynptr_slice];")
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
+/* the slice of a file dynptr is read-only, and it is always the buffer */
+SLICE_BUF_PROG("?lsm.s/file_open", bpf_dynptr_slice, slice_buf_file, SLICE_BUF_INVALID,
+	"r1 = *(u64 *)(r1 + 0);"
+	SLICE_BUF_DYNPTR(bpf_dynptr_from_file)
+	SLICE_BUF_AT(8, 8)
+	"*(u64 *)(r10 - 8) = 0;")
+
+SLICE_BUF_PROG("?xdp", bpf_dynptr_slice_rdwr, slice_buf_xdp, SLICE_BUF_INVALID,
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
+	return *p;							\
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
+	return *p;
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
index 56be4eafc270..7949dd538569 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -231,6 +231,40 @@ int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
 	return 1;
 }
 
+/*
+ * The tcp header is not in the linear part: the slice is the buffer, and a store
+ * through the slice is seen in the buffer. As in the documentation, the stores
+ * come before the compare with the buffer: after it a compiler may use one
+ * pointer in place of the other.
+ */
+SEC("?tc")
+int test_dynptr_skb_slice_rdwr_buffer(struct __sk_buff *skb)
+{
+	struct tcphdr buffer = {}, *tcp;
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
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.55.0


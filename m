Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749478;
	b=dEwEDBhPUU6FDac3uhZq8tNUxw9WQFLDnfXLW3+T2GbB/ngbAmAFjY39YSUWp30Zi5Sx
	 czOYMWu+DwYnDEQxCCaCsksrmgT4e/1ujl9cwITs1eLMONaE2u9N5CKkYAsUo8r+lPl4R
	 hajc1H9UPOV6HDYoMiYAJ5vXHiJqhoX8sCExdGe12V3eSmVi/9JWIpU73CEl0QHlJAh2/
	 czoYOkIUH+SECaIZD1nHtpXcHcKOYlgvA2TocxeSHzWWwVlzh5EmzIR23VRNp2491wt8p
	 SONU3XE6/nhTjTXjf8quFmlhdlYZ/c6P5plWpQI4g9wmy+6i7TNgD6JtHnVd/YMX7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jWIZYFTxS7I7MK4UFWuGP9yPBI+bYYmOfkCR2laSe0I=;
	b=koqppYej5m2TjCvJR2Zspn0241mRwLipSiqDwl7cmdj20raK1vcwSkwZ1NhWVaoOpzyA
	 +tCchMJ8NalSYn6qd2WpA6J6OM4EjZ7ku1Q5sd2X0dLVM8/ndoDNJ5gA2em5bV89bzd5W
	 ydkWk1pm7Ozb0Y9Zi6nRTF0VHHxDe64L0TF7jxafUVX1i0uoQtNzY1bukr2+LLgL3o01R
	 0yfoMOTYnz35Z5pT0m2r+cC/OlC843ApU7QWAXkgD3xwl8LEkL1F2M2LKz6mrci+H+R+g
	 dQqhFH2uDwuSRcubM1NVQyXxBBBHrEMhFB2UH+22/lHrzDaBjfU7wg12IBlgcUdw2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbRbADlb;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CD606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5CD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbRbADlb
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so88348a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749477; x=1794354277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWIZYFTxS7I7MK4UFWuGP9yPBI+bYYmOfkCR2laSe0I=;
        b=LbRbADlbV35Ud6LvMfoF89vhTIm1dJs1CKQAAy0UFVD34oknj1I33pCm8ywytHRf7C
         U4zyrZA6Ps6xXBmHcXIu4EkDkHJbuuPRXCULXWcz9LtA+iUFA5A6Uimxeco/46uFr3jr
         df1VYukdwsVRdBq317hsU8OWqyaDhlrabN85jBKVq++4CyX2biEDLleF1yn6ofygg+YY
         LnQBkV3dZr80fx54ssGm6JZSPv3O0hr/X8Qefysc6EJuZv5D+fs1e/Yzau1x3su3oNgt
         VV3jzR4gPF/I0Ss+Hu2r2uAHHFU2i1ArsRyOpjLn9YD4DfH/fcDPrIwxBzM5dC4nQLLX
         4mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749477; x=1794354277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWIZYFTxS7I7MK4UFWuGP9yPBI+bYYmOfkCR2laSe0I=;
        b=wEU75DEP+aM1ebKItvhC03VN8t07vjyquS9joXCj3mqomKCw/GPuE2tOgs91+SCaUu
         rcX1tFzeYOIVbds2f1iFv7xVx3PVpcshCU9L/8g3Vcrq5y8CSr+daSzUn1aL5/6zJ3lH
         Z9b7VRMFiHsqhQOUc0kmivgRwpRYPlEx7Hl9GP2jOmK8OiSPIEiDbi64HZnaW+HCon5s
         ocJE+KcjCmUGDotxEv8A0UPEdAQdI4UWOYIJgkO23AtnyW7VKVMyi3uJiGWwNrjrb1ZM
         7ZVy08HAMkQyHWkxTw9IDkgEmeiA6tvgt1DXAqeCfnffoV7jPypNHHpND1zO5zkiV2aB
         BAMg==
X-Gm-Message-State: APuU4Z/zfIIFe3+1z3QiIZLLa4HsR6RR/mztki6A0EjT2BQYGjxgE+Vx
	Pg8dmhJZxRpZG5m8qLv/ixjnG7Xx75b4lRt6GkXs26gx1+KG4kB9h1A2DD4T9g==
X-Gm-Gg: AYBFou3KgGTeyUglcKlH8TrFuTVAJ3V+PSIWvFJbnAlflx1QadAf6oTaOKjnoqorobC
	v9kKqiyeCsZBZ/yCN+zSpuis1p6VAYSY43cw9rluhejag5o5zDhGnkAk2FVWXRzP1JS3bwz3jF4
	RMYnlU0hxEnGN/3aZbnL8EgNAjxiISlOLq6as4+T/k+8oeq3saynIWhdMEH/jFyahqQmBP/TCNC
	f6JIkXTzks+hEHPq0bWxkIOUTQnCzjRDzWSophG3/cwoWub5gKkK9Ww6MtUusuZCobnLhGe78D7
	UmGItJwPydAABqNS8HkYFLrzlNsyG/lxqINXM6fQyqVcx7MGQ64fHhxGEpFLT+UlIjgZjKYoXeP
	wqdK9rGasWn7KpI8jHzpLaM4AYDgest2RentpYEQC9oGnPnc301WZLvjZR/sjqtugNHRqRdWHfL
	0eTjNhm+UBxC0Kd82kkOeepA5bJppdG5RJedxalHb+cQpimulTcNiqz8lbzOYt5q46uGVmMDam1
	2o0M3GTN4KjgswE1M5GnmtZrvMy/RkgbP3+/aVPbiwz+YYMWD6gAKdlnBubn7KaMBQKqMZWKKnv
	zN2rbdLHFoTb6VhjCoStYTtk+cksFK8n1PpE6pWF1QLafBqtRbhp2Ihy8ws4cQraJj6LkoXEpiS
	NOzdTEC1oEgC3Uv0VtjkCHyL2qKhpsD3zWvFsZro+2Cd4EQzqXsjMBPN+peYS7gg5VWybme+0oQ
	==
X-Received: by 2002:a17:90b:5487:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3ae89775250mr10078399a91.22.1793749476675;
        Tue, 03 Nov 2026 15:44:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d41bsm292535a12.12.2026.11.03.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 35/37] selftests/bpf: Test a static subprog with 24 arguments
Date: Tue,  3 Nov 2026 23:41:00 +0000
Message-ID: <20261103234104.208239-36-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A prog passes 1 .. 24 to a static subprog, in r1 - r5 and in all 19 stack
slots. The subprog adds them up. The test runs the prog and expects 300.
Thus it also shows that the JIT has room for each slot. The subprog is in
asm and its prototype has no parameters: the verifier sees in the code what
it takes.

A second prog passes 17 slices of dynptrs in stack slots. Each slice has
two ids: its own and the id of its dynptr. The subprog returns the last
one, a slice of a ringbuf dynptr. The prog submits the dynptr and then
writes through the slice. The verifier must reject the write: what the
subprog returns is still the slice of that dynptr, whatever the number of
ids in front of it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index c54a9b80ced4..146cdf81bbc4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -13,6 +13,11 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
 #if defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 struct {
@@ -440,6 +445,218 @@ __naked void stack_arg_shared_store(void)
 	);
 }
 
+/* r1 - r5 and all 19 slots. Its prototype has no parameters: what it takes is seen in its code. */
+__naked __noinline __used
+static unsigned long subprog_24args(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += r2;"
+		"r0 += r3;"
+		"r0 += r4;"
+		"r0 += r5;"
+		"r1 = *(u64 *)(r11 + 8);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 16);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 24);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 32);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 40);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 48);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 56);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 64);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 72);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 80);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 88);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 96);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 104);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 112);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 120);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 128);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 136);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 144);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 152);"
+		"r0 += r1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog with 24 args")
+__success __retval(300)
+__naked void stack_arg_24args(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 152) = 24;"
+		"*(u64 *)(r11 - 144) = 23;"
+		"*(u64 *)(r11 - 136) = 22;"
+		"*(u64 *)(r11 - 128) = 21;"
+		"*(u64 *)(r11 - 120) = 20;"
+		"*(u64 *)(r11 - 112) = 19;"
+		"*(u64 *)(r11 - 104) = 18;"
+		"*(u64 *)(r11 - 96) = 17;"
+		"*(u64 *)(r11 - 88) = 16;"
+		"*(u64 *)(r11 - 80) = 15;"
+		"*(u64 *)(r11 - 72) = 14;"
+		"*(u64 *)(r11 - 64) = 13;"
+		"*(u64 *)(r11 - 56) = 12;"
+		"*(u64 *)(r11 - 48) = 11;"
+		"*(u64 *)(r11 - 40) = 10;"
+		"*(u64 *)(r11 - 32) = 9;"
+		"*(u64 *)(r11 - 24) = 8;"
+		"*(u64 *)(r11 - 16) = 7;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call subprog_24args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long returns_arg22(void)
+{
+	asm volatile (
+		"r0 = *(u64 *)(r11 + 136);"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* A dynptr and a slice of it, which has two ids: its own and the one of the dynptr */
+#define SLICE(dynptr, slice)			\
+	"r1 = r6;"				\
+	"r2 = 8;"				\
+	"r3 = 0;"				\
+	"r4 = r10;"				\
+	"r4 += -" #dynptr ";"			\
+	"call %[bpf_dynptr_from_mem];"		\
+	"r1 = r10;"				\
+	"r1 += -" #dynptr ";"			\
+	"r2 = 0;"				\
+	"r3 = 8;"				\
+	"call %[bpf_dynptr_data];"		\
+	"*(u64 *)(r10 - " #slice ") = r0;"
+
+#define SLICE_ARG(slice, arg)			\
+	"r1 = *(u64 *)(r10 - " #slice ");"	\
+	"*(u64 *)(r11 - " #arg ") = r1;"
+
+/*
+ * The 16 slices in front of it have 32 ids. What the subprog returns is still the slice of
+ * the dynptr that is submitted.
+ */
+SEC("tc")
+__description("stack_arg: ids of the last of 17 slices")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void stack_arg_ids_of_17_slices(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 408) = r1;"
+		"r2 = r10;"
+		"r2 += -408;"
+		"r1 = %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 2f;"
+		"r6 = r0;"
+		SLICE(16, 280)
+		SLICE(32, 288)
+		SLICE(48, 296)
+		SLICE(64, 304)
+		SLICE(80, 312)
+		SLICE(96, 320)
+		SLICE(112, 328)
+		SLICE(128, 336)
+		SLICE(144, 344)
+		SLICE(160, 352)
+		SLICE(176, 360)
+		SLICE(192, 368)
+		SLICE(208, 376)
+		SLICE(224, 384)
+		SLICE(240, 392)
+		SLICE(256, 400)
+		"r1 = %[ringbuf] ll;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -272;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"r1 = r10;"
+		"r1 += -272;"
+		"r2 = 0;"
+		"r3 = 8;"
+		"call %[bpf_dynptr_data];"
+		"if r0 == 0 goto 1f;"
+		"*(u64 *)(r11 - 136) = r0;"
+		SLICE_ARG(400, 128)
+		SLICE_ARG(392, 120)
+		SLICE_ARG(384, 112)
+		SLICE_ARG(376, 104)
+		SLICE_ARG(368, 96)
+		SLICE_ARG(360, 88)
+		SLICE_ARG(352, 80)
+		SLICE_ARG(344, 72)
+		SLICE_ARG(336, 64)
+		SLICE_ARG(328, 56)
+		SLICE_ARG(320, 48)
+		SLICE_ARG(312, 40)
+		SLICE_ARG(304, 32)
+		SLICE_ARG(296, 24)
+		SLICE_ARG(288, 16)
+		SLICE_ARG(280, 8)
+		"call returns_arg22;"
+		"r6 = r0;"
+		"r1 = r10;"
+		"r1 += -272;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_submit_dynptr];"
+		"r1 = 0;"
+		"*(u64 *)(r6 + 0) = r1;"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -272;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_discard_dynptr];"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm(bpf_dynptr_from_mem),
+		  __imm(bpf_dynptr_data),
+		  __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_submit_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm_addr(map_hash_8b),
+		  __imm_addr(ringbuf)
+		: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("stack_arg: write beyond max outgoing depth")
 __failure
-- 
2.55.0


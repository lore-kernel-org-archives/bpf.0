Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FB5328A8
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866384; cv=none; b=oRNssSCMIxa8hVozwA3HRh7JMBNv3LUp+iinybVrl5U074zrZ11zfd3hnX8jkPpDA9O1fLU9E1NCMoAB+NhgSaJqnPgCtUCCVzL2UohauIAsiRM2gkmjfoooKMa7xZvkwdVCL2J7f7STYH/3BJQy7q4QUfTOowwhOcVdUEwBE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866384; c=relaxed/simple;
	bh=YcmYc0v2DE3lkir2t72dOEq9zMwtDx3i5PD5d5doq90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6Fa2vSgr+Ji6vCgIDGktMXMZ0hAc+5aHgtgR6/n6xWkotoWkB3IUZW8tWMtRAtqMNbTrpMLh503BN8wApn+OS4Oys2Cjxsvj3weBZym24AWyYP9MJnEeQclOp/g7XZHwCtlJzXqpEIlJx46qfjt/wSlS8DAHdKFFlXGizqesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an9KU9Sh; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an9KU9Sh"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d42b972bso18214545ad.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790866381; x=1791471181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJHHggK6KzkF5Hr51ChHWiCBnfxlQMycQHhPNSVfRXY=;
        b=an9KU9Sh2Tkf3xEhLYse0TxwBaRvmH5zvVEsNQodocbTxXXUoKfcR8yqybNBWM+trj
         YxW0IUwDi5RrUs/KTLlZKdyHOI/5f2ArSev04xN3LS7/Utt/5/J7wlj572QfACp0547Q
         VMYeL5qhRZVv2BNQHRk5GlFWyX2fEHr4LquVUWeKWGWAisZ0Y70xoAsbxY3Mqw1+kOW1
         CrdeW5CdglHQS+hmAVlwsSvUjXFn87pMakYaF1hX0OgWqGTv4BiyK/eHkMOuP8NNbUly
         PQioFaxOJmGP6j/FVE0S1WwJ0Qte5APSEQpxYFxR/lM8h86TJ7cBZF5595T7N7YnQGOz
         uYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790866381; x=1791471181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yJHHggK6KzkF5Hr51ChHWiCBnfxlQMycQHhPNSVfRXY=;
        b=yGLKiHgc+QVD5mLDWf1/KRq0IVpvakLPL4Y0sbr3JU/4k6tSz+yFqHBSXdC5z38CTr
         3aWzptpRSS4VvHULVzqVDKoZw0gMAxf6gIDXsWQi6EhIOlUHoZN71Q47BaUc+/mCXFNs
         opW3nKMQjNnX0woiRUa+fRf666ShnEQSGVVDUsAWmn1bao+MArOqPgHfxzaAKXqya0+/
         biw/dJeFNBFhEX52qg2K8HIBgaecy2h4pi2lV0XEnJJk0T635ldNn8EwS+CKcXN1QYvj
         2MVo9S7QPZvB6scrNvwBria644xaBYls+wkIAsP3eAAIWEt3NctzlVErvhADMyI3tdaO
         XYnw==
X-Gm-Message-State: AFq9FYIb7FFzdycc8cwjbYKRdbMDrh0pPlTdbOd3cL8FRpcPsdpaMnaT
	+MKYawyDQeC/Wk2LW+mHEqeYJvHGrzCYkiDIIoixRTGbcB4yqbN5JKEc0ofZalod
X-Gm-Gg: AYBFou2jctIfHtri/PSuzdqVQsIc8odTc4PKFdj3WMH19Lw7tYDWEul9tl7vLcUAoRP
	/6wVbOtoRH110cZh1wzjDhZK4rsUNykk1Xo7EniEax1LNu1X4qUvdqQ9WGKJm9VnLD1FMMI0idy
	Dd633TliTIqIXxte5+ijjmPCTrIHjbmWhmQowEakZPnzfpOQicZ8ZJTaZphUn/mQa9eM722KgRd
	Gfe9mc4jO+kftOXJY8jNsY4xU4mWvJqEZ3IOrAKpj83wdTh40zv+fwwEGWmUnankM82dJSFGNbS
	Xoue9j9TAYb2KSffFDJ97Vgk2Hmj48AHyQoOJt5tV/KpmPa1CnlI+EM3axeBY/puN5TgMabiNz4
	nCUR+BuQkmuQ0idUOEKH0yel0AnDlZ2xBRLk3esLRln3jgzcY5eaHa9B9gvNgDYAUM9mc/AamAM
	Eap5qaLo6nNoGu49QEOU/PRlW358Aii8TXjZGLnMtfV2+cQZFL6Ve17K3HSL62CuGoE5y1Au65b
	APr1GWlpOkzC2iP+q4OC5jWG3bD8ZSByGZ8wL+KAt+O8x1w234oyX4FT3249v27OkITWQrU5o/f
	CWtsp2HoMi7lE/lxfRql7ujdz+TJxtRVQXawJpi4DzPs
X-Received: by 2002:a17:903:2c10:b0:2df:9305:8909 with SMTP id d9443c01a7336-2e2e49f7477mr41877625ad.17.1790866381064;
        Thu, 01 Oct 2026 07:53:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e306c3cb2csm9889375ad.83.2026.10.01.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:53:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Test packet range of pointers sharing an id
Date: Thu,  1 Oct 2026 14:52:55 +0000
Message-ID: <20261001145255.855630-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001145255.855630-1-alexei.starovoitov@gmail.com>
References: <20261001145255.855630-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests where two packet pointers share an id and tightening one
pointer's umax from its var_off would put it less than their constant
distance from the other's umax: with an index & 0x38 capped at 50, the
base pointer keeps umax 50, so the pointer 8 bytes further on must keep
umax 58, even though its known bits allow at most 56.

These refused a valid program or accepted an out-of-bounds access before
the fix:

- check the advanced copy, load through the base: valid, was refused;
- check the base, load the byte at base + 1 through a copy advanced by
  8: was accepted;
- check base + 4, load 4 bytes at base + 2 through base + 8: reads two
  bytes past the checked range, was accepted;
- the same as the second with data_meta pointers checked against data:
  was accepted.

These pass with and without the fix and cover nearby paths:

- subtract an unknown scalar from a checked pointer and load below it
  (the range is kept across a new id);
- reach a load through two paths whose checks cover 8 and 7 bytes after
  the loaded pointer; the second path must not be pruned by the first;
- spill a copy of a pointer, check the pointer, fill the copy and load
  one byte past the checked range: the load is refused, and the copy
  has the range of the check.

Assisted-by: LLM
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_direct_packet_access.c | 178 ++++++++++++++++++
 .../bpf/progs/verifier_meta_access.c          |  30 +++
 2 files changed, 208 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 915a97072..139ff019d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -920,4 +920,182 @@ l1_%=:	r0 = *(u8*)(r9 + 0);				\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("direct packet access: 8-aligned offset, check p + 8, load 8 bytes at p")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_same_id_check_copy_load_base(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 &= 0x38;					\
+	if r4 > 50 goto l0_%=;				\
+	/* r4 is a multiple of 8, at most 48 */		\
+	r5 = r2;					\
+	r5 += r4;					\
+	r6 = r5;					\
+	r6 += 8;					\
+	if r6 > r3 goto l0_%=;				\
+	/* [r5, r5 + 8) is in the packet */		\
+	r0 = *(u64*)(r5 + 0);				\
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
+__description("direct packet access: 8-aligned offset, check p, load past it via p + 8")
+__failure __msg("invalid access to packet, off=51 size=1")
+__naked void pkt_same_id_check_base_load_via_copy(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 &= 0x38;					\
+	if r4 > 50 goto l0_%=;				\
+	/* r4 is a multiple of 8, at most 48 */		\
+	r5 = r2;					\
+	r5 += r4;					\
+	r6 = r5;					\
+	r6 += 8;					\
+	if r5 > r3 goto l0_%=;				\
+	/* r6 - 7 is r5 + 1 */				\
+	r0 = *(u8*)(r6 - 7);				\
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
+__description("direct packet access: 8-aligned offset, check p + 4, 4-byte load at p + 2")
+__failure __msg("invalid access to packet, off=52 size=4")
+__naked void pkt_same_id_check_base_4_load_via_copy(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 &= 0x38;					\
+	if r4 > 50 goto l0_%=;				\
+	/* r4 is a multiple of 8, at most 48 */		\
+	r5 = r2;					\
+	r5 += r4;					\
+	r6 = r5;					\
+	r6 += 8;					\
+	r7 = r5;					\
+	r7 += 4;					\
+	if r7 > r3 goto l0_%=;				\
+	/* [r5, r5 + 4) is in the packet, [r5 + 2, r5 + 6) may not be */ \
+	r0 = *(u32*)(r6 - 6);				\
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
+__description("direct packet access: checked pointer minus non-negative unknown keeps range")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_sub_unknown_keeps_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 &= 0x1f;					\
+	r4 += 8;					\
+	r5 = r2;					\
+	r5 += 40;					\
+	if r5 > r3 goto l0_%=;				\
+	/* r5 is 8 to 39 bytes below the checked pointer */	\
+	r5 -= r4;					\
+	r0 = *(u64*)(r5 + 0);				\
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
+__description("direct packet access: no pruning of a path whose checks prove fewer bytes")
+__failure __msg("invalid access to packet, off=255 size=8")
+__flag(BPF_F_ANY_ALIGNMENT) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void pkt_same_id_pruning(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r0 = *(u32*)(r1 + %[__sk_buff_priority]);	\
+	r4 &= 0xff;					\
+	r5 = r2;					\
+	r5 += r4;					\
+	if r0 != 0 goto l1_%=;				\
+	/* this path proves [r5, r5 + 8) */		\
+	r6 = r5;					\
+	r6 += 8;					\
+	if r6 > r3 goto l0_%=;				\
+	goto l2_%=;					\
+l1_%=:	/* this path proves [r5, r5 + 7) */		\
+	if r5 > r3 goto l0_%=;				\
+	r6 = r5;					\
+	r6 += 7;					\
+	if r6 > r3 goto l0_%=;				\
+l2_%=:	r0 = *(u64*)(r5 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_priority, offsetof(struct __sk_buff, priority))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: spilled copy of checked pointer, load past range")
+__failure __msg("invalid access to packet, off=262 size=1, R7(id={{[0-9]+}},off=262,r=262)")
+__naked void pkt_spilled_copy_gets_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 &= 0xff;					\
+	r5 = r2;					\
+	r5 += r4;					\
+	*(u64*)(r10 - 8) = r5;				\
+	/* proves only bytes before r5 */		\
+	if r5 > r3 goto l0_%=;				\
+	r6 = r5;					\
+	r6 += 7;					\
+	if r6 > r3 goto l0_%=;				\
+	/* [r5, r5 + 7) is in the packet */		\
+	r7 = *(u64*)(r10 - 8);				\
+	r0 = *(u8*)(r7 + 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_meta_access.c b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
index 62235f032..c87e0be4b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_meta_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
@@ -281,4 +281,34 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("meta access, 8-aligned offset, check p, load a byte at p + 1 via p + 8")
+__failure __msg("invalid access to packet, off=51 size=1")
+__naked void meta_access_check_base_load_via_copy(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	r4 = r0;					\
+	r4 &= 0x38;					\
+	if r4 > 50 goto l0_%=;				\
+	/* r4 is a multiple of 8, at most 48 */		\
+	r2 = *(u32*)(r9 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r9 + %[xdp_md_data]);		\
+	r5 = r2;					\
+	r5 += r4;					\
+	r6 = r5;					\
+	r6 += 8;					\
+	if r5 > r3 goto l0_%=;				\
+	/* r6 - 7 is r5 + 1 */				\
+	r0 = *(u8*)(r6 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0


Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D939B4BC
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345217; cv=none; b=qZYckdiNf0+zCBhwy04SSQsr15zFCjYtbofolgnGvl1k5X+Y13UwT7L6h1rvQmdhUCJU9HsEJbX24QtdsYTXHuVVuO4xOQu3IQJ+PkFCtwSNXj8jo2oAfoLISlqxtl/P6IDTrS2heYOhjZRVz3JP68Z6tgtZpXTT8P5xlv1oK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345217; c=relaxed/simple;
	bh=ZlTZScHonllQqcw5E6o38N/l5ISjkOaJ+ish/b+O0eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTCjDehVLNiN5ZFWcdIvScMcvuWFcHEzgJBLPjNiP6sqN6qqDLz25N0x1vq2zzY57vRPmn6zx6leLc9htaF5N1p0wRvoe+sPgRyomwkUs/4HhXlJbN5IrjqHO55e+iEVuLDLk8d2w58X/FryH9R9KO+ERWZGZ1X7bTvTgfo6JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3mGpaZX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3mGpaZX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so77242885e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345214; x=1776950014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWD4SQ+EbH9Fd1LuUihrvK7jk2JKZgmBneMysbBvusQ=;
        b=C3mGpaZXu/0Uy9xbCXpYlrrsoiVk/Psvkg5VaNMWrUxgBpoYuVDbyB4azWIDoFBNzC
         7N196v0hrmVdIP8QnrK9RONEr3Eui3ltQngkzoflBIAFruVizRWyIlw67UPoVtxy/QxR
         er8PVnmCtQmhKUgguOKOTkb90dnJBTrP2fuvV05G8cDIaboYGweBW8o5mJknE+AZjry8
         jZsK7a26xLRxxRv+PrpsTFSDwlUCZNxUZh0CWk/Hjd2Jbf2ESsvBdXw+tY+EsyO5+t1S
         uMlJZD5Gncr1XqbgLaWwVDtxV8WC56IKrBuDkj0AY8cyVvLIp+5RvcLZqId373Txwy2Z
         ZrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345214; x=1776950014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWD4SQ+EbH9Fd1LuUihrvK7jk2JKZgmBneMysbBvusQ=;
        b=I7vKhQcvD6KDNiYKlDDvDPKcdWQ39j4O+SnSA5nAdl7VayH+yJ0+ngIsUTRmgGBKDq
         b/y/+ptDLlL7YCPL8bBNU1aF2wMl4+m7imUZU5v8QI8hc5q8ee+So7utv3TVgbC6QKDb
         NEvW3UwehqusWfF1h90pNri7MaLo7YPueJw/SOIWZ54pwddxYNrhXruNoUZg2iqndZsO
         M2mrZ3wSSPOuQpwRpUQrGfrmC7Lio73v+4Bg7ygwDcuuDjhe+PWrvWU2tIR4w0NrM+Tl
         l5Qh97dXgI/1QNLcmZOXDdFSTiSel8elHlMUJFhDOyQ6tY7ivjwsFQGGoUFEj4vw6fpK
         SHow==
X-Gm-Message-State: AOJu0YwWEXk0PO/j8f3kMGJ8MA8OEaiGi0PySeI088tvDeQJJL//RXDv
	LSfssCoXJlYZZLkzO3LyL5i6LlAM8orjKOwLFEuE1kvpqMAtbw7r6b9BB8oySak9
X-Gm-Gg: AeBDieuaZIO78Pqy6jC7C+hpqJip4Qlsalydjr5OiYp7+pqLeUbYQJB/a0wlLV79OHu
	I9rIuzfF5k+m2v5flBi7lptzYxaHUl/icwSP2WRe4e+0caZn2y4xg0VhtR43mDhjAOKtU2dqLyU
	gQTKSLDopftzBh1hGvSZWwmluKJ2rMgoQMdpgRxcYj+ML5G9ptk6DgrijP9Fp6TDBaPX6EFd5hM
	/IRi78is7GxIy3c527TmJYJ/2jNsReJCuAioVhzpFRYMD3LbYnvtQMWKmL/oAQO6tI9dcHcIgTX
	daRihPUVNombtbkZpFCl5QCMVKUj06P3gNfLyN/cz/9nJRVrzLZahifVZHU/Wpf9K4bNejYkkcM
	dhwBuY9YbQF3hhYb/1vB1c/1eswROL0YcRa5jrnfPydkULuaGiXcDjxoRzN997TnXleOgDfuWoR
	ZczLAbOBR7pLUd/hLIm4YV3z2uh7KlFpjYLe/dC6XNh3YCuMzr1NqHGQ5CoKyXbsjHpXCrSdLNg
	9uKti3KJSKIa4xLN4M6/5OblsithTBwg2HWAoYoEETWU+Ttdv2ymgxOx9Uo4k3dG1G8NGY42LxC
	UBtA1FSzHyVVReS1+Meaam/MW0oAtenyzak9N7wLVfnoKngvPlllE1t4JHCyF6M=
X-Received: by 2002:a05:600c:3f16:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-488d6894bf6mr383979175e9.20.1776345213669;
        Thu, 16 Apr 2026 06:13:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3566c4sm13443591f8f.12.2026.04.16.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:13:33 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:13:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 7/7] selftests/bpf: new cases handled by 32->64
 range refinements
Message-ID: <e8ca4497372dbc730e93c98d116cd0dec541296d.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

From: Eduard Zingerman <eddyz87@gmail.com>

1. u64 range where the lo32 of each endpoint falls outside the u32
   range within its 2^32 block, requiring umin/umax to advance to an
   adjacent block. Three variants:
   - range entirely below S64_MAX;
   - s64 range spanning negative and positive values to exercise
     smin/smax advance;
   - u64 range crossing the sign boundary: smin/smax stay conservative
     at S64_MIN/S64_MAX.

2. 32-bit range crosses the U32_MAX/0 boundary, represented as s32
   range crossing sign boundary.

3. s32-bit range wraps, but u32 has a tighter lower bound from an
   unsigned comparison.

Co-developed-by: Helen Koike <koike@igalia.com>
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 151c7a479a6b..6dd9574fd0c3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2209,4 +2209,181 @@ __naked void empty_tnum_u64_intersection(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * 64-bit range is outside the 32-bit range in each 2^32 block.
+ *
+ * This test triggers updates on umin/umax and smin/smax.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
+ *       |< b >|  |                |< b >|                 | |< b >|
+ *                |                |     |                 |
+ *                |<---------------+- a -+---------------->|
+ *                                 |     |
+ *                                 |< t >| refined r0 range
+ *
+ * a = u64 [0x1'00000008, 0x3'00000001]
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000008 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x300000001 ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000008, 0x3'00000001] */	\
+	if w0 < 2 goto 2f;						\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */			\
+	r2 = 0x200000002 ll;						\
+	r3 = 0x200000005 ll;						\
+	if r0 >= r2 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r3 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Similar to the deduce64_from_32_block_change test for smin/smax boundaries.
+ *
+ * a = s64 [0x8000000100000008, 0x0000000300000001]  (crosses sign boundary)
+ * b = u32 [2, 5]
+ * t = s64 [0x8000000200000002, 0x0000000200000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change_signed(void *ctx)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = 0x8000000100000008 ll;				\
+	if r0 s< r1 goto 2f;					\
+	r1 = 0x300000001 ll;					\
+	if r0 s> r1 goto 2f;	/* s64: [0x8000000100000008, 0x3'00000001] */ \
+	if w0 < 2 goto 2f;					\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */		\
+	r2 = 0x8000000200000002 ll;				\
+	r3 = 0x200000005 ll;					\
+	if r0 s>= r2 goto 1f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+1:	if r0 s<= r3 goto 2f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+2:	exit;							\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Similar to the deduce64_from_32_block_change test, with conservative signed boundaries.
+ *
+ * a = u64 [0x1'00000008, 0x80000003'00000001]
+ *   = s64 [S64_MIN, S64_MAX] (since (s64)umin > (s64)umax)
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x80000002'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change_conservative_signed(void *ctx)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = 0x100000008 ll;					\
+	if r0 < r1 goto 2f;					\
+	r1 = 0x8000000300000001 ll;				\
+	if r0 > r1 goto 2f;	/* u64: [0x100000008, 0x8000000300000001] */ \
+	if w0 < 2 goto 2f;					\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */		\
+	r2 = 0x200000002 ll;					\
+	r3 = 0x8000000200000005 ll;				\
+	if r0 >= r2 goto 1f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+1:	if r0 <= r3 goto 2f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+2:	exit;							\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 32-bit range crossing U32_MAX / 0 boundary.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||===|---------|------|===||===|----------------|===||===|---------|------|===||
+ *  |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
+ *                |      |                                  |         |
+ *                |<-----+----------------- a --------------+-------->|
+ *                       |                                  |
+ *                       |<---------------- t ------------->| refined r0 range
+ *
+ * a = u64 [0x1'00000006, 0x2'FFFFFFEF]
+ * b = s32 [-16, 5] (u32 wrapping [0xFFFFFFF0, 0x00000005])
+ * t = u64 [0x1'FFFFFFF0, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_wrapping_32bit(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000006 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x2ffffffef ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000006, 0x2'FFFFFFEF] */	\
+	if w0 s< -16 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-16, 5] */			\
+	r1 = 0x1fffffff0 ll;						\
+	r2 = 0x200000005 ll;						\
+	if r0 >= r1 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * s32 range wraps, but u32 has a tighter lower bound from an unsigned
+ * comparison.
+ *
+ * a = u64 [0x7FFFFFFF'00000001, 0x80000002'00000010]
+ * b = s32 [-5, 5] + w0 u>= 2  =>  u32: [2, U32_MAX]
+ * t = u64 [0x7FFFFFFF'00000002, ...]
+ */
+SEC("socket")
+__success __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_u32_tighter_than_s32(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x7fffffff00000001 ll;					\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x8000000200000010 ll;					\
+	if r0 > r1 goto 2f;	/* u64: [0x7FFFFFFF'00000001, 0x80000002'00000010] */	\
+	if w0 s< -5 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-5, 5] */			\
+	if w0 < 2 goto 2f;	/* u32_min=2; s32 still wraps */	\
+	r2 = 0x7fffffff00000002 ll;					\
+	if r0 >= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


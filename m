Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057928;
	b=R5HziwjZnqDI0HVEZn/WSVGQ4voqbsHE9GbEZDRlSdJ+cWewQNy978+XI1tJiNhIpqsj
	 z1luyL0tz9qb2A6Yc/w+dfG2OKzV8xhYTUT3zW4WyJXVzu51Z0A8jd0j/VPBizVepyDrt
	 f6AJrZuYvmm1Dh5WR5bTgWQgV6HmOYOSUcU1JUQXb3KSSPEFhkJpBM7CfZgJUdcf6epgz
	 7oAc/kvIFoM15uaX2hMPcPVTN/lnxNa80c1Y9dF/Zk2Ot6zCurxY4Uld3G8+kAqjVx7EJ
	 70D7mBrloRHMUH0LyzKmVvaCQHPz9BdEwbtOmnO4N3vzDRJ/43C7W1WvMDgntqBhXow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MkhJ8PedzI6S8hVxfKHgTKYNSsZAAQFD8b7d1VB6A2c=;
	b=02FVplttZCeN/3S+rInTHd8SwkMhufo67khqlPARQtP0ZQsVQ9tYhfdG4g83IUglWGa8
	 iWQVVwd45KHw6Buf5hNZEouVaHGWCtQdqOoNuivFWMW0C2JoIEhtVMzpdpGhE8jE6LGMd
	 NUklPHTwpPU5KibK8J+RDpAhVb/VuJbhcN4yhpg+779t2VgIk81cytgJMWu25lWNiPAkV
	 WxRvkah0ZEyA8EoPdGY/FSx7jXppl2n1NYDc5A276JdvGroTJgo2v59nUCsbHsLqUlQH+
	 5pmiMZLvTX6A/2e26DOLyKUBnqvBu/zjdawjMHadAeL7K5LIbaVdxBGtwYv129SQM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PnMnTPES;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PnMnTPES
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987a2ba0cso22447855ad.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057927; x=1793662727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MkhJ8PedzI6S8hVxfKHgTKYNSsZAAQFD8b7d1VB6A2c=;
        b=PnMnTPES68Rv5kAOV8Y4XcAhj1PX1qQrv1Mh8OnUvkABn312wEnQPKMJ+XQ0hRAwlb
         5xvCVLzS4xzrulvN3lh3Og0gVLAhQsqConj/+8SN9DZOSt8aKFNjmbYNFKUq7UtDo3hh
         51MwJGJgbXyurbmE8WX0pChKBtU0kJ+ZQPuAAslL+gKxEGfM2UlyUrdgw+0dW6ggo9Xm
         OhdUmwrvf41UsBG8c9ZIDUs9pcwOWu0Oa9JE93ePNO9x91cVmpbikmF4qDXcUHguNbyD
         Y5RsZNCgrZy9CEOeprKYumVSvqYk/Hvn+HWZ1McortilX9GKuTeQ/esmj96CB+AptIUj
         IDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057927; x=1793662727;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkhJ8PedzI6S8hVxfKHgTKYNSsZAAQFD8b7d1VB6A2c=;
        b=S6cHeW9MmlzPwFSWx1u8i6pwelU2unRyX46vIGlikVh8kLS61e7pbc2lSXL4HqzmDE
         Tm92i7BwCs3auxHCkmmdeR7ne+hDWGJoUXPYdZVlcs4Qt3EiSbOTHzKeVnG+HFhoPoPw
         dj/1rCn/3yyX3iv8EGBWkOrymYhTPWz5uzecBmKc9itcwjM5FOjRwCLYNBQO+uQ3Wlwl
         XyKdpuXYx2+aY09FuFAjaFemNxJvtckA/lUHXwam1Wb0TcISIzU7QpRZl0oZgNBalpw5
         1QdNlSozKK9nYGBVbUYGjDOBzuM/7NtT8eWo+q2iayqjKr+XMkPoJvNQWp18x/p7RceC
         NZXg==
X-Gm-Message-State: AFq9FYKyr7SkrYVRDDV4eF77JEygDJqfL+Gtw2Nv0JkkyJ3zylA0ub7j
	Mrgl/kG/Oe/kZGlpeR9kVX/7DwZuLkURNpoFkE2R3bVZYL6L7oOpV1ZqLdGPDA==
X-Gm-Gg: AYBFou3I68V9g6K1BuI3SVOdpWABMRAL2MoYPnQQ1Q2RI150XXGmHGl8vPVCcRSAPG5
	nwt9nOoO8jxLDwWSQanRW8d3p8ufZTwIWOaKWpdjqP/qWMiXs//TMrG8kjrwodTGtOCBDfQM/bb
	scfQ7CdpR04CykGWoMGQovYVeMa0VBwiZp9Bsg3xL8cBiKeixwIVuKpHMD8FM6d9noufSsSgu0U
	CVFzeSf3TcmLLYjBOqOI8y68Ygn4w0pUvTZ3JxZT0rtqaDqIf3drYXISMX187sb7IobXKReBqS7
	KkbA0bLORIswDgBVzkHxUK8+WDvh1HL+y3MGeVciMEhk2cJRNuNE9LNHWz6SEwkmRBwQPXVeTx1
	IL8A79BPqBuKWsRGqjlUfXYz6UDVXjYIxJ0O4WoTlzIUSlZQ+ELSjVNihIW/mds+ZUIwhidjA+T
	tDeM+UtWl3jC//rnKiIe4DDQCthA4R/wdI4HsLMttnQSTtpei8/huWK09zvljp2k26B+o/nxBjV
	tGBJ1TFeP9uCfS1/RRKfPRzQZsup21/JgKrhci3kinrNxlQWmxusLYoK5yEPEf36xGtJbye16v1
	L+AOee000G42uRx0VJXLQ6Jh1eafr1fSqo8TKAJKCiZ4
X-Received: by 2002:a17:90b:5805:b0:3a0:b312:1fbe with SMTP id 98e67ed59e1d1-3adea899396mr6508450a91.23.1793057926937;
        Mon, 26 Oct 2026 16:38:46 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 07/11] selftests/bpf: pointer operands for 32-bit recurrences/latches
Date: Mon, 26 Oct 2026 16:38:27 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-7-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add four tests for pointer operands in 32-bit SCEV analysis.
Check that loop bounds are not inferred for the following program shapes:

     32-bit latch          |    32-bit recurrence
  -------------------------+--------------------------
     r6 = ... pointer ...  |    r6 = ... pointer ...
     r7 = ... pointer ...  |    r7 = ... pointer ...
  l: r6 += 1               | l: w6 += 1
     ...                   |    ...
     if w6 < w7 goto l     |    if r6 < r7 goto l

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 109 ++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 2103c58cfaad..805157cfea78 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2971,6 +2971,115 @@ __naked void ptr_stack_other_frame(void)
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__log_level(2)
+__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
+__msg("loop header at 11, can't compute iterations count at 14")
+__naked void ptr_map_value_jmp32(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	if w6 < w7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__failure
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__msg("R6 32-bit pointer arithmetic prohibited")
+__naked void ptr_map_value_alu32_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	w6 += 1;					\
+	if r6 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__naked void ptr_map_value_alu32_latch2(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	w8 = w6;					\
+	if r8 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 8, can't widen r0, expr is (zext32 (+ r0 1))")
+__naked void ptr_map_value_alu32_non_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r1 = 0;						\
+1:	r1 += 1;					\
+	w0 = w0;					\
+	w0 += 1;					\
+	if r1 < 4 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
 /* Metadata and packet data have different origins. */
 SEC("xdp")
 __success

-- 
2.56.0

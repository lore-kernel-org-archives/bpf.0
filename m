Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418A3F54CB
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796699; cv=none; b=JTY2j0B100ZZEWSRskxJFgH4KqKhzRsz2tEXyAb4qefwACGf4qFyNooDRvczZ+zO6zckYvWxhuE7gO4z6+DIU6F+aB8+P6vB/16yjmJi+P5sa5KUNa0XOfdMLtCjMheqPOa3FLpnaO0sK5SNod/I8QEL6yDHIxz27owjbbFI3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796699; c=relaxed/simple;
	bh=HnILx6srqYNSVl+PVnybpHPN9GIGCOQgqJiQfnqdnsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfzmbFudB4c5Q6qL+BOyh7J3y6O/k0n+CNVJwPhhBzNUWOwltFHhMYC6YWJRzjhv3EzFm1CD7Y2MHbTy/A3swKkW2XKqolDTZK/T8SNmWAwBSLeXPjxLccaxJ8peqyjGh56Itd10wZW+Fus+w2hVWCdTy+SsmBlAOus7t6riMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OseE3jKd; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OseE3jKd"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so28095855ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796697; x=1791401497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lC50uJg3JX39oNmh2zC53BH7LMSiBuHwAv317RzPsbs=;
        b=OseE3jKd1FHjjuc0J/l/1yNdVL9adjBPEy8Y8iG+LdP5PisWESLQFtU40YAXbdUVGr
         OxB6u88y8cYXgtVpuosBIMyYelJLWVvvAqqQyAQtreON645/ubBv8zT++QM1VR27dH8U
         l674bgR26vFVBdoaHMY955snN1G9gcvu/bhrxk3faICRdYghw6HrHdg1r/wB+FQEM0lr
         Dln41Q4wzwTS7wR1umIr762QjezA5WSKxLltxX8XCCBB9rb/ihyPENMTtNnYaZTwWRDL
         WArWCs5Mso8SaukzK3EVah8bgsqG5MrbbIyvqbQfG7L7Zy2Fd+dHBjJ9INCV9vdJKR9e
         c/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796697; x=1791401497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lC50uJg3JX39oNmh2zC53BH7LMSiBuHwAv317RzPsbs=;
        b=jv9rSyDRmEPs9NxsITTpIwrRzCy8zKBHfMb9ZTFCWS3ajDQRjFUprWQvpQc1e2aQV4
         o09Vgl5yV9DAx/Js9cW5bmfPWk5tY2FGmjng9wV8pD5m0jz9nx2zz3p9tFe1F8Cl112X
         c4QEwQIatNx4gTsuUoGiDPF6AEBk36Yfsa/EUW6ZmJw0btvrrUeOgT/TFC0Wf0aAv8vF
         yQqfUO6Afc+jweSyU37pSfv3E6lB4Vypx95q3ZP5oAJqXUS7XCorbIXC2rzxNS4ctKTV
         3A730MhiClHv9fTJM8FRQk+bleZVoLHrLoM/eyb8325Db6AKGFz4Quk40JJJkEHrm5sf
         e2yg==
X-Gm-Message-State: AFq9FYJWHR95MzH93qxGnh6OFbAL9dtA2H0LvgzZhMf2O3Gzh04qqTRw
	0b8FN1b/I1bjJUhGeKCcYUmHABz+EXMO2fkrCyboepyFBsywJIILePV6NUzSlI1u
X-Gm-Gg: AYBFou2fR5MTVW748A9sTr9lzV8N9oGbo9KzGpPDcV6Il4r938w48odkXo67r098NSA
	lMbugYD3bmXAlPW+IQ/UXUxgRc2YN+4HEJeALGP8zjhTuL24hnUUoufi3ilGdG2Pg27w3tugUOl
	p0KUpgJSokh/gCj/DV/YTwOB1IaqdBqOF/HLkUy/9WPz7DG1j2VtIsqMjK+7M8PVF5hUnetY4Jp
	fZl5NPVLCjZOICSF7dxOIRQvGxoEtO/zv+bAKgM6n3o51IndabCExFgvBA95tAd+YpfMgeyKmaP
	RPNfH7IswLVt9WSi+9I1qh9EwGVEXe8PDCsRZHmV4r5ObLWeYyFrNEz5gjVlSBOX5/nboGue8Eq
	E8NaLvuLLzfc80kUa6N/8BxPiXRc7L5mmkvMWhEbMYYKcrVLfuoSTEQziDRDMXmuPKUVu/9AdDc
	W2XDFcXGPJOVX6o+S/77/8JcO9jKTEPiYeJxu7/x/cTKTqQ61KfkmbcjFTaIgv3EYKUDmw2/Npa
	EfOl1USKumLvQKfb+3b8eYd6F0Zd6U9aPJvkJdo+6K2V1ORgINgpQauu1Blx7IYrtb6u8iN3dH1
	HnHE+3K27+mpNsCxuNVLi4nLyNqF9I4caY99+yaC/qg=
X-Received: by 2002:a17:903:4405:b0:2e2:d09f:d770 with SMTP id d9443c01a7336-2e2e4a28957mr17542965ad.26.1790796697159;
        Wed, 30 Sep 2026 12:31:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30099924bsm1726405ad.13.2026.09.30.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/14] selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON
Date: Wed, 30 Sep 2026 19:31:15 +0000
Message-ID: <20260930193127.2181684-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that &=, |=, ^=, >>=, *= and 32-bit &= on a pointer to map value
produce a number for a program with CAP_PERFMON and that the number
can't be dereferenced. They are rejected without CAP_PERFMON, with
CAP_BPF or without it. Pointer that may be NULL and pointer to map are
rejected as before.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_value_illegal_alu.c    | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 9f669cf85c59..31663338866d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -165,6 +165,171 @@ __naked void map_ptr_illegal_alu_op(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("tag in the low bit of a pointer, and, shift")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R1 bitwise operator &= on pointer")
+__naked void ptr_tag_and_shift(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 &= 1;					\
+	r2 = r0;					\
+	r2 >>= 1;					\
+	r3 = r0;					\
+	r3 |= 1;					\
+	r3 ^= 1;					\
+	r0 = *(u32*)(r0 + 0);				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("tag in the low bit of a pointer, CAP_BPF without CAP_PERFMON")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R1 bitwise operator &= on pointer")
+__caps_unpriv(CAP_BPF)
+__naked void ptr_tag_cap_bpf(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 &= 1;					\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("number op= pointer")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R1 pointer arithmetic with *= operator")
+__naked void number_mul_ptr(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 7;						\
+	r1 *= r0;					\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pointer with the tag cleared is a number")
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 bitwise operator |= on pointer")
+__naked void ptr_tag_cleared_deref(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 |= 1;					\
+	r0 ^= 1;					\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("shift of a pointer that may be NULL")
+__failure __msg("R0 pointer arithmetic on map_value_or_null prohibited, null-check it first")
+__failure_unpriv
+__naked void ptr_or_null_shift(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r0 >>= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("and of a pointer to map")
+__failure __msg("R0 pointer arithmetic on map_ptr prohibited")
+__failure_unpriv
+__naked void map_ptr_and(void)
+{
+	asm volatile ("					\
+	r0 = %[map_hash_48b] ll;			\
+	r0 &= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit and of a pointer")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R0 32-bit pointer arithmetic prohibited")
+__naked void ptr_and32(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	w0 &= 1;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
 SEC("flow_dissector")
 __description("flow_keys illegal alu op with variable offset")
 __failure __msg("R7 pointer arithmetic on flow_keys prohibited")
-- 
2.55.0


Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6402FE042
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945244; cv=none; b=iloOJw8Rhmh6kINJWTjHRsPBExV99XiLcxavFbmRR2OXtcKiaSUKQGT1Z/avCPnq7+m1PupqXpy1WbAROQEJSH3Y0xQVLWuWO8B4dkz8VdolFOZSr5vyVs7Y+chSvzF937pKQZN5KbEkFrLqfoptcFG6oLXM8Rt9WFT+dnzvI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945244; c=relaxed/simple;
	bh=HnILx6srqYNSVl+PVnybpHPN9GIGCOQgqJiQfnqdnsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxCb4FhY28pzCd5h+i3JFP9N2MkIdSIMeZBlQVxjNDcuHbBOQed+X4cTDsmKPNcTefGfAAF6my8ithM1pplj+dcjXE8nSe0y1MIABHuuFj/kDz3GQa1jtbPRDKXNCqh8i+jrt2XoeMg4TdaLnCgG6SJL8IRPUPfBB+tqG427diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqlfrX/F; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqlfrX/F"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so3666832a91.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945242; x=1791550042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lC50uJg3JX39oNmh2zC53BH7LMSiBuHwAv317RzPsbs=;
        b=QqlfrX/FrJDNpoP6xRmBueGiiI1U6Czj6B3hlszsvPXBtHIlUd6SMNNhfc5mfcuy6d
         XD0GQJzbNKjKzCt5MKpepNMwleuq33X5k4zaX7114DrHeySqPB241SK9wK6rORuliXdB
         d/9gtO8eFOq9mHjmHv469e5QwD0tJFz96II9xRP3QL2yi3hCu/VM5r4NRWGnbuiPhC7+
         Zg1toLzDCWA7tqKMPlU6UCrCMXi1MHRcK5OilbR2mZw95JXpb/AwdqKrR/PXHp8pZ1rn
         xcGo3XMuTpJOLVDX960AErhbLSm+86zvnzjoB6iRyCn48/gn3YhsH1a3MUQBQIt8BPSP
         KcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945242; x=1791550042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lC50uJg3JX39oNmh2zC53BH7LMSiBuHwAv317RzPsbs=;
        b=TrvRQYfsrhR8Bxe5dbpwH51oxY7lKsY5uOuh5RxRyUOai3nRH5Sp5NqAk/pQ8oVCX3
         rluUyidvvP//DBIsKrNgi/mhGLKlEwIF/cEJ2dzsskk5PPWU3XpQIMB/MYQ371iAk62Q
         mSVYqV04p/mv6zxDmC4xDP2SfBnssUx4Loa66hB9pVEzAets7E+jKXutjLaBaQ+EGUpY
         hDAUU8vWI2LLGrmfhQ7ef3ahZT6VYxhFGnjue7iBTh1j/Ctu0fqi2Z+yqFHsJjYsmsH6
         OHM7ypVoKTHDCXGyykE2N9uSdt2JxQTxQzf3UsbBPHoSeLJPUF4FKhW+lzW23qAF6qJV
         MWKQ==
X-Gm-Message-State: AFq9FYINf/RurgtuMI2lMCBFq4BVYeqHJEobGqFOsN0QkTxQK5m+p978
	/bl3tVSXU7lGYCXZpLnvf7tkNvu9hRT3K6+aiBqAiEe4pGgC0yFiPKhF8tOSLMZGifI=
X-Gm-Gg: AYBFou1NLZlpcHJ2uVI3W4G7roLyNE04aS0/gX28tJ7ljuVUBVKNVU7K7UXSuCSOJJ/
	4s+S8RWrMVgvaemJG1QWK9CKCnFlRlJCWbHyF7STjnSszR9dVzRUATll/aLxwUUzQ66dLpQi8+F
	uN7oiJATVyFIkHp2NVMgF/sH3gcGF5fBKNaszf/9qDyqo0jgVEhH8Wa9tlakdRfHlumE6paj1NQ
	Q75Ygf+1VBbIDt3H9+bwjmah3dUMtYHez8eDMFUdcGoHnZ5eSdobCZzhNxLFW/QxmiTcUE+cct0
	H6Phy/1/VU2DXO/T4B1I2SSY/tpoK05U2unRCC9f9zuNtDkm8pr81YY8qXuTFwb4lwIVbtz5nJN
	60WfK6eWNLWBtLLf8yJwN/sfffupaf0Lu8+xmnqHcrrQRIE/BaU/uJOVhiDb07dOUeYaWe9QEsa
	mDvr5Rl0XDnmCoLLb3wMujfClcd92Qc8znfm0NvC5dTt3MxgAkds7D95sE3cQL6cEGMiz6uC/IJ
	n70Iv9zVQm/CmU5hgltyjRF5OMjVwaiR9OGMC3ZsEhw1m5mb5XUO1V3aiPtqAf+reuK577BsISl
	viVDC1renGqQV1zFBtU+6ZJ/Pey7Om0XdSaM/WY1f1I=
X-Received: by 2002:a17:90b:17cc:b0:3a0:bf26:f24a with SMTP id 98e67ed59e1d1-3a6ceacff1bmr2337782a91.45.1790945242415;
        Fri, 02 Oct 2026 05:47:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd135d8asm1559798a91.3.2026.10.02.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/15] selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON
Date: Fri,  2 Oct 2026 12:47:01 +0000
Message-ID: <20261002124714.180012-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
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


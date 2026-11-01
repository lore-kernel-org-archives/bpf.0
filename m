Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555241;
	b=4GZZTLKZhjp3oQG/H193gFxmedzEMyr7HYYdhXMN4sx3GGqA+mqaxlP4yYU0NM9HgTvM
	 npcEX3MaArPEGG8Shi/eex9kJO5rVDygbyDliKfcCnI8FBZANL2kzDRjOHhtJwkgO6SoT
	 ehwsS0qCMdUbYWR/cXLE25F28lQyFvZ0yXaNNNyudJnrFhp7Uw9Vcbq1POTdP3d95iBM7
	 5eP92Hs8umlumi0U6KkT7dz08fa/zNAn7x7e6jsfIpbh0jck9bwUDERXUu9tLTS6mGLs7
	 R+KlzPGkRgB++XxLq/lZjURkQ7SaOEV9gZflYlcFY2KXMNl5hKO3A5YUKYLZ1zG/7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkVTBsURwmSJasTYwD+5mAW458wDketl/2WkO/cm1lA=;
	b=Rergq7OUBmxyjTdZhuvYcNY8pywo6U/H3IeDDFi++JbK7XmLjt7f3ZBmPOcrvFfl/NfV
	 T2iEQm7SdT9dkXJ7Jm2l6lswxlx0tH/BzJbzZAQMMiqBhsfQBmHdEsMneN8+QtbVuSlLE
	 XZrflw5dsu9cwFqmlSsKNUOS/k85VrZ6ug0/el4vKH5pYv6MXtDT8+AFTEXnNXMt6dojg
	 83Xb02/hZ/1bGrF+KSWTfqqMPRbEVf/j6NBkaME+CAD51hbLxH3GML+8HmHo3onJ3wUWc
	 WqexMQRgejChf2adVRmefE6luHyPVBqiABiZ8enHWTcRaiaiISmUXEDewkzeHgu8hwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAQ5Cmhn;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC49606A325
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC49606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAQ5Cmhn
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8871ada1a26so16160937b3.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555240; x=1794160040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkVTBsURwmSJasTYwD+5mAW458wDketl/2WkO/cm1lA=;
        b=AAQ5Cmhn9rfrSSL7nnwc1tTgrCAWyKi4b7GE5lHbMOdTmZOKpy84C3sA79MDVtxS/D
         O9sSk1/+PuOPuZCcESB35I9PLC73SX5fwyKFqH+KtTF4lojg4oeAmrje/nLWbQ9kaxhP
         f5nrfSCTk/iufoGw1m+x8lDZhqt+YJqY576u9wt2TWBTlOLrtORY99lYTNWVuau7XWI3
         lJvM84MOZRRKjLy5sil6tMBY9IR4qFgyHPE0Fs0bU5iOVKFaM1iLesXkBH/XIM1mBOHQ
         4zUYOGJAl+5W743Y0I6lddPeSuMUDa31BmL4VJgv032WPR5WLMB41h6vI2CDO08Y+22w
         kz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555240; x=1794160040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkVTBsURwmSJasTYwD+5mAW458wDketl/2WkO/cm1lA=;
        b=0YX5gn3VK/JVMqvOJqqDgIVDarYBrHxlSKERBkc1Z27zW38kPz8y2T7vppk358xVSS
         18OkvaKQxlDHHKnmR8QcKeACPykgjzXntvRSZHayNZDlYQQD0tgKMJHv1DwzJDRSbsRe
         tNZu//X406zIPaEbKgJ98A3LpiiaP5l4rZNHK+EVttElduo9fx5OrvooB2sd/7eIv7QP
         zkm1w/ZOtiRJk7TvFsw5i8HqnomomnkVOze7i0sBDHYf/Uq4a+dPPepa8/Nbt3kelVcE
         fs/xzlwmnSKicsDJO+CX3BZJm2DssugPygwdijueeSxi21as59CpB6+CjreI/RlXCDpf
         gpDQ==
X-Gm-Message-State: APuU4Z+NhFTsgpDjN7edxPQLjhRlh1brg9OWkOxTj8ydqjPIXGpSRkJd
	Miiz2FUpy5ozkgA8PWBVFliHbHYubtQwWh193fbROeLfGV+c821uFVeIzVp/Tg==
X-Gm-Gg: AYBFou1aLyjsKj4cimI2Xtoq71krB0KgKxFLnfVNAifgfQUBuRWuinWENEb+qtaLFys
	hrl6aw8dO0TgvAWibXjWtVPyayaRBHSEcx6Qa0NV+YocvhhavRFcyxvQ5HHSXiNOU02NnlCSPyR
	1fKglYnYTrXZMa5zwHZiXpXVIzqHP3/1VGbvhE9jEepNYs/8r91blmlsy+RcgHxwG/pQwuveLWb
	X58xWfLEOvFxbmztcgaKEVpkH5DrTiHDurvS2UsabSS7H8puamjyjcwh3ArKUCTkdW5KDHxYEE5
	Vw/Vk/+bxiq87N8mJ8diprc0yl6o6erbxzVo3oogFD7xjElcqMGUNu6MIGkgGSay9RXmRYdK8Jf
	Pf05Z2mcb4o7bCUFForgPPnbIr4NOzYa72ckfPG0/Q7gcO9TrXLdrqspNxi+Y355utKOK0yE7Zy
	J3DPlfC1guiKSqfHEdEoCkdVOqQJ/qTfQC4a5pDlLcxz3FdBkEKzjN+7LcBVC8FVVjHAXtrtZDc
	qL5ZTU9Wa2uuJo9k+2NyCcpUpQEtmv0PlUDo5qs/F0/FHUxgkd/OMxHim6TrOyWI0mWSKp48gNW
	d5Q3EjBJOUE9A63hxkrsp9SY/g63Up+L1titIVjb91ykxsx8pKpRgCoxunW9JlbOkCrOVjfHns0
	KPcphKdWyfOV95GCO1gzg0F2ZQS8kKiaOFO9CXap4qQSVi6GVJZAGjoIOTuGMZmTsqctGlIZWlQ
	==
X-Received: by 2002:a05:690c:c510:b0:8b0:e13c:2858 with SMTP id 00721157ae682-8b2b67c82dcmr44502797b3.92.1793555239973;
        Sun, 01 Nov 2026 09:47:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bd40sm39379827b3.16.2026.11.01.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:47:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test array lookups with a key that is not a constant
Date: Sun,  1 Nov 2026 17:47:00 +0000
Message-ID: <20261101174700.4086827-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
References: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
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

No prog has a NULL check. max_entries of the two arrays is 2.

  key                                      result
  ---------------------------------------  ------
  0 or 1                                   loads
  1 or 2                                   reject
  prandom & 1                              loads
  prandom & 1, per-cpu array               loads
  the counter of a loop, [0, 1]            loads
  compared with 1 after the store          loads
  [0, 1] on one path, [2, 3] on the other  reject
  [-1, 0]                                  reject

The verifier examines the path with [0, 1] first. This state must not stand
for the state with [2, 3]: the prog loads if the key is not precise.

The last prog uses an inner array with BPF_F_INNER_MAP and max_entries 8.
The array at run time can have fewer elements. Thus the verifier rejects
the key 'prandom & 7'.

The progs that load also run.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_array_access.c         | 165 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_in_map.c |  31 ++++
 2 files changed, 196 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 0a187ff725cc..9333321c3ac8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -680,6 +680,171 @@ unsigned int mixed_const_and_non_const_key_lookup(void)
 	return val->index;
 }
 
+SEC("socket")
+__description("valid map access into an array using one of two constants without nullness")
+__success __retval(4)
+unsigned int an_array_with_one_of_two_constants_no_nullness(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+
+	/* the paths meet in front of the one store to key */
+	key = bpf_get_prandom_u32() > 42 ? 1 : 0;
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("invalid map access into an array using one of two constants without nullness")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int an_array_with_one_of_two_constants_out_of_bounds(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+
+	/* 2 is out of bounds */
+	key = bpf_get_prandom_u32() > 42 ? 1 : 2;
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("valid map access into an array using a key below max_entries without nullness")
+__success __retval(4)
+unsigned int an_array_with_a_key_in_range_no_nullness(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+
+	key = bpf_get_prandom_u32() & 1;
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("valid map access into a pcpu array using a key below max_entries without nullness")
+__success __retval(4)
+unsigned int a_pcpu_array_with_a_key_in_range_no_nullness(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+
+	key = bpf_get_prandom_u32() & 1;
+	val = bpf_map_lookup_elem(&map_array_pcpu, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+/* Scalar evolution gives r6 the range [0, 1] for all iterations */
+SEC("socket")
+__description("valid map access into an array using the counter of a loop without nullness")
+__success __retval(0)
+__naked void an_array_with_a_loop_counter_no_nullness(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+l0_%=:	*(u32*)(r10 - 8) = r6;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u32*)(r0 + 0);				\
+	r6 += 1;					\
+	if r6 < 2 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
+/* The slot has the id of r6, so the compare sets the range of the slot too */
+SEC("socket")
+__description("valid map access into an array using a key that is compared after the spill")
+__success __retval(0)
+__naked void an_array_with_a_key_compared_after_the_spill(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w6 = w0;					\
+	*(u32*)(r10 - 8) = r6;				\
+	if r6 > 1 goto l0_%=;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
+/*
+ * The verifier sees the key [0, 1] first, then the key [2, 3]. The first state must not stand
+ * for the second one.
+ */
+SEC("socket")
+__description("invalid map access into an array using a key in range, then a key out of range")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void an_array_with_a_key_in_range_then_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 3;					\
+	if r6 > 1 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	*(u32*)(r10 - 8) = r6;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u32*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
+/* [-1, 0]: the key is 0xffffffff or 0 */
+SEC("socket")
+__description("invalid map access into an array using a key that can be negative")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void an_array_with_a_key_that_can_be_negative(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 1;					\
+	r0 += -1;					\
+	*(u32*)(r10 - 8) = r0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u32*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
 SEC("socket")
 __failure __msg("invalid read from stack R2 off=4096 size=4")
 __naked void key_lookup_at_invalid_fp(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index 621248a02a1f..5ecf53ac9321 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -85,6 +85,37 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+/* max_entries of the map that is there at run time can be below 8 */
+SEC("socket")
+__description("map in map dynamic inner array lookup is nullable, key below max_entries")
+__failure __msg("invalid mem access 'map_value_or_null'")
+__naked void map_in_map_dynamic_inner_array_key_in_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 7;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_in_map_dyn] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	*(u32*)(r10 - 8) = r6;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u64 *)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map_dyn)
+	: __clobber_all);
+}
+
 SEC("xdp")
 __description("map in map state pruning")
 __success __msg("processed 15 insns")
-- 
2.55.0


Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246E361DCB
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123068; cv=none; b=c34uKTK7MWffN6tiWV+2aiv23iZS6U6tnqa+/4+amvp2EGy0BxPBZn1cH1w5Ef1Q9yIITHzAT/8JN1A/JzNbEp0P8SNVGD8sDdXZA4ll36U+h01ij0lEYGmyctMHTbrq2jTPJoh93aNebpZSJC4jRuhy117+OrPf9utwS3aikMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123068; c=relaxed/simple;
	bh=limKVhOddzfckR/6NCc2rKypMa9vGI8Ox95kNXtsbGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDzudnV+cFbQIUzoEtD7z9aTtdgTAeMFiwuDIvG/muoMUEQCdPykckfyn8BV9SGSy6U1/sFm53TpgKVU8tbbgbtaP4VwkGTMDMoDEqVx/bwws/fffa5MJUc1meP6dOxLYrHJM/qmppyujCvdJxYR+Nw0/dtL/48Ee7AZkf8FZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjfwAyRq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjfwAyRq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3205770a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776123066; x=1776727866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHlz2g+ASehekPEJejgubhta7Nf2P2LbJZeUg6pDZfU=;
        b=PjfwAyRq3kX8jxbSoKBK7oA7R56ujp7hX7jaoGbCGLoze+NRlEzTNV4ho1cdSBuZYQ
         vT70DFaAhWauAQjxk/Gw7lv579cxMWV50+pdY4G6dWQQTcqmgvOVN9R5Kn1H6QjXYpWS
         Wrwztlh/ytreT0wh8izj3g3ha86/HFs/T+Th8zdBV2fY5mSKj3M9dUkWIwvn9oRUkcNG
         G9xh9etW/UFmpjMjmyVs+ZxEajTIU5dJ13uaE7QrtTlpHmRL8HCUEOMP2efJfUenH7SS
         UQonE1UDiUWFz/+/6uWoQ3XGJ80vaZwmvvRpPHg7hH1TpaQSHN4yUqalMCXe3HZads7b
         +MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776123066; x=1776727866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHlz2g+ASehekPEJejgubhta7Nf2P2LbJZeUg6pDZfU=;
        b=eX3EH+mqX7VbgvT6yMWrXDM1FBuImKkj+PKovxNRe2+pavVbfCdsg/bVYHdFbPon7M
         tIjBmaA8FjGJiVpCFeqapNihFjlKJndH1//t5B+QrAyVINDWlxH6WTmhN92dJR+U04K6
         A0crfVqfmBpEBpg4So7mirz+bZrs6HwePuZ2MjJ7GbvaNYaZ7J0lzVwUlbJPAivZbTjz
         vgovtF/zuLvKWKC/N9Co98jaNMgT7m/GGXBp9M/H0wpQJVpoSanAreTgjcI/OuAqxy11
         1ESKqCIBGZCnv0x8ZHzQzsLsN7PDHlUGOrntodrzbHVJ26OcP2OZ+NL17zm5z4f+LX9g
         TJug==
X-Gm-Message-State: AOJu0YwG5u3CmWE33G8jOOyh/2h0h6cRu7BwqD3Bnx4/6xksO0EGsizs
	WjReVKOqKPHtEYwYosV71LX4BHyM3ttW8sAnEqcEFz1BsKUF0ROdpGJpQHM4iA==
X-Gm-Gg: AeBDieu/ARQ2vYaFxwX2W8mKLeovObTflt1iHoTLXWsVdz4VX3Kc0l848uIz+EYHW3n
	HmFl8c2X7N/eAWKvoECSmnNQj2N7yVtS8BXMH9r6NY+j1w6RPiRGdOF4EkiQBsQDaaYSWAkaR6q
	IU7yxICx7HJtF1gOtNkhpEbpkfjvoB8jXRvUg86PCESXcil+o9bPBVi+XdPnBClzoFkT8ZuvolO
	RA6/V4Xdi0eyKlPObYfBU3yJPBRkeIh/Ist1IOhGt4UJ+nUIFbVYAUGrdO65TxZrH0tSKUIkGVB
	K8A65Q/xzXOEPX25N8ytjsbTBBwOiG7Sg5LnL/wAaroT/Ct5I6Y5C0kZNmAdE14EMn5ui66I79Z
	mOCM7EPu05Mc89LUsYs1EJxzsvvxOMX/ret+a+NunU19OXZkuV3QA8fqtus2K3kul1G1BIOXP/g
	8GeBGdRpiJXakx4+GWst2vwh+nkLjeFPV26kPLiI79AXiaEbzMKBOz4B5ZEm0i5izazjCPHeTPF
	5II6Q==
X-Received: by 2002:a17:90b:4c50:b0:35d:8ea1:62df with SMTP id 98e67ed59e1d1-35e42838d40mr15906490a91.21.1776123065939;
        Mon, 13 Apr 2026 16:31:05 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2bc5575sm584349a91.3.2026.04.13.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:31:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 16:30:53 -0700
Message-ID: <20260413-stacklive-fixes-v2-2-398e126e5cf3@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
References: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add test cases for clear_stack_for_all_offs and dst_is_local_fp
handling of multi-offset and ARG_IMPRECISE stack pointers:

- st_imm_join_with_multi_off: BPF_ST through multi-offset dst should
  join at_stack with none instead of overwriting both candidate slots.
- st_imm_join_with_imprecise_off: BPF_ST through offset-imprecise dst
  should join at_stack with none instead of clearing all slots.
- st_imm_join_with_single_off: a canary checking that BPF_ST with a
  known offset overwrites slot instead of joining.
- imprecise_dst_spill_join: BPF_STX through ARG_IMPRECISE dst should
  be recognized as a local spill and join at_stack with the written
  value.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 193 +++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index b7a9fa10e84d..401152b2b64f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2647,3 +2647,196 @@ __naked void spill_join_with_imprecise_off(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/*
+ * Same as spill_join_with_multi_off but the write is BPF_ST (store
+ * immediate) instead of BPF_STX. BPF_ST goes through
+ * clear_stack_for_all_offs() rather than spill_to_stack(), and that
+ * path also needs to join instead of overwriting.
+ *
+ *   fp-8  = &fp-24
+ *   fp-16 = &fp-32
+ *   r1 = fp-8 or fp-16 (two offsets from branch)
+ *   *(u64 *)(r1 + 0) = 0        -- BPF_ST with immediate
+ *   r0 = *(u64 *)(r10 - 16)     -- fill from fp-16
+ *   r0 = *(u64 *)(r0 + 0)       -- deref: should produce use
+ */
+SEC("socket")
+__log_level(2)
+__failure
+__msg("15: (7a) *(u64 *)(r1 +0) = 0	fp-8: fp0-24 -> fp0-24|fp0+0	fp-16: fp0-32 -> fp0-32|fp0+0")
+__msg("17: (79) r0 = *(u64 *)(r0 +0)         ; use: fp0-32")
+__naked void st_imm_join_with_multi_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	"*(u64 *)(r10 - 32) = 0;"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -32;"
+	"*(u64 *)(r10 - 16) = r1;"
+	/* create r1 with two candidate offsets: fp-8 or fp-16 */
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 2f;"
+"1:"
+	"r1 = r10;"
+	"r1 += -16;"
+"2:"
+	/* BPF_ST: store immediate through multi-offset r1 */
+	"*(u64 *)(r1 + 0) = 0;"
+	/* read back fp-16 and deref */
+	"r0 = *(u64 *)(r10 - 16);"
+	"r0 = *(u64 *)(r0 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Check that BPF_ST with a known offset fully overwrites stack slot
+ * from the arg tracking point of view.
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("5: (7a) *(u64 *)(r1 +0) = 0	fp-8: fp0-16 -> _{{$}}")
+__naked void st_imm_join_with_single_off(void)
+{
+	asm volatile (
+	"r2 = r10;"
+	"r2 += -16;"
+	"*(u64 *)(r10 - 8) = r2;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r1 + 0) = 0;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * Same as spill_join_with_imprecise_off but the write is BPF_ST.
+ * Use "r2 = -8; r1 += r2" to make arg tracking lose offset
+ * precision while the main verifier keeps r1 as fixed-offset.
+ *
+ *   fp-8  = &fp-24
+ *   fp-16 = &fp-32
+ *   r1 = fp-8 (imprecise to arg tracking)
+ *   *(u64 *)(r1 + 0) = 0        -- BPF_ST with immediate
+ *   r0 = *(u64 *)(r10 - 16)     -- fill from fp-16
+ *   r0 = *(u64 *)(r0 + 0)       -- deref: should produce use
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("13: (79) r0 = *(u64 *)(r0 +0)         ; use: fp0-32")
+__naked void st_imm_join_with_imprecise_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	"*(u64 *)(r10 - 32) = 0;"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -32;"
+	"*(u64 *)(r10 - 16) = r1;"
+	/* r1 = fp-8 but arg tracking sees off_cnt == 0 */
+	"r1 = r10;"
+	"r2 = -8;"
+	"r1 += r2;"
+	/* store immediate through imprecise r1 */
+	"*(u64 *)(r1 + 0) = 0;"
+	/* read back fp-16 */
+	"r0 = *(u64 *)(r10 - 16);"
+	/* deref: should produce use */
+	"r0 = *(u64 *)(r0 + 0);"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * Test that spilling through an ARG_IMPRECISE pointer joins with
+ * existing at_stack values. Subprog receives r1 = fp0-24 and
+ * r2 = map_value, creates an ARG_IMPRECISE pointer by joining caller
+ * and callee FP on two branches.
+ *
+ * Setup: callee spills &fp1-16 to fp1-8 (precise, tracked).
+ * Then writes map_value through ARG_IMPRECISE r1 — on path A
+ * this hits fp1-8, on path B it hits caller stack.
+ * Since spill_to_stack is skipped for ARG_IMPRECISE dst,
+ * fp1-8 tracking isn't joined with none.
+ *
+ * Expected after the imprecise write:
+ * - arg tracking should show fp1-8 = fp1-16|fp1+0 (joined with none)
+ * - read from fp1-8 and deref should produce use for fp1-16
+ * - write through it should NOT produce def for fp1-16
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("26: (79) r0 = *(u64 *)(r10 -8) // r1=IMP3 r6=fp0-24 r7=fp1-16 fp-8=fp1-16|fp1+0")
+__naked void imprecise_dst_spill_join(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	/* map lookup for a valid non-FP pointer */
+	"*(u32 *)(r10 - 32) = 0;"
+	"r1 = %[map] ll;"
+	"r2 = r10;"
+	"r2 += -32;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	/* r1 = &caller_fp-24, r2 = map_value */
+	"r1 = r10;"
+	"r1 += -24;"
+	"r2 = r0;"
+	"call imprecise_dst_spill_join_sub;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(map),
+	   __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+static __used __naked void imprecise_dst_spill_join_sub(void)
+{
+	asm volatile (
+	/* r6 = &caller_fp-24 (frame=0), r8 = map_value */
+	"r6 = r1;"
+	"r8 = r2;"
+	/* spill &fp1-16 to fp1-8: at_stack[0] = fp1-16 */
+	"*(u64 *)(r10 - 16) = 0;"
+	"r7 = r10;"
+	"r7 += -16;"
+	"*(u64 *)(r10 - 8) = r7;"
+	/* branch to create ARG_IMPRECISE pointer */
+	"call %[bpf_get_prandom_u32];"
+	/* path B: r1 = caller fp-24 (frame=0) */
+	"r1 = r6;"
+	"if r0 == 0 goto 1f;"
+	/* path A: r1 = callee fp-8 (frame=1) */
+	"r1 = r10;"
+	"r1 += -8;"
+"1:"
+	/* r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}.
+	 * Write map_value (non-FP) through r1. On path A this overwrites fp1-8.
+	 * Should join at_stack[0] with none: fp1-16|fp1+0.
+	 */
+	"*(u64 *)(r1 + 0) = r8;"
+	/* read fp1-8: should be fp1-16|fp1+0 (joined) */
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u64 *)(r0 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}

-- 
2.53.0

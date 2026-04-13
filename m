Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144193E51C4
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110221; cv=none; b=TsdIB3V04TpKlV32Nu6Jk0S3z6t3UzoCJPegBn6Ep05+3WmMwUGrVJ712kMrFbF4D0T3TgRITn+QXyYoQLO2soerIPSQGnEwPhEYK4s0/XrfiHcTDbjpNA+hi7Ho7Hb0tt0Uv10wEjJv/erBItH291jsZStmgJP4bo5v7k4li2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110221; c=relaxed/simple;
	bh=h18i0Avw7kbBAyqSEPEDvoVx/UnEXeymvi+CwH6NTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLkcvWizDFf9Lr/z+uSf1zj8g2Dka6iFMBQaLT7HbSDf8/wwJovH/Mjk7rn5XJ/iOopdvLIaaVbH5u6d1CI2jhYbonGv2c4ui49rwmYKzE5mjV6s3gEC11fEJGMI7Jp4FaHnHrfsdc/e8TO0BaTVzLMSlPpAf/d1+FNSGYRgJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL+vlg0c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL+vlg0c"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d90833cacso2941994a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110219; x=1776715019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZUNiqLjCMOpcMhy14RLNpm9rZ3XLPzi9jwrbH9eFgY=;
        b=EL+vlg0c5nPMvGKifV7x/yu8w/XH72Rh2lLX3De4PMiSvYjNMoWAWSS9bIBjYmW1Ea
         49nCbtkBK6vHGzH0X0+RfIWifLNJfV+eLGmYYGA4kq9O3c2tAWB42wz2gOapXVxmRmse
         P5yFKtz00C1QcxH4daASgv77tawZQc3YQYay1VIqHGUn2cCIBku0gWUrsP8PlqWNY7zs
         nMs08QzDseoD5Is9xhPFDv1NEwCFnLUs4VvtN9MzzUt4GRkywY300kyyfdPyxpBrlqGi
         /0678F0WbcI7bA84da27I2bU73kBQ9Mo5TfAlhrQKl04H8j/dMrnOSORcLscE/o7JhJe
         cJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110219; x=1776715019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZUNiqLjCMOpcMhy14RLNpm9rZ3XLPzi9jwrbH9eFgY=;
        b=MBDyWWbyl4KtmVThKV/Uuli1JupGVrL5jda03CYJ7F18xrB++qEVHE2g6fvRh+4CXR
         5QoCwzeNL5kFyJ+b8os8ZzH+NlA1+89QpK4kPNIoCeUngRWJdk14QuXgSSa4qLc/ELJm
         /zLSh4ANKqke1mjSmwVWjlVUl5ZPCUwqHoEK445flkO90pW1SyMJTpnbsbnziA3bigWV
         H7REkcCzXFAB08gE9WFMP/AKaJsQe7+UX0Kdm9LN8Q1T2MBbmijmLNd3/Dp74NdZoYby
         O4emCDYu2H3GLtho8US4dnvlNjT1RpZA+adU6Wk4OrSbbLjnQlvZqfhm9Eqhyx1SfGwF
         LDIA==
X-Gm-Message-State: AOJu0YwFttppvbSyIMPgRHOIl8EpMZNKY7YOLInOHnpguHZk5px9n4/R
	hb6IjIaiq0pmArZzozx6PdAZkK9X72Zg+nfREdH/oRs4B9Dqt+Me1o2k2ir2mw==
X-Gm-Gg: AeBDiet9petR8px2IJAy2At71RQwP9XodwZ7WhkjqGhksk0Wu6hvzI0egUtfnNzbQz/
	W86K8DgXLbWjztF56e6U7AH3Y7MXZc96Z+U/mNvQMd2RBdzV7lXFANsy9NE+x9fDrnbP/+6th+h
	iPcuNoHEb3zo13ZEkBN/DTb3M8akLz/EtZIQf/uqKCjG4qzm8uwTlin5C3wN9xDHURooLx/GPSL
	Rj7U1BRIQJKPQVDrjMSmVJ3fbuywWWnUpD9gA+WjdukQRVgnAlYEYRceh705SyBZn7hf3/0sTvI
	sNOP8JBPbYRGtvxOg0gYyScprlBkFTvwWjd7vfATgvAXStAt5SzkwamC8N2gjCqkNgDhHVVc+5e
	UQv2X6NsxEHduBDuCfaqFEbPEjEStAUR0RXE4yhxRX45M3MvYbO0u9p5hQacPHG0pWtTTj68Pde
	QGR6WFydUhWxhGldHvhvrKY/IC3M8aSTrL5Sf51FOO5LevSgDqI4UaWxAA4FoHcYt6EEIbiMC0f
	TwTYg==
X-Received: by 2002:a17:90b:2fce:b0:35e:599f:aef0 with SMTP id 98e67ed59e1d1-35e599fb177mr6935855a91.11.1776110219297;
        Mon, 13 Apr 2026 12:56:59 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm16452599a91.9.2026.04.13.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:56:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 12:56:41 -0700
Message-ID: <20260413-stacklive-fixes-v1-3-9f48a9999d6e@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com>
References: <20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com>
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
 .../selftests/bpf/progs/verifier_live_stack.c      | 194 +++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index b7a9fa10e84d..536e214d0376 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2647,3 +2647,197 @@ __naked void spill_join_with_imprecise_off(void)
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
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
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

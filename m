Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65A37DE91
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263257; cv=none; b=AVPwgpBNAAjfSdB/FTCiECkQLymYZIF1No3EzPRCTtBnajieV5/E2jkrF1YLDz0PVAMM25sZjZEc3qyv19kSyC4eJDiIQakD1DK7R2dqO2lW7/q0D+VgXp55+GrvR8+5ONXTQKjbXPK7a73m2I5V6TvStFISaEIBoS+B+7gsOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263257; c=relaxed/simple;
	bh=+nV2dDrWsgUKgd4WW4vC1cDi15fKvgLtIdpTrbrkMe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2Aj6tWqPeVQWd6HB2A4maUhvmpgVe2+j9M+VsCZ2m5e0sZRnnwZeu2sON1I7KPgFjDuOEAo6uJiJiRbPBrmOxcgcucQvtzbbp5jLZGBLosYLV60SRjXjGQx/TqdMChHGsh9IxmPxrLg9XhwH9VLTPL8VzkObnBbK1ZEsjCluHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D2kql0he; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D2kql0he"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso6635701a12.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263250; x=1784868050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1L1GjsHLmGk58BggPrtZj3cGawb4i1fhYZ+TPnSPmbs=;
        b=D2kql0hetw2OPzFeCPUEVcJOPKrVSNrY+AYkEvvbY42pb6SAWEsNGzh8KdqZ0QX48p
         Xq94ccIj09LJ1eVH4EEd0O9Orf37hMgU/4mXj6La0M6pPloWTJftsz/VGa39cp+IPLLY
         oyowQL3Zx6JLEOwvMRKD6EJPzI2mIQEgQQR7u8/MJsNh8pi9VU/3CZyX+j/ZUyusuFAC
         TGgt2Xs8XMRcJoQpF0yK2z0OjiG0QMvKnhkeIE6+VkbAoKk7j4/0SKo7MEV2s8+3Rx51
         PVYcurjiIVlB0GTxDJRPoC0l1g7qZzNJ+ZJrTLbrxWH58tQMdFQhys3cGEU8Hh4bu/v4
         m2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263250; x=1784868050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1L1GjsHLmGk58BggPrtZj3cGawb4i1fhYZ+TPnSPmbs=;
        b=ZgQXKGWav2uSgzqQh45oiHbabwRJ+a+CyU3lGqgzVrQJAM5hOg2PRTMzaBetxy4lOA
         DK8LWabijQV+LbutZG9yyKEFbkVdyr0uraaP5rQKKq4r0edI5yx7ItDruXQ6mtvi6e58
         uTXX7i/PrRc1S0NXBvcffMSAw2etsKPkDpqw3AzZp57o1W6oGZxIhLYE3Rn04l3VslKW
         PdlicpszCqhc7y19lO1E/5t8g99JdvGUphGSIS11ftmh4cWnJdrcUT9JEla8wwiiXdVu
         dpbQ8pdHBr6KN+qzxN7fZicDtgl/hnCMU+9clXNeF+D+b3eAkfNAScUvroNhgZefMiIP
         jNFA==
X-Gm-Message-State: AOJu0Yy0x3mmxW4tErMcNyC/0vPnM+8caja737oupnUGn763DJS6AzAS
	UaARgYyan12rliaD6ap4SoU43tP1YKGmrEcPi74jw8CTlHa1RADg9nN43gbAdCZBPzV5DjxkoEf
	jUaDr
X-Gm-Gg: AfdE7cnFFv3ni3X0vYEByi2G9Wwq/2ssv9UfmeJGqPBtWvOZG31kqp/DPb115Yc+aHL
	jpVsm+q62jL9sf+UyB+50ZVXoWkSvZCtkHdii/PiTZ/19IC9Y8Rs/56P59wf+MDCeO1qztJLMoS
	fGBXXHRDhu7zNSgyPPHObSep14oinrtLcgp5FyBGbRj4poKwXBQlE9anezOjQVWDIZsVxuBlfIs
	5Msa2kom+lKnRLQ47mGFLJn8JP5Eyb+AWofgYYyclqVghSQqPb8Scq6ie+nQPYtJdD9SW38+P1R
	QHxrD4wauAFPb+VTXKY8Ep/Q7sGpHGkhYAlUiQDfdq1dXHvs1NNPjW/kRoa1/y4AY+D/bVUA/ha
	j/DYkOCK/YqjqEc9c8MeJCqm7fRykSUTV/Dn3FrOf5NN/fbBcXGYpzYLVcOECdojd4Vs2Q8GVXE
	WQyL6CWK83AsEta5sdZ7Z+cIqKsVlyy9o=
X-Received: by 2002:a05:6402:40cf:b0:69e:383b:c4b with SMTP id 4fb4d7f45d1cf-69e65273c42mr220494a12.16.1784263250430;
        Thu, 16 Jul 2026 21:40:50 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6fb02sm220256b3a.47.2026.07.16.21.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:49 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 6/6] selftests/bpf: Add tests for stale delta leaking through id reassignment
Date: Fri, 17 Jul 2026 12:40:05 +0800
Message-ID: <20260717044009.120224-7-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044009.120224-1-shung-hsi.yu@suse.com>
References: <20260717044009.120224-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit cac16ce1e3786bd98cec0c108e3bc06ed3d3c6a9 upstream.

Extend the verifier_linked_scalars BPF selftest with a stale delta test
such that the div-by-zero path is rejected in the fixed case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  ./test_progs -t verifier_linked_scalars
  #612/1   verifier_linked_scalars/scalars: find linked scalars:OK
  #612/2   verifier_linked_scalars/sync_linked_regs_preserves_id:OK
  #612/3   verifier_linked_scalars/scalars_neg:OK
  #612/4   verifier_linked_scalars/scalars_neg_sub:OK
  #612/5   verifier_linked_scalars/scalars_neg_alu32_add:OK
  #612/6   verifier_linked_scalars/scalars_neg_alu32_sub:OK
  #612/7   verifier_linked_scalars/scalars_pos:OK
  #612/8   verifier_linked_scalars/scalars_sub_neg_imm:OK
  #612/9   verifier_linked_scalars/scalars_double_add:OK
  #612/10  verifier_linked_scalars/scalars_sync_delta_overflow:OK
  #612/11  verifier_linked_scalars/scalars_sync_delta_overflow_large_range:OK
  #612/12  verifier_linked_scalars/scalars_alu32_big_offset:OK
  #612/13  verifier_linked_scalars/scalars_alu32_basic:OK
  #612/14  verifier_linked_scalars/scalars_alu32_wrap:OK
  #612/15  verifier_linked_scalars/scalars_alu32_zext_linked_reg:OK
  #612/16  verifier_linked_scalars/scalars_alu32_alu64_cross_type:OK
  #612/17  verifier_linked_scalars/scalars_alu32_alu64_regsafe_pruning:OK
  #612/18  verifier_linked_scalars/alu32_negative_offset:OK
  #612/19  verifier_linked_scalars/spurious_precision_marks:OK
  #612/20  verifier_linked_scalars/scalars_self_add_clears_id:OK
  #612/21  verifier_linked_scalars/scalars_self_add_alu32_clears_id:OK
  #612/22  verifier_linked_scalars/scalars_stale_delta_from_cleared_id:OK
  #612/23  verifier_linked_scalars/scalars_stale_delta_from_cleared_id_alu32:OK
  #612     verifier_linked_scalars:OK
  Summary: 1/23 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-4-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8741238b2ebd..3b0c300c9cbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -528,4 +528,59 @@ l_exit_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * Test that stale delta from a cleared BPF_ADD_CONST does not leak
+ * through assign_scalar_id_before_mov() into a new id, causing
+ * sync_linked_regs() to compute an incorrect offset.
+ */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_stale_delta_from_cleared_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 unknown, gets id A */	\
+	r6 += 5;		/* id A|ADD_CONST, delta 5 */	\
+	r6 ^= 0;		/* id cleared; delta stays 5 */	\
+	r8 = r6;		/* new id B, stale delta 5 */	\
+	r8 += 3;		/* id B|ADD_CONST, delta 3 */	\
+	r9 = r6;		/* id B, stale delta 5 */	\
+	if r9 != 10 goto l_exit_%=;				\
+	/* Bug: r8 = 10+(3-5) = 8; Fix: r8 = 10+(3-0) = 13 */	\
+	if r8 == 8 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same as above but with alu32. */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_stale_delta_from_cleared_id_alu32(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;						\
+	w6 += 5;						\
+	w6 ^= 0;						\
+	w8 = w6;						\
+	w8 += 3;						\
+	w9 = w6;						\
+	if w9 != 10 goto l_exit_%=;				\
+	if w8 == 8 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0


Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316937C915
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263251; cv=none; b=pbSTuDE3M8459+IZIhjPTbiDUBlKbTKYo1ECwzlbxHsW0kOqjAevlR8bhx0lH1GW/h2FB/3ZC3rc/SCxTAd2v2Da9B/r2WxpcwIU9Pq49oOCuq0sfi/lHFHP7PeDRWhK+XBfeGGh5608DozeMNPSAf0yUrLvgXU5uGpN7bnYlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263251; c=relaxed/simple;
	bh=t8oyTuvaF/0pimcRUR2qFP1YFH9GpKb/3qdtOa8Ngfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnH1FFjES41XzulEaytBxTp2XJ+TQgQof0is5+5Ne9eg2Gn/W3X8uJp2UcUZVeXpJ7wy+oLEOzQooD2K42hmMY89vXv8o7eckTQt0zYQtcy4iMain07QkhjfIE8V8I5FwAo3vKJODM3tgwuGDFaZhWerEPl45JViM5tMA67EXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WI5Z1GKB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WI5Z1GKB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b1da6b82so442303766b.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263246; x=1784868046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DPZW1hM7MByYiVqSKyEum0NYnmYHvi3g+Mja2JvdDs=;
        b=WI5Z1GKBRVCJRyPNNiYKsZTZCLIUrlLFhAq4CV3SQEsUZJ6wr1RuZC6rLS+3Ug31c2
         eRcSNl08mtqJVvR3oWBhJWZutgNU8Gf33M888ahZP0xsOcROcZiV7uBL++HKCTnrpOUa
         9rqU+y25fnlF6ZJLisuWMWRDU8whYMAy3C3ZeXNfWvbTikAwKVpQ34d6xesV4wxIpzrD
         U/J/1PFg1w+3K9ndcvtqypceVm5oZHF7RBgByxBENLQuxGYHHVSrypedU3kDTpT8MXWf
         CWVVe9f0mSO9U7t3CE0LXTJVEXu8jYZnRUpBBkgTpk+wEbMWcN5OgheMbKxNjYYzKYTn
         4Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263246; x=1784868046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DPZW1hM7MByYiVqSKyEum0NYnmYHvi3g+Mja2JvdDs=;
        b=S4KpPbAydiXxdscZEB5EY9ycJizjHcKd0kaC1nPKUeSZqVGHrhkmC1WWYg9Y+cinhX
         Y/oz/PETzGSs4MjvC3jCqxris2NzJVkjN8KHetRczGftMcrUac6bmb/8+zYFDFnRhHVL
         SvE6E0l97HEf6m3gKOn6U2XxzDLlalnPXv5yUntKEbMXqLCZ93XDpGYCsuBvnFyAOdDz
         QbGhLKYa6U+IHYVOXPI77x1whNPdxtqhcnYyJy46j9Wo9dff/erZZoRSTOh59f0uJEpJ
         XqnMTJOPAuEWDIYyyFUJq/2KVFeXJhjfky7LkK6yftC4bU2z+K/9OQG9TCLUO1+oTa77
         HNdA==
X-Gm-Message-State: AOJu0YyLkB0tr/Peubec8cPl4SABFukVOfxfx2mH+8XfZNs8edtlON15
	lEJM/6copJj79zJDMoJkQ7VDvtuP3/HKT1wHtViOYBhgbwqHEtE3FNWzC1JF4aQFYJ0wOUhPkd6
	LmiDk
X-Gm-Gg: AfdE7ckJe70NOvMSoUcPl1vqqxRvAz961RU2+AUbYpqGSoH6VsZEVjphT7Ni+k3LvlT
	B29wNvn5Gl0hwdI8zL5FpJxfpvAHfcJCVkNegduE9WsJ1X2dFy7gyeaJnpmpT/RFSPpcHFBr2XI
	8A9uHfOnGymVguNFjqIAGIYEylS6v6Nu8v6V6b7jzKgcEmPwIyysgxZtVQttaVH/ri1jJZh+USs
	nSVv9wBb/e1FvdRNE1qCt9XHv+KfI+U9G/8LeCTDHTnHrtv8CYeN92wMk/PS+CcshPVNSRiKER8
	ejhHXkr3btDCZUXEItUwo9Uc8psTceorSNQeUSuzPAWCQut0Vg+XFQX2oqFT0Oyc7MglXNS7jRu
	beiVgBOEvhF0YQ/hPnHXjeFLWEUGdYTQUv2qbQZcfs62fpYyDRdGCnfnj31u1YcIZjLHKqyuOoB
	vBku/vevjioXT7nuobgze6OMG8v8t0lCLb6iLc/vFtJA==
X-Received: by 2002:a17:907:6d11:b0:c15:dcc6:d06d with SMTP id a640c23a62f3a-c16b434f631mr36062266b.0.1784263245861;
        Thu, 16 Jul 2026 21:40:45 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3473ba1dsm3376145ad.65.2026.07.16.21.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:44 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 5/6] selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
Date: Fri, 17 Jul 2026 12:40:04 +0800
Message-ID: <20260717044009.120224-6-shung-hsi.yu@suse.com>
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

commit ed2eecdc0c6613353bc1565e900d2b23237713da upstream.

Extend the verifier_linked_scalars BPF selftest with a rX += rX test
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
  #612     verifier_linked_scalars:OK
  Summary: 1/21 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: missing context from commit 223ffb6a3d05 ("selftests/bpf: add
reproducer for spurious precision propagation through calls").]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 87930b5e7b78..8741238b2ebd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -471,4 +471,61 @@ void alu32_negative_offset(void)
 	__sink(path[0]);
 }
 
+/*
+ * Test that r += r (self-add, src_reg == dst_reg) clears the scalar ID
+ * so that sync_linked_regs() does not propagate an incorrect delta.
+ */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_self_add_clears_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 unknown, id A */		\
+	r7 = r6;		/* r7 linked to r6, id A */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;		/* r8 unknown, id B */		\
+	r9 = r8;		/* r9 linked to r8, id B */	\
+	if r7 != 1 goto l_exit_%=;				\
+	/* r7 == 1; sync propagates: r6 = 1 (known, id A) */	\
+	r6 += r6;		/* r6 = 2; should clear id */	\
+	if r7 == r9 goto l_exit_%=;				\
+	/* Bug: r6 synced to r7(1)+delta(2)=3; Fix: r6 = 2 */	\
+	if r6 == 3 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same as above but with alu32 such that w6 += w6 also clears id. */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_self_add_alu32_clears_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;						\
+	w7 = w6;						\
+	call %[bpf_get_prandom_u32];				\
+	w8 = w0;						\
+	w9 = w8;						\
+	if w7 != 1 goto l_exit_%=;				\
+	w6 += w6;						\
+	if w7 == w9 goto l_exit_%=;				\
+	if w6 == 3 goto l_exit_%=;				\
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


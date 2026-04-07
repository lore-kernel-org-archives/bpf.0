Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB022346AC5
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589868; cv=none; b=jq5dC3u+9hekqhB+gT0hxHBRAEe2hkfddLcg4j+oSJzd4msXqNSnLK/GgFBCiziwMe8sc7pj1RyadKd1geUjfBYOp7Y08/I3Qmc+D3ENHy1EkKoiT4YvX6vakFlPbR+6y64VV8M42wrh0FCxD8K98EkBc9oJkPkjpQNHII7Z+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589868; c=relaxed/simple;
	bh=m67BWom2zFcdE60qlBIh6yTWls/SLfQZWOaQiLL3WsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh3dqcc6QAXAdFacMN3hzu07qaY3pebmBY+Iowo10ob5g+x/SBFVGlHIXnrjetao9zI9vlj5pC9fvnF5h4e85fDMo5m/kvndMwT/j6/wxkSF9ykXwROopteUllUiit2BERLLIEpM8adsuUEm+8/oSLkl6wRx/Y/XBxR8j4geBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OQVtA/Ju; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OQVtA/Ju"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CRmVbCvuCh4VdYFlWfYGanyv1jifYY2YFUafLUApvWY=; b=OQVtA/JubSDhdH2VL7X7gE6vzk
	2pHrI2U83yb0oXForoLIzTs5CqU7r2UI+H/dppVxNefquIy6tTYcDqtciss8VoLJ6qORfZvIgBNwr
	qandPGeYmj5l8p5jR1yBPvhgPBjcgno+kfO/cXxw/e+clkG0TO28syco8EZAKCYk9AjHOb1RD5Qoa
	KtiTxIJKEP6n2/yj82LGG5pcETh2WvLW38dULemLOLUtp+IzMn6L/igrBXx7t5wQw66T1BetvNP/y
	TEo+oxoTaxCTiVpZqV3HvCvyTYn65+cVjvcDK+FW7JU4dXBoqXlEf6R6Aw3ZyrHWgDEwuOjk+lioo
	nnpFLkBA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAC2C-0001vR-2y;
	Tue, 07 Apr 2026 21:24:25 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	info@starlabs.sg
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for stale delta leaking through id reassignment
Date: Tue,  7 Apr 2026 21:24:21 +0200
Message-ID: <20260407192421.508817-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407192421.508817-1-daniel@iogearbox.net>
References: <20260407192421.508817-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)

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
---
 .../bpf/progs/verifier_linked_scalars.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 09146e5db061..60a6f246e2d1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -592,4 +592,59 @@ l_exit_%=:							\
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
2.43.0


Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92033E35B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589869; cv=none; b=tZ0wmGWMI7wPhDW4zmWAXnuQuRq07Pb2Drxt8Hlfa1it8Ln69SF2+tWbizUK0mCWfhmCL7/o1uScbZSDOmre1RGXvhVHFLf6fqt+qZdatF5g+ch+Sx4YtWmo+5kSF3Mzu+YlPZFVeadP2ucWwwJqqD7CyGm0IdUbyB3ePHP96g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589869; c=relaxed/simple;
	bh=RzKxHOfUtGotl7UkcUG3EbSLYhMAghsBnL6RdX/zcbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzrG+EV80Lod4PANR/M3Y42n3kJl342LOqLZv5db+cCynW0yPzv8oi7JF5G6GixD4QC6ECwVFX9VP417Avt4uAiUf0gTHWlTxaj0b3++p5hm1qmMJc8nM9xJUTR5N3qqYuHLqEnXf1g9JnqbE4PskwEGsZCw1kIaIJHaeYc+L2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KXhrbXXC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KXhrbXXC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jBwru21t4qYjA/atO52ZALhYrOxA/FCclj71Sst2S4o=; b=KXhrbXXCnb966ukq8h6daL0pIW
	o8MXxb+pF67/eQB5wHhJrZFhZ733BezcTc43QRdGJBFxIA5oSaxucMQHKt0UXGzuQJMKT30KhX4o0
	YKwA4hN1DY3UBL9oVlWSxBjmYQq7nwXq611P99HuEbPA5jRv5Td4u//3BuXN4LxT+00kx91rRBft8
	pY0jr/CDF0RrWeB2Qr9SRoUt7qna4prwVdIvoAczwtFpquSIZ0vAPn86Clu72ClKOls2hHTe4U3kP
	TVDZd0G6RDN8wbFwiPw+8JpOIp/jSzVsiP4dNmxBzkv7xBddyL8n7DaYaMNw6rw9ZuxUb5IjMUrjB
	JIlAnnsg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAC2C-0001vB-1C;
	Tue, 07 Apr 2026 21:24:24 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	info@starlabs.sg
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
Date: Tue,  7 Apr 2026 21:24:20 +0200
Message-ID: <20260407192421.508817-3-daniel@iogearbox.net>
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
---
 .../bpf/progs/verifier_linked_scalars.c       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index f4f8a055af8a..09146e5db061 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -535,4 +535,61 @@ int spurious_precision_marks(void *ctx)
 	return 0;
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
2.43.0


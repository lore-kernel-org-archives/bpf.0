Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FB4C6521
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=WnUJj9/LF3lLWWB0//xsrk28nXT2+LAT4kUTAYYllG0s9h80VZJV8XHBeejj5LGotiVABoGLcA121OoJXj5edncrDHjR7KK/2IzVUP9ndPG3F5ChfSOLwv9IClE4k2N3eP/d6lG6NAY+VEDrl1o14HzibT4nwhe+CsJJ/Tmy4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=c23vTFdmjzWlb9I6T1hHP1AronQGKFMW8L39YD6kjbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSUemacsUeB3NIKrPk1h0BfqDn0ps0XvuiN5mYtm9Nncm8PA/8PSFy2vj5z2SaQV5YPCivDRMEWpLeu2iMc9qKB8GGjZrWRFDNGrvjvWdTab5h4ILsiqY8TzmE0YnCmXp2QHGppkBEjdiGaap+lrBgZFBpkbcG1lP3QX9+q3Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OmKYT2iG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OmKYT2iG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hassxcxnh9zIPm9vWxkDxlj8zxR7B6Nd1REt/P4oIaY=; b=OmKYT2iGRYudMgv7BdLDGyuaEK
	xHkWRihEBHV6P0pUSmsF5xxM7BrCRcIanju4RjHBorINjmBlQ0V8OFR18vMCukvptkPcgPRMD68GK
	s1UpjrkwETDRLe0JyHbIhF42K9nWxR9NNRKRvcSnWZ4KbOaR9bPQrncWvdkmMPZRgn/bctPfWBbSi
	ZcgySqOl16j7aA9f/KvoJwYoeW1b3VQywQTVvlMISutvAkvNBsksONd5mM+KwWbLC/DStoBddZs54
	vcP3RVOco28FeO/WN3dytrFe3v2eo988rSZlI1z3Wlb0Tf0KIJHlEJO5cD7ltrybvqsDaxJfCYYmp
	haUHq9RA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6P-000Jl3-03;
	Fri, 25 Sep 2026 19:52:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 12/16] selftests/bpf: Add a test for a tail call in a subprogram without an exit
Date: Fri, 25 Sep 2026 19:52:39 +0200
Message-ID: <20260925175244.1136329-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Add a test with a subprogram which leaves through a tail call or a
bpf_throw() and never reaches an exit insn, so that the hidden edge of
the tail call has no exit to point at. The subprogram accesses its stack,
so that the liveness pass walks it.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_cfg
  [...]
  #624/21  verifier_cfg/tail call in a subprogram without an exit:OK
  #624     verifier_cfg:OK
  Summary: 1/21 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 3c3bb03e8217..07388a922e5b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -173,4 +173,42 @@ l1_%=:	exit;						\
 "	::: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_array SEC(".maps");
+
+extern void bpf_throw(__u64 cookie) __ksym;
+
+/*
+ * The subprogram leaves through the tail call or the exception and never
+ * reaches an exit insn, so the hidden edge of the tail call has no exit to
+ * point at. The stack access makes the liveness pass walk the subprogram,
+ * and the loop compiles to a single jump back onto itself.
+ */
+__noinline __used
+static int tail_call_or_throw_subprog(void *ctx)
+{
+	volatile __u32 idx = 0;
+
+	bpf_tail_call(ctx, &map_array, idx);
+	bpf_throw(0);
+	for (;;) {}
+}
+
+SEC("tc")
+__description("tail call in a subprogram without an exit")
+__arch_x86_64
+__arch_arm64
+__success
+__naked void tail_call_in_subprog_without_exit(void)
+{
+	asm volatile ("					\
+	call tail_call_or_throw_subprog;		\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9026056C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790422721; cv=none; b=ibbp67N7I02cSDnXBFfsFdxHRy3QvCywUQmC6cki2H6Rew9rRpQm1ccMUpOH52ZilwJ8uthHiWcHemndcDkn1+rDYzlvdyYl6t6qjRmlWrqcAQTCe1KWdfMGRVNChkMgww8cTROlg2sXk52eV9yVufetD0SODvNkQKZVxdERPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790422721; c=relaxed/simple;
	bh=C/hE5r4KBcm+2N/xbdp0HluCcV5kagncek7SqfGHU1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGUoU/KrV5fxJJaYCYX7P0Dh2KxccyNT74dCsI6g3M7iR1KhbktIAE1DgnZAi9XNzqyGRK+FZsbpvXc0FbqcmEhFrz2qW0CEKBUvBBbfjWu7ZjH/57DBhzuakQIQpGIJ3mXuwyGHUi82/nQzM9r+kJkLHlPsR1x0wuuoVnL9O5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BtnTLA0T; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BtnTLA0T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=eDoWzsXYzDG3n7D/n/CSB/VHLlJCzMa12GtOcCkhr+4=; b=BtnTLA0TEBV6foWIPUmr6TZpXD
	rTlP6kZoYmkf1guahhMLtNeTPg9iTYqMDVkzva0rwJlDhGQN6HtpNL1ajjJB749wECi3Yp15uI8JA
	ZmMpcohQ6LWRKB9Wx+YxDr2v8gMubjjg8F+dBDujqUv0YacvvwP1i0IrKYahl/lXNfP8rqp7mvGfL
	HlJHlEll3N/gwapa7fUZdHywuxyyvW9pen+4coRyqt0PizmwglWIyYfUQfGvkBYuufCPOxYMwI3Qi
	Nz0cyuuO+jqT0E6Z0ylW706H32ox8t35QtSS4vNsooRVk/mOGwn7Q9XfAtKbLkeetevXG5wZQbJjU
	k5QL9DaA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAQjk-000IkB-1M;
	Sat, 26 Sep 2026 13:38:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix gcc -Wreturn-type error in the tail call subprog test
Date: Sat, 26 Sep 2026 13:38:35 +0200
Message-ID: <20260926113835.1193471-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28135/Sat Sep 26 08:24:13 2026)

gcc's C front end warns for a static function returning non-void that has
no return statement at all, regardless of the for (;;) {} it ends in, and
BPF CI builds test_progs-bpf_gcc with -Werror:

  progs/verifier_cfg.c: In function 'tail_call_or_throw_subprog':
  error: no return statement in function returning non-void [-Werror=return-type]

Add an unreachable return after the loop.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_cfg
  [...]
  #626/21  verifier_cfg/tail call in a subprogram without an exit:OK
  #626     verifier_cfg:OK
  Summary: 1/21 PASSED, 0 SKIPPED, 0/0 FAILED

Fixes: 5add2c64f474 ("selftests/bpf: Add a test for a tail call in a subprogram without an exit")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 07388a922e5b..6379dfc9389b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -196,6 +196,7 @@ static int tail_call_or_throw_subprog(void *ctx)
 	bpf_tail_call(ctx, &map_array, idx);
 	bpf_throw(0);
 	for (;;) {}
+	return 0;
 }
 
 SEC("tc")
-- 
2.43.0


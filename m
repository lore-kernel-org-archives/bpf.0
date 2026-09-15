Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542E3DA7DC
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484876; cv=none; b=RGEncYaIkmo9gm9zSWAVYCr3HPas9ho23bSuP+cBGBz85FzCaUEMAtMfKaMrmriLhLpo2tbye4BXDBBt2+l/5W37TK9ipETah74jqcMnEQGPHseMUIo1VtGU2zon8JETVAd5MAxGXEfdBv09IZoarfIySa6mtXphQMbWep+Gha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484876; c=relaxed/simple;
	bh=PD6wzFrkJPlPmuzDXY3YDwyE6YcvlteI+EvOx7WErwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0dLdzpHbBH+gfwxRgaO2jnycPcrt1hDoZgXMnf/iK/XwQZfWDuwDs0tiqKNJT9rLbAuUNeH2mEk97VerP1jv/1SLZFltxsUaw+QzTQL1pqHeMkS4msuAHXVqOIgFVwYWpDHgRh9QkbE/bfdYkchr4Z84bI4kOH+a8tqjnIPZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D9HE03Zn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D9HE03Zn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7LFyJ/VYu+JLE1P6ti3/+CPWpHdA+V8Tbt5cSgi+U6Q=; b=D9HE03ZniTdTbgFDO09OuTf/iJ
	E3lIWiSav464bJTbebjF44j5wfMpn0t9SDRrg5dv9XQrnSpw2mKgona1WiaP8C1U3tSM2QmTi29GF
	ljq6qOZ/Zl8zWlRqt01kh8676SsEpIl72wZ6EBf3xwyQiOXY+8gi3qacnggz9oom/yCmj8mcjsRsq
	XUgqBOrmbN2qrtYNGljxr2gcnuLAnXnm1UAFj/hLSN/L4FoMNPErvsZ50S33me21mE3IcId8j3JyV
	c260JQRagkXKFiFbpXLf2mJj9uAEnLLZbJ1oB/HNNMKnFEIZKo9Oda7kKjzBPX9v/xk5Xw3jo9N7k
	Quu6Uu/g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul7-0007Kt-2k;
	Tue, 15 Sep 2026 17:07:45 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 6/8] selftests/bpf: Test that the BPF LSM context is read-only
Date: Tue, 15 Sep 2026 17:07:37 +0200
Message-ID: <20260915150739.284189-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

Add a new BPF selftest asserting that a store into the context of
an LSM program must be rejected.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -a verifier_lsm
  [...]
  #648/1   verifier_lsm/lsm bpf prog with -4095~0 retval. test 1:OK
  #648/2   verifier_lsm/lsm bpf prog with -4095~0 retval. test 2:OK
  #648/3   verifier_lsm/lsm bpf prog with -4095~0 retval. test 4:OK
  #648/4   verifier_lsm/lsm bpf prog with -4095~0 retval. test 5:OK
  #648/5   verifier_lsm/lsm bpf prog with -4095~0 retval. test 6:OK
  #648/6   verifier_lsm/lsm retval load must reset stale register bounds:OK
  #648/7   verifier_lsm/lsm ctx is read-only:OK
  #648/8   verifier_lsm/lsm bpf prog with bool retval. test 1:OK
  #648/9   verifier_lsm/lsm bpf prog with bool retval. test 2:OK
  #648/10  verifier_lsm/lsm bpf prog with bool retval. test 3:OK
  #648/11  verifier_lsm/lsm bpf prog with bool retval. test 4:OK
  #648/12  verifier_lsm/lsm bpf prog with void retval. test 1:OK
  #648/13  verifier_lsm/lsm bpf prog with void retval. test 2:OK
  #648/14  verifier_lsm/lsm disabled hook: getprocattr:OK
  #648/15  verifier_lsm/lsm disabled hook: setprocattr:OK
  #648/16  verifier_lsm/lsm disabled hook: ismaclabel:OK
  #648/17  verifier_lsm/not null checking nullable pointer in bpf_lsm_mmap_file:OK
  #648/18  verifier_lsm/null checking nullable pointer in bpf_lsm_mmap_file:OK
  #648/19  verifier_lsm/sleepable lsm_cgroup program is rejected:OK
  #648     verifier_lsm:OK
  Summary: 1/19 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index c724bf389f5c..8fbf7862265f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -212,4 +212,17 @@ __naked int retval_load_resets_bounds(void *ctx)
 	::: __clobber_all);
 }
 
+SEC("lsm/file_mprotect")
+__description("lsm ctx is read-only")
+__failure __msg("invalid bpf_context access")
+__naked int reject_ctx_write(void *ctx)
+{
+	asm volatile (
+	"r6 = 0;"
+	"*(u64 *)(r1 + 0) = r6;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


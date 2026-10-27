Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125504;
	b=CYwzxm8fnK4wzLDJOVraHV2msvsh5fZ5ltCrOmpkzuI7GvffRcPFlSOUkgODArIVgk1Y
	 Mca9961mQVmFlfi4kiKUyoGAmIAR/PtSXPxd3IIQqRlKCtxBcDXapDPNYim9pokSexocz
	 q1o2P70M48FgNdR/q2znCBKp5l1JUeabFd+x0xSCgA8tT27GoGl3FUmI8z48R73WGDArg
	 Rxwbv3jhK6prPyrUFhPigMxbnbj5MiCaWwuVfZpRbEhxXqDwJJHoEByuMaApRu3iKW9HH
	 F3806dFGjf42hyEZAvf3zD1M4JJYhsA4UR2k9yXAqNDzlG9OJyFwxLNXhqG34bFOrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125504;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=JXJPfNTV9ibi6r/Wf8ElMW+NdKwSfRPHuQme4W3ipjk=;
	b=a9VuVoS5ZCOr506yjUyZpyoALvDtAZNlwLGwYTsLn3TzbgNBDpxtyCVi1qbR8GgEW6QO
	 nx/pJLdIENBtScppCtfWwtOzLA75OWvVCPmpt4/vG58p9ChwVq67nzDIHxqvoitGsyhAW
	 zkXf9DaXZEHRv9S7heRxW7ToHR9Q6NV7F8uxTIqLzoEmQ8syUAG0slyoBkzAnYS4KOHRZ
	 p++Ac/hGiV+6cEWdZLpAMBABjH3SusyB5tMMrGqeduorsy4GcSU68p3Yluk2p9E093y0/
	 uuUQ6kWqQVBduaPWt9tz4heewaZDFgocH2mFKQcsRLzkYSklGRgULLRFCdvpIw7AKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dqMbT225;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938C606A33C
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8938C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dqMbT225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JXJPfNTV9ibi6r/Wf8ElMW+NdKwSfRPHuQme4W3ipjk=; b=dqMbT225YmJauhyWy4MycB6MpL
	jl/aMxTsT+Rc1S6nhfdyfqOsP8cPTP1RfvHxvcm1AOoss8A6fIWXZpNd913CJB2bQWX4PsXmoWa2X
	chJ5Vx+yHOVl8XmC4lkJYCJ9eSmQlBG8kBSberpurHY+2pYY+3vRQgwUL4GFuWao3Qh13fzvn9PXp
	o5YSbyY/Cg+OF1qAnhzKZbyT/ch2Qeo0hkKiyu3xVmDM0pFFro8HjoFvyVMbzyWb3O9JU4vJZcjwR
	Jn9EARPHpURx6pjgYrVivwCOusMGVIYG2r8hT6hUhibchNl3mFGOrFK5S4YP0/EpDnAXzhy0WaOgY
	VLW9t7Cw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqz-000InH-0W;
	Tue, 27 Oct 2026 19:24:57 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 20/21] selftests/bpf: Let the arm64 private stack check skip the BTI pad
Date: Tue, 27 Oct 2026 19:24:44 +0100
Message-ID: <20261027182445.1156335-21-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

With CONFIG_ARM64_BTI_KERNEL, the default for kernels built with clang
before 21, the JIT emits the BTI J landing pad for tail calls into a
main program between the tail call counter setup and the push of the
callee-saved registers. The arm64 expectations of the Private stack,
exception in main prog test want the push right after the counter setup
and fail on such a kernel:

  WRONG LINE SUBSTR: '	stp	x19, x20, [sp, #-0x10]!'
  expecting match at line 9, actual match is at line 10

Let the expectation skip lines between the two, as the tests of the
same file do elsewhere.

Fixes: e9f545d0d336 ("selftests/bpf: Enable private stack tests for arm64")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..8fe300e52760 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -212,6 +212,7 @@ __jited("	stp	x29, x30, [sp, #-0x10]!")
 __jited("	mov	x29, sp")
 __jited("	stp	xzr, x26, [sp, #-0x10]!")
 __jited("	mov	x26, sp")
+__jited("...")
 __jited("	stp	x19, x20, [sp, #-0x10]!")
 __jited("	stp	x21, x22, [sp, #-0x10]!")
 __jited("	stp	x23, x24, [sp, #-0x10]!")
-- 
2.43.0


Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1A2AD11
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938641; cv=none; b=ZFnRy4devS5iH53A/RpQLMundCBMOwh2oCPrJzwICiga+ic7nbEfEk1P1izEQtIx22U0erX7shEh5YYgMqqALLj167YeRMGQubEnTwOc+k47QfE+p+yx66boNRhOjYW13n/WnijVi9XwE4+xwgC5iA2BUq6NJ6QUFd57QxApP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938641; c=relaxed/simple;
	bh=lFP2p6otLLbphQKtKLMfBWvZcRABG+B29pBlEuCUoFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gml1MC/w3q85SRer/KTKo2v99D2zThCd81FghcpewN4Y4RbElE2MacnVaoC0h/UPHFdy2RYU4NmgXZKzw7PROcaJaf+cOTkhUVvf5UD/VMY8EPwRSGGALRY2V3dInUr+A3AtVDALxylAayn9dKGbfhYV4zWoYkilyVsC4DKf1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HvJ7F6v7; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HvJ7F6v7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757938635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S27mFbMelSc0dJ4MyDaNGcHANXNdM/VQm4BYDwsb0+4=;
	b=HvJ7F6v781lmq/7E3NFwD+lPAHST6oDIPCRLoRVfdskVDUbJ17qFfNkzj57Ub1rBcOxzk/
	gKCXHKrSOXb8MESeiBg/0yvwr8kwtkXU1dOhX9LDcC9cTIL7g6EQMJDtDt9siv51nUte7/
	0Xh8ElKe0ZrumTuxoINrFTAAL7vWs2E=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	yepeilin@google.com,
	joshdon@google.com,
	brho@google.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Skip timer_interrupt case when bpf_timer is not supported
Date: Mon, 15 Sep 2025 20:16:57 +0800
Message-ID: <20250915121657.28084-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Like commit fbdd61c94bcb ("selftests/bpf: Skip timer cases when bpf_timer is not supported"),
'timer_interrupt' test case should be skipped if verifier rejects
bpf_timer with returning -EOPNOTSUPP.

cd tools/testing/selftests/bpf
./test_progs -t timer
461     timer_interrupt:SKIP
Summary: 6/0 PASSED, 7 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 86425939527c8..34f9ccce26029 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -108,6 +108,10 @@ void test_timer_interrupt(void)
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 
 	skel = timer_interrupt__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_interrupt__open_and_load"))
 		return;
 
-- 
2.50.1


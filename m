Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=UD0ZTQISiMjE9Q0mYCl9qkyB2b8Wz56d/7EiuDk0WNSYvlndoBb0W1o2hCpGoIlm00IV
	 uh4MBPV8wXHqcO4oPDP0LjnHjW094JM46XE+/18klvXH6WlSM29nCSU92DC+aEXP1LnY1
	 WVReDF7eNVgedZs9pwWFpR3CghRMHfYi3vNHD4Rqerh0qrX7hB//X5eDVJTHkSxlp16wm
	 oaOAEHPmC57SifsP8AMVne8M3mfeCc0eY5rMrJvNzO0wCVk9QJY/7ZZ69Er+JnDFIzixv
	 KxngqLV+/VC5DXRmXKaRzegzvhATaXuvHGfIud95sMD9hsONyemzEeg9QE+x00jm90Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=JXJPfNTV9ibi6r/Wf8ElMW+NdKwSfRPHuQme4W3ipjk=;
	b=qPxMhZJ6lxK9cO1TjBwurYJghZsCf7vvcTngvGJJlcNAMYfzTcAPS/LCCxDiH6Q5FmVj
	 642NmNs6+IBN9HIi63TR7nG7XxCw3XWhG2seF9b/WXsIDrSRLa9cHQFT2set4u1rXzSjy
	 9wEGd4HJr82cEoxoQludRopdBZm2GAbjiRbPlB/634+16eMUdQ82jxmVWY5bP/+bkWGUp
	 XbzteqcpcapNFTs77CQgHrV4UgznivDc7ZN697mZ85YA9ICFyhpueZ0DA4cgB8QROg5W+
	 H8RGfj6EFGsQkVfdM5bREb8FvJRa2JUpqr+lAvWOYypqY9IMDfpuV02xMtBpC0VZUvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=ll8yWNll;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1EB606D806
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1EB606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=ll8yWNll
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JXJPfNTV9ibi6r/Wf8ElMW+NdKwSfRPHuQme4W3ipjk=; b=ll8yWNll+KnVSqUX7SB4d3bIob
	yJENK9nd/jdkqdutLu7ynf+GmHsFW0ESkMVRwMuvGdHRCqoZYt2bLroDMjsDJppeA8nDrkmI+L8n5
	p9dl2idu27ylel1SnHfAURp5k9dpBh4TTHpFa/bYpR4pWWLqIgWnVJDnBqw6Mx16psTobOmJCi1NI
	zLBUe0FvN8P1G+jWoqP28h0HBj6XozL3CUpUPHv9+dIOAoo1VycqGYAO8ZJUab4YuxWYmZtomL/tA
	fFA6jJaiVbw9LIfcqBrt4YjlPkBbar5A4OLNMR1GhEgIL4IbYm9p8ozcXLks/fxqOE0qKhM6xG352
	oroKidHQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc9-000MSf-0n;
	Tue, 03 Nov 2026 13:27:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 19/20] selftests/bpf: Let the arm64 private stack check skip the BTI pad
Date: Tue,  3 Nov 2026 13:27:32 +0100
Message-ID: <20261103122733.1383002-20-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

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


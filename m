Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166122;
	b=Uy7t4MSvFkkaDBgb6iH9J2vCBaer05KaDuv0HSTOW42Mj2ePLqss5uVD2hoe7O9lV3Ix
	 b/f1XX2ruB7vrzhnmdK9XqSy+gm2zV9BGKVxMR7l/ocMySiE5Q63MPvSFFDtdUVE+qquo
	 fqrZxrxd80GufwVO5Bm9qY26yI4fQia1lS4ZdG2qFdNHA0IHZ8dh8mtjo3N8f5LKpZ/Wb
	 3al3lGTYfQHlXBz1F8dIlFqdb4ktzqnPzeYSCMRwU3r0M4UYl4QBm04ClelqVLVAFQT7+
	 YHBgrl4eM0d2U8Adk3UYUTvAdCyArT5HbRNJxXFxkptxVJxKxV02YopUAbxPDo7di6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166122;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=pKuIrxYzDrzlaMToT+ni90AhRJMijXhqousZQbuoFyE=;
	b=XraAP/VCcfU0o9SNpoladHpzL0NC0EBiWKOm7H/XD85oHKpRHY7P6I8TX990TPDr1dEM
	 nvrIo7bs7EaEGPOtdksd3zbA3rgx6mhH/wn23aVZbaJvfn7jb1ymd/BNNgNGR5ERXzTKc
	 bYTursYevt1Gkb8cr2c6oQQpeV23VBBMtqP5ayc3oBxhHvxx0a0BIZ6mBhHPXyV+gATXP
	 q4fzpOA2ekFdSnpZAiwFUm5dnbAYYEXrkT5T3TLrtnej8uj7Kh7dhN9GFUNo5Zf2Dp9zm
	 9K691wL/0RSVlbKTrcjpVFlHPCAsAHDmactCGHo+dA51aZD2uq3fNl26K1cvCjSlAbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nO5RWrOn;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9827606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9827606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nO5RWrOn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pKuIrxYzDrzlaMToT+ni90AhRJMijXhqousZQbuoFyE=; b=nO5RWrOnmHUlkM1S526gRg0W0g
	/2IiENl8wxztcYiRgCdl4TGBNkHXvzJtk9kw1eb0OToQj1Qeqche3KsN65WD2xOtU4LVmNhexVRv3
	K1swTAGQAbuygTz7IuL6tw+MEq/vDVvKdwyqTkkBxPNre4h4/2iXgZ5/iJxuQAZXfWs0rq0xwtl5T
	EisW0hTqfYM9E0ms+/aW64YwALS5eJd6Ns0uev9W6Y0WkKFB4bGUsyfXxyufhOFJN5zlsrTWTbhUk
	aLqPFCvPzM6OEGWWADKUC6GmEuEv3D1IhMjh/vfWIE2zY0CQ99MZNSnVInukMGYuAsCdTElJeicGm
	kjhYu8iQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8ZD-000Pu4-2W;
	Sun, 08 Nov 2026 20:28:40 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 22/24] selftests/bpf: Let the arm64 private stack check skip the BTI pad
Date: Sun,  8 Nov 2026 20:26:48 +0100
Message-ID: <2df53a485118780853c7fc01d475590e46241073.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

With CONFIG_ARM64_BTI_KERNEL, which is the default with clang before
21, the JIT emits a BTI J landing pad between the tail call counter
setup and the push of the callee-saved registers. The arm64
expectations of the "Private stack, exception in main prog" test want
the push right after the setup, so the test fails:

  WRONG LINE SUBSTR: '	stp	x19, x20, [sp, #-0x10]!'
  expecting match at line 9, actual match is at line 10

Let the expectation skip lines between the two, as other tests in the
same file already do.

Fixes: e9f545d0d336 ("selftests/bpf: Enable private stack tests for arm64")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 0ce07bf6b566..e7f410a74a21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -286,6 +286,7 @@ __jited("	stp	x29, x30, [sp, #-0x10]!")
 __jited("	mov	x29, sp")
 __jited("	stp	xzr, x26, [sp, #-0x10]!")
 __jited("	mov	x26, sp")
+__jited("...")
 __jited("	stp	x19, x20, [sp, #-0x10]!")
 __jited("	stp	x21, x22, [sp, #-0x10]!")
 __jited("	stp	x23, x24, [sp, #-0x10]!")
-- 
2.43.0


Received: from out-2uec-a118.jellyfish.systems (out-2uec-a118.jellyfish.systems [63.250.43.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B331EB9
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709050; cv=none; b=puAzHppa6DW5+LGAeOa/YYi1DFXYpa7clsXgus2b31ihd7fT4HpDKBRExyv+GxMfenBr2eJTRWbYckiIJbDOVa/w8EXU0EmRVUP2JZxdqr9PMmaJi0qu/7ku/1OuKFp6FNJwjpoESLXfVNsQQZZmnc6+XQS01KwjKYAknYOoNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709050; c=relaxed/simple;
	bh=12WX0AutlUFDz09zKJhYYpVdDjn4RKLkAkzWNdJnVFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmMx6Wt5me+rjjaR3ND34v+IAjfbDDUdI0idL3FTM+nsDhCUPLtgU4nm78ui9qrPXJHjO0dXg5YJobbiAi+2K0OGi/ScGSlIwJxK4KHuoEpS2YvGy7/HIZdvd6popWdBtCCkE92nIqBPBMUsJm14zVl2IfIPR0nK47Z3UadOQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=M6J2NxKe; arc=none smtp.client-ip=63.250.43.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="M6J2NxKe"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdDpq2w7qz2xB4;
	Sun, 06 Sep 2026 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788709044;
	bh=12WX0AutlUFDz09zKJhYYpVdDjn4RKLkAkzWNdJnVFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6J2NxKevUZqYo8PWse1bFX+Zg47zhoUa0HweZlOGRahU071npxsMlhyJ3vV2sQwR
	 +pVDNnFZWVwQvSmhva7bpyts4eqBhIre2t2YaBQz4EpaLX0QV/epGhVpcCZuOlyOqD
	 +a69bKFduGBw0STiTgKgazAw4WsUKrHajZ8ll/EE85pbetxIQVVOQU4DVJ2TO5fGFX
	 r3J5Mvs+vlKHmnYjlPA7GT3vkXsTor9CFzIHDqYUOc8qptyqtobqGi5Bf8nVau0o3f
	 QHA/1U5wjI+FmNltRxIl1kakEmp+1IKCwQhirDwZdAw0VQam/x/SNR+K53zxZx3YkX
	 fwxLNNgvXlbpQ==
From: Tianyi Chen <hi@tychen.cc>
To: sashiko-reviews@lists.linux.dev
Cc: Tianyi Chen <hi@tychen.cc>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Check returned keys in map batch validators
Date: Sun,  6 Sep 2026 23:37:13 +0800
Message-ID: <178870889323.880246.17961847400188675208.reply-sashiko@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906144524.0DCE91F00A3A@smtp.kernel.org>
References: <20260906143918.848536-1-hi@tychen.cc> <20260906144524.0DCE91F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks for the review.

These files are built into the legacy test_maps runner and include
test_maps.h. Its CHECK() macro reports the failure and exits immediately;
that header does not provide ASSERT_*() helpers.

The ASSERT_*() helpers in test_progs.h belong to a different test runner
and depend on its failure-reporting state. Replacing these checks would
require a separate framework conversion. The range checks must also stop
execution before the following visited-array access.

I have therefore retained CHECK() in v2, consistent with the existing
map_tests code. The revision also covers the LPM trie validator:

https://lore.kernel.org/bpf/178870889323.880246.16480713814270899611.bpf-batch-v2@tychen.cc/

Thanks,
Tianyi

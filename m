Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF73E0240
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582467; cv=none; b=YK3K7us3h8F47Vp8wbby2bG26HyqLb0X6odQ/WPUOx6NtJ/R+nOfzgcz/LO/eI4LLhfaJ6f7Bk9ue5QiBSa8zjPbvKVJubup5JR2hY8BiZY/0D2B4vMknTukYOQU/qX+2/MnD2VMgNNZ6RyMddTRn/AAofw3WM0FMI+caXWx70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582467; c=relaxed/simple;
	bh=fDhnBddHnpHHddch4fTeeA2OWJcktLZE2wp37ZSpM0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krsr9eLSvVeerhAfpe6pLZkOq/aFAELDHp/evxCweLw4vWml59BGjhNDb3a+Cv5ds25awUBuzMk8OKsV0cD6u72WqWiSE85bhfi01xF8TRqvsz17JwnZUpvJVGmR3Dg1R0/YVi8074KDSaFRSegDw4lRZK8K0nxlqSoNnm8Fdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dzeeCJU1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dzeeCJU1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=pv9tYVduDwNDdz8kPCB5/TVWKv4sm6C4JfP5STfPgAM=; b=dzeeCJU1Fq9cqI3On+Lg3Dh0fv
	wH6xJrLUUBjpR/yei4JnASomwrQAbE7x7/XB/zzwTcaPLKKPrSyNsux6YryELnQ1oghm3qYSmH+2A
	l3CRzOTmvWguZRmv+Ywbb1d3M/zQz7RXTcE0XqUVDWwv/6i/I94oSH1iUh9eOoPkrH50Is7jwWvYX
	Zdq4Fub4GJliNsJL5198ozvPWs/hjR5mTudCH56Df56VVGeXsiHJTSFJVHgvf3jpAPrYbqznb8vDh
	7Xb1Zww6XFiTi6XiyhtnFsMgJ0JUwNBkertplyvrcvF6pgnHabPKx//bjfe43d8Aw9WZ+IjGSwOvm
	z05CiTUw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whjH4-000DvH-2S;
	Thu, 09 Jul 2026 09:34:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: paul@paul-moore.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix security_bpf_map_create error handling
Date: Thu,  9 Jul 2026 09:34:22 +0200
Message-ID: <20260709073422.379247-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)

Commit 5816bf4273ed ("lsm,selinux: Add LSM blob support for BPF objects")
made the LSM hook wrappers for BPF object creation clean up the LSM
state internally upon denial, e.g. security_bpf_map_create() internally
calls security_bpf_map_free() when the bpf_map_create hook returns an
error. map_create() however still routes a denial to its free_map_sec
label, which invokes security_bpf_map_free() a second time, so the
bpf_map_free hook fires twice for a single denied map.

In-tree LSMs are unaffected in practice since the blob kfree() inside
security_bpf_map_free() is NULL-safe and idempotent and none of them
implement bpf_map_free, but a BPF LSM program attached to that hook
observes double invocations. Route the denial to free_map instead.

Fixes: 5816bf4273ed ("lsm,selinux: Add LSM blob support for BPF objects")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 358f2b0ce2bd..0ff9e3aa293d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1649,7 +1649,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_at
 
 	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
-		goto free_map_sec;
+		goto free_map;
 
 	err = bpf_map_alloc_id(map);
 	if (err)
-- 
2.43.0


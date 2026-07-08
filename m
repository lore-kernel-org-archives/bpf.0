Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE0246788
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545348; cv=none; b=lLMfMyIlQ0thaageDotkZBlLi5YqLYT3wfCxUAJqEnWsZ9aFLEbJRyRhwfg5skgWx7wziyhb0i37Zh630Jha0wFEkgvatOgo8p2oqWMmxzorVTVDCUkFyiHs+JmFQBDzI6XRttO9k1JeHbpGiR++X45rzfkBc6y6xwUABoZTeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545348; c=relaxed/simple;
	bh=3tQ6/taXNKyqa2F93hKytEXCmkxbP6uoA7zZf7Ug2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVdoA1/evB4oY+qY3ozJKKyzfxwD7s0MmeCpLxs32uhGFTIaxyNczSZvR4qbDws1ryZ3OcqendEabsw2Pdy5Bw1eM6TzOKrm5xLtXgEw6MxG6gdSJcfGdRWiOYhj32wBYG2liWNhiFDaTrkMB32zzvSxmJUos6G1q7Lm3Jpi3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Awvc3RNZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Awvc3RNZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/VWLa4Va5Gk673VdCTAe6h9UonQqyMJxCEQuKptGRZ4=; b=Awvc3RNZMmEDXbPikVbu1M8H8Y
	UM7KinSvUA8QpYAg+YkYUmrGLQSDgiGVjqm5OF5oYOITgTTuIMuH4B40VL9aW6Lqi9PYjx4K7jQZ/
	HhQTld4JCpYu+47eCPhBMPqdQrrA4XVtv4feuSe6zTLk/sU7hlss8GSarOHMLVDDfOBE/F1ZXMGwx
	qB9JOt+VEX8ZTxK00rEVmo/uCbg+uVyk9CPfdVWSDMMaZ1fjrqZJbq/jR08u/eLUETMGvXi51KKCb
	bT7spydtxD6MsOpnp7oHtDuQf2yYQUYKcK/PUeGd18OvqUzX2Dkf0J0iBG9s/ons9FvdWGajzN+mz
	H0AcOc/Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whZcK-000OUi-08;
	Wed, 08 Jul 2026 23:15:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: Account insn_aux_data allocation in bpf_check
Date: Wed,  8 Jul 2026 23:15:36 +0200
Message-ID: <20260708211537.371874-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708211537.371874-1-daniel@iogearbox.net>
References: <20260708211537.371874-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)

The insn_aux_data array is allocated with a plain vzalloc(), while every
other allocation scoped to the verification - verifier states, explored
states, the cfg/scc arrays, liveness masks, jump history - is charged to
the loader's memcg via GFP_KERNEL_ACCOUNT.

At 136 bytes per instruction it is one of the largest verification-time
buffers, in the range of ~130MB for a program at the 1M instruction limit
(worst case), and it lives across the whole verification. The buffer is
also inconsistent with itself: when instruction patching grows it, the
vrealloc() in bpf_patch_insn_data() already passes GFP_KERNEL_ACCOUNT.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40e20dfa3212..ad8ff228c963 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20096,7 +20096,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	len = env->prog->len;
 	env->insn_aux_data =
-		vzalloc(array_size(sizeof(struct bpf_insn_aux_data), len));
+		__vmalloc(array_size(sizeof(struct bpf_insn_aux_data), len),
+			  GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto skip_full_check;
-- 
2.43.0


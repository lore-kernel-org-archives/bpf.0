Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E4376A07
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653639; cv=none; b=TvxmVczgfbgqKZQ+Ss8Ogdg/G7LljQb8/b1sJ1gmpySrZWokYKUwaT+/Y977QA25EogdKIYtyLob4G5PxFsudaesYjzrQ/kblX2uIO7m8q4+azci+qHbr9jf9k5NLlKR/cP/3ER/MfpumLFrs9+bZb5SpToWejZrrRT11cIhhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653639; c=relaxed/simple;
	bh=Lpsr803KAa8M1cost3bsuslOj7sAwixaMjG4vep/tuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozTVn6DwqAuFhSRfQMIsR/wbA84AGlrWe6FGz93UM+hjhZiu8ZYC4GXIyrBecASi9KKZ4dbjfcjABRSMpSwjoMRSmZBs+GZ0NWmqr9loUxtytOyiyHz5PFgMRELfjtVM72QfLTULLPf9glVIRLDVolmG3XMJ/ddlXESLKHlG7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jlwGFMJZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jlwGFMJZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0eqBpcMD1CYHTlBFdOT1uyfEFz6ToYQKvUP5FgThx4I=; b=jlwGFMJZMD09VgBQnTRgge7SS5
	YYqBEoWzOk3GoCQ2gpEJ+YFW2lgTnxxtphIQG1RD8AZSGnbggkzpG6PScC43KFyXCaOam4FFuTKSh
	92l/c+wgTMxMfMpQwlKVkloM2+l7WFKJFpQNRi6WaxpRfcJR5ZH7YG9G0w6nGyaX/sA9fy4QYOD7d
	os7k5/MsHbhBr0BBVPCK8yHruu0LMGgVQ4juTGvS3MxhHnNOmcxiLGi1YVyFSgZPYCHWX0B2FOeit
	EWhAJokz8M3sGOcuBFEsiAjJXF3ur+AAQ3FH1r4WOyBL7WiSdC/qeChpkpAg6vBE340tmNcbX9mK3
	kPGKSXew==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wucE6-0009ug-2W;
	Thu, 13 Aug 2026 22:40:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: Keep untrusted PTR_TO_MEM read-only on RCU invalidation
Date: Thu, 13 Aug 2026 22:40:31 +0200
Message-ID: <20260813204032.644949-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813204032.644949-1-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28091/Thu Aug 13 08:25:54 2026)

invalidate_rcu_protected_refs() turns MEM_RCU pointers into PTR_UNTRUSTED
ones once the RCU read-side critical section ends.

For a PTR_TO_BTF_ID base that is fine, but for a PTR_TO_MEM base the
result has to carry MEM_RDONLY as well, since the rest of the verifier
relies on the two coming as a pair (e.g. bpf_convert_ctx_accesses()).

A writable untrusted PTR_TO_MEM would otherwise end up as a plain load
or store to memory without fault protection. No in-tree kfunc produces
the combination today, thus this is mainly hardening.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ef9418733ca..0c0dd53118d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9054,6 +9054,9 @@ static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 		if (reg->type & MEM_RCU) {
 			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 			reg->type |= PTR_UNTRUSTED;
+			/* An untrusted PTR_TO_MEM has to be MEM_RDONLY. */
+			if (base_type(reg->type) == PTR_TO_MEM)
+				reg->type |= MEM_RDONLY;
 		}
 	}));
 }
-- 
2.43.0


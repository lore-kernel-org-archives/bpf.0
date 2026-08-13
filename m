Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49F42C4F8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653639; cv=none; b=jeueTPuxHTzQFlg6GkxdcTZjr4drnPk4vNVUJA3nCPJcFXeEXXEPxk96wRT6D28GOP8R0isG8YRD6ExxWddzlPDu526XzSUPC+27HnR2Zx2gCaa4dqYqwmcK77hzsRYLskN/aiajpWp7sILnxKRhNTdN0pzVWxONB/F7SoDwQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653639; c=relaxed/simple;
	bh=Vw8f7VjmOs+o/YV6EN0MEFUljGSUbeWb78E7NMdiMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntWZF42CrxSd7cD4d9zU/IixZB06qQWSHyXip+bfTcW6NPQLaxreM4e7A7j8LF1il1FNkF2DtgfjiXh7PBuNDv0qiwwt1MHFtO17mfD6132J0fHTD1LTF5jEJgta732fAUiGzU2lP9ynsknZEsWDmgNXLrEMH8Z9ZhMCh7TBcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oLWShtAp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oLWShtAp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vKINu3AvHpljab3Ehnojq0Q2oN3C7CWvJ1wTPLsPvzs=; b=oLWShtApxH1Yggf/SDPfgBWAba
	HAMAIjIlStVGp6wh/2z0Oa6f1bOOJo28KB9mfwzWhJxGAMFfwPl0o//gOPDzFab47gLV8XSUz5wIF
	fPwBfTUBmBK59iTkCexrERIr7PW8U2td3ufLXOkcS2qzUylfqR4lMsCubE8JpPwGhHR+PRmQb7uzm
	EUm7ocXyevPBrjQ8dxxp9bRninGmVF9qJlupNA2XuEDz/eNgcp5DDYaGLONsWzoOlE40WTRrppDet
	6y2FfOmkuKIAr+AXQ76qBqBy2BXc7IbtL44K2NMMdo4vcCYREYzziAc4pPgAL52JqEj9jG9fOEabP
	dFD1Npjw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wucE6-0009uT-0Y;
	Thu, 13 Aug 2026 22:40:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both are PTR_TO_MEM
Date: Thu, 13 Aug 2026 22:40:30 +0200
Message-ID: <20260813204032.644949-2-daniel@iogearbox.net>
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

save_aux_ptr_type() only reaches the merge when reg_type_mismatch() says
the two types are incompatible, and that in turn requires at least one of
them to have a base type reg_type_mismatch_ok() rejects. PTR_TO_MEM is
not among those, so for two PTR_TO_MEM based types the merge never runs
and the recorded type stays the one of whichever path was verified first.

That is ok as long as all PTR_TO_MEM variants can be dereferenced with
a plain load, which stopped being true with commit f2362a57aeff ("bpf:
allow void* cast using bpf_rdonly_cast()") adding PTR_TO_MEM | MEM_RDONLY
| PTR_UNTRUSTED. If the other path saved e.g. a PTR_TO_MEM | MEM_RINGBUF
first, then bpf_convert_ctx_accesses() does not rewrite the load into a
BPF_PROBE_MEM one, and the untrusted path faults on a plain load.

Fix by merging the two whenever they differ and both are of PTR_TO_MEM or
PTR_TO_BTF_ID base instead of keying it off reg_type_mismatch(), so that
merge_ptr_types() gets to normalize the result in this case as well. The
rejection of genuinely incompatible types is left untouched.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d3b76d7820e..8ef9418733ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17050,6 +17050,17 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 		 * save type to validate intersecting paths
 		 */
 		*prev_type = type;
+	} else if (*prev_type != type && allow_trust_mismatch &&
+		   is_ptr_to_mem_or_btf_id(type) &&
+		   is_ptr_to_mem_or_btf_id(*prev_type)) {
+		/*
+		 * Have to support a use case when one path through the
+		 * program yields a TRUSTED pointer while another is
+		 * UNTRUSTED. Merge them into a type which keeps the
+		 * BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when either
+		 * side needs it.
+		 */
+		*prev_type = merge_ptr_types(type, *prev_type);
 	} else if (reg_type_mismatch(type, *prev_type)) {
 		/* Abuser program is trying to use the same insn
 		 * dst_reg = *(u32*) (src_reg + off)
@@ -17058,21 +17069,8 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 		 * src_reg == stack|map in some other branch.
 		 * Reject it.
 		 */
-		if (allow_trust_mismatch &&
-		    is_ptr_to_mem_or_btf_id(type) &&
-		    is_ptr_to_mem_or_btf_id(*prev_type)) {
-			/*
-			 * Have to support a use case when one path through
-			 * the program yields a TRUSTED pointer while another
-			 * is UNTRUSTED. Merge them into a type which keeps
-			 * the BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when
-			 * either side needs it.
-			 */
-			*prev_type = merge_ptr_types(type, *prev_type);
-		} else {
-			verbose(env, "same insn cannot be used with different pointers\n");
-			return -EINVAL;
-		}
+		verbose(env, "same insn cannot be used with different pointers\n");
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.43.0


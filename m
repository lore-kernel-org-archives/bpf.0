Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82948F84E
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050076; cv=none; b=s0uynj11id4bX7fU2xpN9dST1t7EeXk1dYTXY1zdsvi3b8RYhoQOuFxN/mYKzBA5aQUYH4yh4jrH15g8t7oIb0nfglJv0zTziSHhzSLiST9sA0jo6VTogw+B5hpo7AdKXu3wgm+0494RZ5QPNf9dRmRDi7AeWWlcBIM3WhsWNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050076; c=relaxed/simple;
	bh=PvMtEFMaJl5nGXc4qpNyJ8ZQkhXBuA4i4FDTwTXjgkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRnuRWHLsLE42YzjJ8PpI6Wk3Jkavg+n/Q7M+oDsQVlutEjbMlRDgQ3Tb8KWOy6FEu7wWvhtSnqXWDer4mQmLR8nZWTcfwrcw7yxRNu1mZWPclxBLDxwgCro/s0r2xox/PMdu0yFa9jzFusdQAnYDxwDCWnKj1ZF7rlhbPJiXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H2zSPG4I; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H2zSPG4I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QchnXzdzWnK0f13cJWqvPcXH5w7iSJjz0U5Wv1QS5zQ=; b=H2zSPG4IYhnZDMsxfBtitWGYlU
	o5KwoH229U4PnQYZzgWzhgXyf9L5xwCu+HcNkuIJhAhvFrGo2GejEyS48RVpHFfJv99xbw3XPrSkn
	SO+BPTX1Y4E6eLofb5I+gaOiHVl1KFxxD981c3f5HDQBWWxq/jr7v56GBpjizu/IQXfQ2gM+b9PC9
	m9Im87YKY8n8Iivsl6TfN+icSFms9aarLFW8M/J4WMklu/fJIvZdyvye3qOaFdrYopo+BOamFGMVv
	E5eOxJfgQWH3mbCC3jrKnfXDE6FLuXJgK9tF/fx7bnGrayli9GXH5YjTjtmrtW4dDfrHHKxb2CiCY
	IwPIaNKA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4feH-000Gm2-1z;
	Thu, 10 Sep 2026 16:21:09 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 3/4] bpf: Require CAP_PERFMON for untrusted read-only memory reads
Date: Thu, 10 Sep 2026 16:21:06 +0200
Message-ID: <20260910142107.40582-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910142107.40582-1-daniel@iogearbox.net>
References: <20260910142107.40582-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

Marking bpf_rdonly_cast() KF_PERFMON CAP-limits one producer of PTR_TO_MEM |
MEM_RDONLY | PTR_UNTRUSTED, but not the type itself. A global subprogram
argument tagged __arg_untrusted results in the same register with no kfunc
call.

Fixes: c4aa454c64ae ("bpf: support for void/primitive __arg_untrusted global func params")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d61e74865a8..3f99b20e04fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6453,6 +6453,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			return -EACCES;
 		}
 
+		if (rdonly_untrusted && !env->allow_ptr_leaks) {
+			verbose(env, "%s access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+				reg_type_str(env, reg->type));
+			bpf_diag_policy(
+				env, insn_idx, "read from untrusted read-only memory",
+				"the access requires CAP_PERFMON",
+				"Load the program with CAP_PERFMON, or avoid dereferencing untrusted pointers.");
+			return -EPERM;
+		}
+
 		/*
 		 * Accesses to untrusted PTR_TO_MEM are done through probe
 		 * instructions, hence no need to check bounds in that case.
-- 
2.43.0


Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAB3BE65C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047686; cv=none; b=LijwR6KF7jhlft36xQDzI8c50gjfLmimJc0bx9G+rB1+wHMe9LIrx0FMDgUXLnvMVstudjTZmIpi/BoGAwAg/ck3aUNQwM9kQsIqEwEHedPVN7/rCzYi5WTfpJPocUep8qjY+jR5pXiZalQ+Z6uAlUbkcoiIX/H0ZvKTWVof1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047686; c=relaxed/simple;
	bh=dYiZMuGREOuwutJRNvMw7V199/hazG1JPPCNc9kTwzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slUDi21iSjW+DPHZ3/RF75foQG0imKUAPkr9j2fq8mcChM6ySCi0JvpmFmLjyLvSZxYn/9wHikazNsLzUhv62NYsmR350a/m6ycpjrPQmGQ6Wy4FHDjIFcqWQvhNF+v7gZ3hgJvotBe57/LOupGPtPjFg1jCIe5aI3EXCzi+FA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nKWT7dc6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nKWT7dc6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4MzxppZazcORgS9qzj0W2Up9gfPh56EM67N95ZlyBzA=; b=nKWT7dc6TRH/Jgdb33w/E6JUyQ
	7Kh3Gu8s1G6SzM14mdtYZ43Dyn355OOMZrGbfuQk85TbOvXP5E5AJOj+wxV/K+bqhLwQk9trKbCEN
	LLQh3FT5yZZl62e2msz5YyiP/btH6qZeUjS9eBZiNMNn6IUp7QPKR53zTeiLimGdKFArLqjHnhbjd
	RhpBWG9ZwXLV2nDyV5Slp/GbB+F7x20CLuiu1/uZR0SgR5EVQ/TfIMIjXUqQtsW0JNk4T719FATiI
	gxVXkHCQoXRnSRIxM6pdViXBs0N9Y5BJ0Re9QsRNpfuk/KWyejTt0NBohIVd08Oa/UblEYaXNFgVM
	1rftlNYg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wStiS-000LAN-1p;
	Fri, 29 May 2026 11:41:20 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kpsingh@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko <sashiko@sashiko.dev>
Subject: [PATCH bpf-next 2/3] libbpf: Skip hash computation when loader generation failed
Date: Fri, 29 May 2026 11:41:17 +0200
Message-ID: <20260529094119.307264-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529094119.307264-1-daniel@iogearbox.net>
References: <20260529094119.307264-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

bpf_gen__finish() calls compute_sha_update_offsets() gated only on
the gen_hash option, without first consulting gen->error. On a failed
generation this is buggy: a failed realloc_data_buf() sets gen->data_start
to NULL (leaving gen->data_cur dangling), so compute_sha_update_offsets()
runs libbpf_sha256() over a NULL buffer with a bogus length; a failed
realloc_insn_buf() likewise sets gen->insn_start to NULL and the hash
immediates get patched through that NULL base.

The computed program is discarded in either case, since the following
"if (!gen->error)" block does not publish opts->insns once an error is
set. Thus, skip the hash pass when generation has already failed.

Fixes: ea923080c145 ("libbpf: Embed and verify the metadata hash in the loader")
Reported-by: sashiko <sashiko@sashiko.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b95ced7bcba..3a6e1d53f287 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -397,13 +397,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 			      blob_fd_array_off(gen, i));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
 	emit(gen, BPF_EXIT_INSN());
-	if (OPTS_GET(gen->opts, gen_hash, false))
-		compute_sha_update_offsets(gen);
-
-	pr_debug("gen: finish %s\n", errstr(gen->error));
 	if (!gen->error) {
 		struct gen_loader_opts *opts = gen->opts;
 
+		if (OPTS_GET(opts, gen_hash, false))
+			compute_sha_update_offsets(gen);
+
 		opts->insns = gen->insn_start;
 		opts->insns_sz = gen->insn_cur - gen->insn_start;
 		opts->data = gen->data_start;
@@ -418,6 +417,7 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 				bpf_insn_bswap(insn++);
 		}
 	}
+	pr_debug("gen: finish %s\n", errstr(gen->error));
 	return gen->error;
 }
 
-- 
2.43.0


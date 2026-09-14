Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C3477294
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405412; cv=none; b=URorceSdj9xM7Ov8PaSk3uuD6bwe4b0A7qJYybHcScxc4aD6SKkWxHLOP396s0Mk0X+rTAeniI5Gig4m4gU8gJkOO+KoZaDCBqcqgSxjlfHpo6mAWl1lBoLFyKfp5uBsoOErl88WnrVBBJAJ6FNoQ6VB5N/EGwWDZH5oxNrmhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405412; c=relaxed/simple;
	bh=bb9DD8bLLswkAK822SREmRBhyrgjFwWQcqPxw11YbEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTNr5XYTBoH6bHJUEcCyEmGLXLxKMQ2T6JgaqhYGWo+l0cX5HSDjYljvhpEP8VM8T7UFBVhygAtb9Sno/4hgQ482826v1CQWw+b+rQmMmeRRSqvEjYdJ5V+26BtB+a0opKg9VkTKtpScGxkb1/AvPfpYOBBOjIco6xULtZD42+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=S520CedJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="S520CedJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=svwHmice1A5zvhWoVbW6UYWLQmcSX5eRqlZ80hnHz+c=; b=S520CedJyZkY6VZbf+Rsyt+zKk
	fORkr0+hGZxkI0irbOpu7+KURXUPm3IUwoeCae/AHqwS6ejq/JCqd3df1ozTWAefhefo//fcSVfCx
	z2i4TjTIqUIw/3PtAWNljTLF6wyjnJ9UlqxrtJ7+WNasVqg2pSUc03/5LTitHvAPeevU65NoFUG3H
	otzVM6bE4+YwH1tBVm5Q6n4m13I/Lv2OsHrZ0pnpTkUHHcS8zvZCuy5RqIe8jVRWfsa0bq5Gsvn3K
	x2sf7Qqm+BplM6ZDnUWIHRk78P70zakw7VpbMVf25eoal48JfYtbvHhhrxSz8VOVEkkV1Ipw1Gqao
	MCoLux1A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5Y-000C8P-2B;
	Mon, 14 Sep 2026 19:03:28 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 02/11] bpf: Bound the number of indirect jump edges in a program
Date: Mon, 14 Sep 2026 19:03:17 +0200
Message-ID: <20260914170326.249953-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

Every gotox instruction gets its own copy of the jump table of the subprog
containing it, and each distinct target in that table is a CFG successor
of the instruction. The number of such edges is therefore the number of
gotox instructions times the number of distinct targets, and neither
factor is bounded by anything except the instruction limit.

What is expensive is a BPF prog whose gotox instructions are themselves
the targets, which makes the edge count quadratic. 1024 such gotox are
already ~1e6 edges and about 4s of CPU to load.

Bound the total across the program at BPF_COMPLEXITY_LIMIT_INSNS, aka
the limit as the number of instructions the verifier processes. Progs
with real switch statements are orders of magnitude below this.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/cfg.c             | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..04bb8f71cabe 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -977,6 +977,7 @@ struct bpf_verifier_env {
 		int cur_stack;
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
+		u32 gotox_edges;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 5cfd02c42afd..df4513e71c80 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -9,6 +9,8 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
+#define BPF_MAX_GOTOX_EDGES	BPF_COMPLEXITY_LIMIT_INSNS
+
 /* non-recursive DFS pseudo code
  * 1  procedure DFS-iterative(G,v):
  * 2      label v as discovered
@@ -388,6 +390,18 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 			return PTR_ERR(jt);
 
 		env->insn_aux_data[t].jt = jt;
+
+		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
+				       &env->cfg.gotox_edges) ||
+		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
+			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
+				BPF_MAX_GOTOX_EDGES);
+			bpf_diag_program_structure(env, t, "too many indirect jump edges",
+				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
+				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
+				BPF_MAX_GOTOX_EDGES);
+			return -E2BIG;
+		}
 	}
 
 	mark_prune_point(env, t);
-- 
2.43.0


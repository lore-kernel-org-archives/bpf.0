Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C33C2798
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986457; cv=none; b=R6bVyjFWU0KQ3PNTO7HLvV7GKzj4WFzoFj0Uue4bgxOd5+grxJQVK/ryd2J8NGzMdhIpOxcsAdfWSTzMEieoFu6rrkW/FX5WS8FLCUKsSgQkJa7432vG7aGzxPnVEIemtngc0L1Uf19qXhaHnKyF3YORrReVegRYXrtN3TbtY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986457; c=relaxed/simple;
	bh=VchK+F1eowVVzqONRZYAhi0u/+sT+uo6xmIbLMQF5jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9miSX4eXrESsZwN7zdFm1ixy1s8B5bcXj4v5SxiYd6i52fHjDzrJ0IZYp8bv/4L+TVjtrKYWArBU/3K4SaOc/WfSMC0P0A1qDgtK/a5aQJqWdOGsQWTS9SsN4/y7fXdvLySG8cB3Dj2Fb3XFzlehNm5P2LWJDhnVb04Yn1P7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QRhpABph; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QRhpABph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/X+gwbPogrfm1eVXMenKSp1fjP4ar0u01WQ5HnXlJ0c=; b=QRhpABphTY8HECGuZOqfjpVNvK
	SuPLvG/npF1vLP78Sz3nmz+22lRw6KhLH95p8LIqSEpXXkXsBNSolNeX+bP3SEQUnWS8xP15TkunY
	jeGnXtMepdFLvSBArdh/SPbW1anYIsbsMSUoUXQMrc8ET/KIrFKOXNuF4GbXDKXi3cqQKrbOiunU4
	P7c7ROYHkA4x8AKJWD5Zt7ejpvF2j78uxTJH6K8NIqekX7RTp3JOdy4kFXFt3a3MUEIpwg9N+MvGm
	lXZumUQmVrVtZXcJXIkdqLWuSt3a2gBZFshKkgygKCHAjYkAtmqN3DIWgrB9AOS/hz7K+zn3jScae
	ltZ0rX9w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P5x-000F6x-1s;
	Wed, 09 Sep 2026 22:40:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 2/6] bpf: Bound the number of indirect jump edges in a program
Date: Wed,  9 Sep 2026 22:40:31 +0200
Message-ID: <20260909204035.24289-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909204035.24289-1-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28118/Wed Sep  9 08:24:03 2026)

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
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/cfg.c             | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

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
index 081f7003eae6..e9910228da58 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -9,6 +9,8 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
+#define BPF_MAX_GOTOX_EDGES	BPF_COMPLEXITY_LIMIT_INSNS
+
 /* non-recursive DFS pseudo code
  * 1  procedure DFS-iterative(G,v):
  * 2      label v as discovered
@@ -388,6 +390,19 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 			return PTR_ERR(jt);
 
 		env->insn_aux_data[t].jt = jt;
+
+		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
+				       &env->cfg.gotox_edges) ||
+		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
+			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
+				BPF_MAX_GOTOX_EDGES);
+			bpf_diag_program_structure(
+				env, t, "too many indirect jump edges",
+				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
+				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
+				BPF_MAX_GOTOX_EDGES);
+			return -E2BIG;
+		}
 	}
 
 	mark_prune_point(env, t);
-- 
2.43.0


Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FC4C224E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=oUhrzW6/eNAmANU78wJN5zNjtH/Rj7emwtTkEqFyLU5xu3UxmVmOwTKlyh5jfpJTPFkj/PUhZ0qTMEssPNWPoshmhYhXJbDUQK244vxnTlVnNSTidx+JnsCW3R6RxluUTGA36gtYXQniiDihxiXdeXjjLBz3TdJR9XL8NGx/Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=oNPRRj2U631Zl5fCJ8Znn+d3htdLYLZnlXFvYky/SB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZkuAnlDQY2qVQ/+jRg4BRoi4kOoGO8dcRNG5eiDPV29Pc+ygH50k2R744BQKwG8qST5QONi6OtZ+wtVAL7l7bXyTKHYZIZG7jRQU39/tqxjPDqJftF+lI0skMNZB7R5ABb7FSiivUojyF3js3ygy7Ni2fqDL8JhTvZeMJlKQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eYec6OJ9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eYec6OJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ljYzXtuGFMqeIyBmxGbJjMLkRr2YR5nY2XRk/khlKIc=; b=eYec6OJ9OIiuhrPDVtMhffV1pe
	bDuZmxt67Zoj1LAjkx+9TetKY4Go+F5KBw9K7xSOi4tIP8x/8cLU6t02CBxosKftHMLjiPdr7r4GS
	zbXkllFIGLPWp9fAOagGp7TImSyDmLe8G3Xg13KP/G76EueaUDvFdBJHsJMhltJWg1cH97nBhOxF3
	xFO+TAxN3MJVRrruEQYO+BA7QjYEPuMedWW8mY066l2FHusJ20xArYho1psVBLmVWmAP6es2npu3l
	fV6S7Wwwm3l/eQqUXR0QYucLX3PPs1G9DWXzlV53feCM6T0pBivT+3ObEmoEv9C+P41s7P0cbXmRt
	tbXT8P1A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6I-000JjL-2N;
	Fri, 25 Sep 2026 19:52:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	STAR Labs SG <info@starlabs.sg>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 02/16] bpf: Bound the number of indirect jump edges in a program
Date: Fri, 25 Sep 2026 19:52:29 +0200
Message-ID: <20260925175244.1136329-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Every gotox instruction gets its own copy of the jump table of the subprog
containing it, and each distinct target in that table is a CFG successor
of the instruction. The number of such edges is therefore the number of
gotox instructions times the number of distinct targets, and neither
factor is bounded by anything except the instruction limit.

What is expensive is a BPF prog whose gotox instructions are themselves
the targets, which makes the edge count quadratic. 1024 such gotox are
already ~1e6 edges and about 4s of CPU to load.

Bound the total across the program at BPF_COMPLEXITY_LIMIT_INSNS, aka
the limit on the number of instructions the verifier processes. Progs
with real switch statements are orders of magnitude below this.

This bounds the edges only. Building the jump table of a gotox costs the
number of entries of all insn array maps regardless of how many distinct
targets they hold, which a later patch addresses separately.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/cfg.c             | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 646e447cebd8..67363c25526d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1004,6 +1004,7 @@ struct bpf_verifier_env {
 		int cur_stack;
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
+		u32 gotox_edges;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 54ff20234236..69e484b25b59 100644
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
+			env, t, "too many indirect jump edges",
+				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
+				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
+				BPF_MAX_GOTOX_EDGES);
+			return -E2BIG;
+		}
 	}
 
 	mark_prune_point(env, t);
-- 
2.43.0


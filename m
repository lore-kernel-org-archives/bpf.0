Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCA302779
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187937; cv=none; b=T7pZOl1rapZbJKLqR5sgIDP907j+kZX0oE+t2fXUZzzScBM9raQiFEJ2e8kuicrBbBQOIIfN6teMtfRm3HMmaY/MyCZv4cGHLPZNx3it4vE8cRhJA9M6gm1Gy1ffMa43FR36uSoMvXB5pDXK1JgCDnlEbZVmAkGdgv1ExDwVT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187937; c=relaxed/simple;
	bh=nXj3Q76IlpZbOECwV6g+4+roXhmhBlgsqVRAXVI8FlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuvqLFJsyULYJRSHyW6OXJfY3eYXypWNiZI3QvW0PWWckcfWhubbFWLf7vaTV9oEfraf+DmGDjEk1JPZj9W++FP3Yz2uZ7fghKzs5ycjCp31qpWQiRMDghk+7IKas6ZsP+b4h6olO2ZB4LmpvPFqWCX8AYNH+nPMfyaADWONmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O3KeqcjS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O3KeqcjS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65807298140so3993728a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187934; x=1769792734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHfRMp+G9XW+duymvt9Q2+cD8A5sxDN6vWrUvFGULFE=;
        b=O3KeqcjSDIe8V0//GgObS3bVzcHr+E3JiV28OAdG/OkfpBX7Vf0YdGd+soPCCMlJwr
         dEXyMe+UVIdMTb7+MK+aK/Erc+GRR0l+N2UknUQU1WhFJOfWB8x0aBMuwWNT5AWOg8Z/
         pJoMC7GHlSYx9Xi5/Sp+MecmPJDB/O/GzYpOmrE5bKshbPzpCEwlmIbVUB995i0ih5Ry
         gWRoeLBre1ukMJfhArvH42gvip8PY9Vomh+6ugsqz1gW3tt2Hapqi2GcVgX76k+PudAR
         6tT/F8/kgfIiSO7nxxcKK+x11VJYFNLbbW2Cxh2XFGHtGblIP7dXk/y4XO+RNEZFihxu
         blNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187934; x=1769792734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fHfRMp+G9XW+duymvt9Q2+cD8A5sxDN6vWrUvFGULFE=;
        b=ellwDs4C8brxIDJaeL1wYCTbvAH5zPSVR1Ywj9bPyXQL8Ye6JmcYc4L4pSOMY89oQd
         aZZnCZ6MrjG5Mlje4mmwWPXrekR0fwMIfDRBfv74iqrjyYobyWy/V2xLnKvQLTMXo73L
         lmavECu+59SNHJFwVLbllJCXGNOi5GUel2bOSuIavWQQ8EMl1odT4QsUGA7jMKy47RWe
         k9iOnIzdzzd8lUthErAigrB/Z4HFCb08I+sJVdX2j2vRVQaHakzKiqa84AYQxQTgBSEe
         XzqzOjvWaiCv0KEZZyOcT5tIxtbbEqQ85GznLroocazSA+xI2VWEHTXwJogULVLM5Auh
         rliA==
X-Gm-Message-State: AOJu0YyE2gSx9/dF/RVPdkheD3nVt3UcJ4tmGNMBbmohOK0MRBGtl2GZ
	KRLVMrld0EcJrFGdrL89IOSMHLmAmkqbcXag1cF7SlexjbgMKGKKUlLT23PIPJbi9iw=
X-Gm-Gg: AZuq6aJFEqlAplVfh20NrjrQ6tKyUsy/ERSIVcv6M93wXBy7cRCSYGyt3MaIg6TvCb5
	z/t9CC1VIuOfY+qLkaO0v66mpXRP+1KIppNJfoOuYJZdq+2YnVpXVjDz0aw6elyBIRHKA/FkTDE
	TKjFGFYi+v0ecV/B1DYUaFhLo08g5EllIMMY6YavgOIwdi712RFJYkkWlnTFdveCBMaBZnYOeoS
	q4+HPbZ6o26+DtWu94vF/AQntQ4sUMxy+ROnS4DaOAS0i3cagcgWhkI4zGX1aTIifXJq4x3QMpC
	VngAhvpNcbc8Q9S95OkhO0pmU9JTp2AtNeO2L1PM6Ui4ITs3O1ZDzCj2NQ5siYLUc5ltbEUVuUI
	tU5j6Hb5WaoZW9gAXsIjerNj86UV8nrZFgYciEK5PW+d3qolIiqlijY2tGcvgwRJEbvMQc8l6Dq
	1EF0qBVXOsjNyi+Wn105KanKiJ57/DC+9O7Frte0HKbKwUSVVz8J+nBIQUiWiwsw==
X-Received: by 2002:a17:907:7b8e:b0:b87:1be6:c707 with SMTP id a640c23a62f3a-b885ac69192mr308784666b.17.1769187933746;
        Fri, 23 Jan 2026 09:05:33 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4d7sm130944866b.45.2026.01.23.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:33 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:19 +0100
Subject: [PATCH bpf-next v2 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-2-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailer: b4 0.15-dev-07fe9

Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
helper calls instead of BPF_CALL_KFUNC.

Remove the BTF_ID_LIST entries for these functions since they are no longer
registered as kfuncs.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/sched/bpf_qdisc.c | 76 ++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..cad9701d3b95 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -130,7 +130,30 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
+/* bpf_qdisc_init_prologue - Called in prologue of .init. */
+BPF_CALL_2(bpf_qdisc_init_prologue, struct Qdisc *, sch,
+	   struct netlink_ext_ack *, extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *p;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+
+	if (sch->parent != TC_H_ROOT) {
+		/* If qdisc_lookup() returns NULL, it means .init is called by
+		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
+		 * has not been added to qdisc_hash yet.
+		 */
+		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (p && !(p->flags & TCQ_F_MQROOT)) {
+			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 				  const struct bpf_prog *prog)
@@ -151,7 +174,7 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_init_prologue);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
 	*insn++ = BPF_EXIT_INSN();
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
@@ -160,7 +183,15 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return insn - insn_buf;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_reset_destroy_epilogue_ids, func, bpf_qdisc_reset_destroy_epilogue)
+/* bpf_qdisc_reset_destroy_epilogue - Called in epilogue of .reset and .destroy */
+BPF_CALL_1(bpf_qdisc_reset_destroy_epilogue, struct Qdisc *, sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
 				  s16 ctx_stack_off)
@@ -178,7 +209,7 @@ static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_pr
 	 */
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_reset_destroy_epilogue);
 	*insn++ = BPF_EXIT_INSN();
 
 	return insn - insn_buf;
@@ -230,41 +261,6 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
 }
 
-/* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
-__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
-					struct netlink_ext_ack *extack)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-	struct net_device *dev = qdisc_dev(sch);
-	struct Qdisc *p;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-
-	if (sch->parent != TC_H_ROOT) {
-		/* If qdisc_lookup() returns NULL, it means .init is called by
-		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
-		 * has not been added to qdisc_hash yet.
-		 */
-		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
-		if (p && !(p->flags & TCQ_F_MQROOT)) {
-			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-/* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
- * and .destroy
- */
-__bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-
-	qdisc_watchdog_cancel(&q->watchdog);
-}
-
 /* bpf_qdisc_bstats_update - Update Qdisc basic statistics
  * @sch: The qdisc from which an skb is dequeued.
  * @skb: The skb to be dequeued.
@@ -282,8 +278,6 @@ BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
-BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
-BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
 BTF_ID_FLAGS(func, bpf_qdisc_bstats_update)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 

-- 
2.43.0


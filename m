Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C71301002
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178129; cv=none; b=pEBgOmrvHSHk1Y/TP84ZSNe/zu4rSXgq4H/J2QBHHcCxOebWC7AwU5UcLjaNMqdwTjUofLtW70mwDhC/Y9LkpZu1MZyy9TfwsysEZ151O0OS42yvirpLc6HdSAFMo9OfS2g/vcGtlbufANfGxa8Xbt3qtEh+W1LEjnIZxP6m4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178129; c=relaxed/simple;
	bh=Btl1bGUnRu7+h0uN8S0x6Vfgm/J7bB+e803H18jiwSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrspwwNRkR9qlOykIkC0odnfrSuDsWP7L0+n5WWj2WP062nE6IUD2K8zqVbamMuykTeCf/imFL9oR0Iywe+ok8ySNoCEKKQlJpTyAx+QdAMZpIEvHZZcTdFSN3T7B2pLsD7NB63Hsk9OB7mNHS4lGXH58Am0BK5UdqOpD/GVMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgTJ74i2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgTJ74i2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c27d14559so3303905a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 20:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770178124; x=1770782924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ln6rcHM3CJsi+L4yX01pz2fFYCfyocMjzXLeCJuEAE=;
        b=MgTJ74i2w8t0xU2rBaHMEqfMv6eebZN3NPThXsnSXoVQ747uLAvrDz2t6pzWw39kcB
         6Nn+XoSM2KKd3QE2ZMzuFP4ZNDNT/yyH4MO7gAqsTFcCCKdWFcH7CPxpk6XIFVyicsj0
         jqAdWFNiBVxX+5X5u9fgBZfH3OfxjU3JaTvGb+UxrG0PsKomWyIVogaR8/+YT/5l5wBc
         e44eKKJNP92IgMF6AqHAWzypnGOuABtqwGCVSYT9jym5PI/BInkJ2Oeo9YDf6U1lH300
         Jf7bt6hkghanlQBXKmfnbofCbp/yvtoEieyL71L/1fqe7KCJDsD4gCvkNv8VNpTwcqwl
         eJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178124; x=1770782924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Ln6rcHM3CJsi+L4yX01pz2fFYCfyocMjzXLeCJuEAE=;
        b=dUnjVZ130S2/+eV+WrNkhM3+rRe7OKFyjlB60B66fFuFkwVALQT4plYwBclFA+tBEZ
         YfWs4rKuFuppmzVVqIH/UG4Cr6GT/TLKDURS0DxTcbJwoQEP+l/P80Is9c840p5iFamP
         Lsoyk3LbLMIhakcKk6v1lMcDndXB8PcswDP5gs7k30VIT6OivM1ndYZ/I7E+sWFhuMnq
         ZziHNzEX4qtMsDcplmvAeg0NYSBCIvthF/+iZuMg8xgxBsVjscdHbajzAtabLcLFpWOg
         fcFtl6+UJ+Se4VEv6hS8EebT0NqJvHkFFwK8ADE7xHBoVdfmASOKa1wHfU8H67DCkHvT
         AKfw==
X-Gm-Message-State: AOJu0Yy8FCmmXirQp2LzGbLI9hj8m+W7nSlDDEwrMepneEENHuc9AaOb
	H+Fdnj3f37iWO15sR9SZspX5qg9of0L+KXrNFNQDHWOmGHO/FnAIU/1IGfho8w==
X-Gm-Gg: AZuq6aLcrRp+6IL4MDh50KTxWro2hQ+mjTG1AKqQCPw3M+zrT1Tvj3N/Labr+NcDPNX
	lTY/QBCP8d6gVq5XNXNh4mrQ0yMk/bwOMOuQuZTySSD2sfaxILEoftqiVggaQ+Mty68hwnAoJLa
	EQ8gdH4DRB6DIxrHeM+Xp4pPeIzORPJadw5YF3QTlNPxypnclGEeXUzIfCR98F32JJ2jW9cBlgM
	yCNQBvD33mWIJ3v+rDXjWXcaGR0KIvKmwYB1AJ9tdkwQB1cTilNXQUsXipYI2IFKsKiwjVyDggZ
	CVCtfaVi6xJ3G1ui39hwrJsiUWTjESnCw9N6vINQVB/Aolv70VuIC2Sw1eYmRWrX2OFynvwlk2M
	zlBOKV9Mw0a035zL98hIV/JOx+GB98iU+43kBhAnGthlAC0fySvp+MUAnPYYCIYrhNY6K7bEEtd
	0tMtDaw4hBYHG+HZUwGmZB5umHLcu48bKnx/XxXyGV1smoJjzDKv9Sq+yxXgp0BWtUUN3ntF2UM
	Ec+fQus/L97JJ+oLh7IHvH9vDYMBt5yR3OvBY+s9OgQeTZwWw==
X-Received: by 2002:a17:90b:5348:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-354870e9703mr1479750a91.12.1770178123980;
        Tue, 03 Feb 2026 20:08:43 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860bef61sm1047619a91.3.2026.02.03.20.08.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 20:08:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v2 bpf-next 3/4] bpf: Add a recursion counter to prevent loops in bpf_timer
Date: Tue,  3 Feb 2026 20:08:32 -0800
Message-ID: <20260204040834.22263-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
References: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Do not schedule timer/wq operation on a cpu that is in irq_work
callback that is processing async_cmds queue.
Otherwise the following loop is possible:
bpf_timer_start() -> bpf_async_schedule_op() -> irq_work_queue().
irqrestore -> bpf_async_irq_worker() -> tracepoint -> bpf_timer_start().

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0517e9a8fc7c..0f681a89b842 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1427,9 +1427,21 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, async_cb_running);
+
 static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
 				 u64 nsec, u32 timer_mode)
 {
+	/*
+	 * Do not schedule another operation on this cpu if it's in irq_work
+	 * callback that is processing async_cmds queue. Otherwise the following
+	 * loop is possible:
+	 * bpf_timer_start() -> bpf_async_schedule_op() -> irq_work_queue().
+	 * irqrestore -> bpf_async_irq_worker() -> tracepoint -> bpf_timer_start().
+	 */
+	if (this_cpu_read(async_cb_running))
+		return -EDEADLK;
+
 	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
 
 	if (!cmd) {
@@ -1628,6 +1640,7 @@ static void bpf_async_irq_worker(struct irq_work *work)
 		return;
 
 	list = llist_reverse_order(list);
+	this_cpu_inc(async_cb_running);
 	llist_for_each_safe(pos, n, list) {
 		struct bpf_async_cmd *cmd;
 
@@ -1635,6 +1648,7 @@ static void bpf_async_irq_worker(struct irq_work *work)
 		bpf_async_process_op(cb, cmd->op, cmd->nsec, cmd->mode);
 		kfree_nolock(cmd);
 	}
+	this_cpu_dec(async_cb_running);
 }
 
 static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
-- 
2.47.3


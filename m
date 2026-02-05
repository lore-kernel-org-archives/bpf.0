Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344808632A
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318157; cv=none; b=DERpmtcjPCpgEWycGvyqfuz0SO9pwxTRezi9CgydAYGyCVAgobz00k3Em4kfyjW6sqrZ5cAksMi8NaOxOe9L2l0xNwCpVErU+kwvlJh1DGBp2Ee73LjRP6Xm/oPFSidl7ixJ0WZDkPMx4xu9V6/n2a4Y1v0OrGJhDyuaMgC4fnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318157; c=relaxed/simple;
	bh=K3SRS7CC5cdm4UjuYFE99zOY2M5cUsV+TjQ/ZcE0m94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fe86OVyAdlllGG5encN6rV0Jf5YRc9hjDZ+0YfPabeDqX+rtRgNTJ5jh9tUsZ3u/xLz3E43OHzelGCA/W7yNQ17r6OPiMi+NIUxKdTwHKNc0ubZXCYGFJGp48DT5XGckzPWSGQWXmeSFaZRNvm/h1Pv78CByRqMVi7wpIOiAlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX72rczZ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX72rczZ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1337699eec.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318156; x=1770922956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yy9jMp5i+Jb9uHVC4/55/L3T+sqVAKXyYiq6Ktnk+hA=;
        b=MX72rczZDEIE6LRxkNO1qwkPYQEq/AJnZ9Glqpr83scw98/Y/SrPZC3BDHZOu/Ndng
         nbliCNNpzEI5INR1gDZ5NKpPGB5Je7Rrs7ej2UvsPFzqudJ3X4QMeQ+rHO2fVNXRtems
         2oiazScu5gRuru8S2beZCh+GJnOK7/eddzCMuTn2lFOH5AkuFJiAN4uvXy8hXLHVT8Kn
         Vo76wP9WNOHZCRh3hhQYiyF4myyPL3pBP/13mhFA+d2HgtgSExH2wpBx/8IBRBp6Zon0
         bpDNnq8QMINJo4csgsPJRUaGllP7BiTzsZPrBKr5JbkZlCzZqdo+UO7NNh0ARuRxElKI
         OWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318156; x=1770922956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy9jMp5i+Jb9uHVC4/55/L3T+sqVAKXyYiq6Ktnk+hA=;
        b=E4lSLFCQ61xk0pm8acqoVhP9ljXuEDpDPpwXW1W7WTnUzSWmztoI2sFeK3tnwzOr6Y
         1aPKvKk2nZdOXXo47Q0W81Yay1iC+ZAt3WQDfvWQVZFuepWyujuToJ3U0IiOvZjQ+Pq4
         ReXoFuJWAk9ziU1IevhlRFtPmL7/gNS4dNm25+834OXh9oxPY3kh9OPvXOLtALQ14sRg
         1m4uICZ8sjNh7XTBKwphvPNGhvlobM6qE/GlUEhbqsG/zmlI76wUAyDamqjUXbB+8jtb
         k9eE+xp++NIG9GRXGRPGHAZTwymf0d84+frAn077U1iWXYoaLTxap84mWPqhbE6gt8s6
         LHAA==
X-Gm-Message-State: AOJu0YyWZRF7QoO6hcItwGjEPzl1t2ALlDi5Oj8oFcll6kbBatFhOPC5
	tLYUahnySaINA0siIZM9va0QdCofHcfPovBBm2tajZBxhlxdeCGFYB3/7EuiBQ==
X-Gm-Gg: AZuq6aLRl+kuFlTew9qW7ein0u/SPexqX8SR/XDzy2MaUq1kHU8U+SevK5fN6a/9Pfa
	7spe6uDWEt+J15CjnHiKXPfua/Ezu/EFKkGuHw7ZUO2DSZ8X5fyP7AkkouYZ8F0pjLpWdnQ4xzP
	H57lrIO7Dxs1uX3zR2oJfVXU6aGrKD9jIuZF/uMlXMDr1akwQ1Z5NQrcwF/aNkSkswwju0KMzwH
	CyW6ZrGatCEgrQcwuYz3sk4jphGPitiEb79d4FvVn3jiU5oHPrnE+StOvKOVSddJrg74r2KdkUl
	FN0BZyB2Q4/rwPD99W6EDlqLwCK8joQYDMzPjHn3cZ0i7PDc97ZPlHvKEMUT2AEcma0mguNzgfH
	qZRNPFCGYAGv1/lfoVpBir/7jfO5WD1cz+QOOHcF5ngt1kuUq5fk6u4SIO58LgrLLcUJis+Kas9
	1qdhWycFipOA4s71SRrfm2+zJv1j/UxzfVxXwC4lJDhtOSU4Ei/qIcGawN2E2i6zrdv6o4xPew6
	FJ6raTN8RVcSWeEtUbxhn+x84NAS/rdnw==
X-Received: by 2002:a05:693c:3117:b0:2b7:fdb6:cce3 with SMTP id 5a478bee46e88-2b8563d8bb9mr64028eec.8.1770318155583;
        Thu, 05 Feb 2026 11:02:35 -0800 (PST)
Received: from ast-mac.corp.tfbnw.net ([2620:10d:c090:500::1:6325])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855ad8c62sm173427eec.3.2026.02.05.11.02.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Feb 2026 11:02:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next] bpf: Prevent reentrance into call_rcu_tasks_trace()
Date: Thu,  5 Feb 2026 11:02:33 -0800
Message-ID: <20260205190233.912-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

call_rcu_tasks_trace() is not safe from in_nmi() and not reentrant.
To prevent deadlock on raw_spin_lock_rcu_node(rtpcp) or memory corruption
defer to irq_work when IRQs are disabled. call_rcu_tasks_generic()
protects itself with local_irq_save().
Note when bpf_async_cb->refcnt drops to zero it's safe to reuse
bpf_async_cb->worker for a different irq_work callback, since
bpf_async_schedule_op() -> irq_work_queue(&cb->worker);
is only called when refcnt >= 1.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a4f039cee88b..0458597134da 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1276,12 +1276,24 @@ static void bpf_async_cb_rcu_tasks_trace_free(struct rcu_head *rcu)
 	bpf_async_cb_rcu_free(rcu);
 }
 
+static void worker_for_call_rcu(struct irq_work *work)
+{
+	struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
+
+	call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
+}
+
 static void bpf_async_refcount_put(struct bpf_async_cb *cb)
 {
 	if (!refcount_dec_and_test(&cb->refcnt))
 		return;
 
-	call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
+	if (irqs_disabled()) {
+		cb->worker = IRQ_WORK_INIT(worker_for_call_rcu);
+		irq_work_queue(&cb->worker);
+	} else {
+		call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
+	}
 }
 
 static void bpf_async_cancel_and_free(struct bpf_async_kern *async);
-- 
2.47.3


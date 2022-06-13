Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E3C433EF
	for <bpf@archiver.kernel.org>; Mon, 13 Jun 2022 02:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiFMCxt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 12 Jun 2022 22:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiFMCxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jun 2022 22:53:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9F38BDB
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655088828; x=1686624828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6s/ljkxO3fs2NFLJ1nraGTePyjpTWQEUZBwLnPxGa8=;
  b=xZ/s6FQJH4JSrXIcdogtPcuWfI7j4lj61XlSKjsaUq1E3JLCItek+5Zp
   gqfwqsYgp6D/qNrQtDxADvVLDvM/T8ZJSb/YKRZ7480mCDHdDomFYW1ss
   0RiZO/DnKWtshIjGsX/etiYqGW0Vgr9nCv6i9KfQc4NYfRB9kdnfVurt/
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Jun 2022 19:53:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 19:53:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 12 Jun 2022 19:53:46 -0700
Received: from hu-satyap-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 12 Jun 2022 19:53:46 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     <bpf@vger.kernel.org>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <joannelkoong@gmail.com>, <toke@redhat.com>, <brouer@redhat.com>
Subject: [PATCH] bpf: fix rq lock recursion issue
Date:   Sun, 12 Jun 2022 19:52:44 -0700
Message-ID: <20220613025244.31595-1-quic_satyap@quicinc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Below recursion is observed in a rare scenario where __schedule()
takes rq lock, at around same time task's affinity is being changed,
bpf function for tracing sched_switch calls migrate_enabled(),
checks for affinity change (cpus_ptr != cpus_mask) lands into
__set_cpus_allowed_ptr which tries acquire rq lock and causing the
recursion bug.

Fix the issue by replacing migrate_enable/disable() with
preempt_enable/disable().

-010 |spin_bug(lock = ???, msg = ???)
-011 |debug_spin_lock_before(inline)
-011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
-012 |_raw_spin_lock(inline)
-012 |raw_spin_rq_lock_nested(inline)
-012 |raw_spin_rq_lock(inline)
-012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
-013 |__set_cpus_allowed_ptr(inline)
-013 |migrate_enable()
-014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
-015 |perf_trace_run_bpf_submit(inline)
-015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
-016 |__traceiter_sched_switch(inline)
-016 |trace_sched_switch(inline)
-016 |__schedule(sched_mode = ?)
-017 |schedule()
-018 |arch_local_save_flags(inline)
-018 |arch_irqs_disabled(inline)
-018 |__raw_spin_lock_irq(inline)
-018 |_raw_spin_lock_irq(inline)
-018 |worker_thread(__worker = 0xFFFFFF88CE251300)
-019 |kthread(_create = 0xFFFFFF88730A5A80)
-020 |ret_from_fork(asm)

Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b914a56a2c5..4ecb065140e9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1414,7 +1414,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	if (unlikely(!array))
 		return ret;
 
-	migrate_disable();
+	preempt_disable();
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
@@ -1423,7 +1423,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-	migrate_enable();
+	preempt_enable();
 	return ret;
 }
 
-- 
2.36.1


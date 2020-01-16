Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F09C33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D07207E0
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185888;
	bh=sSD5mwamux5+wjoulyCcRI5d07g/ay7zhN0fXj2xIns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzA/ehY+KazwvBmk6lz9It+rCIKIHFrBH0yYsnMIdjRD0tjuD0m6UgfAlKuAZ183/
	 EcBLE8LhYoO3HooZEJOTzLkW2/iAx0zYv4ezYowZpqy7YKuXCiJFh2ldC0bh2ROlUj
	 aQokMTkWEE4IpUsGXxQF3N/fqAbRf1JeuS0rl/iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPOor (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:44:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgAPOor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:44:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED7820684;
        Thu, 16 Jan 2020 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185886;
        bh=sSD5mwamux5+wjoulyCcRI5d07g/ay7zhN0fXj2xIns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J65etQUtUrdHX10B9ewczQfWBBgoADBQmeyjR5eze8xxlMl0CZHLJxFLB4yPpknGX
         psUNAWTfyfAv52AgOaoGYTW3W3NcCmP8B1S9JdyVrvdk/dVbH5kKKS2AGSCY6byePP
         o7XOUgnjfwwwVbbHPBW7a0aSvcSUM/ANDfBONOrA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 03/13] kprobes: Postpone optimizer until a bunch of probes (un)registered
Date:   Thu, 16 Jan 2020 23:44:42 +0900
Message-Id: <157918588172.29301.12636373067838941611.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a counter to kick_kprobe_optimizer() to detect any
additional register/unregister kprobes and postpone
kprobe_optimizer() until a bunch of probes are registered.

This might improve some long waiting unregistration process
for bunch of kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a2c755e79be7..0dacdcecc90f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -465,6 +465,7 @@ static struct kprobe *get_optimized_kprobe(unsigned long addr)
 static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
 static LIST_HEAD(freeing_list);
+static int kprobe_optimizer_queue_update;
 
 static void kprobe_optimizer(struct work_struct *work);
 static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
@@ -555,12 +556,22 @@ static void do_free_cleaned_kprobes(void)
 static void kick_kprobe_optimizer(void)
 {
 	schedule_delayed_work(&optimizing_work, OPTIMIZE_DELAY);
+	kprobe_optimizer_queue_update++;
 }
 
 /* Kprobe jump optimizer */
 static void kprobe_optimizer(struct work_struct *work)
 {
 	mutex_lock(&kprobe_mutex);
+
+	/*
+	 * If new kprobe is queued in optimized/unoptimized list while
+	 * OPTIMIZE_DELAY waiting period, wait again for a series of
+	 * probes registration/unregistrations.
+	 */
+	if (kprobe_optimizer_queue_update > 1)
+		goto end;
+
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	/* Lock modules while optimizing kprobes */
@@ -593,6 +604,8 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
+end:
+	kprobe_optimizer_queue_update = 0;
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();


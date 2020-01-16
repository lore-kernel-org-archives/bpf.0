Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B525C33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C682081E
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185909;
	bh=IFSRRDWoO04+d+aw3lwFPJ0LN77zME0FCYGJcB0/PX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFhQHASBGpVjeC4jcRuOug7z0BMCA9h3hPEPKVwCI+h6WpPxQ+y6+XKn93QEe0k91
	 aAiB/5zg9BkvXFwLWQjviSYLu1/bJ9hHkK03FGZcwwUI5ypffo5MzN2p7QGUXnPiN/
	 JzlixcB19vUOFShd5hjKcEXACgyipuYIseLvROaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAPOpI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPOpI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:08 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811C920684;
        Thu, 16 Jan 2020 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185907;
        bh=IFSRRDWoO04+d+aw3lwFPJ0LN77zME0FCYGJcB0/PX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bql8uLL4lnVu7kUTmWxapGiTQ/LR5RnjuBsGHfU/uf3ISjsMI2kFl2ypvZpKPRzLQ
         OepJt5mMSPPF4m7EVrq6NEqPAx+x/ONAn4eCArzpdoE+FR6Vw0xQut21z0SspMA34v
         N783/x/tHhw9wZRV/SVHWJWvwXCAul0hNjgW3S+E=
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
Subject: [RFT PATCH 05/13] tracing/kprobe: Use call_rcu to defer freeing event_file_link
Date:   Thu, 16 Jan 2020 23:45:02 +0900
Message-Id: <157918590192.29301.6909688694265698678.stgit@devnote2>
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

Use call_rcu() to defer freeing event_file_link data
structure. This removes RCU synchronization from
per-probe event disabling operation.

Since unregistering kprobe event requires all handlers to
be disabled and have finished, this also introduces a
gatekeeper to ensure that. If there is any disabled event
which is not finished, the unregister process can synchronize
RCU once (IOW, may sleep a while.)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   35 +++++++++++++++++++++++++++++------
 kernel/trace/trace_probe.c  |   10 ++++++++--
 kernel/trace/trace_probe.h  |    1 +
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index cbdc4f4e64c7..906af1ffe2b2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -328,10 +328,25 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+atomic_t trace_kprobe_disabled_finished;
+
+static void trace_kprobe_disabled_handlers_finish(void)
+{
+	if (atomic_read(&trace_kprobe_disabled_finished))
+		synchronize_rcu();
+}
+
+static void trace_kprobe_disabled_finish_cb(struct rcu_head *head)
+{
+	atomic_dec(&trace_kprobe_disabled_finished);
+	kfree(head);
+}
+
 static void __disable_trace_kprobe(struct trace_probe *tp)
 {
 	struct trace_probe *pos;
 	struct trace_kprobe *tk;
+	struct rcu_head *head;
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
 		tk = container_of(pos, struct trace_kprobe, tp);
@@ -342,6 +357,13 @@ static void __disable_trace_kprobe(struct trace_probe *tp)
 		else
 			disable_kprobe(&tk->rp.kp);
 	}
+
+	/* Handler exit gatekeeper */
+	head = kzalloc(sizeof(*head), GFP_KERNEL);
+	if (WARN_ON(!head))
+		return;
+	atomic_inc(&trace_kprobe_disabled_finished);
+	call_rcu(head, trace_kprobe_disabled_finish_cb);
 }
 
 /*
@@ -422,13 +444,11 @@ static int disable_trace_kprobe(struct trace_event_call *call,
 
  out:
 	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
 		trace_probe_remove_file(tp, file);
+	/*
+	 * We have no RCU synchronization here. Caller must wait for the
+	 * completion of disabling.
+	 */
 
 	return 0;
 }
@@ -542,6 +562,9 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_probe_is_enabled(&tk->tp))
 		return -EBUSY;
 
+	/* Make sure all disabled trace_kprobe handlers finished */
+	trace_kprobe_disabled_handlers_finish();
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (unregister_kprobe_event(tk))
 		return -EBUSY;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 905b10af5d5c..b18df8e1b2d6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1067,6 +1067,13 @@ struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 	return NULL;
 }
 
+static void event_file_link_free_cb(struct rcu_head *head)
+{
+	struct event_file_link *link = container_of(head, typeof(*link), rcu);
+
+	kfree(link);
+}
+
 int trace_probe_remove_file(struct trace_probe *tp,
 			    struct trace_event_file *file)
 {
@@ -1077,8 +1084,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	synchronize_rcu();
-	kfree(link);
+	call_rcu(&link->rcu, event_file_link_free_cb);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 4ee703728aec..71ac01a50815 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -243,6 +243,7 @@ struct trace_probe {
 struct event_file_link {
 	struct trace_event_file		*file;
 	struct list_head		list;
+	struct rcu_head			rcu;
 };
 
 static inline bool trace_probe_test_flag(struct trace_probe *tp,


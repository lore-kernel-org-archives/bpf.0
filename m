Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BBC33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A48207FF
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185984;
	bh=VutGjxWwdtEPcCBYrGyCDjwJ75btz6UR1pL3UbFs08c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N6pV+Ny60umYY/S9raxFTZ1ZvViMWVPdYxU9G/O0MmMPTNEBwzOLU+i6N+pMBhKZF
	 QY11oWj2JCot6MrjycF5HE9puDeqrNk+ODLOSe7JjuaJjb+F26K/rp2ZQoSkGswrVb
	 gJDzTWgFrYvwcSwc5Ma7ZkvV7BPzv0layoPZj2Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAPOqY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPOqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:46:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F47820684;
        Thu, 16 Jan 2020 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185982;
        bh=VutGjxWwdtEPcCBYrGyCDjwJ75btz6UR1pL3UbFs08c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCopYxEeBllyD83t5ggx9lLCMEqXOioXxFbSCQYI7g2LtcvQJ+qALffU9m3YOzIU3
         9iV9mxRqVVBkBKJ3PY2MpI/Q1qpOXdsfillIc1IfIksCIQfudpXlGrnArkVNTJ0ceG
         RLw8DQq7KHGJV/3hnu7IvzrmRfI+Vw7Wqo6YhXBs=
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
Subject: [RFT PATCH 12/13] tracing/kprobe: Free probe event asynchronously
Date:   Thu, 16 Jan 2020 23:46:17 +0900
Message-Id: <157918597739.29301.3329193112465223174.stgit@devnote2>
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

Free each probe event data structure asynchronously when
deleting probe events. But this finally synchronizes RCU
so that we make sure all event handlers have finished.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |    5 ++++
 kernel/trace/trace_kprobe.c   |   46 +++++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 89779eb84a07..2d5e8d457309 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -70,6 +70,9 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 		if (ret)
 			break;
 	}
+
+	/* Wait for running events because of async event unregistration */
+	synchronize_rcu();
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -164,6 +167,8 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 		if (ret)
 			break;
 	}
+	/* Wait for running events because of async event unregistration */
+	synchronize_rcu();
 out:
 	mutex_unlock(&event_mutex);
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 906af1ffe2b2..f7e0370b10ae 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -551,7 +551,35 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 	}
 }
 
-/* Unregister a trace_probe and probe_event */
+static void free_trace_kprobe_cb(struct rcu_head *head)
+{
+	struct kprobe *kp = container_of(head, struct kprobe, rcu);
+	struct kretprobe *rp = container_of(kp, struct kretprobe, kp);
+	struct trace_kprobe *tk = container_of(rp, struct trace_kprobe, rp);
+
+	if (trace_kprobe_is_return(tk))
+		kretprobe_free_callback(head);
+	else
+		kprobe_free_callback(head);
+	free_trace_kprobe(tk);
+}
+
+static void __unregister_trace_kprobe_async(struct trace_kprobe *tk)
+{
+	if (trace_kprobe_is_registered(tk)) {
+		if (trace_kprobe_is_return(tk))
+			unregister_kretprobe_async(&tk->rp,
+						   free_trace_kprobe_cb);
+		else
+			unregister_kprobe_async(&tk->rp.kp,
+						free_trace_kprobe_cb);
+	}
+}
+
+/*
+ * Unregister a trace_probe and probe_event asynchronously.
+ * Caller must wait for RCU.
+ */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
 	/* If other probes are on the event, just unregister kprobe */
@@ -570,9 +598,17 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 		return -EBUSY;
 
 unreg:
-	__unregister_trace_kprobe(tk);
 	dyn_event_remove(&tk->devent);
+	/*
+	 * This trace_probe_unlink() can free the trace_event_call linked to
+	 * this probe.
+	 * We can do this before unregistering because this probe is
+	 * already disabled and the disabling process waits enough period
+	 * for all handlers finished. IOW, the disabling process must wait
+	 * RCU sync at least once before returning to its caller.
+	 */
 	trace_probe_unlink(&tk->tp);
+	__unregister_trace_kprobe_async(tk);
 
 	return 0;
 }
@@ -928,11 +964,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
-	int ret = unregister_trace_kprobe(tk);
-
-	if (!ret)
-		free_trace_kprobe(tk);
-	return ret;
+	return unregister_trace_kprobe(tk);
 }
 
 static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)


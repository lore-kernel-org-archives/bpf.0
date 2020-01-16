Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB5C33CB1
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF089207FF
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185994;
	bh=r2rV98t7yERiTDZYhhTOeqzP6On1Kcg4dpcDBQpoYPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1lschC3+DvbDKHQzB6zSfmNJg4zPGJz/lrCB07qmEhrze2djHQjRidM384XgmXpB
	 bedusv+lpY68xuD2uOwhEss4lcZ23VcleUr+bGx64dY0MecZNXa/gqOAssoifdbO1Q
	 1DM86mj5PXhNJyZG+TA48Q87zQ3kEsWQ+3XQzOy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAPOqe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPOqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:46:34 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 731712072B;
        Thu, 16 Jan 2020 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185993;
        bh=r2rV98t7yERiTDZYhhTOeqzP6On1Kcg4dpcDBQpoYPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOCjJ1rpSVWGkHUp1Y6fMnYBivSXeTotY0HS/WEhID+pmAFzMigIDudiVspHPH7Hk
         I4WZMJJkCrUliRXG30305TQeEYUHIRgJsKHfl5xqn82om3FOKRpNHgIMgLfMnWqYHC
         V7lhv50kptG3qGKK8iMhFjd0ylBUw8xRuQi7oABw=
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
Subject: [RFT PATCH 13/13] tracing/kprobe: perf_event: Remove local kprobe event asynchronously
Date:   Thu, 16 Jan 2020 23:46:28 +0900
Message-Id: <157918598813.29301.14393624193409447045.stgit@devnote2>
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

Remove local kprobe event asynchronously. Note that this
can asynchronously remove a kprobe_event part, but the
perf_event needs to wait for all handlers finished before
removing the local kprobe event. So from the perf_event
(and eBPF) point of view, this shortens the trace termination
process a bit, but it still takes O(n) time to finish it.

To fix this issue, we need to change perf_event terminating
process by decoupling "disable events" and "destroy events"
as in ftrace.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f7e0370b10ae..e8c4828c21ae 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1707,9 +1707,7 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 		return;
 	}
 
-	__unregister_trace_kprobe(tk);
-
-	free_trace_kprobe(tk);
+	__unregister_trace_kprobe_async(tk);
 }
 #endif /* CONFIG_PERF_EVENTS */
 


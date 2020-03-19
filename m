Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B98C55195
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7C92076C
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCSX1s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbgCSX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 101DF21556;
        Thu, 19 Mar 2020 23:27:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZY-000h9X-VX; Thu, 19 Mar 2020 19:27:32 -0400
Message-Id: <20200319232732.839465737@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: [PATCH 09/12 v2] ring-buffer: Do not disable recording when there is an iterator
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that the iterator can handle a concurrent writer, do not disable writing
to the ring buffer when there is an iterator present.

Link: http://lkml.kernel.org/r/20200317213416.759770696@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5979327254f9..8bafba674ec0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4295,7 +4295,6 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	iter->cpu_buffer = cpu_buffer;
 
 	atomic_inc(&buffer->resize_disabled);
-	atomic_inc(&cpu_buffer->record_disabled);
 
 	return iter;
 }
@@ -4368,7 +4367,6 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	rb_check_pages(cpu_buffer);
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	atomic_dec(&cpu_buffer->record_disabled);
 	atomic_dec(&cpu_buffer->buffer->resize_disabled);
 	kfree(iter->event);
 	kfree(iter);
-- 
2.25.1



Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDEC55190
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5670720767
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCSX2I (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgCSX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B68B20B1F;
        Thu, 19 Mar 2020 23:27:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZY-000h7T-BS; Thu, 19 Mar 2020 19:27:32 -0400
Message-Id: <20200319232732.233732857@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:24 -0400
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
Subject: [PATCH 05/12 v2] ring-buffer: Add page_stamp to iterator for synchronization
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have the ring_buffer_iter structure contain a page_stamp, such that it can
be used to see if the writer entered the page the iterator is on. When going
to a new page, the iterator will record the time stamp of that page. When
reading events, it can copy the event to an internal buffer on the iterator
(to be implemented later), then check the page's time stamp with its own to
see if the writer entered the page. If so, it will need to try to read the
event again.

Link: http://lkml.kernel.org/r/20200317213416.163549674@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f57eeaa80e3e..e689bdcb53e8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -507,6 +507,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
 	u64				read_stamp;
+	u64				page_stamp;
 };
 
 /**
@@ -1959,7 +1960,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	else
 		rb_inc_page(cpu_buffer, &iter->head_page);
 
-	iter->read_stamp = iter->head_page->page->time_stamp;
+	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
 }
 
@@ -3551,10 +3552,13 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
 
-	if (iter->head)
+	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
-	else
+		iter->page_stamp = cpu_buffer->reader_page->page->time_stamp;
+	} else {
 		iter->read_stamp = iter->head_page->page->time_stamp;
+		iter->page_stamp = iter->read_stamp;
+	}
 }
 
 /**
-- 
2.25.1



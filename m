Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4DC41621
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0F920767
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCSX1e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCSX1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB73120767;
        Thu, 19 Mar 2020 23:27:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZX-000h5O-P2; Thu, 19 Mar 2020 19:27:31 -0400
Message-Id: <20200319232731.618036981@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:20 -0400
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
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 01/12 v2] selftest/ftrace: Fix function trigger test to handle trace not
 disabling the tracer
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ftrace selftest "ftrace - test for function traceon/off triggers"
enables all events and reads the trace file. Now that the trace file does
not disable tracing, and will attempt to continually read new data that is
added, the selftest gets stuck reading the trace file. This is because the
data added to the trace file will fill up quicker than the reading of it.

By only enabling scheduling events, the read can keep up with the writes.
Instead of enabling all events, only enable the scheduler events.

Link: http://lkml.kernel.org/r/20200318111345.0516642e@gandalf.local.home

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index 0c04282d33dd..1947387fe976 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -41,7 +41,7 @@ fi
 
 echo '** ENABLE EVENTS'
 
-echo 1 > events/enable
+echo 1 > events/sched/enable
 
 echo '** ENABLE TRACING'
 enable_tracing
-- 
2.25.1



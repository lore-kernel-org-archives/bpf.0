Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EF9C433E0
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2880864EBB
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 02:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBXCRX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhBXCRX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 21:17:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465A564E7A;
        Wed, 24 Feb 2021 02:16:41 +0000 (UTC)
Date:   Tue, 23 Feb 2021 21:16:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Jeanson <mjeanson@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
Message-ID: <20210223211639.670db85c@gandalf.local.home>
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Feb 2021 17:21:19 -0500
Michael Jeanson <mjeanson@efficios.com> wrote:

> This series only implements the tracepoint infrastructure required to
> allow tracers to handle page faults. Modifying each tracer to handle
> those page faults would be a next step after we all agree on this piece
> of instrumentation infrastructure.

I started taking a quick look at this, and came up with the question: how
do you allow preemption when dealing with per-cpu buffers or storage to
record the data?

That is, perf, bpf and ftrace are all using some kind of per-cpu data, and
this is the reason for the need to disable preemption. What's the solution
that LTTng is using for this? I know it has a per cpu buffers too, but does
it have some kind of "per task" buffer that is being used to extract the
data that can fault?

-- Steve

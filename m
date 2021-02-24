Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C65C433DB
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F4F64F09
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 17:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhBXRBo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:01:44 -0500
Received: from mail.efficios.com ([167.114.26.124]:38456 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhBXRAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 12:00:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 16782314DFA;
        Wed, 24 Feb 2021 11:59:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Oo6_FxBf9LtE; Wed, 24 Feb 2021 11:59:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9F546314DF9;
        Wed, 24 Feb 2021 11:59:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9F546314DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614185975;
        bh=HEfbepuKRcrVTCoH6GbCxFlhDDwQ2ulNWGVI56da24o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hVQn13V9mk0vgQl4yAOHeRLnUfT9O+Nje2UhFfFrs1qsO6CbgZI3FfIqRgIBnIIff
         rDmxexQiUbOC1ceDJrb23m3/iWTP4acHAV+2qZGaoQpJNM6hGX49Hh1A6YiGkrLQD2
         A+/Bw7WlsIa7TacKcDekdx70LK9JNqcpRjwgOgyhLebps06/SyMgcj3772NpBsUK54
         SZ21bWVJ5gc1Y5ksXGDkxeYgqTgH8RM3+2Bn4oKokSwyGl2pUZBZfAFaWy15B3rwoE
         ScRfxCPt4DPZGNCDlNXQq+VqZ3l6AL/GrV+VTSXE2cYhJhIbKUAm8KhstnKy/bA0k9
         bcnWJlnKizdrA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AKuBUfaxsntE; Wed, 24 Feb 2021 11:59:35 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8B07F3150BB;
        Wed, 24 Feb 2021 11:59:35 -0500 (EST)
Date:   Wed, 24 Feb 2021 11:59:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Jeanson <mjeanson@efficios.com>,
        rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        bpf <bpf@vger.kernel.org>
Message-ID: <915297635.2997.1614185975415.JavaMail.zimbra@efficios.com>
In-Reply-To: <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com> <20210223211639.670db85c@gandalf.local.home> <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com>
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: Faultable tracepoints (v2)
Thread-Index: urvfoX6HX+i7c2KJtiaEM9MhS7PYpw==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

----- On Feb 24, 2021, at 11:22 AM, Michael Jeanson mjeanson@efficios.com wrote:

> [ Adding Mathieu Desnoyers in CC ]
> 
> On 2021-02-23 21 h 16, Steven Rostedt wrote:
>> On Thu, 18 Feb 2021 17:21:19 -0500
>> Michael Jeanson <mjeanson@efficios.com> wrote:
>> 
>>> This series only implements the tracepoint infrastructure required to
>>> allow tracers to handle page faults. Modifying each tracer to handle
>>> those page faults would be a next step after we all agree on this piece
>>> of instrumentation infrastructure.
>> 
>> I started taking a quick look at this, and came up with the question: how
>> do you allow preemption when dealing with per-cpu buffers or storage to
>> record the data?
>> 
>> That is, perf, bpf and ftrace are all using some kind of per-cpu data, and
>> this is the reason for the need to disable preemption. What's the solution
>> that LTTng is using for this? I know it has a per cpu buffers too, but does
>> it have some kind of "per task" buffer that is being used to extract the
>> data that can fault?

As a prototype solution, what I've done currently is to copy the user-space
data into a kmalloc'd buffer in a preparation step before disabling preemption
and copying data over into the per-cpu buffers. It works, but I think we should
be able to do it without the needless copy.

What I have in mind as an efficient solution (not implemented yet) for the LTTng
kernel tracer goes as follows:

#define COMMIT_LOCAL 0
#define COMMIT_REMOTE 1

- faultable probe is called from system call tracepoint [ preemption/blocking/migration is allowed ]
  - probe code calculate the length which needs to be reserved to store the event
    (e.g. user strlen),

  - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
    - reserve_cpu = smp_processor_id()
    - reserve space in the ring buffer for reserve_cpu
      [ from that point on, we have _exclusive_ access to write into the ring buffer "slot"
        from any cpu until we commit. ]
  - preempt enable -> [ preemption/blocking/migration is allowed from here ]

  - copy data from user-space to the ring buffer "slot",

  - preempt disable -> [ preemption/blocking/migration is not allowed from here ]
    commit_cpu = smp_processor_id()
    if (commit_cpu == reserve_cpu)
       use local_add to increment the buf[commit_cpu].subbuffer[current].commit_count[COMMIT_LOCAL]
    else
       use atomic_add to increment the buf[commit_cpu].subbuffer[current].commit_count[COMMIT_REMOTE]
  - preempt enable -> [ preemption/blocking/migration is allowed from here ]

Given that lttng uses per-buffer/per-sub-buffer commit counters as simple free-running
accumulators, the trick here is to use two commit counters rather than single one for each
sub-buffer. Whenever we need to read a commit count value, we always sum the total of the
LOCAL and REMOTE counter.

This allows dealing with migration between reserve and commit without requiring the overhead
of an atomic operation on the fast-path (LOCAL case).

I had to design this kind of dual-counter trick in the context of user-space use of restartable
sequences. It looks like it may have a role to play in the kernel as well. :)

Or am I missing something important that would not survive real-life ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

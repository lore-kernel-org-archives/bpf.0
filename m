Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1669FC433EF
	for <bpf@archiver.kernel.org>; Fri,  8 Oct 2021 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43FA60F5E
	for <bpf@archiver.kernel.org>; Fri,  8 Oct 2021 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhJHXjU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231927AbhJHXjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:39:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC0B760F51;
        Fri,  8 Oct 2021 23:37:23 +0000 (UTC)
Date:   Fri, 8 Oct 2021 19:37:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Subject: Re: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to
 test_progs
Message-ID: <20211008193717.21d93a47@oasis.local.home>
In-Reply-To: <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com>
References: <20211006185619.364369-1-fallentree@fb.com>
        <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
        <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Oct 2021 15:42:31 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> orgot to actually cc Steven, oops. Steven, I've run into the problem
> when running a few selftests that do uprobe/kprobe attachment. At some
> point, they started complaining that files like
> /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id don't
> exist. And this condition persisted. When I checked
> /sys/kernel/debug/tracing in QEMU, it was empty. Is this a known
> problem?

The tracefs directory should automatically be mounted in the debugfs
"tracing" directory when debugfs is mounted.

Does /sys/kernel/tracing exist?

-- Steve

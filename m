Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F7C433EF
	for <bpf@archiver.kernel.org>; Sat,  9 Oct 2021 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C689E60FC3
	for <bpf@archiver.kernel.org>; Sat,  9 Oct 2021 03:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbhJIDaJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Oct 2021 23:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244025AbhJIDaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D7060F6B;
        Sat,  9 Oct 2021 03:28:12 +0000 (UTC)
Date:   Fri, 8 Oct 2021 23:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jussi Maki <joamaki@gmail.com>, Yucong Sun <fallentree@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Subject: Re: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to
 test_progs
Message-ID: <20211008232810.7cdafbd8@oasis.local.home>
In-Reply-To: <CAEf4BzYCUZBmO6qY0VtUshnepVEGRn3Cfiiw4cbVmYBH7ztAUw@mail.gmail.com>
References: <20211006185619.364369-1-fallentree@fb.com>
        <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
        <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com>
        <20211008193717.21d93a47@oasis.local.home>
        <CAEf4BzYCUZBmO6qY0VtUshnepVEGRn3Cfiiw4cbVmYBH7ztAUw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Oct 2021 20:20:38 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > Does /sys/kernel/tracing exist?  
> 
> Yeah, it was there, but was empty.

And would be filled with: mount -t tracefs nodev /sys/kernel/tracing

-- Steve

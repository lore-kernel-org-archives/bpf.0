Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68877C433EF
	for <bpf@archiver.kernel.org>; Fri, 15 Oct 2021 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4661037
	for <bpf@archiver.kernel.org>; Fri, 15 Oct 2021 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhJOOHZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236637AbhJOOHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 10:07:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254EC60F44;
        Fri, 15 Oct 2021 14:05:15 +0000 (UTC)
Date:   Fri, 15 Oct 2021 10:05:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20211015100509.78d4fb01@gandalf.local.home>
In-Reply-To: <YWluhdDMfkNGwlhz@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
        <20211008091336.33616-8-jolsa@kernel.org>
        <20211014162819.5c85618b@gandalf.local.home>
        <YWluhdDMfkNGwlhz@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 Oct 2021 14:05:25 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> ATM I'm bit stuck on the bpf side of this whole change, I'll test
> it with my other changes when I unstuck myself ;-)

If you want, I'll apply this as a separate change on top of your patch set.
As I don't see anything wrong with your current code.

And when you are satisfied with this, just give me a "tested-by" and I'll
push it too.

-- Steve

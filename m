Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801FBC433F5
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 12:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0BA6109E
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 12:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhIWMmL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Sep 2021 08:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241096AbhIWMk3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 08:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2FF360EC0;
        Thu, 23 Sep 2021 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632400737;
        bh=2SYyzBmvsUeVPR77N8xF8Vz3mjTv8podVq1Rkxg0Z1E=;
        h=From:To:Cc:Subject:Date:From;
        b=pGXRp97wZZ+3jKSo/MGSZPFd1T1D3WdpH0OsC3+JvvLH9YFeiWctkgqzRqlQeaPcE
         ChsuLVvYcClFqQwu/8WJ0df6bcaTSptZJO8AVw+3hKpOFrbwI86QDPLmSBP/sZle6W
         WKGRa95AxYI71XBYf5MEXQQuRiMnmEa5NiPFglsuwSMHxLFLYtPxUCf8neFL0GMzkt
         BcpxHQaLb9yKErNYONWFyyfbtVlpd2HdQV/sSxHAgAeIwTcvHCWunUtNvpg2+rEXIM
         kxazlxbJFj9TPARNAu+EtsHGld5hBgTCYtEbSsbvrXEA/MCraNAy265SjIjzyaWtbe
         vcaXloOJmNdSw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Series short description
Date:   Thu, 23 Sep 2021 21:38:55 +0900
Message-Id: <163240073510.33849.16299450051908678322.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Steve,

Here I share my testing patch of the BTF for kprobe events.
Currently this only allow user to specify '$$args' for
tracing all arguments of the function. This is only
avaialbe if
- the probe point is on the function entry
- the kernel is compiled with BTF (CONFIG_DEBUG_INFO_BTF)
- the kernel is enables BPF (CONFIG_BPF_SYSCALL)

And Special thanks to Sven! Most of BTF handling part of
this patch comes from his patch [1]

[1] https://stackframe.org/0001-ftrace-arg-hack.patch

What I thought while coding this were;
- kernel/bpf/btf.c can be moved under lib/ so that
  the other subsystems can reuse it, independent
  from BPF. (Also, this should depends on CONFIG_DEBUG_INFO_BTF)
- some more utility functions can be exposed.
  e.g. I copied btf_type_int() from btf.c
- If there are more comments for the BTF APIs, it will
  be more useful...
- Overall, the BTF is easy to understand for who
  already understand DWARF. Great work!
- I think I need 'ptr' and 'bool' types for fetcharg types.

Anyway, this is just for testing. I have to add some
more cleanup, features and documentations, etc.

Thank you,

---

Masami Hiramatsu (1):
      tracing/kprobe: Support $$args for function entry


 kernel/trace/trace_kprobe.c |   60 ++++++++++++++++++++++++-
 kernel/trace/trace_probe.c  |  105 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    5 ++
 3 files changed, 168 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

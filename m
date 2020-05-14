Return-Path: <SRS0=rqwV=64=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F42C433E3
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE344206A5
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 16:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgENQSL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 12:18:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:36480 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgENQSL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 12:18:11 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jZGYe-00017X-Cx; Thu, 14 May 2020 18:18:05 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        torvalds@linux-foundation.org, mhiramat@kernel.org,
        brendan.d.gregg@gmail.com, hch@lst.de, john.fastabend@gmail.com,
        yhs@fb.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/3] Restrict bpf_probe_read{,str}() and bpf_trace_printk()'s %s
Date:   Thu, 14 May 2020 18:16:04 +0200
Message-Id: <20200514161607.9212-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25812/Thu May 14 14:13:00 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Small set of fixes in order to restrict BPF helpers for tracing which are
broken on archs with overlapping address ranges as per discussion in [0].
I've targetted this for -bpf tree so they can be routed as fixes. Thanks!

  [0] https://lore.kernel.org/bpf/CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com/T/

Daniel Borkmann (3):
  bpf: restrict bpf_probe_read{,str}() only to archs where they work
  bpf: add bpf_probe_read_{user, kernel}_str() to do_refine_retval_range
  bpf: restrict bpf_trace_printk()'s %s usage and add %psK, %psU specifier

 Documentation/core-api/printk-formats.rst | 14 ++++
 arch/arm/Kconfig                          |  1 +
 arch/arm64/Kconfig                        |  1 +
 arch/x86/Kconfig                          |  1 +
 init/Kconfig                              |  3 +
 kernel/bpf/verifier.c                     |  4 +-
 kernel/trace/bpf_trace.c                  | 98 +++++++++++++++--------
 lib/vsprintf.c                            |  7 +-
 8 files changed, 94 insertions(+), 35 deletions(-)

-- 
2.21.0


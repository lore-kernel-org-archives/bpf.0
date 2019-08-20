Return-Path: <SRS0=Y+lb=WQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51DC3A59E
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C192339E
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 23:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="DqHIfd6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHTXJJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:09:09 -0400
Received: from lekensteyn.nl ([178.21.112.251]:34323 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfHTXJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 19:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=4HwCBJFfSBkXZe8xYmCQoO/bOakWt6wrHLfSFTA8ino=;
        b=DqHIfd6f8UIzx3Bsa35j8eDbh7AAhwSm9FPc9wXLKvqtE5T2rGjgfAlHg5YzwuKI1ujcJ4a0nrnx1FTlSk/6iJZi5DsySs0MX4zWNk/3LhjQQ4pC17NL0UV+BKLk5VRIsUM3NyL+4HSF2TTBlhPIB1Bg2+53eJYJY0U4yQV6va6vD8dZevdxKDhzlMMrFqZ127aS02S/FvOnFiDXjPoC4yYRjy9Sw8R0ADjkIrMjjD4aSyTLUtqgBlEhV/Hst0o1ukeOZHUshks8p5/uOC9+CKBDc5MEKRs+TMINC+3AuT0hQh7zJRHVYpgWzznbRIhDQlgSuyA+luAmZq85ompJNQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1i0DFO-00055S-9k; Wed, 21 Aug 2019 01:09:03 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 0/4] BPF-related documentation fixes
Date:   Wed, 21 Aug 2019 00:08:56 +0100
Message-Id: <20190820230900.23445-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here are some small doc updates that should hopefully save the next
eBPF/uprobe user some time. Based on v5.3-rc2, but net-next appears to
have no conflicts.

Changes since the v1[1]:
- Split bpf.h patch for kernel and userspace tools (requested by Alexei)
- Add new 'bpf: clarify when bpf_trace_printk discards lines' patch.

Kind regards,
Peter

 [1]: https://lkml.kernel.org/r/20190819212122.10286-1-peter@lekensteyn.nl

Peter Wu (4):
  bpf: clarify description for CONFIG_BPF_EVENTS
  bpf: fix 'struct pt_reg' typo in documentation
  bpf: clarify when bpf_trace_printk discards lines
  bpf: sync bpf.h to tools/

 include/uapi/linux/bpf.h       | 8 +++++---
 kernel/trace/Kconfig           | 3 ++-
 tools/include/uapi/linux/bpf.h | 8 +++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.22.0


Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4CC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96542175B
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCVXsD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:48:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:60436 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCVXsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 19:48:03 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7TtJ-0006ap-S1; Sat, 23 Mar 2019 00:48:02 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     sdf@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/2] libbpf fix up and clarify version info
Date:   Sat, 23 Mar 2019 00:47:53 +0100
Message-Id: <20190322234755.29306-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25396/Fri Mar 22 08:52:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First one is fixing version in Makefile and shared object and
second one clarifies bump in version. Thanks!

Daniel Borkmann (2):
  bpf, libbpf: fix version info and add it to shared object
  bpf, libbpf: clarify bump in libbpf version info

 tools/lib/bpf/Makefile   | 42 ++++++++++++++++++++++++++++--------------
 tools/lib/bpf/README.rst |  1 +
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.9.5


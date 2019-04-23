Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B996FC10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03A218D3
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfDWWqK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:46:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:51112 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 18:46:10 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJ4Ay-0003mU-SE; Wed, 24 Apr 2019 00:46:08 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 0/2] Two libbpf fixes
Date:   Wed, 24 Apr 2019 00:45:55 +0200
Message-Id: <cover.1556059361.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25428/Tue Apr 23 10:00:55 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two small fixes in relation to global data handling. Thanks!

Daniel Borkmann (2):
  bpf, libbpf: handle old kernels more graceful wrt global data sections
  bpf, libbpf: fix segfault in bpf_object__init_maps' pr_debug statement

 tools/lib/bpf/libbpf.c | 105 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 16 deletions(-)

-- 
2.9.5


Return-Path: <SRS0=YueQ=TN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15938C04AA7
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 23:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E334A208C3
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 23:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEMXTW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 May 2019 19:19:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:57876 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEMXTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 19:19:22 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hQKE3-0001rj-Pz; Tue, 14 May 2019 01:19:19 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     kafai@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/3] BPF LRU map fix
Date:   Tue, 14 May 2019 01:18:54 +0200
Message-Id: <cover.1557789256.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25448/Mon May 13 09:57:34 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set fixes LRU map eviction in combination with map lookups out
of system call side from user space. Main patch is the second one and
test cases are adapted and added in the last one. Thanks!

Daniel Borkmann (3):
  bpf: add map_lookup_elem_sys_only for lookups from syscall side
  bpf, lru: avoid messing with eviction heuristics upon syscall lookup
  bpf: test ref bit from data path and add new tests for syscall path

 include/linux/bpf.h                        |   1 +
 kernel/bpf/hashtab.c                       |  23 ++-
 kernel/bpf/syscall.c                       |   5 +-
 tools/testing/selftests/bpf/test_lru_map.c | 288 +++++++++++++++++++++++++++--
 4 files changed, 297 insertions(+), 20 deletions(-)

-- 
2.9.5


Return-Path: <SRS0=7q6j=CE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B9C433DF
	for <bpf@archiver.kernel.org>; Wed, 26 Aug 2020 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBEE20678
	for <bpf@archiver.kernel.org>; Wed, 26 Aug 2020 08:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBXP3+qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHZIRp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:17:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgHZIRp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 04:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598429864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t/lO1LD5UKp7asqrvZQAOD8ZrvKSwS12vFg3xfJR+OQ=;
        b=GBXP3+qSiJgQPiG8F5FAx5MpEntqBXbM3fumWA+0MktP3sK5M8Djsw4pRS6u5TX6JrOZfJ
        IAk0Q/+HVbg1QgptLRneAgTXFSNWPnO6yM2yfaOmsWprASI2Xq/Fjwx0F5fylvhTVKNQSk
        llXH4sJ86UNu94H776ffQGP/ESNne98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-fBcqRfp3PNSzxi0gkL3UbQ-1; Wed, 26 Aug 2020 04:17:42 -0400
X-MC-Unique: fBcqRfp3PNSzxi0gkL3UbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F98381CBDD;
        Wed, 26 Aug 2020 08:17:41 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBC476F142;
        Wed, 26 Aug 2020 08:17:37 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 9A39430736C8B;
        Wed, 26 Aug 2020 10:17:36 +0200 (CEST)
Subject: [PATCH bpf] selftests/bpf: Fix massive output from test_maps
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ykaliuta@redhat.com, zsun@redhat.com, vkabatov@redhat.com
Date:   Wed, 26 Aug 2020 10:17:36 +0200
Message-ID: <159842985651.1050885.2154399297503372406.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When stdout output from the selftests tool 'test_maps' gets redirected
into e.g file or pipe, then the output lines increase a lot (from 21
to 33949 lines).  This is caused by the printf that happens before the
fork() call, and there are user-space buffered printf data that seems
to be duplicated into the forked process.

To fix this fflush() stdout before the fork loop in __run_parallel().

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_maps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 754cf611723e..0d92ebcb335d 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1274,6 +1274,8 @@ static void __run_parallel(unsigned int tasks,
 	pid_t pid[tasks];
 	int i;
 
+	fflush(stdout);
+
 	for (i = 0; i < tasks; i++) {
 		pid[i] = fork();
 		if (pid[i] == 0) {



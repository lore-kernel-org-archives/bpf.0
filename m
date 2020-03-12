Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965EFC10DCE
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635DE20716
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VTyQbz7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCLRLK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:11:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42533 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLRLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 13:11:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so7278271ljp.9
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSb08jUO1PscpcMIat6OsbfjKhx8HZRSxYG1uKCNpGA=;
        b=VTyQbz7CogS4i8LRp25C8xqU565gko6MZ2QJ7gLXVpCP10Xnzxykmw5YbXRr+38anQ
         aFjiaVOR0WSuJOIRaOAY9lvTB04fMzk/lMFyA3kbChDm2u/F8/uAZ9r+HSkXcxJCawT2
         nploHEqS4PbGR1v59WOe9CmjCcTbCG4Yhp524=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSb08jUO1PscpcMIat6OsbfjKhx8HZRSxYG1uKCNpGA=;
        b=N2h0+j4rQDn8KiiZ8hQJJ181qK4sZ2NO29M/yMMdhjLaKUvwXLKLSffzZM0dzBOZtm
         al0nRU5xNImF4d6+K2LQtNohs3KNXdtbrFCdk+n1tmrFVlzJ6z8eWCjDn/OMqWGxl5Fk
         gK8zEMe8Bj1rZMf4TWiN0zMbr5htwp3ps50nRohbF5zSJCxJRTVOfjirmU0PQ40u95T/
         QeVcVIeMQtViGfyCl04/b06OUu3eJApBW0o5pWzNVaEpi1lv9lFiczExceCD4sUe/H2I
         G1jFxkFpb6DhHtaG70bUWr3VDKqwBvJmYg/ShDRavigwgv8i4i+xmdtRMBHP2YYW40pR
         nIdw==
X-Gm-Message-State: ANhLgQ2IwwvK79XxfOIPkZuZC5PWJAtWGLIFsuC//i2h8R09IHln3toG
        C1KM1auhnM1R4fWY6NwyMeVe0a40we7ihw==
X-Google-Smtp-Source: ADFU+vu8LRkR2Bzu5HvGDFDcq1brASp+4hF+OWsdHkIwSscgK15ylMbBtXNufmGlzjEfHVnaOn85uw==
X-Received: by 2002:a2e:a318:: with SMTP id l24mr5665871lje.41.1584033067205;
        Thu, 12 Mar 2020 10:11:07 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a2sm25863908ljn.50.2020.03.12.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:11:06 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix spurious failures in accept due to EAGAIN
Date:   Thu, 12 Mar 2020 18:11:05 +0100
Message-Id: <20200312171105.533690-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko reports that sockmap_listen test suite is frequently
failing due to accept() calls erroring out with EAGAIN:

  ./test_progs:connect_accept_thread:733: accept: Resource temporarily unavailable
  connect_accept_thread:FAIL:733

This is because we are needlessly putting the listening TCP sockets in
non-blocking mode.

Fix it by using the default blocking mode in all tests in this suite.

Fixes: 44d28be2b8d4 ("selftests/bpf: Tests for sockmap/sockhash holding listening sockets")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 52aa468bdccd..90271ec90388 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -754,7 +754,7 @@ static void test_syn_recv_insert_delete(int family, int sotype, int mapfd)
 	int err, s;
 	u64 value;
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -896,7 +896,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -1028,7 +1028,7 @@ static void redir_to_listening(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
-- 
2.24.1


Return-Path: <SRS0=396g=AN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C73C433E0
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953021531
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFN3aBFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGBR7v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:59:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727932AbgGBR7u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Jul 2020 13:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593712788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRhtPMhqlhqnOe1hdlLHWlYessgAjO4kXt3vnlCbry4=;
        b=IFN3aBFF9sLc/EYTAPApOPf8exLgt2p5N41u0btBtK26HhcTaUR6KClcZKAjv+XiyJho5m
        6hDQjH5d0Qm37DGWVfQlUn9+IVfBV0KWPTZrzKPVRyHdkFhafyCXcMax1VEmriMKLWsuTc
        NN959+zsk4676x1QJECutMu7XlQRh7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-f7AwhQoIONKPyqDrgL9Nmg-1; Thu, 02 Jul 2020 13:59:45 -0400
X-MC-Unique: f7AwhQoIONKPyqDrgL9Nmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1414B185B3BA;
        Thu,  2 Jul 2020 17:59:44 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0AE571678;
        Thu,  2 Jul 2020 17:59:40 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id E09AF300003EB;
        Thu,  2 Jul 2020 19:59:39 +0200 (CEST)
Subject: [PATCH bpf-next] selftests/bpf: test_progs use another shell exit on
 non-actions
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Thu, 02 Jul 2020 19:59:39 +0200
Message-ID: <159371277981.942611.89883359210042038.stgit@firesoul>
In-Reply-To: <20200702154728.6700e790@carbon>
References: <20200702154728.6700e790@carbon>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow up adjustment to commit 6c92bd5cd465 ("selftests/bpf:
Test_progs indicate to shell on non-actions"), that returns shell exit
indication EXIT_FAILURE (value 1) when user selects a non-existing test.

The problem with using EXIT_FAILURE is that a shell script cannot tell
the difference between a non-existing test and the test failing.

This patch uses value 2 as shell exit indication.
(Aside note unrecognized option parameters use value 64).

Fixes: 6c92bd5cd465 ("selftests/bpf: Test_progs indicate to shell on non-actions")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 104e833d0087..e8f7cd5dbae4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -12,6 +12,8 @@
 #include <string.h>
 #include <execinfo.h> /* backtrace */
 
+#define EXIT_NO_TEST 2
+
 /* defined in test_progs.h */
 struct test_env env = {};
 
@@ -740,7 +742,7 @@ int main(int argc, char **argv)
 	close(env.saved_netns_fd);
 
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
-		return EXIT_FAILURE;
+		return EXIT_NO_TEST;
 
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }



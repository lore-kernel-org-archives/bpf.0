Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699EC43334
	for <bpf@archiver.kernel.org>; Wed, 20 Jul 2022 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGTUxn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jul 2022 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD650720
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 13:53:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BCE4D240028
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 22:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658350418; bh=Eca2D4rjSbHVeb3k/4ZRAjsxxYFd84dDa3fSFFozrow=;
        h=From:To:Subject:Date:From;
        b=L0ikjE/mG1FPTOmOVzyGjlAPXy8b7lOj+by3silYtgGW+cybBYkXrbqWlBtgmnYrl
         FNGTWwFxPeSv18SxTQPLqc8w6Hua8bliJL7toU6Cf/s7I+bg+3QtDHVKrktvPqvIT/
         +Ikm0loNoi5fbiyG8XeMq1PTuSfD4G+bo9GVG4fO7K7w3WSTnufQCZ+dE1F8USD9Z1
         rD8lskTXREOnXhIM5wAZx7gs2iqLqT0JDkINjh0mBkDnJA2Ei9vboBhBBcjyFU6Q6i
         F8uXwX1lB/Ie0iIA50vFYU4pHkEYyEKHPJk8Us7OvOW7qBBuBBIGZIlGmmpncpTtcd
         Md4OmOTXelBbQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lp7GB0YBpz6tmJ;
        Wed, 20 Jul 2022 22:53:38 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] samples/bpf: Don't use uninitialized cg2 variable
Date:   Wed, 20 Jul 2022 20:53:36 +0000
Message-Id: <20220720205336.3628755-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the setup_cgroup_environment function returns false, we enter a
cleanup path that uses the cg2 variable, which, at this point, is not
initialized.
This change fixes the issue by introducing a new error label that does
not perform the close operation which uses said variable on this path.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 samples/bpf/test_current_task_under_cgroup_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_current_task_under_cgroup_user.c b/samples/bpf/test_current_task_under_cgroup_user.c
index ac251a..04a37f 100644
--- a/samples/bpf/test_current_task_under_cgroup_user.c
+++ b/samples/bpf/test_current_task_under_cgroup_user.c
@@ -55,7 +55,7 @@ int main(int argc, char **argv)
 	}
 
 	if (setup_cgroup_environment())
-		goto err;
+		goto err_cgroup;
 
 	cg2 = create_and_get_cgroup(CGROUP_PATH);
 
@@ -104,6 +104,7 @@ int main(int argc, char **argv)
 
 err:
 	close(cg2);
+err_cgroup:
 	cleanup_cgroup_environment();
 
 cleanup:
-- 
2.30.2


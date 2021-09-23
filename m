Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC6C433EF
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8839F6124D
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbhIWULV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:11:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:60618 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhIWULV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 16:11:21 -0400
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mTV2O-0001Ai-PU; Thu, 23 Sep 2021 22:09:44 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     andrii@kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com,
        Tejun Heo <tj@kernel.org>, Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf 1/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interrupt
Date:   Thu, 23 Sep 2021 22:09:23 +0200
Message-Id: <fe51fd2101fe9df82750d0beb2772ef77ba06bcf.1632427246.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26301/Thu Sep 23 11:06:09 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If cgroup_sk_alloc() is called from interrupt context, then just assign the
root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path. Rather
than re-adding the NULL-test to the fast-path we can just assign it once from
cgroup_sk_alloc() given v1/v2 handling has been simplified.

Fixes: 8520e224f547 ("bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode")
Reported-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
Cc: Tejun Heo <tj@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
---
 kernel/cgroup/cgroup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8afa8690d288..570b0c97392a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6574,22 +6574,29 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 
 void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 {
-	/* Don't associate the sock with unrelated interrupted task's cgroup. */
-	if (in_interrupt())
-		return;
+	struct cgroup *cgroup;
 
 	rcu_read_lock();
+	/* Don't associate the sock with unrelated interrupted task's cgroup. */
+	if (in_interrupt()) {
+		cgroup = &cgrp_dfl_root.cgrp;
+		cgroup_get(cgroup);
+		goto out;
+	}
+
 	while (true) {
 		struct css_set *cset;
 
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
-			skcd->cgroup = cset->dfl_cgrp;
-			cgroup_bpf_get(cset->dfl_cgrp);
+			cgroup = cset->dfl_cgrp;
 			break;
 		}
 		cpu_relax();
 	}
+out:
+	skcd->cgroup = cgroup;
+	cgroup_bpf_get(cgroup);
 	rcu_read_unlock();
 }
 
-- 
2.21.0

